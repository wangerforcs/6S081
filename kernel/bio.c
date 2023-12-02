// Buffer cache.
//
// The buffer cache is a linked list of buf structures holding
// cached copies of disk block contents.  Caching disk blocks
// in memory reduces the number of disk reads and also provides
// a synchronization point for disk blocks used by multiple processes.
//
// Interface:
// * To get a buffer for a particular disk block, call bread.
// * After changing buffer data, call bwrite to write it to disk.
// * When done with the buffer, call brelse.
// * Do not use the buffer after calling brelse.
// * Only one process at a time can use a buffer,
//     so do not keep them longer than necessary.


#include "types.h"
#include "param.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "riscv.h"
#include "defs.h"
#include "fs.h"
#include "buf.h"

struct {
  struct spinlock lock;
  struct buf buf[NBUF];

  // Linked list of all buffers, through prev/next.
  // Sorted by how recently the buffer was used.
  // head.next is most recent, head.prev is least.
} bcache;
#define NHASH 13
struct {
  struct spinlock lock;
  struct buf head;
}hash[NHASH];

void
binit(void)
{
  struct buf *b;

  initlock(&bcache.lock, "bcache");

  // Create linked list of buffers
  for(int i = 0; i < NHASH; i++) {
    initlock(&hash[i].lock, "bcache");
    hash[i].head.prev = &hash[i].head;
    hash[i].head.next = &hash[i].head;
  }
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = hash[0].head.next;
    b->prev = &hash[0].head;
    hash[0].head.next->prev = b;
    hash[0].head.next = b;
  }
}

// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  int index = blockno % NHASH;
  acquire(&hash[index].lock);
  for(b = hash[index].head.next; b != &hash[index].head; b = b->next){
    if(b->dev == dev && b->blockno == blockno){
      b->refcnt++;
      release(&hash[index].lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  for(b = hash[index].head.next; b != &hash[index].head; b = b->next){
    if(b->refcnt == 0) {
      b->dev = dev;
      b->blockno = blockno;
      b->valid = 0;
      b->refcnt = 1;
      release(&hash[index].lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  // acquire(&bcache.lock);
  // for(b = bcache.buf; b < bcache.buf+NBUF; b++){
  //   if(b->refcnt == 0) {
  //     int newidx = b->blockno % NHASH;
  //     if(index == newidx) continue;
  //     acquire(&hash[newidx].lock);
  //     if(b->refcnt != 0) {
  //       release(&hash[newidx].lock);
  //       continue;
  //     }
  //     b->next->prev = b->prev;
  //     b->prev->next = b->next;
  //     release(&hash[newidx].lock);

  //     b->next = hash[index].head.next;
  //     b->prev = &hash[index].head;
  //     hash[index].head.next->prev = b;
  //     hash[index].head.next = b;
  //     b->dev = dev;
  //     b->blockno = blockno;
  //     b->valid = 0;
  //     b->refcnt = 1;
  //     release(&bcache.lock);
  //     release(&hash[index].lock);
  //     acquiresleep(&b->lock);
  //     return b;
  //   }
  // }


  // acquire(&bcache.lock);
  for(int i=0;i<NHASH;i++) {
    if(i == index) continue;
    acquire(&hash[i].lock);
    for(b = hash[i].head.next; b != &hash[i].head; b = b->next){
      if(b->refcnt == 0) {
        b->dev = dev;
        b->blockno = blockno;
        b->valid = 0;
        b->refcnt = 1;
        b->prev->next = b->next;
        b->next->prev = b->prev;
        b->next = hash[index].head.next;
        b->prev = &hash[index].head;
        hash[index].head.next->prev = b;
        hash[index].head.next = b;
        // release(&bcache.lock);
        release(&hash[i].lock);
        release(&hash[index].lock);
        acquiresleep(&b->lock);
        return b;
      }
    }
  }
  
  panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  virtio_disk_rw(b, 1);
}

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");

  releasesleep(&b->lock);

  b->refcnt--;
}

void
bpin(struct buf *b) {
  acquire(&bcache.lock);
  b->refcnt++;
  release(&bcache.lock);
}

void
bunpin(struct buf *b) {
  acquire(&bcache.lock);
  b->refcnt--;
  release(&bcache.lock);
}



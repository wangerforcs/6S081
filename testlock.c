#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<pthread.h>

struct spinlock {
    int locked;
};
void initlock(struct spinlock *lk)
{
    lk->locked = 0;
}
void acquire(struct spinlock *lk)
{
    while(__sync_lock_test_and_set(&lk->locked, 1));
}
void release(struct spinlock *lk)
{
    lk->locked = 0;
    // __sync_lock_release(&lk->locked);
}
struct spinlock lk;
volatile int cnt = 0;
void *thread(void *arg)
{
    while(1){
        acquire(&lk);
        cnt++;
        printf("%d\n", cnt);
        cnt--;
        release(&lk);
    }
    return NULL;
}
int main()
{
    initlock(&lk);
    pthread_t tid[10];
    int i;
    for(i=0;i<10;i++)
    {
        pthread_create(&tid[i], NULL, thread, NULL);
    }
    for(i=0;i<10;i++)
    {
        pthread_join(tid[i], NULL);
    }
}
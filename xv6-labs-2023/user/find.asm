
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	316080e7          	jalr	790(ra) # 326 <strlen>
  18:	02051793          	slli	a5,a0,0x20
  1c:	9381                	srli	a5,a5,0x20
  1e:	97a6                	add	a5,a5,s1
  20:	02f00693          	li	a3,47
  24:	0097e963          	bltu	a5,s1,36 <fmtname+0x36>
  28:	0007c703          	lbu	a4,0(a5)
  2c:	00d70563          	beq	a4,a3,36 <fmtname+0x36>
  30:	17fd                	addi	a5,a5,-1
  32:	fe97fbe3          	bgeu	a5,s1,28 <fmtname+0x28>
    ;
  p++;
  36:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  3a:	8526                	mv	a0,s1
  3c:	00000097          	auipc	ra,0x0
  40:	2ea080e7          	jalr	746(ra) # 326 <strlen>
  44:	2501                	sext.w	a0,a0
  46:	47b5                	li	a5,13
  48:	00a7fa63          	bgeu	a5,a0,5c <fmtname+0x5c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  4c:	8526                	mv	a0,s1
  4e:	70a2                	ld	ra,40(sp)
  50:	7402                	ld	s0,32(sp)
  52:	64e2                	ld	s1,24(sp)
  54:	6942                	ld	s2,16(sp)
  56:	69a2                	ld	s3,8(sp)
  58:	6145                	addi	sp,sp,48
  5a:	8082                	ret
  memmove(buf, p, strlen(p));
  5c:	8526                	mv	a0,s1
  5e:	00000097          	auipc	ra,0x0
  62:	2c8080e7          	jalr	712(ra) # 326 <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	faa98993          	addi	s3,s3,-86 # 1010 <buf.0>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	422080e7          	jalr	1058(ra) # 498 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	2a6080e7          	jalr	678(ra) # 326 <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	298080e7          	jalr	664(ra) # 326 <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	02000593          	li	a1,32
  a4:	01298533          	add	a0,s3,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	2a8080e7          	jalr	680(ra) # 350 <memset>
  return buf;
  b0:	84ce                	mv	s1,s3
  b2:	bf69                	j	4c <fmtname+0x4c>

00000000000000b4 <find>:

void find(char* path,char* file){
  b4:	d9010113          	addi	sp,sp,-624
  b8:	26113423          	sd	ra,616(sp)
  bc:	26813023          	sd	s0,608(sp)
  c0:	24913c23          	sd	s1,600(sp)
  c4:	25213823          	sd	s2,592(sp)
  c8:	25313423          	sd	s3,584(sp)
  cc:	25413023          	sd	s4,576(sp)
  d0:	23513c23          	sd	s5,568(sp)
  d4:	23613823          	sd	s6,560(sp)
  d8:	1c80                	addi	s0,sp,624
  da:	892a                	mv	s2,a0
  dc:	89ae                	mv	s3,a1
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;

    if((fd = open(path, 0)) < 0){
  de:	4581                	li	a1,0
  e0:	00000097          	auipc	ra,0x0
  e4:	4aa080e7          	jalr	1194(ra) # 58a <open>
  e8:	08054763          	bltz	a0,176 <find+0xc2>
  ec:	84aa                	mv	s1,a0
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }

    if(fstat(fd, &st) < 0){
  ee:	d9840593          	addi	a1,s0,-616
  f2:	00000097          	auipc	ra,0x0
  f6:	4b0080e7          	jalr	1200(ra) # 5a2 <fstat>
  fa:	08054963          	bltz	a0,18c <find+0xd8>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }
    switch(st.type){
  fe:	da041783          	lh	a5,-608(s0)
 102:	0007869b          	sext.w	a3,a5
 106:	4705                	li	a4,1
 108:	0ae68c63          	beq	a3,a4,1c0 <find+0x10c>
 10c:	37f9                	addiw	a5,a5,-2
 10e:	17c2                	slli	a5,a5,0x30
 110:	93c1                	srli	a5,a5,0x30
 112:	02f76a63          	bltu	a4,a5,146 <find+0x92>
    case T_DEVICE:
    case T_FILE:
        char* name = fmtname(path);
 116:	854a                	mv	a0,s2
 118:	00000097          	auipc	ra,0x0
 11c:	ee8080e7          	jalr	-280(ra) # 0 <fmtname>
 120:	8a2a                	mv	s4,a0
        name[strlen(file)] = 0;
 122:	854e                	mv	a0,s3
 124:	00000097          	auipc	ra,0x0
 128:	202080e7          	jalr	514(ra) # 326 <strlen>
 12c:	02051793          	slli	a5,a0,0x20
 130:	9381                	srli	a5,a5,0x20
 132:	97d2                	add	a5,a5,s4
 134:	00078023          	sb	zero,0(a5)
        if( strcmp(name,file) == 0){
 138:	85ce                	mv	a1,s3
 13a:	8552                	mv	a0,s4
 13c:	00000097          	auipc	ra,0x0
 140:	1be080e7          	jalr	446(ra) # 2fa <strcmp>
 144:	c525                	beqz	a0,1ac <find+0xf8>
            p[DIRSIZ] = 0;
            find(buf,file);
        }
        break;
    }
    close(fd);
 146:	8526                	mv	a0,s1
 148:	00000097          	auipc	ra,0x0
 14c:	42a080e7          	jalr	1066(ra) # 572 <close>
}
 150:	26813083          	ld	ra,616(sp)
 154:	26013403          	ld	s0,608(sp)
 158:	25813483          	ld	s1,600(sp)
 15c:	25013903          	ld	s2,592(sp)
 160:	24813983          	ld	s3,584(sp)
 164:	24013a03          	ld	s4,576(sp)
 168:	23813a83          	ld	s5,568(sp)
 16c:	23013b03          	ld	s6,560(sp)
 170:	27010113          	addi	sp,sp,624
 174:	8082                	ret
        fprintf(2, "find: cannot open %s\n", path);
 176:	864a                	mv	a2,s2
 178:	00001597          	auipc	a1,0x1
 17c:	8f858593          	addi	a1,a1,-1800 # a70 <malloc+0xf4>
 180:	4509                	li	a0,2
 182:	00000097          	auipc	ra,0x0
 186:	714080e7          	jalr	1812(ra) # 896 <fprintf>
        return;
 18a:	b7d9                	j	150 <find+0x9c>
        fprintf(2, "find: cannot stat %s\n", path);
 18c:	864a                	mv	a2,s2
 18e:	00001597          	auipc	a1,0x1
 192:	8fa58593          	addi	a1,a1,-1798 # a88 <malloc+0x10c>
 196:	4509                	li	a0,2
 198:	00000097          	auipc	ra,0x0
 19c:	6fe080e7          	jalr	1790(ra) # 896 <fprintf>
        close(fd);
 1a0:	8526                	mv	a0,s1
 1a2:	00000097          	auipc	ra,0x0
 1a6:	3d0080e7          	jalr	976(ra) # 572 <close>
        return;
 1aa:	b75d                	j	150 <find+0x9c>
            printf("%s\n",path);
 1ac:	85ca                	mv	a1,s2
 1ae:	00001517          	auipc	a0,0x1
 1b2:	8f250513          	addi	a0,a0,-1806 # aa0 <malloc+0x124>
 1b6:	00000097          	auipc	ra,0x0
 1ba:	70e080e7          	jalr	1806(ra) # 8c4 <printf>
 1be:	b761                	j	146 <find+0x92>
        if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1c0:	854a                	mv	a0,s2
 1c2:	00000097          	auipc	ra,0x0
 1c6:	164080e7          	jalr	356(ra) # 326 <strlen>
 1ca:	2541                	addiw	a0,a0,16
 1cc:	20000793          	li	a5,512
 1d0:	00a7fb63          	bgeu	a5,a0,1e6 <find+0x132>
            printf("find: path too long\n");
 1d4:	00001517          	auipc	a0,0x1
 1d8:	8d450513          	addi	a0,a0,-1836 # aa8 <malloc+0x12c>
 1dc:	00000097          	auipc	ra,0x0
 1e0:	6e8080e7          	jalr	1768(ra) # 8c4 <printf>
            break;
 1e4:	b78d                	j	146 <find+0x92>
        strcpy(buf, path);
 1e6:	85ca                	mv	a1,s2
 1e8:	dc040513          	addi	a0,s0,-576
 1ec:	00000097          	auipc	ra,0x0
 1f0:	0f2080e7          	jalr	242(ra) # 2de <strcpy>
        p = buf+strlen(buf);
 1f4:	dc040513          	addi	a0,s0,-576
 1f8:	00000097          	auipc	ra,0x0
 1fc:	12e080e7          	jalr	302(ra) # 326 <strlen>
 200:	1502                	slli	a0,a0,0x20
 202:	9101                	srli	a0,a0,0x20
 204:	dc040793          	addi	a5,s0,-576
 208:	00a78933          	add	s2,a5,a0
        *p++ = '/';
 20c:	00190b13          	addi	s6,s2,1
 210:	02f00793          	li	a5,47
 214:	00f90023          	sb	a5,0(s2)
            if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 218:	00001a17          	auipc	s4,0x1
 21c:	8a8a0a13          	addi	s4,s4,-1880 # ac0 <malloc+0x144>
 220:	00001a97          	auipc	s5,0x1
 224:	8a8a8a93          	addi	s5,s5,-1880 # ac8 <malloc+0x14c>
        while(read(fd, &de, sizeof(de)) == sizeof(de)){
 228:	4641                	li	a2,16
 22a:	db040593          	addi	a1,s0,-592
 22e:	8526                	mv	a0,s1
 230:	00000097          	auipc	ra,0x0
 234:	332080e7          	jalr	818(ra) # 562 <read>
 238:	47c1                	li	a5,16
 23a:	f0f516e3          	bne	a0,a5,146 <find+0x92>
            if(de.inum == 0)
 23e:	db045783          	lhu	a5,-592(s0)
 242:	d3fd                	beqz	a5,228 <find+0x174>
            if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 244:	85d2                	mv	a1,s4
 246:	db240513          	addi	a0,s0,-590
 24a:	00000097          	auipc	ra,0x0
 24e:	0b0080e7          	jalr	176(ra) # 2fa <strcmp>
 252:	d979                	beqz	a0,228 <find+0x174>
 254:	85d6                	mv	a1,s5
 256:	db240513          	addi	a0,s0,-590
 25a:	00000097          	auipc	ra,0x0
 25e:	0a0080e7          	jalr	160(ra) # 2fa <strcmp>
 262:	d179                	beqz	a0,228 <find+0x174>
            memmove(p, de.name, DIRSIZ);
 264:	4639                	li	a2,14
 266:	db240593          	addi	a1,s0,-590
 26a:	855a                	mv	a0,s6
 26c:	00000097          	auipc	ra,0x0
 270:	22c080e7          	jalr	556(ra) # 498 <memmove>
            p[DIRSIZ] = 0;
 274:	000907a3          	sb	zero,15(s2)
            find(buf,file);
 278:	85ce                	mv	a1,s3
 27a:	dc040513          	addi	a0,s0,-576
 27e:	00000097          	auipc	ra,0x0
 282:	e36080e7          	jalr	-458(ra) # b4 <find>
 286:	b74d                	j	228 <find+0x174>

0000000000000288 <main>:

int
main(int argc, char *argv[])
{
 288:	1101                	addi	sp,sp,-32
 28a:	ec06                	sd	ra,24(sp)
 28c:	e822                	sd	s0,16(sp)
 28e:	e426                	sd	s1,8(sp)
 290:	1000                	addi	s0,sp,32
 292:	84ae                	mv	s1,a1
    if(argc != 3){
 294:	478d                	li	a5,3
 296:	00f51d63          	bne	a0,a5,2b0 <main+0x28>
        fprintf(2, "Usage: find <dir> <file>\n");
    }
    find(argv[1], argv[2]);
 29a:	688c                	ld	a1,16(s1)
 29c:	6488                	ld	a0,8(s1)
 29e:	00000097          	auipc	ra,0x0
 2a2:	e16080e7          	jalr	-490(ra) # b4 <find>
    exit(0);
 2a6:	4501                	li	a0,0
 2a8:	00000097          	auipc	ra,0x0
 2ac:	2a2080e7          	jalr	674(ra) # 54a <exit>
        fprintf(2, "Usage: find <dir> <file>\n");
 2b0:	00001597          	auipc	a1,0x1
 2b4:	82058593          	addi	a1,a1,-2016 # ad0 <malloc+0x154>
 2b8:	4509                	li	a0,2
 2ba:	00000097          	auipc	ra,0x0
 2be:	5dc080e7          	jalr	1500(ra) # 896 <fprintf>
 2c2:	bfe1                	j	29a <main+0x12>

00000000000002c4 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e406                	sd	ra,8(sp)
 2c8:	e022                	sd	s0,0(sp)
 2ca:	0800                	addi	s0,sp,16
  extern int main();
  main();
 2cc:	00000097          	auipc	ra,0x0
 2d0:	fbc080e7          	jalr	-68(ra) # 288 <main>
  exit(0);
 2d4:	4501                	li	a0,0
 2d6:	00000097          	auipc	ra,0x0
 2da:	274080e7          	jalr	628(ra) # 54a <exit>

00000000000002de <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 2de:	1141                	addi	sp,sp,-16
 2e0:	e422                	sd	s0,8(sp)
 2e2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2e4:	87aa                	mv	a5,a0
 2e6:	0585                	addi	a1,a1,1
 2e8:	0785                	addi	a5,a5,1
 2ea:	fff5c703          	lbu	a4,-1(a1)
 2ee:	fee78fa3          	sb	a4,-1(a5)
 2f2:	fb75                	bnez	a4,2e6 <strcpy+0x8>
    ;
  return os;
}
 2f4:	6422                	ld	s0,8(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret

00000000000002fa <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2fa:	1141                	addi	sp,sp,-16
 2fc:	e422                	sd	s0,8(sp)
 2fe:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 300:	00054783          	lbu	a5,0(a0)
 304:	cb91                	beqz	a5,318 <strcmp+0x1e>
 306:	0005c703          	lbu	a4,0(a1)
 30a:	00f71763          	bne	a4,a5,318 <strcmp+0x1e>
    p++, q++;
 30e:	0505                	addi	a0,a0,1
 310:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 312:	00054783          	lbu	a5,0(a0)
 316:	fbe5                	bnez	a5,306 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 318:	0005c503          	lbu	a0,0(a1)
}
 31c:	40a7853b          	subw	a0,a5,a0
 320:	6422                	ld	s0,8(sp)
 322:	0141                	addi	sp,sp,16
 324:	8082                	ret

0000000000000326 <strlen>:

uint
strlen(const char *s)
{
 326:	1141                	addi	sp,sp,-16
 328:	e422                	sd	s0,8(sp)
 32a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 32c:	00054783          	lbu	a5,0(a0)
 330:	cf91                	beqz	a5,34c <strlen+0x26>
 332:	0505                	addi	a0,a0,1
 334:	87aa                	mv	a5,a0
 336:	4685                	li	a3,1
 338:	9e89                	subw	a3,a3,a0
 33a:	00f6853b          	addw	a0,a3,a5
 33e:	0785                	addi	a5,a5,1
 340:	fff7c703          	lbu	a4,-1(a5)
 344:	fb7d                	bnez	a4,33a <strlen+0x14>
    ;
  return n;
}
 346:	6422                	ld	s0,8(sp)
 348:	0141                	addi	sp,sp,16
 34a:	8082                	ret
  for(n = 0; s[n]; n++)
 34c:	4501                	li	a0,0
 34e:	bfe5                	j	346 <strlen+0x20>

0000000000000350 <memset>:

void*
memset(void *dst, int c, uint n)
{
 350:	1141                	addi	sp,sp,-16
 352:	e422                	sd	s0,8(sp)
 354:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 356:	ca19                	beqz	a2,36c <memset+0x1c>
 358:	87aa                	mv	a5,a0
 35a:	1602                	slli	a2,a2,0x20
 35c:	9201                	srli	a2,a2,0x20
 35e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 362:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 366:	0785                	addi	a5,a5,1
 368:	fee79de3          	bne	a5,a4,362 <memset+0x12>
  }
  return dst;
}
 36c:	6422                	ld	s0,8(sp)
 36e:	0141                	addi	sp,sp,16
 370:	8082                	ret

0000000000000372 <strchr>:

char*
strchr(const char *s, char c)
{
 372:	1141                	addi	sp,sp,-16
 374:	e422                	sd	s0,8(sp)
 376:	0800                	addi	s0,sp,16
  for(; *s; s++)
 378:	00054783          	lbu	a5,0(a0)
 37c:	cb99                	beqz	a5,392 <strchr+0x20>
    if(*s == c)
 37e:	00f58763          	beq	a1,a5,38c <strchr+0x1a>
  for(; *s; s++)
 382:	0505                	addi	a0,a0,1
 384:	00054783          	lbu	a5,0(a0)
 388:	fbfd                	bnez	a5,37e <strchr+0xc>
      return (char*)s;
  return 0;
 38a:	4501                	li	a0,0
}
 38c:	6422                	ld	s0,8(sp)
 38e:	0141                	addi	sp,sp,16
 390:	8082                	ret
  return 0;
 392:	4501                	li	a0,0
 394:	bfe5                	j	38c <strchr+0x1a>

0000000000000396 <gets>:

char*
gets(char *buf, int max)
{
 396:	711d                	addi	sp,sp,-96
 398:	ec86                	sd	ra,88(sp)
 39a:	e8a2                	sd	s0,80(sp)
 39c:	e4a6                	sd	s1,72(sp)
 39e:	e0ca                	sd	s2,64(sp)
 3a0:	fc4e                	sd	s3,56(sp)
 3a2:	f852                	sd	s4,48(sp)
 3a4:	f456                	sd	s5,40(sp)
 3a6:	f05a                	sd	s6,32(sp)
 3a8:	ec5e                	sd	s7,24(sp)
 3aa:	1080                	addi	s0,sp,96
 3ac:	8baa                	mv	s7,a0
 3ae:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3b0:	892a                	mv	s2,a0
 3b2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3b4:	4aa9                	li	s5,10
 3b6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3b8:	89a6                	mv	s3,s1
 3ba:	2485                	addiw	s1,s1,1
 3bc:	0344d863          	bge	s1,s4,3ec <gets+0x56>
    cc = read(0, &c, 1);
 3c0:	4605                	li	a2,1
 3c2:	faf40593          	addi	a1,s0,-81
 3c6:	4501                	li	a0,0
 3c8:	00000097          	auipc	ra,0x0
 3cc:	19a080e7          	jalr	410(ra) # 562 <read>
    if(cc < 1)
 3d0:	00a05e63          	blez	a0,3ec <gets+0x56>
    buf[i++] = c;
 3d4:	faf44783          	lbu	a5,-81(s0)
 3d8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3dc:	01578763          	beq	a5,s5,3ea <gets+0x54>
 3e0:	0905                	addi	s2,s2,1
 3e2:	fd679be3          	bne	a5,s6,3b8 <gets+0x22>
  for(i=0; i+1 < max; ){
 3e6:	89a6                	mv	s3,s1
 3e8:	a011                	j	3ec <gets+0x56>
 3ea:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3ec:	99de                	add	s3,s3,s7
 3ee:	00098023          	sb	zero,0(s3)
  return buf;
}
 3f2:	855e                	mv	a0,s7
 3f4:	60e6                	ld	ra,88(sp)
 3f6:	6446                	ld	s0,80(sp)
 3f8:	64a6                	ld	s1,72(sp)
 3fa:	6906                	ld	s2,64(sp)
 3fc:	79e2                	ld	s3,56(sp)
 3fe:	7a42                	ld	s4,48(sp)
 400:	7aa2                	ld	s5,40(sp)
 402:	7b02                	ld	s6,32(sp)
 404:	6be2                	ld	s7,24(sp)
 406:	6125                	addi	sp,sp,96
 408:	8082                	ret

000000000000040a <stat>:

int
stat(const char *n, struct stat *st)
{
 40a:	1101                	addi	sp,sp,-32
 40c:	ec06                	sd	ra,24(sp)
 40e:	e822                	sd	s0,16(sp)
 410:	e426                	sd	s1,8(sp)
 412:	e04a                	sd	s2,0(sp)
 414:	1000                	addi	s0,sp,32
 416:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 418:	4581                	li	a1,0
 41a:	00000097          	auipc	ra,0x0
 41e:	170080e7          	jalr	368(ra) # 58a <open>
  if(fd < 0)
 422:	02054563          	bltz	a0,44c <stat+0x42>
 426:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 428:	85ca                	mv	a1,s2
 42a:	00000097          	auipc	ra,0x0
 42e:	178080e7          	jalr	376(ra) # 5a2 <fstat>
 432:	892a                	mv	s2,a0
  close(fd);
 434:	8526                	mv	a0,s1
 436:	00000097          	auipc	ra,0x0
 43a:	13c080e7          	jalr	316(ra) # 572 <close>
  return r;
}
 43e:	854a                	mv	a0,s2
 440:	60e2                	ld	ra,24(sp)
 442:	6442                	ld	s0,16(sp)
 444:	64a2                	ld	s1,8(sp)
 446:	6902                	ld	s2,0(sp)
 448:	6105                	addi	sp,sp,32
 44a:	8082                	ret
    return -1;
 44c:	597d                	li	s2,-1
 44e:	bfc5                	j	43e <stat+0x34>

0000000000000450 <atoi>:

int
atoi(const char *s)
{
 450:	1141                	addi	sp,sp,-16
 452:	e422                	sd	s0,8(sp)
 454:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 456:	00054683          	lbu	a3,0(a0)
 45a:	fd06879b          	addiw	a5,a3,-48
 45e:	0ff7f793          	zext.b	a5,a5
 462:	4625                	li	a2,9
 464:	02f66863          	bltu	a2,a5,494 <atoi+0x44>
 468:	872a                	mv	a4,a0
  n = 0;
 46a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 46c:	0705                	addi	a4,a4,1
 46e:	0025179b          	slliw	a5,a0,0x2
 472:	9fa9                	addw	a5,a5,a0
 474:	0017979b          	slliw	a5,a5,0x1
 478:	9fb5                	addw	a5,a5,a3
 47a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 47e:	00074683          	lbu	a3,0(a4)
 482:	fd06879b          	addiw	a5,a3,-48
 486:	0ff7f793          	zext.b	a5,a5
 48a:	fef671e3          	bgeu	a2,a5,46c <atoi+0x1c>
  return n;
}
 48e:	6422                	ld	s0,8(sp)
 490:	0141                	addi	sp,sp,16
 492:	8082                	ret
  n = 0;
 494:	4501                	li	a0,0
 496:	bfe5                	j	48e <atoi+0x3e>

0000000000000498 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 498:	1141                	addi	sp,sp,-16
 49a:	e422                	sd	s0,8(sp)
 49c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 49e:	02b57463          	bgeu	a0,a1,4c6 <memmove+0x2e>
    while(n-- > 0)
 4a2:	00c05f63          	blez	a2,4c0 <memmove+0x28>
 4a6:	1602                	slli	a2,a2,0x20
 4a8:	9201                	srli	a2,a2,0x20
 4aa:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4ae:	872a                	mv	a4,a0
      *dst++ = *src++;
 4b0:	0585                	addi	a1,a1,1
 4b2:	0705                	addi	a4,a4,1
 4b4:	fff5c683          	lbu	a3,-1(a1)
 4b8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4bc:	fee79ae3          	bne	a5,a4,4b0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4c0:	6422                	ld	s0,8(sp)
 4c2:	0141                	addi	sp,sp,16
 4c4:	8082                	ret
    dst += n;
 4c6:	00c50733          	add	a4,a0,a2
    src += n;
 4ca:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4cc:	fec05ae3          	blez	a2,4c0 <memmove+0x28>
 4d0:	fff6079b          	addiw	a5,a2,-1
 4d4:	1782                	slli	a5,a5,0x20
 4d6:	9381                	srli	a5,a5,0x20
 4d8:	fff7c793          	not	a5,a5
 4dc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4de:	15fd                	addi	a1,a1,-1
 4e0:	177d                	addi	a4,a4,-1
 4e2:	0005c683          	lbu	a3,0(a1)
 4e6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4ea:	fee79ae3          	bne	a5,a4,4de <memmove+0x46>
 4ee:	bfc9                	j	4c0 <memmove+0x28>

00000000000004f0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4f0:	1141                	addi	sp,sp,-16
 4f2:	e422                	sd	s0,8(sp)
 4f4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4f6:	ca05                	beqz	a2,526 <memcmp+0x36>
 4f8:	fff6069b          	addiw	a3,a2,-1
 4fc:	1682                	slli	a3,a3,0x20
 4fe:	9281                	srli	a3,a3,0x20
 500:	0685                	addi	a3,a3,1
 502:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 504:	00054783          	lbu	a5,0(a0)
 508:	0005c703          	lbu	a4,0(a1)
 50c:	00e79863          	bne	a5,a4,51c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 510:	0505                	addi	a0,a0,1
    p2++;
 512:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 514:	fed518e3          	bne	a0,a3,504 <memcmp+0x14>
  }
  return 0;
 518:	4501                	li	a0,0
 51a:	a019                	j	520 <memcmp+0x30>
      return *p1 - *p2;
 51c:	40e7853b          	subw	a0,a5,a4
}
 520:	6422                	ld	s0,8(sp)
 522:	0141                	addi	sp,sp,16
 524:	8082                	ret
  return 0;
 526:	4501                	li	a0,0
 528:	bfe5                	j	520 <memcmp+0x30>

000000000000052a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 52a:	1141                	addi	sp,sp,-16
 52c:	e406                	sd	ra,8(sp)
 52e:	e022                	sd	s0,0(sp)
 530:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 532:	00000097          	auipc	ra,0x0
 536:	f66080e7          	jalr	-154(ra) # 498 <memmove>
}
 53a:	60a2                	ld	ra,8(sp)
 53c:	6402                	ld	s0,0(sp)
 53e:	0141                	addi	sp,sp,16
 540:	8082                	ret

0000000000000542 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 542:	4885                	li	a7,1
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <exit>:
.global exit
exit:
 li a7, SYS_exit
 54a:	4889                	li	a7,2
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <wait>:
.global wait
wait:
 li a7, SYS_wait
 552:	488d                	li	a7,3
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 55a:	4891                	li	a7,4
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <read>:
.global read
read:
 li a7, SYS_read
 562:	4895                	li	a7,5
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <write>:
.global write
write:
 li a7, SYS_write
 56a:	48c1                	li	a7,16
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <close>:
.global close
close:
 li a7, SYS_close
 572:	48d5                	li	a7,21
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <kill>:
.global kill
kill:
 li a7, SYS_kill
 57a:	4899                	li	a7,6
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <exec>:
.global exec
exec:
 li a7, SYS_exec
 582:	489d                	li	a7,7
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <open>:
.global open
open:
 li a7, SYS_open
 58a:	48bd                	li	a7,15
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 592:	48c5                	li	a7,17
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 59a:	48c9                	li	a7,18
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5a2:	48a1                	li	a7,8
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <link>:
.global link
link:
 li a7, SYS_link
 5aa:	48cd                	li	a7,19
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5b2:	48d1                	li	a7,20
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5ba:	48a5                	li	a7,9
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5c2:	48a9                	li	a7,10
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5ca:	48ad                	li	a7,11
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5d2:	48b1                	li	a7,12
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5da:	48b5                	li	a7,13
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5e2:	48b9                	li	a7,14
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5ea:	1101                	addi	sp,sp,-32
 5ec:	ec06                	sd	ra,24(sp)
 5ee:	e822                	sd	s0,16(sp)
 5f0:	1000                	addi	s0,sp,32
 5f2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5f6:	4605                	li	a2,1
 5f8:	fef40593          	addi	a1,s0,-17
 5fc:	00000097          	auipc	ra,0x0
 600:	f6e080e7          	jalr	-146(ra) # 56a <write>
}
 604:	60e2                	ld	ra,24(sp)
 606:	6442                	ld	s0,16(sp)
 608:	6105                	addi	sp,sp,32
 60a:	8082                	ret

000000000000060c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 60c:	7139                	addi	sp,sp,-64
 60e:	fc06                	sd	ra,56(sp)
 610:	f822                	sd	s0,48(sp)
 612:	f426                	sd	s1,40(sp)
 614:	f04a                	sd	s2,32(sp)
 616:	ec4e                	sd	s3,24(sp)
 618:	0080                	addi	s0,sp,64
 61a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 61c:	c299                	beqz	a3,622 <printint+0x16>
 61e:	0805c963          	bltz	a1,6b0 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 622:	2581                	sext.w	a1,a1
  neg = 0;
 624:	4881                	li	a7,0
 626:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 62a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 62c:	2601                	sext.w	a2,a2
 62e:	00000517          	auipc	a0,0x0
 632:	52250513          	addi	a0,a0,1314 # b50 <digits>
 636:	883a                	mv	a6,a4
 638:	2705                	addiw	a4,a4,1
 63a:	02c5f7bb          	remuw	a5,a1,a2
 63e:	1782                	slli	a5,a5,0x20
 640:	9381                	srli	a5,a5,0x20
 642:	97aa                	add	a5,a5,a0
 644:	0007c783          	lbu	a5,0(a5)
 648:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 64c:	0005879b          	sext.w	a5,a1
 650:	02c5d5bb          	divuw	a1,a1,a2
 654:	0685                	addi	a3,a3,1
 656:	fec7f0e3          	bgeu	a5,a2,636 <printint+0x2a>
  if(neg)
 65a:	00088c63          	beqz	a7,672 <printint+0x66>
    buf[i++] = '-';
 65e:	fd070793          	addi	a5,a4,-48
 662:	00878733          	add	a4,a5,s0
 666:	02d00793          	li	a5,45
 66a:	fef70823          	sb	a5,-16(a4)
 66e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 672:	02e05863          	blez	a4,6a2 <printint+0x96>
 676:	fc040793          	addi	a5,s0,-64
 67a:	00e78933          	add	s2,a5,a4
 67e:	fff78993          	addi	s3,a5,-1
 682:	99ba                	add	s3,s3,a4
 684:	377d                	addiw	a4,a4,-1
 686:	1702                	slli	a4,a4,0x20
 688:	9301                	srli	a4,a4,0x20
 68a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 68e:	fff94583          	lbu	a1,-1(s2)
 692:	8526                	mv	a0,s1
 694:	00000097          	auipc	ra,0x0
 698:	f56080e7          	jalr	-170(ra) # 5ea <putc>
  while(--i >= 0)
 69c:	197d                	addi	s2,s2,-1
 69e:	ff3918e3          	bne	s2,s3,68e <printint+0x82>
}
 6a2:	70e2                	ld	ra,56(sp)
 6a4:	7442                	ld	s0,48(sp)
 6a6:	74a2                	ld	s1,40(sp)
 6a8:	7902                	ld	s2,32(sp)
 6aa:	69e2                	ld	s3,24(sp)
 6ac:	6121                	addi	sp,sp,64
 6ae:	8082                	ret
    x = -xx;
 6b0:	40b005bb          	negw	a1,a1
    neg = 1;
 6b4:	4885                	li	a7,1
    x = -xx;
 6b6:	bf85                	j	626 <printint+0x1a>

00000000000006b8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6b8:	7119                	addi	sp,sp,-128
 6ba:	fc86                	sd	ra,120(sp)
 6bc:	f8a2                	sd	s0,112(sp)
 6be:	f4a6                	sd	s1,104(sp)
 6c0:	f0ca                	sd	s2,96(sp)
 6c2:	ecce                	sd	s3,88(sp)
 6c4:	e8d2                	sd	s4,80(sp)
 6c6:	e4d6                	sd	s5,72(sp)
 6c8:	e0da                	sd	s6,64(sp)
 6ca:	fc5e                	sd	s7,56(sp)
 6cc:	f862                	sd	s8,48(sp)
 6ce:	f466                	sd	s9,40(sp)
 6d0:	f06a                	sd	s10,32(sp)
 6d2:	ec6e                	sd	s11,24(sp)
 6d4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6d6:	0005c903          	lbu	s2,0(a1)
 6da:	18090f63          	beqz	s2,878 <vprintf+0x1c0>
 6de:	8aaa                	mv	s5,a0
 6e0:	8b32                	mv	s6,a2
 6e2:	00158493          	addi	s1,a1,1
  state = 0;
 6e6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6e8:	02500a13          	li	s4,37
 6ec:	4c55                	li	s8,21
 6ee:	00000c97          	auipc	s9,0x0
 6f2:	40ac8c93          	addi	s9,s9,1034 # af8 <malloc+0x17c>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6f6:	02800d93          	li	s11,40
  putc(fd, 'x');
 6fa:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6fc:	00000b97          	auipc	s7,0x0
 700:	454b8b93          	addi	s7,s7,1108 # b50 <digits>
 704:	a839                	j	722 <vprintf+0x6a>
        putc(fd, c);
 706:	85ca                	mv	a1,s2
 708:	8556                	mv	a0,s5
 70a:	00000097          	auipc	ra,0x0
 70e:	ee0080e7          	jalr	-288(ra) # 5ea <putc>
 712:	a019                	j	718 <vprintf+0x60>
    } else if(state == '%'){
 714:	01498d63          	beq	s3,s4,72e <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 718:	0485                	addi	s1,s1,1
 71a:	fff4c903          	lbu	s2,-1(s1)
 71e:	14090d63          	beqz	s2,878 <vprintf+0x1c0>
    if(state == 0){
 722:	fe0999e3          	bnez	s3,714 <vprintf+0x5c>
      if(c == '%'){
 726:	ff4910e3          	bne	s2,s4,706 <vprintf+0x4e>
        state = '%';
 72a:	89d2                	mv	s3,s4
 72c:	b7f5                	j	718 <vprintf+0x60>
      if(c == 'd'){
 72e:	11490c63          	beq	s2,s4,846 <vprintf+0x18e>
 732:	f9d9079b          	addiw	a5,s2,-99
 736:	0ff7f793          	zext.b	a5,a5
 73a:	10fc6e63          	bltu	s8,a5,856 <vprintf+0x19e>
 73e:	f9d9079b          	addiw	a5,s2,-99
 742:	0ff7f713          	zext.b	a4,a5
 746:	10ec6863          	bltu	s8,a4,856 <vprintf+0x19e>
 74a:	00271793          	slli	a5,a4,0x2
 74e:	97e6                	add	a5,a5,s9
 750:	439c                	lw	a5,0(a5)
 752:	97e6                	add	a5,a5,s9
 754:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 756:	008b0913          	addi	s2,s6,8
 75a:	4685                	li	a3,1
 75c:	4629                	li	a2,10
 75e:	000b2583          	lw	a1,0(s6)
 762:	8556                	mv	a0,s5
 764:	00000097          	auipc	ra,0x0
 768:	ea8080e7          	jalr	-344(ra) # 60c <printint>
 76c:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 76e:	4981                	li	s3,0
 770:	b765                	j	718 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 772:	008b0913          	addi	s2,s6,8
 776:	4681                	li	a3,0
 778:	4629                	li	a2,10
 77a:	000b2583          	lw	a1,0(s6)
 77e:	8556                	mv	a0,s5
 780:	00000097          	auipc	ra,0x0
 784:	e8c080e7          	jalr	-372(ra) # 60c <printint>
 788:	8b4a                	mv	s6,s2
      state = 0;
 78a:	4981                	li	s3,0
 78c:	b771                	j	718 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 78e:	008b0913          	addi	s2,s6,8
 792:	4681                	li	a3,0
 794:	866a                	mv	a2,s10
 796:	000b2583          	lw	a1,0(s6)
 79a:	8556                	mv	a0,s5
 79c:	00000097          	auipc	ra,0x0
 7a0:	e70080e7          	jalr	-400(ra) # 60c <printint>
 7a4:	8b4a                	mv	s6,s2
      state = 0;
 7a6:	4981                	li	s3,0
 7a8:	bf85                	j	718 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7aa:	008b0793          	addi	a5,s6,8
 7ae:	f8f43423          	sd	a5,-120(s0)
 7b2:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7b6:	03000593          	li	a1,48
 7ba:	8556                	mv	a0,s5
 7bc:	00000097          	auipc	ra,0x0
 7c0:	e2e080e7          	jalr	-466(ra) # 5ea <putc>
  putc(fd, 'x');
 7c4:	07800593          	li	a1,120
 7c8:	8556                	mv	a0,s5
 7ca:	00000097          	auipc	ra,0x0
 7ce:	e20080e7          	jalr	-480(ra) # 5ea <putc>
 7d2:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7d4:	03c9d793          	srli	a5,s3,0x3c
 7d8:	97de                	add	a5,a5,s7
 7da:	0007c583          	lbu	a1,0(a5)
 7de:	8556                	mv	a0,s5
 7e0:	00000097          	auipc	ra,0x0
 7e4:	e0a080e7          	jalr	-502(ra) # 5ea <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7e8:	0992                	slli	s3,s3,0x4
 7ea:	397d                	addiw	s2,s2,-1
 7ec:	fe0914e3          	bnez	s2,7d4 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 7f0:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7f4:	4981                	li	s3,0
 7f6:	b70d                	j	718 <vprintf+0x60>
        s = va_arg(ap, char*);
 7f8:	008b0913          	addi	s2,s6,8
 7fc:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 800:	02098163          	beqz	s3,822 <vprintf+0x16a>
        while(*s != 0){
 804:	0009c583          	lbu	a1,0(s3)
 808:	c5ad                	beqz	a1,872 <vprintf+0x1ba>
          putc(fd, *s);
 80a:	8556                	mv	a0,s5
 80c:	00000097          	auipc	ra,0x0
 810:	dde080e7          	jalr	-546(ra) # 5ea <putc>
          s++;
 814:	0985                	addi	s3,s3,1
        while(*s != 0){
 816:	0009c583          	lbu	a1,0(s3)
 81a:	f9e5                	bnez	a1,80a <vprintf+0x152>
        s = va_arg(ap, char*);
 81c:	8b4a                	mv	s6,s2
      state = 0;
 81e:	4981                	li	s3,0
 820:	bde5                	j	718 <vprintf+0x60>
          s = "(null)";
 822:	00000997          	auipc	s3,0x0
 826:	2ce98993          	addi	s3,s3,718 # af0 <malloc+0x174>
        while(*s != 0){
 82a:	85ee                	mv	a1,s11
 82c:	bff9                	j	80a <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 82e:	008b0913          	addi	s2,s6,8
 832:	000b4583          	lbu	a1,0(s6)
 836:	8556                	mv	a0,s5
 838:	00000097          	auipc	ra,0x0
 83c:	db2080e7          	jalr	-590(ra) # 5ea <putc>
 840:	8b4a                	mv	s6,s2
      state = 0;
 842:	4981                	li	s3,0
 844:	bdd1                	j	718 <vprintf+0x60>
        putc(fd, c);
 846:	85d2                	mv	a1,s4
 848:	8556                	mv	a0,s5
 84a:	00000097          	auipc	ra,0x0
 84e:	da0080e7          	jalr	-608(ra) # 5ea <putc>
      state = 0;
 852:	4981                	li	s3,0
 854:	b5d1                	j	718 <vprintf+0x60>
        putc(fd, '%');
 856:	85d2                	mv	a1,s4
 858:	8556                	mv	a0,s5
 85a:	00000097          	auipc	ra,0x0
 85e:	d90080e7          	jalr	-624(ra) # 5ea <putc>
        putc(fd, c);
 862:	85ca                	mv	a1,s2
 864:	8556                	mv	a0,s5
 866:	00000097          	auipc	ra,0x0
 86a:	d84080e7          	jalr	-636(ra) # 5ea <putc>
      state = 0;
 86e:	4981                	li	s3,0
 870:	b565                	j	718 <vprintf+0x60>
        s = va_arg(ap, char*);
 872:	8b4a                	mv	s6,s2
      state = 0;
 874:	4981                	li	s3,0
 876:	b54d                	j	718 <vprintf+0x60>
    }
  }
}
 878:	70e6                	ld	ra,120(sp)
 87a:	7446                	ld	s0,112(sp)
 87c:	74a6                	ld	s1,104(sp)
 87e:	7906                	ld	s2,96(sp)
 880:	69e6                	ld	s3,88(sp)
 882:	6a46                	ld	s4,80(sp)
 884:	6aa6                	ld	s5,72(sp)
 886:	6b06                	ld	s6,64(sp)
 888:	7be2                	ld	s7,56(sp)
 88a:	7c42                	ld	s8,48(sp)
 88c:	7ca2                	ld	s9,40(sp)
 88e:	7d02                	ld	s10,32(sp)
 890:	6de2                	ld	s11,24(sp)
 892:	6109                	addi	sp,sp,128
 894:	8082                	ret

0000000000000896 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 896:	715d                	addi	sp,sp,-80
 898:	ec06                	sd	ra,24(sp)
 89a:	e822                	sd	s0,16(sp)
 89c:	1000                	addi	s0,sp,32
 89e:	e010                	sd	a2,0(s0)
 8a0:	e414                	sd	a3,8(s0)
 8a2:	e818                	sd	a4,16(s0)
 8a4:	ec1c                	sd	a5,24(s0)
 8a6:	03043023          	sd	a6,32(s0)
 8aa:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8ae:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8b2:	8622                	mv	a2,s0
 8b4:	00000097          	auipc	ra,0x0
 8b8:	e04080e7          	jalr	-508(ra) # 6b8 <vprintf>
}
 8bc:	60e2                	ld	ra,24(sp)
 8be:	6442                	ld	s0,16(sp)
 8c0:	6161                	addi	sp,sp,80
 8c2:	8082                	ret

00000000000008c4 <printf>:

void
printf(const char *fmt, ...)
{
 8c4:	711d                	addi	sp,sp,-96
 8c6:	ec06                	sd	ra,24(sp)
 8c8:	e822                	sd	s0,16(sp)
 8ca:	1000                	addi	s0,sp,32
 8cc:	e40c                	sd	a1,8(s0)
 8ce:	e810                	sd	a2,16(s0)
 8d0:	ec14                	sd	a3,24(s0)
 8d2:	f018                	sd	a4,32(s0)
 8d4:	f41c                	sd	a5,40(s0)
 8d6:	03043823          	sd	a6,48(s0)
 8da:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8de:	00840613          	addi	a2,s0,8
 8e2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8e6:	85aa                	mv	a1,a0
 8e8:	4505                	li	a0,1
 8ea:	00000097          	auipc	ra,0x0
 8ee:	dce080e7          	jalr	-562(ra) # 6b8 <vprintf>
}
 8f2:	60e2                	ld	ra,24(sp)
 8f4:	6442                	ld	s0,16(sp)
 8f6:	6125                	addi	sp,sp,96
 8f8:	8082                	ret

00000000000008fa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8fa:	1141                	addi	sp,sp,-16
 8fc:	e422                	sd	s0,8(sp)
 8fe:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 900:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 904:	00000797          	auipc	a5,0x0
 908:	6fc7b783          	ld	a5,1788(a5) # 1000 <freep>
 90c:	a02d                	j	936 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 90e:	4618                	lw	a4,8(a2)
 910:	9f2d                	addw	a4,a4,a1
 912:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 916:	6398                	ld	a4,0(a5)
 918:	6310                	ld	a2,0(a4)
 91a:	a83d                	j	958 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 91c:	ff852703          	lw	a4,-8(a0)
 920:	9f31                	addw	a4,a4,a2
 922:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 924:	ff053683          	ld	a3,-16(a0)
 928:	a091                	j	96c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 92a:	6398                	ld	a4,0(a5)
 92c:	00e7e463          	bltu	a5,a4,934 <free+0x3a>
 930:	00e6ea63          	bltu	a3,a4,944 <free+0x4a>
{
 934:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 936:	fed7fae3          	bgeu	a5,a3,92a <free+0x30>
 93a:	6398                	ld	a4,0(a5)
 93c:	00e6e463          	bltu	a3,a4,944 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 940:	fee7eae3          	bltu	a5,a4,934 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 944:	ff852583          	lw	a1,-8(a0)
 948:	6390                	ld	a2,0(a5)
 94a:	02059813          	slli	a6,a1,0x20
 94e:	01c85713          	srli	a4,a6,0x1c
 952:	9736                	add	a4,a4,a3
 954:	fae60de3          	beq	a2,a4,90e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 958:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 95c:	4790                	lw	a2,8(a5)
 95e:	02061593          	slli	a1,a2,0x20
 962:	01c5d713          	srli	a4,a1,0x1c
 966:	973e                	add	a4,a4,a5
 968:	fae68ae3          	beq	a3,a4,91c <free+0x22>
    p->s.ptr = bp->s.ptr;
 96c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 96e:	00000717          	auipc	a4,0x0
 972:	68f73923          	sd	a5,1682(a4) # 1000 <freep>
}
 976:	6422                	ld	s0,8(sp)
 978:	0141                	addi	sp,sp,16
 97a:	8082                	ret

000000000000097c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 97c:	7139                	addi	sp,sp,-64
 97e:	fc06                	sd	ra,56(sp)
 980:	f822                	sd	s0,48(sp)
 982:	f426                	sd	s1,40(sp)
 984:	f04a                	sd	s2,32(sp)
 986:	ec4e                	sd	s3,24(sp)
 988:	e852                	sd	s4,16(sp)
 98a:	e456                	sd	s5,8(sp)
 98c:	e05a                	sd	s6,0(sp)
 98e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 990:	02051493          	slli	s1,a0,0x20
 994:	9081                	srli	s1,s1,0x20
 996:	04bd                	addi	s1,s1,15
 998:	8091                	srli	s1,s1,0x4
 99a:	0014899b          	addiw	s3,s1,1
 99e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9a0:	00000517          	auipc	a0,0x0
 9a4:	66053503          	ld	a0,1632(a0) # 1000 <freep>
 9a8:	c515                	beqz	a0,9d4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9aa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ac:	4798                	lw	a4,8(a5)
 9ae:	02977f63          	bgeu	a4,s1,9ec <malloc+0x70>
 9b2:	8a4e                	mv	s4,s3
 9b4:	0009871b          	sext.w	a4,s3
 9b8:	6685                	lui	a3,0x1
 9ba:	00d77363          	bgeu	a4,a3,9c0 <malloc+0x44>
 9be:	6a05                	lui	s4,0x1
 9c0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9c4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9c8:	00000917          	auipc	s2,0x0
 9cc:	63890913          	addi	s2,s2,1592 # 1000 <freep>
  if(p == (char*)-1)
 9d0:	5afd                	li	s5,-1
 9d2:	a895                	j	a46 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 9d4:	00000797          	auipc	a5,0x0
 9d8:	64c78793          	addi	a5,a5,1612 # 1020 <base>
 9dc:	00000717          	auipc	a4,0x0
 9e0:	62f73223          	sd	a5,1572(a4) # 1000 <freep>
 9e4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9e6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9ea:	b7e1                	j	9b2 <malloc+0x36>
      if(p->s.size == nunits)
 9ec:	02e48c63          	beq	s1,a4,a24 <malloc+0xa8>
        p->s.size -= nunits;
 9f0:	4137073b          	subw	a4,a4,s3
 9f4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9f6:	02071693          	slli	a3,a4,0x20
 9fa:	01c6d713          	srli	a4,a3,0x1c
 9fe:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a00:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a04:	00000717          	auipc	a4,0x0
 a08:	5ea73e23          	sd	a0,1532(a4) # 1000 <freep>
      return (void*)(p + 1);
 a0c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a10:	70e2                	ld	ra,56(sp)
 a12:	7442                	ld	s0,48(sp)
 a14:	74a2                	ld	s1,40(sp)
 a16:	7902                	ld	s2,32(sp)
 a18:	69e2                	ld	s3,24(sp)
 a1a:	6a42                	ld	s4,16(sp)
 a1c:	6aa2                	ld	s5,8(sp)
 a1e:	6b02                	ld	s6,0(sp)
 a20:	6121                	addi	sp,sp,64
 a22:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a24:	6398                	ld	a4,0(a5)
 a26:	e118                	sd	a4,0(a0)
 a28:	bff1                	j	a04 <malloc+0x88>
  hp->s.size = nu;
 a2a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a2e:	0541                	addi	a0,a0,16
 a30:	00000097          	auipc	ra,0x0
 a34:	eca080e7          	jalr	-310(ra) # 8fa <free>
  return freep;
 a38:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a3c:	d971                	beqz	a0,a10 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a3e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a40:	4798                	lw	a4,8(a5)
 a42:	fa9775e3          	bgeu	a4,s1,9ec <malloc+0x70>
    if(p == freep)
 a46:	00093703          	ld	a4,0(s2)
 a4a:	853e                	mv	a0,a5
 a4c:	fef719e3          	bne	a4,a5,a3e <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a50:	8552                	mv	a0,s4
 a52:	00000097          	auipc	ra,0x0
 a56:	b80080e7          	jalr	-1152(ra) # 5d2 <sbrk>
  if(p == (char*)-1)
 a5a:	fd5518e3          	bne	a0,s5,a2a <malloc+0xae>
        return 0;
 a5e:	4501                	li	a0,0
 a60:	bf45                	j	a10 <malloc+0x94>

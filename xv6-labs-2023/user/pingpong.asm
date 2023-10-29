
user/_pingpong:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#include "kernel/stat.h"

int main(){
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
    int pf[2], pc[2];
    if(pipe(pf)<0){
   8:	fe840513          	addi	a0,s0,-24
   c:	00000097          	auipc	ra,0x0
  10:	3dc080e7          	jalr	988(ra) # 3e8 <pipe>
  14:	08054b63          	bltz	a0,aa <main+0xaa>
        fprintf(2, "pipe error\n");
        exit(1);
    }
    if(pipe(pc)<0){
  18:	fe040513          	addi	a0,s0,-32
  1c:	00000097          	auipc	ra,0x0
  20:	3cc080e7          	jalr	972(ra) # 3e8 <pipe>
  24:	0a054163          	bltz	a0,c6 <main+0xc6>
        fprintf(2, "pipe error\n");
        exit(1);
    }
    if(fork()==0){
  28:	00000097          	auipc	ra,0x0
  2c:	3a8080e7          	jalr	936(ra) # 3d0 <fork>
  30:	e94d                	bnez	a0,e2 <main+0xe2>
        close(pf[1]);
  32:	fec42503          	lw	a0,-20(s0)
  36:	00000097          	auipc	ra,0x0
  3a:	3ca080e7          	jalr	970(ra) # 400 <close>
        close(pc[0]);
  3e:	fe042503          	lw	a0,-32(s0)
  42:	00000097          	auipc	ra,0x0
  46:	3be080e7          	jalr	958(ra) # 400 <close>
        char buf[1];
        read(pf[0], buf, 1);
  4a:	4605                	li	a2,1
  4c:	fd840593          	addi	a1,s0,-40
  50:	fe842503          	lw	a0,-24(s0)
  54:	00000097          	auipc	ra,0x0
  58:	39c080e7          	jalr	924(ra) # 3f0 <read>
        printf("%d: received ping\n", getpid());
  5c:	00000097          	auipc	ra,0x0
  60:	3fc080e7          	jalr	1020(ra) # 458 <getpid>
  64:	85aa                	mv	a1,a0
  66:	00001517          	auipc	a0,0x1
  6a:	89a50513          	addi	a0,a0,-1894 # 900 <malloc+0xf6>
  6e:	00000097          	auipc	ra,0x0
  72:	6e4080e7          	jalr	1764(ra) # 752 <printf>
        write(pc[1], buf, 1);
  76:	4605                	li	a2,1
  78:	fd840593          	addi	a1,s0,-40
  7c:	fe442503          	lw	a0,-28(s0)
  80:	00000097          	auipc	ra,0x0
  84:	378080e7          	jalr	888(ra) # 3f8 <write>
        close(pf[0]);
  88:	fe842503          	lw	a0,-24(s0)
  8c:	00000097          	auipc	ra,0x0
  90:	374080e7          	jalr	884(ra) # 400 <close>
        close(pc[1]);
  94:	fe442503          	lw	a0,-28(s0)
  98:	00000097          	auipc	ra,0x0
  9c:	368080e7          	jalr	872(ra) # 400 <close>
        read(pc[0], buf, 1);
        printf("%d: received pong\n", getpid());
        close(pc[0]);
        close(pf[1]);
    }
    exit(0);
  a0:	4501                	li	a0,0
  a2:	00000097          	auipc	ra,0x0
  a6:	336080e7          	jalr	822(ra) # 3d8 <exit>
        fprintf(2, "pipe error\n");
  aa:	00001597          	auipc	a1,0x1
  ae:	84658593          	addi	a1,a1,-1978 # 8f0 <malloc+0xe6>
  b2:	4509                	li	a0,2
  b4:	00000097          	auipc	ra,0x0
  b8:	670080e7          	jalr	1648(ra) # 724 <fprintf>
        exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	31a080e7          	jalr	794(ra) # 3d8 <exit>
        fprintf(2, "pipe error\n");
  c6:	00001597          	auipc	a1,0x1
  ca:	82a58593          	addi	a1,a1,-2006 # 8f0 <malloc+0xe6>
  ce:	4509                	li	a0,2
  d0:	00000097          	auipc	ra,0x0
  d4:	654080e7          	jalr	1620(ra) # 724 <fprintf>
        exit(1);
  d8:	4505                	li	a0,1
  da:	00000097          	auipc	ra,0x0
  de:	2fe080e7          	jalr	766(ra) # 3d8 <exit>
        close(pc[1]);
  e2:	fe442503          	lw	a0,-28(s0)
  e6:	00000097          	auipc	ra,0x0
  ea:	31a080e7          	jalr	794(ra) # 400 <close>
        close(pf[0]);
  ee:	fe842503          	lw	a0,-24(s0)
  f2:	00000097          	auipc	ra,0x0
  f6:	30e080e7          	jalr	782(ra) # 400 <close>
        write(pf[1], buf, 1);
  fa:	4605                	li	a2,1
  fc:	fd840593          	addi	a1,s0,-40
 100:	fec42503          	lw	a0,-20(s0)
 104:	00000097          	auipc	ra,0x0
 108:	2f4080e7          	jalr	756(ra) # 3f8 <write>
        read(pc[0], buf, 1);
 10c:	4605                	li	a2,1
 10e:	fd840593          	addi	a1,s0,-40
 112:	fe042503          	lw	a0,-32(s0)
 116:	00000097          	auipc	ra,0x0
 11a:	2da080e7          	jalr	730(ra) # 3f0 <read>
        printf("%d: received pong\n", getpid());
 11e:	00000097          	auipc	ra,0x0
 122:	33a080e7          	jalr	826(ra) # 458 <getpid>
 126:	85aa                	mv	a1,a0
 128:	00000517          	auipc	a0,0x0
 12c:	7f050513          	addi	a0,a0,2032 # 918 <malloc+0x10e>
 130:	00000097          	auipc	ra,0x0
 134:	622080e7          	jalr	1570(ra) # 752 <printf>
        close(pc[0]);
 138:	fe042503          	lw	a0,-32(s0)
 13c:	00000097          	auipc	ra,0x0
 140:	2c4080e7          	jalr	708(ra) # 400 <close>
        close(pf[1]);
 144:	fec42503          	lw	a0,-20(s0)
 148:	00000097          	auipc	ra,0x0
 14c:	2b8080e7          	jalr	696(ra) # 400 <close>
 150:	bf81                	j	a0 <main+0xa0>

0000000000000152 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 152:	1141                	addi	sp,sp,-16
 154:	e406                	sd	ra,8(sp)
 156:	e022                	sd	s0,0(sp)
 158:	0800                	addi	s0,sp,16
  extern int main();
  main();
 15a:	00000097          	auipc	ra,0x0
 15e:	ea6080e7          	jalr	-346(ra) # 0 <main>
  exit(0);
 162:	4501                	li	a0,0
 164:	00000097          	auipc	ra,0x0
 168:	274080e7          	jalr	628(ra) # 3d8 <exit>

000000000000016c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 16c:	1141                	addi	sp,sp,-16
 16e:	e422                	sd	s0,8(sp)
 170:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 172:	87aa                	mv	a5,a0
 174:	0585                	addi	a1,a1,1
 176:	0785                	addi	a5,a5,1
 178:	fff5c703          	lbu	a4,-1(a1)
 17c:	fee78fa3          	sb	a4,-1(a5)
 180:	fb75                	bnez	a4,174 <strcpy+0x8>
    ;
  return os;
}
 182:	6422                	ld	s0,8(sp)
 184:	0141                	addi	sp,sp,16
 186:	8082                	ret

0000000000000188 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 188:	1141                	addi	sp,sp,-16
 18a:	e422                	sd	s0,8(sp)
 18c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 18e:	00054783          	lbu	a5,0(a0)
 192:	cb91                	beqz	a5,1a6 <strcmp+0x1e>
 194:	0005c703          	lbu	a4,0(a1)
 198:	00f71763          	bne	a4,a5,1a6 <strcmp+0x1e>
    p++, q++;
 19c:	0505                	addi	a0,a0,1
 19e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1a0:	00054783          	lbu	a5,0(a0)
 1a4:	fbe5                	bnez	a5,194 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1a6:	0005c503          	lbu	a0,0(a1)
}
 1aa:	40a7853b          	subw	a0,a5,a0
 1ae:	6422                	ld	s0,8(sp)
 1b0:	0141                	addi	sp,sp,16
 1b2:	8082                	ret

00000000000001b4 <strlen>:

uint
strlen(const char *s)
{
 1b4:	1141                	addi	sp,sp,-16
 1b6:	e422                	sd	s0,8(sp)
 1b8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1ba:	00054783          	lbu	a5,0(a0)
 1be:	cf91                	beqz	a5,1da <strlen+0x26>
 1c0:	0505                	addi	a0,a0,1
 1c2:	87aa                	mv	a5,a0
 1c4:	4685                	li	a3,1
 1c6:	9e89                	subw	a3,a3,a0
 1c8:	00f6853b          	addw	a0,a3,a5
 1cc:	0785                	addi	a5,a5,1
 1ce:	fff7c703          	lbu	a4,-1(a5)
 1d2:	fb7d                	bnez	a4,1c8 <strlen+0x14>
    ;
  return n;
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	addi	sp,sp,16
 1d8:	8082                	ret
  for(n = 0; s[n]; n++)
 1da:	4501                	li	a0,0
 1dc:	bfe5                	j	1d4 <strlen+0x20>

00000000000001de <memset>:

void*
memset(void *dst, int c, uint n)
{
 1de:	1141                	addi	sp,sp,-16
 1e0:	e422                	sd	s0,8(sp)
 1e2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1e4:	ca19                	beqz	a2,1fa <memset+0x1c>
 1e6:	87aa                	mv	a5,a0
 1e8:	1602                	slli	a2,a2,0x20
 1ea:	9201                	srli	a2,a2,0x20
 1ec:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1f0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1f4:	0785                	addi	a5,a5,1
 1f6:	fee79de3          	bne	a5,a4,1f0 <memset+0x12>
  }
  return dst;
}
 1fa:	6422                	ld	s0,8(sp)
 1fc:	0141                	addi	sp,sp,16
 1fe:	8082                	ret

0000000000000200 <strchr>:

char*
strchr(const char *s, char c)
{
 200:	1141                	addi	sp,sp,-16
 202:	e422                	sd	s0,8(sp)
 204:	0800                	addi	s0,sp,16
  for(; *s; s++)
 206:	00054783          	lbu	a5,0(a0)
 20a:	cb99                	beqz	a5,220 <strchr+0x20>
    if(*s == c)
 20c:	00f58763          	beq	a1,a5,21a <strchr+0x1a>
  for(; *s; s++)
 210:	0505                	addi	a0,a0,1
 212:	00054783          	lbu	a5,0(a0)
 216:	fbfd                	bnez	a5,20c <strchr+0xc>
      return (char*)s;
  return 0;
 218:	4501                	li	a0,0
}
 21a:	6422                	ld	s0,8(sp)
 21c:	0141                	addi	sp,sp,16
 21e:	8082                	ret
  return 0;
 220:	4501                	li	a0,0
 222:	bfe5                	j	21a <strchr+0x1a>

0000000000000224 <gets>:

char*
gets(char *buf, int max)
{
 224:	711d                	addi	sp,sp,-96
 226:	ec86                	sd	ra,88(sp)
 228:	e8a2                	sd	s0,80(sp)
 22a:	e4a6                	sd	s1,72(sp)
 22c:	e0ca                	sd	s2,64(sp)
 22e:	fc4e                	sd	s3,56(sp)
 230:	f852                	sd	s4,48(sp)
 232:	f456                	sd	s5,40(sp)
 234:	f05a                	sd	s6,32(sp)
 236:	ec5e                	sd	s7,24(sp)
 238:	1080                	addi	s0,sp,96
 23a:	8baa                	mv	s7,a0
 23c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 23e:	892a                	mv	s2,a0
 240:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 242:	4aa9                	li	s5,10
 244:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 246:	89a6                	mv	s3,s1
 248:	2485                	addiw	s1,s1,1
 24a:	0344d863          	bge	s1,s4,27a <gets+0x56>
    cc = read(0, &c, 1);
 24e:	4605                	li	a2,1
 250:	faf40593          	addi	a1,s0,-81
 254:	4501                	li	a0,0
 256:	00000097          	auipc	ra,0x0
 25a:	19a080e7          	jalr	410(ra) # 3f0 <read>
    if(cc < 1)
 25e:	00a05e63          	blez	a0,27a <gets+0x56>
    buf[i++] = c;
 262:	faf44783          	lbu	a5,-81(s0)
 266:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 26a:	01578763          	beq	a5,s5,278 <gets+0x54>
 26e:	0905                	addi	s2,s2,1
 270:	fd679be3          	bne	a5,s6,246 <gets+0x22>
  for(i=0; i+1 < max; ){
 274:	89a6                	mv	s3,s1
 276:	a011                	j	27a <gets+0x56>
 278:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 27a:	99de                	add	s3,s3,s7
 27c:	00098023          	sb	zero,0(s3)
  return buf;
}
 280:	855e                	mv	a0,s7
 282:	60e6                	ld	ra,88(sp)
 284:	6446                	ld	s0,80(sp)
 286:	64a6                	ld	s1,72(sp)
 288:	6906                	ld	s2,64(sp)
 28a:	79e2                	ld	s3,56(sp)
 28c:	7a42                	ld	s4,48(sp)
 28e:	7aa2                	ld	s5,40(sp)
 290:	7b02                	ld	s6,32(sp)
 292:	6be2                	ld	s7,24(sp)
 294:	6125                	addi	sp,sp,96
 296:	8082                	ret

0000000000000298 <stat>:

int
stat(const char *n, struct stat *st)
{
 298:	1101                	addi	sp,sp,-32
 29a:	ec06                	sd	ra,24(sp)
 29c:	e822                	sd	s0,16(sp)
 29e:	e426                	sd	s1,8(sp)
 2a0:	e04a                	sd	s2,0(sp)
 2a2:	1000                	addi	s0,sp,32
 2a4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a6:	4581                	li	a1,0
 2a8:	00000097          	auipc	ra,0x0
 2ac:	170080e7          	jalr	368(ra) # 418 <open>
  if(fd < 0)
 2b0:	02054563          	bltz	a0,2da <stat+0x42>
 2b4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2b6:	85ca                	mv	a1,s2
 2b8:	00000097          	auipc	ra,0x0
 2bc:	178080e7          	jalr	376(ra) # 430 <fstat>
 2c0:	892a                	mv	s2,a0
  close(fd);
 2c2:	8526                	mv	a0,s1
 2c4:	00000097          	auipc	ra,0x0
 2c8:	13c080e7          	jalr	316(ra) # 400 <close>
  return r;
}
 2cc:	854a                	mv	a0,s2
 2ce:	60e2                	ld	ra,24(sp)
 2d0:	6442                	ld	s0,16(sp)
 2d2:	64a2                	ld	s1,8(sp)
 2d4:	6902                	ld	s2,0(sp)
 2d6:	6105                	addi	sp,sp,32
 2d8:	8082                	ret
    return -1;
 2da:	597d                	li	s2,-1
 2dc:	bfc5                	j	2cc <stat+0x34>

00000000000002de <atoi>:

int
atoi(const char *s)
{
 2de:	1141                	addi	sp,sp,-16
 2e0:	e422                	sd	s0,8(sp)
 2e2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e4:	00054683          	lbu	a3,0(a0)
 2e8:	fd06879b          	addiw	a5,a3,-48
 2ec:	0ff7f793          	zext.b	a5,a5
 2f0:	4625                	li	a2,9
 2f2:	02f66863          	bltu	a2,a5,322 <atoi+0x44>
 2f6:	872a                	mv	a4,a0
  n = 0;
 2f8:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2fa:	0705                	addi	a4,a4,1
 2fc:	0025179b          	slliw	a5,a0,0x2
 300:	9fa9                	addw	a5,a5,a0
 302:	0017979b          	slliw	a5,a5,0x1
 306:	9fb5                	addw	a5,a5,a3
 308:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 30c:	00074683          	lbu	a3,0(a4)
 310:	fd06879b          	addiw	a5,a3,-48
 314:	0ff7f793          	zext.b	a5,a5
 318:	fef671e3          	bgeu	a2,a5,2fa <atoi+0x1c>
  return n;
}
 31c:	6422                	ld	s0,8(sp)
 31e:	0141                	addi	sp,sp,16
 320:	8082                	ret
  n = 0;
 322:	4501                	li	a0,0
 324:	bfe5                	j	31c <atoi+0x3e>

0000000000000326 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 326:	1141                	addi	sp,sp,-16
 328:	e422                	sd	s0,8(sp)
 32a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 32c:	02b57463          	bgeu	a0,a1,354 <memmove+0x2e>
    while(n-- > 0)
 330:	00c05f63          	blez	a2,34e <memmove+0x28>
 334:	1602                	slli	a2,a2,0x20
 336:	9201                	srli	a2,a2,0x20
 338:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 33c:	872a                	mv	a4,a0
      *dst++ = *src++;
 33e:	0585                	addi	a1,a1,1
 340:	0705                	addi	a4,a4,1
 342:	fff5c683          	lbu	a3,-1(a1)
 346:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 34a:	fee79ae3          	bne	a5,a4,33e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 34e:	6422                	ld	s0,8(sp)
 350:	0141                	addi	sp,sp,16
 352:	8082                	ret
    dst += n;
 354:	00c50733          	add	a4,a0,a2
    src += n;
 358:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 35a:	fec05ae3          	blez	a2,34e <memmove+0x28>
 35e:	fff6079b          	addiw	a5,a2,-1
 362:	1782                	slli	a5,a5,0x20
 364:	9381                	srli	a5,a5,0x20
 366:	fff7c793          	not	a5,a5
 36a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 36c:	15fd                	addi	a1,a1,-1
 36e:	177d                	addi	a4,a4,-1
 370:	0005c683          	lbu	a3,0(a1)
 374:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 378:	fee79ae3          	bne	a5,a4,36c <memmove+0x46>
 37c:	bfc9                	j	34e <memmove+0x28>

000000000000037e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 37e:	1141                	addi	sp,sp,-16
 380:	e422                	sd	s0,8(sp)
 382:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 384:	ca05                	beqz	a2,3b4 <memcmp+0x36>
 386:	fff6069b          	addiw	a3,a2,-1
 38a:	1682                	slli	a3,a3,0x20
 38c:	9281                	srli	a3,a3,0x20
 38e:	0685                	addi	a3,a3,1
 390:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 392:	00054783          	lbu	a5,0(a0)
 396:	0005c703          	lbu	a4,0(a1)
 39a:	00e79863          	bne	a5,a4,3aa <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 39e:	0505                	addi	a0,a0,1
    p2++;
 3a0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3a2:	fed518e3          	bne	a0,a3,392 <memcmp+0x14>
  }
  return 0;
 3a6:	4501                	li	a0,0
 3a8:	a019                	j	3ae <memcmp+0x30>
      return *p1 - *p2;
 3aa:	40e7853b          	subw	a0,a5,a4
}
 3ae:	6422                	ld	s0,8(sp)
 3b0:	0141                	addi	sp,sp,16
 3b2:	8082                	ret
  return 0;
 3b4:	4501                	li	a0,0
 3b6:	bfe5                	j	3ae <memcmp+0x30>

00000000000003b8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3b8:	1141                	addi	sp,sp,-16
 3ba:	e406                	sd	ra,8(sp)
 3bc:	e022                	sd	s0,0(sp)
 3be:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3c0:	00000097          	auipc	ra,0x0
 3c4:	f66080e7          	jalr	-154(ra) # 326 <memmove>
}
 3c8:	60a2                	ld	ra,8(sp)
 3ca:	6402                	ld	s0,0(sp)
 3cc:	0141                	addi	sp,sp,16
 3ce:	8082                	ret

00000000000003d0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3d0:	4885                	li	a7,1
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3d8:	4889                	li	a7,2
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3e0:	488d                	li	a7,3
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3e8:	4891                	li	a7,4
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <read>:
.global read
read:
 li a7, SYS_read
 3f0:	4895                	li	a7,5
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <write>:
.global write
write:
 li a7, SYS_write
 3f8:	48c1                	li	a7,16
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <close>:
.global close
close:
 li a7, SYS_close
 400:	48d5                	li	a7,21
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <kill>:
.global kill
kill:
 li a7, SYS_kill
 408:	4899                	li	a7,6
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <exec>:
.global exec
exec:
 li a7, SYS_exec
 410:	489d                	li	a7,7
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <open>:
.global open
open:
 li a7, SYS_open
 418:	48bd                	li	a7,15
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 420:	48c5                	li	a7,17
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 428:	48c9                	li	a7,18
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 430:	48a1                	li	a7,8
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <link>:
.global link
link:
 li a7, SYS_link
 438:	48cd                	li	a7,19
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 440:	48d1                	li	a7,20
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 448:	48a5                	li	a7,9
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <dup>:
.global dup
dup:
 li a7, SYS_dup
 450:	48a9                	li	a7,10
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 458:	48ad                	li	a7,11
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 460:	48b1                	li	a7,12
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 468:	48b5                	li	a7,13
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 470:	48b9                	li	a7,14
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 478:	1101                	addi	sp,sp,-32
 47a:	ec06                	sd	ra,24(sp)
 47c:	e822                	sd	s0,16(sp)
 47e:	1000                	addi	s0,sp,32
 480:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 484:	4605                	li	a2,1
 486:	fef40593          	addi	a1,s0,-17
 48a:	00000097          	auipc	ra,0x0
 48e:	f6e080e7          	jalr	-146(ra) # 3f8 <write>
}
 492:	60e2                	ld	ra,24(sp)
 494:	6442                	ld	s0,16(sp)
 496:	6105                	addi	sp,sp,32
 498:	8082                	ret

000000000000049a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 49a:	7139                	addi	sp,sp,-64
 49c:	fc06                	sd	ra,56(sp)
 49e:	f822                	sd	s0,48(sp)
 4a0:	f426                	sd	s1,40(sp)
 4a2:	f04a                	sd	s2,32(sp)
 4a4:	ec4e                	sd	s3,24(sp)
 4a6:	0080                	addi	s0,sp,64
 4a8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4aa:	c299                	beqz	a3,4b0 <printint+0x16>
 4ac:	0805c963          	bltz	a1,53e <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4b0:	2581                	sext.w	a1,a1
  neg = 0;
 4b2:	4881                	li	a7,0
 4b4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4b8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4ba:	2601                	sext.w	a2,a2
 4bc:	00000517          	auipc	a0,0x0
 4c0:	4d450513          	addi	a0,a0,1236 # 990 <digits>
 4c4:	883a                	mv	a6,a4
 4c6:	2705                	addiw	a4,a4,1
 4c8:	02c5f7bb          	remuw	a5,a1,a2
 4cc:	1782                	slli	a5,a5,0x20
 4ce:	9381                	srli	a5,a5,0x20
 4d0:	97aa                	add	a5,a5,a0
 4d2:	0007c783          	lbu	a5,0(a5)
 4d6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4da:	0005879b          	sext.w	a5,a1
 4de:	02c5d5bb          	divuw	a1,a1,a2
 4e2:	0685                	addi	a3,a3,1
 4e4:	fec7f0e3          	bgeu	a5,a2,4c4 <printint+0x2a>
  if(neg)
 4e8:	00088c63          	beqz	a7,500 <printint+0x66>
    buf[i++] = '-';
 4ec:	fd070793          	addi	a5,a4,-48
 4f0:	00878733          	add	a4,a5,s0
 4f4:	02d00793          	li	a5,45
 4f8:	fef70823          	sb	a5,-16(a4)
 4fc:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 500:	02e05863          	blez	a4,530 <printint+0x96>
 504:	fc040793          	addi	a5,s0,-64
 508:	00e78933          	add	s2,a5,a4
 50c:	fff78993          	addi	s3,a5,-1
 510:	99ba                	add	s3,s3,a4
 512:	377d                	addiw	a4,a4,-1
 514:	1702                	slli	a4,a4,0x20
 516:	9301                	srli	a4,a4,0x20
 518:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 51c:	fff94583          	lbu	a1,-1(s2)
 520:	8526                	mv	a0,s1
 522:	00000097          	auipc	ra,0x0
 526:	f56080e7          	jalr	-170(ra) # 478 <putc>
  while(--i >= 0)
 52a:	197d                	addi	s2,s2,-1
 52c:	ff3918e3          	bne	s2,s3,51c <printint+0x82>
}
 530:	70e2                	ld	ra,56(sp)
 532:	7442                	ld	s0,48(sp)
 534:	74a2                	ld	s1,40(sp)
 536:	7902                	ld	s2,32(sp)
 538:	69e2                	ld	s3,24(sp)
 53a:	6121                	addi	sp,sp,64
 53c:	8082                	ret
    x = -xx;
 53e:	40b005bb          	negw	a1,a1
    neg = 1;
 542:	4885                	li	a7,1
    x = -xx;
 544:	bf85                	j	4b4 <printint+0x1a>

0000000000000546 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 546:	7119                	addi	sp,sp,-128
 548:	fc86                	sd	ra,120(sp)
 54a:	f8a2                	sd	s0,112(sp)
 54c:	f4a6                	sd	s1,104(sp)
 54e:	f0ca                	sd	s2,96(sp)
 550:	ecce                	sd	s3,88(sp)
 552:	e8d2                	sd	s4,80(sp)
 554:	e4d6                	sd	s5,72(sp)
 556:	e0da                	sd	s6,64(sp)
 558:	fc5e                	sd	s7,56(sp)
 55a:	f862                	sd	s8,48(sp)
 55c:	f466                	sd	s9,40(sp)
 55e:	f06a                	sd	s10,32(sp)
 560:	ec6e                	sd	s11,24(sp)
 562:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 564:	0005c903          	lbu	s2,0(a1)
 568:	18090f63          	beqz	s2,706 <vprintf+0x1c0>
 56c:	8aaa                	mv	s5,a0
 56e:	8b32                	mv	s6,a2
 570:	00158493          	addi	s1,a1,1
  state = 0;
 574:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 576:	02500a13          	li	s4,37
 57a:	4c55                	li	s8,21
 57c:	00000c97          	auipc	s9,0x0
 580:	3bcc8c93          	addi	s9,s9,956 # 938 <malloc+0x12e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 584:	02800d93          	li	s11,40
  putc(fd, 'x');
 588:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 58a:	00000b97          	auipc	s7,0x0
 58e:	406b8b93          	addi	s7,s7,1030 # 990 <digits>
 592:	a839                	j	5b0 <vprintf+0x6a>
        putc(fd, c);
 594:	85ca                	mv	a1,s2
 596:	8556                	mv	a0,s5
 598:	00000097          	auipc	ra,0x0
 59c:	ee0080e7          	jalr	-288(ra) # 478 <putc>
 5a0:	a019                	j	5a6 <vprintf+0x60>
    } else if(state == '%'){
 5a2:	01498d63          	beq	s3,s4,5bc <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 5a6:	0485                	addi	s1,s1,1
 5a8:	fff4c903          	lbu	s2,-1(s1)
 5ac:	14090d63          	beqz	s2,706 <vprintf+0x1c0>
    if(state == 0){
 5b0:	fe0999e3          	bnez	s3,5a2 <vprintf+0x5c>
      if(c == '%'){
 5b4:	ff4910e3          	bne	s2,s4,594 <vprintf+0x4e>
        state = '%';
 5b8:	89d2                	mv	s3,s4
 5ba:	b7f5                	j	5a6 <vprintf+0x60>
      if(c == 'd'){
 5bc:	11490c63          	beq	s2,s4,6d4 <vprintf+0x18e>
 5c0:	f9d9079b          	addiw	a5,s2,-99
 5c4:	0ff7f793          	zext.b	a5,a5
 5c8:	10fc6e63          	bltu	s8,a5,6e4 <vprintf+0x19e>
 5cc:	f9d9079b          	addiw	a5,s2,-99
 5d0:	0ff7f713          	zext.b	a4,a5
 5d4:	10ec6863          	bltu	s8,a4,6e4 <vprintf+0x19e>
 5d8:	00271793          	slli	a5,a4,0x2
 5dc:	97e6                	add	a5,a5,s9
 5de:	439c                	lw	a5,0(a5)
 5e0:	97e6                	add	a5,a5,s9
 5e2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5e4:	008b0913          	addi	s2,s6,8
 5e8:	4685                	li	a3,1
 5ea:	4629                	li	a2,10
 5ec:	000b2583          	lw	a1,0(s6)
 5f0:	8556                	mv	a0,s5
 5f2:	00000097          	auipc	ra,0x0
 5f6:	ea8080e7          	jalr	-344(ra) # 49a <printint>
 5fa:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5fc:	4981                	li	s3,0
 5fe:	b765                	j	5a6 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 600:	008b0913          	addi	s2,s6,8
 604:	4681                	li	a3,0
 606:	4629                	li	a2,10
 608:	000b2583          	lw	a1,0(s6)
 60c:	8556                	mv	a0,s5
 60e:	00000097          	auipc	ra,0x0
 612:	e8c080e7          	jalr	-372(ra) # 49a <printint>
 616:	8b4a                	mv	s6,s2
      state = 0;
 618:	4981                	li	s3,0
 61a:	b771                	j	5a6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 61c:	008b0913          	addi	s2,s6,8
 620:	4681                	li	a3,0
 622:	866a                	mv	a2,s10
 624:	000b2583          	lw	a1,0(s6)
 628:	8556                	mv	a0,s5
 62a:	00000097          	auipc	ra,0x0
 62e:	e70080e7          	jalr	-400(ra) # 49a <printint>
 632:	8b4a                	mv	s6,s2
      state = 0;
 634:	4981                	li	s3,0
 636:	bf85                	j	5a6 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 638:	008b0793          	addi	a5,s6,8
 63c:	f8f43423          	sd	a5,-120(s0)
 640:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 644:	03000593          	li	a1,48
 648:	8556                	mv	a0,s5
 64a:	00000097          	auipc	ra,0x0
 64e:	e2e080e7          	jalr	-466(ra) # 478 <putc>
  putc(fd, 'x');
 652:	07800593          	li	a1,120
 656:	8556                	mv	a0,s5
 658:	00000097          	auipc	ra,0x0
 65c:	e20080e7          	jalr	-480(ra) # 478 <putc>
 660:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 662:	03c9d793          	srli	a5,s3,0x3c
 666:	97de                	add	a5,a5,s7
 668:	0007c583          	lbu	a1,0(a5)
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	e0a080e7          	jalr	-502(ra) # 478 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 676:	0992                	slli	s3,s3,0x4
 678:	397d                	addiw	s2,s2,-1
 67a:	fe0914e3          	bnez	s2,662 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 67e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 682:	4981                	li	s3,0
 684:	b70d                	j	5a6 <vprintf+0x60>
        s = va_arg(ap, char*);
 686:	008b0913          	addi	s2,s6,8
 68a:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 68e:	02098163          	beqz	s3,6b0 <vprintf+0x16a>
        while(*s != 0){
 692:	0009c583          	lbu	a1,0(s3)
 696:	c5ad                	beqz	a1,700 <vprintf+0x1ba>
          putc(fd, *s);
 698:	8556                	mv	a0,s5
 69a:	00000097          	auipc	ra,0x0
 69e:	dde080e7          	jalr	-546(ra) # 478 <putc>
          s++;
 6a2:	0985                	addi	s3,s3,1
        while(*s != 0){
 6a4:	0009c583          	lbu	a1,0(s3)
 6a8:	f9e5                	bnez	a1,698 <vprintf+0x152>
        s = va_arg(ap, char*);
 6aa:	8b4a                	mv	s6,s2
      state = 0;
 6ac:	4981                	li	s3,0
 6ae:	bde5                	j	5a6 <vprintf+0x60>
          s = "(null)";
 6b0:	00000997          	auipc	s3,0x0
 6b4:	28098993          	addi	s3,s3,640 # 930 <malloc+0x126>
        while(*s != 0){
 6b8:	85ee                	mv	a1,s11
 6ba:	bff9                	j	698 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 6bc:	008b0913          	addi	s2,s6,8
 6c0:	000b4583          	lbu	a1,0(s6)
 6c4:	8556                	mv	a0,s5
 6c6:	00000097          	auipc	ra,0x0
 6ca:	db2080e7          	jalr	-590(ra) # 478 <putc>
 6ce:	8b4a                	mv	s6,s2
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	bdd1                	j	5a6 <vprintf+0x60>
        putc(fd, c);
 6d4:	85d2                	mv	a1,s4
 6d6:	8556                	mv	a0,s5
 6d8:	00000097          	auipc	ra,0x0
 6dc:	da0080e7          	jalr	-608(ra) # 478 <putc>
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	b5d1                	j	5a6 <vprintf+0x60>
        putc(fd, '%');
 6e4:	85d2                	mv	a1,s4
 6e6:	8556                	mv	a0,s5
 6e8:	00000097          	auipc	ra,0x0
 6ec:	d90080e7          	jalr	-624(ra) # 478 <putc>
        putc(fd, c);
 6f0:	85ca                	mv	a1,s2
 6f2:	8556                	mv	a0,s5
 6f4:	00000097          	auipc	ra,0x0
 6f8:	d84080e7          	jalr	-636(ra) # 478 <putc>
      state = 0;
 6fc:	4981                	li	s3,0
 6fe:	b565                	j	5a6 <vprintf+0x60>
        s = va_arg(ap, char*);
 700:	8b4a                	mv	s6,s2
      state = 0;
 702:	4981                	li	s3,0
 704:	b54d                	j	5a6 <vprintf+0x60>
    }
  }
}
 706:	70e6                	ld	ra,120(sp)
 708:	7446                	ld	s0,112(sp)
 70a:	74a6                	ld	s1,104(sp)
 70c:	7906                	ld	s2,96(sp)
 70e:	69e6                	ld	s3,88(sp)
 710:	6a46                	ld	s4,80(sp)
 712:	6aa6                	ld	s5,72(sp)
 714:	6b06                	ld	s6,64(sp)
 716:	7be2                	ld	s7,56(sp)
 718:	7c42                	ld	s8,48(sp)
 71a:	7ca2                	ld	s9,40(sp)
 71c:	7d02                	ld	s10,32(sp)
 71e:	6de2                	ld	s11,24(sp)
 720:	6109                	addi	sp,sp,128
 722:	8082                	ret

0000000000000724 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 724:	715d                	addi	sp,sp,-80
 726:	ec06                	sd	ra,24(sp)
 728:	e822                	sd	s0,16(sp)
 72a:	1000                	addi	s0,sp,32
 72c:	e010                	sd	a2,0(s0)
 72e:	e414                	sd	a3,8(s0)
 730:	e818                	sd	a4,16(s0)
 732:	ec1c                	sd	a5,24(s0)
 734:	03043023          	sd	a6,32(s0)
 738:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 73c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 740:	8622                	mv	a2,s0
 742:	00000097          	auipc	ra,0x0
 746:	e04080e7          	jalr	-508(ra) # 546 <vprintf>
}
 74a:	60e2                	ld	ra,24(sp)
 74c:	6442                	ld	s0,16(sp)
 74e:	6161                	addi	sp,sp,80
 750:	8082                	ret

0000000000000752 <printf>:

void
printf(const char *fmt, ...)
{
 752:	711d                	addi	sp,sp,-96
 754:	ec06                	sd	ra,24(sp)
 756:	e822                	sd	s0,16(sp)
 758:	1000                	addi	s0,sp,32
 75a:	e40c                	sd	a1,8(s0)
 75c:	e810                	sd	a2,16(s0)
 75e:	ec14                	sd	a3,24(s0)
 760:	f018                	sd	a4,32(s0)
 762:	f41c                	sd	a5,40(s0)
 764:	03043823          	sd	a6,48(s0)
 768:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 76c:	00840613          	addi	a2,s0,8
 770:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 774:	85aa                	mv	a1,a0
 776:	4505                	li	a0,1
 778:	00000097          	auipc	ra,0x0
 77c:	dce080e7          	jalr	-562(ra) # 546 <vprintf>
}
 780:	60e2                	ld	ra,24(sp)
 782:	6442                	ld	s0,16(sp)
 784:	6125                	addi	sp,sp,96
 786:	8082                	ret

0000000000000788 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 788:	1141                	addi	sp,sp,-16
 78a:	e422                	sd	s0,8(sp)
 78c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 78e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 792:	00001797          	auipc	a5,0x1
 796:	86e7b783          	ld	a5,-1938(a5) # 1000 <freep>
 79a:	a02d                	j	7c4 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 79c:	4618                	lw	a4,8(a2)
 79e:	9f2d                	addw	a4,a4,a1
 7a0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7a4:	6398                	ld	a4,0(a5)
 7a6:	6310                	ld	a2,0(a4)
 7a8:	a83d                	j	7e6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7aa:	ff852703          	lw	a4,-8(a0)
 7ae:	9f31                	addw	a4,a4,a2
 7b0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7b2:	ff053683          	ld	a3,-16(a0)
 7b6:	a091                	j	7fa <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b8:	6398                	ld	a4,0(a5)
 7ba:	00e7e463          	bltu	a5,a4,7c2 <free+0x3a>
 7be:	00e6ea63          	bltu	a3,a4,7d2 <free+0x4a>
{
 7c2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c4:	fed7fae3          	bgeu	a5,a3,7b8 <free+0x30>
 7c8:	6398                	ld	a4,0(a5)
 7ca:	00e6e463          	bltu	a3,a4,7d2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ce:	fee7eae3          	bltu	a5,a4,7c2 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7d2:	ff852583          	lw	a1,-8(a0)
 7d6:	6390                	ld	a2,0(a5)
 7d8:	02059813          	slli	a6,a1,0x20
 7dc:	01c85713          	srli	a4,a6,0x1c
 7e0:	9736                	add	a4,a4,a3
 7e2:	fae60de3          	beq	a2,a4,79c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7e6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7ea:	4790                	lw	a2,8(a5)
 7ec:	02061593          	slli	a1,a2,0x20
 7f0:	01c5d713          	srli	a4,a1,0x1c
 7f4:	973e                	add	a4,a4,a5
 7f6:	fae68ae3          	beq	a3,a4,7aa <free+0x22>
    p->s.ptr = bp->s.ptr;
 7fa:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7fc:	00001717          	auipc	a4,0x1
 800:	80f73223          	sd	a5,-2044(a4) # 1000 <freep>
}
 804:	6422                	ld	s0,8(sp)
 806:	0141                	addi	sp,sp,16
 808:	8082                	ret

000000000000080a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 80a:	7139                	addi	sp,sp,-64
 80c:	fc06                	sd	ra,56(sp)
 80e:	f822                	sd	s0,48(sp)
 810:	f426                	sd	s1,40(sp)
 812:	f04a                	sd	s2,32(sp)
 814:	ec4e                	sd	s3,24(sp)
 816:	e852                	sd	s4,16(sp)
 818:	e456                	sd	s5,8(sp)
 81a:	e05a                	sd	s6,0(sp)
 81c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 81e:	02051493          	slli	s1,a0,0x20
 822:	9081                	srli	s1,s1,0x20
 824:	04bd                	addi	s1,s1,15
 826:	8091                	srli	s1,s1,0x4
 828:	0014899b          	addiw	s3,s1,1
 82c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 82e:	00000517          	auipc	a0,0x0
 832:	7d253503          	ld	a0,2002(a0) # 1000 <freep>
 836:	c515                	beqz	a0,862 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 838:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 83a:	4798                	lw	a4,8(a5)
 83c:	02977f63          	bgeu	a4,s1,87a <malloc+0x70>
 840:	8a4e                	mv	s4,s3
 842:	0009871b          	sext.w	a4,s3
 846:	6685                	lui	a3,0x1
 848:	00d77363          	bgeu	a4,a3,84e <malloc+0x44>
 84c:	6a05                	lui	s4,0x1
 84e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 852:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 856:	00000917          	auipc	s2,0x0
 85a:	7aa90913          	addi	s2,s2,1962 # 1000 <freep>
  if(p == (char*)-1)
 85e:	5afd                	li	s5,-1
 860:	a895                	j	8d4 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 862:	00000797          	auipc	a5,0x0
 866:	7ae78793          	addi	a5,a5,1966 # 1010 <base>
 86a:	00000717          	auipc	a4,0x0
 86e:	78f73b23          	sd	a5,1942(a4) # 1000 <freep>
 872:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 874:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 878:	b7e1                	j	840 <malloc+0x36>
      if(p->s.size == nunits)
 87a:	02e48c63          	beq	s1,a4,8b2 <malloc+0xa8>
        p->s.size -= nunits;
 87e:	4137073b          	subw	a4,a4,s3
 882:	c798                	sw	a4,8(a5)
        p += p->s.size;
 884:	02071693          	slli	a3,a4,0x20
 888:	01c6d713          	srli	a4,a3,0x1c
 88c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 88e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 892:	00000717          	auipc	a4,0x0
 896:	76a73723          	sd	a0,1902(a4) # 1000 <freep>
      return (void*)(p + 1);
 89a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 89e:	70e2                	ld	ra,56(sp)
 8a0:	7442                	ld	s0,48(sp)
 8a2:	74a2                	ld	s1,40(sp)
 8a4:	7902                	ld	s2,32(sp)
 8a6:	69e2                	ld	s3,24(sp)
 8a8:	6a42                	ld	s4,16(sp)
 8aa:	6aa2                	ld	s5,8(sp)
 8ac:	6b02                	ld	s6,0(sp)
 8ae:	6121                	addi	sp,sp,64
 8b0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8b2:	6398                	ld	a4,0(a5)
 8b4:	e118                	sd	a4,0(a0)
 8b6:	bff1                	j	892 <malloc+0x88>
  hp->s.size = nu;
 8b8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8bc:	0541                	addi	a0,a0,16
 8be:	00000097          	auipc	ra,0x0
 8c2:	eca080e7          	jalr	-310(ra) # 788 <free>
  return freep;
 8c6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8ca:	d971                	beqz	a0,89e <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8cc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ce:	4798                	lw	a4,8(a5)
 8d0:	fa9775e3          	bgeu	a4,s1,87a <malloc+0x70>
    if(p == freep)
 8d4:	00093703          	ld	a4,0(s2)
 8d8:	853e                	mv	a0,a5
 8da:	fef719e3          	bne	a4,a5,8cc <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8de:	8552                	mv	a0,s4
 8e0:	00000097          	auipc	ra,0x0
 8e4:	b80080e7          	jalr	-1152(ra) # 460 <sbrk>
  if(p == (char*)-1)
 8e8:	fd5518e3          	bne	a0,s5,8b8 <malloc+0xae>
        return 0;
 8ec:	4501                	li	a0,0
 8ee:	bf45                	j	89e <malloc+0x94>


user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <prime_seive>:
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#include "kernel/stat.h"

void prime_seive(int fd[2]){
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
   a:	84aa                	mv	s1,a0
    int prime;
    if(read(fd[0], &prime, sizeof(prime)) == 0){
   c:	4611                	li	a2,4
   e:	fdc40593          	addi	a1,s0,-36
  12:	4108                	lw	a0,0(a0)
  14:	00000097          	auipc	ra,0x0
  18:	444080e7          	jalr	1092(ra) # 458 <read>
  1c:	e919                	bnez	a0,32 <prime_seive+0x32>
        close(fd[0]);
  1e:	4088                	lw	a0,0(s1)
  20:	00000097          	auipc	ra,0x0
  24:	448080e7          	jalr	1096(ra) # 468 <close>
        exit(0);
  28:	4501                	li	a0,0
  2a:	00000097          	auipc	ra,0x0
  2e:	416080e7          	jalr	1046(ra) # 440 <exit>
    }
    printf("prime %d\n", prime);
  32:	fdc42583          	lw	a1,-36(s0)
  36:	00001517          	auipc	a0,0x1
  3a:	92a50513          	addi	a0,a0,-1750 # 960 <malloc+0xee>
  3e:	00000097          	auipc	ra,0x0
  42:	77c080e7          	jalr	1916(ra) # 7ba <printf>
    int pright[2];
    if(pipe(pright)<0){
  46:	fd040513          	addi	a0,s0,-48
  4a:	00000097          	auipc	ra,0x0
  4e:	406080e7          	jalr	1030(ra) # 450 <pipe>
  52:	02054863          	bltz	a0,82 <prime_seive+0x82>
        fprintf(2, "pipe error\n");
        exit(1);
    }
    if(fork() == 0){
  56:	00000097          	auipc	ra,0x0
  5a:	3e2080e7          	jalr	994(ra) # 438 <fork>
  5e:	e121                	bnez	a0,9e <prime_seive+0x9e>
        close(fd[0]);
  60:	4088                	lw	a0,0(s1)
  62:	00000097          	auipc	ra,0x0
  66:	406080e7          	jalr	1030(ra) # 468 <close>
        close(pright[1]);        
  6a:	fd442503          	lw	a0,-44(s0)
  6e:	00000097          	auipc	ra,0x0
  72:	3fa080e7          	jalr	1018(ra) # 468 <close>
        prime_seive(pright);
  76:	fd040513          	addi	a0,s0,-48
  7a:	00000097          	auipc	ra,0x0
  7e:	f86080e7          	jalr	-122(ra) # 0 <prime_seive>
        fprintf(2, "pipe error\n");
  82:	00001597          	auipc	a1,0x1
  86:	8ee58593          	addi	a1,a1,-1810 # 970 <malloc+0xfe>
  8a:	4509                	li	a0,2
  8c:	00000097          	auipc	ra,0x0
  90:	700080e7          	jalr	1792(ra) # 78c <fprintf>
        exit(1);
  94:	4505                	li	a0,1
  96:	00000097          	auipc	ra,0x0
  9a:	3aa080e7          	jalr	938(ra) # 440 <exit>
        exit(0);
    }else{
        close(pright[0]);
  9e:	fd042503          	lw	a0,-48(s0)
  a2:	00000097          	auipc	ra,0x0
  a6:	3c6080e7          	jalr	966(ra) # 468 <close>
        int num;
        while(read(fd[0], &num, sizeof(num)) != 0){
  aa:	4611                	li	a2,4
  ac:	fcc40593          	addi	a1,s0,-52
  b0:	4088                	lw	a0,0(s1)
  b2:	00000097          	auipc	ra,0x0
  b6:	3a6080e7          	jalr	934(ra) # 458 <read>
  ba:	c115                	beqz	a0,de <prime_seive+0xde>
            if(num%prime != 0){
  bc:	fcc42783          	lw	a5,-52(s0)
  c0:	fdc42703          	lw	a4,-36(s0)
  c4:	02e7e7bb          	remw	a5,a5,a4
  c8:	d3ed                	beqz	a5,aa <prime_seive+0xaa>
                write(pright[1], &num, sizeof(num));
  ca:	4611                	li	a2,4
  cc:	fcc40593          	addi	a1,s0,-52
  d0:	fd442503          	lw	a0,-44(s0)
  d4:	00000097          	auipc	ra,0x0
  d8:	38c080e7          	jalr	908(ra) # 460 <write>
  dc:	b7f9                	j	aa <prime_seive+0xaa>
            }
        }
        close(fd[0]);
  de:	4088                	lw	a0,0(s1)
  e0:	00000097          	auipc	ra,0x0
  e4:	388080e7          	jalr	904(ra) # 468 <close>
        close(pright[1]);
  e8:	fd442503          	lw	a0,-44(s0)
  ec:	00000097          	auipc	ra,0x0
  f0:	37c080e7          	jalr	892(ra) # 468 <close>
        wait(0);
  f4:	4501                	li	a0,0
  f6:	00000097          	auipc	ra,0x0
  fa:	352080e7          	jalr	850(ra) # 448 <wait>
        exit(0);
  fe:	4501                	li	a0,0
 100:	00000097          	auipc	ra,0x0
 104:	340080e7          	jalr	832(ra) # 440 <exit>

0000000000000108 <main>:
    }
}
int main(){
 108:	7179                	addi	sp,sp,-48
 10a:	f406                	sd	ra,40(sp)
 10c:	f022                	sd	s0,32(sp)
 10e:	ec26                	sd	s1,24(sp)
 110:	1800                	addi	s0,sp,48
    int pp[2];
    if(pipe(pp)<0){
 112:	fd840513          	addi	a0,s0,-40
 116:	00000097          	auipc	ra,0x0
 11a:	33a080e7          	jalr	826(ra) # 450 <pipe>
 11e:	02054363          	bltz	a0,144 <main+0x3c>
        fprintf(2, "pipe error\n");
        exit(1);
    }
    if(fork() ==0 ){
 122:	00000097          	auipc	ra,0x0
 126:	316080e7          	jalr	790(ra) # 438 <fork>
 12a:	e91d                	bnez	a0,160 <main+0x58>
        close(pp[1]);
 12c:	fdc42503          	lw	a0,-36(s0)
 130:	00000097          	auipc	ra,0x0
 134:	338080e7          	jalr	824(ra) # 468 <close>
        prime_seive(pp);
 138:	fd840513          	addi	a0,s0,-40
 13c:	00000097          	auipc	ra,0x0
 140:	ec4080e7          	jalr	-316(ra) # 0 <prime_seive>
        fprintf(2, "pipe error\n");
 144:	00001597          	auipc	a1,0x1
 148:	82c58593          	addi	a1,a1,-2004 # 970 <malloc+0xfe>
 14c:	4509                	li	a0,2
 14e:	00000097          	auipc	ra,0x0
 152:	63e080e7          	jalr	1598(ra) # 78c <fprintf>
        exit(1);
 156:	4505                	li	a0,1
 158:	00000097          	auipc	ra,0x0
 15c:	2e8080e7          	jalr	744(ra) # 440 <exit>
        exit(0);
    }else{
        close(pp[0]);
 160:	fd842503          	lw	a0,-40(s0)
 164:	00000097          	auipc	ra,0x0
 168:	304080e7          	jalr	772(ra) # 468 <close>
        for(int i = 2; i <= 35; i++){
 16c:	4789                	li	a5,2
 16e:	fcf42a23          	sw	a5,-44(s0)
 172:	02300493          	li	s1,35
            write(pp[1], &i, sizeof(i));
 176:	4611                	li	a2,4
 178:	fd440593          	addi	a1,s0,-44
 17c:	fdc42503          	lw	a0,-36(s0)
 180:	00000097          	auipc	ra,0x0
 184:	2e0080e7          	jalr	736(ra) # 460 <write>
        for(int i = 2; i <= 35; i++){
 188:	fd442783          	lw	a5,-44(s0)
 18c:	2785                	addiw	a5,a5,1
 18e:	0007871b          	sext.w	a4,a5
 192:	fcf42a23          	sw	a5,-44(s0)
 196:	fee4d0e3          	bge	s1,a4,176 <main+0x6e>
        }
        close(pp[1]);
 19a:	fdc42503          	lw	a0,-36(s0)
 19e:	00000097          	auipc	ra,0x0
 1a2:	2ca080e7          	jalr	714(ra) # 468 <close>
        wait(0);
 1a6:	4501                	li	a0,0
 1a8:	00000097          	auipc	ra,0x0
 1ac:	2a0080e7          	jalr	672(ra) # 448 <wait>
        exit(0);
 1b0:	4501                	li	a0,0
 1b2:	00000097          	auipc	ra,0x0
 1b6:	28e080e7          	jalr	654(ra) # 440 <exit>

00000000000001ba <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e406                	sd	ra,8(sp)
 1be:	e022                	sd	s0,0(sp)
 1c0:	0800                	addi	s0,sp,16
  extern int main();
  main();
 1c2:	00000097          	auipc	ra,0x0
 1c6:	f46080e7          	jalr	-186(ra) # 108 <main>
  exit(0);
 1ca:	4501                	li	a0,0
 1cc:	00000097          	auipc	ra,0x0
 1d0:	274080e7          	jalr	628(ra) # 440 <exit>

00000000000001d4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1d4:	1141                	addi	sp,sp,-16
 1d6:	e422                	sd	s0,8(sp)
 1d8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1da:	87aa                	mv	a5,a0
 1dc:	0585                	addi	a1,a1,1
 1de:	0785                	addi	a5,a5,1
 1e0:	fff5c703          	lbu	a4,-1(a1)
 1e4:	fee78fa3          	sb	a4,-1(a5)
 1e8:	fb75                	bnez	a4,1dc <strcpy+0x8>
    ;
  return os;
}
 1ea:	6422                	ld	s0,8(sp)
 1ec:	0141                	addi	sp,sp,16
 1ee:	8082                	ret

00000000000001f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1f0:	1141                	addi	sp,sp,-16
 1f2:	e422                	sd	s0,8(sp)
 1f4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1f6:	00054783          	lbu	a5,0(a0)
 1fa:	cb91                	beqz	a5,20e <strcmp+0x1e>
 1fc:	0005c703          	lbu	a4,0(a1)
 200:	00f71763          	bne	a4,a5,20e <strcmp+0x1e>
    p++, q++;
 204:	0505                	addi	a0,a0,1
 206:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 208:	00054783          	lbu	a5,0(a0)
 20c:	fbe5                	bnez	a5,1fc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 20e:	0005c503          	lbu	a0,0(a1)
}
 212:	40a7853b          	subw	a0,a5,a0
 216:	6422                	ld	s0,8(sp)
 218:	0141                	addi	sp,sp,16
 21a:	8082                	ret

000000000000021c <strlen>:

uint
strlen(const char *s)
{
 21c:	1141                	addi	sp,sp,-16
 21e:	e422                	sd	s0,8(sp)
 220:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 222:	00054783          	lbu	a5,0(a0)
 226:	cf91                	beqz	a5,242 <strlen+0x26>
 228:	0505                	addi	a0,a0,1
 22a:	87aa                	mv	a5,a0
 22c:	4685                	li	a3,1
 22e:	9e89                	subw	a3,a3,a0
 230:	00f6853b          	addw	a0,a3,a5
 234:	0785                	addi	a5,a5,1
 236:	fff7c703          	lbu	a4,-1(a5)
 23a:	fb7d                	bnez	a4,230 <strlen+0x14>
    ;
  return n;
}
 23c:	6422                	ld	s0,8(sp)
 23e:	0141                	addi	sp,sp,16
 240:	8082                	ret
  for(n = 0; s[n]; n++)
 242:	4501                	li	a0,0
 244:	bfe5                	j	23c <strlen+0x20>

0000000000000246 <memset>:

void*
memset(void *dst, int c, uint n)
{
 246:	1141                	addi	sp,sp,-16
 248:	e422                	sd	s0,8(sp)
 24a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 24c:	ca19                	beqz	a2,262 <memset+0x1c>
 24e:	87aa                	mv	a5,a0
 250:	1602                	slli	a2,a2,0x20
 252:	9201                	srli	a2,a2,0x20
 254:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 258:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 25c:	0785                	addi	a5,a5,1
 25e:	fee79de3          	bne	a5,a4,258 <memset+0x12>
  }
  return dst;
}
 262:	6422                	ld	s0,8(sp)
 264:	0141                	addi	sp,sp,16
 266:	8082                	ret

0000000000000268 <strchr>:

char*
strchr(const char *s, char c)
{
 268:	1141                	addi	sp,sp,-16
 26a:	e422                	sd	s0,8(sp)
 26c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 26e:	00054783          	lbu	a5,0(a0)
 272:	cb99                	beqz	a5,288 <strchr+0x20>
    if(*s == c)
 274:	00f58763          	beq	a1,a5,282 <strchr+0x1a>
  for(; *s; s++)
 278:	0505                	addi	a0,a0,1
 27a:	00054783          	lbu	a5,0(a0)
 27e:	fbfd                	bnez	a5,274 <strchr+0xc>
      return (char*)s;
  return 0;
 280:	4501                	li	a0,0
}
 282:	6422                	ld	s0,8(sp)
 284:	0141                	addi	sp,sp,16
 286:	8082                	ret
  return 0;
 288:	4501                	li	a0,0
 28a:	bfe5                	j	282 <strchr+0x1a>

000000000000028c <gets>:

char*
gets(char *buf, int max)
{
 28c:	711d                	addi	sp,sp,-96
 28e:	ec86                	sd	ra,88(sp)
 290:	e8a2                	sd	s0,80(sp)
 292:	e4a6                	sd	s1,72(sp)
 294:	e0ca                	sd	s2,64(sp)
 296:	fc4e                	sd	s3,56(sp)
 298:	f852                	sd	s4,48(sp)
 29a:	f456                	sd	s5,40(sp)
 29c:	f05a                	sd	s6,32(sp)
 29e:	ec5e                	sd	s7,24(sp)
 2a0:	1080                	addi	s0,sp,96
 2a2:	8baa                	mv	s7,a0
 2a4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a6:	892a                	mv	s2,a0
 2a8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2aa:	4aa9                	li	s5,10
 2ac:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2ae:	89a6                	mv	s3,s1
 2b0:	2485                	addiw	s1,s1,1
 2b2:	0344d863          	bge	s1,s4,2e2 <gets+0x56>
    cc = read(0, &c, 1);
 2b6:	4605                	li	a2,1
 2b8:	faf40593          	addi	a1,s0,-81
 2bc:	4501                	li	a0,0
 2be:	00000097          	auipc	ra,0x0
 2c2:	19a080e7          	jalr	410(ra) # 458 <read>
    if(cc < 1)
 2c6:	00a05e63          	blez	a0,2e2 <gets+0x56>
    buf[i++] = c;
 2ca:	faf44783          	lbu	a5,-81(s0)
 2ce:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2d2:	01578763          	beq	a5,s5,2e0 <gets+0x54>
 2d6:	0905                	addi	s2,s2,1
 2d8:	fd679be3          	bne	a5,s6,2ae <gets+0x22>
  for(i=0; i+1 < max; ){
 2dc:	89a6                	mv	s3,s1
 2de:	a011                	j	2e2 <gets+0x56>
 2e0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2e2:	99de                	add	s3,s3,s7
 2e4:	00098023          	sb	zero,0(s3)
  return buf;
}
 2e8:	855e                	mv	a0,s7
 2ea:	60e6                	ld	ra,88(sp)
 2ec:	6446                	ld	s0,80(sp)
 2ee:	64a6                	ld	s1,72(sp)
 2f0:	6906                	ld	s2,64(sp)
 2f2:	79e2                	ld	s3,56(sp)
 2f4:	7a42                	ld	s4,48(sp)
 2f6:	7aa2                	ld	s5,40(sp)
 2f8:	7b02                	ld	s6,32(sp)
 2fa:	6be2                	ld	s7,24(sp)
 2fc:	6125                	addi	sp,sp,96
 2fe:	8082                	ret

0000000000000300 <stat>:

int
stat(const char *n, struct stat *st)
{
 300:	1101                	addi	sp,sp,-32
 302:	ec06                	sd	ra,24(sp)
 304:	e822                	sd	s0,16(sp)
 306:	e426                	sd	s1,8(sp)
 308:	e04a                	sd	s2,0(sp)
 30a:	1000                	addi	s0,sp,32
 30c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 30e:	4581                	li	a1,0
 310:	00000097          	auipc	ra,0x0
 314:	170080e7          	jalr	368(ra) # 480 <open>
  if(fd < 0)
 318:	02054563          	bltz	a0,342 <stat+0x42>
 31c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 31e:	85ca                	mv	a1,s2
 320:	00000097          	auipc	ra,0x0
 324:	178080e7          	jalr	376(ra) # 498 <fstat>
 328:	892a                	mv	s2,a0
  close(fd);
 32a:	8526                	mv	a0,s1
 32c:	00000097          	auipc	ra,0x0
 330:	13c080e7          	jalr	316(ra) # 468 <close>
  return r;
}
 334:	854a                	mv	a0,s2
 336:	60e2                	ld	ra,24(sp)
 338:	6442                	ld	s0,16(sp)
 33a:	64a2                	ld	s1,8(sp)
 33c:	6902                	ld	s2,0(sp)
 33e:	6105                	addi	sp,sp,32
 340:	8082                	ret
    return -1;
 342:	597d                	li	s2,-1
 344:	bfc5                	j	334 <stat+0x34>

0000000000000346 <atoi>:

int
atoi(const char *s)
{
 346:	1141                	addi	sp,sp,-16
 348:	e422                	sd	s0,8(sp)
 34a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 34c:	00054683          	lbu	a3,0(a0)
 350:	fd06879b          	addiw	a5,a3,-48
 354:	0ff7f793          	zext.b	a5,a5
 358:	4625                	li	a2,9
 35a:	02f66863          	bltu	a2,a5,38a <atoi+0x44>
 35e:	872a                	mv	a4,a0
  n = 0;
 360:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 362:	0705                	addi	a4,a4,1
 364:	0025179b          	slliw	a5,a0,0x2
 368:	9fa9                	addw	a5,a5,a0
 36a:	0017979b          	slliw	a5,a5,0x1
 36e:	9fb5                	addw	a5,a5,a3
 370:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 374:	00074683          	lbu	a3,0(a4)
 378:	fd06879b          	addiw	a5,a3,-48
 37c:	0ff7f793          	zext.b	a5,a5
 380:	fef671e3          	bgeu	a2,a5,362 <atoi+0x1c>
  return n;
}
 384:	6422                	ld	s0,8(sp)
 386:	0141                	addi	sp,sp,16
 388:	8082                	ret
  n = 0;
 38a:	4501                	li	a0,0
 38c:	bfe5                	j	384 <atoi+0x3e>

000000000000038e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 38e:	1141                	addi	sp,sp,-16
 390:	e422                	sd	s0,8(sp)
 392:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 394:	02b57463          	bgeu	a0,a1,3bc <memmove+0x2e>
    while(n-- > 0)
 398:	00c05f63          	blez	a2,3b6 <memmove+0x28>
 39c:	1602                	slli	a2,a2,0x20
 39e:	9201                	srli	a2,a2,0x20
 3a0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3a4:	872a                	mv	a4,a0
      *dst++ = *src++;
 3a6:	0585                	addi	a1,a1,1
 3a8:	0705                	addi	a4,a4,1
 3aa:	fff5c683          	lbu	a3,-1(a1)
 3ae:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3b2:	fee79ae3          	bne	a5,a4,3a6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3b6:	6422                	ld	s0,8(sp)
 3b8:	0141                	addi	sp,sp,16
 3ba:	8082                	ret
    dst += n;
 3bc:	00c50733          	add	a4,a0,a2
    src += n;
 3c0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3c2:	fec05ae3          	blez	a2,3b6 <memmove+0x28>
 3c6:	fff6079b          	addiw	a5,a2,-1
 3ca:	1782                	slli	a5,a5,0x20
 3cc:	9381                	srli	a5,a5,0x20
 3ce:	fff7c793          	not	a5,a5
 3d2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3d4:	15fd                	addi	a1,a1,-1
 3d6:	177d                	addi	a4,a4,-1
 3d8:	0005c683          	lbu	a3,0(a1)
 3dc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3e0:	fee79ae3          	bne	a5,a4,3d4 <memmove+0x46>
 3e4:	bfc9                	j	3b6 <memmove+0x28>

00000000000003e6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3e6:	1141                	addi	sp,sp,-16
 3e8:	e422                	sd	s0,8(sp)
 3ea:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3ec:	ca05                	beqz	a2,41c <memcmp+0x36>
 3ee:	fff6069b          	addiw	a3,a2,-1
 3f2:	1682                	slli	a3,a3,0x20
 3f4:	9281                	srli	a3,a3,0x20
 3f6:	0685                	addi	a3,a3,1
 3f8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3fa:	00054783          	lbu	a5,0(a0)
 3fe:	0005c703          	lbu	a4,0(a1)
 402:	00e79863          	bne	a5,a4,412 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 406:	0505                	addi	a0,a0,1
    p2++;
 408:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 40a:	fed518e3          	bne	a0,a3,3fa <memcmp+0x14>
  }
  return 0;
 40e:	4501                	li	a0,0
 410:	a019                	j	416 <memcmp+0x30>
      return *p1 - *p2;
 412:	40e7853b          	subw	a0,a5,a4
}
 416:	6422                	ld	s0,8(sp)
 418:	0141                	addi	sp,sp,16
 41a:	8082                	ret
  return 0;
 41c:	4501                	li	a0,0
 41e:	bfe5                	j	416 <memcmp+0x30>

0000000000000420 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 420:	1141                	addi	sp,sp,-16
 422:	e406                	sd	ra,8(sp)
 424:	e022                	sd	s0,0(sp)
 426:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 428:	00000097          	auipc	ra,0x0
 42c:	f66080e7          	jalr	-154(ra) # 38e <memmove>
}
 430:	60a2                	ld	ra,8(sp)
 432:	6402                	ld	s0,0(sp)
 434:	0141                	addi	sp,sp,16
 436:	8082                	ret

0000000000000438 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 438:	4885                	li	a7,1
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <exit>:
.global exit
exit:
 li a7, SYS_exit
 440:	4889                	li	a7,2
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <wait>:
.global wait
wait:
 li a7, SYS_wait
 448:	488d                	li	a7,3
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 450:	4891                	li	a7,4
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <read>:
.global read
read:
 li a7, SYS_read
 458:	4895                	li	a7,5
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <write>:
.global write
write:
 li a7, SYS_write
 460:	48c1                	li	a7,16
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <close>:
.global close
close:
 li a7, SYS_close
 468:	48d5                	li	a7,21
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <kill>:
.global kill
kill:
 li a7, SYS_kill
 470:	4899                	li	a7,6
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <exec>:
.global exec
exec:
 li a7, SYS_exec
 478:	489d                	li	a7,7
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <open>:
.global open
open:
 li a7, SYS_open
 480:	48bd                	li	a7,15
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 488:	48c5                	li	a7,17
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 490:	48c9                	li	a7,18
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 498:	48a1                	li	a7,8
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <link>:
.global link
link:
 li a7, SYS_link
 4a0:	48cd                	li	a7,19
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4a8:	48d1                	li	a7,20
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4b0:	48a5                	li	a7,9
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4b8:	48a9                	li	a7,10
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4c0:	48ad                	li	a7,11
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4c8:	48b1                	li	a7,12
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4d0:	48b5                	li	a7,13
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4d8:	48b9                	li	a7,14
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4e0:	1101                	addi	sp,sp,-32
 4e2:	ec06                	sd	ra,24(sp)
 4e4:	e822                	sd	s0,16(sp)
 4e6:	1000                	addi	s0,sp,32
 4e8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4ec:	4605                	li	a2,1
 4ee:	fef40593          	addi	a1,s0,-17
 4f2:	00000097          	auipc	ra,0x0
 4f6:	f6e080e7          	jalr	-146(ra) # 460 <write>
}
 4fa:	60e2                	ld	ra,24(sp)
 4fc:	6442                	ld	s0,16(sp)
 4fe:	6105                	addi	sp,sp,32
 500:	8082                	ret

0000000000000502 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 502:	7139                	addi	sp,sp,-64
 504:	fc06                	sd	ra,56(sp)
 506:	f822                	sd	s0,48(sp)
 508:	f426                	sd	s1,40(sp)
 50a:	f04a                	sd	s2,32(sp)
 50c:	ec4e                	sd	s3,24(sp)
 50e:	0080                	addi	s0,sp,64
 510:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 512:	c299                	beqz	a3,518 <printint+0x16>
 514:	0805c963          	bltz	a1,5a6 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 518:	2581                	sext.w	a1,a1
  neg = 0;
 51a:	4881                	li	a7,0
 51c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 520:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 522:	2601                	sext.w	a2,a2
 524:	00000517          	auipc	a0,0x0
 528:	4bc50513          	addi	a0,a0,1212 # 9e0 <digits>
 52c:	883a                	mv	a6,a4
 52e:	2705                	addiw	a4,a4,1
 530:	02c5f7bb          	remuw	a5,a1,a2
 534:	1782                	slli	a5,a5,0x20
 536:	9381                	srli	a5,a5,0x20
 538:	97aa                	add	a5,a5,a0
 53a:	0007c783          	lbu	a5,0(a5)
 53e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 542:	0005879b          	sext.w	a5,a1
 546:	02c5d5bb          	divuw	a1,a1,a2
 54a:	0685                	addi	a3,a3,1
 54c:	fec7f0e3          	bgeu	a5,a2,52c <printint+0x2a>
  if(neg)
 550:	00088c63          	beqz	a7,568 <printint+0x66>
    buf[i++] = '-';
 554:	fd070793          	addi	a5,a4,-48
 558:	00878733          	add	a4,a5,s0
 55c:	02d00793          	li	a5,45
 560:	fef70823          	sb	a5,-16(a4)
 564:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 568:	02e05863          	blez	a4,598 <printint+0x96>
 56c:	fc040793          	addi	a5,s0,-64
 570:	00e78933          	add	s2,a5,a4
 574:	fff78993          	addi	s3,a5,-1
 578:	99ba                	add	s3,s3,a4
 57a:	377d                	addiw	a4,a4,-1
 57c:	1702                	slli	a4,a4,0x20
 57e:	9301                	srli	a4,a4,0x20
 580:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 584:	fff94583          	lbu	a1,-1(s2)
 588:	8526                	mv	a0,s1
 58a:	00000097          	auipc	ra,0x0
 58e:	f56080e7          	jalr	-170(ra) # 4e0 <putc>
  while(--i >= 0)
 592:	197d                	addi	s2,s2,-1
 594:	ff3918e3          	bne	s2,s3,584 <printint+0x82>
}
 598:	70e2                	ld	ra,56(sp)
 59a:	7442                	ld	s0,48(sp)
 59c:	74a2                	ld	s1,40(sp)
 59e:	7902                	ld	s2,32(sp)
 5a0:	69e2                	ld	s3,24(sp)
 5a2:	6121                	addi	sp,sp,64
 5a4:	8082                	ret
    x = -xx;
 5a6:	40b005bb          	negw	a1,a1
    neg = 1;
 5aa:	4885                	li	a7,1
    x = -xx;
 5ac:	bf85                	j	51c <printint+0x1a>

00000000000005ae <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5ae:	7119                	addi	sp,sp,-128
 5b0:	fc86                	sd	ra,120(sp)
 5b2:	f8a2                	sd	s0,112(sp)
 5b4:	f4a6                	sd	s1,104(sp)
 5b6:	f0ca                	sd	s2,96(sp)
 5b8:	ecce                	sd	s3,88(sp)
 5ba:	e8d2                	sd	s4,80(sp)
 5bc:	e4d6                	sd	s5,72(sp)
 5be:	e0da                	sd	s6,64(sp)
 5c0:	fc5e                	sd	s7,56(sp)
 5c2:	f862                	sd	s8,48(sp)
 5c4:	f466                	sd	s9,40(sp)
 5c6:	f06a                	sd	s10,32(sp)
 5c8:	ec6e                	sd	s11,24(sp)
 5ca:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5cc:	0005c903          	lbu	s2,0(a1)
 5d0:	18090f63          	beqz	s2,76e <vprintf+0x1c0>
 5d4:	8aaa                	mv	s5,a0
 5d6:	8b32                	mv	s6,a2
 5d8:	00158493          	addi	s1,a1,1
  state = 0;
 5dc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5de:	02500a13          	li	s4,37
 5e2:	4c55                	li	s8,21
 5e4:	00000c97          	auipc	s9,0x0
 5e8:	3a4c8c93          	addi	s9,s9,932 # 988 <malloc+0x116>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5ec:	02800d93          	li	s11,40
  putc(fd, 'x');
 5f0:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5f2:	00000b97          	auipc	s7,0x0
 5f6:	3eeb8b93          	addi	s7,s7,1006 # 9e0 <digits>
 5fa:	a839                	j	618 <vprintf+0x6a>
        putc(fd, c);
 5fc:	85ca                	mv	a1,s2
 5fe:	8556                	mv	a0,s5
 600:	00000097          	auipc	ra,0x0
 604:	ee0080e7          	jalr	-288(ra) # 4e0 <putc>
 608:	a019                	j	60e <vprintf+0x60>
    } else if(state == '%'){
 60a:	01498d63          	beq	s3,s4,624 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 60e:	0485                	addi	s1,s1,1
 610:	fff4c903          	lbu	s2,-1(s1)
 614:	14090d63          	beqz	s2,76e <vprintf+0x1c0>
    if(state == 0){
 618:	fe0999e3          	bnez	s3,60a <vprintf+0x5c>
      if(c == '%'){
 61c:	ff4910e3          	bne	s2,s4,5fc <vprintf+0x4e>
        state = '%';
 620:	89d2                	mv	s3,s4
 622:	b7f5                	j	60e <vprintf+0x60>
      if(c == 'd'){
 624:	11490c63          	beq	s2,s4,73c <vprintf+0x18e>
 628:	f9d9079b          	addiw	a5,s2,-99
 62c:	0ff7f793          	zext.b	a5,a5
 630:	10fc6e63          	bltu	s8,a5,74c <vprintf+0x19e>
 634:	f9d9079b          	addiw	a5,s2,-99
 638:	0ff7f713          	zext.b	a4,a5
 63c:	10ec6863          	bltu	s8,a4,74c <vprintf+0x19e>
 640:	00271793          	slli	a5,a4,0x2
 644:	97e6                	add	a5,a5,s9
 646:	439c                	lw	a5,0(a5)
 648:	97e6                	add	a5,a5,s9
 64a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 64c:	008b0913          	addi	s2,s6,8
 650:	4685                	li	a3,1
 652:	4629                	li	a2,10
 654:	000b2583          	lw	a1,0(s6)
 658:	8556                	mv	a0,s5
 65a:	00000097          	auipc	ra,0x0
 65e:	ea8080e7          	jalr	-344(ra) # 502 <printint>
 662:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 664:	4981                	li	s3,0
 666:	b765                	j	60e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 668:	008b0913          	addi	s2,s6,8
 66c:	4681                	li	a3,0
 66e:	4629                	li	a2,10
 670:	000b2583          	lw	a1,0(s6)
 674:	8556                	mv	a0,s5
 676:	00000097          	auipc	ra,0x0
 67a:	e8c080e7          	jalr	-372(ra) # 502 <printint>
 67e:	8b4a                	mv	s6,s2
      state = 0;
 680:	4981                	li	s3,0
 682:	b771                	j	60e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 684:	008b0913          	addi	s2,s6,8
 688:	4681                	li	a3,0
 68a:	866a                	mv	a2,s10
 68c:	000b2583          	lw	a1,0(s6)
 690:	8556                	mv	a0,s5
 692:	00000097          	auipc	ra,0x0
 696:	e70080e7          	jalr	-400(ra) # 502 <printint>
 69a:	8b4a                	mv	s6,s2
      state = 0;
 69c:	4981                	li	s3,0
 69e:	bf85                	j	60e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6a0:	008b0793          	addi	a5,s6,8
 6a4:	f8f43423          	sd	a5,-120(s0)
 6a8:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6ac:	03000593          	li	a1,48
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	e2e080e7          	jalr	-466(ra) # 4e0 <putc>
  putc(fd, 'x');
 6ba:	07800593          	li	a1,120
 6be:	8556                	mv	a0,s5
 6c0:	00000097          	auipc	ra,0x0
 6c4:	e20080e7          	jalr	-480(ra) # 4e0 <putc>
 6c8:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6ca:	03c9d793          	srli	a5,s3,0x3c
 6ce:	97de                	add	a5,a5,s7
 6d0:	0007c583          	lbu	a1,0(a5)
 6d4:	8556                	mv	a0,s5
 6d6:	00000097          	auipc	ra,0x0
 6da:	e0a080e7          	jalr	-502(ra) # 4e0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6de:	0992                	slli	s3,s3,0x4
 6e0:	397d                	addiw	s2,s2,-1
 6e2:	fe0914e3          	bnez	s2,6ca <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 6e6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	b70d                	j	60e <vprintf+0x60>
        s = va_arg(ap, char*);
 6ee:	008b0913          	addi	s2,s6,8
 6f2:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 6f6:	02098163          	beqz	s3,718 <vprintf+0x16a>
        while(*s != 0){
 6fa:	0009c583          	lbu	a1,0(s3)
 6fe:	c5ad                	beqz	a1,768 <vprintf+0x1ba>
          putc(fd, *s);
 700:	8556                	mv	a0,s5
 702:	00000097          	auipc	ra,0x0
 706:	dde080e7          	jalr	-546(ra) # 4e0 <putc>
          s++;
 70a:	0985                	addi	s3,s3,1
        while(*s != 0){
 70c:	0009c583          	lbu	a1,0(s3)
 710:	f9e5                	bnez	a1,700 <vprintf+0x152>
        s = va_arg(ap, char*);
 712:	8b4a                	mv	s6,s2
      state = 0;
 714:	4981                	li	s3,0
 716:	bde5                	j	60e <vprintf+0x60>
          s = "(null)";
 718:	00000997          	auipc	s3,0x0
 71c:	26898993          	addi	s3,s3,616 # 980 <malloc+0x10e>
        while(*s != 0){
 720:	85ee                	mv	a1,s11
 722:	bff9                	j	700 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 724:	008b0913          	addi	s2,s6,8
 728:	000b4583          	lbu	a1,0(s6)
 72c:	8556                	mv	a0,s5
 72e:	00000097          	auipc	ra,0x0
 732:	db2080e7          	jalr	-590(ra) # 4e0 <putc>
 736:	8b4a                	mv	s6,s2
      state = 0;
 738:	4981                	li	s3,0
 73a:	bdd1                	j	60e <vprintf+0x60>
        putc(fd, c);
 73c:	85d2                	mv	a1,s4
 73e:	8556                	mv	a0,s5
 740:	00000097          	auipc	ra,0x0
 744:	da0080e7          	jalr	-608(ra) # 4e0 <putc>
      state = 0;
 748:	4981                	li	s3,0
 74a:	b5d1                	j	60e <vprintf+0x60>
        putc(fd, '%');
 74c:	85d2                	mv	a1,s4
 74e:	8556                	mv	a0,s5
 750:	00000097          	auipc	ra,0x0
 754:	d90080e7          	jalr	-624(ra) # 4e0 <putc>
        putc(fd, c);
 758:	85ca                	mv	a1,s2
 75a:	8556                	mv	a0,s5
 75c:	00000097          	auipc	ra,0x0
 760:	d84080e7          	jalr	-636(ra) # 4e0 <putc>
      state = 0;
 764:	4981                	li	s3,0
 766:	b565                	j	60e <vprintf+0x60>
        s = va_arg(ap, char*);
 768:	8b4a                	mv	s6,s2
      state = 0;
 76a:	4981                	li	s3,0
 76c:	b54d                	j	60e <vprintf+0x60>
    }
  }
}
 76e:	70e6                	ld	ra,120(sp)
 770:	7446                	ld	s0,112(sp)
 772:	74a6                	ld	s1,104(sp)
 774:	7906                	ld	s2,96(sp)
 776:	69e6                	ld	s3,88(sp)
 778:	6a46                	ld	s4,80(sp)
 77a:	6aa6                	ld	s5,72(sp)
 77c:	6b06                	ld	s6,64(sp)
 77e:	7be2                	ld	s7,56(sp)
 780:	7c42                	ld	s8,48(sp)
 782:	7ca2                	ld	s9,40(sp)
 784:	7d02                	ld	s10,32(sp)
 786:	6de2                	ld	s11,24(sp)
 788:	6109                	addi	sp,sp,128
 78a:	8082                	ret

000000000000078c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 78c:	715d                	addi	sp,sp,-80
 78e:	ec06                	sd	ra,24(sp)
 790:	e822                	sd	s0,16(sp)
 792:	1000                	addi	s0,sp,32
 794:	e010                	sd	a2,0(s0)
 796:	e414                	sd	a3,8(s0)
 798:	e818                	sd	a4,16(s0)
 79a:	ec1c                	sd	a5,24(s0)
 79c:	03043023          	sd	a6,32(s0)
 7a0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7a4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7a8:	8622                	mv	a2,s0
 7aa:	00000097          	auipc	ra,0x0
 7ae:	e04080e7          	jalr	-508(ra) # 5ae <vprintf>
}
 7b2:	60e2                	ld	ra,24(sp)
 7b4:	6442                	ld	s0,16(sp)
 7b6:	6161                	addi	sp,sp,80
 7b8:	8082                	ret

00000000000007ba <printf>:

void
printf(const char *fmt, ...)
{
 7ba:	711d                	addi	sp,sp,-96
 7bc:	ec06                	sd	ra,24(sp)
 7be:	e822                	sd	s0,16(sp)
 7c0:	1000                	addi	s0,sp,32
 7c2:	e40c                	sd	a1,8(s0)
 7c4:	e810                	sd	a2,16(s0)
 7c6:	ec14                	sd	a3,24(s0)
 7c8:	f018                	sd	a4,32(s0)
 7ca:	f41c                	sd	a5,40(s0)
 7cc:	03043823          	sd	a6,48(s0)
 7d0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7d4:	00840613          	addi	a2,s0,8
 7d8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7dc:	85aa                	mv	a1,a0
 7de:	4505                	li	a0,1
 7e0:	00000097          	auipc	ra,0x0
 7e4:	dce080e7          	jalr	-562(ra) # 5ae <vprintf>
}
 7e8:	60e2                	ld	ra,24(sp)
 7ea:	6442                	ld	s0,16(sp)
 7ec:	6125                	addi	sp,sp,96
 7ee:	8082                	ret

00000000000007f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7f0:	1141                	addi	sp,sp,-16
 7f2:	e422                	sd	s0,8(sp)
 7f4:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7f6:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7fa:	00001797          	auipc	a5,0x1
 7fe:	8067b783          	ld	a5,-2042(a5) # 1000 <freep>
 802:	a02d                	j	82c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 804:	4618                	lw	a4,8(a2)
 806:	9f2d                	addw	a4,a4,a1
 808:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 80c:	6398                	ld	a4,0(a5)
 80e:	6310                	ld	a2,0(a4)
 810:	a83d                	j	84e <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 812:	ff852703          	lw	a4,-8(a0)
 816:	9f31                	addw	a4,a4,a2
 818:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 81a:	ff053683          	ld	a3,-16(a0)
 81e:	a091                	j	862 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 820:	6398                	ld	a4,0(a5)
 822:	00e7e463          	bltu	a5,a4,82a <free+0x3a>
 826:	00e6ea63          	bltu	a3,a4,83a <free+0x4a>
{
 82a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 82c:	fed7fae3          	bgeu	a5,a3,820 <free+0x30>
 830:	6398                	ld	a4,0(a5)
 832:	00e6e463          	bltu	a3,a4,83a <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 836:	fee7eae3          	bltu	a5,a4,82a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 83a:	ff852583          	lw	a1,-8(a0)
 83e:	6390                	ld	a2,0(a5)
 840:	02059813          	slli	a6,a1,0x20
 844:	01c85713          	srli	a4,a6,0x1c
 848:	9736                	add	a4,a4,a3
 84a:	fae60de3          	beq	a2,a4,804 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 84e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 852:	4790                	lw	a2,8(a5)
 854:	02061593          	slli	a1,a2,0x20
 858:	01c5d713          	srli	a4,a1,0x1c
 85c:	973e                	add	a4,a4,a5
 85e:	fae68ae3          	beq	a3,a4,812 <free+0x22>
    p->s.ptr = bp->s.ptr;
 862:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 864:	00000717          	auipc	a4,0x0
 868:	78f73e23          	sd	a5,1948(a4) # 1000 <freep>
}
 86c:	6422                	ld	s0,8(sp)
 86e:	0141                	addi	sp,sp,16
 870:	8082                	ret

0000000000000872 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 872:	7139                	addi	sp,sp,-64
 874:	fc06                	sd	ra,56(sp)
 876:	f822                	sd	s0,48(sp)
 878:	f426                	sd	s1,40(sp)
 87a:	f04a                	sd	s2,32(sp)
 87c:	ec4e                	sd	s3,24(sp)
 87e:	e852                	sd	s4,16(sp)
 880:	e456                	sd	s5,8(sp)
 882:	e05a                	sd	s6,0(sp)
 884:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 886:	02051493          	slli	s1,a0,0x20
 88a:	9081                	srli	s1,s1,0x20
 88c:	04bd                	addi	s1,s1,15
 88e:	8091                	srli	s1,s1,0x4
 890:	0014899b          	addiw	s3,s1,1
 894:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 896:	00000517          	auipc	a0,0x0
 89a:	76a53503          	ld	a0,1898(a0) # 1000 <freep>
 89e:	c515                	beqz	a0,8ca <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8a2:	4798                	lw	a4,8(a5)
 8a4:	02977f63          	bgeu	a4,s1,8e2 <malloc+0x70>
 8a8:	8a4e                	mv	s4,s3
 8aa:	0009871b          	sext.w	a4,s3
 8ae:	6685                	lui	a3,0x1
 8b0:	00d77363          	bgeu	a4,a3,8b6 <malloc+0x44>
 8b4:	6a05                	lui	s4,0x1
 8b6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8ba:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8be:	00000917          	auipc	s2,0x0
 8c2:	74290913          	addi	s2,s2,1858 # 1000 <freep>
  if(p == (char*)-1)
 8c6:	5afd                	li	s5,-1
 8c8:	a895                	j	93c <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 8ca:	00000797          	auipc	a5,0x0
 8ce:	74678793          	addi	a5,a5,1862 # 1010 <base>
 8d2:	00000717          	auipc	a4,0x0
 8d6:	72f73723          	sd	a5,1838(a4) # 1000 <freep>
 8da:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8dc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8e0:	b7e1                	j	8a8 <malloc+0x36>
      if(p->s.size == nunits)
 8e2:	02e48c63          	beq	s1,a4,91a <malloc+0xa8>
        p->s.size -= nunits;
 8e6:	4137073b          	subw	a4,a4,s3
 8ea:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8ec:	02071693          	slli	a3,a4,0x20
 8f0:	01c6d713          	srli	a4,a3,0x1c
 8f4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8f6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8fa:	00000717          	auipc	a4,0x0
 8fe:	70a73323          	sd	a0,1798(a4) # 1000 <freep>
      return (void*)(p + 1);
 902:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 906:	70e2                	ld	ra,56(sp)
 908:	7442                	ld	s0,48(sp)
 90a:	74a2                	ld	s1,40(sp)
 90c:	7902                	ld	s2,32(sp)
 90e:	69e2                	ld	s3,24(sp)
 910:	6a42                	ld	s4,16(sp)
 912:	6aa2                	ld	s5,8(sp)
 914:	6b02                	ld	s6,0(sp)
 916:	6121                	addi	sp,sp,64
 918:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 91a:	6398                	ld	a4,0(a5)
 91c:	e118                	sd	a4,0(a0)
 91e:	bff1                	j	8fa <malloc+0x88>
  hp->s.size = nu;
 920:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 924:	0541                	addi	a0,a0,16
 926:	00000097          	auipc	ra,0x0
 92a:	eca080e7          	jalr	-310(ra) # 7f0 <free>
  return freep;
 92e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 932:	d971                	beqz	a0,906 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 934:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 936:	4798                	lw	a4,8(a5)
 938:	fa9775e3          	bgeu	a4,s1,8e2 <malloc+0x70>
    if(p == freep)
 93c:	00093703          	ld	a4,0(s2)
 940:	853e                	mv	a0,a5
 942:	fef719e3          	bne	a4,a5,934 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 946:	8552                	mv	a0,s4
 948:	00000097          	auipc	ra,0x0
 94c:	b80080e7          	jalr	-1152(ra) # 4c8 <sbrk>
  if(p == (char*)-1)
 950:	fd5518e3          	bne	a0,s5,920 <malloc+0xae>
        return 0;
 954:	4501                	li	a0,0
 956:	bf45                	j	906 <malloc+0x94>

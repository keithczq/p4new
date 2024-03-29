
_userRR:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "x86.h"
#include "pstat.h"
#include "user.h"

int main( int argc, const char* argv[] )
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
    exit();
  11:	e8 8d 01 00 00       	call   1a3 <exit>

00000016 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  16:	55                   	push   %ebp
  17:	89 e5                	mov    %esp,%ebp
  19:	53                   	push   %ebx
  1a:	8b 45 08             	mov    0x8(%ebp),%eax
  1d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  20:	89 c2                	mov    %eax,%edx
  22:	0f b6 19             	movzbl (%ecx),%ebx
  25:	88 1a                	mov    %bl,(%edx)
  27:	8d 52 01             	lea    0x1(%edx),%edx
  2a:	8d 49 01             	lea    0x1(%ecx),%ecx
  2d:	84 db                	test   %bl,%bl
  2f:	75 f1                	jne    22 <strcpy+0xc>
    ;
  return os;
}
  31:	5b                   	pop    %ebx
  32:	5d                   	pop    %ebp
  33:	c3                   	ret    

00000034 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  34:	55                   	push   %ebp
  35:	89 e5                	mov    %esp,%ebp
  37:	8b 4d 08             	mov    0x8(%ebp),%ecx
  3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  3d:	eb 06                	jmp    45 <strcmp+0x11>
    p++, q++;
  3f:	83 c1 01             	add    $0x1,%ecx
  42:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  45:	0f b6 01             	movzbl (%ecx),%eax
  48:	84 c0                	test   %al,%al
  4a:	74 04                	je     50 <strcmp+0x1c>
  4c:	3a 02                	cmp    (%edx),%al
  4e:	74 ef                	je     3f <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
  50:	0f b6 c0             	movzbl %al,%eax
  53:	0f b6 12             	movzbl (%edx),%edx
  56:	29 d0                	sub    %edx,%eax
}
  58:	5d                   	pop    %ebp
  59:	c3                   	ret    

0000005a <strlen>:

uint
strlen(const char *s)
{
  5a:	55                   	push   %ebp
  5b:	89 e5                	mov    %esp,%ebp
  5d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  60:	ba 00 00 00 00       	mov    $0x0,%edx
  65:	eb 03                	jmp    6a <strlen+0x10>
  67:	83 c2 01             	add    $0x1,%edx
  6a:	89 d0                	mov    %edx,%eax
  6c:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  70:	75 f5                	jne    67 <strlen+0xd>
    ;
  return n;
}
  72:	5d                   	pop    %ebp
  73:	c3                   	ret    

00000074 <memset>:

void*
memset(void *dst, int c, uint n)
{
  74:	55                   	push   %ebp
  75:	89 e5                	mov    %esp,%ebp
  77:	57                   	push   %edi
  78:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  7b:	89 d7                	mov    %edx,%edi
  7d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80:	8b 45 0c             	mov    0xc(%ebp),%eax
  83:	fc                   	cld    
  84:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  86:	89 d0                	mov    %edx,%eax
  88:	5f                   	pop    %edi
  89:	5d                   	pop    %ebp
  8a:	c3                   	ret    

0000008b <strchr>:

char*
strchr(const char *s, char c)
{
  8b:	55                   	push   %ebp
  8c:	89 e5                	mov    %esp,%ebp
  8e:	8b 45 08             	mov    0x8(%ebp),%eax
  91:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  95:	0f b6 10             	movzbl (%eax),%edx
  98:	84 d2                	test   %dl,%dl
  9a:	74 09                	je     a5 <strchr+0x1a>
    if(*s == c)
  9c:	38 ca                	cmp    %cl,%dl
  9e:	74 0a                	je     aa <strchr+0x1f>
  for(; *s; s++)
  a0:	83 c0 01             	add    $0x1,%eax
  a3:	eb f0                	jmp    95 <strchr+0xa>
      return (char*)s;
  return 0;
  a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  aa:	5d                   	pop    %ebp
  ab:	c3                   	ret    

000000ac <gets>:

char*
gets(char *buf, int max)
{
  ac:	55                   	push   %ebp
  ad:	89 e5                	mov    %esp,%ebp
  af:	57                   	push   %edi
  b0:	56                   	push   %esi
  b1:	53                   	push   %ebx
  b2:	83 ec 1c             	sub    $0x1c,%esp
  b5:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  b8:	bb 00 00 00 00       	mov    $0x0,%ebx
  bd:	8d 73 01             	lea    0x1(%ebx),%esi
  c0:	3b 75 0c             	cmp    0xc(%ebp),%esi
  c3:	7d 2e                	jge    f3 <gets+0x47>
    cc = read(0, &c, 1);
  c5:	83 ec 04             	sub    $0x4,%esp
  c8:	6a 01                	push   $0x1
  ca:	8d 45 e7             	lea    -0x19(%ebp),%eax
  cd:	50                   	push   %eax
  ce:	6a 00                	push   $0x0
  d0:	e8 e6 00 00 00       	call   1bb <read>
    if(cc < 1)
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	85 c0                	test   %eax,%eax
  da:	7e 17                	jle    f3 <gets+0x47>
      break;
    buf[i++] = c;
  dc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  e0:	88 04 1f             	mov    %al,(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
  e3:	3c 0a                	cmp    $0xa,%al
  e5:	0f 94 c2             	sete   %dl
  e8:	3c 0d                	cmp    $0xd,%al
  ea:	0f 94 c0             	sete   %al
    buf[i++] = c;
  ed:	89 f3                	mov    %esi,%ebx
    if(c == '\n' || c == '\r')
  ef:	08 c2                	or     %al,%dl
  f1:	74 ca                	je     bd <gets+0x11>
      break;
  }
  buf[i] = '\0';
  f3:	c6 04 1f 00          	movb   $0x0,(%edi,%ebx,1)
  return buf;
}
  f7:	89 f8                	mov    %edi,%eax
  f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
  fc:	5b                   	pop    %ebx
  fd:	5e                   	pop    %esi
  fe:	5f                   	pop    %edi
  ff:	5d                   	pop    %ebp
 100:	c3                   	ret    

00000101 <stat>:

int
stat(const char *n, struct stat *st)
{
 101:	55                   	push   %ebp
 102:	89 e5                	mov    %esp,%ebp
 104:	56                   	push   %esi
 105:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 106:	83 ec 08             	sub    $0x8,%esp
 109:	6a 00                	push   $0x0
 10b:	ff 75 08             	pushl  0x8(%ebp)
 10e:	e8 d0 00 00 00       	call   1e3 <open>
  if(fd < 0)
 113:	83 c4 10             	add    $0x10,%esp
 116:	85 c0                	test   %eax,%eax
 118:	78 24                	js     13e <stat+0x3d>
 11a:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 11c:	83 ec 08             	sub    $0x8,%esp
 11f:	ff 75 0c             	pushl  0xc(%ebp)
 122:	50                   	push   %eax
 123:	e8 d3 00 00 00       	call   1fb <fstat>
 128:	89 c6                	mov    %eax,%esi
  close(fd);
 12a:	89 1c 24             	mov    %ebx,(%esp)
 12d:	e8 99 00 00 00       	call   1cb <close>
  return r;
 132:	83 c4 10             	add    $0x10,%esp
}
 135:	89 f0                	mov    %esi,%eax
 137:	8d 65 f8             	lea    -0x8(%ebp),%esp
 13a:	5b                   	pop    %ebx
 13b:	5e                   	pop    %esi
 13c:	5d                   	pop    %ebp
 13d:	c3                   	ret    
    return -1;
 13e:	be ff ff ff ff       	mov    $0xffffffff,%esi
 143:	eb f0                	jmp    135 <stat+0x34>

00000145 <atoi>:

int
atoi(const char *s)
{
 145:	55                   	push   %ebp
 146:	89 e5                	mov    %esp,%ebp
 148:	53                   	push   %ebx
 149:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 14c:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 151:	eb 10                	jmp    163 <atoi+0x1e>
    n = n*10 + *s++ - '0';
 153:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
 156:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
 159:	83 c1 01             	add    $0x1,%ecx
 15c:	0f be d2             	movsbl %dl,%edx
 15f:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  while('0' <= *s && *s <= '9')
 163:	0f b6 11             	movzbl (%ecx),%edx
 166:	8d 5a d0             	lea    -0x30(%edx),%ebx
 169:	80 fb 09             	cmp    $0x9,%bl
 16c:	76 e5                	jbe    153 <atoi+0xe>
  return n;
}
 16e:	5b                   	pop    %ebx
 16f:	5d                   	pop    %ebp
 170:	c3                   	ret    

00000171 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 171:	55                   	push   %ebp
 172:	89 e5                	mov    %esp,%ebp
 174:	56                   	push   %esi
 175:	53                   	push   %ebx
 176:	8b 45 08             	mov    0x8(%ebp),%eax
 179:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 17c:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 17f:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 181:	eb 0d                	jmp    190 <memmove+0x1f>
    *dst++ = *src++;
 183:	0f b6 13             	movzbl (%ebx),%edx
 186:	88 11                	mov    %dl,(%ecx)
 188:	8d 5b 01             	lea    0x1(%ebx),%ebx
 18b:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 18e:	89 f2                	mov    %esi,%edx
 190:	8d 72 ff             	lea    -0x1(%edx),%esi
 193:	85 d2                	test   %edx,%edx
 195:	7f ec                	jg     183 <memmove+0x12>
  return vdst;
}
 197:	5b                   	pop    %ebx
 198:	5e                   	pop    %esi
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    

0000019b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 19b:	b8 01 00 00 00       	mov    $0x1,%eax
 1a0:	cd 40                	int    $0x40
 1a2:	c3                   	ret    

000001a3 <exit>:
SYSCALL(exit)
 1a3:	b8 02 00 00 00       	mov    $0x2,%eax
 1a8:	cd 40                	int    $0x40
 1aa:	c3                   	ret    

000001ab <wait>:
SYSCALL(wait)
 1ab:	b8 03 00 00 00       	mov    $0x3,%eax
 1b0:	cd 40                	int    $0x40
 1b2:	c3                   	ret    

000001b3 <pipe>:
SYSCALL(pipe)
 1b3:	b8 04 00 00 00       	mov    $0x4,%eax
 1b8:	cd 40                	int    $0x40
 1ba:	c3                   	ret    

000001bb <read>:
SYSCALL(read)
 1bb:	b8 05 00 00 00       	mov    $0x5,%eax
 1c0:	cd 40                	int    $0x40
 1c2:	c3                   	ret    

000001c3 <write>:
SYSCALL(write)
 1c3:	b8 10 00 00 00       	mov    $0x10,%eax
 1c8:	cd 40                	int    $0x40
 1ca:	c3                   	ret    

000001cb <close>:
SYSCALL(close)
 1cb:	b8 15 00 00 00       	mov    $0x15,%eax
 1d0:	cd 40                	int    $0x40
 1d2:	c3                   	ret    

000001d3 <kill>:
SYSCALL(kill)
 1d3:	b8 06 00 00 00       	mov    $0x6,%eax
 1d8:	cd 40                	int    $0x40
 1da:	c3                   	ret    

000001db <exec>:
SYSCALL(exec)
 1db:	b8 07 00 00 00       	mov    $0x7,%eax
 1e0:	cd 40                	int    $0x40
 1e2:	c3                   	ret    

000001e3 <open>:
SYSCALL(open)
 1e3:	b8 0f 00 00 00       	mov    $0xf,%eax
 1e8:	cd 40                	int    $0x40
 1ea:	c3                   	ret    

000001eb <mknod>:
SYSCALL(mknod)
 1eb:	b8 11 00 00 00       	mov    $0x11,%eax
 1f0:	cd 40                	int    $0x40
 1f2:	c3                   	ret    

000001f3 <unlink>:
SYSCALL(unlink)
 1f3:	b8 12 00 00 00       	mov    $0x12,%eax
 1f8:	cd 40                	int    $0x40
 1fa:	c3                   	ret    

000001fb <fstat>:
SYSCALL(fstat)
 1fb:	b8 08 00 00 00       	mov    $0x8,%eax
 200:	cd 40                	int    $0x40
 202:	c3                   	ret    

00000203 <link>:
SYSCALL(link)
 203:	b8 13 00 00 00       	mov    $0x13,%eax
 208:	cd 40                	int    $0x40
 20a:	c3                   	ret    

0000020b <mkdir>:
SYSCALL(mkdir)
 20b:	b8 14 00 00 00       	mov    $0x14,%eax
 210:	cd 40                	int    $0x40
 212:	c3                   	ret    

00000213 <chdir>:
SYSCALL(chdir)
 213:	b8 09 00 00 00       	mov    $0x9,%eax
 218:	cd 40                	int    $0x40
 21a:	c3                   	ret    

0000021b <dup>:
SYSCALL(dup)
 21b:	b8 0a 00 00 00       	mov    $0xa,%eax
 220:	cd 40                	int    $0x40
 222:	c3                   	ret    

00000223 <getpid>:
SYSCALL(getpid)
 223:	b8 0b 00 00 00       	mov    $0xb,%eax
 228:	cd 40                	int    $0x40
 22a:	c3                   	ret    

0000022b <sbrk>:
SYSCALL(sbrk)
 22b:	b8 0c 00 00 00       	mov    $0xc,%eax
 230:	cd 40                	int    $0x40
 232:	c3                   	ret    

00000233 <sleep>:
SYSCALL(sleep)
 233:	b8 0d 00 00 00       	mov    $0xd,%eax
 238:	cd 40                	int    $0x40
 23a:	c3                   	ret    

0000023b <uptime>:
SYSCALL(uptime)
 23b:	b8 0e 00 00 00       	mov    $0xe,%eax
 240:	cd 40                	int    $0x40
 242:	c3                   	ret    

00000243 <setpri>:
SYSCALL(setpri)
 243:	b8 16 00 00 00       	mov    $0x16,%eax
 248:	cd 40                	int    $0x40
 24a:	c3                   	ret    

0000024b <getpri>:
SYSCALL(getpri)
 24b:	b8 17 00 00 00       	mov    $0x17,%eax
 250:	cd 40                	int    $0x40
 252:	c3                   	ret    

00000253 <fork2>:
SYSCALL(fork2)
 253:	b8 18 00 00 00       	mov    $0x18,%eax
 258:	cd 40                	int    $0x40
 25a:	c3                   	ret    

0000025b <getpinfo>:
SYSCALL(getpinfo)
 25b:	b8 19 00 00 00       	mov    $0x19,%eax
 260:	cd 40                	int    $0x40
 262:	c3                   	ret    

00000263 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 263:	55                   	push   %ebp
 264:	89 e5                	mov    %esp,%ebp
 266:	83 ec 1c             	sub    $0x1c,%esp
 269:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 26c:	6a 01                	push   $0x1
 26e:	8d 55 f4             	lea    -0xc(%ebp),%edx
 271:	52                   	push   %edx
 272:	50                   	push   %eax
 273:	e8 4b ff ff ff       	call   1c3 <write>
}
 278:	83 c4 10             	add    $0x10,%esp
 27b:	c9                   	leave  
 27c:	c3                   	ret    

0000027d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 27d:	55                   	push   %ebp
 27e:	89 e5                	mov    %esp,%ebp
 280:	57                   	push   %edi
 281:	56                   	push   %esi
 282:	53                   	push   %ebx
 283:	83 ec 2c             	sub    $0x2c,%esp
 286:	89 c7                	mov    %eax,%edi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 288:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 28c:	0f 95 c3             	setne  %bl
 28f:	89 d0                	mov    %edx,%eax
 291:	c1 e8 1f             	shr    $0x1f,%eax
 294:	84 c3                	test   %al,%bl
 296:	74 10                	je     2a8 <printint+0x2b>
    neg = 1;
    x = -xx;
 298:	f7 da                	neg    %edx
    neg = 1;
 29a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 2a1:	be 00 00 00 00       	mov    $0x0,%esi
 2a6:	eb 0b                	jmp    2b3 <printint+0x36>
  neg = 0;
 2a8:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 2af:	eb f0                	jmp    2a1 <printint+0x24>
  do{
    buf[i++] = digits[x % base];
 2b1:	89 c6                	mov    %eax,%esi
 2b3:	89 d0                	mov    %edx,%eax
 2b5:	ba 00 00 00 00       	mov    $0x0,%edx
 2ba:	f7 f1                	div    %ecx
 2bc:	89 c3                	mov    %eax,%ebx
 2be:	8d 46 01             	lea    0x1(%esi),%eax
 2c1:	0f b6 92 c0 05 00 00 	movzbl 0x5c0(%edx),%edx
 2c8:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
  }while((x /= base) != 0);
 2cc:	89 da                	mov    %ebx,%edx
 2ce:	85 db                	test   %ebx,%ebx
 2d0:	75 df                	jne    2b1 <printint+0x34>
 2d2:	89 c3                	mov    %eax,%ebx
  if(neg)
 2d4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 2d8:	74 16                	je     2f0 <printint+0x73>
    buf[i++] = '-';
 2da:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 2df:	8d 5e 02             	lea    0x2(%esi),%ebx
 2e2:	eb 0c                	jmp    2f0 <printint+0x73>

  while(--i >= 0)
    putc(fd, buf[i]);
 2e4:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 2e9:	89 f8                	mov    %edi,%eax
 2eb:	e8 73 ff ff ff       	call   263 <putc>
  while(--i >= 0)
 2f0:	83 eb 01             	sub    $0x1,%ebx
 2f3:	79 ef                	jns    2e4 <printint+0x67>
}
 2f5:	83 c4 2c             	add    $0x2c,%esp
 2f8:	5b                   	pop    %ebx
 2f9:	5e                   	pop    %esi
 2fa:	5f                   	pop    %edi
 2fb:	5d                   	pop    %ebp
 2fc:	c3                   	ret    

000002fd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 2fd:	55                   	push   %ebp
 2fe:	89 e5                	mov    %esp,%ebp
 300:	57                   	push   %edi
 301:	56                   	push   %esi
 302:	53                   	push   %ebx
 303:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 306:	8d 45 10             	lea    0x10(%ebp),%eax
 309:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 30c:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 311:	bb 00 00 00 00       	mov    $0x0,%ebx
 316:	eb 14                	jmp    32c <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 318:	89 fa                	mov    %edi,%edx
 31a:	8b 45 08             	mov    0x8(%ebp),%eax
 31d:	e8 41 ff ff ff       	call   263 <putc>
 322:	eb 05                	jmp    329 <printf+0x2c>
      }
    } else if(state == '%'){
 324:	83 fe 25             	cmp    $0x25,%esi
 327:	74 25                	je     34e <printf+0x51>
  for(i = 0; fmt[i]; i++){
 329:	83 c3 01             	add    $0x1,%ebx
 32c:	8b 45 0c             	mov    0xc(%ebp),%eax
 32f:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 333:	84 c0                	test   %al,%al
 335:	0f 84 23 01 00 00    	je     45e <printf+0x161>
    c = fmt[i] & 0xff;
 33b:	0f be f8             	movsbl %al,%edi
 33e:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 341:	85 f6                	test   %esi,%esi
 343:	75 df                	jne    324 <printf+0x27>
      if(c == '%'){
 345:	83 f8 25             	cmp    $0x25,%eax
 348:	75 ce                	jne    318 <printf+0x1b>
        state = '%';
 34a:	89 c6                	mov    %eax,%esi
 34c:	eb db                	jmp    329 <printf+0x2c>
      if(c == 'd'){
 34e:	83 f8 64             	cmp    $0x64,%eax
 351:	74 49                	je     39c <printf+0x9f>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 353:	83 f8 78             	cmp    $0x78,%eax
 356:	0f 94 c1             	sete   %cl
 359:	83 f8 70             	cmp    $0x70,%eax
 35c:	0f 94 c2             	sete   %dl
 35f:	08 d1                	or     %dl,%cl
 361:	75 63                	jne    3c6 <printf+0xc9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 363:	83 f8 73             	cmp    $0x73,%eax
 366:	0f 84 84 00 00 00    	je     3f0 <printf+0xf3>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 36c:	83 f8 63             	cmp    $0x63,%eax
 36f:	0f 84 b7 00 00 00    	je     42c <printf+0x12f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 375:	83 f8 25             	cmp    $0x25,%eax
 378:	0f 84 cc 00 00 00    	je     44a <printf+0x14d>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 37e:	ba 25 00 00 00       	mov    $0x25,%edx
 383:	8b 45 08             	mov    0x8(%ebp),%eax
 386:	e8 d8 fe ff ff       	call   263 <putc>
        putc(fd, c);
 38b:	89 fa                	mov    %edi,%edx
 38d:	8b 45 08             	mov    0x8(%ebp),%eax
 390:	e8 ce fe ff ff       	call   263 <putc>
      }
      state = 0;
 395:	be 00 00 00 00       	mov    $0x0,%esi
 39a:	eb 8d                	jmp    329 <printf+0x2c>
        printint(fd, *ap, 10, 1);
 39c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 39f:	8b 17                	mov    (%edi),%edx
 3a1:	83 ec 0c             	sub    $0xc,%esp
 3a4:	6a 01                	push   $0x1
 3a6:	b9 0a 00 00 00       	mov    $0xa,%ecx
 3ab:	8b 45 08             	mov    0x8(%ebp),%eax
 3ae:	e8 ca fe ff ff       	call   27d <printint>
        ap++;
 3b3:	83 c7 04             	add    $0x4,%edi
 3b6:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 3b9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 3bc:	be 00 00 00 00       	mov    $0x0,%esi
 3c1:	e9 63 ff ff ff       	jmp    329 <printf+0x2c>
        printint(fd, *ap, 16, 0);
 3c6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 3c9:	8b 17                	mov    (%edi),%edx
 3cb:	83 ec 0c             	sub    $0xc,%esp
 3ce:	6a 00                	push   $0x0
 3d0:	b9 10 00 00 00       	mov    $0x10,%ecx
 3d5:	8b 45 08             	mov    0x8(%ebp),%eax
 3d8:	e8 a0 fe ff ff       	call   27d <printint>
        ap++;
 3dd:	83 c7 04             	add    $0x4,%edi
 3e0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 3e3:	83 c4 10             	add    $0x10,%esp
      state = 0;
 3e6:	be 00 00 00 00       	mov    $0x0,%esi
 3eb:	e9 39 ff ff ff       	jmp    329 <printf+0x2c>
        s = (char*)*ap;
 3f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 3f3:	8b 30                	mov    (%eax),%esi
        ap++;
 3f5:	83 c0 04             	add    $0x4,%eax
 3f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 3fb:	85 f6                	test   %esi,%esi
 3fd:	75 28                	jne    427 <printf+0x12a>
          s = "(null)";
 3ff:	be b8 05 00 00       	mov    $0x5b8,%esi
 404:	8b 7d 08             	mov    0x8(%ebp),%edi
 407:	eb 0d                	jmp    416 <printf+0x119>
          putc(fd, *s);
 409:	0f be d2             	movsbl %dl,%edx
 40c:	89 f8                	mov    %edi,%eax
 40e:	e8 50 fe ff ff       	call   263 <putc>
          s++;
 413:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 416:	0f b6 16             	movzbl (%esi),%edx
 419:	84 d2                	test   %dl,%dl
 41b:	75 ec                	jne    409 <printf+0x10c>
      state = 0;
 41d:	be 00 00 00 00       	mov    $0x0,%esi
 422:	e9 02 ff ff ff       	jmp    329 <printf+0x2c>
 427:	8b 7d 08             	mov    0x8(%ebp),%edi
 42a:	eb ea                	jmp    416 <printf+0x119>
        putc(fd, *ap);
 42c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 42f:	0f be 17             	movsbl (%edi),%edx
 432:	8b 45 08             	mov    0x8(%ebp),%eax
 435:	e8 29 fe ff ff       	call   263 <putc>
        ap++;
 43a:	83 c7 04             	add    $0x4,%edi
 43d:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 440:	be 00 00 00 00       	mov    $0x0,%esi
 445:	e9 df fe ff ff       	jmp    329 <printf+0x2c>
        putc(fd, c);
 44a:	89 fa                	mov    %edi,%edx
 44c:	8b 45 08             	mov    0x8(%ebp),%eax
 44f:	e8 0f fe ff ff       	call   263 <putc>
      state = 0;
 454:	be 00 00 00 00       	mov    $0x0,%esi
 459:	e9 cb fe ff ff       	jmp    329 <printf+0x2c>
    }
  }
}
 45e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 461:	5b                   	pop    %ebx
 462:	5e                   	pop    %esi
 463:	5f                   	pop    %edi
 464:	5d                   	pop    %ebp
 465:	c3                   	ret    

00000466 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 466:	55                   	push   %ebp
 467:	89 e5                	mov    %esp,%ebp
 469:	57                   	push   %edi
 46a:	56                   	push   %esi
 46b:	53                   	push   %ebx
 46c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 46f:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 472:	a1 58 08 00 00       	mov    0x858,%eax
 477:	eb 02                	jmp    47b <free+0x15>
 479:	89 d0                	mov    %edx,%eax
 47b:	39 c8                	cmp    %ecx,%eax
 47d:	73 04                	jae    483 <free+0x1d>
 47f:	39 08                	cmp    %ecx,(%eax)
 481:	77 12                	ja     495 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 483:	8b 10                	mov    (%eax),%edx
 485:	39 c2                	cmp    %eax,%edx
 487:	77 f0                	ja     479 <free+0x13>
 489:	39 c8                	cmp    %ecx,%eax
 48b:	72 08                	jb     495 <free+0x2f>
 48d:	39 ca                	cmp    %ecx,%edx
 48f:	77 04                	ja     495 <free+0x2f>
 491:	89 d0                	mov    %edx,%eax
 493:	eb e6                	jmp    47b <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
 495:	8b 73 fc             	mov    -0x4(%ebx),%esi
 498:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 49b:	8b 10                	mov    (%eax),%edx
 49d:	39 d7                	cmp    %edx,%edi
 49f:	74 19                	je     4ba <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 4a1:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4a4:	8b 50 04             	mov    0x4(%eax),%edx
 4a7:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4aa:	39 ce                	cmp    %ecx,%esi
 4ac:	74 1b                	je     4c9 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 4ae:	89 08                	mov    %ecx,(%eax)
  freep = p;
 4b0:	a3 58 08 00 00       	mov    %eax,0x858
}
 4b5:	5b                   	pop    %ebx
 4b6:	5e                   	pop    %esi
 4b7:	5f                   	pop    %edi
 4b8:	5d                   	pop    %ebp
 4b9:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 4ba:	03 72 04             	add    0x4(%edx),%esi
 4bd:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 4c0:	8b 10                	mov    (%eax),%edx
 4c2:	8b 12                	mov    (%edx),%edx
 4c4:	89 53 f8             	mov    %edx,-0x8(%ebx)
 4c7:	eb db                	jmp    4a4 <free+0x3e>
    p->s.size += bp->s.size;
 4c9:	03 53 fc             	add    -0x4(%ebx),%edx
 4cc:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 4cf:	8b 53 f8             	mov    -0x8(%ebx),%edx
 4d2:	89 10                	mov    %edx,(%eax)
 4d4:	eb da                	jmp    4b0 <free+0x4a>

000004d6 <morecore>:

static Header*
morecore(uint nu)
{
 4d6:	55                   	push   %ebp
 4d7:	89 e5                	mov    %esp,%ebp
 4d9:	53                   	push   %ebx
 4da:	83 ec 04             	sub    $0x4,%esp
 4dd:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 4df:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 4e4:	77 05                	ja     4eb <morecore+0x15>
    nu = 4096;
 4e6:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 4eb:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 4f2:	83 ec 0c             	sub    $0xc,%esp
 4f5:	50                   	push   %eax
 4f6:	e8 30 fd ff ff       	call   22b <sbrk>
  if(p == (char*)-1)
 4fb:	83 c4 10             	add    $0x10,%esp
 4fe:	83 f8 ff             	cmp    $0xffffffff,%eax
 501:	74 1c                	je     51f <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 503:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 506:	83 c0 08             	add    $0x8,%eax
 509:	83 ec 0c             	sub    $0xc,%esp
 50c:	50                   	push   %eax
 50d:	e8 54 ff ff ff       	call   466 <free>
  return freep;
 512:	a1 58 08 00 00       	mov    0x858,%eax
 517:	83 c4 10             	add    $0x10,%esp
}
 51a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 51d:	c9                   	leave  
 51e:	c3                   	ret    
    return 0;
 51f:	b8 00 00 00 00       	mov    $0x0,%eax
 524:	eb f4                	jmp    51a <morecore+0x44>

00000526 <malloc>:

void*
malloc(uint nbytes)
{
 526:	55                   	push   %ebp
 527:	89 e5                	mov    %esp,%ebp
 529:	53                   	push   %ebx
 52a:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 52d:	8b 45 08             	mov    0x8(%ebp),%eax
 530:	8d 58 07             	lea    0x7(%eax),%ebx
 533:	c1 eb 03             	shr    $0x3,%ebx
 536:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 539:	8b 0d 58 08 00 00    	mov    0x858,%ecx
 53f:	85 c9                	test   %ecx,%ecx
 541:	74 04                	je     547 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 543:	8b 01                	mov    (%ecx),%eax
 545:	eb 4d                	jmp    594 <malloc+0x6e>
    base.s.ptr = freep = prevp = &base;
 547:	c7 05 58 08 00 00 5c 	movl   $0x85c,0x858
 54e:	08 00 00 
 551:	c7 05 5c 08 00 00 5c 	movl   $0x85c,0x85c
 558:	08 00 00 
    base.s.size = 0;
 55b:	c7 05 60 08 00 00 00 	movl   $0x0,0x860
 562:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 565:	b9 5c 08 00 00       	mov    $0x85c,%ecx
 56a:	eb d7                	jmp    543 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 56c:	39 da                	cmp    %ebx,%edx
 56e:	74 1a                	je     58a <malloc+0x64>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 570:	29 da                	sub    %ebx,%edx
 572:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 575:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 578:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 57b:	89 0d 58 08 00 00    	mov    %ecx,0x858
      return (void*)(p + 1);
 581:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 584:	83 c4 04             	add    $0x4,%esp
 587:	5b                   	pop    %ebx
 588:	5d                   	pop    %ebp
 589:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 58a:	8b 10                	mov    (%eax),%edx
 58c:	89 11                	mov    %edx,(%ecx)
 58e:	eb eb                	jmp    57b <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 590:	89 c1                	mov    %eax,%ecx
 592:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 594:	8b 50 04             	mov    0x4(%eax),%edx
 597:	39 da                	cmp    %ebx,%edx
 599:	73 d1                	jae    56c <malloc+0x46>
    if(p == freep)
 59b:	39 05 58 08 00 00    	cmp    %eax,0x858
 5a1:	75 ed                	jne    590 <malloc+0x6a>
      if((p = morecore(nunits)) == 0)
 5a3:	89 d8                	mov    %ebx,%eax
 5a5:	e8 2c ff ff ff       	call   4d6 <morecore>
 5aa:	85 c0                	test   %eax,%eax
 5ac:	75 e2                	jne    590 <malloc+0x6a>
        return 0;
 5ae:	b8 00 00 00 00       	mov    $0x0,%eax
 5b3:	eb cf                	jmp    584 <malloc+0x5e>

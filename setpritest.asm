
_setpritest:     file format elf32-i386


Disassembly of section .text:

00000000 <swap>:
#include "types.h"
#include "user.h"
#include "stat.h"


void swap(char *first, char *last) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	8b 55 08             	mov    0x8(%ebp),%edx
   7:	8b 45 0c             	mov    0xc(%ebp),%eax
    char x = *first; *first = *last; *last = x;
   a:	0f b6 0a             	movzbl (%edx),%ecx
   d:	0f b6 18             	movzbl (%eax),%ebx
  10:	88 1a                	mov    %bl,(%edx)
  12:	88 08                	mov    %cl,(%eax)
}
  14:	5b                   	pop    %ebx
  15:	5d                   	pop    %ebp
  16:	c3                   	ret    

00000017 <my_itoa>:

char* my_itoa(int value, char* buffer) {
  17:	55                   	push   %ebp
  18:	89 e5                	mov    %esp,%ebp
  1a:	57                   	push   %edi
  1b:	56                   	push   %esi
  1c:	53                   	push   %ebx
  1d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  20:	8b 75 0c             	mov    0xc(%ebp),%esi
    int x = 0;
  23:	bb 00 00 00 00       	mov    $0x0,%ebx
    while (value) {
  28:	eb 2a                	jmp    54 <my_itoa+0x3d>
        int r = value % 10;
  2a:	ba 67 66 66 66       	mov    $0x66666667,%edx
  2f:	89 c8                	mov    %ecx,%eax
  31:	f7 ea                	imul   %edx
  33:	c1 fa 02             	sar    $0x2,%edx
  36:	89 c8                	mov    %ecx,%eax
  38:	c1 f8 1f             	sar    $0x1f,%eax
  3b:	29 c2                	sub    %eax,%edx
  3d:	89 d0                	mov    %edx,%eax
  3f:	8d 3c 92             	lea    (%edx,%edx,4),%edi
  42:	8d 14 3f             	lea    (%edi,%edi,1),%edx
  45:	29 d1                	sub    %edx,%ecx
  47:	89 ca                	mov    %ecx,%edx
        buffer[x++] = 48 + r;
  49:	83 c2 30             	add    $0x30,%edx
  4c:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
        value = value / 10;
  4f:	89 c1                	mov    %eax,%ecx
        buffer[x++] = 48 + r;
  51:	8d 5b 01             	lea    0x1(%ebx),%ebx
    while (value) {
  54:	85 c9                	test   %ecx,%ecx
  56:	75 d2                	jne    2a <my_itoa+0x13>
    }

    if (x == 0) {
  58:	85 db                	test   %ebx,%ebx
  5a:	75 07                	jne    63 <my_itoa+0x4c>
        buffer[x++] = '0';
  5c:	c6 04 1e 30          	movb   $0x30,(%esi,%ebx,1)
  60:	8d 5b 01             	lea    0x1(%ebx),%ebx
    }
    buffer[x] = '\0';
  63:	c6 04 1e 00          	movb   $0x0,(%esi,%ebx,1)
    int i = 0, j = i - 1;
    while (i < j) {
        swap(&buffer[i++], &buffer[j--]);
    }
    return buffer;
}
  67:	89 f0                	mov    %esi,%eax
  69:	5b                   	pop    %ebx
  6a:	5e                   	pop    %esi
  6b:	5f                   	pop    %edi
  6c:	5d                   	pop    %ebp
  6d:	c3                   	ret    

0000006e <strcat>:

char* strcat(char* src, char* dst) {
  6e:	55                   	push   %ebp
  6f:	89 e5                	mov    %esp,%ebp
  71:	53                   	push   %ebx
  72:	8b 4d 08             	mov    0x8(%ebp),%ecx
  75:	8b 45 0c             	mov    0xc(%ebp),%eax
    char* ptr = dst;
  78:	89 c2                	mov    %eax,%edx
    while (*ptr != '\0')
  7a:	eb 03                	jmp    7f <strcat+0x11>
        ptr++;
  7c:	83 c2 01             	add    $0x1,%edx
    while (*ptr != '\0')
  7f:	80 3a 00             	cmpb   $0x0,(%edx)
  82:	75 f8                	jne    7c <strcat+0xe>
  84:	eb 08                	jmp    8e <strcat+0x20>
    while (*src != '\0')
        *ptr++ = *src++;
  86:	83 c1 01             	add    $0x1,%ecx
  89:	88 1a                	mov    %bl,(%edx)
  8b:	8d 52 01             	lea    0x1(%edx),%edx
    while (*src != '\0')
  8e:	0f b6 19             	movzbl (%ecx),%ebx
  91:	84 db                	test   %bl,%bl
  93:	75 f1                	jne    86 <strcat+0x18>
    *ptr = '\0';
  95:	c6 02 00             	movb   $0x0,(%edx)
    return dst;

}
  98:	5b                   	pop    %ebx
  99:	5d                   	pop    %ebp
  9a:	c3                   	ret    

0000009b <my_atoi>:

int my_atoi(char* str) {
  9b:	55                   	push   %ebp
  9c:	89 e5                	mov    %esp,%ebp
  9e:	56                   	push   %esi
  9f:	53                   	push   %ebx
  a0:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int num = 0;
    for (int i = 0; str[i] != '\0'; i++) {
  a3:	b9 00 00 00 00       	mov    $0x0,%ecx
    int num = 0;
  a8:	b8 00 00 00 00       	mov    $0x0,%eax
    for (int i = 0; str[i] != '\0'; i++) {
  ad:	eb 10                	jmp    bf <my_atoi+0x24>
        num = num * 10 + str[i] - '0';
  af:	8d 34 80             	lea    (%eax,%eax,4),%esi
  b2:	8d 04 36             	lea    (%esi,%esi,1),%eax
  b5:	0f be d2             	movsbl %dl,%edx
  b8:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
    for (int i = 0; str[i] != '\0'; i++) {
  bc:	83 c1 01             	add    $0x1,%ecx
  bf:	0f b6 14 0b          	movzbl (%ebx,%ecx,1),%edx
  c3:	84 d2                	test   %dl,%dl
  c5:	75 e8                	jne    af <my_atoi+0x14>
    }
    return num;
}
  c7:	5b                   	pop    %ebx
  c8:	5e                   	pop    %esi
  c9:	5d                   	pop    %ebp
  ca:	c3                   	ret    

000000cb <main>:

int main(int argc, char* argv[] ) {
  cb:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  cf:	83 e4 f0             	and    $0xfffffff0,%esp
  d2:	ff 71 fc             	pushl  -0x4(%ecx)
  d5:	55                   	push   %ebp
  d6:	89 e5                	mov    %esp,%ebp
  d8:	56                   	push   %esi
  d9:	53                   	push   %ebx
  da:	51                   	push   %ecx
  db:	83 ec 0c             	sub    $0xc,%esp
  de:	8b 71 04             	mov    0x4(%ecx),%esi
    if (argc < 3) {
  e1:	83 39 02             	cmpl   $0x2,(%ecx)
  e4:	7f 14                	jg     fa <main+0x2f>
        printf(1, "error: too few arguments\n");
  e6:	83 ec 08             	sub    $0x8,%esp
  e9:	68 0c 07 00 00       	push   $0x70c
  ee:	6a 01                	push   $0x1
  f0:	e8 5d 03 00 00       	call   452 <printf>
        exit();
  f5:	e8 fe 01 00 00       	call   2f8 <exit>
    }
    //argv[1] = pid
    //argv[2] = priority

    int pid = my_atoi(argv[1]);
  fa:	83 ec 0c             	sub    $0xc,%esp
  fd:	ff 76 04             	pushl  0x4(%esi)
 100:	e8 96 ff ff ff       	call   9b <my_atoi>
 105:	83 c4 04             	add    $0x4,%esp
 108:	89 c3                	mov    %eax,%ebx
    int priority = my_atoi(argv[2]);
 10a:	ff 76 08             	pushl  0x8(%esi)
 10d:	e8 89 ff ff ff       	call   9b <my_atoi>
 112:	83 c4 0c             	add    $0xc,%esp
 115:	89 c6                	mov    %eax,%esi

    printf(1, "input pid: %d\n", pid);
 117:	53                   	push   %ebx
 118:	68 26 07 00 00       	push   $0x726
 11d:	6a 01                	push   $0x1
 11f:	e8 2e 03 00 00       	call   452 <printf>
    printf(1, "input priority: %d\n", priority);
 124:	83 c4 0c             	add    $0xc,%esp
 127:	56                   	push   %esi
 128:	68 35 07 00 00       	push   $0x735
 12d:	6a 01                	push   $0x1
 12f:	e8 1e 03 00 00       	call   452 <printf>

    setpri(pid, priority);
 134:	83 c4 08             	add    $0x8,%esp
 137:	56                   	push   %esi
 138:	53                   	push   %ebx
 139:	e8 5a 02 00 00       	call   398 <setpri>

    printf(1, "new pid: %d\n", pid);
 13e:	83 c4 0c             	add    $0xc,%esp
 141:	53                   	push   %ebx
 142:	68 49 07 00 00       	push   $0x749
 147:	6a 01                	push   $0x1
 149:	e8 04 03 00 00       	call   452 <printf>
    printf(1, "new priority: %d\n", getpri(pid));
 14e:	89 1c 24             	mov    %ebx,(%esp)
 151:	e8 4a 02 00 00       	call   3a0 <getpri>
 156:	83 c4 0c             	add    $0xc,%esp
 159:	50                   	push   %eax
 15a:	68 56 07 00 00       	push   $0x756
 15f:	6a 01                	push   $0x1
 161:	e8 ec 02 00 00       	call   452 <printf>

    exit();
 166:	e8 8d 01 00 00       	call   2f8 <exit>

0000016b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 16b:	55                   	push   %ebp
 16c:	89 e5                	mov    %esp,%ebp
 16e:	53                   	push   %ebx
 16f:	8b 45 08             	mov    0x8(%ebp),%eax
 172:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 175:	89 c2                	mov    %eax,%edx
 177:	0f b6 19             	movzbl (%ecx),%ebx
 17a:	88 1a                	mov    %bl,(%edx)
 17c:	8d 52 01             	lea    0x1(%edx),%edx
 17f:	8d 49 01             	lea    0x1(%ecx),%ecx
 182:	84 db                	test   %bl,%bl
 184:	75 f1                	jne    177 <strcpy+0xc>
    ;
  return os;
}
 186:	5b                   	pop    %ebx
 187:	5d                   	pop    %ebp
 188:	c3                   	ret    

00000189 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 189:	55                   	push   %ebp
 18a:	89 e5                	mov    %esp,%ebp
 18c:	8b 4d 08             	mov    0x8(%ebp),%ecx
 18f:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 192:	eb 06                	jmp    19a <strcmp+0x11>
    p++, q++;
 194:	83 c1 01             	add    $0x1,%ecx
 197:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 19a:	0f b6 01             	movzbl (%ecx),%eax
 19d:	84 c0                	test   %al,%al
 19f:	74 04                	je     1a5 <strcmp+0x1c>
 1a1:	3a 02                	cmp    (%edx),%al
 1a3:	74 ef                	je     194 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
 1a5:	0f b6 c0             	movzbl %al,%eax
 1a8:	0f b6 12             	movzbl (%edx),%edx
 1ab:	29 d0                	sub    %edx,%eax
}
 1ad:	5d                   	pop    %ebp
 1ae:	c3                   	ret    

000001af <strlen>:

uint
strlen(const char *s)
{
 1af:	55                   	push   %ebp
 1b0:	89 e5                	mov    %esp,%ebp
 1b2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1b5:	ba 00 00 00 00       	mov    $0x0,%edx
 1ba:	eb 03                	jmp    1bf <strlen+0x10>
 1bc:	83 c2 01             	add    $0x1,%edx
 1bf:	89 d0                	mov    %edx,%eax
 1c1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1c5:	75 f5                	jne    1bc <strlen+0xd>
    ;
  return n;
}
 1c7:	5d                   	pop    %ebp
 1c8:	c3                   	ret    

000001c9 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c9:	55                   	push   %ebp
 1ca:	89 e5                	mov    %esp,%ebp
 1cc:	57                   	push   %edi
 1cd:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d0:	89 d7                	mov    %edx,%edi
 1d2:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1d5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d8:	fc                   	cld    
 1d9:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1db:	89 d0                	mov    %edx,%eax
 1dd:	5f                   	pop    %edi
 1de:	5d                   	pop    %ebp
 1df:	c3                   	ret    

000001e0 <strchr>:

char*
strchr(const char *s, char c)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ea:	0f b6 10             	movzbl (%eax),%edx
 1ed:	84 d2                	test   %dl,%dl
 1ef:	74 09                	je     1fa <strchr+0x1a>
    if(*s == c)
 1f1:	38 ca                	cmp    %cl,%dl
 1f3:	74 0a                	je     1ff <strchr+0x1f>
  for(; *s; s++)
 1f5:	83 c0 01             	add    $0x1,%eax
 1f8:	eb f0                	jmp    1ea <strchr+0xa>
      return (char*)s;
  return 0;
 1fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1ff:	5d                   	pop    %ebp
 200:	c3                   	ret    

00000201 <gets>:

char*
gets(char *buf, int max)
{
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	57                   	push   %edi
 205:	56                   	push   %esi
 206:	53                   	push   %ebx
 207:	83 ec 1c             	sub    $0x1c,%esp
 20a:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 20d:	bb 00 00 00 00       	mov    $0x0,%ebx
 212:	8d 73 01             	lea    0x1(%ebx),%esi
 215:	3b 75 0c             	cmp    0xc(%ebp),%esi
 218:	7d 2e                	jge    248 <gets+0x47>
    cc = read(0, &c, 1);
 21a:	83 ec 04             	sub    $0x4,%esp
 21d:	6a 01                	push   $0x1
 21f:	8d 45 e7             	lea    -0x19(%ebp),%eax
 222:	50                   	push   %eax
 223:	6a 00                	push   $0x0
 225:	e8 e6 00 00 00       	call   310 <read>
    if(cc < 1)
 22a:	83 c4 10             	add    $0x10,%esp
 22d:	85 c0                	test   %eax,%eax
 22f:	7e 17                	jle    248 <gets+0x47>
      break;
    buf[i++] = c;
 231:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 235:	88 04 1f             	mov    %al,(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 238:	3c 0a                	cmp    $0xa,%al
 23a:	0f 94 c2             	sete   %dl
 23d:	3c 0d                	cmp    $0xd,%al
 23f:	0f 94 c0             	sete   %al
    buf[i++] = c;
 242:	89 f3                	mov    %esi,%ebx
    if(c == '\n' || c == '\r')
 244:	08 c2                	or     %al,%dl
 246:	74 ca                	je     212 <gets+0x11>
      break;
  }
  buf[i] = '\0';
 248:	c6 04 1f 00          	movb   $0x0,(%edi,%ebx,1)
  return buf;
}
 24c:	89 f8                	mov    %edi,%eax
 24e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 251:	5b                   	pop    %ebx
 252:	5e                   	pop    %esi
 253:	5f                   	pop    %edi
 254:	5d                   	pop    %ebp
 255:	c3                   	ret    

00000256 <stat>:

int
stat(const char *n, struct stat *st)
{
 256:	55                   	push   %ebp
 257:	89 e5                	mov    %esp,%ebp
 259:	56                   	push   %esi
 25a:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 25b:	83 ec 08             	sub    $0x8,%esp
 25e:	6a 00                	push   $0x0
 260:	ff 75 08             	pushl  0x8(%ebp)
 263:	e8 d0 00 00 00       	call   338 <open>
  if(fd < 0)
 268:	83 c4 10             	add    $0x10,%esp
 26b:	85 c0                	test   %eax,%eax
 26d:	78 24                	js     293 <stat+0x3d>
 26f:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 271:	83 ec 08             	sub    $0x8,%esp
 274:	ff 75 0c             	pushl  0xc(%ebp)
 277:	50                   	push   %eax
 278:	e8 d3 00 00 00       	call   350 <fstat>
 27d:	89 c6                	mov    %eax,%esi
  close(fd);
 27f:	89 1c 24             	mov    %ebx,(%esp)
 282:	e8 99 00 00 00       	call   320 <close>
  return r;
 287:	83 c4 10             	add    $0x10,%esp
}
 28a:	89 f0                	mov    %esi,%eax
 28c:	8d 65 f8             	lea    -0x8(%ebp),%esp
 28f:	5b                   	pop    %ebx
 290:	5e                   	pop    %esi
 291:	5d                   	pop    %ebp
 292:	c3                   	ret    
    return -1;
 293:	be ff ff ff ff       	mov    $0xffffffff,%esi
 298:	eb f0                	jmp    28a <stat+0x34>

0000029a <atoi>:

int
atoi(const char *s)
{
 29a:	55                   	push   %ebp
 29b:	89 e5                	mov    %esp,%ebp
 29d:	53                   	push   %ebx
 29e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 2a1:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2a6:	eb 10                	jmp    2b8 <atoi+0x1e>
    n = n*10 + *s++ - '0';
 2a8:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
 2ab:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
 2ae:	83 c1 01             	add    $0x1,%ecx
 2b1:	0f be d2             	movsbl %dl,%edx
 2b4:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  while('0' <= *s && *s <= '9')
 2b8:	0f b6 11             	movzbl (%ecx),%edx
 2bb:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2be:	80 fb 09             	cmp    $0x9,%bl
 2c1:	76 e5                	jbe    2a8 <atoi+0xe>
  return n;
}
 2c3:	5b                   	pop    %ebx
 2c4:	5d                   	pop    %ebp
 2c5:	c3                   	ret    

000002c6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2c6:	55                   	push   %ebp
 2c7:	89 e5                	mov    %esp,%ebp
 2c9:	56                   	push   %esi
 2ca:	53                   	push   %ebx
 2cb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ce:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2d1:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 2d4:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 2d6:	eb 0d                	jmp    2e5 <memmove+0x1f>
    *dst++ = *src++;
 2d8:	0f b6 13             	movzbl (%ebx),%edx
 2db:	88 11                	mov    %dl,(%ecx)
 2dd:	8d 5b 01             	lea    0x1(%ebx),%ebx
 2e0:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 2e3:	89 f2                	mov    %esi,%edx
 2e5:	8d 72 ff             	lea    -0x1(%edx),%esi
 2e8:	85 d2                	test   %edx,%edx
 2ea:	7f ec                	jg     2d8 <memmove+0x12>
  return vdst;
}
 2ec:	5b                   	pop    %ebx
 2ed:	5e                   	pop    %esi
 2ee:	5d                   	pop    %ebp
 2ef:	c3                   	ret    

000002f0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2f0:	b8 01 00 00 00       	mov    $0x1,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <exit>:
SYSCALL(exit)
 2f8:	b8 02 00 00 00       	mov    $0x2,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <wait>:
SYSCALL(wait)
 300:	b8 03 00 00 00       	mov    $0x3,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <pipe>:
SYSCALL(pipe)
 308:	b8 04 00 00 00       	mov    $0x4,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <read>:
SYSCALL(read)
 310:	b8 05 00 00 00       	mov    $0x5,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <write>:
SYSCALL(write)
 318:	b8 10 00 00 00       	mov    $0x10,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <close>:
SYSCALL(close)
 320:	b8 15 00 00 00       	mov    $0x15,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <kill>:
SYSCALL(kill)
 328:	b8 06 00 00 00       	mov    $0x6,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <exec>:
SYSCALL(exec)
 330:	b8 07 00 00 00       	mov    $0x7,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <open>:
SYSCALL(open)
 338:	b8 0f 00 00 00       	mov    $0xf,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <mknod>:
SYSCALL(mknod)
 340:	b8 11 00 00 00       	mov    $0x11,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <unlink>:
SYSCALL(unlink)
 348:	b8 12 00 00 00       	mov    $0x12,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <fstat>:
SYSCALL(fstat)
 350:	b8 08 00 00 00       	mov    $0x8,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <link>:
SYSCALL(link)
 358:	b8 13 00 00 00       	mov    $0x13,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <mkdir>:
SYSCALL(mkdir)
 360:	b8 14 00 00 00       	mov    $0x14,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <chdir>:
SYSCALL(chdir)
 368:	b8 09 00 00 00       	mov    $0x9,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <dup>:
SYSCALL(dup)
 370:	b8 0a 00 00 00       	mov    $0xa,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <getpid>:
SYSCALL(getpid)
 378:	b8 0b 00 00 00       	mov    $0xb,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <sbrk>:
SYSCALL(sbrk)
 380:	b8 0c 00 00 00       	mov    $0xc,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <sleep>:
SYSCALL(sleep)
 388:	b8 0d 00 00 00       	mov    $0xd,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <uptime>:
SYSCALL(uptime)
 390:	b8 0e 00 00 00       	mov    $0xe,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <setpri>:
SYSCALL(setpri)
 398:	b8 16 00 00 00       	mov    $0x16,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <getpri>:
SYSCALL(getpri)
 3a0:	b8 17 00 00 00       	mov    $0x17,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <fork2>:
SYSCALL(fork2)
 3a8:	b8 18 00 00 00       	mov    $0x18,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <getpinfo>:
SYSCALL(getpinfo)
 3b0:	b8 19 00 00 00       	mov    $0x19,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3b8:	55                   	push   %ebp
 3b9:	89 e5                	mov    %esp,%ebp
 3bb:	83 ec 1c             	sub    $0x1c,%esp
 3be:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 3c1:	6a 01                	push   $0x1
 3c3:	8d 55 f4             	lea    -0xc(%ebp),%edx
 3c6:	52                   	push   %edx
 3c7:	50                   	push   %eax
 3c8:	e8 4b ff ff ff       	call   318 <write>
}
 3cd:	83 c4 10             	add    $0x10,%esp
 3d0:	c9                   	leave  
 3d1:	c3                   	ret    

000003d2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3d2:	55                   	push   %ebp
 3d3:	89 e5                	mov    %esp,%ebp
 3d5:	57                   	push   %edi
 3d6:	56                   	push   %esi
 3d7:	53                   	push   %ebx
 3d8:	83 ec 2c             	sub    $0x2c,%esp
 3db:	89 c7                	mov    %eax,%edi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3dd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 3e1:	0f 95 c3             	setne  %bl
 3e4:	89 d0                	mov    %edx,%eax
 3e6:	c1 e8 1f             	shr    $0x1f,%eax
 3e9:	84 c3                	test   %al,%bl
 3eb:	74 10                	je     3fd <printint+0x2b>
    neg = 1;
    x = -xx;
 3ed:	f7 da                	neg    %edx
    neg = 1;
 3ef:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3f6:	be 00 00 00 00       	mov    $0x0,%esi
 3fb:	eb 0b                	jmp    408 <printint+0x36>
  neg = 0;
 3fd:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 404:	eb f0                	jmp    3f6 <printint+0x24>
  do{
    buf[i++] = digits[x % base];
 406:	89 c6                	mov    %eax,%esi
 408:	89 d0                	mov    %edx,%eax
 40a:	ba 00 00 00 00       	mov    $0x0,%edx
 40f:	f7 f1                	div    %ecx
 411:	89 c3                	mov    %eax,%ebx
 413:	8d 46 01             	lea    0x1(%esi),%eax
 416:	0f b6 92 70 07 00 00 	movzbl 0x770(%edx),%edx
 41d:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
  }while((x /= base) != 0);
 421:	89 da                	mov    %ebx,%edx
 423:	85 db                	test   %ebx,%ebx
 425:	75 df                	jne    406 <printint+0x34>
 427:	89 c3                	mov    %eax,%ebx
  if(neg)
 429:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 42d:	74 16                	je     445 <printint+0x73>
    buf[i++] = '-';
 42f:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 434:	8d 5e 02             	lea    0x2(%esi),%ebx
 437:	eb 0c                	jmp    445 <printint+0x73>

  while(--i >= 0)
    putc(fd, buf[i]);
 439:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 43e:	89 f8                	mov    %edi,%eax
 440:	e8 73 ff ff ff       	call   3b8 <putc>
  while(--i >= 0)
 445:	83 eb 01             	sub    $0x1,%ebx
 448:	79 ef                	jns    439 <printint+0x67>
}
 44a:	83 c4 2c             	add    $0x2c,%esp
 44d:	5b                   	pop    %ebx
 44e:	5e                   	pop    %esi
 44f:	5f                   	pop    %edi
 450:	5d                   	pop    %ebp
 451:	c3                   	ret    

00000452 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 452:	55                   	push   %ebp
 453:	89 e5                	mov    %esp,%ebp
 455:	57                   	push   %edi
 456:	56                   	push   %esi
 457:	53                   	push   %ebx
 458:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 45b:	8d 45 10             	lea    0x10(%ebp),%eax
 45e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 461:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 466:	bb 00 00 00 00       	mov    $0x0,%ebx
 46b:	eb 14                	jmp    481 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 46d:	89 fa                	mov    %edi,%edx
 46f:	8b 45 08             	mov    0x8(%ebp),%eax
 472:	e8 41 ff ff ff       	call   3b8 <putc>
 477:	eb 05                	jmp    47e <printf+0x2c>
      }
    } else if(state == '%'){
 479:	83 fe 25             	cmp    $0x25,%esi
 47c:	74 25                	je     4a3 <printf+0x51>
  for(i = 0; fmt[i]; i++){
 47e:	83 c3 01             	add    $0x1,%ebx
 481:	8b 45 0c             	mov    0xc(%ebp),%eax
 484:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 488:	84 c0                	test   %al,%al
 48a:	0f 84 23 01 00 00    	je     5b3 <printf+0x161>
    c = fmt[i] & 0xff;
 490:	0f be f8             	movsbl %al,%edi
 493:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 496:	85 f6                	test   %esi,%esi
 498:	75 df                	jne    479 <printf+0x27>
      if(c == '%'){
 49a:	83 f8 25             	cmp    $0x25,%eax
 49d:	75 ce                	jne    46d <printf+0x1b>
        state = '%';
 49f:	89 c6                	mov    %eax,%esi
 4a1:	eb db                	jmp    47e <printf+0x2c>
      if(c == 'd'){
 4a3:	83 f8 64             	cmp    $0x64,%eax
 4a6:	74 49                	je     4f1 <printf+0x9f>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4a8:	83 f8 78             	cmp    $0x78,%eax
 4ab:	0f 94 c1             	sete   %cl
 4ae:	83 f8 70             	cmp    $0x70,%eax
 4b1:	0f 94 c2             	sete   %dl
 4b4:	08 d1                	or     %dl,%cl
 4b6:	75 63                	jne    51b <printf+0xc9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4b8:	83 f8 73             	cmp    $0x73,%eax
 4bb:	0f 84 84 00 00 00    	je     545 <printf+0xf3>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4c1:	83 f8 63             	cmp    $0x63,%eax
 4c4:	0f 84 b7 00 00 00    	je     581 <printf+0x12f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4ca:	83 f8 25             	cmp    $0x25,%eax
 4cd:	0f 84 cc 00 00 00    	je     59f <printf+0x14d>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4d3:	ba 25 00 00 00       	mov    $0x25,%edx
 4d8:	8b 45 08             	mov    0x8(%ebp),%eax
 4db:	e8 d8 fe ff ff       	call   3b8 <putc>
        putc(fd, c);
 4e0:	89 fa                	mov    %edi,%edx
 4e2:	8b 45 08             	mov    0x8(%ebp),%eax
 4e5:	e8 ce fe ff ff       	call   3b8 <putc>
      }
      state = 0;
 4ea:	be 00 00 00 00       	mov    $0x0,%esi
 4ef:	eb 8d                	jmp    47e <printf+0x2c>
        printint(fd, *ap, 10, 1);
 4f1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 4f4:	8b 17                	mov    (%edi),%edx
 4f6:	83 ec 0c             	sub    $0xc,%esp
 4f9:	6a 01                	push   $0x1
 4fb:	b9 0a 00 00 00       	mov    $0xa,%ecx
 500:	8b 45 08             	mov    0x8(%ebp),%eax
 503:	e8 ca fe ff ff       	call   3d2 <printint>
        ap++;
 508:	83 c7 04             	add    $0x4,%edi
 50b:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 50e:	83 c4 10             	add    $0x10,%esp
      state = 0;
 511:	be 00 00 00 00       	mov    $0x0,%esi
 516:	e9 63 ff ff ff       	jmp    47e <printf+0x2c>
        printint(fd, *ap, 16, 0);
 51b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 51e:	8b 17                	mov    (%edi),%edx
 520:	83 ec 0c             	sub    $0xc,%esp
 523:	6a 00                	push   $0x0
 525:	b9 10 00 00 00       	mov    $0x10,%ecx
 52a:	8b 45 08             	mov    0x8(%ebp),%eax
 52d:	e8 a0 fe ff ff       	call   3d2 <printint>
        ap++;
 532:	83 c7 04             	add    $0x4,%edi
 535:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 538:	83 c4 10             	add    $0x10,%esp
      state = 0;
 53b:	be 00 00 00 00       	mov    $0x0,%esi
 540:	e9 39 ff ff ff       	jmp    47e <printf+0x2c>
        s = (char*)*ap;
 545:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 548:	8b 30                	mov    (%eax),%esi
        ap++;
 54a:	83 c0 04             	add    $0x4,%eax
 54d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 550:	85 f6                	test   %esi,%esi
 552:	75 28                	jne    57c <printf+0x12a>
          s = "(null)";
 554:	be 68 07 00 00       	mov    $0x768,%esi
 559:	8b 7d 08             	mov    0x8(%ebp),%edi
 55c:	eb 0d                	jmp    56b <printf+0x119>
          putc(fd, *s);
 55e:	0f be d2             	movsbl %dl,%edx
 561:	89 f8                	mov    %edi,%eax
 563:	e8 50 fe ff ff       	call   3b8 <putc>
          s++;
 568:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 56b:	0f b6 16             	movzbl (%esi),%edx
 56e:	84 d2                	test   %dl,%dl
 570:	75 ec                	jne    55e <printf+0x10c>
      state = 0;
 572:	be 00 00 00 00       	mov    $0x0,%esi
 577:	e9 02 ff ff ff       	jmp    47e <printf+0x2c>
 57c:	8b 7d 08             	mov    0x8(%ebp),%edi
 57f:	eb ea                	jmp    56b <printf+0x119>
        putc(fd, *ap);
 581:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 584:	0f be 17             	movsbl (%edi),%edx
 587:	8b 45 08             	mov    0x8(%ebp),%eax
 58a:	e8 29 fe ff ff       	call   3b8 <putc>
        ap++;
 58f:	83 c7 04             	add    $0x4,%edi
 592:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 595:	be 00 00 00 00       	mov    $0x0,%esi
 59a:	e9 df fe ff ff       	jmp    47e <printf+0x2c>
        putc(fd, c);
 59f:	89 fa                	mov    %edi,%edx
 5a1:	8b 45 08             	mov    0x8(%ebp),%eax
 5a4:	e8 0f fe ff ff       	call   3b8 <putc>
      state = 0;
 5a9:	be 00 00 00 00       	mov    $0x0,%esi
 5ae:	e9 cb fe ff ff       	jmp    47e <printf+0x2c>
    }
  }
}
 5b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b6:	5b                   	pop    %ebx
 5b7:	5e                   	pop    %esi
 5b8:	5f                   	pop    %edi
 5b9:	5d                   	pop    %ebp
 5ba:	c3                   	ret    

000005bb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5bb:	55                   	push   %ebp
 5bc:	89 e5                	mov    %esp,%ebp
 5be:	57                   	push   %edi
 5bf:	56                   	push   %esi
 5c0:	53                   	push   %ebx
 5c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5c4:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c7:	a1 ac 0a 00 00       	mov    0xaac,%eax
 5cc:	eb 02                	jmp    5d0 <free+0x15>
 5ce:	89 d0                	mov    %edx,%eax
 5d0:	39 c8                	cmp    %ecx,%eax
 5d2:	73 04                	jae    5d8 <free+0x1d>
 5d4:	39 08                	cmp    %ecx,(%eax)
 5d6:	77 12                	ja     5ea <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5d8:	8b 10                	mov    (%eax),%edx
 5da:	39 c2                	cmp    %eax,%edx
 5dc:	77 f0                	ja     5ce <free+0x13>
 5de:	39 c8                	cmp    %ecx,%eax
 5e0:	72 08                	jb     5ea <free+0x2f>
 5e2:	39 ca                	cmp    %ecx,%edx
 5e4:	77 04                	ja     5ea <free+0x2f>
 5e6:	89 d0                	mov    %edx,%eax
 5e8:	eb e6                	jmp    5d0 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5ea:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5ed:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5f0:	8b 10                	mov    (%eax),%edx
 5f2:	39 d7                	cmp    %edx,%edi
 5f4:	74 19                	je     60f <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5f6:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5f9:	8b 50 04             	mov    0x4(%eax),%edx
 5fc:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5ff:	39 ce                	cmp    %ecx,%esi
 601:	74 1b                	je     61e <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 603:	89 08                	mov    %ecx,(%eax)
  freep = p;
 605:	a3 ac 0a 00 00       	mov    %eax,0xaac
}
 60a:	5b                   	pop    %ebx
 60b:	5e                   	pop    %esi
 60c:	5f                   	pop    %edi
 60d:	5d                   	pop    %ebp
 60e:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 60f:	03 72 04             	add    0x4(%edx),%esi
 612:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 615:	8b 10                	mov    (%eax),%edx
 617:	8b 12                	mov    (%edx),%edx
 619:	89 53 f8             	mov    %edx,-0x8(%ebx)
 61c:	eb db                	jmp    5f9 <free+0x3e>
    p->s.size += bp->s.size;
 61e:	03 53 fc             	add    -0x4(%ebx),%edx
 621:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 624:	8b 53 f8             	mov    -0x8(%ebx),%edx
 627:	89 10                	mov    %edx,(%eax)
 629:	eb da                	jmp    605 <free+0x4a>

0000062b <morecore>:

static Header*
morecore(uint nu)
{
 62b:	55                   	push   %ebp
 62c:	89 e5                	mov    %esp,%ebp
 62e:	53                   	push   %ebx
 62f:	83 ec 04             	sub    $0x4,%esp
 632:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 634:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 639:	77 05                	ja     640 <morecore+0x15>
    nu = 4096;
 63b:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 640:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 647:	83 ec 0c             	sub    $0xc,%esp
 64a:	50                   	push   %eax
 64b:	e8 30 fd ff ff       	call   380 <sbrk>
  if(p == (char*)-1)
 650:	83 c4 10             	add    $0x10,%esp
 653:	83 f8 ff             	cmp    $0xffffffff,%eax
 656:	74 1c                	je     674 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 658:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 65b:	83 c0 08             	add    $0x8,%eax
 65e:	83 ec 0c             	sub    $0xc,%esp
 661:	50                   	push   %eax
 662:	e8 54 ff ff ff       	call   5bb <free>
  return freep;
 667:	a1 ac 0a 00 00       	mov    0xaac,%eax
 66c:	83 c4 10             	add    $0x10,%esp
}
 66f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 672:	c9                   	leave  
 673:	c3                   	ret    
    return 0;
 674:	b8 00 00 00 00       	mov    $0x0,%eax
 679:	eb f4                	jmp    66f <morecore+0x44>

0000067b <malloc>:

void*
malloc(uint nbytes)
{
 67b:	55                   	push   %ebp
 67c:	89 e5                	mov    %esp,%ebp
 67e:	53                   	push   %ebx
 67f:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 682:	8b 45 08             	mov    0x8(%ebp),%eax
 685:	8d 58 07             	lea    0x7(%eax),%ebx
 688:	c1 eb 03             	shr    $0x3,%ebx
 68b:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 68e:	8b 0d ac 0a 00 00    	mov    0xaac,%ecx
 694:	85 c9                	test   %ecx,%ecx
 696:	74 04                	je     69c <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 698:	8b 01                	mov    (%ecx),%eax
 69a:	eb 4d                	jmp    6e9 <malloc+0x6e>
    base.s.ptr = freep = prevp = &base;
 69c:	c7 05 ac 0a 00 00 b0 	movl   $0xab0,0xaac
 6a3:	0a 00 00 
 6a6:	c7 05 b0 0a 00 00 b0 	movl   $0xab0,0xab0
 6ad:	0a 00 00 
    base.s.size = 0;
 6b0:	c7 05 b4 0a 00 00 00 	movl   $0x0,0xab4
 6b7:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 6ba:	b9 b0 0a 00 00       	mov    $0xab0,%ecx
 6bf:	eb d7                	jmp    698 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 6c1:	39 da                	cmp    %ebx,%edx
 6c3:	74 1a                	je     6df <malloc+0x64>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6c5:	29 da                	sub    %ebx,%edx
 6c7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 6ca:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 6cd:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 6d0:	89 0d ac 0a 00 00    	mov    %ecx,0xaac
      return (void*)(p + 1);
 6d6:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6d9:	83 c4 04             	add    $0x4,%esp
 6dc:	5b                   	pop    %ebx
 6dd:	5d                   	pop    %ebp
 6de:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 6df:	8b 10                	mov    (%eax),%edx
 6e1:	89 11                	mov    %edx,(%ecx)
 6e3:	eb eb                	jmp    6d0 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e5:	89 c1                	mov    %eax,%ecx
 6e7:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 6e9:	8b 50 04             	mov    0x4(%eax),%edx
 6ec:	39 da                	cmp    %ebx,%edx
 6ee:	73 d1                	jae    6c1 <malloc+0x46>
    if(p == freep)
 6f0:	39 05 ac 0a 00 00    	cmp    %eax,0xaac
 6f6:	75 ed                	jne    6e5 <malloc+0x6a>
      if((p = morecore(nunits)) == 0)
 6f8:	89 d8                	mov    %ebx,%eax
 6fa:	e8 2c ff ff ff       	call   62b <morecore>
 6ff:	85 c0                	test   %eax,%eax
 701:	75 e2                	jne    6e5 <malloc+0x6a>
        return 0;
 703:	b8 00 00 00 00       	mov    $0x0,%eax
 708:	eb cf                	jmp    6d9 <malloc+0x5e>

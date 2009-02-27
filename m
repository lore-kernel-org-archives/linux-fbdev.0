From: "Bender aka Sergei S." <bender.rodriguez@open.by>
Subject: Re: [Bugme-new] [Bug 12712] New: s2disk hangs
	with nvidiafb
Date: Fri, 27 Feb 2009 09:55:49 +0200
Message-ID: <1193034780.20090227095549@open.by>
References: <web-46440394@post.open.by>
	<20090222150504.a77dc9b3.krzysztof.h1@poczta.fm>
Reply-To: Bender <bender.rodriguez@open.by>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------FE631EFA288244"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bender.rodriguez@open.by>) id 1LcxYZ-0006dM-WA
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Feb 2009 07:54:51 +0000
Received: from mail.open.by ([193.232.92.17] helo=post.open.by)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LcxYT-0002hU-0S for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Feb 2009 07:54:51 +0000
In-Reply-To: <20090222150504.a77dc9b3.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org

------------FE631EFA288244
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable

Hello.
Sorry, I've been a bit busy. So, back to the s2disk problem.

For 2.6.29-rc6-git1 strace s2disk shows:
------------------------------------------------------
execve("/usr/sbin/s2disk", ["s2disk"], [/* 37 vars */]) =3D 0
brk(0)                                  =3D 0x8e9f000
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0xb7fad000
access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D77137, ...}) =3D 0
mmap2(NULL, 77137, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0xb7f9a000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/liblzo2.so.2", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320#\0\0004\0\0\0\=
24"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D124924, ...}) =3D 0
mmap2(NULL, 127840, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0xb7f7a000
mmap2(0xb7f99000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DEN=
YWRITE, 3, 0x1e) =3D 0xb7f99000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libgcrypt.so.11", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240D\0\0004\0\0\0\=
314"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D425220, ...}) =3D 0
mmap2(NULL, 424676, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0xb7f12000
mmap2(0xb7f78000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DEN=
YWRITE, 3, 0x66) =3D 0xb7f78000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/lib/libsplashy.so.1", O_RDONLY)  =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\17\0\0004\0\0\=
0004"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D18716, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0xb7f11000
mmap2(NULL, 21828, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0xb7f0b000
mmap2(0xb7f10000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DEN=
YWRITE, 3, 0x4) =3D 0xb7f10000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/lib/libgcc_s.so.1", O_RDONLY)    =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\34\0\0004\0\0\=
0\254"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D50916, ...}) =3D 0
mmap2(NULL, 49928, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0xb7efe000
mmap2(0xb7f0a000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DEN=
YWRITE, 3, 0xc) =3D 0xb7f0a000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/lib/i686/cmov/libc.so.6", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260e\1\0004\0\0\0\=
4"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D1413540, ...}) =3D 0
mmap2(NULL, 1418864, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0xb7da3000
mmap2(0xb7ef8000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DE=
NYWRITE, 3, 0x155) =3D 0xb7ef8000
mmap2(0xb7efb000, 9840, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANO=
NYMOUS, -1, 0) =3D 0xb7efb000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libgpg-error.so.0", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\6\0\0004\0\0\0=
\214"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D11556, ...}) =3D 0
mmap2(NULL, 14568, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0xb7d9f000
mmap2(0xb7da2000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DEN=
YWRITE, 3, 0x2) =3D 0xb7da2000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libglib-2.0.so.0", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\25\1\0004\0\0\=
0\24"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D736588, ...}) =3D 0
mmap2(NULL, 740420, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0xb7cea000
mmap2(0xb7d9e000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DEN=
YWRITE, 3, 0xb3) =3D 0xb7d9e000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/lib/libsplashycnf.so.1", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \v\0\0004\0\0\0P".=
.., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D7696, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0xb7ce9000
mmap2(NULL, 10684, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0xb7ce6000
mmap2(0xb7ce8000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DEN=
YWRITE, 3, 0x1) =3D 0xb7ce8000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libdirectfb-1.0.so.0", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\274\0\0004\0\0\0\=
314"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D421300, ...}) =3D 0
mmap2(NULL, 421540, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0xb7c7f000
mmap2(0xb7ce4000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DEN=
YWRITE, 3, 0x65) =3D 0xb7ce4000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libpcre.so.3", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260\17\0\0004\0\0\=
0@"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D162088, ...}) =3D 0
mmap2(NULL, 164984, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0xb7c56000
mmap2(0xb7c7e000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DEN=
YWRITE, 3, 0x27) =3D 0xb7c7e000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libdirect-1.0.so.0", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2602\0\0004\0\0\0t=
"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D76932, ...}) =3D 0
mmap2(NULL, 81836, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0xb7c42000
mmap2(0xb7c55000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DEN=
YWRITE, 3, 0x12) =3D 0xb7c55000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libfusion-1.0.so.0", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20$\0\0004\0\0\0\3=
70"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D28344, ...}) =3D 0
mmap2(NULL, 31328, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0xb7c3a000
mmap2(0xb7c41000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DEN=
YWRITE, 3, 0x6) =3D 0xb7c41000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/lib/i686/cmov/libdl.so.2", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\n\0\0004\0\0\0H".=
.., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D9680, ...}) =3D 0
mmap2(NULL, 12412, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0xb7c36000
mmap2(0xb7c38000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DEN=
YWRITE, 3, 0x1) =3D 0xb7c38000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/lib/i686/cmov/libpthread.so.0", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000H\0\0004\0\0\0\3=
30"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D116414, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0xb7c35000
mmap2(NULL, 98784, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
=3D 0xb7c1c000
mmap2(0xb7c31000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DEN=
YWRITE, 3, 0x14) =3D 0xb7c31000
mmap2(0xb7c33000, 4576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANO=
NYMOUS, -1, 0) =3D 0xb7c33000
close(3)                                =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0xb7c1b000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7c1b6b0, limit:1048575,=
 seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_prese=
nt:0, useable:1}) =3D 0
mprotect(0xb7ef8000, 4096, PROT_READ)   =3D 0
munmap(0xb7f9a000, 77137)               =3D 0
set_tid_address(0xb7c1b6f8)             =3D 3293
set_robust_list(0xb7c1b700, 0xc)        =3D 0
futex(0xbfcc9770, FUTEX_WAKE_PRIVATE, 1) =3D 0
rt_sigaction(SIGRTMIN, {0xb7c202e0, [], SA_SIGINFO}, NULL, 8) =3D 0
rt_sigaction(SIGRT_1, {0xb7c20720, [], SA_RESTART|SA_SIGINFO}, NULL, 8) =3D=
 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) =3D 0
getrlimit(RLIMIT_STACK, {rlim_cur=3D8192*1024, rlim_max=3DRLIM_INFINITY}) =
=3D 0
uname({sys=3D"Linux", node=3D"swordfish", ...}) =3D 0
brk(0)                                  =3D 0x8e9f000
brk(0x8ec0000)                          =3D 0x8ec0000
open("/dev/null", O_RDWR)               =3D 3
close(3)                                =3D 0
stat64("/etc/uswsusp.conf", {st_mode=3DS_IFREG|0644, st_size=3D204, ...}) =
=3D 0
open("/etc/uswsusp.conf", O_RDONLY)     =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D204, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0xb7fac000
read(3, "# /etc/uswsusp.conf(8) -- Configu"..., 4096) =3D 204
read(3, ""..., 4096)                    =3D 0
close(3)                                =3D 0
munmap(0xb7fac000, 4096)                =3D 0
mmap2(NULL, 212992, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)=
 =3D 0xb7be7000
mlockall(MCL_CURRENT|MCL_FUTURE)        =3D 0
mount("none", "/proc/3293", "tmpfs", 0, NULL) =3D 0
stat64("/dev/sda5", {st_mode=3DS_IFBLK|0660, st_rdev=3Dmakedev(8, 5), ...})=
 =3D 0
chdir("/proc/3293")                     =3D 0
mknod("resume", S_IFBLK|0600, makedev(8, 5)) =3D 0
open("resume", O_RDWR)                  =3D 3
stat64("/dev/snapshot", {st_mode=3DS_IFCHR|0660, st_rdev=3Dmakedev(10, 231)=
, ...}) =3D 0
open("/dev/snapshot", O_RDONLY)         =3D 4
ioctl(4, 0x400c330d, 0xbfcc9714)        =3D 0
open("/dev/console", O_RDONLY)          =3D 5
ioctl(5, KDGKBTYPE, 0xbfcc9748)         =3D 0
ioctl(5, TIOCLINUX, 0xbfcc9766)         =3D 0
ioctl(5, VT_GETSTATE, 0xbfcc973e)       =3D 0
ioctl(5, VIDIOC_QUERYCAP or VT_OPENQRY, 0xbfcc9744) =3D 0
close(5)                                =3D 0
open("/dev/tty8", O_RDWR)               =3D 5
ioctl(5, VIDIOC_G_COMP or VT_ACTIVATE, 0x8) =3D 0
ioctl(5, VIDIOC_S_COMP or VT_WAITACTIVE



drivers/char/vt_ioctl.c

int vt_ioctl(struct tty_struct *tty, struct file * file,
             unsigned int cmd, unsigned long arg)
...
case VT_WAITACTIVE:
                if (!perm)
                        goto eperm;
                if (arg =3D=3D 0 || arg > MAX_NR_CONSOLES)
                        ret =3D -ENXIO;
                else
                        ret =3D vt_waitactive(arg - 1);
                break;


"Never" returns:
int vt_waitactive(int vt)
{
        int retval;
        DECLARE_WAITQUEUE(wait, current);

        add_wait_queue(&vt_activate_queue, &wait);
        for (;;) {
                retval =3D 0;

                /*
                 * Synchronize with redraw_screen(). By acquiring the conso=
le
                 * semaphore we make sure that the console switch is comple=
ted
                 * before we return. If we didn't wait for the semaphore, we
                 * could return at a point where fg_console has already been
                 * updated, but the console switch hasn't been completed.
                 */
                acquire_console_sem();
                set_current_state(TASK_INTERRUPTIBLE);
                if (vt =3D=3D fg_console) {
                        release_console_sem();
                        break;
                }
                release_console_sem();
                retval =3D -ERESTARTNOHAND;
                if (signal_pending(current))
                        break;

                schedule();
                ^^^^^^^^^^^
        }
        remove_wait_queue(&vt_activate_queue, &wait);
        __set_current_state(TASK_RUNNING);
        return retval;
}


Best regards,
Sergey.

------------FE631EFA288244
Content-Type: application/octet-stream;
 name=_strace_vn_29
Content-transfer-encoding: base64
Content-Disposition: attachment;
 filename=_strace_vn_29

ZXhlY3ZlKCIvdXNyL3NiaW4vczJkaXNrIiwgWyJzMmRpc2siXSwgWy8qIDM3IHZhcnMgKi9d
KSA9IDAKYnJrKDApICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMHg4ZTlm
MDAwCmFjY2VzcygiL2V0Yy9sZC5zby5ub2h3Y2FwIiwgRl9PSykgICAgICA9IC0xIEVOT0VO
VCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKbW1hcDIoTlVMTCwgODE5MiwgUFJPVF9S
RUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9BTk9OWU1PVVMsIC0xLCAwKSA9IDB4
YjdmYWQwMDAKYWNjZXNzKCIvZXRjL2xkLnNvLnByZWxvYWQiLCBSX09LKSAgICAgID0gLTEg
RU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIvZXRjL2xkLnNvLmNh
Y2hlIiwgT19SRE9OTFkpICAgICAgPSAzCmZzdGF0NjQoMywge3N0X21vZGU9U19JRlJFR3ww
NjQ0LCBzdF9zaXplPTc3MTM3LCAuLi59KSA9IDAKbW1hcDIoTlVMTCwgNzcxMzcsIFBST1Rf
UkVBRCwgTUFQX1BSSVZBVEUsIDMsIDApID0gMHhiN2Y5YTAwMApjbG9zZSgzKSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgPSAwCmFjY2VzcygiL2V0Yy9sZC5zby5ub2h3Y2Fw
IiwgRl9PSykgICAgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkK
b3BlbigiL3Vzci9saWIvbGlibHpvMi5zby4yIiwgT19SRE9OTFkpID0gMwpyZWFkKDMsICJc
MTc3RUxGXDFcMVwxXDBcMFwwXDBcMFwwXDBcMFwwXDNcMFwzXDBcMVwwXDBcMFwzMjAjXDBc
MDAwNFwwXDBcMFwyNCIuLi4sIDUxMikgPSA1MTIKZnN0YXQ2NCgzLCB7c3RfbW9kZT1TX0lG
UkVHfDA2NDQsIHN0X3NpemU9MTI0OTI0LCAuLi59KSA9IDAKbW1hcDIoTlVMTCwgMTI3ODQw
LCBQUk9UX1JFQUR8UFJPVF9FWEVDLCBNQVBfUFJJVkFURXxNQVBfREVOWVdSSVRFLCAzLCAw
KSA9IDB4YjdmN2EwMDAKbW1hcDIoMHhiN2Y5OTAwMCwgNDA5NiwgUFJPVF9SRUFEfFBST1Rf
V1JJVEUsIE1BUF9QUklWQVRFfE1BUF9GSVhFRHxNQVBfREVOWVdSSVRFLCAzLCAweDFlKSA9
IDB4YjdmOTkwMDAKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0g
MAphY2Nlc3MoIi9ldGMvbGQuc28ubm9od2NhcCIsIEZfT0spICAgICAgPSAtMSBFTk9FTlQg
KE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi91c3IvbGliL2xpYmdjcnlwdC5z
by4xMSIsIE9fUkRPTkxZKSA9IDMKcmVhZCgzLCAiXDE3N0VMRlwxXDFcMVwwXDBcMFwwXDBc
MFwwXDBcMFwzXDBcM1wwXDFcMFwwXDBcMjQwRFwwXDAwMDRcMFwwXDBcMzE0Ii4uLiwgNTEy
KSA9IDUxMgpmc3RhdDY0KDMsIHtzdF9tb2RlPVNfSUZSRUd8MDY0NCwgc3Rfc2l6ZT00MjUy
MjAsIC4uLn0pID0gMAptbWFwMihOVUxMLCA0MjQ2NzYsIFBST1RfUkVBRHxQUk9UX0VYRUMs
IE1BUF9QUklWQVRFfE1BUF9ERU5ZV1JJVEUsIDMsIDApID0gMHhiN2YxMjAwMAptbWFwMigw
eGI3Zjc4MDAwLCA4MTkyLCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQ
X0ZJWEVEfE1BUF9ERU5ZV1JJVEUsIDMsIDB4NjYpID0gMHhiN2Y3ODAwMApjbG9zZSgzKSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCmFjY2VzcygiL2V0Yy9sZC5zby5u
b2h3Y2FwIiwgRl9PSykgICAgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVj
dG9yeSkKb3BlbigiL2xpYi9saWJzcGxhc2h5LnNvLjEiLCBPX1JET05MWSkgID0gMwpyZWFk
KDMsICJcMTc3RUxGXDFcMVwxXDBcMFwwXDBcMFwwXDBcMFwwXDNcMFwzXDBcMVwwXDBcMFwz
MDBcMTdcMFwwMDA0XDBcMFwwMDA0Ii4uLiwgNTEyKSA9IDUxMgpmc3RhdDY0KDMsIHtzdF9t
b2RlPVNfSUZSRUd8MDY0NCwgc3Rfc2l6ZT0xODcxNiwgLi4ufSkgPSAwCm1tYXAyKE5VTEws
IDQwOTYsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VT
LCAtMSwgMCkgPSAweGI3ZjExMDAwCm1tYXAyKE5VTEwsIDIxODI4LCBQUk9UX1JFQUR8UFJP
VF9FWEVDLCBNQVBfUFJJVkFURXxNQVBfREVOWVdSSVRFLCAzLCAwKSA9IDB4YjdmMGIwMDAK
bW1hcDIoMHhiN2YxMDAwMCwgNDA5NiwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklW
QVRFfE1BUF9GSVhFRHxNQVBfREVOWVdSSVRFLCAzLCAweDQpID0gMHhiN2YxMDAwMApjbG9z
ZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCmFjY2VzcygiL2V0Yy9s
ZC5zby5ub2h3Y2FwIiwgRl9PSykgICAgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9y
IGRpcmVjdG9yeSkKb3BlbigiL2xpYi9saWJnY2Nfcy5zby4xIiwgT19SRE9OTFkpICAgID0g
MwpyZWFkKDMsICJcMTc3RUxGXDFcMVwxXDBcMFwwXDBcMFwwXDBcMFwwXDNcMFwzXDBcMVww
XDBcMFwyMjBcMzRcMFwwMDA0XDBcMFwwXDI1NCIuLi4sIDUxMikgPSA1MTIKZnN0YXQ2NCgz
LCB7c3RfbW9kZT1TX0lGUkVHfDA2NDQsIHN0X3NpemU9NTA5MTYsIC4uLn0pID0gMAptbWFw
MihOVUxMLCA0OTkyOCwgUFJPVF9SRUFEfFBST1RfRVhFQywgTUFQX1BSSVZBVEV8TUFQX0RF
TllXUklURSwgMywgMCkgPSAweGI3ZWZlMDAwCm1tYXAyKDB4YjdmMGEwMDAsIDQwOTYsIFBS
T1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfRklYRUR8TUFQX0RFTllXUklU
RSwgMywgMHhjKSA9IDB4YjdmMGEwMDAKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgID0gMAphY2Nlc3MoIi9ldGMvbGQuc28ubm9od2NhcCIsIEZfT0spICAgICAg
PSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9saWIvaTY4
Ni9jbW92L2xpYmMuc28uNiIsIE9fUkRPTkxZKSA9IDMKcmVhZCgzLCAiXDE3N0VMRlwxXDFc
MVwwXDBcMFwwXDBcMFwwXDBcMFwzXDBcM1wwXDFcMFwwXDBcMjYwZVwxXDAwMDRcMFwwXDBc
NCIuLi4sIDUxMikgPSA1MTIKZnN0YXQ2NCgzLCB7c3RfbW9kZT1TX0lGUkVHfDA3NTUsIHN0
X3NpemU9MTQxMzU0MCwgLi4ufSkgPSAwCm1tYXAyKE5VTEwsIDE0MTg4NjQsIFBST1RfUkVB
RHxQUk9UX0VYRUMsIE1BUF9QUklWQVRFfE1BUF9ERU5ZV1JJVEUsIDMsIDApID0gMHhiN2Rh
MzAwMAptbWFwMigweGI3ZWY4MDAwLCAxMjI4OCwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1B
UF9QUklWQVRFfE1BUF9GSVhFRHxNQVBfREVOWVdSSVRFLCAzLCAweDE1NSkgPSAweGI3ZWY4
MDAwCm1tYXAyKDB4YjdlZmIwMDAsIDk4NDAsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBf
UFJJVkFURXxNQVBfRklYRUR8TUFQX0FOT05ZTU9VUywgLTEsIDApID0gMHhiN2VmYjAwMApj
bG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCmFjY2VzcygiL2V0
Yy9sZC5zby5ub2h3Y2FwIiwgRl9PSykgICAgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxl
IG9yIGRpcmVjdG9yeSkKb3BlbigiL3Vzci9saWIvbGliZ3BnLWVycm9yLnNvLjAiLCBPX1JE
T05MWSkgPSAzCnJlYWQoMywgIlwxNzdFTEZcMVwxXDFcMFwwXDBcMFwwXDBcMFwwXDBcM1ww
XDNcMFwxXDBcMFwwXDIyMFw2XDBcMDAwNFwwXDBcMFwyMTQiLi4uLCA1MTIpID0gNTEyCmZz
dGF0NjQoMywge3N0X21vZGU9U19JRlJFR3wwNjQ0LCBzdF9zaXplPTExNTU2LCAuLi59KSA9
IDAKbW1hcDIoTlVMTCwgMTQ1NjgsIFBST1RfUkVBRHxQUk9UX0VYRUMsIE1BUF9QUklWQVRF
fE1BUF9ERU5ZV1JJVEUsIDMsIDApID0gMHhiN2Q5ZjAwMAptbWFwMigweGI3ZGEyMDAwLCA0
MDk2LCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0ZJWEVEfE1BUF9E
RU5ZV1JJVEUsIDMsIDB4MikgPSAweGI3ZGEyMDAwCmNsb3NlKDMpICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA9IDAKYWNjZXNzKCIvZXRjL2xkLnNvLm5vaHdjYXAiLCBGX09L
KSAgICAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIv
dXNyL2xpYi9saWJnbGliLTIuMC5zby4wIiwgT19SRE9OTFkpID0gMwpyZWFkKDMsICJcMTc3
RUxGXDFcMVwxXDBcMFwwXDBcMFwwXDBcMFwwXDNcMFwzXDBcMVwwXDBcMFwzNDBcMjVcMVww
MDA0XDBcMFwwXDI0Ii4uLiwgNTEyKSA9IDUxMgpmc3RhdDY0KDMsIHtzdF9tb2RlPVNfSUZS
RUd8MDY0NCwgc3Rfc2l6ZT03MzY1ODgsIC4uLn0pID0gMAptbWFwMihOVUxMLCA3NDA0MjAs
IFBST1RfUkVBRHxQUk9UX0VYRUMsIE1BUF9QUklWQVRFfE1BUF9ERU5ZV1JJVEUsIDMsIDAp
ID0gMHhiN2NlYTAwMAptbWFwMigweGI3ZDllMDAwLCA0MDk2LCBQUk9UX1JFQUR8UFJPVF9X
UklURSwgTUFQX1BSSVZBVEV8TUFQX0ZJWEVEfE1BUF9ERU5ZV1JJVEUsIDMsIDB4YjMpID0g
MHhiN2Q5ZTAwMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAw
CmFjY2VzcygiL2V0Yy9sZC5zby5ub2h3Y2FwIiwgRl9PSykgICAgICA9IC0xIEVOT0VOVCAo
Tm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3BlbigiL2xpYi9saWJzcGxhc2h5Y25mLnNv
LjEiLCBPX1JET05MWSkgPSAzCnJlYWQoMywgIlwxNzdFTEZcMVwxXDFcMFwwXDBcMFwwXDBc
MFwwXDBcM1wwXDNcMFwxXDBcMFwwIFx2XDBcMDAwNFwwXDBcMFAiLi4uLCA1MTIpID0gNTEy
CmZzdGF0NjQoMywge3N0X21vZGU9U19JRlJFR3wwNjQ0LCBzdF9zaXplPTc2OTYsIC4uLn0p
ID0gMAptbWFwMihOVUxMLCA0MDk2LCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZB
VEV8TUFQX0FOT05ZTU9VUywgLTEsIDApID0gMHhiN2NlOTAwMAptbWFwMihOVUxMLCAxMDY4
NCwgUFJPVF9SRUFEfFBST1RfRVhFQywgTUFQX1BSSVZBVEV8TUFQX0RFTllXUklURSwgMywg
MCkgPSAweGI3Y2U2MDAwCm1tYXAyKDB4YjdjZTgwMDAsIDQwOTYsIFBST1RfUkVBRHxQUk9U
X1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfRklYRUR8TUFQX0RFTllXUklURSwgMywgMHgxKSA9
IDB4YjdjZTgwMDAKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0g
MAphY2Nlc3MoIi9ldGMvbGQuc28ubm9od2NhcCIsIEZfT0spICAgICAgPSAtMSBFTk9FTlQg
KE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi91c3IvbGliL2xpYmRpcmVjdGZi
LTEuMC5zby4wIiwgT19SRE9OTFkpID0gMwpyZWFkKDMsICJcMTc3RUxGXDFcMVwxXDBcMFww
XDBcMFwwXDBcMFwwXDNcMFwzXDBcMVwwXDBcMFBcMjc0XDBcMDAwNFwwXDBcMFwzMTQiLi4u
LCA1MTIpID0gNTEyCmZzdGF0NjQoMywge3N0X21vZGU9U19JRlJFR3wwNjQ0LCBzdF9zaXpl
PTQyMTMwMCwgLi4ufSkgPSAwCm1tYXAyKE5VTEwsIDQyMTU0MCwgUFJPVF9SRUFEfFBST1Rf
RVhFQywgTUFQX1BSSVZBVEV8TUFQX0RFTllXUklURSwgMywgMCkgPSAweGI3YzdmMDAwCm1t
YXAyKDB4YjdjZTQwMDAsIDgxOTIsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFU
RXxNQVBfRklYRUR8TUFQX0RFTllXUklURSwgMywgMHg2NSkgPSAweGI3Y2U0MDAwCmNsb3Nl
KDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKYWNjZXNzKCIvZXRjL2xk
LnNvLm5vaHdjYXAiLCBGX09LKSAgICAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3Ig
ZGlyZWN0b3J5KQpvcGVuKCIvdXNyL2xpYi9saWJwY3JlLnNvLjMiLCBPX1JET05MWSkgPSAz
CnJlYWQoMywgIlwxNzdFTEZcMVwxXDFcMFwwXDBcMFwwXDBcMFwwXDBcM1wwXDNcMFwxXDBc
MFwwXDI2MFwxN1wwXDAwMDRcMFwwXDBAIi4uLiwgNTEyKSA9IDUxMgpmc3RhdDY0KDMsIHtz
dF9tb2RlPVNfSUZSRUd8MDY0NCwgc3Rfc2l6ZT0xNjIwODgsIC4uLn0pID0gMAptbWFwMihO
VUxMLCAxNjQ5ODQsIFBST1RfUkVBRHxQUk9UX0VYRUMsIE1BUF9QUklWQVRFfE1BUF9ERU5Z
V1JJVEUsIDMsIDApID0gMHhiN2M1NjAwMAptbWFwMigweGI3YzdlMDAwLCA0MDk2LCBQUk9U
X1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0ZJWEVEfE1BUF9ERU5ZV1JJVEUs
IDMsIDB4MjcpID0gMHhiN2M3ZTAwMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgPSAwCmFjY2VzcygiL2V0Yy9sZC5zby5ub2h3Y2FwIiwgRl9PSykgICAgICA9
IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3BlbigiL3Vzci9saWIv
bGliZGlyZWN0LTEuMC5zby4wIiwgT19SRE9OTFkpID0gMwpyZWFkKDMsICJcMTc3RUxGXDFc
MVwxXDBcMFwwXDBcMFwwXDBcMFwwXDNcMFwzXDBcMVwwXDBcMFwyNjAyXDBcMDAwNFwwXDBc
MHQiLi4uLCA1MTIpID0gNTEyCmZzdGF0NjQoMywge3N0X21vZGU9U19JRlJFR3wwNjQ0LCBz
dF9zaXplPTc2OTMyLCAuLi59KSA9IDAKbW1hcDIoTlVMTCwgODE4MzYsIFBST1RfUkVBRHxQ
Uk9UX0VYRUMsIE1BUF9QUklWQVRFfE1BUF9ERU5ZV1JJVEUsIDMsIDApID0gMHhiN2M0MjAw
MAptbWFwMigweGI3YzU1MDAwLCA0MDk2LCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BS
SVZBVEV8TUFQX0ZJWEVEfE1BUF9ERU5ZV1JJVEUsIDMsIDB4MTIpID0gMHhiN2M1NTAwMApj
bG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCmFjY2VzcygiL2V0
Yy9sZC5zby5ub2h3Y2FwIiwgRl9PSykgICAgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxl
IG9yIGRpcmVjdG9yeSkKb3BlbigiL3Vzci9saWIvbGliZnVzaW9uLTEuMC5zby4wIiwgT19S
RE9OTFkpID0gMwpyZWFkKDMsICJcMTc3RUxGXDFcMVwxXDBcMFwwXDBcMFwwXDBcMFwwXDNc
MFwzXDBcMVwwXDBcMFwyMCRcMFwwMDA0XDBcMFwwXDM3MCIuLi4sIDUxMikgPSA1MTIKZnN0
YXQ2NCgzLCB7c3RfbW9kZT1TX0lGUkVHfDA2NDQsIHN0X3NpemU9MjgzNDQsIC4uLn0pID0g
MAptbWFwMihOVUxMLCAzMTMyOCwgUFJPVF9SRUFEfFBST1RfRVhFQywgTUFQX1BSSVZBVEV8
TUFQX0RFTllXUklURSwgMywgMCkgPSAweGI3YzNhMDAwCm1tYXAyKDB4YjdjNDEwMDAsIDQw
OTYsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfRklYRUR8TUFQX0RF
TllXUklURSwgMywgMHg2KSA9IDB4YjdjNDEwMDAKY2xvc2UoMykgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgID0gMAphY2Nlc3MoIi9ldGMvbGQuc28ubm9od2NhcCIsIEZfT0sp
ICAgICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9s
aWIvaTY4Ni9jbW92L2xpYmRsLnNvLjIiLCBPX1JET05MWSkgPSAzCnJlYWQoMywgIlwxNzdF
TEZcMVwxXDFcMFwwXDBcMFwwXDBcMFwwXDBcM1wwXDNcMFwxXDBcMFwwYFxuXDBcMDAwNFww
XDBcMEgiLi4uLCA1MTIpID0gNTEyCmZzdGF0NjQoMywge3N0X21vZGU9U19JRlJFR3wwNjQ0
LCBzdF9zaXplPTk2ODAsIC4uLn0pID0gMAptbWFwMihOVUxMLCAxMjQxMiwgUFJPVF9SRUFE
fFBST1RfRVhFQywgTUFQX1BSSVZBVEV8TUFQX0RFTllXUklURSwgMywgMCkgPSAweGI3YzM2
MDAwCm1tYXAyKDB4YjdjMzgwMDAsIDgxOTIsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBf
UFJJVkFURXxNQVBfRklYRUR8TUFQX0RFTllXUklURSwgMywgMHgxKSA9IDB4YjdjMzgwMDAK
Y2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMAphY2Nlc3MoIi9l
dGMvbGQuc28ubm9od2NhcCIsIEZfT0spICAgICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmls
ZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9saWIvaTY4Ni9jbW92L2xpYnB0aHJlYWQuc28uMCIs
IE9fUkRPTkxZKSA9IDMKcmVhZCgzLCAiXDE3N0VMRlwxXDFcMVwwXDBcMFwwXDBcMFwwXDBc
MFwzXDBcM1wwXDFcMFwwXDAwMDBIXDBcMDAwNFwwXDBcMFwzMzAiLi4uLCA1MTIpID0gNTEy
CmZzdGF0NjQoMywge3N0X21vZGU9U19JRlJFR3wwNzU1LCBzdF9zaXplPTExNjQxNCwgLi4u
fSkgPSAwCm1tYXAyKE5VTEwsIDQwOTYsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJ
VkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCkgPSAweGI3YzM1MDAwCm1tYXAyKE5VTEwsIDk4
Nzg0LCBQUk9UX1JFQUR8UFJPVF9FWEVDLCBNQVBfUFJJVkFURXxNQVBfREVOWVdSSVRFLCAz
LCAwKSA9IDB4YjdjMWMwMDAKbW1hcDIoMHhiN2MzMTAwMCwgODE5MiwgUFJPVF9SRUFEfFBS
T1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9GSVhFRHxNQVBfREVOWVdSSVRFLCAzLCAweDE0
KSA9IDB4YjdjMzEwMDAKbW1hcDIoMHhiN2MzMzAwMCwgNDU3NiwgUFJPVF9SRUFEfFBST1Rf
V1JJVEUsIE1BUF9QUklWQVRFfE1BUF9GSVhFRHxNQVBfQU5PTllNT1VTLCAtMSwgMCkgPSAw
eGI3YzMzMDAwCmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAK
bW1hcDIoTlVMTCwgNDA5NiwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1B
UF9BTk9OWU1PVVMsIC0xLCAwKSA9IDB4YjdjMWIwMDAKc2V0X3RocmVhZF9hcmVhKHtlbnRy
eV9udW1iZXI6LTEgLT4gNiwgYmFzZV9hZGRyOjB4YjdjMWI2YjAsIGxpbWl0OjEwNDg1NzUs
IHNlZ18zMmJpdDoxLCBjb250ZW50czowLCByZWFkX2V4ZWNfb25seTowLCBsaW1pdF9pbl9w
YWdlczoxLCBzZWdfbm90X3ByZXNlbnQ6MCwgdXNlYWJsZToxfSkgPSAwCm1wcm90ZWN0KDB4
YjdlZjgwMDAsIDQwOTYsIFBST1RfUkVBRCkgICA9IDAKbXVubWFwKDB4YjdmOWEwMDAsIDc3
MTM3KSAgICAgICAgICAgICAgID0gMApzZXRfdGlkX2FkZHJlc3MoMHhiN2MxYjZmOCkgICAg
ICAgICAgICAgPSAzMjkzCnNldF9yb2J1c3RfbGlzdCgweGI3YzFiNzAwLCAweGMpICAgICAg
ICA9IDAKZnV0ZXgoMHhiZmNjOTc3MCwgRlVURVhfV0FLRV9QUklWQVRFLCAxKSA9IDAKcnRf
c2lnYWN0aW9uKFNJR1JUTUlOLCB7MHhiN2MyMDJlMCwgW10sIFNBX1NJR0lORk99LCBOVUxM
LCA4KSA9IDAKcnRfc2lnYWN0aW9uKFNJR1JUXzEsIHsweGI3YzIwNzIwLCBbXSwgU0FfUkVT
VEFSVHxTQV9TSUdJTkZPfSwgTlVMTCwgOCkgPSAwCnJ0X3NpZ3Byb2NtYXNrKFNJR19VTkJM
T0NLLCBbUlRNSU4gUlRfMV0sIE5VTEwsIDgpID0gMApnZXRybGltaXQoUkxJTUlUX1NUQUNL
LCB7cmxpbV9jdXI9ODE5MioxMDI0LCBybGltX21heD1STElNX0lORklOSVRZfSkgPSAwCnVu
YW1lKHtzeXM9IkxpbnV4Iiwgbm9kZT0ic3dvcmRmaXNoIiwgLi4ufSkgPSAwCmJyaygwKSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4OGU5ZjAwMApicmsoMHg4ZWMw
MDAwKSAgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDhlYzAwMDAKb3BlbigiL2Rldi9u
dWxsIiwgT19SRFdSKSAgICAgICAgICAgICAgID0gMwpjbG9zZSgzKSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgPSAwCnN0YXQ2NCgiL2V0Yy91c3dzdXNwLmNvbmYiLCB7c3Rf
bW9kZT1TX0lGUkVHfDA2NDQsIHN0X3NpemU9MjA0LCAuLi59KSA9IDAKb3BlbigiL2V0Yy91
c3dzdXNwLmNvbmYiLCBPX1JET05MWSkgICAgID0gMwpmc3RhdDY0KDMsIHtzdF9tb2RlPVNf
SUZSRUd8MDY0NCwgc3Rfc2l6ZT0yMDQsIC4uLn0pID0gMAptbWFwMihOVUxMLCA0MDk2LCBQ
Uk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9VUywgLTEsIDAp
ID0gMHhiN2ZhYzAwMApyZWFkKDMsICIjIC9ldGMvdXN3c3VzcC5jb25mKDgpIC0tIENvbmZp
Z3UiLi4uLCA0MDk2KSA9IDIwNApyZWFkKDMsICIiLi4uLCA0MDk2KSAgICAgICAgICAgICAg
ICAgICAgPSAwCmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAK
bXVubWFwKDB4YjdmYWMwMDAsIDQwOTYpICAgICAgICAgICAgICAgID0gMAptbWFwMihOVUxM
LCAyMTI5OTIsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfQU5PTllN
T1VTLCAtMSwgMCkgPSAweGI3YmU3MDAwCm1sb2NrYWxsKE1DTF9DVVJSRU5UfE1DTF9GVVRV
UkUpICAgICAgICA9IDAKbW91bnQoIm5vbmUiLCAiL3Byb2MvMzI5MyIsICJ0bXBmcyIsIDAs
IE5VTEwpID0gMApzdGF0NjQoIi9kZXYvc2RhNSIsIHtzdF9tb2RlPVNfSUZCTEt8MDY2MCwg
c3RfcmRldj1tYWtlZGV2KDgsIDUpLCAuLi59KSA9IDAKY2hkaXIoIi9wcm9jLzMyOTMiKSAg
ICAgICAgICAgICAgICAgICAgID0gMApta25vZCgicmVzdW1lIiwgU19JRkJMS3wwNjAwLCBt
YWtlZGV2KDgsIDUpKSA9IDAKb3BlbigicmVzdW1lIiwgT19SRFdSKSAgICAgICAgICAgICAg
ICAgID0gMwpzdGF0NjQoIi9kZXYvc25hcHNob3QiLCB7c3RfbW9kZT1TX0lGQ0hSfDA2NjAs
IHN0X3JkZXY9bWFrZWRldigxMCwgMjMxKSwgLi4ufSkgPSAwCm9wZW4oIi9kZXYvc25hcHNo
b3QiLCBPX1JET05MWSkgICAgICAgICA9IDQKaW9jdGwoNCwgMHg0MDBjMzMwZCwgMHhiZmNj
OTcxNCkgICAgICAgID0gMApvcGVuKCIvZGV2L2NvbnNvbGUiLCBPX1JET05MWSkgICAgICAg
ICAgPSA1CmlvY3RsKDUsIEtER0tCVFlQRSwgMHhiZmNjOTc0OCkgICAgICAgICA9IDAKaW9j
dGwoNSwgVElPQ0xJTlVYLCAweGJmY2M5NzY2KSAgICAgICAgID0gMAppb2N0bCg1LCBWVF9H
RVRTVEFURSwgMHhiZmNjOTczZSkgICAgICAgPSAwCmlvY3RsKDUsIFZJRElPQ19RVUVSWUNB
UCBvciBWVF9PUEVOUVJZLCAweGJmY2M5NzQ0KSA9IDAKY2xvc2UoNSkgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgID0gMApvcGVuKCIvZGV2L3R0eTgiLCBPX1JEV1IpICAgICAg
ICAgICAgICAgPSA1CmlvY3RsKDUsIFZJRElPQ19HX0NPTVAgb3IgVlRfQUNUSVZBVEUsIDB4
OCkgPSAwCmlvY3RsKDUsIFZJRElPQ19TX0NPTVAgb3IgVlRfV0FJVEFDVElWRQ==
------------FE631EFA288244
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
------------FE631EFA288244
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

------------FE631EFA288244--

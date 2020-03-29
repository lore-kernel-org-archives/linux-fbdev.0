From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 29 Mar 2020 00:37:23 +0000
Subject: framebuffer bug (Re: general protection fault in do_syscall_64)
Message-Id: <CALCETrVR_qcUPpi2=5QYUVu8VugouYcJ_j4R2jsG4QzggowGsA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000000000000960ee605a1ef4d4e@google.com>
In-Reply-To: <000000000000960ee605a1ef4d4e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: syzbot <syzbot+f9b2c53f55a9270fc778@syzkaller.appspotmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, syzkaller-bugs@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>

On Sat, Mar 28, 2020 at 12:34 PM syzbot
<syzbot+f9b2c53f55a9270fc778@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    69c5eea3 Merge branch 'parisc-5.6-2' of git://git.kernel.=
o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14d3517be00000
> kernel config:  https://syzkaller.appspot.com/x/.config?xJc76c43beddbd9
> dashboard link: https://syzkaller.appspot.com/bug?extid=F9b2c53f55a9270fc=
778
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-projec=
t/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15059d05e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e5d5a3e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f9b2c53f55a9270fc778@syzkaller.appspotmail.com

Hi framebuffer people-

Somewhere in the framebuffer code is a horrible bug that spews zeros
over kernel memory (including text, suggesting a *physical* memory
overrun).  My suspicion is that there is insufficient validation in
the ioctls that set font parameters.

Could someone who is actually familiar with this code take a look?

--Andy

>
> general protection fault, probably for non-canonical address 0x1ffffffff1=
215a85: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 7207 Comm: syz-executor045 Not tainted 5.6.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
> RIP: 0010:do_syscall_64+0x5f/0x1b0 arch/x86/entry/common.c:289
> Code: 48 c7 c7 28 d4 0a 89 e8 bf 5d b0 00 48 83 3d af 5b 0a 08 00 0f 84 5=
8 01 00 00 fb 66 0f 1f 44 00 00 65 48 8b 1c 25 c0 1d 02 00 <48> 00 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> RSP: 0018:ffffc90001617f28 EFLAGS: 00010282
> RAX: 1ffffffff1215a85 RBX: ffff888095530380 RCX: ffff888095530380
> RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff888095530bc4
> RBP: 0000000000000000 R08: ffffffff817a2210 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000023
> R13: dffffc0000000000 R14: ffffc90001617f58 R15: 0000000000000000
> FS:  0000000001333880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f87bf9aae78 CR3: 00000000a6a3f000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4454e1
> Code: 75 14 b8 23 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 64 1f fc ff c3 4=
8 83 ec 08 e8 9a 42 00 00 48 89 04 24 b8 23 00 00 00 0f 05 <48> 8b 3c 24 48=
 89 c2 e8 e3 42 00 00 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00007ffd72d164b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000023
> RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00000000004454e1
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffd72d164c0
> RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007ffd72d164e0 R11: 0000000000000293 R12: 0000000000000000
> R13: 00000000006dbc2c R14: 000000000000000a R15: 0000000000000000
> Modules linked in:
> ---[ end trace 3da67f82bf6bae14 ]---
> RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
> RIP: 0010:do_syscall_64+0x5f/0x1b0 arch/x86/entry/common.c:289
> Code: 48 c7 c7 28 d4 0a 89 e8 bf 5d b0 00 48 83 3d af 5b 0a 08 00 0f 84 5=
8 01 00 00 fb 66 0f 1f 44 00 00 65 48 8b 1c 25 c0 1d 02 00 <48> 00 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> RSP: 0018:ffffc90001617f28 EFLAGS: 00010282
> RAX: 1ffffffff1215a85 RBX: ffff888095530380 RCX: ffff888095530380
> RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff888095530bc4
> RBP: 0000000000000000 R08: ffffffff817a2210 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000023
> R13: dffffc0000000000 R14: ffffc90001617f58 R15: 0000000000000000
> FS:  0000000001333880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f87bf9aae78 CR3: 00000000a6a3f000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

From: syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>
Date: Fri, 08 May 2020 07:07:13 +0000
Subject: BUG: unable to handle kernel paging request in vga16fb_imageblit (2)
Message-Id: <00000000000086452c05a51da504@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+ydwtrmj_nXc3KNLW3YCE4BU_dOZnWRhkAC7wTXmrj5dXz6_Q@mail.gmail.com>
In-Reply-To: <CA+ydwtrmj_nXc3KNLW3YCE4BU_dOZnWRhkAC7wTXmrj5dXz6_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org, jani.nikula@intel.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com

Hello,

syzbot found the following crash on:

HEAD commit:    262f7a6b Merge tag 'for-5.7-rc3-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x786888100000
kernel config:  https://syzkaller.appspot.com/x/.config?x[075813ec8b93cd
dashboard link: https://syzkaller.appspot.com/bug?extid29e126cf461c4de3b3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffff8880ffca0e80
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD d401067 P4D d401067 PUD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 710 Comm: syz-executor.5 Not tainted 5.7.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:writeb arch/x86/include/asm/io.h:65 [inline]
RIP: 0010:vga_imageblit_expand drivers/video/fbdev/vga16fb.c:1168 [inline]
RIP: 0010:vga16fb_imageblit+0xa5b/0x2210 drivers/video/fbdev/vga16fb.c:1260
Code: 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 ee 59 ed fd 41 8b 47 14 48 8b 74 24 08 <88> 06 0f ae e8 8a 06 b8 05 00 00 00 ba ce 03 00 00 ee 48 c7 c2 18
RSP: 0000:ffffc90002ea71f0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000007 RCX: ffffc90014391000
RDX: 0000000000000000 RSI: ffff8880ffca0e80 RDI: ffffc90002ea739c
RBP: ffffc90002ea738c R08: ffff8880922ac200 R09: 0000000000000000
R10: ffffffff8a895007 R11: fffffbfff1512a00 R12: 0000000000000000
R13: ffff888218de5140 R14: 0000000000000001 R15: ffffc90002ea7388
FS:  00007fbeeb282700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880ffca0e80 CR3: 000000008e9c5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 bit_putcs_unaligned drivers/video/fbdev/core/bitblit.c:139 [inline]
 bit_putcs+0x910/0xe10 drivers/video/fbdev/core/bitblit.c:188
 fbcon_putcs+0x345/0x3f0 drivers/video/fbdev/core/fbcon.c:1362
 con_flush drivers/tty/vt/vt.c:2569 [inline]
 do_con_write.part.0+0x7d1/0x1dc0 drivers/tty/vt/vt.c:2772
 do_con_write drivers/tty/vt/vt.c:2588 [inline]
 con_write+0x41/0xe0 drivers/tty/vt/vt.c:3154
 process_output_block drivers/tty/n_tty.c:595 [inline]
 n_tty_write+0x3f0/0xf90 drivers/tty/n_tty.c:2333
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x495/0x800 drivers/tty/tty_io.c:1046
 __vfs_write+0x76/0x100 fs/read_write.c:495
 __kernel_write+0x11c/0x3a0 fs/read_write.c:516
 write_pipe_buf+0x153/0x1e0 fs/splice.c:809
 splice_from_pipe_feed fs/splice.c:512 [inline]
 __splice_from_pipe+0x3e6/0x7b0 fs/splice.c:636
 splice_from_pipe+0xd9/0x140 fs/splice.c:671
 default_file_splice_write+0x37/0x90 fs/splice.c:821
 do_splice_from fs/splice.c:863 [inline]
 direct_splice_actor+0x115/0x160 fs/splice.c:1037
 splice_direct_to_actor+0x38c/0x980 fs/splice.c:992
 do_splice_direct+0x1b4/0x280 fs/splice.c:1080
 do_sendfile+0x555/0xc50 fs/read_write.c:1521
 __do_sys_sendfile64 fs/read_write.c:1582 [inline]
 __se_sys_sendfile64 fs/read_write.c:1568 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1568
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c829
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbeeb281c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000004fc0c0 RCX: 000000000045c829
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0800000080004103 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000008d6 R14: 00000000004cb7a1 R15: 00007fbeeb2826d4
Modules linked in:
CR2: ffff8880ffca0e80
---[ end trace 5bb103c4fc7bf525 ]---
RIP: 0010:writeb arch/x86/include/asm/io.h:65 [inline]
RIP: 0010:vga_imageblit_expand drivers/video/fbdev/vga16fb.c:1168 [inline]
RIP: 0010:vga16fb_imageblit+0xa5b/0x2210 drivers/video/fbdev/vga16fb.c:1260
Code: 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 ee 59 ed fd 41 8b 47 14 48 8b 74 24 08 <88> 06 0f ae e8 8a 06 b8 05 00 00 00 ba ce 03 00 00 ee 48 c7 c2 18
RSP: 0000:ffffc90002ea71f0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000007 RCX: ffffc90014391000
RDX: 0000000000000000 RSI: ffff8880ffca0e80 RDI: ffffc90002ea739c
RBP: ffffc90002ea738c R08: ffff8880922ac200 R09: 0000000000000000
R10: ffffffff8a895007 R11: fffffbfff1512a00 R12: 0000000000000000
R13: ffff888218de5140 R14: 0000000000000001 R15: ffffc90002ea7388
FS:  00007fbeeb282700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880ffca0e80 CR3: 000000008e9c5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

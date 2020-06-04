From: syzbot <syzbot+a2196edd853f2b2eed30@syzkaller.appspotmail.com>
Date: Thu, 04 Jun 2020 10:15:19 +0000
Subject: KASAN: vmalloc-out-of-bounds Read in trace_raw_output_sys_enter
Message-Id: <000000000000f1859f05a73f6bb0@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com

Hello,

syzbot found the following crash on:

HEAD commit:    86852175 Merge tag 'armsoc-fixes-v5.7' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125d79ce100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=129ea1e5950835e5
dashboard link: https://syzkaller.appspot.com/bug?extid=A2196edd853f2b2eed30
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a2196edd853f2b2eed30@syzkaller.appspotmail.com

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: vmalloc-out-of-bounds in trace_raw_output_sys_enter+0x1a8/0x230=
 include/trace/events/syscalls.h:18
Read of size 8 at addr ffffc90006191510 by task syz-executor.1/3440

CPU: 1 PID: 3440 Comm: syz-executor.1 Not tainted 5.7.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x413 mm/kasan/report.c:382
 __kasan_report.cold+0x20/0x38 mm/kasan/report.c:511
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 trace_raw_output_sys_enter+0x1a8/0x230 include/trace/events/syscalls.h:18
 interrupt_entry+0xb8/0xc0 arch/x86/entry/entry_64.S:578
 </IRQ>
RIP: 0010:bitfill_aligned drivers/video/fbdev/core/cfbfillrect.c:71 [inline]
RIP: 0010:bitfill_aligned+0x11c/0x200 drivers/video/fbdev/core/cfbfillrect.=
c:35
Code: 89 e7 4c 89 ed e8 b4 04 b4 fd 48 89 5d 00 48 89 5d 08 48 89 5d 10 48 =
89 5d 18 48 89 5d 20 48 89 5d 28 48 8d 45 38 48 89 5d 30 <48> 83 c5 40 48 8=
9 18 41 83 ef 08 bf 07 00 00 00 44 89 fe e8 ec 05
RSP: 0018:ffffc9000618f480 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffff888001007a78 RBX: 0000000000000000 RCX: ffffc9000a905000
RDX: 0000000000040000 RSI: ffffffff83bf3b1c RDI: 0000000000000005
RBP: ffff888001007a40 R08: ffff8880a7aa41c0 R09: 0000000000000040
R10: ffff8880a3ada55f R11: ffffed101475b4ab R12: 0000000000000050
R13: ffff888001007980 R14: 0000000000000000 R15: 0000000000000038
 cfb_fillrect+0x418/0x7a0 drivers/video/fbdev/core/cfbfillrect.c:327
 vga16fb_fillrect+0x68f/0x1960 drivers/video/fbdev/vga16fb.c:951
 bit_clear_margins+0x2d5/0x4a0 drivers/video/fbdev/core/bitblit.c:232
 fbcon_clear_margins+0x1de/0x240 drivers/video/fbdev/core/fbcon.c:1381
 fbcon_switch+0xcde/0x16f0 drivers/video/fbdev/core/fbcon.c:2363
 redraw_screen+0x2ae/0x770 drivers/tty/vt/vt.c:1015
 fbcon_modechanged+0x581/0x720 drivers/video/fbdev/core/fbcon.c:3000
 fbcon_set_all_vcs+0x3b3/0x460 drivers/video/fbdev/core/fbcon.c:3038
 fbcon_update_vcs+0x26/0x50 drivers/video/fbdev/core/fbcon.c:3045
 fb_set_var+0xad0/0xd40 drivers/video/fbdev/core/fbmem.c:1056
 do_fb_ioctl+0x390/0x6e0 drivers/video/fbdev/core/fbmem.c:1109
 fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:771
 __do_sys_ioctl fs/ioctl.c:780 [inline]
 __se_sys_ioctl fs/ioctl.c:778 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:778
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45ca69
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4c0e062c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e4b00 RCX: 000000000045ca69
RDX: 0000000020000000 RSI: 0000000000004601 RDI: 0000000000000004
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000002f2 R14: 00000000004c5708 R15: 00007f4c0e0636d4


Memory state around the buggy address:
 ffffc90006191400: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc90006191480: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
>ffffc90006191500: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                         ^
 ffffc90006191580: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc90006191600: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

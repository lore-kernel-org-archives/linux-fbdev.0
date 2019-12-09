From: syzbot <syzbot+0568d05e486eee0a1ba2@syzkaller.appspotmail.com>
Date: Mon, 09 Dec 2019 04:27:09 +0000
Subject: Re: KASAN: global-out-of-bounds Read in fb_pad_aligned_buffer
Message-Id: <00000000000017046a05993dcf90@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <00000000000000ffab05992442a7@google.com>
References: <00000000000000ffab05992442a7@google.com>
In-Reply-To: <00000000000000ffab05992442a7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org, kraxel@redhat.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, peda@axentia.se, sam@ravnborg.org, syzkaller-bugs@googlegroups.com

syzbot has found a reproducer for the following crash on:

HEAD commit:    9455d25f Merge tag 'ntb-5.5' of git://github.com/jonmason/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x1e09dae00000
kernel config:  https://syzkaller.appspot.com/x/.config?xz3b8f5088d4043a
dashboard link: https://syzkaller.appspot.com/bug?extid68d05e486eee0a1ba2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?xddeca6e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?xdf9e41e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0568d05e486eee0a1ba2@syzkaller.appspotmail.com

=================================
BUG: KASAN: global-out-of-bounds in __fb_pad_aligned_buffer  
include/linux/fb.h:655 [inline]
BUG: KASAN: global-out-of-bounds in fb_pad_aligned_buffer+0x138/0x160  
drivers/video/fbdev/core/fbmem.c:115
Read of size 1 at addr ffffffff8872a77c by task syz-executor208/9953

CPU: 1 PID: 9953 Comm: syz-executor208 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  __fb_pad_aligned_buffer include/linux/fb.h:655 [inline]
  fb_pad_aligned_buffer+0x138/0x160 drivers/video/fbdev/core/fbmem.c:115
  bit_putcs_aligned drivers/video/fbdev/core/bitblit.c:99 [inline]
  bit_putcs+0xd14/0xf10 drivers/video/fbdev/core/bitblit.c:185
  fbcon_putcs+0x33c/0x3e0 drivers/video/fbdev/core/fbcon.c:1353
  do_update_region+0x42b/0x6f0 drivers/tty/vt/vt.c:677
  redraw_screen+0x676/0x7d0 drivers/tty/vt/vt.c:1011
  fbcon_do_set_font+0x829/0x960 drivers/video/fbdev/core/fbcon.c:2605
  fbcon_copy_font+0x12c/0x190 drivers/video/fbdev/core/fbcon.c:2620
  con_font_copy drivers/tty/vt/vt.c:4594 [inline]
  con_font_op+0x6b2/0x1270 drivers/tty/vt/vt.c:4609
  vt_ioctl+0x181a/0x26d0 drivers/tty/vt/vt_ioctl.c:965
  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440269
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff65832458 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440269
RDX: 0000000020000000 RSI: 0000000000004b72 RDI: 0000000000000004
RBP: 00000000006cb018 R08: 000000000000000d R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401b50
R13: 0000000000401be0 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the variable:
  oid_index+0x93c/0xb80

Memory state around the buggy address:
  ffffffff8872a600: 04 fa fa fa fa fa fa fa 00 01 fa fa fa fa fa fa
  ffffffff8872a680: 04 fa fa fa fa fa fa fa 04 fa fa fa fa fa fa fa
> ffffffff8872a700: 07 fa fa fa fa fa fa fa 04 fa fa fa fa fa fa fa
                                                                 ^
  ffffffff8872a780: 05 fa fa fa fa fa fa fa 01 fa fa fa fa fa fa fa
  ffffffff8872a800: 00 00 02 fa fa fa fa fa 00 00 00 05 fa fa fa fa
=================================

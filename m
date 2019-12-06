From: syzbot <syzbot+cf43fb300aa142fb024b@syzkaller.appspotmail.com>
Date: Fri, 06 Dec 2019 12:25:07 +0000
Subject: KASAN: use-after-free Read in soft_cursor
Message-Id: <000000000000e1d639059908223b@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com

Hello,

syzbot found the following crash on:

HEAD commit:    b0d4beaa Merge branch 'next.autofs' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b97e41e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=F07a23020fd7d21a
dashboard link: https://syzkaller.appspot.com/bug?extid=CF43fb300aa142fb024b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1745a90ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1361042ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cf43fb300aa142fb024b@syzkaller.appspotmail.com

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: use-after-free in memcpy include/linux/string.h:380 [inline]
BUG: KASAN: use-after-free in soft_cursor+0x439/0xa30 =20
drivers/video/fbdev/core/softcursor.c:70
Read of size 9 at addr ffff8880a1b23851 by task syz-executor549/8989

CPU: 0 PID: 8989 Comm: syz-executor549 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =20
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:3=
74
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  memcpy+0x24/0x50 mm/kasan/common.c:125
  memcpy include/linux/string.h:380 [inline]
  soft_cursor+0x439/0xa30 drivers/video/fbdev/core/softcursor.c:70
  bit_cursor+0x12fc/0x1a60 drivers/video/fbdev/core/bitblit.c:386
  fbcon_cursor+0x487/0x660 drivers/video/fbdev/core/fbcon.c:1402
  hide_cursor+0x9d/0x2b0 drivers/tty/vt/vt.c:895
  redraw_screen+0x60b/0x7d0 drivers/tty/vt/vt.c:988
  vc_do_resize+0x10c9/0x1460 drivers/tty/vt/vt.c:1284
  vc_resize+0x4d/0x60 drivers/tty/vt/vt.c:1304
  vt_ioctl+0x2076/0x26d0 drivers/tty/vt/vt_ioctl.c:887
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
RIP: 0033:0x440219
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 =
=20
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  =

ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe3702aa48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440219
RDX: 00000000200002c0 RSI: 000000000000560a RDI: 0000000000000004
RBP: 00000000006ca018 R08: 0000000000000001 R09: 00000000004002c8
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000401b00
R13: 0000000000401b90 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 8975:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:513 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
  __do_kmalloc mm/slab.c:3656 [inline]
  __kmalloc+0x163/0x770 mm/slab.c:3665
  kmalloc include/linux/slab.h:561 [inline]
  kzalloc include/linux/slab.h:670 [inline]
  tomoyo_init_log+0x141f/0x2070 security/tomoyo/audit.c:275
  tomoyo_supervisor+0x33f/0xef0 security/tomoyo/common.c:2095
  tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
  tomoyo_path_permission security/tomoyo/file.c:587 [inline]
  tomoyo_path_permission+0x263/0x360 security/tomoyo/file.c:573
  tomoyo_check_open_permission+0x3a6/0x3e0 security/tomoyo/file.c:777
  tomoyo_file_open security/tomoyo/tomoyo.c:319 [inline]
  tomoyo_file_open+0xa9/0xd0 security/tomoyo/tomoyo.c:314
  security_file_open+0x71/0x300 security/security.c:1497
  do_dentry_open+0x37a/0x1380 fs/open.c:784
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3412 [inline]
  path_openat+0x10e4/0x4710 fs/namei.c:3529
  do_filp_open+0x1a1/0x280 fs/namei.c:3559
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1110
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8975:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  kasan_set_free_info mm/kasan/common.c:335 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  tomoyo_supervisor+0x360/0xef0 security/tomoyo/common.c:2147
  tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
  tomoyo_path_permission security/tomoyo/file.c:587 [inline]
  tomoyo_path_permission+0x263/0x360 security/tomoyo/file.c:573
  tomoyo_check_open_permission+0x3a6/0x3e0 security/tomoyo/file.c:777
  tomoyo_file_open security/tomoyo/tomoyo.c:319 [inline]
  tomoyo_file_open+0xa9/0xd0 security/tomoyo/tomoyo.c:314
  security_file_open+0x71/0x300 security/security.c:1497
  do_dentry_open+0x37a/0x1380 fs/open.c:784
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3412 [inline]
  path_openat+0x10e4/0x4710 fs/namei.c:3529
  do_filp_open+0x1a1/0x280 fs/namei.c:3559
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1110
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a1b23800
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 81 bytes inside of
  512-byte region [ffff8880a1b23800, ffff8880a1b23a00)
The buggy address belongs to the page:
page:ffffea000286c8c0 refcount:1 mapcount:0 mapping:ffff8880aa400a80 =20
index:0xffff8880a1b23000
raw: 00fffe0000000200 ffffea00028bd888 ffffea0002a4a388 ffff8880aa400a80
raw: ffff8880a1b23000 ffff8880a1b23000 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a1b23700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a1b23780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8880a1b23800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                  ^
  ffff8880a1b23880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a1b23900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

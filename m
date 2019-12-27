From: syzbot <syzbot+a81b7bd8a01c0af7f6cb@syzkaller.appspotmail.com>
Date: Fri, 27 Dec 2019 07:22:10 +0000
Subject: KASAN: slab-out-of-bounds Write in fbcon_scroll
Message-Id: <00000000000015c31e059aaa5acc@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, sam@ravnborg.org, syzkaller-bugs@googlegroups.com

Hello,

syzbot found the following crash on:

HEAD commit:    46cf053e Linux 5.5-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1376a2c6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ED9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=A81b7bd8a01c0af7f6cb
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a81b7bd8a01c0af7f6cb@syzkaller.appspotmail.com

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:380 [inline]
BUG: KASAN: slab-out-of-bounds in scr_memcpyw include/linux/vt_buffer.h:49 =
=20
[inline]
BUG: KASAN: slab-out-of-bounds in fbcon_softback_note =20
drivers/video/fbdev/core/fbcon.c:1854 [inline]
BUG: KASAN: slab-out-of-bounds in fbcon_scroll+0x261e/0x35b0 =20
drivers/video/fbdev/core/fbcon.c:1892
Write of size 160 at addr ffff8880a3f17f80 by task syz-executor.3/29803

CPU: 1 PID: 29803 Comm: syz-executor.3 Not tainted 5.5.0-rc3-syzkaller #0
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
  memcpy+0x38/0x50 mm/kasan/common.c:126
  memcpy include/linux/string.h:380 [inline]
  scr_memcpyw include/linux/vt_buffer.h:49 [inline]
  fbcon_softback_note drivers/video/fbdev/core/fbcon.c:1854 [inline]
  fbcon_scroll+0x261e/0x35b0 drivers/video/fbdev/core/fbcon.c:1892
  con_scroll+0x3fd/0x650 drivers/tty/vt/vt.c:631
  csi_M drivers/tty/vt/vt.c:1995 [inline]
  do_con_trol+0x4ba7/0x61b0 drivers/tty/vt/vt.c:2376
  do_con_write.part.0+0xfd9/0x1ef0 drivers/tty/vt/vt.c:2797
  do_con_write drivers/tty/vt/vt.c:2565 [inline]
  con_write+0x46/0xd0 drivers/tty/vt/vt.c:3135
  process_output_block drivers/tty/n_tty.c:595 [inline]
  n_tty_write+0x40e/0x1080 drivers/tty/n_tty.c:2333
  do_tty_write drivers/tty/tty_io.c:962 [inline]
  tty_write+0x496/0x7f0 drivers/tty/tty_io.c:1046
  __vfs_write+0x8a/0x110 fs/read_write.c:494
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a919
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 =
=20
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  =

ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4314bc3c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a919
RDX: 00000000000002c1 RSI: 0000000020000880 RDI: 0000000000000008
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4314bc46d4
R13: 00000000004cbd7a R14: 00000000004e5b48 R15: 00000000ffffffff

Allocated by task 1:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:513 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
  __do_kmalloc_node mm/slab.c:3616 [inline]
  __kmalloc_node+0x4e/0x70 mm/slab.c:3623
  kmalloc_node include/linux/slab.h:579 [inline]
  kvmalloc_node+0xbd/0x100 mm/util.c:574
  kvmalloc include/linux/mm.h:655 [inline]
  fbcon_startup+0xa0e/0xe20 drivers/video/fbdev/core/fbcon.c:1024
  do_register_con_driver drivers/tty/vt/vt.c:3965 [inline]
  do_take_over_console+0x13e/0x5a0 drivers/tty/vt/vt.c:4104
  do_fbcon_takeover+0x116/0x220 drivers/video/fbdev/core/fbcon.c:581
  fbcon_fb_registered+0x275/0x340 drivers/video/fbdev/core/fbcon.c:3252
  do_register_framebuffer drivers/video/fbdev/core/fbmem.c:1652 [inline]
  register_framebuffer+0x5c3/0xa10 drivers/video/fbdev/core/fbmem.c:1821
  vga16fb_probe+0x711/0x825 drivers/video/fbdev/vga16fb.c:1373
  platform_drv_probe+0x8d/0x140 drivers/base/platform.c:725
  really_probe+0x291/0x710 drivers/base/dd.c:548
  driver_probe_device+0x110/0x220 drivers/base/dd.c:721
  __device_attach_driver+0x1c9/0x230 drivers/base/dd.c:828
  bus_for_each_drv+0x172/0x1f0 drivers/base/bus.c:430
  __device_attach+0x237/0x390 drivers/base/dd.c:894
  device_initial_probe+0x1b/0x20 drivers/base/dd.c:941
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:490
  device_add+0x14fe/0x1d00 drivers/base/core.c:2487
  platform_device_add+0x34d/0x6c0 drivers/base/platform.c:562
  vga16fb_init+0x15f/0x1d6 drivers/video/fbdev/vga16fb.c:1431
  do_one_initcall+0x120/0x820 init/main.c:939
  do_initcall_level init/main.c:1007 [inline]
  do_initcalls init/main.c:1015 [inline]
  do_basic_setup init/main.c:1032 [inline]
  kernel_init_freeable+0x4ca/0x570 init/main.c:1216
  kernel_init+0x12/0x1bf init/main.c:1110
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8880a3f10000
  which belongs to the cache kmalloc-32k of size 32768
The buggy address is located 32640 bytes inside of
  32768-byte region [ffff8880a3f10000, ffff8880a3f18000)
The buggy address belongs to the page:
page:ffffea00028fc400 refcount:1 mapcount:0 mapping:ffff8880aa402540 =20
index:0x0 compound_mapcount: 0
raw: 00fffe0000010200 ffff8880aa401d48 ffffea000285e808 ffff8880aa402540
raw: 0000000000000000 ffff8880a3f10000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a3f17f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8880a3f17f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8880a3f18000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                    ^
  ffff8880a3f18080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a3f18100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

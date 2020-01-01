From: syzbot <syzbot+29d4ed7f3bdedf2aa2fd@syzkaller.appspotmail.com>
Date: Wed, 01 Jan 2020 17:40:08 +0000
Subject: Re: KASAN: global-out-of-bounds Read in fbcon_get_font
Message-Id: <0000000000005e40e3059b17917c@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <0000000000006b9e8d059952095e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org, ghalat@redhat.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, sam@ravnborg.org, syzkaller-bugs@googlegroups.com

syzbot has found a reproducer for the following crash on:

HEAD commit:    738d2902 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e396c1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=874bac2ff63646fa
dashboard link: https://syzkaller.appspot.com/bug?extid)d4ed7f3bdedf2aa2fd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a0b866e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fc963ee00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b75532e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17b75532e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13b75532e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+29d4ed7f3bdedf2aa2fd@syzkaller.appspotmail.com

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: global-out-of-bounds in memcpy include/linux/string.h:380 =20
[inline]
BUG: KASAN: global-out-of-bounds in fbcon_get_font+0x2b2/0x5e0 =20
drivers/video/fbdev/core/fbcon.c:2465
Read of size 32 at addr ffffffff88729e80 by task syz-executor334/10190

CPU: 0 PID: 10190 Comm: syz-executor334 Not tainted 5.5.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =20
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  memcpy+0x24/0x50 mm/kasan/common.c:125
  memcpy include/linux/string.h:380 [inline]
  fbcon_get_font+0x2b2/0x5e0 drivers/video/fbdev/core/fbcon.c:2465
  con_font_get drivers/tty/vt/vt.c:4446 [inline]
  con_font_op+0x20b/0x1270 drivers/tty/vt/vt.c:4605
  vt_ioctl+0xd2e/0x26d0 drivers/tty/vt/vt_ioctl.c:913
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
RIP: 0033:0x4412d9
Code: e8 3c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 =
=20
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  =

ff 0f 83 9b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc49b97f18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004a2487 RCX: 00000000004412d9
RDX: 0000000020000200 RSI: 0000000000004b60 RDI: 0000000000000004
RBP: 0000000000018ac7 R08: 000000000000000d R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402100
R13: 0000000000402190 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the variable:
  fontdata_8x16+0x1000/0x1120

Memory state around the buggy address:
  ffffffff88729d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffffff88729e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffffffff88729e80: fa fa fa fa 06 fa fa fa fa fa fa fa 05 fa fa fa
                    ^
  ffffffff88729f00: fa fa fa fa 06 fa fa fa fa fa fa fa 00 00 03 fa
  ffffffff88729f80: fa fa fa fa 00 00 00 00 00 00 00 00 00 00 00 00
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 04 Dec 2019 10:54:17 +0000
Subject: cirrusfb: divide errors in cirrusfb_check_var/cirrusfb_check_pixclock/cirrusfb_set_par_foo
Message-Id: <CACT4Y+YjudGzx44Jw1UMgEPB4kfzp3jo-TcCVR62U+N+2C6tjA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>

Hello,

syzkaller has found 3 of divide errors in the cirrusfb driver.
Kernel is on c5db92909bedd Add linux-next specific files for 20191202.

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8133 Comm: syz-executor.5 Not tainted 5.4.0-next-20191202+ #13
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:cirrusfb_set_par_foo+0x1d17/0x64b0 drivers/video/fbdev/cirrusfb.c:836
Call Trace:
 cirrusfb_set_par+0x15/0x20 drivers/video/fbdev/cirrusfb.c:1272
 fb_set_var+0x518/0xdd0 drivers/video/fbdev/core/fbmem.c:1024
 do_fb_ioctl+0x50c/0x830 drivers/video/fbdev/core/fbmem.c:1104
 fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
 vfs_ioctl fs/ioctl.c:47 [inline]
 file_ioctl fs/ioctl.c:545 [inline]
 do_vfs_ioctl+0x1df/0x1420 fs/ioctl.c:732
 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:749

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 3 PID: 7639 Comm: syz-executor.0 Not tainted 5.4.0-next-20191202+ #12
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:cirrusfb_check_pixclock drivers/video/fbdev/cirrusfb.c:482 [inline]
RIP: 0010:cirrusfb_check_var+0x6e8/0x1150 drivers/video/fbdev/cirrusfb.c:623
Call Trace:
 fb_set_var+0x236/0xdd0 drivers/video/fbdev/core/fbmem.c:1005
 do_fb_ioctl+0x50c/0x830 drivers/video/fbdev/core/fbmem.c:1104
 fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
 vfs_ioctl fs/ioctl.c:47 [inline]
 file_ioctl fs/ioctl.c:545 [inline]
 do_vfs_ioctl+0x1df/0x1420 fs/ioctl.c:732
 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:749

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 12555 Comm: syz-executor.5 Not tainted 5.4.0-next-20191202+ #15
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:cirrusfb_check_var.cold.16+0x12e/0x1e7
drivers/video/fbdev/cirrusfb.c:581
Call Trace:
 fb_set_var+0x236/0xdd0 drivers/video/fbdev/core/fbmem.c:1005
 do_fb_ioctl+0x50c/0x830 drivers/video/fbdev/core/fbmem.c:1104
 fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
 vfs_ioctl fs/ioctl.c:47 [inline]
 file_ioctl fs/ioctl.c:545 [inline]
 do_vfs_ioctl+0x1df/0x1420 fs/ioctl.c:732
 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:749

From: Alexei Starovoitov <ast@plumgrid.com>
Date: Fri, 11 Oct 2013 22:00:35 +0000
Subject: [PATCH] do_register_framebuffer() fix potential deadlock
Message-Id: <1381528835-3351-1-git-send-email-ast@plumgrid.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

commit 50e244cc79
"fb: rework locking to fix lock ordering on takeover"

fixed the locking, but in one place the console_lock() and lock_fb_info()
seem to be in the wrong order vs the rest

to reproduce just boot and wait till blank

===========================
[ INFO: possible circular locking dependency detected ]
3.12.0-rc3+ #50 Not tainted
-------------------------------------------------------
kworker/0:0/4 is trying to acquire lock:
 (&fb_info->lock){+.+.+.}, at: [<ffffffff813ec786>] lock_fb_info+0x26/0x60

but task is already holding lock:
 (console_lock){+.+.+.}, at: [<ffffffff8146acf3>] console_callback+0x13/0x140

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (console_lock){+.+.+.}:
       [<ffffffff810cf002>] lock_acquire+0x92/0x1d0
       [<ffffffff810b3467>] console_lock+0x77/0x80
       [<ffffffff813edc14>] register_framebuffer+0x1d4/0x320
       [<ffffffff81403e4a>] vesafb_probe+0x5ba/0xa70
       [<ffffffff814b7393>] platform_drv_probe+0x43/0x80
       [<ffffffff814b52cb>] driver_probe_device+0x7b/0x220
       [<ffffffff814b551b>] __driver_attach+0xab/0xb0
       [<ffffffff814b32bd>] bus_for_each_dev+0x5d/0xa0
       [<ffffffff814b4cde>] driver_attach+0x1e/0x20
       [<ffffffff814b486f>] bus_add_driver+0x10f/0x2a0
       [<ffffffff814b5be4>] driver_register+0x64/0xf0
       [<ffffffff814b6b8a>] __platform_driver_register+0x4a/0x50
       [<ffffffff81d5e863>] vesafb_driver_init+0x12/0x14
       [<ffffffff8100031a>] do_one_initcall+0x11a/0x170
       [<ffffffff81d21fed>] kernel_init_freeable+0x13e/0x1cd
       [<ffffffff8174a49e>] kernel_init+0xe/0xf0
       [<ffffffff8176c86c>] ret_from_fork+0x7c/0xb0

-> #0 (&fb_info->lock){+.+.+.}:
       [<ffffffff810ce883>] __lock_acquire+0x1c63/0x1d50
       [<ffffffff810cf002>] lock_acquire+0x92/0x1d0
       [<ffffffff8175dc94>] mutex_lock_nested+0x74/0x380
       [<ffffffff813ec786>] lock_fb_info+0x26/0x60
       [<ffffffff813fb08b>] fbcon_blank+0x29b/0x2e0
       [<ffffffff81468898>] do_blank_screen+0x1d8/0x280
       [<ffffffff8146ad44>] console_callback+0x64/0x140
       [<ffffffff81074b48>] process_one_work+0x1d8/0x6a0
       [<ffffffff810754bb>] worker_thread+0x11b/0x370
       [<ffffffff8107e36a>] kthread+0xea/0xf0
       [<ffffffff8176c86c>] ret_from_fork+0x7c/0xb0

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(console_lock);
                               lock(&fb_info->lock);
                               lock(console_lock);
  lock(&fb_info->lock);

 *** DEADLOCK ***

Signed-off-by: Alexei Starovoitov <ast@plumgrid.com>
---
 drivers/video/fbmem.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index dacaf74..f12ab1c 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1660,12 +1660,14 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	registered_fb[i] = fb_info;
 
 	event.info = fb_info;
-	if (!lock_fb_info(fb_info))
-		return -ENODEV;
 	console_lock();
+	if (!lock_fb_info(fb_info)) {
+		console_unlock();
+		return -ENODEV;
+	}
 	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
-	console_unlock();
 	unlock_fb_info(fb_info);
+	console_unlock();
 	return 0;
 }
 
-- 
1.7.9.5


From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 1/4 (updated)] ps3fb: thread updates
Date: Fri, 16 Feb 2007 17:00:01 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0702161658530.8263@pademelon.sonytel.be>
References: <20070215152301.573853000@sonycom.com>
	<20070215152432.264415000@sonycom.com>
	<20070215175007.GA10817@lst.de>
	<1171575817.5644.44.camel@localhost.localdomain>
	<20070215165916.de546f0d.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HI5Vr-0000N4-TC for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 08:00:44 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HI5Vp-0000nw-68
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 08:00:43 -0800
In-Reply-To: <20070215165916.de546f0d.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net, Christoph Hellwig <hch@lst.de>, linuxppc-dev@ozlabs.org

ps3fb: Replace the kernel_thread by a proper kthread, which sleeps on a
waitqueue_head.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |   45 +++++++++++++++++++++++++++++++++++----------
 1 files changed, 35 insertions(+), 10 deletions(-)

--- ps3-linux-2.6.20.orig/drivers/video/ps3fb.c
+++ ps3-linux-2.6.20/drivers/video/ps3fb.c
@@ -32,6 +32,8 @@
 #include <linux/ioctl.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
+#include <linux/freezer.h>
+#include <linux/kthread.h>
 
 #include <asm/uaccess.h>
 #include <linux/fb.h>
@@ -129,7 +131,6 @@ struct ps3fb_priv {
 	u64 context_handle, memory_handle;
 	void *xdr_ea;
 	struct gpu_driver_info *dinfo;
-	struct semaphore sem;
 	u32 res_index;
 
 	u64 vblank_count;	/* frame count */
@@ -139,6 +140,8 @@ struct ps3fb_priv {
 	atomic_t ext_flip;	/* on/off flip with vsync */
 	atomic_t f_count;	/* fb_open count */
 	int is_blanked;
+	int is_kicked;
+	struct task_struct *task;
 };
 static struct ps3fb_priv ps3fb;
 
@@ -805,11 +808,16 @@ static int ps3fb_ioctl(struct fb_info *i
 
 static int ps3fbd(void *arg)
 {
-	daemonize("ps3fbd");
-	for (;;) {
-		down(&ps3fb.sem);
-		if (atomic_read(&ps3fb.ext_flip) == 0)
-			ps3fb_sync(0);	/* single buffer */
+	DEFINE_WAIT(wait);
+	DECLARE_WAIT_QUEUE_HEAD(wq);
+
+	while (!kthread_should_stop()) {
+		prepare_to_wait(&wq, &wait, TASK_INTERRUPTIBLE);
+		if (!ps3fb.is_kicked)
+			schedule();
+		finish_wait(&wq, &wait);
+		ps3fb.is_kicked = 0;
+		ps3fb_sync(0);	/* single buffer */
 	}
 	return 0;
 }
@@ -830,8 +838,11 @@ static irqreturn_t ps3fb_vsync_interrupt
 	if (v1 & (1 << GPU_INTR_STATUS_VSYNC_1)) {
 		/* VSYNC */
 		ps3fb.vblank_count = head->vblank_count;
-		if (!ps3fb.is_blanked)
-			up(&ps3fb.sem);
+		if (ps3fb.task && !ps3fb.is_blanked &&
+		    !atomic_read(&ps3fb.ext_flip)) {
+			ps3fb.is_kicked = 1;
+			wake_up_process(ps3fb.task);
+		}
 		wake_up_interruptible(&ps3fb.wait_vsync);
 	}
 
@@ -968,6 +979,7 @@ static int __init ps3fb_probe(struct pla
 	u64 xdr_lpar;
 	int status;
 	unsigned long offset;
+	struct task_struct *task;
 
 	/* get gpu context handle */
 	status = lv1_gpu_memory_allocate(DDR_SIZE, 0, 0, 0, 0,
@@ -1050,9 +1062,18 @@ static int __init ps3fb_probe(struct pla
 	       "fb%d: PS3 frame buffer device, using %ld KiB of video memory\n",
 	       info->node, ps3fb_videomemory.size >> 10);
 
-	kernel_thread(ps3fbd, info, CLONE_KERNEL);
+	task = kthread_run(ps3fbd, info, "ps3fbd");
+	if (IS_ERR(task)) {
+		retval = PTR_ERR(task);
+		goto err_unregister_framebuffer;
+	}
+
+	ps3fb.task = task;
+
 	return 0;
 
+err_unregister_framebuffer:
+	unregister_framebuffer(info);
 err_fb_dealloc:
 	fb_dealloc_cmap(&info->cmap);
 err_framebuffer_release:
@@ -1083,6 +1104,11 @@ void ps3fb_cleanup(void)
 {
 	int status;
 
+	if (ps3fb.task) {
+		struct task_struct *task = ps3fb.task;
+		ps3fb.task = NULL;
+		kthread_stop(task);
+	}
 	if (ps3fb.irq_no) {
 		free_irq(ps3fb.irq_no, ps3fb.dev);
 		ps3_free_irq(ps3fb.irq_no);
@@ -1195,7 +1221,6 @@ static int __init ps3fb_init(void)
 
 	atomic_set(&ps3fb.f_count, -1);	/* fbcon opens ps3fb */
 	atomic_set(&ps3fb.ext_flip, 0);	/* for flip with vsync */
-	init_MUTEX(&ps3fb.sem);
 	init_waitqueue_head(&ps3fb.wait_vsync);
 	ps3fb.num_frames = 1;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

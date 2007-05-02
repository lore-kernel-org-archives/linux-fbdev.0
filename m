From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 1/8] ps3fb: thread updates
Date: Wed, 02 May 2007 14:48:31 +0200
Message-ID: <20070502124840.149818000@pademelon.sonytel.be>
References: <20070502124830.911142000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjEHh-0007NH-8Y for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 05:50:17 -0700
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HjEHe-0005ny-Jb
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 05:50:17 -0700
Content-Disposition: inline; filename=ps3-stable/ps3fb-kthread.diff
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: James Simmons <jsimmons@infradead.org>, Antonino Daplas <adaplas@gmail.com>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net

ps3fb: Replace the kernel_thread and the semaphore by a proper kthread, which
is simply woken up when the screen must be updated

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |   41 ++++++++++++++++++++++++++++++++---------
 1 files changed, 32 insertions(+), 9 deletions(-)

--- ps3-linux-2.6.21.orig/drivers/video/ps3fb.c
+++ ps3-linux-2.6.21/drivers/video/ps3fb.c
@@ -32,6 +32,8 @@
 #include <linux/ioctl.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
 
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
 
@@ -805,11 +808,14 @@ static int ps3fb_ioctl(struct fb_info *i
 
 static int ps3fbd(void *arg)
 {
-	daemonize("ps3fbd");
-	for (;;) {
-		down(&ps3fb.sem);
-		if (atomic_read(&ps3fb.ext_flip) == 0)
+	while (!kthread_should_stop()) {
+		try_to_freeze();
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (ps3fb.is_kicked) {
+			ps3fb.is_kicked = 0;
 			ps3fb_sync(0);	/* single buffer */
+		}
+		schedule();
 	}
 	return 0;
 }
@@ -830,8 +836,11 @@ static irqreturn_t ps3fb_vsync_interrupt
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
 
@@ -968,6 +977,7 @@ static int __init ps3fb_probe(struct pla
 	u64 xdr_lpar;
 	int status;
 	unsigned long offset;
+	struct task_struct *task;
 
 	/* get gpu context handle */
 	status = lv1_gpu_memory_allocate(DDR_SIZE, 0, 0, 0, 0,
@@ -1050,9 +1060,18 @@ static int __init ps3fb_probe(struct pla
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
@@ -1083,6 +1102,11 @@ void ps3fb_cleanup(void)
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
@@ -1195,7 +1219,6 @@ static int __init ps3fb_init(void)
 
 	atomic_set(&ps3fb.f_count, -1);	/* fbcon opens ps3fb */
 	atomic_set(&ps3fb.ext_flip, 0);	/* for flip with vsync */
-	init_MUTEX(&ps3fb.sem);
 	init_waitqueue_head(&ps3fb.wait_vsync);
 	ps3fb.num_frames = 1;
 

--
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

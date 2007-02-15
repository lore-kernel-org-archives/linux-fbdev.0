From: Geert.Uytterhoeven@sonycom.com
Subject: [patch 1/4] ps3fb: thread updates
Date: Thu, 15 Feb 2007 16:23:02 +0100
Message-ID: <20070215152432.264415000@sonycom.com>
References: <20070215152301.573853000@sonycom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHiV0-00068H-3g for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 07:26:18 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HHiUw-0004hW-Kx
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 07:26:18 -0800
Content-Disposition: inline; filename=ps3-wip/ps3fb-kthread.diff
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
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net

ps3fb: Replace the kernel_thread by a proper kthread.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |   29 +++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 6 deletions(-)

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
@@ -139,6 +141,7 @@ struct ps3fb_priv {
 	atomic_t ext_flip;	/* on/off flip with vsync */
 	atomic_t f_count;	/* fb_open count */
 	int is_blanked;
+	struct task_struct *task;
 };
 static struct ps3fb_priv ps3fb;
 
@@ -805,12 +808,14 @@ static int ps3fb_ioctl(struct fb_info *i
 
 static int ps3fbd(void *arg)
 {
-	daemonize("ps3fbd");
-	for (;;) {
-		down(&ps3fb.sem);
-		if (atomic_read(&ps3fb.ext_flip) == 0)
+	int error;
+
+	do {
+		try_to_freeze();
+		error = down_interruptible(&ps3fb.sem);
+		if (!error && !atomic_read(&ps3fb.ext_flip))
 			ps3fb_sync(0);	/* single buffer */
-	}
+	} while (!kthread_should_stop());
 	return 0;
 }
 
@@ -1050,9 +1055,17 @@ static int __init ps3fb_probe(struct pla
 	       "fb%d: PS3 frame buffer device, using %ld KiB of video memory\n",
 	       info->node, ps3fb_videomemory.size >> 10);
 
-	kernel_thread(ps3fbd, info, CLONE_KERNEL);
+	ps3fb.task = kthread_run(ps3fbd, info, "ps3fbd");
+	if (IS_ERR(ps3fb.task)) {
+		retval = PTR_ERR(ps3fb.task);
+		ps3fb.task = NULL;
+		goto err_unregister_framebuffer;
+	}
+
 	return 0;
 
+err_unregister_framebuffer:
+	unregister_framebuffer(info);
 err_fb_dealloc:
 	fb_dealloc_cmap(&info->cmap);
 err_framebuffer_release:
@@ -1083,6 +1096,10 @@ void ps3fb_cleanup(void)
 {
 	int status;
 
+	if (ps3fb.task) {
+		kthread_stop(ps3fb.task);
+		ps3fb.task = NULL;
+	}
 	if (ps3fb.irq_no) {
 		free_irq(ps3fb.irq_no, ps3fb.dev);
 		ps3_free_irq(ps3fb.irq_no);

--
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

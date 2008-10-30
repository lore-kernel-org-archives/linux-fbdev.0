From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH] tmiofb: fix compilation with ACCEL
	disabled
Date: Fri, 31 Oct 2008 01:45:49 +0300
Message-ID: <1225406749-18282-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dbaryshkov@gmail.com>) id 1KvgHJ-00057x-Lg
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 30 Oct 2008 22:46:09 +0000
Received: from fg-out-1718.google.com ([72.14.220.158])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KvgHH-00031t-0z for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 30 Oct 2008 22:46:09 +0000
Received: by fg-out-1718.google.com with SMTP id d23so684116fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 30 Oct 2008 15:46:05 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>

Restore support for compiling tmiofb with acceleration disabled.

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 drivers/video/tmiofb.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
index 2a38001..7baf2dd 100644
--- a/drivers/video/tmiofb.c
+++ b/drivers/video/tmiofb.c
@@ -222,6 +222,9 @@ static irqreturn_t tmiofb_irq(int irq, void *__info)
 	unsigned int bbisc = tmio_ioread16(par->lcr + LCR_BBISC);
 
 
+	tmio_iowrite16(bbisc, par->lcr + LCR_BBISC);
+
+#ifdef CONFIG_FB_TMIO_ACCELL
 	/*
 	 * We were in polling mode and now we got correct irq.
 	 * Switch back to IRQ-based sync of command FIFO
@@ -231,9 +234,6 @@ static irqreturn_t tmiofb_irq(int irq, void *__info)
 		par->use_polling = false;
 	}
 
-	tmio_iowrite16(bbisc, par->lcr + LCR_BBISC);
-
-#ifdef CONFIG_FB_TMIO_ACCELL
 	if (bbisc & 1)
 		wake_up(&par->wait_acc);
 #endif
@@ -938,7 +938,9 @@ static void tmiofb_dump_regs(struct platform_device *dev)
 static int tmiofb_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
+#ifdef CONFIG_FB_TMIO_ACCELL
 	struct tmiofb_par *par = info->par;
+#endif
 	struct mfd_cell *cell = dev->dev.platform_data;
 	int retval = 0;
 
@@ -950,12 +952,14 @@ static int tmiofb_suspend(struct platform_device *dev, pm_message_t state)
 		info->fbops->fb_sync(info);
 
 
+#ifdef CONFIG_FB_TMIO_ACCELL
 	/*
 	 * The fb should be usable even if interrupts are disabled (and they are
 	 * during suspend/resume). Switch temporary to forced polling.
 	 */
 	printk(KERN_INFO "tmiofb: switching to polling\n");
 	par->use_polling = true;
+#endif
 	tmiofb_hw_stop(dev);
 
 	if (cell->suspend)
-- 
1.5.6.5


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

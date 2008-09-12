From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: [PATCH] atmel_lcdfb: Disable LCD and DMA
	engines when suspending
Date: Fri, 12 Sep 2008 12:22:30 +0200
Message-ID: <1221214950-18268-1-git-send-email-haavard.skinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ke5o7-00013r-H4 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Sep 2008 03:23:23 -0700
Received: from smtpeu1.atmel.com ([195.65.72.27] helo=bagnes.atmel.com)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1Ke5o3-0000ej-Sk
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Sep 2008 03:23:18 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

When suspending the system with atmel_lcdfb enabled, I sometimes see
this:

[17179610.896000] atmel_lcdfb atmel_lcdfb.0: FIFO underflow 0x10

Which can be explained by the fact that we're not stopping the LCD
controller and its DMA engine when suspending, we're just gating the
clocks to them.

There's another potential issue which may be harder to trigger but
much more nasty: If we gate the clocks at _just_ the right moment,
e.g. when the DMA engine is doing a bus transaction, we may cause the
DMA engine to violate the system bus protocol and cause a lockup.

Avoid these issues by shutting down the LCD controller before entering
suspend (and restarting it when resuming). This prevents the underrun
from happening in the first place, and prevents whatever nastiness is
happening when the bus clock stops in the middle of a DMA transfer.

Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/video/atmel_lcdfb.c |   84 +++++++++++++++++++++++++------------------
 1 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 5a24c64..75dac57 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -208,6 +208,36 @@ static unsigned long compute_hozval(unsigned long xres, unsigned long lcdcon2)
 	return value;
 }
 
+static void atmel_lcdfb_stop_nowait(struct atmel_lcdfb_info *sinfo)
+{
+	/* Turn off the LCD controller and the DMA controller */
+	lcdc_writel(sinfo, ATMEL_LCDC_PWRCON,
+			sinfo->guard_time << ATMEL_LCDC_GUARDT_OFFSET);
+
+	/* Wait for the LCDC core to become idle */
+	while (lcdc_readl(sinfo, ATMEL_LCDC_PWRCON) & ATMEL_LCDC_BUSY)
+		msleep(10);
+
+	lcdc_writel(sinfo, ATMEL_LCDC_DMACON, 0);
+}
+
+static void atmel_lcdfb_stop(struct atmel_lcdfb_info *sinfo)
+{
+	atmel_lcdfb_stop_nowait(sinfo);
+
+	/* Wait for DMA engine to become idle... */
+	while (lcdc_readl(sinfo, ATMEL_LCDC_DMACON) & ATMEL_LCDC_DMABUSY)
+		msleep(10);
+}
+
+static void atmel_lcdfb_start(struct atmel_lcdfb_info *sinfo)
+{
+	lcdc_writel(sinfo, ATMEL_LCDC_DMACON, sinfo->default_dmacon);
+	lcdc_writel(sinfo, ATMEL_LCDC_PWRCON,
+		(sinfo->guard_time << ATMEL_LCDC_GUARDT_OFFSET)
+		| ATMEL_LCDC_PWR);
+}
+
 static void atmel_lcdfb_update_dma(struct fb_info *info,
 			       struct fb_var_screeninfo *var)
 {
@@ -420,26 +450,8 @@ static void atmel_lcdfb_reset(struct atmel_lcdfb_info *sinfo)
 {
 	might_sleep();
 
-	/* LCD power off */
-	lcdc_writel(sinfo, ATMEL_LCDC_PWRCON, sinfo->guard_time << ATMEL_LCDC_GUARDT_OFFSET);
-
-	/* wait for the LCDC core to become idle */
-	while (lcdc_readl(sinfo, ATMEL_LCDC_PWRCON) & ATMEL_LCDC_BUSY)
-		msleep(10);
-
-	/* DMA disable */
-	lcdc_writel(sinfo, ATMEL_LCDC_DMACON, 0);
-
-	/* wait for DMA engine to become idle */
-	while (lcdc_readl(sinfo, ATMEL_LCDC_DMACON) & ATMEL_LCDC_DMABUSY)
-		msleep(10);
-
-	/* LCD power on */
-	lcdc_writel(sinfo, ATMEL_LCDC_PWRCON,
-		(sinfo->guard_time << ATMEL_LCDC_GUARDT_OFFSET) | ATMEL_LCDC_PWR);
-
-	/* DMA enable */
-	lcdc_writel(sinfo, ATMEL_LCDC_DMACON, sinfo->default_dmacon);
+	atmel_lcdfb_stop(sinfo);
+	atmel_lcdfb_start(sinfo);
 }
 
 /**
@@ -471,14 +483,7 @@ static int atmel_lcdfb_set_par(struct fb_info *info)
 		 info->var.xres, info->var.yres,
 		 info->var.xres_virtual, info->var.yres_virtual);
 
-	/* Turn off the LCD controller and the DMA controller */
-	lcdc_writel(sinfo, ATMEL_LCDC_PWRCON, sinfo->guard_time << ATMEL_LCDC_GUARDT_OFFSET);
-
-	/* Wait for the LCDC core to become idle */
-	while (lcdc_readl(sinfo, ATMEL_LCDC_PWRCON) & ATMEL_LCDC_BUSY)
-		msleep(10);
-
-	lcdc_writel(sinfo, ATMEL_LCDC_DMACON, 0);
+	atmel_lcdfb_stop_nowait(sinfo);
 
 	if (info->var.bits_per_pixel == 1)
 		info->fix.visual = FB_VISUAL_MONO01;
@@ -583,13 +588,7 @@ static int atmel_lcdfb_set_par(struct fb_info *info)
 	while (lcdc_readl(sinfo, ATMEL_LCDC_DMACON) & ATMEL_LCDC_DMABUSY)
 		msleep(10);
 
-	dev_dbg(info->device, "  * re-enable DMA engine\n");
-	/* ...and enable it with updated configuration */
-	lcdc_writel(sinfo, ATMEL_LCDC_DMACON, sinfo->default_dmacon);
-
-	dev_dbg(info->device, "  * re-enable LCDC core\n");
-	lcdc_writel(sinfo, ATMEL_LCDC_PWRCON,
-		(sinfo->guard_time << ATMEL_LCDC_GUARDT_OFFSET) | ATMEL_LCDC_PWR);
+	atmel_lcdfb_start(sinfo);
 
 	dev_dbg(info->device, "  * DONE\n");
 
@@ -1032,11 +1031,20 @@ static int atmel_lcdfb_suspend(struct platform_device *pdev, pm_message_t mesg)
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct atmel_lcdfb_info *sinfo = info->par;
 
+	/*
+	 * We don't want to handle interrupts while the clock is
+	 * stopped. It may take forever.
+	 */
+	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0UL);
+
 	sinfo->saved_lcdcon = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_VAL);
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, 0);
 	if (sinfo->atmel_lcdfb_power_control)
 		sinfo->atmel_lcdfb_power_control(0);
+
+	atmel_lcdfb_stop(sinfo);
 	atmel_lcdfb_stop_clock(sinfo);
+
 	return 0;
 }
 
@@ -1046,9 +1054,15 @@ static int atmel_lcdfb_resume(struct platform_device *pdev)
 	struct atmel_lcdfb_info *sinfo = info->par;
 
 	atmel_lcdfb_start_clock(sinfo);
+	atmel_lcdfb_start(sinfo);
 	if (sinfo->atmel_lcdfb_power_control)
 		sinfo->atmel_lcdfb_power_control(1);
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, sinfo->saved_lcdcon);
+
+	/* Enable FIFO & DMA errors */
+	lcdc_writel(sinfo, ATMEL_LCDC_IER, ATMEL_LCDC_UFLWI
+			| ATMEL_LCDC_OWRI | ATMEL_LCDC_MERI);
+
 	return 0;
 }
 
-- 
1.5.6.5


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

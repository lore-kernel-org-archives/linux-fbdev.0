From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: [PATCH] atmel_lcdfb: Disable LCD and DMA
	engines when suspending
Date: Mon, 11 Aug 2008 14:34:28 +0200
Message-ID: <1218458068-23834-1-git-send-email-haavard.skinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSWbo-0001ov-Q6 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 05:34:52 -0700
Received: from smtpeu1.atmel.com ([195.65.72.27] helo=bagnes.atmel.com)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1KSWbo-0006AX-48
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 05:34:48 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: kernel@avr32linux.org

When suspending the system with atmel_lcdfb enabled, I sometimes see
this:

[17179610.896000] atmel_lcdfb atmel_lcdfb.0: FIFO underflow 0x10

After this happens, the serial console is unresponsive for a long time,
but eventually recovers (after a minute or so).  SysRq-W shows that the
events thread is blocked trying to recover from the underflow:

SysRq : Show Blocked State
  task                PC stack   pid father
events/0      D 90169e50     0     5      2
Stack: (0x93833ebc to 0x93834000)
3ea0:                                                                93832008
3ec0: 90169fd8 90169fd8 93833f18 ffff11ce 93833ee8 00000000 901fb560 00000004
3ee0: 901c7788 00000000 902254f8 902254f8 ffff11ce 90023884 9381b900 90225460
3f00: 90169fd6 6576656e 74732f30 00000000 00000000 00000005 9016a012 93833f3c
3f20: 9388ca40 93821000 00000000 93832000 00000000 901c7788 00000000 90023d16
3f40: 93833f50 9388ca40 93821000 00000000 900c7ed2 93833f64 9388ca40 93821000
3f60: 00000000 90028156 93833f90 9388ca6c 93821000 00000000 90028110 900c7eb8
3f80: 904b7754 00000000 901c7788 00000000 900285a8 93833fc8 93832000 93832000
3fa0: 00000000 93821000 ffffe000 9002a7bc 93817eec 00000000 9381b900 9002aa14
3fc0: 93833fc0 93833fc0 9002a7e8 93833fec 93821000 900284f8 00000000 00000000
3fe0: 9001f718 9002a7bc 93817eec 9001f718 00000000 00000000 00000000 00000000
Call trace:
 [<90169fd8>] schedule_timeout+0x60/0x88
 [<9016a012>] schedule_timeout_uninterruptible+0x12/0x14
 [<90023d16>] msleep+0x12/0x1c
 [<900c7ed2>] atmel_lcdfb_task+0x1a/0x5c
 [<90028156>] run_workqueue+0xba/0x168
 [<900285a8>] worker_thread+0xb0/0xbc
 [<9002a7e8>] kthread+0x2c/0x44
 [<9001f718>] do_exit+0x0/0x508

Which is understandable since stopping the bus clock while the LCD
controller is doing a DMA transfer is a thoroughly nasty thing to do,
and the strange thing isn't that the controller gets confused, but that
it somehow actually manages to recover after a while.

Avoid this issue by shutting down the LCD controller before entering
suspend (and restarting it when resuming). This prevents the underrun
from happening in the first place, and prevents whatever nastiness is
happening when the bus clock stops in the middle of a DMA transfer.

Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
---
I think this patch is 2.6.27 and possibly -stable material. I have
only tested it on a prototype board which doesn't have a working LCD
panel yet, so I can't say for sure that it's doing everything
correctly, but it does appear to prevent the events thread from
hanging.

I'll probably get around to testing it more thoroughly in a couple of
days, but I'm posting it now (a) to make people aware of the problem,
and (b) so that others can test it.

 drivers/video/atmel_lcdfb.c |   84 +++++++++++++++++++++++++------------------
 1 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 763f9ae..a42406a 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -206,6 +206,36 @@ static unsigned long compute_hozval(unsigned long xres, unsigned long lcdcon2)
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
@@ -416,26 +446,8 @@ static void atmel_lcdfb_reset(struct atmel_lcdfb_info *sinfo)
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
@@ -467,14 +479,7 @@ static int atmel_lcdfb_set_par(struct fb_info *info)
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
@@ -579,13 +584,7 @@ static int atmel_lcdfb_set_par(struct fb_info *info)
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
 
@@ -1026,11 +1025,20 @@ static int atmel_lcdfb_suspend(struct platform_device *pdev, pm_message_t mesg)
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
 
@@ -1040,9 +1048,15 @@ static int atmel_lcdfb_resume(struct platform_device *pdev)
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
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

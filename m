From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:19:57 +0000
Subject: [PATCH 03/15] fbdev: sh_mobile_lcdcfb: fix more error paths
Message-Id: <Pine.LNX.4.64.1009030911190.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes the following two erroneous error paths:

hw_usecnt is allocated with a value of 0, therefore in an early error case,
calling sh_mobile_lcdc_clk_off() will wrongly conclude, that hw_usecnt has
already been incremented. Then sh_mobile_lcdc_runtime_suspend() will be called,
which will access uninitialised data fields and crash the kernel.

sh_mobile_lcdc_stop() can be called before framebuffer has been allocated, then
ch->info is NULL and dereferencing it will Oops too.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 43132de..295bf4b 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -614,7 +614,7 @@ static void sh_mobile_lcdc_stop(struct sh_mobile_lcdc_priv *priv)
 		 * flush frame, and wait for frame end interrupt
 		 * clean up deferred io and enable clock
 		 */
-		if (ch->info->fbdefio) {
+		if (ch->info && ch->info->fbdefio) {
 			ch->frame_end = 0;
 			schedule_delayed_work(&ch->info->deferred_work, 0);
 			wait_event(ch->frame_end_wait, ch->frame_end);
@@ -704,7 +704,6 @@ static int sh_mobile_lcdc_setup_clocks(struct platform_device *pdev,
 			return PTR_ERR(priv->dot_clk);
 		}
 	}
-	atomic_set(&priv->hw_usecnt, -1);
 
 	/* Runtime PM support involves two step for this driver:
 	 * 1) Enable Runtime PM
@@ -1055,6 +1054,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 
 	priv->irq = i;
 	pdata = pdev->dev.platform_data;
+	atomic_set(&priv->hw_usecnt, -1);
 
 	j = 0;
 	for (i = 0; i < ARRAY_SIZE(pdata->ch); i++) {
-- 
1.7.1


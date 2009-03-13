From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] video: sh_mobile_lcdcfb suspend/resume support
Date: Sat, 14 Mar 2009 00:36:55 +0900
Message-ID: <20090313153655.20515.14828.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds suspend/resume support to the LCDC
driver for SuperH Mobile - sh_mobile_lcdcfb.

We simply stop hardware on suspend and start it again
on resume. For RGB panels this is trivial, but for SYS
panels in deferred io mode this becomes a bit more
difficult - we need to wait for a frame end interrupt
to make sure the clocks are balanced before stopping
the actual hardware.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested on ap325 and Migo-R.

 drivers/video/sh_mobile_lcdcfb.c |   66 +++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 7 deletions(-)

--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2009-03-14 00:06:47.000000000 +0900
@@ -33,6 +33,8 @@ struct sh_mobile_lcdc_chan {
 	struct fb_info info;
 	dma_addr_t dma_handle;
 	struct fb_deferred_io defio;
+	unsigned long frame_end;
+	wait_queue_head_t frame_end_wait;
 };
 
 struct sh_mobile_lcdc_priv {
@@ -226,7 +228,10 @@ static void sh_mobile_lcdc_deferred_io_t
 static irqreturn_t sh_mobile_lcdc_irq(int irq, void *data)
 {
 	struct sh_mobile_lcdc_priv *priv = data;
+	struct sh_mobile_lcdc_chan *ch;
 	unsigned long tmp;
+	int is_sub;
+	int k;
 
 	/* acknowledge interrupt */
 	tmp = lcdc_read(priv, _LDINTR);
@@ -234,8 +239,24 @@ static irqreturn_t sh_mobile_lcdc_irq(in
 	tmp |= 0x000000ff ^ LDINTR_FS; /* status in low 8 */
 	lcdc_write(priv, _LDINTR, tmp);
 
-	/* disable clocks */
-	sh_mobile_lcdc_clk_off(priv);
+	/* figure out if this interrupt is for main or sub lcd */
+	is_sub = (lcdc_read(priv, _LDSR) & (1 << 10)) ? 1 : 0;
+
+	/* wake up channel and disable clocks*/
+	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
+		ch = &priv->ch[k];
+
+		if (!ch->enabled)
+			continue;
+
+		if (is_sub == lcdc_chan_is_sublcd(ch)) {
+			ch->frame_end = 1;
+			wake_up(&ch->frame_end_wait);
+
+			sh_mobile_lcdc_clk_off(priv);
+		}
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -448,18 +469,27 @@ static void sh_mobile_lcdc_stop(struct s
 	struct sh_mobile_lcdc_board_cfg	*board_cfg;
 	int k;
 
-	/* tell the board code to disable the panel */
+	/* clean up deferred io and ask board code to disable panel */
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
 		ch = &priv->ch[k];
-		board_cfg = &ch->cfg.board_cfg;
-		if (board_cfg->display_off)
-			board_cfg->display_off(board_cfg->board_data);
 
-		/* cleanup deferred io if enabled */
+		/* deferred io mode:
+		 * flush frame, and wait for frame end interrupt
+		 * clean up deferred io and enable clock
+		 */
 		if (ch->info.fbdefio) {
+			ch->frame_end = 0;
+			schedule_delayed_work(&ch->info.deferred_work, 0);
+			wait_event(ch->frame_end_wait, ch->frame_end);
 			fb_deferred_io_cleanup(&ch->info);
 			ch->info.fbdefio = NULL;
+			sh_mobile_lcdc_clk_on(priv);
 		}
+
+		board_cfg = &ch->cfg.board_cfg;
+		if (board_cfg->display_off)
+			board_cfg->display_off(board_cfg->board_data);
+
 	}
 
 	/* stop the lcdc */
@@ -652,6 +682,26 @@ static int sh_mobile_lcdc_set_bpp(struct
 	return 0;
 }
 
+static int sh_mobile_lcdc_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	sh_mobile_lcdc_stop(platform_get_drvdata(pdev));
+	return 0;
+}
+
+static int sh_mobile_lcdc_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return sh_mobile_lcdc_start(platform_get_drvdata(pdev));
+}
+
+static struct dev_pm_ops sh_mobile_lcdc_dev_pm_ops = {
+	.suspend = sh_mobile_lcdc_suspend,
+	.resume = sh_mobile_lcdc_resume,
+};
+
 static int sh_mobile_lcdc_remove(struct platform_device *pdev);
 
 static int __init sh_mobile_lcdc_probe(struct platform_device *pdev)
@@ -707,6 +757,7 @@ static int __init sh_mobile_lcdc_probe(s
 			dev_err(&pdev->dev, "unsupported interface type\n");
 			goto err1;
 		}
+		init_waitqueue_head(&priv->ch[i].frame_end_wait);
 
 		switch (pdata->ch[i].chan) {
 		case LCDC_CHAN_MAINLCD:
@@ -860,6 +911,7 @@ static struct platform_driver sh_mobile_
 	.driver		= {
 		.name		= "sh_mobile_lcdc_fb",
 		.owner		= THIS_MODULE,
+		.pm		= &sh_mobile_lcdc_dev_pm_ops,
 	},
 	.probe		= sh_mobile_lcdc_probe,
 	.remove		= sh_mobile_lcdc_remove,

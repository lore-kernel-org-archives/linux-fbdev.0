From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 22 Sep 2013 10:01:49 +0000
Subject: [PATCH 2/2] video: jz4740-fb: Use clk_prepare_enable/clk_disable_unprepare
Message-Id: <1379844109-10513-2-git-send-email-lars@metafoo.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

In preparation to switching the jz4740 clk driver to the common clk framework
update the clk enable/disable calls to clk_prepare_enable/clk_disable_unprepare.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/video/jz4740_fb.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index 23aa475..3f99dcb 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -471,7 +471,7 @@ static int jzfb_set_par(struct fb_info *info)
 	writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
 
 	if (!jzfb->is_enabled)
-		clk_disable(jzfb->ldclk);
+		clk_disable_unprepare(jzfb->ldclk);
 
 	mutex_unlock(&jzfb->lock);
 
@@ -485,7 +485,7 @@ static void jzfb_enable(struct jzfb *jzfb)
 {
 	uint32_t ctrl;
 
-	clk_enable(jzfb->ldclk);
+	clk_prepare_enable(jzfb->ldclk);
 
 	jz_gpio_bulk_resume(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
 	jz_gpio_bulk_resume(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
@@ -514,7 +514,7 @@ static void jzfb_disable(struct jzfb *jzfb)
 	jz_gpio_bulk_suspend(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
 	jz_gpio_bulk_suspend(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
 
-	clk_disable(jzfb->ldclk);
+	clk_disable_unprepare(jzfb->ldclk);
 }
 
 static int jzfb_blank(int blank_mode, struct fb_info *info)
@@ -693,7 +693,7 @@ static int jzfb_probe(struct platform_device *pdev)
 
 	fb_alloc_cmap(&fb->cmap, 256, 0);
 
-	clk_enable(jzfb->ldclk);
+	clk_prepare_enable(jzfb->ldclk);
 	jzfb->is_enabled = 1;
 
 	writel(jzfb->framedesc->next, jzfb->base + JZ_REG_LCD_DA0);
@@ -763,7 +763,7 @@ static int jzfb_suspend(struct device *dev)
 static int jzfb_resume(struct device *dev)
 {
 	struct jzfb *jzfb = dev_get_drvdata(dev);
-	clk_enable(jzfb->ldclk);
+	clk_prepare_enable(jzfb->ldclk);
 
 	mutex_lock(&jzfb->lock);
 	if (jzfb->is_enabled)
-- 
1.7.10.4


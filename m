From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 25 Sep 2012 14:23:41 +0000
Subject: [PATCH] da8xx-fb: save and restore LCDC context across suspend/resume cycle
Message-Id: <1348582301-27373-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Save and restore register context of LCDC respectively
before suspend and after resume.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Applies on top of below patch under review:
"da8xx-fb: add pm_runtime support"
 drivers/video/da8xx-fb.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 4280d23..65a11ef 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1491,6 +1491,69 @@ err_request_mem:
 }
 
 #ifdef CONFIG_PM
+struct lcdc_context {
+	u32 clk_enable;
+	u32 ctrl;
+	u32 dma_ctrl;
+	u32 raster_timing_0;
+	u32 raster_timing_1;
+	u32 raster_timing_2;
+	u32 int_enable_set;
+	u32 dma_frm_buf_base_addr_0;
+	u32 dma_frm_buf_ceiling_addr_0;
+	u32 dma_frm_buf_base_addr_1;
+	u32 dma_frm_buf_ceiling_addr_1;
+	u32 raster_ctrl;
+} reg_context;
+
+static void lcd_context_save(void)
+{
+	if (lcd_revision = LCD_VERSION_2) {
+		reg_context.clk_enable = lcdc_read(LCD_CLK_ENABLE_REG);
+		reg_context.int_enable_set = lcdc_read(LCD_INT_ENABLE_SET_REG);
+	}
+
+	reg_context.ctrl = lcdc_read(LCD_CTRL_REG);
+	reg_context.dma_ctrl = lcdc_read(LCD_DMA_CTRL_REG);
+	reg_context.raster_timing_0 = lcdc_read(LCD_RASTER_TIMING_0_REG);
+	reg_context.raster_timing_1 = lcdc_read(LCD_RASTER_TIMING_1_REG);
+	reg_context.raster_timing_2 = lcdc_read(LCD_RASTER_TIMING_2_REG);
+	reg_context.dma_frm_buf_base_addr_0 +		lcdc_read(LCD_DMA_FRM_BUF_BASE_ADDR_0_REG);
+	reg_context.dma_frm_buf_ceiling_addr_0 +		lcdc_read(LCD_DMA_FRM_BUF_CEILING_ADDR_0_REG);
+	reg_context.dma_frm_buf_base_addr_1 +		lcdc_read(LCD_DMA_FRM_BUF_BASE_ADDR_1_REG);
+	reg_context.dma_frm_buf_ceiling_addr_1 +		lcdc_read(LCD_DMA_FRM_BUF_CEILING_ADDR_1_REG);
+	reg_context.raster_ctrl = lcdc_read(LCD_RASTER_CTRL_REG);
+	return;
+}
+
+static void lcd_context_restore(void)
+{
+	if (lcd_revision = LCD_VERSION_2) {
+		lcdc_write(reg_context.clk_enable, LCD_CLK_ENABLE_REG);
+		lcdc_write(reg_context.int_enable_set, LCD_INT_ENABLE_SET_REG);
+	}
+
+	lcdc_write(reg_context.ctrl, LCD_CTRL_REG);
+	lcdc_write(reg_context.dma_ctrl, LCD_DMA_CTRL_REG);
+	lcdc_write(reg_context.raster_timing_0, LCD_RASTER_TIMING_0_REG);
+	lcdc_write(reg_context.raster_timing_1, LCD_RASTER_TIMING_1_REG);
+	lcdc_write(reg_context.raster_timing_2, LCD_RASTER_TIMING_2_REG);
+	lcdc_write(reg_context.dma_frm_buf_base_addr_0,
+			LCD_DMA_FRM_BUF_BASE_ADDR_0_REG);
+	lcdc_write(reg_context.dma_frm_buf_ceiling_addr_0,
+			LCD_DMA_FRM_BUF_CEILING_ADDR_0_REG);
+	lcdc_write(reg_context.dma_frm_buf_base_addr_1,
+			LCD_DMA_FRM_BUF_BASE_ADDR_1_REG);
+	lcdc_write(reg_context.dma_frm_buf_ceiling_addr_1,
+			LCD_DMA_FRM_BUF_CEILING_ADDR_1_REG);
+	lcdc_write(reg_context.raster_ctrl, LCD_RASTER_CTRL_REG);
+	return;
+}
+
 static int fb_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
@@ -1502,6 +1565,7 @@ static int fb_suspend(struct platform_device *dev, pm_message_t state)
 
 	fb_set_suspend(info, 1);
 	lcd_disable_raster(true);
+	lcd_context_save();
 	pm_runtime_put_sync(&dev->dev);
 	console_unlock();
 
@@ -1514,6 +1578,7 @@ static int fb_resume(struct platform_device *dev)
 
 	console_lock();
 	pm_runtime_get_sync(&dev->dev);
+	lcd_context_restore();
 	if (par->blank = FB_BLANK_UNBLANK) {
 		lcd_enable_raster();
 
-- 
1.7.0.4


From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 24 Jul 2012 03:55:33 +0000
Subject: [PATCH v2] da8xx-fb: enable sync lost interrupt
Message-Id: <1343101413-1820-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Patch enables sync lost interrupt and interrupt handler already
takes care to handle it.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Since v1:
Minor nit, replaced spaces with tabs.

 drivers/video/da8xx-fb.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 47118c7..8163832 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -54,6 +54,7 @@
 #define LCD_DMA_BURST_8			0x3
 #define LCD_DMA_BURST_16		0x4
 #define LCD_V1_END_OF_FRAME_INT_ENA	BIT(2)
+#define LCD_V1_SYNC_LOST_ENA		BIT(5)
 #define LCD_V2_END_OF_FRAME0_INT_ENA	BIT(8)
 #define LCD_V2_END_OF_FRAME1_INT_ENA	BIT(9)
 #define LCD_DUAL_FRAME_BUFFER_ENABLE	BIT(0)
@@ -441,10 +442,10 @@ static int lcd_cfg_display(const struct lcd_ctrl_config *cfg)
 
 	/* enable additional interrupts here */
 	if (lcd_revision = LCD_VERSION_1) {
-		reg |= LCD_V1_UNDERFLOW_INT_ENA;
+		reg |= LCD_V1_UNDERFLOW_INT_ENA | LCD_V1_SYNC_LOST_ENA;
 	} else {
 		reg_int = lcdc_read(LCD_INT_ENABLE_SET_REG) |
-			LCD_V2_UNDERFLOW_INT_ENA;
+			LCD_V2_UNDERFLOW_INT_ENA | LCD_SYNC_LOST;
 		lcdc_write(reg_int, LCD_INT_ENABLE_SET_REG);
 	}
 
@@ -718,6 +719,7 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
 	u32 reg_int;
 
 	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
+		pr_err("LCDC sync lost or underflow error occurred\n");
 		lcd_disable_raster();
 		lcdc_write(stat, LCD_MASKED_STAT_REG);
 		lcd_enable_raster();
@@ -773,6 +775,7 @@ static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
 	u32 reg_ras;
 
 	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
+		pr_err("LCDC sync lost or underflow error occurred\n");
 		lcd_disable_raster();
 		lcdc_write(stat, LCD_STAT_REG);
 		lcd_enable_raster();
-- 
1.7.1


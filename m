From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Wed, 18 Jul 2012 15:42:17 +0000
Subject: [PATCH RESEND] video: da8xx-fb: enable sync lost interrupt
Message-Id: <1342625417-6974-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Patch enables sync lost interrupt and interrupt handler already
takes care to handle it.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Resending as my earlier patch seems like not reached fbdev mailing list.

 drivers/video/da8xx-fb.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 88e98ea..e9d2f6e 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -54,6 +54,7 @@
 #define LCD_DMA_BURST_8			0x3
 #define LCD_DMA_BURST_16		0x4
 #define LCD_V1_END_OF_FRAME_INT_ENA	BIT(2)
+#define LCD_V1_SYNC_LOST_ENA            BIT(5)
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
 
-- 
1.7.1


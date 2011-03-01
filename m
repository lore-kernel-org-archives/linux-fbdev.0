From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Tue, 01 Mar 2011 12:06:05 +0000
Subject: [PATCH 5/6] FBDEV: JZ4740: Get rid of enumeration value not handled in switch warnings
Message-Id: <1202f26b58f8dea782600827a158f08b1775953b.1298980528.git.mcuelenaere@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Convert enum jz4740_fb_lcd_type to #define's in order to get rid of these
warnings.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/mips/include/asm/mach-jz4740/jz4740_fb.h |   40 ++++++++++++-------------
 1 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_fb.h b/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
index eaaac43..d6c11f2 100644
--- a/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
+++ b/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
@@ -17,27 +17,25 @@
 
 #include <linux/fb.h>
 
-enum jz4740_fb_lcd_type {
-	JZ_LCD_TYPE_GENERIC_16_BIT = 0,
-	JZ_LCD_TYPE_GENERIC_18_BIT = 0 | (1 << 4),
-	JZ_LCD_TYPE_SPECIAL_TFT_1 = 1,
-	JZ_LCD_TYPE_SPECIAL_TFT_2 = 2,
-	JZ_LCD_TYPE_SPECIAL_TFT_3 = 3,
-	JZ_LCD_TYPE_NON_INTERLACED_CCIR656 = 5,
-	JZ_LCD_TYPE_INTERLACED_CCIR656 = 7,
-	JZ_LCD_TYPE_SINGLE_COLOR_STN = 8,
-	JZ_LCD_TYPE_SINGLE_MONOCHROME_STN = 9,
-	JZ_LCD_TYPE_DUAL_COLOR_STN = 10,
-	JZ_LCD_TYPE_DUAL_MONOCHROME_STN = 11,
-	JZ_LCD_TYPE_8BIT_SERIAL = 12,
+#define JZ_LCD_TYPE_GENERIC_16_BIT		(0)
+#define JZ_LCD_TYPE_GENERIC_18_BIT		(0 | (1 << 4))
+#define JZ_LCD_TYPE_SPECIAL_TFT_1		(1)
+#define JZ_LCD_TYPE_SPECIAL_TFT_2		(2)
+#define JZ_LCD_TYPE_SPECIAL_TFT_3		(3)
+#define JZ_LCD_TYPE_NON_INTERLACED_CCIR656	(5)
+#define JZ_LCD_TYPE_INTERLACED_CCIR656		(7)
+#define JZ_LCD_TYPE_SINGLE_COLOR_STN		(8)
+#define JZ_LCD_TYPE_SINGLE_MONOCHROME_STN	(9)
+#define JZ_LCD_TYPE_DUAL_COLOR_STN		(10)
+#define JZ_LCD_TYPE_DUAL_MONOCHROME_STN		(11)
+#define JZ_LCD_TYPE_8BIT_SERIAL			(12)
 
-	JZ_SLCD_TYPE_PARALLEL_8_BIT = 1 | (1 << 5),
-	JZ_SLCD_TYPE_PARALLEL_16_BIT = 0 | (1 << 5),
-	JZ_SLCD_TYPE_PARALLEL_18_BIT = 2 | (1 << 5),
-	JZ_SLCD_TYPE_SERIAL_8_BIT = 1 | (3 << 5),
-	JZ_SLCD_TYPE_SERIAL_16_BIT = 0 | (3 << 5),
-	JZ_SLCD_TYPE_SERIAL_18_BIT = 2 | (3 << 5),
-};
+#define JZ_SLCD_TYPE_PARALLEL_8_BIT		(1 | (1 << 5))
+#define JZ_SLCD_TYPE_PARALLEL_16_BIT		(0 | (1 << 5))
+#define JZ_SLCD_TYPE_PARALLEL_18_BIT		(2 | (1 << 5))
+#define JZ_SLCD_TYPE_SERIAL_8_BIT		(1 | (3 << 5))
+#define JZ_SLCD_TYPE_SERIAL_16_BIT		(0 | (3 << 5))
+#define JZ_SLCD_TYPE_SERIAL_18_BIT		(2 | (3 << 5))
 
 #define JZ4740_FB_SPECIAL_TFT_CONFIG(start, stop) (((start) << 16) | (stop))
 
@@ -58,7 +56,7 @@ struct jz4740_fb_platform_data {
 	struct fb_videomode *modes;
 
 	unsigned int bpp;
-	enum jz4740_fb_lcd_type lcd_type;
+	unsigned int lcd_type;
 
 	struct {
 		uint32_t spl;
-- 
1.7.4


From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 21 Jul 2019 07:39:40 +0000
Subject: [PATCH] backlight: add include guards to platform_lcd.h and ili9320.h
Message-Id: <20190721073940.11422-1-yamada.masahiro@socionext.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org

Add header include guards just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/video/ili9320.h      | 4 ++++
 include/video/platform_lcd.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/video/ili9320.h b/include/video/ili9320.h
index 62f424f0bc52..b76a0b8f16fc 100644
--- a/include/video/ili9320.h
+++ b/include/video/ili9320.h
@@ -9,6 +9,9 @@
  * http://armlinux.simtec.co.uk/
 */
 
+#ifndef _VIDEO_ILI9320_H
+#define _VIDEO_ILI9320_H
+
 #define ILI9320_REG(x)	(x)
 
 #define ILI9320_INDEX			ILI9320_REG(0x00)
@@ -196,3 +199,4 @@ struct ili9320_platdata {
 	unsigned short	interface6;
 };
 
+#endif /* _VIDEO_ILI9320_H */
diff --git a/include/video/platform_lcd.h b/include/video/platform_lcd.h
index 6a95184a28c1..c68f3f45b5c1 100644
--- a/include/video/platform_lcd.h
+++ b/include/video/platform_lcd.h
@@ -7,6 +7,9 @@
  * Generic platform-device LCD power control interface.
 */
 
+#ifndef _VIDEO_PLATFORM_LCD_H
+#define _VIDEO_PLATFORM_LCD_H
+
 struct plat_lcd_data;
 struct fb_info;
 
@@ -16,3 +19,4 @@ struct plat_lcd_data {
 	int	(*match_fb)(struct plat_lcd_data *, struct fb_info *);
 };
 
+#endif /* _VIDEO_PLATFORM_LCD_H */
-- 
2.17.1

From: Paul Burton <paul.burton@imgtec.com>
Date: Tue, 09 Aug 2016 12:35:41 +0000
Subject: [PATCH 16/20] fbdev: cobalt_lcdfb: Drop SEAD3 support
Message-Id: <20160809123546.10190-17-paul.burton@imgtec.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160809123546.10190-1-paul.burton@imgtec.com>
In-Reply-To: <20160809123546.10190-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>, Ondrej Zary <linux@rainbow-software.org>, linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Robert Jarzmik <robert.jarzmik@free.fr>, "Maciej W. Rozycki" <macro@linux-mips.org>, Linus Walleij <linus.walleij@linaro.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>

The SEAD3 board no longer uses the cobalt_lcdfb driver, so remove the
SEAD3-specific code from it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/video/fbdev/Kconfig        |  2 +-
 drivers/video/fbdev/cobalt_lcdfb.c | 42 --------------------------------------
 2 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 88b008f..914bfb2 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2183,7 +2183,7 @@ config FB_GOLDFISH
 
 config FB_COBALT
 	tristate "Cobalt server LCD frame buffer support"
-	depends on FB && (MIPS_COBALT || MIPS_SEAD3)
+	depends on FB && MIPS_COBALT
 
 config FB_SH7760
 	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
diff --git a/drivers/video/fbdev/cobalt_lcdfb.c b/drivers/video/fbdev/cobalt_lcdfb.c
index 07675d6..2d3b691 100644
--- a/drivers/video/fbdev/cobalt_lcdfb.c
+++ b/drivers/video/fbdev/cobalt_lcdfb.c
@@ -63,7 +63,6 @@
 #define LCD_CUR_POS(x)		((x) & LCD_CUR_POS_MASK)
 #define LCD_TEXT_POS(x)		((x) | LCD_TEXT_MODE)
 
-#ifdef CONFIG_MIPS_COBALT
 static inline void lcd_write_control(struct fb_info *info, u8 control)
 {
 	writel((u32)control << 24, info->screen_base);
@@ -83,47 +82,6 @@ static inline u8 lcd_read_data(struct fb_info *info)
 {
 	return readl(info->screen_base + LCD_DATA_REG_OFFSET) >> 24;
 }
-#else
-
-#define LCD_CTL			0x00
-#define LCD_DATA		0x08
-#define CPLD_STATUS		0x10
-#define CPLD_DATA		0x18
-
-static inline void cpld_wait(struct fb_info *info)
-{
-	do {
-	} while (readl(info->screen_base + CPLD_STATUS) & 1);
-}
-
-static inline void lcd_write_control(struct fb_info *info, u8 control)
-{
-	cpld_wait(info);
-	writel(control, info->screen_base + LCD_CTL);
-}
-
-static inline u8 lcd_read_control(struct fb_info *info)
-{
-	cpld_wait(info);
-	readl(info->screen_base + LCD_CTL);
-	cpld_wait(info);
-	return readl(info->screen_base + CPLD_DATA) & 0xff;
-}
-
-static inline void lcd_write_data(struct fb_info *info, u8 data)
-{
-	cpld_wait(info);
-	writel(data, info->screen_base + LCD_DATA);
-}
-
-static inline u8 lcd_read_data(struct fb_info *info)
-{
-	cpld_wait(info);
-	readl(info->screen_base + LCD_DATA);
-	cpld_wait(info);
-	return readl(info->screen_base + CPLD_DATA) & 0xff;
-}
-#endif
 
 static int lcd_busy_wait(struct fb_info *info)
 {
-- 
2.9.2


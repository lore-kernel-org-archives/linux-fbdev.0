From: "Steven J. Hill" <sjhill@mips.com>
Date: Wed, 18 Apr 2012 14:11:49 +0000
Subject: [RESEND][PATCH 09/10] cobalt_lcdfb: LCD panel framebuffer support for SEAD-3 platform.
Message-Id: <1334758309-3986-1-git-send-email-sjhill@mips.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: "Steven J. Hill" <sjhill@mips.com>

Add support for LCD panel on MIPS SEAD-3 development platform.

Signed-off-by: Douglas Leung <douglas@mips.com>
Signed-off-by: Chris Dearman <chris@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 drivers/video/Kconfig        |    2 +-
 drivers/video/cobalt_lcdfb.c |   45 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index a8a897a..e921a45 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2210,7 +2210,7 @@ config FB_XILINX
 
 config FB_COBALT
 	tristate "Cobalt server LCD frame buffer support"
-	depends on FB && MIPS_COBALT
+	depends on FB && (MIPS_COBALT || MIPS_SEAD3)
 
 config FB_SH7760
 	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
diff --git a/drivers/video/cobalt_lcdfb.c b/drivers/video/cobalt_lcdfb.c
index f56699d..eae46f6 100644
--- a/drivers/video/cobalt_lcdfb.c
+++ b/drivers/video/cobalt_lcdfb.c
@@ -1,7 +1,8 @@
 /*
- *  Cobalt server LCD frame buffer driver.
+ *  Cobalt/SEAD3 LCD frame buffer driver.
  *
  *  Copyright (C) 2008  Yoichi Yuasa <yuasa@linux-mips.org>
+ *  Copyright (C) 2012  MIPS Technologies, Inc.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -62,6 +63,7 @@
 #define LCD_CUR_POS(x)		((x) & LCD_CUR_POS_MASK)
 #define LCD_TEXT_POS(x)		((x) | LCD_TEXT_MODE)
 
+#ifdef CONFIG_MIPS_COBALT
 static inline void lcd_write_control(struct fb_info *info, u8 control)
 {
 	writel((u32)control << 24, info->screen_base);
@@ -81,6 +83,47 @@ static inline u8 lcd_read_data(struct fb_info *info)
 {
 	return readl(info->screen_base + LCD_DATA_REG_OFFSET) >> 24;
 }
+#else
+
+#define LCD_CTL			0x00
+#define LCD_DATA		0x08
+#define CPLD_STATUS		0x10
+#define CPLD_DATA		0x18
+
+static inline void cpld_wait(struct fb_info *info)
+{
+	do {
+	} while (readl(info->screen_base + CPLD_STATUS) & 1);
+}
+
+static inline void lcd_write_control(struct fb_info *info, u8 control)
+{
+	cpld_wait(info);
+	writel(control, info->screen_base + LCD_CTL);
+}
+
+static inline u8 lcd_read_control(struct fb_info *info)
+{
+	cpld_wait(info);
+	readl(info->screen_base + LCD_CTL);
+	cpld_wait(info);
+	return readl(info->screen_base + CPLD_DATA) & 0xff;
+}
+
+static inline void lcd_write_data(struct fb_info *info, u8 data)
+{
+	cpld_wait(info);
+	writel(data, info->screen_base + LCD_DATA);
+}
+
+static inline u8 lcd_read_data(struct fb_info *info)
+{
+	cpld_wait(info);
+	readl(info->screen_base + LCD_DATA);
+	cpld_wait(info);
+	return readl(info->screen_base + CPLD_DATA) & 0xff;
+}
+#endif
 
 static int lcd_busy_wait(struct fb_info *info)
 {
-- 
1.7.9.6


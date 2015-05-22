From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 May 2015 14:22:16 +0000
Subject: [PATCH] video: omap/h3: fix tps65010 dependency
Message-Id: <4416278.oVFvT3Eyqf@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The h3 LCD driver fails to link when tps65010 is configured
as a loadable module:

drivers/built-in.o: In function `h3_panel_disable':
debugfs.c:(.text+0x206ac): undefined reference to `tps65010_set_gpio_out_value'
debugfs.c:(.text+0x206cc): undefined reference to `tps65010_set_gpio_out_value'
drivers/built-in.o: In function `h3_panel_enable':
debugfs.c:(.text+0x206e0): undefined reference to `tps65010_set_gpio_out_value'
debugfs.c:(.text+0x20704): undefined reference to `tps65010_set_gpio_out_value'

This clarifies the dependency so we can only select it if
the dependnecy is built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/video/fbdev/omap/Kconfig b/drivers/video/fbdev/omap/Kconfig
index 18c4cb0d5690..29d250da8a3e 100644
--- a/drivers/video/fbdev/omap/Kconfig
+++ b/drivers/video/fbdev/omap/Kconfig
@@ -42,7 +42,7 @@ config FB_OMAP_LCD_MIPID
 config FB_OMAP_LCD_H3
 	bool "TPS65010 LCD controller on OMAP-H3"
 	depends on MACH_OMAP_H3
-	depends on TPS65010
+	depends on TPS65010=y
 	default y
 	help
 	  Say Y here if you want to have support for the LCD on the


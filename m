From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 26 Aug 2016 15:34:29 +0000
Subject: [PATCH] video: ARM CLCD: export symbols for driver module
Message-Id: <20160826153500.768744-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Linus Walleij <linus.walleij@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The amba-clcd-versatile.c code is always built-in and has to
be done that way because it gets called by platform code that is
also built-in. However, it now also gets called from the
core CLCD driver through the .init_panel callback function,
which leads to a build error when the framebuffer is configured
as a loadable module:

ERROR: "versatile_clcd_init_panel" [drivers/video/fbdev/amba-clcd-mod.ko] undefined!

The same thing happens for the nomadik driver, although that
could be linked into the core module if we want to:

ERROR: "nomadik_clcd_init_panel" [drivers/video/fbdev/amba-clcd.ko] undefined!
ERROR: "nomadik_clcd_init_board" [drivers/video/fbdev/amba-clcd.ko] undefined!

For consistency, I'm taking the same approach in both cases here
and just export the functions to make them usable by the driver.

Alternatively, we could split out the CONFIG_OF-code from amba-clcd-versatile.c
into a new file and link those two together with the core driver as one
module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 1d3f0cbe0d3a ("video: ARM CLCD: add special board and panel hooks for Nomadik")
Fixes: 25348160e9a4 ("video: ARM CLCD: add special panel hook for Versatiles")
---
 drivers/video/fbdev/amba-clcd-nomadik.c   | 2 ++
 drivers/video/fbdev/amba-clcd-versatile.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/amba-clcd-nomadik.c b/drivers/video/fbdev/amba-clcd-nomadik.c
index 243167c8ee15..0c06fcaaa6e8 100644
--- a/drivers/video/fbdev/amba-clcd-nomadik.c
+++ b/drivers/video/fbdev/amba-clcd-nomadik.c
@@ -231,6 +231,7 @@ int nomadik_clcd_init_panel(struct clcd_fb *fb,
 	/* Unknown panel, fall through */
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nomadik_clcd_init_panel);
 
 #define PMU_CTRL_OFFSET 0x0000
 #define PMU_CTRL_LCDNDIF BIT(26)
@@ -255,3 +256,4 @@ int nomadik_clcd_init_board(struct amba_device *adev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nomadik_clcd_init_board);
diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/fbdev/amba-clcd-versatile.c
index 9a90817b1550..dc3c153cad0f 100644
--- a/drivers/video/fbdev/amba-clcd-versatile.c
+++ b/drivers/video/fbdev/amba-clcd-versatile.c
@@ -567,5 +567,5 @@ int versatile_clcd_init_panel(struct clcd_fb *fb,
 
 	return 0;
 }
-
+EXPORT_SYMBOL_GPL(versatile_clcd_init_panel);
 #endif
-- 
2.9.0


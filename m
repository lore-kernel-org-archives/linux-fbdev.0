From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Jan 2012 10:00:22 +0000
Subject: [PATCH 07/16] OAMPFB: remove unused omapfb_set_ctrl_platform_data()
Message-Id: <1327399231-20826-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb_set_ctrl_platform_data() is no longer used, so it can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/fb.c |    5 -----
 include/linux/omapfb.h  |    2 --
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index 15d4d16..a05ab56 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -175,11 +175,6 @@ void __init omapfb_reserve_sdram_memblock(void)
 			 reserved);
 }
 
-void omapfb_set_ctrl_platform_data(void *data)
-{
-	omapfb_config.ctrl_platform_data = data;
-}
-
 static int __init omap_init_fb(void)
 {
 	const struct omap_lcd_config *conf;
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index c0b0187..85cad31 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -250,12 +250,10 @@ struct omapfb_mem_desc {
 struct omapfb_platform_data {
 	struct omap_lcd_config		lcd;
 	struct omapfb_mem_desc		mem_desc;
-	void				*ctrl_platform_data;
 };
 
 /* in arch/arm/plat-omap/fb.c */
 extern void omapfb_set_platform_data(struct omapfb_platform_data *data);
-extern void omapfb_set_ctrl_platform_data(void *pdata);
 extern void omapfb_reserve_sdram_memblock(void);
 
 #endif
-- 
1.7.4.1


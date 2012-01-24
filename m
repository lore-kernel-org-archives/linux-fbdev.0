From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Jan 2012 10:00:27 +0000
Subject: [PATCH 12/16] OMAPFB: remove omapfb_set_platform_data()
Message-Id: <1327399231-20826-13-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb_set_platform_data() is no longer used, so remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/fb.c |   15 ---------------
 include/linux/omapfb.h  |    3 ---
 2 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index a742b60..45f35c9 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -52,10 +52,6 @@ static struct platform_device omap_fb_device = {
 	.num_resources = 0,
 };
 
-void omapfb_set_platform_data(struct omapfb_platform_data *data)
-{
-}
-
 static int __init omap_init_fb(void)
 {
 	const struct omap_lcd_config *conf;
@@ -87,11 +83,6 @@ static struct platform_device omap_fb_device = {
 	.num_resources = 0,
 };
 
-void omapfb_set_platform_data(struct omapfb_platform_data *data)
-{
-	omapfb_config = *data;
-}
-
 static int __init omap_init_fb(void)
 {
 	return platform_device_register(&omap_fb_device);
@@ -99,10 +90,4 @@ static int __init omap_init_fb(void)
 
 arch_initcall(omap_init_fb);
 
-#else
-
-void omapfb_set_platform_data(struct omapfb_platform_data *data)
-{
-}
-
 #endif
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index 7a8e0ea..a575706 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -226,9 +226,6 @@ struct omapfb_platform_data {
 	struct omap_lcd_config		lcd;
 };
 
-/* in arch/arm/plat-omap/fb.c */
-extern void omapfb_set_platform_data(struct omapfb_platform_data *data);
-
 #endif
 
 #endif /* __OMAPFB_H */
-- 
1.7.4.1


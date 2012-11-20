From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Tue, 20 Nov 2012 15:54:53 +0000
Subject: [PATCH v12 3/6] fbmon: add videomode helpers
Message-Id: <1353426896-6045-4-git-send-email-s.trumtrar@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353426896-6045-1-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1353426896-6045-1-git-send-email-s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Add a function to convert from the generic videomode to a fb_videomode.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
Acked-by: Thierry Reding <thierry.reding@avionic-design.de>
Tested-by: Thierry Reding <thierry.reding@avionic-design.de>
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/fbmon.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fb.h    |    6 ++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index cef6557..c1939a6 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -31,6 +31,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <video/edid.h>
+#include <linux/videomode.h>
 #ifdef CONFIG_PPC_OF
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
@@ -1373,6 +1374,51 @@ int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var, struct fb_inf
 	kfree(timings);
 	return err;
 }
+
+#if IS_ENABLED(CONFIG_VIDEOMODE)
+int fb_videomode_from_videomode(const struct videomode *vm,
+				struct fb_videomode *fbmode)
+{
+	unsigned int htotal, vtotal;
+
+	fbmode->xres = vm->hactive;
+	fbmode->left_margin = vm->hback_porch;
+	fbmode->right_margin = vm->hfront_porch;
+	fbmode->hsync_len = vm->hsync_len;
+
+	fbmode->yres = vm->vactive;
+	fbmode->upper_margin = vm->vback_porch;
+	fbmode->lower_margin = vm->vfront_porch;
+	fbmode->vsync_len = vm->vsync_len;
+
+	fbmode->pixclock = KHZ2PICOS(vm->pixelclock / 1000);
+
+	fbmode->sync = 0;
+	fbmode->vmode = 0;
+	if (vm->hah)
+		fbmode->sync |= FB_SYNC_HOR_HIGH_ACT;
+	if (vm->vah)
+		fbmode->sync |= FB_SYNC_VERT_HIGH_ACT;
+	if (vm->interlaced)
+		fbmode->vmode |= FB_VMODE_INTERLACED;
+	if (vm->doublescan)
+		fbmode->vmode |= FB_VMODE_DOUBLE;
+	if (vm->de)
+		fbmode->sync |= FB_SYNC_DATA_ENABLE_HIGH_ACT;
+	fbmode->flag = 0;
+
+	htotal = vm->hactive + vm->hfront_porch + vm->hback_porch +
+		 vm->hsync_len;
+	vtotal = vm->vactive + vm->vfront_porch + vm->vback_porch +
+		 vm->vsync_len;
+	fbmode->refresh = (vm->pixelclock * 1000) / (htotal * vtotal);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fb_videomode_from_videomode);
+#endif
+
+
 #else
 int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 {
diff --git a/include/linux/fb.h b/include/linux/fb.h
index c7a9571..920cbe3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -14,6 +14,7 @@
 #include <linux/backlight.h>
 #include <linux/slab.h>
 #include <asm/io.h>
+#include <linux/videomode.h>
 
 struct vm_area_struct;
 struct fb_info;
@@ -714,6 +715,11 @@ extern void fb_destroy_modedb(struct fb_videomode *modedb);
 extern int fb_find_mode_cvt(struct fb_videomode *mode, int margins, int rb);
 extern unsigned char *fb_ddc_read(struct i2c_adapter *adapter);
 
+#if IS_ENABLED(CONFIG_VIDEOMODE)
+extern int fb_videomode_from_videomode(const struct videomode *vm,
+				       struct fb_videomode *fbmode);
+#endif
+
 /* drivers/video/modedb.c */
 #define VESA_MODEDB_SIZE 34
 extern void fb_var_to_videomode(struct fb_videomode *mode,
-- 
1.7.10.4


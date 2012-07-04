From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 04 Jul 2012 07:56:35 +0000
Subject: [PATCH v2] of: Add videomode helper
Message-Id: <1341388595-30672-1-git-send-email-s.hauer@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org

This patch adds a helper function for parsing videomodes from the devicetree.
The videomode can be either converted to a struct drm_display_mode or a
struct fb_videomode.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

changes since v1:
- use hyphens instead of underscores for property names

 .../devicetree/bindings/video/displaymode          |   40 ++++++++
 drivers/of/Kconfig                                 |    5 +
 drivers/of/Makefile                                |    1 +
 drivers/of/of_videomode.c                          |  108 ++++++++++++++++++++
 include/linux/of_videomode.h                       |   19 ++++
 5 files changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/displaymode
 create mode 100644 drivers/of/of_videomode.c
 create mode 100644 include/linux/of_videomode.h

diff --git a/Documentation/devicetree/bindings/video/displaymode b/Documentation/devicetree/bindings/video/displaymode
new file mode 100644
index 0000000..43cc17d
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/displaymode
@@ -0,0 +1,40 @@
+videomode bindings
+=========
+
+Required properties:
+ - xres, yres: Display resolution
+ - left-margin, right-margin, hsync-len: Horizontal Display timing parameters
+   in pixels
+   upper-margin, lower-margin, vsync-len: Vertical display timing parameters in
+   lines
+ - clock: displayclock in Hz
+
+Optional properties:
+ - width-mm, height-mm: Display dimensions in mm
+ - hsync-active-high (bool): Hsync pulse is active high
+ - vsync-active-high (bool): Vsync pulse is active high
+ - interlaced (bool): This is an interlaced mode
+ - doublescan (bool): This is a doublescan mode
+
+There are different ways of describing a display mode. The devicetree representation
+corresponds to the one used by the Linux Framebuffer framework described here in
+Documentation/fb/framebuffer.txt. This representation has been chosen because it's
+the only format which does not allow for inconsistent parameters.Unlike the Framebuffer
+framework the devicetree has the clock in Hz instead of ps.
+
+Example:
+
+	display@0 {
+		/* 1920x1080p24 */
+		clock = <52000000>;
+		xres = <1920>;
+		yres = <1080>;
+		left-margin = <25>;
+		right-margin = <25>;
+		hsync-len = <25>;
+		lower-margin = <2>;
+		upper-margin = <2>;
+		vsync-len = <2>;
+		hsync-active-high;
+	};
+
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index dfba3e6..a3acaa3 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -83,4 +83,9 @@ config OF_MTD
 	depends on MTD
 	def_bool y
 
+config OF_VIDEOMODE
+	def_bool y
+	help
+	  helper to parse videomodes from the devicetree
+
 endmenu # OF
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index e027f44..80e6db3 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
 obj-$(CONFIG_OF_PCI)	+= of_pci.o
 obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
 obj-$(CONFIG_OF_MTD)	+= of_mtd.o
+obj-$(CONFIG_OF_VIDEOMODE)	+= of_videomode.o
diff --git a/drivers/of/of_videomode.c b/drivers/of/of_videomode.c
new file mode 100644
index 0000000..50d3bd2
--- /dev/null
+++ b/drivers/of/of_videomode.c
@@ -0,0 +1,108 @@
+/*
+ * OF helpers for parsing display modes
+ *
+ * Copyright (c) 2012 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
+ *
+ * This file is released under the GPLv2
+ */
+#include <linux/of.h>
+#include <linux/fb.h>
+#include <linux/export.h>
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+
+int of_get_video_mode(struct device_node *np, struct drm_display_mode *dmode,
+		struct fb_videomode *fbmode)
+{
+	int ret = 0;
+	u32 left_margin, xres, right_margin, hsync_len;
+	u32 upper_margin, yres, lower_margin, vsync_len;
+	u32 width_mm = 0, height_mm = 0;
+	u32 clock;
+	bool hah = false, vah = false, interlaced = false, doublescan = false;
+
+	if (!np)
+		return -EINVAL;
+
+	ret |= of_property_read_u32(np, "left-margin", &left_margin);
+	ret |= of_property_read_u32(np, "xres", &xres);
+	ret |= of_property_read_u32(np, "right-margin", &right_margin);
+	ret |= of_property_read_u32(np, "hsync-len", &hsync_len);
+	ret |= of_property_read_u32(np, "upper-margin", &upper_margin);
+	ret |= of_property_read_u32(np, "yres", &yres);
+	ret |= of_property_read_u32(np, "lower-margin", &lower_margin);
+	ret |= of_property_read_u32(np, "vsync-len", &vsync_len);
+	ret |= of_property_read_u32(np, "clock", &clock);
+	if (ret)
+		return -EINVAL;
+
+	of_property_read_u32(np, "width-mm", &width_mm);
+	of_property_read_u32(np, "height-mm", &height_mm);
+
+	hah = of_property_read_bool(np, "hsync-active-high");
+	vah = of_property_read_bool(np, "vsync-active-high");
+	interlaced = of_property_read_bool(np, "interlaced");
+	doublescan = of_property_read_bool(np, "doublescan");
+
+	if (dmode) {
+		memset(dmode, 0, sizeof(*dmode));
+
+		dmode->hdisplay = xres;
+		dmode->hsync_start = xres + right_margin;
+		dmode->hsync_end = xres + right_margin + hsync_len;
+		dmode->htotal = xres + right_margin + hsync_len + left_margin;
+
+		dmode->vdisplay = yres;
+		dmode->vsync_start = yres + lower_margin;
+		dmode->vsync_end = yres + lower_margin + vsync_len;
+		dmode->vtotal = yres + lower_margin + vsync_len + upper_margin;
+
+		dmode->width_mm = width_mm;
+		dmode->height_mm = height_mm;
+
+		dmode->clock = clock / 1000;
+
+		if (hah)
+			dmode->flags |= DRM_MODE_FLAG_PHSYNC;
+		else
+			dmode->flags |= DRM_MODE_FLAG_NHSYNC;
+		if (vah)
+			dmode->flags |= DRM_MODE_FLAG_PVSYNC;
+		else
+			dmode->flags |= DRM_MODE_FLAG_NVSYNC;
+		if (interlaced)
+			dmode->flags |= DRM_MODE_FLAG_INTERLACE;
+		if (doublescan)
+			dmode->flags |= DRM_MODE_FLAG_DBLSCAN;
+
+		drm_mode_set_name(dmode);
+	}
+
+	if (fbmode) {
+		memset(fbmode, 0, sizeof(*fbmode));
+
+		fbmode->xres = xres;
+		fbmode->left_margin = left_margin;
+		fbmode->right_margin = right_margin;
+		fbmode->hsync_len = hsync_len;
+
+		fbmode->yres = yres;
+		fbmode->upper_margin = upper_margin;
+		fbmode->lower_margin = lower_margin;
+		fbmode->vsync_len = vsync_len;
+
+		fbmode->pixclock = KHZ2PICOS(clock / 1000);
+
+		if (hah)
+			fbmode->sync |= FB_SYNC_HOR_HIGH_ACT;
+		if (vah)
+			fbmode->sync |= FB_SYNC_VERT_HIGH_ACT;
+		if (interlaced)
+			fbmode->vmode |= FB_VMODE_INTERLACED;
+		if (doublescan)
+			fbmode->vmode |= FB_VMODE_DOUBLE;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_get_video_mode);
diff --git a/include/linux/of_videomode.h b/include/linux/of_videomode.h
new file mode 100644
index 0000000..a988429
--- /dev/null
+++ b/include/linux/of_videomode.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright 2012 Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * OF helpers for videomodes.
+ *
+ * This file is released under the GPLv2
+ */
+
+#ifndef __LINUX_OF_VIDEOMODE_H
+#define __LINUX_OF_VIDEOMODE_H
+
+struct device_node;
+struct fb_videomode;
+struct drm_display_mode;
+
+int of_get_video_mode(struct device_node *np, struct drm_display_mode *dmode,
+		struct fb_videomode *fbmode);
+
+#endif /* __LINUX_OF_VIDEOMODE_H */
-- 
1.7.10


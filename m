From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 27 Mar 2013 06:58:22 +0000
Subject: [PATCHv2 2/5] videomode: combine videomode dmt_flags and data_flags
Message-Id: <1364367505-4366-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364367505-4366-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1364367505-4366-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Both videomode and display_timing contain flags describing the modes.
These are stored in dmt_flags and data_flags. There's no need to
separate these flags, and having separate fields just makes the flags
more difficult to use.

This patch combines the fields and renames VESA_DMT_* flags to
DISPLAY_FLAGS_*.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/gpu/drm/drm_modes.c       |   12 ++++++------
 drivers/video/fbmon.c             |    8 ++++----
 drivers/video/of_display_timing.c |   19 +++++++++----------
 drivers/video/videomode.c         |    3 +--
 include/video/display_timing.h    |   26 +++++++++++---------------
 include/video/videomode.h         |    3 +--
 6 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 0698c0e..f83f071 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -523,17 +523,17 @@ int drm_display_mode_from_videomode(const struct videomode *vm,
 	dmode->clock = vm->pixelclock / 1000;
 
 	dmode->flags = 0;
-	if (vm->dmt_flags & VESA_DMT_HSYNC_HIGH)
+	if (vm->flags & DISPLAY_FLAGS_HSYNC_HIGH)
 		dmode->flags |= DRM_MODE_FLAG_PHSYNC;
-	else if (vm->dmt_flags & VESA_DMT_HSYNC_LOW)
+	else if (vm->flags & DISPLAY_FLAGS_HSYNC_LOW)
 		dmode->flags |= DRM_MODE_FLAG_NHSYNC;
-	if (vm->dmt_flags & VESA_DMT_VSYNC_HIGH)
+	if (vm->flags & DISPLAY_FLAGS_VSYNC_HIGH)
 		dmode->flags |= DRM_MODE_FLAG_PVSYNC;
-	else if (vm->dmt_flags & VESA_DMT_VSYNC_LOW)
+	else if (vm->flags & DISPLAY_FLAGS_VSYNC_LOW)
 		dmode->flags |= DRM_MODE_FLAG_NVSYNC;
-	if (vm->data_flags & DISPLAY_FLAGS_INTERLACED)
+	if (vm->flags & DISPLAY_FLAGS_INTERLACED)
 		dmode->flags |= DRM_MODE_FLAG_INTERLACE;
-	if (vm->data_flags & DISPLAY_FLAGS_DOUBLESCAN)
+	if (vm->flags & DISPLAY_FLAGS_DOUBLESCAN)
 		dmode->flags |= DRM_MODE_FLAG_DBLSCAN;
 	drm_mode_set_name(dmode);
 
diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 368cedf..e5cc2fd 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -1398,13 +1398,13 @@ int fb_videomode_from_videomode(const struct videomode *vm,
 
 	fbmode->sync = 0;
 	fbmode->vmode = 0;
-	if (vm->dmt_flags & VESA_DMT_HSYNC_HIGH)
+	if (vm->flags & DISPLAY_FLAGS_HSYNC_HIGH)
 		fbmode->sync |= FB_SYNC_HOR_HIGH_ACT;
-	if (vm->dmt_flags & VESA_DMT_HSYNC_HIGH)
+	if (vm->flags & DISPLAY_FLAGS_HSYNC_HIGH)
 		fbmode->sync |= FB_SYNC_VERT_HIGH_ACT;
-	if (vm->data_flags & DISPLAY_FLAGS_INTERLACED)
+	if (vm->flags & DISPLAY_FLAGS_INTERLACED)
 		fbmode->vmode |= FB_VMODE_INTERLACED;
-	if (vm->data_flags & DISPLAY_FLAGS_DOUBLESCAN)
+	if (vm->flags & DISPLAY_FLAGS_DOUBLESCAN)
 		fbmode->vmode |= FB_VMODE_DOUBLE;
 	fbmode->flag = 0;
 
diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index 13ecd98..56009bc 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -79,25 +79,24 @@ static struct display_timing *of_get_display_timing(struct device_node *np)
 	ret |= parse_timing_property(np, "vsync-len", &dt->vsync_len);
 	ret |= parse_timing_property(np, "clock-frequency", &dt->pixelclock);
 
-	dt->dmt_flags = 0;
-	dt->data_flags = 0;
+	dt->flags = 0;
 	if (!of_property_read_u32(np, "vsync-active", &val))
-		dt->dmt_flags |= val ? VESA_DMT_VSYNC_HIGH :
-				VESA_DMT_VSYNC_LOW;
+		dt->flags |= val ? DISPLAY_FLAGS_VSYNC_HIGH :
+				DISPLAY_FLAGS_VSYNC_LOW;
 	if (!of_property_read_u32(np, "hsync-active", &val))
-		dt->dmt_flags |= val ? VESA_DMT_HSYNC_HIGH :
-				VESA_DMT_HSYNC_LOW;
+		dt->flags |= val ? DISPLAY_FLAGS_HSYNC_HIGH :
+				DISPLAY_FLAGS_HSYNC_LOW;
 	if (!of_property_read_u32(np, "de-active", &val))
-		dt->data_flags |= val ? DISPLAY_FLAGS_DE_HIGH :
+		dt->flags |= val ? DISPLAY_FLAGS_DE_HIGH :
 				DISPLAY_FLAGS_DE_LOW;
 	if (!of_property_read_u32(np, "pixelclk-active", &val))
-		dt->data_flags |= val ? DISPLAY_FLAGS_PIXDATA_POSEDGE :
+		dt->flags |= val ? DISPLAY_FLAGS_PIXDATA_POSEDGE :
 				DISPLAY_FLAGS_PIXDATA_NEGEDGE;
 
 	if (of_property_read_bool(np, "interlaced"))
-		dt->data_flags |= DISPLAY_FLAGS_INTERLACED;
+		dt->flags |= DISPLAY_FLAGS_INTERLACED;
 	if (of_property_read_bool(np, "doublescan"))
-		dt->data_flags |= DISPLAY_FLAGS_DOUBLESCAN;
+		dt->flags |= DISPLAY_FLAGS_DOUBLESCAN;
 
 	if (ret) {
 		pr_err("%s: error reading timing properties\n",
diff --git a/drivers/video/videomode.c b/drivers/video/videomode.c
index 21c47a2..810afff 100644
--- a/drivers/video/videomode.c
+++ b/drivers/video/videomode.c
@@ -31,8 +31,7 @@ int videomode_from_timing(const struct display_timings *disp,
 	vm->vback_porch = display_timing_get_value(&dt->vback_porch, TE_TYP);
 	vm->vsync_len = display_timing_get_value(&dt->vsync_len, TE_TYP);
 
-	vm->dmt_flags = dt->dmt_flags;
-	vm->data_flags = dt->data_flags;
+	vm->flags = dt->flags;
 
 	return 0;
 }
diff --git a/include/video/display_timing.h b/include/video/display_timing.h
index 71e9a38..a8a4be5 100644
--- a/include/video/display_timing.h
+++ b/include/video/display_timing.h
@@ -12,19 +12,16 @@
 #include <linux/bitops.h>
 #include <linux/types.h>
 
-/* VESA display monitor timing parameters */
-#define VESA_DMT_HSYNC_LOW		BIT(0)
-#define VESA_DMT_HSYNC_HIGH		BIT(1)
-#define VESA_DMT_VSYNC_LOW		BIT(2)
-#define VESA_DMT_VSYNC_HIGH		BIT(3)
-
-/* display specific flags */
-#define DISPLAY_FLAGS_DE_LOW		BIT(0)	/* data enable flag */
-#define DISPLAY_FLAGS_DE_HIGH		BIT(1)
-#define DISPLAY_FLAGS_PIXDATA_POSEDGE	BIT(2)	/* drive data on pos. edge */
-#define DISPLAY_FLAGS_PIXDATA_NEGEDGE	BIT(3)	/* drive data on neg. edge */
-#define DISPLAY_FLAGS_INTERLACED	BIT(4)
-#define DISPLAY_FLAGS_DOUBLESCAN	BIT(5)
+#define DISPLAY_FLAGS_HSYNC_LOW		BIT(0)
+#define DISPLAY_FLAGS_HSYNC_HIGH	BIT(1)
+#define DISPLAY_FLAGS_VSYNC_LOW		BIT(2)
+#define DISPLAY_FLAGS_VSYNC_HIGH	BIT(3)
+#define DISPLAY_FLAGS_DE_LOW		BIT(4)	/* data enable flag */
+#define DISPLAY_FLAGS_DE_HIGH		BIT(5)
+#define DISPLAY_FLAGS_PIXDATA_POSEDGE	BIT(6)	/* drive data on pos. edge */
+#define DISPLAY_FLAGS_PIXDATA_NEGEDGE	BIT(7)	/* drive data on neg. edge */
+#define DISPLAY_FLAGS_INTERLACED	BIT(8)
+#define DISPLAY_FLAGS_DOUBLESCAN	BIT(9)
 
 /*
  * A single signal can be specified via a range of minimal and maximal values
@@ -72,8 +69,7 @@ struct display_timing {
 	struct timing_entry vback_porch;	/* ver. back porch */
 	struct timing_entry vsync_len;		/* ver. sync len */
 
-	unsigned int dmt_flags;			/* VESA DMT flags */
-	unsigned int data_flags;		/* video data flags */
+	unsigned int flags;			/* display flags */
 };
 
 /*
diff --git a/include/video/videomode.h b/include/video/videomode.h
index a421562..f4ae6ed 100644
--- a/include/video/videomode.h
+++ b/include/video/videomode.h
@@ -29,8 +29,7 @@ struct videomode {
 	u32 vback_porch;
 	u32 vsync_len;
 
-	unsigned int dmt_flags;	/* VESA DMT flags */
-	unsigned int data_flags; /* video data flags */
+	unsigned int flags; /* display flags */
 };
 
 /**
-- 
1.7.10.4


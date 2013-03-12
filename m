From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 12 Mar 2013 10:19:38 +0000
Subject: [PATCH 5/5] videomode: rename fields
Message-Id: <1363083578-17062-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363083578-17062-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1363083578-17062-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Structs videomode and display_timing have rather long field names for
the timing values. Nothing wrong with that as such, but this patch
changes them to abbreviations for the following reasons:

* The timing values often need to be used in calculations, and long
  field names makes their direct use clumsier.

* The current names are a bit of a mishmash: some words are used as
  such, some are shortened, and for some only first letter is used. Some
  names use underscode, some don't. All this makes it difficult to
  remember what the field names are.

* The abbreviations used in this patch are very common, and there
  shouldn't be any misunderstanding about their meaning.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/gpu/drm/drm_modes.c       |   18 +++++++++---------
 drivers/video/fbmon.c             |   24 +++++++++++-------------
 drivers/video/of_display_timing.c |   16 ++++++++--------
 drivers/video/videomode.c         |   16 ++++++++--------
 include/video/display_timing.h    |   16 ++++++++--------
 include/video/videomode.h         |   18 +++++++++---------
 6 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index f83f071..d744e95 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -510,15 +510,15 @@ EXPORT_SYMBOL(drm_gtf_mode);
 int drm_display_mode_from_videomode(const struct videomode *vm,
 				    struct drm_display_mode *dmode)
 {
-	dmode->hdisplay = vm->hactive;
-	dmode->hsync_start = dmode->hdisplay + vm->hfront_porch;
-	dmode->hsync_end = dmode->hsync_start + vm->hsync_len;
-	dmode->htotal = dmode->hsync_end + vm->hback_porch;
+	dmode->hdisplay = vm->hact;
+	dmode->hsync_start = dmode->hdisplay + vm->hfp;
+	dmode->hsync_end = dmode->hsync_start + vm->hsl;
+	dmode->htotal = dmode->hsync_end + vm->hbp;
 
-	dmode->vdisplay = vm->vactive;
-	dmode->vsync_start = dmode->vdisplay + vm->vfront_porch;
-	dmode->vsync_end = dmode->vsync_start + vm->vsync_len;
-	dmode->vtotal = dmode->vsync_end + vm->vback_porch;
+	dmode->vdisplay = vm->vact;
+	dmode->vsync_start = dmode->vdisplay + vm->vfp;
+	dmode->vsync_end = dmode->vsync_start + vm->vsl;
+	dmode->vtotal = dmode->vsync_end + vm->vbp;
 
 	dmode->clock = vm->pixelclock / 1000;
 
@@ -565,7 +565,7 @@ int of_get_drm_display_mode(struct device_node *np,
 	drm_display_mode_from_videomode(&vm, dmode);
 
 	pr_debug("%s: got %dx%d display mode from %s\n",
-		of_node_full_name(np), vm.hactive, vm.vactive, np->name);
+		of_node_full_name(np), vm.hact, vm.vact, np->name);
 	drm_mode_debug_printmodeline(dmode);
 
 	return 0;
diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index e5cc2fd..8103fc9 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -1382,15 +1382,15 @@ int fb_videomode_from_videomode(const struct videomode *vm,
 {
 	unsigned int htotal, vtotal;
 
-	fbmode->xres = vm->hactive;
-	fbmode->left_margin = vm->hback_porch;
-	fbmode->right_margin = vm->hfront_porch;
-	fbmode->hsync_len = vm->hsync_len;
+	fbmode->xres = vm->hact;
+	fbmode->left_margin = vm->hbp;
+	fbmode->right_margin = vm->hfp;
+	fbmode->hsync_len = vm->hsl;
 
-	fbmode->yres = vm->vactive;
-	fbmode->upper_margin = vm->vback_porch;
-	fbmode->lower_margin = vm->vfront_porch;
-	fbmode->vsync_len = vm->vsync_len;
+	fbmode->yres = vm->vact;
+	fbmode->upper_margin = vm->vbp;
+	fbmode->lower_margin = vm->vfp;
+	fbmode->vsync_len = vm->vsl;
 
 	/* prevent division by zero in KHZ2PICOS macro */
 	fbmode->pixclock = vm->pixelclock ?
@@ -1408,10 +1408,8 @@ int fb_videomode_from_videomode(const struct videomode *vm,
 		fbmode->vmode |= FB_VMODE_DOUBLE;
 	fbmode->flag = 0;
 
-	htotal = vm->hactive + vm->hfront_porch + vm->hback_porch +
-		 vm->hsync_len;
-	vtotal = vm->vactive + vm->vfront_porch + vm->vback_porch +
-		 vm->vsync_len;
+	htotal = vm->hact + vm->hfp + vm->hbp + vm->hsl;
+	vtotal = vm->vact + vm->vfp + vm->vbp + vm->vsl;
 	/* prevent division by zero */
 	if (htotal && vtotal) {
 		fbmode->refresh = vm->pixelclock / (htotal * vtotal);
@@ -1458,7 +1456,7 @@ int of_get_fb_videomode(struct device_node *np, struct fb_videomode *fb,
 	fb_videomode_from_videomode(&vm, fb);
 
 	pr_debug("%s: got %dx%d display mode from %s\n",
-		of_node_full_name(np), vm.hactive, vm.vactive, np->name);
+		of_node_full_name(np), vm.hact, vm.vact, np->name);
 	dump_fb_videomode(fb);
 
 	return 0;
diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index 56009bc..79660937 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -69,14 +69,14 @@ static struct display_timing *of_get_display_timing(struct device_node *np)
 		return NULL;
 	}
 
-	ret |= parse_timing_property(np, "hback-porch", &dt->hback_porch);
-	ret |= parse_timing_property(np, "hfront-porch", &dt->hfront_porch);
-	ret |= parse_timing_property(np, "hactive", &dt->hactive);
-	ret |= parse_timing_property(np, "hsync-len", &dt->hsync_len);
-	ret |= parse_timing_property(np, "vback-porch", &dt->vback_porch);
-	ret |= parse_timing_property(np, "vfront-porch", &dt->vfront_porch);
-	ret |= parse_timing_property(np, "vactive", &dt->vactive);
-	ret |= parse_timing_property(np, "vsync-len", &dt->vsync_len);
+	ret |= parse_timing_property(np, "hback-porch", &dt->hbp);
+	ret |= parse_timing_property(np, "hfront-porch", &dt->hfp);
+	ret |= parse_timing_property(np, "hactive", &dt->hact);
+	ret |= parse_timing_property(np, "hsync-len", &dt->hsl);
+	ret |= parse_timing_property(np, "vback-porch", &dt->vbp);
+	ret |= parse_timing_property(np, "vfront-porch", &dt->vfp);
+	ret |= parse_timing_property(np, "vactive", &dt->vact);
+	ret |= parse_timing_property(np, "vsync-len", &dt->vsl);
 	ret |= parse_timing_property(np, "clock-frequency", &dt->pixelclock);
 
 	dt->flags = 0;
diff --git a/drivers/video/videomode.c b/drivers/video/videomode.c
index a3d95f2..c42689a 100644
--- a/drivers/video/videomode.c
+++ b/drivers/video/videomode.c
@@ -21,15 +21,15 @@ int videomode_from_timing(const struct display_timings *disp,
 		return -EINVAL;
 
 	vm->pixelclock = dt->pixelclock.typ;
-	vm->hactive = dt->hactive.typ;
-	vm->hfront_porch = dt->hfront_porch.typ;
-	vm->hback_porch = dt->hback_porch.typ;
-	vm->hsync_len = dt->hsync_len.typ;
+	vm->hact = dt->hact.typ;
+	vm->hfp = dt->hfp.typ;
+	vm->hbp = dt->hbp.typ;
+	vm->hsl = dt->hsl.typ;
 
-	vm->vactive = dt->vactive.typ;
-	vm->vfront_porch = dt->vfront_porch.typ;
-	vm->vback_porch = dt->vback_porch.typ;
-	vm->vsync_len = dt->vsync_len.typ;
+	vm->vact = dt->vact.typ;
+	vm->vfp = dt->vfp.typ;
+	vm->vbp = dt->vbp.typ;
+	vm->vsl = dt->vsl.typ;
 
 	vm->flags = dt->flags;
 
diff --git a/include/video/display_timing.h b/include/video/display_timing.h
index 5d0259b..db98ef9 100644
--- a/include/video/display_timing.h
+++ b/include/video/display_timing.h
@@ -59,15 +59,15 @@ struct timing_entry {
 struct display_timing {
 	struct timing_entry pixelclock;
 
-	struct timing_entry hactive;		/* hor. active video */
-	struct timing_entry hfront_porch;	/* hor. front porch */
-	struct timing_entry hback_porch;	/* hor. back porch */
-	struct timing_entry hsync_len;		/* hor. sync len */
+	struct timing_entry hact;		/* hor. active video */
+	struct timing_entry hfp;		/* hor. front porch */
+	struct timing_entry hbp;		/* hor. back porch */
+	struct timing_entry hsl;		/* hor. sync len */
 
-	struct timing_entry vactive;		/* ver. active video */
-	struct timing_entry vfront_porch;	/* ver. front porch */
-	struct timing_entry vback_porch;	/* ver. back porch */
-	struct timing_entry vsync_len;		/* ver. sync len */
+	struct timing_entry vact;		/* ver. active video */
+	struct timing_entry vfp;		/* ver. front porch */
+	struct timing_entry vbp;		/* ver. back porch */
+	struct timing_entry vsl;		/* ver. sync len */
 
 	enum display_flags flags;		/* display flags */
 };
diff --git a/include/video/videomode.h b/include/video/videomode.h
index 8b12e60..b601c0c 100644
--- a/include/video/videomode.h
+++ b/include/video/videomode.h
@@ -19,15 +19,15 @@
 struct videomode {
 	unsigned long pixelclock;	/* pixelclock in Hz */
 
-	u32 hactive;
-	u32 hfront_porch;
-	u32 hback_porch;
-	u32 hsync_len;
-
-	u32 vactive;
-	u32 vfront_porch;
-	u32 vback_porch;
-	u32 vsync_len;
+	u32 hact;
+	u32 hfp;
+	u32 hbp;
+	u32 hsl;
+
+	u32 vact;
+	u32 vfp;
+	u32 vbp;
+	u32 vsl;
 
 	enum display_flags flags; /* display flags */
 };
-- 
1.7.10.4


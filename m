From: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Date: Wed, 25 Feb 2015 21:01:20 +0000
Subject: [PATCH] video: ARM CLCD: Added support for FBIOPAN_DISPLAY and virtual y resolution
Message-Id: <1424898082-1522-2-git-send-email-arun.ramamurthy@broadcom.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
In-Reply-To: <1424898082-1522-1-git-send-email-arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Added code to support FBIOPAN_DISPLAY. Also added yres_virtual
parameter to device tree to set the virtual y resolution

Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
---
 .../devicetree/bindings/video/arm,pl11x.txt        |  4 +++
 drivers/video/fbdev/amba-clcd.c                    | 31 +++++++++++++++++++---
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/arm,pl11x.txt b/Documentation/devicetree/bindings/video/arm,pl11x.txt
index 14d6f87..2262cdb 100644
--- a/Documentation/devicetree/bindings/video/arm,pl11x.txt
+++ b/Documentation/devicetree/bindings/video/arm,pl11x.txt
@@ -50,6 +50,10 @@ Optional properties:
 	display mode, data is driven onto the LCD data lines at the
 	programmed edge of CLCP when CLAC is in its active state.
 
+- yres_virtual: Virtual Y resolution,
+	It can be used to configure a virtual y resolution. It
+	must be a value larger than the actual y resolution.
+
 Required sub-nodes:
 
 - port: describes LCD panel signals, following the common binding
diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 4e4e50f..3bc09ad 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -454,6 +454,18 @@ static int clcdfb_mmap(struct fb_info *info,
 	return ret;
 }
 
+static int clcdfb_pan_display(struct fb_var_screeninfo *var,
+			      struct fb_info *info)
+{
+	struct clcd_fb *fb;
+
+	info->var = *var;
+	fb = to_clcd(info);
+	clcdfb_set_start(fb);
+
+	return 0;
+}
+
 static struct fb_ops clcdfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_check_var	= clcdfb_check_var,
@@ -464,6 +476,7 @@ static struct fb_ops clcdfb_ops = {
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 	.fb_mmap	= clcdfb_mmap,
+	.fb_pan_display	= clcdfb_pan_display,
 };
 
 static int clcdfb_register(struct clcd_fb *fb)
@@ -517,14 +530,16 @@ static int clcdfb_register(struct clcd_fb *fb)
 	fb->fb.fix.type		= FB_TYPE_PACKED_PIXELS;
 	fb->fb.fix.type_aux	= 0;
 	fb->fb.fix.xpanstep	= 0;
-	fb->fb.fix.ypanstep	= 0;
+	if (fb->fb.var.yres_virtual > fb->panel->mode.yres)
+		fb->fb.fix.ypanstep = 1;
+	else
+		fb->fb.fix.ypanstep = 0;
 	fb->fb.fix.ywrapstep	= 0;
 	fb->fb.fix.accel	= FB_ACCEL_NONE;
 
 	fb->fb.var.xres		= fb->panel->mode.xres;
 	fb->fb.var.yres		= fb->panel->mode.yres;
 	fb->fb.var.xres_virtual	= fb->panel->mode.xres;
-	fb->fb.var.yres_virtual	= fb->panel->mode.yres;
 	fb->fb.var.bits_per_pixel = fb->panel->bpp;
 	fb->fb.var.grayscale	= fb->panel->grayscale;
 	fb->fb.var.pixclock	= fb->panel->mode.pixclock;
@@ -690,7 +705,7 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 	struct device_node *endpoint;
 	int err;
 	unsigned int bpp;
-	u32 max_bandwidth;
+	u32 max_bandwidth, yres_virtual;
 	u32 tft_r0b0g0[3];
 
 	fb->panel = devm_kzalloc(&fb->dev->dev, sizeof(*fb->panel), GFP_KERNEL);
@@ -730,6 +745,14 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 	fb->panel->width = -1;
 	fb->panel->height = -1;
 
+	/* if yres_virtual property is not specified in device tree,
+	 * set it as the actual y resolution */
+	if (of_property_read_u32(fb->dev->dev.of_node,
+				"yres_virtual", &yres_virtual))
+		fb->fb.var.yres_virtual = fb->panel->mode.yres;
+	else
+		fb->fb.var.yres_virtual = yres_virtual;
+
 	if (of_property_read_u32_array(endpoint,
 			"arm,pl11x,tft-r0g0b0-pads",
 			tft_r0b0g0, ARRAY_SIZE(tft_r0b0g0)) = 0)
@@ -797,7 +820,7 @@ static int clcdfb_of_dma_setup(struct clcd_fb *fb)
 	if (err)
 		return err;
 
-	framesize = fb->panel->mode.xres * fb->panel->mode.yres *
+	framesize = fb->panel->mode.xres * fb->fb.var.yres_virtual *
 			fb->panel->bpp / 8;
 	fb->fb.screen_base = dma_alloc_coherent(&fb->dev->dev, framesize,
 			&dma, GFP_KERNEL);
-- 
2.3.0


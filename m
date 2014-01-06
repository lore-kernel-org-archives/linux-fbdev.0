From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Date: Mon, 06 Jan 2014 13:17:58 +0000
Subject: [PATCH 2/2] video: mxsfb: fix broken videomode selection
Message-Id: <1389014278-4903-3-git-send-email-LW@KARO-electronics.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389014278-4903-1-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1389014278-4903-1-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Currently the driver re-implements the code found in of_get_videomode()
except for the fact that the latter honors the 'native-mode' property
to select a spcific video timing from the list of possible timings.
The driver builds up a list of all video timings, but uses only the
last mode from the list anyway. While building the list it incorrectly
OR's the 'pixelclk-active' and 'de-active' flags of all modes into
single flags, possibly leading to a wrong pixelclock or data-enable
polarity setting.

Fix this by using the of_get_videomode() directly with the
OF_USE_NATIVE_MODE flag.

Since all current dts files only have one entry in their
display-timings node, this bug was not apparent and the fix does not
change the driver's behaviour for the current users.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/video/mxsfb.c |  120 ++++++++++++++++++++-------------------------=
---
 1 files changed, 50 insertions(+), 70 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index d11c35c..accf48a2 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -49,6 +49,7 @@
 #include <linux/fb.h>
 #include <linux/regulator/consumer.h>
 #include <video/of_display_timing.h>
+#include <video/of_videomode.h>
 #include <video/videomode.h>
=20
 #define REG_SET	4
@@ -589,7 +590,8 @@ static struct fb_ops mxsfb_ops =3D {
 	.fb_imageblit =3D cfb_imageblit,
 };
=20
-static int mxsfb_restore_mode(struct mxsfb_info *host)
+static int mxsfb_restore_mode(struct mxsfb_info *host,
+			struct fb_videomode *vmode)
 {
 	struct fb_info *fb_info =3D &host->fb_info;
 	unsigned line_count;
@@ -597,7 +599,6 @@ static int mxsfb_restore_mode(struct mxsfb_info *host)
 	unsigned long pa, fbsize;
 	int bits_per_pixel, ofs;
 	u32 transfer_count, vdctrl0, vdctrl2, vdctrl3, vdctrl4, ctrl;
-	struct fb_videomode vmode;
=20
 	/* Only restore the mode when the controller is running */
 	ctrl =3D readl(host->base + LCDC_CTRL);
@@ -611,8 +612,8 @@ static int mxsfb_restore_mode(struct mxsfb_info *host)
=20
 	transfer_count =3D readl(host->base + host->devdata->transfer_count);
=20
-	vmode.xres =3D TRANSFER_COUNT_GET_HCOUNT(transfer_count);
-	vmode.yres =3D TRANSFER_COUNT_GET_VCOUNT(transfer_count);
+	vmode->xres =3D TRANSFER_COUNT_GET_HCOUNT(transfer_count);
+	vmode->yres =3D TRANSFER_COUNT_GET_VCOUNT(transfer_count);
=20
 	switch (CTRL_GET_WORD_LENGTH(ctrl)) {
 	case 0:
@@ -628,40 +629,39 @@ static int mxsfb_restore_mode(struct mxsfb_info *host)
=20
 	fb_info->var.bits_per_pixel =3D bits_per_pixel;
=20
-	vmode.pixclock =3D KHZ2PICOS(clk_get_rate(host->clk) / 1000U);
-	vmode.hsync_len =3D get_hsync_pulse_width(host, vdctrl2);
-	vmode.left_margin =3D GET_HOR_WAIT_CNT(vdctrl3) - vmode.hsync_len;
-	vmode.right_margin =3D VDCTRL2_GET_HSYNC_PERIOD(vdctrl2) - vmode.hsync_le=
n -
-		vmode.left_margin - vmode.xres;
-	vmode.vsync_len =3D VDCTRL0_GET_VSYNC_PULSE_WIDTH(vdctrl0);
+	vmode->pixclock =3D KHZ2PICOS(clk_get_rate(host->clk) / 1000U);
+	vmode->hsync_len =3D get_hsync_pulse_width(host, vdctrl2);
+	vmode->left_margin =3D GET_HOR_WAIT_CNT(vdctrl3) - vmode->hsync_len;
+	vmode->right_margin =3D VDCTRL2_GET_HSYNC_PERIOD(vdctrl2) -
+		vmode->hsync_len - vmode->left_margin - vmode->xres;
+	vmode->vsync_len =3D VDCTRL0_GET_VSYNC_PULSE_WIDTH(vdctrl0);
 	period =3D readl(host->base + LCDC_VDCTRL1);
-	vmode.upper_margin =3D GET_VERT_WAIT_CNT(vdctrl3) - vmode.vsync_len;
-	vmode.lower_margin =3D period - vmode.vsync_len - vmode.upper_margin - vm=
ode.yres;
+	vmode->upper_margin =3D GET_VERT_WAIT_CNT(vdctrl3) - vmode->vsync_len;
+	vmode->lower_margin =3D period - vmode->vsync_len -
+		vmode->upper_margin - vmode->yres;
=20
-	vmode.vmode =3D FB_VMODE_NONINTERLACED;
+	vmode->vmode =3D FB_VMODE_NONINTERLACED;
=20
-	vmode.sync =3D 0;
+	vmode->sync =3D 0;
 	if (vdctrl0 & VDCTRL0_HSYNC_ACT_HIGH)
-		vmode.sync |=3D FB_SYNC_HOR_HIGH_ACT;
+		vmode->sync |=3D FB_SYNC_HOR_HIGH_ACT;
 	if (vdctrl0 & VDCTRL0_VSYNC_ACT_HIGH)
-		vmode.sync |=3D FB_SYNC_VERT_HIGH_ACT;
+		vmode->sync |=3D FB_SYNC_VERT_HIGH_ACT;
=20
 	pr_debug("Reconstructed video mode:\n");
 	pr_debug("%dx%d, hsync: %u left: %u, right: %u, vsync: %u, upper: %u, low=
er: %u\n",
-			vmode.xres, vmode.yres,
-			vmode.hsync_len, vmode.left_margin, vmode.right_margin,
-			vmode.vsync_len, vmode.upper_margin, vmode.lower_margin);
-	pr_debug("pixclk: %ldkHz\n", PICOS2KHZ(vmode.pixclock));
-
-	fb_add_videomode(&vmode, &fb_info->modelist);
+		vmode->xres, vmode->yres, vmode->hsync_len, vmode->left_margin,
+		vmode->right_margin, vmode->vsync_len, vmode->upper_margin,
+		vmode->lower_margin);
+	pr_debug("pixclk: %ldkHz\n", PICOS2KHZ(vmode->pixclock));
=20
 	host->ld_intf_width =3D CTRL_GET_BUS_WIDTH(ctrl);
 	host->dotclk_delay =3D VDCTRL4_GET_DOTCLK_DLY(vdctrl4);
=20
-	fb_info->fix.line_length =3D vmode.xres * (bits_per_pixel >> 3);
+	fb_info->fix.line_length =3D vmode->xres * (bits_per_pixel >> 3);
=20
 	pa =3D readl(host->base + host->devdata->cur_buf);
-	fbsize =3D fb_info->fix.line_length * vmode.yres;
+	fbsize =3D fb_info->fix.line_length * vmode->yres;
 	if (pa < fb_info->fix.smem_start)
 		return -EINVAL;
 	if (pa + fbsize > fb_info->fix.smem_start + fb_info->fix.smem_len)
@@ -681,18 +681,17 @@ static int mxsfb_restore_mode(struct mxsfb_info *host)
 	return 0;
 }
=20
-static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host)
+static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host,
+				struct fb_videomode *vmode)
 {
 	struct fb_info *fb_info =3D &host->fb_info;
 	struct fb_var_screeninfo *var =3D &fb_info->var;
 	struct device *dev =3D &host->pdev->dev;
 	struct device_node *np =3D host->pdev->dev.of_node;
 	struct device_node *display_np;
-	struct device_node *timings_np;
-	struct display_timings *timings;
+	struct videomode vm;
 	u32 width;
-	int i;
-	int ret =3D 0;
+	int ret;
=20
 	display_np =3D of_parse_phandle(np, "display", 0);
 	if (!display_np) {
@@ -732,54 +731,35 @@ static int mxsfb_init_fbinfo_dt(struct mxsfb_info *ho=
st)
 		goto put_display_node;
 	}
=20
-	timings =3D of_get_display_timings(display_np);
-	if (!timings) {
-		dev_err(dev, "failed to get display timings\n");
-		ret =3D -ENOENT;
+	ret =3D of_get_videomode(display_np, &vm, OF_USE_NATIVE_MODE);
+	if (ret) {
+		dev_err(dev, "failed to get videomode from DT\n");
 		goto put_display_node;
 	}
=20
-	timings_np =3D of_find_node_by_name(display_np,
-					  "display-timings");
-	if (!timings_np) {
-		dev_err(dev, "failed to find display-timings node\n");
-		ret =3D -ENOENT;
+	ret =3D fb_videomode_from_videomode(&vm, vmode);
+	if (ret < 0)
 		goto put_display_node;
-	}
=20
-	for (i =3D 0; i < of_get_child_count(timings_np); i++) {
-		struct videomode vm;
-		struct fb_videomode fb_vm;
-
-		ret =3D videomode_from_timings(timings, &vm, i);
-		if (ret < 0)
-			goto put_timings_node;
-		ret =3D fb_videomode_from_videomode(&vm, &fb_vm);
-		if (ret < 0)
-			goto put_timings_node;
-
-		if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
-			host->sync |=3D MXSFB_SYNC_DATA_ENABLE_HIGH_ACT;
-		if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
-			host->sync |=3D MXSFB_SYNC_DOTCLK_FALLING_ACT;
-		fb_add_videomode(&fb_vm, &fb_info->modelist);
-	}
+	if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
+		host->sync |=3D MXSFB_SYNC_DATA_ENABLE_HIGH_ACT;
+	if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+		host->sync |=3D MXSFB_SYNC_DOTCLK_FALLING_ACT;
=20
-put_timings_node:
-	of_node_put(timings_np);
 put_display_node:
 	of_node_put(display_np);
 	return ret;
 }
=20
-static int mxsfb_init_fbinfo(struct mxsfb_info *host)
+static int mxsfb_init_fbinfo(struct mxsfb_info *host,
+			struct fb_videomode *vmode)
 {
+	int ret;
 	struct fb_info *fb_info =3D &host->fb_info;
 	struct fb_var_screeninfo *var =3D &fb_info->var;
 	dma_addr_t fb_phys;
 	void *fb_virt;
 	unsigned fb_size;
-	int ret;
=20
 	fb_info->fbops =3D &mxsfb_ops;
 	fb_info->flags =3D FBINFO_FLAG_DEFAULT | FBINFO_READS_FAST;
@@ -789,7 +769,7 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host)
 	fb_info->fix.visual =3D FB_VISUAL_TRUECOLOR,
 	fb_info->fix.accel =3D FB_ACCEL_NONE;
=20
-	ret =3D mxsfb_init_fbinfo_dt(host);
+	ret =3D mxsfb_init_fbinfo_dt(host, vmode);
 	if (ret)
 		return ret;
=20
@@ -810,7 +790,7 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host)
 	fb_info->screen_base =3D fb_virt;
 	fb_info->screen_size =3D fb_info->fix.smem_len =3D fb_size;
=20
-	if (mxsfb_restore_mode(host))
+	if (mxsfb_restore_mode(host, vmode))
 		memset(fb_virt, 0, fb_size);
=20
 	return 0;
@@ -850,7 +830,7 @@ static int mxsfb_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct mxsfb_info *host;
 	struct fb_info *fb_info;
-	struct fb_modelist *modelist;
+	struct fb_videomode *mode;
 	int ret;
=20
 	if (of_id)
@@ -862,6 +842,11 @@ static int mxsfb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
=20
+	mode =3D devm_kzalloc(&pdev->dev, sizeof(struct fb_videomode),
+			GFP_KERNEL);
+	if (mode =3D NULL)
+		return -ENOMEM;
+
 	host =3D to_imxfb_host(fb_info);
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -893,15 +878,11 @@ static int mxsfb_probe(struct platform_device *pdev)
 		goto fb_release;
 	}
=20
-	INIT_LIST_HEAD(&fb_info->modelist);
-
-	ret =3D mxsfb_init_fbinfo(host);
+	ret =3D mxsfb_init_fbinfo(host, mode);
 	if (ret !=3D 0)
 		goto fb_release;
=20
-	modelist =3D list_first_entry(&fb_info->modelist,
-			struct fb_modelist, list);
-	fb_videomode_to_var(&fb_info->var, &modelist->mode);
+	fb_videomode_to_var(&fb_info->var, mode);
=20
 	/* init the color fields */
 	mxsfb_check_var(&fb_info->var, fb_info);
@@ -927,7 +908,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 fb_destroy:
 	if (host->enabled)
 		clk_disable_unprepare(host->clk);
-	fb_destroy_modelist(&fb_info->modelist);
 fb_release:
 	framebuffer_release(fb_info);
=20
--=20
1.7.2.5


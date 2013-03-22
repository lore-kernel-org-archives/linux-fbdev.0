From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Fri, 22 Mar 2013 14:15:55 +0000
Subject: [PATCH 6/9] AUO-K190x: make color handling more flexible
Message-Id: <201303221515.55477.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Don't hardcode the 8bit mode in all parts. This creates the possibility
to add another colormode easily later on.

Signed-off-by: Heiko St=C3=BCbner <heiko@sntech.de>
---
 drivers/video/auo_k190x.c |   79 +++++++++++++++++++++++++++++++++++++----=
----
 1 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/drivers/video/auo_k190x.c b/drivers/video/auo_k190x.c
index 7f4c4ef..848cfe9 100644
--- a/drivers/video/auo_k190x.c
+++ b/drivers/video/auo_k190x.c
@@ -59,8 +59,8 @@ static void auok190x_issue_cmd(struct auok190xfb_par *par=
, u16 data)
 	par->board->set_ctl(par, AUOK190X_I80_DC, 1);
 }
=20
-static int auok190x_issue_pixels(struct auok190xfb_par *par, int size,
-				 u16 *data)
+static int auok190x_issue_pixels_gray8(struct auok190xfb_par *par, int siz=
e,
+				       u16 *data)
 {
 	struct device *dev =3D par->info->device;
 	int i;
@@ -90,6 +90,21 @@ static int auok190x_issue_pixels(struct auok190xfb_par *=
par, int size,
 	return 0;
 }
=20
+static int auok190x_issue_pixels(struct auok190xfb_par *par, int size,
+				 u16 *data)
+{
+	struct fb_info *info =3D par->info;
+	struct device *dev =3D par->info->device;
+
+	if (info->var.bits_per_pixel =3D 8 && info->var.grayscale)
+		auok190x_issue_pixels_gray8(par, size, data);
+	else
+		dev_err(dev, "unsupported color mode (bits: %d, gray: %d)\n",
+			info->var.bits_per_pixel, info->var.grayscale);
+
+	return 0;
+}
+
 static u16 auok190x_read_data(struct auok190xfb_par *par)
 {
 	u16 data;
@@ -381,6 +396,35 @@ static int auok190xfb_check_var(struct fb_var_screenin=
fo *var,
 	int size;
=20
 	/*
+	 * Color depth
+	 */
+
+	if (var->bits_per_pixel =3D 8 && var->grayscale =3D 1) {
+		/*
+		 * For 8-bit grayscale, R, G, and B offset are equal.
+		 */
+		var->red.length =3D 8;
+		var->red.offset =3D 0;
+		var->red.msb_right =3D 0;
+
+		var->green.length =3D 8;
+		var->green.offset =3D 0;
+		var->green.msb_right =3D 0;
+
+		var->blue.length =3D 8;
+		var->blue.offset =3D 0;
+		var->blue.msb_right =3D 0;
+
+		var->transp.length =3D 0;
+		var->transp.offset =3D 0;
+		var->transp.msb_right =3D 0;
+	} else {
+		dev_warn(dev, "unsupported color mode (bits: %d, grayscale: %d)\n",
+			info->var.bits_per_pixel, info->var.grayscale);
+		return -EINVAL;
+	}
+
+	/*
 	 * Dimensions
 	 */
=20
@@ -409,6 +453,24 @@ static int auok190xfb_check_var(struct fb_var_screenin=
fo *var,
 	return 0;
 }
=20
+static int auok190xfb_set_fix(struct fb_info *info)
+{
+	struct fb_fix_screeninfo *fix =3D &info->fix;
+	struct fb_var_screeninfo *var =3D &info->var;
+
+	fix->line_length =3D var->xres_virtual * var->bits_per_pixel / 8;
+
+	fix->type =3D FB_TYPE_PACKED_PIXELS;
+	fix->accel =3D FB_ACCEL_NONE;
+	fix->visual =3D (var->grayscale) ? FB_VISUAL_STATIC_PSEUDOCOLOR
+				       : FB_VISUAL_TRUECOLOR;
+	fix->xpanstep =3D 0;
+	fix->ypanstep =3D 0;
+	fix->ywrapstep =3D 0;
+
+	return 0;
+}
+
 static struct fb_ops auok190xfb_ops =3D {
 	.owner		=3D THIS_MODULE,
 	.fb_read	=3D fb_sys_read,
@@ -893,18 +955,8 @@ int __devinit auok190x_common_probe(struct platform_de=
vice *pdev,
 	/* initialise fix, var, resolution and rotation */
=20
 	strlcpy(info->fix.id, init->id, 16);
-	info->fix.type =3D FB_TYPE_PACKED_PIXELS;
-	info->fix.visual =3D FB_VISUAL_STATIC_PSEUDOCOLOR;
-	info->fix.xpanstep =3D 0;
-	info->fix.ypanstep =3D 0;
-	info->fix.ywrapstep =3D 0;
-	info->fix.accel =3D FB_ACCEL_NONE;
-
 	info->var.bits_per_pixel =3D 8;
 	info->var.grayscale =3D 1;
-	info->var.red.length =3D 8;
-	info->var.green.length =3D 8;
-	info->var.blue.length =3D 8;
=20
 	panel =3D &panel_table[board->resolution];
=20
@@ -932,8 +984,7 @@ int __devinit auok190x_common_probe(struct platform_dev=
ice *pdev,
 	if (ret)
 		goto err_defio;
=20
-	info->fix.line_length =3D info->var.xres_virtual *
-				info->var.bits_per_pixel / 8;
+	auok190xfb_set_fix(info);
=20
 	/* deferred io init */
=20
--=20
1.7.2.3


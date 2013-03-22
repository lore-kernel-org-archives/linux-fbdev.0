From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Fri, 22 Mar 2013 14:16:29 +0000
Subject: [PATCH 7/9] AUO-K190x: add a 16bit truecolor mode
Message-Id: <201303221516.29815.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Some applications seem to have problems using the 8bit grayscale mode.
Therefore provide a 16bit truecolor mode which also gets converted to
the 4bit grayscale the display uses, when updating a region.

Signed-off-by: Heiko St=C3=BCbner <heiko@sntech.de>
---
 drivers/video/auo_k190x.c |   71 +++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/video/auo_k190x.c b/drivers/video/auo_k190x.c
index 848cfe9..69abb9c 100644
--- a/drivers/video/auo_k190x.c
+++ b/drivers/video/auo_k190x.c
@@ -59,6 +59,46 @@ static void auok190x_issue_cmd(struct auok190xfb_par *pa=
r, u16 data)
 	par->board->set_ctl(par, AUOK190X_I80_DC, 1);
 }
=20
+/**
+ * Conversion of 16bit color to 4bit grayscale
+ * does roughly (0.3 * R + 0.6 G + 0.1 B) / 2
+ */
+static inline int rgb565_to_gray4(u16 data, struct fb_var_screeninfo *var)
+{
+	return ((((data & 0xF800) >> var->red.offset) * 77 +
+		 ((data & 0x07E0) >> (var->green.offset + 1)) * 151 +
+		 ((data & 0x1F) >> var->blue.offset) * 28) >> 8 >> 1);
+}
+
+static int auok190x_issue_pixels_rgb565(struct auok190xfb_par *par, int si=
ze,
+					u16 *data)
+{
+	struct fb_var_screeninfo *var =3D &par->info->var;
+	struct device *dev =3D par->info->device;
+	int i;
+	u16 tmp;
+
+	if (size & 7) {
+		dev_err(dev, "issue_pixels: size %d must be a multiple of 8\n",
+			size);
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < (size >> 2); i++) {
+		par->board->set_ctl(par, AUOK190X_I80_WR, 0);
+
+		tmp  =3D (rgb565_to_gray4(data[4*i], var) & 0x000F);
+		tmp |=3D (rgb565_to_gray4(data[4*i+1], var) << 4) & 0x00F0;
+		tmp |=3D (rgb565_to_gray4(data[4*i+2], var) << 8) & 0x0F00;
+		tmp |=3D (rgb565_to_gray4(data[4*i+3], var) << 12) & 0xF000;
+
+		par->board->set_hdb(par, tmp);
+		par->board->set_ctl(par, AUOK190X_I80_WR, 1);
+	}
+
+	return 0;
+}
+
 static int auok190x_issue_pixels_gray8(struct auok190xfb_par *par, int siz=
e,
 				       u16 *data)
 {
@@ -98,6 +138,8 @@ static int auok190x_issue_pixels(struct auok190xfb_par *=
par, int size,
=20
 	if (info->var.bits_per_pixel =3D 8 && info->var.grayscale)
 		auok190x_issue_pixels_gray8(par, size, data);
+	else if (info->var.bits_per_pixel =3D 16)
+		auok190x_issue_pixels_rgb565(par, size, data);
 	else
 		dev_err(dev, "unsupported color mode (bits: %d, gray: %d)\n",
 			info->var.bits_per_pixel, info->var.grayscale);
@@ -418,6 +460,22 @@ static int auok190xfb_check_var(struct fb_var_screenin=
fo *var,
 		var->transp.length =3D 0;
 		var->transp.offset =3D 0;
 		var->transp.msb_right =3D 0;
+	} else if (var->bits_per_pixel =3D 16) {
+		var->red.length =3D 5;
+		var->red.offset =3D 11;
+		var->red.msb_right =3D 0;
+
+		var->green.length =3D 6;
+		var->green.offset =3D 5;
+		var->green.msb_right =3D 0;
+
+		var->blue.length =3D 5;
+		var->blue.offset =3D 0;
+		var->blue.msb_right =3D 0;
+
+		var->transp.length =3D 0;
+		var->transp.offset =3D 0;
+		var->transp.msb_right =3D 0;
 	} else {
 		dev_warn(dev, "unsupported color mode (bits: %d, grayscale: %d)\n",
 			info->var.bits_per_pixel, info->var.grayscale);
@@ -471,6 +529,15 @@ static int auok190xfb_set_fix(struct fb_info *info)
 	return 0;
 }
=20
+static int auok190xfb_set_par(struct fb_info *info)
+{
+	struct auok190xfb_par *par =3D info->par;
+
+	auok190xfb_set_fix(info);
+
+	return 0;
+}
+
 static struct fb_ops auok190xfb_ops =3D {
 	.owner		=3D THIS_MODULE,
 	.fb_read	=3D fb_sys_read,
@@ -479,6 +546,7 @@ static struct fb_ops auok190xfb_ops =3D {
 	.fb_copyarea	=3D auok190xfb_copyarea,
 	.fb_imageblit	=3D auok190xfb_imageblit,
 	.fb_check_var	=3D auok190xfb_check_var,
+	.fb_set_par     =3D auok190xfb_set_par,
 };
=20
 /*
@@ -965,8 +1033,7 @@ int __devinit auok190x_common_probe(struct platform_de=
vice *pdev,
=20
 	/* videomemory handling */
=20
-	videomemorysize =3D roundup((panel->w * panel->h) *
-				info->var.bits_per_pixel / 8, PAGE_SIZE);
+	videomemorysize =3D roundup((panel->w * panel->h) * 2, PAGE_SIZE);
 	videomemory =3D vmalloc(videomemorysize);
 	if (!videomemory) {
 		ret =3D -ENOMEM;
--=20
1.7.2.3


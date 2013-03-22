From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Fri, 22 Mar 2013 14:15:27 +0000
Subject: [PATCH 5/9] AUO-K190x: move var resolution-handling into check_var
Message-Id: <201303221515.27264.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Provides a central place for this, which will be helpful for
the following changes.

Signed-off-by: Heiko St=C3=BCbner <heiko@sntech.de>
---
 drivers/video/auo_k190x.c |   43 ++++++++++++++++++++++-------------------=
--
 1 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/video/auo_k190x.c b/drivers/video/auo_k190x.c
index 9cd9b7e..7f4c4ef 100644
--- a/drivers/video/auo_k190x.c
+++ b/drivers/video/auo_k190x.c
@@ -376,16 +376,25 @@ static int auok190xfb_check_var(struct fb_var_screeni=
nfo *var,
 				   struct fb_info *info)
 {
 	struct device *dev =3D info->device;
+	struct auok190xfb_par *par =3D info->par;
+	struct panel_info *panel =3D &panel_table[par->resolution];
 	int size;
=20
-	if (info->var.xres !=3D var->xres || info->var.yres !=3D var->yres ||
-	    info->var.xres_virtual !=3D var->xres_virtual ||
-	    info->var.yres_virtual !=3D var->yres_virtual) {
-		pr_info("%s: Resolution not supported: X%u x Y%u\n",
-			 __func__, var->xres, var->yres);
-		return -EINVAL;
+	/*
+	 * Dimensions
+	 */
+
+	if (par->rotation & 1) {
+		var->xres =3D panel->h;
+		var->yres =3D panel->w;
+	} else {
+		var->xres =3D panel->w;
+		var->yres =3D panel->h;
 	}
=20
+	var->xres_virtual =3D var->xres;
+	var->yres_virtual =3D var->yres;
+
 	/*
 	 *  Memory limit
 	 */
@@ -899,21 +908,6 @@ int __devinit auok190x_common_probe(struct platform_de=
vice *pdev,
=20
 	panel =3D &panel_table[board->resolution];
=20
-	/* if 90 degree rotation, switch width and height */
-	if (board->rotation & 1) {
-		info->var.xres =3D panel->h;
-		info->var.yres =3D panel->w;
-		info->var.xres_virtual =3D panel->h;
-		info->var.yres_virtual =3D panel->w;
-		info->fix.line_length =3D panel->h * info->var.bits_per_pixel / 8;
-	} else {
-		info->var.xres =3D panel->w;
-		info->var.yres =3D panel->h;
-		info->var.xres_virtual =3D panel->w;
-		info->var.yres_virtual =3D panel->h;
-		info->fix.line_length =3D panel->w * info->var.bits_per_pixel / 8;
-	}
-
 	par->resolution =3D board->resolution;
 	par->rotation =3D board->rotation;
=20
@@ -934,6 +928,13 @@ int __devinit auok190x_common_probe(struct platform_de=
vice *pdev,
 	info->flags =3D FBINFO_FLAG_DEFAULT | FBINFO_VIRTFB;
 	info->fbops =3D &auok190xfb_ops;
=20
+	ret =3D auok190xfb_check_var(&info->var, info);
+	if (ret)
+		goto err_defio;
+
+	info->fix.line_length =3D info->var.xres_virtual *
+				info->var.bits_per_pixel / 8;
+
 	/* deferred io init */
=20
 	info->fbdefio =3D devm_kzalloc(info->device,
--=20
1.7.2.3


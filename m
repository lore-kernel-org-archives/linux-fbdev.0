From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Fri, 22 Mar 2013 14:17:00 +0000
Subject: [PATCH 8/9] AUO-K190x: add framebuffer rotation support
Message-Id: <201303221517.01056.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Change the driver to use the framebuffer rotation functions to be
able to change the rotation at runtime.

This also removes the setting of the rotation via the platform data.

Signed-off-by: Heiko St=C3=BCbner <heiko@sntech.de>
---
 drivers/video/auo_k190x.c   |   25 ++++++++++++++++++++-----
 include/video/auo_k190xfb.h |    1 -
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/video/auo_k190x.c b/drivers/video/auo_k190x.c
index 69abb9c..87cff5b 100644
--- a/drivers/video/auo_k190x.c
+++ b/drivers/video/auo_k190x.c
@@ -486,12 +486,20 @@ static int auok190xfb_check_var(struct fb_var_screeni=
nfo *var,
 	 * Dimensions
 	 */
=20
-	if (par->rotation & 1) {
-		var->xres =3D panel->h;
-		var->yres =3D panel->w;
-	} else {
+	switch (var->rotate) {
+	case FB_ROTATE_UR:
+	case FB_ROTATE_UD:
 		var->xres =3D panel->w;
 		var->yres =3D panel->h;
+		break;
+	case FB_ROTATE_CW:
+	case FB_ROTATE_CCW:
+		var->xres =3D panel->h;
+		var->yres =3D panel->w;
+		break;
+	default:
+		dev_dbg(dev, "Invalid rotation request\n");
+		return -EINVAL;
 	}
=20
 	var->xres_virtual =3D var->xres;
@@ -533,8 +541,15 @@ static int auok190xfb_set_par(struct fb_info *info)
 {
 	struct auok190xfb_par *par =3D info->par;
=20
+	par->rotation =3D info->var.rotate;
 	auok190xfb_set_fix(info);
=20
+	/* reinit the controller to honor the rotation */
+	par->init(par);
+
+	/* wait for init to complete */
+	par->board->wait_for_rdy(par);
+
 	return 0;
 }
=20
@@ -1029,7 +1044,7 @@ int __devinit auok190x_common_probe(struct platform_d=
evice *pdev,
 	panel =3D &panel_table[board->resolution];
=20
 	par->resolution =3D board->resolution;
-	par->rotation =3D board->rotation;
+	par->rotation =3D 0;
=20
 	/* videomemory handling */
=20
diff --git a/include/video/auo_k190xfb.h b/include/video/auo_k190xfb.h
index 609efe8..ad7bc51 100644
--- a/include/video/auo_k190xfb.h
+++ b/include/video/auo_k190xfb.h
@@ -98,7 +98,6 @@ struct auok190x_board {
 	int gpio_nbusy;
=20
 	int resolution;
-	int rotation;
 	int quirks;
 	int fps;
 };
--=20
1.7.2.3


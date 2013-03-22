From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Fri, 22 Mar 2013 14:13:02 +0000
Subject: [PATCH 1/9] AUO-K190x: Use correct line length
Message-Id: <201303221513.02390.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Previously all functions that used the line length used xres directly,
thus hardcoding a 8bits per pixel value.

This patch calculates the correct line length according to the actual
bits per pixel value and changes all line length users to use the
calculated line length value.

Signed-off-by: Heiko St=C3=BCbner <heiko@sntech.de>
---
 drivers/video/auo_k1900fb.c |    5 +++--
 drivers/video/auo_k1901fb.c |    5 +++--
 drivers/video/auo_k190x.c   |   15 ++++++++-------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/video/auo_k1900fb.c b/drivers/video/auo_k1900fb.c
index c36cf96..b02fab5d 100644
--- a/drivers/video/auo_k1900fb.c
+++ b/drivers/video/auo_k1900fb.c
@@ -82,6 +82,7 @@ static void auok1900_update_region(struct auok190xfb_par =
*par, int mode,
 	struct device *dev =3D par->info->device;
 	unsigned char *buf =3D (unsigned char *)par->info->screen_base;
 	int xres =3D par->info->var.xres;
+	int line_length =3D par->info->fix.line_length;
 	u16 args[4];
=20
 	pm_runtime_get_sync(dev);
@@ -100,9 +101,9 @@ static void auok1900_update_region(struct auok190xfb_pa=
r *par, int mode,
 	args[1] =3D y1 + 1;
 	args[2] =3D xres;
 	args[3] =3D y2 - y1;
-	buf +=3D y1 * xres;
+	buf +=3D y1 * line_length;
 	auok190x_send_cmdargs_pixels(par, AUOK1900_CMD_PARTIALDISP, 4, args,
-				     ((y2 - y1) * xres)/2, (u16 *) buf);
+				     ((y2 - y1) * line_length)/2, (u16 *) buf);
 	auok190x_send_command(par, AUOK190X_CMD_DATA_STOP);
=20
 	par->update_cnt++;
diff --git a/drivers/video/auo_k1901fb.c b/drivers/video/auo_k1901fb.c
index 1c054c1..ece99b8 100644
--- a/drivers/video/auo_k1901fb.c
+++ b/drivers/video/auo_k1901fb.c
@@ -121,6 +121,7 @@ static void auok1901_update_region(struct auok190xfb_pa=
r *par, int mode,
 	struct device *dev =3D par->info->device;
 	unsigned char *buf =3D (unsigned char *)par->info->screen_base;
 	int xres =3D par->info->var.xres;
+	int line_length =3D par->info->fix.line_length;
 	u16 args[5];
=20
 	pm_runtime_get_sync(dev);
@@ -139,9 +140,9 @@ static void auok1901_update_region(struct auok190xfb_pa=
r *par, int mode,
 	args[1] =3D y1 + 1;
 	args[2] =3D xres;
 	args[3] =3D y2 - y1;
-	buf +=3D y1 * xres;
+	buf +=3D y1 * line_length;
 	auok190x_send_cmdargs_pixels_nowait(par, AUOK1901_CMD_DMA_START, 4,
-					    args, ((y2 - y1) * xres)/2,
+					    args, ((y2 - y1) * line_length)/2,
 					    (u16 *) buf);
 	auok190x_send_command_nowait(par, AUOK190X_CMD_DATA_STOP);
=20
diff --git a/drivers/video/auo_k190x.c b/drivers/video/auo_k190x.c
index 77da6a2..6c2879d 100644
--- a/drivers/video/auo_k190x.c
+++ b/drivers/video/auo_k190x.c
@@ -223,8 +223,8 @@ static void auok190xfb_dpy_deferred_io(struct fb_info *=
info,
 {
 	struct fb_deferred_io *fbdefio =3D info->fbdefio;
 	struct auok190xfb_par *par =3D info->par;
+	u16 line_length =3D info->fix.line_length;
 	u16 yres =3D info->var.yres;
-	u16 xres =3D info->var.xres;
 	u16 y1 =3D 0, h =3D 0;
 	int prev_index =3D -1;
 	struct page *cur;
@@ -253,7 +253,7 @@ static void auok190xfb_dpy_deferred_io(struct fb_info *=
info,
 	}
=20
 	/* height increment is fixed per page */
-	h_inc =3D DIV_ROUND_UP(PAGE_SIZE , xres);
+	h_inc =3D DIV_ROUND_UP(PAGE_SIZE , line_length);
=20
 	/* calculate number of pages from pixel height */
 	threshold =3D par->consecutive_threshold / h_inc;
@@ -264,7 +264,7 @@ static void auok190xfb_dpy_deferred_io(struct fb_info *=
info,
 	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
 		if (prev_index < 0) {
 			/* just starting so assign first page */
-			y1 =3D (cur->index << PAGE_SHIFT) / xres;
+			y1 =3D (cur->index << PAGE_SHIFT) / line_length;
 			h =3D h_inc;
 		} else if ((cur->index - prev_index) <=3D threshold) {
 			/* page is within our threshold for single updates */
@@ -274,7 +274,7 @@ static void auok190xfb_dpy_deferred_io(struct fb_info *=
info,
 			par->update_partial(par, y1, y1 + h);
=20
 			/* start over with our non consecutive page */
-			y1 =3D (cur->index << PAGE_SHIFT) / xres;
+			y1 =3D (cur->index << PAGE_SHIFT) / line_length;
 			h =3D h_inc;
 		}
 		prev_index =3D cur->index;
@@ -895,13 +895,13 @@ int __devinit auok190x_common_probe(struct platform_d=
evice *pdev,
 		info->var.yres =3D panel->w;
 		info->var.xres_virtual =3D panel->h;
 		info->var.yres_virtual =3D panel->w;
-		info->fix.line_length =3D panel->h;
+		info->fix.line_length =3D panel->h * info->var.bits_per_pixel / 8;
 	} else {
 		info->var.xres =3D panel->w;
 		info->var.yres =3D panel->h;
 		info->var.xres_virtual =3D panel->w;
 		info->var.yres_virtual =3D panel->h;
-		info->fix.line_length =3D panel->w;
+		info->fix.line_length =3D panel->w * info->var.bits_per_pixel / 8;
 	}
=20
 	par->resolution =3D board->resolution;
@@ -909,7 +909,8 @@ int __devinit auok190x_common_probe(struct platform_dev=
ice *pdev,
=20
 	/* videomemory handling */
=20
-	videomemorysize =3D roundup((panel->w * panel->h), PAGE_SIZE);
+	videomemorysize =3D roundup((panel->w * panel->h) *
+				info->var.bits_per_pixel / 8, PAGE_SIZE);
 	videomemory =3D vmalloc(videomemorysize);
 	if (!videomemory) {
 		ret =3D -ENOMEM;
--=20
1.7.2.3


From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bytesatwork.ch>
Date: Fri, 03 Jul 2015 08:38:16 +0000
Subject: [PATCH 3/3] fbdev: use largest logo if possible
Message-Id: <1435912696-17546-4-git-send-email-urs.fassler@bytesatwork.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435912696-17546-1-git-send-email-urs.fassler@bytesatwork.ch>
In-Reply-To: <1435912696-17546-1-git-send-email-urs.fassler@bytesatwork.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, oliver.staebler@bytesatwork.ch, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, urs.fassler@bytesatwork.ch

If CONFIG_FB_LOGO_LARGEST is set, fbdev uses the largest boot logo to
display.

Signed-off-by: Urs F=C3=A4ssler <urs.fassler@bytesatwork.ch>
---
 drivers/video/fbdev/core/fbmem.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fb=
mem.c
index 0705d88..319f168 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -595,7 +595,7 @@ static inline int fb_show_extra_logos(struct fb_info *i=
nfo, int y, int rotate)
 int fb_prepare_logo(struct fb_info *info, int rotate)
 {
 	int depth =3D fb_get_color_depth(&info->var, &info->fix);
-	unsigned int yres;
+	unsigned int xres, yres;
=20
 	memset(&fb_logo, 0, sizeof(struct logo_data));
=20
@@ -616,18 +616,25 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 		depth =3D 4;
 	}
=20
-	/* Return if no suitable logo was found */
+	if (rotate =3D FB_ROTATE_UR || rotate =3D FB_ROTATE_UD) {
+		xres =3D info->var.xres;
+		yres =3D info->var.yres;
+	} else {
+		xres =3D info->var.yres;
+		yres =3D info->var.xres;
+	}
+
+#ifdef CONFIG_FB_LOGO_LARGEST
+	fb_logo.logo =3D fb_find_logo_largest(depth, xres, yres);
+#else
 	fb_logo.logo =3D fb_find_logo(depth);
+#endif
=20
+	/* Return if no suitable logo was found */
 	if (!fb_logo.logo) {
 		return 0;
 	}
=20
-	if (rotate =3D FB_ROTATE_UR || rotate =3D FB_ROTATE_UD)
-		yres =3D info->var.yres;
-	else
-		yres =3D info->var.xres;
-
 	if (fb_logo.logo->height > yres) {
 		fb_logo.logo =3D NULL;
 		return 0;
--=20
2.1.4


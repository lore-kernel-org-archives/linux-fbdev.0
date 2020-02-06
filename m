From: Finn Thain <fthain@telegraphics.com.au>
Date: Thu, 06 Feb 2020 23:01:13 +0000
Subject: [PATCH v2 1/3] fbdev/g364fb: Fix build failure
Message-Id: <5504c0c416525ed8c7b8440e5f9971f2a7b59f28.1581030073.git.fthain@telegraphics.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1581030073.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1581030073.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>
Cc: linux-fbdev@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, linux-mips@vger.kernel.org

This patch resolves these compiler errors and warnings --

  CC      drivers/video/fbdev/g364fb.o
drivers/video/fbdev/g364fb.c: In function 'g364fb_cursor':
drivers/video/fbdev/g364fb.c:137:9: error: 'x' undeclared (first use in thi=
s function)
drivers/video/fbdev/g364fb.c:137:9: note: each undeclared identifier is rep=
orted only once for each function it appears in
drivers/video/fbdev/g364fb.c:137:7: error: implicit declaration of function=
 'fontwidth' [-Werror=3Dimplicit-function-declaration]
drivers/video/fbdev/g364fb.c:137:23: error: 'p' undeclared (first use in th=
is function)
drivers/video/fbdev/g364fb.c:137:38: error: 'y' undeclared (first use in th=
is function)
drivers/video/fbdev/g364fb.c:137:7: error: implicit declaration of function=
 'fontheight' [-Werror=3Dimplicit-function-declaration]
drivers/video/fbdev/g364fb.c: In function 'g364fb_init':
drivers/video/fbdev/g364fb.c:233:24: error: 'fbvar' undeclared (first use i=
n this function)
drivers/video/fbdev/g364fb.c:234:24: error: 'xres' undeclared (first use in=
 this function)
drivers/video/fbdev/g364fb.c:201:14: warning: unused variable 'j' [-Wunused=
-variable]
drivers/video/fbdev/g364fb.c:197:25: warning: unused variable 'pal_ptr' [-W=
unused-variable]

The MIPS Magnum framebuffer console now works when tested in QEMU.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/video/fbdev/g364fb.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/video/fbdev/g364fb.c b/drivers/video/fbdev/g364fb.c
index 845b79da2a7c..05837a3b985c 100644
--- a/drivers/video/fbdev/g364fb.c
+++ b/drivers/video/fbdev/g364fb.c
@@ -108,7 +108,6 @@ static int g364fb_pan_display(struct fb_var_screeninfo =
*var,
 static int g364fb_setcolreg(u_int regno, u_int red, u_int green,
 			    u_int blue, u_int transp,
 			    struct fb_info *info);
-static int g364fb_cursor(struct fb_info *info, struct fb_cursor *cursor);
 static int g364fb_blank(int blank, struct fb_info *info);
=20
 static const struct fb_ops g364fb_ops =3D {
@@ -119,28 +118,8 @@ static const struct fb_ops g364fb_ops =3D {
 	.fb_fillrect	=3D cfb_fillrect,
 	.fb_copyarea	=3D cfb_copyarea,
 	.fb_imageblit	=3D cfb_imageblit,
-	.fb_cursor	=3D g364fb_cursor,
 };
=20
-int g364fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
-{
-=09
-	switch (cursor->enable) {
-	case CM_ERASE:
-		*(unsigned int *) CTLA_REG |=3D CURS_TOGGLE;
-		break;
-
-	case CM_MOVE:
-	case CM_DRAW:
-		*(unsigned int *) CTLA_REG &=3D ~CURS_TOGGLE;
-		*(unsigned int *) CURS_POS_REG -		    ((x * fontwidth(p)) << 12) | ((y *=
 fontheight(p)) -
-						  info->var.yoffset);
-		break;
-	}
-	return 0;
-}
-
 /*
  *  Pan or Wrap the Display
  *
@@ -194,11 +173,9 @@ static int g364fb_setcolreg(u_int regno, u_int red, u_=
int green,
  */
 int __init g364fb_init(void)
 {
-	volatile unsigned int *pal_ptr -	    (volatile unsigned int *) CLR_PAL_RE=
G;
 	volatile unsigned int *curs_pal_ptr  	    (volatile unsigned int *) CURS_=
PAL_REG;
-	int mem, i, j;
+	int mem, i;
=20
 	if (fb_get_options("g364fb", NULL))
 		return -ENODEV;
@@ -230,8 +207,8 @@ int __init g364fb_init(void)
 	 */
 	*(unsigned short *) (CURS_PAT_REG + 14 * 64) =3D 0xffff;
 	*(unsigned short *) (CURS_PAT_REG + 15 * 64) =3D 0xffff;
-	fb_var.xres_virtual =3D fbvar.xres;
-	fb_fix.line_length =3D (xres / 8) * fb_var.bits_per_pixel;
+	fb_var.xres_virtual =3D fb_var.xres;
+	fb_fix.line_length =3D fb_var.xres_virtual * fb_var.bits_per_pixel / 8;
 	fb_fix.smem_start =3D 0x40000000;	/* physical address */
 	/* get size of video memory; this is special for the JAZZ hardware */
 	mem =3D (r4030_read_reg32(JAZZ_R4030_CONFIG) >> 8) & 3;
--=20
2.24.1

From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH 1/3] s3c2410fb: adds pixclock to
	s3c2410fb_display
Date: Wed, 15 Aug 2007 10:24:06 +0200
Message-ID: <46c2b8264ef91@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46c2b826516a0"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILEAj-0001te-Hi for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Aug 2007 01:24:20 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ILEAi-0005VH-FY
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Aug 2007 01:24:09 -0700
Received: from poczta-15.free.wp-sa.pl (HELO localhost) ([10.1.1.43])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	15 Aug 2007 10:24:06 +0200
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Ben Dooks <ben-linux@fluff.org>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>

This is a multi-part message in MIME format.

--part46c2b826516a0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds pixelclock field to the s3c2410fb_display
structure and make use of it in the driver.

The Bast machine defined 9 modes but pixclock and margin
values are defined only for the 640x480 modes so I removed
other modes.

This patch also fixes wrong display type constant for the
SMDK2440 board.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-amlm5900.c=20
linux-2.6.23/arch/arm/mach-s3c2410/mach-amlm5900.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-amlm5900.c=09
2007-08-14 21:03:15.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-amlm5900.c	2007-08-
14 21:02:22.000000000 +0200
@@ -174,6 +174,7 @@ static struct s3c2410fb_display __initda
=20
 	.type		=3D S3C2410_LCDCON1_STN4,
=20
+	.pixclock	=3D 680000, /* HCLK =3D 100MHz */
 	.xres		=3D 160,
 	.yres		=3D 160,
 	.bpp		=3D 4,
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-bast.c=20
linux-2.6.23/arch/arm/mach-s3c2410/mach-bast.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-bast.c	2007-08-
14 21:03:15.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-bast.c	2007-08-
14 21:02:22.000000000 +0200
@@ -473,25 +473,7 @@ static struct s3c2410fb_display __initda
 		.width		=3D 640,
 		.height		=3D 480,
=20
-		.xres		=3D 320,
-		.yres		=3D 240,
-		.left_margin	=3D 40,
-		.right_margin	=3D 20,
-		.hsync_len	=3D 88,
-		.upper_margin	=3D 30,
-		.lower_margin	=3D 32,
-		.vsync_len	=3D 3,
-
-		.bpp		=3D 4,
-
-		.lcdcon1	=3D 0x00000176,
-		.lcdcon5	=3D 0x00014b02,
-	},
-	{
-		.type		=3D S3C2410_LCDCON1_TFT,
-		.width		=3D 640,
-		.height		=3D 480,
-
+		.pixclock	=3D 33333,
 		.xres		=3D 640,
 		.yres		=3D 480,
 		.bpp		=3D 4,
@@ -510,42 +492,7 @@ static struct s3c2410fb_display __initda
 		.width		=3D 640,
 		.height		=3D 480,
=20
-		.xres		=3D 800,
-		.yres		=3D 600,
-		.bpp		=3D 4,
-		.left_margin	=3D 40,
-		.right_margin	=3D 20,
-		.hsync_len	=3D 88,
-		.upper_margin	=3D 30,
-		.lower_margin	=3D 32,
-		.vsync_len	=3D 3,
-
-		.lcdcon1	=3D 0x00000176,
-		.lcdcon5	=3D 0x00014b02,
-	},
-	{
-		.type		=3D S3C2410_LCDCON1_TFT,
-		.width		=3D 640,
-		.height		=3D 480,
-
-		.xres		=3D 320,
-		.yres		=3D 240,
-		.bpp		=3D 8,
-		.left_margin	=3D 40,
-		.right_margin	=3D 20,
-		.hsync_len	=3D 88,
-		.upper_margin	=3D 30,
-		.lower_margin	=3D 32,
-		.vsync_len	=3D 3,
-
-		.lcdcon1	=3D 0x00000176,
-		.lcdcon5	=3D 0x00014b02,
-	},
-	{
-		.type		=3D S3C2410_LCDCON1_TFT,
-		.width		=3D 640,
-		.height		=3D 480,
-
+		.pixclock	=3D 33333,
 		.xres		=3D 640,
 		.yres		=3D 480,
 		.bpp		=3D 8,
@@ -564,42 +511,7 @@ static struct s3c2410fb_display __initda
 		.width		=3D 640,
 		.height		=3D 480,
=20
-		.xres		=3D 800,
-		.yres		=3D 600,
-		.bpp		=3D 8,
-		.left_margin	=3D 40,
-		.right_margin	=3D 20,
-		.hsync_len	=3D 88,
-		.upper_margin	=3D 30,
-		.lower_margin	=3D 32,
-		.vsync_len	=3D 3,
-
-		.lcdcon1	=3D 0x00000176,
-		.lcdcon5	=3D 0x00014b02,
-	},
-	{
-		.type		=3D S3C2410_LCDCON1_TFT,
-		.width		=3D 640,
-		.height		=3D 480,
-
-		.xres		=3D 320,
-		.yres		=3D 240,
-		.bpp		=3D 16,
-		.left_margin	=3D 40,
-		.right_margin	=3D 20,
-		.hsync_len	=3D 88,
-		.upper_margin	=3D 30,
-		.lower_margin	=3D 32,
-		.vsync_len	=3D 3,
-
-		.lcdcon1	=3D 0x00000176,
-		.lcdcon5	=3D 0x00014b02,
-	},
-	{
-		.type		=3D S3C2410_LCDCON1_TFT,
-		.width		=3D 640,
-		.height		=3D 480,
-
+		.pixclock	=3D 33333,
 		.xres		=3D 640,
 		.yres		=3D 480,
 		.bpp		=3D 16,
@@ -613,24 +525,6 @@ static struct s3c2410fb_display __initda
 		.lcdcon1	=3D 0x00000176,
 		.lcdcon5	=3D 0x00014b02,
 	},
-	{
-		.type		=3D S3C2410_LCDCON1_TFT,
-		.width		=3D 640,
-		.height		=3D 480,
-
-		.xres		=3D 800,
-		.yres		=3D 600,
-		.bpp		=3D 16,
-		.left_margin	=3D 40,
-		.right_margin	=3D 20,
-		.hsync_len	=3D 88,
-		.upper_margin	=3D 30,
-		.lower_margin	=3D 32,
-		.vsync_len	=3D 3,
-
-		.lcdcon1	=3D 0x00000176,
-		.lcdcon5	=3D 0x00014b02,
-	},
 };
=20
 /* LCD/VGA controller */
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-h1940.c=20
linux-2.6.23/arch/arm/mach-s3c2410/mach-h1940.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-h1940.c	2007-08-
14 21:03:15.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-h1940.c	2007-08-
14 21:02:22.000000000 +0200
@@ -145,6 +145,7 @@ static struct s3c2410fb_display h1940_lc
 	.type =3D		S3C2410_LCDCON1_TFT,
 	.width =3D	240,
 	.height =3D	320,
+	.pixclock =3D	260000,
 	.xres =3D		240,
 	.yres =3D		320,
 	.bpp =3D		16,
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-qt2410.c=20
linux-2.6.23/arch/arm/mach-s3c2410/mach-qt2410.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-qt2410.c=09
2007-08-14 21:03:16.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-qt2410.c	2007-08-
14 21:02:22.000000000 +0200
@@ -112,6 +112,7 @@ static struct s3c2410fb_display qt2410_l
 		.width		=3D 640,
 		.height		=3D 480,
=20
+		.pixclock	=3D 40000, /* HCLK/4 */
 		.xres		=3D 640,
 		.yres		=3D 480,
 		.bpp		=3D 16,
@@ -137,6 +138,7 @@ static struct s3c2410fb_display qt2410_l
 		.type		=3D S3C2410_LCDCON1_TFT,
 		.width		=3D 480,
 		.height		=3D 640,
+		.pixclock	=3D 40000, /* HCLK/4 */
 		.xres		=3D 480,
 		.yres		=3D 640,
 		.bpp		=3D 16,
@@ -162,6 +164,7 @@ static struct s3c2410fb_display qt2410_l
 		.type		=3D S3C2410_LCDCON1_TFT,
 		.width		=3D 240,
 		.height		=3D 320,
+		.pixclock	=3D 100000, /* HCLK/10 */
 		.xres		=3D 240,
 		.yres		=3D 320,
 		.bpp		=3D 16,
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2440/mach-rx3715.c=20
linux-2.6.23/arch/arm/mach-s3c2440/mach-rx3715.c
--- linux-2.6.23.old/arch/arm/mach-s3c2440/mach-rx3715.c=09
2007-08-14 21:03:16.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2440/mach-rx3715.c	2007-08-
14 21:02:22.000000000 +0200
@@ -123,6 +123,7 @@ static struct s3c2410fb_display rx3715_l
 	.width		=3D 240,
 	.height		=3D 320,
=20
+	.pixclock	=3D 260000,
 	.xres		=3D 240,
 	.yres		=3D 320,
 	.bpp		=3D 16,
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2440/mach-smdk2440.c=20
linux-2.6.23/arch/arm/mach-s3c2440/mach-smdk2440.c
--- linux-2.6.23.old/arch/arm/mach-s3c2440/mach-smdk2440.c=09
2007-08-14 21:03:16.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2440/mach-smdk2440.c	2007-08-
14 21:02:22.000000000 +0200
@@ -115,11 +115,12 @@ static struct s3c2410fb_display smdk2440
 			  S3C2410_LCDCON5_PWREN |
 			  S3C2410_LCDCON5_HWSWP,
=20
-	.type		=3D S3C2410_LCDCON1_TFT16BPP,
+	.type		=3D S3C2410_LCDCON1_TFT,
=20
 	.width		=3D 240,
 	.height		=3D 320,
=20
+	.pixclock	=3D 166667, /* HCLK 60 MHz, divisor 10 */
 	.xres		=3D 240,
 	.yres		=3D 320,
 	.bpp		=3D 16,
diff -urp linux-2.6.23.old/drivers/video/s3c2410fb.c linux-
2.6.23/drivers/video/s3c2410fb.c
--- linux-2.6.23.old/drivers/video/s3c2410fb.c	2007-08-14=20
21:03:16.000000000 +0200
+++ linux-2.6.23/drivers/video/s3c2410fb.c	2007-08-14=20
21:02:59.000000000 +0200
@@ -199,6 +199,7 @@ static int s3c2410fb_check_var(struct fb
 	var->width =3D display->width;
=20
 	/* copy lcd settings */
+	var->pixclock =3D display->pixclock;
 	var->left_margin =3D display->left_margin;
 	var->right_margin =3D display->right_margin;
 	var->upper_margin =3D display->upper_margin;
@@ -297,10 +298,6 @@ static void s3c2410fb_calculate_stn_lcd_
 	unsigned wdly =3D (var->left_margin >> 4) - 1;
 	unsigned wlh =3D (var->hsync_len >> 4) - 1;
=20
-	dprintk("%s: var->xres  =3D %d\n", __FUNCTION__, var-
>xres);
-	dprintk("%s: var->yres  =3D %d\n", __FUNCTION__, var-
>yres);
-	dprintk("%s: var->bpp   =3D %d\n", __FUNCTION__, var-
>bits_per_pixel);
-
 	if (type !=3D S3C2410_LCDCON1_STN4)
 		hs >>=3D 1;
=20
@@ -359,10 +356,6 @@ static void s3c2410fb_calculate_tft_lcd_
 	const struct s3c2410fb_info *fbi =3D info->par;
 	const struct fb_var_screeninfo *var =3D &info->var;
=20
-	dprintk("%s: var->xres  =3D %d\n", __FUNCTION__, var-
>xres);
-	dprintk("%s: var->yres  =3D %d\n", __FUNCTION__, var-
>yres);
-	dprintk("%s: var->bpp   =3D %d\n", __FUNCTION__, var-
>bits_per_pixel);
-
 	regs->lcdcon1 &=3D ~S3C2410_LCDCON1_MODEMASK;
=20
 	switch (var->bits_per_pixel) {
@@ -427,28 +420,25 @@ static void s3c2410fb_activate_var(struc
 	void __iomem *regs =3D fbi->io;
 	int type =3D fbi->regs.lcdcon1 & S3C2410_LCDCON1_TFT;
 	struct fb_var_screeninfo *var =3D &info->var;
+	int clkdiv =3D s3c2410fb_calc_pixclk(fbi, var->pixclock) /=20
2;
=20
-	if (var->pixclock > 0) {
-		int clkdiv =3D s3c2410fb_calc_pixclk(fbi, var-
>pixclock);
-
-		if (type =3D=3D S3C2410_LCDCON1_TFT) {
-			clkdiv =3D (clkdiv / 2) - 1;
-			if (clkdiv < 0)
-				clkdiv =3D 0;
-		} else {
-			clkdiv =3D (clkdiv / 2);
-			if (clkdiv < 2)
-				clkdiv =3D 2;
-		}
-
-		fbi->regs.lcdcon1=20
&=3D ~S3C2410_LCDCON1_CLKVAL(0x3ff);
-		fbi->regs.lcdcon1 |=3D =20
S3C2410_LCDCON1_CLKVAL(clkdiv);
-	}
+	dprintk("%s: var->xres  =3D %d\n", __FUNCTION__, var-
>xres);
+	dprintk("%s: var->yres  =3D %d\n", __FUNCTION__, var-
>yres);
+	dprintk("%s: var->bpp   =3D %d\n", __FUNCTION__, var-
>bits_per_pixel);
=20
-	if (type =3D=3D S3C2410_LCDCON1_TFT)
+	if (type =3D=3D S3C2410_LCDCON1_TFT) {
 		s3c2410fb_calculate_tft_lcd_regs(info, &fbi-
>regs);
-	else
+		--clkdiv;
+		if (clkdiv < 0)
+			clkdiv =3D 0;
+	} else {
 		s3c2410fb_calculate_stn_lcd_regs(info, &fbi-
>regs);
+		if (clkdiv < 2)
+			clkdiv =3D 2;
+	}
+
+	fbi->regs.lcdcon1 &=3D ~S3C2410_LCDCON1_CLKVAL(0x3ff);
+	fbi->regs.lcdcon1 |=3D  S3C2410_LCDCON1_CLKVAL(clkdiv);
=20
 	/* write new registers */
=20
diff -urp linux-2.6.23.old/include/asm-arm/arch-s3c2410/fb.h=20
linux-2.6.23/include/asm-arm/arch-s3c2410/fb.h
--- linux-2.6.23.old/include/asm-arm/arch-s3c2410/fb.h	2007-08-
14 21:03:16.000000000 +0200
+++ linux-2.6.23/include/asm-arm/arch-s3c2410/fb.h	2007-08-
14 21:02:22.000000000 +0200
@@ -36,6 +36,7 @@ struct s3c2410fb_display {
 	unsigned short yres;
 	unsigned short bpp;
=20
+	unsigned pixclock;		/* pixclock in=20
picoseconds */
 	unsigned short left_margin;  /* value in pixels (TFT) or=20
HCLKs (STN) */
 	unsigned short right_margin; /* value in pixels (TFT) or=20
HCLKs (STN) */
 	unsigned short hsync_len;    /* value in pixels (TFT) or=20
HCLKs (STN) */


----------------------------------------------------
Producenci filmu SEZON NA MISIA przedstawiaj=B1
surfuj=B1ce pingwiny w nowej, animowanej komedii
NA FALI -  w kinach od 10 sierpnia!=20
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fnafali_zwi=
astun.html&sid=3D1256

--part46c2b826516a0
Content-Type: application/octet-stream; name="s3c2410fb-pixclock.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="s3c2410fb-pixclock.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggYWRk
cyBwaXhlbGNsb2NrIGZpZWxkIHRvIHRoZSBzM2MyNDEwZmJfZGlzcGxheQpzdHJ1Y3R1cmUgYW5k
IG1ha2UgdXNlIG9mIGl0IGluIHRoZSBkcml2ZXIuCgpUaGUgQmFzdCBtYWNoaW5lIGRlZmluZWQg
OSBtb2RlcyBidXQgcGl4Y2xvY2sgYW5kIG1hcmdpbgp2YWx1ZXMgYXJlIGRlZmluZWQgb25seSBm
b3IgdGhlIDY0MHg0ODAgbW9kZXMgc28gSSByZW1vdmVkCm90aGVyIG1vZGVzLgoKVGhpcyBwYXRj
aCBhbHNvIGZpeGVzIHdyb25nIGRpc3BsYXkgdHlwZSBjb25zdGFudCBmb3IgdGhlClNNREsyNDQw
IGJvYXJkLgoKU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5w
bD4KCi0tLQoKZGlmZiAtdXJwIGxpbnV4LTIuNi4yMy5vbGQvYXJjaC9hcm0vbWFjaC1zM2MyNDEw
L21hY2gtYW1sbTU5MDAuYyBsaW51eC0yLjYuMjMvYXJjaC9hcm0vbWFjaC1zM2MyNDEwL21hY2gt
YW1sbTU5MDAuYwotLS0gbGludXgtMi42LjIzLm9sZC9hcmNoL2FybS9tYWNoLXMzYzI0MTAvbWFj
aC1hbWxtNTkwMC5jCTIwMDctMDgtMTQgMjE6MDM6MTUuMDAwMDAwMDAwICswMjAwCisrKyBsaW51
eC0yLjYuMjMvYXJjaC9hcm0vbWFjaC1zM2MyNDEwL21hY2gtYW1sbTU5MDAuYwkyMDA3LTA4LTE0
IDIxOjAyOjIyLjAwMDAwMDAwMCArMDIwMApAQCAtMTc0LDYgKzE3NCw3IEBAIHN0YXRpYyBzdHJ1
Y3QgczNjMjQxMGZiX2Rpc3BsYXkgX19pbml0ZGEKIAogCS50eXBlCQk9IFMzQzI0MTBfTENEQ09O
MV9TVE40LAogCisJLnBpeGNsb2NrCT0gNjgwMDAwLCAvKiBIQ0xLID0gMTAwTUh6ICovCiAJLnhy
ZXMJCT0gMTYwLAogCS55cmVzCQk9IDE2MCwKIAkuYnBwCQk9IDQsCmRpZmYgLXVycCBsaW51eC0y
LjYuMjMub2xkL2FyY2gvYXJtL21hY2gtczNjMjQxMC9tYWNoLWJhc3QuYyBsaW51eC0yLjYuMjMv
YXJjaC9hcm0vbWFjaC1zM2MyNDEwL21hY2gtYmFzdC5jCi0tLSBsaW51eC0yLjYuMjMub2xkL2Fy
Y2gvYXJtL21hY2gtczNjMjQxMC9tYWNoLWJhc3QuYwkyMDA3LTA4LTE0IDIxOjAzOjE1LjAwMDAw
MDAwMCArMDIwMAorKysgbGludXgtMi42LjIzL2FyY2gvYXJtL21hY2gtczNjMjQxMC9tYWNoLWJh
c3QuYwkyMDA3LTA4LTE0IDIxOjAyOjIyLjAwMDAwMDAwMCArMDIwMApAQCAtNDczLDI1ICs0NzMs
NyBAQCBzdGF0aWMgc3RydWN0IHMzYzI0MTBmYl9kaXNwbGF5IF9faW5pdGRhCiAJCS53aWR0aAkJ
PSA2NDAsCiAJCS5oZWlnaHQJCT0gNDgwLAogCi0JCS54cmVzCQk9IDMyMCwKLQkJLnlyZXMJCT0g
MjQwLAotCQkubGVmdF9tYXJnaW4JPSA0MCwKLQkJLnJpZ2h0X21hcmdpbgk9IDIwLAotCQkuaHN5
bmNfbGVuCT0gODgsCi0JCS51cHBlcl9tYXJnaW4JPSAzMCwKLQkJLmxvd2VyX21hcmdpbgk9IDMy
LAotCQkudnN5bmNfbGVuCT0gMywKLQotCQkuYnBwCQk9IDQsCi0KLQkJLmxjZGNvbjEJPSAweDAw
MDAwMTc2LAotCQkubGNkY29uNQk9IDB4MDAwMTRiMDIsCi0JfSwKLQl7Ci0JCS50eXBlCQk9IFMz
QzI0MTBfTENEQ09OMV9URlQsCi0JCS53aWR0aAkJPSA2NDAsCi0JCS5oZWlnaHQJCT0gNDgwLAot
CisJCS5waXhjbG9jawk9IDMzMzMzLAogCQkueHJlcwkJPSA2NDAsCiAJCS55cmVzCQk9IDQ4MCwK
IAkJLmJwcAkJPSA0LApAQCAtNTEwLDQyICs0OTIsNyBAQCBzdGF0aWMgc3RydWN0IHMzYzI0MTBm
Yl9kaXNwbGF5IF9faW5pdGRhCiAJCS53aWR0aAkJPSA2NDAsCiAJCS5oZWlnaHQJCT0gNDgwLAog
Ci0JCS54cmVzCQk9IDgwMCwKLQkJLnlyZXMJCT0gNjAwLAotCQkuYnBwCQk9IDQsCi0JCS5sZWZ0
X21hcmdpbgk9IDQwLAotCQkucmlnaHRfbWFyZ2luCT0gMjAsCi0JCS5oc3luY19sZW4JPSA4OCwK
LQkJLnVwcGVyX21hcmdpbgk9IDMwLAotCQkubG93ZXJfbWFyZ2luCT0gMzIsCi0JCS52c3luY19s
ZW4JPSAzLAotCi0JCS5sY2Rjb24xCT0gMHgwMDAwMDE3NiwKLQkJLmxjZGNvbjUJPSAweDAwMDE0
YjAyLAotCX0sCi0JewotCQkudHlwZQkJPSBTM0MyNDEwX0xDRENPTjFfVEZULAotCQkud2lkdGgJ
CT0gNjQwLAotCQkuaGVpZ2h0CQk9IDQ4MCwKLQotCQkueHJlcwkJPSAzMjAsCi0JCS55cmVzCQk9
IDI0MCwKLQkJLmJwcAkJPSA4LAotCQkubGVmdF9tYXJnaW4JPSA0MCwKLQkJLnJpZ2h0X21hcmdp
bgk9IDIwLAotCQkuaHN5bmNfbGVuCT0gODgsCi0JCS51cHBlcl9tYXJnaW4JPSAzMCwKLQkJLmxv
d2VyX21hcmdpbgk9IDMyLAotCQkudnN5bmNfbGVuCT0gMywKLQotCQkubGNkY29uMQk9IDB4MDAw
MDAxNzYsCi0JCS5sY2Rjb241CT0gMHgwMDAxNGIwMiwKLQl9LAotCXsKLQkJLnR5cGUJCT0gUzND
MjQxMF9MQ0RDT04xX1RGVCwKLQkJLndpZHRoCQk9IDY0MCwKLQkJLmhlaWdodAkJPSA0ODAsCi0K
KwkJLnBpeGNsb2NrCT0gMzMzMzMsCiAJCS54cmVzCQk9IDY0MCwKIAkJLnlyZXMJCT0gNDgwLAog
CQkuYnBwCQk9IDgsCkBAIC01NjQsNDIgKzUxMSw3IEBAIHN0YXRpYyBzdHJ1Y3QgczNjMjQxMGZi
X2Rpc3BsYXkgX19pbml0ZGEKIAkJLndpZHRoCQk9IDY0MCwKIAkJLmhlaWdodAkJPSA0ODAsCiAK
LQkJLnhyZXMJCT0gODAwLAotCQkueXJlcwkJPSA2MDAsCi0JCS5icHAJCT0gOCwKLQkJLmxlZnRf
bWFyZ2luCT0gNDAsCi0JCS5yaWdodF9tYXJnaW4JPSAyMCwKLQkJLmhzeW5jX2xlbgk9IDg4LAot
CQkudXBwZXJfbWFyZ2luCT0gMzAsCi0JCS5sb3dlcl9tYXJnaW4JPSAzMiwKLQkJLnZzeW5jX2xl
bgk9IDMsCi0KLQkJLmxjZGNvbjEJPSAweDAwMDAwMTc2LAotCQkubGNkY29uNQk9IDB4MDAwMTRi
MDIsCi0JfSwKLQl7Ci0JCS50eXBlCQk9IFMzQzI0MTBfTENEQ09OMV9URlQsCi0JCS53aWR0aAkJ
PSA2NDAsCi0JCS5oZWlnaHQJCT0gNDgwLAotCi0JCS54cmVzCQk9IDMyMCwKLQkJLnlyZXMJCT0g
MjQwLAotCQkuYnBwCQk9IDE2LAotCQkubGVmdF9tYXJnaW4JPSA0MCwKLQkJLnJpZ2h0X21hcmdp
bgk9IDIwLAotCQkuaHN5bmNfbGVuCT0gODgsCi0JCS51cHBlcl9tYXJnaW4JPSAzMCwKLQkJLmxv
d2VyX21hcmdpbgk9IDMyLAotCQkudnN5bmNfbGVuCT0gMywKLQotCQkubGNkY29uMQk9IDB4MDAw
MDAxNzYsCi0JCS5sY2Rjb241CT0gMHgwMDAxNGIwMiwKLQl9LAotCXsKLQkJLnR5cGUJCT0gUzND
MjQxMF9MQ0RDT04xX1RGVCwKLQkJLndpZHRoCQk9IDY0MCwKLQkJLmhlaWdodAkJPSA0ODAsCi0K
KwkJLnBpeGNsb2NrCT0gMzMzMzMsCiAJCS54cmVzCQk9IDY0MCwKIAkJLnlyZXMJCT0gNDgwLAog
CQkuYnBwCQk9IDE2LApAQCAtNjEzLDI0ICs1MjUsNiBAQCBzdGF0aWMgc3RydWN0IHMzYzI0MTBm
Yl9kaXNwbGF5IF9faW5pdGRhCiAJCS5sY2Rjb24xCT0gMHgwMDAwMDE3NiwKIAkJLmxjZGNvbjUJ
PSAweDAwMDE0YjAyLAogCX0sCi0JewotCQkudHlwZQkJPSBTM0MyNDEwX0xDRENPTjFfVEZULAot
CQkud2lkdGgJCT0gNjQwLAotCQkuaGVpZ2h0CQk9IDQ4MCwKLQotCQkueHJlcwkJPSA4MDAsCi0J
CS55cmVzCQk9IDYwMCwKLQkJLmJwcAkJPSAxNiwKLQkJLmxlZnRfbWFyZ2luCT0gNDAsCi0JCS5y
aWdodF9tYXJnaW4JPSAyMCwKLQkJLmhzeW5jX2xlbgk9IDg4LAotCQkudXBwZXJfbWFyZ2luCT0g
MzAsCi0JCS5sb3dlcl9tYXJnaW4JPSAzMiwKLQkJLnZzeW5jX2xlbgk9IDMsCi0KLQkJLmxjZGNv
bjEJPSAweDAwMDAwMTc2LAotCQkubGNkY29uNQk9IDB4MDAwMTRiMDIsCi0JfSwKIH07CiAKIC8q
IExDRC9WR0EgY29udHJvbGxlciAqLwpkaWZmIC11cnAgbGludXgtMi42LjIzLm9sZC9hcmNoL2Fy
bS9tYWNoLXMzYzI0MTAvbWFjaC1oMTk0MC5jIGxpbnV4LTIuNi4yMy9hcmNoL2FybS9tYWNoLXMz
YzI0MTAvbWFjaC1oMTk0MC5jCi0tLSBsaW51eC0yLjYuMjMub2xkL2FyY2gvYXJtL21hY2gtczNj
MjQxMC9tYWNoLWgxOTQwLmMJMjAwNy0wOC0xNCAyMTowMzoxNS4wMDAwMDAwMDAgKzAyMDAKKysr
IGxpbnV4LTIuNi4yMy9hcmNoL2FybS9tYWNoLXMzYzI0MTAvbWFjaC1oMTk0MC5jCTIwMDctMDgt
MTQgMjE6MDI6MjIuMDAwMDAwMDAwICswMjAwCkBAIC0xNDUsNiArMTQ1LDcgQEAgc3RhdGljIHN0
cnVjdCBzM2MyNDEwZmJfZGlzcGxheSBoMTk0MF9sYwogCS50eXBlID0JCVMzQzI0MTBfTENEQ09O
MV9URlQsCiAJLndpZHRoID0JMjQwLAogCS5oZWlnaHQgPQkzMjAsCisJLnBpeGNsb2NrID0JMjYw
MDAwLAogCS54cmVzID0JCTI0MCwKIAkueXJlcyA9CQkzMjAsCiAJLmJwcCA9CQkxNiwKZGlmZiAt
dXJwIGxpbnV4LTIuNi4yMy5vbGQvYXJjaC9hcm0vbWFjaC1zM2MyNDEwL21hY2gtcXQyNDEwLmMg
bGludXgtMi42LjIzL2FyY2gvYXJtL21hY2gtczNjMjQxMC9tYWNoLXF0MjQxMC5jCi0tLSBsaW51
eC0yLjYuMjMub2xkL2FyY2gvYXJtL21hY2gtczNjMjQxMC9tYWNoLXF0MjQxMC5jCTIwMDctMDgt
MTQgMjE6MDM6MTYuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvYXJjaC9hcm0vbWFj
aC1zM2MyNDEwL21hY2gtcXQyNDEwLmMJMjAwNy0wOC0xNCAyMTowMjoyMi4wMDAwMDAwMDAgKzAy
MDAKQEAgLTExMiw2ICsxMTIsNyBAQCBzdGF0aWMgc3RydWN0IHMzYzI0MTBmYl9kaXNwbGF5IHF0
MjQxMF9sCiAJCS53aWR0aAkJPSA2NDAsCiAJCS5oZWlnaHQJCT0gNDgwLAogCisJCS5waXhjbG9j
awk9IDQwMDAwLCAvKiBIQ0xLLzQgKi8KIAkJLnhyZXMJCT0gNjQwLAogCQkueXJlcwkJPSA0ODAs
CiAJCS5icHAJCT0gMTYsCkBAIC0xMzcsNiArMTM4LDcgQEAgc3RhdGljIHN0cnVjdCBzM2MyNDEw
ZmJfZGlzcGxheSBxdDI0MTBfbAogCQkudHlwZQkJPSBTM0MyNDEwX0xDRENPTjFfVEZULAogCQku
d2lkdGgJCT0gNDgwLAogCQkuaGVpZ2h0CQk9IDY0MCwKKwkJLnBpeGNsb2NrCT0gNDAwMDAsIC8q
IEhDTEsvNCAqLwogCQkueHJlcwkJPSA0ODAsCiAJCS55cmVzCQk9IDY0MCwKIAkJLmJwcAkJPSAx
NiwKQEAgLTE2Miw2ICsxNjQsNyBAQCBzdGF0aWMgc3RydWN0IHMzYzI0MTBmYl9kaXNwbGF5IHF0
MjQxMF9sCiAJCS50eXBlCQk9IFMzQzI0MTBfTENEQ09OMV9URlQsCiAJCS53aWR0aAkJPSAyNDAs
CiAJCS5oZWlnaHQJCT0gMzIwLAorCQkucGl4Y2xvY2sJPSAxMDAwMDAsIC8qIEhDTEsvMTAgKi8K
IAkJLnhyZXMJCT0gMjQwLAogCQkueXJlcwkJPSAzMjAsCiAJCS5icHAJCT0gMTYsCmRpZmYgLXVy
cCBsaW51eC0yLjYuMjMub2xkL2FyY2gvYXJtL21hY2gtczNjMjQ0MC9tYWNoLXJ4MzcxNS5jIGxp
bnV4LTIuNi4yMy9hcmNoL2FybS9tYWNoLXMzYzI0NDAvbWFjaC1yeDM3MTUuYwotLS0gbGludXgt
Mi42LjIzLm9sZC9hcmNoL2FybS9tYWNoLXMzYzI0NDAvbWFjaC1yeDM3MTUuYwkyMDA3LTA4LTE0
IDIxOjAzOjE2LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIzL2FyY2gvYXJtL21hY2gt
czNjMjQ0MC9tYWNoLXJ4MzcxNS5jCTIwMDctMDgtMTQgMjE6MDI6MjIuMDAwMDAwMDAwICswMjAw
CkBAIC0xMjMsNiArMTIzLDcgQEAgc3RhdGljIHN0cnVjdCBzM2MyNDEwZmJfZGlzcGxheSByeDM3
MTVfbAogCS53aWR0aAkJPSAyNDAsCiAJLmhlaWdodAkJPSAzMjAsCiAKKwkucGl4Y2xvY2sJPSAy
NjAwMDAsCiAJLnhyZXMJCT0gMjQwLAogCS55cmVzCQk9IDMyMCwKIAkuYnBwCQk9IDE2LApkaWZm
IC11cnAgbGludXgtMi42LjIzLm9sZC9hcmNoL2FybS9tYWNoLXMzYzI0NDAvbWFjaC1zbWRrMjQ0
MC5jIGxpbnV4LTIuNi4yMy9hcmNoL2FybS9tYWNoLXMzYzI0NDAvbWFjaC1zbWRrMjQ0MC5jCi0t
LSBsaW51eC0yLjYuMjMub2xkL2FyY2gvYXJtL21hY2gtczNjMjQ0MC9tYWNoLXNtZGsyNDQwLmMJ
MjAwNy0wOC0xNCAyMTowMzoxNi4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMy9hcmNo
L2FybS9tYWNoLXMzYzI0NDAvbWFjaC1zbWRrMjQ0MC5jCTIwMDctMDgtMTQgMjE6MDI6MjIuMDAw
MDAwMDAwICswMjAwCkBAIC0xMTUsMTEgKzExNSwxMiBAQCBzdGF0aWMgc3RydWN0IHMzYzI0MTBm
Yl9kaXNwbGF5IHNtZGsyNDQwCiAJCQkgIFMzQzI0MTBfTENEQ09ONV9QV1JFTiB8CiAJCQkgIFMz
QzI0MTBfTENEQ09ONV9IV1NXUCwKIAotCS50eXBlCQk9IFMzQzI0MTBfTENEQ09OMV9URlQxNkJQ
UCwKKwkudHlwZQkJPSBTM0MyNDEwX0xDRENPTjFfVEZULAogCiAJLndpZHRoCQk9IDI0MCwKIAku
aGVpZ2h0CQk9IDMyMCwKIAorCS5waXhjbG9jawk9IDE2NjY2NywgLyogSENMSyA2MCBNSHosIGRp
dmlzb3IgMTAgKi8KIAkueHJlcwkJPSAyNDAsCiAJLnlyZXMJCT0gMzIwLAogCS5icHAJCT0gMTYs
CmRpZmYgLXVycCBsaW51eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vczNjMjQxMGZiLmMgbGlu
dXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vczNjMjQxMGZiLmMKLS0tIGxpbnV4LTIuNi4yMy5vbGQv
ZHJpdmVycy92aWRlby9zM2MyNDEwZmIuYwkyMDA3LTA4LTE0IDIxOjAzOjE2LjAwMDAwMDAwMCAr
MDIwMAorKysgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vczNjMjQxMGZiLmMJMjAwNy0wOC0x
NCAyMTowMjo1OS4wMDAwMDAwMDAgKzAyMDAKQEAgLTE5OSw2ICsxOTksNyBAQCBzdGF0aWMgaW50
IHMzYzI0MTBmYl9jaGVja192YXIoc3RydWN0IGZiCiAJdmFyLT53aWR0aCA9IGRpc3BsYXktPndp
ZHRoOwogCiAJLyogY29weSBsY2Qgc2V0dGluZ3MgKi8KKwl2YXItPnBpeGNsb2NrID0gZGlzcGxh
eS0+cGl4Y2xvY2s7CiAJdmFyLT5sZWZ0X21hcmdpbiA9IGRpc3BsYXktPmxlZnRfbWFyZ2luOwog
CXZhci0+cmlnaHRfbWFyZ2luID0gZGlzcGxheS0+cmlnaHRfbWFyZ2luOwogCXZhci0+dXBwZXJf
bWFyZ2luID0gZGlzcGxheS0+dXBwZXJfbWFyZ2luOwpAQCAtMjk3LDEwICsyOTgsNiBAQCBzdGF0
aWMgdm9pZCBzM2MyNDEwZmJfY2FsY3VsYXRlX3N0bl9sY2RfCiAJdW5zaWduZWQgd2RseSA9ICh2
YXItPmxlZnRfbWFyZ2luID4+IDQpIC0gMTsKIAl1bnNpZ25lZCB3bGggPSAodmFyLT5oc3luY19s
ZW4gPj4gNCkgLSAxOwogCi0JZHByaW50aygiJXM6IHZhci0+eHJlcyAgPSAlZFxuIiwgX19GVU5D
VElPTl9fLCB2YXItPnhyZXMpOwotCWRwcmludGsoIiVzOiB2YXItPnlyZXMgID0gJWRcbiIsIF9f
RlVOQ1RJT05fXywgdmFyLT55cmVzKTsKLQlkcHJpbnRrKCIlczogdmFyLT5icHAgICA9ICVkXG4i
LCBfX0ZVTkNUSU9OX18sIHZhci0+Yml0c19wZXJfcGl4ZWwpOwotCiAJaWYgKHR5cGUgIT0gUzND
MjQxMF9MQ0RDT04xX1NUTjQpCiAJCWhzID4+PSAxOwogCkBAIC0zNTksMTAgKzM1Niw2IEBAIHN0
YXRpYyB2b2lkIHMzYzI0MTBmYl9jYWxjdWxhdGVfdGZ0X2xjZF8KIAljb25zdCBzdHJ1Y3QgczNj
MjQxMGZiX2luZm8gKmZiaSA9IGluZm8tPnBhcjsKIAljb25zdCBzdHJ1Y3QgZmJfdmFyX3NjcmVl
bmluZm8gKnZhciA9ICZpbmZvLT52YXI7CiAKLQlkcHJpbnRrKCIlczogdmFyLT54cmVzICA9ICVk
XG4iLCBfX0ZVTkNUSU9OX18sIHZhci0+eHJlcyk7Ci0JZHByaW50aygiJXM6IHZhci0+eXJlcyAg
PSAlZFxuIiwgX19GVU5DVElPTl9fLCB2YXItPnlyZXMpOwotCWRwcmludGsoIiVzOiB2YXItPmJw
cCAgID0gJWRcbiIsIF9fRlVOQ1RJT05fXywgdmFyLT5iaXRzX3Blcl9waXhlbCk7Ci0KIAlyZWdz
LT5sY2Rjb24xICY9IH5TM0MyNDEwX0xDRENPTjFfTU9ERU1BU0s7CiAKIAlzd2l0Y2ggKHZhci0+
Yml0c19wZXJfcGl4ZWwpIHsKQEAgLTQyNywyOCArNDIwLDI1IEBAIHN0YXRpYyB2b2lkIHMzYzI0
MTBmYl9hY3RpdmF0ZV92YXIoc3RydWMKIAl2b2lkIF9faW9tZW0gKnJlZ3MgPSBmYmktPmlvOwog
CWludCB0eXBlID0gZmJpLT5yZWdzLmxjZGNvbjEgJiBTM0MyNDEwX0xDRENPTjFfVEZUOwogCXN0
cnVjdCBmYl92YXJfc2NyZWVuaW5mbyAqdmFyID0gJmluZm8tPnZhcjsKKwlpbnQgY2xrZGl2ID0g
czNjMjQxMGZiX2NhbGNfcGl4Y2xrKGZiaSwgdmFyLT5waXhjbG9jaykgLyAyOwogCi0JaWYgKHZh
ci0+cGl4Y2xvY2sgPiAwKSB7Ci0JCWludCBjbGtkaXYgPSBzM2MyNDEwZmJfY2FsY19waXhjbGso
ZmJpLCB2YXItPnBpeGNsb2NrKTsKLQotCQlpZiAodHlwZSA9PSBTM0MyNDEwX0xDRENPTjFfVEZU
KSB7Ci0JCQljbGtkaXYgPSAoY2xrZGl2IC8gMikgLSAxOwotCQkJaWYgKGNsa2RpdiA8IDApCi0J
CQkJY2xrZGl2ID0gMDsKLQkJfSBlbHNlIHsKLQkJCWNsa2RpdiA9IChjbGtkaXYgLyAyKTsKLQkJ
CWlmIChjbGtkaXYgPCAyKQotCQkJCWNsa2RpdiA9IDI7Ci0JCX0KLQotCQlmYmktPnJlZ3MubGNk
Y29uMSAmPSB+UzNDMjQxMF9MQ0RDT04xX0NMS1ZBTCgweDNmZik7Ci0JCWZiaS0+cmVncy5sY2Rj
b24xIHw9ICBTM0MyNDEwX0xDRENPTjFfQ0xLVkFMKGNsa2Rpdik7Ci0JfQorCWRwcmludGsoIiVz
OiB2YXItPnhyZXMgID0gJWRcbiIsIF9fRlVOQ1RJT05fXywgdmFyLT54cmVzKTsKKwlkcHJpbnRr
KCIlczogdmFyLT55cmVzICA9ICVkXG4iLCBfX0ZVTkNUSU9OX18sIHZhci0+eXJlcyk7CisJZHBy
aW50aygiJXM6IHZhci0+YnBwICAgPSAlZFxuIiwgX19GVU5DVElPTl9fLCB2YXItPmJpdHNfcGVy
X3BpeGVsKTsKIAotCWlmICh0eXBlID09IFMzQzI0MTBfTENEQ09OMV9URlQpCisJaWYgKHR5cGUg
PT0gUzNDMjQxMF9MQ0RDT04xX1RGVCkgewogCQlzM2MyNDEwZmJfY2FsY3VsYXRlX3RmdF9sY2Rf
cmVncyhpbmZvLCAmZmJpLT5yZWdzKTsKLQllbHNlCisJCS0tY2xrZGl2OworCQlpZiAoY2xrZGl2
IDwgMCkKKwkJCWNsa2RpdiA9IDA7CisJfSBlbHNlIHsKIAkJczNjMjQxMGZiX2NhbGN1bGF0ZV9z
dG5fbGNkX3JlZ3MoaW5mbywgJmZiaS0+cmVncyk7CisJCWlmIChjbGtkaXYgPCAyKQorCQkJY2xr
ZGl2ID0gMjsKKwl9CisKKwlmYmktPnJlZ3MubGNkY29uMSAmPSB+UzNDMjQxMF9MQ0RDT04xX0NM
S1ZBTCgweDNmZik7CisJZmJpLT5yZWdzLmxjZGNvbjEgfD0gIFMzQzI0MTBfTENEQ09OMV9DTEtW
QUwoY2xrZGl2KTsKIAogCS8qIHdyaXRlIG5ldyByZWdpc3RlcnMgKi8KIApkaWZmIC11cnAgbGlu
dXgtMi42LjIzLm9sZC9pbmNsdWRlL2FzbS1hcm0vYXJjaC1zM2MyNDEwL2ZiLmggbGludXgtMi42
LjIzL2luY2x1ZGUvYXNtLWFybS9hcmNoLXMzYzI0MTAvZmIuaAotLS0gbGludXgtMi42LjIzLm9s
ZC9pbmNsdWRlL2FzbS1hcm0vYXJjaC1zM2MyNDEwL2ZiLmgJMjAwNy0wOC0xNCAyMTowMzoxNi4w
MDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMy9pbmNsdWRlL2FzbS1hcm0vYXJjaC1zM2My
NDEwL2ZiLmgJMjAwNy0wOC0xNCAyMTowMjoyMi4wMDAwMDAwMDAgKzAyMDAKQEAgLTM2LDYgKzM2
LDcgQEAgc3RydWN0IHMzYzI0MTBmYl9kaXNwbGF5IHsKIAl1bnNpZ25lZCBzaG9ydCB5cmVzOwog
CXVuc2lnbmVkIHNob3J0IGJwcDsKIAorCXVuc2lnbmVkIHBpeGNsb2NrOwkJLyogcGl4Y2xvY2sg
aW4gcGljb3NlY29uZHMgKi8KIAl1bnNpZ25lZCBzaG9ydCBsZWZ0X21hcmdpbjsgIC8qIHZhbHVl
IGluIHBpeGVscyAoVEZUKSBvciBIQ0xLcyAoU1ROKSAqLwogCXVuc2lnbmVkIHNob3J0IHJpZ2h0
X21hcmdpbjsgLyogdmFsdWUgaW4gcGl4ZWxzIChURlQpIG9yIEhDTEtzIChTVE4pICovCiAJdW5z
aWduZWQgc2hvcnQgaHN5bmNfbGVuOyAgICAvKiB2YWx1ZSBpbiBwaXhlbHMgKFRGVCkgb3IgSENM
S3MgKFNUTikgKi8K

--part46c2b826516a0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--part46c2b826516a0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part46c2b826516a0--

From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH 2/3] s3c2410fb: removes lcdcon1 register
	value from s3c2410fb_display
Date: Wed, 15 Aug 2007 10:24:41 +0200
Message-ID: <46c2b8497d168@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46c2b8497f86f"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILEBK-0001y5-Nk for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Aug 2007 01:24:48 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ILEBH-0005nA-NC
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Aug 2007 01:24:46 -0700
Received: from poczta-15.free.wp-sa.pl (HELO localhost) ([10.1.1.43])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	15 Aug 2007 10:24:41 +0200
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

--part46c2b8497f86f
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes lcdcon1 register field from the=20
s3c2410fb_display
as all bits are calculated from other fields.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-amlm5900.c=20
linux-2.6.23/arch/arm/mach-s3c2410/mach-amlm5900.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-amlm5900.c=09
2007-08-14 21:13:31.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-amlm5900.c	2007-08-
14 21:13:52.000000000 +0200
@@ -184,7 +184,6 @@ static struct s3c2410fb_display __initda
 	.upper_margin	=3D 0,
 	.lower_margin	=3D 0,
=20
-	.lcdcon1	=3D 0x00008225,
 	.lcdcon5	=3D 0x00000001,
 };
=20
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-bast.c=20
linux-2.6.23/arch/arm/mach-s3c2410/mach-bast.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-bast.c	2007-08-
14 21:13:31.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-bast.c	2007-08-
14 21:13:52.000000000 +0200
@@ -484,7 +484,6 @@ static struct s3c2410fb_display __initda
 		.lower_margin	=3D 32,
 		.vsync_len	=3D 3,
=20
-		.lcdcon1	=3D 0x00000176,
 		.lcdcon5	=3D 0x00014b02,
 	},
 	{
@@ -503,7 +502,6 @@ static struct s3c2410fb_display __initda
 		.lower_margin	=3D 32,
 		.vsync_len	=3D 3,
=20
-		.lcdcon1	=3D 0x00000176,
 		.lcdcon5	=3D 0x00014b02,
 	},
 	{
@@ -522,7 +520,6 @@ static struct s3c2410fb_display __initda
 		.lower_margin	=3D 32,
 		.vsync_len	=3D 3,
=20
-		.lcdcon1	=3D 0x00000176,
 		.lcdcon5	=3D 0x00014b02,
 	},
 };
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-h1940.c=20
linux-2.6.23/arch/arm/mach-s3c2410/mach-h1940.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-h1940.c	2007-08-
14 21:13:31.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-h1940.c	2007-08-
14 21:13:52.000000000 +0200
@@ -134,10 +134,6 @@ static struct s3c2410_udc_mach_info h194
  * Set lcd on or off
  **/
 static struct s3c2410fb_display h1940_lcd __initdata =3D {
-	.lcdcon1=3D	S3C2410_LCDCON1_TFT16BPP | \
-			S3C2410_LCDCON1_TFT | \
-			S3C2410_LCDCON1_CLKVAL(0x0C),
-
 	.lcdcon5=3D	S3C2410_LCDCON5_FRM565 | \
 			S3C2410_LCDCON5_INVVLINE | \
 			S3C2410_LCDCON5_HWSWP,
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-qt2410.c=20
linux-2.6.23/arch/arm/mach-s3c2410/mach-qt2410.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-qt2410.c=09
2007-08-14 21:13:31.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-qt2410.c	2007-08-
14 21:13:52.000000000 +0200
@@ -98,10 +98,6 @@ static struct s3c2410_uartcfg smdk2410_u
 static struct s3c2410fb_display qt2410_lcd_cfg[] __initdata =3D {
 	{
 		/* Configuration for 640x480 SHARP LQ080V3DG01 */
-		.lcdcon1 =3D S3C2410_LCDCON1_TFT16BPP |
-			   S3C2410_LCDCON1_TFT |
-			   S3C2410_LCDCON1_CLKVAL(0x01), /* HCLK/
4 */
-
 		.lcdcon5 =3D S3C2410_LCDCON5_FRM565 |
 			   S3C2410_LCDCON5_INVVLINE |
 			   S3C2410_LCDCON5_INVVFRAME |
@@ -125,10 +121,6 @@ static struct s3c2410fb_display qt2410_l
 	},
 	{
 		/* Configuration for 480x640 toppoly TD028TTEC1=20
*/
-		.lcdcon1 =3D S3C2410_LCDCON1_TFT16BPP |
-			   S3C2410_LCDCON1_TFT |
-			   S3C2410_LCDCON1_CLKVAL(0x01), /* HCLK/
4 */
-
 		.lcdcon5 =3D S3C2410_LCDCON5_FRM565 |
 			   S3C2410_LCDCON5_INVVLINE |
 			   S3C2410_LCDCON5_INVVFRAME |
@@ -151,10 +143,6 @@ static struct s3c2410fb_display qt2410_l
 	},
 	{
 		/* Config for 240x320 LCD */
-		.lcdcon1 =3D S3C2410_LCDCON1_TFT16BPP |
-			   S3C2410_LCDCON1_TFT |
-			   S3C2410_LCDCON1_CLKVAL(0x04),
-
 		.lcdcon5 =3D S3C2410_LCDCON5_FRM565 |
 			   S3C2410_LCDCON5_INVVLINE |
 			   S3C2410_LCDCON5_INVVFRAME |
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2440/mach-rx3715.c=20
linux-2.6.23/arch/arm/mach-s3c2440/mach-rx3715.c
--- linux-2.6.23.old/arch/arm/mach-s3c2440/mach-rx3715.c=09
2007-08-14 21:13:31.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2440/mach-rx3715.c	2007-08-
14 21:13:52.000000000 +0200
@@ -111,10 +111,6 @@ static struct s3c2410_uartcfg rx3715_uar
 /* framebuffer lcd controller information */
=20
 static struct s3c2410fb_display rx3715_lcdcfg __initdata =3D {
-	.lcdcon1 =3D	S3C2410_LCDCON1_TFT16BPP | \
-			S3C2410_LCDCON1_TFT | \
-			S3C2410_LCDCON1_CLKVAL(0x0C),
-
 	.lcdcon5 =3D	S3C2410_LCDCON5_INVVLINE |
 			S3C2410_LCDCON5_FRM565 |
 			S3C2410_LCDCON5_HWSWP,
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2440/mach-smdk2440.c=20
linux-2.6.23/arch/arm/mach-s3c2440/mach-smdk2440.c
--- linux-2.6.23.old/arch/arm/mach-s3c2440/mach-smdk2440.c=09
2007-08-14 21:13:31.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2440/mach-smdk2440.c	2007-08-
14 21:13:52.000000000 +0200
@@ -105,10 +105,6 @@ static struct s3c2410_uartcfg smdk2440_u
=20
 static struct s3c2410fb_display smdk2440_lcd_cfg __initdata =3D {
=20
-	.lcdcon1	=3D S3C2410_LCDCON1_TFT16BPP |
-			  S3C2410_LCDCON1_TFT |
-			  S3C2410_LCDCON1_CLKVAL(0x04),
-
 	.lcdcon5	=3D S3C2410_LCDCON5_FRM565 |
 			  S3C2410_LCDCON5_INVVLINE |
 			  S3C2410_LCDCON5_INVVFRAME |
diff -urp linux-2.6.23.old/drivers/video/s3c2410fb.c linux-
2.6.23/drivers/video/s3c2410fb.c
--- linux-2.6.23.old/drivers/video/s3c2410fb.c	2007-08-14=20
21:13:31.000000000 +0200
+++ linux-2.6.23/drivers/video/s3c2410fb.c	2007-08-14=20
21:14:20.000000000 +0200
@@ -207,11 +207,9 @@ static int s3c2410fb_check_var(struct fb
 	var->vsync_len =3D display->vsync_len;
 	var->hsync_len =3D display->hsync_len;
=20
-	fbi->regs.lcdcon1 =3D display->lcdcon1;
 	fbi->regs.lcdcon5 =3D display->lcdcon5;
 	/* set display type */
-	fbi->regs.lcdcon1 &=3D ~S3C2410_LCDCON1_TFT;
-	fbi->regs.lcdcon1 |=3D display->type;
+	fbi->regs.lcdcon1 =3D display->type;
=20
 	var->transp.offset =3D 0;
 	var->transp.length =3D 0;
@@ -301,8 +299,6 @@ static void s3c2410fb_calculate_stn_lcd_
 	if (type !=3D S3C2410_LCDCON1_STN4)
 		hs >>=3D 1;
=20
-	regs->lcdcon1 &=3D ~S3C2410_LCDCON1_MODEMASK;
-
 	switch (var->bits_per_pixel) {
 	case 1:
 		regs->lcdcon1 |=3D S3C2410_LCDCON1_STN1BPP;
@@ -356,8 +352,6 @@ static void s3c2410fb_calculate_tft_lcd_
 	const struct s3c2410fb_info *fbi =3D info->par;
 	const struct fb_var_screeninfo *var =3D &info->var;
=20
-	regs->lcdcon1 &=3D ~S3C2410_LCDCON1_MODEMASK;
-
 	switch (var->bits_per_pixel) {
 	case 1:
 		regs->lcdcon1 |=3D S3C2410_LCDCON1_TFT1BPP;
@@ -437,7 +431,6 @@ static void s3c2410fb_activate_var(struc
 			clkdiv =3D 2;
 	}
=20
-	fbi->regs.lcdcon1 &=3D ~S3C2410_LCDCON1_CLKVAL(0x3ff);
 	fbi->regs.lcdcon1 |=3D  S3C2410_LCDCON1_CLKVAL(clkdiv);
=20
 	/* write new registers */
diff -urp linux-2.6.23.old/include/asm-arm/arch-s3c2410/fb.h=20
linux-2.6.23/include/asm-arm/arch-s3c2410/fb.h
--- linux-2.6.23.old/include/asm-arm/arch-s3c2410/fb.h	2007-08-
14 21:13:31.000000000 +0200
+++ linux-2.6.23/include/asm-arm/arch-s3c2410/fb.h	2007-08-
14 21:13:52.000000000 +0200
@@ -45,7 +45,6 @@ struct s3c2410fb_display {
 	unsigned short vsync_len;	/* value in lines (TFT)=20
or 0 (STN) */
=20
 	/* lcd configuration registers */
-	unsigned long	lcdcon1;
 	unsigned long	lcdcon5;
 };
=20


----------------------------------------------------
Czy na wakacje warto zabra=E6 laptopa?
Zobacz gdzie dzia=B3aj=B1 strefy darmowego, bezprzewodowego Internetu!
Kliknij: http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd=
128.html&sid=3D1259

--part46c2b8497f86f
Content-Type: application/octet-stream; name="s3c2410fb-remove-lcdcon1.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="s3c2410fb-remove-lcdcon1.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggcmVt
b3ZlcyBsY2Rjb24xIHJlZ2lzdGVyIGZpZWxkIGZyb20gdGhlIHMzYzI0MTBmYl9kaXNwbGF5CmFz
IGFsbCBiaXRzIGFyZSBjYWxjdWxhdGVkIGZyb20gb3RoZXIgZmllbGRzLgoKU2lnbmVkLW9mZi1i
eTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KCi0tLQoKZGlmZiAtdXJwIGxp
bnV4LTIuNi4yMy5vbGQvYXJjaC9hcm0vbWFjaC1zM2MyNDEwL21hY2gtYW1sbTU5MDAuYyBsaW51
eC0yLjYuMjMvYXJjaC9hcm0vbWFjaC1zM2MyNDEwL21hY2gtYW1sbTU5MDAuYwotLS0gbGludXgt
Mi42LjIzLm9sZC9hcmNoL2FybS9tYWNoLXMzYzI0MTAvbWFjaC1hbWxtNTkwMC5jCTIwMDctMDgt
MTQgMjE6MTM6MzEuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvYXJjaC9hcm0vbWFj
aC1zM2MyNDEwL21hY2gtYW1sbTU5MDAuYwkyMDA3LTA4LTE0IDIxOjEzOjUyLjAwMDAwMDAwMCAr
MDIwMApAQCAtMTg0LDcgKzE4NCw2IEBAIHN0YXRpYyBzdHJ1Y3QgczNjMjQxMGZiX2Rpc3BsYXkg
X19pbml0ZGEKIAkudXBwZXJfbWFyZ2luCT0gMCwKIAkubG93ZXJfbWFyZ2luCT0gMCwKIAotCS5s
Y2Rjb24xCT0gMHgwMDAwODIyNSwKIAkubGNkY29uNQk9IDB4MDAwMDAwMDEsCiB9OwogCmRpZmYg
LXVycCBsaW51eC0yLjYuMjMub2xkL2FyY2gvYXJtL21hY2gtczNjMjQxMC9tYWNoLWJhc3QuYyBs
aW51eC0yLjYuMjMvYXJjaC9hcm0vbWFjaC1zM2MyNDEwL21hY2gtYmFzdC5jCi0tLSBsaW51eC0y
LjYuMjMub2xkL2FyY2gvYXJtL21hY2gtczNjMjQxMC9tYWNoLWJhc3QuYwkyMDA3LTA4LTE0IDIx
OjEzOjMxLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIzL2FyY2gvYXJtL21hY2gtczNj
MjQxMC9tYWNoLWJhc3QuYwkyMDA3LTA4LTE0IDIxOjEzOjUyLjAwMDAwMDAwMCArMDIwMApAQCAt
NDg0LDcgKzQ4NCw2IEBAIHN0YXRpYyBzdHJ1Y3QgczNjMjQxMGZiX2Rpc3BsYXkgX19pbml0ZGEK
IAkJLmxvd2VyX21hcmdpbgk9IDMyLAogCQkudnN5bmNfbGVuCT0gMywKIAotCQkubGNkY29uMQk9
IDB4MDAwMDAxNzYsCiAJCS5sY2Rjb241CT0gMHgwMDAxNGIwMiwKIAl9LAogCXsKQEAgLTUwMyw3
ICs1MDIsNiBAQCBzdGF0aWMgc3RydWN0IHMzYzI0MTBmYl9kaXNwbGF5IF9faW5pdGRhCiAJCS5s
b3dlcl9tYXJnaW4JPSAzMiwKIAkJLnZzeW5jX2xlbgk9IDMsCiAKLQkJLmxjZGNvbjEJPSAweDAw
MDAwMTc2LAogCQkubGNkY29uNQk9IDB4MDAwMTRiMDIsCiAJfSwKIAl7CkBAIC01MjIsNyArNTIw
LDYgQEAgc3RhdGljIHN0cnVjdCBzM2MyNDEwZmJfZGlzcGxheSBfX2luaXRkYQogCQkubG93ZXJf
bWFyZ2luCT0gMzIsCiAJCS52c3luY19sZW4JPSAzLAogCi0JCS5sY2Rjb24xCT0gMHgwMDAwMDE3
NiwKIAkJLmxjZGNvbjUJPSAweDAwMDE0YjAyLAogCX0sCiB9OwpkaWZmIC11cnAgbGludXgtMi42
LjIzLm9sZC9hcmNoL2FybS9tYWNoLXMzYzI0MTAvbWFjaC1oMTk0MC5jIGxpbnV4LTIuNi4yMy9h
cmNoL2FybS9tYWNoLXMzYzI0MTAvbWFjaC1oMTk0MC5jCi0tLSBsaW51eC0yLjYuMjMub2xkL2Fy
Y2gvYXJtL21hY2gtczNjMjQxMC9tYWNoLWgxOTQwLmMJMjAwNy0wOC0xNCAyMToxMzozMS4wMDAw
MDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMy9hcmNoL2FybS9tYWNoLXMzYzI0MTAvbWFjaC1o
MTk0MC5jCTIwMDctMDgtMTQgMjE6MTM6NTIuMDAwMDAwMDAwICswMjAwCkBAIC0xMzQsMTAgKzEz
NCw2IEBAIHN0YXRpYyBzdHJ1Y3QgczNjMjQxMF91ZGNfbWFjaF9pbmZvIGgxOTQKICAqIFNldCBs
Y2Qgb24gb3Igb2ZmCiAgKiovCiBzdGF0aWMgc3RydWN0IHMzYzI0MTBmYl9kaXNwbGF5IGgxOTQw
X2xjZCBfX2luaXRkYXRhID0gewotCS5sY2Rjb24xPQlTM0MyNDEwX0xDRENPTjFfVEZUMTZCUFAg
fCBcCi0JCQlTM0MyNDEwX0xDRENPTjFfVEZUIHwgXAotCQkJUzNDMjQxMF9MQ0RDT04xX0NMS1ZB
TCgweDBDKSwKLQogCS5sY2Rjb241PQlTM0MyNDEwX0xDRENPTjVfRlJNNTY1IHwgXAogCQkJUzND
MjQxMF9MQ0RDT041X0lOVlZMSU5FIHwgXAogCQkJUzNDMjQxMF9MQ0RDT041X0hXU1dQLApkaWZm
IC11cnAgbGludXgtMi42LjIzLm9sZC9hcmNoL2FybS9tYWNoLXMzYzI0MTAvbWFjaC1xdDI0MTAu
YyBsaW51eC0yLjYuMjMvYXJjaC9hcm0vbWFjaC1zM2MyNDEwL21hY2gtcXQyNDEwLmMKLS0tIGxp
bnV4LTIuNi4yMy5vbGQvYXJjaC9hcm0vbWFjaC1zM2MyNDEwL21hY2gtcXQyNDEwLmMJMjAwNy0w
OC0xNCAyMToxMzozMS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMy9hcmNoL2FybS9t
YWNoLXMzYzI0MTAvbWFjaC1xdDI0MTAuYwkyMDA3LTA4LTE0IDIxOjEzOjUyLjAwMDAwMDAwMCAr
MDIwMApAQCAtOTgsMTAgKzk4LDYgQEAgc3RhdGljIHN0cnVjdCBzM2MyNDEwX3VhcnRjZmcgc21k
azI0MTBfdQogc3RhdGljIHN0cnVjdCBzM2MyNDEwZmJfZGlzcGxheSBxdDI0MTBfbGNkX2NmZ1td
IF9faW5pdGRhdGEgPSB7CiAJewogCQkvKiBDb25maWd1cmF0aW9uIGZvciA2NDB4NDgwIFNIQVJQ
IExRMDgwVjNERzAxICovCi0JCS5sY2Rjb24xID0gUzNDMjQxMF9MQ0RDT04xX1RGVDE2QlBQIHwK
LQkJCSAgIFMzQzI0MTBfTENEQ09OMV9URlQgfAotCQkJICAgUzNDMjQxMF9MQ0RDT04xX0NMS1ZB
TCgweDAxKSwgLyogSENMSy80ICovCi0KIAkJLmxjZGNvbjUgPSBTM0MyNDEwX0xDRENPTjVfRlJN
NTY1IHwKIAkJCSAgIFMzQzI0MTBfTENEQ09ONV9JTlZWTElORSB8CiAJCQkgICBTM0MyNDEwX0xD
RENPTjVfSU5WVkZSQU1FIHwKQEAgLTEyNSwxMCArMTIxLDYgQEAgc3RhdGljIHN0cnVjdCBzM2My
NDEwZmJfZGlzcGxheSBxdDI0MTBfbAogCX0sCiAJewogCQkvKiBDb25maWd1cmF0aW9uIGZvciA0
ODB4NjQwIHRvcHBvbHkgVEQwMjhUVEVDMSAqLwotCQkubGNkY29uMSA9IFMzQzI0MTBfTENEQ09O
MV9URlQxNkJQUCB8Ci0JCQkgICBTM0MyNDEwX0xDRENPTjFfVEZUIHwKLQkJCSAgIFMzQzI0MTBf
TENEQ09OMV9DTEtWQUwoMHgwMSksIC8qIEhDTEsvNCAqLwotCiAJCS5sY2Rjb241ID0gUzNDMjQx
MF9MQ0RDT041X0ZSTTU2NSB8CiAJCQkgICBTM0MyNDEwX0xDRENPTjVfSU5WVkxJTkUgfAogCQkJ
ICAgUzNDMjQxMF9MQ0RDT041X0lOVlZGUkFNRSB8CkBAIC0xNTEsMTAgKzE0Myw2IEBAIHN0YXRp
YyBzdHJ1Y3QgczNjMjQxMGZiX2Rpc3BsYXkgcXQyNDEwX2wKIAl9LAogCXsKIAkJLyogQ29uZmln
IGZvciAyNDB4MzIwIExDRCAqLwotCQkubGNkY29uMSA9IFMzQzI0MTBfTENEQ09OMV9URlQxNkJQ
UCB8Ci0JCQkgICBTM0MyNDEwX0xDRENPTjFfVEZUIHwKLQkJCSAgIFMzQzI0MTBfTENEQ09OMV9D
TEtWQUwoMHgwNCksCi0KIAkJLmxjZGNvbjUgPSBTM0MyNDEwX0xDRENPTjVfRlJNNTY1IHwKIAkJ
CSAgIFMzQzI0MTBfTENEQ09ONV9JTlZWTElORSB8CiAJCQkgICBTM0MyNDEwX0xDRENPTjVfSU5W
VkZSQU1FIHwKZGlmZiAtdXJwIGxpbnV4LTIuNi4yMy5vbGQvYXJjaC9hcm0vbWFjaC1zM2MyNDQw
L21hY2gtcngzNzE1LmMgbGludXgtMi42LjIzL2FyY2gvYXJtL21hY2gtczNjMjQ0MC9tYWNoLXJ4
MzcxNS5jCi0tLSBsaW51eC0yLjYuMjMub2xkL2FyY2gvYXJtL21hY2gtczNjMjQ0MC9tYWNoLXJ4
MzcxNS5jCTIwMDctMDgtMTQgMjE6MTM6MzEuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYu
MjMvYXJjaC9hcm0vbWFjaC1zM2MyNDQwL21hY2gtcngzNzE1LmMJMjAwNy0wOC0xNCAyMToxMzo1
Mi4wMDAwMDAwMDAgKzAyMDAKQEAgLTExMSwxMCArMTExLDYgQEAgc3RhdGljIHN0cnVjdCBzM2My
NDEwX3VhcnRjZmcgcngzNzE1X3VhcgogLyogZnJhbWVidWZmZXIgbGNkIGNvbnRyb2xsZXIgaW5m
b3JtYXRpb24gKi8KIAogc3RhdGljIHN0cnVjdCBzM2MyNDEwZmJfZGlzcGxheSByeDM3MTVfbGNk
Y2ZnIF9faW5pdGRhdGEgPSB7Ci0JLmxjZGNvbjEgPQlTM0MyNDEwX0xDRENPTjFfVEZUMTZCUFAg
fCBcCi0JCQlTM0MyNDEwX0xDRENPTjFfVEZUIHwgXAotCQkJUzNDMjQxMF9MQ0RDT04xX0NMS1ZB
TCgweDBDKSwKLQogCS5sY2Rjb241ID0JUzNDMjQxMF9MQ0RDT041X0lOVlZMSU5FIHwKIAkJCVMz
QzI0MTBfTENEQ09ONV9GUk01NjUgfAogCQkJUzNDMjQxMF9MQ0RDT041X0hXU1dQLApkaWZmIC11
cnAgbGludXgtMi42LjIzLm9sZC9hcmNoL2FybS9tYWNoLXMzYzI0NDAvbWFjaC1zbWRrMjQ0MC5j
IGxpbnV4LTIuNi4yMy9hcmNoL2FybS9tYWNoLXMzYzI0NDAvbWFjaC1zbWRrMjQ0MC5jCi0tLSBs
aW51eC0yLjYuMjMub2xkL2FyY2gvYXJtL21hY2gtczNjMjQ0MC9tYWNoLXNtZGsyNDQwLmMJMjAw
Ny0wOC0xNCAyMToxMzozMS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMy9hcmNoL2Fy
bS9tYWNoLXMzYzI0NDAvbWFjaC1zbWRrMjQ0MC5jCTIwMDctMDgtMTQgMjE6MTM6NTIuMDAwMDAw
MDAwICswMjAwCkBAIC0xMDUsMTAgKzEwNSw2IEBAIHN0YXRpYyBzdHJ1Y3QgczNjMjQxMF91YXJ0
Y2ZnIHNtZGsyNDQwX3UKIAogc3RhdGljIHN0cnVjdCBzM2MyNDEwZmJfZGlzcGxheSBzbWRrMjQ0
MF9sY2RfY2ZnIF9faW5pdGRhdGEgPSB7CiAKLQkubGNkY29uMQk9IFMzQzI0MTBfTENEQ09OMV9U
RlQxNkJQUCB8Ci0JCQkgIFMzQzI0MTBfTENEQ09OMV9URlQgfAotCQkJICBTM0MyNDEwX0xDRENP
TjFfQ0xLVkFMKDB4MDQpLAotCiAJLmxjZGNvbjUJPSBTM0MyNDEwX0xDRENPTjVfRlJNNTY1IHwK
IAkJCSAgUzNDMjQxMF9MQ0RDT041X0lOVlZMSU5FIHwKIAkJCSAgUzNDMjQxMF9MQ0RDT041X0lO
VlZGUkFNRSB8CmRpZmYgLXVycCBsaW51eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vczNjMjQx
MGZiLmMgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vczNjMjQxMGZiLmMKLS0tIGxpbnV4LTIu
Ni4yMy5vbGQvZHJpdmVycy92aWRlby9zM2MyNDEwZmIuYwkyMDA3LTA4LTE0IDIxOjEzOjMxLjAw
MDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vczNjMjQxMGZiLmMJ
MjAwNy0wOC0xNCAyMToxNDoyMC4wMDAwMDAwMDAgKzAyMDAKQEAgLTIwNywxMSArMjA3LDkgQEAg
c3RhdGljIGludCBzM2MyNDEwZmJfY2hlY2tfdmFyKHN0cnVjdCBmYgogCXZhci0+dnN5bmNfbGVu
ID0gZGlzcGxheS0+dnN5bmNfbGVuOwogCXZhci0+aHN5bmNfbGVuID0gZGlzcGxheS0+aHN5bmNf
bGVuOwogCi0JZmJpLT5yZWdzLmxjZGNvbjEgPSBkaXNwbGF5LT5sY2Rjb24xOwogCWZiaS0+cmVn
cy5sY2Rjb241ID0gZGlzcGxheS0+bGNkY29uNTsKIAkvKiBzZXQgZGlzcGxheSB0eXBlICovCi0J
ZmJpLT5yZWdzLmxjZGNvbjEgJj0gflMzQzI0MTBfTENEQ09OMV9URlQ7Ci0JZmJpLT5yZWdzLmxj
ZGNvbjEgfD0gZGlzcGxheS0+dHlwZTsKKwlmYmktPnJlZ3MubGNkY29uMSA9IGRpc3BsYXktPnR5
cGU7CiAKIAl2YXItPnRyYW5zcC5vZmZzZXQgPSAwOwogCXZhci0+dHJhbnNwLmxlbmd0aCA9IDA7
CkBAIC0zMDEsOCArMjk5LDYgQEAgc3RhdGljIHZvaWQgczNjMjQxMGZiX2NhbGN1bGF0ZV9zdG5f
bGNkXwogCWlmICh0eXBlICE9IFMzQzI0MTBfTENEQ09OMV9TVE40KQogCQlocyA+Pj0gMTsKIAot
CXJlZ3MtPmxjZGNvbjEgJj0gflMzQzI0MTBfTENEQ09OMV9NT0RFTUFTSzsKLQogCXN3aXRjaCAo
dmFyLT5iaXRzX3Blcl9waXhlbCkgewogCWNhc2UgMToKIAkJcmVncy0+bGNkY29uMSB8PSBTM0My
NDEwX0xDRENPTjFfU1ROMUJQUDsKQEAgLTM1Niw4ICszNTIsNiBAQCBzdGF0aWMgdm9pZCBzM2My
NDEwZmJfY2FsY3VsYXRlX3RmdF9sY2RfCiAJY29uc3Qgc3RydWN0IHMzYzI0MTBmYl9pbmZvICpm
YmkgPSBpbmZvLT5wYXI7CiAJY29uc3Qgc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIgPSAm
aW5mby0+dmFyOwogCi0JcmVncy0+bGNkY29uMSAmPSB+UzNDMjQxMF9MQ0RDT04xX01PREVNQVNL
OwotCiAJc3dpdGNoICh2YXItPmJpdHNfcGVyX3BpeGVsKSB7CiAJY2FzZSAxOgogCQlyZWdzLT5s
Y2Rjb24xIHw9IFMzQzI0MTBfTENEQ09OMV9URlQxQlBQOwpAQCAtNDM3LDcgKzQzMSw2IEBAIHN0
YXRpYyB2b2lkIHMzYzI0MTBmYl9hY3RpdmF0ZV92YXIoc3RydWMKIAkJCWNsa2RpdiA9IDI7CiAJ
fQogCi0JZmJpLT5yZWdzLmxjZGNvbjEgJj0gflMzQzI0MTBfTENEQ09OMV9DTEtWQUwoMHgzZmYp
OwogCWZiaS0+cmVncy5sY2Rjb24xIHw9ICBTM0MyNDEwX0xDRENPTjFfQ0xLVkFMKGNsa2Rpdik7
CiAKIAkvKiB3cml0ZSBuZXcgcmVnaXN0ZXJzICovCmRpZmYgLXVycCBsaW51eC0yLjYuMjMub2xk
L2luY2x1ZGUvYXNtLWFybS9hcmNoLXMzYzI0MTAvZmIuaCBsaW51eC0yLjYuMjMvaW5jbHVkZS9h
c20tYXJtL2FyY2gtczNjMjQxMC9mYi5oCi0tLSBsaW51eC0yLjYuMjMub2xkL2luY2x1ZGUvYXNt
LWFybS9hcmNoLXMzYzI0MTAvZmIuaAkyMDA3LTA4LTE0IDIxOjEzOjMxLjAwMDAwMDAwMCArMDIw
MAorKysgbGludXgtMi42LjIzL2luY2x1ZGUvYXNtLWFybS9hcmNoLXMzYzI0MTAvZmIuaAkyMDA3
LTA4LTE0IDIxOjEzOjUyLjAwMDAwMDAwMCArMDIwMApAQCAtNDUsNyArNDUsNiBAQCBzdHJ1Y3Qg
czNjMjQxMGZiX2Rpc3BsYXkgewogCXVuc2lnbmVkIHNob3J0IHZzeW5jX2xlbjsJLyogdmFsdWUg
aW4gbGluZXMgKFRGVCkgb3IgMCAoU1ROKSAqLwogCiAJLyogbGNkIGNvbmZpZ3VyYXRpb24gcmVn
aXN0ZXJzICovCi0JdW5zaWduZWQgbG9uZwlsY2Rjb24xOwogCXVuc2lnbmVkIGxvbmcJbGNkY29u
NTsKIH07CiAK

--part46c2b8497f86f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--part46c2b8497f86f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part46c2b8497f86f--

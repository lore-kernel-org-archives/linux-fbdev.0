From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] s3c2410fb: byte ordering fixes
Date: Tue, 14 Aug 2007 18:26:38 +0200
Message-ID: <46c1d7beb3dd8@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46c1d7beb648e"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKzED-0007wV-Rj for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Aug 2007 09:26:54 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IKzE8-0007f4-T0
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Aug 2007 09:26:43 -0700
Received: from poczta-7.free.wp-sa.pl (HELO localhost) ([10.1.1.16])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	14 Aug 2007 18:26:38 +0200
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
Cc: ben-linux@fluff.org

This is a multi-part message in MIME format.

--part46c1d7beb648e
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch sets correct bits related to the byte ordering
of the framebuffer. This was tested on little endian kernel
only. The big endian kernel may require different settings.

The patch also adds 32 bpp mode which is called 24 bpp by
Samsung. One pixel takes 32 bits but only 24 bits are used
in this mode.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch requires all s3c2410fb patches sent to this list.

The patch was tested on iPAQ rx1950 (TFT display only).
The 1, 2 and 4 bpp modes do not work on little endian kernel
(wrong order of pixels in byte). 1bpp is not stable for
unknown reason.

diff -urp linux-2.6.23.old/drivers/video/s3c2410fb.c linux-2.6.
23/drivers/video/s3c2410fb.c
--- linux-2.6.23.old/drivers/video/s3c2410fb.c	2007-08-13 20:
21:57.000000000 +0200
+++ linux-2.6.23/drivers/video/s3c2410fb.c	2007-08-13 20:46:
18.000000000 +0200
@@ -270,8 +270,8 @@ static int s3c2410fb_check_var(struct fb
 			var->blue.length	=3D 5;
 		}
 		break;
-	case 24:
-		/* 24 bpp 888 */
+	case 32:
+		/* 24 bpp 888 and 8 dummy */
 		var->red.length		=3D 8;
 		var->red.offset		=3D 16;
 		var->green.length	=3D 8;
@@ -279,8 +279,6 @@ static int s3c2410fb_check_var(struct fb
 		var->blue.length	=3D 8;
 		var->blue.offset	=3D 0;
 		break;
-
-
 	}
 	return 0;
 }
@@ -379,11 +377,21 @@ static void s3c2410fb_calculate_tft_lcd_
 		break;
 	case 8:
 		regs->lcdcon1 |=3D S3C2410_LCDCON1_TFT8BPP;
+		regs->lcdcon5 |=3D S3C2410_LCDCON5_BSWP |
+				 S3C2410_LCDCON5_FRM565;
+		regs->lcdcon5 &=3D ~S3C2410_LCDCON5_HWSWP;
 		break;
 	case 16:
 		regs->lcdcon1 |=3D S3C2410_LCDCON1_TFT16BPP;
+		regs->lcdcon5 &=3D ~S3C2410_LCDCON5_BSWP;
+		regs->lcdcon5 |=3D S3C2410_LCDCON5_HWSWP;
+		break;
+	case 32:
+		regs->lcdcon1 |=3D S3C2410_LCDCON1_TFT24BPP;
+		regs->lcdcon5 &=3D ~(S3C2410_LCDCON5_BSWP |
+				   S3C2410_LCDCON5_HWSWP |
+				   S3C2410_LCDCON5_BPP24BL);
 		break;
-
 	default:
 		/* invalid pixel depth */
 		dev_err(fbi->dev, "invalid bpp %d\n",
@@ -475,7 +483,9 @@ static int s3c2410fb_set_par(struct fb_i
 	struct fb_var_screeninfo *var =3D &info->var;
=20
 	switch (var->bits_per_pixel) {
+	case 32:
 	case 16:
+	case 12:
 		info->fix.visual =3D FB_VISUAL_TRUECOLOR;
 		break;
 	case 1:


----------------------------------------------------
Obud=BC w sobie Wilka Morskiego i we=BC udzia=B3 w =BFeglarskiej=20
imprezie: regaty NIVEA B=B3=EAkitne =AFagle, Miasteczko Pirat=F3w,=20
koncerty. Sopot, molo 18-19 sierpnia!=20
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fnivea.html=
&sid=3D1261

--part46c1d7beb648e
Content-Type: application/octet-stream; name="s3c2410fb-32bpp.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="s3c2410fb-32bpp.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggc2V0
cyBjb3JyZWN0IGJpdHMgcmVsYXRlZCB0byB0aGUgYnl0ZSBvcmRlcmluZwpvZiB0aGUgZnJhbWVi
dWZmZXIuIFRoaXMgd2FzIHRlc3RlZCBvbiBsaXR0bGUgZW5kaWFuIGtlcm5lbApvbmx5LiBUaGUg
YmlnIGVuZGlhbiBrZXJuZWwgbWF5IHJlcXVpcmUgZGlmZmVyZW50IHNldHRpbmdzLgoKVGhlIHBh
dGNoIGFsc28gYWRkcyAzMiBicHAgbW9kZSB3aGljaCBpcyBjYWxsZWQgMjQgYnBwIGJ5ClNhbXN1
bmcuIE9uZSBwaXhlbCB0YWtlcyAzMiBiaXRzIGJ1dCBvbmx5IDI0IGJpdHMgYXJlIHVzZWQKaW4g
dGhpcyBtb2RlLgoKU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3
cC5wbD4KCi0tLQoKVGhpcyBwYXRjaCByZXF1aXJlcyBhbGwgczNjMjQxMGZiIHBhdGNoZXMgc2Vu
dCB0byB0aGlzIGxpc3QuCgpUaGUgcGF0Y2ggd2FzIHRlc3RlZCBvbiBpUEFRIHJ4MTk1MCAoVEZU
IGRpc3BsYXkgb25seSkuClRoZSAxLCAyIGFuZCA0IGJwcCBtb2RlcyBkbyBub3Qgd29yayBvbiBs
aXR0bGUgZW5kaWFuIGtlcm5lbAood3Jvbmcgb3JkZXIgb2YgcGl4ZWxzIGluIGJ5dGUpLgoKZGlm
ZiAtdXJwIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9zM2MyNDEwZmIuYyBsaW51eC0y
LjYuMjMvZHJpdmVycy92aWRlby9zM2MyNDEwZmIuYwotLS0gbGludXgtMi42LjIzLm9sZC9kcml2
ZXJzL3ZpZGVvL3MzYzI0MTBmYi5jCTIwMDctMDgtMTMgMjA6MjE6NTcuMDAwMDAwMDAwICswMjAw
CisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9zM2MyNDEwZmIuYwkyMDA3LTA4LTEzIDIw
OjQ2OjE4LjAwMDAwMDAwMCArMDIwMApAQCAtMjcwLDggKzI3MCw4IEBAIHN0YXRpYyBpbnQgczNj
MjQxMGZiX2NoZWNrX3ZhcihzdHJ1Y3QgZmIKIAkJCXZhci0+Ymx1ZS5sZW5ndGgJPSA1OwogCQl9
CiAJCWJyZWFrOwotCWNhc2UgMjQ6Ci0JCS8qIDI0IGJwcCA4ODggKi8KKwljYXNlIDMyOgorCQkv
KiAyNCBicHAgODg4IGFuZCA4IGR1bW15ICovCiAJCXZhci0+cmVkLmxlbmd0aAkJPSA4OwogCQl2
YXItPnJlZC5vZmZzZXQJCT0gMTY7CiAJCXZhci0+Z3JlZW4ubGVuZ3RoCT0gODsKQEAgLTI3OSw4
ICsyNzksNiBAQCBzdGF0aWMgaW50IHMzYzI0MTBmYl9jaGVja192YXIoc3RydWN0IGZiCiAJCXZh
ci0+Ymx1ZS5sZW5ndGgJPSA4OwogCQl2YXItPmJsdWUub2Zmc2V0CT0gMDsKIAkJYnJlYWs7Ci0K
LQogCX0KIAlyZXR1cm4gMDsKIH0KQEAgLTM3OSwxMSArMzc3LDIxIEBAIHN0YXRpYyB2b2lkIHMz
YzI0MTBmYl9jYWxjdWxhdGVfdGZ0X2xjZF8KIAkJYnJlYWs7CiAJY2FzZSA4OgogCQlyZWdzLT5s
Y2Rjb24xIHw9IFMzQzI0MTBfTENEQ09OMV9URlQ4QlBQOworCQlyZWdzLT5sY2Rjb241IHw9IFMz
QzI0MTBfTENEQ09ONV9CU1dQIHwKKwkJCQkgUzNDMjQxMF9MQ0RDT041X0ZSTTU2NTsKKwkJcmVn
cy0+bGNkY29uNSAmPSB+UzNDMjQxMF9MQ0RDT041X0hXU1dQOwogCQlicmVhazsKIAljYXNlIDE2
OgogCQlyZWdzLT5sY2Rjb24xIHw9IFMzQzI0MTBfTENEQ09OMV9URlQxNkJQUDsKKwkJcmVncy0+
bGNkY29uNSAmPSB+UzNDMjQxMF9MQ0RDT041X0JTV1A7CisJCXJlZ3MtPmxjZGNvbjUgfD0gUzND
MjQxMF9MQ0RDT041X0hXU1dQOworCQlicmVhazsKKwljYXNlIDMyOgorCQlyZWdzLT5sY2Rjb24x
IHw9IFMzQzI0MTBfTENEQ09OMV9URlQyNEJQUDsKKwkJcmVncy0+bGNkY29uNSAmPSB+KFMzQzI0
MTBfTENEQ09ONV9CU1dQIHwKKwkJCQkgICBTM0MyNDEwX0xDRENPTjVfSFdTV1AgfAorCQkJCSAg
IFMzQzI0MTBfTENEQ09ONV9CUFAyNEJMKTsKIAkJYnJlYWs7Ci0KIAlkZWZhdWx0OgogCQkvKiBp
bnZhbGlkIHBpeGVsIGRlcHRoICovCiAJCWRldl9lcnIoZmJpLT5kZXYsICJpbnZhbGlkIGJwcCAl
ZFxuIiwKQEAgLTQ3NSw3ICs0ODMsOSBAQCBzdGF0aWMgaW50IHMzYzI0MTBmYl9zZXRfcGFyKHN0
cnVjdCBmYl9pCiAJc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIgPSAmaW5mby0+dmFyOwog
CiAJc3dpdGNoICh2YXItPmJpdHNfcGVyX3BpeGVsKSB7CisJY2FzZSAzMjoKIAljYXNlIDE2Ogor
CWNhc2UgMTI6CiAJCWluZm8tPmZpeC52aXN1YWwgPSBGQl9WSVNVQUxfVFJVRUNPTE9SOwogCQli
cmVhazsKIAljYXNlIDE6Cg==

--part46c1d7beb648e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--part46c1d7beb648e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part46c1d7beb648e--

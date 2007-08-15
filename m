From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH 3/3] s3c2410fb: make use of
	default_display settings
Date: Wed, 15 Aug 2007 10:26:33 +0200
Message-ID: <46c2b8b979c28@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46c2b8b97c371"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILED8-00027y-66 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Aug 2007 01:26:44 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ILED7-0002Rt-Ej
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Aug 2007 01:26:38 -0700
Received: from poczta-15.free.wp-sa.pl (HELO localhost) ([10.1.1.43])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	15 Aug 2007 10:26:33 +0200
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

--part46c2b8b97c371
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch changes mode selection to always prefer default
mode if possible and always honor type of display
set by default mode settings.

This patch is required in case the same display modes
were defined for different panels (e.g. STN and TFT).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch requires all s3c2410fb patches sent to this list.

diff -urp linux-2.6.23.old/drivers/video/s3c2410fb.c linux-
2.6.23/drivers/video/s3c2410fb.c
--- linux-2.6.23.old/drivers/video/s3c2410fb.c	2007-08-14=20
18:02:04.000000000 +0200
+++ linux-2.6.23/drivers/video/s3c2410fb.c	2007-08-14=20
20:05:10.000000000 +0200
@@ -172,19 +172,28 @@ static int s3c2410fb_check_var(struct fb
 	struct s3c2410fb_info *fbi =3D info->par;
 	struct s3c2410fb_mach_info *mach_info =3D fbi->dev-
>platform_data;
 	struct s3c2410fb_display *display =3D NULL;
+	struct s3c2410fb_display *default_display =3D mach_info-
>displays +
+						    mach_info-
>default_display;
+	int type =3D default_display->type;
 	unsigned i;
=20
 	dprintk("check_var(var=3D%p, info=3D%p)\n", var, info);
=20
-	/* validate x/y resolution */
-
-	for (i =3D 0; i < mach_info->num_displays; i++)
-		if (var->yres =3D=3D mach_info->displays[i].yres &&
-		    var->xres =3D=3D mach_info->displays[i].xres &&
-		    var->bits_per_pixel =3D=3D mach_info-
>displays[i].bpp) {
-			display =3D mach_info->displays + i;
-			break;
-		}
+	/* validate x/y resolution */=20
+	/* choose default mode if possible */
+	if (var->yres =3D=3D default_display->yres &&
+	    var->xres =3D=3D default_display->xres &&
+	    var->bits_per_pixel =3D=3D default_display->bpp)
+		display =3D default_display;
+	else
+		for (i =3D 0; i < mach_info->num_displays; i++)
+			if (type =3D=3D mach_info->displays[i].type=20
&&
+			    var->yres =3D=3D mach_info-
>displays[i].yres &&
+			    var->xres =3D=3D mach_info-
>displays[i].xres &&
+			    var->bits_per_pixel =3D=3D mach_info-
>displays[i].bpp) {
+				display =3D mach_info->displays +=20
i;
+				break;
+			}
=20
 	if (!display) {
 		dprintk("wrong resolution or depth %dx%d at %d=20
bpp\n",


----------------------------------------------------
Najnowszy album =B6wiatowej klasy DJ'a Paula van Dyka=20
"In Between" ju=BF w sklepach! Kompilacja zawiera singiel=20
"White Lies" z udzia=B3em Jessica Sutta z Pussycat Dolls.
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fpaul.html&=
sid=3D1260

--part46c2b8b97c371
Content-Type: application/octet-stream; name="s3c2410fb-default-type.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="s3c2410fb-default-type.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggY2hh
bmdlcyBtb2RlIHNlbGVjdGlvbiB0byBhbHdheXMgcHJlZmVyIGRlZmF1bHQKbW9kZSBpZiBwb3Nz
aWJsZSBhbmQgYWx3YXlzIGhvbm9yIHR5cGUgb2YgZGlzcGxheQpzZXQgYnkgZGVmYXVsdCBtb2Rl
IHNldHRpbmdzLgoKVGhpcyBwYXRjaCBpcyByZXF1aXJlZCBpbiBjYXNlIHRoZSBzYW1lIGRpc3Bs
YXkgbW9kZXMKd2VyZSBkZWZpbmVkIGZvciBkaWZmZXJlbnQgcGFuZWxzIChlLmcuIFNUTiBhbmQg
VEZUKS4KClNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBIZWx0IDxrcnp5c3p0b2YuaDFAd3AucGw+
CgotLS0KClRoaXMgcGF0Y2ggcmVxdWlyZXMgYWxsIHMzYzI0MTBmYiBwYXRjaGVzIHNlbnQgdG8g
dGhpcyBsaXN0LgoKZGlmZiAtdXJwIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9zM2My
NDEwZmIuYyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9zM2MyNDEwZmIuYwotLS0gbGludXgt
Mi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL3MzYzI0MTBmYi5jCTIwMDctMDgtMTQgMTg6MDI6MDQu
MDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9zM2MyNDEwZmIu
YwkyMDA3LTA4LTE0IDIwOjA1OjEwLjAwMDAwMDAwMCArMDIwMApAQCAtMTcyLDE5ICsxNzIsMjgg
QEAgc3RhdGljIGludCBzM2MyNDEwZmJfY2hlY2tfdmFyKHN0cnVjdCBmYgogCXN0cnVjdCBzM2My
NDEwZmJfaW5mbyAqZmJpID0gaW5mby0+cGFyOwogCXN0cnVjdCBzM2MyNDEwZmJfbWFjaF9pbmZv
ICptYWNoX2luZm8gPSBmYmktPmRldi0+cGxhdGZvcm1fZGF0YTsKIAlzdHJ1Y3QgczNjMjQxMGZi
X2Rpc3BsYXkgKmRpc3BsYXkgPSBOVUxMOworCXN0cnVjdCBzM2MyNDEwZmJfZGlzcGxheSAqZGVm
YXVsdF9kaXNwbGF5ID0gbWFjaF9pbmZvLT5kaXNwbGF5cyArCisJCQkJCQkgICAgbWFjaF9pbmZv
LT5kZWZhdWx0X2Rpc3BsYXk7CisJaW50IHR5cGUgPSBkZWZhdWx0X2Rpc3BsYXktPnR5cGU7CiAJ
dW5zaWduZWQgaTsKIAogCWRwcmludGsoImNoZWNrX3Zhcih2YXI9JXAsIGluZm89JXApXG4iLCB2
YXIsIGluZm8pOwogCi0JLyogdmFsaWRhdGUgeC95IHJlc29sdXRpb24gKi8KLQotCWZvciAoaSA9
IDA7IGkgPCBtYWNoX2luZm8tPm51bV9kaXNwbGF5czsgaSsrKQotCQlpZiAodmFyLT55cmVzID09
IG1hY2hfaW5mby0+ZGlzcGxheXNbaV0ueXJlcyAmJgotCQkgICAgdmFyLT54cmVzID09IG1hY2hf
aW5mby0+ZGlzcGxheXNbaV0ueHJlcyAmJgotCQkgICAgdmFyLT5iaXRzX3Blcl9waXhlbCA9PSBt
YWNoX2luZm8tPmRpc3BsYXlzW2ldLmJwcCkgewotCQkJZGlzcGxheSA9IG1hY2hfaW5mby0+ZGlz
cGxheXMgKyBpOwotCQkJYnJlYWs7Ci0JCX0KKwkvKiB2YWxpZGF0ZSB4L3kgcmVzb2x1dGlvbiAq
LyAKKwkvKiBjaG9vc2UgZGVmYXVsdCBtb2RlIGlmIHBvc3NpYmxlICovCisJaWYgKHZhci0+eXJl
cyA9PSBkZWZhdWx0X2Rpc3BsYXktPnlyZXMgJiYKKwkgICAgdmFyLT54cmVzID09IGRlZmF1bHRf
ZGlzcGxheS0+eHJlcyAmJgorCSAgICB2YXItPmJpdHNfcGVyX3BpeGVsID09IGRlZmF1bHRfZGlz
cGxheS0+YnBwKQorCQlkaXNwbGF5ID0gZGVmYXVsdF9kaXNwbGF5OworCWVsc2UKKwkJZm9yIChp
ID0gMDsgaSA8IG1hY2hfaW5mby0+bnVtX2Rpc3BsYXlzOyBpKyspCisJCQlpZiAodHlwZSA9PSBt
YWNoX2luZm8tPmRpc3BsYXlzW2ldLnR5cGUgJiYKKwkJCSAgICB2YXItPnlyZXMgPT0gbWFjaF9p
bmZvLT5kaXNwbGF5c1tpXS55cmVzICYmCisJCQkgICAgdmFyLT54cmVzID09IG1hY2hfaW5mby0+
ZGlzcGxheXNbaV0ueHJlcyAmJgorCQkJICAgIHZhci0+Yml0c19wZXJfcGl4ZWwgPT0gbWFjaF9p
bmZvLT5kaXNwbGF5c1tpXS5icHApIHsKKwkJCQlkaXNwbGF5ID0gbWFjaF9pbmZvLT5kaXNwbGF5
cyArIGk7CisJCQkJYnJlYWs7CisJCQl9CiAKIAlpZiAoIWRpc3BsYXkpIHsKIAkJZHByaW50aygi
d3JvbmcgcmVzb2x1dGlvbiBvciBkZXB0aCAlZHglZCBhdCAlZCBicHBcbiIsCg==

--part46c2b8b97c371
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--part46c2b8b97c371
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part46c2b8b97c371--

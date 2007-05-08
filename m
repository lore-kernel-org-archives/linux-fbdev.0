From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb: fb_sync added
Date: Tue, 08 May 2007 09:26:10 +0200
Message-ID: <464026127324d@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part464026127594a"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlK5O-0004YX-2a for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 00:26:14 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HlK5N-0001rD-A8
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 00:26:14 -0700
Received: from poczta-16.free.wp-sa.pl (HELO localhost) ([10.1.1.71])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 8 May 2007 09:26:10 +0200
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--part464026127594a
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch converts internal wait_pm2() function to fb API
fb_sync() method.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
The change of arguments in acceleration function allows use of
fb_sync by them. Current testing shows that fb_sync is not
required, but I left new arguments in case it may be needed. I am
working on speeding scrolling now.

Regards,
Krzysztof

--- linux.orig/drivers/video/pm2fb.c	2007-05-08
09:21:08.000000000 +0200
+++ linux-2.6.21/drivers/video/pm2fb.c	2007-05-08
09:22:08.000000000 +0200
@@ -204,17 +204,6 @@ static inline void WAIT_FIFO(struct pm2f
 }
 #endif
=20
-static void wait_pm2(struct pm2fb_par* par) {
-
-	WAIT_FIFO(par, 1);
-	pm2_WR(par, PM2R_SYNC, 0);
-	mb();
-	do {
-		while (pm2_RD(par, PM2R_OUT_FIFO_WORDS) =3D=3D 0);
-		rmb();
-	} while (pm2_RD(par, PM2R_OUT_FIFO) !=3D PM2TAG(PM2R_SYNC));
-}
-
 /*
  * partial products for the supported horizontal resolutions.
  */
@@ -1050,13 +1039,30 @@ static int pm2fb_blank(int blank_mode, s
 	return 0;
 }
=20
+static int pm2fb_sync(struct fb_info *info)
+{
+	struct pm2fb_par *par =3D info->par;
+
+	WAIT_FIFO(par, 1);
+	pm2_WR(par, PM2R_SYNC, 0);
+	mb();
+	do {
+		while (pm2_RD(par, PM2R_OUT_FIFO_WORDS) =3D=3D 0)
+			udelay(10);
+		rmb();
+	} while (pm2_RD(par, PM2R_OUT_FIFO) !=3D PM2TAG(PM2R_SYNC));
+
+	return 0;
+}
+
 /*
  * block operation. copy=3D0: rectangle fill, copy=3D1: rectangle copy.
  */
-static void pm2fb_block_op(struct pm2fb_par* par, int copy,
+static void pm2fb_block_op(struct fb_info* info, int copy,
 				s32 xsrc, s32 ysrc,
 				s32 x, s32 y, s32 w, s32 h,
 				u32 color) {
+	struct pm2fb_par *par =3D info->par;
=20
 	if (!w || !h)
 		return;
@@ -1076,13 +1082,11 @@ static void pm2fb_block_op(struct pm2fb_
 				(x<xsrc ? PM2F_INCREASE_X : 0) |
 				(y<ysrc ? PM2F_INCREASE_Y : 0) |
 				(copy ? 0 : PM2F_RENDER_FASTFILL));
-	wait_pm2(par);
 }
=20
 static void pm2fb_fillrect (struct fb_info *info,=20
 				const struct fb_fillrect *region)
 {
-	struct pm2fb_par *par =3D info->par;
 	struct fb_fillrect modded;
 	int vxres, vyres;
 	u32 color =3D (info->fix.visual =3D=3D FB_VISUAL_TRUECOLOR) ?
@@ -1116,7 +1120,7 @@ static void pm2fb_fillrect (struct fb_in
 		color |=3D color << 16;
=20
 	if(info->var.bits_per_pixel !=3D 24)
-		pm2fb_block_op(par, 0, 0, 0,
+		pm2fb_block_op(info, 0, 0, 0,
 				modded.dx, modded.dy,
 				modded.width, modded.height, color);
 	else
@@ -1126,7 +1130,6 @@ static void pm2fb_fillrect (struct fb_in
 static void pm2fb_copyarea(struct fb_info *info,
 				const struct fb_copyarea *area)
 {
-	struct pm2fb_par *par =3D info->par;
 	struct fb_copyarea modded;
 	u32 vxres, vyres;
=20
@@ -1156,7 +1159,7 @@ static void pm2fb_copyarea(struct fb_inf
 	if(modded.dy + modded.height > vyres)
 		modded.height =3D vyres - modded.dy;
=20
-	pm2fb_block_op(par, 1, modded.sx, modded.sy,
+	pm2fb_block_op(info, 1, modded.sx, modded.sy,
 			modded.dx, modded.dy,
 			modded.width, modded.height, 0);
 }
@@ -1177,6 +1180,7 @@ static struct fb_ops pm2fb_ops =3D {
 	.fb_fillrect	=3D pm2fb_fillrect,
 	.fb_copyarea	=3D pm2fb_copyarea,
 	.fb_imageblit	=3D cfb_imageblit,
+	.fb_sync	=3D pm2fb_sync,
 };
=20
 /*


----------------------------------------------------
Morderstwa i krew ofiar na =B6cianach. Mroczne miasto=20
pogr=B1=BFone w chaosie. Sprawd=BC kto jest Przybywaj=B1cym!
Przybywaj=B1cy - thriller metafizyczny ju=BF w ksi=EAgarniach.
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fksiazki.wp.pl%2Fkatalog%2Fksiazki%2=
Fksiazka.html%3Fkw%3D10414&sid=3D1128

--part464026127594a
Content-Type: text/x-patch; name="pm2fb-sync.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pm2fb-sync.diff"

LS0tIGxpbnV4Lm9yaWcvZHJpdmVycy92aWRlby9wbTJmYi5jCTIwMDctMDUtMDggMDk6MjE6MDgu
MDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjEvZHJpdmVycy92aWRlby9wbTJmYi5jCTIw
MDctMDUtMDggMDk6MjI6MDguMDAwMDAwMDAwICswMjAwCkBAIC0yMDQsMTcgKzIwNCw2IEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCBXQUlUX0ZJRk8oc3RydWN0IHBtMmYKIH0KICNlbmRpZgogCi1zdGF0
aWMgdm9pZCB3YWl0X3BtMihzdHJ1Y3QgcG0yZmJfcGFyKiBwYXIpIHsKLQotCVdBSVRfRklGTyhw
YXIsIDEpOwotCXBtMl9XUihwYXIsIFBNMlJfU1lOQywgMCk7Ci0JbWIoKTsKLQlkbyB7Ci0JCXdo
aWxlIChwbTJfUkQocGFyLCBQTTJSX09VVF9GSUZPX1dPUkRTKSA9PSAwKTsKLQkJcm1iKCk7Ci0J
fSB3aGlsZSAocG0yX1JEKHBhciwgUE0yUl9PVVRfRklGTykgIT0gUE0yVEFHKFBNMlJfU1lOQykp
OwotfQotCiAvKgogICogcGFydGlhbCBwcm9kdWN0cyBmb3IgdGhlIHN1cHBvcnRlZCBob3Jpem9u
dGFsIHJlc29sdXRpb25zLgogICovCkBAIC0xMDUwLDEzICsxMDM5LDMwIEBAIHN0YXRpYyBpbnQg
cG0yZmJfYmxhbmsoaW50IGJsYW5rX21vZGUsIHMKIAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIGlu
dCBwbTJmYl9zeW5jKHN0cnVjdCBmYl9pbmZvICppbmZvKQoreworCXN0cnVjdCBwbTJmYl9wYXIg
KnBhciA9IGluZm8tPnBhcjsKKworCVdBSVRfRklGTyhwYXIsIDEpOworCXBtMl9XUihwYXIsIFBN
MlJfU1lOQywgMCk7CisJbWIoKTsKKwlkbyB7CisJCXdoaWxlIChwbTJfUkQocGFyLCBQTTJSX09V
VF9GSUZPX1dPUkRTKSA9PSAwKQorCQkJdWRlbGF5KDEwKTsKKwkJcm1iKCk7CisJfSB3aGlsZSAo
cG0yX1JEKHBhciwgUE0yUl9PVVRfRklGTykgIT0gUE0yVEFHKFBNMlJfU1lOQykpOworCisJcmV0
dXJuIDA7Cit9CisKIC8qCiAgKiBibG9jayBvcGVyYXRpb24uIGNvcHk9MDogcmVjdGFuZ2xlIGZp
bGwsIGNvcHk9MTogcmVjdGFuZ2xlIGNvcHkuCiAgKi8KLXN0YXRpYyB2b2lkIHBtMmZiX2Jsb2Nr
X29wKHN0cnVjdCBwbTJmYl9wYXIqIHBhciwgaW50IGNvcHksCitzdGF0aWMgdm9pZCBwbTJmYl9i
bG9ja19vcChzdHJ1Y3QgZmJfaW5mbyogaW5mbywgaW50IGNvcHksCiAJCQkJczMyIHhzcmMsIHMz
MiB5c3JjLAogCQkJCXMzMiB4LCBzMzIgeSwgczMyIHcsIHMzMiBoLAogCQkJCXUzMiBjb2xvcikg
eworCXN0cnVjdCBwbTJmYl9wYXIgKnBhciA9IGluZm8tPnBhcjsKIAogCWlmICghdyB8fCAhaCkK
IAkJcmV0dXJuOwpAQCAtMTA3NiwxMyArMTA4MiwxMSBAQCBzdGF0aWMgdm9pZCBwbTJmYl9ibG9j
a19vcChzdHJ1Y3QgcG0yZmJfCiAJCQkJKHg8eHNyYyA/IFBNMkZfSU5DUkVBU0VfWCA6IDApIHwK
IAkJCQkoeTx5c3JjID8gUE0yRl9JTkNSRUFTRV9ZIDogMCkgfAogCQkJCShjb3B5ID8gMCA6IFBN
MkZfUkVOREVSX0ZBU1RGSUxMKSk7Ci0Jd2FpdF9wbTIocGFyKTsKIH0KIAogc3RhdGljIHZvaWQg
cG0yZmJfZmlsbHJlY3QgKHN0cnVjdCBmYl9pbmZvICppbmZvLCAKIAkJCQljb25zdCBzdHJ1Y3Qg
ZmJfZmlsbHJlY3QgKnJlZ2lvbikKIHsKLQlzdHJ1Y3QgcG0yZmJfcGFyICpwYXIgPSBpbmZvLT5w
YXI7CiAJc3RydWN0IGZiX2ZpbGxyZWN0IG1vZGRlZDsKIAlpbnQgdnhyZXMsIHZ5cmVzOwogCXUz
MiBjb2xvciA9IChpbmZvLT5maXgudmlzdWFsID09IEZCX1ZJU1VBTF9UUlVFQ09MT1IpID8KQEAg
LTExMTYsNyArMTEyMCw3IEBAIHN0YXRpYyB2b2lkIHBtMmZiX2ZpbGxyZWN0IChzdHJ1Y3QgZmJf
aW4KIAkJY29sb3IgfD0gY29sb3IgPDwgMTY7CiAKIAlpZihpbmZvLT52YXIuYml0c19wZXJfcGl4
ZWwgIT0gMjQpCi0JCXBtMmZiX2Jsb2NrX29wKHBhciwgMCwgMCwgMCwKKwkJcG0yZmJfYmxvY2tf
b3AoaW5mbywgMCwgMCwgMCwKIAkJCQltb2RkZWQuZHgsIG1vZGRlZC5keSwKIAkJCQltb2RkZWQu
d2lkdGgsIG1vZGRlZC5oZWlnaHQsIGNvbG9yKTsKIAllbHNlCkBAIC0xMTI2LDcgKzExMzAsNiBA
QCBzdGF0aWMgdm9pZCBwbTJmYl9maWxscmVjdCAoc3RydWN0IGZiX2luCiBzdGF0aWMgdm9pZCBw
bTJmYl9jb3B5YXJlYShzdHJ1Y3QgZmJfaW5mbyAqaW5mbywKIAkJCQljb25zdCBzdHJ1Y3QgZmJf
Y29weWFyZWEgKmFyZWEpCiB7Ci0Jc3RydWN0IHBtMmZiX3BhciAqcGFyID0gaW5mby0+cGFyOwog
CXN0cnVjdCBmYl9jb3B5YXJlYSBtb2RkZWQ7CiAJdTMyIHZ4cmVzLCB2eXJlczsKIApAQCAtMTE1
Niw3ICsxMTU5LDcgQEAgc3RhdGljIHZvaWQgcG0yZmJfY29weWFyZWEoc3RydWN0IGZiX2luZgog
CWlmKG1vZGRlZC5keSArIG1vZGRlZC5oZWlnaHQgPiB2eXJlcykKIAkJbW9kZGVkLmhlaWdodCA9
IHZ5cmVzIC0gbW9kZGVkLmR5OwogCi0JcG0yZmJfYmxvY2tfb3AocGFyLCAxLCBtb2RkZWQuc3gs
IG1vZGRlZC5zeSwKKwlwbTJmYl9ibG9ja19vcChpbmZvLCAxLCBtb2RkZWQuc3gsIG1vZGRlZC5z
eSwKIAkJCW1vZGRlZC5keCwgbW9kZGVkLmR5LAogCQkJbW9kZGVkLndpZHRoLCBtb2RkZWQuaGVp
Z2h0LCAwKTsKIH0KQEAgLTExNzcsNiArMTE4MCw3IEBAIHN0YXRpYyBzdHJ1Y3QgZmJfb3BzIHBt
MmZiX29wcyA9IHsKIAkuZmJfZmlsbHJlY3QJPSBwbTJmYl9maWxscmVjdCwKIAkuZmJfY29weWFy
ZWEJPSBwbTJmYl9jb3B5YXJlYSwKIAkuZmJfaW1hZ2VibGl0CT0gY2ZiX2ltYWdlYmxpdCwKKwku
ZmJfc3luYwk9IHBtMmZiX3N5bmMsCiB9OwogCiAvKgo=

--part464026127594a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part464026127594a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part464026127594a--

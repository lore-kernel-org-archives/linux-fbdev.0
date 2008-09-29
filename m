From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Allow more chip revisions in Epson s1d13...
	video driver
Date: Mon, 29 Sep 2008 17:37:16 +0200
Message-ID: <20080929173716.8c55dc66.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Mon__29_Sep_2008_17_37_16_+0200_vAaFHFRk.D5Dt0A0"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1KkKpC-0001Hn-K4
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Sep 2008 15:38:14 +0000
Received: from ey-out-1920.google.com ([74.125.78.150])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KkKp0-00074O-7R for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Sep 2008 15:38:14 +0000
Received: by ey-out-1920.google.com with SMTP id 4so525726eyk.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 29 Sep 2008 08:37:49 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: akpm@linux-foundation.org
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, varenet@parisc-linux.org

This is a multi-part message in MIME format.

--Multipart=_Mon__29_Sep_2008_17_37_16_+0200_vAaFHFRk.D5Dt0A0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The Epson s1d13xxx hardware is common in many handhelds, but our
driver is currently locked to a single chip revision. This patch
adds an array of known to work revisions (which can be extended).

Signed-off-by: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
Acked-by: Thibaut Var=E8ne <varenet@parisc-linux.org>

diff --git a/include/video/s1d13xxxfb.h b/include/video/s1d13xxxfb.h
index c99d261..fe41b84 100644
--- a/include/video/s1d13xxxfb.h
+++ b/include/video/s1d13xxxfb.h
@@ -14,7 +14,8 @@
 #define	S1D13XXXFB_H
=20
 #define S1D_PALETTE_SIZE		256
-#define S1D_CHIP_REV			7	/* expected chip revision number for s1d13806 */
+#define S1D13506_CHIP_REV		4	/* expected chip revision number for s1d13506=
 */
+#define S1D13806_CHIP_REV		7	/* expected chip revision number for s1d13806=
 */
 #define S1D_FBID			"S1D13806"
 #define S1D_DEVICENAME			"s1d13806fb"
=20
diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
index b829dc7..8ae7bfa 100644
--- a/drivers/video/s1d13xxxfb.c
+++ b/drivers/video/s1d13xxxfb.c
@@ -50,6 +50,11 @@
 #define dbg(fmt, args...) do { } while (0)
 #endif
=20
+static const int __devinitconst s1d13xxxfb_revisions[] =3D {
+	S1D13506_CHIP_REV,/* Rev.4 on HP Jornada 7xx S1D13506 */
+	S1D13806_CHIP_REV /* Rev.7 on .. */
+};
+
 /*
  * Here we define the default struct fb_fix_screeninfo
  */
@@ -538,6 +543,7 @@ s1d13xxxfb_probe(struct platform_device *pdev)
 	struct fb_info *info;
 	struct s1d13xxxfb_pdata *pdata =3D NULL;
 	int ret =3D 0;
+	int i;
 	u8 revision;
=20
 	dbg("probe called: device is %p\n", pdev);
@@ -607,10 +613,19 @@ s1d13xxxfb_probe(struct platform_device *pdev)
 		goto bail;
 	}
=20
-	revision =3D s1d13xxxfb_readreg(default_par, S1DREG_REV_CODE);
-	if ((revision >> 2) !=3D S1D_CHIP_REV) {
-		printk(KERN_INFO PFX "chip not found: %i\n", (revision >> 2));
-		ret =3D -ENODEV;
+	revision =3D s1d13xxxfb_readreg(default_par, S1DREG_REV_CODE) >> 2;
+
+	ret =3D -ENODEV;
+
+	for (i =3D 0; i < ARRAY_SIZE(s1d13xxxfb_revisions); i++) {
+		if (revision =3D=3D s1d13xxxfb_revisions[i])
+			ret =3D 0;
+	}
+
+	if (!ret)
+		printk(KERN_INFO PFX "chip revision %i\n", (revision));
+	else {
+		printk(KERN_INFO PFX "unknown chip revision %i\n", (revision));
 		goto bail;
 	}
=20


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Multipart=_Mon__29_Sep_2008_17_37_16_+0200_vAaFHFRk.D5Dt0A0
Content-Type: application/octet-stream; name="s1d13xxxfb-allow-revisions.patch"
Content-Disposition: attachment;
 filename="s1d13xxxfb-allow-revisions.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvdmlkZW8vczFkMTN4eHhmYi5oIGIvaW5jbHVkZS92aWRlby9z
MWQxM3h4eGZiLmgKaW5kZXggYzk5ZDI2MS4uZmU0MWI4NCAxMDA2NDQKLS0tIGEvaW5jbHVkZS92
aWRlby9zMWQxM3h4eGZiLmgKKysrIGIvaW5jbHVkZS92aWRlby9zMWQxM3h4eGZiLmgKQEAgLTE0
LDcgKzE0LDggQEAKICNkZWZpbmUJUzFEMTNYWFhGQl9ICiAKICNkZWZpbmUgUzFEX1BBTEVUVEVf
U0laRQkJMjU2Ci0jZGVmaW5lIFMxRF9DSElQX1JFVgkJCTcJLyogZXhwZWN0ZWQgY2hpcCByZXZp
c2lvbiBudW1iZXIgZm9yIHMxZDEzODA2ICovCisjZGVmaW5lIFMxRDEzNTA2X0NISVBfUkVWCQk0
CS8qIGV4cGVjdGVkIGNoaXAgcmV2aXNpb24gbnVtYmVyIGZvciBzMWQxMzUwNiAqLworI2RlZmlu
ZSBTMUQxMzgwNl9DSElQX1JFVgkJNwkvKiBleHBlY3RlZCBjaGlwIHJldmlzaW9uIG51bWJlciBm
b3IgczFkMTM4MDYgKi8KICNkZWZpbmUgUzFEX0ZCSUQJCQkiUzFEMTM4MDYiCiAjZGVmaW5lIFMx
RF9ERVZJQ0VOQU1FCQkJInMxZDEzODA2ZmIiCiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8v
czFkMTN4eHhmYi5jIGIvZHJpdmVycy92aWRlby9zMWQxM3h4eGZiLmMKaW5kZXggYjgyOWRjNy4u
OGFlN2JmYSAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9zMWQxM3h4eGZiLmMKKysrIGIvZHJp
dmVycy92aWRlby9zMWQxM3h4eGZiLmMKQEAgLTUwLDYgKzUwLDExIEBACiAjZGVmaW5lIGRiZyhm
bXQsIGFyZ3MuLi4pIGRvIHsgfSB3aGlsZSAoMCkKICNlbmRpZgogCitzdGF0aWMgY29uc3QgaW50
IF9fZGV2aW5pdGNvbnN0IHMxZDEzeHh4ZmJfcmV2aXNpb25zW10gPSB7CisJUzFEMTM1MDZfQ0hJ
UF9SRVYsLyogUmV2LjQgb24gSFAgSm9ybmFkYSA3eHggUzFEMTM1MDYgKi8KKwlTMUQxMzgwNl9D
SElQX1JFViAvKiBSZXYuNyBvbiAuLiAqLworfTsKKwogLyoKICAqIEhlcmUgd2UgZGVmaW5lIHRo
ZSBkZWZhdWx0IHN0cnVjdCBmYl9maXhfc2NyZWVuaW5mbwogICovCkBAIC01MzgsNiArNTQzLDcg
QEAgczFkMTN4eHhmYl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCXN0cnVj
dCBmYl9pbmZvICppbmZvOwogCXN0cnVjdCBzMWQxM3h4eGZiX3BkYXRhICpwZGF0YSA9IE5VTEw7
CiAJaW50IHJldCA9IDA7CisJaW50IGk7CiAJdTggcmV2aXNpb247CiAKIAlkYmcoInByb2JlIGNh
bGxlZDogZGV2aWNlIGlzICVwXG4iLCBwZGV2KTsKQEAgLTYwNywxMCArNjEzLDE5IEBAIHMxZDEz
eHh4ZmJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkJZ290byBiYWlsOwog
CX0KIAotCXJldmlzaW9uID0gczFkMTN4eHhmYl9yZWFkcmVnKGRlZmF1bHRfcGFyLCBTMURSRUdf
UkVWX0NPREUpOwotCWlmICgocmV2aXNpb24gPj4gMikgIT0gUzFEX0NISVBfUkVWKSB7Ci0JCXBy
aW50ayhLRVJOX0lORk8gUEZYICJjaGlwIG5vdCBmb3VuZDogJWlcbiIsIChyZXZpc2lvbiA+PiAy
KSk7Ci0JCXJldCA9IC1FTk9ERVY7CisJcmV2aXNpb24gPSBzMWQxM3h4eGZiX3JlYWRyZWcoZGVm
YXVsdF9wYXIsIFMxRFJFR19SRVZfQ09ERSkgPj4gMjsKKworCXJldCA9IC1FTk9ERVY7CisKKwlm
b3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShzMWQxM3h4eGZiX3JldmlzaW9ucyk7IGkrKykgewor
CQlpZiAocmV2aXNpb24gPT0gczFkMTN4eHhmYl9yZXZpc2lvbnNbaV0pCisJCQlyZXQgPSAwOwor
CX0KKworCWlmICghcmV0KQorCQlwcmludGsoS0VSTl9JTkZPIFBGWCAiY2hpcCByZXZpc2lvbiAl
aVxuIiwgKHJldmlzaW9uKSk7CisJZWxzZSB7CisJCXByaW50ayhLRVJOX0lORk8gUEZYICJ1bmtu
b3duIGNoaXAgcmV2aXNpb24gJWlcbiIsIChyZXZpc2lvbikpOwogCQlnb3RvIGJhaWw7CiAJfQog
Cg==

--Multipart=_Mon__29_Sep_2008_17_37_16_+0200_vAaFHFRk.D5Dt0A0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--Multipart=_Mon__29_Sep_2008_17_37_16_+0200_vAaFHFRk.D5Dt0A0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--Multipart=_Mon__29_Sep_2008_17_37_16_+0200_vAaFHFRk.D5Dt0A0--

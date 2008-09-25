From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: (resend) PATCH - Allow more revisions in
	s1d13...fb driver
Date: Thu, 25 Sep 2008 12:07:37 +0200
Message-ID: <20080925120737.fcbe0541.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Thu__25_Sep_2008_12_07_37_+0200_PSBt+hBzSPJA49=3"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1Kinlo-0006Wy-H2
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 25 Sep 2008 10:08:24 +0000
Received: from nf-out-0910.google.com ([64.233.182.187])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kinli-00058V-Hc for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 25 Sep 2008 10:08:24 +0000
Received: by nf-out-0910.google.com with SMTP id g16so131202nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 25 Sep 2008 03:08:17 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: varenet@parisc-linux.org
Cc: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--Multipart=_Thu__25_Sep_2008_12_07_37_+0200_PSBt+hBzSPJA49=3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The Epson s1d13xxx hardware is common in many handhelds, but our
driver is currently locked to a single chip revision. This patch
adds an array of known to work revisions (which can be extended).

Signed-off-by: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>

diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
index b829dc7..c674949 100644
--- a/drivers/video/s1d13xxxfb.c
+++ b/drivers/video/s1d13xxxfb.c
@@ -50,6 +50,11 @@
 #define dbg(fmt, args...) do { } while (0)
 #endif
 
+static const int s1d13xxxfb_revisions[] = {
+	S1D13506_CHIP_REV,/* Rev.4 on HP Jornada 7xx S1D13506 */
+	S1D13806_CHIP_REV /* Rev.7 on .. */
+};
+
 /*
  * Here we define the default struct fb_fix_screeninfo
  */
@@ -538,6 +543,7 @@ s1d13xxxfb_probe(struct platform_device *pdev)
 	struct fb_info *info;
 	struct s1d13xxxfb_pdata *pdata = NULL;
 	int ret = 0;
+	int i;
 	u8 revision;
 
 	dbg("probe called: device is %p\n", pdev);
@@ -607,10 +613,19 @@ s1d13xxxfb_probe(struct platform_device *pdev)
 		goto bail;
 	}
 
-	revision = s1d13xxxfb_readreg(default_par, S1DREG_REV_CODE);
-	if ((revision >> 2) != S1D_CHIP_REV) {
-		printk(KERN_INFO PFX "chip not found: %i\n", (revision >> 2));
-		ret = -ENODEV;
+	revision = s1d13xxxfb_readreg(default_par, S1DREG_REV_CODE) >> 2;
+
+	ret = -ENODEV;
+
+	for (i = 0; i < ARRAY_SIZE(s1d13xxxfb_revisions); i++) {
+		if (revision == s1d13xxxfb_revisions[i])
+			ret = 0;
+	}
+
+	if (!ret)
+		printk(KERN_INFO PFX "chip revision %i\n", (revision));
+	else {
+		printk(KERN_INFO PFX "unknown chip revision %i\n", (revision));
 		goto bail;
 	}
 
diff --git a/include/video/s1d13xxxfb.h b/include/video/s1d13xxxfb.h
index c99d261..fe41b84 100644
--- a/include/video/s1d13xxxfb.h
+++ b/include/video/s1d13xxxfb.h
@@ -14,7 +14,8 @@
 #define	S1D13XXXFB_H
 
 #define S1D_PALETTE_SIZE		256
-#define S1D_CHIP_REV			7	/* expected chip revision number for s1d13806 */
+#define S1D13506_CHIP_REV		4	/* expected chip revision number for s1d13506 */
+#define S1D13806_CHIP_REV		7	/* expected chip revision number for s1d13806 */
 #define S1D_FBID			"S1D13806"
 #define S1D_DEVICENAME			"s1d13806fb"
 


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>



-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Multipart=_Thu__25_Sep_2008_12_07_37_+0200_PSBt+hBzSPJA49=3
Content-Type: application/octet-stream; name="s1d13xxxfb-allow-revisions.patch"
Content-Disposition: attachment;
 filename="s1d13xxxfb-allow-revisions.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vczFkMTN4eHhmYi5jIGIvZHJpdmVycy92aWRlby9z
MWQxM3h4eGZiLmMKaW5kZXggYjgyOWRjNy4uYzY3NDk0OSAxMDA2NDQKLS0tIGEvZHJpdmVycy92
aWRlby9zMWQxM3h4eGZiLmMKKysrIGIvZHJpdmVycy92aWRlby9zMWQxM3h4eGZiLmMKQEAgLTUw
LDYgKzUwLDExIEBACiAjZGVmaW5lIGRiZyhmbXQsIGFyZ3MuLi4pIGRvIHsgfSB3aGlsZSAoMCkK
ICNlbmRpZgogCitzdGF0aWMgY29uc3QgaW50IHMxZDEzeHh4ZmJfcmV2aXNpb25zW10gPSB7CisJ
UzFEMTM1MDZfQ0hJUF9SRVYsLyogUmV2LjQgb24gSFAgSm9ybmFkYSA3eHggUzFEMTM1MDYgKi8K
KwlTMUQxMzgwNl9DSElQX1JFViAvKiBSZXYuNyBvbiAuLiAqLworfTsKKwogLyoKICAqIEhlcmUg
d2UgZGVmaW5lIHRoZSBkZWZhdWx0IHN0cnVjdCBmYl9maXhfc2NyZWVuaW5mbwogICovCkBAIC01
MzgsNiArNTQzLDcgQEAgczFkMTN4eHhmYl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQogCXN0cnVjdCBmYl9pbmZvICppbmZvOwogCXN0cnVjdCBzMWQxM3h4eGZiX3BkYXRhICpw
ZGF0YSA9IE5VTEw7CiAJaW50IHJldCA9IDA7CisJaW50IGk7CiAJdTggcmV2aXNpb247CiAKIAlk
YmcoInByb2JlIGNhbGxlZDogZGV2aWNlIGlzICVwXG4iLCBwZGV2KTsKQEAgLTYwNywxMCArNjEz
LDE5IEBAIHMxZDEzeHh4ZmJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkJ
Z290byBiYWlsOwogCX0KIAotCXJldmlzaW9uID0gczFkMTN4eHhmYl9yZWFkcmVnKGRlZmF1bHRf
cGFyLCBTMURSRUdfUkVWX0NPREUpOwotCWlmICgocmV2aXNpb24gPj4gMikgIT0gUzFEX0NISVBf
UkVWKSB7Ci0JCXByaW50ayhLRVJOX0lORk8gUEZYICJjaGlwIG5vdCBmb3VuZDogJWlcbiIsIChy
ZXZpc2lvbiA+PiAyKSk7Ci0JCXJldCA9IC1FTk9ERVY7CisJcmV2aXNpb24gPSBzMWQxM3h4eGZi
X3JlYWRyZWcoZGVmYXVsdF9wYXIsIFMxRFJFR19SRVZfQ09ERSkgPj4gMjsKKworCXJldCA9IC1F
Tk9ERVY7CisKKwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShzMWQxM3h4eGZiX3JldmlzaW9u
cyk7IGkrKykgeworCQlpZiAocmV2aXNpb24gPT0gczFkMTN4eHhmYl9yZXZpc2lvbnNbaV0pCisJ
CQlyZXQgPSAwOworCX0KKworCWlmICghcmV0KQorCQlwcmludGsoS0VSTl9JTkZPIFBGWCAiY2hp
cCByZXZpc2lvbiAlaVxuIiwgKHJldmlzaW9uKSk7CisJZWxzZSB7CisJCXByaW50ayhLRVJOX0lO
Rk8gUEZYICJ1bmtub3duIGNoaXAgcmV2aXNpb24gJWlcbiIsIChyZXZpc2lvbikpOwogCQlnb3Rv
IGJhaWw7CiAJfQogCmRpZmYgLS1naXQgYS9pbmNsdWRlL3ZpZGVvL3MxZDEzeHh4ZmIuaCBiL2lu
Y2x1ZGUvdmlkZW8vczFkMTN4eHhmYi5oCmluZGV4IGM5OWQyNjEuLmZlNDFiODQgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvdmlkZW8vczFkMTN4eHhmYi5oCisrKyBiL2luY2x1ZGUvdmlkZW8vczFkMTN4
eHhmYi5oCkBAIC0xNCw3ICsxNCw4IEBACiAjZGVmaW5lCVMxRDEzWFhYRkJfSAogCiAjZGVmaW5l
IFMxRF9QQUxFVFRFX1NJWkUJCTI1NgotI2RlZmluZSBTMURfQ0hJUF9SRVYJCQk3CS8qIGV4cGVj
dGVkIGNoaXAgcmV2aXNpb24gbnVtYmVyIGZvciBzMWQxMzgwNiAqLworI2RlZmluZSBTMUQxMzUw
Nl9DSElQX1JFVgkJNAkvKiBleHBlY3RlZCBjaGlwIHJldmlzaW9uIG51bWJlciBmb3IgczFkMTM1
MDYgKi8KKyNkZWZpbmUgUzFEMTM4MDZfQ0hJUF9SRVYJCTcJLyogZXhwZWN0ZWQgY2hpcCByZXZp
c2lvbiBudW1iZXIgZm9yIHMxZDEzODA2ICovCiAjZGVmaW5lIFMxRF9GQklECQkJIlMxRDEzODA2
IgogI2RlZmluZSBTMURfREVWSUNFTkFNRQkJCSJzMWQxMzgwNmZiIgogCg==

--Multipart=_Thu__25_Sep_2008_12_07_37_+0200_PSBt+hBzSPJA49=3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--Multipart=_Thu__25_Sep_2008_12_07_37_+0200_PSBt+hBzSPJA49=3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--Multipart=_Thu__25_Sep_2008_12_07_37_+0200_PSBt+hBzSPJA49=3--

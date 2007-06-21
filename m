From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [REPOST][PATCH] pm2fb: mtrr support and noaccel
	option
Date: Thu, 21 Jun 2007 09:04:15 +0200
Message-ID: <467a22ef07292@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part467a22ef0998c"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I1GiL-0005Ei-KR for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Jun 2007 00:04:21 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I1GiJ-0005KF-Pk
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Jun 2007 00:04:21 -0700
Received: from poczta-17.free.wp-sa.pl (HELO localhost) ([10.1.1.76])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	21 Jun 2007 09:04:15 +0200
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

This is a multi-part message in MIME format.

--part467a22ef0998c
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds usage of MTRR registers and two new options:
noaccel and nomtrr.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

The previous patch does not applied if the mm patches were
applied. This one fixes it.

--- linux-2.6.21/drivers/video/pm2fb.c	2007-06-21
08:32:07.000000000 +0200
+++ linux-2.6.22/drivers/video/pm2fb.c	2007-06-21
08:30:09.000000000 +0200
@@ -38,6 +38,9 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
=20
 #include <video/permedia2.h>
 #include <video/cvisionppc.h>
@@ -71,8 +74,13 @@ static char *mode __devinitdata =3D NULL;
  * these flags allow the user to specify that requests for +ve sync
  * should be silently turned in -ve sync.
  */
-static int lowhsync;
-static int lowvsync;
+static int lowhsync __devinitdata;
+static int lowvsync __devinitdata;
+static int noaccel __devinitdata;
+/* mtrr option */
+#ifdef CONFIG_MTRR
+static int nomtrr __devinitdata;
+#endif
=20
 /*
  * The hardware state of the graphics card that isn't part of the
@@ -88,6 +96,7 @@ struct pm2fb_par
 	u32		mem_control;	/* MemControl reg at probe */
 	u32		boot_address;	/* BootAddress reg at probe */
 	u32		palette[16];
+	int		mtrr_handle;
 };
=20
 /*
@@ -1316,6 +1325,15 @@ static int __devinit pm2fb_probe(struct=20
 		goto err_exit_mmio;
 	}
=20
+#ifdef CONFIG_MTRR
+	default_par->mtrr_handle =3D -1;
+	if (!nomtrr)
+		default_par->mtrr_handle =3D
+			mtrr_add(pm2fb_fix.smem_start,
+				 pm2fb_fix.smem_len,
+				 MTRR_TYPE_WRCOMB, 1);
+#endif
+
 	info->fbops		=3D &pm2fb_ops;
 	info->fix		=3D pm2fb_fix;
 	info->pseudo_palette	=3D default_par->palette;
@@ -1324,6 +1342,11 @@ static int __devinit pm2fb_probe(struct=20
 				  FBINFO_HWACCEL_COPYAREA |
 				  FBINFO_HWACCEL_FILLRECT;
=20
+	if (noaccel) {
+	    	printk(KERN_DEBUG "disabling acceleration\n");
+  		info->flags |=3D FBINFO_HWACCEL_DISABLED;
+	}
+
 	if (!mode)
 		mode =3D "640x480@60";
=20
@@ -1375,6 +1398,11 @@ static void __devexit pm2fb_remove(struc
=20
 	unregister_framebuffer(info);
=20
+#ifdef CONFIG_MTRR
+	if (par->mtrr_handle >=3D 0)
+		mtrr_del(par->mtrr_handle, info->fix.smem_start,
+			 info->fix.smem_len);
+#endif /* CONFIG_MTRR */
 	iounmap(info->screen_base);
 	release_mem_region(fix->smem_start, fix->smem_len);
 	iounmap(par->v_regs);
@@ -1430,6 +1458,12 @@ static int __init pm2fb_setup(char *opti
 			lowhsync =3D 1;
 		} else if(!strcmp(this_opt, "lowvsync")) {
 			lowvsync =3D 1;
+#ifdef CONFIG_MTRR
+		} else if (!strncmp(this_opt, "nomtrr", 6)) {
+			nomtrr =3D 1;
+#endif
+		} else if (!strncmp(this_opt, "noaccel", 7)) {
+			noaccel =3D 1;
 		} else {
 			mode =3D this_opt;
 		}
@@ -1474,6 +1508,12 @@ module_param(lowhsync, bool, 0);
 MODULE_PARM_DESC(lowhsync, "Force horizontal sync low regardless
of mode");
 module_param(lowvsync, bool, 0);
 MODULE_PARM_DESC(lowvsync, "Force vertical sync low regardless
of mode");
+module_param(noaccel, bool, 0);
+MODULE_PARM_DESC(noaccel, "Disable acceleration");
+#ifdef CONFIG_MTRR
+module_param(nomtrr, bool, 0);
+MODULE_PARM_DESC(nomtrr, "Disable MTRR support (0 or 1=3Ddisabled)
(default=3D0)");
+#endif
=20
 MODULE_AUTHOR("Jim Hague <jim.hague@acm.org>");
 MODULE_DESCRIPTION("Permedia2 framebuffer device driver");


----------------------------------------------------
Wroc=B3aw Non Stop - eksplozja kultury we Wroc=B3awiu!=20
22 czerwca - 1 lipca 2007.=20
W ramach festiwalu wyst=B1pi=B1 m.in. Iggy Pop & The Stooges!
wwW.wroclawnonstop.pl http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.w=
p.pl%2Fas%2Figgypop.html&sid=3D1194

--part467a22ef0998c
Content-Type: text/x-patch; name="pm2fb-mtrr.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pm2fb-mtrr.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggYWRk
cyB1c2FnZSBvZiBNVFJSIHJlZ2lzdGVycyBhbmQgdHdvIG5ldyBvcHRpb25zOiBub2FjY2VsIGFu
ZCBub210cnIuCgpTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgSGVsdCA8a3J6eXN6dG9mLmgxQHdw
LnBsPgoKLS0tCgotLS0gbGludXgtMi42LjIxL2RyaXZlcnMvdmlkZW8vcG0yZmIuYwkyMDA3LTA2
LTIxIDA4OjMyOjA3LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIyL2RyaXZlcnMvdmlk
ZW8vcG0yZmIuYwkyMDA3LTA2LTIxIDA4OjMwOjA5LjAwMDAwMDAwMCArMDIwMApAQCAtMzgsNiAr
MzgsOSBAQAogI2luY2x1ZGUgPGxpbnV4L2ZiLmg+CiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPgog
I2luY2x1ZGUgPGxpbnV4L3BjaS5oPgorI2lmZGVmIENPTkZJR19NVFJSCisjaW5jbHVkZSA8YXNt
L210cnIuaD4KKyNlbmRpZgogCiAjaW5jbHVkZSA8dmlkZW8vcGVybWVkaWEyLmg+CiAjaW5jbHVk
ZSA8dmlkZW8vY3Zpc2lvbnBwYy5oPgpAQCAtNzEsOCArNzQsMTMgQEAgc3RhdGljIGNoYXIgKm1v
ZGUgX19kZXZpbml0ZGF0YSA9IE5VTEw7CiAgKiB0aGVzZSBmbGFncyBhbGxvdyB0aGUgdXNlciB0
byBzcGVjaWZ5IHRoYXQgcmVxdWVzdHMgZm9yICt2ZSBzeW5jCiAgKiBzaG91bGQgYmUgc2lsZW50
bHkgdHVybmVkIGluIC12ZSBzeW5jLgogICovCi1zdGF0aWMgaW50IGxvd2hzeW5jOwotc3RhdGlj
IGludCBsb3d2c3luYzsKK3N0YXRpYyBpbnQgbG93aHN5bmMgX19kZXZpbml0ZGF0YTsKK3N0YXRp
YyBpbnQgbG93dnN5bmMgX19kZXZpbml0ZGF0YTsKK3N0YXRpYyBpbnQgbm9hY2NlbCBfX2Rldmlu
aXRkYXRhOworLyogbXRyciBvcHRpb24gKi8KKyNpZmRlZiBDT05GSUdfTVRSUgorc3RhdGljIGlu
dCBub210cnIgX19kZXZpbml0ZGF0YTsKKyNlbmRpZgogCiAvKgogICogVGhlIGhhcmR3YXJlIHN0
YXRlIG9mIHRoZSBncmFwaGljcyBjYXJkIHRoYXQgaXNuJ3QgcGFydCBvZiB0aGUKQEAgLTg4LDYg
Kzk2LDcgQEAgc3RydWN0IHBtMmZiX3BhcgogCXUzMgkJbWVtX2NvbnRyb2w7CS8qIE1lbUNvbnRy
b2wgcmVnIGF0IHByb2JlICovCiAJdTMyCQlib290X2FkZHJlc3M7CS8qIEJvb3RBZGRyZXNzIHJl
ZyBhdCBwcm9iZSAqLwogCXUzMgkJcGFsZXR0ZVsxNl07CisJaW50CQltdHJyX2hhbmRsZTsKIH07
CiAKIC8qCkBAIC0xMzE2LDYgKzEzMjUsMTUgQEAgc3RhdGljIGludCBfX2RldmluaXQgcG0yZmJf
cHJvYmUoc3RydWN0IAogCQlnb3RvIGVycl9leGl0X21taW87CiAJfQogCisjaWZkZWYgQ09ORklH
X01UUlIKKwlkZWZhdWx0X3Bhci0+bXRycl9oYW5kbGUgPSAtMTsKKwlpZiAoIW5vbXRycikKKwkJ
ZGVmYXVsdF9wYXItPm10cnJfaGFuZGxlID0KKwkJCW10cnJfYWRkKHBtMmZiX2ZpeC5zbWVtX3N0
YXJ0LAorCQkJCSBwbTJmYl9maXguc21lbV9sZW4sCisJCQkJIE1UUlJfVFlQRV9XUkNPTUIsIDEp
OworI2VuZGlmCisKIAlpbmZvLT5mYm9wcwkJPSAmcG0yZmJfb3BzOwogCWluZm8tPmZpeAkJPSBw
bTJmYl9maXg7CiAJaW5mby0+cHNldWRvX3BhbGV0dGUJPSBkZWZhdWx0X3Bhci0+cGFsZXR0ZTsK
QEAgLTEzMjQsNiArMTM0MiwxMSBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBwbTJmYl9wcm9iZShz
dHJ1Y3QgCiAJCQkJICBGQklORk9fSFdBQ0NFTF9DT1BZQVJFQSB8CiAJCQkJICBGQklORk9fSFdB
Q0NFTF9GSUxMUkVDVDsKIAorCWlmIChub2FjY2VsKSB7CisJICAgIAlwcmludGsoS0VSTl9ERUJV
RyAiZGlzYWJsaW5nIGFjY2VsZXJhdGlvblxuIik7CisgIAkJaW5mby0+ZmxhZ3MgfD0gRkJJTkZP
X0hXQUNDRUxfRElTQUJMRUQ7CisJfQorCiAJaWYgKCFtb2RlKQogCQltb2RlID0gIjY0MHg0ODBA
NjAiOwogCkBAIC0xMzc1LDYgKzEzOTgsMTEgQEAgc3RhdGljIHZvaWQgX19kZXZleGl0IHBtMmZi
X3JlbW92ZShzdHJ1YwogCiAJdW5yZWdpc3Rlcl9mcmFtZWJ1ZmZlcihpbmZvKTsKIAorI2lmZGVm
IENPTkZJR19NVFJSCisJaWYgKHBhci0+bXRycl9oYW5kbGUgPj0gMCkKKwkJbXRycl9kZWwocGFy
LT5tdHJyX2hhbmRsZSwgaW5mby0+Zml4LnNtZW1fc3RhcnQsCisJCQkgaW5mby0+Zml4LnNtZW1f
bGVuKTsKKyNlbmRpZiAvKiBDT05GSUdfTVRSUiAqLwogCWlvdW5tYXAoaW5mby0+c2NyZWVuX2Jh
c2UpOwogCXJlbGVhc2VfbWVtX3JlZ2lvbihmaXgtPnNtZW1fc3RhcnQsIGZpeC0+c21lbV9sZW4p
OwogCWlvdW5tYXAocGFyLT52X3JlZ3MpOwpAQCAtMTQzMCw2ICsxNDU4LDEyIEBAIHN0YXRpYyBp
bnQgX19pbml0IHBtMmZiX3NldHVwKGNoYXIgKm9wdGkKIAkJCWxvd2hzeW5jID0gMTsKIAkJfSBl
bHNlIGlmKCFzdHJjbXAodGhpc19vcHQsICJsb3d2c3luYyIpKSB7CiAJCQlsb3d2c3luYyA9IDE7
CisjaWZkZWYgQ09ORklHX01UUlIKKwkJfSBlbHNlIGlmICghc3RybmNtcCh0aGlzX29wdCwgIm5v
bXRyciIsIDYpKSB7CisJCQlub210cnIgPSAxOworI2VuZGlmCisJCX0gZWxzZSBpZiAoIXN0cm5j
bXAodGhpc19vcHQsICJub2FjY2VsIiwgNykpIHsKKwkJCW5vYWNjZWwgPSAxOwogCQl9IGVsc2Ug
ewogCQkJbW9kZSA9IHRoaXNfb3B0OwogCQl9CkBAIC0xNDc0LDYgKzE1MDgsMTIgQEAgbW9kdWxl
X3BhcmFtKGxvd2hzeW5jLCBib29sLCAwKTsKIE1PRFVMRV9QQVJNX0RFU0MobG93aHN5bmMsICJG
b3JjZSBob3Jpem9udGFsIHN5bmMgbG93IHJlZ2FyZGxlc3Mgb2YgbW9kZSIpOwogbW9kdWxlX3Bh
cmFtKGxvd3ZzeW5jLCBib29sLCAwKTsKIE1PRFVMRV9QQVJNX0RFU0MobG93dnN5bmMsICJGb3Jj
ZSB2ZXJ0aWNhbCBzeW5jIGxvdyByZWdhcmRsZXNzIG9mIG1vZGUiKTsKK21vZHVsZV9wYXJhbShu
b2FjY2VsLCBib29sLCAwKTsKK01PRFVMRV9QQVJNX0RFU0Mobm9hY2NlbCwgIkRpc2FibGUgYWNj
ZWxlcmF0aW9uIik7CisjaWZkZWYgQ09ORklHX01UUlIKK21vZHVsZV9wYXJhbShub210cnIsIGJv
b2wsIDApOworTU9EVUxFX1BBUk1fREVTQyhub210cnIsICJEaXNhYmxlIE1UUlIgc3VwcG9ydCAo
MCBvciAxPWRpc2FibGVkKSAoZGVmYXVsdD0wKSIpOworI2VuZGlmCiAKIE1PRFVMRV9BVVRIT1Io
IkppbSBIYWd1ZSA8amltLmhhZ3VlQGFjbS5vcmc+Iik7CiBNT0RVTEVfREVTQ1JJUFRJT04oIlBl
cm1lZGlhMiBmcmFtZWJ1ZmZlciBkZXZpY2UgZHJpdmVyIik7Cg==

--part467a22ef0998c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part467a22ef0998c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part467a22ef0998c--

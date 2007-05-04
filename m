From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] skeletonfb: improvements
Date: Fri, 04 May 2007 19:12:24 +0200
Message-ID: <463b6978c449f@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part463b6978c6bb4"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hk1Ka-00035e-AG for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 May 2007 10:12:32 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hk1KW-0003Ut-Pi
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 May 2007 10:12:32 -0700
Received: from poczta-4.free.wp-sa.pl (HELO localhost) ([10.1.1.22])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 4 May 2007 19:12:24 +0200
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

--part463b6978c6bb4
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds a macro to register PCI ids table and corrects=20
type of xxxfb_fix variable to avoid modpost warnings.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---


--- linux-2.6.21.orig/drivers/video/skeletonfb.c	2007-05-04=20
10:20:25.000000000 +0200
+++ linux-2.6.21/drivers/video/skeletonfb.c	2007-05-04 10:17:
21.000000000 +0200
@@ -84,7 +84,7 @@ struct xxx_par;
  * if we don't use modedb. If we do use modedb see xxxfb_init=20
how to use it
  * to get a fb_var_screeninfo. Otherwise define a default var as=20
well.=20
  */
-static struct fb_fix_screeninfo xxxfb_fix __initdata =3D {
+static struct fb_fix_screeninfo xxxfb_fix __devinitdata =3D {
 	.id =3D		"FB's name",=20
 	.type =3D		FB_TYPE_PACKED_PIXELS,
 	.visual =3D	FB_VISUAL_PSEUDOCOLOR,
@@ -705,7 +705,7 @@ static int __devinit xxxfb_probe(struct=20
     info->screen_base =3D framebuffer_virtual_memory;
     info->fbops =3D &xxxfb_ops;
     info->fix =3D xxxfb_fix; /* this will be the only time=20
xxxfb_fix will be
-			    * used, so mark it as __initdata
+			    * used, so mark it as __devinitdata
 			    */
     info->pseudo_palette =3D pseudo_palette; /* The pseudopalette=20
is an
 					    * 16-member array
@@ -900,6 +900,8 @@ static struct pci_driver xxxfb_driver =3D=20
 	.resume =3D       xxxfb_resume,  /* optional but recommended */
 };
=20
+MODULE_DEVICE_TABLE(pci, xxxfb_id_table);
+
 int __init xxxfb_init(void)
 {
 	/*


----------------------------------------------------
Ju=BF nied=B3ugo pierwsza komunia! Zr=F3b naprawd=EA niezapomniany prezen=
t:
Pi=EAknie wydany i zilustrowany album do uzupe=B3nienia przez dziecko
b=EAdzie na ca=B3e =BFycie kronik=B1 Pierwszej Komunii =A6wi=EAtej - Zoba=
cz:
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fkom.html&s=
id=3D1125

--part463b6978c6bb4
Content-Type: application/octet-stream; name="skeletonfb-improvements.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="skeletonfb-improvements.diff"

LS0tIGxpbnV4LTIuNi4yMS5vcmlnL2RyaXZlcnMvdmlkZW8vc2tlbGV0b25mYi5jCTIwMDctMDUt
MDQgMTA6MjA6MjUuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjEvZHJpdmVycy92aWRl
by9za2VsZXRvbmZiLmMJMjAwNy0wNS0wNCAxMDoxNzoyMS4wMDAwMDAwMDAgKzAyMDAKQEAgLTg0
LDcgKzg0LDcgQEAgc3RydWN0IHh4eF9wYXI7CiAgKiBpZiB3ZSBkb24ndCB1c2UgbW9kZWRiLiBJ
ZiB3ZSBkbyB1c2UgbW9kZWRiIHNlZSB4eHhmYl9pbml0IGhvdyB0byB1c2UgaXQKICAqIHRvIGdl
dCBhIGZiX3Zhcl9zY3JlZW5pbmZvLiBPdGhlcndpc2UgZGVmaW5lIGEgZGVmYXVsdCB2YXIgYXMg
d2VsbC4gCiAgKi8KLXN0YXRpYyBzdHJ1Y3QgZmJfZml4X3NjcmVlbmluZm8geHh4ZmJfZml4IF9f
aW5pdGRhdGEgPSB7CitzdGF0aWMgc3RydWN0IGZiX2ZpeF9zY3JlZW5pbmZvIHh4eGZiX2ZpeCBf
X2RldmluaXRkYXRhID0gewogCS5pZCA9CQkiRkIncyBuYW1lIiwgCiAJLnR5cGUgPQkJRkJfVFlQ
RV9QQUNLRURfUElYRUxTLAogCS52aXN1YWwgPQlGQl9WSVNVQUxfUFNFVURPQ09MT1IsCkBAIC03
MDUsNyArNzA1LDcgQEAgc3RhdGljIGludCBfX2RldmluaXQgeHh4ZmJfcHJvYmUoc3RydWN0IAog
ICAgIGluZm8tPnNjcmVlbl9iYXNlID0gZnJhbWVidWZmZXJfdmlydHVhbF9tZW1vcnk7CiAgICAg
aW5mby0+ZmJvcHMgPSAmeHh4ZmJfb3BzOwogICAgIGluZm8tPmZpeCA9IHh4eGZiX2ZpeDsgLyog
dGhpcyB3aWxsIGJlIHRoZSBvbmx5IHRpbWUgeHh4ZmJfZml4IHdpbGwgYmUKLQkJCSAgICAqIHVz
ZWQsIHNvIG1hcmsgaXQgYXMgX19pbml0ZGF0YQorCQkJICAgICogdXNlZCwgc28gbWFyayBpdCBh
cyBfX2RldmluaXRkYXRhCiAJCQkgICAgKi8KICAgICBpbmZvLT5wc2V1ZG9fcGFsZXR0ZSA9IHBz
ZXVkb19wYWxldHRlOyAvKiBUaGUgcHNldWRvcGFsZXR0ZSBpcyBhbgogCQkJCQkgICAgKiAxNi1t
ZW1iZXIgYXJyYXkKQEAgLTkwMCw2ICs5MDAsOCBAQCBzdGF0aWMgc3RydWN0IHBjaV9kcml2ZXIg
eHh4ZmJfZHJpdmVyID0gCiAJLnJlc3VtZSA9ICAgICAgIHh4eGZiX3Jlc3VtZSwgIC8qIG9wdGlv
bmFsIGJ1dCByZWNvbW1lbmRlZCAqLwogfTsKIAorTU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIHh4
eGZiX2lkX3RhYmxlKTsKKwogaW50IF9faW5pdCB4eHhmYl9pbml0KHZvaWQpCiB7CiAJLyoK

--part463b6978c6bb4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part463b6978c6bb4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part463b6978c6bb4--

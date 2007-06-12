From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] skeletonfb: wrong field name fix
Date: Tue, 12 Jun 2007 08:42:35 +0200
Message-ID: <466e405b7cfb3@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part466e405b7f6a6"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hy05R-0000ED-VK for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Jun 2007 23:42:42 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hy05Q-0002CZ-Ah
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Jun 2007 23:42:41 -0700
Received: from poczta-16.free.wp-sa.pl (HELO localhost) ([10.1.1.71])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	12 Jun 2007 08:42:35 +0200
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

--part466e405b7f6a6
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch corrects name of the field.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
--- linux-2.6.21/drivers/video/skeletonfb.c	2007-06-05
09:01:06.000000000 +0200
+++ linux-2.6.22/drivers/video/skeletonfb.c	2007-06-12
08:31:52.000000000 +0200
@@ -780,7 +780,7 @@ static int __devinit xxxfb_probe(struct=20
      *
      * NOTE: This field is currently unused.
      */
-    info->pixmap.scan_align =3D 32;
+    info->pixmap.access_align =3D 32;
 /***************************** End optional stage
***************************/
=20
     /*


----------------------------------------------------
"Szklana Pu=B3apka,"Na Fali" i "Zab=F3jcza Bro=F1" w jednym filmie,=20
pe=B3nym niepowtarzalnego, angielskiego humoru."Hot Fuzz:Ostre Psy"=20
w kinach od 8 czerwca! http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.=
wp.pl%2Fas%2Fhotfuzz.html&sid=3D1188

--part466e405b7f6a6
Content-Type: text/x-patch; name="skeletonfb-access_align-fix.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="skeletonfb-access_align-fix.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggY29y
cmVjdHMgbmFtZSBvZiB0aGUgZmllbGQuCgpTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgSGVsdCA8
a3J6eXN6dG9mLmgxQHdwLnBsPgoKLS0tCgotLS0gbGludXgtMi42LjIxL2RyaXZlcnMvdmlkZW8v
c2tlbGV0b25mYi5jCTIwMDctMDYtMDUgMDk6MDE6MDYuMDAwMDAwMDAwICswMjAwCisrKyBsaW51
eC0yLjYuMjIvZHJpdmVycy92aWRlby9za2VsZXRvbmZiLmMJMjAwNy0wNi0xMiAwODozMTo1Mi4w
MDAwMDAwMDAgKzAyMDAKQEAgLTc4MCw3ICs3ODAsNyBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCB4
eHhmYl9wcm9iZShzdHJ1Y3QgCiAgICAgICoKICAgICAgKiBOT1RFOiBUaGlzIGZpZWxkIGlzIGN1
cnJlbnRseSB1bnVzZWQuCiAgICAgICovCi0gICAgaW5mby0+cGl4bWFwLnNjYW5fYWxpZ24gPSAz
MjsKKyAgICBpbmZvLT5waXhtYXAuYWNjZXNzX2FsaWduID0gMzI7CiAvKioqKioqKioqKioqKioq
KioqKioqKioqKioqKiogRW5kIG9wdGlvbmFsIHN0YWdlICoqKioqKioqKioqKioqKioqKioqKioq
KioqKi8KIAogICAgIC8qCg==

--part466e405b7f6a6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part466e405b7f6a6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part466e405b7f6a6--

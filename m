From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb: Fix of jumps in pm2fb_probe
Date: Fri, 04 May 2007 19:15:00 +0200
Message-ID: <463b6a1411340@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part463b6a1413a4f"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hk1N2-0003Dq-Uh for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 May 2007 10:15:05 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hk1N2-0004oj-BE
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 May 2007 10:15:04 -0700
Received: from poczta-4.free.wp-sa.pl (HELO localhost) ([10.1.1.22])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 4 May 2007 19:15:00 +0200
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

--part463b6a1413a4f
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes incorrect targets of jumps when an error occurs=20
in the pm2fb_probe.

Signed-off-by: <krzysztof.h1@wp.pl>

---

This patch may requires pm2fb patches I sent before.



--- linux-2.6.21.orig/drivers/video/pm2fb.c	2007-05-03 14:46:
06.000000000 +0200
+++ linux-2.6.21/drivers/video/pm2fb.c	2007-05-03 14:46:59.
000000000 +0200
@@ -1210,10 +1209,10 @@ static int __devinit pm2fb_probe(struct=20
 		info->var =3D pm2fb_var;
=20
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
-		goto err_exit_all;
+		goto err_exit_both;
=20
 	if (register_framebuffer(info) < 0)
-		goto err_exit_both;
+		goto err_exit_all;
=20
 	printk(KERN_INFO "fb%d: %s frame buffer device, memory =3D %
dK.\n",
 	       info->node, info->fix.id, pm2fb_fix.smem_len / 1024);


----------------------------------------------------
Zobacz, jak=B1 walk=EA stoczy superbohater, by ocali=E6 siebie
i swych bliskich. A najwi=EAksza bitwa rozegra si=EA w jego duszy.
SPIDER-MAN 3 w kinach od 4 maja.
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fspiderman3=
.html&sid=3D1122

--part463b6a1413a4f
Content-Type: application/octet-stream; name="pm2fb-exit-fix.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pm2fb-exit-fix.diff"

LS0tIGxpbnV4LTIuNi4yMS5vcmlnL2RyaXZlcnMvdmlkZW8vcG0yZmIuYwkyMDA3LTA1LTAzIDE0
OjQ2OjA2LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIxL2RyaXZlcnMvdmlkZW8vcG0y
ZmIuYwkyMDA3LTA1LTAzIDE0OjQ2OjU5LjAwMDAwMDAwMCArMDIwMApAQCAtMTIxMCwxMCArMTIw
OSwxMCBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBwbTJmYl9wcm9iZShzdHJ1Y3QgCiAJCWluZm8t
PnZhciA9IHBtMmZiX3ZhcjsKIAogCWlmIChmYl9hbGxvY19jbWFwKCZpbmZvLT5jbWFwLCAyNTYs
IDApIDwgMCkKLQkJZ290byBlcnJfZXhpdF9hbGw7CisJCWdvdG8gZXJyX2V4aXRfYm90aDsKIAog
CWlmIChyZWdpc3Rlcl9mcmFtZWJ1ZmZlcihpbmZvKSA8IDApCi0JCWdvdG8gZXJyX2V4aXRfYm90
aDsKKwkJZ290byBlcnJfZXhpdF9hbGw7CiAKIAlwcmludGsoS0VSTl9JTkZPICJmYiVkOiAlcyBm
cmFtZSBidWZmZXIgZGV2aWNlLCBtZW1vcnkgPSAlZEsuXG4iLAogCSAgICAgICBpbmZvLT5ub2Rl
LCBpbmZvLT5maXguaWQsIHBtMmZiX2ZpeC5zbWVtX2xlbiAvIDEwMjQpOwo=

--part463b6a1413a4f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part463b6a1413a4f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part463b6a1413a4f--

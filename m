From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb: Reset transparency settings
Date: Sun, 29 Apr 2007 21:14:21 +0200
Message-ID: <4634ee8d7d1b2@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part4634ee8d7f844"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiEqo-0006I2-42 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Apr 2007 12:14:26 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiEqm-0003F7-MY
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Apr 2007 12:14:26 -0700
Received: from poczta-8.free.wp-sa.pl (HELO localhost) ([10.1.1.19])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	29 Apr 2007 21:14:21 +0200
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

--part4634ee8d7f844
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt < krzysztof.h1@wp.pl>

This patch resets transparency settings when depth changes.
Otherwise the 16 and 24-bit modes work incorrectly after
switching from 32-bit mode.

---
This is a patch against 2.6.21 kernel.


----------------------------------------------------
Sprawd=BC ile wart jest Tw=F3j samoch=F3d.=20
Wycena aut jak na d=B3oni: http://klik.wp.pl/?adr=3Dwww.wycenyaut.wp.pl&s=
id=3D1117

--part4634ee8d7f844
Content-Type: application/octet-stream; name="pm2fb-reset-transp.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pm2fb-reset-transp.diff"

LS0tIGxpbnV4LTIuNi4yMS5uZXcvZHJpdmVycy92aWRlby9wbTJmYi5jCTIwMDctMDQtMjkgMTk6
Mjk6NDMuMTE3NjgyNzM3ICswMjAwCisrKyBsaW51eC0yLjYuMjEvZHJpdmVycy92aWRlby9wbTJm
Yi5jCTIwMDctMDQtMjkgMjA6NTk6MjQuOTk1NjMwMjE2ICswMjAwCkBAIC02NDUsNiArNjU2LDgg
QEAgc3RhdGljIGludCBwbTJmYl9jaGVja192YXIoc3RydWN0IGZiX3ZhcgogCQlyZXR1cm4gLUVJ
TlZBTDsKIAl9CiAKKwl2YXItPnRyYW5zcC5vZmZzZXQgPSAwOworCXZhci0+dHJhbnNwLmxlbmd0
aCA9IDA7CiAJc3dpdGNoKHZhci0+Yml0c19wZXJfcGl4ZWwpIHsKIAljYXNlIDg6CiAJCXZhci0+
cmVkLmxlbmd0aCA9IHZhci0+Z3JlZW4ubGVuZ3RoID0gdmFyLT5ibHVlLmxlbmd0aCA9IDg7Cg==

--part4634ee8d7f844
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part4634ee8d7f844
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part4634ee8d7f844--

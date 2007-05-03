From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [RESENT][PATCH] pm2fb: removal of pm2fb_par
	fields
Date: Thu, 03 May 2007 09:44:32 +0200
Message-ID: <463992e0d1eee@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part463992e0d464a"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjVzS-0001l3-O6 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 00:44:38 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HjVzR-0008GJ-BB
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 00:44:38 -0700
Received: from poczta-2.free.wp-sa.pl (HELO localhost) ([10.1.1.167])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 3 May 2007 09:44:32 +0200
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

--part463992e0d464a
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes two redudant fields in the pm2fb_par=20
structure.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This is a patch against mm tree with already sent pm2fb patches=20
applied.

This is sent as attachment to avoid wrapping long lines.

Regards,
Krzysztof

----------------------------------------------------
Zobacz, jak=B1 walk=EA stoczy superbohater, by ocali=E6 siebie
i swych bliskich. A najwi=EAksza bitwa rozegra si=EA w jego duszy.
SPIDER-MAN 3 w kinach od 4 maja.
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fspiderman3=
.html&sid=3D1122

--part463992e0d464a
Content-Type: application/octet-stream; name="pm2fb-par_fields_removal.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pm2fb-par_fields_removal.diff"

LS0tIGxpbnV4LTIuNi4yMS5vcmlnL2RyaXZlcnMvdmlkZW8vcG0yZmIuYwkyMDA3LTA1LTAxIDEx
OjM4OjU1LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIxL2RyaXZlcnMvdmlkZW8vcG0y
ZmIuYwkyMDA3LTA1LTAyIDIxOjE0OjI1LjAwMDAwMDAwMCArMDIwMApAQCAtODEsOCArODEsNiBA
QCBzdGF0aWMgaW50IGxvd3ZzeW5jOwogc3RydWN0IHBtMmZiX3BhcgogewogCXBtMnR5cGVfdAl0
eXBlOwkJLyogQm9hcmQgdHlwZSAqLwotCXUzMgkJZmJfc2l6ZTsJLyogZnJhbWVidWZmZXIgbWVt
b3J5IHNpemUgKi8KLQl1bnNpZ25lZCBjaGFyCV9faW9tZW0gKnZfZmI7ICAvKiB2aXJ0dWFsIGFk
ZHJlc3Mgb2YgZnJhbWUgYnVmZmVyICovCiAJdW5zaWduZWQgY2hhcglfX2lvbWVtICp2X3JlZ3M7
LyogdmlydHVhbCBhZGRyZXNzIG9mIHBfcmVncyAqLwogCXUzMiAJICAgCW1lbWNsb2NrOwkvKiBt
ZW1jbG9jayAqLwogCXUzMgkJdmlkZW87CQkvKiB2aWRlbyBmbGFncyBiZWZvcmUgYmxhbmtpbmcg
Ki8KQEAgLTExNjksMjAgKzExNjcsMjAgQEAgc3RhdGljIGludCBfX2RldmluaXQgcG0yZmJfcHJv
YmUoc3RydWN0IAogCS8qIE5vdyB3b3JrIG91dCBob3cgYmlnIGxmYiBpcyBnb2luZyB0byBiZS4g
Ki8KIAlzd2l0Y2goZGVmYXVsdF9wYXItPm1lbV9jb25maWcgJiBQTTJGX01FTV9DT05GSUdfUkFN
X01BU0spIHsKIAljYXNlIFBNMkZfTUVNX0JBTktTXzE6Ci0JCWRlZmF1bHRfcGFyLT5mYl9zaXpl
PTB4MjAwMDAwOworCQlwbTJmYl9maXguc21lbV9sZW49MHgyMDAwMDA7CiAJCWJyZWFrOwogCWNh
c2UgUE0yRl9NRU1fQkFOS1NfMjoKLQkJZGVmYXVsdF9wYXItPmZiX3NpemU9MHg0MDAwMDA7CisJ
CXBtMmZiX2ZpeC5zbWVtX2xlbj0weDQwMDAwMDsKIAkJYnJlYWs7CiAJY2FzZSBQTTJGX01FTV9C
QU5LU18zOgotCQlkZWZhdWx0X3Bhci0+ZmJfc2l6ZT0weDYwMDAwMDsKKwkJcG0yZmJfZml4LnNt
ZW1fbGVuPTB4NjAwMDAwOwogCQlicmVhazsKIAljYXNlIFBNMkZfTUVNX0JBTktTXzQ6Ci0JCWRl
ZmF1bHRfcGFyLT5mYl9zaXplPTB4ODAwMDAwOworCQlwbTJmYl9maXguc21lbV9sZW49MHg4MDAw
MDA7CiAJCWJyZWFrOwogCX0KIAlwbTJmYl9maXguc21lbV9zdGFydCA9IHBjaV9yZXNvdXJjZV9z
dGFydChwZGV2LCAxKTsKLQlwbTJmYl9maXguc21lbV9sZW4gPSBkZWZhdWx0X3Bhci0+ZmJfc2l6
ZTsKKwlwbTJmYl9maXguc21lbV9sZW4gPSBwbTJmYl9maXguc21lbV9sZW47CiAKIAkvKiBMaW5l
YXIgZnJhbWUgYnVmZmVyIC0gcmVxdWVzdCByZWdpb24gYW5kIG1hcCBpdC4gKi8KIAlpZiAoICFy
ZXF1ZXN0X21lbV9yZWdpb24ocG0yZmJfZml4LnNtZW1fc3RhcnQsIHBtMmZiX2ZpeC5zbWVtX2xl
biwKQEAgLTExOTAsOSArMTE4OCw5IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IHBtMmZiX3Byb2Jl
KHN0cnVjdCAKIAkJcHJpbnRrKEtFUk5fV0FSTklORyAicG0yZmI6IENhbid0IHJlc2VydmUgc21l
bS5cbiIpOwogCQlnb3RvIGVycl9leGl0X21taW87CiAJfQotCWluZm8tPnNjcmVlbl9iYXNlID0g
ZGVmYXVsdF9wYXItPnZfZmIgPQorCWluZm8tPnNjcmVlbl9iYXNlID0KIAkJaW9yZW1hcF9ub2Nh
Y2hlKHBtMmZiX2ZpeC5zbWVtX3N0YXJ0LCBwbTJmYl9maXguc21lbV9sZW4pOwotCWlmICggIWRl
ZmF1bHRfcGFyLT52X2ZiICkgeworCWlmICggIWluZm8tPnNjcmVlbl9iYXNlICkgewogCQlwcmlu
dGsoS0VSTl9XQVJOSU5HICJwbTJmYjogQ2FuJ3QgaW9yZW1hcCBzbWVtIGFyZWEuXG4iKTsKIAkJ
cmVsZWFzZV9tZW1fcmVnaW9uKHBtMmZiX2ZpeC5zbWVtX3N0YXJ0LCBwbTJmYl9maXguc21lbV9s
ZW4pOwogCQlnb3RvIGVycl9leGl0X21taW87CkBAIC0xMjE4LDcgKzEyMTYsNyBAQCBzdGF0aWMg
aW50IF9fZGV2aW5pdCBwbTJmYl9wcm9iZShzdHJ1Y3QgCiAJCWdvdG8gZXJyX2V4aXRfYm90aDsK
IAogCXByaW50ayhLRVJOX0lORk8gImZiJWQ6ICVzIGZyYW1lIGJ1ZmZlciBkZXZpY2UsIG1lbW9y
eSA9ICVkSy5cbiIsCi0JICAgICAgIGluZm8tPm5vZGUsIGluZm8tPmZpeC5pZCwgZGVmYXVsdF9w
YXItPmZiX3NpemUgLyAxMDI0KTsKKwkgICAgICAgaW5mby0+bm9kZSwgaW5mby0+Zml4LmlkLCBw
bTJmYl9maXguc21lbV9sZW4gLyAxMDI0KTsKIAogCS8qCiAJICogT3VyIGRyaXZlciBkYXRhCg==

--part463992e0d464a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part463992e0d464a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part463992e0d464a--

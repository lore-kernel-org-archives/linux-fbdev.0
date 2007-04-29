From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb: memclock setting corrections
Date: Sun, 29 Apr 2007 21:24:10 +0200
Message-ID: <4634f0da1294f@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part4634f0da15052"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiF0G-0007Hq-5z for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Apr 2007 12:24:14 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiF0F-0006sX-OA
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Apr 2007 12:24:12 -0700
Received: from poczta-8.free.wp-sa.pl (HELO localhost) ([10.1.1.19])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	29 Apr 2007 21:24:10 +0200
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

--part4634f0da15052
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch disables a memory clock setting if a board has been
initialized by BIOS. This allows using the memory clock set by
manufacturer of the board.
This patch also sets default clock for 3dlabs Permedia 2V
reference board's clock to 75MHz (BIOS setting for EONtronic
Permedia 2Vboard), because the default 83MHz can be too high.

---
This patch requires the patch
pm2fb-3dlabs-permedia-2v-reference-board-added.patch
 from mm tree to be applied first.


----------------------------------------------------
Sprawd=BC ile wart jest Tw=F3j samoch=F3d.=20
Wycena aut jak na d=B3oni: http://klik.wp.pl/?adr=3Dwww.wycenyaut.wp.pl&s=
id=3D1117

--part4634f0da15052
Content-Type: application/octet-stream; name="pm2fb-clock-corrections.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pm2fb-clock-corrections.diff"

ZGlmZiAtdXJwIGxpbnV4LTIuNi4yMS5vcmlnL2RyaXZlcnMvdmlkZW8vcG0yZmIuYyBsaW51eC0y
LjYuMjEub2xkL2RyaXZlcnMvdmlkZW8vcG0yZmIuYwotLS0gbGludXgtMi42LjIxLm9yaWcvZHJp
dmVycy92aWRlby9wbTJmYi5jCTIwMDctMDQtMjYgMjI6NTk6MjEuNjk3Nzc3NjY4ICswMjAwCisr
KyBsaW51eC0yLjYuMjEub2xkL2RyaXZlcnMvdmlkZW8vcG0yZmIuYwkyMDA3LTA0LTIyIDE5OjQy
OjI5LjcxNTIxNDI2NSArMDIwMApAQCAtMTEzOSwxMCArMTE0NCwxMCBAQCBzdGF0aWMgaW50IF9f
ZGV2aW5pdCBwbTJmYl9wcm9iZShzdHJ1Y3QgCiAJCWRlZmF1bHRfcGFyLT5tZW1fY29udHJvbCwg
ZGVmYXVsdF9wYXItPmJvb3RfYWRkcmVzcywKIAkJZGVmYXVsdF9wYXItPm1lbV9jb25maWcpOwog
Ci0JZGVmYXVsdF9wYXItPm1lbWNsb2NrID0gQ1ZQUENfTUVNQ0xPQ0s7CiAJaWYoZGVmYXVsdF9w
YXItPm1lbV9jb250cm9sID09IDAgJiYKIAkJZGVmYXVsdF9wYXItPmJvb3RfYWRkcmVzcyA9PSAw
eDMxICYmCiAJCWRlZmF1bHRfcGFyLT5tZW1fY29uZmlnID09IDB4MjU5ZmZmZmYpIHsKKwkJZGVm
YXVsdF9wYXItPm1lbWNsb2NrID0gQ1ZQUENfTUVNQ0xPQ0s7CiAJCWRlZmF1bHRfcGFyLT5tZW1f
Y29udHJvbD0wOwogCQlkZWZhdWx0X3Bhci0+Ym9vdF9hZGRyZXNzPTB4MjA7CiAJCWRlZmF1bHRf
cGFyLT5tZW1fY29uZmlnPTB4ZTYwMDIwMjE7CkBAIC0xMTYyLDcgKzExNjcsNyBAQCBzdGF0aWMg
aW50IF9fZGV2aW5pdCBwbTJmYl9wcm9iZShzdHJ1Y3QgCiAJCQlEUFJJTlRLKCJXZSBoYXZlIG5v
dCBiZWVuIGluaXRpYWxpemVkIGJ5IFZHQSBCSU9TICIKIAkJCQkiYW5kIGFyZSBydW5uaW5nIG9u
IGFuIDNkbGFicyByZWZlcmVuY2UgYm9hcmRcbiIpOwogCQkJRFBSSU5USygiSW5pdGlhbGl6aW5n
IGNhcmQgdGltaW5ncyBtYW51YWxseS4uLlxuIik7Ci0JCQlkZWZhdWx0X3Bhci0+bWVtY2xvY2s9
NzAwMDA7CisJCQlkZWZhdWx0X3Bhci0+bWVtY2xvY2s9NzQ4OTQ7CiAJCX0KIAl9CiAK

--part4634f0da15052
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part4634f0da15052
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part4634f0da15052--

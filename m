From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [RESENT] [PATCH] pm2fb: memclock setting
	corrections
Date: Mon, 30 Apr 2007 14:16:09 +0200
Message-ID: <4635de0972357@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part4635de0974a55"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiUnq-0003EO-Po for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 05:16:27 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiUnq-0006Jw-3G
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 05:16:26 -0700
Received: from poczta-7.free.wp-sa.pl (HELO localhost) ([10.1.1.16])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	30 Apr 2007 14:16:09 +0200
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

--part4635de0974a55
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

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
This patch requires the patch
pm2fb-3dlabs-permedia-2v-reference-board-added.patch
from mm tree to be applied first.


----------------------------------------------------
Poznaj nowa milo=B6=E6! HOLIDAY - ciep=B3y i pe=B3en humoru=20
film tw=F3rc=F3w "Czego pragn=B1 kobiety". Cameron Diaz, Kate Winslet,=20
Jude Law w romantycznej komedii HOLIDAY. Ju=BF na DVD!
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fholiday2.h=
tml&sid=3D1120

--part4635de0974a55
Content-Type: text/x-patch; name="pm2fb-clock-corrections.diff"
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

--part4635de0974a55
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part4635de0974a55
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part4635de0974a55--

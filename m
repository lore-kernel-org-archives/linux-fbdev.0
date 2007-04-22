From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb - Permedia 2V memory clock setting
Date: Sun, 22 Apr 2007 07:37:06 +0200
Message-ID: <462af48280f5c@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part462af4828366f"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HfUl5-0005vx-TW for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 21 Apr 2007 22:37:12 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HfUl4-0000o0-GC
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 21 Apr 2007 22:37:11 -0700
Received: from poczta-11.free.wp-sa.pl (HELO localhost) ([10.1.1.31])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	22 Apr 2007 07:37:06 +0200
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

--part462af4828366f
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Permedia 2V uses its own registers to set a memory clock. The
patch adds these registers and uses them in the set_memclock()
function.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

----------------------------------------------------
Konkurs - Szukaj konkret=F3w i wygrywaj nagrody!
Czekaj=B1 na Ciebie telewizory, odtwarzacze DVD, p=B3yty, ksi=B1=BFki i i=
nne!
Zobacz: http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fszukaj.wp.pl%2Fkonkurs%2F&s=
id=3D1102

--part462af4828366f
Content-Type: application/octet-stream; name="pm2fb-p2v_memclk.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pm2fb-p2v_memclk.diff"

ZGlmZiAtdXJwIGxpbnV4LTIuNi4yMS5vcmlnL2RyaXZlcnMvdmlkZW8vcG0yZmIuYyBsaW51eC0y
LjYuMjEvZHJpdmVycy92aWRlby9wbTJmYi5jCi0tLSBsaW51eC0yLjYuMjEub3JpZy9kcml2ZXJz
L3ZpZGVvL3BtMmZiLmMJMjAwNy0wNC0yMSAyMTozNDozNC42NzI5MTc0MTIgKzAyMDAKKysrIGxp
bnV4LTIuNi4yMS9kcml2ZXJzL3ZpZGVvL3BtMmZiLmMJMjAwNy0wNC0yMSAyMTozOTo1NS4zODMx
OTM2NDkgKzAyMDAKQEAgLTQ2MiwyMSArNDY0LDQzIEBAIHN0YXRpYyB2b2lkIHNldF9tZW1jbG9j
ayhzdHJ1Y3QgcG0yZmJfcGEKIAlpbnQgaTsKIAl1bnNpZ25lZCBjaGFyIG0sIG4sIHA7CiAKLQlw
bTJfbW5wKGNsaywgJm0sICZuLCAmcCk7Ci0JV0FJVF9GSUZPKHBhciwgMTApOwotCXBtMl9SREFD
X1dSKHBhciwgUE0ySV9SRF9NRU1PUllfQ0xPQ0tfMywgNik7Ci0Jd21iKCk7Ci0JcG0yX1JEQUNf
V1IocGFyLCBQTTJJX1JEX01FTU9SWV9DTE9DS18xLCBtKTsKLQlwbTJfUkRBQ19XUihwYXIsIFBN
MklfUkRfTUVNT1JZX0NMT0NLXzIsIG4pOwotCXdtYigpOwotCXBtMl9SREFDX1dSKHBhciwgUE0y
SV9SRF9NRU1PUllfQ0xPQ0tfMywgOHxwKTsKLQl3bWIoKTsKLQlwbTJfUkRBQ19SRChwYXIsIFBN
MklfUkRfTUVNT1JZX0NMT0NLX1NUQVRVUyk7Ci0Jcm1iKCk7Ci0JZm9yIChpID0gMjU2OwotCSAg
ICAgaSAmJiAhKHBtMl9SRChwYXIsIFBNMlJfUkRfSU5ERVhFRF9EQVRBKSAmIFBNMkZfUExMX0xP
Q0tFRCk7Ci0JICAgICBpLS0pCi0JCTsKKwlzd2l0Y2ggKHBhci0+dHlwZSkgeworCWNhc2UgUE0y
X1RZUEVfUEVSTUVESUEyVjoKKwkJcG0ydl9tbnAoY2xrLzIsICZtLCAmbiwgJnApOworCQlXQUlU
X0ZJRk8ocGFyLCA4KTsKKwkJcG0yX1dSKHBhciwgUE0yVlJfUkRfSU5ERVhfSElHSCwgUE0yVklf
UkRfTUNMS19DT05UUk9MID4+IDgpOworCQlwbTJ2X1JEQUNfV1IocGFyLCBQTTJWSV9SRF9NQ0xL
X0NPTlRST0wsIDApOworCQl3bWIoKTsKKwkJcG0ydl9SREFDX1dSKHBhciwgUE0yVklfUkRfTUNM
S19QUkVTQ0FMRSwgbSk7CisJCXBtMnZfUkRBQ19XUihwYXIsIFBNMlZJX1JEX01DTEtfRkVFREJB
Q0ssIG4pOworCQlwbTJ2X1JEQUNfV1IocGFyLCBQTTJWSV9SRF9NQ0xLX1BPU1RTQ0FMRSwgcCk7
CisJCXdtYigpOworCQlwbTJ2X1JEQUNfV1IocGFyLCBQTTJWSV9SRF9NQ0xLX0NPTlRST0wsIDEp
OworCQlybWIoKTsKKwkJZm9yIChpID0gMjU2OworCQkgICAgIGkgJiYgIShwbTJfUkRBQ19SRChw
YXIsIFBNMlZJX1JEX01DTEtfQ09OVFJPTCkgJiAyKTsKKwkJICAgICBpLS0pCisJCQk7CisJCXBt
Ml9XUihwYXIsIFBNMlZSX1JEX0lOREVYX0hJR0gsIDApOworCQlicmVhazsKKwljYXNlIFBNMl9U
WVBFX1BFUk1FRElBMjoKKwkJcG0yX21ucChjbGssICZtLCAmbiwgJnApOworCQlXQUlUX0ZJRk8o
cGFyLCAxMCk7CisJCXBtMl9SREFDX1dSKHBhciwgUE0ySV9SRF9NRU1PUllfQ0xPQ0tfMywgNik7
CisJCXdtYigpOworCQlwbTJfUkRBQ19XUihwYXIsIFBNMklfUkRfTUVNT1JZX0NMT0NLXzEsIG0p
OworCQlwbTJfUkRBQ19XUihwYXIsIFBNMklfUkRfTUVNT1JZX0NMT0NLXzIsIG4pOworCQl3bWIo
KTsKKwkJcG0yX1JEQUNfV1IocGFyLCBQTTJJX1JEX01FTU9SWV9DTE9DS18zLCA4fHApOworCQl3
bWIoKTsKKwkJcG0yX1JEQUNfUkQocGFyLCBQTTJJX1JEX01FTU9SWV9DTE9DS19TVEFUVVMpOwor
CQlybWIoKTsKKwkJZm9yIChpID0gMjU2OworCQkgICAgIGkgJiYgIShwbTJfUkQocGFyLCBQTTJS
X1JEX0lOREVYRURfREFUQSkgJiBQTTJGX1BMTF9MT0NLRUQpOworCQkgICAgIGktLSkKKwkJCTsK
KwkJYnJlYWs7CisJfQogfQogCiBzdGF0aWMgdm9pZCBzZXRfcGl4Y2xvY2soc3RydWN0IHBtMmZi
X3BhciogcGFyLCB1MzIgY2xrKQpkaWZmIC11cnAgbGludXgtMi42LjIxLm9yaWcvaW5jbHVkZS92
aWRlby9wZXJtZWRpYTIuaCBsaW51eC0yLjYuMjEvaW5jbHVkZS92aWRlby9wZXJtZWRpYTIuaAot
LS0gbGludXgtMi42LjIxLm9yaWcvaW5jbHVkZS92aWRlby9wZXJtZWRpYTIuaAkyMDA3LTA0LTA2
IDA0OjM2OjU2LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIxL2luY2x1ZGUvdmlkZW8v
cGVybWVkaWEyLmgJMjAwNy0wNC0xNyAwMDo0MjowNy45MzE5OTk2MTYgKzAyMDAKQEAgLTE1NCw2
ICsxNTQsMTAgQEAKICNkZWZpbmUgUE0yVklfUkRfQ0xLMV9QUkVTQ0FMRQkJCQkweDIwNAogI2Rl
ZmluZSBQTTJWSV9SRF9DTEsxX0ZFRURCQUNLCQkJCTB4MjA1CiAjZGVmaW5lIFBNMlZJX1JEX0NM
SzFfUE9TVFNDQUxFCQkJCTB4MjA2CisjZGVmaW5lIFBNMlZJX1JEX01DTEtfQ09OVFJPTAkJCQkw
eDIwRAorI2RlZmluZSBQTTJWSV9SRF9NQ0xLX1BSRVNDQUxFCQkJCTB4MjBFCisjZGVmaW5lIFBN
MlZJX1JEX01DTEtfRkVFREJBQ0sJCQkJMHgyMEYKKyNkZWZpbmUgUE0yVklfUkRfTUNMS19QT1NU
U0NBTEUJCQkJMHgyMTAKICNkZWZpbmUgUE0yVklfUkRfQ1VSU09SX1BBTEVUVEUJCQkJMHgzMDMK
ICNkZWZpbmUgUE0yVklfUkRfQ1VSU09SX1BBVFRFUk4JCQkJMHg0MDAKIAo=

--part462af4828366f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part462af4828366f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part462af4828366f--

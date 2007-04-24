From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [REPOST][PATCH] pm2fb: pixclock setting
	restriction
Date: Tue, 24 Apr 2007 09:25:12 +0200
Message-ID: <462db0d890110@wp.pl>
References: <462cf49998412@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part462db0d89284e"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgFOn-0006GT-BP for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Apr 2007 00:25:36 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HgFOl-0005kr-G1
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Apr 2007 00:25:16 -0700
Received: from poczta-17.free.wp-sa.pl (HELO localhost) ([10.1.1.76])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	24 Apr 2007 09:25:12 +0200
In-reply-to: <462cf49998412@wp.pl>
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

--part462db0d89284e
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds restrictions to calculations of m, n and p factors
which sets the pixclock for the Permedia 2V. I found during tests
that synchronization is unstable if m (divisor) is bigger than
half of the n (numerator). The patch disallows such settings
combination.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
=20
---
This patch has fixed range overflow with m > 127 comparing to
previous one.

Regards,
Krzysztof

----------------------------------------------------
Skorzystaj ze staro=BFytnej chi=F1skiej m=B1dro=B6ci. Tw=F3j horoskop wio=
senny
- http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fchinski.=
html&sid=3D1112

--part462db0d89284e
Content-Type: text/x-patch; name="pm2fb-p2v-pixclock-calc.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pm2fb-p2v-pixclock-calc.diff"

LS0tIGxpbnV4LTIuNi4yMS5vcmlnL2RyaXZlcnMvdmlkZW8vcG0yZmIuYwkyMDA3LTA0LTIxIDIx
OjM0OjM0LjY3MjkxNzQxMiArMDIwMAorKysgbGludXgtMi42LjIxL2RyaXZlcnMvdmlkZW8vcG0y
ZmIuYwkyMDA3LTA0LTIyIDE5OjQyOjI5LjcxNTIxNDI2NSArMDIwMApAQCAtMzAyLDEwICszMDMs
MTAgQEAgc3RhdGljIHZvaWQgcG0ydl9tbnAodTMyIGNsaywgdW5zaWduZWQgYwogCXMzMiBkZWx0
YSA9IDEwMDA7CiAKIAkqbW0gPSAqbm4gPSAqcHAgPSAwOwotCWZvciAobiA9IDE7IG47IG4rKykg
ewotCQlmb3IgKCBtID0gMTsgbTsgbSsrKSB7CisJZm9yICggbSA9IDE7IG0gPCAxMjg7IG0rKykg
eworCQlmb3IgKG4gPSAyICogbSArIDE7IG47IG4rKykgewogCQkJZm9yICggcCA9IDA7IHAgPCAy
OyBwKyspIHsKLQkJCQlmID0gUE0yX1JFRkVSRU5DRV9DTE9DSyAqIG4gLyAobSAqICgxIDw8IChw
ICsgMSkpKTsKKwkJCQlmID0gKCBQTTJfUkVGRVJFTkNFX0NMT0NLID4+ICggcCArIDEgKSkgKiBu
IC8gbTsKIAkJCQlpZiAoIGNsayA+IGYgLSBkZWx0YSAmJiBjbGsgPCBmICsgZGVsdGEgKSB7CiAJ
CQkJCWRlbHRhID0gKCBjbGsgPiBmICkgPyBjbGsgLSBmIDogZiAtIGNsazsKIAkJCQkJKm1tPW07
Cg==

--part462db0d89284e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part462db0d89284e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part462db0d89284e--

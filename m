From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb: pixclock setting restriction
Date: Mon, 23 Apr 2007 20:02:01 +0200
Message-ID: <462cf49998412@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part462cf4999ab02"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hg2rY-0001yr-In for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Apr 2007 11:02:08 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hg2rW-0005BV-16
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Apr 2007 11:02:08 -0700
Received: from poczta-7.free.wp-sa.pl (HELO localhost) ([10.1.1.16])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	23 Apr 2007 20:02:01 +0200
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

--part462cf4999ab02
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch add restrictions to calculations of m, n and p factors
which sets the pixclock for the Permedia 2V. I found during tests
that synchronization is unstable if m (divisor) is bigger than
half of the n (numerator). The patch dissallows such settings
combination.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---



----------------------------------------------------
Ju=BF nied=B3ugo pierwsza komunia! Zr=F3b naprawd=EA niezapomniany prezen=
t:
Pi=EAknie wydany i zilustrowany album do uzupe=B3nienia przez dziecko
b=EAdzie na ca=B3e =BFycie kronik=B1 Pierwszej Komunii =A6wi=EAtej - Zoba=
cz:
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fksiazka.eu%2F%3Fpg%3Dseria%26idseri=
a%3D19%26ref%3Dwppl&sid=3D1113

--part462cf4999ab02
Content-Type: application/octet-stream; name="pm2fb-p2v-pixclock-calc.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pm2fb-p2v-pixclock-calc.diff"

LS0tIGxpbnV4LTIuNi4yMS5vcmlnL2RyaXZlcnMvdmlkZW8vcG0yZmIuYwkyMDA3LTA0LTIxIDIx
OjM0OjM0LjY3MjkxNzQxMiArMDIwMAorKysgbGludXgtMi42LjIxL2RyaXZlcnMvdmlkZW8vcG0y
ZmIuYwkyMDA3LTA0LTIyIDE5OjQyOjI5LjcxNTIxNDI2NSArMDIwMApAQCAtMzAyLDEwICszMDMs
MTAgQEAgc3RhdGljIHZvaWQgcG0ydl9tbnAodTMyIGNsaywgdW5zaWduZWQgYwogCXMzMiBkZWx0
YSA9IDEwMDA7CiAKIAkqbW0gPSAqbm4gPSAqcHAgPSAwOwotCWZvciAobiA9IDE7IG47IG4rKykg
ewotCQlmb3IgKCBtID0gMTsgbTsgbSsrKSB7CisJZm9yICggbSA9IDE7IG07IG0rKykgeworCQlm
b3IgKG4gPSAyICogbSArIDE7IG47IG4rKykgewogCQkJZm9yICggcCA9IDA7IHAgPCAyOyBwKysp
IHsKLQkJCQlmID0gUE0yX1JFRkVSRU5DRV9DTE9DSyAqIG4gLyAobSAqICgxIDw8IChwICsgMSkp
KTsKKwkJCQlmID0gKCBQTTJfUkVGRVJFTkNFX0NMT0NLID4+ICggcCArIDEgKSkgKiBuIC8gbTsK
IAkJCQlpZiAoIGNsayA+IGYgLSBkZWx0YSAmJiBjbGsgPCBmICsgZGVsdGEgKSB7CiAJCQkJCWRl
bHRhID0gKCBjbGsgPiBmICkgPyBjbGsgLSBmIDogZiAtIGNsazsKIAkJCQkJKm1tPW07Cg==

--part462cf4999ab02
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part462cf4999ab02
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part462cf4999ab02--

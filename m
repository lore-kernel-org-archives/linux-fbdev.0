From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [PATCH] Fix typo in Documentation/fb/vesafb.txt.
Date: Sun, 26 Apr 2009 12:06:34 +0200
Message-ID: <1240740394.6022.3.camel@mattotaupa.wohnung.familie-menzel.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0698248721857233026=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1Ly1G3-0003XK-Qx for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Apr 2009 10:06:47 +0000
Received: from b186.blue.fastwebserver.de ([62.141.42.186] helo=mail.gw90.de)
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ly1G2-0004wu-As
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Apr 2009 10:06:47 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@goldbach.in-berlin.de>, Andrew Morton <akpm@linux-foundation.org>, Nico Schmoigl <schmoigl@rumms.uni-mannheim.de>


--===============0698248721857233026==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-rJPXtmwCrdz1Lfpk0JcN"


--=-rJPXtmwCrdz1Lfpk0JcN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
CC: Gerd Knorr <kraxel@goldbach.in-berlin.de>
CC: Nico Schmoigl <schmoigl@rumms.uni-mannheim.de>
---
 Documentation/fb/vesafb.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/fb/vesafb.txt b/Documentation/fb/vesafb.txt
index ee277dd..950d5a6 100644
--- a/Documentation/fb/vesafb.txt
+++ b/Documentation/fb/vesafb.txt
@@ -95,7 +95,7 @@ There is no way to change the vesafb video mode and/or ti=
mings after
 booting linux.  If you are not happy with the 60 Hz refresh rate, you
 have these options:
=20
- * configure and load the DOS-Tools for your the graphics board (if
+ * configure and load the DOS-Tools for the graphics board (if
    available) and boot linux with loadlin.
  * use a native driver (matroxfb/atyfb) instead if vesafb.  If none
    is available, write a new one!
--=20
1.6.2.4

--=-rJPXtmwCrdz1Lfpk0JcN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkn0MiEACgkQPX1aK2wOHVh7AwCfTs4cDDTZ51fz7lT7OL8D5uii
ZTgAoINnImklKv5OifUrUI7uLM6eC8UL
=4EZL
-----END PGP SIGNATURE-----

--=-rJPXtmwCrdz1Lfpk0JcN--



--===============0698248721857233026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports &#45; New Free Runtime and 30 Day Trial
Check out the new simplified licensign option that enables unlimited
royalty&#45;free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--===============0698248721857233026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0698248721857233026==--

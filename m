From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [PATCH] Fix typo.
Date: Fri, 13 Mar 2009 23:26:11 +0100
Message-ID: <1236983171.4376.3.camel@mattotaupa.wohnung.familie-menzel.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7429192767431679759=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1LiFpp-0003K5-QD for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Mar 2009 22:26:33 +0000
Received: from b186.blue.fastwebserver.de ([62.141.42.186] helo=mail.gw90.de)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LiFpb-0001ft-IW
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Mar 2009 22:26:28 +0000
Received: from f053037133.adsl.alicedsl.de ([78.53.37.133]
	helo=[192.168.178.20])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1LiFpZ-0003Xy-Pd for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Mar 2009 22:26:17 +0000
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


--===============7429192767431679759==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-vM1PRc5bbLrfaN2uuN8x"


--=-vM1PRc5bbLrfaN2uuN8x
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
---
 drivers/video/aty/radeon_base.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_bas=
e.c
index 8db675c..e33a1ea 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -701,8 +701,8 @@ static void __devinit radeon_get_pllinfo(struct radeonf=
b_info *rinfo)
 found:
 	/*
 	 * Some methods fail to retrieve SCLK and MCLK values, we apply default
-	 * settings in this case (200Mhz). If that really happne often, we could
-	 * fetch from registers instead...
+	 * settings in this case (200Mhz). If that really happens often, we
+	 * could fetch from registers instead...
 	 */
 	if (rinfo->pll.mclk =3D=3D 0)
 		rinfo->pll.mclk =3D 20000;
--=20
1.6.2

--=-vM1PRc5bbLrfaN2uuN8x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkm63YMACgkQPX1aK2wOHVimVQCeINjgao1xN7uUTjIknrEc0VeM
xYAAnRLGCJFKFtSv1dNKvbWnrMZrhCxX
=Ul37
-----END PGP SIGNATURE-----

--=-vM1PRc5bbLrfaN2uuN8x--



--===============7429192767431679759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
--===============7429192767431679759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============7429192767431679759==--

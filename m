From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [PATCH] Add video modes for resolutions and
	timings of PAL RGB.
Date: Sat, 25 Apr 2009 11:08:31 +0200
Message-ID: <1240650511.6916.19.camel@mattotaupa.wohnung.familie-menzel.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7185168911065146721=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1LxdsO-0000r4-Cx for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 25 Apr 2009 09:08:48 +0000
Received: from b186.blue.fastwebserver.de ([62.141.42.186] helo=mail.gw90.de)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LxdsM-0007Nd-VN
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 25 Apr 2009 09:08:48 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Thomas Hilber <sparkie@lowbyte.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org


--===============7185168911065146721==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-qwQDfBj1zwCeMAdIbEY2"


--=-qwQDfBj1zwCeMAdIbEY2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch was taken from vga-sync-field version 0.0.3 [1][2].

[1] http://lowbyte.de/vga-sync-fields/vga-sync-fields-0.0.3.tgz
[2] http://git.hellersdorfer-jugendchor.de/?p=3Dvga2scart.git;a=3Dcommit;h=
=3Dc5c8ed6c51fc9879dbf38d8b91d5db6f4300ea03

Signed-off-by: Thomas Hilber <sparkie@lowbyte.de>
Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
---
 drivers/video/modedb.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 1618624..6175882 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -264,6 +264,14 @@ static const struct fb_videomode modedb[] =3D {
 	/* 1280x800, 60 Hz, 47.403 kHz hsync, WXGA 16:10 aspect ratio */
 	NULL, 60, 1280, 800, 12048, 200, 64, 24, 1, 136, 3,
 	0, FB_VMODE_NONINTERLACED
+    }, {
+       /* 720x576i @ 50 Hz, 15.625 kHz hsync (PAL RGB) */
+       NULL, 50, 720, 576, 74074, 64, 16, 39, 5, 64, 5,=20
+       0, FB_VMODE_INTERLACED
+    }, {
+       /* 800x520i @ 50 Hz, 15.625 kHz hsync (PAL RGB) */
+       NULL, 50, 800, 520, 58823, 144, 64, 72, 28, 80, 5,=20
+       0, FB_VMODE_INTERLACED
     },
 };
=20
--=20
1.6.2.4

--=-qwQDfBj1zwCeMAdIbEY2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkny0w8ACgkQPX1aK2wOHVgaFgCdGm5pXwntnBK4Q/jI9KoVckCG
iXAAn1UV2v3apy0mcosekRWBspzud2+3
=JHit
-----END PGP SIGNATURE-----

--=-qwQDfBj1zwCeMAdIbEY2--



--===============7185168911065146721==
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
--===============7185168911065146721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============7185168911065146721==--

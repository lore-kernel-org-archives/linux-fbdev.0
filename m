From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [PATCH] Fix a bug in intelfb initialization.
Date: Sat, 02 May 2009 19:32:19 +0200
Message-ID: <1241285539.20882.0.camel@mattotaupa.wohnung.familie-menzel.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5565114492587045279=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1M0J4k-0004zT-Pl for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 May 2009 17:32:34 +0000
Received: from b186.blue.fastwebserver.de ([62.141.42.186] helo=mail.gw90.de)
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M0J4e-0003Tu-0y
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 May 2009 17:32:29 +0000
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
Cc: Dave Airlie <airlied@gmail.com>


--===============5565114492587045279==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-G4/8TBmhZ+1ginPuVasV"


--=-G4/8TBmhZ+1ginPuVasV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

When changing video timing dynamically via fbset the screen sporadically
is rendered black.

With the attached fix which disables VCO prior to timing register
change the problem disappears.

I had a look at the Xserver register setup code. Here the VCO is
disabled in the same way [1].

This patch is taken from vga-sync-field version 0.0.11 [2][3].

[1] http://cgit.freedesktop.org/xorg/driver/xf86-video-intel/tree/src/i830_=
driver.c
[2] http://lowbyte.de/vga-sync-fields/vga-sync-fields-0.0.11.tgz
[3] http://git.hellersdorfer-jugendchor.de/?p=3Dvga2scart.git;a=3Dcommitdif=
f;h=3Ddcc3b863e5a663652587619c357bd20075af6896

Signed-off-by: Thomas Hilber <sparkie@lowbyte.de>
Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
CC: Dave Airlie <airlied@gmail.com>
---
 drivers/video/intelfb/intelfbdrv.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/int=
elfbdrv.c
index 6d8e541..7ba8db5 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -1364,6 +1364,11 @@ static int intelfb_set_par(struct fb_info *info)
 	DBG_MSG("intelfb_set_par (%dx%d-%d)\n", info->var.xres,
 		info->var.yres, info->var.bits_per_pixel);
=20
+	/*
+	 * Disable VCO prior to timing register change.
+	 */
+	OUTREG(DPLL_A, INREG(DPLL_A) & ~DPLL_VCO_ENABLE);
+
 	intelfb_blank(FB_BLANK_POWERDOWN, info);
=20
 	if (ACCEL(dinfo, info))
--=20
1.6.2.4

--=-G4/8TBmhZ+1ginPuVasV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkn8g5wACgkQPX1aK2wOHVhoRACdFB20QBjtBToghaRtXoVLxTNh
fncAniylFVXZ6L9UWNjwqiNksPFYfIod
=rvKL
-----END PGP SIGNATURE-----

--=-G4/8TBmhZ+1ginPuVasV--



--===============5565114492587045279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
--===============5565114492587045279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============5565114492587045279==--

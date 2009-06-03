From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [RESEND] [PATCH] Fix a bug in intelfb
 initialization.
Date: Wed, 03 Jun 2009 14:35:55 +0000
Message-ID: <1244039755.5947.91.camel@mattotaupa.wohnung.familie-menzel.net>
References: <1241285539.20882.0.camel@mattotaupa.wohnung.familie-menzel.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1027430756295702761=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1MBrZc-0005eK-3e for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Jun 2009 14:36:12 +0000
Received: from b186.blue.fastwebserver.de ([62.141.42.186] helo=mail.gw90.de)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MBrZV-0006Fe-7P
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Jun 2009 14:36:07 +0000
In-Reply-To: <1241285539.20882.0.camel@mattotaupa.wohnung.familie-menzel.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: sylvain.meyer@worldonline.fr
Cc: Andrew Morton <akpm@linux-foundation.org>, samanddeanus@yahoo.com, linux-fbdev-devel@lists.sourceforge.net, Michal Suchanek <hramrach@centrum.cz>


--===============1027430756295702761==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-2l2ub/DcQK7C6EDIoYP5"


--=-2l2ub/DcQK7C6EDIoYP5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Dear hackers,


I sent this message already some time ago but probably not to the
correct people. (Now I took the one from MAINTAINERS and the ones from
this message [1].)


Bests,

Paul


[1] http://marc.info/?l=3Dlinux-fbdev-devel&m=3D124388452327831&w=3D2

--
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
[3] http://easy-vdr.de/git?p=3Dfrc.git/.git;a=3Dcommit;h=3Ddcc3b863e5a66365=
2587619c357bd20075af6896

Signed-off-by: Thomas Hilber <sparkie@lowbyte.de>
Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
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

--=-2l2ub/DcQK7C6EDIoYP5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkomiksACgkQPX1aK2wOHVh36ACfWtwKvnBHTpgS6ILKntHy/IuA
HFIAnjLp5DZZBKjQmXgzzoEBnRGM5KH4
=HcMq
-----END PGP SIGNATURE-----

--=-2l2ub/DcQK7C6EDIoYP5--



--===============1027430756295702761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
--===============1027430756295702761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1027430756295702761==--

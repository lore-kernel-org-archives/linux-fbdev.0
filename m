From: Thomas Jahns <Thomas.Jahns@gmx.net>
Subject: Re: Re: [patch 1/1] delete unused file
Date: Thu, 28 Apr 2005 19:15:50 +0000
Message-ID: <1114715755l.8158l.0l@mercury>
References: <20041226151328.47F751ECC0@trashy.coderock.org>
	<200501100515.52513.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-yhNN5YOpP+M41NR5PhkQ"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRFsd-00028I-Nq
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Apr 2005 13:45:03 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DRFsa-00052g-O4
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Apr 2005 13:45:03 -0700
Received: from mercury (tjahns@localhost [127.0.0.1])
	by mercury.jahnsnet.de (8.13.4/8.13.4/Debian-1) with ESMTP id j3SJFtba015805
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Apr 2005 21:15:55 +0200
In-Reply-To: <200501100515.52513.adaplas@hotpop.com> (from
	adaplas@hotpop.com on Sun Jan  9 22:15:50 2005)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

--=-yhNN5YOpP+M41NR5PhkQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On 01/09/05 22:15:50, Antonino A. Daplas wrote:
> On Sunday 26 December 2004 23:13, domen@coderock.org wrote:
> > Remove nowhere referenced file. (egrep "filename\." didn't find
> > anything)
>=20
> This file is now being used for BIOS-less booting of Rage XL cards in
> 2.6.10-mm1.

I had this file accidentally selected when building a 2.6.11.6 kernel=20
from debians kernel-source-2.6.11, 2.6.11-3 version package for my=20
PowerMac G3, all of:

FB_ATY
FB_ATY_CT
FB_ATY_XL_INIT
FB_ATY_GX

but not

FB_ATY_GENERIC_LCD

where selected, accordingly the build failed because of a missing=20
symbol: aty_st_lcd
aty_st_lcd is called in line 256 of xlinit.c but perhaps should be=20
surrounded by an ifdef like its declaration in atyfb.h and definition=20
in atyfb_base.c:

#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined
(CONFIG_FB_ATY_GENERIC_LCD)
extern void aty_st_lcd(int index, u32 val, const struct atyfb_par *par);
extern u32 aty_ld_lcd(int index, const struct atyfb_par *par);
#endif

This is just a report of a problem I faced because I had FB_ATY_XL_INIT
activated, although I don't really need it. Therefore I'm currently
using a kernel built without FB_ATY_XL_INIT defined (the kernel thus
produced does work on my system, I guess therefore, that the problem
described by Mikael Pettersson does only affect the first generation
beige PowerMac G3 (my system is of 2nd revision).

OTOH: This kernel does, with the exact same arguments to the kernel,
boot with another video timing than the 2.6.9 kernel I used until now.
This is an improvement because the old kernel selected the mode
1024x768-24@60 while 1024x768-24@75 was requested. The 2.6.11 kernel
doesn't select a perfect match either (it's using 1024x768-24@76).

Thomas Jahns
--=20
"Computers are good at following instructions,
 but not at reading your mind."
D. E. Knuth, The TeXbook, Addison-Wesley 1984, 1986, 1996, p. 9


--=-yhNN5YOpP+M41NR5PhkQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCcTZroKHaAfEZMbkRAqU3AJ9CH4ikU3T+S29l4r0qw9rtyjKI4gCfcqU+
7gwpHI8Tvds6cM+H5uYv6Es=
=1ULh
-----END PGP SIGNATURE-----

--=-yhNN5YOpP+M41NR5PhkQ--



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix

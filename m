From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: Seg fault on any FB write (Epson
 S1D13A04onColdfire running 2.6.25)
Date: Tue, 11 Nov 2008 20:14:06 +0100
Message-ID: <20081111201406.7c1babfb.kristoffer.ericson@gmail.com>
References: <4918E5C3.2090108@one.net> <49195726.2060103@cetrtapot.si>
	<43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net>
	<49199EE3.5090101@cetrtapot.si>
	<20081111195208.e2da189f.kristoffer.ericson@gmail.com>
	<47826.137.237.242.138.1226426531.squirrel@webmail.nuvox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9126205201818381006=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1Kzxke-00077H-M5
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 18:14:08 +0000
Received: from nf-out-0910.google.com ([64.233.182.190])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kzxka-0001D7-0r for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 18:14:08 +0000
Received: by nf-out-0910.google.com with SMTP id g16so8390nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 11 Nov 2008 10:14:01 -0800 (PST)
In-Reply-To: <47826.137.237.242.138.1226426531.squirrel@webmail.nuvox.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: jkimble@one.net
Cc: linux-fbdev-devel@lists.sourceforge.net

--===============9126205201818381006==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__11_Nov_2008_20_14_06_+0100_YVBSbkH8gPTyTs2K"

--Signature=_Tue__11_Nov_2008_20_14_06_+0100_YVBSbkH8gPTyTs2K
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Nov 2008 13:02:11 -0500 (EST)
jkimble@one.net wrote:

>=20
> Sorry, I was hacking around just to get something to work. If you look at
> the two side by side you'll see that I've not changed that much. The
> changes are mostly just plugging in my specific info for the panel I'm
> using.
>=20
> I've not worked with patches much so I'll have to figure out how to do th=
at.

Perhaps you should include the old patch to 2.6.10 since
we know that worked and take it from there? In theory
all you should need are the basic mappings and
perhaps and reg init structure. =20

>=20
>=20
> > On Tue, 11 Nov 2008 16:04:03 +0100
> > Hinko Kocevar <hinko.kocevar@cetrtapot.si> wrote:
> >
> >> jkimble@one.net wrote:
> >> >> James Kimble wrote:
> >> >
> >> > /proc/iomem shows:
> >> >
> >> > 74000000-74009000 : s1d13a04fb.0
> >> > 74000000-74009000 : s1d13xxxfb regs
> >> > 74040000-74068000 : s1d13a04fb.0
> >> > 74040000-74068000 : s1d13xxxfb mem
> >>
> >> I'm not sure if this is correct - two drivers mapped the same region
> >> twice !?
> >> Maybe the experts will shed some light on this..
> >>
> >> > f000070c-f000070c : spi-int-mask
> >> > f0000740-f000075f : spi-int-level
> >> > f0000a50-f0000a50 : spi-par
> >> > f0008a00-f0008ab8 : spi-module
> >> > f0008f00-f0008f20 : MCF548X-i2c
> >> > f000a000-f000a7ff : mcf548x-flexcan.0
> >> > f000a000-f000a7ff : mcf548x-flexcan
> >> > f000a800-f000afff : mcf548x-flexcan.1
> >> > f000a800-f000afff : mcf548x-flexcan
> >> > f0020000-f0033000 : fsl-sec1
> >> > fc000000-ffffffff : physmap-flash.0
> >> >
> >>
> >> I haven't took a long look at your driver, but here is our driver for
> >> S13706FB that
> >> we use on our embedded platform. Hope it helps.
> >
> > Any chance of getting a patch against s1d13xxxfb?
> >
> >>
> >> Regards,
> >> Hinko
> >> --
> >> Hinko Ko=C4=8Devar, OSS developer
> >> =C4=8CETRTA POT, d.o.o.
> >> Planina 3, 4000 Kranj, SI EU
> >> tel     ++386 (0) 4 280 66 03
> >> e-mail  hinko.kocevar@cetrtapot.si
> >> http    www.cetrtapot.si
> >>
> >>
> >> ----------------------------------------------------------------------=
---
> >> This SF.Net email is sponsored by the Moblin Your Move Developer's
> >> challenge
> >> Build the coolest Linux based applications with Moblin SDK & win great
> >> prizes
> >> Grand prize is a trip for two to an Open Source event anywhere in the
> >> world
> >> http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
> >> _______________________________________________
> >> Linux-fbdev-devel mailing list
> >> Linux-fbdev-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> >
> >
> > --
> > Kristoffer Ericson <kristoffer.ericson@gmail.com>
> >
>=20
>=20


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Tue__11_Nov_2008_20_14_06_+0100_YVBSbkH8gPTyTs2K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkZ2X4ACgkQPQls10ERAGeejwCcCudwuauerKV38YUm2BYS0fMs
jk8AoJxODeES0c5OAVTQB+XayOReHd8M
=NOin
-----END PGP SIGNATURE-----

--Signature=_Tue__11_Nov_2008_20_14_06_+0100_YVBSbkH8gPTyTs2K--


--===============9126205201818381006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============9126205201818381006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============9126205201818381006==--

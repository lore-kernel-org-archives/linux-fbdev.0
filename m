From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: Seg fault on any FB write (Epson S1D13A04on
 Coldfire running 2.6.25)
Date: Tue, 11 Nov 2008 19:52:08 +0100
Message-ID: <20081111195208.e2da189f.kristoffer.ericson@gmail.com>
References: <4918E5C3.2090108@one.net> <49195726.2060103@cetrtapot.si>
	<43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net>
	<49199EE3.5090101@cetrtapot.si>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7848290998067566484=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1KzxP4-0003xi-Pm
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 17:51:50 +0000
Received: from ug-out-1314.google.com ([66.249.92.172])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KzxOv-00042x-Go for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 17:51:50 +0000
Received: by ug-out-1314.google.com with SMTP id 36so966065uga.17
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 11 Nov 2008 09:51:39 -0800 (PST)
In-Reply-To: <49199EE3.5090101@cetrtapot.si>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Cc: linux-fbdev-devel@lists.sourceforge.net

--===============7848290998067566484==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__11_Nov_2008_19_52_08_+0100_abk8YJLR4AZbaiKk"

--Signature=_Tue__11_Nov_2008_19_52_08_+0100_abk8YJLR4AZbaiKk
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Nov 2008 16:04:03 +0100
Hinko Kocevar <hinko.kocevar@cetrtapot.si> wrote:

> jkimble@one.net wrote:
> >> James Kimble wrote:
> >=20
> > /proc/iomem shows:
> >=20
> > 74000000-74009000 : s1d13a04fb.0
> > 74000000-74009000 : s1d13xxxfb regs
> > 74040000-74068000 : s1d13a04fb.0
> > 74040000-74068000 : s1d13xxxfb mem
>=20
> I'm not sure if this is correct - two drivers mapped the same region twic=
e !?
> Maybe the experts will shed some light on this..
>=20
> > f000070c-f000070c : spi-int-mask
> > f0000740-f000075f : spi-int-level
> > f0000a50-f0000a50 : spi-par
> > f0008a00-f0008ab8 : spi-module
> > f0008f00-f0008f20 : MCF548X-i2c
> > f000a000-f000a7ff : mcf548x-flexcan.0
> > f000a000-f000a7ff : mcf548x-flexcan
> > f000a800-f000afff : mcf548x-flexcan.1
> > f000a800-f000afff : mcf548x-flexcan
> > f0020000-f0033000 : fsl-sec1
> > fc000000-ffffffff : physmap-flash.0
> >=20
>=20
> I haven't took a long look at your driver, but here is our driver for S13=
706FB that
> we use on our embedded platform. Hope it helps.

Any chance of getting a patch against s1d13xxxfb?

>=20
> Regards,
> Hinko
> --=20
> Hinko Ko=C4=8Devar, OSS developer
> =C4=8CETRTA POT, d.o.o.
> Planina 3, 4000 Kranj, SI EU
> tel     ++386 (0) 4 280 66 03
> e-mail  hinko.kocevar@cetrtapot.si
> http    www.cetrtapot.si
>=20
>=20
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challe=
nge
> Build the coolest Linux based applications with Moblin SDK & win great pr=
izes
> Grand prize is a trip for two to an Open Source event anywhere in the wor=
ld
> http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Tue__11_Nov_2008_19_52_08_+0100_abk8YJLR4AZbaiKk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkZ1FgACgkQPQls10ERAGcVkQCcCJZheoNQTMBjm54r7dYtfkPE
8oIAn2pJp3q5qvU5Sh1jUU5C6nKvHYry
=+SPF
-----END PGP SIGNATURE-----

--Signature=_Tue__11_Nov_2008_19_52_08_+0100_abk8YJLR4AZbaiKk--


--===============7848290998067566484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============7848290998067566484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============7848290998067566484==--

From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: Seg fault on any FB write (Epson
 S1D13A04onColdfire running 2.6.25)
Date: Tue, 11 Nov 2008 20:29:44 +0100
Message-ID: <20081111202944.e6b137b0.kristoffer.ericson@gmail.com>
References: <4918E5C3.2090108@one.net> <49195726.2060103@cetrtapot.si>
	<43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net>
	<49199EE3.5090101@cetrtapot.si>
	<20081111195208.e2da189f.kristoffer.ericson@gmail.com>
	<47826.137.237.242.138.1226426531.squirrel@webmail.nuvox.net>
	<20081111201406.7c1babfb.kristoffer.ericson@gmail.com>
	<40797.137.237.242.138.1226427622.squirrel@webmail.nuvox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2917743012862389437=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1KzxzR-0001pq-6a
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 18:29:25 +0000
Received: from nf-out-0910.google.com ([64.233.182.188])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KzxzM-00085a-2u for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 18:29:25 +0000
Received: by nf-out-0910.google.com with SMTP id g16so11858nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 11 Nov 2008 10:29:18 -0800 (PST)
In-Reply-To: <40797.137.237.242.138.1226427622.squirrel@webmail.nuvox.net>
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

--===============2917743012862389437==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__11_Nov_2008_20_29_44_+0100_wia+vr7he/QLCmvW"

--Signature=_Tue__11_Nov_2008_20_29_44_+0100_wia+vr7he/QLCmvW
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Nov 2008 13:20:22 -0500 (EST)
jkimble@one.net wrote:

> The 2.6.10 driver is considerably different. There's no platform device
> structure. I tried taking the 2.6.10 forward to the 2.6.25 kernel but
> found so many differences I thought getting the 2.6.25 driver working
> would be easier.

I havent seen the 2.6.10 driver so you might be
right. Ive only recently taken over maintainership
so still working out the quirks.

>=20
> Again, I've never made a patch for it. I've attached the actual driver
> code here.
>=20

Roger, I'll take a look at it.

> Not to make excuses (but here I go) this is the first foray I've made into
> the kernel in any real way so I'm still figuring out the right way to do
> things (after I get them to work at all).
>=20

No worries. The best/easiest approach is to clone a copy
of linux-2.6.git (google for it). You then edit the file
in that directory and can generate diffs with 'git diff <filename>'.

> Thanks again.
>=20
>=20
> > On Tue, 11 Nov 2008 13:02:11 -0500 (EST)
> > jkimble@one.net wrote:
> >
> >>
> >> Sorry, I was hacking around just to get something to work. If you look
> >> at
> >> the two side by side you'll see that I've not changed that much. The
> >> changes are mostly just plugging in my specific info for the panel I'm
> >> using.
> >>
> >> I've not worked with patches much so I'll have to figure out how to do
> >> that.
> >
> > Perhaps you should include the old patch to 2.6.10 since
> > we know that worked and take it from there? In theory
> > all you should need are the basic mappings and
> > perhaps and reg init structure.
> >
> >>
> >>
> >> > On Tue, 11 Nov 2008 16:04:03 +0100
> >> > Hinko Kocevar <hinko.kocevar@cetrtapot.si> wrote:
> >> >
> >> >> jkimble@one.net wrote:
> >> >> >> James Kimble wrote:
> >> >> >
> >> >> > /proc/iomem shows:
> >> >> >
> >> >> > 74000000-74009000 : s1d13a04fb.0
> >> >> > 74000000-74009000 : s1d13xxxfb regs
> >> >> > 74040000-74068000 : s1d13a04fb.0
> >> >> > 74040000-74068000 : s1d13xxxfb mem
> >> >>
> >> >> I'm not sure if this is correct - two drivers mapped the same region
> >> >> twice !?
> >> >> Maybe the experts will shed some light on this..
> >> >>
> >> >> > f000070c-f000070c : spi-int-mask
> >> >> > f0000740-f000075f : spi-int-level
> >> >> > f0000a50-f0000a50 : spi-par
> >> >> > f0008a00-f0008ab8 : spi-module
> >> >> > f0008f00-f0008f20 : MCF548X-i2c
> >> >> > f000a000-f000a7ff : mcf548x-flexcan.0
> >> >> > f000a000-f000a7ff : mcf548x-flexcan
> >> >> > f000a800-f000afff : mcf548x-flexcan.1
> >> >> > f000a800-f000afff : mcf548x-flexcan
> >> >> > f0020000-f0033000 : fsl-sec1
> >> >> > fc000000-ffffffff : physmap-flash.0
> >> >> >
> >> >>
> >> >> I haven't took a long look at your driver, but here is our driver f=
or
> >> >> S13706FB that
> >> >> we use on our embedded platform. Hope it helps.
> >> >
> >> > Any chance of getting a patch against s1d13xxxfb?
> >> >
> >> >>
> >> >> Regards,
> >> >> Hinko
> >> >> --
> >> >> Hinko Ko=C4=8Devar, OSS developer
> >> >> =C4=8CETRTA POT, d.o.o.
> >> >> Planina 3, 4000 Kranj, SI EU
> >> >> tel     ++386 (0) 4 280 66 03
> >> >> e-mail  hinko.kocevar@cetrtapot.si
> >> >> http    www.cetrtapot.si
> >> >>
> >> >>
> >> >> -------------------------------------------------------------------=
------
> >> >> This SF.Net email is sponsored by the Moblin Your Move Developer's
> >> >> challenge
> >> >> Build the coolest Linux based applications with Moblin SDK & win
> >> great
> >> >> prizes
> >> >> Grand prize is a trip for two to an Open Source event anywhere in t=
he
> >> >> world
> >> >> http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
> >> >> _______________________________________________
> >> >> Linux-fbdev-devel mailing list
> >> >> Linux-fbdev-devel@lists.sourceforge.net
> >> >> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> >> >
> >> >
> >> > --
> >> > Kristoffer Ericson <kristoffer.ericson@gmail.com>
> >> >
> >>
> >>
> >
> >
> > --
> > Kristoffer Ericson <kristoffer.ericson@gmail.com>
> >
>=20


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Tue__11_Nov_2008_20_29_44_+0100_wia+vr7he/QLCmvW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkZ3SgACgkQPQls10ERAGcr7ACfakKN6WuPi2C7J3HdaQkGIEsL
7aAAoOCJN60RDpJlQFh31MsptknpuyVU
=BfT8
-----END PGP SIGNATURE-----

--Signature=_Tue__11_Nov_2008_20_29_44_+0100_wia+vr7he/QLCmvW--


--===============2917743012862389437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============2917743012862389437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============2917743012862389437==--

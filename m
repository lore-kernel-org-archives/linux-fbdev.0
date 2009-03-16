From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: Epson S1D13xxxfb.c on 2.6.25 kernel: wierd
 seg faults...
Date: Mon, 16 Mar 2009 12:54:38 +0100
Message-ID: <20090316125438.f81a3906.kristoffer.ericson@gmail.com>
References: <50026.137.237.242.42.1226355298.squirrel@webmail.nuvox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1280808460998996904=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1LjBOv-00079S-3J
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Mar 2009 11:54:37 +0000
Received: from mail-ew0-f168.google.com ([209.85.219.168])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LjBOm-0001g5-Pp for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Mar 2009 11:54:32 +0000
Received: by ewy12 with SMTP id 12so3610144ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 16 Mar 2009 04:54:26 -0700 (PDT)
In-Reply-To: <50026.137.237.242.42.1226355298.squirrel@webmail.nuvox.net>
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

--===============1280808460998996904==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__16_Mar_2009_12_54_38_+0100_y4=iDWmWW+CcCowK"

--Signature=_Mon__16_Mar_2009_12_54_38_+0100_y4=iDWmWW+CcCowK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Nov 2008 17:14:58 -0500 (EST)
jkimble@one.net wrote:

>=20
> Maybe this is a dumb question but bear with me. I'm running an Epson
> S1D13A04 video chip with a Coldfire processor (5484) running the latest
> kernel for this chip from Freescale (2.6.25). I had this device working
> with the older 2.6.10 kernel and I've been working to port the driver that
> came with the 2.6.25 kernel to work with this particular chip (it's a
> device "family" driver).
>=20
> Got things going fairly well, I thought, to the point that I even get a
> little Tux logo up when the driver loads. However when I go to use the
> frame buffer device, though I can open it and read the data from the info
> structure (size, bpp, etc..) any attempt to write the fb0 device causes a
> seg fault. I've been looking at this for hours and I cannot get why.
>=20
> I'm configuring the RAM in exactly the same way I was before (went from
> colilo to U-Boot). I'm mapping the CS associated with this device to the
> same memory space I was on the 2.6.10 kernel (0x4400 0000). I tried moving
> it and it made no difference. I don't get it... Is this a 2.6.25 thing I'm
> missing?
>=20
> Any help/suggestions GREATLY appreciated.
>=20

Just interested in any updates you might have one this. Did you get it reso=
lved?

/Kristoffer

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

--Signature=_Mon__16_Mar_2009_12_54_38_+0100_y4=iDWmWW+CcCowK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkm+Pf4ACgkQPQls10ERAGfUnACggJ7i8OQBD+xwZn6xeMCLZoJc
g/QAn2HovEWt8/MzmEZIivk60rJOOtFZ
=1zkZ
-----END PGP SIGNATURE-----

--Signature=_Mon__16_Mar_2009_12_54_38_+0100_y4=iDWmWW+CcCowK--


--===============1280808460998996904==
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
--===============1280808460998996904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1280808460998996904==--

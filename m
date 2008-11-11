From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: Seg fault on any FB write (Epson S1D13A04
 on Coldfire running 2.6.25)
Date: Tue, 11 Nov 2008 19:50:43 +0100
Message-ID: <20081111195043.2e24ad61.kristoffer.ericson@gmail.com>
References: <4918E5C3.2090108@one.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1371514456406285621=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1KzxNh-0008KI-K9
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 17:50:25 +0000
Received: from ey-out-1920.google.com ([74.125.78.147])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KzxNb-0002i5-Ka for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 17:50:25 +0000
Received: by ey-out-1920.google.com with SMTP id 4so2254eyk.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 11 Nov 2008 09:50:17 -0800 (PST)
In-Reply-To: <4918E5C3.2090108@one.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: James Kimble <jkimble@one.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

--===============1371514456406285621==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__11_Nov_2008_19_50_43_+0100_Fsi2IXLMT8GhR8Yo"

--Signature=_Tue__11_Nov_2008_19_50_43_+0100_Fsi2IXLMT8GhR8Yo
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Nov 2008 20:54:11 -0500
James Kimble <jkimble@one.net> wrote:

>=20
> I've been working on porting the s1d13xxxfb driver from the latest=20
> kernel from Freescale for Coldfire to work with the S1D13A04 chip. I was=
=20
> able to get things working to the point that I do get a little TUX logo=20
> up on the screen at boot up. Seemed like a good start but none of my=20
> user space applications will work. I can open the /dev/fb0 device and=20
> the data in the info structure is correct but if I try to write to any=20
> register or area in the frame buffer (or write to the device at all) I=20
> get a seg fault.

Please drop me a mail with patch attached and I'll look at it,
you must have hit something nasty.

>=20
> I had an earlier driver working with the 2.6.10 kernel with the same=20
> hardware. The same application space program should work ( I would=20
> think...) but I get the seg fault on the first write to fb0. I tried a=20
> different memory location (ox4400 0000 to 0x7400 0000) for the CS=20
> associated with the video  chip, no  difference. Permissions for=20
> /dev/fb0 are "rw". No other process using fb0. This is really weird.
>=20
> Any help or suggestions MUCH appreciated.
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

--Signature=_Tue__11_Nov_2008_19_50_43_+0100_Fsi2IXLMT8GhR8Yo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkZ1AMACgkQPQls10ERAGcadgCgimihE/B4Csu4hj1MwZ/qiKag
cm8An0IKbmgCUPYCfFO7U6Y4e1ewVGUS
=m0Qr
-----END PGP SIGNATURE-----

--Signature=_Tue__11_Nov_2008_19_50_43_+0100_Fsi2IXLMT8GhR8Yo--


--===============1371514456406285621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1371514456406285621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1371514456406285621==--

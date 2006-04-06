From: Ondrej Zajicek <santiago@mail.cz>
Subject: Re: Bug in vga16fb?
Date: Thu, 6 Apr 2006 16:39:01 +0200
Message-ID: <20060406143901.GA9683@localhost.localdomain>
References: <20060404204002.GB2251@localhost.localdomain> <44344950.9090703@vc.cvut.cz> <20060406073713.GA3051@localhost.localdomain> <44351E1A.8050404@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRVdk-0000uC-FB
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Apr 2006 07:39:16 -0700
Received: from smtp1.kolej.mff.cuni.cz ([195.113.24.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FRVde-0008Jo-SL
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Apr 2006 07:39:13 -0700
Received: from localhost.localdomain (feanorr.kolej.mff.cuni.cz [195.113.26.209])
	by smtp1.kolej.mff.cuni.cz (8.13.1/8.13.1) with ESMTP id k36Ed4t6060720
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 6 Apr 2006 16:39:05 +0200 (CEST)
	(envelope-from zajio1am@artax.karlin.mff.cuni.cz)
Received: from santiago by localhost.localdomain with local (Exim 4.50)
	id 1FRVdV-0002ZH-MD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Apr 2006 16:39:01 +0200
Content-Disposition: inline
In-Reply-To: <44351E1A.8050404@gmail.com>
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


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2006 at 09:56:42PM +0800, Antonino A. Daplas wrote:
> Ondrej Zajicek wrote:
> > On Thu, Apr 06, 2006 at 12:48:48AM +0200, Petr Vandrovec wrote:
> >> Ondrej Zajicek wrote:
> >=20
> > Even if we find some possibility to autodetect what hardware does (or in
> > case of another, non-VGA hardware using CFB4 mode) there would be
> > problem that driver cannot say it to userspace (or generic kernel
> > functions like cfb_imageblit). Maybe there should be some flag in
> > type_aux specifying whether given packed pixel mode is LSB-first or
> > MSB-first (relevant only for bpp % 8 !=3D 0) ?
> >=20
>=20
> var->{red|green|blue|transp}.msb_right

I think that this bit says something different - ordering of bits inside
one color component. This is OK for all VGA (MSB bit of color index is
left), i hope.

Problem is in ordering of pixels inside a byte, which is completely
orthogonal to bitplane.msb_right-ness.

But maybe i misunderstood of meaning of=20
var->{red|green|blue|transp}.msb_right ...


--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.ne=
tlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iEYEARECAAYFAkQ1KAUACgkQw1GB2RHercNeGgCeLPVGJ0BaZvwNFfTu5JLAOZUn
JBQAn0d9K86WvlNidNKuryjs1wt8ypie
=KFGq
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

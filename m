From: Ondrej Zajicek <santiago@crfreenet.org>
Date: Sat, 14 Aug 2010 11:58:42 +0000
Subject: Re: [PATCH v2] s3fb: add DDC support
Message-Id: <20100814115842.GA29442@localhost>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <201008112218.11535.linux@rainbow-software.org> <20100812131421.bb2839f8.akpm@linux-foundation.org> <201008131836.18835.linux@rainbow-software.org>
In-Reply-To: <201008131836.18835.linux@rainbow-software.org>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 13, 2010 at 06:36:16PM +0200, Ondrej Zary wrote:
> Add I2C support for the DDC bus to s3fb driver. This is only bus support,
> driver does not use EDID.
>=20
> Tested on Trio64V+, Trio64V2/DX, Virge (2 cards), Virge/DX (4 cards) and
> Trio3D/2X (3 cards) with i2cdetect and decode-edid.
>=20
> Will probably not work on Trio32 - my 2 cards have DDC support in BIOS th=
at
> looks different from the other cards but the DDC pins on the VGA connector
> are not connected.
>=20
> Virge/GX, Virge/GX2 and Virge/VX are untested.
>=20
>=20
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

Acked-by: Ondrej Zajicek <santiago@crfreenet.org>

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkxmhPIACgkQw1GB2RHercMvbACcCWWRfqzN+fDq6DEQBKYxkzgU
edAAni3kalU4CkeN4i+wUtOssHiRSi0X
=eNKd
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

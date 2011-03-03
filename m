From: Ondrej Zajicek <santiago@crfreenet.org>
Date: Thu, 03 Mar 2011 08:50:08 +0000
Subject: Re: [PATCH 3/5] s3fb: fix 15/16bpp modes with over 115MHz
Message-Id: <20110303085008.GC8363@localhost>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OBd5C1Lgu00Gd/Tn"
List-Id: <linux-fbdev.vger.kernel.org>
References: <201103012018.30651.linux@rainbow-software.org>
In-Reply-To: <201103012018.30651.linux@rainbow-software.org>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Ondrej Zajicek <santiago@crfreenet.org>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2011 at 08:18:27PM +0100, Ondrej Zary wrote:
> Enable pixel multiplexing in 15/16bpp modes when pixclock is over 115MHz
> on Trio3D (86C365) cards to fix artifacts on the left side of screen.
>=20
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

Acked-by: Ondrej Zajicek <santiago@crfreenet.org>

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1vVkAACgkQw1GB2RHercP+FQCeKugRwpNCxqjARh5lEdGnl8nk
7j0AnjhCtF2lbTAL/EflerO+1QXhoBxL
=JIZK
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--

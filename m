From: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 10 Feb 2011 10:47:25 +0000
Subject: Re: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
Message-Id: <20110210104725.GC2206@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oTHb8nViIGeoXxdp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<1297257651-8002-2-git-send-email-s.hauer@pengutronix.de>
	<09EC74FE2C9E8444BF2FF67BD36E1D69167919@039-SN1MPN1-003.039d.mgd.msft.net>
	<201102101046.33994.jbe@pengutronix.de>
In-Reply-To: <201102101046.33994.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> But I would prefer:
> #define SET 4
> #define CLEAR 8
> [...]
> writel(CTRL_DOTCLK_MODE, host->base + CTRL + SET)

NACK.

This will indeed not be caught by the compiler.

And while I like the shorter macros better as well, an MXSFB_ prefix
should be added IMO. Macros like CTRL and TIMING are not too well
protected.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1Twj0ACgkQD27XaX1/VRubuQCeLpRR0S+KRFmbjQnsYMk4Fc0i
l8gAn3zq2L545GdBZLc+oayzImYxRwl6
=Y/bg
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--

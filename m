From: Mark Brown <broonie@kernel.org>
Date: Wed, 22 Apr 2015 19:32:48 +0000
Subject: Re: [PATCH 4/5] ASoC: omap-hdmi-audio: Force channel allocation only for OMAP4
Message-Id: <20150422193248.GG22845@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="boT9Oj39GmgPxYhu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1429705991.git.jsarha@ti.com>
 <24329adf0076ff2ac004817a602c12db2ccc477d.1429705991.git.jsarha@ti.com>
In-Reply-To: <24329adf0076ff2ac004817a602c12db2ccc477d.1429705991.git.jsarha@ti.com>
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, misael.lopez@ti.com


--boT9Oj39GmgPxYhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 04:23:00PM +0300, Jyri Sarha wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
>=20
> There is a constraint in the OMAP4 HDMI IP that requires to use
> the 8-channel code when transmitting more than two channels.

Acked-by: Mark Brown <broonie@kernel.org>

--boT9Oj39GmgPxYhu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN/dfAAoJECTWi3JdVIfQz84H/jQCRRjilDh3qMk/b1vW/mmq
tG9+pWC/5WqVtgujeJY1E9f/wCi8o1DSa8oTSnYBHh1XI+sEwnM3aeNOnUrvLLNT
9PkvGvARM5GuJzZi/1G0/hY2gXY/eeD05gLVuseWLzQ3+ljurW2BIPfX9N3tG+Rb
K4ySrTnjrvolEn6CZWfk2WVxX6nPAja/X07r3no1yZclUxyhQwtZM88qVSG+E3wi
gC3unjZ2uuxBbdHbDayBpWp4ux/+gsqUeXGyPIKzRzOABvBxrvV7y3wR92wrQehg
bGdp0rFqvoOI9NT7BDsUmMTymSTGvfknvwHCt5eY9cnkPHU1hK5NXkQbmmh/Nmw=
=RMXA
-----END PGP SIGNATURE-----

--boT9Oj39GmgPxYhu--

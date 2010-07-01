From: Luotao Fu <l.fu@pengutronix.de>
Date: Thu, 01 Jul 2010 10:50:43 +0000
Subject: Re: [PATCH] imxfb: add flag to avoid disabling clk multiple times
Message-Id: <20100701105043.GB4092@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="l76fUT7nc3MelDdI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1275561288-20661-1-git-send-email-l.fu@pengutronix.de>
	<4C1CE6B8.4090504@gmail.com>
In-Reply-To: <4C1CE6B8.4090504@gmail.com>
To: linux-arm-kernel@lists.infradead.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Sat, Jun 19, 2010 at 05:48:08PM +0200, Martin Fuzzey wrote:
> Hi Luotao,
>=20
> Luotao Fu wrote:

=2E...
> Your patch fixes the clock_disable problem but fbi->backlight_power()
> and fbi->lcd_power() can still be called multiple times.
> Not sure if that is really a problem - they should be idempotent.
>=20
> I did it by making all of imxfb_disable_controller() do nothing if the
> disable was already done like this  (just for illustration not submission,
> lines may be mangled):
>=20

Anything new on this? 'd be nice if you could resend a clean patch based
on the described you sent in this mail. There're about 3 Patches about
this issue out there. More might come in, as long as the bug still
exists. ;-) So let's pack it up and push a proper fix to Sascha.

cheers
Luotao Fu

--=20
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwscwMACgkQkLuxfMCkDTZxCQCfbNb2dMseo0tUAeqPUN8FFmq4
As8AnR+Jp9lED+D3ZKNZOh3F+jRZCiEE
=XHxL
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--

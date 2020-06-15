From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Mon, 15 Jun 2020 15:16:15 +0000
Subject: Re: [PATCH 2/2] pwm: iqs620a: Use 64-bit division
Message-Id: <20200615151615.lbxajfkgzmdbmdva@taurus.defre.kleine-koenig.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pn5rhpjdzgafivym"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200615141606.2814208-1-thierry.reding@gmail.com>
 <20200615141606.2814208-3-thierry.reding@gmail.com>
In-Reply-To: <20200615141606.2814208-3-thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lee Jones <lee.jones@linaro.org>, Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--pn5rhpjdzgafivym
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 04:16:06PM +0200, Thierry Reding wrote:
> The PWM framework is going to change the PWM period and duty cycles to
> be 64-bit unsigned integers. To avoid build errors on platforms that do
> not natively support 64-bit division, use explicity 64-bit division.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

LGTM,

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pn5rhpjdzgafivym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7nkLsACgkQwfwUeK3K
7AlWHwf/dICNt57s5UZBXtembW54DPqqvCVw0lr4GNUtJE7S2lUR33/emNrjb8kN
WyDTQuDeHgYt7ELaXIuLEjTEu97kZyYOgl5bSQefsdfNMhnstvjPRELO3z80ZCoC
WQfuBkAS2G+MjjkopJnTi+k5F7JqBPGP7Vx7fsuQ3AvfBXkqSTGKzJLOwdTPghFB
yZ0XpNNN0J2qD5ZayA+kP5wd8faBSe5JLMOnIpmpAs0gNRF33vyE3hnunyV7QKpO
7Av1YFLti+pj1Wyc6mWv0kRVrSKnivrYWuYJ35M4Tu77KEU16hpRjclrtdV3yXDK
0vV88ZiTLuJHk9nrOcIHLITiKKIkLA==
=U0uY
-----END PGP SIGNATURE-----

--pn5rhpjdzgafivym--

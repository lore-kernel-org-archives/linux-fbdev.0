From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 28 Sep 2015 08:12:30 +0000
Subject: Re: [PATCHv3 2/3] backlight: add led-backlight driver
Message-Id: <5608F66E.8020703@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="TCBBEosFDnwbpLwveGIDaoJW7NfQ7o81j"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441976857-26548-1-git-send-email-tomi.valkeinen@ti.com>
 <1441976857-26548-3-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1441976857-26548-3-git-send-email-tomi.valkeinen@ti.com>
To: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

--TCBBEosFDnwbpLwveGIDaoJW7NfQ7o81j
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Jingoo, Lee,

On 11/09/15 16:07, Tomi Valkeinen wrote:
> This patch adds a led-backlight driver (led_bl), which is similar to
> pwm_bl except the driver uses a LED class driver to adjust the
> brightness in the HW.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/backlight/Kconfig  |   7 ++
>  drivers/video/backlight/Makefile |   1 +
>  drivers/video/backlight/led_bl.c | 246 +++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 254 insertions(+)
>  create mode 100644 drivers/video/backlight/led_bl.c

Any comments on the backlight side of this series? It is very similar to
the pwm_bl.c, so I presume the approach is acceptable?

 Tomi


--TCBBEosFDnwbpLwveGIDaoJW7NfQ7o81j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWCPZuAAoJEPo9qoy8lh71+D8P/2EpIzb2ZTsoVDhBSwNqUEqP
Ng+jtemeytYRVgP59Aa2q4oDreN/stiIEUNnyD2AD/ZS0oNnMLvMdimExDc4lJ+0
EtPeHQF22mPsKPRr6vlexzUrS4siezFOumJkSZHHFmujHZAGR65mBxNbWYyLr2aB
AjXvqHIei++wN729dSY2PdCpFMxrl99wEDgDCVI3WH894xmBXXSWrveJCJB36/nq
8yrwJGFmQmUugu5r+40qxY3g/+2UcSEq2TEZzoQmQ9H5dEsSh792AuKa+Ot5IseP
tV0qON7xDduaCVq4/Q9UEyxOgDXwjNHHk8f7Sy6L5c90DyqL8ngLYaDQzsVlScgj
F3qNitzVhakUkqo9e+qnEeyhonrJXmykhfg2OdB07RTV92kABaZbSVecRj6bpRM7
WY6qMa5rP9Gb2ScoyBXTmRTq1oIQn5wsYbGtrA88jA39epnyhMAuUHgigzWdC1H2
WF6ZHMTAXJaA9Zvv3Gw69dyRVxlQtluXINLPFumAZhSXZU6xMQrdCdAcuT2m6kDZ
Qe0ulQfBbZG/lWfNKNo1mEeXIUd1yzpeYhjcVqvVf5MpX4cgIIHGf/XHzwb4si9k
NhAUg5joNBIGkK/bkcrAAShJCMNTHoP1Y0CKhru34tfpzyqkEXyqmuixSmwJ+kf5
8CgB0lp3o3QxGe2j98p2
=rld4
-----END PGP SIGNATURE-----

--TCBBEosFDnwbpLwveGIDaoJW7NfQ7o81j--

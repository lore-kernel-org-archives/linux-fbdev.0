From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Dec 2012 09:43:39 +0000
Subject: Re: [patch 1/2] drivers/video: add support for the Solomon SSD1307 OLED Controller
Message-Id: <50C5AECB.4040302@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig82822A23A398387699837A28"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20121207203038.F16D082004A@wpzn4.hot.corp.google.com>
In-Reply-To: <20121207203038.F16D082004A@wpzn4.hot.corp.google.com>
To: linux-fbdev@vger.kernel.org

--------------enig82822A23A398387699837A28
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On 2012-12-07 22:30, akpm@linux-foundation.org wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> Subject: drivers/video: add support for the Solomon SSD1307 OLED Contro=
ller
>=20
> Add support for the Solomon SSD1307 OLED controller found on the
> Crystalfontz CFA10036 board.
>=20
> This controller can drive a display with a resolution up to 128x39 and =
can
> operate over I2C or SPI.
>=20
> The current driver has only been tested on the CFA-10036, that is using=

> this controller over I2C to driver a 96x16 OLED screen.
>=20
> [akpm@linux-foundation.org: checkpatch fixes]
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Brian Lilly <brian@crystalfontz.com>
> Cc: Greg KH <gregkh@linux-foundation.org>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: Thomas Petazzoni <thomas@free-electrons.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>=20
>  Documentation/devicetree/bindings/video/ssd1307fb.txt |   24=20
>  drivers/video/Kconfig                                 |   15=20
>  drivers/video/Makefile                                |    1=20
>  drivers/video/ssd1307fb.c                             |  396 +++++++++=
+
>  4 files changed, 436 insertions(+)

Thanks, queued for 3.8.

 Tomi



--------------enig82822A23A398387699837A28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQxa7LAAoJEPo9qoy8lh71LrEP/2XAZyd3FYR3s3z9XB71XNqS
lIWh1pAB2PtJIz52CSStSFDn1O+/TYzGITi5saS80vv8D2U69e0mobipY+QrMmX/
q2YxLNb2o9qpTU6Zd0XdJ20aMJnmpVm0uqLyESwHn3MCTcKXVIyS6CJPXYxcN6ZX
oD5XWtJYCs0Kyj7Za6jBtA4KoV8JHcanFN4ug4x5KT7XNi+kEdJgwvxbc4mXACHY
JrPKzsFSbtjBScCHlvf8OYQluawj7+6gQ4KG9NqpSVxSSh9imtm8pbFSCt09IxOF
NexF4LRH5Yfm3PPgkqfYmXSPOgKHpCADh4G6bptJNRK1YI3y+3mPVOWQMooXuGMH
ltI5XTYPDn2xYR517hYgSXJgL+NvaYiZMf1wpze1CkGn9lj7KLPvfuAQdN7JWdzq
DC7JA1Gggm3M2KHS2aIAUUg4b/9BnQR73VVrRU5r2DNvKEqmyGDDswHf2zcmAI7m
3IGAs5biJPT1OqnvXEdaMWh+P67aowWgbWQAr0Kdy5/j4nKFaZ9mxe40+/bOnYuH
/HL4QeG34hO3Teo0yuDUKLWnXfm0GJBlGMlIqIxhrKONm6dqcyO2RwwBo3E/HKIO
7DhAJImwmlnHqTdHKRZTzC69Y01igeee8JloLZmrVOCiHJXDDqFrHXkdjTFElhrz
Qdy3moPma1/dZsPH5SFZ
=Nh58
-----END PGP SIGNATURE-----

--------------enig82822A23A398387699837A28--

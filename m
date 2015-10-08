From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 08 Oct 2015 09:35:46 +0000
Subject: Re: [PATCHv4 0/3] backlight: led-backlight driver
Message-Id: <561638F2.2010003@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sPkKlvsXIOuNStKnh4o43Vf88rxWbDkAV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443605522-1118-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1443605522-1118-1-git-send-email-tomi.valkeinen@ti.com>
To: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>

--sPkKlvsXIOuNStKnh4o43Vf88rxWbDkAV
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 30/09/15 12:31, Tomi Valkeinen wrote:
> This series aims to add a led-backlight driver, similar to pwm-backligh=
t, but
> using a LED class device underneath.
>=20
> LED framework has no support for DT or getting a LED class driver from =
another
> kernel driver, so I added minimal functionality to led-class to get
> led-backlight working.
>=20
> Changes to v3:
> - Change a comment to refer to of_led_get()
>=20
> Changes to v2:
> - power supply is now optional
> - cosmetic changes
> - no-op function for led_put() when !CONFIG_LEDS_CLASS
>=20
> Changes to v1:
> - Split LED OF parts into separate .h and .c files
> - Check for CONFIG_OF and CONFIG_LEDS_CLASS where relevant to leave unu=
sed code
>   out.
> - Improved error prints and comments a bit
> - Added put_device() into led_put(), as the device was gotten from
>   class_find_device() which requires a put_device() call.
>=20
>  Tomi
>=20
> Tomi Valkeinen (3):
>   leds: Add of_led_get() and led_put()
>   backlight: add led-backlight driver
>   devicetree: Add led-backlight binding
>=20
>  .../bindings/video/backlight/led-backlight.txt     |  30 +++
>  drivers/leds/Makefile                              |   6 +-
>  drivers/leds/led-class.c                           |  13 +-
>  drivers/leds/led-of.c                              |  85 +++++++
>  drivers/leds/leds.h                                |   1 +
>  drivers/video/backlight/Kconfig                    |   7 +
>  drivers/video/backlight/Makefile                   |   1 +
>  drivers/video/backlight/led_bl.c                   | 246 +++++++++++++=
++++++++
>  include/linux/leds.h                               |  10 +
>  include/linux/of_leds.h                            |  26 +++
>  10 files changed, 423 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/l=
ed-backlight.txt
>  create mode 100644 drivers/leds/led-of.c
>  create mode 100644 drivers/video/backlight/led_bl.c
>  create mode 100644 include/linux/of_leds.h

There's been no more comments on this. Should this be merged via led or
backlight trees?

Possible conflicts probably happen on the led side, as this changes the
led core files, so perhaps that's easier way?

 Tomi


--sPkKlvsXIOuNStKnh4o43Vf88rxWbDkAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWFjjyAAoJEPo9qoy8lh71pC0P/1zhKf727SkjS4CMbjaKfH1S
9AtCn0OY2igbYUZFX9y+Mjpnt/Oc/YghPgPkXlttT+JjD9RcMJSfsjDPLFWFQ9R4
u1KRR0bbAeFKSWLICetT290pQ8ieXvOAQXI3uqGuIGecuALpjYjqbn2HXiaREE/F
bfJ1RxhJK6PZSdEcKSI/r8PpFPGRQiemsOdBcJAV4Lb0Z9X4KdsenrwURC7rAYe3
mHmziANV0SXX39C+h/jBFGmBrtf+rocHEzv8wwFODGNloamyonlsKZehEkKZax/Y
eBbhHpZi2GFOhnhWoEBk77ez84bhrM5pAHj5j9OZjSzTFNoco8Ct01t3m3m3lSrX
sbk76VQpsEDvoOSTGs/NhCi6is7CBTVSPSgXTsPuu40+7GA+Psy8Z8YAiP04B3Np
8NpMbuxZK5eD/lPJ60VeAwefkA1XB0nIT0ld1NqoeK2I5jQ1p1UYdkL7CBBHBExS
0BKIMgu2yE7NpVn/IYmqS0ugesOKWUzzx0mlRvhpr+60CYclLBWr8NE35YeQghwC
On2hcaxeEMKOBibQOoU66XP6Icf9nEM0ZkXECkmJfjyuq5BFMF/waT2A13NsfI/2
oRjUoVVG59Qelhw4wftE5QVTX5s9I1kmBEPC6IEjypREA+jDmXM65AcPljp2OTGu
ET6LykqYCwJPGLdxnxvq
=ZIrr
-----END PGP SIGNATURE-----

--sPkKlvsXIOuNStKnh4o43Vf88rxWbDkAV--

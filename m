From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 20 Jul 2015 08:00:09 +0000
Subject: Re: [RFC PATCH 04/15] pwm: make use of pwm_get_xxx helpers where appropriate
Message-Id: <20150720080008.GE29614@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZInfyf7laFu/Kiw7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-5-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1435738921-25027-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2015 at 10:21:50AM +0200, Boris Brezillon wrote:
> Use the pwm_get_xxx helpers instead of directly accessing the fields in
> pwm_device. This will allow us to smoothly move to the atomic update
> approach.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/pwm-atmel.c    |  2 +-
>  drivers/pwm/pwm-bcm-kona.c |  3 ++-
>  drivers/pwm/pwm-imx.c      |  3 ++-
>  drivers/pwm/pwm-rockchip.c |  2 +-
>  drivers/pwm/sysfs.c        | 11 ++++++-----
>  5 files changed, 12 insertions(+), 9 deletions(-)

Applied, thanks.

Thierry

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrKqIAAoJEN0jrNd/PrOhmkAP/3jAQ8oiQfrfWodZO1Dcskmx
3oZaEo+BBSwOA96Zfgg5dyjR1GUEVPgbQboE2XQI33KTqvgALCxwsU8Yn7dzT/b1
yPGtK0t2dZ2wU006le/nCzOPzWA9x9IMtQcib0qcKd3X+TDhk8DBjRYgGQ1a5h0L
C4tAU46/7+RO4PBruuuebocCpIGDuOtg/nxSe01HKeAdNS9L6ToFOyFZsldpnWbc
3Q+tLdehMTikBqRBMaiZHf3Ovmgl8YsLOrP5yBwvj8h6ZNVd9bTL8/3ORchbW9d9
C0uBopbK6XJsKy/UsG/UJOPt79boCHxPCHol+dHpzB8KFn5XRBBQXoTOjDTnYCv0
OGLpTDfBj9IkEYtz9lJ7fgGXzQ3LYUVBXdmaztROIcgl0vEQMYyBZ3xW/yUf+iId
1YZGT9VMoHKfD5pJSelEhXCLSsnmw3QNdkG13SbkX+yjE7nVG0rj2iRErjOdjemt
JR4srFPeZQxSJWN2ezFGXsnmw0qy4xCA5v7o1LvFqrclr3huRKKHU6lEOIHudPlR
L1vi/4JEmWCwAyW9Aw0j1ZrB1ZIuYiNh/mgFXjZIaVvqCFWJEEtx0JLWF6HKBdpE
EBXfKy4g0uUobUu/wJj9mdkIo46rZDi59kXz+V88Abn4xIls5EAForDcBeQ1uZaV
8XJhdaJ0YYOMfSYjG2Pj
=iyGV
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--

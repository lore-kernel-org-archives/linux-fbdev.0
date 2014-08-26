From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Aug 2014 09:52:16 +0000
Subject: Re: [PATCH v2] video: ARM CLCD: Fix calculation of bits-per-pixel
Message-Id: <53FC58D0.6080700@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NS5181eCm51hkXd64OT5eDcXTowo1Gsm8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1408538464.3858.43.camel@linaro1.home>
In-Reply-To: <1408538464.3858.43.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org

--NS5181eCm51hkXd64OT5eDcXTowo1Gsm8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/08/14 15:41, Jon Medhurst (Tixy) wrote:
> If the device-tree specifies a max-memory-bandwidth property then the
> CLCD driver uses that to calculate the bits-per-pixel supported,
> however, this calculation is faulty for two reasons.
>=20
> 1. It doesn't ensure that the result is a sane value, i.e. a power of 2=

>    and <=3D 32 as the rest of the code assumes.
>=20
> 2. It uses the displayed resolution and calculates the average bandwidt=
h
>    across the whole frame. It should instead calculate the peak
>    bandwidth based on the pixel clock.
>=20
> This patch fixes both the above.
>=20
> Signed-off-by: Jon Medhurst <tixy@linaro.org>

Thanks, queued for 3.17 fbdev fixes.

 Tomi



--NS5181eCm51hkXd64OT5eDcXTowo1Gsm8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/FjQAAoJEPo9qoy8lh71kuMP/0ROjT7sPvCqpRlkcqV+PnA5
XPWonbe30/WJQXFL0llCmJTQ2NhUks2xgK0yQKJwZ0ejX5fnqdixANt2Ufk+yGPh
Ys1qUSPExeAHG+Ts3OO11UzYLD8pc35JD9PmW9udb4D81FxbAptsDj7NYa+tyAy7
pBHIwNfA83oSm756X6ZW0cSDafwleEV/iEYrmPpBr/5LhFE3E9cFtPuR6+WcdZlP
xwSQAlEA/APXx6yOhHsyYyNLfMKpemevp/bb0cGCrKF8r6lLIanv/VfaeUJ5PlyP
RPsdW48FK7hsz8jspAkYzmwuRxavE9RU/fVRkG1dSSlzSEzXwAtxWOcGbiH3WIjo
dPqIeA2Vsh57JoP7/eewik6wZgCfzjjSgawuHFYT8Gy9EUbAmMDnE29049h63Jc3
fAPtkbKHMdPrS9NxV7fBIgZ/VARWpI2Zq49u0tAb1E1gU0velIlKhBq9TgkZNPFd
kuTu6w5DyhaMC1d+p5RN8GkqY5i6t3Hg/orpnp4POUE8xrZ63ROrxoLv+moY9EFm
24XlnAeZWLtANpOVYk7wmGVNG1x/ntH6/3ngTzNxhLeSTXybYPIXZlkSjR3EyaZb
AiBiN0KYmVm+x8I4qnFk3/65PMlEdwIxyZgJHnkt8xmbH/AgFIU9J5f1P9lQU7Di
oYhN3ClF5cVLO68x/ZR4
=/Jt/
-----END PGP SIGNATURE-----

--NS5181eCm51hkXd64OT5eDcXTowo1Gsm8--

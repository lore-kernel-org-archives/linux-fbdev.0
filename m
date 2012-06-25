From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 25 Jun 2012 06:20:21 +0000
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Message-Id: <1340605221.12683.30.camel@lappyti>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-3lgmC4hJlhz04DojR0ow"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
In-Reply-To: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
To: jaswinder.singh@linaro.org
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-3lgmC4hJlhz04DojR0ow
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
>=20
> If the runtime PM of the device is disabled (for example in resume from
> suspend path), it doesn't make sense to attempt pm_runtime_get/put, esp
> when their return values affect the control flow path.

This looks strange. When the driver does pm_runtime_get() it expects the
HW to be functional and registers accessible. If we just skip the
pm_runtime_get(), how can the code work?

> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>=20
>  Currenlty HDMI fails to come up in the suspend-resume path.
> This patch helps that real-world scenario.

What is the problem there? It'd be good to explain the problem in the
patch description. Does the pm_runtime_get return -EACCES?

 Tomi


--=-3lgmC4hJlhz04DojR0ow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6AMlAAoJEPo9qoy8lh71MFMP/jtfzPAECTb5aiAKV3eFylDC
qFz4NWTWRUFLiTx5sDGEYYG16sBYpqmAMI+iWqeiKs+CjTlY1vNMZu2GWZkftuKd
KBlPoRJR69pR8MJIrgfx6BOcatLUm7I/sYTMqv3iuHR4QuBMPMAHdT64746QvXt0
/34mzMG7MhWskM0bk5WA2Mrd/ys3rjPvnIv4R0bBTvMB96l72xFeOaRsi4QQQtKB
u9k5tqVhFPjPRfPdUjGKOpXbHMIYcY5vUqz1mG6pG2pcFpKhV5NY1tTBJsS8NkhL
hHq49jrVIWfetROa2hiHiKAxgcDWGK+BxXrQnrnlFMR4dTFxft8nrEh/vHC3fgzV
+PDQmvB/VKZZPt/jkCSrbqOl8BgeLdaF5NcGQGG47omCDdS4h/f+RgKOcvPyh0OP
fCiheQpkE4RyZgbQTouVxocamlhqtRKXsKh3GJU4pXNkoTX7KKIdbbmBO2eO9ofr
YoMUeYMDbSz3Q8FfKaonOm6UX7ZzDVP+LVM+8hEUI4wsOd80lCWh6NAXGtypUmpe
TlegRBkY+8P3R0+9XnUWY7xd6X+uQeqV0kVb9950o/avYgGlzofGsZZpnwHn8j11
mrqO2ce329KL5soh+q/EwxQXq+SDP5O8Ar0aLi8Khx/Vd84mCogXESKOChkcjjdr
TTGnQzBHUZ55HkGiCTMz
=ReYc
-----END PGP SIGNATURE-----

--=-3lgmC4hJlhz04DojR0ow--


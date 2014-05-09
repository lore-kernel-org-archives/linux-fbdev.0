From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 09 May 2014 09:11:29 +0000
Subject: Re: [PATCH v3] video: mx3fb: Add backlight control support
Message-Id: <536C9BC1.2040704@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mMoDSPhWpklguC5spLUcSki0751tXa1K5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1399559916-15183-1-git-send-email-alexander.stein@systec-electronic.com>
In-Reply-To: <1399559916-15183-1-git-send-email-alexander.stein@systec-electronic.com>
To: linux-fbdev@vger.kernel.org

--mMoDSPhWpklguC5spLUcSki0751tXa1K5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/05/14 17:38, Alexander Stein wrote:
> This patch add backlight control support to allow dimming the backlight=

> using the internal PWM. Currently the brightness is set fixed to a
> maximum of 255.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> Changes in v3:
> * Add a more descriptive commit message
>=20
> Changes in v2:
> * rebased to v3.15-rc4
>=20
>  drivers/video/fbdev/mx3fb.c | 98 +++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 98 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
> index 142e860..10a7244 100644
> --- a/drivers/video/fbdev/mx3fb.c
> +++ b/drivers/video/fbdev/mx3fb.c
> @@ -27,6 +27,7 @@
>  #include <linux/clk.h>
>  #include <linux/mutex.h>
>  #include <linux/dma/ipu-dma.h>
> +#include <linux/backlight.h>
> =20
>  #include <linux/platform_data/dma-imx.h>
>  #include <linux/platform_data/video-mx3fb.h>
> @@ -34,6 +35,12 @@
>  #include <asm/io.h>
>  #include <asm/uaccess.h>
> =20
> +#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
> +	(defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE) && \
> +		defined(CONFIG_MX3FB_MODULE))
> +#define PWM_BACKLIGHT_AVAILABLE
> +#endif

I'm not very fond of this kind of ifdeffery. It makes the driver rather
messy and confusing, especially if large blocks of code are inside the
ifdefs.

Can't you just make the driver select BACKLIGHT_CLASS_DEVICE?

 Tomi



--mMoDSPhWpklguC5spLUcSki0751tXa1K5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTbJvBAAoJEPo9qoy8lh71voQP/jxeyiAzv0TsJXGG6Gh95wtJ
5l0lj9JtPF/4WDYzu4OFzdY8f+n/dLbK1ChylqjTmpSmIzOyW4IcKpkSRPhz5haa
nzoBPLE7XA23r9hawDfUh54ukUWfMJBRSg/pv8lfa4VdMJhij55G1bZkUtzc/cU0
M7ZKBQj8bZ4Fucm/A2e8zfkzGa8hIIzex4zCl3ehWF7wGVFnOzQ0/4CDDZKx3D+g
CgAPJt3i8fosFTuiBdTmvVx7P4vK2KcOQ+kHi0gSCKdLTeKh0mC2SJ7HPVrRg0gT
KXE7KMY8nbGIrVuCV3t09CTjQb8gadiNAFRxDw32aKiuQIkv7sB4WD4frsetPZwi
dNQSCrFm966Ow64sZ+8MiO8ygWzi6pKZJDivaDcgR1NT+5kTanlFsAe+xKelC9LE
bA8tK6SJ8W9h5w029gRswbMSCIum0YupV4+DqgARDma2E2QiAwjBFRUrH/T94s1L
JnHL+5AHxGo6NYo0Hj4odmKvI2s2dnx+nWLprPq3h1YqEpa6OYez+7JlFUaJRBUg
7wDJhgejvD4oRg9rTnpkC1fJYmXs93DUokjqcBK5LWmeSTr81NL6WyNE2ibeddE8
VrBEeTHTBKSMyTPSwlLIz0jdkxmuLvGg8HxYbcd5XUEH/g2FBM4CWVKXOfiqpvBy
BO0BHm4NfANDaEs+/IxZ
=vaSZ
-----END PGP SIGNATURE-----

--mMoDSPhWpklguC5spLUcSki0751tXa1K5--

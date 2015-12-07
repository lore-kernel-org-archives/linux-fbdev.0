From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Dec 2015 16:29:50 +0000
Subject: Re: [PATCH] video: fbdev: rivafb: unlock chip before probiding EDID
Message-Id: <5665B3FE.7000905@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mp2X0kXpcRqKwDPG5ALNr62xEm0UPDho5"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--mp2X0kXpcRqKwDPG5ALNr62xEm0UPDho5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17/11/15 03:38, Dmitry Eremin-Solenikov wrote:
> At least NV3 requires for chip to be unlocked before it is possible to
> access I2C registers. Without it, it is not possible to read EDID.
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/video/fbdev/riva/fbdev.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riv=
a/fbdev.c
> index f1ad274..2ef26ad 100644
> --- a/drivers/video/fbdev/riva/fbdev.c
> +++ b/drivers/video/fbdev/riva/fbdev.c
> @@ -1765,6 +1765,7 @@ static int riva_get_EDID_i2c(struct fb_info *info=
)
>  	int i;
> =20
>  	NVTRACE_ENTER();
> +	par->riva.LockUnlock(&par->riva, 0);
>  	riva_create_i2c_busses(par);
>  	for (i =3D 0; i < 3; i++) {
>  		if (!par->chan[i].par)
>=20

Thanks, applied for 4.5.

 Tomi


--mp2X0kXpcRqKwDPG5ALNr62xEm0UPDho5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZbP+AAoJEPo9qoy8lh718U4QAJjo2YH35gsluMOxAN7rDwT0
v6138qbx2NlpfuqSGtZ08T4uMIXM9q63mxKs3/hapkSWGXS9l88eze0Nat2ae6eW
ORJEZ/TzZLOtgQ4JOMi6Tm9rjfL+twPcAL//0t2d3rnipFvqR9V/2j5kOu1faTm3
esRrcLL9MTYcX75EuwGBbiEQs2DC0HhOV20gT0Hj66aDE8HESJWf4TbopfmyVC6p
FN50kFf3jlmeLot2RwHNBuRyZDL8g5xC7deMnzxOE+XCp8GnQKft/L9Y5iLp1kso
ZOPYuYMWCDnjT9m55E9vLXp0/NqFAMFz3cicMH/DD4MGlUz9AMDMNugzzPOZDm/r
PRiYmGlNB4ZFgabHn8JWu8PQTXdRit4zwJlwEpHDjhcDkLHVnT0owd7l90Uz/NLC
m+mQCVaTqzIy2tu35vvB3sbakZhYl4LEfIxfxerAD1/DsE1LK4J8G5/lMNeaK0PM
KnZW2D4GtjFP9R2lVKUiHGrsW3Cv8QmrgsQXdiUqAbNeyF//Z6ERZhaGzZwbthXg
IM35AjfWNt7BUyu1hnXe1F2lzjjDxQqCB3vGsqI2BchwibBIHKjteHGhp7V8imM+
pMavYPJrIpgZ0V6UZ7Y5JTteEsWfSsl565iu1t3KRKAZmRDT5NLVg0AONnKq/PhV
+rSeSNEu06mXP08qQX6D
=TdDH
-----END PGP SIGNATURE-----

--mp2X0kXpcRqKwDPG5ALNr62xEm0UPDho5--

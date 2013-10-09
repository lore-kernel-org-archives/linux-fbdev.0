From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Oct 2013 08:52:17 +0000
Subject: Re: [PATCH 1/1] video: wmt_ge_rops: Fix a trivial typo
Message-Id: <52551941.5020400@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7k6L0cQqiwWe3ApveTbjjbnNKVfAk0JDw"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--7k6L0cQqiwWe3ApveTbjjbnNKVfAk0JDw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/09/13 11:50, Sachin Kamat wrote:
> Add a missing closing brace for email address.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Alexey Charkov <alchark@gmail.com>
> ---
>  drivers/video/wmt_ge_rops.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/wmt_ge_rops.c b/drivers/video/wmt_ge_rops.c
> index d4ef841..b0a9f34 100644
> --- a/drivers/video/wmt_ge_rops.c
> +++ b/drivers/video/wmt_ge_rops.c
> @@ -175,7 +175,7 @@ static struct platform_driver wmt_ge_rops_driver =3D=
 {
> =20
>  module_platform_driver(wmt_ge_rops_driver);
> =20
> -MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com");
> +MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com>");
>  MODULE_DESCRIPTION("Accelerators for raster operations using "
>  		   "WonderMedia Graphics Engine");
>  MODULE_LICENSE("GPL v2");
>=20

Thanks, queuing for 3.13.

 Tomi



--7k6L0cQqiwWe3ApveTbjjbnNKVfAk0JDw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVRlBAAoJEPo9qoy8lh71ZOYP/2zIUjuvxiSgTHKhIKr/LmIt
w1YomwjrGJZjWWw47eHNYPGdnrMKyJiBzoQHmGFx8k8TLL5egnz5jfZ6Te6mM8k/
5obktOfM0/QfHdKpQ8i4LwYKpumqsbiiqmC+kp++yC8Fo4+gkIlqHc1fkLuso/Ar
EeSrUmTgcc8t/O/m1NsdccMhqCt6Zoch2tverfyZeUT36/UnA728IjJ7CLEs3jZt
N7RQl/Tqh1UWLt4VEodJpxRjDuvjqq8dLaG1y1nkEPiuXOfbhNdGC4Mh2WuhStAf
hv1UYorDy2O0cP7+ajhm37q8guPzbIlIcJEzoJmWUkSxZEJF2cAhJL58JuRzZhBA
pjU7i2VBOwFhdO1qScI0snfxwiNPh+h0pe5yuPm0U/Q+A+662nzd2gV1OPKOwL2O
kTNuedcQFj1ay0nXEfT2v0/ECYioMpN1JtTxE9JxAhDS7lX+SVO8Y5twilrt6xeN
248Ayqj1faNezQ/tpL6FAXHcE/0A60JalUKrwXpr6xmDCeV9xpaQhGKH0ANdttfD
FUtYgQS5+lbBb4CC7chbvwZ+4pY+O40U7SpCHNxOBAfJwaDKMmBRBE5pWJOgNfDn
jFakwKwSQ4CF2g5t4fnfrTNgryCAK1KcjJkY0b8S1O2DWGCe2iuF/Di8CgrhHrAs
AO2dcsllF9tix9LnFvWA
=eZf0
-----END PGP SIGNATURE-----

--7k6L0cQqiwWe3ApveTbjjbnNKVfAk0JDw--

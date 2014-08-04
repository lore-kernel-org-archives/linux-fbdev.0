From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 04 Aug 2014 06:48:54 +0000
Subject: Re: [PATCH] video: amba-clcd: Select FB_MODE_HELPERS
Message-Id: <53DF2CD6.1050406@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LQCUFvcSJtLkc3QcHVCR0DFkGPUfkrUgD"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1406908430-18487-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1406908430-18487-1-git-send-email-broonie@kernel.org>
To: linux-fbdev@vger.kernel.org

--LQCUFvcSJtLkc3QcHVCR0DFkGPUfkrUgD
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 01/08/14 18:53, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>=20
> The AMBA CLCD driver uses fb_videomode_from_videomode() so it needs to
> select DB_MODE_HELPERS as well as VIDEOMODE_HELPERS.
>=20
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/video/fbdev/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 37d473f..e222048 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -280,6 +280,7 @@ config FB_ARMCLCD
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> +	select FB_MODE_HELPERS
>  	select VIDEOMODE_HELPERS if OF
>  	help
>  	  This framebuffer device driver is for the ARM PrimeCell PL110

Pawel sent a patch fixing the same issue. I've applied that one.

 Tomi



--LQCUFvcSJtLkc3QcHVCR0DFkGPUfkrUgD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT3yzWAAoJEPo9qoy8lh71sm0QAJLQfRdsHvM7YzTs0K3hjilu
/e+cS9eAAzQTSSZ3o8l54p5kXCO51YaMtTGO4T2rhUQB1V074g6IRMtzQQlsyTCf
7+bXQgU8tYSk3BlfXWCEmVWmLahMlYxV8fkseOwY1jTOtd0SGG1WaL+bJqyb7s0m
2DZmUAxE6kCgSyZU2EI4uEjgQsGQ7ty8CigyVBbspoX8mhOlgeoxtPZRMN1/fFAs
PknDHvdpJuiQ1ZvuyGIBNAv7kyMGDuXfnp6+WQVe+3OvH06AcVYmNFU/tXGx1C9D
lKJ0u58Zq2oNUWVvRO7hcVrVryIYUpSBjFBVTjvh0UwCjdv86VeFv88xhK4Bta0d
NYxi9Tatg4LfF+KHWhmfX/fOLLfKuFF57nsu97SQmfsaIRfidg2l152rwBi7QOKC
0nTlW3BfjAUF/90dauXZ3luQ4n8aYEuX1Qwscd3EY7yugXntm9CMSp/Vewwvrdl1
lr3Q0HPIk3ZolB6or4daahA+B/7yBVifTdPXu7uu+hkDl58OVtc/4Y3qw7Dy9WDc
rVO5vrOj9+2APrD8Ph1M13eAJaKh/doK7HLBkttWnbLE/axqsPTO4kFfqUmIqKrq
w1pVmi+eHPvwf5aqXx8nU+Nm5DAL2m/XCRpQe22kr9S3sCLGOSPkRhE8lKycJCYj
84UGAb/sBZhKaAhZ929W
=h239
-----END PGP SIGNATURE-----

--LQCUFvcSJtLkc3QcHVCR0DFkGPUfkrUgD--

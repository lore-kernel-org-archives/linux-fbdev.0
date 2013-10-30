From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 30 Oct 2013 11:53:36 +0000
Subject: Re: [PATCH 1/1] video: exynos_mipi_dsi: Unlock the mutex before returning
Message-Id: <5270F340.4050702@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7mOW2iuX3jU5XIBcUAMGtKPL7JBqxgBNE"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382677964-15298-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382677964-15298-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--7mOW2iuX3jU5XIBcUAMGtKPL7JBqxgBNE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-10-25 08:12, Sachin Kamat wrote:
> Mutex should be unlocked before returning. Fixes mutex lock-unlock
> imbalance issue.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/exynos/exynos_mipi_dsi_common.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c b/drivers/vi=
deo/exynos/exynos_mipi_dsi_common.c
> index 520fc9b..649d9e6 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi_common.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
> @@ -376,6 +376,7 @@ int exynos_mipi_dsi_rd_data(struct mipi_dsim_device=
 *dsim, unsigned int data_id,
>  			"data id %x is not supported current DSI spec.\n",
>  			data_id);
> =20
> +		mutex_unlock(&dsim->lock);
>  		return -EINVAL;
>  	}
> =20
>=20

Thanks, queued for 3.13.

 Tomi



--7mOW2iuX3jU5XIBcUAMGtKPL7JBqxgBNE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJScPNAAAoJEPo9qoy8lh71XqcQAJnWTD6+Ya+cfmzwDB0JS6v+
vgsPYrIQbteMuoIsSAY0lf6cz05qbEFERMf2rFtAX+685kT4hzWVSvYHbNzvT/yF
WZNyFXRkT568DqaSn0aWHS02TogtHHyDJHwJFYB0LKLIFAif7rsmi891DUulTy+2
1qqce6n88UAipQEFTpAJrfWzpfG7McwwnE+c7yOBmuigO6CplL9h15j9kMxk6N6q
GMsqSR2lxbHw0VSdbjlCextNYmy7XQ3I44F8DVXquJweFeJoXcnJOg7XtI7iCVtS
k+nsAwIGF7nHveA0mU0OULepbLC0ovXIlzYb792OmurCr50FDRyWdT7uo1pP9Izg
n6gra8ISuhcqelUOpcsyLVBhbjUP6IONtl0KRHKFTSnJH35mPA4e4XXViDoFIqQs
cLQOnpfdaiSeU10GxZjsanDZ0gKwe7mZx6Ulnxp9HmqMl5w6zIGmOqIXW3rTWf9h
AEbtYfgfkYkIQZzORQyxumEWl4akcAN2ZJ2xywY52335IKB1Bd299/LXySIeaF4k
UuBASlfpjd0Ifdn0iSsxMN51Be4sgJ0s9cRXkdth3fVHkZpSdoX/lYRZ4qu59TEw
+G1YsILV4BZDF+9VNFOb/s1ILAUJLf0C0YoEVyAVFyg0eKuYemfnzo+N8G6NWrI9
cROZS3kpa5Yw8AG3iBg2
=NVY5
-----END PGP SIGNATURE-----

--7mOW2iuX3jU5XIBcUAMGtKPL7JBqxgBNE--

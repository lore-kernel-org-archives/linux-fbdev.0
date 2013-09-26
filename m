From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Sep 2013 08:46:13 +0000
Subject: Re: [PATCH] neofb: fix error return code in neofb_probe()
Message-Id: <5243F455.7020202@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uoOnh6mlQUJWIBX4svAcULwv1nkUnv0u2"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPgLHd8sm1rhuuG7TJqAfWesiSDf6MaM4E4VCrrWXGziLEiYVA@mail.gmail.com>
In-Reply-To: <CAPgLHd8sm1rhuuG7TJqAfWesiSDf6MaM4E4VCrrWXGziLEiYVA@mail.gmail.com>
To: linux-fbdev@vger.kernel.org

--uoOnh6mlQUJWIBX4svAcULwv1nkUnv0u2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 23/09/13 18:00, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/video/neofb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
> index 891b0bf..2a3e5bd 100644
> --- a/drivers/video/neofb.c
> +++ b/drivers/video/neofb.c
> @@ -2075,6 +2075,7 @@ static int neofb_probe(struct pci_dev *dev, const=
 struct pci_device_id *id)
>  	if (!fb_find_mode(&info->var, info, mode_option, NULL, 0,
>  			info->monspecs.modedb, 16)) {
>  		printk(KERN_ERR "neofb: Unable to find usable video mode.\n");
> +		err =3D -EINVAL;
>  		goto err_map_video;
>  	}
> =20
> @@ -2097,7 +2098,8 @@ static int neofb_probe(struct pci_dev *dev, const=
 struct pci_device_id *id)
>  	       info->fix.smem_len >> 10, info->var.xres,
>  	       info->var.yres, h_sync / 1000, h_sync % 1000, v_sync);
> =20
> -	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
> +	err =3D fb_alloc_cmap(&info->cmap, 256, 0);
> +	if (err < 0)
>  		goto err_map_video;
> =20
>  	err =3D register_framebuffer(info);
>=20

Thanks, queuing for 3.12 fixes.

 Tomi



--uoOnh6mlQUJWIBX4svAcULwv1nkUnv0u2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSQ/RVAAoJEPo9qoy8lh71uB4P/27D9hRsO+D+9baiM0kDVz/R
tb8IjjiAwHX41AAZAau/QOebEYneGTFzcCBpLe8XOGn89kH3RncTodLmOmY/hW/h
WnxiwFh7xh3blK5fyS9Q/3JrZeJc2q0h2+UJQnQLdWXJrTn8/UymCD5HutbpDrUo
xifXBTy/9ABaOI6lFvKZCAWnorYjZk/7LJYMbynwAis143fSd3tljrpX+t67GYax
BJhB05HqaBT+/ZJNaBPaZGkDXC3D3Eci2JvXBXmZHW5nYdtjGUU3x+612Fv2mwhu
Dl8Uog0wuOayNa3GGTcjhS7CVcuvUbSv9WH8O/RGi0GFUF7P7n4UnZX1+/eo1iwe
9BlPiiBgIcTyAlnABrDCOpkSBEJgAg0qLxyLFW13FoLMM5hJk2Xza+iACwswgt1u
zBECtEKYoMoZLPHUdte+5M11JhGTpL9zxQcm5FWUego71frhUH3+zQk1jVfXZ/be
8ZaibRNvjGgOtZ+4buUIREA+9lyrLX5hTed5UfcyJCptyb+L2ojbt+Pc8y3YIPo/
7XPs9qzIHqwObw8F39qfCgxwvD4GnDWDV9tEJU3ZqR0GeWiD58Hg68lNjs+BSqUB
ABcFcbQm9QKdZZb3GwaynIe6BeBTSm1bBrv2SfdkUrCyQqkvQfQH4LLKx2PAoPvX
/9wh3Nr4RNSAMFOegjMT
=0Y2w
-----END PGP SIGNATURE-----

--uoOnh6mlQUJWIBX4svAcULwv1nkUnv0u2--

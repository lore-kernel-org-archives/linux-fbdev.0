From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 08 Jan 2014 08:33:31 +0000
Subject: Re: [PATCH RESEND 1/4] video: asiliantfb: remove unnecessary pci_set_drvdata()
Message-Id: <52CD0D5B.9060102@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="G3NV3W0hhGJs6DsVCferB9vKjLNRv3aDM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <001901cf0c0a$cb48b5e0$61da21a0$%han@samsung.com>
In-Reply-To: <001901cf0c0a$cb48b5e0$61da21a0$%han@samsung.com>
To: linux-fbdev@vger.kernel.org

--G3NV3W0hhGJs6DsVCferB9vKjLNRv3aDM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-08 02:44, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure. Thus, it is not needed to manually clear the
> device driver data to NULL.
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/video/asiliantfb.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
> index d611f1a..7e8ddf0 100644
> --- a/drivers/video/asiliantfb.c
> +++ b/drivers/video/asiliantfb.c
> @@ -589,7 +589,6 @@ static void asiliantfb_remove(struct pci_dev *dp)
>  	fb_dealloc_cmap(&p->cmap);
>  	iounmap(p->screen_base);
>  	release_mem_region(pci_resource_start(dp, 0), pci_resource_len(dp, 0)=
);
> -	pci_set_drvdata(dp, NULL);
>  	framebuffer_release(p);
>  }
> =20
>=20

Series queued for 3.14.

 Tomi



--G3NV3W0hhGJs6DsVCferB9vKjLNRv3aDM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSzQ1bAAoJEPo9qoy8lh71xTkQAKop/Gt6YqzqmbNmUtTnJXqZ
GrTHSf7uXHTHCIsSFnKls/f8NO0Bwrxnpt+Czqzr44cOZoyoYd71TUR2a9iArThr
O1Hq36UNYfS3XrcBC7fCyBsOFcLWTPVa7BAa9DyI9tZ0whe/6o27/2JM4u6tC8O2
7DaKZlzhXxYJwCTw58z3DJqIOdjIJJWIw7pWGARH+bZzBFgd8fQmn1LQNDQMy5uA
bltY6724EHKW+V3/bQOewz6FfFntynPF4UQCWOMAK6hh5rEej+ckmRlmezJUGfan
UrzUhw2yxpqRbk+yq+PVVdy87e7goSQO3JlsT0Ac956CL/rg+sbyocAt623i9rZu
zPo2P59cJuT42gP5+Olx71xahMKchEKSzS+gmXSTXn0PdkKGKMe7AQ0P2JXFdx01
DOfct6wbGb687UwzQHnH105bGsOO0xCLRe60rgB/Bx9/uqFgd63ezJZYvFdJTsgU
Z+4sUZ/jPnrWLz6k/jsvEiVkzDi1+34+NkZHiVcneLEGe0Yx2I6PqAopOUekEjxq
fN8noRzo8u0EdtaoVciRuU9VqNorqEwQAPr9sIWP0T8kkhBl7s8LhvkgKoXvCoMR
ZDrHHxKcjc+tqad3DME1CQx4w9KhSmGj+H/41h0dNHtZwnFCTXJft2IXoD4vQVG5
AWfXqctrSwxDu/I/j9Dr
=IlxB
-----END PGP SIGNATURE-----

--G3NV3W0hhGJs6DsVCferB9vKjLNRv3aDM--

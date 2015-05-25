From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 25 May 2015 05:40:07 +0000
Subject: Re: [patch] fbdev: ssd1307fb: potential ERR_PTR dereference
Message-Id: <5562B5B7.3060701@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ru8wNP7tvsJQKJDcBv1nSsxCBLTTA4TXp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150523173235.GA31595@mwanda>
In-Reply-To: <20150523173235.GA31595@mwanda>
To: linux-fbdev@vger.kernel.org

--ru8wNP7tvsJQKJDcBv1nSsxCBLTTA4TXp
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 23/05/15 20:32, Dan Carpenter wrote:
> The error handling got shifted down a few lines from where it was
> supposed to be for some reason.
>=20
> Fixes: a14a7ba8cb0f ('fbdev: ssd1307fb: add backlight controls for sett=
ing the contrast')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1=
307fb.c
> index 8fc224c..9c28a77 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -655,15 +655,16 @@ static int ssd1307fb_probe(struct i2c_client *cli=
ent,
>  	snprintf(bl_name, sizeof(bl_name), "ssd1307fb%d", info->node);
>  	bl =3D backlight_device_register(bl_name, &client->dev, par,
>  				       &ssd1307fb_bl_ops, NULL);
> -	bl->props.brightness =3D par->contrast;
> -	bl->props.max_brightness =3D MAX_CONTRAST;
> -	info->bl_dev =3D bl;
> -
>  	if (IS_ERR(bl)) {
>  		dev_err(&client->dev, "unable to register backlight device: %ld\n",
>  			PTR_ERR(bl));
>  		goto bl_init_error;
>  	}
> +
> +	bl->props.brightness =3D par->contrast;
> +	bl->props.max_brightness =3D MAX_CONTRAST;
> +	info->bl_dev =3D bl;
> +
>  	dev_info(&client->dev, "fb%d: %s framebuffer device registered, using=
 %d bytes of video memory\n", info->node, info->fix.id, vmem_size);
> =20
>  	return 0;
>=20

Thanks, queued for 4.2.

 Tomi


--ru8wNP7tvsJQKJDcBv1nSsxCBLTTA4TXp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVYrW6AAoJEPo9qoy8lh71ED8QAKty8s2pGd8ISUvqYTQLEkPy
0h+UcJ8x8FmV4vV9uM9yzwEQncJQBf+ciD4UcNsVhpxsoUpatsR5vWWJidPZuJV1
0pDT4apq6RT9fhaGBrJCpPIj4jJYnbw7e+z8Pgsg4VcH1YoupifYsyB1wGORrHnY
5F+X63LauYaz5ENN/I7E+L72i0uOR0fX7K74kVTqNfsagh3IFHYL+6W47o51npBA
I/3q4P9OrkpOT+zwjghKpaEsTjfij3s08sj2tCZwB0dWr81Maj7HInwK9MQubZLC
rkcH+H8dq623L3hck55X+9z6j7XP1eyJKcaP/lzVrIaLfhxsXyIuzI9oCNzCFb63
h9ASXWOb/wtH05DEqDV+0dnn+nT8GJbX3g2A0+te3Xz8wZJS/tgB8hvNr8FCi2+o
SBQO2mWmd/WTkHFX00F8oPMYTx9W2elMJXqFWVVjyx9xsQ7Vv4P6ZdldnyCddAzz
8vr80mO1RlLU+TPQmEbXqr9dEpFnqxuVTTUyLmmBo8jpv9RqSoZDUJozuWmssA/U
17tCkOqIOdZRzRKpmmQ0G92sxD3/RcttcxXuoH88HvVbGh6Cmm7urJ1vEQ+xcSlQ
B+5XLFg7PkEQND+9FIIoJ1ph64/CKlcc6yrgqRGXjHWhzKVK5TWlA+0AJfpgC8mq
XpaAASdi4CC8cVrzJOAI
=tLVa
-----END PGP SIGNATURE-----

--ru8wNP7tvsJQKJDcBv1nSsxCBLTTA4TXp--

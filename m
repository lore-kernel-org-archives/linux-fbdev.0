From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 04 Dec 2013 08:51:10 +0000
Subject: Re: [patch] video: vt8500: fix error handling in probe()
Message-Id: <529EECFE.1010607@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KsUE8qUPuMWlB8dR5mT3wLubP3qNvRXOh"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20131202081118.GB3852@elgon.mountain>
In-Reply-To: <20131202081118.GB3852@elgon.mountain>
To: linux-arm-kernel@lists.infradead.org

--KsUE8qUPuMWlB8dR5mT3wLubP3qNvRXOh
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-02 10:11, Dan Carpenter wrote:
> We shouldn't kfree(fbi) because that was allocated with devm_kzalloc().=

> There were several error paths which returned directly instead of
> releasing resources.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
> index b30e5a439d1f..a8f2b280f796 100644
> --- a/drivers/video/vt8500lcdfb.c
> +++ b/drivers/video/vt8500lcdfb.c
> @@ -293,8 +293,7 @@ static int vt8500lcd_probe(struct platform_device *=
pdev)
>  			+ sizeof(u32) * 16, GFP_KERNEL);
>  	if (!fbi) {
>  		dev_err(&pdev->dev, "Failed to initialize framebuffer device\n");
> -		ret =3D -ENOMEM;
> -		goto failed;
> +		return -ENOMEM;
>  	}
> =20
>  	strcpy(fbi->fb.fix.id, "VT8500 LCD");
> @@ -327,15 +326,13 @@ static int vt8500lcd_probe(struct platform_device=
 *pdev)
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (res =3D=3D NULL) {
>  		dev_err(&pdev->dev, "no I/O memory resource defined\n");
> -		ret =3D -ENODEV;
> -		goto failed_fbi;
> +		return -ENODEV;
>  	}
> =20
>  	res =3D request_mem_region(res->start, resource_size(res), "vt8500lcd=
");
>  	if (res =3D=3D NULL) {
>  		dev_err(&pdev->dev, "failed to request I/O memory\n");
> -		ret =3D -EBUSY;
> -		goto failed_fbi;
> +		return -EBUSY;
>  	}
> =20
>  	fbi->regbase =3D ioremap(res->start, resource_size(res));
> @@ -346,17 +343,19 @@ static int vt8500lcd_probe(struct platform_device=
 *pdev)
>  	}
> =20
>  	disp_timing =3D of_get_display_timings(pdev->dev.of_node);
> -	if (!disp_timing)
> -		return -EINVAL;
> +	if (!disp_timing) {
> +		ret =3D -EINVAL;
> +		goto failed_free_io;
> +	}
> =20
>  	ret =3D of_get_fb_videomode(pdev->dev.of_node, &of_mode,
>  							OF_USE_NATIVE_MODE);
>  	if (ret)
> -		return ret;
> +		goto failed_free_io;
> =20
>  	ret =3D of_property_read_u32(pdev->dev.of_node, "bits-per-pixel", &bp=
p);
>  	if (ret)
> -		return ret;
> +		goto failed_free_io;
> =20
>  	/* try allocating the framebuffer */
>  	fb_mem_len =3D of_mode.xres * of_mode.yres * 2 * (bpp / 8);
> @@ -364,7 +363,8 @@ static int vt8500lcd_probe(struct platform_device *=
pdev)
>  				GFP_KERNEL);
>  	if (!fb_mem_virt) {
>  		pr_err("%s: Failed to allocate framebuffer\n", __func__);
> -		return -ENOMEM;
> +		ret =3D -ENOMEM;
> +		goto failed_free_io;
>  	}
> =20
>  	fbi->fb.fix.smem_start	=3D fb_mem_phys;
> @@ -447,9 +447,6 @@ failed_free_io:
>  	iounmap(fbi->regbase);
>  failed_free_res:
>  	release_mem_region(res->start, resource_size(res));
> -failed_fbi:
> -	kfree(fbi);
> -failed:
>  	return ret;
>  }

Thanks, queued for 3.13 fbdev fixes.

 Tomi



--KsUE8qUPuMWlB8dR5mT3wLubP3qNvRXOh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSnuz+AAoJEPo9qoy8lh71D5AP/R5/pddubsPEM41a4K5bGGtW
2NBLdgskWDd17G+ZyltFcudAPZTbNaQxo5UgN0nsmyIav1A86et/AV79W+oYisnS
YuB6S5qVyPUVVZyDgo2zJRhPFuU02BD+w+OG1Wov1VI/DDDQ7U8rMIdLT+K3kqsA
IO4XSlTDIvuqSt3yd3OPI7s+k0ZHplIZYVBjt32qVCJ7aRUdqH3hhGaY+8GneP6/
g1qd0zudplsVDCzjAtB+y/+hpsvoRcAs9KIYA8B2lczGDcZ2TiNjiPTm7lMtgBMg
zAysW/wAQ7A/lKZ62TiPwtflISvJiXyz3czAG+b7eDkFwNOUYiPNxcCs/prSbYZR
eLcE7Fn0dJXIdU+CfyooUka285rkrW9tMSgeDSFiINWJNDJkXGdoKEqcyx4ns+gy
2HmJMlHbnKOABthFLF7+ZLXNhSdCGuxoYzQbvMMPgGlWcn9e9LHz/FztUhXenZxh
26pItToDUXodAT38UiNXg1jEJiDWt7K1hb1k1I8mgAT5Omb5rDPKBA4VOjmHfNIV
zutDUGhSy8PTjcJL0Mfnga7dGOaSwoBYydzFMHk7wmCenY7lsBCEA/2j/BL55Gt7
Ry5j43FZfbQ955l7P+XDQNtNEBPR3z3R8HE05bLt2rc1vRyAgpGc0hz60MzIvzGX
v+zo4QorGYQKqAHJuPK2
=4n/3
-----END PGP SIGNATURE-----

--KsUE8qUPuMWlB8dR5mT3wLubP3qNvRXOh--

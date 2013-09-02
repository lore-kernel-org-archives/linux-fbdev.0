From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 02 Sep 2013 08:52:43 +0000
Subject: Re: [PATCH] video: xilinxfb: use devm_ioremap_resource() instead of devm_request_and_ioremap()
Message-Id: <522451DB.1020100@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sdBpJNV8m5DC8qXhx76GQ93NKRNH6Ln77"
List-Id: <linux-fbdev.vger.kernel.org>
References: <005401cea77c$6925eec0$3b71cc40$%han@samsung.com>
In-Reply-To: <005401cea77c$6925eec0$3b71cc40$%han@samsung.com>
To: linux-fbdev@vger.kernel.org

--sdBpJNV8m5DC8qXhx76GQ93NKRNH6Ln77
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 02/09/13 04:33, Jingoo Han wrote:
> Use devm_ioremap_resource() because devm_request_and_ioremap() is
> obsoleted by devm_ioremap_resource().
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/video/xilinxfb.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> index 6629b29..ed90051 100644
> --- a/drivers/video/xilinxfb.c
> +++ b/drivers/video/xilinxfb.c
> @@ -260,9 +260,9 @@ static int xilinxfb_assign(struct platform_device *=
pdev,
> =20
>  		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  		drvdata->regs_phys =3D res->start;
> -		drvdata->regs =3D devm_request_and_ioremap(&pdev->dev, res);
> -		if (!drvdata->regs) {
> -			rc =3D -EADDRNOTAVAIL;
> +		drvdata->regs =3D devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(drvdata->regs)) {
> +			rc =3D PTR_ERR(drvdata->regs);
>  			goto err_region;
>  		}
>  	}

I have already applied a similar patch from Julia Lawall.

 Tomi



--sdBpJNV8m5DC8qXhx76GQ93NKRNH6Ln77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSJFHbAAoJEPo9qoy8lh71/90P/1PvOu2JQKy3vtjSYL8JSGFz
KSFOe8lwLbc98B8vCa99eUwcK7ZjzMWWNr3vBx6dK4zxFnVve8LOae1aK0fSrT/b
up/d0OVbZgWADBa7kVhYAv2bzesbCvcSmzEgFYNQlwrKc1ywBBylK0VmXpufQC13
eeCb3PVial/YSUcfg1Cal0J8ITRAZA32iynX9rZTFqzyvvUUFVfX+rw7ea/OD5L2
UxcwS7sgktQConO9VDv5/zN7g3+EUEhXXw6N5aQFWRn4kdTzXgYjpLeo1gXao9gS
HVuyal9eYE8IBpCveZevLvj4iS5ZlNJK4xUv6HkpuV7qsfABxvVTw4LfecgID2O1
cc5OI5tenggfy1xnQr3urpe62SIJtFkv/F7Nn5T7giehGKAIj+jdYcNywyeQDjOd
TjOG08V1cAMEqaa6Sal+W7EyoHQM81OoP32N4hrrKncj8uoZJbtXzBLv7mUbpnHB
mJD2Ulad46Y1/yNnnTFPpx2WcOHp8jyLSw1NIWvfakbhxljxIIKq90lGVRpOSRH2
8brjE55DoLcXIJS+SVAWw+Qz6sRGfyoDo2gJARZOuz1DmNuwaerNDIBAkjkA6KGI
SieROGrqgriLHR97B27l9Nau2TK25zD5puZBUWuapWs3J3SQM+f5cxaI14dEKdUh
IomMcr6anahztNpfJfNW
=8S/J
-----END PGP SIGNATURE-----

--sdBpJNV8m5DC8qXhx76GQ93NKRNH6Ln77--

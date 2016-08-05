From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 05 Aug 2016 13:29:42 +0000
Subject: Re: [PATCH] backlight: adp5520: fix error handling in adp5520_bl_probe()
Message-Id: <20160805132942.GF5243@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1468016392-6061-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1468016392-6061-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

On Sat, 09 Jul 2016, Alexey Khoroshilov wrote:

> If adp5520_bl_setup() fails, sysfs group left unremoved.
>=20
> By the way, fix overcomplicated assignement of error code.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/video/backlight/adp5520_bl.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlig=
ht/adp5520_bl.c
> index dd88ba1d71ce..35373e2065b2 100644
> --- a/drivers/video/backlight/adp5520_bl.c
> +++ b/drivers/video/backlight/adp5520_bl.c
> @@ -332,10 +332,18 @@ static int adp5520_bl_probe(struct platform_device =
*pdev)
>  	}
> =20
>  	platform_set_drvdata(pdev, bl);
> -	ret |=3D adp5520_bl_setup(bl);
> +	ret =3D adp5520_bl_setup(bl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to setup\n");
> +		if (data->pdata->en_ambl_sens)
> +			sysfs_remove_group(&bl->dev.kobj,
> +					&adp5520_bl_attr_group);
> +		return ret;
> +	}
> +
>  	backlight_update_status(bl);
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  static int adp5520_bl_remove(struct platform_device *pdev)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

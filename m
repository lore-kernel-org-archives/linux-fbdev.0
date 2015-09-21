From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 21 Sep 2015 23:23:38 +0000
Subject: Re: [PATCH] backlight: pwm: free pwm requested by legacy API on error path
Message-Id: <20150921232338.GG11284@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434292334-22312-1-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1434292334-22312-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

On Sun, 14 Jun 2015, Vladimir Zapolskiy wrote:

> If pwm is requested by legacy pwm_request() and if the following
> backlight_device_register() call fails, add pwm_free() clean-up.
>=20
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 9991cdb..a691247 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -307,6 +307,8 @@ static int pwm_backlight_probe(struct platform_device=
 *pdev)
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		ret =3D PTR_ERR(bl);
> +		if (pb->legacy)
> +			pwm_free(pb->pwm);
>  		goto err_alloc;
>  	}
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

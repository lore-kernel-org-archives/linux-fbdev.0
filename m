From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 13 Oct 2017 08:50:20 +0000
Subject: Re: [PATCH] cklight: tps65217_bl: Remove unnecessary default brightness check
Message-Id: <20171013085020.rggykq7gyd5ttnlo@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1507499808-12896-1-git-send-email-chris.gekas@gmail.com>
In-Reply-To: <1507499808-12896-1-git-send-email-chris.gekas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Christos Gkekas <chris.gekas@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 08 Oct 2017, Christos Gkekas wrote:

> Variable val holds the default brightness and is unsigned, therefore
> checking whether it is less than zero is redundant.
>=20
> Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
> ---
>  drivers/video/backlight/tps65217_bl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Subject line fixed and patch applied, thanks.

> diff --git a/drivers/video/backlight/tps65217_bl.c b/drivers/video/backli=
ght/tps65217_bl.c
> index fd524ad..61ea82d 100644
> --- a/drivers/video/backlight/tps65217_bl.c
> +++ b/drivers/video/backlight/tps65217_bl.c
> @@ -239,8 +239,7 @@ tps65217_bl_parse_dt(struct platform_device *pdev)
>  	}
> =20
>  	if (!of_property_read_u32(node, "default-brightness", &val)) {
> -		if (val < 0 ||
> -			val > 100) {
> +		if (val > 100) {
>  			dev_err(&pdev->dev,
>  				"invalid 'default-brightness' value in the device tree\n");
>  			err =3D ERR_PTR(-EINVAL);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

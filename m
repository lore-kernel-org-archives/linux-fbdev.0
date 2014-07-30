From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 30 Jul 2014 07:42:04 +0000
Subject: Re: [PATCH -next] backlight: ipaq_micro: Fix sparse non static symbol warning
Message-Id: <20140730074204.GE9030@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAK5ve-K6WpvN++xdKsHw=-BipV-mYh1PP63G78K=ExynBD9VGQ@mail.gmail.com>
In-Reply-To: <CAK5ve-K6WpvN++xdKsHw=-BipV-mYh1PP63G78K=ExynBD9VGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Wed, 30 Jul 2014, weiyj_lk@163.com wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Fixes the following sparse warnings:
>=20
> drivers/video/backlight/ipaq_micro_bl.c:73:24: warning:
>  symbol 'micro_backlight_device_driver' was not declared. Should it be st=
atic?
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/video/backlight/ipaq_micro_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied with Bryan's Ack.

> diff --git a/drivers/video/backlight/ipaq_micro_bl.c b/drivers/video/back=
light/ipaq_micro_bl.c
> index feab29c..347dc11 100644
> --- a/drivers/video/backlight/ipaq_micro_bl.c
> +++ b/drivers/video/backlight/ipaq_micro_bl.c
> @@ -70,7 +70,7 @@ static int micro_backlight_probe(struct platform_device=
 *pdev)
>  	return 0;
>  }
> =20
> -struct platform_driver micro_backlight_device_driver =3D {
> +static struct platform_driver micro_backlight_device_driver =3D {
>  	.driver =3D {
>  		.name    =3D "ipaq-micro-backlight",
>  	},
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

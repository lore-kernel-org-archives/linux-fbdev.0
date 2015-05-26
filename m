From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 26 May 2015 07:18:50 +0000
Subject: Re: [PATCH 15/21] backlight: Probe backlight devices on demand
Message-Id: <20150526071850.GA11677@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-16-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1432565608-26036-16-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, 25 May 2015, Tomeu Vizoso wrote:

> When looking up a backlight device through its DT node, ensure that the
> corresponding device has been registered.
>=20
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/video/backlight/backlight.c | 3 +++
>  1 file changed, 3 insertions(+)

Looks reasonable.

Until anyone screams at me, applied thanks.

> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backligh=
t/backlight.c
> index bddc8b1..fe7833b 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -12,6 +12,7 @@
>  #include <linux/device.h>
>  #include <linux/backlight.h>
>  #include <linux/notifier.h>
> +#include <linux/of_platform.h>
>  #include <linux/ctype.h>
>  #include <linux/err.h>
>  #include <linux/fb.h>
> @@ -559,6 +560,8 @@ struct backlight_device *of_find_backlight_by_node(st=
ruct device_node *node)
>  {
>  	struct device *dev;
> =20
> +	of_platform_device_ensure(node);
> +
>  	dev =3D class_find_device(backlight_class, NULL, node, of_parent_match);
> =20
>  	return dev ? to_backlight_device(dev) : NULL;

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

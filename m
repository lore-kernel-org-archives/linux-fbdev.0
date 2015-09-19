From: Lee Jones <lee.jones@linaro.org>
Date: Sat, 19 Sep 2015 10:06:22 +0000
Subject: Re: [PATCH] backlight: lp855x: Make sure props struct is zeroed
Message-Id: <20150919100622.GJ3218@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440697275-4469-1-git-send-email-bjorn.andersson@sonymobile.com>
In-Reply-To: <1440697275-4469-1-git-send-email-bjorn.andersson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Milo Kim <milo.kim@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Werner Johansson <werner.johansson@sonymobile.com>

On Thu, 27 Aug 2015, Bjorn Andersson wrote:

> From: Werner Johansson <werner.johansson@sonymobile.com>
>=20
> The driver occasionally got stuck in suspend mode or other strange
> states as those parts of the props struct were never initialized.
>=20
> Signed-off-by: Werner Johansson <werner.johansson@sonymobile.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>  drivers/video/backlight/lp855x_bl.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backligh=
t/lp855x_bl.c
> index 88116b493f3b..0a7f88ce1ab0 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -282,6 +282,7 @@ static int lp855x_backlight_register(struct lp855x *l=
p)
>  	struct lp855x_platform_data *pdata =3D lp->pdata;
>  	const char *name =3D pdata->name ? : DEFAULT_BL_NAME;
> =20
> +	memset(&props, 0, sizeof(props));
>  	props.type =3D BACKLIGHT_PLATFORM;
>  	props.max_brightness =3D MAX_BRIGHTNESS;
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

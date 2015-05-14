From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 14 May 2015 07:25:09 +0000
Subject: Re: [PATCH] backlight/lp855x: Don't clear level on suspend/blank
Message-Id: <20150514072509.GC20358@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1431376325-25741-1-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1431376325-25741-1-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Mon, 11 May 2015, Sean Paul wrote:

> Don't clear the backlight level when we're going into suspend or
> blanking. Instead, just temporarily set the level to 0 so we retain
> the value when we resume.
>=20
> Reported-by: Benson Leung <bleung@chromium.org>
> Tested-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>  drivers/video/backlight/lp855x_bl.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Applied with Acks, thanks.

> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backligh=
t/lp855x_bl.c
> index 08ae72f..74daf7c 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -257,21 +257,15 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int =
br, int max_br)
>  static int lp855x_bl_update_status(struct backlight_device *bl)
>  {
>  	struct lp855x *lp =3D bl_get_data(bl);
> +	int brightness =3D bl->props.brightness;
> =20
>  	if (bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
> -		bl->props.brightness =3D 0;
> +		brightness =3D 0;
> =20
> -	if (lp->mode =3D PWM_BASED) {
> -		int br =3D bl->props.brightness;
> -		int max_br =3D bl->props.max_brightness;
> -
> -		lp855x_pwm_ctrl(lp, br, max_br);
> -
> -	} else if (lp->mode =3D REGISTER_BASED) {
> -		u8 val =3D bl->props.brightness;
> -
> -		lp855x_write_byte(lp, lp->cfg->reg_brightness, val);
> -	}
> +	if (lp->mode =3D PWM_BASED)
> +		lp855x_pwm_ctrl(lp, brightness, bl->props.max_brightness);
> +	else if (lp->mode =3D REGISTER_BASED)
> +		lp855x_write_byte(lp, lp->cfg->reg_brightness, (u8)brightness);
> =20
>  	return 0;
>  }

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 26 Oct 2016 12:13:29 +0000
Subject: Re: [PATCH 2/2] backlight: pwm_bl: Check the pwm state for initial backlight power state
Message-Id: <20161026121329.GR8574@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160930070259.5710-1-peter.ujfalusi@ti.com>
 <20160930070259.5710-3-peter.ujfalusi@ti.com>
In-Reply-To: <20160930070259.5710-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: thierry.reding@gmail.com, jingoohan1@gmail.com, tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de

On Fri, 30 Sep 2016, Peter Ujfalusi wrote:

> If the pwm is not enabled the backlight initially should not be enabled
> either if we have booted with DT and there is a phandle pointing to the
> backlight node.
>=20
> The patch extends the checks to decide if we should keep the backlight off
> initially.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 4 ++++
>  1 file changed, 4 insertions(+)

Makes sense to me.

I'm going to apply this until someone screams at me.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 9bc4715bf116..e4326bbf807f 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -223,6 +223,10 @@ static int pwm_backlight_initial_power_state(const s=
truct pwm_bl_data *pb)
>  	if (!regulator_is_enabled(pb->power_supply))
>  		return FB_BLANK_POWERDOWN;
> =20
> +	/* The pwm is disabled, keep it like this */
> +	if (!pwm_is_enabled(pb->pwm))
> +		return FB_BLANK_POWERDOWN;
> +
>  	return FB_BLANK_UNBLANK;
>  }
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

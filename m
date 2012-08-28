From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 28 Aug 2012 07:37:44 +0000
Subject: Re: [PATCH] pwm-imx: Fix config / enable / disable
Message-Id: <20120828073744.GU26594@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120823191108.GB8127@avionic-0098.mockup.avionic-design.de>
 <1305545087.2775440.1345755837651.JavaMail.root@advansee.com>
In-Reply-To: <1305545087.2775440.1345755837651.JavaMail.root@advansee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 23, 2012 at 11:03:57PM +0200, Beno=EEt Th=E9baudeau wrote:
> imx_pwm_config() did not enable the PWM IP clock while accessing the regi=
sters.
> Hence, a call to pwm_config() had no effect before pwm_enable() had been =
called,
> which does not comply to the PWM API.
>=20
> Moreover, calling pwm_disable() then pwm_enable() must be a transparent
> operation.
>=20
> This fixes the first setting of brightness through sysfs that had no effe=
ct with
> leds-pwm.

I don't really like this patch. I'd like to have this one first, it
makes further cleanups easier:

https://lkml.org/lkml/2012/8/28/24

Simililarly, we should probably introduce a imx_pwm_[en|dis]able_v[12]

Then, the pwm core already makes sure that pwm_enable/disable are called
only once, so the if (imx->clk_enabled) in pwm_enable/disable is
unnecessary.

Sascha

>=20
> Cc: Thierry Reding <thierry.reding@avionic-design.de>
> Cc: <linux-kernel@vger.kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: Beno=EEt Th=E9baudeau <benoit.thebaudeau@advansee.com>
> Signed-off-by: Beno=EEt Th=E9baudeau <benoit.thebaudeau@advansee.com>
> ---
>  .../drivers/pwm/pwm-imx.c                          |   55 ++++++++++++++=
+-----
>  1 file changed, 43 insertions(+), 12 deletions(-)
>=20
> diff --git linux-next-c94456b.orig/drivers/pwm/pwm-imx.c linux-next-c9445=
6b/drivers/pwm/pwm-imx.c
> index 2a0b353..0519bf2 100644
> --- linux-next-c94456b.orig/drivers/pwm/pwm-imx.c
> +++ linux-next-c94456b/drivers/pwm/pwm-imx.c
> @@ -55,6 +55,16 @@ static int imx_pwm_config(struct pwm_chip *chip,
>  {
>  	struct imx_chip *imx =3D to_imx_chip(chip);
> =20
> +	/*
> +	 * If the PWM is disabled, make sure to turn on the clock before
> +	 * accessing the registers.
> +	 */
> +	if (!imx->clk_enabled) {
> +		int rc =3D clk_prepare_enable(imx->clk);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	if (!(cpu_is_mx1() || cpu_is_mx21())) {
>  		unsigned long long c;
>  		unsigned long period_cycles, duty_cycles, prescale;
> @@ -85,8 +95,11 @@ static int imx_pwm_config(struct pwm_chip *chip,
>  		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> =20
>  		cr =3D MX3_PWMCR_PRESCALER(prescale) |
> -			MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
> -			MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
> +			MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN | MX3_PWMCR_DBGEN;
> +
> +		/* If the PWM is enabled, keep it so. */
> +		if (imx->clk_enabled)
> +			cr |=3D MX3_PWMCR_EN;
> =20
>  		if (cpu_is_mx25())
>  			cr |=3D MX3_PWMCR_CLKSRC_IPG;
> @@ -118,32 +131,50 @@ static int imx_pwm_config(struct pwm_chip *chip,
>  		BUG();
>  	}
> =20
> +	/* If the PWM is disabled, turn the clock off again to save power. */
> +	if (!imx->clk_enabled)
> +		clk_disable_unprepare(imx->clk);
> +
>  	return 0;
>  }
> =20
>  static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct imx_chip *imx =3D to_imx_chip(chip);
> -	int rc =3D 0;
> +	int rc;
> =20
> -	if (!imx->clk_enabled) {
> -		rc =3D clk_prepare_enable(imx->clk);
> -		if (!rc)
> -			imx->clk_enabled =3D 1;
> +	if (imx->clk_enabled)
> +		return 0;
> +
> +	rc =3D clk_prepare_enable(imx->clk);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cpu_is_mx1() || cpu_is_mx21())) {
> +		u32 cr =3D readl(imx->mmio_base + MX3_PWMCR);
> +		cr |=3D MX3_PWMCR_EN;
> +		writel(cr, imx->mmio_base + MX3_PWMCR);
>  	}
> -	return rc;
> +
> +	imx->clk_enabled =3D 1;
> +	return 0;
>  }
> =20
>  static void imx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pw=
m)
>  {
>  	struct imx_chip *imx =3D to_imx_chip(chip);
> =20
> -	writel(0, imx->mmio_base + MX3_PWMCR);
> +	if (!imx->clk_enabled)
> +		return;
> =20
> -	if (imx->clk_enabled) {
> -		clk_disable_unprepare(imx->clk);
> -		imx->clk_enabled =3D 0;
> +	if (!(cpu_is_mx1() || cpu_is_mx21())) {
> +		u32 cr =3D readl(imx->mmio_base + MX3_PWMCR);
> +		cr &=3D ~MX3_PWMCR_EN;
> +		writel(cr, imx->mmio_base + MX3_PWMCR);
>  	}
> +
> +	clk_disable_unprepare(imx->clk);
> +	imx->clk_enabled =3D 0;
>  }
> =20
>  static struct pwm_ops imx_pwm_ops =3D {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

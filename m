From: Marek Vasut <marex@denx.de>
Date: Sun, 28 Oct 2012 21:53:14 +0000
Subject: Re: [PATCH] lms283gf05: add suspend/resume handlers
Message-Id: <201210282253.14426.marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351439357-9843-1-git-send-email-anarsoul@gmail.com>
In-Reply-To: <1351439357-9843-1-git-send-email-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Dear Vasily Khoruzhick,

> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/video/backlight/lms283gf05.c | 42
> ++++++++++++++++++++++++++++++++++++ 1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/video/backlight/lms283gf05.c
> b/drivers/video/backlight/lms283gf05.c index ea43f22..ed15752 100644
> --- a/drivers/video/backlight/lms283gf05.c
> +++ b/drivers/video/backlight/lms283gf05.c
> @@ -22,6 +22,7 @@
>  struct lms283gf05_state {
>  	struct spi_device	*spi;
>  	struct lcd_device	*ld;
> +	unsigned int		power;
>  };
> 
>  struct lms283gf05_seq {
> @@ -130,6 +131,8 @@ static int lms283gf05_power_set(struct lcd_device *ld,
> int power) struct spi_device *spi = st->spi;
>  	struct lms283gf05_pdata *pdata = spi->dev.platform_data;
> 
> +	st->power = power;
> +
>  	if (power <= FB_BLANK_NORMAL) {
>  		if (pdata)
>  			lms283gf05_reset(pdata->reset_gpio,
> @@ -193,6 +196,43 @@ static int __devinit lms283gf05_probe(struct
> spi_device *spi) return 0;
>  }
> 
> +#if defined(CONFIG_PM)
> +static unsigned int before_power;

NAK, this won't work if you have two different LCDs connected, use private data.

> +static int lms283gf05_suspend(struct spi_device *spi, pm_message_t mesg)
> +{
> +	int ret = 0;

Redundant assignment.

> +	struct lms283gf05_state *state = dev_get_drvdata(&spi->dev);
> +
> +	dev_dbg(&spi->dev, "lcd->power = %d\n", state->power);
> +
> +	before_power = state->power;
> +
> +	/*
> +	 * when lcd panel is suspend, lcd panel becomes off
> +	 * regardless of status.
> +	 */
> +	ret = lms283gf05_power_set(state->ld, FB_BLANK_POWERDOWN);

Why not just return lms...(); ?

> +	return ret;
> +}
> +
> +static int lms283gf05_resume(struct spi_device *spi)
> +{
> +	int ret = 0;

Redundant assignment.

> +	struct lms283gf05_state *state = dev_get_drvdata(&spi->dev);
> +
> +	dev_dbg(&spi->dev, "before_power = %d\n", before_power);
> +
> +	ret = lms283gf05_power_set(state->ld, before_power);
> +
> +	return ret;
> +}
> +#else
> +#define lms283gf05_suspend	NULL
> +#define lms283gf05_resume	NULL
> +#endif
> +
>  static int __devexit lms283gf05_remove(struct spi_device *spi)
>  {
>  	struct lms283gf05_state *st = dev_get_drvdata(&spi->dev);
> @@ -209,6 +249,8 @@ static struct spi_driver lms283gf05_driver = {
>  	},
>  	.probe		= lms283gf05_probe,
>  	.remove		= __devexit_p(lms283gf05_remove),
> +	.suspend	= lms283gf05_suspend,
> +	.resume		= lms283gf05_resume,
>  };
> 
>  module_spi_driver(lms283gf05_driver);

Best regards,
Marek Vasut

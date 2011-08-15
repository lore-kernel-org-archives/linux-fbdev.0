From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 15 Aug 2011 06:42:42 +0000
Subject: Re: [PATCH] backlight: Fix broken regulator API usage in l4f00242t03
Message-Id: <20110815064242.GR31404@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313372500-28017-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1313372500-28017-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Aug 15, 2011 at 10:41:40AM +0900, Mark Brown wrote:
> The regulator support in the l4f00242t03 is very non-idiomatic, rather
> than requesting the regulators based on the device name and the supply
> names used by the device the driver requires boards to pass system
> specific supply names around through platform data. The driver also
> conditionally requests the regulators based on this platform data, adding
> unneeded conditional code to the driver.
> 
> Fix this by removing the platform data and converting to the standard idiom,
> also updating all in tree users of the driver. As no datasheet appears to
> be available for the LCD I'm guessing the names for the supplies based on
> the existing users and I've no ability to do anything more than compile
> test.
> 
> The use of regulator_set_voltage() in the driver is also problematic, since
> fixed voltages are required the expectation would be that the voltages
> would be fixed in the constraints set by the machines rather than manually
> configured by the driver, but is less problematic.
> 
>  static int l4f00242t03_lcd_power_get(struct lcd_device *ld)
> @@ -202,24 +195,18 @@ static int __devinit l4f00242t03_probe(struct spi_device *spi)
>  	if (ret)
>  		goto err3;
>  
> -	if (pdata->io_supply) {
> -		priv->io_reg = regulator_get(NULL, pdata->io_supply);
> -
> -		if (IS_ERR(priv->io_reg)) {
> -			pr_err("%s: Unable to get the IO regulator\n",
> -								__func__);
> -			goto err3;
> -		}
> +	priv->io_reg = regulator_get(&spi->dev, "vdd");
> +	if (IS_ERR(priv->io_reg)) {
> +		pr_err("%s: Unable to get the IO regulator\n",
> +		       __func__);
> +		goto err3;
>  	}
>  
> -	if (pdata->core_supply) {
> -		priv->core_reg = regulator_get(NULL, pdata->core_supply);
> -
> -		if (IS_ERR(priv->core_reg)) {
> -			pr_err("%s: Unable to get the core regulator\n",
> -								__func__);
> -			goto err4;
> -		}
> +	priv->core_reg = regulator_get(&spi->dev, "vcore");
> +	if (IS_ERR(priv->core_reg)) {
> +		pr_err("%s: Unable to get the core regulator\n",
> +		       __func__);
> +		goto err4;
>  	}

Maybe you could change these pr_err to dev_err on the way. The rest of
the driver already uses dev_*.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

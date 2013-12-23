From: Shawn Guo <shawn.guo@linaro.org>
Date: Mon, 23 Dec 2013 08:21:09 +0000
Subject: Re: [PATCH] video: imxfb: Use regulator API with LCD class for powering
Message-Id: <20131223082107.GF26070@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387624080-15312-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1387624080-15312-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Dec 21, 2013 at 03:08:00PM +0400, Alexander Shiyan wrote:
> This patch replaces custom lcd_power() callback with
> regulator API over LCD class.

FYI.  Denis' effort on this already goes to v13.

http://thread.gmane.org/gmane.linux.ports.arm.kernel/285326

Shawn

> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../devicetree/bindings/video/fsl,imx-fb.txt       |  1 +
>  arch/arm/mach-imx/mach-mx27ads.c                   | 55 +++++++++++++++--
>  drivers/video/imxfb.c                              | 71 +++++++++++++++++++---
>  include/linux/platform_data/video-imxfb.h          |  1 -
>  4 files changed, 114 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> index 46da08d..e6b1ee9 100644
> --- a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> +++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> @@ -15,6 +15,7 @@ Required nodes:
>  	- fsl,pcr: LCDC PCR value
>  
>  Optional properties:
> +- lcd-supply: Regulator for LCD supply voltage.
>  - fsl,dmacr: DMA Control Register value. This is optional. By default, the
>  	register is not modified as recommended by the datasheet.
>  - fsl,lscr1: LCDC Sharp Configuration Register value.
> diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
> index 9821b824..a7a4a9c 100644
> --- a/arch/arm/mach-imx/mach-mx27ads.c
> +++ b/arch/arm/mach-imx/mach-mx27ads.c
> @@ -21,6 +21,10 @@
>  #include <linux/mtd/physmap.h>
>  #include <linux/i2c.h>
>  #include <linux/irq.h>
> +
> +#include <linux/regulator/fixed.h>
> +#include <linux/regulator/machine.h>
> +
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
> @@ -195,14 +199,58 @@ static const struct imxi2c_platform_data mx27ads_i2c1_data __initconst = {
>  static struct i2c_board_info mx27ads_i2c_devices[] = {
>  };
>  
> -void lcd_power(int on)
> +static void vgpio_set(struct gpio_chip *chip, unsigned offset, int value)
>  {
> -	if (on)
> +	if (value)
>  		__raw_writew(PBC_BCTRL1_LCDON, PBC_BCTRL1_SET_REG);
>  	else
>  		__raw_writew(PBC_BCTRL1_LCDON, PBC_BCTRL1_CLEAR_REG);
>  }
>  
> +static int vgpio_dir_out(struct gpio_chip *chip, unsigned offset, int value)
> +{
> +	return 0;
> +}
> +
> +#define MX27ADS_LCD_GPIO	(6 * 32)
> +
> +static struct regulator_consumer_supply mx27ads_lcd_regulator_consumer > +	REGULATOR_SUPPLY("lcd", "imx-fb.0");
> +
> +static struct regulator_init_data mx27ads_lcd_regulator_init_data = {
> +	.constraints	= {
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
> +},
> +	.consumer_supplies	= &mx27ads_lcd_regulator_consumer,
> +	.num_consumer_supplies	= 1,
> +};
> +
> +static struct fixed_voltage_config mx27ads_lcd_regulator_pdata = {
> +	.supply_name	= "LCD",
> +	.microvolts	= 3300000,
> +	.gpio		= MX27ADS_LCD_GPIO,
> +	.init_data	= &mx27ads_lcd_regulator_init_data,
> +};
> +
> +static void __init mx27ads_regulator_init(void)
> +{
> +	struct gpio_chip *vchip;
> +
> +	vchip = kzalloc(sizeof(*vchip), GFP_KERNEL);
> +	vchip->owner		= THIS_MODULE;
> +	vchip->label		= "LCD";
> +	vchip->base		= MX27ADS_LCD_GPIO;
> +	vchip->ngpio		= 1;
> +	vchip->direction_output	= vgpio_dir_out;
> +	vchip->set		= vgpio_set;
> +	gpiochip_add(vchip);
> +
> +	platform_device_register_data(&platform_bus, "reg-fixed-voltage",
> +				      PLATFORM_DEVID_AUTO,
> +				      &mx27ads_lcd_regulator_pdata,
> +				      sizeof(mx27ads_lcd_regulator_pdata));
> +}
> +
>  static struct imx_fb_videomode mx27ads_modes[] = {
>  	{
>  		.mode = {
> @@ -239,8 +287,6 @@ static const struct imx_fb_platform_data mx27ads_fb_data __initconst = {
>  	.pwmr		= 0x00A903FF,
>  	.lscr1		= 0x00120300,
>  	.dmacr		= 0x00020010,
> -
> -	.lcd_power	= lcd_power,
>  };
>  
>  static int mx27ads_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
> @@ -304,6 +350,7 @@ static void __init mx27ads_board_init(void)
>  	i2c_register_board_info(1, mx27ads_i2c_devices,
>  				ARRAY_SIZE(mx27ads_i2c_devices));
>  	imx27_add_imx_i2c(1, &mx27ads_i2c1_data);
> +	mx27ads_regulator_init();
>  	imx27_add_imx_fb(&mx27ads_fb_data);
>  	imx27_add_mxc_mmc(0, &sdhc1_pdata);
>  	imx27_add_mxc_mmc(1, &sdhc2_pdata);
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index 44ee678..e50b67f 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -30,10 +30,13 @@
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
> +#include <linux/lcd.h>
>  #include <linux/math64.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  
> +#include <linux/regulator/consumer.h>
> +
>  #include <video/of_display_timing.h>
>  #include <video/of_videomode.h>
>  #include <video/videomode.h>
> @@ -177,8 +180,9 @@ struct imxfb_info {
>  	struct backlight_device *bl;
>  #endif
>  
> -	void (*lcd_power)(int);
>  	void (*backlight_power)(int);
> +
> +	struct regulator	*lcd_pwr;
>  };
>  
>  static struct platform_device_id imxfb_devtype[] = {
> @@ -591,8 +595,6 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
>  
>  	if (fbi->backlight_power)
>  		fbi->backlight_power(1);
> -	if (fbi->lcd_power)
> -		fbi->lcd_power(1);
>  }
>  
>  static void imxfb_disable_controller(struct imxfb_info *fbi)
> @@ -604,8 +606,6 @@ static void imxfb_disable_controller(struct imxfb_info *fbi)
>  
>  	if (fbi->backlight_power)
>  		fbi->backlight_power(0);
> -	if (fbi->lcd_power)
> -		fbi->lcd_power(0);
>  
>  	clk_disable_unprepare(fbi->clk_per);
>  	clk_disable_unprepare(fbi->clk_ipg);
> @@ -796,7 +796,6 @@ static int imxfb_init_fbinfo(struct platform_device *pdev)
>  		fbi->lscr1			= pdata->lscr1;
>  		fbi->dmacr			= pdata->dmacr;
>  		fbi->pwmr			= pdata->pwmr;
> -		fbi->lcd_power			= pdata->lcd_power;
>  		fbi->backlight_power		= pdata->backlight_power;
>  	} else {
>  		np = pdev->dev.of_node;
> @@ -810,9 +809,6 @@ static int imxfb_init_fbinfo(struct platform_device *pdev)
>  
>  		of_property_read_u32(np, "fsl,dmacr", &fbi->dmacr);
>  
> -		/* These two function pointers could be used by some specific
> -		 * platforms. */
> -		fbi->lcd_power = NULL;
>  		fbi->backlight_power = NULL;
>  	}
>  
> @@ -856,9 +852,50 @@ static int imxfb_of_read_mode(struct device *dev, struct device_node *np,
>  	return 0;
>  }
>  
> +static int imxfb_lcd_check_fb(struct lcd_device *lcddev, struct fb_info *fi)
> +{
> +	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
> +
> +	if (!fi || fi->par = fbi)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int imxfb_lcd_get_power(struct lcd_device *lcddev)
> +{
> +	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
> +
> +	if (!IS_ERR(fbi->lcd_pwr))
> +		return regulator_is_enabled(fbi->lcd_pwr);
> +
> +	return 1;
> +}
> +
> +static int imxfb_lcd_set_power(struct lcd_device *lcddev, int power)
> +{
> +	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
> +
> +	if (!IS_ERR(fbi->lcd_pwr)) {
> +		if (power)
> +			return regulator_enable(fbi->lcd_pwr);
> +		else
> +			return regulator_disable(fbi->lcd_pwr);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct lcd_ops imxfb_lcd_ops = {
> +	.check_fb	= imxfb_lcd_check_fb,
> +	.get_power	= imxfb_lcd_get_power,
> +	.set_power	= imxfb_lcd_set_power,
> +};
> +
>  static int imxfb_probe(struct platform_device *pdev)
>  {
>  	struct imxfb_info *fbi;
> +	struct lcd_device *lcd;
>  	struct fb_info *info;
>  	struct imx_fb_platform_data *pdata;
>  	struct resource *res;
> @@ -1020,6 +1057,19 @@ static int imxfb_probe(struct platform_device *pdev)
>  		goto failed_register;
>  	}
>  
> +	fbi->lcd_pwr = devm_regulator_get(&pdev->dev, "lcd");
> +	if (IS_ERR(fbi->lcd_pwr) && (PTR_ERR(fbi->lcd_pwr) = -EPROBE_DEFER)) {
> +		ret = -EPROBE_DEFER;
> +		goto failed_lcd;
> +	}
> +
> +	lcd = devm_lcd_device_register(&pdev->dev, "imxfb-lcd", &pdev->dev, fbi,
> +				       &imxfb_lcd_ops);
> +	if (IS_ERR(lcd)) {
> +		ret = PTR_ERR(lcd);
> +		goto failed_lcd;
> +	}
> +
>  	imxfb_enable_controller(fbi);
>  	fbi->pdev = pdev;
>  #ifdef PWMR_BACKLIGHT_AVAILABLE
> @@ -1028,6 +1078,9 @@ static int imxfb_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +failed_lcd:
> +	unregister_framebuffer(info);
> +
>  failed_register:
>  	fb_dealloc_cmap(&info->cmap);
>  failed_cmap:
> diff --git a/include/linux/platform_data/video-imxfb.h b/include/linux/platform_data/video-imxfb.h
> index 9de8f06..8902706 100644
> --- a/include/linux/platform_data/video-imxfb.h
> +++ b/include/linux/platform_data/video-imxfb.h
> @@ -76,7 +76,6 @@ struct imx_fb_platform_data {
>  	int (*init)(struct platform_device *);
>  	void (*exit)(struct platform_device *);
>  
> -	void (*lcd_power)(int);
>  	void (*backlight_power)(int);
>  };
>  
> -- 
> 1.8.3.2
> 


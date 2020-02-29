From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Date: Sat, 29 Feb 2020 16:51:22 +0000
Subject: Re: [PATCH] ARM/fbdev: sa11x0: Switch to use GPIO descriptors
Message-Id: <20200229165122.GC25745@shell.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200229163441.90639-1-linus.walleij@linaro.org>
In-Reply-To: <20200229163441.90639-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Sat, Feb 29, 2020 at 05:34:41PM +0100, Linus Walleij wrote:
> This converts the SA11x0 frame buffer driver to use
> GPIO descriptors. Get the GPIO optional and register
> a look-up table specifically for the Shannon machine.

I don't think this GPIO should be named "enable" - while the placement
may be correct for Shannon, it's not true for all the other platforms
that twiddle enable GPIOs for the LCD.  Shannon's LCD enable control
is specific to Shannon and nothing else.

> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-sa1100/shannon.c |  9 +++++++++
>  drivers/video/fbdev/sa1100fb.c | 20 +++++++++-----------
>  drivers/video/fbdev/sa1100fb.h |  3 +++
>  3 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
> index 5bc82e2671c6..f1f825ed0b3a 100644
> --- a/arch/arm/mach-sa1100/shannon.c
> +++ b/arch/arm/mach-sa1100/shannon.c
> @@ -104,6 +104,14 @@ static struct fixed_voltage_config shannon_cf_vcc_pdata __initdata = {
>  	.enabled_at_boot = 1,
>  };
>  
> +static struct gpiod_lookup_table shannon_display_gpio_table = {
> +	.dev_id = "sa11x0-fb",
> +	.table = {
> +		GPIO_LOOKUP("gpio", 22, "enable", GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
> +};
> +
>  static void __init shannon_init(void)
>  {
>  	sa11x0_register_fixed_regulator(0, &shannon_cf_vcc_pdata,
> @@ -113,6 +121,7 @@ static void __init shannon_init(void)
>  	sa11x0_register_pcmcia(0, &shannon_pcmcia0_gpio_table);
>  	sa11x0_register_pcmcia(1, &shannon_pcmcia1_gpio_table);
>  	sa11x0_ppc_configure_mcp();
> +	gpiod_add_lookup_table(&shannon_display_gpio_table);
>  	sa11x0_register_lcd(&shannon_lcd_info);
>  	sa11x0_register_mtd(&shannon_flash_data, &shannon_flash_resource, 1);
>  	sa11x0_register_mcp(&shannon_mcp_data);
> diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
> index 5bb653db0cec..cdea3b31a54f 100644
> --- a/drivers/video/fbdev/sa1100fb.c
> +++ b/drivers/video/fbdev/sa1100fb.c
> @@ -173,7 +173,7 @@
>  #include <linux/init.h>
>  #include <linux/ioport.h>
>  #include <linux/cpufreq.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/mutex.h>
> @@ -799,8 +799,8 @@ static void sa1100fb_enable_controller(struct sa1100fb_info *fbi)
>  	writel_relaxed(fbi->dbar2, fbi->base + DBAR2);
>  	writel_relaxed(fbi->reg_lccr0 | LCCR0_LEN, fbi->base + LCCR0);
>  
> -	if (machine_is_shannon())
> -		gpio_set_value(SHANNON_GPIO_DISP_EN, 1);
> +	if (fbi->enable)
> +		gpiod_set_value(fbi->enable, 1);
>  
>  	dev_dbg(fbi->dev, "DBAR1: 0x%08x\n", readl_relaxed(fbi->base + DBAR1));
>  	dev_dbg(fbi->dev, "DBAR2: 0x%08x\n", readl_relaxed(fbi->base + DBAR2));
> @@ -817,8 +817,8 @@ static void sa1100fb_disable_controller(struct sa1100fb_info *fbi)
>  
>  	dev_dbg(fbi->dev, "Disabling LCD controller\n");
>  
> -	if (machine_is_shannon())
> -		gpio_set_value(SHANNON_GPIO_DISP_EN, 0);
> +	if (fbi->enable)
> +		gpiod_set_value(fbi->enable, 0);
>  
>  	set_current_state(TASK_UNINTERRUPTIBLE);
>  	add_wait_queue(&fbi->ctrlr_wait, &wait);
> @@ -1173,12 +1173,10 @@ static int sa1100fb_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	if (machine_is_shannon()) {
> -		ret = devm_gpio_request_one(&pdev->dev, SHANNON_GPIO_DISP_EN,
> -			GPIOF_OUT_INIT_LOW, "display enable");
> -		if (ret)
> -			return ret;
> -	}
> +	fbi->enable = gpiod_get_optional(&pdev->dev, "enable",
> +					 GPIOD_OUT_LOW);
> +	if (IS_ERR(fbi->enable))
> +		return PTR_ERR(fbi->enable);
>  
>  	/* Initialize video memory */
>  	ret = sa1100fb_map_video_memory(fbi);
> diff --git a/drivers/video/fbdev/sa1100fb.h b/drivers/video/fbdev/sa1100fb.h
> index d0aa33b0b88a..9711bbcd6e99 100644
> --- a/drivers/video/fbdev/sa1100fb.h
> +++ b/drivers/video/fbdev/sa1100fb.h
> @@ -10,6 +10,8 @@
>   * for more details.
>   */
>  
> +struct gpio_desc;
> +
>  #define LCCR0           0x0000          /* LCD Control Reg. 0 */
>  #define LCSR            0x0004          /* LCD Status Reg. */
>  #define DBAR1           0x0010          /* LCD DMA Base Address Reg. channel 1 */
> @@ -33,6 +35,7 @@ struct sa1100fb_info {
>  	struct device		*dev;
>  	const struct sa1100fb_rgb *rgb[NR_RGB];
>  	void __iomem		*base;
> +	struct gpio_desc	*enable;
>  
>  	/*
>  	 * These are the addresses we mapped
> -- 
> 2.24.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

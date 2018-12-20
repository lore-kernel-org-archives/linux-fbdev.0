From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Thu, 20 Dec 2018 12:35:05 +0000
Subject: Re: [PATCH v2 4/4] ARM: mxs: cfa10036: Fixup OLED display reset polarity
Message-Id: <20181220123505.GH2188@piout.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
 <1545308005-51559-5-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1545308005-51559-5-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Rob Herring <robh+dt@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Maxime Ripard <maxime.ripard@bootlin.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 20/12/2018 12:13:57+0000, Vokáč Michal wrote:
> There was a bug in reset signal generation in ssd1307fb OLED driver.
> The display needs an active-low reset signal but the driver produced
> the correct sequence only if the GPIO used for reset was specified as
> GPIO_ACTIVE_HIGH.
> 
> Now as the OLED driver is fixed it is also necessarry to implement
> a fixup for all current users of the old DT ABI. There is only one
> in-tree user and that is the Crystalfontz CFA-10036 board. In case
> this board is booting and GPIO_ACTIVE_HIGH is used for reset we
> override it to GPIO_ACTIVE_LOW.
> 

Honestly, the platform has been discontinued and I don't really think
it is worth having that fixup in the tree forever.

> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> Changes from v1:
>  - Add R-by from Rob
>  - Use of_property_read_variable_u32_array to read the GPIO specifier
>    array instead of reading it manualy in for cycle. (Rob)
> 
>  arch/arm/mach-mxs/mach-mxs.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 1c6062d..50038d6 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -21,6 +21,7 @@
>  #include <linux/reboot.h>
>  #include <linux/micrel_phy.h>
>  #include <linux/of_address.h>
> +#include <linux/of_gpio.h>
>  #include <linux/of_platform.h>
>  #include <linux/phy.h>
>  #include <linux/pinctrl/consumer.h>
> @@ -268,9 +269,52 @@ static void __init apx4devkit_init(void)
>  					   apx4devkit_phy_fixup);
>  }
>  
> +#define OLED_RESET_GPIO_LEN	3
> +#define OLED_RESET_GPIO_SIZE	(OLED_RESET_GPIO_LEN * sizeof(u32))
> +
> +static void __init crystalfontz_oled_reset_fixup(void)
> +{
> +	struct property *newgpio;
> +	struct device_node *np;
> +	u32 *gpiospec;
> +	int ret;
> +
> +	np = of_find_compatible_node(NULL, NULL, "solomon,ssd1306fb-i2c");
> +	if (!np)
> +		return;
> +
> +	newgpio = kzalloc(sizeof(*newgpio) + OLED_RESET_GPIO_SIZE, GFP_KERNEL);
> +	if (!newgpio)
> +		return;
> +
> +	newgpio->value = newgpio + 1;
> +	newgpio->length = OLED_RESET_GPIO_SIZE;
> +	newgpio->name = kstrdup("reset-gpios", GFP_KERNEL);
> +	if (!newgpio->name) {
> +		kfree(newgpio);
> +		return;
> +	}
> +
> +	gpiospec = newgpio->value;
> +	ret = of_property_read_variable_u32_array(np, "reset-gpios", gpiospec,
> +						  OLED_RESET_GPIO_LEN, 0);
> +
> +	if (ret < 0) {
> +		kfree(newgpio);
> +		return;
> +	}
> +
> +	if (!(gpiospec[2] & OF_GPIO_ACTIVE_LOW)) {
> +		gpiospec[2] |= OF_GPIO_ACTIVE_LOW;
> +		cpu_to_be32_array(gpiospec, gpiospec, OLED_RESET_GPIO_LEN);
> +		of_update_property(np, newgpio);
> +	}
> +}
> +
>  static void __init crystalfontz_init(void)
>  {
>  	update_fec_mac_prop(OUI_CRYSTALFONTZ);
> +	crystalfontz_oled_reset_fixup();
>  }
>  
>  static void __init duckbill_init(void)
> -- 
> 2.1.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

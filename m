From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 08 Aug 2012 18:58:54 +0000
Subject: Re: [PATCH 6/8] arm: vt8500: Update arch-vt8500 to devicetree support.
Message-Id: <5022B6EE.7060006@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
 <1344389967-8465-7-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1344389967-8465-7-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/07/2012 07:39 PM, Tony Prisk wrote:
> Merged existing board files to a single dt-capable file.
> Converted irq and timer code to devicetree.
> Removed existing device files that are no longer required with
> devicetree support.
>
> All existing platform devices are converted to devicetree nodes
> except GPIO and PWM.

Perhaps that also explains what I was commenting on in the GPIO driver
patch. Why not convert GPIO too?

> diff --git a/arch/arm/mach-vt8500/irq.c b/arch/arm/mach-vt8500/irq.c

>  /*
> - *  arch/arm/mach-vt8500/irq.c
> + *  arch/arm/mach-vt8500/irq_dt.c

This file didn't get renamed?

> diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c

> +void __init vt8500_init(void)
> +{
> +	struct device_node *np, *fb;
> +	void __iomem *gpio_base;
> +
> +#ifdef CONFIG_FB_VT8500
> +	fb = of_find_compatible_node(NULL, NULL, "via,vt8500-fb");
> +	if (fb) {
> +		np = of_find_compatible_node(NULL, NULL, "via,vt8500-gpio");
> +		if (np) {
> +			gpio_base = of_iomap(np, 0);
> +
> +			if (!gpio_base)
> +				pr_err("%s:of_iomap(gpio_mux) failed\n", __func__);
> +
> +			of_node_put(np);
> +		} else {
> +			gpio_base = ioremap(LEGACY_GPIO_BASE, 0x1000);
> +			if (!gpio_base)
> +				pr_err("%s:ioremap(legacy_gpio_mux) failed\n", __func__);
> +		}
> +		if (gpio_base) {
> +			writel(readl(gpio_base + VT8500_GPIO_MUX_REG) | 1,
> +				gpio_base + VT8500_GPIO_MUX_REG);
> +			iounmap(gpio_base);
> +		} else
> +			pr_err("%s: Could not remap GPIO mux\n", __func__);
> +
> +		of_node_put(fb);
> +	}
> +#endif

That looks quite suspicious. What's it doing? Is this something that
should be part of a pinctrl driver, or the GPIO driver?

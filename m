From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Fri, 12 Oct 2012 21:44:05 +0000
Subject: Re: [PATCH V5 1/2] video: exynos_dp: Add device tree support to DP driver
Message-Id: <50788F25.2040003@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350074859-23226-1-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1350074859-23226-1-git-send-email-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ajay Kumar <ajaykumar.rs@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, jg1.han@samsung.com, devicetree-discuss@lists.ozlabs.org, FlorianSchandinat@gmx.de, sylvester.nawrocki@gmail.com, tomasz.figa@gmail.com, thomas.ab@samsung.com

On 10/12/2012 10:47 PM, Ajay Kumar wrote:
> This patch enables device tree based discovery support for DP driver.
> The driver is modified to handle platform data in both the cases:
> with DT and non-DT.
> 
> Signed-off-by: Ajay Kumar<ajaykumar.rs@samsung.com>
> Acked-by: Jingoo Han<jg1.han@samsung.com>
> ---
>   drivers/video/exynos/exynos_dp_core.c |  161 ++++++++++++++++++++++++++++++---
>   drivers/video/exynos/exynos_dp_core.h |    2 +
>   2 files changed, 149 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index d55470e..62932ba 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -18,6 +18,7 @@
>   #include<linux/io.h>
>   #include<linux/interrupt.h>
>   #include<linux/delay.h>
> +#include<linux/of.h>
> 
>   #include<video/exynos_dp.h>
> 
> @@ -856,6 +857,99 @@ static irqreturn_t exynos_dp_irq_handler(int irq, void *arg)
>   	return IRQ_HANDLED;
>   }
> 
> +#ifdef CONFIG_OF
> +struct exynos_dp_platdata *exynos_dp_dt_parse_pdata(struct device *dev)
> +{
> +	struct device_node *dp_node = dev->of_node;
> +	struct exynos_dp_platdata *pd;
> +	struct video_info *dp_video_config;
> +
> +	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> +	if (!pd) {
> +		dev_err(dev, "memory allocation for pdata failed\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	dp_video_config = devm_kzalloc(dev,
> +				sizeof(*dp_video_config), GFP_KERNEL);
> +
> +	if (!dp_video_config) {
> +		dev_err(dev, "memory allocation for video config failed\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	pd->video_info = dp_video_config;
> +
> +	if (of_get_property(dp_node, "hsync-active-high", NULL))
> +		dp_video_config->h_sync_polarity = 1;
> +
> +	if (of_get_property(dp_node, "vsync-active-high", NULL))
> +		dp_video_config->v_sync_polarity = 1;
> +
> +	if (of_get_property(dp_node, "interlaced", NULL))
> +		dp_video_config->interlaced = 1;

of_property_read_bool() could also be used here.

> +
> +	of_property_read_u32(dp_node, "samsung,color-space",
> +				&dp_video_config->color_space);
> +
> +	of_property_read_u32(dp_node, "samsung,dynamic-range",
> +				&dp_video_config->dynamic_range);
> +
> +	of_property_read_u32(dp_node, "samsung,ycbcr-coeff",
> +				&dp_video_config->ycbcr_coeff);
> +
> +	of_property_read_u32(dp_node, "samsung,color-depth",
> +				&dp_video_config->color_depth);
> +
> +	of_property_read_u32(dp_node, "samsung,link-rate",
> +				&dp_video_config->link_rate);
> +
> +	of_property_read_u32(dp_node, "samsung,lane-count",
> +				&dp_video_config->lane_count);

Shouldn't it be checked whether all these required properties are present ? 
If someone forgets to specify any one the driver will silently ignore it,
not giving a clue what's wrong.

> +	return pd;
> +}
> +
> +void exynos_dp_dt_parse_phydata(struct exynos_dp_device *dp)
> +{
> +	struct device_node *dp_phy_node;
> +	u32 phy_base;
> +	void *virt_phy_base;
> +
> +	dp_phy_node = of_find_node_by_name(dp->dev->of_node, "dptx-phy");
> +	if (!dp_phy_node) {
> +		dp->dp_phy_addr = NULL;

Is this required ? You've allocated dp with kzalloc().

> +		return;
> +	}
> +
> +	of_property_read_u32(dp_phy_node, "reg",&phy_base);
> +	of_property_read_u32(dp_phy_node, "samsung,enable-mask",
> +							&dp->enable_mask);

I think you should check the return values, these are required properties.
Some error logs might be useful here.

> +	virt_phy_base = ioremap(phy_base, SZ_4);

How about assigning to dp->dp_phy_addr directly and gettting rid of
virt_phy_base ?

> +	if (!virt_phy_base) {
> +		dev_err(dp->dev, "failed to ioremap dp-phy\n");
> +		dp->dp_phy_addr = NULL;
> +		return;
> +	}
> +	dp->dp_phy_addr = virt_phy_base;
> +}
> +
> +void exynos_dp_phy_init(struct exynos_dp_device *dp)
> +{
> +	u32 reg;
> +
> +	reg = __raw_readl(dp->dp_phy_addr);
> +	reg |= dp->enable_mask;
> +	__raw_writel(reg, dp->dp_phy_addr);
> +}
> +
> +void exynos_dp_phy_exit(struct exynos_dp_device *dp)
> +{
> +	u32 reg;
> +
> +	reg = __raw_readl(dp->dp_phy_addr);
> +	reg&= ~(dp->enable_mask);
> +	__raw_writel(reg, dp->dp_phy_addr);
> +}
> +#endif /* CONFIG_OF */
> +
>   static int __devinit exynos_dp_probe(struct platform_device *pdev)
>   {
>   	struct resource *res;
> @@ -864,12 +958,6 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
> 
>   	int ret = 0;
> 
> -	pdata = pdev->dev.platform_data;
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "no platform data\n");
> -		return -EINVAL;
> -	}
> -
>   	dp = devm_kzalloc(&pdev->dev, sizeof(struct exynos_dp_device),
>   				GFP_KERNEL);
>   	if (!dp) {
> @@ -879,6 +967,21 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
> 
>   	dp->dev =&pdev->dev;
> 
> +	if (pdev->dev.of_node) {
> +		pdata = exynos_dp_dt_parse_pdata(&pdev->dev);
> +		if (IS_ERR(pdata))
> +			return PTR_ERR(pdata);
> +
> +		exynos_dp_dt_parse_phydata(dp);
> +	} else {
> +		pdata = pdev->dev.platform_data;
> +	}
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "no platform data\n");
> +		return -EINVAL;
> +	}
> +

This check is only reqired for non-dt case, might be worth to move
it under else statement above.

>   	dp->clock = devm_clk_get(&pdev->dev, "dp");
>   	if (IS_ERR(dp->clock)) {
>   		dev_err(&pdev->dev, "failed to get clock\n");
> @@ -909,8 +1012,14 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>   	}
> 
>   	dp->video_info = pdata->video_info;
> -	if (pdata->phy_init)
> -		pdata->phy_init();
> +
> +	if (pdev->dev.of_node) {
> +		if (dp->dp_phy_addr)
> +			exynos_dp_phy_init(dp);
> +	} else {
> +		if (pdata->phy_init)
> +			pdata->phy_init();
> +	}
> 
>   	exynos_dp_init_dp(dp);
> 
> @@ -953,8 +1062,13 @@ static int __devexit exynos_dp_remove(struct platform_device *pdev)
>   	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
>   	struct exynos_dp_device *dp = platform_get_drvdata(pdev);

This doesn't belong to your patch, but the above 2 lines could be written as:

  	struct exynos_dp_device *dp = dev_get_drvdata(&pdev->dev);

Same in functions exynos_dp_suspend() and exynos_dp_resume().

> 
> -	if (pdata&&  pdata->phy_exit)
> -		pdata->phy_exit();
> +	if (pdev->dev.of_node) {
> +		if (dp->dp_phy_addr)
> +			exynos_dp_phy_exit(dp);
> +	} else {
> +		if (pdata&&  pdata->phy_exit)
> +			pdata->phy_exit();
> +	}

It is not possible to have valid dp->dp_phy_addr pointer without
valid pdev->dev.of_node, is it ?

Can't this (and all similar occurrences) be simplified to:

	if (dp->dp_phy_addr)
		exynos_dp_phy_exit(dp);
	else if (pdata->phy_exit)
		pdata->phy_exit();
?

It just requires dp->dp_phy_addr being NULL for non-dt case. 
pdata is never NULL, otherwise probe() would have already failed.

>   	clk_disable_unprepare(dp->clock);
> 
> @@ -968,8 +1082,13 @@ static int exynos_dp_suspend(struct device *dev)
>   	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
>   	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
> 
> -	if (pdata&&  pdata->phy_exit)
> -		pdata->phy_exit();
> +	if (dev->of_node) {
> +		if (dp->dp_phy_addr)
> +			exynos_dp_phy_exit(dp);
> +	} else {
> +		if (pdata&&  pdata->phy_exit)
> +			pdata->phy_exit();
> +	}
> 
>   	clk_disable_unprepare(dp->clock);
> 
> @@ -982,8 +1101,13 @@ static int exynos_dp_resume(struct device *dev)
>   	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
>   	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
> 
> -	if (pdata&&  pdata->phy_init)
> -		pdata->phy_init();
> +	if (dev->of_node) {
> +		if (dp->dp_phy_addr)
> +			exynos_dp_phy_init(dp);
> +	} else {
> +		if (pdata&&  pdata->phy_init)
> +			pdata->phy_init();
> +	}
> 
>   	clk_prepare_enable(dp->clock);
> 
> @@ -1013,6 +1137,14 @@ static const struct dev_pm_ops exynos_dp_pm_ops = {
>   	SET_SYSTEM_SLEEP_PM_OPS(exynos_dp_suspend, exynos_dp_resume)
>   };
> 
> +#ifdef CONFIG_OF
> +static const struct of_device_id exynos_dp_match[] = {
> +	{ .compatible = "samsung,exynos5-dp" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, exynos_dp_match);
> +#endif
> +

How about just dropping this #ifdef, since you're using of_match_ptr() ?

>   static struct platform_driver exynos_dp_driver = {
>   	.probe		= exynos_dp_probe,
>   	.remove		= __devexit_p(exynos_dp_remove),
> @@ -1020,6 +1152,7 @@ static struct platform_driver exynos_dp_driver = {
>   		.name	= "exynos-dp",
>   		.owner	= THIS_MODULE,
>   		.pm	=&exynos_dp_pm_ops,
> +		.of_match_table = of_match_ptr(exynos_dp_match),
>   	},
>   };
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
> index 57b8a65..569858b 100644
> --- a/drivers/video/exynos/exynos_dp_core.h
> +++ b/drivers/video/exynos/exynos_dp_core.h
> @@ -29,6 +29,8 @@ struct exynos_dp_device {
>   	struct clk		*clock;
>   	unsigned int		irq;
>   	void __iomem		*reg_base;
> +	void __iomem		*dp_phy_addr;

Nit: "dp" is already within the structure name. How about just
     naming it phy_addr ? dp->phy_addr might look better than 
     dp->dp_phy_addr ;)

> +	unsigned int		enable_mask;
> 
>   	struct video_info	*video_info;
>   	struct link_train	link_train;

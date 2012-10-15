From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 15 Oct 2012 09:44:53 +0000
Subject: RE: [PATCH V6 1/2] video: exynos_dp: Add device tree support to DP driver
Message-Id: <00a101cdaab9$ba3f1360$2ebd3a20$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <009e01cdaab5$25cff2c0$716fd840$%han@samsung.com>
In-Reply-To: <009e01cdaab5$25cff2c0$716fd840$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, 'Ajay Kumar' <ajaykumar.rs@samsung.com>, 'Sylwester Nawrocki' <sylvester.nawrocki@gmail.com>, 'Tomasz Figa' <t.figa@samsung.com>, 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Jingoo Han' <jg1.han@samsung.com>

On Monday, October 15, 2012 6:12 PM Jingoo Han wrote
> 
> From: Ajay Kumar <ajaykumar.rs@samsung.com>
> 
> This patch enables device tree based discovery support for DP driver.
> The driver is modified to handle platform data in both the cases:
> with DT and non-DT.
> 
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> This patch is tested with Exynos5250.
> 
> Changes since v6:
> - Check return values of required properties
> - Replace dp_phy_addr with phy_addr
> - Remove unnecessary NULL deference checking for 'pdata'
> - Remove unncessary 'virt_phy_base' variable
> - Make functions static
> - Fix build errors when CONFIG_OF option is diabled
> - Add return values to exynos_dp_dt_parse_phydata()
> 
>  drivers/video/exynos/exynos_dp_core.c |  206 ++++++++++++++++++++++++++++++---
>  drivers/video/exynos/exynos_dp_core.h |    2 +
>  2 files changed, 194 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index d55470e..0d9c0ee 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -18,6 +18,7 @@
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/of.h>
> 
>  #include <video/exynos_dp.h>
> 
> @@ -856,6 +857,145 @@ static irqreturn_t exynos_dp_irq_handler(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
> 
> +#ifdef CONFIG_OF
> +static struct exynos_dp_platdata *exynos_dp_dt_parse_pdata(struct device *dev)
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
> +	dp_video_config->h_sync_polarity > +		of_property_read_bool(dp_node, "hsync-active-high");
> +
> +	dp_video_config->v_sync_polarity > +		of_property_read_bool(dp_node, "vsync-active-high");
> +
> +	dp_video_config->interlaced > +		of_property_read_bool(dp_node, "interlaced");
> +
> +	if (of_property_read_u32(dp_node, "samsung,color-space",
> +				&dp_video_config->color_space)) {
> +		dev_err(dev, "failed to get color-space\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (of_property_read_u32(dp_node, "samsung,dynamic-range",
> +				&dp_video_config->dynamic_range)) {
> +		dev_err(dev, "failed to get dynamic-range\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (of_property_read_u32(dp_node, "samsung,ycbcr-coeff",
> +				&dp_video_config->ycbcr_coeff)) {
> +		dev_err(dev, "failed to get ycbcr-coeff\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (of_property_read_u32(dp_node, "samsung,color-depth",
> +				&dp_video_config->color_depth)) {
> +		dev_err(dev, "failed to get color-depth\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (of_property_read_u32(dp_node, "samsung,link-rate",
> +				&dp_video_config->link_rate)) {
> +		dev_err(dev, "failed to get link-rate\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (of_property_read_u32(dp_node, "samsung,lane-count",
> +				&dp_video_config->lane_count)) {
> +		dev_err(dev, "failed to get lane-count\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return pd;
> +}
> +
> +static int exynos_dp_dt_parse_phydata(struct exynos_dp_device *dp)
> +{
> +	struct device_node *dp_phy_node;
> +	u32 phy_base;
> +
> +	dp_phy_node = of_find_node_by_name(dp->dev->of_node, "dptx-phy");
> +	if (!dp_phy_node) {
> +		dev_err(dp->dev, "could not find dptx-phy node\n");
> +		return -ENODEV;
> +	}
> +
> +	if (of_property_read_u32(dp_phy_node, "reg", &phy_base)) {
> +		dev_err(dp->dev, "faild to get reg for dptx-phy\n");
> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_u32(dp_phy_node, "samsung,enable-mask",
> +				&dp->enable_mask)) {
> +		dev_err(dp->dev, "faild to get enable-mask for dptx-phy\n");
> +		return -EINVAL;
> +	}
> +
> +	dp->phy_addr = ioremap(phy_base, SZ_4);
> +	if (!dp->phy_addr) {
> +		dev_err(dp->dev, "failed to ioremap dp-phy\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void exynos_dp_phy_init(struct exynos_dp_device *dp)
> +{
> +	u32 reg;
> +
> +	reg = __raw_readl(dp->phy_addr);
> +	reg |= dp->enable_mask;
> +	__raw_writel(reg, dp->phy_addr);
> +}
> +
> +static void exynos_dp_phy_exit(struct exynos_dp_device *dp)
> +{
> +	u32 reg;
> +
> +	reg = __raw_readl(dp->phy_addr);
> +	reg &= ~(dp->enable_mask);
> +	__raw_writel(reg, dp->phy_addr);
> +}
> +#else
> +static struct exynos_dp_platdata *exynos_dp_dt_parse_pdata(struct device *dev)
> +{
> +	return NULL;
> +}
> +
> +static int exynos_dp_dt_parse_phydata(struct exynos_dp_device *dp)
> +{
> +	return -EINVAL;
> +}
> +
> +static void exynos_dp_phy_init(struct exynos_dp_device *dp)
> +{
> +	return;
> +}
> +
> +static void exynos_dp_phy_exit(struct exynos_dp_device *dp)
> +{
> +	return;
> +}
> +#endif /* CONFIG_OF */
> +
>  static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> @@ -864,12 +1004,6 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
> 
>  	int ret = 0;
> 
> -	pdata = pdev->dev.platform_data;
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "no platform data\n");
> -		return -EINVAL;
> -	}
> -
>  	dp = devm_kzalloc(&pdev->dev, sizeof(struct exynos_dp_device),
>  				GFP_KERNEL);
>  	if (!dp) {
> @@ -879,6 +1013,22 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
> 
>  	dp->dev = &pdev->dev;
> 
> +	if (pdev->dev.of_node) {
> +		pdata = exynos_dp_dt_parse_pdata(&pdev->dev);
> +		if (IS_ERR(pdata))
> +			return PTR_ERR(pdata);
> +
> +		ret = exynos_dp_dt_parse_phydata(dp);
> +		if (!ret)

It should be 'if (ret)' instead of 'if (!ret)'.
It is my fault. I will send v7 patch, soon.

Sorry.

> +			return ret;
> +	} else {
> +		pdata = pdev->dev.platform_data;
> +		if (!pdata) {
> +			dev_err(&pdev->dev, "no platform data\n");
> +			return -EINVAL;
> +		}
> +	}
> +
>  	dp->clock = devm_clk_get(&pdev->dev, "dp");
>  	if (IS_ERR(dp->clock)) {
>  		dev_err(&pdev->dev, "failed to get clock\n");
> @@ -909,8 +1059,14 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  	}
> 
>  	dp->video_info = pdata->video_info;
> -	if (pdata->phy_init)
> -		pdata->phy_init();
> +
> +	if (pdev->dev.of_node) {
> +		if (dp->phy_addr)
> +			exynos_dp_phy_init(dp);
> +	} else {
> +		if (pdata->phy_init)
> +			pdata->phy_init();
> +	}
> 
>  	exynos_dp_init_dp(dp);
> 
> @@ -953,8 +1109,13 @@ static int __devexit exynos_dp_remove(struct platform_device *pdev)
>  	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
>  	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
> 
> -	if (pdata && pdata->phy_exit)
> -		pdata->phy_exit();
> +	if (pdev->dev.of_node) {
> +		if (dp->phy_addr)
> +			exynos_dp_phy_exit(dp);
> +	} else {
> +		if (pdata->phy_exit)
> +			pdata->phy_exit();
> +	}
> 
>  	clk_disable_unprepare(dp->clock);
> 
> @@ -968,8 +1129,13 @@ static int exynos_dp_suspend(struct device *dev)
>  	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
>  	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
> 
> -	if (pdata && pdata->phy_exit)
> -		pdata->phy_exit();
> +	if (dev->of_node) {
> +		if (dp->phy_addr)
> +			exynos_dp_phy_exit(dp);
> +	} else {
> +		if (pdata->phy_exit)
> +			pdata->phy_exit();
> +	}
> 
>  	clk_disable_unprepare(dp->clock);
> 
> @@ -982,8 +1148,13 @@ static int exynos_dp_resume(struct device *dev)
>  	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
>  	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
> 
> -	if (pdata && pdata->phy_init)
> -		pdata->phy_init();
> +	if (dev->of_node) {
> +		if (dp->phy_addr)
> +			exynos_dp_phy_init(dp);
> +	} else {
> +		if (pdata->phy_init)
> +			pdata->phy_init();
> +	}
> 
>  	clk_prepare_enable(dp->clock);
> 
> @@ -1013,6 +1184,12 @@ static const struct dev_pm_ops exynos_dp_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(exynos_dp_suspend, exynos_dp_resume)
>  };
> 
> +static const struct of_device_id exynos_dp_match[] = {
> +	{ .compatible = "samsung,exynos5-dp" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, exynos_dp_match);
> +
>  static struct platform_driver exynos_dp_driver = {
>  	.probe		= exynos_dp_probe,
>  	.remove		= __devexit_p(exynos_dp_remove),
> @@ -1020,6 +1197,7 @@ static struct platform_driver exynos_dp_driver = {
>  		.name	= "exynos-dp",
>  		.owner	= THIS_MODULE,
>  		.pm	= &exynos_dp_pm_ops,
> +		.of_match_table = of_match_ptr(exynos_dp_match),
>  	},
>  };
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
> index 57b8a65..6dbeeb2 100644
> --- a/drivers/video/exynos/exynos_dp_core.h
> +++ b/drivers/video/exynos/exynos_dp_core.h
> @@ -29,6 +29,8 @@ struct exynos_dp_device {
>  	struct clk		*clock;
>  	unsigned int		irq;
>  	void __iomem		*reg_base;
> +	void __iomem		*phy_addr;
> +	unsigned int		enable_mask;
> 
>  	struct video_info	*video_info;
>  	struct link_train	link_train;
> --
> 1.7.1



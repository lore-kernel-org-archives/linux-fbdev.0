From: Ajay kumar <ajaynumb@gmail.com>
Date: Mon, 24 Sep 2012 12:59:38 +0000
Subject: Re: [PATCH] video: exynos_dp: Add device tree support to DP driver
Message-Id: <CAEC9eQMEy6cPQQiW64=jpHtvmWQkpSpz=_X0JBwm=vAtipja_A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347561592-29400-1-git-send-email-ajaykumar.rs@samsung.com>
	<008d01cd9725$a096e480$e1c4ad80$%han@samsung.com>
In-Reply-To: <008d01cd9725$a096e480$e1c4ad80$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: Ajay Kumar <ajaykumar.rs@samsung.com>, FlorianSchandinat@gmx.de, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, thomas.ab@samsung.com, Leela Krishna Amudala <l.krishna@samsung.com>

Hi Jingoo,

I have addressed all your comments and have sent the V3 Patch.

Regards,
Ajay Kumar

On Thu, Sep 20, 2012 at 5:16 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> On Friday, September 14, 2012 3:40 AM Ajay Kumar wrote
>>
>> This patch enables device tree based discovery support for DP driver.
>> The driver is modified to handle platform data in both the cases:
>> with DT and non-DT.
>>
>> DP-PHY should be regarded as a seperate device node while
>> being passed from device tree list, and device node for
>> DP should contain DP-PHY as child node with property name "dp-phy"
>> associated with it.
>
> Hi Ajay,
>
> Thank you for sending the patch for Device Tree support.
> I tested the patch with Exynos5250.
>
> As Leela Krishna Amudala mentioned, please post the documentation
> for the bindings.
>
> Also, I added some comments for minor fix.
>
> Best regards,
> Jingoo Han
>
>>
>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>> ---
>>  drivers/video/exynos/exynos_dp_core.c |  156 +++++++++++++++++++++++++++++++--
>>  drivers/video/exynos/exynos_dp_core.h |    2 +
>>  2 files changed, 151 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
>> index f57c915..15887bd 100644
>> --- a/drivers/video/exynos/exynos_dp_core.c
>> +++ b/drivers/video/exynos/exynos_dp_core.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/io.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/delay.h>
>> +#include <linux/of.h>
>>
>>  #include <video/exynos_dp.h>
>>
>> @@ -856,20 +857,117 @@ static irqreturn_t exynos_dp_irq_handler(int irq, void *arg)
>>       return IRQ_HANDLED;
>>  }
>>
>> +#ifdef CONFIG_OF
>> +struct exynos_dp_platdata *exynos_dp_dt_parse_pdata(struct device *dev)
>> +{
>> +     struct device_node *dp_node = dev->of_node;
>> +     struct exynos_dp_platdata *pd;
>> +     struct video_info *dp_video_config;
>> +
>> +     pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
>> +     if (!pd) {
>> +             dev_err(dev, "memory allocation for pdata failed\n");
>> +             return ERR_PTR(-ENOMEM);
>> +     }
>> +     dp_video_config = devm_kzalloc(dev,
>> +                             sizeof(*dp_video_config), GFP_KERNEL);
>> +
>> +     if (!dp_video_config) {
>> +             dev_err(dev, "memory allocation for video config failed\n");
>> +             return ERR_PTR(-ENOMEM);
>> +     }
>> +     pd->video_info = dp_video_config;
>> +
>> +     if (of_get_property(dp_node, "samsung,h-sync-polarity", NULL))
>> +             dp_video_config->h_sync_polarity = 1;
>> +
>> +     if (of_get_property(dp_node, "samsung,v-sync-polarity", NULL))
>> +             dp_video_config->v_sync_polarity = 1;
>> +
>> +     if (of_get_property(dp_node, "samsung,interlaced", NULL))
>> +             dp_video_config->interlaced = 1;
>> +
>> +     of_property_read_u32(dp_node, "samsung,color_space",
>> +                             &dp_video_config->color_space);
>> +
>> +     of_property_read_u32(dp_node, "samsung,dynamic_range",
>> +                             &dp_video_config->dynamic_range);
>> +
>> +     of_property_read_u32(dp_node, "samsung,ycbcr_coeff",
>> +                             &dp_video_config->ycbcr_coeff);
>> +
>> +     of_property_read_u32(dp_node, "samsung,color_depth",
>> +                             &dp_video_config->color_depth);
>> +
>> +     of_property_read_u32(dp_node, "samsung,link_rate",
>> +                             &dp_video_config->link_rate);
>> +
>> +     of_property_read_u32(dp_node, "samsung,lane_count",
>> +                             &dp_video_config->lane_count);
>> +     return pd;
>> +}
>> +
>> +void exynos_dp_dt_parse_phydata(struct exynos_dp_device *dp)
>> +{
>> +     struct device_node *dp_phy_node;
>> +
>> +     const __be32 *parp;
>> +
>> +     u32 phy_base;
>> +
>> +     void *virt_phy_base;
>
> Please, remove unnecessary spaces between variables.
>
>
>> +
>> +     parp = of_get_property(dp->dev->of_node, "dp_phy", NULL);
>> +     if (!parp) {
>> +             dp->dp_phy_addr = NULL;
>> +             return;
>> +     }
>> +
>> +     dp_phy_node = of_find_node_by_phandle(be32_to_cpup(parp));
>> +     if (!dp_phy_node) {
>> +             dp->dp_phy_addr = NULL;
>> +             return;
>> +     }
>> +
>> +     of_property_read_u32(dp_phy_node, "samsung,dptx_phy_reg", &phy_base);
>> +     of_property_read_u32(dp_phy_node, "samsung,enable_bit",
>> +                                                     &dp->enable_bit);
>> +     virt_phy_base = ioremap(phy_base, SZ_4);
>> +     if (!virt_phy_base) {
>> +             dev_err(dp->dev, "failed to ioremap dp-phy\n");
>> +             dp->dp_phy_addr = NULL;
>> +             return;
>> +     }
>> +     dp->dp_phy_addr = virt_phy_base;
>> +}
>> +
>> +void dp_phy_init(struct exynos_dp_device *dp)
>
> Use exynos_dp_phy_init.
>
>> +{
>> +     u32 reg;
>> +
>> +     reg = __raw_readl(dp->dp_phy_addr);
>> +     reg |= dp->enable_bit;
>> +     __raw_writel(reg, dp->dp_phy_addr);
>> +}
>> +
>> +void dp_phy_exit(struct exynos_dp_device *dp)
>
> Use exynos_dp_phy_exit.
>
>> +{
>> +     u32 reg;
>> +
>> +     reg = __raw_readl(dp->dp_phy_addr);
>> +     reg &= ~(dp->enable_bit);
>> +     __raw_writel(reg, dp->dp_phy_addr);
>> +}
>> +#endif /* CONFIG_OF */
>> +
>>  static int __devinit exynos_dp_probe(struct platform_device *pdev)
>>  {
>>       struct resource *res;
>>       struct exynos_dp_device *dp;
>> -     struct exynos_dp_platdata *pdata;
>> +     struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
>>
>>       int ret = 0;
>>
>> -     pdata = pdev->dev.platform_data;
>> -     if (!pdata) {
>> -             dev_err(&pdev->dev, "no platform data\n");
>> -             return -EINVAL;
>> -     }
>> -
>>       dp = devm_kzalloc(&pdev->dev, sizeof(struct exynos_dp_device),
>>                               GFP_KERNEL);
>>       if (!dp) {
>> @@ -879,6 +982,19 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>>
>>       dp->dev = &pdev->dev;
>>
>> +     if (pdev->dev.of_node) {
>> +             pdata = exynos_dp_dt_parse_pdata(&pdev->dev);
>> +             if (IS_ERR(pdata))
>> +                     return PTR_ERR(pdata);
>> +
>> +             exynos_dp_dt_parse_phydata(dp);
>> +     }
>
> I would like to use the style as follows.
>
> if (pdev->dev.of_node) {
>         DT case
> else
>         Non-DT case
>
> Could you modify it as follows?
>
> +       if (pdev->dev.of_node) {
> +               pdata = exynos_dp_dt_parse_pdata(&pdev->dev);
> +               if (IS_ERR(pdata))
> +                       return PTR_ERR(pdata);
> +
> +               exynos_dp_dt_parse_phydata(dp);
> +       } else {
> +               pdata = pdev->dev.platform_data;
> +       }
>
>
>> +
>> +     if (!pdata) {
>> +             dev_err(&pdev->dev, "no platform data\n");
>> +             return -EINVAL;
>> +     }
>> +
>>       dp->clock = devm_clk_get(&pdev->dev, "dp");
>>       if (IS_ERR(dp->clock)) {
>>               dev_err(&pdev->dev, "failed to get clock\n");
>> @@ -909,9 +1025,13 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>>       }
>>
>>       dp->video_info = pdata->video_info;
>>       if (pdata->phy_init)
>>               pdata->phy_init();
>>
>> +     if (pdev->dev.of_node)
>> +             if (dp->dp_phy_addr)
>> +                     dp_phy_init(dp);
>> +
>
> Could you modify it as follows?
> phy_init() and dp_phy_init(dp) cannot be used simultaneously.
> So, it seems to be clearer.
>
> -       if (pdata->phy_init)
> -               pdata->phy_init();
> +
> +       if (pdev->dev.of_node) {
> +               if (dp->dp_phy_addr)
> +                       dp_phy_init(dp);
> +       } else {
> +               if (pdata->phy_init)
> +                       pdata->phy_init();
> +       }
>
>
>>       exynos_dp_init_dp(dp);
>>
>>       ret = exynos_dp_detect_hpd(dp);
>> @@ -956,6 +1077,10 @@ static int __devexit exynos_dp_remove(struct platform_device *pdev)
>>       if (pdata && pdata->phy_exit)
>>               pdata->phy_exit();
>>
>> +     if (pdev->dev.of_node)
>> +             if (dp->dp_phy_addr)
>> +                     dp_phy_exit(dp);
>> +
>
> Same as above.
>
>>       clk_disable(dp->clock);
>>
>>       return 0;
>> @@ -971,6 +1096,10 @@ static int exynos_dp_suspend(struct device *dev)
>>       if (pdata && pdata->phy_exit)
>>               pdata->phy_exit();
>>
>> +     if (dev->of_node)
>> +             if (dp->dp_phy_addr)
>> +                     dp_phy_exit(dp);
>> +
>
> Same as above.
>
>>       clk_disable(dp->clock);
>>
>>       return 0;
>> @@ -985,6 +1114,10 @@ static int exynos_dp_resume(struct device *dev)
>>       if (pdata && pdata->phy_init)
>>               pdata->phy_init();
>>
>> +     if (dev->of_node)
>> +             if (dp->dp_phy_addr)
>> +                     dp_phy_init(dp);
>> +
>
> Same as above.
>
>>       clk_enable(dp->clock);
>>
>>       exynos_dp_init_dp(dp);
>> @@ -1013,6 +1146,14 @@ static const struct dev_pm_ops exynos_dp_pm_ops = {
>>       SET_SYSTEM_SLEEP_PM_OPS(exynos_dp_suspend, exynos_dp_resume)
>>  };
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id exynos_dp_match[] = {
>> +     { .compatible = "samsung,exynos5-dp" },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, exynos_dp_match);
>> +#endif
>> +
>>  static struct platform_driver exynos_dp_driver = {
>>       .probe          = exynos_dp_probe,
>>       .remove         = __devexit_p(exynos_dp_remove),
>> @@ -1020,6 +1161,7 @@ static struct platform_driver exynos_dp_driver = {
>>               .name   = "exynos-dp",
>>               .owner  = THIS_MODULE,
>>               .pm     = &exynos_dp_pm_ops,
>> +             .of_match_table = of_match_ptr(exynos_dp_match),
>>       },
>>  };
>>
>> diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
>> index 57b8a65..49b30cb 100644
>> --- a/drivers/video/exynos/exynos_dp_core.h
>> +++ b/drivers/video/exynos/exynos_dp_core.h
>> @@ -29,6 +29,8 @@ struct exynos_dp_device {
>>       struct clk              *clock;
>>       unsigned int            irq;
>>       void __iomem            *reg_base;
>> +     void __iomem            *dp_phy_addr;
>> +     int                     enable_bit;
>
> How about replacing 'int' with 'unsigned int'?
> unsigned number would be better for the bit definition.
>
>>
>>       struct video_info       *video_info;
>>       struct link_train       link_train;
>> --
>> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

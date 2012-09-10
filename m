From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 10 Sep 2012 01:31:22 +0000
Subject: Re: video: exynos_dp: Add device tree based discovery support
Message-Id: <001301cd8ef3$fc594b80$f50be280$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346835251-1276-1-git-send-email-~@samsung.com>
In-Reply-To: <1346835251-1276-1-git-send-email-~@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Ajay Kumar' <ajaykumar.rs@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, FlorianSchandinat@gmx.de, 'Jingoo Han' <jg1.han@samsung.com>

On Wednesday, September 05, 2012 5:54 PM Ajay Kumar wrote
> 
> From: Ajay Kumar <ajaykumar.rs@samsung.com>
> 
> Add device tree match table for Exynos DP
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>

Please insert one line between the commit message and Signed-off-by.

Also, add '[PATCH]' to subject as follow:
     [PATCH] video: exynos_dp: Add device tree based discovery support

Last, pay attention of your mail address and name.
Um, now, you are using "~@samsung.com" as mail address and name.
Please configure your mail program in order to set "Ajay Kumar"
and "ajaykumar.rs@samsung.com".

If you want to get reviewed, please keep the basic rules
as I mentioned above.


Best regards,
Jingoo Han


> ---
>  drivers/video/exynos/exynos_dp_core.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index c6c016a..3bccd6b 100644
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
> @@ -1019,6 +1020,14 @@ static const struct dev_pm_ops exynos_dp_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(exynos_dp_suspend, exynos_dp_resume)
>  };
> 
> +#ifdef CONFIG_OF
> +static const struct of_device_id exynos_dp_match[] = {
> +	{ .compatible = "samsung,exynos5-dp" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, exynos_dp_match);
> +#endif
> +
>  static struct platform_driver exynos_dp_driver = {
>  	.probe		= exynos_dp_probe,
>  	.remove		= __devexit_p(exynos_dp_remove),
> @@ -1026,6 +1035,7 @@ static struct platform_driver exynos_dp_driver = {
>  		.name	= "exynos-dp",
>  		.owner	= THIS_MODULE,
>  		.pm	= &exynos_dp_pm_ops,
> +		.of_match_table = of_match_ptr(exynos_dp_match),
>  	},
>  };
> 
> --
> 1.7.0.4


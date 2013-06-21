From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 21 Jun 2013 00:02:32 +0000
Subject: Re: [PATCH resend] fbdev: bfin-lq035q1-fb: Use dev_pm_ops
Message-Id: <001a01ce6e12$a09fffb0$e1dfff10$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371746326-5087-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1371746326-5087-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Friday, June 21, 2013 1:39 AM, Lars-Peter Clausen wrote:
> Use dev_pm_ops instead of the legacy suspend/resume callbacks.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>

It looks good.

> ---
> Since Rafael said he won't take the pm_sleep_ops_ptr() macro, just a resend of
> the previous version of the patch.

Yep, other better and nicer scheme will be merged. :)

Best regards,
Jingoo Han

> ---
>  drivers/video/bfin-lq035q1-fb.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
> index 29d8c04..6084c17 100644
> --- a/drivers/video/bfin-lq035q1-fb.c
> +++ b/drivers/video/bfin-lq035q1-fb.c
> @@ -170,16 +170,19 @@ static int lq035q1_spidev_remove(struct spi_device *spi)
>  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_SHUT);
>  }
> 
> -#ifdef CONFIG_PM
> -static int lq035q1_spidev_suspend(struct spi_device *spi, pm_message_t state)
> +#ifdef CONFIG_PM_SLEEP
> +static int lq035q1_spidev_suspend(struct device *dev)
>  {
> +	struct spi_device *spi = to_spi_device(dev);
> +
>  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_SHUT);
>  }
> 
> -static int lq035q1_spidev_resume(struct spi_device *spi)
> +static int lq035q1_spidev_resume(struct device *dev)
>  {
> -	int ret;
> +	struct spi_device *spi = to_spi_device(dev);
>  	struct spi_control *ctl = spi_get_drvdata(spi);
> +	int ret;
> 
>  	ret = lq035q1_control(spi, LQ035_DRIVER_OUTPUT_CTL, ctl->mode);
>  	if (ret)
> @@ -187,9 +190,13 @@ static int lq035q1_spidev_resume(struct spi_device *spi)
> 
>  	return lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_ON);
>  }
> +
> +static SIMPLE_DEV_PM_OPS(lq035q1_spidev_pm_ops, lq035q1_spidev_suspend,
> +	lq035q1_spidev_resume);
> +#define LQ035Q1_SPIDEV_PM_OPS (&lq035q1_spidev_pm_ops)
> +
>  #else
> -# define lq035q1_spidev_suspend NULL
> -# define lq035q1_spidev_resume  NULL
> +#define LQ035Q1_SPIDEV_PM_OPS NULL
>  #endif
> 
>  /* Power down all displays on reboot, poweroff or halt */
> @@ -708,8 +715,7 @@ static int bfin_lq035q1_probe(struct platform_device *pdev)
>  	info->spidrv.probe    = lq035q1_spidev_probe;
>  	info->spidrv.remove   = lq035q1_spidev_remove;
>  	info->spidrv.shutdown = lq035q1_spidev_shutdown;
> -	info->spidrv.suspend  = lq035q1_spidev_suspend;
> -	info->spidrv.resume   = lq035q1_spidev_resume;
> +	info->spidrv.driver.pm = LQ035Q1_SPIDEV_PM_OPS;
> 
>  	ret = spi_register_driver(&info->spidrv);
>  	if (ret < 0) {
> --
> 1.8.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


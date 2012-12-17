From: Donghwa Lee <dh09.lee@samsung.com>
Date: Mon, 17 Dec 2012 00:36:58 +0000
Subject: Re: [PATCH 1/1] video: exynos: Use devm_* APIs in s6e8ax0.c
Message-Id: <50CE692A.1040008@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355289083-28269-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1355289083-28269-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Dec 12, 2012 at 14:11, Sachin Kamat wrote:
> devm_* APIs are device managed and make error handling
> and code cleanup simpler.
>
> Cc: Donghwa Lee <dh09.lee@samsung.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> Compile tested against linux-next.
> ---
>   drivers/video/exynos/s6e8ax0.c |   14 ++++----------
>   1 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/video/exynos/s6e8ax0.c b/drivers/video/exynos/s6e8ax0.c
> index 05d080b..ca26024 100644
> --- a/drivers/video/exynos/s6e8ax0.c
> +++ b/drivers/video/exynos/s6e8ax0.c
> @@ -776,7 +776,7 @@ static int s6e8ax0_probe(struct mipi_dsim_lcd_device *dsim_dev)
>   	int ret;
>   	u8 mtp_id[3] = {0, };
>   
> -	lcd = kzalloc(sizeof(struct s6e8ax0), GFP_KERNEL);
> +	lcd = devm_kzalloc(&dsim_dev->dev, sizeof(struct s6e8ax0), GFP_KERNEL);
>   	if (!lcd) {
>   		dev_err(&dsim_dev->dev, "failed to allocate s6e8ax0 structure.\n");
>   		return -ENOMEM;
> @@ -788,18 +788,17 @@ static int s6e8ax0_probe(struct mipi_dsim_lcd_device *dsim_dev)
>   
>   	mutex_init(&lcd->lock);
>   
> -	ret = regulator_bulk_get(lcd->dev, ARRAY_SIZE(supplies), supplies);
> +	ret = devm_regulator_bulk_get(lcd->dev, ARRAY_SIZE(supplies), supplies);
>   	if (ret) {
>   		dev_err(lcd->dev, "Failed to get regulators: %d\n", ret);
> -		goto err_lcd_register;
> +		return ret;
>   	}
>   
>   	lcd->ld = lcd_device_register("s6e8ax0", lcd->dev, lcd,
>   			&s6e8ax0_lcd_ops);
>   	if (IS_ERR(lcd->ld)) {
>   		dev_err(lcd->dev, "failed to register lcd ops.\n");
> -		ret = PTR_ERR(lcd->ld);
> -		goto err_lcd_register;
> +		return PTR_ERR(lcd->ld);
>   	}
>   
>   	lcd->bd = backlight_device_register("s6e8ax0-bl", lcd->dev, lcd,
> @@ -838,11 +837,6 @@ static int s6e8ax0_probe(struct mipi_dsim_lcd_device *dsim_dev)
>   
>   err_backlight_register:
>   	lcd_device_unregister(lcd->ld);
> -
> -err_lcd_register:
> -	regulator_bulk_free(ARRAY_SIZE(supplies), supplies);
> -	kfree(lcd);
> -
>   	return ret;
>   }
>   
It looks good to me.
Acked-by: Donghwa Lee <dh09.lee@samsung.com>

Thank you,
Donghwa Lee

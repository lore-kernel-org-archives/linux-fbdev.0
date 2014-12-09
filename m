From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 09 Dec 2014 01:36:36 +0000
Subject: Re: [PATCH v2 4/4] backlight/lp855x: Remove CONFIG_OF ifdef in favor of Kconfig depends
Message-Id: <000001d01350$9276b930$b7642b90$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1418077278-14144-4-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1418077278-14144-4-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tuesday, December 09, 2014 7:21 AM, Sean Paul wrote:
> 
> Now that we've removed all traces of pdata, remove the CONFIG_OF ifdef
> from lp855x and instead make the driver depend on OF.
> 
> Signed-off-by: Sean Paul <seanpaul@chromium.org>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
> Changes in v2:
> 	- Remove of_match_ptr() wrapper
> 
>  drivers/video/backlight/Kconfig     | 2 +-
>  drivers/video/backlight/lp855x_bl.c | 9 +--------
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 8d03924..113c8b3 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -384,7 +384,7 @@ config BACKLIGHT_LM3639
> 
>  config BACKLIGHT_LP855X
>  	tristate "Backlight driver for TI LP855X"
> -	depends on BACKLIGHT_CLASS_DEVICE && I2C && PWM
> +	depends on BACKLIGHT_CLASS_DEVICE && I2C && PWM && OF
>  	help
>  	  This supports TI LP8550, LP8551, LP8552, LP8553, LP8555, LP8556 and
>  	  LP8557 backlight driver.
> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
> index 6530d60..f0a85f5 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -379,7 +379,6 @@ static const struct attribute_group lp855x_attr_group = {
>  	.attrs = lp855x_attributes,
>  };
> 
> -#ifdef CONFIG_OF
>  static int lp855x_parse_dt(struct lp855x *lp)
>  {
>  	struct device *dev = lp->dev;
> @@ -426,12 +425,6 @@ static int lp855x_parse_dt(struct lp855x *lp)
> 
>  	return 0;
>  }
> -#else
> -static int lp855x_parse_dt(struct lp855x *lp)
> -{
> -	return -EINVAL;
> -}
> -#endif
> 
>  static int lp855x_probe(struct i2c_client *cl, const struct i2c_device_id *id)
>  {
> @@ -532,7 +525,7 @@ MODULE_DEVICE_TABLE(i2c, lp855x_ids);
>  static struct i2c_driver lp855x_driver = {
>  	.driver = {
>  		   .name = "lp855x",
> -		   .of_match_table = of_match_ptr(lp855x_dt_ids),
> +		   .of_match_table = lp855x_dt_ids,
>  		   },
>  	.probe = lp855x_probe,
>  	.remove = lp855x_remove,
> --
> 2.1.1


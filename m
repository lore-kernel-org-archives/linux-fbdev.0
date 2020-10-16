From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 Oct 2020 21:19:43 +0000
Subject: Re: [PATCH -next] omapfb: connector-hdmi: simplify the return expression of hdmic_connect
Message-Id: <20201016211943.GG1496366@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200921131051.92661-1-miaoqinglang@huawei.com>
In-Reply-To: <20200921131051.92661-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: linux-fbdev@vger.kernel.org, linux-gpio@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org

Hi Qinglang Miao

On Mon, Sep 21, 2020 at 09:10:51PM +0800, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

I dropped the changes to gpio-cs5535.c when I applied this patch to
drm-misc-next. It looks like an accident that it was included here.

	Sam

> ---
>  drivers/gpio/gpio-cs5535.c                                 | 6 +-----
>  drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c | 7 +------
>  2 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-cs5535.c b/drivers/gpio/gpio-cs5535.c
> index 53b24e3ae..57b9ddffd 100644
> --- a/drivers/gpio/gpio-cs5535.c
> +++ b/drivers/gpio/gpio-cs5535.c
> @@ -345,12 +345,8 @@ static int cs5535_gpio_probe(struct platform_device *pdev)
>  				mask_orig, mask);
>  
>  	/* finally, register with the generic GPIO API */
> -	err = devm_gpiochip_add_data(&pdev->dev, &cs5535_gpio_chip.chip,
> +	return devm_gpiochip_add_data(&pdev->dev, &cs5535_gpio_chip.chip,
>  				     &cs5535_gpio_chip);
> -	if (err)
> -		return err;
> -
> -	return 0;
>  }
>  
>  static struct platform_driver cs5535_gpio_driver = {
> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c b/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c
> index 49551afbd..670b9c6eb 100644
> --- a/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c
> +++ b/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c
> @@ -50,18 +50,13 @@ static int hdmic_connect(struct omap_dss_device *dssdev)
>  {
>  	struct panel_drv_data *ddata = to_panel_data(dssdev);
>  	struct omap_dss_device *in = ddata->in;
> -	int r;
>  
>  	dev_dbg(ddata->dev, "connect\n");
>  
>  	if (omapdss_device_is_connected(dssdev))
>  		return 0;
>  
> -	r = in->ops.hdmi->connect(in, dssdev);
> -	if (r)
> -		return r;
> -
> -	return 0;
> +	return in->ops.hdmi->connect(in, dssdev);
>  }
>  
>  static void hdmic_disconnect(struct omap_dss_device *dssdev)
> -- 
> 2.23.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

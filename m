From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 14 Mar 2014 02:22:21 +0000
Subject: Re: [PATCH] backlight: lm3639: use devm_backlight_device_register()
Message-Id: <000901cf3f2c$3af30630$b0d91290$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394763240-10176-1-git-send-email-gshark.jeong@gmail.com>
In-Reply-To: <1394763240-10176-1-git-send-email-gshark.jeong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Lee Jones' <lee.jones@linaro.org>, 'Bryan Wu' <cooloney@gmail.com>
Cc: 'Daniel Jeong' <gshark.jeong@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Jingoo Han' <jg1.han@samsung.com>

On Friday, March 14, 2014 11:14 AM, Daniel Jeong wrote:
> 
>  change to use devm_backlight_device_register() for simple cleanup.
> 
> Signed-off-by: Daniel Jeong <gshark.jeong@gmail.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Lee Jones,
Would you merge this patch into your backlight tree?

Best regards,
Jingoo Han

> ---
>  drivers/video/backlight/lm3639_bl.c |   17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
> index 6fd60ad..5f36808 100644
> --- a/drivers/video/backlight/lm3639_bl.c
> +++ b/drivers/video/backlight/lm3639_bl.c
> @@ -349,8 +349,9 @@ static int lm3639_probe(struct i2c_client *client,
>  	props.brightness = pdata->init_brt_led;
>  	props.max_brightness = pdata->max_brt_led;
>  	pchip->bled > -	    backlight_device_register("lm3639_bled", pchip->dev, pchip,
> -				      &lm3639_bled_ops, &props);
> +	    devm_backlight_device_register(pchip->dev, "lm3639_bled",
> +					   pchip->dev, pchip, &lm3639_bled_ops,
> +					   &props);
>  	if (IS_ERR(pchip->bled)) {
>  		dev_err(&client->dev, "fail : backlight register\n");
>  		ret = PTR_ERR(pchip->bled);
> @@ -360,7 +361,7 @@ static int lm3639_probe(struct i2c_client *client,
>  	ret = device_create_file(&(pchip->bled->dev), &dev_attr_bled_mode);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "failed : add sysfs entries\n");
> -		goto err_bled_mode;
> +		goto err_out;
>  	}
> 
>  	/* flash */
> @@ -391,8 +392,6 @@ err_torch:
>  	led_classdev_unregister(&pchip->cdev_flash);
>  err_flash:
>  	device_remove_file(&(pchip->bled->dev), &dev_attr_bled_mode);
> -err_bled_mode:
> -	backlight_device_unregister(pchip->bled);
>  err_out:
>  	return ret;
>  }
> @@ -407,10 +406,8 @@ static int lm3639_remove(struct i2c_client *client)
>  		led_classdev_unregister(&pchip->cdev_torch);
>  	if (&pchip->cdev_flash)
>  		led_classdev_unregister(&pchip->cdev_flash);
> -	if (pchip->bled) {
> +	if (pchip->bled)
>  		device_remove_file(&(pchip->bled->dev), &dev_attr_bled_mode);
> -		backlight_device_unregister(pchip->bled);
> -	}
>  	return 0;
>  }
> 
> @@ -432,6 +429,6 @@ static struct i2c_driver lm3639_i2c_driver = {
>  module_i2c_driver(lm3639_i2c_driver);
> 
>  MODULE_DESCRIPTION("Texas Instruments Backlight+Flash LED driver for LM3639");
> -MODULE_AUTHOR("Daniel Jeong <daniel.jeong@ti.com>");
> -MODULE_AUTHOR("G.Shark Jeong <gshark.jeong@gmail.com>");
> +MODULE_AUTHOR("Daniel Jeong <gshark.jeong@gmail.com>");
> +MODULE_AUTHOR("Ldd Mlp <ldd-mlp@list.ti.com>");
>  MODULE_LICENSE("GPL v2");
> --
> 1.7.9.5


From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 17 Apr 2020 14:07:33 +0000
Subject: Re: [PATCH v1 2/5] video: ssd1307fb: Introduce temporary variable to increase readability
Message-Id: <3a7ef743-580a-d5e6-08b8-07507c6c6ea7@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200324170532.44384-1-andriy.shevchenko@linux.intel.com>
 <CGME20200324170551eucas1p2a568c0296a5773cdf70e162c5a1e9b72@eucas1p2.samsung.com>
 <20200324170532.44384-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200324170532.44384-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-fbdev@vger.kernel.org, xllacyx@gmail.com, dri-devel@lists.freedesktop.org


[ added dri-devel ML to Cc: ]

On 3/24/20 6:05 PM, Andy Shevchenko wrote:
> Introduce temporary variable to increase readability of the code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch queued for v5.8 (w/ few lines over 80 characters fixed), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/ssd1307fb.c | 34 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
> index 397eae246c2c..84dfd7b0f682 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -588,6 +588,7 @@ MODULE_DEVICE_TABLE(of, ssd1307fb_of_match);
>  
>  static int ssd1307fb_probe(struct i2c_client *client)
>  {
> +	struct device *dev = &client->dev;
>  	struct backlight_device *bl;
>  	char bl_name[12];
>  	struct fb_info *info;
> @@ -598,7 +599,7 @@ static int ssd1307fb_probe(struct i2c_client *client)
>  	void *vmem;
>  	int ret;
>  
> -	info = framebuffer_alloc(sizeof(struct ssd1307fb_par), &client->dev);
> +	info = framebuffer_alloc(sizeof(struct ssd1307fb_par), dev);
>  	if (!info)
>  		return -ENOMEM;
>  
> @@ -608,23 +609,20 @@ static int ssd1307fb_probe(struct i2c_client *client)
>  
>  	par->device_info = of_device_get_match_data(&client->dev);
>  
> -	par->reset = devm_gpiod_get_optional(&client->dev, "reset",
> -					     GPIOD_OUT_LOW);
> +	par->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(par->reset)) {
> -		dev_err(&client->dev, "failed to get reset gpio: %ld\n",
> -			PTR_ERR(par->reset));
> +		dev_err(dev, "failed to get reset gpio: %ld\n", PTR_ERR(par->reset));
>  		ret = PTR_ERR(par->reset);
>  		goto fb_alloc_error;
>  	}
>  
> -	par->vbat_reg = devm_regulator_get_optional(&client->dev, "vbat");
> +	par->vbat_reg = devm_regulator_get_optional(dev, "vbat");
>  	if (IS_ERR(par->vbat_reg)) {
>  		ret = PTR_ERR(par->vbat_reg);
>  		if (ret = -ENODEV) {
>  			par->vbat_reg = NULL;
>  		} else {
> -			dev_err(&client->dev, "failed to get VBAT regulator: %d\n",
> -				ret);
> +			dev_err(dev, "failed to get VBAT regulator: %d\n", ret);
>  			goto fb_alloc_error;
>  		}
>  	}
> @@ -674,15 +672,14 @@ static int ssd1307fb_probe(struct i2c_client *client)
>  	vmem = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>  					get_order(vmem_size));
>  	if (!vmem) {
> -		dev_err(&client->dev, "Couldn't allocate graphical memory.\n");
> +		dev_err(dev, "Couldn't allocate graphical memory.\n");
>  		ret = -ENOMEM;
>  		goto fb_alloc_error;
>  	}
>  
> -	ssd1307fb_defio = devm_kzalloc(&client->dev, sizeof(*ssd1307fb_defio),
> -				       GFP_KERNEL);
> +	ssd1307fb_defio = devm_kzalloc(dev, sizeof(*ssd1307fb_defio), GFP_KERNEL);
>  	if (!ssd1307fb_defio) {
> -		dev_err(&client->dev, "Couldn't allocate deferred io.\n");
> +		dev_err(dev, "Couldn't allocate deferred io.\n");
>  		ret = -ENOMEM;
>  		goto fb_alloc_error;
>  	}
> @@ -720,8 +717,7 @@ static int ssd1307fb_probe(struct i2c_client *client)
>  	if (par->vbat_reg) {
>  		ret = regulator_enable(par->vbat_reg);
>  		if (ret) {
> -			dev_err(&client->dev, "failed to enable VBAT: %d\n",
> -				ret);
> +			dev_err(dev, "failed to enable VBAT: %d\n", ret);
>  			goto reset_oled_error;
>  		}
>  	}
> @@ -732,17 +728,15 @@ static int ssd1307fb_probe(struct i2c_client *client)
>  
>  	ret = register_framebuffer(info);
>  	if (ret) {
> -		dev_err(&client->dev, "Couldn't register the framebuffer\n");
> +		dev_err(dev, "Couldn't register the framebuffer\n");
>  		goto panel_init_error;
>  	}
>  
>  	snprintf(bl_name, sizeof(bl_name), "ssd1307fb%d", info->node);
> -	bl = backlight_device_register(bl_name, &client->dev, par,
> -				       &ssd1307fb_bl_ops, NULL);
> +	bl = backlight_device_register(bl_name, dev, par, &ssd1307fb_bl_ops, NULL);
>  	if (IS_ERR(bl)) {
>  		ret = PTR_ERR(bl);
> -		dev_err(&client->dev, "unable to register backlight device: %d\n",
> -			ret);
> +		dev_err(dev, "unable to register backlight device: %d\n", ret);
>  		goto bl_init_error;
>  	}
>  
> @@ -750,7 +744,7 @@ static int ssd1307fb_probe(struct i2c_client *client)
>  	bl->props.max_brightness = MAX_CONTRAST;
>  	info->bl_dev = bl;
>  
> -	dev_info(&client->dev, "fb%d: %s framebuffer device registered, using %d bytes of video memory\n", info->node, info->fix.id, vmem_size);
> +	dev_info(dev, "fb%d: %s framebuffer device registered, using %d bytes of video memory\n", info->node, info->fix.id, vmem_size);
>  
>  	return 0;
>  

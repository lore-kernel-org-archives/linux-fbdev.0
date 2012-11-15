From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 15 Nov 2012 01:30:11 +0000
Subject: Re: [PATCH] backlight: Add of_find_backlight_by_node() function
Message-Id: <004201cdc2d0$c1920210$44b60630$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352469878-4532-1-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1352469878-4532-1-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Thierry Reding' <thierry.reding@avionic-design.de>, 'Andrew Morton' <akpm@linux-foundation.org>
Cc: 'Richard Purdie' <rpurdie@rpsys.net>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org

On Friday, November 09, 2012 11:05 PM Thierry Reding wrote
> 
> This function finds the struct backlight_device for a given device tree
> node. A dummy function is provided so that it safely compiles out if OF
> support is disabled.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

CC'ed Andrew Morton

Hi Thierry Reding,

The patch itself looks good.
Could you explain when this API is used?
Thank you.


Best regards,
Jingoo Han

> ---
>  drivers/video/backlight/backlight.c | 17 +++++++++++++++++
>  include/linux/backlight.h           | 10 ++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 297db2f..0d1ed4f 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -370,6 +370,23 @@ void backlight_device_unregister(struct backlight_device *bd)
>  }
>  EXPORT_SYMBOL(backlight_device_unregister);
> 
> +#if IS_ENABLED(CONFIG_OF)
> +static int of_parent_match(struct device *dev, void *data)
> +{
> +	return dev->parent && dev->parent->of_node = data;
> +}
> +
> +struct backlight_device *of_find_backlight_by_node(struct device_node *node)
> +{
> +	struct device *dev;
> +
> +	dev = class_find_device(backlight_class, NULL, node, of_parent_match);
> +
> +	return dev ? to_backlight_device(dev) : NULL;
> +}
> +EXPORT_SYMBOL(of_find_backlight_by_node);
> +#endif
> +
>  static void __exit backlight_class_exit(void)
>  {
>  	class_destroy(backlight_class);
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 5ffc6dd..11840e9 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -134,4 +134,14 @@ struct generic_bl_info {
>  	void (*kick_battery)(void);
>  };
> 
> +#if IS_ENABLED(CONFIG_OF)
> +struct backlight_device *of_find_backlight_by_node(struct device_node *node);
> +#else
> +static inline struct backlight_device *
> +of_find_backlight_by_node(struct device_node *node)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  #endif
> --
> 1.8.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


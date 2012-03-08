From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 08 Mar 2012 09:25:49 +0000
Subject: Re: [RFC PATCH] video:backlight: add dimming sysfs node
Message-Id: <4F587B1D.5080206@metafoo.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4F58573C.3020407@samsung.com>
In-Reply-To: <4F58573C.3020407@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 03/08/2012 07:52 AM, Donghwa Lee wrote:
> In backlight class, update_status() callback function is mostly used to change
> backlight brightness. When platform enter the dimming state, it is usually used.
> But, I think dimming state can be defined variety of method including brightness.
> So, it is need to differentiated node from brightness node.

What do you mean by dimming? Completely blank the display or just lower the
brightness to a certain level > 0? In the former case the bl_power sysfs
node already exposes such functionality. In the later case can you give an
example how this will be used and how a typical driver would implement this
functionality?

> 
> In set_dimming() callback function, developers can define variety dimming functions.
> 
> Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/video/backlight/backlight.c |   37 +++++++++++++++++++++++++++++++++++
>  include/linux/backlight.h           |    9 ++++++++
>  2 files changed, 46 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index bf5b1ec..44a77e4 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -101,6 +101,43 @@ static void backlight_generate_event(struct backlight_device *bd,
>  	sysfs_notify(&bd->dev.kobj, NULL, "actual_brightness");
>  }
>  
> +static ssize_t backlight_store_dimming(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int rc;
> +	struct backlight_device *bd = to_backlight_device(dev);
> +	unsigned long dimming;
> +
> +	rc = strict_strtoul(buf, 0, &dimming);
> +	if (rc)
> +		return rc;
> +
> +	if (dimming < 0)
> +		rc = -EINVAL;
> +	else {
> +		pr_debug("set dimming mode\n");
> +
> +		if (dimming)
> +			bd->props.dimming = true;
> +		else
> +			bd->props.dimming = false;
> +
> +		backlight_set_dimming(bd);
> +
> +		rc = count;
> +	}
> +
> +	return rc;
> +}
> +
> +static ssize_t backlight_show_dimming(struct device *dev,
> +		struct device_attribute *attr,char *buf)
> +{
> +	struct backlight_device *bd = to_backlight_device(dev);
> +
> +	return sprintf(buf, "%d\n", bd->props.dimming);
> +}
> +
>  static ssize_t backlight_show_power(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 5ffc6dd..823717e 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -55,10 +55,13 @@ struct backlight_ops {
>  	/* Check if given framebuffer device is the one bound to this backlight;
>  	   return 0 if not, !=0 if it is. If NULL, backlight always matches the fb. */
>  	int (*check_fb)(struct backlight_device *, struct fb_info *);
> +	/* Notify the backlight driver to enter the dimming state */
> +	int (*set_dimming)(struct backlight_device *);
>  };
>  
>  /* This structure defines all the properties of a backlight */
>  struct backlight_properties {
> +	bool dimming;
>  	/* Current User requested brightness (0 - max_brightness) */
>  	int brightness;
>  	/* Maximal value for brightness (read-only) */
> @@ -111,6 +114,12 @@ static inline void backlight_update_status(struct backlight_device *bd)
>  	mutex_unlock(&bd->update_lock);
>  }
>  
> +static inline void backlight_set_dimming(struct backlight_device *bd)
> +{
> +	if (bd->ops && bd->ops->set_dimming)
> +		bd->ops->set_dimming(bd);
> +}
> +
>  extern struct backlight_device *backlight_device_register(const char *name,
>  	struct device *dev, void *devdata, const struct backlight_ops *ops,
>  	const struct backlight_properties *props);


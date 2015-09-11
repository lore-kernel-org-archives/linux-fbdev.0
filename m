From: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Fri, 11 Sep 2015 13:50:52 +0000
Subject: Re: [PATCHv3 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55F2DC3C.6090100@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441976857-26548-1-git-send-email-tomi.valkeinen@ti.com>
 <1441976857-26548-2-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1441976857-26548-2-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

On 09/11/2015 03:07 PM, Tomi Valkeinen wrote:
> This patch adds basic support for a kernel driver to get a LED device.
> This will be used by the led-backlight driver.
>
> Only OF version is implemented for now, and the behavior is similar to
> PWM's of_pwm_get() and pwm_put().
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/leds/Makefile    |  6 +++-
>   drivers/leds/led-class.c | 13 +++++++-
>   drivers/leds/led-of.c    | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/leds/leds.h      |  1 +
>   include/linux/leds.h     | 10 ++++++
>   include/linux/of_leds.h  | 26 +++++++++++++++
>   6 files changed, 139 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/leds/led-of.c
>   create mode 100644 include/linux/of_leds.h
>
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 8d6a24a2f513..6fd22e411810 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -1,7 +1,11 @@
>
>   # LED Core
>   obj-$(CONFIG_NEW_LEDS)			+= led-core.o
> -obj-$(CONFIG_LEDS_CLASS)		+= led-class.o
> +
> +obj-$(CONFIG_LEDS_CLASS)		+= led-class-objs.o
> +led-class-objs-y			:= led-class.o
> +led-class-objs-$(CONFIG_OF)		+= led-of.o
> +
>   obj-$(CONFIG_LEDS_CLASS_FLASH)		+= led-class-flash.o
>   obj-$(CONFIG_LEDS_TRIGGERS)		+= led-triggers.o
>
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index beabfbc6f7cd..1234f9dc3537 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -22,7 +22,7 @@
>   #include <linux/timer.h>
>   #include "leds.h"
>
> -static struct class *leds_class;
> +struct class *leds_class;
>
>   static ssize_t brightness_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
> @@ -216,6 +216,17 @@ static int led_resume(struct device *dev)
>
>   static SIMPLE_DEV_PM_OPS(leds_class_dev_pm_ops, led_suspend, led_resume);
>
> +/**
> + * led_put() - release a LED device, reserved with led_get()

s/led_get/of_led_get/

or we should add led_get, but since class_find_device, which increments
device ref count, takes led_node and led_match_led_node, it is tightly
coupled tightly with OF. OTOH we could have of_led_put for symmetry,
but it would have nothing to do with OF. Amending the comment is the
best option here, I think.


> + * @led_cdev: LED device
> + */
> +void led_put(struct led_classdev *led_cdev)
> +{
> +	put_device(led_cdev->dev);
> +	module_put(led_cdev->dev->parent->driver->owner);
> +}
> +EXPORT_SYMBOL_GPL(led_put);
> +
>   static int match_name(struct device *dev, const void *data)
>   {
>   	if (!dev_name(dev))
> diff --git a/drivers/leds/led-of.c b/drivers/leds/led-of.c
> new file mode 100644
> index 000000000000..6e96fee9adf1
> --- /dev/null
> +++ b/drivers/leds/led-of.c
> @@ -0,0 +1,85 @@
> +/*
> + * LED Class Core OF support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_leds.h>
> +
> +#include "leds.h"
> +
> +/* find OF node for the given led_cdev */
> +static struct device_node *find_led_of_node(struct led_classdev *led_cdev)
> +{
> +	struct device *led_dev = led_cdev->dev;
> +	struct device_node *child;
> +
> +	for_each_child_of_node(led_dev->parent->of_node, child) {
> +		int idx;
> +
> +		idx = of_property_match_string(child, "label", led_cdev->name);
> +		if (idx = 0)
> +			return child;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int led_match_led_node(struct device *led_dev, const void *data)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(led_dev);
> +	const struct device_node *target_node = data;
> +	struct device_node *led_node;
> +
> +	led_node = find_led_of_node(led_cdev);
> +	if (!led_node)
> +		return 0;
> +
> +	of_node_put(led_node);
> +
> +	return led_node = target_node;
> +}
> +
> +/**
> + * of_led_get() - request a LED device via the LED framework
> + * @np: device node to get the LED device from
> + *
> + * Returns the LED device parsed from the phandle specified in the "leds"
> + * property of a device tree node or a negative error-code on failure.
> + *
> + * The caller must use led_put() to release the device after use.
> + */
> +struct led_classdev *of_led_get(struct device_node *np)
> +{
> +	struct device *led_dev;
> +	struct led_classdev *led_cdev;
> +	struct device_node *led_node;
> +
> +	led_node = of_parse_phandle(np, "leds", 0);
> +	if (!led_node)
> +		return ERR_PTR(-ENODEV);
> +
> +	led_dev = class_find_device(leds_class, NULL, led_node,
> +		led_match_led_node);
> +
> +	of_node_put(led_node);
> +
> +	if (!led_dev) {
> +		pr_err("failed to find led device for node %s, deferring probe\n",
> +			of_node_full_name(led_node));
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	led_cdev = dev_get_drvdata(led_dev);
> +
> +	if (!try_module_get(led_cdev->dev->parent->driver->owner))
> +		return ERR_PTR(-ENODEV);
> +
> +	return led_cdev;
> +}
> +EXPORT_SYMBOL_GPL(of_led_get);
> diff --git a/drivers/leds/leds.h b/drivers/leds/leds.h
> index bc89d7ace2c4..ccc3abb417d4 100644
> --- a/drivers/leds/leds.h
> +++ b/drivers/leds/leds.h
> @@ -46,6 +46,7 @@ static inline int led_get_brightness(struct led_classdev *led_cdev)
>
>   void led_stop_software_blink(struct led_classdev *led_cdev);
>
> +extern struct class *leds_class;
>   extern struct rw_semaphore leds_list_lock;
>   extern struct list_head leds_list;
>
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index b122eeafb5dc..fbad4ce78e6e 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -113,6 +113,16 @@ extern void devm_led_classdev_unregister(struct device *parent,
>   extern void led_classdev_suspend(struct led_classdev *led_cdev);
>   extern void led_classdev_resume(struct led_classdev *led_cdev);
>
> +#if IS_ENABLED(CONFIG_LEDS_CLASS)
> +
> +extern void led_put(struct led_classdev *led_cdev);
> +
> +#else
> +
> +static inline void led_put(struct led_classdev *led_cdev) { }
> +
> +#endif /* IS_ENABLED(CONFIG_LEDS_CLASS) */
> +
>   /**
>    * led_blink_set - set blinking with software fallback
>    * @led_cdev: the LED to start blinking
> diff --git a/include/linux/of_leds.h b/include/linux/of_leds.h
> new file mode 100644
> index 000000000000..7e8e64bd9811
> --- /dev/null
> +++ b/include/linux/of_leds.h
> @@ -0,0 +1,26 @@
> +/*
> + * OF support for leds
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __LINUX_LEDS_OF_H_INCLUDED
> +#define __LINUX_LEDS_OF_H_INCLUDED
> +
> +#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_LEDS_CLASS)
> +
> +extern struct led_classdev *of_led_get(struct device_node *np);
> +
> +#else
> +
> +static inline struct led_classdev *of_led_get(struct device_node *np)
> +{
> +	return -ENODEV;
> +}
> +
> +#endif
> +
> +#endif /* __LINUX_LEDS_OF_H_INCLUDED */
>


-- 
Best Regards,
Jacek Anaszewski

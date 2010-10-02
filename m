From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sat, 02 Oct 2010 17:28:10 +0000
Subject: Re: [RESEND #2][PATCH] LEDS: Add output invertion option to backlight
Message-Id: <4CA76BAA.7020507@metafoo.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201009301404.18985.jkrzyszt@tis.icnet.pl>
In-Reply-To: <201009301404.18985.jkrzyszt@tis.icnet.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Richard Purdie <rpurdie@rpsys.net>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-kernel@vger.kernel.org, e3-hacking@earth.li

Janusz Krzysztofik wrote:
> This patch extends the LED backlight tirgger driver with an option that allows 
> for inverting the trigger output polarity.
> 
> Whith the invertion option provided, I (ab)use the backlight trigger for 
> driving a led that indicates LCD display blank condtition on my Amstrad Delta 
> videophone. Since the machine has no dedicated power LED, it was not possible 
> to distinguish if its display was blanked or it was turned off, without 
> touching it.
> 
> The invert sysfs control is modeled after a similiar function provided by the 
> gpio trigger driver.
> 
> Created and tested against linux-2.6.35-rc3 on Amstrad Delta.
> Re-tested against linux-2.6.36-rc5.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
>  drivers/leds/ledtrig-backlight.c |   59 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 55 insertions(+), 4 deletions(-)
> 
> diff -uprN git/drivers/leds/ledtrig-backlight.c git/drivers/leds/ledtrig-backlight.c
> --- git/drivers/leds/ledtrig-backlight.c	2010-06-15 18:01:50.000000000 +0200
> +++ git/drivers/leds/ledtrig-backlight.c	2010-06-23 02:48:44.000000000 +0200
> @@ -26,6 +26,7 @@ struct bl_trig_notifier {
>  	int brightness;
>  	int old_status;
>  	struct notifier_block notifier;
> +	unsigned invert;
>  };
>  
>  static int fb_notifier_callback(struct notifier_block *p,
> @@ -39,13 +40,15 @@ static int fb_notifier_callback(struct n
>  
>  	switch (event) {
>  	case FB_EVENT_BLANK :
> -		if (*blank && n->old_status = UNBLANK) {
> +		if ((!n->invert && *blank && n->old_status = UNBLANK) ||
> +			    (n->invert && !*blank && n->old_status = BLANK)) {
>  			n->brightness = led->brightness;
>  			led_set_brightness(led, LED_OFF);
> -			n->old_status = BLANK;
> -		} else if (!*blank && n->old_status = BLANK) {
> +			n->old_status = n->invert ? UNBLANK : BLANK;
> +		} else if ((!n->invert && !*blank && n->old_status = BLANK) ||
> +			    (n->invert && *blank && n->old_status = UNBLANK)) {
>  			led_set_brightness(led, n->brightness);
> -			n->old_status = UNBLANK;
> +			n->old_status = n->invert ? BLANK : UNBLANK;
>  		}
>  		break;
>  	}

How about some like:

unsigned new_status = *blank ? BLANK : UNBLANK;

if (new_status != n->old_status) {
	if ((new_status ^ n->invert) = BLANK) {
		n->brightness = led->brightness;
		led_set_brightness(led, LED_OFF);
	} else {
		led_set_brightness(led, n->brightness);
	}

	n->old_status = new_status;
}

In my opinion that would be more readable.


> @@ -53,6 +56,43 @@ static int fb_notifier_callback(struct n
>  	return 0;
>  }
>  
> +static ssize_t bl_trig_invert_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct led_classdev *led = dev_get_drvdata(dev);
> +	struct bl_trig_notifier *n = led->trigger_data;
> +
> +	return sprintf(buf, "%s\n", n->invert ? "yes" : "no");
> +}
> +
> +static ssize_t bl_trig_invert_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t num)
> +{
> +	struct led_classdev *led = dev_get_drvdata(dev);
> +	struct bl_trig_notifier *n = led->trigger_data;
> +	unsigned invert;
> +	int ret;
> +
> +	ret = sscanf(buf, "%u", &invert);
> +	if (ret < 1) {
> +		dev_err(dev, "invalid value\n");
> +		return -EINVAL;
> +	}
> +
> +	n->invert = !!invert;
> +
> +	/* After inverting, we need to update the LED. */
> +	if ((!n->invert && n->old_status = UNBLANK) ||
> +			(n->invert && n->old_status = BLANK))
> +		led_set_brightness(led, n->brightness);
> +	else if ((!n->invert && n->old_status = BLANK) ||
> +			(n->invert && n->old_status = UNBLANK))
> +		led_set_brightness(led, LED_OFF);
> +
> +	return num;
> +}

Same here:

if ((n->old_status ^ n->invert) = BLANK)
	led_set_brightness(led, LED_OFF);
else
	led_set_brightness(led, n->brightness);

> +static DEVICE_ATTR(invert, 0644, bl_trig_invert_show, bl_trig_invert_store);
> +
>  static void bl_trig_activate(struct led_classdev *led)
>  {
>  	int ret;
> @@ -66,6 +106,10 @@ static void bl_trig_activate(struct led_
>  		return;
>  	}
>  
> +	ret = device_create_file(led->dev, &dev_attr_invert);
> +	if (ret)
> +		goto err_invert;
> +
>  	n->led = led;
>  	n->brightness = led->brightness;
>  	n->old_status = UNBLANK;
> @@ -74,6 +118,12 @@ static void bl_trig_activate(struct led_
>  	ret = fb_register_client(&n->notifier);
>  	if (ret)
>  		dev_err(led->dev, "unable to register backlight trigger\n");
> +
> +	return;
> +
> +err_invert:
> +	led->trigger_data = NULL;
> +	kfree(n);
>  }
>  
>  static void bl_trig_deactivate(struct led_classdev *led)
> @@ -82,6 +132,7 @@ static void bl_trig_deactivate(struct le
>  		(struct bl_trig_notifier *) led->trigger_data;
>  
>  	if (n) {
> +		device_remove_file(led->dev, &dev_attr_invert);
>  		fb_unregister_client(&n->notifier);
>  		kfree(n);
>  	}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


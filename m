From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 26 Nov 2012 10:44:04 +0000
Subject: Re: [PATCH 1/5] backlight: Add GPIO-based backlight driver
Message-Id: <50B347F4.2080705@metafoo.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <32552643.33371353923376540.JavaMail.weblogic@epv6ml07>
In-Reply-To: <32552643.33371353923376540.JavaMail.weblogic@epv6ml07>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: jg1.han@samsung.com, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On 11/26/2012 10:49 AM, Jingoo Han wrote:
> On Saturday, November 24, 2012 1:35 AM, Laurent Pinchart wrote
[...]
>> +static int gpio_backlight_check_fb(struct backlight_device *bl,
>> +				   struct fb_info *info)
>> +{
>> +	struct gpio_backlight *gbl = bl_get_data(bl);
>> +
>> +	return gbl->fbdev = info->dev;

I think it makes sense to return true if fbdev is NULL, to provide a simple
fallback for systems with only one framebuffer device.

>> +}
>> +
[...]
>> +#ifdef CONFIG_PM
>> +static int gpio_backlight_suspend(struct device *dev)
>> +{
>> +	struct backlight_device *bl = dev_get_drvdata(dev);
>> +	struct gpio_backlight *gbl = bl_get_data(bl);
>> +
>> +	gpio_set_value(gbl->gpio, !gbl->active);
>> +
>> +	return 0;
>> +}
>> +
>> +static int gpio_backlight_resume(struct device *dev)
>> +{
>> +	struct backlight_device *bl = dev_get_drvdata(dev);
>> +
>> +	backlight_update_status(bl);
>> +	return 0;
>> +}

If you use BL_CORE_SUSPENDRESUME you can get rid of the custom
suspend/resume handlers.

>> +
>> +static SIMPLE_DEV_PM_OPS(gpio_backlight_pm_ops, gpio_backlight_suspend,
>> +			 gpio_backlight_resume);
>> +
>> +#endif
>> +
[...]

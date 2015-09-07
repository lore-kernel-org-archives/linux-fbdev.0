From: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Mon, 07 Sep 2015 14:11:13 +0000
Subject: Re: [PATCH 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55ED9B01.5030003@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-2-git-send-email-tomi.valkeinen@ti.com>
 <55DC6CB9.5060301@samsung.com> <55ED848F.2060906@ti.com>
In-Reply-To: <55ED848F.2060906@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

On 09/07/2015 02:35 PM, Tomi Valkeinen wrote:
> Hi,
>
> On 25/08/15 16:25, Jacek Anaszewski wrote:
>> Hi Tomi,
>>
>> Thanks for the patch. Generally, I'd prefer to add files
>> drivers/leds/of.c and include/linux/of_leds.h and put related functions
>> there. Those functions' names should begin with "of_". Please provide
>
> Ok, I'll do that. I do need to export something from led-class in that
> case, so that the of.c gets hold of 'leds_class' pointer, either
> directly or indirectly.

What exactly do you need to export?

>
>> also no-op versions of the functions to address configurations when
>> CONFIG_OF isn't enabled. I have also few comments below.
>
> Yep. No-ops for the purpose of making the kernel image smaller?

No, for the case when support for LED subsystem is disabled in the
kernel config. I'd rather backlight driver depended on LED subsystem
than selected it.

> I do
> think the current code compiles and works fine with CONFIG_OF disabled
> (although I have to say I don't remember if I actually tested it).
>
>>> +struct led_classdev *of_led_get(struct device_node *np)
>>> +{
>>> +    struct device *led_dev;
>>> +    struct led_classdev *led_cdev;
>>> +    struct device_node *led_node;
>>> +
>>> +    led_node = of_parse_phandle(np, "leds", 0);
>>> +    if (!led_node)
>>> +        return ERR_PTR(-ENODEV);
>>> +
>>> +    led_dev = class_find_device(leds_class, NULL, led_node,
>>> +        led_match_led_node);
>>
>> Single of_node_put(led_node) here will do.
>
> Right.
>
>>> +    if (!led_dev) {
>>> +        of_node_put(led_node);
>>> +        return ERR_PTR(-EPROBE_DEFER);
>>> +    }
>>> +
>>> +    of_node_put(led_node);
>>
>>> +    led_cdev = dev_get_drvdata(led_dev);
>>> +pinctrl/pinctrl.h"
>>> +    if (!try_module_get(led_cdev->dev->parent->driver->owner))
>>> +        return ERR_PTR(-ENODEV);
>>> +
>>> +    return led_cdev;
>>> +}
>>> +EXPORT_SYMBOL_GPL(of_led_get);
>>> +/**
>>> + * led_put() - release a LED device
>>> + * @led_cdev: LED device
>>> + */
>>> +void led_put(struct led_classdev *led_cdev)
>>> +{
>>> +    module_put(led_cdev->dev->parent->driver->owner);
>>> +}
>>> +EXPORT_SYMBOL_GPL(led_put);
>>
>> Please move it to include/linux/leds.h, make static inline and provide
>> also no-op version for the case when CONFIG_LEDS_CLASS isn't enabled.
>
> Ok. Why do you want it as static inline in the leds.h?

This function contains only one instruction, why should we waste
a function call for it?

> I usually like to
> keep the matching functions (get and put here) in the same place.

-- 
Best Regards,
Jacek Anaszewski

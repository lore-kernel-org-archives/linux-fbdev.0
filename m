From: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Tue, 08 Sep 2015 14:04:52 +0000
Subject: Re: [PATCHv2 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55EEEB04.3090207@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441711176-4258-1-git-send-email-tomi.valkeinen@ti.com>
 <1441711176-4258-2-git-send-email-tomi.valkeinen@ti.com>
 <55EEE0A1.5070000@samsung.com>
In-Reply-To: <55EEE0A1.5070000@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

On 09/08/2015 01:19 PM, Tomi Valkeinen wrote:
>> This patch adds basic support for a kernel driver to get a LED device.
>> This will be used by the led-backlight driver.
>>
>> Only OF version is implemented for now, and the behavior is similar to
>> PWM's of_pwm_get() and pwm_put().
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/leds/Makefile    |  6 +++-
>>   drivers/leds/led-class.c | 13 +++++++-
>>   drivers/leds/led-of.c    | 82
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/leds/leds.h      |  1 +
>>   include/linux/leds-of.h  | 26 +++++++++++++++

[...]

>> diff --git a/include/linux/leds-of.h b/include/linux/leds-of.h
>> new file mode 100644
>> index 000000000000..7e8e64bd9811
>> --- /dev/null
>> +++ b/include/linux/leds-of.h
>> @@ -0,0 +1,26 @@
>> +/*
>> + * OF support for leds
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#ifndef __LINUX_LEDS_OF_H_INCLUDED
>> +#define __LINUX_LEDS_OF_H_INCLUDED
>> +
>> +#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_LEDS_CLASS)
>> +
>> +extern struct led_classdev *of_led_get(struct device_node *np);
>> +
>> +#else
>> +
>> +static inline struct led_classdev *of_led_get(struct device_node *np)
>> +{
>> +    return -ENODEV;
>> +}
>> +
>> +#endif
>> +
>> +#endif /* __LINUX_LEDS_OF_H_INCLUDED */
>> diff --git a/include/linux/leds.h b/include/linux/leds.h
>> index b122eeafb5dc..0fce71a06d68 100644
>> --- a/include/linux/leds.h
>> +++ b/include/linux/leds.h
>> @@ -113,6 +113,8 @@ extern void devm_led_classdev_unregister(struct
>> device *parent,
>>   extern void led_classdev_suspend(struct led_classdev *led_cdev);
>>   extern void led_classdev_resume(struct led_classdev *led_cdev);
>>
>> +extern void led_put(struct led_classdev *led_cdev);
>> +

This also needs no-op version.

>>   /**
>>    * led_blink_set - set blinking with software fallback
>>    * @led_cdev: the LED to start blinking
>>
>
>


-- 
Best Regards,
Jacek Anaszewski

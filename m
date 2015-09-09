From: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Wed, 09 Sep 2015 12:40:14 +0000
Subject: Re: [PATCHv2 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55F028AE.70407@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441711176-4258-1-git-send-email-tomi.valkeinen@ti.com>
 <1441711176-4258-2-git-send-email-tomi.valkeinen@ti.com>
 <55EEE0A1.5070000@samsung.com> <55EEEB04.3090207@samsung.com>
 <55F0230C.9000309@ti.com>
In-Reply-To: <55F0230C.9000309@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

On 09/09/2015 02:16 PM, Tomi Valkeinen wrote:
>
>
> On 08/09/15 17:04, Jacek Anaszewski wrote:
>
>>>> +#endif /* __LINUX_LEDS_OF_H_INCLUDED */
>>>> diff --git a/include/linux/leds.h b/include/linux/leds.h
>>>> index b122eeafb5dc..0fce71a06d68 100644
>>>> --- a/include/linux/leds.h
>>>> +++ b/include/linux/leds.h
>>>> @@ -113,6 +113,8 @@ extern void devm_led_classdev_unregister(struct
>>>> device *parent,
>>>>    extern void led_classdev_suspend(struct led_classdev *led_cdev);
>>>>    extern void led_classdev_resume(struct led_classdev *led_cdev);
>>>>
>>>> +extern void led_put(struct led_classdev *led_cdev);
>>>> +
>>
>> This also needs no-op version.
>
> Ok, but... I think other already existing functions need no-ops also. If
> there's a driver that uses of_led_get and led_put, it's sure to use some
> other led_* functions also.
>
> So if we want that driver to be compilable when LED support is disabled
> in the kernel, we need to provide no-ops for all those functions.
>
> Probably:
>
> led_set_brightness
> led_blink_set_oneshot
> led_blink_set

That's right. It needs to be addressed soon too. Potentially
this could show up by breaking randconfig build.

-- 
Best Regards,
Jacek Anaszewski

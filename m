From: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Tue, 08 Sep 2015 09:21:54 +0000
Subject: Re: [PATCH 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55EEA8B2.3040808@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-2-git-send-email-tomi.valkeinen@ti.com>
 <55DC6CB9.5060301@samsung.com> <55ED848F.2060906@ti.com>
 <55ED9B01.5030003@samsung.com> <55EE89CF.8060308@ti.com>
In-Reply-To: <55EE89CF.8060308@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

On 09/08/2015 09:10 AM, Tomi Valkeinen wrote:
>
> On 07/09/15 17:11, Jacek Anaszewski wrote:
>
>>>> Thanks for the patch. Generally, I'd prefer to add files
>>>> drivers/leds/of.c and include/linux/of_leds.h and put related functions
>>>> there. Those functions' names should begin with "of_". Please provide
>>>
>>> Ok, I'll do that. I do need to export something from led-class in that
>>> case, so that the of.c gets hold of 'leds_class' pointer, either
>>> directly or indirectly.
>>
>> What exactly do you need to export?
>
> The "static struct class *leds_class" from led-class.c, in one way or
> another. of_led_get() needs to go through the led devices from the class.
>
> For now I just removed the "static" from it, so that I can use it from of.c.

I think we can go in this direction. I've skimmed through existing
class drivers and found similar examples (e.g. tty_class, rtc_class).

>>>> also no-op versions of the functions to address configurations when
>>>> CONFIG_OF isn't enabled. I have also few comments below.
>>>
>>> Yep. No-ops for the purpose of making the kernel image smaller?
>>
>> No, for the case when support for LED subsystem is disabled in the
>> kernel config. I'd rather backlight driver depended on LED subsystem
>> than selected it.
>
> Sorry, I didn't get that one. How does the backlight driver's
> depend/select affect this?

OK, I confused something here. Backlight driver should depend on
LEDS_CLASS by defining "depends on LEDS_CLASS" in backlight Kconfig.
It should also depend on OF. In case of this driver the no-ops would be
only for the purpose of making the kernel image smaller, as the driver
probe will fail without them anyway. Nevertheless, there might be added
other drivers in the future, using of_led_get{put} API which would like
to make some decisions basing on whether LEDS_CLASS or/and OF are
turned on. No-ops would be of use then.


>>>> Please move it to include/linux/leds.h, make static inline and provide
>>>> also no-op version for the case when CONFIG_LEDS_CLASS isn't enabled.
>>>
>>> Ok. Why do you want it as static inline in the leds.h?
>>
>> This function contains only one instruction, why should we waste
>> a function call for it?
>
> I like to keep code in .c files and leave .h files for declarations, and
> only in special cases have inline code in .h files.
>
> What do you mean with "waste"?

I used 'waste' because we would be wasting time here for the call which
can be avoided at no cost. Of course if compiler will decide to inline
it.

> In this case there's no need to get more performance by inlining

Why so?

> (which
> anyway may not help and needs to be studied separately for every case),

There is the tradeoff. Readability vs performance.

> with inlining the resulting kernel image is larger,

That's why we inline only small functions.

> and inlining forces the users of led_put to include module.h to compile.

We could include module.h from leds.h.

-- 
Best Regards,
Jacek Anaszewski

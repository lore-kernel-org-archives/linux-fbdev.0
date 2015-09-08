From: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Tue, 08 Sep 2015 10:57:00 +0000
Subject: Re: [PATCH 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55EEBEFC.4090904@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-2-git-send-email-tomi.valkeinen@ti.com>
 <55DC6CB9.5060301@samsung.com> <55ED848F.2060906@ti.com>
 <55ED9B01.5030003@samsung.com> <55EE89CF.8060308@ti.com>
 <55EEA8B2.3040808@samsung.com> <55EEBB3F.4040908@ti.com>
In-Reply-To: <55EEBB3F.4040908@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

On 09/08/2015 12:41 PM, Tomi Valkeinen wrote:
>
> On 08/09/15 12:21, Jacek Anaszewski wrote:
>
>>> The "static struct class *leds_class" from led-class.c, in one way or
>>> another. of_led_get() needs to go through the led devices from the class.
>>>
>>> For now I just removed the "static" from it, so that I can use it from
>>> of.c.
>>
>> I think we can go in this direction. I've skimmed through existing
>> class drivers and found similar examples (e.g. tty_class, rtc_class).
>
> Yep.
>
>>> Sorry, I didn't get that one. How does the backlight driver's
>>> depend/select affect this?
>>
>> OK, I confused something here. Backlight driver should depend on
>> LEDS_CLASS by defining "depends on LEDS_CLASS" in backlight Kconfig.
>> It should also depend on OF. In case of this driver the no-ops would be
>> only for the purpose of making the kernel image smaller, as the driver
>> probe will fail without them anyway. Nevertheless, there might be added
>> other drivers in the future, using of_led_get{put} API which would like
>> to make some decisions basing on whether LEDS_CLASS or/and OF are
>> turned on. No-ops would be of use then.
>
> I agree.
>
>>> What do you mean with "waste"?
>>
>> I used 'waste' because we would be wasting time here for the call which
>> can be avoided at no cost. Of course if compiler will decide to inline
>> it.
>>
>>> In this case there's no need to get more performance by inlining
>>
>> Why so?
>
> Reserving and freeing resources are rarely hot paths. The functions in
> question are usually called in a driver's probe and remove. Saving a few
> CPU cycles there doesn't really matter, so I think readability is the
> important part here.

OK, I agree.

>>> and inlining forces the users of led_put to include module.h to compile.
>>
>> We could include module.h from leds.h.
>
> Yes we can. And I can do that in my patch. I don't agree with the
> solution but neither do I really have a problem with it =).

Please go ahead as you originally planned, i.e. without inlining.

-- 
Best Regards,
Jacek Anaszewski

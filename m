From: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Wed, 26 Aug 2015 09:56:26 +0000
Subject: Re: [PATCH 3/3] devicetree: Add led-backlight binding
Message-Id: <55DD8D4A.8010507@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-4-git-send-email-tomi.valkeinen@ti.com>
 <55DC700C.4030802@samsung.com> <55DC8C9D.4050007@ti.com>
 <55DD65BE.4050308@samsung.com> <55DD82C4.50405@ti.com>
In-Reply-To: <55DD82C4.50405@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 08/26/2015 11:11 AM, Tomi Valkeinen wrote:
>
>
> On 26/08/15 10:07, Jacek Anaszewski wrote:
>> On 08/25/2015 05:41 PM, Tomi Valkeinen wrote:
>>>
>>>
>>> On 25/08/15 16:39, Jacek Anaszewski wrote:
>>>
>>>>> +Example:
>>>>> +
>>>>> +    backlight {
>>>>> +        compatible = "led-backlight";
>>>>> +        leds = <&backlight_led>;
>>>>> +
>>>>> +        brightness-levels = <0 4 8 16 32 64 128 255>;
>>>>
>>>> brightness level is not a suitable unit for describing LED brightness
>>>> in a Device Tree, as it is not a physical unit. We have led-max-microamp
>>>> property for this, expressed in microamperes, please refer to [0] from
>>>> linux-next.
>>>
>>> Hmm, ok, but what should the driver do with microamperes? As far as I
>>> see, "enum led_brightness" (which is between 0-255) is used to set the
>>> brightness to LEDs. I don't see any function accepting microamperes.
>>
>> This is implementation detail. You can convert microamperes to
>> enum led_brightness in the driver. Please refer to the discussion [1].
>
> The led_set_brightness() takes "enum led_brightness", so I don't
> understand what this driver would do with the microampere value. It
> could, of course, do an arbitrary conversion, say, direct mapping of the
> mA value to brightness, but that would just confuse things further.

OK, I was looking at the problem from LED-centric perspective. Indeed,
backlight subsystem has no other way to pass brightness to the LED
subsystem than in the form of levels. However, the last word belongs
to DT maintainer in this matter.

Cc'ing devicetree@vger.kernel.org.

> If there was a led_set_microampere(), supported by all led devices, then
> yes, the above should be microamperes.
>
> Or are you saying that I should have the binding use microamperes, and
> just do a naive microampere -> brightness conversion in this driver, and
> hope that in the future this driver can be changes to pass the
> micrompere value directly to the underlying LED driver?
>
> And speaking of microamperes for LED drivers, what's a meaningful
> microampere conversion for LED drivers that don't deal with microamperes
> at all? For example, the LED chip we're using, TLC59108, is basically a
> PWM chip. Can we somehow calculate microamperes if we know duty cycle
> and period?

For this type of drivers we have to resort to levels in DT.
It shouldn't serve as an excuse for not describing the rest of
hardware in a better way, though.

-- 
Best Regards,
Jacek Anaszewski

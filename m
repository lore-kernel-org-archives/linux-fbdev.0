From: Rob Herring <robherring2@gmail.com>
Date: Mon, 31 Aug 2015 23:12:17 +0000
Subject: Re: [PATCH 3/3] devicetree: Add led-backlight binding
Message-Id: <CAL_JsqK=QiNk=ZEqJ=T6_rHbjnHq7UY9=ZtWg1HLoU=qdSn8Gg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-4-git-send-email-tomi.valkeinen@ti.com> <55DC700C.4030802@samsung.com>
 <55DC8C9D.4050007@ti.com> <55DD65BE.4050308@samsung.com> <55DD82C4.50405@ti.com>
 <55DD8D4A.8010507@samsung.com>
In-Reply-To: <55DD8D4A.8010507@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Aug 26, 2015 at 4:56 AM, Jacek Anaszewski
<j.anaszewski@samsung.com> wrote:
> On 08/26/2015 11:11 AM, Tomi Valkeinen wrote:
>>
>>
>>
>> On 26/08/15 10:07, Jacek Anaszewski wrote:
>>>
>>> On 08/25/2015 05:41 PM, Tomi Valkeinen wrote:
>>>>
>>>>
>>>>
>>>> On 25/08/15 16:39, Jacek Anaszewski wrote:
>>>>
>>>>>> +Example:
>>>>>> +
>>>>>> +    backlight {
>>>>>> +        compatible = "led-backlight";
>>>>>> +        leds = <&backlight_led>;
>>>>>> +
>>>>>> +        brightness-levels = <0 4 8 16 32 64 128 255>;
>>>>>
>>>>>
>>>>> brightness level is not a suitable unit for describing LED brightness
>>>>> in a Device Tree, as it is not a physical unit. We have
>>>>> led-max-microamp
>>>>> property for this, expressed in microamperes, please refer to [0] from
>>>>> linux-next.
>>>>
>>>>
>>>> Hmm, ok, but what should the driver do with microamperes? As far as I
>>>> see, "enum led_brightness" (which is between 0-255) is used to set the
>>>> brightness to LEDs. I don't see any function accepting microamperes.
>>>
>>>
>>> This is implementation detail. You can convert microamperes to
>>> enum led_brightness in the driver. Please refer to the discussion [1].
>>
>>
>> The led_set_brightness() takes "enum led_brightness", so I don't
>> understand what this driver would do with the microampere value. It
>> could, of course, do an arbitrary conversion, say, direct mapping of the
>> mA value to brightness, but that would just confuse things further.
>
>
> OK, I was looking at the problem from LED-centric perspective. Indeed,
> backlight subsystem has no other way to pass brightness to the LED
> subsystem than in the form of levels. However, the last word belongs
> to DT maintainer in this matter.
>
> Cc'ing devicetree@vger.kernel.org.

I don't have a simple answer for you...

There was a similar discussion for pm8941-wled and
"default-brightness-level" units[1]. The conclusion was it should be
units matching the h/w so that there is no conversion between
bootloader and OS units to h/w units. That principle probably applies
here.

If the brightness levels are non-linear, then you need a translation
from percent to h/w level. What's needed here for h/w levels depends
on whether the brightness control is PWM, current control or both. For
PWM, units of the PWM control makes sense. For current control, units
of microamps probably makes sense. I don't know what you do with both,
but I have seen that h/w (FSL PMICs).

This all certainly needs some more work on defining some common
binding. We already have some bindings for backlights with the LED and
PWM bindings (perhaps incomplete?). Do we need another way here? This
also introduces possibility of multiple ways to define GPIO controlled
backlights: gpio -> gpio-leds ->  led-backlight or gpio ->
gpio-backlight. We don't want that...

This problem is not really specific at all to backlights, but applies
to all LEDs. Some LEDs you may not have control beyond on/off or
really care about fine-grained control of level, but they are really
no different. The main unique thing about backlights is what display
are they associated with.

Rob

[1] https://lkml.org/lkml/2015/7/30/542

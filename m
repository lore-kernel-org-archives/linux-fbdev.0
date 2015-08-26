From: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Wed, 26 Aug 2015 07:07:42 +0000
Subject: Re: [PATCH 3/3] devicetree: Add led-backlight binding
Message-Id: <55DD65BE.4050308@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-4-git-send-email-tomi.valkeinen@ti.com>
 <55DC700C.4030802@samsung.com> <55DC8C9D.4050007@ti.com>
In-Reply-To: <55DC8C9D.4050007@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

On 08/25/2015 05:41 PM, Tomi Valkeinen wrote:
>
>
> On 25/08/15 16:39, Jacek Anaszewski wrote:
>
>>> +Example:
>>> +
>>> +    backlight {
>>> +        compatible = "led-backlight";
>>> +        leds = <&backlight_led>;
>>> +
>>> +        brightness-levels = <0 4 8 16 32 64 128 255>;
>>
>> brightness level is not a suitable unit for describing LED brightness
>> in a Device Tree, as it is not a physical unit. We have led-max-microamp
>> property for this, expressed in microamperes, please refer to [0] from
>> linux-next.
>
> Hmm, ok, but what should the driver do with microamperes? As far as I
> see, "enum led_brightness" (which is between 0-255) is used to set the
> brightness to LEDs. I don't see any function accepting microamperes.

This is implementation detail. You can convert microamperes to
enum led_brightness in the driver. Please refer to the discussion [1].

>>> +        default-brightness-level = <6>;
>>
>> This also should be microamperes.
>
> This is an index to the above brightness-levels array. It's not LED
> brightness, but backlight brightness, between 0 and
> ARRAY_SIZE(brightness-levels) - 1.

You could skip "-level" postfix  and have default brightness
in microamperes.

[1] http://www.spinics.net/lists/linux-leds/msg03416.html

-- 
Best Regards,
Jacek Anaszewski

From: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Thu, 08 Oct 2015 10:09:17 +0000
Subject: Re: [PATCHv4 0/3] backlight: led-backlight driver
Message-Id: <561640CD.8070901@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443605522-1118-1-git-send-email-tomi.valkeinen@ti.com>
 <561638F2.2010003@ti.com>
In-Reply-To: <561638F2.2010003@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

On 10/08/2015 11:35 AM, Tomi Valkeinen wrote:
> Hi,
>
> On 30/09/15 12:31, Tomi Valkeinen wrote:
>> This series aims to add a led-backlight driver, similar to pwm-backlight, but
>> using a LED class device underneath.
>>
>> LED framework has no support for DT or getting a LED class driver from another
>> kernel driver, so I added minimal functionality to led-class to get
>> led-backlight working.
>>
>> Changes to v3:
>> - Change a comment to refer to of_led_get()
>>
>> Changes to v2:
>> - power supply is now optional
>> - cosmetic changes
>> - no-op function for led_put() when !CONFIG_LEDS_CLASS
>>
>> Changes to v1:
>> - Split LED OF parts into separate .h and .c files
>> - Check for CONFIG_OF and CONFIG_LEDS_CLASS where relevant to leave unused code
>>    out.
>> - Improved error prints and comments a bit
>> - Added put_device() into led_put(), as the device was gotten from
>>    class_find_device() which requires a put_device() call.
>>
>>   Tomi
>>
>> Tomi Valkeinen (3):
>>    leds: Add of_led_get() and led_put()
>>    backlight: add led-backlight driver
>>    devicetree: Add led-backlight binding
>>
>>   .../bindings/video/backlight/led-backlight.txt     |  30 +++
>>   drivers/leds/Makefile                              |   6 +-
>>   drivers/leds/led-class.c                           |  13 +-
>>   drivers/leds/led-of.c                              |  85 +++++++
>>   drivers/leds/leds.h                                |   1 +
>>   drivers/video/backlight/Kconfig                    |   7 +
>>   drivers/video/backlight/Makefile                   |   1 +
>>   drivers/video/backlight/led_bl.c                   | 246 +++++++++++++++++++++
>>   include/linux/leds.h                               |  10 +
>>   include/linux/of_leds.h                            |  26 +++
>>   10 files changed, 423 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/video/backlight/led-backlight.txt
>>   create mode 100644 drivers/leds/led-of.c
>>   create mode 100644 drivers/video/backlight/led_bl.c
>>   create mode 100644 include/linux/of_leds.h
>
> There's been no more comments on this. Should this be merged via led or
> backlight trees?
>
> Possible conflicts probably happen on the led side, as this changes the
> led core files, so perhaps that's easier way?

Yes, it would be better to merge it via LED tree, also because the
driver being added depends on drivers/leds/led-of.c which is introduced
in this set. Obviously I need backlight maintainer's ack. Jingoo, Lee,
are you ok with this changes?

-- 
Best Regards,
Jacek Anaszewski

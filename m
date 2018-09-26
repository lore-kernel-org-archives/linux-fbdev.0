From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 26 Sep 2018 10:25:19 +0000
Subject: Re: [PATCH RESEND] backlight: gpio-backlight: Correct initial power state handling
Message-Id: <94685994-98ff-2a1d-901c-6d3cce71db16@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180508070426.32211-1-peter.ujfalusi@ti.com>
 <cb603304-2052-2586-1673-96ab421a5547@linaro.org>
In-Reply-To: <cb603304-2052-2586-1673-96ab421a5547@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Thompson <daniel.thompson@linaro.org>, lee.jones@linaro.org, jingoohan1@gmail.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Daniel,

On 2018-06-13 18:11, Daniel Thompson wrote:
> On 08/05/18 08:04, Peter Ujfalusi wrote:
>> The default-on property - or the def_value via legacy pdata) should be
>> handled as:
>> if it is 1, the backlight must be enabled (kept enabled)
>> if it is 0, the backlight must be disabled (kept disabled)
>>
>> This only works for the case when default-on is set. If it is not set
>> then
>> the brightness of the backlight is set to 0. Now if the backlight is
>> enabled by external driver (graphics) the backlight will stay disabled
>> since
>> the brightness is configured as 0. The backlight will not turn on.
>>
>> The correct action at probe time is to configure the props.power to
>> FB_BLANK_UNBLANK if we want the backlight on by default or to
>> FB_BLANK_POWERDOWN if the backlight should be off by default.
>>
>> The initial brightness should be set to 1.
> 
> Hmnn... I guess this comes down to the definition of "on" for a binary
> 
> Actually I'm a little worried that backlight already has too many
> different behaviors and that this patch introduces another way for them
> to be different!
> 
> Is there any mileage in adopting the same approach as PWM backlight for
> blank/unblank management as a way to get a flicker free boot?

This patch is merely fixing a bug in the driver.

> For PWM the default property controls the initial brightness and the
> initial power state is unblanked *unless* there is a phandle link to the
> node, in which case we inherit whatever the power state the bootloader
> had configured before the driver probed.
> 
> Put another way, what happens is we implement
> gpio_backlight_initial_power_state() to perform a similar task to
> pwm_backlight_initial_power_state().

I agree, but what should we do with the default-on parameter?

non DT boot or DT boot, no phandle link:
default-on ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN

DT boot and phandle link:
if the GPIO was enabled by the bootloader: FB_BLANK_UNBLANK
if the GIOP was not enabled by the bootloader: FB_BLANK_POWERDOWN

I think this will mimic closely what the
pwm_backlight_initial_power_state() does.

- Péter

> 
> 
> Daniel.
> 
> 
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> for some reason the original patch got lost:
>> https://patchwork.kernel.org/patch/9445539/
>>
>> But it is still valid, so I'm resending it.
>>
>> Regards,
>> Peter
>>
>>   drivers/video/backlight/gpio_backlight.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/backlight/gpio_backlight.c
>> b/drivers/video/backlight/gpio_backlight.c
>> index e470da95d806..904a4462cefe 100644
>> --- a/drivers/video/backlight/gpio_backlight.c
>> +++ b/drivers/video/backlight/gpio_backlight.c
>> @@ -142,7 +142,9 @@ static int gpio_backlight_probe(struct
>> platform_device *pdev)
>>           return PTR_ERR(bl);
>>       }
>>   -    bl->props.brightness = gbl->def_value;
>> +    bl->props.power = gbl->def_value ? FB_BLANK_UNBLANK :
>> FB_BLANK_POWERDOWN;
>> +    bl->props.brightness = 1;
>> +
>>       backlight_update_status(bl);
>>         platform_set_drvdata(pdev, bl);
>>
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

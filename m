From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 20 Jun 2019 13:56:25 +0000
Subject: Re: Re: [PATCH] backlight: gpio-backlight: Set power state instead of brightness at probe
Message-Id: <29712212-0567-702b-fbc9-c0f37806d84c@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190517150546.4508-1-paul.kocialkowski@bootlin.com>
 <bee40295b2c6b489468d4e1fc12d7a1ac122cb9b.camel@bootlin.com>
In-Reply-To: <bee40295b2c6b489468d4e1fc12d7a1ac122cb9b.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On 18/06/2019 13:58, Paul Kocialkowski wrote:
> Hi,
> 
> On Fri, 2019-05-17 at 17:05 +0200, Paul Kocialkowski wrote:
>> On a trivial gpio-backlight setup with a panel using the backlight but
>> no boot software to enable it beforehand, we fall in a case where the
>> backlight is disabled (not just blanked) and thus remains disabled when
>> the panel gets enabled.
>>
>> Setting gbl->def_value via the device-tree prop allows enabling the
>> backlight in this situation, but it will be unblanked straight away,
>> in compliance with the binding. This does not work well when there was no
>> boot software to display something before, since we really need to unblank
>> by the time the panel is enabled, not before.
>>
>> Resolve the situation by setting the brightness to 1 at probe and
>> managing the power state accordingly, a bit like it's done in
>> pwm-backlight.
> 
> Any feedback on this? I was under the impression that it could be quite
> controversial, as it implies that the backlight can no longer be
> enabled without a bound panel (which IMO makes good sense but could be
> a matter to debate).

My apologies. This patch brought on such severe deja-vu I got rather 
confused. Then when I went digging I've also dropped the ball on the 
same feature previously.

Peter Ujfalusi provided a similar patch to yours but with a slightly 
different implementation:
https://lore.kernel.org/patchwork/patch/1002359/

On the whole I think it is important to read the GPIO pin since 
otherwise we swap problems when there bootloader does setup the 
backlight for problems where it does not.

The thing I don't get is why both patches try to avoid setting the 
backlight brightness from def_value. Simple displays, especially 
monochrome ones are perfectly readable with the backlight off... zero 
brightness is not a "bad" value.

Not sure if Peter is still willing to rev his version of this code 
(given how badly we neglected him previously) or whether you want to try 
and combine both ideas.


Daniel.


> 
> Cheers,
> 
> Paul
> 
>> Fixes: 8b770e3c9824 ("backlight: Add GPIO-based backlight driver")
>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>> ---
>>   drivers/video/backlight/gpio_backlight.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
>> index e470da95d806..c9cb97fa13d0 100644
>> --- a/drivers/video/backlight/gpio_backlight.c
>> +++ b/drivers/video/backlight/gpio_backlight.c
>> @@ -57,6 +57,21 @@ static const struct backlight_ops gpio_backlight_ops = {
>>   	.check_fb	= gpio_backlight_check_fb,
>>   };
>>   
>> +static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
>> +{
>> +	struct device_node *node = gbl->dev->of_node;
>> +
>> +	/* If we absolutely want the backlight enabled at boot. */
>> +	if (gbl->def_value)
>> +		return FB_BLANK_UNBLANK;
>> +
>> +	/* If there's no panel to unblank the backlight later. */
>> +	if (!node || !node->phandle)
>> +		return FB_BLANK_UNBLANK;
>> +
>> +	return FB_BLANK_POWERDOWN;
>> +}
>> +
>>   static int gpio_backlight_probe_dt(struct platform_device *pdev,
>>   				   struct gpio_backlight *gbl)
>>   {
>> @@ -142,7 +157,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>>   		return PTR_ERR(bl);
>>   	}
>>   
>> -	bl->props.brightness = gbl->def_value;
>> +	bl->props.brightness = 1;
>> +	bl->props.power = gpio_backlight_initial_power_state(gbl);
>> +
>>   	backlight_update_status(bl);
>>   
>>   	platform_set_drvdata(pdev, bl);

From: Phil Reid <preid@electromag.com.au>
Date: Mon, 20 Jun 2016 06:29:12 +0000
Subject: Re: [PATCHv2] backlight: pwm_bl: disable PWM when 'duty_cycle' is zero
Message-Id: <9d79cc78-ef51-9461-c6dc-8a28945440ee@electromag.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1465294429-8570-1-git-send-email-LW@KARO-electronics.de>
 <20160609135125.GA2385@dell> <20160610072346.51b0a5d5@ipc1.ka-ro>
 <20160610074449.GB1537@dell> <20160610123453.3a8ee14e@ipc1.ka-ro>
 <20160610145449.GA7351@dell> <20160611090803.42aeaf5f@ipc1.ka-ro>
 <20160617141719.GH21702@dell> <20160620082118.10a639d5@ipc1.ka-ro>
In-Reply-To: <20160620082118.10a639d5@ipc1.ka-ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>, Lee Jones <lee.jones@linaro.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

On 20/06/2016 14:21, Lothar Waßmann wrote:
> Hi,
>
> On Fri, 17 Jun 2016 15:17:19 +0100 Lee Jones wrote:
>> On Sat, 11 Jun 2016, Lothar Waßmann wrote:
>>> On Fri, 10 Jun 2016 15:54:49 +0100 Lee Jones wrote:
>>>> On Fri, 10 Jun 2016, Lothar Waßmann wrote:
>>>>> On Fri, 10 Jun 2016 08:44:49 +0100 Lee Jones wrote:
>>>>>> On Fri, 10 Jun 2016, Lothar Waßmann wrote:
>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Thu, 9 Jun 2016 14:51:25 +0100 Lee Jones wrote:
>>>>>>>> On Tue, 07 Jun 2016, Lothar Waßmann wrote:
>>>>>>>>
>>>>>>>>> 'brightness' is usually an index into a table of duty_cycle values,
>>>>>>>>> where the value at index 0 may well be non-zero
>>>>>>>>> (tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dts are real-life
>>>>>>>>> examples).
>>>>>>>>> Thus brightness = 0 does not necessarily mean that the PWM output
>>>>>>>>> will be inactive.
>>>>>>>>> Check for 'duty_cycle = 0' rather than 'brightness = 0' to decide
>>>>>>>>> whether to disable the PWM.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
>>>>>>>>> ---
>>>>>>>>> Changes wrt. v1:
>>>>>>>>>   - update binding docs to reflect the change
>>>>>>>>>
>>>>>>>>>  .../devicetree/bindings/leds/backlight/pwm-backlight.txt         | 9 ++++++---
>>>>>>>>>  drivers/video/backlight/pwm_bl.c                                 | 4 ++--
>>>>>>>>>  2 files changed, 8 insertions(+), 5 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>>>>>>>>> index 764db86..95fa8a9 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>>>>>>>>> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>>>>>>>>> @@ -4,10 +4,13 @@ Required properties:
>>>>>>>>>    - compatible: "pwm-backlight"
>>>>>>>>>    - pwms: OF device-tree PWM specification (see PWM binding[0])
>>>>>>>>>    - brightness-levels: Array of distinct brightness levels. Typically these
>>>>>>>>> -      are in the range from 0 to 255, but any range starting at 0 will do.
>>>>>>>>> +      are in the range from 0 to 255, but any range will do.
>>>>>>>>>        The actual brightness level (PWM duty cycle) will be interpolated
>>>>>>>>> -      from these values. 0 means a 0% duty cycle (darkest/off), while the
>>>>>>>>> -      last value in the array represents a 100% duty cycle (brightest).
>>>>>>>>> +      from these values. 0 means a 0% duty cycle, while the highest value in
>>>>>>>>> +      the array represents a 100% duty cycle.
>>>>>>>>> +      The range may be in reverse order (starting with the maximum duty cycle
>>>>>>>>> +      value) to create a PWM signal with the 100% duty cycle representing
>>>>>>>>> +      minimum and 0% duty cycle maximum brigthness.
>>>>>>>>>    - default-brightness-level: the default brightness level (index into the
>>>>>>>>>        array defined by the "brightness-levels" property)
>>>>>>>>>    - power-supply: regulator for supply voltage
>>>>>>>>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
>>>>>>>>> index b2b366b..80b2b52 100644
>>>>>>>>> --- a/drivers/video/backlight/pwm_bl.c
>>>>>>>>> +++ b/drivers/video/backlight/pwm_bl.c
>>>>>>>>> @@ -103,8 +103,8 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>>>>>>>>>  	if (pb->notify)
>>>>>>>>>  		brightness = pb->notify(pb->dev, brightness);
>>>>>>>>>
>>>>>>>>> -	if (brightness > 0) {
>>>>>>>>> -		duty_cycle = compute_duty_cycle(pb, brightness);
>>>>>>>>> +	duty_cycle = compute_duty_cycle(pb, brightness);
>>>>>>>>> +	if (duty_cycle > 0) {
>>>>>>>>
>>>>>>>> How does this work in the aforementioned:
>>>>>>>>
>>>>>>>>   "The range may be in reverse order"
>>>>>>>>
>>>>>>>> ... case?  Surely when duty_cycle is when the screen should be at it's
>>>>>>>> brightest?  Wouldn't it confuse the user if they turn their brightness
>>>>>>>> *up* and the screen goes *off*?
>>>>>>>>
>>>>>>> Assuming that the PWM output is inactive (LOW) when the duty_cycle is
>>>>>>> set to zero, there will be no difference between operating the PWM at
>>>>>>> duty_cycle 0 or disabling it.
>>>>>>>
>>>>>>> Currently, the screen will go bright when it should be off in this
>>>>>>> case.
>>>>>>
>>>>>> It sounds like we need something that lets the framework know if
>>>>>> duty_cycle = MAX is the brightest or if duty_cycle = 0 is.  Either way
>>>>>> someone is going to get screwed by this logic.
>>>>>>
>>>>> The backlight framework does not (and does not need to) know anything
>>>>> about PWM duty cycles. Its 'brightness' values are consistently 0 =
>>>>> dark, max = brightest in either case.
>>>>
>>>> What I'm getting at is; by the look of the documentation, the
>>>> brightest setting can either be a duty cycle of 0 or 255.  So what
>>>> happens with your new semantics when the duty cycle of 0 represents
>>>> the brightest setting and you reach 0?  Didn't you just turn the
>>>> backlight off?
>>>>
>>> As mentioned earlier, disabling the PWM has generally the same result as
>>> setting the duty cycle to 0. The current behaviour is broken in this
>>> case, since setting brightness to 0 with a non-zero duty_cycle as the
>>> first element of brightness-levels, the PWM will be disabled rather than
>>> switched to the given duty cycle.
>>> Disabling the PWM should have the same effect as setting the duty cycle
>>> to 0, so it is safe to check for duty_cycle = 0 to decide whether to
>>> disable the PWM.
>>
>> I agree with this. BUT, that's not what you're doing is it?
>>
>> Look at the code you're trying to write:
>>
>> duty_cycle = compute_duty_cycle(pb, brightness);
>> if (duty_cycle > 0) {
>>         pwm_config(pb->pwm, duty_cycle, pb->period);
>>         pwm_backlight_power_on(pb, brightness);
>> } else
>>         pwm_backlight_power_off(pb);
>>
>> Let's say duty_cycle = 0.  In some cases this can mean "turn
>> brightness up to the *maximum*", but with your new logic you just
>> turned the backlight *off*.
>>
> Huh? Please think again!
>  - duty_cycle = 0 means a CONSTANT LOW level on the PWM output. Agreed?
>  - Disabling the PWM usually achieves a CONSTANT LOW level on the PWM
>    output. Agreed?
> So duty_cycle = 0  <=> disable the PWM no matter whether the backlight
> is darkest or brightest at this duty cycle setting!
>
> The backlight controller does not know anything about the value of the
> 'brightness' variable in the code but only sees the 'duty_cycle' value.
> When brightness = 0 translates into max. duty cycle, the original code
> will switch the PWM OFF (which is equivalent to a ZERO duty cycle), when
> it rather should operate at the max. duty cycle.
> When duty_cycle is '0', this is equivalent to the PWM output being at
> constant LOW level which is the same as being switched OFF in the usual
> cases.
>
> When the brightness is maximum at duty_cycle = 0, that means, that the
> backlight is brightest when the control pin is constantly LOW, which
> is usually the case when the PWM is disabled. This is exactly what the
> patch does achieve!
> With the current code a backlight that is brightest at a constant '0'
> level will turn to max. brightness rather than off when selecting
> brightness level 0 (max. PWM duty cycle).
>
>> Conversely, let's say duty_cycle = 255.  In some cases this can mean
>> "turn the brightness to the *lowest* setting" i.e. *off*. Well your
>> logic just turned the backlight *on*.
>>
> OK. Let's try a sequence of brightness levels and duty cycles:
> For simplicity assume a range of brightness levels from 0..100, so
> that the 'brightness' value directly represents the duty cycle of the
> PWM. So either: brightness = 0 => duty cycle = 0% => constant LOW
> Or: brightnes = 0 => duty cycle = 100% => constant HIGH.
>
> Normal range with current and patched code:
>  brightness   duty_cycle
>     0            0           PWM disabled => constant LOW
>     1            1           PWM active
>   ...
>   100          100           PWM active => constant HIGH
>
> Inverted range (backlight brightest at duty cycle 0)
> Current code:
>  brightness   duty_cycle
>     0          100           PWM disabled (OUTPUT CONSTANT LOW!)
>     1           99           PWM active with near full duty cycle
>   ...
>    99            1           PWM active with near ZERO duty cycle
>   100            0           PWM active with 0% duty cycle => constant LOW
>
> With my patch:
>  brightness   duty_cycle
>     0          100           PWM active with 100% duty cycle (constant HIGH)
>     1           99           PWM active with near full duty cycle
>   ...
>    99            1           PWM active with near ZERO duty cycle
>   100            0           PWM disabled => constant LOW
>
>
pwm_backlight_power_off() disables the regulator.
So the supply to Backlight disappears, regardless of constant low...



-- 
Regards
Phil Reid


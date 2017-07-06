From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 06 Jul 2017 09:57:26 +0000
Subject: Re: [PATCH v2 2/4] pwm-backlight: add support for pwm-delay-us property
Message-Id: <429fe130-4744-2846-185f-2d74bc20e68c@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170630112109.13785-1-enric.balletbo@collabora.com>
 <20170630112109.13785-2-enric.balletbo@collabora.com>
 <20170706080132.GL16144@ulmo.fritz.box> <20170706091231.GA6741@amd>
 <ac8bd991-be3c-c090-8e71-8f901b0a45a7@linaro.org>
 <20170706092448.GQ16144@ulmo.fritz.box>
In-Reply-To: <20170706092448.GQ16144@ulmo.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org, huang lin <hl@rock-chips.com>

On 06/07/17 10:24, Thierry Reding wrote:
> On Thu, Jul 06, 2017 at 10:17:18AM +0100, Daniel Thompson wrote:
>> On 06/07/17 10:12, Pavel Machek wrote:
>>> On Thu 2017-07-06 10:01:32, Thierry Reding wrote:
>>>> On Fri, Jun 30, 2017 at 01:21:07PM +0200, Enric Balletbo i Serra wrote:
>>>>> From: huang lin <hl@rock-chips.com>
>>>>>
>>>>> Some panels (i.e. N116BGE-L41), in their power sequence specifications,
>>>>> request a delay between set the PWM signal and enable the backlight and
>>>>> between clear the PWM signal and disable the backlight. Add support for
>>>>> the new pwm-delay-us property to meet the timing.
>>>>>
>>>>> Note that this patch inverts current sequence. Before this patch the
>>>>> enable signal was set before the PWM signal and vice-versa on power off.
>>>>>
>>>>> I assumed that this sequence was wrong, at least it is on different panel
>>>>> datasheets that I checked, so I inverted the sequence to follow:
>>>>>
>>>>>     On power on, set the PWM signal, wait, and set the LED_EN signal.
>>>>>     On power off, clear the LED_EN signal, wait, and stop the PWM signal.
>>>>
>>>> I think this should be two separate patches to make it easier to revert
>>>> the inverted sequence should it prove to regress on other panels.
>>>
>>> Don't make this overly complex. This is trivial. No need to split it
>>> into more patches.
>>
>> Agree. IMHO getting the code that reads the (optional) new parameter correct
>> is the best way to manage risk of regression since in most cases the delay
>> will be skipped anyway.
> 
> The potential regression that I'm referring to would be caused by
> inversing the sequence (GPIO enable -> PWM enable). That's completely
> unrelated to the delays introduced by this patch. Many boards use this
> driver and they've been running with the old sequence for many years.
> Granted, it's fairly unlikely to regress, but it's still a possibility.
> 
> Given that both changes are logically separate, I think separate patches
> are totally appropriate. I also don't think that this would overly
> complicate things.

... and you are right on both counts!

Thanks for the detailed reply.


Daniel.


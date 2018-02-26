From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Mon, 26 Feb 2018 09:57:25 +0000
Subject: Re: [PATCH v3 05/10] pwm: add PWM mode to pwm_config()
Message-Id: <87po4s2hve.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
 <1519300881-8136-6-git-send-email-claudiu.beznea@microchip.com>
 <20180222123308.mypx2r7n6o63mj5z@oak.lan>
In-Reply-To: <20180222123308.mypx2r7n6o63mj5z@oak.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>, Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: mark.rutland@arm.com, milo.kim@ti.com, linux-fbdev@vger.kernel.org, sean@mess.org, devicetree@vger.kernel.org, airlied@linux.ie, mturquette@baylibre.com, kamil@wypas.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, pavel@ucw.cz, lee.jones@linaro.org, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, linux-samsung-soc@vger.kernel.org, shc_work@mail.ru, corbet@lwn.net, linux-doc@vger.kernel.org, linux@armlinux.org.uk, krzk@kernel.org, kgene@kernel.org, linux-input@vger.kernel.org, linux@roeck-us.net, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, jdelvare@suse.com, b.zolnierkie@samsung.com, intel-gfx@lists.freedesktop.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, rodrigo.vivi@intel.com, mchehab@kernel.org, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, jingoohan1@gmail.com, dm

On Thu, 22 Feb 2018, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> On Thu, Feb 22, 2018 at 02:01:16PM +0200, Claudiu Beznea wrote:
>> Add PWM mode to pwm_config() function. The drivers which uses pwm_config()
>> were adapted to this change.
>> 
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  arch/arm/mach-s3c24xx/mach-rx1950.c  | 11 +++++++++--
>>  drivers/bus/ts-nbus.c                |  2 +-
>>  drivers/clk/clk-pwm.c                |  3 ++-
>>  drivers/gpu/drm/i915/intel_panel.c   | 17 ++++++++++++++---
>>  drivers/hwmon/pwm-fan.c              |  2 +-
>>  drivers/input/misc/max77693-haptic.c |  2 +-
>>  drivers/input/misc/max8997_haptic.c  |  6 +++++-
>>  drivers/leds/leds-pwm.c              |  5 ++++-
>>  drivers/media/rc/ir-rx51.c           |  5 ++++-
>>  drivers/media/rc/pwm-ir-tx.c         |  5 ++++-
>>  drivers/video/backlight/lm3630a_bl.c |  4 +++-
>>  drivers/video/backlight/lp855x_bl.c  |  4 +++-
>>  drivers/video/backlight/lp8788_bl.c  |  5 ++++-
>>  drivers/video/backlight/pwm_bl.c     | 11 +++++++++--
>>  drivers/video/fbdev/ssd1307fb.c      |  3 ++-
>>  include/linux/pwm.h                  |  6 ++++--
>>  16 files changed, 70 insertions(+), 21 deletions(-)
>> 
>> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
>> index 2030a6b77a09..696fa25dafd2 100644
>> --- a/drivers/video/backlight/lm3630a_bl.c
>> +++ b/drivers/video/backlight/lm3630a_bl.c
>> @@ -165,8 +165,10 @@ static void lm3630a_pwm_ctrl(struct lm3630a_chip *pchip, int br, int br_max)
>>  {
>>  	unsigned int period = pchip->pdata->pwm_period;
>>  	unsigned int duty = br * period / br_max;
>> +	struct pwm_caps caps = { };
>>  
>> -	pwm_config(pchip->pwmd, duty, period);
>> +	pwm_get_caps(pchip->pwmd->chip, pchip->pwmd, &caps);
>> +	pwm_config(pchip->pwmd, duty, period, BIT(ffs(caps.modes) - 1));
>
> Well... I admit I've only really looked at the patches that impact 
> backlight but dispersing this really odd looking bit twiddling 
> throughout the kernel doesn't strike me a great API design.
>
> IMHO callers should not be required to find the first set bit in
> some specially crafted set of capability bits simply to get sane 
> default behaviour.

Agreed. IMHO the regular use case becomes rather tedious, ugly, and
error prone.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center

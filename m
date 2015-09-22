From: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Tue, 22 Sep 2015 06:36:22 +0000
Subject: Re: [PATCH v3 01/12] pwm: introduce default period and polarity concepts
Message-Id: <5600F6E6.8050406@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1442828009-6241-2-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1442828009-6241-2-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Boris,

On 09/21/2015 11:33 AM, Boris Brezillon wrote:
> When requested by a user, the PWM is assigned a default period and polarity
> extracted from the DT, the platform data or statically set by the driver.
> Those default values are currently stored in the period and polarity
> fields of the pwm_device struct, but they will be stored somewhere else
> once we have introduced the architecture allowing for hardware state
> retrieval.
>
> The pwm_set_default_polarity and pwm_set_default_period should only be
> used by PWM drivers or the PWM core infrastructure to specify the
> default period and polarity values.
>
> PWM users might call the pwm_get_default_period to query the default
> period value. There is currently no helper to query the default
> polarity, but it might be added later on if there is a need for it.
>
> This patch also modifies all the places where the default helpers should
> be used in place of the standard ones.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>   drivers/leds/leds-pwm.c              |  2 +-
>   drivers/pwm/core.c                   | 14 +++++++-------
>   drivers/pwm/pwm-pxa.c                |  2 +-
>   drivers/pwm/pwm-sun4i.c              |  3 ++-
>   drivers/regulator/pwm-regulator.c    |  4 ++--
>   drivers/video/backlight/lm3630a_bl.c |  4 ++--
>   drivers/video/backlight/pwm_bl.c     |  2 +-
>   drivers/video/fbdev/ssd1307fb.c      |  2 +-
>   include/linux/pwm.h                  | 17 +++++++++++++++++
>   9 files changed, 34 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index 1d07e3e..2c564d1 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -125,7 +125,7 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>   	if (led_data->can_sleep)
>   		INIT_WORK(&led_data->work, led_pwm_work);
>
> -	led_data->period = pwm_get_period(led_data->pwm);
> +	led_data->period = pwm_get_default_period(led_data->pwm);
>   	if (!led_data->period && (led->pwm_period_ns > 0))
>   		led_data->period = led->pwm_period_ns;
>

Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best Regards,
Jacek Anaszewski

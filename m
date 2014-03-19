From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Date: Wed, 19 Mar 2014 14:20:01 +0000
Subject: Re: [PATCH 11/16] avr32: merisc: use generic leds_pwm driver
Message-Id: <20140319142001.GC20872@samfundet.no>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395234209-15546-12-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1395234209-15546-12-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Around Wed 19 Mar 2014 14:03:24 +0100 or thereabout, Alexandre Belloni wrote:
> Switch to the generic leds_pwm driver instead of leds-atmel-pwm.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

I do not have this board either.

> ---
>  arch/avr32/boards/merisc/setup.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/avr32/boards/merisc/setup.c b/arch/avr32/boards/merisc/setup.c
> index ed137e335796..b0980c1946a7 100644
> --- a/arch/avr32/boards/merisc/setup.c
> +++ b/arch/avr32/boards/merisc/setup.c
> @@ -22,6 +22,8 @@
>  #include <linux/irq.h>
>  #include <linux/fb.h>
>  #include <linux/atmel-mci.h>
> +#include <linux/pwm.h>
> +#include <linux/leds_pwm.h>
>  
>  #include <asm/io.h>
>  #include <asm/setup.h>
> @@ -167,24 +169,29 @@ static struct i2c_board_info __initdata i2c_info[] = {
>  	},
>  };
>  
> -#ifdef CONFIG_LEDS_ATMEL_PWM
> -static struct gpio_led stk_pwm_led[] = {
> +#if IS_ENABLED(CONFIG_LEDS_PWM)
> +static struct pwm_lookup pwm_lookup[] = {
> +	PWM_LOOKUP("at91sam9rl-pwm", 0, "leds_pwm", "backlight"),
> +};
> +
> +static struct led_pwm pwm_leds[] = {
>  	{
>  		.name	= "backlight",
> -		.gpio	= 0,		/* PWM channel 0 (LCD backlight) */
> +		.max_brightness = 255,
> +		.pwm_period_ns  = 5000,
>  	},
>  };
>  
> -static struct gpio_led_platform_data stk_pwm_led_data = {
> -	.num_leds	= ARRAY_SIZE(stk_pwm_led),
> -	.leds		= stk_pwm_led,
> +static struct led_pwm_platform_data pwm_data = {
> +	.num_leds       = ARRAY_SIZE(pwm_leds),
> +	.leds           = pwm_leds,
>  };
>  
> -static struct platform_device stk_pwm_led_dev = {
> -	.name	= "leds-atmel-pwm",
> -	.id	= -1,
> -	.dev	= {
> -		.platform_data	= &stk_pwm_led_data,
> +static struct platform_device leds_pwm = {
> +	.name   = "leds_pwm",
> +	.id     = -1,
> +	.dev    = {
> +		.platform_data = &pwm_data,
>  	},
>  };
>  #endif
> @@ -278,9 +285,10 @@ static int __init merisc_init(void)
>  
>  	at32_add_device_mci(0, &mci0_data);
>  
> -#ifdef CONFIG_LEDS_ATMEL_PWM
> +#if IS_ENABLED(CONFIG_LEDS_PWM)
> +	pwm_add_table(pwm_lookup, ARRAY_SIZE(pwm_lookup));
>  	at32_add_device_pwm((1 << 0) | (1 << 2));
> -	platform_device_register(&stk_pwm_led_dev);
> +	platform_device_register(&leds_pwm);
>  #else
>  	at32_add_device_pwm((1 << 2));
>  #endif
-- 
mvh
Hans-Christian Egtvedt

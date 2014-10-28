From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Tue, 28 Oct 2014 19:13:17 +0000
Subject: Re: [PATCH 12/15] ARM: pxa: poodle: don't preallocate IRQ space for locomo
Message-Id: <87bnow80tu.fsf@free.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-13-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1414454528-24240-13-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Tue, 28 Oct 2014 03:02:05 +0300")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-fbdev@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, alsa-devel@alsa-project.org, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Daniel Mack <daniel@zonque.org>, Lee Jones <lee.jones@linaro.org>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

...zip...

> diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
> index 3041d83..97eced9 100644
> --- a/arch/arm/mach-pxa/poodle.c
> +++ b/arch/arm/mach-pxa/poodle.c
> @@ -181,14 +181,18 @@ static struct locomo_platform_data locomo_info = {
>  	.gpio_data = {
>  		.gpio_base = POODLE_LOCOMO_GPIO_BASE,
>  	},
> -	.bl_data = {
> +	.lcd_data = {
Is that part really belonging to that patch ? It seems to me that this changes
the code included in patch 10/15 "ARM: pxa: poodle: use new LoCoMo
driver".

Therefore I'm wondering if I take the serie, halt it at patch 10, and try to
compile I would succeed ... I think I wouldn't.

> +	},
> +	.bl_data = {
>  		.gpio_fl_vr       = POODLE_GPIO_FL_VR,
>  	},
Ditto.

> +	.gpio_amp1_on	= -1,
> +	.gpio_amp2_on	= -1,
This won't prevent compilation, but is it the target of this patch which is IRQ
space oriented ?

> @@ -453,7 +457,7 @@ static void __init poodle_init(void)
>  	platform_scoop_config = &poodle_pcmcia_config;
>  
>  	if (sharpsl_param.comadj != -1)
> -		locomo_info.bl_data.comadj = sharpsl_param.comadj;
> +		locomo_info.lcd_data.comadj = sharpsl_param.comadj;
Ditto.

Cheers.

-- 
Robert

From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 17 Oct 2019 11:37:07 +0000
Subject: Re: [PATCH 29/34] backlight/jornada720: Use CONFIG_PREEMPTION
Message-Id: <20191017113707.lsjwlhi6b4ittcpe@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-30-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-30-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

On Tue, Oct 15, 2019 at 09:18:16PM +0200, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> Both PREEMPT and PREEMPT_RT require the same functionality which today
> depends on CONFIG_PREEMPT.
> 
> Switch the Kconfig dependency to CONFIG_PREEMPTION.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: +LCD_HP700]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

(I know... the review for this particular patch is trivial but an
Acked-by from a maintainer means something specific and it is Lee
Jones who coordinates landing cross sub-system patch sets for
backlight).


Daniel.

> ---
>  drivers/video/backlight/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 40676be2e46aa..d09396393724b 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -99,7 +99,7 @@ config LCD_TOSA
>  
>  config LCD_HP700
>  	tristate "HP Jornada 700 series LCD Driver"
> -	depends on SA1100_JORNADA720_SSP && !PREEMPT
> +	depends on SA1100_JORNADA720_SSP && !PREEMPTION
>  	default y
>  	help
>  	  If you have an HP Jornada 700 series handheld (710/720/728)
> @@ -228,7 +228,7 @@ config BACKLIGHT_HP680
>  
>  config BACKLIGHT_HP700
>  	tristate "HP Jornada 700 series Backlight Driver"
> -	depends on SA1100_JORNADA720_SSP && !PREEMPT
> +	depends on SA1100_JORNADA720_SSP && !PREEMPTION
>  	default y
>  	help
>  	  If you have an HP Jornada 700 series,
> -- 
> 2.23.0
> 

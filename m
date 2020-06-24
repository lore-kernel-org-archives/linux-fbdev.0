From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 24 Jun 2020 15:32:16 +0000
Subject: Re: [PATCH 0/8] Fix a bunch of W=1 warnings in Backlight
Message-Id: <20200624153216.GA1814806@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
In-Reply-To: <20200624145721.2590327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: daniel.thompson@linaro.org, jingoohan1@gmail.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Lee.

On Wed, Jun 24, 2020 at 03:57:13PM +0100, Lee Jones wrote:
> Attempting to clean-up W=1 kernel builds, which are currently
> overwhelmingly riddled with niggly little warnings.
> 
> Lee Jones (8):
>   backlight: lms501kf03: Remove unused const variables
>   backlight: lcd: Add missing kerneldoc entry for 'struct device parent'


>   backlight: ili922x: Add missing kerneldoc descriptions for
>     CHECK_FREQ_REG() args
>   backlight: ili922x: Remove invalid use of kerneldoc syntax
>   backlight: ili922x: Add missing kerneldoc description for
>     ili922x_reg_dump()'s arg
I wonder why these warnings show up as nothing pulls in this .c file.
Anyway I would suggest to drop using kerneldoc syntax for single drivers
like this - and the benefit here is low.
Now they are typed, otherwise this ahd been fine in a single patch.

>   backlight: backlight: Supply description for function args in existing
>     Kerneldocs
>   backlight: lm3630a_bl: Remove invalid checks for unsigned int < 0
>   backlight: qcom-wled: Remove unused configs for LED3 and LED4

The other fixes looks good.
They are all:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam

>  drivers/video/backlight/backlight.c  | 2 ++
>  drivers/video/backlight/ili922x.c    | 8 ++++++--
>  drivers/video/backlight/lcd.c        | 1 +
>  drivers/video/backlight/lm3630a_bl.c | 4 ++--
>  drivers/video/backlight/lms501kf03.c | 8 --------
>  drivers/video/backlight/qcom-wled.c  | 8 --------
>  6 files changed, 11 insertions(+), 20 deletions(-)
> 
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

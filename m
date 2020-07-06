From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 06 Jul 2020 07:13:40 +0000
Subject: Re: [PATCH 0/8] Fix a bunch of W=1 warnings in Backlight
Message-Id: <20200706071340.GC2821869@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
In-Reply-To: <20200624145721.2590327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: daniel.thompson@linaro.org, jingoohan1@gmail.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 24 Jun 2020, Lee Jones wrote:

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
>   backlight: backlight: Supply description for function args in existing
>     Kerneldocs
>   backlight: lm3630a_bl: Remove invalid checks for unsigned int < 0
>   backlight: qcom-wled: Remove unused configs for LED3 and LED4
> 
>  drivers/video/backlight/backlight.c  | 2 ++
>  drivers/video/backlight/ili922x.c    | 8 ++++++--
>  drivers/video/backlight/lcd.c        | 1 +
>  drivers/video/backlight/lm3630a_bl.c | 4 ++--
>  drivers/video/backlight/lms501kf03.c | 8 --------
>  drivers/video/backlight/qcom-wled.c  | 8 --------
>  6 files changed, 11 insertions(+), 20 deletions(-)

All applied to Backlight.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

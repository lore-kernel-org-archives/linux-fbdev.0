From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 08 Jul 2020 13:06:34 +0000
Subject: Re: [PATCH 1/1] video: backlight: sky81452-backlight: Fix some kerneldoc issues
Message-Id: <20200708130634.5tttrzlq2zfx7uho@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200708130419.3445042-1-lee.jones@linaro.org>
In-Reply-To: <20200708130419.3445042-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Gyungoh Yoo <jack.yoo@skyworksinc.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org

On Wed, Jul 08, 2020 at 02:04:19PM +0100, Lee Jones wrote:
> Firstly, all lines must begin with a '*'.  Secondly, arg descriptions
> must be spelt correctly, so fix misspelling of 'gpioD_enable' and
> 'short_detecTion_threshold'
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/video/backlight/sky81452-backlight.c:46: warning: bad line:                 If it is not defined, default name is lcd-backlight.
>  drivers/video/backlight/sky81452-backlight.c:64: warning: Function parameter or member 'gpiod_enable' not described in 'sky81452_bl_platform_data'
>  drivers/video/backlight/sky81452-backlight.c:64: warning: Function parameter or member 'short_detection_threshold' not described in 'sky81452_bl_platform_data'
> 
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Gyungoh Yoo <jack.yoo@skyworksinc.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

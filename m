From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 21 Jul 2020 13:52:33 +0000
Subject: Re: [PATCH 1/1] video: backlight: cr_bllcd: Remove unused variable 'intensity'
Message-Id: <20200721135233.53gmti745t66la5i@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200721073919.925935-1-lee.jones@linaro.org>
In-Reply-To: <20200721073919.925935-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org

On Tue, Jul 21, 2020 at 08:39:19AM +0100, Lee Jones wrote:
> Fixes the following kernel build warning:
> 
>  drivers/video/backlight/cr_bllcd.c: In function ‘cr_backlight_set_intensity’:
>  drivers/video/backlight/cr_bllcd.c:62:6: warning: unused variable ‘intensity’ [-Wunused-variable]
>  62 | int intensity = bd->props.brightness;
>  | ^~~~~~~~~
> 
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Fixes: 24d34617c24f ("backlight: cr_bllcd: Introduce gpio-backlight semantics")
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I doubt you are awaiting this for a one line fixup... but just in case:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

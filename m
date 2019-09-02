From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 02 Sep 2019 09:11:30 +0000
Subject: Re: [PATCH v3] backlight: gpio-backlight: Correct initial power state handling
Message-Id: <20190902091130.GG32232@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190731084018.5318-1-peter.ujfalusi@ti.com>
In-Reply-To: <20190731084018.5318-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: daniel.thompson@linaro.org, jingoohan1@gmail.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, paul.kocialkowski@bootlin.com

On Wed, 31 Jul 2019, Peter Ujfalusi wrote:

> The default-on property - or the def_value via legacy pdata) should be
> handled as:
> if it is 1, the backlight must be enabled (kept enabled)
> if it is 0, the backlight must be disabled (kept disabled)
> 
> This only works for the case when default-on is set. If it is not set then
> the brightness of the backlight is set to 0. Now if the backlight is
> enabled by external driver (graphics) the backlight will stay disabled since
> the brightness is configured as 0. The backlight will not turn on.
> 
> In order to minimize screen flickering during device boot:
> 
> The initial brightness should be set to 1.
> 
> If booted in non DT mode or no phandle link to the backlight node:
> follow the def_value/default-on to select UNBLANK or POWERDOWN
> 
> If in DT boot we have phandle link then leave the GPIO in a state which the
> bootloader left it and let the user of the backlight to configure it
> further.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> sorry for the delay, but got distracted a bit with the resend of this...
> Let's try again ;)
> 
> Changes since v2 (https://lore.kernel.org/patchwork/patch/1002359/):
> - Rebased on drm-next
> 
> Changes since v1:
> - Implement similiar initial power state handling as pwm backlight have
> 
> Regards,
> Peter
> 
>  drivers/video/backlight/gpio_backlight.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

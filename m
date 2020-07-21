From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 21 Jul 2020 08:00:22 +0000
Subject: Re: [PATCH 1/1] video: backlight: cr_bllcd: Remove unused variable 'intensity'
Message-Id: <20200721080022.GA41608@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200721073919.925935-1-lee.jones@linaro.org>
In-Reply-To: <20200721073919.925935-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Lee.

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

Thanks for fixing this.
The driver only build for X86 so the warnings was lost in other build
noise.
One more thing to improve before next submission - sorry for this.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  drivers/video/backlight/cr_bllcd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backlight/cr_bllcd.c
> index a24d42e1ea3cd..4ad0a72531fe2 100644
> --- a/drivers/video/backlight/cr_bllcd.c
> +++ b/drivers/video/backlight/cr_bllcd.c
> @@ -59,7 +59,6 @@ struct cr_panel {
>  
>  static int cr_backlight_set_intensity(struct backlight_device *bd)
>  {
> -	int intensity = bd->props.brightness;
>  	u32 addr = gpio_bar + CRVML_PANEL_PORT;
>  	u32 cur = inl(addr);
>  
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

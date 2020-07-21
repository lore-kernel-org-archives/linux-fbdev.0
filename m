From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 21 Jul 2020 14:47:11 +0000
Subject: Re: [PATCH -next] backlight: cr_bllcd: Remove unused variable 'intensity'
Message-Id: <20200721144711.GF621928@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200721134841.33893-1-weiyongjun1@huawei.com>
In-Reply-To: <20200721134841.33893-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Hulk Robot <hulkci@huawei.com>, Sam Ravnborg <sam@ravnborg.org>

On Tue, 21 Jul 2020, Wei Yongjun wrote:

> Gcc report unused-variable warning as follows:
> 
> drivers/video/backlight/cr_bllcd.c:62:6: warning:
>  unused variable 'intensity' [-Wunused-variable]
>    62 |  int intensity = bd->props.brightness;
>       |      ^~~~~~~~~
> 
> After commit 24d34617c24f ("backlight: cr_bllcd: Introduce
> gpio-backlight semantics"), this variable is never used, this
> commit removing it.
> 
> Fixes: 24d34617c24f ("backlight: cr_bllcd: Introduce gpio-backlight semantics")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/video/backlight/cr_bllcd.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks for the patch, but this has already been fixed.

> diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backlight/cr_bllcd.c
> index a24d42e1ea3c..4ad0a72531fe 100644
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
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

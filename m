From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 06 Mar 2012 10:05:32 +0000
Subject: RE: [PATCH 2/3] video: s3c-fb: remove 'default_win' element from platform data
Message-Id: <002801ccfb80$aac11cf0$004356d0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330789808-8253-1-git-send-email-thomas.abraham@linaro.org>
 <1330789808-8253-3-git-send-email-thomas.abraham@linaro.org>
In-Reply-To: <1330789808-8253-3-git-send-email-thomas.abraham@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-fbdev@vger.kernel.org
Cc: FlorianSchandinat@gmx.de, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org, 'Jingoo Han' <jg1.han@samsung.com>

> -----Original Message-----
> From: Thomas Abraham [mailto:thomas.abraham@linaro.org]
> Sent: Sunday, March 04, 2012 12:50 AM
> To: linux-fbdev@vger.kernel.org
> Cc: FlorianSchandinat@gmx.de; linux-samsung-soc@vger.kernel.org; kgene.kim@samsung.com;
> jg1.han@samsung.com; ben-linux@fluff.org; patches@linaro.org
> Subject: [PATCH 2/3] video: s3c-fb: remove 'default_win' element from platform data
> 
> The decision to enable or disable the data output to the lcd panel from
> the controller need not be based on the value of 'default_win' element
> in the platform data. Instead, the data output to the panel is enabled
> if any of the windows are active, else data output is disabled.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/plat-samsung/include/plat/fb.h |    2 --
>  drivers/video/s3c-fb.c                  |   24 ++++--------------------
>  2 files changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
> index 39d6bd7..536002f 100644
> --- a/arch/arm/plat-samsung/include/plat/fb.h
> +++ b/arch/arm/plat-samsung/include/plat/fb.h
> @@ -62,8 +62,6 @@ struct s3c_fb_platdata {
>  	struct s3c_fb_pd_win	*win[S3C_FB_MAX_WIN];
>  	struct fb_videomode     *vtiming;
> 
> -	u32			 default_win;
> -
>  	u32			 vidcon0;
>  	u32			 vidcon1;
>  };
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 8e05d4d..8baba31 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -531,7 +531,7 @@ static int s3c_fb_set_par(struct fb_info *info)
>  	/* disable the window whilst we update it */
>  	writel(0, regs + WINCON(win_no));
> 
> -	if (win_no = sfb->pdata->default_win)
> +	if (!sfb->output_on)
>  		s3c_fb_enable(sfb, 1);
> 
>  	/* write the buffer address */
> @@ -792,7 +792,7 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
>  	struct s3c_fb_win *win = info->par;
>  	struct s3c_fb *sfb = win->parent;
>  	unsigned int index = win->index;
> -	u32 wincon;
> +	u32 wincon, output_on = sfb->output_on;

Can you add new line as below? It's more readable.
+	u32 output_on = sfb->output_on;
Sorry for nitpicking.

> 
>  	dev_dbg(sfb->dev, "blank mode %d\n", blank_mode);
> 
> @@ -838,27 +838,11 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
>  	 * it is highly likely that we also do not need to output
>  	 * anything.
>  	 */
> -
> -	/* We could do something like the following code, but the current
> -	 * system of using framebuffer events means that we cannot make
> -	 * the distinction between just window 0 being inactive and all
> -	 * the windows being down.
> -	 *
> -	 * s3c_fb_enable(sfb, sfb->enabled ? 1 : 0);
> -	*/
> -
> -	/* we're stuck with this until we can do something about overriding
> -	 * the power control using the blanking event for a single fb.
> -	 */
> -	if (index = sfb->pdata->default_win) {
> -		shadow_protect_win(win, 1);
> -		s3c_fb_enable(sfb, blank_mode != FB_BLANK_POWERDOWN ? 1 : 0);
> -		shadow_protect_win(win, 0);
> -	}
> +	s3c_fb_enable(sfb, sfb->enabled ? 1 : 0);

However, shadow_protect_win() is necessary as belows.
Because shadow registers such as VIDCON0 should be protectd
whenever the registers are updated. The s3c_fb_enable() updates
VIDCON0.
+	shadow_protect_win(win, 1);
+	s3c_fb_enable(sfb, sfb->enabled ? 1 : 0);
+	shadow_protect_win(win, 0);

> 
>  	pm_runtime_put_sync(sfb->dev);
> 
> -	return 0;
> +	return output_on = sfb->output_on;
>  }
> 
>  /**
> --
> 1.6.6.rc2


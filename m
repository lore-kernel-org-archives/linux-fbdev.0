From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 06 Sep 2019 18:36:15 +0000
Subject: Re: [PATCH] fbdev/sa1100fb: Remove even more dead code
Message-Id: <20190906183615.GH3958@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190906151307.1127187-1-arnd@arndb.de>
In-Reply-To: <20190906151307.1127187-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Viresh Kumar <viresh.kumar@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>

On Fri, Sep 06, 2019 at 05:13:00PM +0200, Arnd Bergmann wrote:
> This function lost its only call site as part of
> earlier dead code removal, so remove it as well:
> 
> drivers/video/fbdev/sa1100fb.c:975:21: error: unused function 'sa1100fb_min_dma_period' [-Werror,-Wunused-function]
> 
> Fixes: 390e5de11284 ("fbdev/sa1100fb: Remove dead code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Queud for 5.5 in drm-misc-next since Bart is away from merge duties until
end of this month.
-Daniel
> ---
>  drivers/video/fbdev/sa1100fb.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
> index ae2bcfee338a..81ad3aa1ca06 100644
> --- a/drivers/video/fbdev/sa1100fb.c
> +++ b/drivers/video/fbdev/sa1100fb.c
> @@ -967,19 +967,6 @@ static void sa1100fb_task(struct work_struct *w)
>  }
>  
>  #ifdef CONFIG_CPU_FREQ
> -/*
> - * Calculate the minimum DMA period over all displays that we own.
> - * This, together with the SDRAM bandwidth defines the slowest CPU
> - * frequency that can be selected.
> - */
> -static unsigned int sa1100fb_min_dma_period(struct sa1100fb_info *fbi)
> -{
> -	/*
> -	 * FIXME: we need to verify _all_ consoles.
> -	 */
> -	return sa1100fb_display_dma_period(&fbi->fb.var);
> -}
> -
>  /*
>   * CPU clock speed change handler.  We need to adjust the LCD timing
>   * parameters when the CPU clock is adjusted by the power management
> -- 
> 2.20.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

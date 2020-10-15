From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 15 Oct 2020 08:10:15 +0000
Subject: Re: [PATCH] video: fbdev: sh_mobile_lcdcfb: Remove redundant null check before clk_prepare_enable/cl
Message-Id: <20201015101015.6dbd25ce@linux-uq9g>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20201014085722.26069-1-vulab@iscas.ac.cn>
In-Reply-To: <20201014085722.26069-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Xu Wang <vulab@iscas.ac.cn>
Cc: linux-fbdev@vger.kernel.org, arnd@arndb.de, b.zolnierkie@samsung.com, jani.nikula@intel.com, daniel.vetter@ffwll.ch, gustavoars@kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 08:57:22 +0000 Xu Wang <vulab@iscas.ac.cn> wrote:

> Because clk_prepare_enable() and clk_disable_unprepare() already checked
> NULL clock parameter, so the additional checks are unnecessary, just
> remove them.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> b/drivers/video/fbdev/sh_mobile_lcdcfb.c index c1043420dbd3..c0952cc96bdb
> 100644 --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -341,8 +341,7 @@ static void lcdc_wait_bit(struct sh_mobile_lcdc_priv
> *priv, static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
>  {
>  	if (atomic_inc_and_test(&priv->hw_usecnt)) {
> -		if (priv->dot_clk)
> -			clk_prepare_enable(priv->dot_clk);
> +		clk_prepare_enable(priv->dot_clk);
>  		pm_runtime_get_sync(priv->dev);
>  	}
>  }
> @@ -351,8 +350,7 @@ static void sh_mobile_lcdc_clk_off(struct
> sh_mobile_lcdc_priv *priv) {
>  	if (atomic_sub_return(1, &priv->hw_usecnt) = -1) {
>  		pm_runtime_put(priv->dev);
> -		if (priv->dot_clk)
> -			clk_disable_unprepare(priv->dot_clk);
> +		clk_disable_unprepare(priv->dot_clk);
>  	}
>  }
>  



-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 Jul 2020 14:23:56 +0000
Subject: Re: [PATCH] omapfb: dss: Fix max fclk divider for omap36xx
Message-Id: <e7bb19a5-774c-63c3-058f-1977d29cd94c@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200630182652eucas1p1ce5e07b065127e32ab734f4447c2f735@eucas1p1.samsung.com>
 <20200630182636.439015-1-aford173@gmail.com>
In-Reply-To: <20200630182636.439015-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adam Ford <aford173@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org


On 6/30/20 8:26 PM, Adam Ford wrote:
> The drm/omap driver was fixed to correct an issue where using a
> divider of 32 breaks the DSS despite the TRM stating 32 is a valid
> number.  Through experimentation, it appears that 31 works, and
> it is consistent with the value used by the drm/omap driver.
> 
> This patch fixes the divider for fbdev driver instead of the drm.
> 
> Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")
> 
> Cc: <stable@vger.kernel.org> #4.9+
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied to drm-misc-next tree, thanks.

(I marked patch as applicable to stable 4.5+ while merging)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> Linux 4.4 will need a similar patch, but it doesn't apply cleanly.
> 
> The DRM version of this same fix is:
> e2c4ed148cf3 ("drm/omap: fix max fclk divider for omap36xx")
> 
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> index 7252d22dd117..bfc5c4c5a26a 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> @@ -833,7 +833,7 @@ static const struct dss_features omap34xx_dss_feats = {
>  };
>  
>  static const struct dss_features omap3630_dss_feats = {
> -	.fck_div_max		=	32,
> +	.fck_div_max		=	31,
>  	.dss_fck_multiplier	=	1,
>  	.parent_clk_name	=	"dpll4_ck",
>  	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
> 

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 31 Oct 2013 10:47:40 +0000
Subject: Re: [PATCH 12/12] fbdev: shmobile-lcdcfb: Convert to clk_prepare/unprepare
Message-Id: <20131031104740.GA18477@ns203013.ovh.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383000569-8916-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 23:49 Mon 28 Oct     , Laurent Pinchart wrote:
> Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> clk_disable_unprepare() to get ready for the migration to the common
> clock framework.
> 
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/video/sh_mobile_lcdcfb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
> index 0264704..eaeae0f 100644
> --- a/drivers/video/sh_mobile_lcdcfb.c
> +++ b/drivers/video/sh_mobile_lcdcfb.c
> @@ -344,7 +344,7 @@ static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
>  {
>  	if (atomic_inc_and_test(&priv->hw_usecnt)) {
>  		if (priv->dot_clk)
> -			clk_enable(priv->dot_clk);
> +			clk_prepare_enable(priv->dot_clk);
>  		pm_runtime_get_sync(priv->dev);
>  		if (priv->meram_dev && priv->meram_dev->pdev)
>  			pm_runtime_get_sync(&priv->meram_dev->pdev->dev);
> @@ -358,7 +358,7 @@ static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv)
>  			pm_runtime_put_sync(&priv->meram_dev->pdev->dev);
>  		pm_runtime_put(priv->dev);
>  		if (priv->dot_clk)
> -			clk_disable(priv->dot_clk);
> +			clk_disable_unprepare(priv->dot_clk);
>  	}
>  }
>  
> -- 
> 1.8.1.5
> 

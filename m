From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Wed, 12 Jun 2013 12:08:00 +0000
Subject: Re: [V2 3/7] video: mmp: fix graphics/video layer enable/mask swap issue
Message-Id: <20130612120800.GC305@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370879521-10962-1-git-send-email-jtzhou@marvell.com>
 <1370879552-11290-1-git-send-email-jtzhou@marvell.com>
In-Reply-To: <1370879552-11290-1-git-send-email-jtzhou@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 23:52 Mon 10 Jun     , Jett.Zhou wrote:
> From: Jing Xiang <jxiang@marvell.com>
> 
> There is bug when switch dma of graphic layer and video layer, it
> configured opposite bit, fix it.
> 
> Signed-off-by: Jing Xiang <jxiang@marvell.com>
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
do you need those 2 fixes for 3.10 or it can wait for 3.11?

Best Regards,
J.
> ---
>  drivers/video/mmp/hw/mmp_ctrl.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
> index 3a8c2a3..8836053 100644
> --- a/drivers/video/mmp/hw/mmp_ctrl.c
> +++ b/drivers/video/mmp/hw/mmp_ctrl.c
> @@ -160,9 +160,9 @@ static void overlay_set_win(struct mmp_overlay *overlay, struct mmp_win *win)
>  
>  static void dmafetch_onoff(struct mmp_overlay *overlay, int on)
>  {
> -	u32 mask = overlay_is_vid(overlay) ? CFG_GRA_ENA_MASK :
> -		   CFG_DMA_ENA_MASK;
> -	u32 enable = overlay_is_vid(overlay) ? CFG_GRA_ENA(1) : CFG_DMA_ENA(1);
> +	u32 mask = overlay_is_vid(overlay) ? CFG_DMA_ENA_MASK :
> +		   CFG_GRA_ENA_MASK;
> +	u32 enable = overlay_is_vid(overlay) ? CFG_DMA_ENA(1) : CFG_GRA_ENA(1);
>  	u32 tmp;
>  	struct mmp_path *path = overlay->path;
>  
> -- 
> 1.7.0.4
> 

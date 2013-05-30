From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 30 May 2013 11:09:45 +0000
Subject: Re: [PATCH 05/32] OMAPDSS: fix dss_get_ctx_loss_count for DT
Message-Id: <20130530110945.GI19468@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
 <1369906493-27538-6-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1369906493-27538-6-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On 12:34 Thu 30 May     , Tomi Valkeinen wrote:
> When using DT, dss device does not have platform data. However,
> dss_get_ctx_loss_count() uses dss device's platform data to find the
> get_ctx_loss_count function pointer.
> 
> To fix this, dss_get_ctx_loss_count() needs to be changed to get the
> platform data from the omapdss device, which is a "virtual" device and
> always has platform data.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/dss/dss.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 94f66f9..bd01608 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -157,7 +157,8 @@ static void dss_restore_context(void)
>  
>  int dss_get_ctx_loss_count(void)
>  {
> -	struct omap_dss_board_info *board_data = dss.pdev->dev.platform_data;
> +	struct platform_device *core_pdev = dss_get_core_pdev();
> +	struct omap_dss_board_info *board_data = core_pdev->dev.platform_data;

	how about store the pdata in the drivers internal struct and if !dt
	you ust do this

	dss_dev->pdata = *pdev->dev.platform_data;

	to copy it and we do not alloc it for dt

Best Regards,
J.
>  	int cnt;
>  
>  	if (!board_data->get_context_loss_count)
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

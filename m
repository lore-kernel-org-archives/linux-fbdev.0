From: Archit Taneja <a0393947@ti.com>
Date: Wed, 05 Sep 2012 09:27:27 +0000
Subject: Re: [PATCH 12/17] OMAPDSS: clean up dss_mgr_set_timings
Message-Id: <5047182F.3030507@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com> <1346833555-31258-13-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1346833555-31258-13-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 05 September 2012 01:55 PM, Tomi Valkeinen wrote:
> dss_mgr_set_timings() can only be called when the output is not active.
> This means that most of the code in the function is extra, as there's no
> need to write the values to registers, etc, because that will be handled
> when the output will be enabled.

We need to fix dpi_set_timings() before we can make this change. DPI 
still tries to change timings on the fly, i.e, with manager enabled. We 
need to disable and enable the DPI output like we do for other outputs.

Archit

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/apply.c |   18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
> index 53629dd..1b49019 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -1314,21 +1314,19 @@ void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
>   		const struct omap_video_timings *timings)
>   {
>   	unsigned long flags;
> -
> -	mutex_lock(&apply_lock);
> +	struct mgr_priv_data *mp = get_mgr_priv(mgr);
>
>   	spin_lock_irqsave(&data_lock, flags);
>
> -	dss_apply_mgr_timings(mgr, timings);
> -
> -	dss_write_regs();
> -	dss_set_go_bits();
> +	if (mp->enabled) {
> +		DSSERR("cannot set timings for %s: manager needs to be disabled\n",
> +			mgr->name);
> +		goto out;
> +	}
>
> +	dss_apply_mgr_timings(mgr, timings);
> +out:
>   	spin_unlock_irqrestore(&data_lock, flags);
> -
> -	wait_pending_extra_info_updates();
> -
> -	mutex_unlock(&apply_lock);
>   }
>
>   static void dss_apply_mgr_lcd_config(struct omap_overlay_manager *mgr,
>


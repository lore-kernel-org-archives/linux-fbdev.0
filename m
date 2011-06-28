From: Archit Taneja <a0393947@ti.com>
Date: Tue, 28 Jun 2011 16:19:09 +0000
Subject: Re: [PATCH] OMAP: DSS: dispc: enable/disable clocks in error handler
Message-Id: <4E09FEFD.9020005@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1309195865-23808-1-git-send-email-dima@android.com>
In-Reply-To: <1309195865-23808-1-git-send-email-dima@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dima Zavin <dima@android.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Monday 27 June 2011 10:31 AM, Dima Zavin wrote:
> There's no guarantee that the error handler worker thread
> will run while the dispc clocks are on. Explicitly enable/disable
> them.

I agree with this.

Tomi,

We could get prevent scheduling of the error worker by registering 
omap_dispc_irq_handler() as an interrupt thread.

Archit

>
> Signed-off-by: Dima Zavin<dima@android.com>
> ---
>   drivers/video/omap2/dss/dispc.c |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index 62aa77c..2458248 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -3292,6 +3292,8 @@ static void dispc_error_worker(struct work_struct *work)
>   	dispc.error_irqs = 0;
>   	spin_unlock_irqrestore(&dispc.irq_lock, flags);
>
> +	dispc_runtime_get();
> +
>   	if (errors&  DISPC_IRQ_GFX_FIFO_UNDERFLOW) {
>   		DSSERR("GFX_FIFO_UNDERFLOW, disabling GFX\n");
>   		for (i = 0; i<  omap_dss_get_num_overlays(); ++i) {
> @@ -3478,6 +3480,8 @@ static void dispc_error_worker(struct work_struct *work)
>   	dispc.irq_error_mask |= errors;
>   	_omap_dispc_set_irqs();
>   	spin_unlock_irqrestore(&dispc.irq_lock, flags);
> +
> +	dispc_runtime_put();
>   }
>
>   int omap_dispc_wait_for_irq_timeout(u32 irqmask, unsigned long timeout)


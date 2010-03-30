From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 30 Mar 2010 20:36:21 +0000
Subject: Re: [PATCH v2] DA8XX/OMAP-L1XX: FB: Implement double buffering
Message-Id: <20100330133621.e897cdb5.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <A24693684029E5489D1D202277BE89445316FAB1@dlee02.ent.ti.com>
In-Reply-To: <A24693684029E5489D1D202277BE89445316FAB1@dlee02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, 29 Mar 2010 08:16:51 -0500
"Ambrose, Martin" <martin@ti.com> wrote:

> +/*
> + * Function to wait for vertical sync which for this LCD peripheral
> + * translates into waiting for the current raster frame to complete.
> + */
> +static int fb_wait_for_vsync(struct fb_info *info)
> +{
> +       struct da8xx_fb_par *par = info->par;
> +       wait_queue_t wq;
> +       int ret;
> +
> +       init_waitqueue_entry(&wq, current);

DECLARE_WAITQUEUE() would be more conventional.

> +       /*
> +        * Set flag to 0 and wait for isr to set to 1. It would seem there is a
> +        * race condition here where the ISR could have occured just before or
> +        * just after this set. But since we are just coarsely waiting for
> +        * a frame to complete then that's OK. i.e. if the frame completed
> +        * just before this code executed then we have to wait another full
> +        * frame time but there is no way to avoid such a situation. On the
> +        * other hand if the frame completed just after then we don't need
> +        * to wait long at all. Either way we are guaranteed to return to the
> +        * user immediately after a frame completion which is all that is
> +        * required.
> +        */
> +       par->vsync_flag = 0;
> +       ret = wait_event_interruptible_timeout(par->vsync_wait,
> +                                              par->vsync_flag != 0,
> +                                              par->vsync_timeout);

If the calling process has signal_pending() (say, someone hit ^C) then
wait_event_interruptible_timeout() will fall straight through with
-ERESTARTSYS.  Will this cause the driver to malfunction at all?


> +       if (ret < 0)
> +               return ret;
> +       if (ret = 0)
> +               return -ETIMEDOUT;
> +
> +       return 0;
> +}

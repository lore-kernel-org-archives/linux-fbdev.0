From: "Ambrose, Martin" <martin@ti.com>
Date: Thu, 01 Apr 2010 01:43:29 +0000
Subject: RE: [PATCH v2] DA8XX/OMAP-L1XX: FB: Implement double buffering
Message-Id: <A24693684029E5489D1D202277BE8944546D96C1@dlee02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <A24693684029E5489D1D202277BE89445316FAB1@dlee02.ent.ti.com>
In-Reply-To: <A24693684029E5489D1D202277BE89445316FAB1@dlee02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Andrew,

Thanks for the feedback.

> > +/*
> > + * Function to wait for vertical sync which for this LCD peripheral
> > + * translates into waiting for the current raster frame to complete.
> > + */
> > +static int fb_wait_for_vsync(struct fb_info *info)
> > +{
> > +       struct da8xx_fb_par *par = info->par;
> > +       wait_queue_t wq;
> > +       int ret;
> > +
> > +       init_waitqueue_entry(&wq, current);
> 
> DECLARE_WAITQUEUE() would be more conventional.

I'll update -- cloned this from some older code I think.
 
> > +       /*
> > +        * Set flag to 0 and wait for isr to set to 1. It would seem there is a
> > +        * race condition here where the ISR could have occured just before or
> > +        * just after this set. But since we are just coarsely waiting for
> > +        * a frame to complete then that's OK. i.e. if the frame completed
> > +        * just before this code executed then we have to wait another full
> > +        * frame time but there is no way to avoid such a situation. On the
> > +        * other hand if the frame completed just after then we don't need
> > +        * to wait long at all. Either way we are guaranteed to return to the
> > +        * user immediately after a frame completion which is all that is
> > +        * required.
> > +        */
> > +       par->vsync_flag = 0;
> > +       ret = wait_event_interruptible_timeout(par->vsync_wait,
> > +                                              par->vsync_flag != 0,
> > +                                              par->vsync_timeout);
> 
> If the calling process has signal_pending() (say, someone hit ^C) then
> wait_event_interruptible_timeout() will fall straight through with
> -ERESTARTSYS.  Will this cause the driver to malfunction at all?

I don't think so since the driver doesn't make use of this
information in any way. This is just status to the caller that the
current frame has finished DMA'ing out of the framebuffer. 

Could you maybe propose a scenario/use case where you think it is
problematic? I could then either reason why it should be OK or 
I'll create a test harness and see how the driver can/should be modified.

Regards,
Martin



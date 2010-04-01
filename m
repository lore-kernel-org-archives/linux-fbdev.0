From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 01 Apr 2010 00:32:56 +0000
Subject: Re: [PATCH v2] DA8XX/OMAP-L1XX: FB: Implement double buffering
Message-Id: <20100331203256.852450d3.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <A24693684029E5489D1D202277BE89445316FAB1@dlee02.ent.ti.com>
In-Reply-To: <A24693684029E5489D1D202277BE89445316FAB1@dlee02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, 31 Mar 2010 20:43:29 -0500 "Ambrose, Martin" <martin@ti.com> wrote:

> > > +       /*
> > > +        * Set flag to 0 and wait for isr to set to 1. It would seem there is a
> > > +        * race condition here where the ISR could have occured just before or
> > > +        * just after this set. But since we are just coarsely waiting for
> > > +        * a frame to complete then that's OK. i.e. if the frame completed
> > > +        * just before this code executed then we have to wait another full
> > > +        * frame time but there is no way to avoid such a situation. On the
> > > +        * other hand if the frame completed just after then we don't need
> > > +        * to wait long at all. Either way we are guaranteed to return to the
> > > +        * user immediately after a frame completion which is all that is
> > > +        * required.
> > > +        */
> > > +       par->vsync_flag = 0;
> > > +       ret = wait_event_interruptible_timeout(par->vsync_wait,
> > > +                                              par->vsync_flag != 0,
> > > +                                              par->vsync_timeout);
> > 
> > If the calling process has signal_pending() (say, someone hit ^C) then
> > wait_event_interruptible_timeout() will fall straight through with
> > -ERESTARTSYS.  Will this cause the driver to malfunction at all?
> 
> I don't think so since the driver doesn't make use of this
> information in any way. This is just status to the caller that the
> current frame has finished DMA'ing out of the framebuffer. 
> 
> Could you maybe propose a scenario/use case where you think it is
> problematic? I could then either reason why it should be OK or 
> I'll create a test harness and see how the driver can/should be modified.
> 

Gee, I dunno - I don't understand the driver to that level.  If you're
OK with this wait being interrupted by a signal and the driver handles
it OK then fine, that's a feature.

To test it I suppose you should give your test app a signal handler and
blast kills at it from another process.


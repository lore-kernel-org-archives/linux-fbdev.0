From: Scott Wood <scottwood@freescale.com>
Date: Tue, 24 Nov 2015 16:55:19 +0000
Subject: Re: [PATCH] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <1448384119.27264.339.camel@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 2015-11-24 at 11:54 -0500, Timur Tabi wrote:
> On Tue, Nov 24, 2015 at 11:15 AM, Scott Wood <scottwood@freescale.com>
> wrote:
> > On Tue, 2015-11-24 at 11:12 -0500, Timur Tabi wrote:
> > >  On Tue, Nov 24, 2015 at 1:27 AM, Dongsheng Wang
> > > <dongsheng.wang@freescale.com> wrote:
> > > > @@ -1697,6 +1700,9 @@ static int fsl_diu_probe(struct platform_device
> > > > *pdev)
> > > >         unsigned int i;
> > > >         int ret;
> > > > 
> > > > +       if (!diu_ops.set_pixel_clock)
> > > > +               return -ENODEV;
> > > > +
> > > >         data = dmam_alloc_coherent(&pdev->dev, sizeof(struct
> > > > fsl_diu_data),
> > > >                                    &dma_addr, GFP_DMA | __GFP_ZERO);
> > > >         if (!data)
> > > 
> > > This doesn't make any sense.  If set_pixel_clock() is not defined,
> > > then the whole driver aborts the probe.
> > 
> > That's what this patch is trying to accomplish.  Currently it crashes
> > instead.
> > 
> > >   When could that ever happen?
> > > If the platform code does not exist, then don't let the driver be
> > > probed.
> > 
> > How do you propose to accomplish that other than with such a check?
> 
> Well, if you're concern is that there's no platform code, then there
> should be a check that says, "see if there's any platform code", not
> "let's check this obscure function and abort without explanation if
> it's not initialized."

Do you have a *specific* better way to "see if there's any platform code"?

> 
> Alternatively, why can't you just do this, in update_lcdc():
> 
> 
> 

Do nothing?

-Scott



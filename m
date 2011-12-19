From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 19 Dec 2011 00:27:54 +0000
Subject: Re: [PATCH 12/57] arm: mach-shmobile: Add LCDC tx_dev field to
Message-Id: <Pine.LNX.4.64.1112190124170.23431@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-13-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-13-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, 16 Dec 2011, Laurent Pinchart wrote:

> Hi Guennadi,
> 
> On Thursday 15 December 2011 15:01:27 Guennadi Liakhovetski wrote:
> > On Tue, 13 Dec 2011, Laurent Pinchart wrote:
> > > Make sure the transmitter devices get registered before the associated
> > > LCDC devices.
> > > 
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> [snip]
> 
> > > diff --git a/arch/arm/mach-shmobile/board-ap4evb.c
> > > b/arch/arm/mach-shmobile/board-ap4evb.c index dca4860..e0a6b3d 100644
> > > --- a/arch/arm/mach-shmobile/board-ap4evb.c
> > > +++ b/arch/arm/mach-shmobile/board-ap4evb.c
> 
> [snip]
> 
> > > @@ -627,6 +553,86 @@ static struct platform_device *qhd_devices[]
> > > __initdata = {
> > > 
> > >  };
> > >  #endif /* CONFIG_AP4EVB_QHD */
> > > 
> > > +/* LCDC0 */
> > > +static const struct fb_videomode ap4evb_lcdc_modes[] = {
> > 
> > Hm, I must be missing something. I thought you were moving all the structs
> > around to make them available for reference _without_ forward
> > declarations. But you _do_ end up using a forward declaration anyway. Here
> > and for HDMI below too. So, what's the point? Why not just forward declare
> > that one struct, that's needed and leave the rest where it currently is
> > in the file?
> 
> As we have circular dependencies forward declaration can't be avoided. I found 
> it cleaner to have devices data in registration order in the board file, but I 
> can remove this if you prefer.

As a _general_ guidline I find smaller patches more pleasant than 
bigger;-) but if you really see an important advantage in moving these 
structs around - I can live with that too:-)

> > > +	{
> > > +#ifdef CONFIG_AP4EVB_QHD
> > > +		.name		= "R63302(QHD)",
> > > +		.xres		= 544,
> > > +		.yres		= 961,
> > > +		.left_margin	= 72,
> > > +		.right_margin	= 600,
> > > +		.hsync_len	= 16,
> > > +		.upper_margin	= 8,
> > > +		.lower_margin	= 8,
> > > +		.vsync_len	= 2,
> > > +		.sync		= FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
> > > +#else
> > > +		.name		= "WVGA Panel",
> > > +		.xres		= 800,
> > > +		.yres		= 480,
> > > +		.left_margin	= 220,
> > > +		.right_margin	= 110,
> > > +		.hsync_len	= 70,
> > > +		.upper_margin	= 20,
> > > +		.lower_margin	= 5,
> > > +		.vsync_len	= 5,
> > > +		.sync		= 0,
> > > +#endif
> > > +	},
> > > +};
> 
> [snip]
> 
> > > diff --git a/arch/arm/mach-shmobile/board-mackerel.c
> > > b/arch/arm/mach-shmobile/board-mackerel.c index 4ed0138..ccdd9fc 100644
> > > --- a/arch/arm/mach-shmobile/board-mackerel.c
> > > +++ b/arch/arm/mach-shmobile/board-mackerel.c
> 
> [snip]
> 
> > > @@ -1313,8 +1317,8 @@ static struct platform_device *mackerel_devices[]
> > > __initdata = {
> > >  	&sh_mmcif_device,
> > >  	&ceu_device,
> > >  	&mackerel_camera,
> > > -	&hdmi_lcdc_device,
> > >  	&hdmi_device,
> > > +	&hdmi_lcdc_device,
> > >  	&meram_device,
> > >  };
> > 
> > Sorry, could you elaborate, why this is needed? If this is really
> > important, then I'd prefer to test this before committing. If OTOH this is
> > unimportant, and my assumption, that normally it's the platform driver
> > registration order, that's important, not device registration order, is
> > correct, then you don't have to swap the order?
> 
> If both the transmitter and LCDC drivers are built-in, the device probe order 
> is the device registration order. As we need the transmitter to be probed 
> first, it needs to be registered first.

Even there I'm not quite sure about - I do remember having to fiddle with 
the Makefiles to change the probe order, which followed the linkage order. 
Could be, that this has changed since I last checked, but I'd really 
double-check this.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

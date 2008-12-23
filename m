From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/4 v4] i.MX31: Image Processing Unit DMA and IRQ
	drivers
Date: Tue, 23 Dec 2008 13:50:15 +0100
Message-ID: <20081223125015.GG1614@pengutronix.de>
References: <Pine.LNX.4.64.0812181406000.5510@axis700.grange> <Pine.LNX.4.64.0812181414280.5510@axis700.grange> <20081218225834.GJ20756@pengutronix.de> <Pine.LNX.4.64.0812221240210.5241@axis700.grange> <20081222183753.GD1614@pengutronix.de> <Pine.LNX.4.64.0812221942480.7796@axis700.grange> <20081223105006.GE1614@pengutronix.de> <Pine.LNX.4.64.0812231157180.5188@axis700.grange>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751901AbYLWMu2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0812231157180.5188@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, Dan Williams <dan.j.williams@intel.com>

On Tue, Dec 23, 2008 at 12:21:54PM +0100, Guennadi Liakhovetski wrote:
> Hi Sascha
> 
> On Tue, 23 Dec 2008, Sascha Hauer wrote:
> 
> > On Mon, Dec 22, 2008 at 09:10:03PM +0100, Guennadi Liakhovetski wrote:
> > > 
> > > Ok, so, what would we like to have there? We agree that the proper way to 
> > > serve them is a irq-chip driver, right?
> > 
> > In case of the *_EOF interrupts when they can be used outside the idmac
> > driver then yes. If not then not for the reasons I explained.
> 
> Wait a minute, are you suggesting to handle interrupts that are exported 
> to client drivers and that are "internal" to ipu_idmac differently? Like 
> exported once - properly using the irq chip machinery, and internal once 
> just demux in the driver hiding them from the kernel?... Or have I 
> misunderstood you? If this is indeed what you mean, then that doesn't 
> sound like a good idea to me, sorry. Like you configure a chained handler, 
> then when it is called on an IRQ, you check if the reason is bits 0, 1, or 
> 2 you call generic_handle_irq(), for other bits you handle them 
> internally... grrrr... 

I'm not suggesting that. The *_EOF registers are all 32 bits on the *same*
register. And these 32 interrupts are inherently occupied by ipu_idmac.c
as you cannot request a idmac channel without requesting this interrupt.
So at the moment you are passing 32 bits of the same register through a
chained interrupt handler and *all* these interrupts go to the very same
interrupt handler.
For the corresponding 32 error interrupts it's probably also the idmac
engine that has to react to these interrupts, not the drivers using it.
Not sure about the remaining assorted interrupts.

> And, in fact, I don't see many internal interrupts 
> there - maybe only those from IPU_INT_STAT_3 related to CM? You see, we 
> could split interrupts further: support for EOF irqs - unconditional, 
> error, NF, and IPU_INT_STAT_3 IRQs - under 3 config variables, maybe even 
> split IPU_INT_STAT_3 further in submodules... But this would clutter the 
> Kconfig. Ok, I could add an own Kconfig under drivers/dma/ipu. But I 
> really do not think we should export some interrupts to the irq_desc array 
> and handle others internally. So, what granularity would you like to see 
> there?
> 
> > > > Another thing is the overlay framebuffer. I think it's mainly useful to
> > > > display video streams. Maybe it's better to implement this as a v4l
> > > > device as unlike the framebuffer API the v4l API is designed to handle
> > > > different image buffers.
> > > > These things just popped up in my mind, I don't know if they are
> > > > practical, I still have a quite limited understanding of the whole
> > > > imaging stuff on the MX31.
> > > 
> > > You mean an output v4l device? I think overlays are handled by framebuffer 
> > > drivers... But I'm also not quite sure about it, however, handling overlay 
> > > as another framebuffer seems logical to me.
> > 
> > Well the DMA engine seems to suggest that frames should be passed around
> > whereas the framebuffer API only has a single frame. That would fit
> > better into the v4l API. Also the IPU can do things like colourspace
> > conversion and hw scaling which would fit into the V4L API.
> > OTOH there are not many examples of drivers doing this (ivtv, zoran in
> > kernel and an Omap driver found on lists). And I haven't found any
> > application supporting a V4L output device.
> > BTW is the overlay framebuffer useful in it's current implementation?
> > There seems to be no way to adjust the x/y offset or the blending modes.
> 
> No - that's what the comment in the commit says:
> 
> This is a framebuffer driver for i.MX31 SoCs. It only supports synchronous
> displays, overlay support is included but has never been tested.

No, it's not working. The overlay framebuffer maybe there, but it's
configured to be invisible.

> 
> [Oops, just noticed - in v5 framebuffer I again have the "panning not 
> tested" clause, which is not true, and the comment has been fixed in v4:-( 
> So, if we decide to take v5, we'd have to take the comment from v4]
> 
> So, I could just throw overlay completely out. OTOH, if anyone ever wants 
> to use it, they'll have something to start with.

And in the meantime we maintain known to be broken code?

> 
> > > If there are no other problems with v5, could we maybe take it as a basis 
> > > and then I would submit a patch to reduce the number of IRQs?
> > 
> > Please understand my concerns with this driver. It's a quite complex
> > beast and experience shows that once a driver is in the kernel it is far
> > more complicated to change it than to do it right the first way. You
> > know that I'm also interested in having a MX31 framebuffer (and camera)
> > driver in kernel but I want to make sure that it works properly and leaves
> > room for feature enhancements without having to refactor the whole
> > driver.
> 
> Well, not quite so. At least with my workflow it takes more work to 
> regenerate a complete patch-series, than to create incremental patches. 
> For me it would be definitely easier to have a version of the driver 
> upstream to then only create incremental patches for it. Also, it would be 
> easier for others to test it. And consider the constantly moving target 
> effect - you know it as well as I do, rebasing your off-tree patches to 
> new kernel versions is a considerable amount of work too.
> 
> > It would be good if someone else could throw his 2 cents into this
> > discussion.
> 
> Yes, eventually, the drivers will have to go over dma and framebuffer 
> trees...


> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

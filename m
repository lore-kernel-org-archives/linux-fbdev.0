From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 01 Mar 2011 11:31:55 +0000
Subject: Re: [PATCH 3/8] Add a mfd IPUv3 driver
Message-Id: <20110301113155.GO29521@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298887229-7987-1-git-send-email-s.hauer@pengutronix.de>
	<1298887229-7987-4-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.00.1102281858240.2701@localhost6.localdomain6>
	<20110301093956.GL29521@pengutronix.de>
	<alpine.LFD.2.00.1103011054440.2701@localhost6.localdomain6>
In-Reply-To: <alpine.LFD.2.00.1103011054440.2701@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Mar 01, 2011 at 11:00:09AM +0100, Thomas Gleixner wrote:
> On Tue, 1 Mar 2011, Sascha Hauer wrote:
> > On Mon, Feb 28, 2011 at 07:33:05PM +0100, Thomas Gleixner wrote:
> > > > +void ipu_idmac_put(struct ipu_channel *channel)
> > > > +{
> > > > +	dev_dbg(ipu_dev, "%s %d\n", __func__, channel->num);
> > > 
> > > Do we really need this debug stuff in all these functions ?
> > 
> > Reading this comment I expected tons of dev_dbg in the driver. The one
> > you mentioned above (plus the corresponding one in ipu_idmac_get) are
> > indeed not particularly useful, but do you think there is still too much
> > debug code left?
> 
> Well, I don't see a point in having useless debug stuff around.
> > > > +	DECLARE_IPU_IRQ_BITMAP(irqs);
> > > 
> > > Why the hell do we need this? It's a bog standard bitmap, right ?
> > 
> > It's defined as:
> > 
> > #define DECLARE_IPU_IRQ_BITMAP(name)     DECLARE_BITMAP(name, IPU_IRQ_COUNT)
> > 
> > So yes, it's a standard bitmask. It can be used in client drivers
> > aswell. Where's the problem of adding a define for this so that client
> > drivers do not have to care about the size of the bitmap?
> 
> That's nonsense. You have to know about the size of the bitmap for any
> operation on it. Or are you going to provide wrappers around
> bitmap_zero() and all other possible bitmap_* functions as well?

Ok, you're right.

> 
> > > 
> > > > +	bitmap_zero(irqs, IPU_IRQ_COUNT);
> > > > +	ret = ipu_submodules_init(pdev, ipu_base, ipu_clk);
> > > > +	if (ret)
> > > > +		goto failed_submodules_init;
> > > > +
> > > > +	/* Set sync refresh channels as high priority */
> > > > +	ipu_idmac_write(0x18800000, IDMAC_CHA_PRI(0));
> > > 
> > > Hmm, this random prio setting here is odd.
> > 
> > This is 1:1 from the Freescale Kernel and I never thought about it. We
> > can remove it and see what happens. Maybe then some day we'll learn
> > *why* this is done.
> 
> Well, the point is to move that to the init function which deals with
> IDMAC and not have it at some random place in the code.

Ok, will move it there.

>  
> > > > +	/* Wait for DC triple buffer to empty */
> > > > +	if (dc_channels[dc_chan].di = 0)
> > > > +		while ((__raw_readl(DC_STAT) & 0x00000002)
> > > > +			!= 0x00000002) {
> > > > +			msleep(2);
> > > > +			timeout -= 2;
> > > > +			if (timeout <= 0)
> > > > +				break;
> > > 
> > > So we poll stuff which is updated from some other function ?
> > 
> > We poll the DC_STAT register here which is updated from the hardware.
> 
> And there is no interrupt for this ?

Given the sheer amount of interrupt bits it's a bit surprising, but no,
I haven't found an interrupt for this (This of course doesn't mean it
doesn't exist...)

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

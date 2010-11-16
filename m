From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 Nov 2010 16:12:31 +0000
Subject: Re: [PATCH 01/10] MCDE: Add hardware abstraction layer
Message-Id: <201011161712.31703.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289390653-6111-1-git-send-email-jimmy.rubin@stericsson.com>
	<201011121643.52923.arnd@arndb.de>
	<F45880696056844FA6A73F415B568C6953604E7D94@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <F45880696056844FA6A73F415B568C6953604E7D94@EXDCVYMBSTM006.EQ1STM.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 16 November 2010, Jimmy RUBIN wrote:
> 
> > Even static variables like these can cause problems. Ideally all of
> > these
> > are referenced through a driver private data structure that is passed
> > around
> > with the device. This way you can trivially support multiple devices if
> > that ever becomes necessary.
> 
> What is the general opinion about singleton drivers?
> Both global and static variables could be fixed if the driver is redesigned to support multiple devices.

I don't know if there is a general rule. The reason why I don't like to have
device specific data spread across global variables is that it messes up
my mental model of the code.

Every device in Linux "normally" is set up by a bus probe (or as a hack,
a platform device instance) and given to a device driver, which then
allocates a private data structure that describes what the driver but
not the bus knows about this device. That data structure typically also
contains the locks for all in-memory and physical state of the device.
If you deviate from this model, you make it harder for reviewers and
other developers to understand what is going on.

> > > +static inline u32 dsi_rreg(int i, u32 reg)
> > > +{
> > > +	return readl(dsiio[i] + reg);
> > > +}
> > > +static inline void dsi_wreg(int i, u32 reg, u32 val)
> > > +{
> > > +	writel(val, dsiio[i] + reg);
> > > +}
> > 
> > dsiio is not marked __iomem, so there is something wrong here.
> > Moreover, why do you need two indexes? If you have multiple identical
> > "dsiio" structures, maybe each of them should just be a device by
> > itself?
> We will add __iomem.
> Each dsi link (dsiio[x]) is tightly coupled with mcde and it feels that they should not be a device of their own.
> We feel that it would be to many devices doing little.

Ok.

> > This looks a bit like you actually have multiple interrupt lines
> > multiplexed
> > through a private interrupt controller. Have you considered making this
> > controller
> > a separate device to multiplex the interrupt numbers?
> 
> MCDE contains several pipelines, each of them can generate interrupts.
> Since each interrupt comes from the same device there is no need for
> separate devices for interrupt controller.

Right, so this one and the one above is really a question of how to describe
a pipeline

	Arnd

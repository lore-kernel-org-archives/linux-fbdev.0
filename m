From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 01 Mar 2011 11:12:20 +0000
Subject: Re: [PATCH 3/8] Add a mfd IPUv3 driver
Message-Id: <20110301111220.GN29521@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298887229-7987-1-git-send-email-s.hauer@pengutronix.de>
	<201102281811.45277.arnd@arndb.de>
	<20110301091544.GK29521@pengutronix.de>
	<201103011127.51605.arnd@arndb.de>
In-Reply-To: <201103011127.51605.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Mar 01, 2011 at 11:27:49AM +0100, Arnd Bergmann wrote:
> On Tuesday 01 March 2011, Sascha Hauer wrote:
> 
> > When turning this into a kms driver moving the source code will be the
> > smallest problem I guess.
> > I have no preference where to put this code. First it was in
> > drivers/mfd/ and it felt wrong because there seems to be too much code
> > in it a mfd maintainer shouldn't be bothered with. drivers/video/ seems
> > to be wrong because this code will probably support cameras which belong
> > to drivers/media/video/. So if there's consensus on drivers/gpu/ I will
> > happily put it there.
> > What directory do you suggest? drivers/gpu/ or some subdirectory
> > (drm/vga)?
> 
> I'd suggest a subdirectory of drivers/gpu/, e.g.
> drivers/gpu/embedded/imx-ipu/. Alan is currently adding a driver
> for the Intel GMA500, and there are others (TI, ST-Ericsson, ...)
> that fit in a similar category of complex graphics subsystems
> without an actual GPU core. I think they should all go to the same
> place.
> 
> > > The interrupt logic needs some comments. What are you trying to achieve here?
> > 
> > The IPU has 463 status bits which can trigger an interrupt. Most
> > of them are associated to channels, some are general interrupts. My
> > problem is that I don't know how the interrupts will be used by drivers
> > later. Most drivers will probably use only one interrupt but others
> > will be interested in a larger group of interrupts. So I decided to
> > use a bitmap allowing each driver to register for groups of event
> > it is interested in.
> 
> Ok, I see. So you essentially have a huge nested interrupt controller
> and try to be clever about the possible use cases, which may be the
> right choice, but apparently you don't know that yet because not
> all the drivers have been written at this point.
> 
> Taking one step back from this, have you considered making this
> a regular interrupt controller? That would make the client drivers
> more standard -- you could define the interrupt numbers as resources
> of a platform device or in the device tree, for instance.
> The cost might be more complex code, e.g. when a device requires
> many interrupts, but I think it will be at least as efficient
> at run-time, and less surprising for readers and authors of
> client drivers.

I thought about this, but hesitated to increase NR_IRQS by 463. Do you
think we should do this instead?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

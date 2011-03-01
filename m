From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 01 Mar 2011 11:43:33 +0000
Subject: Re: [PATCH 3/8] Add a mfd IPUv3 driver
Message-Id: <201103011243.33765.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298887229-7987-1-git-send-email-s.hauer@pengutronix.de>
	<201103011127.51605.arnd@arndb.de>
	<20110301111220.GN29521@pengutronix.de>
In-Reply-To: <20110301111220.GN29521@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 01 March 2011, Sascha Hauer wrote:
> > Taking one step back from this, have you considered making this
> > a regular interrupt controller? That would make the client drivers
> > more standard -- you could define the interrupt numbers as resources
> > of a platform device or in the device tree, for instance.
> > The cost might be more complex code, e.g. when a device requires
> > many interrupts, but I think it will be at least as efficient
> > at run-time, and less surprising for readers and authors of
> > client drivers.
> 
> I thought about this, but hesitated to increase NR_IRQS by 463. Do you
> think we should do this instead?

I think there is a plan to virtualize the interrupt numbers on ARM,
and in that case NR_IRQS becomes rather meaningless. I don't know
exactly how far that effort has come.

	Arnd

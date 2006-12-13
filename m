From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: SM501: core (mfd) driver
Date: Wed, 13 Dec 2006 18:21:31 +0100
Message-ID: <1166030491.27217.844.camel@laptopd505.fenrus.org>
References: <20061213155134.GA10097@home.fluff.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932351AbWLMRVe@vger.kernel.org>
In-Reply-To: <20061213155134.GA10097@home.fluff.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Ben Dooks <ben-fbdev@fluff.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Hi,

some review comments below
> +
> +struct sm501_devdata {
> +	spinlock_t			 reg_lock;
> +	struct semaphore		 clock_lock;

can't this be a mutex instead ?
> +#ifdef CONFIG_DEBUG
> +static unsigned int misc_div[] = {
> +	[0]		= 1,
> +	[1]		= 2,

can this be const ?

> +
> +int sm501_unit_power(struct device *dev, unsigned int unit, unsigned int to)
> +{
> +	struct sm501_devdata *sm = dev_get_drvdata(dev);
> +	unsigned long mode = readl(sm->regs + SM501_POWER_MODE_CONTROL);
> +	unsigned long gate = readl(sm->regs + SM501_CURRENT_GATE);
> +	unsigned long clock = readl(sm->regs + SM501_CURRENT_CLOCK);
> +
> +	mode &= 3;		/* get current power mode */
> +
> +	down(&sm->clock_lock);

eh shouldn't you do the readl()'s inside the semaphore (or mutex) area?

> +
> +	writel(mode, sm->regs + SM501_POWER_MODE_CONTROL);
> +
> +	dev_dbg(sm->dev, "gate %08lx, clock %08lx, mode %08lx\n",
> +		gate, clock, mode);
> +
> +	msleep(16);

you're missing a PCI posting flush here
(if you don't know what this is please ask)

> +	sm->dev = &dev->dev;
> +	sm->irq = dev->irq;

you shouldn't look at dev->irq ...

> +
> +	/* set a hopefully unique id for our child platform devices */
> +	sm->pdev_id = 32 + dev->devfn;
> +
> +	pci_set_drvdata(dev, sm);
> +
> +	err = pci_enable_device(dev);

.. before calling pci_enable_device() since pci_enable_device() may be
the one that sets the dev->irq value to it's final value in the first
place



> +	sm->io_res = &dev->resource[1];
> +	sm->mem_res = &dev->resource[0];
> +
> +	sm->regs = ioremap(pci_resource_start(dev, 1),
> +			   pci_resource_len(dev, 1));

you know how to use pci_resource_start() and co.. why not use them 3
lines higher ? ;)


the driver looks quite clean otherwise btw, great work!


- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

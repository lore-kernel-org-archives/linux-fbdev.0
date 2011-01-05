From: Alex Buell <alex.buell@munted.org.uk>
Date: Wed, 05 Jan 2011 21:13:42 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <1294262022.24378.2.camel@lithium>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294086801.17576.14.camel@lithium>
	 <20110103.123939.02282416.davem@davemloft.net>
	 <1294090573.17576.16.camel@lithium>
	 <20110105.110705.104043006.davem@davemloft.net>
In-Reply-To: <20110105.110705.104043006.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2011-01-05 at 11:07 -0800, David Miller wrote:
> > Those are 32 bit addresses, so I suppose I should be getting the
> base
> > address for the registers accesses from region 1, right? 
> 
> Actually, I take back what I said earlier.  Region 1 is a Memory
> region not an I/O region.
> 
> It looks like you'll have to find a way to get at the implicit
> I/O space for the PCI domain this framebuffer is behind and
> construct the implicit VGA addresses by hand.
> 
> There is a way to do this, via pcibios_bus_to_resource().  You could
> do something like:
> 
> struct s3fb_info {
>  ...
>         void __iomem *vga_iobase;
>  ...
> static int __devinit s3_pci_probe(struct pci_dev *dev, const struct
> pci_device_id *id)
> {
>         struct pci_bus_region bus_reg;
>         struct resource vga_res;
>  ...
>         bus_reg.start = 0;
>         bus_reg.end = 64 * 1024;
> 
>         vga_res.flags = IORESOURCE_IO;
> 
>         pcibios_bus_to_resource(dev, &bus_reg, &vga_res);
> 
>         par->vga_iobase = (void __iomem *) vga_res.start;
> 
> Then replace all NULL vga_*() initial arguments in the driver
> with par->vga_iobase. 

No wonder it was crashing, there was nothing to access with region 1! I
will do as you suggest, and see if it works. Thank you!
-- 
Tactical Nuclear Kittens

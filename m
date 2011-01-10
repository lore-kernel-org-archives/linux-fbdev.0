From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Mon, 10 Jan 2011 18:17:16 +0000
Subject: Re: A query on frame buffers
Message-Id: <20110110181716.GA9627@dumpdata.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimBpZHwS81BeFxC0dG7mvMg6UaAnFMv6oj04j+Z@mail.gmail.com>
	<20101227153011.GD3728@dumpdata.com>
	<AANLkTim38gpvun=QwWcnwz719a2NYBcpiSvPYtgR6jMj@mail.gmail.com>
	<1294390835.6019.218.camel@thor.local>
	<20110107165813.GA24320@dumpdata.com>
	<AANLkTik_YENOcUioFFEN73i9ASZ7oZ80FZ_NXt-Ti5RV@mail.gmail.com>
	<20110107192437.GD27871@dumpdata.com>
	<AANLkTim4Cm-3gWwpqa8YmPekoyariRXVrzB6Ayv-zHAi@mail.gmail.com>
In-Reply-To: <AANLkTim4Cm-3gWwpqa8YmPekoyariRXVrzB6Ayv-zHAi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prasad Joshi <prasadjoshi124@gmail.com>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

> Tried your patches on Guest machine, it did not help. I am attaching
> the messages from guest machine.

Ok, then the issue is not with the guest but the IOMMU.
> 
> > well, what is the DMA code that gets turned on when you run your guest?
> 
> Looking into the qemu-kvm code to find more information about DMA.
> 
> > What do you see for 'PCI-DMA' ?
> 
> > Is it bounce buffer or swiotlb?
> 
> It is the default configuration. I did not pass swiotlb parameter on
> kernel boot line.

That is the nop one. So using virt_to_phys to get DMA address.

> 
> The host kernel is booted with iommu=1.

Is this a AMD or Intel chipset?
> 
> > How much memory do you pass to the guest? less than 4GB?
> 
> root@prasad-kvm:~/VMDisks# qemu-system-x86_64 -hda
> Ubuntu-10.10-amd64.img -m 1024M -device pci-assign,host:00.0
> 
> I am passing 1GB memory to the guest machine.

Since you mentioned that you were able to passthrough other PCI devices
that means the IOMMU is working. This narrows it down.

The big difference between other PCI devices and the graphics card
is that the graphic card has its own VMM and "radeon_gart_bind" ends
up programming the bus address (so virt_to_phys of the pages, and 
you could put in a printk there to see what it is) in the graphic
VMM. This means that when the graphic card is told to fetch the
writeback data it ends up using the address that was programmed
in there to look. Here the IOMMU should step in and see "oh, this
DMA address is for this guest, let me patch it up and actually
look where this would fall in the guest space. Oh OK, let me use
this value real value which correspond the guests real value."

But the IOMMU has a couple of knobs. One of those is the passthrough
code and the GFX mapping code. The first should be easy to spot (should
tell you on bootup whether you got that enabled or not), while the other
looks to be a bunch of workarounds when passing in GFX cards b/c they ..
well, not sure what, but they look to not work correctly with the IOMMU. 

If you see 'identity map for device' where the device is your GFX
then that looks to be the bug. It shouldn't set the identity mapping on it.

Look for 'DMAR GFX' on Google. Might shed some more light.

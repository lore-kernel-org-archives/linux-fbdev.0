From: David Miller <davem@davemloft.net>
Date: Wed, 05 Jan 2011 19:07:05 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <20110105.110705.104043006.davem@davemloft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294086801.17576.14.camel@lithium>
	<20110103.123939.02282416.davem@davemloft.net>
	<1294090573.17576.16.camel@lithium>
In-Reply-To: <1294090573.17576.16.camel@lithium>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alex.buell@munted.org.uk
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alex Buell <alex.buell@munted.org.uk>
Date: Mon, 03 Jan 2011 21:36:13 +0000

> On Mon, 2011-01-03 at 12:39 -0800, David Miller wrote:
> 
>> > I've just started digging into the innards of the s3fb driver, my first
>> > attempt provoked this, simply by commenting out the check to see if it's
>> > not the primary device and exits with -ENODEV: 
>> > 
>> > Jan  3 20:16:29 sodium kernel: ERROR(1): Cheetah error trap taken
>> > afsr[0030100000000000] afar[00000000000003d0] TL1(0)
>> > Jan  3 20:16:29 sodium kernel: ERROR(1): TPC[105918d8] TNPC[105918dc]
>> > O7[10591884] TSTATE[4411001606]
>> > Jan  3 20:16:29 sodium kernel: ERROR(1): TPC<s3_pci_probe+0x194/0x63c
>> > [s3fb]>
>> > Jan  3 20:16:29 sodium kernel: ERROR(1): M_SYND(0),  E_SYND(0), Multiple
>> > Errors, Privileged
>> 
>> I know, this is what happens if you call vga_*() with a NULL first parameter
>> on sparc64.  It's accessing garbage addresses.
> 
> OK. 
> 
>  # lspci -vvxx -s 0:0:03
> 0000:00:03.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)
> (prog-if 00 [VGA controller])
>         Subsystem: S3 Inc. ViRGE/DX
>         Physical Slot: PCI 3
>         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 23
>         Region 0: Memory at 14000000 (32-bit, non-prefetchable)
> [sizedM]
>         Region 1: [virtual] Memory at fffff80200000000 (32-bit,
> non-prefetchable) [size=1]
>         Region 2: [virtual] Memory at fffff80200000000 (32-bit,
> non-prefetchable) [size=1]
>         Region 3: [virtual] Memory at fffff80200000000 (32-bit,
> non-prefetchable) [size=1]
>         Region 4: [virtual] Memory at fffff80200000000 (32-bit,
> non-prefetchable) [size=1]
>         Region 5: [virtual] Memory at fffff80200000000 (32-bit,
> non-prefetchable) [size=1]
>         Expansion ROM at 00130000 [disabled] [sizedK]
>         Kernel driver in use: s3fb
>         Kernel modules: s3fb
> 00: 33 53 01 8a 02 00 00 02 01 00 00 03 00 40 00 00
> 10: 00 00 00 14 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 33 53 01 8a
> 30: 00 00 13 00 00 00 00 00 00 00 00 00 00 01 04 ff
> 
> Those are 32 bit addresses, so I suppose I should be getting the base
> address for the registers accesses from region 1, right? 

Actually, I take back what I said earlier.  Region 1 is a Memory
region not an I/O region.

It looks like you'll have to find a way to get at the implicit
I/O space for the PCI domain this framebuffer is behind and
construct the implicit VGA addresses by hand.

There is a way to do this, via pcibios_bus_to_resource().  You could
do something like:

struct s3fb_info {
 ...
	void __iomem *vga_iobase;
 ...
static int __devinit s3_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
{
	struct pci_bus_region bus_reg;
	struct resource vga_res;
 ...
	bus_reg.start = 0;
	bus_reg.end = 64 * 1024;

	vga_res.flags = IORESOURCE_IO;

	pcibios_bus_to_resource(dev, &bus_reg, &vga_res);

	par->vga_iobase = (void __iomem *) vga_res.start;

Then replace all NULL vga_*() initial arguments in the driver
with par->vga_iobase.

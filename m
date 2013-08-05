From: David Miller <davem@davemloft.net>
Date: Mon, 05 Aug 2013 22:29:24 +0000
Subject: Re: [PATCH] fbdev: suppress warning when assigning vga-save/restore base
Message-Id: <20130805.152924.1091133627005881284.davem@davemloft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51FE907A.2090201@zytor.com>
	<20130804.185146.1621476659301936865.davem@davemloft.net>
	<20130805202955.GH22789@localhost>
In-Reply-To: <20130805202955.GH22789@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: santiago@crfreenet.org
Cc: hpa@zytor.com, dh.herrmann@gmail.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux@rainbow-software.org

From: Ondrej Zajicek <santiago@crfreenet.org>
Date: Mon, 5 Aug 2013 22:29:55 +0200

> On Sun, Aug 04, 2013 at 06:51:46PM -0700, David Miller wrote:
>> From: "H. Peter Anvin" <hpa@zytor.com>
>> Date: Sun, 04 Aug 2013 10:33:46 -0700
>> 
>> > Anyone who can dig backwards and summarize?  In other words:
>> > 
>> > Where in the current code do we stuff a physical address in a pointer,
>> > or a virtual address into a non-pointer?
>> 
>> The VGA register accessors try to accomodate iomem and ioport
>> accesses.
>> 
>> If they are given a non-NULL iomem pointer 'regbase' they use
>> iomem accesses, otherwise they do direct ISA port poking.
>> 
>> And yes the drivers in question are making some brash assumptions.
>> I suspect they should be using ioremap() or similar.
> 
> Well, these drivers were written without MMIO (port IO only with NULL
> instead of 'vgabase' for VGA register accessors). They were converted in
> patches 94c322c30bd14ae6cdd369cb4a1f94c5c3809ac9,
> f8645933513c65ac55f23c63b2649097289795c6 and a few others (from David
> Miller) to potentially use MMIO by using 'vgabase' instead of NULL:
> 
>  pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
>  par->state.vgabase = (void __iomem *) vga_res.start;
> 
> How this could even work? AFAIK these cards have to be explicitly programmed
> to enable MMIO (which was not done in the patches). These patches claim that
> it is for multi-domain PCI. I would guess that vgabase is NULL in common
> configurations but if it is non-NULL, it probably wouldn't work, unless
> there is some hardware magic that transparently converts MMIO (from CPU PoV)
> to port IO (from card/PCI PoV).
> 
> Note that there are some later patches (86c0f043a737dadf034a4e6f29aefb074f4a1146)
> from Ondrej Zary that independently enable MMIO, but they use par->mmio
> field instead of par->state.vgabase .

Ok, so the correct fix would be to make them pass NULL again and to simply
ignore the resources.

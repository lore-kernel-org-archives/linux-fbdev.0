From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RESEND] [PATCH] convert sticore.c to PCI ROM API
Date: Sat, 7 Jun 2008 11:08:36 +0200
Message-ID: <20080607110836.b2c9f48a.krzysztof.h1@poczta.fm>
References: <20080605231327.af9cc9e6.krzysztof.h1@poczta.fm>
	<1212704814.4241.37.camel@localhost.localdomain>
	<20080606223507.0daf2b80.krzysztof.h1@poczta.fm>
	<1212794861.16182.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1212794861.16182.39.camel@localhost.localdomain>
Sender: linux-parisc-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Jon Smirl <jonsmirl@yahoo.com>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org

On Fri, 06 Jun 2008 18:27:41 -0500
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> On Fri, 2008-06-06 at 22:35 +0200, Krzysztof Helt wrote:

> > What is you advise for this patch James?
> 
> The more I look at this the more I doubt that it's a good thing.  STI is
> really a platform driver; it has to function for both GSC and PCI
> busses.  pci_map_rom() seems to be a bit of a minefield designed for x86
> centric video cards, which STI definitely isn't.  The sticore driver is
> also designed to operate on unmapped ranges ... at least this is the way
> it's designed for the GSC, so the PCI part has to follow suit.
> 
> Our simple base get and enabling transparently the driver currently has
> says what we're doing; I don't really see why it needs to switch to
> pci_map_rom.  Additionally, I fear that switching to pci_map_rom will
> cause us to break later on down the road.
> 

I am forwarding it to the reporter of the bug 9425 as this bug should be 
closed without changing the code.

A very similar case is for the bug 9424. I analyzed code for the Matrox
framebuffers and it is not worth changing. The idea behind the  pci_map_rom()
is that it enables and maps the ROM area. The Matrox framebuffer has
these two separated as the ROM may appear in the already mapped area.
The ROM is always enabled but not always mapped.

The only unification I see is to export pci_rom_enable/pci_rom_disable()
and use them inside the Matrox and sticore drivers (so no ioremap() 
is done but the code is shorter).

Regards,
Krzysztof

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>>  http://link.interia.pl/f1e22 


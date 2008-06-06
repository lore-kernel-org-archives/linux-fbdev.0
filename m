From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [RESEND] [PATCH] convert sticore.c to PCI ROM API
Date: Fri, 06 Jun 2008 18:27:41 -0500
Message-ID: <1212794861.16182.39.camel@localhost.localdomain>
References: <20080605231327.af9cc9e6.krzysztof.h1@poczta.fm>
	 <1212704814.4241.37.camel@localhost.localdomain>
	 <20080606223507.0daf2b80.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20080606223507.0daf2b80.krzysztof.h1@poczta.fm>
Sender: linux-parisc-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org

On Fri, 2008-06-06 at 22:35 +0200, Krzysztof Helt wrote:
> On Thu, 05 Jun 2008 17:26:54 -0500
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > 
> > I'm really not sure this is such a good idea.  pci_map_rom() can do an
> > ioremap() on the region.  In that case, gsc_readl which punches through
> > our virtual memory into physical I/O space will fail.  What assurance do
> > we have that all STI roms are correctly set up so pci_map_rom() isn't
> > inclined to ioremap them?
> > 
> 
> I haven't thought about this. The ROM the Helge tested was obviously
> set up correctly, otherwise reading the ROM signature would be impossible.

I suspect Helge only tested GSC based cards, which will work just fine
because they use the old logic.

> What is you advise for this patch James?

The more I look at this the more I doubt that it's a good thing.  STI is
really a platform driver; it has to function for both GSC and PCI
busses.  pci_map_rom() seems to be a bit of a minefield designed for x86
centric video cards, which STI definitely isn't.  The sticore driver is
also designed to operate on unmapped ranges ... at least this is the way
it's designed for the GSC, so the PCI part has to follow suit.

Our simple base get and enabling transparently the driver currently has
says what we're doing; I don't really see why it needs to switch to
pci_map_rom.  Additionally, I fear that switching to pci_map_rom will
cause us to break later on down the road.

James



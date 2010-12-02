From: Tony Lindgren <tony@atomide.com>
Date: Thu, 02 Dec 2010 22:32:08 +0000
Subject: Re: Mainline OMAP3 breakage (and other OMAP?)
Message-Id: <20101202223208.GA17222@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101202211421.GG10461@n2100.arm.linux.org.uk>
	<20101202215837.GW17222@atomide.com>
	<20101202221612.GJ10461@n2100.arm.linux.org.uk>
In-Reply-To: <20101202221612.GJ10461@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [101202 14:06]:
> On Thu, Dec 02, 2010 at 01:58:38PM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [101202 13:04]:
> > > This has been around since October:
> > > 
> > > drivers/video/omap2/vram.c: In function ■omap_vram_reserve_sdram_memblock■:
> > > drivers/video/omap2/vram.c:573: error: ■MEMBLOCK_REAL_LIMIT■ undeclared (first use in this function)
> > > drivers/video/omap2/vram.c:573: error: (Each undeclared identifier is reported only once
> > > drivers/video/omap2/vram.c:573: error: for each function it appears in.)
> > > 
> > > This requires a trivial one-liner compile fix:
> > > 
> > > diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
> > > index fed2a72..a8973f0 100644
> > > --- a/drivers/video/omap2/vram.c
> > > +++ b/drivers/video/omap2/vram.c
> > > @@ -570,7 +570,7 @@ void __init omap_vram_reserve_sdram_memblock(void)
> > >  			return;
> > >  		}
> > >  	} else {
> > > -		paddr = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT);
> > > +		paddr = memblock_alloc(size, PAGE_SIZE);
> > >  	}
> > >  
> > >  	omap_vram_add_region(paddr, size);
> > > 
> > > which restores the old behaviour before the X86 memblock changes went
> > > in.  Yes, there may be other changes due to the ioremap stuff, but
> > > that's really no excuse for not fixing the compile error itself.
> > 
> > Great. Adding fbdev and Tomi to Cc.
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> http://marc.info/?l=linux-omap&w=2&r=1&s=MEMBLOCK_REAL_LIMIT%20vram&q=b
> 
> There have been patches posted throughout November to fix this, but
> the problem is they're not making it to mainline.  It needs chasing
> until someone does the right thing and sends one variant of the above
> patch, rather than just leaving it until the ioremap fixes hit
> mainline during the next merge window.

Yes this should go in during the -rc for sure.

I suggest you merge this but let's wait a bit and check if Tomi
already has a similar fix queued for the -rc series.

Regards,

Tony

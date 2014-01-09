From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Date: Thu, 09 Jan 2014 08:31:10 +0000
Subject: RE: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Message-Id: <79CD15C6BA57404B839C016229A409A83EDB147E@DBDE04.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
 <20140107235951.GH5074@atomide.com> <52CD5D13.9090806@ti.com>
 <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
 <52CE5C1A.3070603@ti.com>
In-Reply-To: <52CE5C1A.3070603@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Thursday, January 09, 2014 1:52 PM
> To: Hiremath, Vaibhav; Ivaylo Dimitrov
> Cc: Tony Lindgren; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
> 
> On 2014-01-09 07:06, Hiremath, Vaibhav wrote:
> 
> > I am seeing underflow issue on AM43x device if I use omapfb_vram argument.
> > Did you see this on OMAP?
> >
> > I am using "omapfb_vramM@0xA0000000", and I believe it is correct way
> of usage.
> 
> Hmm ok... The AM4x seems to have issues anyway, as we're seeing underflows
> easily in other situations also.
> 
> Well, there's a small difference in the allocation. The normal dma alloc uses
> dma_alloc_attrs() and passes DMA_ATTR_WRITE_COMBINE as a flag, whereas
> allocating from the absolute address just uses the piece of memory. I couldn't
> find how to set write-combine for the abs memory area.
> 
> Then again, that's for CPU caching, so I don't see why it would affect DSS as
> such (but that's still something we should measure, cpu read/write perf for
> normal and abs allocation).
> 
> The only thought I have is that somehow the reserved memory area is missing
> some configuration that is done for the rest of the memory. But that's purely a
> guess, this is totally out of my area of expertise...
> 
> Vaibhav, just to be sure, can you run both with normal dma_alloc and with the
> reserve, and verify that the dispc register dumps are the same?
> I don't see how they could be different, but just to be sure.
> 

Will check and update you shortly.

Thanks,
Vaibhav

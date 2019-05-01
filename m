From: Paul Burton <paul.burton@mips.com>
Date: Wed, 01 May 2019 17:40:34 +0000
Subject: Re: [PATCH 4/7] dma-direct: provide generic support for uncached kernel segments
Message-Id: <20190501174033.6rj5aiopdeo4uqpw@pburton-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190430110032.25301-1-hch@lst.de>
 <20190430110032.25301-5-hch@lst.de>
 <20190501171857.chfxqntvm6r4xrr4@pburton-laptop>
 <20190501172912.GA19375@lst.de>
In-Reply-To: <20190501172912.GA19375@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Christoph,

On Wed, May 01, 2019 at 07:29:12PM +0200, Christoph Hellwig wrote:
> On Wed, May 01, 2019 at 05:18:59PM +0000, Paul Burton wrote:
> > I'm not so sure about this part though.
> > 
> > On MIPS we currently don't clear the allocated memory with memset. Is
> > doing that really necessary?
> 
> We are clearling it on mips, it is inside dma_direct_alloc_pages.

Ah, of course, I clearly require more caffeine :)

> > If it is necessary then as-is this code will clear the allocated memory
> > using uncached writes which will be pretty slow. It would be much more
> > efficient to perform the memset before arch_dma_prep_coherent() & before
> > converting ret to an uncached address.
> 
> Yes, we could do that.

Great; using cached writes would match the existing MIPS behavior.

Thanks,
    Paul

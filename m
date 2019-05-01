From: Christoph Hellwig <hch@lst.de>
Date: Wed, 01 May 2019 17:49:05 +0000
Subject: Re: [PATCH 4/7] dma-direct: provide generic support for uncached kernel segments
Message-Id: <20190501174905.GA20458@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190430110032.25301-1-hch@lst.de> <20190430110032.25301-5-hch@lst.de> <20190501171857.chfxqntvm6r4xrr4@pburton-laptop> <20190501172912.GA19375@lst.de> <20190501174033.6rj5aiopdeo4uqpw@pburton-laptop>
In-Reply-To: <20190501174033.6rj5aiopdeo4uqpw@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Burton <paul.burton@mips.com>
Cc: Christoph Hellwig <hch@lst.de>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Wed, May 01, 2019 at 05:40:34PM +0000, Paul Burton wrote:
> > > If it is necessary then as-is this code will clear the allocated memory
> > > using uncached writes which will be pretty slow. It would be much more
> > > efficient to perform the memset before arch_dma_prep_coherent() & before
> > > converting ret to an uncached address.
> > 
> > Yes, we could do that.
> 
> Great; using cached writes would match the existing MIPS behavior.

Can you test the stack with the two updated patches and ack them if
they are fine?  That would allow getting at least the infrastructure
and mips in for this merge window.

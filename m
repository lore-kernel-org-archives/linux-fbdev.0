From: Christoph Hellwig <hch@lst.de>
Date: Tue, 07 May 2019 06:36:18 +0000
Subject: Re: [PATCH 2/7] au1100fb: fix DMA API abuse
Message-Id: <20190507063618.GA28147@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190430110032.25301-1-hch@lst.de>
	<CGME20190430110118epcas2p24019c7551331cc6390e5b5e07b381dd9@epcas2p2.samsung.com>
	<20190430110032.25301-3-hch@lst.de>
	<7a63eeae-4ec3-c82e-c497-8adc7bcb3cea@samsung.com>
In-Reply-To: <7a63eeae-4ec3-c82e-c497-8adc7bcb3cea@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Michal Simek <monstr@monstr.eu>, James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>, iommu@lists.linux-foundation.org, linux-fbdev@vger.kernel.org, Ley Foon Tan <lftan@altera.com>, Christoph Hellwig <hch@lst.de>

On Mon, May 06, 2019 at 03:49:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> On 04/30/2019 01:00 PM, Christoph Hellwig wrote:
> > Virtual addresses return from dma(m)_alloc_coherent are opaque in what
> > backs then, and drivers must not poke into them.  Switch the driver
> > to use the generic DMA API mmap helper to avoid these games.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Given this actually fixes issues with the current driver, what do you
think of taking it for 5.2 through your tree?  Also au1200fb has
basically the same issues, just without abusing the CAC_ADDR helper,
I could send you a patch for that one as well.

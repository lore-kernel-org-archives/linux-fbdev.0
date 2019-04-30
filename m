From: Paul Burton <paul.burton@mips.com>
Date: Tue, 30 Apr 2019 21:11:07 +0000
Subject: Re: [PATCH 5/7] MIPS: use the generic uncached segment support in dma-direct
Message-Id: <20190430211105.ielntedm46uqamca@pburton-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190430110032.25301-1-hch@lst.de>
 <20190430110032.25301-6-hch@lst.de>
 <20190430201041.536amvinrcvd2wua@pburton-laptop>
 <20190430202947.GA30262@lst.de>
In-Reply-To: <20190430202947.GA30262@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Christoph,

On Tue, Apr 30, 2019 at 10:29:47PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 30, 2019 at 08:10:43PM +0000, Paul Burton wrote:
> > This series looks like a nice cleanup to me - the one thing that puzzles
> > me is the !PageHighMem check above.
> > 
> > As far as I can see arch_dma_prep_coherent() should never be called with
> > a highmem page, so would it make more sense to either drop this check or
> > perhaps wrap it in a WARN_ON()?
> 
> dma_alloc_from_contigous can return highmem pages depending on where
> the CMA area is located.  But given that these pages don't have a
> direct kernel mapping we also shouldn't have to flush the caches
> for them.

Right but dma_direct_alloc_pages() already checks for the PageHighMem
case & returns before ever calling arch_dma_prep_coherent(), no?

Thanks,
    Paul

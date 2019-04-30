From: Christoph Hellwig <hch@lst.de>
Date: Tue, 30 Apr 2019 21:15:54 +0000
Subject: Re: [PATCH 5/7] MIPS: use the generic uncached segment support in dma-direct
Message-Id: <20190430211553.GA31109@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190430110032.25301-1-hch@lst.de> <20190430110032.25301-6-hch@lst.de> <20190430201041.536amvinrcvd2wua@pburton-laptop> <20190430202947.GA30262@lst.de> <20190430211105.ielntedm46uqamca@pburton-laptop>
In-Reply-To: <20190430211105.ielntedm46uqamca@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Burton <paul.burton@mips.com>
Cc: Christoph Hellwig <hch@lst.de>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Tue, Apr 30, 2019 at 09:11:07PM +0000, Paul Burton wrote:
> Right but dma_direct_alloc_pages() already checks for the PageHighMem
> case & returns before ever calling arch_dma_prep_coherent(), no?

True.  And of course it can't be remapped into the uncached segment
anyway.  So yes, we should drop it.  Eventually I want to add generic
support for DMA_ATTR_NO_KERNEL_MAPPING, but that'll involved auditing
all instances anyway.

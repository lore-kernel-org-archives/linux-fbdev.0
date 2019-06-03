From: Christoph Hellwig <hch@lst.de>
Date: Mon, 03 Jun 2019 06:48:55 +0000
Subject: Re: [PATCH 5/7 v2] MIPS: use the generic uncached segment support in dma-direct
Message-Id: <20190603064855.GA22023@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190430110032.25301-1-hch@lst.de>
	<20190430110032.25301-6-hch@lst.de>
	<20190430201041.536amvinrcvd2wua@pburton-laptop>
	<20190430202947.GA30262@lst.de>
	<20190430211105.ielntedm46uqamca@pburton-laptop>
	<20190501131339.GA890@lst.de>
	<20190501171355.7wnrutfnax5djkpx@pburton-laptop>
In-Reply-To: <20190501171355.7wnrutfnax5djkpx@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Burton <paul.burton@mips.com>
Cc: Michal Simek <monstr@monstr.eu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, James Hogan <jhogan@kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Ley Foon Tan <lftan@altera.com>, Christoph Hellwig <hch@lst.de>

On Wed, May 01, 2019 at 05:13:57PM +0000, Paul Burton wrote:
> Hi Christoph,
> 
> On Wed, May 01, 2019 at 03:13:39PM +0200, Christoph Hellwig wrote:
> > Stop providing our arch alloc/free hooks and just expose the segment
> > offset instead.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/mips/Kconfig              |  1 +
> >  arch/mips/include/asm/page.h   |  3 ---
> >  arch/mips/jazz/jazzdma.c       |  6 ------
> >  arch/mips/mm/dma-noncoherent.c | 26 +++++++++-----------------
> >  4 files changed, 10 insertions(+), 26 deletions(-)
> 
> This one looks good to me now, for patches 1 & 5:
> 
>   Acked-by: Paul Burton <paul.burton@mips.com>

Thanks, I've merged thos into the dma-mapping tree.

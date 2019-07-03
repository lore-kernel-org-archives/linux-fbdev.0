From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 03 Jul 2019 08:54:05 +0000
Subject: Re: [PATCH 5/7 v2] MIPS: use the generic uncached segment support in dma-direct
Message-Id: <CAK8P3a0+mmc_DsHZZeM85xGUUB8zc50ROUu3=i3UN1XwD8UGeQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190430110032.25301-1-hch@lst.de>
	<20190430110032.25301-6-hch@lst.de>
	<20190430201041.536amvinrcvd2wua@pburton-laptop>
	<20190430202947.GA30262@lst.de>
	<20190430211105.ielntedm46uqamca@pburton-laptop>
	<20190501131339.GA890@lst.de>
	<20190501171355.7wnrutfnax5djkpx@pburton-laptop>
	<20190603064855.GA22023@lst.de>
In-Reply-To: <20190603064855.GA22023@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Christoph Hellwig <hch@lst.de>
Cc: Michal Simek <monstr@monstr.eu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, James Hogan <jhogan@kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Ley Foon Tan <lftan@altera.com>

On Mon, Jun 3, 2019 at 8:50 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, May 01, 2019 at 05:13:57PM +0000, Paul Burton wrote:
> > Hi Christoph,
> >
> > On Wed, May 01, 2019 at 03:13:39PM +0200, Christoph Hellwig wrote:
> > > Stop providing our arch alloc/free hooks and just expose the segment
> > > offset instead.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  arch/mips/Kconfig              |  1 +
> > >  arch/mips/include/asm/page.h   |  3 ---
> > >  arch/mips/jazz/jazzdma.c       |  6 ------
> > >  arch/mips/mm/dma-noncoherent.c | 26 +++++++++-----------------
> > >  4 files changed, 10 insertions(+), 26 deletions(-)
> >
> > This one looks good to me now, for patches 1 & 5:
> >
> >   Acked-by: Paul Burton <paul.burton@mips.com>
>
> Thanks, I've merged thos into the dma-mapping tree.

I think this is the cause of some kernelci failures in current
linux-next builds:

https://kernelci.org/build/next/branch/master/kernel/next-20190702/

bigsur_defconfig ‐ mips3 warnings — 1 error
cavium_octeon_defconfig ‐ mips3 warnings — 1 error
ip27_defconfig ‐ mips3 warnings — 1 error
loongson3_defconfig ‐ mips3 warnings — 1 error
mips_paravirt_defconfig ‐ mips3 warnings — 1 error
nlm_xlp_defconfig ‐ mips3 warnings — 1 error
nlm_xlr_defconfig ‐ mips1 warning — 1 error

/home/buildslave/workspace/workspace/kernel-build@8/linux/build/../kernel/dma/direct.c:144:
undefined reference to `arch_dma_prep_coherent'
2/home/buildslave/workspace/kernel-build/linux/build/../kernel/dma/direct.c:144:
undefined reference to `arch_dma_prep_coherent'
2(.text+0xafc): undefined reference to `arch_dma_prep_coherent'
1direct.c:(.text+0x934): undefined reference to `arch_dma_prep_coherent'
1(.text+0xb84): undefined reference to `arch_dma_prep_coherent'

I haven't looked into the details, but I suspect all machines
with cache-coherent DMA are broken.

       Arnd

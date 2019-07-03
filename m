From: Christoph Hellwig <hch@lst.de>
Date: Wed, 03 Jul 2019 12:13:47 +0000
Subject: Re: [PATCH 5/7 v2] MIPS: use the generic uncached segment support in dma-direct
Message-Id: <20190703121347.GB7671@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190430110032.25301-1-hch@lst.de>
	<20190430110032.25301-6-hch@lst.de>
	<20190430201041.536amvinrcvd2wua@pburton-laptop>
	<20190430202947.GA30262@lst.de>
	<20190430211105.ielntedm46uqamca@pburton-laptop>
	<20190501131339.GA890@lst.de>
	<20190501171355.7wnrutfnax5djkpx@pburton-laptop>
	<20190603064855.GA22023@lst.de>
	<CAK8P3a0+mmc_DsHZZeM85xGUUB8zc50ROUu3=i3UN1XwD8UGeQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0+mmc_DsHZZeM85xGUUB8zc50ROUu3=i3UN1XwD8UGeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Simek <monstr@monstr.eu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, James Hogan <jhogan@kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Ley Foon Tan <lftan@altera.com>, Christoph Hellwig <hch@lst.de>

On Wed, Jul 03, 2019 at 10:54:05AM +0200, Arnd Bergmann wrote:
> I think this is the cause of some kernelci failures in current
> linux-next builds:

Yes, Guenther reported this already and I sent a fix.  I've been waiting
for an ACK from the mips maintaines, but given the breakage I
might as well just pull it in without an ACK.

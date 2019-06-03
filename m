From: Christoph Hellwig <hch@lst.de>
Date: Mon, 03 Jun 2019 06:49:21 +0000
Subject: Re: [PATCH 2/7] au1100fb: fix DMA API abuse
Message-Id: <20190603064921.GB22023@lst.de>
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

FYI, I've merged this patch into the dma-mapping tree to make progress
with the generic uncached segment support for mips.

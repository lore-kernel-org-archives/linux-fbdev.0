From: Christoph Hellwig <hch@lst.de>
Date: Tue, 30 Apr 2019 11:00:25 +0000
Subject: provide generic support for uncached segements in dma-direct
Message-Id: <20190430110032.25301-1-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi all,

can you take a look at this series?  It lifts the support for mips-style
uncached segements to the dma-direct layer, thus removing the need
to have arch_dma_alloc/free routines for these architectures.

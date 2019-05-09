From: Christoph Hellwig <hch@lst.de>
Date: Thu, 09 May 2019 17:38:46 +0000
Subject: fix DMA API abuse in various mips fbdev drivers
Message-Id: <20190509173849.11825-1-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Manuel Lauss <manuel.lauss@gmail.com>
Cc: linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

this series fixes up three mips-specific fbdev drivers to not poke
into the return values from the DMA memory allocators, as those
aren't guranteed to be pages backed (although on mips in practice
they are).  Two of them are also fixed up to use the proper DMA API
mmap helper.

Note that the first patch is required for pending mips DMA changes,
so if they are queued up for 5.3 we'll need a stable branch that
can be pulled into the dma-mapping or mips tree.

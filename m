From: Hideki EIRAKU <hdk@igel.co.jp>
Date: Wed, 25 Jul 2012 06:29:21 +0000
Subject: [PATCH 0/3] Use dma_mmap_coherent to support IOMMU mapper
Message-Id: <1343197764-13659-1-git-send-email-hdk@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

There is a dma_mmap_coherent() API in some architectures.  This API
provides a mmap function for memory allocated by dma_alloc_coherent().
Some drivers mmap a dma_addr_t returned by dma_alloc_coherent() as a
physical address.  But such drivers do not work correctly when IOMMU
mapper is used.

Hideki EIRAKU (3):
  ARM: dma-mapping: define ARCH_HAS_DMA_MMAP_COHERENT
  media: videobuf2-dma-contig: use dma_mmap_coherent if available
  fbdev: sh_mobile_lcdc: use dma_mmap_coherent if available

 arch/arm/include/asm/dma-mapping.h         |    1 +
 drivers/media/video/videobuf2-dma-contig.c |   18 ++++++++++++++++++
 drivers/video/sh_mobile_lcdcfb.c           |   14 ++++++++++++++
 3 files changed, 33 insertions(+), 0 deletions(-)


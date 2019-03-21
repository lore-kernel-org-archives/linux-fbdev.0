From: Christoph Hellwig <hch@lst.de>
Date: Thu, 21 Mar 2019 22:52:33 +0000
Subject: [PATCH 5/7] arm: use a dummy struct device for ISA DMA use of the DMA API
Message-Id: <20190321225235.30648-6-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190321225235.30648-1-hch@lst.de>
In-Reply-To: <20190321225235.30648-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@armlinux.org.uk>, x86@kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

This gets rid of the last NULL dev argument passed to the DMA API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/kernel/dma-isa.c | 8 +++++++-
 arch/arm/mach-rpc/dma.c   | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/dma-isa.c b/arch/arm/kernel/dma-isa.c
index 84363fe7bad2..10c45cc6b957 100644
--- a/arch/arm/kernel/dma-isa.c
+++ b/arch/arm/kernel/dma-isa.c
@@ -55,6 +55,12 @@ static int isa_get_dma_residue(unsigned int chan, dma_t *dma)
 	return chan < 4 ? count : (count << 1);
 }
 
+static struct device isa_dma_dev = {
+	.init_name		= "fallback device",
+	.coherent_dma_mask	= ~(dma_addr_t)0,
+	.dma_mask		= &isa_dma_dev.coherent_dma_mask,
+};
+
 static void isa_enable_dma(unsigned int chan, dma_t *dma)
 {
 	if (dma->invalid) {
@@ -89,7 +95,7 @@ static void isa_enable_dma(unsigned int chan, dma_t *dma)
 			dma->sg = &dma->buf;
 			dma->sgcount = 1;
 			dma->buf.length = dma->count;
-			dma->buf.dma_address = dma_map_single(NULL,
+			dma->buf.dma_address = dma_map_single(&isa_dma_dev,
 				dma->addr, dma->count,
 				direction);
 		}
diff --git a/arch/arm/mach-rpc/dma.c b/arch/arm/mach-rpc/dma.c
index fb48f3141fb4..f2703ca17954 100644
--- a/arch/arm/mach-rpc/dma.c
+++ b/arch/arm/mach-rpc/dma.c
@@ -151,6 +151,12 @@ static void iomd_free_dma(unsigned int chan, dma_t *dma)
 	free_irq(idma->irq, idma);
 }
 
+static struct device isa_dma_dev = {
+	.init_name		= "fallback device",
+	.coherent_dma_mask	= ~(dma_addr_t)0,
+	.dma_mask		= &isa_dma_dev.coherent_dma_mask,
+};
+
 static void iomd_enable_dma(unsigned int chan, dma_t *dma)
 {
 	struct iomd_dma *idma = container_of(dma, struct iomd_dma, dma);
@@ -168,7 +174,7 @@ static void iomd_enable_dma(unsigned int chan, dma_t *dma)
 			idma->dma.sg = &idma->dma.buf;
 			idma->dma.sgcount = 1;
 			idma->dma.buf.length = idma->dma.count;
-			idma->dma.buf.dma_address = dma_map_single(NULL,
+			idma->dma.buf.dma_address = dma_map_single(&isa_dma_dev,
 				idma->dma.addr, idma->dma.count,
 				idma->dma.dma_mode = DMA_MODE_READ ?
 				DMA_FROM_DEVICE : DMA_TO_DEVICE);
-- 
2.20.1

From: Christoph Hellwig <hch@lst.de>
Date: Fri, 16 Jun 2017 07:17:10 +0000
Subject: [PATCH 05/11] serial/mpsc: switch to dma_alloc_attrs
Message-Id: <20170616071716.17321-6-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170616071716.17321-1-hch@lst.de>
In-Reply-To: <20170616071716.17321-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org, netdev@vger.kernel.org, linux-metag@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org

Use dma_alloc_attrs directly instead of the dma_alloc_noncoherent wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/tty/serial/mpsc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
index 1a60a2063e75..67ffecc50e42 100644
--- a/drivers/tty/serial/mpsc.c
+++ b/drivers/tty/serial/mpsc.c
@@ -754,9 +754,10 @@ static int mpsc_alloc_ring_mem(struct mpsc_port_info *pi)
 		if (!dma_set_mask(pi->port.dev, 0xffffffff)) {
 			printk(KERN_ERR "MPSC: Inadequate DMA support\n");
 			rc = -ENXIO;
-		} else if ((pi->dma_region = dma_alloc_noncoherent(pi->port.dev,
+		} else if ((pi->dma_region = dma_alloc_attrs(pi->port.dev,
 						MPSC_DMA_ALLOC_SIZE,
-						&pi->dma_region_p, GFP_KERNEL))
+						&pi->dma_region_p, GFP_KERNEL,
+						DMA_ATTR_NON_CONSISTENT))
 				= NULL) {
 			printk(KERN_ERR "MPSC: Can't alloc Desc region\n");
 			rc = -ENOMEM;
@@ -771,8 +772,9 @@ static void mpsc_free_ring_mem(struct mpsc_port_info *pi)
 	pr_debug("mpsc_free_ring_mem[%d]: Freeing ring mem\n", pi->port.line);
 
 	if (pi->dma_region) {
-		dma_free_noncoherent(pi->port.dev, MPSC_DMA_ALLOC_SIZE,
-				pi->dma_region, pi->dma_region_p);
+		dma_free_attrs(pi->port.dev, MPSC_DMA_ALLOC_SIZE,
+				pi->dma_region, pi->dma_region_p,
+				DMA_ATTR_NON_CONSISTENT);
 		pi->dma_region = NULL;
 		pi->dma_region_p = (dma_addr_t)NULL;
 	}
-- 
2.11.0


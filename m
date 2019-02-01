From: Christoph Hellwig <hch@lst.de>
Date: Fri, 01 Feb 2019 08:47:54 +0000
Subject: [PATCH 11/18] parport_ip32: pass struct device to DMA API functions
Message-Id: <20190201084801.10983-12-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de>
In-Reply-To: <20190201084801.10983-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: iommu@lists.linux-foundation.org

The DMA API generally relies on a struct device to work properly, and
only barely works without one for legacy reasons.  Pass the easily
available struct device from the platform_device to remedy this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/parport/parport_ip32.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/parport/parport_ip32.c b/drivers/parport/parport_ip32.c
index 62873070f988..b7a892791c3e 100644
--- a/drivers/parport/parport_ip32.c
+++ b/drivers/parport/parport_ip32.c
@@ -568,6 +568,7 @@ static irqreturn_t parport_ip32_merr_interrupt(int irq, void *dev_id)
 
 /**
  * parport_ip32_dma_start - begins a DMA transfer
+ * @p:		partport to work on
  * @dir:	DMA direction: DMA_TO_DEVICE or DMA_FROM_DEVICE
  * @addr:	pointer to data buffer
  * @count:	buffer size
@@ -575,8 +576,8 @@ static irqreturn_t parport_ip32_merr_interrupt(int irq, void *dev_id)
  * Calls to parport_ip32_dma_start() and parport_ip32_dma_stop() must be
  * correctly balanced.
  */
-static int parport_ip32_dma_start(enum dma_data_direction dir,
-				  void *addr, size_t count)
+static int parport_ip32_dma_start(struct parport *p,
+		enum dma_data_direction dir, void *addr, size_t count)
 {
 	unsigned int limit;
 	u64 ctrl;
@@ -601,7 +602,7 @@ static int parport_ip32_dma_start(enum dma_data_direction dir,
 
 	/* Prepare DMA pointers */
 	parport_ip32_dma.dir = dir;
-	parport_ip32_dma.buf = dma_map_single(NULL, addr, count, dir);
+	parport_ip32_dma.buf = dma_map_single(&p->bus_dev, addr, count, dir);
 	parport_ip32_dma.len = count;
 	parport_ip32_dma.next = parport_ip32_dma.buf;
 	parport_ip32_dma.left = parport_ip32_dma.len;
@@ -625,11 +626,12 @@ static int parport_ip32_dma_start(enum dma_data_direction dir,
 
 /**
  * parport_ip32_dma_stop - ends a running DMA transfer
+ * @p:		partport to work on
  *
  * Calls to parport_ip32_dma_start() and parport_ip32_dma_stop() must be
  * correctly balanced.
  */
-static void parport_ip32_dma_stop(void)
+static void parport_ip32_dma_stop(struct parport *p)
 {
 	u64 ctx_a;
 	u64 ctx_b;
@@ -685,8 +687,8 @@ static void parport_ip32_dma_stop(void)
 	enable_irq(MACEISA_PAR_CTXB_IRQ);
 	parport_ip32_dma.irq_on = 1;
 
-	dma_unmap_single(NULL, parport_ip32_dma.buf, parport_ip32_dma.len,
-			 parport_ip32_dma.dir);
+	dma_unmap_single(&p->bus_dev, parport_ip32_dma.buf,
+			 parport_ip32_dma.len, parport_ip32_dma.dir);
 }
 
 /**
@@ -1445,7 +1447,7 @@ static size_t parport_ip32_fifo_write_block_dma(struct parport *p,
 
 	priv->irq_mode = PARPORT_IP32_IRQ_HERE;
 
-	parport_ip32_dma_start(DMA_TO_DEVICE, (void *)buf, len);
+	parport_ip32_dma_start(p, DMA_TO_DEVICE, (void *)buf, len);
 	reinit_completion(&priv->irq_complete);
 	parport_ip32_frob_econtrol(p, ECR_DMAEN | ECR_SERVINTR, ECR_DMAEN);
 
@@ -1461,7 +1463,7 @@ static size_t parport_ip32_fifo_write_block_dma(struct parport *p,
 		if (ecr & ECR_SERVINTR)
 			break;	/* DMA transfer just finished */
 	}
-	parport_ip32_dma_stop();
+	parport_ip32_dma_stop(p);
 	written = len - parport_ip32_dma_get_residue();
 
 	priv->irq_mode = PARPORT_IP32_IRQ_FWD;
-- 
2.20.1

From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Sep 2011 21:44:52 +0000
Subject: [PATCH 07/13] drivers/video: fsl-diu-fb: improve local variable usage in some functions
Message-Id: <1316123098-30967-8-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Clean up the local variable usage in request_irq_local() and allocate_buf().
This streamlines the code without affecting functionality.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index c893954..4d22399 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1265,14 +1265,14 @@ static irqreturn_t fsl_diu_isr(int irq, void *dev_id)
 
 static int request_irq_local(int irq)
 {
-	unsigned long status, ints;
+	u32 ints;
 	struct diu *hw;
 	int ret;
 
 	hw = dr.diu_reg;
 
 	/* Read to clear the status */
-	status = in_be32(&hw->int_status);
+	in_be32(&hw->int_status);
 
 	ret = request_irq(irq, fsl_diu_isr, 0, "diu", NULL);
 	if (!ret) {
@@ -1285,7 +1285,7 @@ static int request_irq_local(int irq)
 			ints |= INT_VSYNC_WB;
 
 		/* Read to clear the status */
-		status = in_be32(&hw->int_status);
+		in_be32(&hw->int_status);
 		out_be32(&hw->int_mask, ints);
 	}
 
@@ -1336,23 +1336,20 @@ static int fsl_diu_resume(struct platform_device *ofdev)
 static int allocate_buf(struct device *dev, struct diu_addr *buf, u32 size,
 			u32 bytes_align)
 {
-	u32 offset, ssize;
-	u32 mask;
-	dma_addr_t paddr = 0;
+	u32 offset;
+	dma_addr_t mask;
 
-	ssize = size + bytes_align;
-	buf->vaddr = dma_alloc_coherent(dev, ssize, &paddr, GFP_DMA |
-							     __GFP_ZERO);
+	buf->vaddr +		dma_alloc_coherent(dev, size + bytes_align, &buf->paddr,
+				   GFP_DMA | __GFP_ZERO);
 	if (!buf->vaddr)
 		return -ENOMEM;
 
-	buf->paddr = (__u32) paddr;
-
 	mask = bytes_align - 1;
-	offset = (u32)buf->paddr & mask;
+	offset = buf->paddr & mask;
 	if (offset) {
 		buf->offset = bytes_align - offset;
-		buf->paddr = (u32)buf->paddr + offset;
+		buf->paddr = buf->paddr + offset;
 	} else
 		buf->offset = 0;
 
-- 
1.7.3.4



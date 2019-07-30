From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Tue, 30 Jul 2019 19:45:20 +0000
Subject: [PATCH] video: fbdev:via: Remove dead code
Message-Id: <1564515200-5020-1-git-send-email-jrdr.linux@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Souptick Joarder <jrdr.linux@gmail.com>

This is dead code since 3.15. If there is no plan to use
it further, this can be removed forever.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/video/fbdev/via/via-core.c | 43 --------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/video/fbdev/via/via-core.c b/drivers/video/fbdev/via/via-core.c
index e2b2062..ffa2ca2 100644
--- a/drivers/video/fbdev/via/via-core.c
+++ b/drivers/video/fbdev/via/via-core.c
@@ -221,49 +221,6 @@ void viafb_release_dma(void)
 }
 EXPORT_SYMBOL_GPL(viafb_release_dma);
 
-
-#if 0
-/*
- * Copy a single buffer from FB memory, synchronously.  This code works
- * but is not currently used.
- */
-void viafb_dma_copy_out(unsigned int offset, dma_addr_t paddr, int len)
-{
-	unsigned long flags;
-	int csr;
-
-	mutex_lock(&viafb_dma_lock);
-	init_completion(&viafb_dma_completion);
-	/*
-	 * Program the controller.
-	 */
-	spin_lock_irqsave(&global_dev.reg_lock, flags);
-	viafb_mmio_write(VDMA_CSR0, VDMA_C_ENABLE|VDMA_C_DONE);
-	/* Enable ints; must happen after CSR0 write! */
-	viafb_mmio_write(VDMA_MR0, VDMA_MR_TDIE);
-	viafb_mmio_write(VDMA_MARL0, (int) (paddr & 0xfffffff0));
-	viafb_mmio_write(VDMA_MARH0, (int) ((paddr >> 28) & 0xfff));
-	/* Data sheet suggests DAR0 should be <<4, but it lies */
-	viafb_mmio_write(VDMA_DAR0, offset);
-	viafb_mmio_write(VDMA_DQWCR0, len >> 4);
-	viafb_mmio_write(VDMA_TMR0, 0);
-	viafb_mmio_write(VDMA_DPRL0, 0);
-	viafb_mmio_write(VDMA_DPRH0, 0);
-	viafb_mmio_write(VDMA_PMR0, 0);
-	csr = viafb_mmio_read(VDMA_CSR0);
-	viafb_mmio_write(VDMA_CSR0, VDMA_C_ENABLE|VDMA_C_START);
-	spin_unlock_irqrestore(&global_dev.reg_lock, flags);
-	/*
-	 * Now we just wait until the interrupt handler says
-	 * we're done.
-	 */
-	wait_for_completion_interruptible(&viafb_dma_completion);
-	viafb_mmio_write(VDMA_MR0, 0); /* Reset int enable */
-	mutex_unlock(&viafb_dma_lock);
-}
-EXPORT_SYMBOL_GPL(viafb_dma_copy_out);
-#endif
-
 /*
  * Do a scatter/gather DMA copy from FB memory.  You must have done
  * a successful call to viafb_request_dma() first.
-- 
1.9.1

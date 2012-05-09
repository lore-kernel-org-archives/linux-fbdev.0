From: Donghwa Lee <dh09.lee@samsung.com>
Date: Wed, 09 May 2012 05:33:29 +0000
Subject: [PATCH 4/5] video: exynos mipi dsi: Properly interpret the interrupt source flags
Message-Id: <4FAA01A9.4070908@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

Rework the interrupt handler so the RX_DONE, FIFO_EMPTY interrupts are
properly detected. This prevents missing the interrupts when there are
other bits set in the INTSRC register than just RX_DONE and FIFO_EMPTY.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/exynos/exynos_mipi_dsi_common.c |   28 +++++++++----------------
 1 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c b/drivers/video/exynos/exynos_mipi_dsi_common.c
index 14909c1..b78d448 100644
--- a/drivers/video/exynos/exynos_mipi_dsi_common.c
+++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
@@ -76,33 +76,25 @@ static unsigned int dpll_table[15] = {
 
 irqreturn_t exynos_mipi_dsi_interrupt_handler(int irq, void *dev_id)
 {
-	unsigned int intsrc = 0;
-	unsigned int intmsk = 0;
-	struct mipi_dsim_device *dsim = NULL;
-
-	dsim = dev_id;
-	if (!dsim) {
-		dev_dbg(dsim->dev, KERN_ERR "%s:error: wrong parameter\n",
-							__func__);
-		return IRQ_HANDLED;
+	struct mipi_dsim_device *dsim = dev_id;
+	unsigned int intsrc, intmsk;
+
+	if (dsim = NULL) {
+		dev_err(dsim->dev, "%s: wrong parameter\n", __func__);
+		return IRQ_NONE;
 	}
 
 	intsrc = exynos_mipi_dsi_read_interrupt(dsim);
 	intmsk = exynos_mipi_dsi_read_interrupt_mask(dsim);
+	intmsk = ~intmsk & intsrc;
 
-	intmsk = ~(intmsk) & intsrc;
-
-	switch (intmsk) {
-	case INTMSK_RX_DONE:
+	if (intsrc & INTMSK_RX_DONE) {
 		complete(&dsim_rd_comp);
 		dev_dbg(dsim->dev, "MIPI INTMSK_RX_DONE\n");
-		break;
-	case INTMSK_FIFO_EMPTY:
+	}
+	if (intsrc & INTMSK_FIFO_EMPTY) {
 		complete(&dsim_wr_comp);
 		dev_dbg(dsim->dev, "MIPI INTMSK_FIFO_EMPTY\n");
-		break;
-	default:
-		break;
 	}
 
 	exynos_mipi_dsi_clear_interrupt(dsim, intmsk);
-- 
1.7.4.1

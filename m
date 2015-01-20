From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Tue, 20 Jan 2015 05:23:50 +0000
Subject: [PATCH] video: treat signal like timeout as failure
Message-Id: <1421731430-13207-1-git-send-email-der.herr@hofr.at>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

if(!wait_for_completion_interruptible_timeout(...))
only handles the timeout case - this patch adds handling the
signal case the same as timeout and cleans up.

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---

Only the timeout case was being handled, return of 0 in 
wait_for_completion_interruptible_timeout, the signal case (-ERESTARTSYS)
was treated just like the case of successful completion, which is most 
likely not reasonable.

Note that exynos_mipi_dsi_wr_data/exynos_mipi_dsi_rd_data return values
are not checked at the call sites in s6e8ax0.c (cmd_read/cmd_write)!

This patch simply treats the signal case the same way as the timeout case,
by releasing locks and returning 0 - which might not be the right thing to
do - this needs a review by someone knowing the details of this driver.

Patch is against 3.19.0-rc5 -next-20150119

Patch was only compile-tested with exynos_defconfig

 drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c b/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c
index 2358a2f..55a7a45 100644
--- a/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c
+++ b/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c
@@ -157,6 +157,7 @@ int exynos_mipi_dsi_wr_data(struct mipi_dsim_device *dsim, unsigned int data_id,
 	const unsigned char *data0, unsigned int data_size)
 {
 	unsigned int check_rx_ack = 0;
+	long timeout;
 
 	if (dsim->state = DSIM_STATE_ULPS) {
 		dev_err(dsim->dev, "state is ULPS.\n");
@@ -244,9 +245,11 @@ int exynos_mipi_dsi_wr_data(struct mipi_dsim_device *dsim, unsigned int data_id,
 		exynos_mipi_dsi_wr_tx_header(dsim, data_id, data_size & 0xff,
 			(data_size & 0xff00) >> 8);
 
-		if (!wait_for_completion_interruptible_timeout(&dsim_wr_comp,
-							MIPI_FIFO_TIMEOUT)) {
-			dev_warn(dsim->dev, "command write timeout.\n");
+		timeout = wait_for_completion_interruptible_timeout(
+					&dsim_wr_comp, MIPI_FIFO_TIMEOUT);
+		if (timeout <= 0) {
+			dev_warn(dsim->dev,
+				"command write timed-out/interrupted.\n");
 			mutex_unlock(&dsim->lock);
 			return -EAGAIN;
 		}
@@ -345,6 +348,7 @@ int exynos_mipi_dsi_rd_data(struct mipi_dsim_device *dsim, unsigned int data_id,
 	unsigned int rx_data, rcv_pkt, i;
 	u8 response = 0;
 	u16 rxsize;
+	long timeout;
 
 	if (dsim->state = DSIM_STATE_ULPS) {
 		dev_err(dsim->dev, "state is ULPS.\n");
@@ -380,9 +384,10 @@ int exynos_mipi_dsi_rd_data(struct mipi_dsim_device *dsim, unsigned int data_id,
 		return -EINVAL;
 	}
 
-	if (!wait_for_completion_interruptible_timeout(&dsim_rd_comp,
-				MIPI_FIFO_TIMEOUT)) {
-		pr_err("RX done interrupt timeout\n");
+	timeout = wait_for_completion_interruptible_timeout(&dsim_rd_comp,
+				MIPI_FIFO_TIMEOUT);
+	if (timeout <= 0) {
+		pr_err("RX done interrupt timeout/interrupted\n");
 		mutex_unlock(&dsim->lock);
 		return 0;
 	}
-- 
1.7.10.4


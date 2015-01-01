From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Thu, 01 Jan 2015 19:14:24 +0000
Subject: [PATCH] video: fbdev: exynos: exynos_mipi_dsi_common:  Remove some unused functions
Message-Id: <1420139664-3008-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Removes some functions that are not used anywhere:
exynos_mipi_dsi_fifo_clear() exynos_mipi_dsi_set_data_transfer_mode()
exynos_mipi_dsi_enable_frame_done_int()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 .../video/fbdev/exynos/exynos_mipi_dsi_common.c    |   53 --------------------
 .../video/fbdev/exynos/exynos_mipi_dsi_common.h    |    7 ---
 2 files changed, 60 deletions(-)

diff --git a/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c b/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c
index 85edabf..d7b4abc 100644
--- a/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c
+++ b/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c
@@ -690,15 +690,6 @@ void exynos_mipi_dsi_init_interrupt(struct mipi_dsim_device *dsim)
 	exynos_mipi_dsi_set_interrupt_mask(dsim, src, 1);
 }
 
-int exynos_mipi_dsi_enable_frame_done_int(struct mipi_dsim_device *dsim,
-	unsigned int enable)
-{
-	/* enable only frame done interrupt */
-	exynos_mipi_dsi_set_interrupt_mask(dsim, INTMSK_FRAME_DONE, enable);
-
-	return 0;
-}
-
 void exynos_mipi_dsi_stand_by(struct mipi_dsim_device *dsim,
 		unsigned int enable)
 {
@@ -819,30 +810,6 @@ int exynos_mipi_dsi_set_hs_enable(struct mipi_dsim_device *dsim)
 	return 0;
 }
 
-int exynos_mipi_dsi_set_data_transfer_mode(struct mipi_dsim_device *dsim,
-		unsigned int mode)
-{
-	if (mode) {
-		if (dsim->state != DSIM_STATE_HSCLKEN) {
-			dev_err(dsim->dev, "HS Clock lane is not enabled.\n");
-			return -EINVAL;
-		}
-
-		exynos_mipi_dsi_set_lcdc_transfer_mode(dsim, 0);
-	} else {
-		if (dsim->state = DSIM_STATE_INIT || dsim->state =
-			DSIM_STATE_ULPS) {
-			dev_err(dsim->dev,
-				"DSI Master is not STOP or HSDT state.\n");
-			return -EINVAL;
-		}
-
-		exynos_mipi_dsi_set_cpu_transfer_mode(dsim, 0);
-	}
-
-	return 0;
-}
-
 int exynos_mipi_dsi_get_frame_done_status(struct mipi_dsim_device *dsim)
 {
 	return _exynos_mipi_dsi_get_frame_done_status(dsim);
@@ -855,26 +822,6 @@ int exynos_mipi_dsi_clear_frame_done(struct mipi_dsim_device *dsim)
 	return 0;
 }
 
-int exynos_mipi_dsi_fifo_clear(struct mipi_dsim_device *dsim,
-				unsigned int val)
-{
-	int try = TRY_FIFO_CLEAR;
-
-	exynos_mipi_dsi_sw_reset_release(dsim);
-	exynos_mipi_dsi_func_reset(dsim);
-
-	do {
-		if (exynos_mipi_dsi_get_sw_reset_release(dsim)) {
-			exynos_mipi_dsi_init_interrupt(dsim);
-			dev_dbg(dsim->dev, "reset release done.\n");
-			return 0;
-		}
-	} while (--try);
-
-	dev_err(dsim->dev, "failed to clear dsim fifo.\n");
-	return -EAGAIN;
-}
-
 MODULE_AUTHOR("InKi Dae <inki.dae@samsung.com>");
 MODULE_DESCRIPTION("Samusung SoC MIPI-DSI common driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.h b/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.h
index 4125522..5c1c30b 100644
--- a/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.h
+++ b/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.h
@@ -31,16 +31,9 @@ int exynos_mipi_dsi_set_display_mode(struct mipi_dsim_device *dsim,
 			struct mipi_dsim_config *dsim_info);
 int exynos_mipi_dsi_init_link(struct mipi_dsim_device *dsim);
 int exynos_mipi_dsi_set_hs_enable(struct mipi_dsim_device *dsim);
-int exynos_mipi_dsi_set_data_transfer_mode(struct mipi_dsim_device *dsim,
-		unsigned int mode);
-int exynos_mipi_dsi_enable_frame_done_int(struct mipi_dsim_device *dsim,
-	unsigned int enable);
 int exynos_mipi_dsi_get_frame_done_status(struct mipi_dsim_device *dsim);
 int exynos_mipi_dsi_clear_frame_done(struct mipi_dsim_device *dsim);
 
 extern struct fb_info *registered_fb[FB_MAX] __read_mostly;
 
-int exynos_mipi_dsi_fifo_clear(struct mipi_dsim_device *dsim,
-				unsigned int val);
-
 #endif /* _EXYNOS_MIPI_DSI_COMMON_H */
-- 
1.7.10.4


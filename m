From: Sean Paul <seanpaul@chromium.org>
Date: Wed, 08 Aug 2012 03:54:15 +0000
Subject: [PATCH 01/10] video: exynos_dp: Change aux transaction failures
Message-Id: <1344398064-13563-2-git-send-email-seanpaul@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch adds the function name to aux transaction failure messages
so we can tell which transaction is failing. It also changes the level
of Aux Transaction fail messages from error to debug. We retry the
transactions a few times and will report errors if warranted outside of
this function.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Bernie Thompson <bhthompson@chromium.org>
---
 drivers/video/exynos/exynos_dp_reg.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
index ce401c8..a121bed 100644
--- a/drivers/video/exynos/exynos_dp_reg.c
+++ b/drivers/video/exynos/exynos_dp_reg.c
@@ -471,7 +471,8 @@ int exynos_dp_write_byte_to_dpcd(struct exynos_dp_device *dp,
 		if (retval = 0)
 			break;
 		else
-			dev_err(dp->dev, "Aux Transaction fail!\n");
+			dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
+				__func__);
 	}
 
 	return retval;
@@ -511,7 +512,8 @@ int exynos_dp_read_byte_from_dpcd(struct exynos_dp_device *dp,
 		if (retval = 0)
 			break;
 		else
-			dev_err(dp->dev, "Aux Transaction fail!\n");
+			dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
+				__func__);
 	}
 
 	/* Read data buffer */
@@ -575,7 +577,8 @@ int exynos_dp_write_bytes_to_dpcd(struct exynos_dp_device *dp,
 			if (retval = 0)
 				break;
 			else
-				dev_err(dp->dev, "Aux Transaction fail!\n");
+				dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
+					__func__);
 		}
 
 		start_offset += cur_data_count;
@@ -632,7 +635,8 @@ int exynos_dp_read_bytes_from_dpcd(struct exynos_dp_device *dp,
 			if (retval = 0)
 				break;
 			else
-				dev_err(dp->dev, "Aux Transaction fail!\n");
+				dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
+					__func__);
 		}
 
 		for (cur_data_idx = 0; cur_data_idx < cur_data_count;
@@ -677,7 +681,7 @@ int exynos_dp_select_i2c_device(struct exynos_dp_device *dp,
 	/* Start AUX transaction */
 	retval = exynos_dp_start_aux_transaction(dp);
 	if (retval != 0)
-		dev_err(dp->dev, "Aux Transaction fail!\n");
+		dev_dbg(dp->dev, "%s: Aux Transaction fail!\n", __func__);
 
 	return retval;
 }
@@ -717,7 +721,8 @@ int exynos_dp_read_byte_from_i2c(struct exynos_dp_device *dp,
 		if (retval = 0)
 			break;
 		else
-			dev_err(dp->dev, "Aux Transaction fail!\n");
+			dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
+				__func__);
 	}
 
 	/* Read data */
@@ -777,7 +782,9 @@ int exynos_dp_read_bytes_from_i2c(struct exynos_dp_device *dp,
 				if (retval = 0)
 					break;
 				else
-					dev_err(dp->dev, "Aux Transaction fail!\n");
+					dev_dbg(dp->dev,
+						"%s: Aux Transaction fail!\n",
+						__func__);
 			}
 			/* Check if Rx sends defer */
 			reg = readl(dp->reg_base + EXYNOS_DP_AUX_RX_COMM);
-- 
1.7.7.3


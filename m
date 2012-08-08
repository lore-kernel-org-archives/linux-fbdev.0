From: Sean Paul <seanpaul@chromium.org>
Date: Wed, 08 Aug 2012 03:54:17 +0000
Subject: [PATCH 03/10] video: exynos_dp: Clean up SW link training
Message-Id: <1344398064-13563-4-git-send-email-seanpaul@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Clean up some of the SW training code to make it more clear and reduce
duplicate code.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Mandeep Singh Baines <msb@chromium.org>
---
 drivers/video/exynos/exynos_dp_core.c |  180 ++++++++++++---------------------
 1 files changed, 67 insertions(+), 113 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 1836e33..3deded2 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -260,10 +260,8 @@ static void exynos_dp_set_lane_lane_pre_emphasis(struct exynos_dp_device *dp,
 
 static int exynos_dp_link_start(struct exynos_dp_device *dp)
 {
-	int ret;
-	u8 buf[5];
-	int lane;
-	int lane_count;
+	int ret, lane, lane_count;
+	u8 buf[4];
 
 	lane_count = dp->link_train.lane_count;
 
@@ -286,8 +284,7 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
 	/* Setup RX configuration */
 	buf[0] = dp->link_train.link_rate;
 	buf[1] = dp->link_train.lane_count;
-	ret = exynos_dp_write_bytes_to_dpcd(dp, DPCD_ADDR_LINK_BW_SET,
-				2, buf);
+	ret = exynos_dp_write_bytes_to_dpcd(dp, DPCD_ADDR_LINK_BW_SET, 2, buf);
 	if (ret)
 		return ret;
 
@@ -300,16 +297,15 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
 	exynos_dp_set_training_pattern(dp, TRAINING_PTN1);
 
 	/* Set RX training pattern */
-	buf[0] = DPCD_SCRAMBLING_DISABLED |
-		 DPCD_TRAINING_PATTERN_1;
-	exynos_dp_write_byte_to_dpcd(dp,
-		DPCD_ADDR_TRAINING_PATTERN_SET, buf[0]);
+	ret = exynos_dp_write_byte_to_dpcd(dp, DPCD_ADDR_TRAINING_PATTERN_SET,
+		DPCD_SCRAMBLING_DISABLED | DPCD_TRAINING_PATTERN_1);
+	if (ret)
+		return ret;
 
 	for (lane = 0; lane < lane_count; lane++)
 		buf[lane] = DPCD_PRE_EMPHASIS_PATTERN2_LEVEL0 |
 			    DPCD_VOLTAGE_SWING_PATTERN1_LEVEL0;
-	ret = exynos_dp_write_bytes_to_dpcd(dp,
-		DPCD_ADDR_TRAINING_LANE0_SET,
+	ret = exynos_dp_write_bytes_to_dpcd(dp, DPCD_ADDR_TRAINING_LANE0_SET,
 		lane_count, buf);
 	if (ret)
 		return ret;
@@ -484,67 +480,32 @@ static int exynos_dp_check_max_cr_loop(struct exynos_dp_device *dp,
 
 static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 {
-	int ret;
-	u8 data;
-	u8 link_status[6];
-	int lane;
-	int lane_count;
-	u8 buf[5];
-
-	u8 adjust_request[2];
-	u8 voltage_swing;
-	u8 pre_emphasis;
-	u8 training_lane;
+	int ret, lane, lane_count;
+	u8 voltage_swing, pre_emphasis, training_lane, link_status[6];
+	u8 *adjust_request;
 
 	usleep_range(100, 101);
 
-	ret = exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
-				6, link_status);
+	ret = exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS, 6,
+			link_status);
 	if (ret)
 		return ret;
 
 	lane_count = dp->link_train.lane_count;
+	adjust_request = link_status + 4;
 
 	if (exynos_dp_clock_recovery_ok(link_status, lane_count) = 0) {
 		/* set training pattern 2 for EQ */
 		exynos_dp_set_training_pattern(dp, TRAINING_PTN2);
 
-		adjust_request[0] = link_status[4];
-		adjust_request[1] = link_status[5];
-
-		exynos_dp_get_adjust_train(dp, adjust_request);
-
-		buf[0] = DPCD_SCRAMBLING_DISABLED |
-			 DPCD_TRAINING_PATTERN_2;
 		ret = exynos_dp_write_byte_to_dpcd(dp,
 			DPCD_ADDR_TRAINING_PATTERN_SET,
-			buf[0]);
+			DPCD_SCRAMBLING_DISABLED | DPCD_TRAINING_PATTERN_2);
 		if (ret)
 			return ret;
 
-		for (lane = 0; lane < lane_count; lane++) {
-			exynos_dp_set_lane_link_training(dp,
-				dp->link_train.training_lane[lane],
-				lane);
-			buf[lane] = dp->link_train.training_lane[lane];
-			ret = exynos_dp_write_byte_to_dpcd(dp,
-				DPCD_ADDR_TRAINING_LANE0_SET + lane,
-				buf[lane]);
-			if (ret)
-				return ret;
-		}
 		dp->link_train.lt_state = EQUALIZER_TRAINING;
 	} else {
-		exynos_dp_read_byte_from_dpcd(dp,
-			DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
-			&data);
-		adjust_request[0] = data;
-
-		exynos_dp_read_byte_from_dpcd(dp,
-			DPCD_ADDR_ADJUST_REQUEST_LANE2_3,
-			&data);
-		adjust_request[1] = data;
-
 		for (lane = 0; lane < lane_count; lane++) {
 			training_lane = exynos_dp_get_lane_link_training(
 							dp, lane);
@@ -560,36 +521,31 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 
 		if (exynos_dp_check_max_cr_loop(dp, voltage_swing) != 0) {
 			exynos_dp_reduce_link_rate(dp);
-		} else {
-			exynos_dp_get_adjust_train(dp, adjust_request);
-
-			for (lane = 0; lane < lane_count; lane++) {
-				exynos_dp_set_lane_link_training(dp,
-					dp->link_train.training_lane[lane],
-					lane);
-				buf[lane] = dp->link_train.training_lane[lane];
-				ret = exynos_dp_write_byte_to_dpcd(dp,
-					DPCD_ADDR_TRAINING_LANE0_SET + lane,
-					buf[lane]);
-				if (ret)
-					return ret;
-			}
+			return ret;
 		}
 	}
 
+	exynos_dp_get_adjust_train(dp, adjust_request);
+
+	for (lane = 0; lane < lane_count; lane++) {
+		exynos_dp_set_lane_link_training(dp,
+			dp->link_train.training_lane[lane], lane);
+		ret = exynos_dp_write_byte_to_dpcd(dp,
+			DPCD_ADDR_TRAINING_LANE0_SET + lane,
+			dp->link_train.training_lane[lane]);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 
 static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
 {
-	int ret;
+	int ret, lane, lane_count;
 	u8 link_status[6];
-	int lane;
-	int lane_count;
-	u8 buf[5];
 	u32 reg;
-
-	u8 adjust_request[2];
+	u8 *adjust_request;
 
 	usleep_range(400, 401);
 
@@ -597,55 +553,53 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
 				6, link_status);
 	if (ret)
 		return ret;
+
+	adjust_request = link_status + 4;
 	lane_count = dp->link_train.lane_count;
 
-	if (exynos_dp_clock_recovery_ok(link_status, lane_count) = 0) {
-		adjust_request[0] = link_status[4];
-		adjust_request[1] = link_status[5];
+	if (exynos_dp_clock_recovery_ok(link_status, lane_count)) {
+		exynos_dp_reduce_link_rate(dp);
+		return ret;
+	}
+	if (exynos_dp_channel_eq_ok(link_status, lane_count) = 0) {
+		/* traing pattern Set to Normal */
+		exynos_dp_training_pattern_dis(dp);
 
-		if (exynos_dp_channel_eq_ok(link_status, lane_count) = 0) {
-			/* traing pattern Set to Normal */
-			exynos_dp_training_pattern_dis(dp);
+		dev_info(dp->dev, "Link Training success!\n");
 
-			dev_info(dp->dev, "Link Training success!\n");
+		exynos_dp_get_link_bandwidth(dp, &reg);
+		dp->link_train.link_rate = reg;
+		dev_dbg(dp->dev, "final bandwidth = %.2x\n",
+			dp->link_train.link_rate);
 
-			exynos_dp_get_link_bandwidth(dp, &reg);
-			dp->link_train.link_rate = reg;
-			dev_dbg(dp->dev, "final bandwidth = %.2x\n",
-				dp->link_train.link_rate);
+		exynos_dp_get_lane_count(dp, &reg);
+		dp->link_train.lane_count = reg;
+		dev_dbg(dp->dev, "final lane count = %.2x\n",
+			dp->link_train.lane_count);
+		/* set enhanced mode if available */
+		exynos_dp_set_enhanced_mode(dp);
 
-			exynos_dp_get_lane_count(dp, &reg);
-			dp->link_train.lane_count = reg;
-			dev_dbg(dp->dev, "final lane count = %.2x\n",
-				dp->link_train.lane_count);
-			/* set enhanced mode if available */
-			exynos_dp_set_enhanced_mode(dp);
+		dp->link_train.lt_state = FINISHED;
+	} else {
+		/* not all locked */
+		dp->link_train.eq_loop++;
 
-			dp->link_train.lt_state = FINISHED;
+		if (dp->link_train.eq_loop > MAX_EQ_LOOP) {
+			exynos_dp_reduce_link_rate(dp);
 		} else {
-			/* not all locked */
-			dp->link_train.eq_loop++;
-
-			if (dp->link_train.eq_loop > MAX_EQ_LOOP) {
-				exynos_dp_reduce_link_rate(dp);
-			} else {
-				exynos_dp_get_adjust_train(dp, adjust_request);
-
-				for (lane = 0; lane < lane_count; lane++) {
-					exynos_dp_set_lane_link_training(dp,
-						dp->link_train.training_lane[lane],
-						lane);
-					buf[lane] = dp->link_train.training_lane[lane];
-					ret = exynos_dp_write_byte_to_dpcd(dp,
-						DPCD_ADDR_TRAINING_LANE0_SET + lane,
-						buf[lane]);
-					if (ret)
-						return ret;
-				}
+			exynos_dp_get_adjust_train(dp, adjust_request);
+
+			for (lane = 0; lane < lane_count; lane++) {
+				exynos_dp_set_lane_link_training(dp,
+					dp->link_train.training_lane[lane],
+					lane);
+				ret = exynos_dp_write_byte_to_dpcd(dp,
+					DPCD_ADDR_TRAINING_LANE0_SET + lane,
+					dp->link_train.training_lane[lane]);
+				if (ret)
+					return ret;
 			}
 		}
-	} else {
-		exynos_dp_reduce_link_rate(dp);
 	}
 
 	return ret;
-- 
1.7.7.3


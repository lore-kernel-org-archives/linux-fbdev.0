From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 09 Nov 2012 05:48:37 +0000
Subject: [PATCH v4 1/8] video: exynos_dp: Check DPCD return codes
Message-Id: <001901cdbe3d$dd5bdd00$98139700$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Add return code checks to the DPCD transactions in the SW link training

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |   86 +++++++++++++++++++++-----------
 1 files changed, 56 insertions(+), 30 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index d55470e..44820f2 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -261,11 +261,10 @@ static void exynos_dp_set_lane_lane_pre_emphasis(struct exynos_dp_device *dp,
 	}
 }
 
-static void exynos_dp_link_start(struct exynos_dp_device *dp)
+static int exynos_dp_link_start(struct exynos_dp_device *dp)
 {
 	u8 buf[4];
-	int lane;
-	int lane_count;
+	int lane, lane_count, retval;
 
 	lane_count = dp->link_train.lane_count;
 
@@ -276,8 +275,10 @@ static void exynos_dp_link_start(struct exynos_dp_device *dp)
 		dp->link_train.cr_loop[lane] = 0;
 
 	/* Set sink to D0 (Sink Not Ready) mode. */
-	exynos_dp_write_byte_to_dpcd(dp, DPCD_ADDR_SINK_POWER_STATE,
+	retval = exynos_dp_write_byte_to_dpcd(dp, DPCD_ADDR_SINK_POWER_STATE,
 				DPCD_SET_POWER_STATE_D0);
+	if (retval)
+		return retval;
 
 	/* Set link rate and count as you want to establish*/
 	exynos_dp_set_link_bandwidth(dp, dp->link_train.link_rate);
@@ -286,8 +287,10 @@ static void exynos_dp_link_start(struct exynos_dp_device *dp)
 	/* Setup RX configuration */
 	buf[0] = dp->link_train.link_rate;
 	buf[1] = dp->link_train.lane_count;
-	exynos_dp_write_bytes_to_dpcd(dp, DPCD_ADDR_LINK_BW_SET,
+	retval = exynos_dp_write_bytes_to_dpcd(dp, DPCD_ADDR_LINK_BW_SET,
 				2, buf);
+	if (retval)
+		return retval;
 
 	/* Set TX pre-emphasis to minimum */
 	for (lane = 0; lane < lane_count; lane++)
@@ -306,9 +309,11 @@ static void exynos_dp_link_start(struct exynos_dp_device *dp)
 	for (lane = 0; lane < lane_count; lane++)
 		buf[lane] = DPCD_PRE_EMPHASIS_PATTERN2_LEVEL0 |
 			    DPCD_VOLTAGE_SWING_PATTERN1_LEVEL0;
-	exynos_dp_write_bytes_to_dpcd(dp,
+	retval = exynos_dp_write_bytes_to_dpcd(dp,
 		DPCD_ADDR_TRAINING_LANE0_SET,
 		lane_count, buf);
+
+	return retval;
 }
 
 static unsigned char exynos_dp_get_lane_status(u8 link_status[2], int lane)
@@ -430,8 +435,7 @@ static void exynos_dp_reduce_link_rate(struct exynos_dp_device *dp)
 static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 {
 	u8 link_status[2];
-	int lane;
-	int lane_count;
+	int lane, lane_count, retval;
 
 	u8 adjust_request[2];
 	u8 voltage_swing;
@@ -442,17 +446,22 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 
 	lane_count = dp->link_train.lane_count;
 
-	exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
+	retval =  exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
 				2, link_status);
+	if (retval)
+		return retval;
 
 	if (exynos_dp_clock_recovery_ok(link_status, lane_count) = 0) {
 		/* set training pattern 2 for EQ */
 		exynos_dp_set_training_pattern(dp, TRAINING_PTN2);
 
 		for (lane = 0; lane < lane_count; lane++) {
-			exynos_dp_read_bytes_from_dpcd(dp,
+			retval = exynos_dp_read_bytes_from_dpcd(dp,
 					DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
 					2, adjust_request);
+			if (retval)
+				return retval;
+
 			voltage_swing = exynos_dp_get_adjust_request_voltage(
 							adjust_request, lane);
 			pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis(
@@ -472,15 +481,19 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 				lane);
 		}
 
-		exynos_dp_write_byte_to_dpcd(dp,
+		retval = exynos_dp_write_byte_to_dpcd(dp,
 			DPCD_ADDR_TRAINING_PATTERN_SET,
 			DPCD_SCRAMBLING_DISABLED |
 			DPCD_TRAINING_PATTERN_2);
+		if (retval)
+			return retval;
 
-		exynos_dp_write_bytes_to_dpcd(dp,
+		retval = exynos_dp_write_bytes_to_dpcd(dp,
 			DPCD_ADDR_TRAINING_LANE0_SET,
 			lane_count,
 			dp->link_train.training_lane);
+		if (retval)
+			return retval;
 
 		dev_info(dp->dev, "Link Training Clock Recovery success\n");
 		dp->link_train.lt_state = EQUALIZER_TRAINING;
@@ -488,9 +501,12 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 		for (lane = 0; lane < lane_count; lane++) {
 			training_lane = exynos_dp_get_lane_link_training(
 							dp, lane);
-			exynos_dp_read_bytes_from_dpcd(dp,
+			retval = exynos_dp_read_bytes_from_dpcd(dp,
 					DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
 					2, adjust_request);
+			if (retval)
+				return retval;
+
 			voltage_swing = exynos_dp_get_adjust_request_voltage(
 							adjust_request, lane);
 			pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis(
@@ -527,13 +543,14 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 				dp->link_train.training_lane[lane], lane);
 		}
 
-		exynos_dp_write_bytes_to_dpcd(dp,
-			DPCD_ADDR_TRAINING_LANE0_SET,
-			lane_count,
-			dp->link_train.training_lane);
+		retval = exynos_dp_write_bytes_to_dpcd(dp,
+				DPCD_ADDR_TRAINING_LANE0_SET, lane_count,
+				dp->link_train.training_lane);
+		if (retval)
+			return retval;
 	}
 
-	return 0;
+	return retval;
 
 reduce_link_rate:
 	exynos_dp_reduce_link_rate(dp);
@@ -544,8 +561,7 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
 {
 	u8 link_status[2];
 	u8 link_align[3];
-	int lane;
-	int lane_count;
+	int lane, lane_count, retval;
 	u32 reg;
 
 	u8 adjust_request[2];
@@ -557,8 +573,10 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
 
 	lane_count = dp->link_train.lane_count;
 
-	exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
+	retval = exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
 				2, link_status);
+	if (retval)
+		return retval;
 
 	if (exynos_dp_clock_recovery_ok(link_status, lane_count) = 0) {
 		link_align[0] = link_status[0];
@@ -569,9 +587,12 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
 			&link_align[2]);
 
 		for (lane = 0; lane < lane_count; lane++) {
-			exynos_dp_read_bytes_from_dpcd(dp,
+			retval = exynos_dp_read_bytes_from_dpcd(dp,
 					DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
 					2, adjust_request);
+			if (retval)
+				return retval;
+
 			voltage_swing = exynos_dp_get_adjust_request_voltage(
 							adjust_request, lane);
 			pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis(
@@ -620,10 +641,12 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
 					dp->link_train.training_lane[lane],
 					lane);
 
-			exynos_dp_write_bytes_to_dpcd(dp,
-				DPCD_ADDR_TRAINING_LANE0_SET,
-				lane_count,
-				dp->link_train.training_lane);
+			retval = exynos_dp_write_bytes_to_dpcd(dp,
+					DPCD_ADDR_TRAINING_LANE0_SET,
+					lane_count,
+					dp->link_train.training_lane);
+			if (retval)
+				return retval;
 		}
 	} else {
 		goto reduce_link_rate;
@@ -701,16 +724,17 @@ static void exynos_dp_init_training(struct exynos_dp_device *dp,
 
 static int exynos_dp_sw_link_training(struct exynos_dp_device *dp)
 {
-	int retval = 0;
-	int training_finished = 0;
+	int retval = 0, training_finished = 0;
 
 	dp->link_train.lt_state = START;
 
 	/* Process here */
-	while (!training_finished) {
+	while (!retval && !training_finished) {
 		switch (dp->link_train.lt_state) {
 		case START:
-			exynos_dp_link_start(dp);
+			retval = exynos_dp_link_start(dp);
+			if (retval)
+				dev_err(dp->dev, "LT link start failed!\n");
 			break;
 		case CLOCK_RECOVERY:
 			retval = exynos_dp_process_clock_recovery(dp);
@@ -729,6 +753,8 @@ static int exynos_dp_sw_link_training(struct exynos_dp_device *dp)
 			return -EREMOTEIO;
 		}
 	}
+	if (retval)
+		dev_err(dp->dev, "eDP link training failed (%d)\n", retval);
 
 	return retval;
 }
-- 
1.7.1



From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 01 Nov 2012 10:19:53 +0000
Subject: [PATCH v3 2/8] video: exynos_dp: Clean up SW link training
Message-Id: <011e01cdb81a$6f1378e0$4d3a6aa0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Clean up some of the SW training code to make it more clear and reduce
duplicate code.

[jg1.han@samsung.com: modify the procedure of clock recovery]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |  251 +++++++++++++++------------------
 1 files changed, 117 insertions(+), 134 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 44820f2..13bb10d 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -276,7 +276,7 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
 
 	/* Set sink to D0 (Sink Not Ready) mode. */
 	retval = exynos_dp_write_byte_to_dpcd(dp, DPCD_ADDR_SINK_POWER_STATE,
-				DPCD_SET_POWER_STATE_D0);
+			DPCD_SET_POWER_STATE_D0);
 	if (retval)
 		return retval;
 
@@ -301,17 +301,18 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
 	exynos_dp_set_training_pattern(dp, TRAINING_PTN1);
 
 	/* Set RX training pattern */
-	exynos_dp_write_byte_to_dpcd(dp,
-		DPCD_ADDR_TRAINING_PATTERN_SET,
-		DPCD_SCRAMBLING_DISABLED |
-		DPCD_TRAINING_PATTERN_1);
+	retval = exynos_dp_write_byte_to_dpcd(dp,
+			DPCD_ADDR_TRAINING_PATTERN_SET,
+			DPCD_SCRAMBLING_DISABLED | DPCD_TRAINING_PATTERN_1);
+	if (retval)
+		return retval;
 
 	for (lane = 0; lane < lane_count; lane++)
 		buf[lane] = DPCD_PRE_EMPHASIS_PATTERN2_LEVEL0 |
 			    DPCD_VOLTAGE_SWING_PATTERN1_LEVEL0;
-	retval = exynos_dp_write_bytes_to_dpcd(dp,
-		DPCD_ADDR_TRAINING_LANE0_SET,
-		lane_count, buf);
+
+	retval = exynos_dp_write_bytes_to_dpcd(dp, DPCD_ADDR_TRAINING_LANE0_SET,
+			lane_count, buf);
 
 	return retval;
 }
@@ -337,18 +338,17 @@ static int exynos_dp_clock_recovery_ok(u8 link_status[2], int lane_count)
 	return 0;
 }
 
-static int exynos_dp_channel_eq_ok(u8 link_align[3], int lane_count)
+static int exynos_dp_channel_eq_ok(u8 link_status[2], u8 link_align,
+		int lane_count)
 {
 	int lane;
-	u8 lane_align;
 	u8 lane_status;
 
-	lane_align = link_align[2];
-	if ((lane_align & DPCD_INTERLANE_ALIGN_DONE) = 0)
+	if ((link_align & DPCD_INTERLANE_ALIGN_DONE) = 0)
 		return -EINVAL;
 
 	for (lane = 0; lane < lane_count; lane++) {
-		lane_status = exynos_dp_get_lane_status(link_align, lane);
+		lane_status = exynos_dp_get_lane_status(link_status, lane);
 		lane_status &= DPCD_CHANNEL_EQ_BITS;
 		if (lane_status != DPCD_CHANNEL_EQ_BITS)
 			return -EINVAL;
@@ -432,22 +432,42 @@ static void exynos_dp_reduce_link_rate(struct exynos_dp_device *dp)
 	dp->link_train.lt_state = FAILED;
 }
 
+static void exynos_dp_get_adjust_training_lane(struct exynos_dp_device *dp,
+				u8 adjust_request[2])
+{
+	int lane, lane_count;
+	u8 voltage_swing, pre_emphasis, training_lane;
+
+	lane_count = dp->link_train.lane_count;
+	for (lane = 0; lane < lane_count; lane++) {
+		voltage_swing = exynos_dp_get_adjust_request_voltage(
+						adjust_request, lane);
+		pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis(
+						adjust_request, lane);
+		training_lane = DPCD_VOLTAGE_SWING_SET(voltage_swing) |
+				DPCD_PRE_EMPHASIS_SET(pre_emphasis);
+
+		if (voltage_swing = VOLTAGE_LEVEL_3)
+			training_lane |= DPCD_MAX_SWING_REACHED;
+		if (pre_emphasis = PRE_EMPHASIS_LEVEL_3)
+			training_lane |= DPCD_MAX_PRE_EMPHASIS_REACHED;
+
+		dp->link_train.training_lane[lane] = training_lane;
+	}
+}
+
 static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 {
-	u8 link_status[2];
 	int lane, lane_count, retval;
-
-	u8 adjust_request[2];
-	u8 voltage_swing;
-	u8 pre_emphasis;
-	u8 training_lane;
+	u8 voltage_swing, pre_emphasis, training_lane;
+	u8 link_status[2], adjust_request[2];
 
 	usleep_range(100, 101);
 
 	lane_count = dp->link_train.lane_count;
 
 	retval =  exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
-				2, link_status);
+			2, link_status);
 	if (retval)
 		return retval;
 
@@ -455,43 +475,30 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 		/* set training pattern 2 for EQ */
 		exynos_dp_set_training_pattern(dp, TRAINING_PTN2);
 
-		for (lane = 0; lane < lane_count; lane++) {
-			retval = exynos_dp_read_bytes_from_dpcd(dp,
-					DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
-					2, adjust_request);
-			if (retval)
-				return retval;
-
-			voltage_swing = exynos_dp_get_adjust_request_voltage(
-							adjust_request, lane);
-			pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis(
-							adjust_request, lane);
-			training_lane = DPCD_VOLTAGE_SWING_SET(voltage_swing) |
-					DPCD_PRE_EMPHASIS_SET(pre_emphasis);
-
-			if (voltage_swing = VOLTAGE_LEVEL_3)
-				training_lane |= DPCD_MAX_SWING_REACHED;
-			if (pre_emphasis = PRE_EMPHASIS_LEVEL_3)
-				training_lane |= DPCD_MAX_PRE_EMPHASIS_REACHED;
+		retval = exynos_dp_read_bytes_from_dpcd(dp,
+				DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
+				2, adjust_request);
+		if (retval)
+			return retval;
 
-			dp->link_train.training_lane[lane] = training_lane;
+		exynos_dp_get_adjust_training_lane(dp, adjust_request);
 
+		for (lane = 0; lane < lane_count; lane++) {
 			exynos_dp_set_lane_link_training(dp,
-				dp->link_train.training_lane[lane],
-				lane);
+				dp->link_train.training_lane[lane], lane);
 		}
 
 		retval = exynos_dp_write_byte_to_dpcd(dp,
-			DPCD_ADDR_TRAINING_PATTERN_SET,
-			DPCD_SCRAMBLING_DISABLED |
-			DPCD_TRAINING_PATTERN_2);
+				DPCD_ADDR_TRAINING_PATTERN_SET,
+				DPCD_SCRAMBLING_DISABLED |
+				DPCD_TRAINING_PATTERN_2);
 		if (retval)
 			return retval;
 
 		retval = exynos_dp_write_bytes_to_dpcd(dp,
-			DPCD_ADDR_TRAINING_LANE0_SET,
-			lane_count,
-			dp->link_train.training_lane);
+				DPCD_ADDR_TRAINING_LANE0_SET,
+				lane_count,
+				dp->link_train.training_lane);
 		if (retval)
 			return retval;
 
@@ -501,6 +508,7 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 		for (lane = 0; lane < lane_count; lane++) {
 			training_lane = exynos_dp_get_lane_link_training(
 							dp, lane);
+
 			retval = exynos_dp_read_bytes_from_dpcd(dp,
 					DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
 					2, adjust_request);
@@ -515,18 +523,24 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 			if (voltage_swing = VOLTAGE_LEVEL_3 ||
 			    pre_emphasis = PRE_EMPHASIS_LEVEL_3) {
 				dev_err(dp->dev, "voltage or pre emphasis reached max level\n");
-				goto reduce_link_rate;
+				exynos_dp_reduce_link_rate(dp);
+				return -EIO;
 			}
 
-			if ((DPCD_VOLTAGE_SWING_GET(training_lane) =
-					voltage_swing) &&
-			   (DPCD_PRE_EMPHASIS_GET(training_lane) =
-					pre_emphasis)) {
+			if (DPCD_VOLTAGE_SWING_GET(training_lane) =
+					voltage_swing &&
+			    DPCD_PRE_EMPHASIS_GET(training_lane) =
+					pre_emphasis)
 				dp->link_train.cr_loop[lane]++;
-				if (dp->link_train.cr_loop[lane] = MAX_CR_LOOP) {
-					dev_err(dp->dev, "CR Max loop\n");
-					goto reduce_link_rate;
-				}
+
+			if (dp->link_train.cr_loop[lane] = MAX_CR_LOOP ||
+			    voltage_swing = VOLTAGE_LEVEL_3 ||
+			    pre_emphasis = PRE_EMPHASIS_LEVEL_3) {
+				dev_err(dp->dev, "CR Max reached (%d,%d,%d)\n",
+					dp->link_train.cr_loop[lane],
+					voltage_swing, pre_emphasis);
+				exynos_dp_reduce_link_rate(dp);
+				return -EIO;
 			}
 
 			training_lane = DPCD_VOLTAGE_SWING_SET(voltage_swing) |
@@ -544,30 +558,21 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 		}
 
 		retval = exynos_dp_write_bytes_to_dpcd(dp,
-				DPCD_ADDR_TRAINING_LANE0_SET, lane_count,
+				DPCD_ADDR_TRAINING_LANE0_SET,
+				lane_count,
 				dp->link_train.training_lane);
 		if (retval)
 			return retval;
 	}
 
-	return retval;
-
-reduce_link_rate:
-	exynos_dp_reduce_link_rate(dp);
-	return -EIO;
+	return 0;
 }
 
 static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
 {
-	u8 link_status[2];
-	u8 link_align[3];
 	int lane, lane_count, retval;
 	u32 reg;
-
-	u8 adjust_request[2];
-	u8 voltage_swing;
-	u8 pre_emphasis;
-	u8 training_lane;
+	u8 link_align, link_status[2], adjust_request[2];
 
 	usleep_range(400, 401);
 
@@ -578,85 +583,63 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
 	if (retval)
 		return retval;
 
-	if (exynos_dp_clock_recovery_ok(link_status, lane_count) = 0) {
-		link_align[0] = link_status[0];
-		link_align[1] = link_status[1];
-
-		exynos_dp_read_byte_from_dpcd(dp,
-			DPCD_ADDR_LANE_ALIGN_STATUS_UPDATED,
-			&link_align[2]);
-
-		for (lane = 0; lane < lane_count; lane++) {
-			retval = exynos_dp_read_bytes_from_dpcd(dp,
-					DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
-					2, adjust_request);
-			if (retval)
-				return retval;
+	if (exynos_dp_clock_recovery_ok(link_status, lane_count)) {
+		exynos_dp_reduce_link_rate(dp);
+		return -EIO;
+	}
 
-			voltage_swing = exynos_dp_get_adjust_request_voltage(
-							adjust_request, lane);
-			pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis(
-							adjust_request, lane);
-			training_lane = DPCD_VOLTAGE_SWING_SET(voltage_swing) |
-					DPCD_PRE_EMPHASIS_SET(pre_emphasis);
+	retval = exynos_dp_read_byte_from_dpcd(dp,
+			DPCD_ADDR_LANE_ALIGN_STATUS_UPDATED, &link_align);
+	if (retval)
+		return retval;
 
-			if (voltage_swing = VOLTAGE_LEVEL_3)
-				training_lane |= DPCD_MAX_SWING_REACHED;
-			if (pre_emphasis = PRE_EMPHASIS_LEVEL_3)
-				training_lane |= DPCD_MAX_PRE_EMPHASIS_REACHED;
+	retval = exynos_dp_read_bytes_from_dpcd(dp,
+			DPCD_ADDR_ADJUST_REQUEST_LANE0_1, 2, adjust_request);
+	if (retval)
+		return retval;
 
-			dp->link_train.training_lane[lane] = training_lane;
-		}
+	exynos_dp_get_adjust_training_lane(dp, adjust_request);
 
-		if (exynos_dp_channel_eq_ok(link_align, lane_count) = 0) {
-			/* traing pattern Set to Normal */
-			exynos_dp_training_pattern_dis(dp);
+	if (!exynos_dp_channel_eq_ok(link_status, link_align, lane_count)) {
+		/* traing pattern Set to Normal */
+		exynos_dp_training_pattern_dis(dp);
 
-			dev_info(dp->dev, "Link Training success!\n");
+		dev_info(dp->dev, "Link Training success!\n");
 
-			exynos_dp_get_link_bandwidth(dp, &reg);
-			dp->link_train.link_rate = reg;
-			dev_dbg(dp->dev, "final bandwidth = %.2x\n",
-				dp->link_train.link_rate);
+		exynos_dp_get_link_bandwidth(dp, &reg);
+		dp->link_train.link_rate = reg;
+		dev_dbg(dp->dev, "final bandwidth = %.2x\n",
+			dp->link_train.link_rate);
 
-			exynos_dp_get_lane_count(dp, &reg);
-			dp->link_train.lane_count = reg;
-			dev_dbg(dp->dev, "final lane count = %.2x\n",
-				dp->link_train.lane_count);
+		exynos_dp_get_lane_count(dp, &reg);
+		dp->link_train.lane_count = reg;
+		dev_dbg(dp->dev, "final lane count = %.2x\n",
+			dp->link_train.lane_count);
 
-			/* set enhanced mode if available */
-			exynos_dp_set_enhanced_mode(dp);
-			dp->link_train.lt_state = FINISHED;
-		} else {
-			/* not all locked */
-			dp->link_train.eq_loop++;
+		/* set enhanced mode if available */
+		exynos_dp_set_enhanced_mode(dp);
+		dp->link_train.lt_state = FINISHED;
 
-			if (dp->link_train.eq_loop > MAX_EQ_LOOP) {
-				dev_err(dp->dev, "EQ Max loop\n");
-				goto reduce_link_rate;
-			}
+		return 0;
+	}
 
-			for (lane = 0; lane < lane_count; lane++)
-				exynos_dp_set_lane_link_training(dp,
-					dp->link_train.training_lane[lane],
-					lane);
+	/* not all locked */
+	dp->link_train.eq_loop++;
 
-			retval = exynos_dp_write_bytes_to_dpcd(dp,
-					DPCD_ADDR_TRAINING_LANE0_SET,
-					lane_count,
-					dp->link_train.training_lane);
-			if (retval)
-				return retval;
-		}
-	} else {
-		goto reduce_link_rate;
+	if (dp->link_train.eq_loop > MAX_EQ_LOOP) {
+		dev_err(dp->dev, "EQ Max loop\n");
+		exynos_dp_reduce_link_rate(dp);
+		return -EIO;
 	}
 
-	return 0;
+	for (lane = 0; lane < lane_count; lane++)
+		exynos_dp_set_lane_link_training(dp,
+			dp->link_train.training_lane[lane], lane);
 
-reduce_link_rate:
-	exynos_dp_reduce_link_rate(dp);
-	return -EIO;
+	retval = exynos_dp_write_bytes_to_dpcd(dp, DPCD_ADDR_TRAINING_LANE0_SET,
+			lane_count, dp->link_train.training_lane);
+
+	return retval;
 }
 
 static void exynos_dp_get_max_rx_bandwidth(struct exynos_dp_device *dp,
-- 
1.7.1



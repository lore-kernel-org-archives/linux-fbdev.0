From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 19 Jul 2012 04:52:59 +0000
Subject: [PATCH] video: exynos_dp: adjust voltage swing and pre-emphasis during Link Training
Message-Id: <001101cd656a$5ea25c90$1be715b0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch adds adjustement for voltage swing and pre-emphasis during
Link Training procedure. According to the DP specification, unless all
the LANEx_CR_DONE bits are set, the transmitter must read
the ADJUST_REQUEST_LANEx_x, increase the voltage swing according to
the request, and update the TRAINING_LANEx_SET bytes to match the new
voltage swing setting.

Refer to the DP specification v1.1a, Section 3.5.1.3 Link Training.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |  282 +++++++++++++++++----------------
 drivers/video/exynos/exynos_dp_core.h |    2 +-
 2 files changed, 144 insertions(+), 140 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index c6c016a..9c0140f 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -260,7 +260,7 @@ static void exynos_dp_set_lane_lane_pre_emphasis(struct exynos_dp_device *dp,
 
 static void exynos_dp_link_start(struct exynos_dp_device *dp)
 {
-	u8 buf[5];
+	u8 buf[4];
 	int lane;
 	int lane_count;
 
@@ -295,10 +295,10 @@ static void exynos_dp_link_start(struct exynos_dp_device *dp)
 	exynos_dp_set_training_pattern(dp, TRAINING_PTN1);
 
 	/* Set RX training pattern */
-	buf[0] = DPCD_SCRAMBLING_DISABLED |
-		 DPCD_TRAINING_PATTERN_1;
 	exynos_dp_write_byte_to_dpcd(dp,
-		DPCD_ADDR_TRAINING_PATTERN_SET, buf[0]);
+		DPCD_ADDR_TRAINING_PATTERN_SET,
+		DPCD_SCRAMBLING_DISABLED |
+		DPCD_TRAINING_PATTERN_1);
 
 	for (lane = 0; lane < lane_count; lane++)
 		buf[lane] = DPCD_PRE_EMPHASIS_PATTERN2_LEVEL0 |
@@ -308,7 +308,7 @@ static void exynos_dp_link_start(struct exynos_dp_device *dp)
 		lane_count, buf);
 }
 
-static unsigned char exynos_dp_get_lane_status(u8 link_status[6], int lane)
+static unsigned char exynos_dp_get_lane_status(u8 link_status[2], int lane)
 {
 	int shift = (lane & 1) * 4;
 	u8 link_value = link_status[lane>>1];
@@ -316,7 +316,7 @@ static unsigned char exynos_dp_get_lane_status(u8 link_status[6], int lane)
 	return (link_value >> shift) & 0xf;
 }
 
-static int exynos_dp_clock_recovery_ok(u8 link_status[6], int lane_count)
+static int exynos_dp_clock_recovery_ok(u8 link_status[2], int lane_count)
 {
 	int lane;
 	u8 lane_status;
@@ -329,22 +329,23 @@ static int exynos_dp_clock_recovery_ok(u8 link_status[6], int lane_count)
 	return 0;
 }
 
-static int exynos_dp_channel_eq_ok(u8 link_status[6], int lane_count)
+static int exynos_dp_channel_eq_ok(u8 link_align[3], int lane_count)
 {
 	int lane;
 	u8 lane_align;
 	u8 lane_status;
 
-	lane_align = link_status[2];
+	lane_align = link_align[2];
 	if ((lane_align & DPCD_INTERLANE_ALIGN_DONE) = 0)
 		return -EINVAL;
 
 	for (lane = 0; lane < lane_count; lane++) {
-		lane_status = exynos_dp_get_lane_status(link_status, lane);
+		lane_status = exynos_dp_get_lane_status(link_align, lane);
 		lane_status &= DPCD_CHANNEL_EQ_BITS;
 		if (lane_status != DPCD_CHANNEL_EQ_BITS)
 			return -EINVAL;
 	}
+
 	return 0;
 }
 
@@ -417,69 +418,17 @@ static unsigned int exynos_dp_get_lane_link_training(
 
 static void exynos_dp_reduce_link_rate(struct exynos_dp_device *dp)
 {
-	if (dp->link_train.link_rate = LINK_RATE_2_70GBPS) {
-		/* set to reduced bit rate */
-		dp->link_train.link_rate = LINK_RATE_1_62GBPS;
-		dev_err(dp->dev, "set to bandwidth %.2x\n",
-			dp->link_train.link_rate);
-		dp->link_train.lt_state = START;
-	} else {
-		exynos_dp_training_pattern_dis(dp);
-		/* set enhanced mode if available */
-		exynos_dp_set_enhanced_mode(dp);
-		dp->link_train.lt_state = FAILED;
-	}
-}
-
-static void exynos_dp_get_adjust_train(struct exynos_dp_device *dp,
-				u8 adjust_request[2])
-{
-	int lane;
-	int lane_count;
-	u8 voltage_swing;
-	u8 pre_emphasis;
-	u8 training_lane;
+	exynos_dp_training_pattern_dis(dp);
+	exynos_dp_set_enhanced_mode(dp);
 
-	lane_count = dp->link_train.lane_count;
-	for (lane = 0; lane < lane_count; lane++) {
-		voltage_swing = exynos_dp_get_adjust_request_voltage(
-						adjust_request, lane);
-		pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis(
-						adjust_request, lane);
-		training_lane = DPCD_VOLTAGE_SWING_SET(voltage_swing) |
-				DPCD_PRE_EMPHASIS_SET(pre_emphasis);
-
-		if (voltage_swing = VOLTAGE_LEVEL_3 ||
-		   pre_emphasis = PRE_EMPHASIS_LEVEL_3) {
-			training_lane |= DPCD_MAX_SWING_REACHED;
-			training_lane |= DPCD_MAX_PRE_EMPHASIS_REACHED;
-		}
-		dp->link_train.training_lane[lane] = training_lane;
-	}
-}
-
-static int exynos_dp_check_max_cr_loop(struct exynos_dp_device *dp,
-					u8 voltage_swing)
-{
-	int lane;
-	int lane_count;
-
-	lane_count = dp->link_train.lane_count;
-	for (lane = 0; lane < lane_count; lane++) {
-		if (voltage_swing = VOLTAGE_LEVEL_3 ||
-			dp->link_train.cr_loop[lane] = MAX_CR_LOOP)
-			return -EINVAL;
-	}
-	return 0;
+	dp->link_train.lt_state = FAILED;
 }
 
 static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 {
-	u8 data;
-	u8 link_status[6];
+	u8 link_status[2];
 	int lane;
 	int lane_count;
-	u8 buf[5];
 
 	u8 adjust_request[2];
 	u8 voltage_swing;
@@ -488,98 +437,152 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 
 	usleep_range(100, 101);
 
-	exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
-				6, link_status);
 	lane_count = dp->link_train.lane_count;
 
+	exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
+				2, link_status);
+
 	if (exynos_dp_clock_recovery_ok(link_status, lane_count) = 0) {
 		/* set training pattern 2 for EQ */
 		exynos_dp_set_training_pattern(dp, TRAINING_PTN2);
 
-		adjust_request[0] = link_status[4];
-		adjust_request[1] = link_status[5];
+		for (lane = 0; lane < lane_count; lane++) {
+			exynos_dp_read_bytes_from_dpcd(dp,
+					DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
+					2, adjust_request);
+			voltage_swing = exynos_dp_get_adjust_request_voltage(
+							adjust_request, lane);
+			pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis(
+							adjust_request, lane);
+			training_lane = DPCD_VOLTAGE_SWING_SET(voltage_swing) |
+					DPCD_PRE_EMPHASIS_SET(pre_emphasis);
 
-		exynos_dp_get_adjust_train(dp, adjust_request);
+			if (voltage_swing = VOLTAGE_LEVEL_3)
+				training_lane |= DPCD_MAX_SWING_REACHED;
+			if (pre_emphasis = PRE_EMPHASIS_LEVEL_3)
+				training_lane |= DPCD_MAX_PRE_EMPHASIS_REACHED;
 
-		buf[0] = DPCD_SCRAMBLING_DISABLED |
-			 DPCD_TRAINING_PATTERN_2;
-		exynos_dp_write_byte_to_dpcd(dp,
-			DPCD_ADDR_TRAINING_PATTERN_SET,
-			buf[0]);
+			dp->link_train.training_lane[lane] = training_lane;
 
-		for (lane = 0; lane < lane_count; lane++) {
 			exynos_dp_set_lane_link_training(dp,
 				dp->link_train.training_lane[lane],
 				lane);
-			buf[lane] = dp->link_train.training_lane[lane];
-			exynos_dp_write_byte_to_dpcd(dp,
-				DPCD_ADDR_TRAINING_LANE0_SET + lane,
-				buf[lane]);
 		}
-		dp->link_train.lt_state = EQUALIZER_TRAINING;
-	} else {
-		exynos_dp_read_byte_from_dpcd(dp,
-			DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
-			&data);
-		adjust_request[0] = data;
 
-		exynos_dp_read_byte_from_dpcd(dp,
-			DPCD_ADDR_ADJUST_REQUEST_LANE2_3,
-			&data);
-		adjust_request[1] = data;
+		exynos_dp_write_byte_to_dpcd(dp,
+			DPCD_ADDR_TRAINING_PATTERN_SET,
+			DPCD_SCRAMBLING_DISABLED |
+			DPCD_TRAINING_PATTERN_2);
+
+		exynos_dp_write_bytes_to_dpcd(dp,
+			DPCD_ADDR_TRAINING_LANE0_SET,
+			lane_count,
+			dp->link_train.training_lane);
 
+		dev_info(dp->dev, "Link Training Clock Recovery success\n");
+		dp->link_train.lt_state = EQUALIZER_TRAINING;
+	} else {
 		for (lane = 0; lane < lane_count; lane++) {
 			training_lane = exynos_dp_get_lane_link_training(
 							dp, lane);
+			exynos_dp_read_bytes_from_dpcd(dp,
+					DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
+					2, adjust_request);
 			voltage_swing = exynos_dp_get_adjust_request_voltage(
 							adjust_request, lane);
 			pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis(
 							adjust_request, lane);
-			if ((DPCD_VOLTAGE_SWING_GET(training_lane) = voltage_swing) &&
-			    (DPCD_PRE_EMPHASIS_GET(training_lane) = pre_emphasis))
-				dp->link_train.cr_loop[lane]++;
-			dp->link_train.training_lane[lane] = training_lane;
-		}
 
-		if (exynos_dp_check_max_cr_loop(dp, voltage_swing) != 0) {
-			exynos_dp_reduce_link_rate(dp);
-		} else {
-			exynos_dp_get_adjust_train(dp, adjust_request);
+			if (voltage_swing = VOLTAGE_LEVEL_3 ||
+			    pre_emphasis = PRE_EMPHASIS_LEVEL_3) {
+				dev_err(dp->dev, "voltage or pre emphasis reached max level\n");
+				goto reduce_link_rate;
+			}
 
-			for (lane = 0; lane < lane_count; lane++) {
-				exynos_dp_set_lane_link_training(dp,
-					dp->link_train.training_lane[lane],
-					lane);
-				buf[lane] = dp->link_train.training_lane[lane];
-				exynos_dp_write_byte_to_dpcd(dp,
-					DPCD_ADDR_TRAINING_LANE0_SET + lane,
-					buf[lane]);
+			if ((DPCD_VOLTAGE_SWING_GET(training_lane) =
+					voltage_swing) &&
+			   (DPCD_PRE_EMPHASIS_GET(training_lane) =
+					pre_emphasis)) {
+				dp->link_train.cr_loop[lane]++;
+				if (dp->link_train.cr_loop[lane] = MAX_CR_LOOP) {
+					dev_err(dp->dev, "CR Max loop\n");
+					goto reduce_link_rate;
+				}
 			}
+
+			training_lane = DPCD_VOLTAGE_SWING_SET(voltage_swing) |
+					DPCD_PRE_EMPHASIS_SET(pre_emphasis);
+
+			if (voltage_swing = VOLTAGE_LEVEL_3)
+				training_lane |= DPCD_MAX_SWING_REACHED;
+			if (pre_emphasis = PRE_EMPHASIS_LEVEL_3)
+				training_lane |= DPCD_MAX_PRE_EMPHASIS_REACHED;
+
+			dp->link_train.training_lane[lane] = training_lane;
+
+			exynos_dp_set_lane_link_training(dp,
+				dp->link_train.training_lane[lane], lane);
 		}
+
+		exynos_dp_write_bytes_to_dpcd(dp,
+			DPCD_ADDR_TRAINING_LANE0_SET,
+			lane_count,
+			dp->link_train.training_lane);
 	}
 
 	return 0;
+
+reduce_link_rate:
+	exynos_dp_reduce_link_rate(dp);
+	return -EIO;
 }
 
 static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
 {
-	u8 link_status[6];
+	u8 link_status[2];
+	u8 link_align[3];
 	int lane;
 	int lane_count;
-	u8 buf[5];
 	u32 reg;
 
 	u8 adjust_request[2];
+	u8 voltage_swing;
+	u8 pre_emphasis;
+	u8 training_lane;
 
 	usleep_range(400, 401);
 
-	exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
-				6, link_status);
 	lane_count = dp->link_train.lane_count;
 
+	exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_LANE0_1_STATUS,
+				2, link_status);
+
 	if (exynos_dp_clock_recovery_ok(link_status, lane_count) = 0) {
-		adjust_request[0] = link_status[4];
-		adjust_request[1] = link_status[5];
+		link_align[0] = link_status[0];
+		link_align[1] = link_status[1];
+
+		exynos_dp_read_byte_from_dpcd(dp,
+			DPCD_ADDR_LANE_ALIGN_STATUS_UPDATED,
+			&link_align[2]);
+
+		for (lane = 0; lane < lane_count; lane++) {
+			exynos_dp_read_bytes_from_dpcd(dp,
+					DPCD_ADDR_ADJUST_REQUEST_LANE0_1,
+					2, adjust_request);
+			voltage_swing = exynos_dp_get_adjust_request_voltage(
+							adjust_request, lane);
+			pre_emphasis = exynos_dp_get_adjust_request_pre_emphasis(
+							adjust_request, lane);
+			training_lane = DPCD_VOLTAGE_SWING_SET(voltage_swing) |
+					DPCD_PRE_EMPHASIS_SET(pre_emphasis);
+
+			if (voltage_swing = VOLTAGE_LEVEL_3)
+				training_lane |= DPCD_MAX_SWING_REACHED;
+			if (pre_emphasis = PRE_EMPHASIS_LEVEL_3)
+				training_lane |= DPCD_MAX_PRE_EMPHASIS_REACHED;
+
+			dp->link_train.training_lane[lane] = training_lane;
+		}
 
 		if (exynos_dp_channel_eq_ok(link_status, lane_count) = 0) {
 			/* traing pattern Set to Normal */
@@ -596,39 +599,42 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
 			dp->link_train.lane_count = reg;
 			dev_dbg(dp->dev, "final lane count = %.2x\n",
 				dp->link_train.lane_count);
+
 			/* set enhanced mode if available */
 			exynos_dp_set_enhanced_mode(dp);
-
 			dp->link_train.lt_state = FINISHED;
 		} else {
 			/* not all locked */
 			dp->link_train.eq_loop++;
 
 			if (dp->link_train.eq_loop > MAX_EQ_LOOP) {
-				exynos_dp_reduce_link_rate(dp);
-			} else {
-				exynos_dp_get_adjust_train(dp, adjust_request);
-
-				for (lane = 0; lane < lane_count; lane++) {
-					exynos_dp_set_lane_link_training(dp,
-						dp->link_train.training_lane[lane],
-						lane);
-					buf[lane] = dp->link_train.training_lane[lane];
-					exynos_dp_write_byte_to_dpcd(dp,
-						DPCD_ADDR_TRAINING_LANE0_SET + lane,
-						buf[lane]);
-				}
+				dev_err(dp->dev, "EQ Max loop\n");
+				goto reduce_link_rate;
 			}
+
+			for (lane = 0; lane < lane_count; lane++)
+				exynos_dp_set_lane_link_training(dp,
+					dp->link_train.training_lane[lane],
+					lane);
+
+			exynos_dp_write_bytes_to_dpcd(dp,
+				DPCD_ADDR_TRAINING_LANE0_SET,
+				lane_count,
+				dp->link_train.training_lane);
 		}
 	} else {
-		exynos_dp_reduce_link_rate(dp);
+		goto reduce_link_rate;
 	}
 
 	return 0;
+
+reduce_link_rate:
+	exynos_dp_reduce_link_rate(dp);
+	return -EIO;
 }
 
 static void exynos_dp_get_max_rx_bandwidth(struct exynos_dp_device *dp,
-			u8 *bandwidth)
+					u8 *bandwidth)
 {
 	u8 data;
 
@@ -641,7 +647,7 @@ static void exynos_dp_get_max_rx_bandwidth(struct exynos_dp_device *dp,
 }
 
 static void exynos_dp_get_max_rx_lane_count(struct exynos_dp_device *dp,
-			u8 *lane_count)
+					u8 *lane_count)
 {
 	u8 data;
 
@@ -693,13 +699,7 @@ static void exynos_dp_init_training(struct exynos_dp_device *dp,
 static int exynos_dp_sw_link_training(struct exynos_dp_device *dp)
 {
 	int retval = 0;
-	int training_finished;
-
-	/* Turn off unnecessary lane */
-	if (dp->link_train.lane_count = 1)
-		exynos_dp_set_analog_power_down(dp, CH1_BLOCK, 1);
-
-	training_finished = 0;
+	int training_finished = 0;
 
 	dp->link_train.lt_state = START;
 
@@ -710,10 +710,14 @@ static int exynos_dp_sw_link_training(struct exynos_dp_device *dp)
 			exynos_dp_link_start(dp);
 			break;
 		case CLOCK_RECOVERY:
-			exynos_dp_process_clock_recovery(dp);
+			retval = exynos_dp_process_clock_recovery(dp);
+			if (retval)
+				dev_err(dp->dev, "LT CR failed!\n");
 			break;
 		case EQUALIZER_TRAINING:
-			exynos_dp_process_equalizer_training(dp);
+			retval = exynos_dp_process_equalizer_training(dp);
+			if (retval)
+				dev_err(dp->dev, "LT EQ failed!\n");
 			break;
 		case FINISHED:
 			training_finished = 1;
diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
index 8526e54..44c11e1 100644
--- a/drivers/video/exynos/exynos_dp_core.h
+++ b/drivers/video/exynos/exynos_dp_core.h
@@ -144,7 +144,7 @@ void exynos_dp_disable_scrambling(struct exynos_dp_device *dp);
 #define DPCD_ADDR_TRAINING_PATTERN_SET		0x0102
 #define DPCD_ADDR_TRAINING_LANE0_SET		0x0103
 #define DPCD_ADDR_LANE0_1_STATUS		0x0202
-#define DPCD_ADDR_LANE_ALIGN__STATUS_UPDATED	0x0204
+#define DPCD_ADDR_LANE_ALIGN_STATUS_UPDATED	0x0204
 #define DPCD_ADDR_ADJUST_REQUEST_LANE0_1	0x0206
 #define DPCD_ADDR_ADJUST_REQUEST_LANE2_3	0x0207
 #define DPCD_ADDR_TEST_REQUEST			0x0218
-- 
1.7.1



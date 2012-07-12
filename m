From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Jul 2012 06:10:03 +0000
Subject: [PATCH] video: exynos_dp: fix wrong DPCD address during Link Training
Message-Id: <000901cd5ff4$fa2ffbc0$ee8ff340$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Wrong DPCD addresses were used for clock recovery during Link Training.
The training pattern should be set by TRAINING_PATTERN_SET (0x102), while
voltage swing and pre-emphasis should be set by TRAINING_LANE0_SET (0x103).

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 9db7b9f..bf55e51 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -304,7 +304,7 @@ static void exynos_dp_link_start(struct exynos_dp_device *dp)
 		buf[lane] = DPCD_PRE_EMPHASIS_PATTERN2_LEVEL0 |
 			    DPCD_VOLTAGE_SWING_PATTERN1_LEVEL0;
 	exynos_dp_write_bytes_to_dpcd(dp,
-		DPCD_ADDR_TRAINING_PATTERN_SET,
+		DPCD_ADDR_TRAINING_LANE0_SET,
 		lane_count, buf);
 }
 
@@ -504,7 +504,7 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 		buf[0] = DPCD_SCRAMBLING_DISABLED |
 			 DPCD_TRAINING_PATTERN_2;
 		exynos_dp_write_byte_to_dpcd(dp,
-			DPCD_ADDR_TRAINING_LANE0_SET,
+			DPCD_ADDR_TRAINING_PATTERN_SET,
 			buf[0]);
 
 		for (lane = 0; lane < lane_count; lane++) {
-- 
1.7.1



From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 01 Nov 2012 10:30:54 +0000
Subject: [PATCH v3 4/8] video: exynos_dp: Improve EDID error handling
Message-Id: <012701cdb81b$f919fc70$eb4df550$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <012001cdb81a$b87fb4d0$297f1e70$%han@samsung.com>
In-Reply-To: <012001cdb81a$b87fb4d0$297f1e70$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

EDID error handling has 2 problems:
 - It doesn't fail as early as it can
 - The retry counts for i2c and aux transactions are huge

This patch fails if the initial i2c transaction fails, and reduces the
aux and i2c retry counts down to 3.

[jg1.han@samsung.com: reduced the retry count of exynos_dp_read_byte_from_dpcd()]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Added 'From: Sean Paul <seanpaul@chromium.org>'

 drivers/video/exynos/exynos_dp_core.c |   13 ++++++++-----
 drivers/video/exynos/exynos_dp_reg.c  |   11 +++++------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 878b4b6..ee957e0 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -90,9 +90,11 @@ static int exynos_dp_read_edid(struct exynos_dp_device *dp)
 	 */
 
 	/* Read Extension Flag, Number of 128-byte EDID extension blocks */
-	exynos_dp_read_byte_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
+	retval = exynos_dp_read_byte_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
 				EDID_EXTENSION_FLAG,
 				&extend_block);
+	if (retval)
+		return retval;
 
 	if (extend_block > 0) {
 		dev_dbg(dp->dev, "EDID data includes a single extension!\n");
@@ -181,14 +183,15 @@ static int exynos_dp_handle_edid(struct exynos_dp_device *dp)
 	int retval;
 
 	/* Read DPCD DPCD_ADDR_DPCD_REV~RECEIVE_PORT1_CAP_1 */
-	exynos_dp_read_bytes_from_dpcd(dp,
-		DPCD_ADDR_DPCD_REV,
-		12, buf);
+	retval = exynos_dp_read_bytes_from_dpcd(dp, DPCD_ADDR_DPCD_REV,
+				12, buf);
+	if (retval)
+		return retval;
 
 	/* Read EDID */
 	for (i = 0; i < 3; i++) {
 		retval = exynos_dp_read_edid(dp);
-		if (retval = 0)
+		if (!retval)
 			break;
 	}
 
diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
index 3f5ca8a..dc09278 100644
--- a/drivers/video/exynos/exynos_dp_reg.c
+++ b/drivers/video/exynos/exynos_dp_reg.c
@@ -491,7 +491,7 @@ int exynos_dp_read_byte_from_dpcd(struct exynos_dp_device *dp,
 	int i;
 	int retval;
 
-	for (i = 0; i < 10; i++) {
+	for (i = 0; i < 3; i++) {
 		/* Clear AUX CH data buffer */
 		reg = BUF_CLR;
 		writel(reg, dp->reg_base + EXYNOS_DP_BUFFER_DATA_CTL);
@@ -552,7 +552,7 @@ int exynos_dp_write_bytes_to_dpcd(struct exynos_dp_device *dp,
 		else
 			cur_data_count = count - start_offset;
 
-		for (i = 0; i < 10; i++) {
+		for (i = 0; i < 3; i++) {
 			/* Select DPCD device address */
 			reg = AUX_ADDR_7_0(reg_addr + start_offset);
 			writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_7_0);
@@ -617,7 +617,7 @@ int exynos_dp_read_bytes_from_dpcd(struct exynos_dp_device *dp,
 			cur_data_count = count - start_offset;
 
 		/* AUX CH Request Transaction process */
-		for (i = 0; i < 10; i++) {
+		for (i = 0; i < 3; i++) {
 			/* Select DPCD device address */
 			reg = AUX_ADDR_7_0(reg_addr + start_offset);
 			writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_7_0);
@@ -700,7 +700,7 @@ int exynos_dp_read_byte_from_i2c(struct exynos_dp_device *dp,
 	int i;
 	int retval;
 
-	for (i = 0; i < 10; i++) {
+	for (i = 0; i < 3; i++) {
 		/* Clear AUX CH data buffer */
 		reg = BUF_CLR;
 		writel(reg, dp->reg_base + EXYNOS_DP_BUFFER_DATA_CTL);
@@ -708,7 +708,6 @@ int exynos_dp_read_byte_from_i2c(struct exynos_dp_device *dp,
 		/* Select EDID device */
 		retval = exynos_dp_select_i2c_device(dp, device_addr, reg_addr);
 		if (retval != 0) {
-			dev_err(dp->dev, "Select EDID device fail!\n");
 			continue;
 		}
 
@@ -750,7 +749,7 @@ int exynos_dp_read_bytes_from_i2c(struct exynos_dp_device *dp,
 	int retval = 0;
 
 	for (i = 0; i < count; i += 16) {
-		for (j = 0; j < 100; j++) {
+		for (j = 0; j < 3; j++) {
 			/* Clear AUX CH data buffer */
 			reg = BUF_CLR;
 			writel(reg, dp->reg_base + EXYNOS_DP_BUFFER_DATA_CTL);
-- 
1.7.1



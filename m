From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Jul 2012 08:44:13 +0000
Subject: [PATCH] video: exynos_dp: check the only INTERLANE_ALIGN_DONE bit during Link Training
Message-Id: <000c01cd63f8$57550000$05ff0000$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The only INTERLANE_ALIGN_DONE bit should be checked for channel equalization
during Link Training. Previously, the other bits such as LINK_STATUS_UPDATED
were checked, and channel equalization procedure was repeated unnecessarily.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 9db7b9f..6ca8043 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -336,7 +336,7 @@ static int exynos_dp_channel_eq_ok(u8 link_status[6], int lane_count)
 	u8 lane_status;
 
 	lane_align = link_status[2];
-	if ((lane_align = DPCD_INTERLANE_ALIGN_DONE) = 0)
+	if ((lane_align & DPCD_INTERLANE_ALIGN_DONE) = 0)
 		return -EINVAL;
 
 	for (lane = 0; lane < lane_count; lane++) {
-- 
1.7.1



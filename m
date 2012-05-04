From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 04 May 2012 01:49:46 +0000
Subject: [PATCH] video: exynos_dp: fix max loop count in EQ sequence of link training
Message-Id: <003201cd2998$2ee3eef0$8cabccd0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes max loop count in EQ(Channel Equalization) sequence
of link training. According to DP(displayport) specification,
the max loop count in this sequence should be 5.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/video/exynos_dp.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/video/exynos_dp.h b/include/video/exynos_dp.h
index 8847a9d..bd8cabd 100644
--- a/include/video/exynos_dp.h
+++ b/include/video/exynos_dp.h
@@ -14,7 +14,7 @@
 
 #define DP_TIMEOUT_LOOP_COUNT 100
 #define MAX_CR_LOOP 5
-#define MAX_EQ_LOOP 4
+#define MAX_EQ_LOOP 5
 
 enum link_rate_type {
 	LINK_RATE_1_62GBPS = 0x06,
-- 
1.7.1



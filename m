From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 25 May 2012 07:21:38 +0000
Subject: [PATCH 3/3] video: exynos_dp: reduce delay time when configuring video setting
Message-Id: <001f01cd3a47$060e4560$122ad020$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch reduces delay time when configuring video setting,
which is helpful to reduce wakeup time during resume.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index b446f7e..a36b2d2 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -770,7 +770,7 @@ static int exynos_dp_config_video(struct exynos_dp_device *dp,
 			return -ETIMEDOUT;
 		}
 
-		mdelay(100);
+		udelay(1);
 	}
 
 	/* Set to use the register calculated M/N video */
@@ -804,7 +804,7 @@ static int exynos_dp_config_video(struct exynos_dp_device *dp,
 			return -ETIMEDOUT;
 		}
 
-		mdelay(100);
+		mdelay(1);
 	}
 
 	if (retval != 0)
-- 
1.7.1



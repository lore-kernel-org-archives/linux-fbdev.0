From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 19 Jun 2012 06:36:25 +0000
Subject: [PATCH] video: exynos_dp: fix build warning due to uninitialized value
Message-Id: <001501cd4de5$d955a290$8c00e7b0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Olof Johansson' <olof@lixom.net>, 'Jingoo Han' <jg1.han@samsung.com>

This patch fixes build warning due to uninitialized value dereference.

drivers/video/exynos/exynos_dp_core.c: In function 'exynos_dp_set_link_train':
drivers/video/exynos/exynos_dp_core.c:529:18: warning: 'reg' may be used uninitialized in this function [-Wuninitialized]
drivers/video/exynos/exynos_dp_core.c:395:6: note: 'reg' was declared here

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index a36b2d2..9b2cdff 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -407,6 +407,8 @@ static unsigned int exynos_dp_get_lane_link_training(
 	case 3:
 		reg = exynos_dp_get_lane3_link_training(dp);
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	return reg;
-- 
1.7.1



From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 20 Jun 2012 01:25:48 +0000
Subject: [PATCH v2] video: exynos_dp: fix build warning due to uninitialized value
Message-Id: <000301cd4e83$9f5fcb30$de1f6190$%han@samsung.com>
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
 drivers/video/exynos/exynos_dp_core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index a36b2d2..9db7b9f 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -407,6 +407,9 @@ static unsigned int exynos_dp_get_lane_link_training(
 	case 3:
 		reg = exynos_dp_get_lane3_link_training(dp);
 		break;
+	default:
+		WARN_ON(1);
+		return 0;
 	}
 
 	return reg;
-- 
1.7.1



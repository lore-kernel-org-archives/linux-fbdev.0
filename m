From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 06 Feb 2012 02:30:39 +0000
Subject: [PATCH] MAINTAINERS: add maintainer entry for Exynos DP driver
Message-Id: <001501cce477$50eaad60$f2c00820$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add maintainer entry for Exynos DP driver which can be used for
Samsung Exynos SoC series.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ebb1936..f685bfd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2639,6 +2639,12 @@ M:	Mimi Zohar <zohar@us.ibm.com>
 S:	Supported
 F:	security/integrity/evm/
 
+EXYNOS DP DRIVER
+M:	Jingoo Han <jg1.han@samsung.com>
+L:	linux-fbdev@vger.kernel.org
+S:	Maintained
+F:	drivers/video/exynos/exynos_dp*
+
 F71805F HARDWARE MONITORING DRIVER
 M:	Jean Delvare <khali@linux-fr.org>
 L:	lm-sensors@lm-sensors.org
--


From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Tue, 31 Jul 2012 12:35:02 +0000
Subject: [PATCH V2 2/5] include/video: Add Exynos5 specific FIMD register offsets
Message-Id: <1343737385-23337-3-git-send-email-l.krishna@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
In-Reply-To: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, inki.dae@samsung.com, kgene.kim@samsung.com, joshi@samsung.com, jg1.han@samsung.com, m.szyprowski@samsung.com

Exynos5 has VIDTCON and VIDCON registers at different offsets
from the previous SOCs. Hence, adding the macros.

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 include/video/samsung_fimd.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index e979f42..820f190 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -524,3 +524,10 @@
  * 1110		-none-	 -none-	  -none-   -none-    -none-
  * 1111		-none-	 -none-   -none-   -none-    -none-
 */
+
+/*EXYNOS5 FIMD REG OFFSET */
+#define EXYNOS5_VIDTCON0	(0x20010)
+#define EXYNOS5_VIDTCON1	(0x20014)
+#define EXYNOS5_VIDTCON2	(0x20018)
+#define EXYNOS5_VIDTCON3	(0x2001C)
+#define EXYNOS5_VIDCON1		(0x20004)
-- 
1.7.0.4


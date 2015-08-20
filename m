From: yalin wang <yalin.wang2010@gmail.com>
Date: Thu, 20 Aug 2015 06:52:27 +0000
Subject: [RFC] fbdev/nvidia:change reverse_order() macro
Message-Id: <1440053547-24193-1-git-send-email-yalin.wang2010@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yalin wang <yalin.wang2010@gmail.com>

This change reverse_order() to swab32(bitrev32()), so that
it can have better performance on some platforms.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 drivers/video/fbdev/nvidia/nv_accel.c |  4 ++--
 drivers/video/fbdev/nvidia/nv_local.h | 13 ++++---------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_accel.c b/drivers/video/fbdev/nvidia/nv_accel.c
index ad6472a..c21cb34 100644
--- a/drivers/video/fbdev/nvidia/nv_accel.c
+++ b/drivers/video/fbdev/nvidia/nv_accel.c
@@ -382,7 +382,7 @@ static void nvidiafb_mono_color_expand(struct fb_info *info,
 
 		for (j = RECT_EXPAND_TWO_COLOR_DATA_MAX_DWORDS; j--;) {
 			tmp = data[k++];
-			reverse_order(&tmp);
+			tmp = reverse_order(tmp);
 			NVDmaNext(par, tmp);
 		}
 
@@ -394,7 +394,7 @@ static void nvidiafb_mono_color_expand(struct fb_info *info,
 
 		for (j = dsize; j--;) {
 			tmp = data[k++];
-			reverse_order(&tmp);
+			tmp = reverse_order(tmp);
 			NVDmaNext(par, tmp);
 		}
 	}
diff --git a/drivers/video/fbdev/nvidia/nv_local.h b/drivers/video/fbdev/nvidia/nv_local.h
index 68e508d..a0eb1f3 100644
--- a/drivers/video/fbdev/nvidia/nv_local.h
+++ b/drivers/video/fbdev/nvidia/nv_local.h
@@ -97,18 +97,13 @@
 
 #ifdef __LITTLE_ENDIAN
 
+#include <linux/swab.h>
 #include <linux/bitrev.h>
 
-#define reverse_order(l)        \
-do {                            \
-	u8 *a = (u8 *)(l);      \
-	a[0] = bitrev8(a[0]);   \
-	a[1] = bitrev8(a[1]);   \
-	a[2] = bitrev8(a[2]);   \
-	a[3] = bitrev8(a[3]);   \
-} while(0)
+#define reverse_order(v)	swab32(bitrev32(v))
+
 #else
-#define reverse_order(l) do { } while(0)
+#define reverse_order(v)	(v)
 #endif                          /* __LITTLE_ENDIAN */
 
 #endif				/* __NV_LOCAL_H__ */
-- 
1.9.1


From: yalin wang <yalin.wang2010@gmail.com>
Date: Fri, 21 Aug 2015 03:36:59 +0000
Subject: [RFC V2] fbdev/nvidia:change reverse_order() macro
Message-Id: <1440128219-2951-1-git-send-email-yalin.wang2010@gmail.com>
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
 drivers/video/fbdev/nvidia/nv_local.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_local.h b/drivers/video/fbdev/nvidia/nv_local.h
index 68e508d..2c6baa1 100644
--- a/drivers/video/fbdev/nvidia/nv_local.h
+++ b/drivers/video/fbdev/nvidia/nv_local.h
@@ -97,18 +97,19 @@
 
 #ifdef __LITTLE_ENDIAN
 
+#include <linux/swab.h>
 #include <linux/bitrev.h>
+static inline void reverse_order(u32 *data)
+{
+	*data = swab32(bitrev32(*data));
+}
 
-#define reverse_order(l)        \
-do {                            \
-	u8 *a = (u8 *)(l);      \
-	a[0] = bitrev8(a[0]);   \
-	a[1] = bitrev8(a[1]);   \
-	a[2] = bitrev8(a[2]);   \
-	a[3] = bitrev8(a[3]);   \
-} while(0)
 #else
-#define reverse_order(l) do { } while(0)
-#endif                          /* __LITTLE_ENDIAN */
 
+static inline void reverse_order(u32 *data)
+{
+
+}
+
+#endif                          /* __LITTLE_ENDIAN */
 #endif				/* __NV_LOCAL_H__ */
-- 
1.9.1


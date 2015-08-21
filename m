From: yalin wang <yalin.wang2010@gmail.com>
Date: Fri, 21 Aug 2015 05:59:10 +0000
Subject: [RFC V2] fbdev/riva:change to use generice function to implement reverse_order()
Message-Id: <1440136750-30990-1-git-send-email-yalin.wang2010@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yalin wang <yalin.wang2010@gmail.com>

This change to use swab32(bitrev32()) to implement reverse_order()
function, have better performance on some platforms.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 drivers/video/fbdev/riva/fbdev.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index f1ad274..ccf0f82 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -40,6 +40,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/backlight.h>
+#include <linux/swab.h>
 #include <linux/bitrev.h>
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/machdep.h>
@@ -453,11 +454,7 @@ static inline unsigned char MISCin(struct riva_par *par)
 
 static inline void reverse_order(u32 *l)
 {
-	u8 *a = (u8 *)l;
-	a[0] = bitrev8(a[0]);
-	a[1] = bitrev8(a[1]);
-	a[2] = bitrev8(a[2]);
-	a[3] = bitrev8(a[3]);
+	*l = swab32(bitrev32(*l));
 }
 
 /* ------------------------------------------------------------------------- *
-- 
1.9.1


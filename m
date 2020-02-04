From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 04 Feb 2020 16:21:14 +0000
Subject: [PATCH v1] fbdev: simplefb: Platform data shan't include kernel.h
Message-Id: <20200204162114.28937-1-andriy.shevchenko@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Replace with appropriate types.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/platform_data/simplefb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/simplefb.h b/include/linux/platform_data/simplefb.h
index 4f733a411d18..ca8337695c2a 100644
--- a/include/linux/platform_data/simplefb.h
+++ b/include/linux/platform_data/simplefb.h
@@ -10,7 +10,7 @@
 
 #include <drm/drm_fourcc.h>
 #include <linux/fb.h>
-#include <linux/kernel.h>
+#include <linux/types.h>
 
 /* format array, use it to initialize a "struct simplefb_format" array */
 #define SIMPLEFB_FORMATS \
-- 
2.24.1

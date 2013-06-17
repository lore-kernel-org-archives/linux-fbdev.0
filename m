From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Mon, 17 Jun 2013 13:43:09 +0000
Subject: [PATCH] video: of_display_timing.h: Include <video/display_timing.h>
Message-Id: <1371476589-4660-1-git-send-email-fabio.estevam@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Commit ffa3fd21de ("videomode: implement public of_get_display_timing()") causes
the following build warning:

include/video/of_display_timing.h:18:10: warning: 'struct display_timing' declared inside parameter list [enabled by default]
include/video/of_display_timing.h:18:10: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

As 'struct display_timing' is defined at <video/display_timing.h>, let's include
this header to avoid the warning.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 include/video/of_display_timing.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/video/of_display_timing.h b/include/video/of_display_timing.h
index 6562ad9..a136f58 100644
--- a/include/video/of_display_timing.h
+++ b/include/video/of_display_timing.h
@@ -8,6 +8,7 @@
 
 #ifndef __LINUX_OF_DISPLAY_TIMING_H
 #define __LINUX_OF_DISPLAY_TIMING_H
+#include <video/display_timing.h>
 
 struct device_node;
 struct display_timings;
-- 
1.8.1.2



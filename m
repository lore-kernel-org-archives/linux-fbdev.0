From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Wed, 26 Jun 2013 13:34:25 +0000
Subject: [PATCH v2] video: of_display_timing.h: Declare 'display_timing'
Message-Id: <1372253665-23148-1-git-send-email-fabio.estevam@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Commit ffa3fd21de ("videomode: implement public of_get_display_timing()") causes
the following build warning:

include/video/of_display_timing.h:18:10: warning: 'struct display_timing' declared inside parameter list [enabled by default]
include/video/of_display_timing.h:18:10: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

Declare 'display_timing' to avoid the build warning.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Add 'struct display_timing;' instead of '#include <video/display_timing.h>'
 include/video/of_display_timing.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/video/of_display_timing.h b/include/video/of_display_timing.h
index 6562ad9..79e6697 100644
--- a/include/video/of_display_timing.h
+++ b/include/video/of_display_timing.h
@@ -10,6 +10,7 @@
 #define __LINUX_OF_DISPLAY_TIMING_H
 
 struct device_node;
+struct display_timing;
 struct display_timings;
 
 #define OF_USE_NATIVE_MODE -1
-- 
1.8.1.2



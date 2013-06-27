From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@freescale.com>
Date: Thu, 27 Jun 2013 12:34:57 +0000
Subject: [PATCH linux-next] videomode: fix compilation warning
Message-Id: <1372336497-2005-1-git-send-email-vincent.stehle@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-next@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@freescale.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, trivial@kernel.org

Add missing include file to fix the following compilation warning:

  In file included from drivers/video/wm8505fb.c:35:0:
  include/video/of_display_timing.h:18:10: warning: ‘struct display_timing’ declared inside parameter list [enabled by default]
  include/video/of_display_timing.h:18:10: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

Signed-off-by: Vincent Stehlé <vincent.stehle@freescale.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: trivial@kernel.org
---


Hi,

This warning happens on linux-next tag next-20130627, for ARM multi_v7_defconfig.

Best regards,

V.


 include/video/of_display_timing.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/video/of_display_timing.h b/include/video/of_display_timing.h
index 6562ad9..d43be98 100644
--- a/include/video/of_display_timing.h
+++ b/include/video/of_display_timing.h
@@ -9,6 +9,8 @@
 #ifndef __LINUX_OF_DISPLAY_TIMING_H
 #define __LINUX_OF_DISPLAY_TIMING_H
 
+#include <video/display_timing.h>
+
 struct device_node;
 struct display_timings;
 
-- 
1.7.10.4




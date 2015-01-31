From: Kevin Hao <haokexin@gmail.com>
Date: Sat, 31 Jan 2015 13:47:38 +0000
Subject: [PATCH 08/15] fbdev: remove the unnecessary includes of ppc specific header files
Message-Id: <1422712065-9403-9-git-send-email-haokexin@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

In the current kernel, we don't need to include these arch specific
header files for ppc.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/video/fbdev/core/fbmon.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 95338593ebf4..3ae868c58cef 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -33,10 +33,6 @@
 #include <video/edid.h>
 #include <video/of_videomode.h>
 #include <video/videomode.h>
-#ifdef CONFIG_PPC_OF
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#endif
 #include "../edid.h"
 
 /*
-- 
1.9.3


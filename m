From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 26 Feb 2015 12:08:19 +0000
Subject: [PATCH v2 07/11] fbdev: remove the unnecessary includes of ppc specific header files
Message-Id: <1424952503-8247-8-git-send-email-haokexin@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
In-Reply-To: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linuxppc-dev@lists.ozlabs.org

In the current kernel, we don't need to include these arch specific
header files for ppc.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: No change.

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


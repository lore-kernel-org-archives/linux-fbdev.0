From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Mar 2020 13:45:05 +0000
Subject: [PATCH v2 3/6] video: fbdev: controlfb: remove obsolete module support
Message-Id: <20200324134508.25120-4-b.zolnierkie@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200324134508.25120-1-b.zolnierkie@samsung.com>
 <CGME20200324134519eucas1p2d606db263a636433bf1545c836bed138@eucas1p2.samsung.com>
In-Reply-To: <20200324134508.25120-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Sam Ravnborg <sam@ravnborg.org>, b.zolnierkie@samsung.com

CONFIG_FB_CONTROL is bool, hence the Apple "control" frame buffer
driver cannot be built as a module.

Replace module_init() by device_initcall().

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/controlfb.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index b347bc78bc4a..92cffd2d0219 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -31,7 +31,6 @@
  *  more details.
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -198,28 +197,6 @@ static const struct fb_ops controlfb_ops = {
 
 /********************  The functions for controlfb_ops ********************/
 
-#ifdef MODULE
-MODULE_LICENSE("GPL");
-
-int init_module(void)
-{
-	struct device_node *dp;
-	int ret = -ENXIO;
-
-	dp = of_find_node_by_name(NULL, "control");
-	if (dp && !control_of_init(dp))
-		ret = 0;
-	of_node_put(dp);
-
-	return ret;
-}
-
-void cleanup_module(void)
-{
-	control_cleanup();
-}
-#endif
-
 /*
  * Checks a var structure
  */
@@ -612,7 +589,7 @@ static int __init control_init(void)
 	return ret;
 }
 
-module_init(control_init);
+device_initcall(control_init);
 
 /* Work out which banks of VRAM we have installed. */
 /* danj: I guess the card just ignores writes to nonexistant VRAM... */
-- 
2.24.1

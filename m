From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Jan 2018 16:36:32 +0000
Subject: [PATCH] video: fbdev/mmp: add MODULE_LICENSE
Message-Id: <20180110163709.642189-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org

Kbuild complains about the lack of a license tag in this driver:

WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/mmp/mmp_disp.o

This adds the license, author and description tags.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/mmp/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/mmp/core.c b/drivers/video/fbdev/mmp/core.c
index a0f496049db7..3a6bb6561ba0 100644
--- a/drivers/video/fbdev/mmp/core.c
+++ b/drivers/video/fbdev/mmp/core.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
+#include <linux/module.h>
 #include <video/mmp_disp.h>
 
 static struct mmp_overlay *path_get_overlay(struct mmp_path *path,
@@ -249,3 +250,7 @@ void mmp_unregister_path(struct mmp_path *path)
 	mutex_unlock(&disp_lock);
 }
 EXPORT_SYMBOL_GPL(mmp_unregister_path);
+
+MODULE_AUTHOR("Zhou Zhu <zzhu3@marvell.com>");
+MODULE_DESCRIPTION("Marvell MMP display framework");
+MODULE_LICENSE("GPL");
-- 
2.9.0


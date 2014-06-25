From: Jiri Slaby <jslaby@suse.cz>
Date: Wed, 25 Jun 2014 14:01:47 +0000
Subject: [patch added to the 3.12 stable tree] drivers/video/fbdev/fb-puv3.c: Add header files for function u
Message-Id: <1403704907-18427-30-git-send-email-jslaby@suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Zhichuang SUN <sunzc522@gmail.com>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

=======
commit fbc6c4a13bbfb420eedfdb26a0a859f9c07e8a7b upstream.

Function unifb_mmap calls functions which are defined in linux/mm.h
and asm/pgtable.h

The related error (for unicore32 with unicore32_defconfig):
	CC      drivers/video/fbdev/fb-puv3.o
	drivers/video/fbdev/fb-puv3.c: In function 'unifb_mmap':
	drivers/video/fbdev/fb-puv3.c:646: error: implicit declaration of
				      function 'vm_iomap_memory'
	drivers/video/fbdev/fb-puv3.c:646: error: implicit declaration of
				      function 'pgprot_noncached'

Signed-off-by: Zhichuang Sun <sunzc522@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Joe Perches <joe@perches.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org
Acked-by: Xuetao Guan <gxt@mprc.pku.edu.cn>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/video/fb-puv3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fb-puv3.c b/drivers/video/fb-puv3.c
index 27fc956166fa..520112531eb0 100644
--- a/drivers/video/fb-puv3.c
+++ b/drivers/video/fb-puv3.c
@@ -18,8 +18,10 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/mm.h>
 
 #include <asm/sizes.h>
+#include <asm/pgtable.h>
 #include <mach/hardware.h>
 
 /* Platform_data reserved for unifb registers. */
-- 
2.0.0


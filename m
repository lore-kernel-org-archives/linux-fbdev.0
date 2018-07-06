From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 06 Jul 2018 12:35:07 +0000
Subject: [PATCH] omapfb: rename omap2 module to omap2fb.ko
Message-Id: <20180706123528.2729378-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@s-opensource.com>, linux-omap@vger.kernel.org

In a kernel configuration with both CONFIG_FB_OMAP=m and CONFIG_FB_OMAP2=m,
Kbuild fails to point out that we have two modules with the same name (omapfb.ko),
but instead fails with a cryptic error message like:

ERROR: "omapfb_register_panel" [drivers/video/fbdev/omap/lcd_osk.ko] undefined!

This can now happen when building a randconfig kernel with CONFIG_ARCH_OMAP1,
as the omap1 fbdev driver depends on that, whiel the omap2 fbdev driver can
now be built anywhere with CONFIG_COMPILE_TEST.

The solution is to rename one of the two modules, so for consistency with
the directory naming I decided to rename the omap2 version to omap2fb.ko.

Fixes: 7378f1149884 ("media: omap2: omapfb: allow building it with COMPILE_TEST")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/omap2/omapfb/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/Makefile b/drivers/video/fbdev/omap2/omapfb/Makefile
index 602edfed09df..f54c3f56b641 100644
--- a/drivers/video/fbdev/omap2/omapfb/Makefile
+++ b/drivers/video/fbdev/omap2/omapfb/Makefile
@@ -2,5 +2,5 @@
 obj-$(CONFIG_OMAP2_VRFB) += vrfb.o
 obj-y += dss/
 obj-y += displays/
-obj-$(CONFIG_FB_OMAP2) += omapfb.o
-omapfb-y := omapfb-main.o omapfb-sysfs.o omapfb-ioctl.o
+obj-$(CONFIG_FB_OMAP2) += omap2fb.o
+omap2fb-y := omapfb-main.o omapfb-sysfs.o omapfb-ioctl.o
-- 
2.9.0


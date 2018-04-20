From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 20 Apr 2018 14:20:51 +0000
Subject: [PATCH] video: fbdev: sh_mobile_meram: Drop SUPERH platform dependency
Message-Id: <1524234051-14058-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Since commit a521422ea4ae6128 ("ARM: shmobile: mackerel: Remove Legacy C
board code"), the only remaining platforms using this driver are SuperH
SH-Mobile SoCs (sh7723).  As both SUPERH and ARCH_SHMOBILE are set for
these platforms, the SUPERH dependency can be dropped.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index d94254263ea5caa7..434e95b9320ead05 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2348,7 +2348,7 @@ source "drivers/video/fbdev/mmp/Kconfig"
 
 config FB_SH_MOBILE_MERAM
 	tristate "SuperH Mobile MERAM read ahead support"
-	depends on (SUPERH || ARCH_SHMOBILE)
+	depends on ARCH_SHMOBILE
 	select GENERIC_ALLOCATOR
 	---help---
 	  Enable MERAM support for the SuperH controller.
-- 
2.7.4


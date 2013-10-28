From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 28 Oct 2013 23:47:07 +0000
Subject: [PATCH 19/19] fbdev: sh-mobile-lcdcfb: Enable the driver on all ARM platforms
Message-Id: <1383004027-25036-20-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI and increase build testing coverage.

Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/video/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 84b685f..681858e 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -10,7 +10,7 @@ config HAVE_FB_ATMEL
 
 config SH_MIPI_DSI
 	tristate
-	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
+	depends on (SUPERH || ARM) && HAVE_CLK
 
 config SH_LCD_MIPI_DSI
 	bool
@@ -1995,7 +1995,7 @@ config FB_W100
 
 config FB_SH_MOBILE_LCDC
 	tristate "SuperH Mobile LCDC framebuffer support"
-	depends on FB && (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
+	depends on FB && (SUPERH || ARM) && HAVE_CLK
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
@@ -2482,7 +2482,7 @@ endif
 
 config FB_SH_MOBILE_MERAM
 	tristate "SuperH Mobile MERAM read ahead support"
-	depends on (SUPERH || ARCH_SHMOBILE)
+	depends on (SUPERH || ARM)
 	select GENERIC_ALLOCATOR
 	---help---
 	  Enable MERAM support for the SuperH controller.
-- 
1.8.1.5


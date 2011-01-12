From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Wed, 12 Jan 2011 15:19:35 +0000
Subject: [PATCH] video: move SH_MIPI_DSI/SH_LCD_MIPI_DSI to the top of menu
Message-Id: <1294845575-4508-1-git-send-email-dbaryshkov@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Kconfig entries SH_MIPI_DSI and SH_LCD_MIPI_DSI while being invisible to
the user, broke the FrameBuffer menu (at least in menuconfig), as they
aren't depending on respective menuconfig item (FB). In result several
items got moved to the main "Graphics support" menu. Move these two
problematic items to the top of drivers/video/Kbuild to restore nice
display of FB menu.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/video/Kconfig |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 27c1fb4..055e1a7 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -11,6 +11,13 @@ config HAVE_FB_ATMEL
 config HAVE_FB_IMX
 	bool
 
+config SH_MIPI_DSI
+	tristate
+	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
+
+config SH_LCD_MIPI_DSI
+	bool
+
 source "drivers/char/agp/Kconfig"
 
 source "drivers/gpu/vga/Kconfig"
@@ -1898,13 +1905,6 @@ config FB_W100
 
 	  If unsure, say N.
 
-config SH_MIPI_DSI
-	tristate
-	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
-
-config SH_LCD_MIPI_DSI
-	bool
-
 config FB_SH_MOBILE_LCDC
 	tristate "SuperH Mobile LCDC framebuffer support"
 	depends on FB && (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
-- 
1.7.2.3


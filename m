From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 06 Mar 2012 00:29:56 +0000
Subject: [PATCH v2] fbdev: remove dependency of FB_SH_MOBILE_MERAM from FB_SH_MOBILE_LCDC
Message-Id: <87fwdmwozi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

MERAM can be used for other IP blocks as well in the future.
It doesn't necessarily mean that the MERAM driver depends on the LCDC.
This patch corrects dependency.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This patch is v2 of [PATCH] fbdev: remove "default y" from FB_SH_MOBILE_MERAM

v1 -> v2
- corrects dependency
- modify transfate and help too

 drivers/video/Kconfig |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6ca0c40..11594ea 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2002,11 +2002,10 @@ config FB_SH_MOBILE_HDMI
 	  Driver for the on-chip SH-Mobile HDMI controller.
 
 config FB_SH_MOBILE_MERAM
-	tristate "SuperH Mobile MERAM read ahead support for LCDC"
-	depends on FB_SH_MOBILE_LCDC
-	default y
+	tristate "SuperH Mobile MERAM read ahead support"
+	depends on (SUPERH || ARCH_SHMOBILE)
 	---help---
-	  Enable MERAM support for the SH-Mobile LCD controller.
+	  Enable MERAM support for the SuperH controller.
 
 	  This will allow for caching of the framebuffer to provide more
 	  reliable access under heavy main memory bus traffic situations.
-- 
1.7.5.4


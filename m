From: Darren Etheridge <detheridge@ti.com>
Date: Mon, 05 Aug 2013 22:02:39 +0000
Subject: [PATCH v3 20/20] video: da8xx-fb: adding am33xx as dependency
Message-Id: <1375740159-1045-21-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Updating Kconfig to allow am33xx to include lcdc fbdev driver
including some extra dependencies needed by device tree mods.

v2: must add FB_MODE_HELPERS as VIDEOMODE_HELPERS alone doesn't
	get the correct functions from fbmon.c built in.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/Kconfig |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 2e937bd..f36c2f7 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2226,15 +2226,17 @@ config FB_SH7760
 	  panels <= 320 pixel horizontal resolution.
 
 config FB_DA8XX
-	tristate "DA8xx/OMAP-L1xx Framebuffer support"
-	depends on FB && ARCH_DAVINCI_DA8XX
+	tristate "DA8xx/OMAP-L1xx/AM335x Framebuffer support"
+	depends on FB && (ARCH_DAVINCI_DA8XX || SOC_AM33XX)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_CFB_REV_PIXELS_IN_BYTE
+	select FB_MODE_HELPERS
+	select VIDEOMODE_HELPERS
 	---help---
 	  This is the frame buffer device driver for the TI LCD controller
-	  found on DA8xx/OMAP-L1xx SoCs.
+	  found on DA8xx/OMAP-L1xx/AM335x SoCs.
 	  If unsure, say N.
 
 config FB_VIRTUAL
-- 
1.7.0.4


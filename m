From: Manjunath Hadli <manjunath.hadli@ti.com>
Date: Mon, 26 Sep 2011 13:47:09 +0000
Subject: [RFC PATCH 3/3] davinci: vpbe: add build infrastructure for fbdev driver
Message-Id: <1317044109-7429-4-git-send-email-manjunath.hadli@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

add Kconfig and Makefile changes to build the fbdev driver

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
---
 drivers/media/video/davinci/Kconfig  |   13 +++++++++++++
 drivers/media/video/davinci/Makefile |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/davinci/Kconfig b/drivers/media/video/davinci/Kconfig
index a7f11e7..0ea27b8 100644
--- a/drivers/media/video/davinci/Kconfig
+++ b/drivers/media/video/davinci/Kconfig
@@ -113,3 +113,16 @@ config VIDEO_VPBE_DISPLAY
 
 	    To compile this driver as a module, choose M here: the
 	    module will be called vpbe_display.
+
+config VIDEO_VPBE_FB
+	tristate "VPBE Framebuffer driver"
+	depends on FB && ARCH_DAVINCI
+	select VIDEO_DMXXX_VPBE
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	default y
+	help
+		Enables VPBE Framebuffer driver on a DMXXX device
+		To compile this driver as a module, choose M here: the
+		 module will be called vpbe_fb.
diff --git a/drivers/media/video/davinci/Makefile b/drivers/media/video/davinci/Makefile
index ae7dafb..da4a5b4 100644
--- a/drivers/media/video/davinci/Makefile
+++ b/drivers/media/video/davinci/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_VIDEO_DM355_CCDC) += dm355_ccdc.o
 obj-$(CONFIG_VIDEO_ISIF) += isif.o
 obj-$(CONFIG_VIDEO_DM644X_VPBE) += vpbe.o vpbe_osd.o vpbe_venc.o
 obj-$(CONFIG_VIDEO_VPBE_DISPLAY) += vpbe_display.o
+obj-$(CONFIG_VIDEO_VPBE_FB) += vpbe_fb.o
-- 
1.6.2.4


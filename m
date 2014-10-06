From: Davor Joja <davorjoja@logicbricks.com>
Date: Mon, 06 Oct 2014 13:32:56 +0000
Subject: [RFC 06/10] video: fbdev: Xylon: Framebuffer driver kernel and make configuration
Message-Id: <f274040f-d420-4704-a872-5dd5c1445262@mail.xylon.local>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver kernel and build configuration.

Signed-off-by: Davor Joja <davorjoja@logicbricks.com>
---
 drivers/video/fbdev/xylon/Kconfig  | 40 ++++++++++++++++++++++++++++++++++++++
 drivers/video/fbdev/xylon/Makefile |  3 +++
 2 files changed, 43 insertions(+)
 create mode 100644 drivers/video/fbdev/xylon/Kconfig
 create mode 100644 drivers/video/fbdev/xylon/Makefile

diff --git a/drivers/video/fbdev/xylon/Kconfig b/drivers/video/fbdev/xylon/Kconfig
new file mode 100644
index 0000000..25ae308
--- /dev/null
+++ b/drivers/video/fbdev/xylon/Kconfig
@@ -0,0 +1,40 @@
+menuconfig FB_XYLON
+	tristate "Xylon logiCVC frame buffer support"
+	depends on FB
+	default n
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select VIDEOMODE_HELPERS
+	help
+	  Choose this option if you want to use the Xylon logiCVC as frame
+	  buffer device. Without the support of PCI & AGP.
+
+config FB_XYLON_PIXCLK
+	bool "Xylon logiCVC pixel clock"
+	depends on FB_XYLON
+	default n
+	help
+	  logiCVC pixel clock generated from:
+	  - External generator not controllable by Xylon framebuffer driver
+	    This is default selection.
+	  - Generators controllable by Xylon framebuffer driver
+
+config FB_XYLON_PIXCLK_LOGICLK
+	bool "Xylon logiCLK pixel clock generator"
+	depends on FB_XYLON && FB_XYLON_PIXCLK
+	default n
+	select COMMON_CLK_LOGICLK
+	help
+	  Support for controlling pixel clock generation from
+	  Xylon logiCLK FGPA IP core.
+
+config FB_XYLON_PIXCLK_SI570
+	bool "Si570 pixel clock generator"
+	depends on FB_XYLON && FB_XYLON_PIXCLK
+	default n
+	select I2C
+	select COMMON_CLK_SI570
+	help
+	  Support for controlling pixel clock generation from
+	  Si570 clock generator.
diff --git a/drivers/video/fbdev/xylon/Makefile b/drivers/video/fbdev/xylon/Makefile
new file mode 100644
index 0000000..3baa96a
--- /dev/null
+++ b/drivers/video/fbdev/xylon/Makefile
@@ -0,0 +1,3 @@
+xylonfb-y := xylonfb_main.o xylonfb_core.o xylonfb_ioctl.o xylonfb_pixclk.o
+
+obj-$(CONFIG_FB_XYLON) += xylonfb.o
-- 
1.9.1


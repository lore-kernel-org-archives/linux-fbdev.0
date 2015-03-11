From: Davor Joja <davorjoja@logicbricks.com>
Date: Wed, 11 Mar 2015 15:27:07 +0000
Subject: [PATCH 06/10] fbdev: xylon: Framebuffer driver kernel and make configuration
Message-Id: <879fcb64-0aa3-4b8c-af16-b2a8960a22e5@mail.xylon.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426087631-9952-1-git-send-email-davorjoja@logicbricks.com>
In-Reply-To: <1426087631-9952-1-git-send-email-davorjoja@logicbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, geert@linux-m68k.org
Cc: Davor Joja <davorjoja@logicbricks.com>

Driver kernel and build configuration.

Signed-off-by: Davor Joja <davorjoja@logicbricks.com>
---
 drivers/video/fbdev/xylon/Kconfig  | 31 +++++++++++++++++++++++++++++++
 drivers/video/fbdev/xylon/Makefile |  3 +++
 2 files changed, 34 insertions(+)
 create mode 100644 drivers/video/fbdev/xylon/Kconfig
 create mode 100644 drivers/video/fbdev/xylon/Makefile

diff --git a/drivers/video/fbdev/xylon/Kconfig b/drivers/video/fbdev/xylon/Kconfig
new file mode 100644
index 0000000..74278ad
--- /dev/null
+++ b/drivers/video/fbdev/xylon/Kconfig
@@ -0,0 +1,31 @@
+menuconfig FB_XYLON
+	tristate "Xylon logiCVC frame buffer support"
+	depends on FB
+	default n
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_MODE_HELPERS
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


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 14 Dec 2012 14:27:32 +0000
Subject: [RFC 6/6] video: add makefile & kconfig
Message-Id: <1355495252-26364-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355495252-26364-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1355495252-26364-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/Kconfig          |    1 +
 drivers/video/Makefile         |    1 +
 drivers/video/display/Kconfig  |   26 ++++++++++++++++++++++++++
 drivers/video/display/Makefile |    5 +++++
 4 files changed, 33 insertions(+)
 create mode 100644 drivers/video/display/Kconfig
 create mode 100644 drivers/video/display/Makefile

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c5b7bcf..e91f03e 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2442,6 +2442,7 @@ source "drivers/video/omap/Kconfig"
 source "drivers/video/omap2/Kconfig"
 source "drivers/video/exynos/Kconfig"
 source "drivers/video/backlight/Kconfig"
+source "drivers/video/display/Kconfig"
 
 if VT
 	source "drivers/video/console/Kconfig"
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index b936b00..0a4cfea 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -14,6 +14,7 @@ fb-objs                           := $(fb-y)
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
 obj-y				  += backlight/
+obj-y				  += display/
 
 obj-$(CONFIG_EXYNOS_VIDEO)     += exynos/
 
diff --git a/drivers/video/display/Kconfig b/drivers/video/display/Kconfig
new file mode 100644
index 0000000..1d1a590
--- /dev/null
+++ b/drivers/video/display/Kconfig
@@ -0,0 +1,26 @@
+menuconfig DISPLAY_CORE
+	tristate "Display Core"
+	---help---
+	  Support common display framework for graphics devices.
+
+if DISPLAY_CORE
+
+config DISPLAY_PANEL_DPI
+	tristate "DPI (Parallel) Display Panels"
+	---help---
+	  Support for simple digital (parallel) pixel interface panels. Those
+	  panels receive pixel data through a parallel bus and have no control
+	  bus.
+
+	  If you are in doubt, say N.
+
+config DISPLAY_PANEL_DVI
+	tristate "DVI Monitor"
+
+config DISPLAY_PANEL_TAAL
+	tristate "Taal DSI command mode panel"
+
+config DISPLAY_CHIP_TFP410
+	tristate "DPI to DVI chip"
+
+endif # DISPLAY_CORE
diff --git a/drivers/video/display/Makefile b/drivers/video/display/Makefile
new file mode 100644
index 0000000..ac97dfd
--- /dev/null
+++ b/drivers/video/display/Makefile
@@ -0,0 +1,5 @@
+obj-$(CONFIG_DISPLAY_CORE) += display-core.o
+obj-$(CONFIG_DISPLAY_PANEL_DPI) += panel-dpi.o
+obj-$(CONFIG_DISPLAY_PANEL_DVI) += panel-dvi.o
+obj-$(CONFIG_DISPLAY_PANEL_TAAL) += panel-taal.o
+obj-$(CONFIG_DISPLAY_CHIP_TFP410) += chip-tfp410.o
-- 
1.7.10.4


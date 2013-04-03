From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 03 Apr 2013 01:45:15 +0000
Subject: [PATCH v2 1/2] video: Add a helper for enabling a panel via GPIO from dt
Message-Id: <1364953516-7664-1-git-send-email-festevam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Introduce a helper that can be used to retrieve the GPIO via devicetree that is 
used to turn on a display.

Tested on a mx28evk board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fix return value

 drivers/video/Kconfig                  |    6 +++++
 drivers/video/Makefile                 |    1 +
 drivers/video/of_display_enable_gpio.c |   43 ++++++++++++++++++++++++++++++++
 include/video/of_display_gpio.h        |   17 +++++++++++++
 4 files changed, 67 insertions(+)
 create mode 100644 drivers/video/of_display_enable_gpio.c
 create mode 100644 include/video/of_display_gpio.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0181a87..7607f42 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -52,6 +52,12 @@ config OF_VIDEOMODE
 	help
 	  helper to get videomodes from the devicetree
 
+config OF_DISPLAY_ENABLE_GPIO
+	bool "Support for enabling a panel via GPIO from the devicetree"
+	depends on OF
+	help
+	  helper to turning on a panel via gpio from the devicetree
+
 config HDMI
 	bool
 
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 97f7b6d..4d3ec70 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -176,3 +176,4 @@ obj-$(CONFIG_DISPLAY_TIMING) += display_timing.o
 obj-$(CONFIG_OF_DISPLAY_TIMING) += of_display_timing.o
 obj-$(CONFIG_VIDEOMODE) += videomode.o
 obj-$(CONFIG_OF_VIDEOMODE) += of_videomode.o
+obj-$(CONFIG_OF_DISPLAY_ENABLE_GPIO) += of_display_enable_gpio.o
diff --git a/drivers/video/of_display_enable_gpio.c b/drivers/video/of_display_enable_gpio.c
new file mode 100644
index 0000000..d556854
--- /dev/null
+++ b/drivers/video/of_display_enable_gpio.c
@@ -0,0 +1,43 @@
+/*
+ * generic helper for enabling a panel via GPIO from the devicetree
+ *
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/export.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+
+int of_get_display_gpio_enable(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int panel_enable, ret;
+	enum of_gpio_flags flags;
+
+	panel_enable = of_get_named_gpio_flags(np, "panel-enable-gpios", 0,
+					       &flags);
+
+	if (gpio_is_valid(panel_enable)) {
+		unsigned long f = GPIOF_OUT_INIT_HIGH;
+		if (flags = OF_GPIO_ACTIVE_LOW)
+			f = GPIOF_OUT_INIT_LOW;
+		ret = devm_gpio_request_one(&pdev->dev, panel_enable, f,
+					    "panel-enable");
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request gpio %d: %d\n",
+				panel_enable, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_get_display_gpio_enable);
diff --git a/include/video/of_display_gpio.h b/include/video/of_display_gpio.h
new file mode 100644
index 0000000..a56b6a1
--- /dev/null
+++ b/include/video/of_display_gpio.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef __LINUX_OF_DISPLAY_GPIO_H
+#define __LINUX_OF_DISPLAY_GPIO_H
+
+int of_get_display_gpio_enable(struct platform_device *pdev);
+
+#endif
-- 
1.7.9.5


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 01 Feb 2012 05:27:29 +0000
Subject: [RFC][PATCH] video: add sh_mipi_dsi original driver/device interface for MIPI DSI panel
Message-Id: <87lion9l8i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Linux kernel doesn't have common MIPI DSI interface like i2c/spi
etc at this point.
Therefore, this patch adds very simple sh_mipi_dsi original
driver/device interface for MIPI DSI like ${LINUX}/drivers/video/omap2/.
These should be replaced when common MIPI DSI interface was created.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This is remake version of 
[PATCH] fbdev: sh_mipi_dsi: add extra settings method for platform.

 drivers/video/sh_mipi_dsi.c |   97 +++++++++++++++++++++++++++++++++++++++++++
 include/video/sh_mipi_dsi.h |   33 +++++++++++++++
 2 files changed, 130 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 05151b8..8c56fb7 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -49,6 +49,65 @@
 /* E.g., sh7372 has 2 MIPI-DSIs - one for each LCDC */
 #define MAX_SH_MIPI_DSI 2
 
+/*
+ *	sh_mipi_dsi driver/device register
+ *
+ * FIXME
+ *
+ * sh_mipi_dsi has original driver/device register method here,
+ * since we don't have common MIPI interface at this point.
+ * These should be replaced in the future.
+ */
+static LIST_HEAD(sh_mipi_dsi_driver_list);
+
+static int sh_mipi_dsi_register_device(struct sh_mipi_dsi_device *shdev,
+				       const char *driver_name)
+{
+	static int dev_num;
+	struct sh_mipi_dsi_driver *shdrv;
+
+	/* no driver is not error at this point */
+	if (!driver_name)
+		return 0;
+
+	list_for_each_entry(shdrv, &sh_mipi_dsi_driver_list, node) {
+		if (0 = strcmp(driver_name, shdrv->name))
+			goto driver_find;
+	}
+	/* no driver is not error at this point */
+	return 0;
+
+driver_find:
+	dev_set_name(&shdev->dev, "display%d", dev_num++);
+	shdev->driver = shdrv;
+
+	return device_register(&shdev->dev);
+}
+
+static void sh_mipi_dsi_unregister_device(struct sh_mipi_dsi_device *shdev)
+{
+	shdev->driver = NULL;
+	device_unregister(&shdev->dev);
+}
+
+int sh_mipi_dsi_register_driver(struct sh_mipi_dsi_driver *shdriver)
+{
+	INIT_LIST_HEAD(&shdriver->node);
+	list_add_tail(&shdriver->node, &sh_mipi_dsi_driver_list);
+
+	return 0;
+}
+EXPORT_SYMBOL(sh_mipi_dsi_register_driver);
+
+void sh_mipi_dsi_unregister_driver(struct sh_mipi_dsi_driver *shdriver)
+{
+	list_del_init(&shdriver->node);
+}
+EXPORT_SYMBOL(sh_mipi_dsi_unregister_driver);
+
+/*
+ *		sh_mipi_dsi
+ */
 struct sh_mipi {
 	void __iomem	*base;
 	void __iomem	*linkbase;
@@ -58,8 +117,12 @@ struct sh_mipi {
 	void	*next_board_data;
 	void	(*next_display_on)(void *board_data, struct fb_info *info);
 	void	(*next_display_off)(void *board_data);
+
+	struct sh_mipi_dsi_device device;
 };
 
+#define to_shmipi(x) container_of((x), struct sh_mipi, device)
+
 static struct sh_mipi *mipi_dsi[MAX_SH_MIPI_DSI];
 
 /* Protect the above array */
@@ -109,6 +172,27 @@ static int sh_mipi_dcs_param(int handle, u8 cmd, u8 param)
 				  param);
 }
 
+int sh_mipi_dsi_dcs(struct sh_mipi_dsi_device *shdev, u8 cmd)
+{
+	struct sh_mipi *mipi = to_shmipi(shdev);
+	if (!mipi)
+		return -ENODEV;
+
+	return sh_mipi_send_short(mipi, MIPI_DSI_DCS_SHORT_WRITE, cmd, 0);
+}
+EXPORT_SYMBOL(sh_mipi_dsi_dcs);
+
+int sh_mipi_dsi_dcs_param(struct sh_mipi_dsi_device *shdev, u8 cmd, u8 param)
+{
+	struct sh_mipi *mipi = to_shmipi(shdev);
+	if (!mipi)
+		return -ENODEV;
+
+	return sh_mipi_send_short(mipi, MIPI_DSI_DCS_SHORT_WRITE_PARAM, cmd,
+				  param);
+}
+EXPORT_SYMBOL(sh_mipi_dsi_dcs_param);
+
 static void sh_mipi_dsi_enable(struct sh_mipi *mipi, bool enable)
 {
 	/*
@@ -130,6 +214,8 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 {
 	void __iomem *base = mipi->base;
 	struct sh_mobile_lcdc_chan_cfg *ch = pdata->lcd_chan;
+	struct sh_mipi_dsi_device *shdev = &mipi->device;
+	struct sh_mipi_dsi_driver *shdrv = shdev->driver;
 	u32 pctype, datatype, pixfmt, linelength, vmctr2;
 	u32 tmp, top, bottom, delay, div;
 	bool yuv;
@@ -386,6 +472,9 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 			  pixfmt << 4);
 	sh_mipi_dcs(ch->chan, MIPI_DCS_SET_DISPLAY_ON);
 
+	if (shdrv && shdrv->setup)
+		shdrv->setup(shdev);
+
 	/* Enable timeout counters */
 	iowrite32(0x00000f00, base + DSICTRL);
 
@@ -534,8 +623,14 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 	pdata->lcd_chan->board_cfg.display_off = mipi_display_off;
 	pdata->lcd_chan->board_cfg.owner = THIS_MODULE;
 
+	ret = sh_mipi_dsi_register_device(&mipi->device, pdata->driver_name);
+	if (ret < 0)
+		goto eregister;
+
 	return 0;
 
+eregister:
+	clk_disable(mipi->dsit_clk);
 eclkton:
 esettrate:
 	clk_put(mipi->dsit_clk);
@@ -597,6 +692,8 @@ static int __exit sh_mipi_remove(struct platform_device *pdev)
 	if (res)
 		release_mem_region(res->start, resource_size(res));
 	platform_set_drvdata(pdev, NULL);
+
+	sh_mipi_dsi_unregister_device(&mipi->device);
 	kfree(mipi);
 
 	return 0;
diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index 434d56b..066184f 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -10,6 +10,9 @@
 #ifndef VIDEO_SH_MIPI_DSI_H
 #define VIDEO_SH_MIPI_DSI_H
 
+#include <linux/platform_device.h>
+#include <linux/device.h>
+
 enum sh_mipi_dsi_data_fmt {
 	MIPI_RGB888,
 	MIPI_RGB565,
@@ -55,6 +58,36 @@ struct sh_mipi_dsi_info {
 	int	(*set_dot_clock)(struct platform_device *pdev,
 				 void __iomem *base,
 				 int enable);
+	const char *driver_name;
+};
+
+/*
+ * FIXME
+ *
+ * sh_mipi has original MIPI DSI interface here
+ * since we don't have common interface at this point.
+ * These should be removed in the future.
+ */
+#define to_shmipidsi_driver(x)\
+	container_of((x), struct sh_mipi_dsi_driver, driver)
+#define to_shmipidsi_device(x)\
+	container_of((x), struct sh_mipi_dsi_device, dev)
+
+struct sh_mipi_dsi_driver;
+struct sh_mipi_dsi_device {
+	struct device dev;
+	struct sh_mipi_dsi_driver *driver;
 };
 
+struct sh_mipi_dsi_driver {
+	int (*setup)(struct sh_mipi_dsi_device *);
+	const char *name;
+	struct list_head node;
+};
+
+int sh_mipi_dsi_register_driver(struct sh_mipi_dsi_driver *shdriver);
+void sh_mipi_dsi_unregister_driver(struct sh_mipi_dsi_driver *shdriver);
+int sh_mipi_dsi_dcs(struct sh_mipi_dsi_device *shdev, u8 cmd);
+int sh_mipi_dsi_dcs_param(struct sh_mipi_dsi_device *shdev, u8 cmd, u8 param);
+
 #endif
-- 
1.7.5.4


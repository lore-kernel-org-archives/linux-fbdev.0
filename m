From: Kyungmin Park <kmpark@infradead.org>
Date: Wed, 16 Nov 2011 00:55:16 +0000
Subject: [PATCH v2] video: support MIPI-DSI controller driver
Message-Id: <20111116005516.GA17850@july>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Donghwa Lee <dh09.lee@samsung.com>

Samsung S5PC210 and EXYNOS SoC platform has MIPI-DSI controller and MIPI-DSI
based LCD Panel could be used with it. This patch supports MIPI-DSI driver
based Samsung SoC chip.

LCD panel driver based MIPI-DSI should be registered to MIPI-DSI driver at
machine code and LCD panel driver specific function registered to mipi_dsim_ddi
structure at lcd panel init function called system init.
In the MIPI-DSI driver, find lcd panel driver by using registered
lcd panel name, and then initialize lcd panel driver.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>

Changes since v1:
	- /plat/regs-dsim.h moves to /driver/video/s5p_mipi_dsi_regs.h,
	- /plat/mipi_dsim.h moves to /linux/mipi_dsim.h

---
 drivers/video/Kconfig                 |    7 +
 drivers/video/Makefile                |    2 +
 drivers/video/s5p_mipi_dsi.c          |  601 +++++++++++++++++++++
 drivers/video/s5p_mipi_dsi_common.c   |  931 +++++++++++++++++++++++++++++++++
 drivers/video/s5p_mipi_dsi_common.h   |   48 ++
 drivers/video/s5p_mipi_dsi_lowlevel.c |  608 +++++++++++++++++++++
 drivers/video/s5p_mipi_dsi_lowlevel.h |  108 ++++
 drivers/video/s5p_mipi_dsi_regs.h     |  153 ++++++
 include/linux/mipi_dsim.h             |  362 +++++++++++++
 9 files changed, 2820 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/s5p_mipi_dsi.c
 create mode 100644 drivers/video/s5p_mipi_dsi_common.c
 create mode 100644 drivers/video/s5p_mipi_dsi_common.h
 create mode 100644 drivers/video/s5p_mipi_dsi_lowlevel.c
 create mode 100644 drivers/video/s5p_mipi_dsi_lowlevel.h
 create mode 100644 drivers/video/s5p_mipi_dsi_regs.h
 create mode 100644 include/linux/mipi_dsim.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index d83e967..879177b 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2082,6 +2082,13 @@ config FB_S3C2410_DEBUG
 	  Turn on debugging messages. Note that you can set/unset at run time
 	  through sysfs
 
+config S5P_MIPI_DSI
+	tristate "Samsung SoC MIPI-DSI support."
+	depends on FB_S3C && (ARCH_S5PV210 || ARCH_S5PV310 || ARCH_EXYNOS)
+	default n
+	help
+	  This enables support for MIPI-DSI device.
+
 config FB_NUC900
         bool "NUC900 LCD framebuffer support"
         depends on FB && ARCH_W90X900
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 9b9d8ff..29eb7c9 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -120,6 +120,8 @@ obj-$(CONFIG_FB_SH7760)		  += sh7760fb.o
 obj-$(CONFIG_FB_IMX)              += imxfb.o
 obj-$(CONFIG_FB_S3C)		  += s3c-fb.o
 obj-$(CONFIG_FB_S3C2410)	  += s3c2410fb.o
+obj-$(CONFIG_S5P_MIPI_DSI)	  += s5p_mipi_dsi.o s5p_mipi_dsi_common.o \
+				     s5p_mipi_dsi_lowlevel.o
 obj-$(CONFIG_FB_FSL_DIU)	  += fsl-diu-fb.o
 obj-$(CONFIG_FB_COBALT)           += cobalt_lcdfb.o
 obj-$(CONFIG_FB_PNX4008_DUM)	  += pnx4008/
diff --git a/drivers/video/s5p_mipi_dsi.c b/drivers/video/s5p_mipi_dsi.c
new file mode 100644
index 0000000..09a4af8
--- /dev/null
+++ b/drivers/video/s5p_mipi_dsi.c
@@ -0,0 +1,601 @@
+/* linux/drivers/video/s5p_mipi_dsi.c
+ *
+ * Samsung SoC MIPI-DSIM driver.
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd
+ *
+ * InKi Dae, <inki.dae@samsung.com>
+ * Donghwa Lee, <dh09.lee@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/fb.h>
+#include <linux/ctype.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/memory.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kthread.h>
+#include <linux/notifier.h>
+#include <linux/mipi_dsim.h>
+
+#include <plat/fb.h>
+#include <linux/mipi_dsim.h>
+
+#include "s5p_mipi_dsi_common.h"
+#include "s5p_mipi_dsi_lowlevel.h"
+
+#define master_to_driver(a)	(a->dsim_lcd_drv)
+#define master_to_device(a)	(a->dsim_lcd_dev)
+
+struct mipi_dsim_ddi {
+	int				bus_id;
+	struct list_head		list;
+	struct mipi_dsim_lcd_device	*dsim_lcd_dev;
+	struct mipi_dsim_lcd_driver	*dsim_lcd_drv;
+};
+
+static LIST_HEAD(dsim_ddi_list);
+
+static DEFINE_MUTEX(mipi_dsim_lock);
+
+static struct s5p_platform_mipi_dsim *to_dsim_plat(struct platform_device *pdev)
+{
+	return (struct s5p_platform_mipi_dsim *)pdev->dev.platform_data;
+}
+
+/* update all register settings to MIPI DSI controller. */
+static void s5p_mipi_update_cfg(struct mipi_dsim_device *dsim)
+{
+	/*
+	 * data from Display controller(FIMD) is not transferred in video mode
+	 * but in case of command mode, all settings is not updated to
+	 * registers.
+	 */
+	s5p_mipi_dsi_stand_by(dsim, 0);
+
+	s5p_mipi_dsi_init_dsim(dsim);
+	s5p_mipi_dsi_init_link(dsim);
+
+	s5p_mipi_dsi_set_hs_enable(dsim);
+
+	/* set display timing. */
+	s5p_mipi_dsi_set_display_mode(dsim, dsim->dsim_config);
+
+	/*
+	 * data from Display controller(FIMD) is transferred in video mode
+	 * but in case of command mode, all settigs is updated to registers.
+	 */
+	s5p_mipi_dsi_stand_by(dsim, 1);
+
+}
+
+static int s5p_mipi_dsi_early_blank_mode(struct mipi_dsim_device *dsim,
+		int power)
+{
+	struct platform_device *pdev = to_platform_device(dsim->dev);
+	struct mipi_dsim_lcd_driver *client_drv = master_to_driver(dsim);
+	struct mipi_dsim_lcd_device *client_dev = master_to_device(dsim);
+
+	switch (power) {
+	case FB_BLANK_POWERDOWN:
+		if (client_drv && client_drv->suspend)
+			client_drv->suspend(client_dev);
+
+		clk_disable(dsim->clock);
+
+		if (dsim->pd->mipi_power)
+			dsim->pd->mipi_power(pdev, 0);
+
+		atomic_set(&dsim->power_t, 0);
+
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int s5p_mipi_dsi_blank_mode(struct mipi_dsim_device *dsim, int power)
+{
+	struct platform_device *pdev = to_platform_device(dsim->dev);
+	struct mipi_dsim_lcd_driver *client_drv = master_to_driver(dsim);
+	struct mipi_dsim_lcd_device *client_dev = master_to_device(dsim);
+
+	switch (power) {
+	case FB_BLANK_UNBLANK:
+		/* lcd panel power on. */
+		if (client_drv && client_drv->power_on)
+			client_drv->power_on(client_dev);
+
+		if (dsim->pd->mipi_power)
+			dsim->pd->mipi_power(pdev, 1);
+
+		/* enable MIPI-DSI PHY. */
+		if (dsim->pd->phy_enable)
+			dsim->pd->phy_enable(pdev, true);
+
+		clk_enable(dsim->clock);
+
+		s5p_mipi_update_cfg(dsim);
+
+		/* set lcd panel sequence commands. */
+		if (client_drv && client_drv->set_sequence)
+			client_drv->set_sequence(client_dev);
+
+		atomic_set(&dsim->power_t, 1);
+
+		break;
+	case FB_BLANK_NORMAL:
+		/* TODO. */
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int s5p_mipi_dsi_register_lcd_device(struct mipi_dsim_lcd_device *lcd_dev)
+{
+	struct mipi_dsim_ddi *dsim_ddi;
+
+	if (!lcd_dev) {
+		printk(KERN_ERR "mipi_dsim_lcd_device is NULL.\n");
+		return -EFAULT;
+	}
+
+	if (!lcd_dev->name) {
+		printk(KERN_ERR "dsim_lcd_device name is NULL.\n");
+		return -EFAULT;
+	}
+
+	dsim_ddi = kzalloc(sizeof(struct mipi_dsim_ddi), GFP_KERNEL);
+	if (!dsim_ddi) {
+		printk(KERN_ERR "failed to allocate dsim_ddi object.\n");
+		return -EFAULT;
+	}
+
+	dsim_ddi->dsim_lcd_dev = lcd_dev;
+
+	mutex_lock(&mipi_dsim_lock);
+	list_add_tail(&dsim_ddi->list, &dsim_ddi_list);
+	mutex_unlock(&mipi_dsim_lock);
+
+	return 0;
+}
+
+struct mipi_dsim_ddi
+	*s5p_mipi_dsi_find_lcd_device(struct mipi_dsim_lcd_driver *lcd_drv)
+{
+	struct mipi_dsim_ddi *dsim_ddi;
+	struct mipi_dsim_lcd_device *lcd_dev;
+
+	mutex_lock(&mipi_dsim_lock);
+
+	list_for_each_entry(dsim_ddi, &dsim_ddi_list, list) {
+		if (!dsim_ddi)
+			goto out;
+
+		lcd_dev = dsim_ddi->dsim_lcd_dev;
+		if (!lcd_dev)
+			continue;
+
+		if (lcd_drv->id >= 0) {
+			if ((strcmp(lcd_drv->name, lcd_dev->name)) = 0 &&
+					lcd_drv->id = lcd_dev->id) {
+				/**
+				 * bus_id would be used to identify
+				 * connected bus.
+				 */
+				dsim_ddi->bus_id = lcd_dev->bus_id;
+				mutex_unlock(&mipi_dsim_lock);
+
+				return dsim_ddi;
+			}
+		} else {
+			if ((strcmp(lcd_drv->name, lcd_dev->name)) = 0) {
+				/**
+				 * bus_id would be used to identify
+				 * connected bus.
+				 */
+				dsim_ddi->bus_id = lcd_dev->bus_id;
+				mutex_unlock(&mipi_dsim_lock);
+
+				return dsim_ddi;
+			}
+		}
+
+		kfree(dsim_ddi);
+		list_del(&dsim_ddi->list);
+	}
+
+out:
+	mutex_unlock(&mipi_dsim_lock);
+
+	return NULL;
+}
+
+int s5p_mipi_dsi_register_lcd_driver(struct mipi_dsim_lcd_driver *lcd_drv)
+{
+	struct mipi_dsim_ddi *dsim_ddi;
+
+	if (!lcd_drv) {
+		printk(KERN_ERR "mipi_dsim_lcd_driver is NULL.\n");
+		return -EFAULT;
+	}
+
+	if (!lcd_drv->name) {
+		printk(KERN_ERR "dsim_lcd_driver name is NULL.\n");
+		return -EFAULT;
+	}
+
+	dsim_ddi = s5p_mipi_dsi_find_lcd_device(lcd_drv);
+	if (!dsim_ddi) {
+		printk(KERN_ERR "mipi_dsim_ddi object not found.\n");
+		return -EFAULT;
+	}
+
+	dsim_ddi->dsim_lcd_drv = lcd_drv;
+
+	printk(KERN_INFO "registered panel driver(%s) to mipi-dsi driver.\n",
+		lcd_drv->name);
+
+	return 0;
+
+}
+
+struct mipi_dsim_ddi
+	*s5p_mipi_dsi_bind_lcd_ddi(struct mipi_dsim_device *dsim,
+			const char *name)
+{
+	struct mipi_dsim_ddi *dsim_ddi;
+	struct mipi_dsim_lcd_driver *lcd_drv;
+	struct mipi_dsim_lcd_device *lcd_dev;
+	int ret;
+
+	mutex_lock(&dsim->lock);
+
+	list_for_each_entry(dsim_ddi, &dsim_ddi_list, list) {
+		lcd_drv = dsim_ddi->dsim_lcd_drv;
+		lcd_dev = dsim_ddi->dsim_lcd_dev;
+		if (!lcd_drv || !lcd_dev ||
+			(dsim->id != dsim_ddi->bus_id))
+				continue;
+
+		dev_dbg(dsim->dev, "lcd_drv->id = %d, lcd_dev->id = %d\n",
+				lcd_drv->id, lcd_dev->id);
+		dev_dbg(dsim->dev, "lcd_dev->bus_id = %d, dsim->id = %d\n",
+				lcd_dev->bus_id, dsim->id);
+
+		if ((strcmp(lcd_drv->name, name) = 0)) {
+			lcd_dev->master = dsim;
+
+			lcd_dev->dev.parent = dsim->dev;
+			dev_set_name(&lcd_dev->dev, "%s", lcd_drv->name);
+
+			ret = device_register(&lcd_dev->dev);
+			if (ret < 0) {
+				dev_err(dsim->dev,
+					"can't register %s, status %d\n",
+					dev_name(&lcd_dev->dev), ret);
+				mutex_unlock(&dsim->lock);
+
+				return NULL;
+			}
+
+			dsim->dsim_lcd_dev = lcd_dev;
+			dsim->dsim_lcd_drv = lcd_drv;
+
+			mutex_unlock(&dsim->lock);
+
+			return dsim_ddi;
+		}
+	}
+
+	mutex_unlock(&dsim->lock);
+
+	return NULL;
+}
+
+/* define MIPI-DSI Master operations. */
+static struct mipi_dsim_master_ops master_ops = {
+	.cmd_read			= s5p_mipi_dsi_rd_data,
+	.cmd_write			= s5p_mipi_dsi_wr_data,
+	.get_dsim_frame_done		= s5p_mipi_dsi_get_frame_done_status,
+	.clear_dsim_frame_done		= s5p_mipi_dsi_clear_frame_done,
+	.set_early_blank_mode		= s5p_mipi_dsi_early_blank_mode,
+	.set_blank_mode			= s5p_mipi_dsi_blank_mode,
+};
+
+static int s5p_mipi_dsi_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct mipi_dsim_device *dsim;
+	struct mipi_dsim_config *dsim_config;
+	struct mipi_dsim_platform_data *dsim_pd;
+	struct mipi_dsim_ddi *dsim_ddi;
+	int ret = -EINVAL;
+
+	dsim = kzalloc(sizeof(struct mipi_dsim_device), GFP_KERNEL);
+	if (!dsim) {
+		dev_err(&pdev->dev, "failed to allocate dsim object.\n");
+		return -EFAULT;
+	}
+
+	dsim->pd = to_dsim_plat(pdev);
+	dsim->dev = &pdev->dev;
+	dsim->id = pdev->id;
+
+	/* get mipi_dsim_platform_data. */
+	dsim_pd = (struct mipi_dsim_platform_data *)dsim->pd;
+	if (dsim_pd = NULL) {
+		dev_err(&pdev->dev, "failed to get platform data for dsim.\n");
+		return -EFAULT;
+	}
+	/* get mipi_dsim_config. */
+	dsim_config = dsim_pd->dsim_config;
+	if (dsim_config = NULL) {
+		dev_err(&pdev->dev, "failed to get dsim config data.\n");
+		return -EFAULT;
+	}
+
+	dsim->dsim_config = dsim_config;
+	dsim->master_ops = &master_ops;
+
+	dsim->clock = clk_get(&pdev->dev, "dsim0");
+	if (IS_ERR(dsim->clock)) {
+		dev_err(&pdev->dev, "failed to get dsim clock source\n");
+		goto err_clock_get;
+	}
+
+	clk_enable(dsim->clock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get io memory region\n");
+		goto err_platform_get;
+	}
+
+	dsim->res = request_mem_region(res->start, resource_size(res),
+					dev_name(&pdev->dev));
+	if (!dsim->res) {
+		dev_err(&pdev->dev, "failed to request io memory region\n");
+		ret = -ENOMEM;
+		goto err_mem_region;
+	}
+
+	dsim->reg_base = ioremap(res->start, resource_size(res));
+	if (!dsim->reg_base) {
+		dev_err(&pdev->dev, "failed to remap io region\n");
+		ret = -EFAULT;
+		goto err_ioremap;
+	}
+
+	mutex_init(&dsim->lock);
+
+	/* bind lcd ddi matched with panel name. */
+	dsim_ddi = s5p_mipi_dsi_bind_lcd_ddi(dsim, dsim_pd->lcd_panel_name);
+	if (!dsim_ddi) {
+		dev_err(&pdev->dev, "mipi_dsim_ddi object not found.\n");
+		goto err_bind;
+	}
+
+	dsim->irq = platform_get_irq(pdev, 0);
+	if (dsim->irq < 0) {
+		dev_err(&pdev->dev, "failed to request dsim irq resource\n");
+		ret = -EINVAL;
+		goto err_platform_get_irq;
+	}
+
+	ret = request_irq(dsim->irq, s5p_mipi_dsi_interrupt_handler,
+			IRQF_SHARED, pdev->name, dsim);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "failed to request dsim irq\n");
+		ret = -EINVAL;
+		goto err_bind;
+	}
+	init_completion(&dsim_rd_comp);
+
+	/* enable interrupt */
+	s5p_mipi_dsi_init_interrupt(dsim);
+
+	/* initialize mipi-dsi client(lcd panel). */
+	if (dsim_ddi->dsim_lcd_drv && dsim_ddi->dsim_lcd_drv->probe)
+		dsim_ddi->dsim_lcd_drv->probe(dsim_ddi->dsim_lcd_dev);
+
+	/* in case that mipi got enabled at bootloader. */
+	if (dsim_pd->enabled)
+		goto out;
+
+	/* lcd panel power on. */
+	if (dsim_ddi->dsim_lcd_drv && dsim_ddi->dsim_lcd_drv->power_on)
+		dsim_ddi->dsim_lcd_drv->power_on(dsim_ddi->dsim_lcd_dev);
+
+	if (dsim->pd->mipi_power)
+		dsim->pd->mipi_power(pdev, 1);
+
+	/* enable MIPI-DSI PHY. */
+	if (dsim->pd->phy_enable)
+		dsim->pd->phy_enable(pdev, true);
+
+	s5p_mipi_update_cfg(dsim);
+
+	/* set lcd panel sequence commands. */
+	if (dsim_ddi->dsim_lcd_drv && dsim_ddi->dsim_lcd_drv->set_sequence)
+		dsim_ddi->dsim_lcd_drv->set_sequence(dsim_ddi->dsim_lcd_dev);
+
+	atomic_set(&dsim->power_t, 1);
+
+out:
+	platform_set_drvdata(pdev, dsim);
+
+	dev_dbg(&pdev->dev, "mipi-dsi driver(%s mode) has been probed.\n",
+		(dsim_config->e_interface = DSIM_COMMAND) ?
+			"CPU" : "RGB");
+
+	return 0;
+
+err_bind:
+	iounmap((void __iomem *) dsim->reg_base);
+
+err_ioremap:
+	release_mem_region(dsim->res->start, resource_size(dsim->res));
+
+err_mem_region:
+	release_resource(dsim->res);
+
+err_platform_get:
+	clk_disable(dsim->clock);
+	clk_put(dsim->clock);
+
+err_clock_get:
+	kfree(dsim);
+
+err_platform_get_irq:
+	return ret;
+}
+
+static int __devexit s5p_mipi_dsi_remove(struct platform_device *pdev)
+{
+	struct mipi_dsim_device *dsim = platform_get_drvdata(pdev);
+	struct mipi_dsim_ddi *dsim_ddi;
+	struct mipi_dsim_lcd_driver *dsim_lcd_drv;
+
+	iounmap(dsim->reg_base);
+
+	clk_disable(dsim->clock);
+	clk_put(dsim->clock);
+
+	release_resource(dsim->res);
+	release_mem_region(dsim->res->start, resource_size(dsim->res));
+
+	list_for_each_entry(dsim_ddi, &dsim_ddi_list, list) {
+		if (dsim_ddi) {
+			if (dsim->id != dsim_ddi->bus_id)
+				continue;
+
+			dsim_lcd_drv = dsim_ddi->dsim_lcd_drv;
+
+			if (dsim_lcd_drv->remove)
+				dsim_lcd_drv->remove(dsim_ddi->dsim_lcd_dev);
+
+			kfree(dsim_ddi);
+		}
+	}
+
+	kfree(dsim);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int s5p_mipi_dsi_suspend(struct platform_device *pdev,
+		pm_message_t state)
+{
+	struct mipi_dsim_device *dsim = platform_get_drvdata(pdev);
+
+	disable_irq(dsim->irq);
+
+	if (!atomic_read(&dsim->power_t))
+		return 0;
+
+	if (master_to_driver(dsim) && (master_to_driver(dsim))->suspend)
+		(master_to_driver(dsim))->suspend(master_to_device(dsim));
+
+	/* enable MIPI-DSI PHY. */
+	if (dsim->pd->phy_enable)
+		dsim->pd->phy_enable(pdev, false);
+
+	clk_disable(dsim->clock);
+
+	if (dsim->pd->mipi_power)
+		dsim->pd->mipi_power(pdev, 0);
+
+	atomic_set(&dsim->power_t, 0);
+
+	return 0;
+}
+
+static int s5p_mipi_dsi_resume(struct platform_device *pdev)
+{
+	struct mipi_dsim_device *dsim = platform_get_drvdata(pdev);
+	struct mipi_dsim_lcd_driver *client_drv = master_to_driver(dsim);
+	struct mipi_dsim_lcd_device *client_dev = master_to_device(dsim);
+
+	enable_irq(dsim->irq);
+
+	if (atomic_read(&dsim->power_t))
+		return 0;
+
+	/* lcd panel power on. */
+	if (client_drv && client_drv->power_on)
+		client_drv->power_on(client_dev);
+
+	if (dsim->pd->mipi_power)
+		dsim->pd->mipi_power(pdev, 1);
+
+	/* enable MIPI-DSI PHY. */
+	if (dsim->pd->phy_enable)
+		dsim->pd->phy_enable(pdev, true);
+
+	clk_enable(dsim->clock);
+
+	s5p_mipi_update_cfg(dsim);
+
+	/* set lcd panel sequence commands. */
+	if (client_drv && client_drv->set_sequence)
+		client_drv->set_sequence(client_dev);
+
+	atomic_set(&dsim->power_t, 1);
+
+	return 0;
+}
+#else
+#define s5p_mipi_dsi_suspend NULL
+#define s5p_mipi_dsi_resume NULL
+#endif
+
+static struct platform_driver s5p_mipi_dsi_driver = {
+	.probe = s5p_mipi_dsi_probe,
+	.remove = __devexit_p(s5p_mipi_dsi_remove),
+	.suspend = s5p_mipi_dsi_suspend,
+	.resume = s5p_mipi_dsi_resume,
+	.driver = {
+		   .name = "s5p-mipi-dsim",
+		   .owner = THIS_MODULE,
+	},
+};
+
+static int s5p_mipi_dsi_register(void)
+{
+	platform_driver_register(&s5p_mipi_dsi_driver);
+
+	return 0;
+}
+
+static void s5p_mipi_dsi_unregister(void)
+{
+	platform_driver_unregister(&s5p_mipi_dsi_driver);
+}
+
+module_init(s5p_mipi_dsi_register);
+module_exit(s5p_mipi_dsi_unregister);
+
+MODULE_AUTHOR("InKi Dae <inki.dae@samsung.com>");
+MODULE_DESCRIPTION("Samusung SoC MIPI-DSI driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/s5p_mipi_dsi_common.c b/drivers/video/s5p_mipi_dsi_common.c
new file mode 100644
index 0000000..f3452b2
--- /dev/null
+++ b/drivers/video/s5p_mipi_dsi_common.c
@@ -0,0 +1,931 @@
+/* linux/drivers/video/s5p_mipi_dsi_common.c
+ *
+ * Samsung SoC MIPI-DSI common driver.
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd
+ *
+ * InKi Dae, <inki.dae@samsung.com>
+ * Donghwa Lee, <dh09.lee@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/fb.h>
+#include <linux/ctype.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/memory.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/mipi_dsim.h>
+
+#include <video/mipi_display.h>
+
+#include <mach/map.h>
+#include <plat/mipi_dsim.h>
+
+#include "s5p_mipi_dsi_regs.h"
+#include "s5p_mipi_dsi_lowlevel.h"
+#include "s5p_mipi_dsi_common.h"
+
+#define MIPI_RX_TIMEOUT         HZ
+#define MIPI_RX_FIFO_READ_DONE  0x30800002
+#define MIPI_MAX_RX_FIFO        20
+#define MHZ			(1000 * 1000)
+#define FIN_HZ			(24 * MHZ)
+
+#define DFIN_PLL_MIN_HZ		(6 * MHZ)
+#define DFIN_PLL_MAX_HZ		(12 * MHZ)
+
+#define DFVCO_MIN_HZ		(500 * MHZ)
+#define DFVCO_MAX_HZ		(1000 * MHZ)
+
+#define TRY_GET_FIFO_TIMEOUT	(5000 * 2)
+
+/* MIPI-DSIM status types. */
+enum {
+	DSIM_STATE_INIT,	/* should be initialized. */
+	DSIM_STATE_STOP,	/* CPU and LCDC are LP mode. */
+	DSIM_STATE_HSCLKEN,	/* HS clock was enabled. */
+	DSIM_STATE_ULPS
+};
+
+/* define DSI lane types. */
+enum {
+	DSIM_LANE_CLOCK = (1 << 0),
+	DSIM_LANE_DATA0 = (1 << 1),
+	DSIM_LANE_DATA1 = (1 << 2),
+	DSIM_LANE_DATA2 = (1 << 3),
+	DSIM_LANE_DATA3 = (1 << 4)
+};
+
+static unsigned int dpll_table[15] = {
+	100, 120, 170, 220, 270,
+	320, 390, 450, 510, 560,
+	640, 690, 770, 870, 950
+};
+
+irqreturn_t s5p_mipi_dsi_interrupt_handler(int irq, void *dev_id)
+{
+	int i;
+	unsigned int intsrc = 0;
+	unsigned int intmsk = 0;
+	struct mipi_dsim_device *dsim = NULL;
+
+	dsim = (struct mipi_dsim_device *)dev_id;
+	if (!dsim) {
+		dev_dbg(dsim->dev, "%s:error:wrong parameter\n", __func__);
+		return IRQ_HANDLED;
+	}
+
+	intsrc = s5p_mipi_dsi_read_interrupt(dsim);
+	intmsk = s5p_mipi_dsi_read_interrupt_mask(dsim);
+
+	intmsk = ~(intmsk) & intsrc;
+
+	for (i = 0; i < 32; i++) {
+		switch (intmsk & (0x1 << i)) {
+		case INTMSK_RX_DONE:
+			complete(&dsim_rd_comp);
+			break;
+		case INTMSK_BTA:
+			/* TODO */
+			break;
+		case INTMSK_RX_TIMEOUT:
+			/* TODO */
+			break;
+		case INTMSK_BTA_TIMEOUT:
+			/* TODO */
+			break;
+		case INTMSK_RX_TE:
+			/* TODO */
+			break;
+		case INTMSK_RX_ACK:
+			/* TODO */
+			break;
+		case INTMSK_RX_ECC_ERR:
+			/* TODO */
+			break;
+		case INTMSK_RX_CRC_ERR:
+			/* TODO */
+			break;
+		case INTMSK_FIFO_EMPTY:
+			/* TODO */
+			break;
+		case INTMSK_FRAME_DONE:
+			/* TODO */
+			break;
+		default:
+			break;
+		}
+	}
+
+	/* clear irq */
+	s5p_mipi_dsi_clear_interrupt(dsim);
+
+	return IRQ_HANDLED;
+}
+
+static void s5p_mipi_dsi_long_data_wr(struct mipi_dsim_device *dsim,
+		unsigned int data0, unsigned int data1)
+{
+	unsigned int data_cnt = 0, payload = 0;
+
+	/* in case that data count is more then 4 */
+	for (data_cnt = 0; data_cnt < data1; data_cnt += 4) {
+		/*
+		 * after sending 4bytes per one time,
+		 * send remainder data less then 4.
+		 */
+		if ((data1 - data_cnt) < 4) {
+			if ((data1 - data_cnt) = 3) {
+				payload = *(u8 *)(data0 + data_cnt) |
+				    (*(u8 *)(data0 + (data_cnt + 1))) << 8 |
+					(*(u8 *)(data0 + (data_cnt + 2))) << 16;
+			dev_dbg(dsim->dev, "count = 3 payload = %x, %x %x %x\n",
+				payload, *(u8 *)(data0 + data_cnt),
+				*(u8 *)(data0 + (data_cnt + 1)),
+				*(u8 *)(data0 + (data_cnt + 2)));
+			} else if ((data1 - data_cnt) = 2) {
+				payload = *(u8 *)(data0 + data_cnt) |
+					(*(u8 *)(data0 + (data_cnt + 1))) << 8;
+			dev_dbg(dsim->dev,
+				"count = 2 payload = %x, %x %x\n", payload,
+				*(u8 *)(data0 + data_cnt),
+				*(u8 *)(data0 + (data_cnt + 1)));
+			} else if ((data1 - data_cnt) = 1) {
+				payload = *(u8 *)(data0 + data_cnt);
+			}
+
+			s5p_mipi_dsi_wr_tx_data(dsim, payload);
+		/* send 4bytes per one time. */
+		} else {
+			payload = *(u8 *)(data0 + data_cnt) |
+				(*(u8 *)(data0 + (data_cnt + 1))) << 8 |
+				(*(u8 *)(data0 + (data_cnt + 2))) << 16 |
+				(*(u8 *)(data0 + (data_cnt + 3))) << 24;
+
+			dev_dbg(dsim->dev,
+				"count = 4 payload = %x, %x %x %x %x\n",
+				payload, *(u8 *)(data0 + data_cnt),
+				*(u8 *)(data0 + (data_cnt + 1)),
+				*(u8 *)(data0 + (data_cnt + 2)),
+				*(u8 *)(data0 + (data_cnt + 3)));
+
+			s5p_mipi_dsi_wr_tx_data(dsim, payload);
+		}
+	}
+}
+
+int s5p_mipi_dsi_wr_data(struct mipi_dsim_device *dsim, unsigned int data_id,
+	unsigned int data0, unsigned int data1)
+{
+	unsigned int timeout = TRY_GET_FIFO_TIMEOUT;
+	unsigned long delay_val, udelay;
+	unsigned int check_rx_ack = 0;
+
+	if (dsim->state = DSIM_STATE_ULPS) {
+		dev_err(dsim->dev, "state is ULPS.\n");
+
+		return -EINVAL;
+	}
+
+	delay_val = MHZ / dsim->dsim_config->esc_clk;
+	udelay = 10 * delay_val;
+
+	mdelay(udelay);
+
+	/* only if transfer mode is LPDT, wait SFR becomes empty. */
+	if (dsim->state = DSIM_STATE_STOP) {
+		while (!(s5p_mipi_dsi_get_fifo_state(dsim) &
+				SFR_HEADER_EMPTY)) {
+			if ((timeout--) > 0)
+				mdelay(1);
+			else {
+				dev_err(dsim->dev,
+					"SRF header fifo is not empty.\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	switch (data_id) {
+	/* short packet types of packet types for command. */
+	case MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_1_PARAM:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
+	case MIPI_DSI_DCS_SHORT_WRITE:
+	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
+	case MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE:
+		s5p_mipi_dsi_wr_pkt_header(dsim, data_id, data0, data1);
+		if (check_rx_ack)
+			/* process response func should be implemented */
+			return 0;
+		else
+			return -EINVAL;
+
+	/* general command */
+	case MIPI_DSI_COLOR_MODE_OFF:
+	case MIPI_DSI_COLOR_MODE_ON:
+	case MIPI_DSI_SHUTDOWN_PERIPHERAL:
+	case MIPI_DSI_TURN_ON_PERIPHERAL:
+		s5p_mipi_dsi_wr_pkt_header(dsim, data_id, data0, data1);
+		if (check_rx_ack)
+			/* process response func should be implemented. */
+			return 0;
+		else
+			return -EINVAL;
+
+	/* packet types for video data */
+	case MIPI_DSI_V_SYNC_START:
+	case MIPI_DSI_V_SYNC_END:
+	case MIPI_DSI_H_SYNC_START:
+	case MIPI_DSI_H_SYNC_END:
+	case MIPI_DSI_END_OF_TRANSMISSION:
+		return 0;
+
+	/* short and response packet types for command */
+	case MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM:
+	case MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM:
+	case MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM:
+	case MIPI_DSI_DCS_READ:
+		s5p_mipi_dsi_clear_all_interrupt(dsim);
+		s5p_mipi_dsi_wr_pkt_header(dsim, data_id, data0, data1);
+		/* process response func should be implemented. */
+		return 0;
+
+	/* long packet type and null packet */
+	case MIPI_DSI_NULL_PACKET:
+	case MIPI_DSI_BLANKING_PACKET:
+		return 0;
+	case MIPI_DSI_GENERIC_LONG_WRITE:
+	case MIPI_DSI_DCS_LONG_WRITE:
+	{
+		unsigned int size, data_cnt = 0, payload = 0;
+
+		size = data1 * 4;
+
+		/* if data count is less then 4, then send 3bytes data.  */
+		if (data1 < 4) {
+			payload = *(u8 *)(data0) |
+				*(u8 *)(data0 + 1) << 8 |
+				*(u8 *)(data0 + 2) << 16;
+
+			s5p_mipi_dsi_wr_tx_data(dsim, payload);
+
+			dev_dbg(dsim->dev, "count = %d payload = %x,%x %x %x\n",
+				data1, payload,
+				*(u8 *)(data0 + data_cnt),
+				*(u8 *)(data0 + (data_cnt + 1)),
+				*(u8 *)(data0 + (data_cnt + 2)));
+		/* in case that data count is more then 4 */
+		} else
+			s5p_mipi_dsi_long_data_wr(dsim, data0, data1);
+
+		/* put data into header fifo */
+		s5p_mipi_dsi_wr_pkt_header(dsim, data_id, data1 & 0xff,
+			(data1 & 0xff00) >> 8);
+
+	}
+	if (check_rx_ack)
+		/* process response func should be implemented. */
+		return 0;
+	else
+		return -EINVAL;
+
+	/* packet typo for video data */
+	case MIPI_DSI_PACKED_PIXEL_STREAM_16:
+	case MIPI_DSI_PACKED_PIXEL_STREAM_18:
+	case MIPI_DSI_PIXEL_STREAM_3BYTE_18:
+	case MIPI_DSI_PACKED_PIXEL_STREAM_24:
+		if (check_rx_ack)
+			/* process response func should be implemented. */
+			return 0;
+		else
+			return -EINVAL;
+	default:
+		dev_warn(dsim->dev,
+			"data id %x is not supported current DSI spec.\n",
+			data_id);
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static unsigned int s5p_mipi_dsi_long_data_rd(struct mipi_dsim_device *dsim,
+		unsigned int req_size, unsigned int rx_data, u8 *rx_buf)
+{
+	unsigned int rcv_pkt, i, j;
+	u16 rxsize;
+
+	/* for long packet */
+	rxsize = (u16)((rx_data & 0x00ffff00) >> 8);
+	dev_dbg(dsim->dev, "mipi dsi rx size : %d\n", rxsize);
+	if (rxsize != req_size) {
+		dev_dbg(dsim->dev,
+			"received data size mismatch\n");
+		dev_dbg(dsim->dev,
+			"received: %d, requested: %d\n", rxsize, req_size);
+		goto err;
+	}
+
+	for (i = 0; i < (rxsize >> 2); i++) {
+		rcv_pkt = s5p_mipi_dsi_rd_rx_fifo(dsim);
+		dev_dbg(dsim->dev, "received pkt : %08x\n", rcv_pkt);
+		for (j = 0; j < 4; j++) {
+			rx_buf[(i * 4) + j] +					(u8)(rcv_pkt >> (j * 8)) & 0xff;
+			dev_dbg(dsim->dev, "received value : %02x\n",
+					(rcv_pkt >> (j * 8)) & 0xff);
+		}
+	}
+	if (rxsize % 4) {
+		rcv_pkt = s5p_mipi_dsi_rd_rx_fifo(dsim);
+		dev_dbg(dsim->dev, "received pkt : %08x\n", rcv_pkt);
+		for (j = 0; j < (rxsize % 4); j++) {
+			rx_buf[(i * 4) + j] +					(u8)(rcv_pkt >> (j * 8)) & 0xff;
+			dev_dbg(dsim->dev, "received value : %02x\n",
+					(rcv_pkt >> (j * 8)) & 0xff);
+		}
+	}
+
+	return rxsize;
+
+err:
+	return -EINVAL;
+}
+
+static unsigned int s5p_mipi_dsi_respense_size(unsigned int req_size)
+{
+	u8 response;
+	switch (req_size) {
+	case 1:
+		response = MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_1BYTE;
+		break;
+	case 2:
+		response = MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_2BYTE;
+		break;
+	default:
+		response = MIPI_DSI_RX_GENERIC_LONG_READ_RESPONSE;
+		break;
+	}
+
+	return response;
+}
+
+int s5p_mipi_dsi_rd_data(struct mipi_dsim_device *dsim, unsigned int data_id,
+	unsigned int data0, unsigned int req_size, u8 *rx_buf)
+{
+	unsigned int timeout = TRY_GET_FIFO_TIMEOUT;
+	unsigned long delay_val, udelay;
+	unsigned int rx_data, rcv_pkt, i;
+	u8 response = 0;
+	u16 rxsize;
+
+	if (dsim->state = DSIM_STATE_ULPS) {
+		dev_err(dsim->dev, "state is ULPS.\n");
+
+		return -EINVAL;
+	}
+
+	delay_val = MHZ / dsim->dsim_config->esc_clk;
+	udelay = 10 * delay_val;
+
+	msleep(udelay);
+
+	/* only if transfer mode is LPDT, wait SFR becomes empty. */
+	if (dsim->state = DSIM_STATE_STOP) {
+		while (!(s5p_mipi_dsi_get_fifo_state(dsim) &
+				SFR_HEADER_EMPTY)) {
+			if ((timeout--) > 0)
+				mdelay(1);
+			else {
+				dev_err(dsim->dev,
+					"SRF header fifo is not empty.\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	mutex_lock(&dsim->lock);
+	INIT_COMPLETION(dsim_rd_comp);
+	s5p_mipi_dsi_rd_pkt_header(dsim,
+		MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE, req_size);
+
+	response = s5p_mipi_dsi_respense_size(req_size);
+
+	msleep(udelay);
+
+	switch (data_id) {
+	case MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM:
+	case MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM:
+	case MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM:
+	case MIPI_DSI_DCS_READ:
+		s5p_mipi_dsi_clear_all_interrupt(dsim);
+		s5p_mipi_dsi_rd_pkt_header(dsim,
+			data_id, data0);
+		/* process response func should be implemented. */
+		break;
+	default:
+		dev_warn(dsim->dev,
+			"data id %x is not supported current DSI spec.\n",
+			data_id);
+
+		return -EINVAL;
+	}
+
+	if (!wait_for_completion_interruptible_timeout(&dsim_rd_comp,
+				MIPI_RX_TIMEOUT)) {
+		printk(KERN_ERR "RX done interrupt timeout\n");
+		mutex_unlock(&dsim->lock);
+		return 0;
+	}
+
+	msleep(20);
+
+	rx_data = s5p_mipi_dsi_rd_rx_fifo(dsim);
+
+	if ((u8)(rx_data & 0xff) != response) {
+		printk(KERN_ERR
+			"mipi dsi wrong response rx_data : %x, response:%x\n",
+			rx_data, response);
+		goto clear_rx_fifo;
+	}
+
+	if (req_size <= 2) {
+		/* for short packet */
+		for (i = 0; i < req_size; i++)
+			rx_buf[i] = (rx_data >> (8 + (i * 8))) & 0xff;
+		rxsize = req_size;
+	} else {
+		/* for long packet */
+		rxsize = s5p_mipi_dsi_long_data_rd(dsim, req_size, rx_data,
+						rx_buf);
+		if (rxsize != req_size)
+			goto clear_rx_fifo;
+	}
+
+	rcv_pkt = s5p_mipi_dsi_rd_rx_fifo(dsim);
+
+	msleep(20);
+
+	if (rcv_pkt != MIPI_RX_FIFO_READ_DONE) {
+		dev_info(dsim->dev,
+			"Can't found RX FIFO READ DONE FLAG : %x\n", rcv_pkt);
+		goto clear_rx_fifo;
+	}
+
+	mutex_unlock(&dsim->lock);
+
+	return rxsize;
+
+clear_rx_fifo:
+	i = 0;
+	while (1) {
+		rcv_pkt = s5p_mipi_dsi_rd_rx_fifo(dsim);
+		if ((rcv_pkt = MIPI_RX_FIFO_READ_DONE)
+				|| (i > MIPI_MAX_RX_FIFO))
+			break;
+		dev_dbg(dsim->dev,
+				"mipi dsi clear rx fifo : %08x\n", rcv_pkt);
+		i++;
+	}
+	dev_info(dsim->dev,
+		"mipi dsi rx done count : %d, rcv_pkt : %08x\n", i, rcv_pkt);
+
+	mutex_unlock(&dsim->lock);
+
+	return 0;
+}
+
+int s5p_mipi_dsi_pll_on(struct mipi_dsim_device *dsim, unsigned int enable)
+{
+	int sw_timeout;
+
+	if (enable) {
+		sw_timeout = 1000;
+
+		s5p_mipi_dsi_clear_interrupt(dsim);
+		s5p_mipi_dsi_enable_pll(dsim, 1);
+		while (1) {
+			sw_timeout--;
+			if (s5p_mipi_dsi_is_pll_stable(dsim))
+				return 0;
+			if (sw_timeout = 0)
+				return -EINVAL;
+		}
+	} else
+		s5p_mipi_dsi_enable_pll(dsim, 0);
+
+	return 0;
+}
+
+unsigned long s5p_mipi_dsi_change_pll(struct mipi_dsim_device *dsim,
+	unsigned int pre_divider, unsigned int main_divider,
+	unsigned int scaler)
+{
+	unsigned long dfin_pll, dfvco, dpll_out;
+	unsigned int i, freq_band = 0xf;
+
+	dfin_pll = (FIN_HZ / pre_divider);
+
+	/******************************************************
+	 *	Serial Clock(=ByteClk X 8)	FreqBand[3:0] *
+	 ******************************************************
+	 *	~ 99.99 MHz			0000
+	 *	100 ~ 119.99 MHz		0001
+	 *	120 ~ 159.99 MHz		0010
+	 *	160 ~ 199.99 MHz		0011
+	 *	200 ~ 239.99 MHz		0100
+	 *	140 ~ 319.99 MHz		0101
+	 *	320 ~ 389.99 MHz		0110
+	 *	390 ~ 449.99 MHz		0111
+	 *	450 ~ 509.99 MHz		1000
+	 *	510 ~ 559.99 MHz		1001
+	 *	560 ~ 639.99 MHz		1010
+	 *	640 ~ 689.99 MHz		1011
+	 *	690 ~ 769.99 MHz		1100
+	 *	770 ~ 869.99 MHz		1101
+	 *	870 ~ 949.99 MHz		1110
+	 *	950 ~ 1000 MHz			1111
+	 ******************************************************/
+	if (dfin_pll < DFIN_PLL_MIN_HZ || dfin_pll > DFIN_PLL_MAX_HZ) {
+		dev_warn(dsim->dev, "fin_pll range should be 6MHz ~ 12MHz\n");
+		s5p_mipi_dsi_enable_afc(dsim, 0, 0);
+	} else {
+		if (dfin_pll < 7 * MHZ)
+			s5p_mipi_dsi_enable_afc(dsim, 1, 0x1);
+		else if (dfin_pll < 8 * MHZ)
+			s5p_mipi_dsi_enable_afc(dsim, 1, 0x0);
+		else if (dfin_pll < 9 * MHZ)
+			s5p_mipi_dsi_enable_afc(dsim, 1, 0x3);
+		else if (dfin_pll < 10 * MHZ)
+			s5p_mipi_dsi_enable_afc(dsim, 1, 0x2);
+		else if (dfin_pll < 11 * MHZ)
+			s5p_mipi_dsi_enable_afc(dsim, 1, 0x5);
+		else
+			s5p_mipi_dsi_enable_afc(dsim, 1, 0x4);
+	}
+
+	dfvco = dfin_pll * main_divider;
+	dev_dbg(dsim->dev, "dfvco = %lu, dfin_pll = %lu, main_divider = %d\n",
+				dfvco, dfin_pll, main_divider);
+	if (dfvco < DFVCO_MIN_HZ || dfvco > DFVCO_MAX_HZ)
+		dev_warn(dsim->dev, "fvco range should be 500MHz ~ 1000MHz\n");
+
+	dpll_out = dfvco / (1 << scaler);
+	dev_dbg(dsim->dev, "dpll_out = %lu, dfvco = %lu, scaler = %d\n",
+		dpll_out, dfvco, scaler);
+
+	for (i = 0; i < ARRAY_SIZE(dpll_table); i++) {
+		if (dpll_out < dpll_table[i] * MHZ) {
+			freq_band = i;
+			break;
+		}
+	}
+
+	dev_dbg(dsim->dev, "freq_band = %d\n", freq_band);
+
+	s5p_mipi_dsi_pll_freq(dsim, pre_divider, main_divider, scaler);
+
+	s5p_mipi_dsi_hs_zero_ctrl(dsim, 0);
+	s5p_mipi_dsi_prep_ctrl(dsim, 0);
+
+	/* Freq Band */
+	s5p_mipi_dsi_pll_freq_band(dsim, freq_band);
+
+	/* Stable time */
+	s5p_mipi_dsi_pll_stable_time(dsim, dsim->dsim_config->pll_stable_time);
+
+	/* Enable PLL */
+	dev_dbg(dsim->dev, "FOUT of mipi dphy pll is %luMHz\n",
+		(dpll_out / MHZ));
+
+	return dpll_out;
+}
+
+int s5p_mipi_dsi_set_clock(struct mipi_dsim_device *dsim,
+	unsigned int byte_clk_sel, unsigned int enable)
+{
+	unsigned int esc_div;
+	unsigned long esc_clk_error_rate;
+	unsigned long hs_clk = 0, byte_clk = 0, escape_clk = 0;
+
+	if (enable) {
+		dsim->e_clk_src = byte_clk_sel;
+
+		/* Escape mode clock and byte clock source */
+		s5p_mipi_dsi_set_byte_clock_src(dsim, byte_clk_sel);
+
+		/* DPHY, DSIM Link : D-PHY clock out */
+		if (byte_clk_sel = DSIM_PLL_OUT_DIV8) {
+			hs_clk = s5p_mipi_dsi_change_pll(dsim,
+				dsim->dsim_config->p, dsim->dsim_config->m,
+				dsim->dsim_config->s);
+			if (hs_clk = 0) {
+				dev_err(dsim->dev,
+					"failed to get hs clock.\n");
+				return -EINVAL;
+			}
+
+			byte_clk = hs_clk / 8;
+			s5p_mipi_dsi_enable_pll_bypass(dsim, 0);
+			s5p_mipi_dsi_pll_on(dsim, 1);
+		/* DPHY : D-PHY clock out, DSIM link : external clock out */
+		} else if (byte_clk_sel = DSIM_EXT_CLK_DIV8) {
+			dev_warn(dsim->dev, "this project is not support\n");
+			dev_warn(dsim->dev,
+				"external clock source for MIPI DSIM.\n");
+		} else if (byte_clk_sel = DSIM_EXT_CLK_BYPASS) {
+			dev_warn(dsim->dev, "this project is not support\n");
+			dev_warn(dsim->dev,
+				"external clock source for MIPI DSIM\n");
+		}
+
+		/* escape clock divider */
+		esc_div = byte_clk / (dsim->dsim_config->esc_clk);
+		dev_dbg(dsim->dev,
+			"esc_div = %d, byte_clk = %lu, esc_clk = %lu\n",
+			esc_div, byte_clk, dsim->dsim_config->esc_clk);
+		if ((byte_clk / esc_div) >= (20 * MHZ) ||
+				(byte_clk / esc_div) >
+					dsim->dsim_config->esc_clk)
+			esc_div += 1;
+
+		escape_clk = byte_clk / esc_div;
+		dev_dbg(dsim->dev,
+			"escape_clk = %lu, byte_clk = %lu, esc_div = %d\n",
+			escape_clk, byte_clk, esc_div);
+
+		/* enable escape clock. */
+		s5p_mipi_dsi_enable_byte_clock(dsim, 1);
+
+		/* enable byte clk and escape clock */
+		s5p_mipi_dsi_set_esc_clk_prs(dsim, 1, esc_div);
+		/* escape clock on lane */
+		s5p_mipi_dsi_enable_esc_clk_on_lane(dsim,
+			(DSIM_LANE_CLOCK | dsim->data_lane), 1);
+
+		dev_dbg(dsim->dev, "byte clock is %luMHz\n",
+			(byte_clk / MHZ));
+		dev_dbg(dsim->dev, "escape clock that user's need is %lu\n",
+			(dsim->dsim_config->esc_clk / MHZ));
+		dev_dbg(dsim->dev, "escape clock divider is %x\n", esc_div);
+		dev_dbg(dsim->dev, "escape clock is %luMHz\n",
+			((byte_clk / esc_div) / MHZ));
+
+		if ((byte_clk / esc_div) > escape_clk) {
+			esc_clk_error_rate = escape_clk /
+				(byte_clk / esc_div);
+			dev_warn(dsim->dev, "error rate is %lu over.\n",
+				(esc_clk_error_rate / 100));
+		} else if ((byte_clk / esc_div) < (escape_clk)) {
+			esc_clk_error_rate = (byte_clk / esc_div) /
+				escape_clk;
+			dev_warn(dsim->dev, "error rate is %lu under.\n",
+				(esc_clk_error_rate / 100));
+		}
+	} else {
+		s5p_mipi_dsi_enable_esc_clk_on_lane(dsim,
+			(DSIM_LANE_CLOCK | dsim->data_lane), 0);
+		s5p_mipi_dsi_set_esc_clk_prs(dsim, 0, 0);
+
+		/* disable escape clock. */
+		s5p_mipi_dsi_enable_byte_clock(dsim, 0);
+
+		if (byte_clk_sel = DSIM_PLL_OUT_DIV8)
+			s5p_mipi_dsi_pll_on(dsim, 0);
+	}
+
+	return 0;
+}
+
+int s5p_mipi_dsi_init_dsim(struct mipi_dsim_device *dsim)
+{
+	dsim->state = DSIM_STATE_INIT;
+
+	switch (dsim->dsim_config->e_no_data_lane) {
+	case DSIM_DATA_LANE_1:
+		dsim->data_lane = DSIM_LANE_DATA0;
+		break;
+	case DSIM_DATA_LANE_2:
+		dsim->data_lane = DSIM_LANE_DATA0 | DSIM_LANE_DATA1;
+		break;
+	case DSIM_DATA_LANE_3:
+		dsim->data_lane = DSIM_LANE_DATA0 | DSIM_LANE_DATA1 |
+			DSIM_LANE_DATA2;
+		break;
+	case DSIM_DATA_LANE_4:
+		dsim->data_lane = DSIM_LANE_DATA0 | DSIM_LANE_DATA1 |
+			DSIM_LANE_DATA2 | DSIM_LANE_DATA3;
+		break;
+	default:
+		dev_info(dsim->dev, "data lane is invalid.\n");
+		return -EINVAL;
+	};
+
+	s5p_mipi_dsi_sw_reset(dsim);
+	s5p_mipi_dsi_func_reset(dsim);
+
+	s5p_mipi_dsi_dp_dn_swap(dsim, 0);
+
+	return 0;
+}
+
+void s5p_mipi_dsi_init_interrupt(struct mipi_dsim_device *dsim)
+{
+	unsigned int reg;
+
+	s5p_mipi_dsi_clear_all_interrupt(dsim);
+
+	reg = s5p_mipi_dsi_read_interrupt_mask(dsim);
+
+	reg &=  (INTMSK_BTA | INTMSK_RX_TIMEOUT |
+		INTMSK_BTA_TIMEOUT | INTMSK_RX_DONE |
+		INTMSK_RX_TE | INTMSK_RX_ACK |
+		INTMSK_RX_ECC_ERR | INTMSK_RX_CRC_ERR |
+		INTMSK_FIFO_EMPTY);
+
+	s5p_mipi_dsi_set_interrupt_mask(dsim, reg, 0);
+}
+
+int s5p_mipi_dsi_enable_frame_done_int(struct mipi_dsim_device *dsim,
+	unsigned int enable)
+{
+	/* enable only frame done interrupt */
+	s5p_mipi_dsi_set_interrupt_mask(dsim, INTMSK_FRAME_DONE, enable);
+
+	return 0;
+}
+
+void s5p_mipi_dsi_stand_by(struct mipi_dsim_device *dsim,
+		unsigned int enable)
+{
+
+	/* consider Main display and Sub display. */
+
+	s5p_mipi_dsi_set_main_stand_by(dsim, enable);
+}
+
+int s5p_mipi_dsi_set_display_mode(struct mipi_dsim_device *dsim,
+	struct mipi_dsim_config *dsim_config)
+{
+	struct mipi_dsim_platform_data *dsim_pd;
+	struct fb_videomode *timing;
+
+	dsim_pd = (struct mipi_dsim_platform_data *)dsim->pd;
+	timing = (struct fb_videomode *)dsim_pd->lcd_panel_info;
+
+	/* in case of VIDEO MODE (RGB INTERFACE), it sets polarities. */
+	if (dsim_config->e_interface = (u32) DSIM_VIDEO) {
+		if (dsim_config->auto_vertical_cnt = 0) {
+			s5p_mipi_dsi_set_main_disp_vporch(dsim,
+				dsim_config->cmd_allow,
+				timing->upper_margin,
+				timing->lower_margin);
+			s5p_mipi_dsi_set_main_disp_hporch(dsim,
+				timing->left_margin,
+				timing->right_margin);
+			s5p_mipi_dsi_set_main_disp_sync_area(dsim,
+				timing->vsync_len,
+				timing->hsync_len);
+		}
+	}
+
+	s5p_mipi_dsi_set_main_disp_resol(dsim, timing->xres,
+			timing->yres);
+
+	s5p_mipi_dsi_display_config(dsim, dsim_config);
+
+	dev_info(dsim->dev, "lcd panel => width = %d, height = %d\n",
+			timing->xres, timing->yres);
+
+	return 0;
+}
+
+int s5p_mipi_dsi_init_link(struct mipi_dsim_device *dsim)
+{
+	unsigned int time_out = 100;
+
+	switch (dsim->state) {
+	case DSIM_STATE_INIT:
+		s5p_mipi_dsi_init_fifo_pointer(dsim, 0x1f);
+
+		/* dsi configuration */
+		s5p_mipi_dsi_init_config(dsim);
+		s5p_mipi_dsi_enable_lane(dsim, DSIM_LANE_CLOCK, 1);
+		s5p_mipi_dsi_enable_lane(dsim, dsim->data_lane, 1);
+
+		/* set clock configuration */
+		s5p_mipi_dsi_set_clock(dsim, dsim->dsim_config->e_byte_clk, 1);
+
+		/* check clock and data lane state are stop state */
+		while (!(s5p_mipi_dsi_is_lane_state(dsim))) {
+			time_out--;
+			if (time_out = 0) {
+				dev_err(dsim->dev,
+					"DSI Master is not stop state.\n");
+				dev_err(dsim->dev,
+					"Check initialization process\n");
+
+				return -EINVAL;
+			}
+		}
+		if (time_out != 0) {
+			dev_info(dsim->dev,
+				"DSI Master driver has been completed.\n");
+			dev_info(dsim->dev, "DSI Master state is stop state\n");
+		}
+
+		dsim->state = DSIM_STATE_STOP;
+
+		/* BTA sequence counters */
+		s5p_mipi_dsi_set_stop_state_counter(dsim,
+			dsim->dsim_config->stop_holding_cnt);
+		s5p_mipi_dsi_set_bta_timeout(dsim,
+			dsim->dsim_config->bta_timeout);
+		s5p_mipi_dsi_set_lpdr_timeout(dsim,
+			dsim->dsim_config->rx_timeout);
+
+		return 0;
+	default:
+		dev_info(dsim->dev, "DSI Master is already init.\n");
+		return 0;
+	}
+
+	return 0;
+}
+
+int s5p_mipi_dsi_set_hs_enable(struct mipi_dsim_device *dsim)
+{
+	if (dsim->state = DSIM_STATE_STOP) {
+		if (dsim->e_clk_src != DSIM_EXT_CLK_BYPASS) {
+			dsim->state = DSIM_STATE_HSCLKEN;
+
+			 /* set LCDC and CPU transfer mode to HS. */
+			s5p_mipi_dsi_set_lcdc_transfer_mode(dsim, 0);
+			s5p_mipi_dsi_set_cpu_transfer_mode(dsim, 0);
+
+			s5p_mipi_dsi_enable_hs_clock(dsim, 1);
+
+			return 0;
+		} else
+			dev_warn(dsim->dev,
+				"clock source is external bypass.\n");
+	} else
+		dev_warn(dsim->dev, "DSIM is not stop state.\n");
+
+	return 0;
+}
+
+int s5p_mipi_dsi_set_data_transfer_mode(struct mipi_dsim_device *dsim,
+		unsigned int mode)
+{
+	if (mode) {
+		if (dsim->state != DSIM_STATE_HSCLKEN) {
+			dev_err(dsim->dev, "HS Clock lane is not enabled.\n");
+			return -EINVAL;
+		}
+
+		s5p_mipi_dsi_set_lcdc_transfer_mode(dsim, 0);
+	} else {
+		if (dsim->state = DSIM_STATE_INIT || dsim->state =
+			DSIM_STATE_ULPS) {
+			dev_err(dsim->dev,
+				"DSI Master is not STOP or HSDT state.\n");
+			return -EINVAL;
+		}
+
+		s5p_mipi_dsi_set_cpu_transfer_mode(dsim, 0);
+	}
+
+	return 0;
+}
+
+int s5p_mipi_dsi_get_frame_done_status(struct mipi_dsim_device *dsim)
+{
+	return _s5p_mipi_dsi_get_frame_done_status(dsim);
+}
+
+int s5p_mipi_dsi_clear_frame_done(struct mipi_dsim_device *dsim)
+{
+	_s5p_mipi_dsi_clear_frame_done(dsim);
+
+	return 0;
+}
+
+MODULE_AUTHOR("InKi Dae <inki.dae@samsung.com>");
+MODULE_DESCRIPTION("Samusung SoC MIPI-DSI common driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/s5p_mipi_dsi_common.h b/drivers/video/s5p_mipi_dsi_common.h
new file mode 100644
index 0000000..89f065a
--- /dev/null
+++ b/drivers/video/s5p_mipi_dsi_common.h
@@ -0,0 +1,48 @@
+/* linux/drivers/video/s5p_mipi_dsi_common.h
+ *
+ * Header file for Samsung SoC MIPI-DSI common driver.
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd
+ *
+ * InKi Dae <inki.dae@samsung.com>
+ * Donghwa Lee <dh09.lee@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef _S5P_MIPI_DSI_COMMON_H
+#define _S5P_MIPI_DSI_COMMON_H
+
+static DECLARE_COMPLETION(dsim_rd_comp);
+
+int s5p_mipi_dsi_wr_data(struct mipi_dsim_device *dsim, unsigned int data_id,
+	unsigned int data0, unsigned int data1);
+int s5p_mipi_dsi_rd_data(struct mipi_dsim_device *dsim, unsigned int data_id,
+	unsigned int data0, unsigned int req_size, u8 *rx_buf);
+int s5p_mipi_dsi_pll_on(struct mipi_dsim_device *dsim, unsigned int enable);
+unsigned long s5p_mipi_dsi_change_pll(struct mipi_dsim_device *dsim,
+	unsigned int pre_divider, unsigned int main_divider,
+	unsigned int scaler);
+irqreturn_t s5p_mipi_dsi_interrupt_handler(int irq, void *dev_id);
+void s5p_mipi_dsi_init_interrupt(struct mipi_dsim_device *dsim);
+int s5p_mipi_dsi_set_clock(struct mipi_dsim_device *dsim,
+	unsigned int byte_clk_sel, unsigned int enable);
+int s5p_mipi_dsi_init_dsim(struct mipi_dsim_device *dsim);
+void s5p_mipi_dsi_stand_by(struct mipi_dsim_device *dsim,
+		unsigned int enable);
+int s5p_mipi_dsi_set_display_mode(struct mipi_dsim_device *dsim,
+			struct mipi_dsim_config *dsim_info);
+int s5p_mipi_dsi_init_link(struct mipi_dsim_device *dsim);
+int s5p_mipi_dsi_set_hs_enable(struct mipi_dsim_device *dsim);
+int s5p_mipi_dsi_set_data_transfer_mode(struct mipi_dsim_device *dsim,
+		unsigned int mode);
+int s5p_mipi_dsi_enable_frame_done_int(struct mipi_dsim_device *dsim,
+	unsigned int enable);
+int s5p_mipi_dsi_get_frame_done_status(struct mipi_dsim_device *dsim);
+int s5p_mipi_dsi_clear_frame_done(struct mipi_dsim_device *dsim);
+
+extern struct fb_info *registered_fb[FB_MAX] __read_mostly;
+
+#endif /* _S5P_MIPI_DSI_COMMON_H */
diff --git a/drivers/video/s5p_mipi_dsi_lowlevel.c b/drivers/video/s5p_mipi_dsi_lowlevel.c
new file mode 100644
index 0000000..e6a9358
--- /dev/null
+++ b/drivers/video/s5p_mipi_dsi_lowlevel.c
@@ -0,0 +1,608 @@
+/* linux/drivers/video/s5p_mipi_dsi_lowlevel.c
+ *
+ * Samsung SoC MIPI-DSI lowlevel driver.
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd
+ *
+ * InKi Dae, <inki.dae@samsung.com>
+ * Donghwa Lee, <dh09.lee@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/ctype.h>
+#include <linux/io.h>
+#include <linux/mipi_dsim.h>
+
+#include <mach/map.h>
+#include <plat/mipi_dsim.h>
+
+#include "s5p_mipi_dsi_regs.h"
+
+void s5p_mipi_dsi_func_reset(struct mipi_dsim_device *dsim)
+{
+	unsigned int reg;
+
+	reg = readl(dsim->reg_base + S5P_DSIM_SWRST);
+
+	reg |= DSIM_FUNCRST;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_SWRST);
+}
+
+void s5p_mipi_dsi_sw_reset(struct mipi_dsim_device *dsim)
+{
+	unsigned int reg;
+
+	reg = readl(dsim->reg_base + S5P_DSIM_SWRST);
+
+	reg |= DSIM_SWRST;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_SWRST);
+}
+
+unsigned int s5p_mipi_dsi_read_interrupt_mask(struct mipi_dsim_device *dsim)
+{
+	unsigned int reg;
+
+	reg = readl(dsim->reg_base + S5P_DSIM_INTMSK);
+
+	return reg;
+}
+
+void s5p_mipi_dsi_set_interrupt_mask(struct mipi_dsim_device *dsim,
+		unsigned int mode, unsigned int mask)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_INTMSK);
+
+	if (mask)
+		reg |= mode;
+	else
+		reg &= ~mode;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_INTMSK);
+}
+
+void s5p_mipi_dsi_init_fifo_pointer(struct mipi_dsim_device *dsim,
+		unsigned int cfg)
+{
+	unsigned int reg;
+
+	reg = readl(dsim->reg_base + S5P_DSIM_FIFOCTRL);
+
+	writel(reg & ~(cfg), dsim->reg_base + S5P_DSIM_FIFOCTRL);
+	mdelay(10);
+	reg |= cfg;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_FIFOCTRL);
+}
+
+/*
+ * this function set PLL P, M and S value in D-PHY
+ */
+void s5p_mipi_dsi_set_phy_tunning(struct mipi_dsim_device *dsim,
+		unsigned int value)
+{
+	writel(DSIM_AFC_CTL(value), dsim->reg_base + S5P_DSIM_PHYACCHR);
+}
+
+void s5p_mipi_dsi_set_main_stand_by(struct mipi_dsim_device *dsim,
+		unsigned int enable)
+{
+	unsigned int reg;
+
+	reg = readl(dsim->reg_base + S5P_DSIM_MDRESOL);
+
+	reg &= ~DSIM_MAIN_STAND_BY;
+
+	if (enable)
+		reg |= DSIM_MAIN_STAND_BY;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_MDRESOL);
+}
+
+void s5p_mipi_dsi_set_main_disp_resol(struct mipi_dsim_device *dsim,
+	unsigned int width_resol, unsigned int height_resol)
+{
+	unsigned int reg;
+
+	/* standby should be set after configuration so set to not ready*/
+	reg = (readl(dsim->reg_base + S5P_DSIM_MDRESOL)) &
+		~(DSIM_MAIN_STAND_BY);
+	writel(reg, dsim->reg_base + S5P_DSIM_MDRESOL);
+
+	reg &= ~((0x7ff << 16) | (0x7ff << 0));
+	reg |= DSIM_MAIN_VRESOL(height_resol) | DSIM_MAIN_HRESOL(width_resol);
+
+	reg |= DSIM_MAIN_STAND_BY;
+	writel(reg, dsim->reg_base + S5P_DSIM_MDRESOL);
+}
+
+void s5p_mipi_dsi_set_main_disp_vporch(struct mipi_dsim_device *dsim,
+	unsigned int cmd_allow, unsigned int vfront, unsigned int vback)
+{
+	unsigned int reg;
+
+	reg = (readl(dsim->reg_base + S5P_DSIM_MVPORCH)) &
+		~((DSIM_CMD_ALLOW_MASK) | (DSIM_STABLE_VFP_MASK) |
+		(DSIM_MAIN_VBP_MASK));
+
+	reg |= ((cmd_allow & 0xf) << DSIM_CMD_ALLOW_SHIFT) |
+		((vfront & 0x7ff) << DSIM_STABLE_VFP_SHIFT) |
+		((vback & 0x7ff) << DSIM_MAIN_VBP_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_MVPORCH);
+}
+
+void s5p_mipi_dsi_set_main_disp_hporch(struct mipi_dsim_device *dsim,
+	unsigned int front, unsigned int back)
+{
+	unsigned int reg;
+
+	reg = (readl(dsim->reg_base + S5P_DSIM_MHPORCH)) &
+		~((DSIM_MAIN_HFP_MASK) | (DSIM_MAIN_HBP_MASK));
+
+	reg |= (front << DSIM_MAIN_HFP_SHIFT) | (back << DSIM_MAIN_HBP_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_MHPORCH);
+}
+
+void s5p_mipi_dsi_set_main_disp_sync_area(struct mipi_dsim_device *dsim,
+	unsigned int vert, unsigned int hori)
+{
+	unsigned int reg;
+
+	reg = (readl(dsim->reg_base + S5P_DSIM_MSYNC)) &
+		~((DSIM_MAIN_VSA_MASK) | (DSIM_MAIN_HSA_MASK));
+
+	reg |= ((vert & 0x3ff) << DSIM_MAIN_VSA_SHIFT) |
+		(hori << DSIM_MAIN_HSA_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_MSYNC);
+}
+
+void s5p_mipi_dsi_set_sub_disp_resol(struct mipi_dsim_device *dsim,
+	unsigned int vert, unsigned int hori)
+{
+	unsigned int reg;
+
+	reg = (readl(dsim->reg_base + S5P_DSIM_SDRESOL)) &
+		~(DSIM_SUB_STANDY_MASK);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_SDRESOL);
+
+	reg &= ~(DSIM_SUB_VRESOL_MASK) | ~(DSIM_SUB_HRESOL_MASK);
+	reg |= ((vert & 0x7ff) << DSIM_SUB_VRESOL_SHIFT) |
+		((hori & 0x7ff) << DSIM_SUB_HRESOL_SHIFT);
+	writel(reg, dsim->reg_base + S5P_DSIM_SDRESOL);
+
+	reg |= (1 << DSIM_SUB_STANDY_SHIFT);
+	writel(reg, dsim->reg_base + S5P_DSIM_SDRESOL);
+}
+
+void s5p_mipi_dsi_init_config(struct mipi_dsim_device *dsim)
+{
+	struct mipi_dsim_config *dsim_config = dsim->dsim_config;
+
+	unsigned int cfg = (readl(dsim->reg_base + S5P_DSIM_CONFIG)) &
+		~((1 << 28) | (0x1f << 20) | (0x3 << 5));
+
+	cfg =	(dsim_config->auto_flush << 29) |
+		(dsim_config->eot_disable << 28) |
+		(dsim_config->auto_vertical_cnt << DSIM_AUTO_MODE_SHIFT) |
+		(dsim_config->hse << DSIM_HSE_MODE_SHIFT) |
+		(dsim_config->hfp << DSIM_HFP_MODE_SHIFT) |
+		(dsim_config->hbp << DSIM_HBP_MODE_SHIFT) |
+		(dsim_config->hsa << DSIM_HSA_MODE_SHIFT) |
+		(dsim_config->e_no_data_lane << DSIM_NUM_OF_DATALANE_SHIFT);
+
+	writel(cfg, dsim->reg_base + S5P_DSIM_CONFIG);
+}
+
+void s5p_mipi_dsi_display_config(struct mipi_dsim_device *dsim,
+				struct mipi_dsim_config *dsim_config)
+{
+	u32 reg = (readl(dsim->reg_base + S5P_DSIM_CONFIG)) &
+		~((0x3 << 26) | (1 << 25) | (0x3 << 18) | (0x7 << 12) |
+		(0x3 << 16) | (0x7 << 8));
+
+	if (dsim_config->e_interface = DSIM_VIDEO)
+		reg |= (1 << 25);
+	else if (dsim_config->e_interface = DSIM_COMMAND)
+		reg &= ~(1 << 25);
+	else {
+		dev_err(dsim->dev, "unknown lcd type.\n");
+		return;
+	}
+
+	/* main lcd */
+	reg |= ((u8) (dsim_config->e_burst_mode) & 0x3) << 26 |
+		((u8) (dsim_config->e_virtual_ch) & 0x3) << 18 |
+		((u8) (dsim_config->e_pixel_format) & 0x7) << 12;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CONFIG);
+}
+
+void s5p_mipi_dsi_enable_lane(struct mipi_dsim_device *dsim, unsigned int lane,
+	unsigned int enable)
+{
+	unsigned int reg;
+
+	reg = readl(dsim->reg_base + S5P_DSIM_CONFIG);
+
+	if (enable)
+		reg |= DSIM_LANE_ENx(lane);
+	else
+		reg &= ~DSIM_LANE_ENx(lane);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CONFIG);
+}
+
+
+void s5p_mipi_dsi_set_data_lane_number(struct mipi_dsim_device *dsim,
+	unsigned int count)
+{
+	unsigned int cfg;
+
+	/* get the data lane number. */
+	cfg = DSIM_NUM_OF_DATA_LANE(count);
+
+	writel(cfg, dsim->reg_base + S5P_DSIM_CONFIG);
+}
+
+void s5p_mipi_dsi_enable_afc(struct mipi_dsim_device *dsim, unsigned int enable,
+	unsigned int afc_code)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_PHYACCHR);
+
+	if (enable) {
+		reg |= (1 << 14);
+		reg &= ~(0x7 << 5);
+		reg |= (afc_code & 0x7) << 5;
+	} else
+		reg &= ~(1 << 14);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PHYACCHR);
+}
+
+void s5p_mipi_dsi_enable_pll_bypass(struct mipi_dsim_device *dsim,
+	unsigned int enable)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)) &
+		~(DSIM_PLL_BYPASS_EXTERNAL);
+
+	reg |= enable << DSIM_PLL_BYPASS_SHIFT;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_mipi_dsi_set_pll_pms(struct mipi_dsim_device *dsim, unsigned int p,
+	unsigned int m, unsigned int s)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_PLLCTRL);
+
+	reg |= ((p & 0x3f) << 13) | ((m & 0x1ff) << 4) | ((s & 0x7) << 1);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_mipi_dsi_pll_freq_band(struct mipi_dsim_device *dsim,
+		unsigned int freq_band)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)) &
+		~(0x1f << DSIM_FREQ_BAND_SHIFT);
+
+	reg |= ((freq_band & 0x1f) << DSIM_FREQ_BAND_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_mipi_dsi_pll_freq(struct mipi_dsim_device *dsim,
+		unsigned int pre_divider, unsigned int main_divider,
+		unsigned int scaler)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)) &
+		~(0x7ffff << 1);
+
+	reg |= (pre_divider & 0x3f) << 13 | (main_divider & 0x1ff) << 4 |
+		(scaler & 0x7) << 1;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_mipi_dsi_pll_stable_time(struct mipi_dsim_device *dsim,
+	unsigned int lock_time)
+{
+	writel(lock_time, dsim->reg_base + S5P_DSIM_PLLTMR);
+}
+
+void s5p_mipi_dsi_enable_pll(struct mipi_dsim_device *dsim, unsigned int enable)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)) &
+		~(0x1 << DSIM_PLL_EN_SHIFT);
+
+	reg |= ((enable & 0x1) << DSIM_PLL_EN_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_mipi_dsi_set_byte_clock_src(struct mipi_dsim_device *dsim,
+		unsigned int src)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)) &
+		~(0x3 << DSIM_BYTE_CLK_SRC_SHIFT);
+
+	reg |= ((unsigned int) src) << DSIM_BYTE_CLK_SRC_SHIFT;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_mipi_dsi_enable_byte_clock(struct mipi_dsim_device *dsim,
+		unsigned int enable)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)) &
+		~(1 << DSIM_BYTE_CLKEN_SHIFT);
+
+	reg |= enable << DSIM_BYTE_CLKEN_SHIFT;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_mipi_dsi_set_esc_clk_prs(struct mipi_dsim_device *dsim,
+		unsigned int enable, unsigned int prs_val)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)) &
+		~((1 << DSIM_ESC_CLKEN_SHIFT) | (0xffff));
+
+	reg |= enable << DSIM_ESC_CLKEN_SHIFT;
+	if (enable)
+		reg |= prs_val;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_mipi_dsi_enable_esc_clk_on_lane(struct mipi_dsim_device *dsim,
+		unsigned int lane_sel, unsigned int enable)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_CLKCTRL);
+
+	if (enable)
+		reg |= DSIM_LANE_ESC_CLKEN(lane_sel);
+	else
+
+		reg &= ~DSIM_LANE_ESC_CLKEN(lane_sel);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_mipi_dsi_force_dphy_stop_state(struct mipi_dsim_device *dsim,
+	unsigned int enable)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_ESCMODE)) &
+		~(0x1 << DSIM_FORCE_STOP_STATE_SHIFT);
+
+	reg |= ((enable & 0x1) << DSIM_FORCE_STOP_STATE_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_ESCMODE);
+}
+
+unsigned int s5p_mipi_dsi_is_lane_state(struct mipi_dsim_device *dsim)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_STATUS);
+
+	/**
+	 * check clock and data lane states.
+	 * if MIPI-DSI controller was enabled at bootloader then
+	 * TX_READY_HS_CLK is enabled otherwise STOP_STATE_CLK.
+	 * so it should be checked for two case.
+	 */
+	if ((reg & DSIM_STOP_STATE_DAT(0xf)) &&
+			((reg & DSIM_STOP_STATE_CLK) ||
+			 (reg & DSIM_TX_READY_HS_CLK)))
+		return 1;
+	else
+		return 0;
+
+	return 0;
+}
+
+void s5p_mipi_dsi_set_stop_state_counter(struct mipi_dsim_device *dsim,
+		unsigned int cnt_val)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_ESCMODE)) &
+		~(0x7ff << DSIM_STOP_STATE_CNT_SHIFT);
+
+	reg |= ((cnt_val & 0x7ff) << DSIM_STOP_STATE_CNT_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_ESCMODE);
+}
+
+void s5p_mipi_dsi_set_bta_timeout(struct mipi_dsim_device *dsim,
+		unsigned int timeout)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_TIMEOUT)) &
+		~(0xff << DSIM_BTA_TOUT_SHIFT);
+
+	reg |= (timeout << DSIM_BTA_TOUT_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_TIMEOUT);
+}
+
+void s5p_mipi_dsi_set_lpdr_timeout(struct mipi_dsim_device *dsim,
+		unsigned int timeout)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_TIMEOUT)) &
+		~(0xffff << DSIM_LPDR_TOUT_SHIFT);
+
+	reg |= (timeout << DSIM_LPDR_TOUT_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_TIMEOUT);
+}
+
+void s5p_mipi_dsi_set_cpu_transfer_mode(struct mipi_dsim_device *dsim,
+		unsigned int lp)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_ESCMODE);
+
+	reg &= ~DSIM_CMD_LPDT_LP;
+
+	if (lp)
+		reg |= DSIM_CMD_LPDT_LP;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_ESCMODE);
+}
+
+void s5p_mipi_dsi_set_lcdc_transfer_mode(struct mipi_dsim_device *dsim,
+		unsigned int lp)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_ESCMODE);
+
+	reg &= ~DSIM_TX_LPDT_LP;
+
+	if (lp)
+		reg |= DSIM_TX_LPDT_LP;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_ESCMODE);
+}
+
+void s5p_mipi_dsi_enable_hs_clock(struct mipi_dsim_device *dsim,
+		unsigned int enable)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)) &
+		~(1 << DSIM_TX_REQUEST_HSCLK_SHIFT);
+
+	reg |= enable << DSIM_TX_REQUEST_HSCLK_SHIFT;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_mipi_dsi_dp_dn_swap(struct mipi_dsim_device *dsim,
+		unsigned int swap_en)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_PHYACCHR1);
+
+	reg &= ~(0x3 << 0);
+	reg |= (swap_en & 0x3) << 0;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PHYACCHR1);
+}
+
+void s5p_mipi_dsi_hs_zero_ctrl(struct mipi_dsim_device *dsim,
+		unsigned int hs_zero)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)) &
+		~(0xf << 28);
+
+	reg |= ((hs_zero & 0xf) << 28);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_mipi_dsi_prep_ctrl(struct mipi_dsim_device *dsim, unsigned int prep)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)) &
+		~(0x7 << 20);
+
+	reg |= ((prep & 0x7) << 20);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+unsigned int s5p_mipi_dsi_read_interrupt(struct mipi_dsim_device *dsim)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_INTSRC);
+
+	return reg;
+}
+
+void s5p_mipi_dsi_clear_interrupt(struct mipi_dsim_device *dsim)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_INTSRC);
+
+	reg |= INTSRC_PLL_STABLE;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_INTSRC);
+}
+
+void s5p_mipi_dsi_clear_all_interrupt(struct mipi_dsim_device *dsim)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_INTSRC);
+
+	reg |= 0xffffffff;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_INTSRC);
+}
+
+unsigned int s5p_mipi_dsi_is_pll_stable(struct mipi_dsim_device *dsim)
+{
+	unsigned int reg;
+
+	reg = readl(dsim->reg_base + S5P_DSIM_STATUS);
+
+	return reg & (1 << 31) ? 1 : 0;
+}
+
+unsigned int s5p_mipi_dsi_get_fifo_state(struct mipi_dsim_device *dsim)
+{
+	unsigned int ret;
+
+	ret = readl(dsim->reg_base + S5P_DSIM_FIFOCTRL) & ~(0x1f);
+
+	return ret;
+}
+
+void s5p_mipi_dsi_wr_pkt_header(struct mipi_dsim_device *dsim,
+	unsigned int di, unsigned int data0, unsigned int data1)
+{
+	unsigned int reg = (data1 << 16) | (data0 << 8) | ((di & 0x3f) << 0);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PKTHDR);
+}
+
+void s5p_mipi_dsi_rd_pkt_header(struct mipi_dsim_device *dsim,
+	unsigned int di, unsigned int data0)
+{
+	unsigned int reg = (data0 << 8) | (di << 0);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PKTHDR);
+}
+
+unsigned int s5p_mipi_dsi_rd_rx_fifo(struct mipi_dsim_device *dsim)
+{
+	unsigned int reg = 0;
+
+	reg = readl(dsim->reg_base + S5P_DSIM_RXFIFO);
+
+	return reg;
+}
+
+unsigned int _s5p_mipi_dsi_get_frame_done_status(struct mipi_dsim_device *dsim)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_INTSRC);
+
+	return (reg & INTSRC_FRAME_DONE) ? 1 : 0;
+}
+
+void _s5p_mipi_dsi_clear_frame_done(struct mipi_dsim_device *dsim)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_INTSRC);
+
+	writel(reg | INTSRC_FRAME_DONE, dsim->reg_base +
+		S5P_DSIM_INTSRC);
+}
+
+void s5p_mipi_dsi_wr_tx_data(struct mipi_dsim_device *dsim,
+		unsigned int tx_data)
+{
+	writel(tx_data, dsim->reg_base + S5P_DSIM_PAYLOAD);
+}
diff --git a/drivers/video/s5p_mipi_dsi_lowlevel.h b/drivers/video/s5p_mipi_dsi_lowlevel.h
new file mode 100644
index 0000000..d224fce
--- /dev/null
+++ b/drivers/video/s5p_mipi_dsi_lowlevel.h
@@ -0,0 +1,108 @@
+/* linux/drivers/video/s5p_mipi_dsi_lowlevel.h
+ *
+ * Header file for Samsung SoC MIPI-DSI lowlevel driver.
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd
+ *
+ * InKi Dae <inki.dae@samsung.com>
+ * Donghwa Lee <dh09.lee@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef _S5P_MIPI_DSI_LOWLEVEL_H
+#define _S5P_MIPI_DSI_LOWLEVEL_H
+
+void s5p_mipi_dsi_func_reset(struct mipi_dsim_device *dsim);
+void s5p_mipi_dsi_sw_reset(struct mipi_dsim_device *dsim);
+void s5p_mipi_dsi_set_interrupt_mask(struct mipi_dsim_device *dsim,
+	unsigned int mode, unsigned int mask);
+void s5p_mipi_dsi_set_data_lane_number(struct mipi_dsim_device *dsim,
+					unsigned int count);
+void s5p_mipi_dsi_init_fifo_pointer(struct mipi_dsim_device *dsim,
+					unsigned int cfg);
+void s5p_mipi_dsi_set_phy_tunning(struct mipi_dsim_device *dsim,
+				unsigned int value);
+void s5p_mipi_dsi_set_phy_tunning(struct mipi_dsim_device *dsim,
+				unsigned int value);
+void s5p_mipi_dsi_set_main_stand_by(struct mipi_dsim_device *dsim,
+		unsigned int enable);
+void s5p_mipi_dsi_set_main_disp_resol(struct mipi_dsim_device *dsim,
+		unsigned int width_resol, unsigned int height_resol);
+void s5p_mipi_dsi_set_main_disp_vporch(struct mipi_dsim_device *dsim,
+	unsigned int cmd_allow, unsigned int vfront, unsigned int vback);
+void s5p_mipi_dsi_set_main_disp_hporch(struct mipi_dsim_device *dsim,
+			unsigned int front, unsigned int back);
+void s5p_mipi_dsi_set_main_disp_sync_area(struct mipi_dsim_device *dsim,
+				unsigned int vert, unsigned int hori);
+void s5p_mipi_dsi_set_sub_disp_resol(struct mipi_dsim_device *dsim,
+				unsigned int vert, unsigned int hori);
+void s5p_mipi_dsi_init_config(struct mipi_dsim_device *dsim);
+void s5p_mipi_dsi_display_config(struct mipi_dsim_device *dsim,
+				struct mipi_dsim_config *dsim_config);
+void s5p_mipi_dsi_set_data_lane_number(struct mipi_dsim_device *dsim,
+				unsigned int count);
+void s5p_mipi_dsi_enable_lane(struct mipi_dsim_device *dsim, unsigned int lane,
+				unsigned int enable);
+void s5p_mipi_dsi_enable_afc(struct mipi_dsim_device *dsim, unsigned int enable,
+				unsigned int afc_code);
+void s5p_mipi_dsi_enable_pll_bypass(struct mipi_dsim_device *dsim,
+				unsigned int enable);
+void s5p_mipi_dsi_set_pll_pms(struct mipi_dsim_device *dsim, unsigned int p,
+				unsigned int m, unsigned int s);
+void s5p_mipi_dsi_pll_freq_band(struct mipi_dsim_device *dsim,
+				unsigned int freq_band);
+void s5p_mipi_dsi_pll_freq(struct mipi_dsim_device *dsim,
+			unsigned int pre_divider, unsigned int main_divider,
+			unsigned int scaler);
+void s5p_mipi_dsi_pll_stable_time(struct mipi_dsim_device *dsim,
+			unsigned int lock_time);
+void s5p_mipi_dsi_enable_pll(struct mipi_dsim_device *dsim,
+					unsigned int enable);
+void s5p_mipi_dsi_set_byte_clock_src(struct mipi_dsim_device *dsim,
+					unsigned int src);
+void s5p_mipi_dsi_enable_byte_clock(struct mipi_dsim_device *dsim,
+					unsigned int enable);
+void s5p_mipi_dsi_set_esc_clk_prs(struct mipi_dsim_device *dsim,
+				unsigned int enable, unsigned int prs_val);
+void s5p_mipi_dsi_enable_esc_clk_on_lane(struct mipi_dsim_device *dsim,
+				unsigned int lane_sel, unsigned int enable);
+void s5p_mipi_dsi_force_dphy_stop_state(struct mipi_dsim_device *dsim,
+				unsigned int enable);
+unsigned int s5p_mipi_dsi_is_lane_state(struct mipi_dsim_device *dsim);
+void s5p_mipi_dsi_set_stop_state_counter(struct mipi_dsim_device *dsim,
+				unsigned int cnt_val);
+void s5p_mipi_dsi_set_bta_timeout(struct mipi_dsim_device *dsim,
+				unsigned int timeout);
+void s5p_mipi_dsi_set_lpdr_timeout(struct mipi_dsim_device *dsim,
+				unsigned int timeout);
+void s5p_mipi_dsi_set_lcdc_transfer_mode(struct mipi_dsim_device *dsim,
+					unsigned int lp);
+void s5p_mipi_dsi_set_cpu_transfer_mode(struct mipi_dsim_device *dsim,
+					unsigned int lp);
+void s5p_mipi_dsi_enable_hs_clock(struct mipi_dsim_device *dsim,
+				unsigned int enable);
+void s5p_mipi_dsi_dp_dn_swap(struct mipi_dsim_device *dsim,
+				unsigned int swap_en);
+void s5p_mipi_dsi_hs_zero_ctrl(struct mipi_dsim_device *dsim,
+				unsigned int hs_zero);
+void s5p_mipi_dsi_prep_ctrl(struct mipi_dsim_device *dsim, unsigned int prep);
+unsigned int s5p_mipi_dsi_read_interrupt(struct mipi_dsim_device *dsim);
+unsigned int s5p_mipi_dsi_read_interrupt_mask(struct mipi_dsim_device *dsim);
+void s5p_mipi_dsi_clear_interrupt(struct mipi_dsim_device *dsim);
+void s5p_mipi_dsi_clear_all_interrupt(struct mipi_dsim_device *dsim);
+unsigned int s5p_mipi_dsi_is_pll_stable(struct mipi_dsim_device *dsim);
+unsigned int s5p_mipi_dsi_get_fifo_state(struct mipi_dsim_device *dsim);
+unsigned int _s5p_mipi_dsi_get_frame_done_status(struct mipi_dsim_device *dsim);
+void _s5p_mipi_dsi_clear_frame_done(struct mipi_dsim_device *dsim);
+void s5p_mipi_dsi_wr_pkt_header(struct mipi_dsim_device *dsim, unsigned int di,
+				unsigned int data0, unsigned int data1);
+void s5p_mipi_dsi_wr_tx_data(struct mipi_dsim_device *dsim,
+		unsigned int tx_data);
+void s5p_mipi_dsi_rd_pkt_header(struct mipi_dsim_device *dsim,
+		unsigned int data0, unsigned int data1);
+unsigned int s5p_mipi_dsi_rd_rx_fifo(struct mipi_dsim_device *dsim);
+
+#endif /* _S5P_MIPI_DSI_LOWLEVEL_H */
diff --git a/drivers/video/s5p_mipi_dsi_regs.h b/drivers/video/s5p_mipi_dsi_regs.h
new file mode 100644
index 0000000..e1e488f
--- /dev/null
+++ b/drivers/video/s5p_mipi_dsi_regs.h
@@ -0,0 +1,153 @@
+/* linux/driver/video/s5p_mipi_dsi_regs.h
+ *
+ * Register definition file for Samsung MIPI-DSIM driver
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd
+ *
+ * InKi Dae <inki.dae@samsung.com>
+ * Donghwa Lee <dh09.lee@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef _REGS_DSIM_H
+#define _REGS_DSIM_H
+
+#define S5P_DSIM_STATUS		(0x0)	/* Status register */
+#define S5P_DSIM_SWRST		(0x4)	/* Software reset register */
+#define S5P_DSIM_CLKCTRL	(0x8)	/* Clock control register */
+#define S5P_DSIM_TIMEOUT	(0xc)	/* Time out register */
+#define S5P_DSIM_CONFIG		(0x10)	/* Configuration register */
+#define S5P_DSIM_ESCMODE	(0x14)	/* Escape mode register */
+
+/* Main display image resolution register */
+#define S5P_DSIM_MDRESOL	(0x18)
+#define S5P_DSIM_MVPORCH	(0x1c)	/* Main display Vporch register */
+#define S5P_DSIM_MHPORCH	(0x20)	/* Main display Hporch register */
+#define S5P_DSIM_MSYNC		(0x24)	/* Main display sync area register */
+
+/* Sub display image resolution register */
+#define S5P_DSIM_SDRESOL	(0x28)
+#define S5P_DSIM_INTSRC		(0x2c)	/* Interrupt source register */
+#define S5P_DSIM_INTMSK		(0x30)	/* Interrupt mask register */
+#define S5P_DSIM_PKTHDR		(0x34)	/* Packet Header FIFO register */
+#define S5P_DSIM_PAYLOAD	(0x38)	/* Payload FIFO register */
+#define S5P_DSIM_RXFIFO		(0x3c)	/* Read FIFO register */
+#define S5P_DSIM_FIFOTHLD	(0x40)	/* FIFO threshold level register */
+#define S5P_DSIM_FIFOCTRL	(0x44)	/* FIFO status and control register */
+
+/* FIFO memory AC characteristic register */
+#define S5P_DSIM_PLLCTRL	(0x4c)	/* PLL control register */
+#define S5P_DSIM_PLLTMR		(0x50)	/* PLL timer register */
+#define S5P_DSIM_PHYACCHR	(0x54)	/* D-PHY AC characteristic register */
+#define S5P_DSIM_PHYACCHR1	(0x58)	/* D-PHY AC characteristic register1 */
+
+/* DSIM_STATUS */
+#define DSIM_STOP_STATE_DAT(x)	(((x) & 0xf) << 0)
+#define DSIM_STOP_STATE_CLK	(1 << 8)
+#define DSIM_TX_READY_HS_CLK	(1 << 10)
+
+/* DSIM_SWRST */
+#define DSIM_FUNCRST		(1 << 16)
+#define DSIM_SWRST		(1 << 0)
+
+/* S5P_DSIM_TIMEOUT */
+#define DSIM_LPDR_TOUT_SHIFT	(0)
+#define DSIM_BTA_TOUT_SHIFT	(16)
+
+/* S5P_DSIM_CLKCTRL */
+#define DSIM_LANE_ESC_CLKEN_SHIFT	(19)
+#define DSIM_BYTE_CLKEN_SHIFT		(24)
+#define DSIM_BYTE_CLK_SRC_SHIFT		(25)
+#define DSIM_PLL_BYPASS_SHIFT		(27)
+#define DSIM_ESC_CLKEN_SHIFT		(28)
+#define DSIM_TX_REQUEST_HSCLK_SHIFT	(31)
+#define DSIM_LANE_ESC_CLKEN(x)		(((x) & 0x1f) << \
+						DSIM_LANE_ESC_CLKEN_SHIFT)
+#define DSIM_BYTE_CLK_ENABLE		(1 << DSIM_BYTE_CLKEN_SHIFT)
+#define DSIM_BYTE_CLK_DISABLE		(0 << DSIM_BYTE_CLKEN_SHIFT)
+#define DSIM_PLL_BYPASS_EXTERNAL	(1 << DSIM_PLL_BYPASS_SHIFT)
+#define DSIM_ESC_CLKEN_ENABLE		(1 << DSIM_ESC_CLKEN_SHIFT)
+#define DSIM_ESC_CLKEN_DISABLE		(0 << DSIM_ESC_CLKEN_SHIFT)
+
+/* S5P_DSIM_CONFIG */
+#define DSIM_NUM_OF_DATALANE_SHIFT	(5)
+#define DSIM_HSA_MODE_SHIFT		(20)
+#define DSIM_HBP_MODE_SHIFT		(21)
+#define DSIM_HFP_MODE_SHIFT		(22)
+#define DSIM_HSE_MODE_SHIFT		(23)
+#define DSIM_AUTO_MODE_SHIFT		(24)
+#define DSIM_LANE_ENx(x)		(((x) & 0x1f) << 0)
+
+#define DSIM_NUM_OF_DATA_LANE(x)	((x) << DSIM_NUM_OF_DATALANE_SHIFT)
+
+/* S5P_DSIM_ESCMODE */
+#define DSIM_TX_LPDT_SHIFT		(6)
+#define DSIM_CMD_LPDT_SHIFT		(7)
+#define DSIM_TX_LPDT_LP			(1 << DSIM_TX_LPDT_SHIFT)
+#define DSIM_CMD_LPDT_LP		(1 << DSIM_CMD_LPDT_SHIFT)
+#define DSIM_STOP_STATE_CNT_SHIFT	(21)
+#define DSIM_FORCE_STOP_STATE_SHIFT	(20)
+
+/* S5P_DSIM_MDRESOL */
+#define DSIM_MAIN_STAND_BY		(1 << 31)
+#define DSIM_MAIN_VRESOL(x)		(((x) & 0x7ff) << 16)
+#define DSIM_MAIN_HRESOL(x)		(((x) & 0X7ff) << 0)
+
+/* S5P_DSIM_MVPORCH */
+#define DSIM_CMD_ALLOW_SHIFT		(28)
+#define DSIM_STABLE_VFP_SHIFT		(16)
+#define DSIM_MAIN_VBP_SHIFT		(0)
+#define DSIM_CMD_ALLOW_MASK		(0xf << DSIM_CMD_ALLOW_SHIFT)
+#define DSIM_STABLE_VFP_MASK		(0x7ff << DSIM_STABLE_VFP_SHIFT)
+#define DSIM_MAIN_VBP_MASK		(0x7ff << DSIM_MAIN_VBP_SHIFT)
+
+/* S5P_DSIM_MHPORCH */
+#define DSIM_MAIN_HFP_SHIFT		(16)
+#define DSIM_MAIN_HBP_SHIFT		(0)
+#define DSIM_MAIN_HFP_MASK		((0xffff) << DSIM_MAIN_HFP_SHIFT)
+#define DSIM_MAIN_HBP_MASK		((0xffff) << DSIM_MAIN_HBP_SHIFT)
+
+/* S5P_DSIM_MSYNC */
+#define DSIM_MAIN_VSA_SHIFT		(22)
+#define DSIM_MAIN_HSA_SHIFT		(0)
+#define DSIM_MAIN_VSA_MASK		((0x3ff) << DSIM_MAIN_VSA_SHIFT)
+#define DSIM_MAIN_HSA_MASK		((0xffff) << DSIM_MAIN_HSA_SHIFT)
+
+/* S5P_DSIM_SDRESOL */
+#define DSIM_SUB_STANDY_SHIFT		(31)
+#define DSIM_SUB_VRESOL_SHIFT		(16)
+#define DSIM_SUB_HRESOL_SHIFT		(0)
+#define DSIM_SUB_STANDY_MASK		((0x1) << DSIM_SUB_STANDY_SHIFT)
+#define DSIM_SUB_VRESOL_MASK		((0x7ff) << DSIM_SUB_VRESOL_SHIFT)
+#define DSIM_SUB_HRESOL_MASK		((0x7ff) << DSIM_SUB_HRESOL_SHIFT)
+
+/* S5P_DSIM_INTSRC */
+#define INTSRC_FRAME_DONE		(1 << 24)
+#define INTSRC_PLL_STABLE		(1 << 31)
+
+/* S5P_DSIM_INTMSK */
+#define INTMSK_FIFO_EMPTY		(1 << 29)
+#define INTMSK_BTA			(1 << 25)
+#define INTMSK_FRAME_DONE		(1 << 24)
+#define INTMSK_RX_TIMEOUT		(1 << 21)
+#define INTMSK_BTA_TIMEOUT		(1 << 20)
+#define INTMSK_RX_DONE			(1 << 18)
+#define INTMSK_RX_TE			(1 << 17)
+#define INTMSK_RX_ACK			(1 << 16)
+#define INTMSK_RX_ECC_ERR		(1 << 15)
+#define INTMSK_RX_CRC_ERR		(1 << 14)
+
+/* S5P_DSIM_FIFOCTRL */
+#define SFR_HEADER_EMPTY		(1 << 22)
+
+/* S5P_DSIM_PHYACCHR */
+#define DSIM_AFC_CTL(x)			(((x) & 0x7) << 5)
+
+/* S5P_DSIM_PLLCTRL */
+#define DSIM_PLL_EN_SHIFT		(23)
+#define DSIM_FREQ_BAND_SHIFT		(24)
+
+#endif /* _REGS_DSIM_H */
diff --git a/include/linux/mipi_dsim.h b/include/linux/mipi_dsim.h
new file mode 100644
index 0000000..82807f2
--- /dev/null
+++ b/include/linux/mipi_dsim.h
@@ -0,0 +1,362 @@
+/* include/linux/mipi_dsim.h
+ *
+ * Platform data header for Samsung SoC MIPI-DSIM.
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd
+ *
+ * InKi Dae <inki.dae@samsung.com>
+ * Donghwa Lee <dh09.lee@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef _LINUX_MIPI_DSIM_H
+#define _LINUX_MIPI_DSIM_H
+
+#include <linux/device.h>
+#include <linux/fb.h>
+
+#define PANEL_NAME_SIZE		(32)
+
+/*
+ * enumurate display interface type.
+ *
+ * DSIM_COMMAND means cpu interface and rgb interface for DSIM_VIDEO.
+ *
+ * P.S. MIPI DSI Master has two display controller intefaces, RGB Interface
+ *	for main display and CPU Interface(same as I80 Interface) for main
+ *	and sub display.
+ */
+enum mipi_dsim_interface_type {
+	DSIM_COMMAND,
+	DSIM_VIDEO
+};
+
+enum mipi_dsim_virtual_ch_no {
+	DSIM_VIRTUAL_CH_0,
+	DSIM_VIRTUAL_CH_1,
+	DSIM_VIRTUAL_CH_2,
+	DSIM_VIRTUAL_CH_3
+};
+
+enum mipi_dsim_burst_mode_type {
+	DSIM_NON_BURST_SYNC_EVENT,
+	DSIM_BURST_SYNC_EVENT,
+	DSIM_NON_BURST_SYNC_PULSE,
+	DSIM_BURST,
+	DSIM_NON_VIDEO_MODE
+};
+
+enum mipi_dsim_no_of_data_lane {
+	DSIM_DATA_LANE_1,
+	DSIM_DATA_LANE_2,
+	DSIM_DATA_LANE_3,
+	DSIM_DATA_LANE_4
+};
+
+enum mipi_dsim_byte_clk_src {
+	DSIM_PLL_OUT_DIV8,
+	DSIM_EXT_CLK_DIV8,
+	DSIM_EXT_CLK_BYPASS
+};
+
+enum mipi_dsim_pixel_format {
+	DSIM_CMD_3BPP,
+	DSIM_CMD_8BPP,
+	DSIM_CMD_12BPP,
+	DSIM_CMD_16BPP,
+	DSIM_VID_16BPP_565,
+	DSIM_VID_18BPP_666PACKED,
+	DSIM_18BPP_666LOOSELYPACKED,
+	DSIM_24BPP_888
+};
+
+/*
+ * struct mipi_dsim_config - interface for configuring mipi-dsi controller.
+ *
+ * @auto_flush: enable or disable Auto flush of MD FIFO using VSYNC pulse.
+ * @eot_disable: enable or disable EoT packet in HS mode.
+ * @auto_vertical_cnt: specifies auto vertical count mode.
+ *	in Video mode, the vertical line transition uses line counter
+ *	configured by VSA, VBP, and Vertical resolution.
+ *	If this bit is set to '1', the line counter does not use VSA and VBP
+ *	registers.(in command mode, this variable is ignored)
+ * @hse: set horizontal sync event mode.
+ *	In VSYNC pulse and Vporch area, MIPI DSI master transfers only HSYNC
+ *	start packet to MIPI DSI slave at MIPI DSI spec1.1r02.
+ *	this bit transfers HSYNC end packet in VSYNC pulse and Vporch area
+ *	(in mommand mode, this variable is ignored)
+ * @hfp: specifies HFP disable mode.
+ *	if this variable is set, DSI master ignores HFP area in VIDEO mode.
+ *	(in command mode, this variable is ignored)
+ * @hbp: specifies HBP disable mode.
+ *	if this variable is set, DSI master ignores HBP area in VIDEO mode.
+ *	(in command mode, this variable is ignored)
+ * @hsa: specifies HSA disable mode.
+ *	if this variable is set, DSI master ignores HSA area in VIDEO mode.
+ *	(in command mode, this variable is ignored)
+ * @cma_allow: specifies the number of horizontal lines, where command packet
+ *	transmission is allowed after Stable VFP period.
+ * @e_interface: specifies interface to be used.(CPU or RGB interface)
+ * @e_virtual_ch: specifies virtual channel number that main or
+ *	sub diaplsy uses.
+ * @e_pixel_format: specifies pixel stream format for main or sub display.
+ * @e_burst_mode: selects Burst mode in Video mode.
+ *	in Non-burst mode, RGB data area is filled with RGB data and NULL
+ *	packets, according to input bandwidth of RGB interface.
+ *	In Burst mode, RGB data area is filled with RGB data only.
+ * @e_no_data_lane: specifies data lane count to be used by Master.
+ * @e_byte_clk: select byte clock source. (it must be DSIM_PLL_OUT_DIV8)
+ *	DSIM_EXT_CLK_DIV8 and DSIM_EXT_CLK_BYPASSS are not supported.
+ * @pll_stable_time: specifies the PLL Timer for stability of the ganerated
+ *	clock(System clock cycle base)
+ *	if the timer value goes to 0x00000000, the clock stable bit of status
+ *	and interrupt register is set.
+ * @esc_clk: specifies escape clock frequency for getting the escape clock
+ *	prescaler value.
+ * @stop_holding_cnt: specifies the interval value between transmitting
+ *	read packet(or write "set_tear_on" command) and BTA request.
+ *	after transmitting read packet or write "set_tear_on" command,
+ *	BTA requests to D-PHY automatically. this counter value specifies
+ *	the interval between them.
+ * @bta_timeout: specifies the timer for BTA.
+ *	this register specifies time out from BTA request to change
+ *	the direction with respect to Tx escape clock.
+ * @rx_timeout: specifies the timer for LP Rx mode timeout.
+ *	this register specifies time out on how long RxValid deasserts,
+ *	after RxLpdt asserts with respect to Tx escape clock.
+ *	- RxValid specifies Rx data valid indicator.
+ *	- RxLpdt specifies an indicator that D-PHY is under RxLpdt mode.
+ *	- RxValid and RxLpdt specifies signal from D-PHY.
+ */
+struct mipi_dsim_config {
+	unsigned char			auto_flush;
+	unsigned char			eot_disable;
+
+	unsigned char			auto_vertical_cnt;
+	unsigned char			hse;
+	unsigned char			hfp;
+	unsigned char			hbp;
+	unsigned char			hsa;
+	unsigned char			cmd_allow;
+
+	enum mipi_dsim_interface_type	e_interface;
+	enum mipi_dsim_virtual_ch_no	e_virtual_ch;
+	enum mipi_dsim_pixel_format	e_pixel_format;
+	enum mipi_dsim_burst_mode_type	e_burst_mode;
+	enum mipi_dsim_no_of_data_lane	e_no_data_lane;
+	enum mipi_dsim_byte_clk_src	e_byte_clk;
+
+	/*
+	 * =====================+	 * |    P    |    M    |    S    |    MHz    |
+	 * -------------------------------------------
+	 * |    3    |   100   |    3    |    100    |
+	 * |    3    |   100   |    2    |    200    |
+	 * |    3    |    63   |    1    |    252    |
+	 * |    4    |   100   |    1    |    300    |
+	 * |    4    |   110   |    1    |    330    |
+	 * |   12    |   350   |    1    |    350    |
+	 * |    3    |   100   |    1    |    400    |
+	 * |    4    |   150   |    1    |    450    |
+	 * |    6    |   118   |    1    |    472    |
+	 * |	3    |   120   |    1    |    480    |
+	 * |   12    |   250   |    0    |    500    |
+	 * |    4    |   100   |    0    |    600    |
+	 * |    3    |    81   |    0    |    648    |
+	 * |    3    |    88   |    0    |    704    |
+	 * |    3    |    90   |    0    |    720    |
+	 * |    3    |   100   |    0    |    800    |
+	 * |   12    |   425   |    0    |    850    |
+	 * |    4    |   150   |    0    |    900    |
+	 * |   12    |   475   |    0    |    950    |
+	 * |    6    |   250   |    0    |   1000    |
+	 * -------------------------------------------
+	 */
+
+	/*
+	 * pms could be calculated as the following.
+	 * M * 24 / P * 2 ^ S = MHz
+	 */
+	unsigned char			p;
+	unsigned short			m;
+	unsigned char			s;
+
+	unsigned int			pll_stable_time;
+	unsigned long			esc_clk;
+
+	unsigned short			stop_holding_cnt;
+	unsigned char			bta_timeout;
+	unsigned short			rx_timeout;
+};
+
+/*
+ * struct mipi_dsim_device - global interface for mipi-dsi driver.
+ *
+ * @dev: driver model representation of the device.
+ * @id: unique device id.
+ * @clock: pointer to MIPI-DSI clock of clock framework.
+ * @irq: interrupt number to MIPI-DSI controller.
+ * @reg_base: base address to memory mapped SRF of MIPI-DSI controller.
+ *	(virtual address)
+ * @lock: the mutex protecting this data structure.
+ * @dsim_info: infomation for configuring mipi-dsi controller.
+ * @master_ops: callbacks to mipi-dsi operations.
+ * @dsim_lcd_dev: pointer to activated ddi device.
+ *	(it would be registered by mipi-dsi driver.)
+ * @dsim_lcd_drv: pointer to activated_ddi driver.
+ *	(it would be registered by mipi-dsi driver.)
+ * @lcd_info: pointer to mipi_lcd_info structure.
+ * @power_t: current power status.
+ * @state: specifies status of MIPI-DSI controller.
+ *	the status could be RESET, INIT, STOP, HSCLKEN and ULPS.
+ * @data_lane: specifiec enabled data lane number.
+ *	this variable would be set by driver according to e_no_data_lane
+ *	automatically.
+ * @e_clk_src: select byte clock source.
+ * @pd: pointer to MIPI-DSI driver platform data.
+ */
+struct mipi_dsim_device {
+	struct device			*dev;
+	int				id;
+	struct resource			*res;
+	struct clk			*clock;
+	unsigned int			irq;
+	void __iomem			*reg_base;
+	struct mutex			lock;
+
+	struct mipi_dsim_config		*dsim_config;
+	struct mipi_dsim_master_ops	*master_ops;
+	struct mipi_dsim_lcd_device	*dsim_lcd_dev;
+	struct mipi_dsim_lcd_driver	*dsim_lcd_drv;
+
+	atomic_t			power_t;
+	unsigned int			state;
+	unsigned int			data_lane;
+	unsigned int			e_clk_src;
+
+	struct mipi_dsim_platform_data	*pd;
+};
+
+/*
+ * struct mipi_dsim_platform_data - interface to platform data
+ *	for mipi-dsi driver.
+ *
+ * @lcd_panel_name: specifies lcd panel name registered to mipi-dsi driver.
+ *	lcd panel driver searched would be actived.
+ * @dsim_config: pointer of structure for configuring mipi-dsi controller.
+ * @enabled: indicate whether mipi controller got enabled or not.
+ * @lcd_panel_info: pointer for lcd panel specific structure.
+ *	this structure specifies width, height, timing and polarity and so on.
+ * @mipi_power: callback pointer for enabling or disabling mipi power.
+ * @phy_enable: pointer to a callback controlling D-PHY enable/reset
+ */
+struct mipi_dsim_platform_data {
+	char				lcd_panel_name[PANEL_NAME_SIZE];
+
+	struct mipi_dsim_config		*dsim_config;
+	unsigned int			enabled;
+	void				*lcd_panel_info;
+
+	int (*mipi_power)(struct platform_device *pdev, unsigned int enable);
+	int (*phy_enable)(struct platform_device *pdev, bool on);
+};
+
+/*
+ * struct mipi_dsim_master_ops - callbacks to mipi-dsi operations.
+ *
+ * @cmd_write: transfer command to lcd panel at LP mode.
+ * @cmd_read: read command from rx register.
+ * @get_dsim_frame_done: get the status that all screen data have been
+ *	transferred to mipi-dsi.
+ * @clear_dsim_frame_done: clear frame done status.
+ * @get_fb_frame_done: get frame done status of display controller.
+ * @trigger: trigger display controller.
+ *	- this one would be used only in case of CPU mode.
+ *  @set_early_blank_mode: set framebuffer blank mode.
+ *	- this callback should be called prior to fb_blank() by a client driver
+ *	only if needing.
+ *  @set_blank_mode: set framebuffer blank mode.
+ *	- this callback should be called after fb_blank() by a client driver
+ *	only if needing.
+ */
+
+struct mipi_dsim_master_ops {
+	int (*cmd_write)(struct mipi_dsim_device *dsim, unsigned int data_id,
+		unsigned int data0, unsigned int data1);
+	int (*cmd_read)(struct mipi_dsim_device *dsim, unsigned int data_id,
+		unsigned int data0, unsigned int req_size, u8 *rx_buf);
+	int (*get_dsim_frame_done)(struct mipi_dsim_device *dsim);
+	int (*clear_dsim_frame_done)(struct mipi_dsim_device *dsim);
+
+	int (*get_fb_frame_done)(struct fb_info *info);
+	void (*trigger)(struct fb_info *info);
+	int (*set_early_blank_mode)(struct mipi_dsim_device *dsim, int power);
+	int (*set_blank_mode)(struct mipi_dsim_device *dsim, int power);
+};
+
+/*
+ * device structure for mipi-dsi based lcd panel.
+ *
+ * @name: name of the device to use with this device, or an
+ *	alias for that name.
+ * @dev: driver model representation of the device.
+ * @id: id of device to be registered.
+ * @bus_id: bus id for identifing connected bus
+ *	and this bus id should be same as id of mipi_dsim_device.
+ * @irq: irq number for signaling when framebuffer transfer of
+ *	lcd panel module is completed.
+ *	this irq would be used only for MIPI-DSI based CPU mode lcd panel.
+ * @master: pointer to mipi-dsi master device object.
+ * @platform_data: lcd panel specific platform data.
+ */
+struct mipi_dsim_lcd_device {
+	char			*name;
+	struct device		dev;
+	int			id;
+	int			bus_id;
+	int			irq;
+
+	struct mipi_dsim_device *master;
+	void			*platform_data;
+};
+
+/*
+ * driver structure for mipi-dsi based lcd panel.
+ *
+ * this structure should be registered by lcd panel driver.
+ * mipi-dsi driver seeks lcd panel registered through name field
+ * and calls these callback functions in appropriate time.
+ *
+ * @name: name of the driver to use with this device, or an
+ *	alias for that name.
+ * @id: id of driver to be registered.
+ *	this id would be used for finding device object registered.
+ */
+struct mipi_dsim_lcd_driver {
+	char			*name;
+	int			id;
+
+	void	(*power_on)(struct mipi_dsim_lcd_device *dsim_dev);
+	void	(*set_sequence)(struct mipi_dsim_lcd_device *dsim_dev);
+	int	(*probe)(struct mipi_dsim_lcd_device *dsim_dev);
+	int	(*remove)(struct mipi_dsim_lcd_device *dsim_dev);
+	void	(*shutdown)(struct mipi_dsim_lcd_device *dsim_dev);
+	int	(*suspend)(struct mipi_dsim_lcd_device *dsim_dev);
+	int	(*resume)(struct mipi_dsim_lcd_device *dsim_dev);
+};
+
+/*
+ * register mipi_dsim_lcd_device to mipi-dsi master.
+ */
+int s5p_mipi_dsi_register_lcd_device(struct mipi_dsim_lcd_device
+						*lcd_dev);
+/**
+ * register mipi_dsim_lcd_driver object defined by lcd panel driver
+ * to mipi-dsi driver.
+ */
+int s5p_mipi_dsi_register_lcd_driver(struct mipi_dsim_lcd_driver
+						*lcd_drv);
+#endif /* _LINUX_MIPI_DSIM_H */
-- 
1.7.4.1


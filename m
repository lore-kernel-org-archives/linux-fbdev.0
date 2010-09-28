From: Donghwa Lee <dh09.lee@samsung.com>
Date: Tue, 28 Sep 2010 02:05:40 +0000
Subject: [PATCH v3 3/3] S5PV210: add MIPI-DSI driver
Message-Id: <1285639540-22117-1-git-send-email-dh09.lee@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch includes MIPI-DSI driver codes.

s5p-dsim.c
- MIPI-DSI driver

s5p_dsim_common.c
- interface to lowlevel codes

s5p_dsim_lowlevel.c
- set registers

Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: InKi Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/Kconfig             |    7 +
 drivers/video/Makefile            |    2 +
 drivers/video/s5p-dsim.c          |  471 +++++++++++++++++++++++++
 drivers/video/s5p_dsim_common.c   |  694 +++++++++++++++++++++++++++++++++++++
 drivers/video/s5p_dsim_common.h   |   35 ++
 drivers/video/s5p_dsim_lowlevel.c |  571 ++++++++++++++++++++++++++++++
 drivers/video/s5p_dsim_lowlevel.h |  101 ++++++
 7 files changed, 1881 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/s5p-dsim.c
 create mode 100644 drivers/video/s5p_dsim_common.c
 create mode 100644 drivers/video/s5p_dsim_common.h
 create mode 100644 drivers/video/s5p_dsim_lowlevel.c
 create mode 100644 drivers/video/s5p_dsim_lowlevel.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 8b31fdf..8547a02 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1991,6 +1991,13 @@ config FB_S3C2410_DEBUG
 	  Turn on debugging messages. Note that you can set/unset at run time
 	  through sysfs
 
+config S5P_MIPI_DSI
+	tristate "Samsung SoC MIPI-DSI support."
+	depends on FB_S3C && ARCH_S5PV210
+	default n
+	---help---
+	  This enables support for MIPI-DSI device.
+
 config FB_NUC900
         bool "NUC900 LCD framebuffer support"
         depends on FB && ARCH_W90X900
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 485e8ed..6d1be1a 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -115,6 +115,8 @@ obj-$(CONFIG_FB_SH7760)		  += sh7760fb.o
 obj-$(CONFIG_FB_IMX)              += imxfb.o
 obj-$(CONFIG_FB_S3C)		  += s3c-fb.o
 obj-$(CONFIG_FB_S3C2410)	  += s3c2410fb.o
+obj-$(CONFIG_S5P_MIPI_DSI)	  += s5p-dsim.o s5p_dsim_common.o \
+    					s5p_dsim_lowlevel.o
 obj-$(CONFIG_FB_FSL_DIU)	  += fsl-diu-fb.o
 obj-$(CONFIG_FB_COBALT)           += cobalt_lcdfb.o
 obj-$(CONFIG_FB_PNX4008_DUM)	  += pnx4008/
diff --git a/drivers/video/s5p-dsim.c b/drivers/video/s5p-dsim.c
new file mode 100644
index 0000000..6f83305
--- /dev/null
+++ b/drivers/video/s5p-dsim.c
@@ -0,0 +1,471 @@
+/* linux/drivers/video/s5p-dsim.c
+ *
+ * Samsung MIPI-DSIM driver.
+ *
+ * InKi Dae, <inki.dae@samsung.com>
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
+#include <linux/regulator/consumer.h>
+#include <linux/notifier.h>
+
+#include <plat/fb.h>
+#include <plat/regs-dsim.h>
+#include <plat/dsim.h>
+#include <plat/mipi_ddi.h>
+
+#include <mach/map.h>
+
+#include "s5p_dsim_common.h"
+
+struct mipi_lcd_info {
+	struct list_head	list;
+	struct mipi_lcd_driver	*mipi_drv;
+};
+
+static LIST_HEAD(lcd_info_list);
+static DEFINE_MUTEX(mipi_lock);
+
+struct dsim_global dsim;
+
+struct s5p_platform_dsim *to_dsim_plat(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return (struct s5p_platform_dsim *)pdev->dev.platform_data;
+}
+
+/*
+ * notifier callback function for fb_blank
+ * - this function would be called by device specific fb_blank.
+ */
+static int s5p_dsim_notifier_callback(struct notifier_block *self,
+	unsigned long event, void *data)
+{
+	switch (event) {
+	case FB_BLANK_UNBLANK:
+	case FB_BLANK_NORMAL:
+		if (dsim.pd->mipi_power)
+			dsim.pd->mipi_power(&dsim, dsim.r_mipi_1_1v,
+				dsim.r_mipi_1_8v, 1);
+
+		clk_enable(dsim.clock);
+
+		if (dsim.mipi_drv->resume)
+			dsim.mipi_drv->resume(dsim.dev);
+
+		s5p_dsim_init_dsim(&dsim);
+		s5p_dsim_init_link(&dsim);
+
+		s5p_dsim_set_hs_enable(&dsim);
+		s5p_dsim_set_data_transfer_mode(&dsim,
+			DSIM_TRANSFER_BYCPU, 1);
+
+		/* it needs delay for stabilization */
+		mdelay(dsim.pd->delay_for_stabilization);
+
+		if (dsim.mipi_drv->init)
+			dsim.mipi_drv->init(dsim.dev);
+		else
+			dev_warn(dsim.dev, "init func is null.\n");
+
+		s5p_dsim_set_display_mode(&dsim, dsim.dsim_lcd_info, NULL);
+
+		s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYLCDC, 1);
+		dsim.mipi_ddi_pd->resume_complete = 1;
+
+		dev_dbg(dsim.dev, "FB_BLANK_NORMAL or UNBLANK.\n");
+
+		break;
+	case FB_BLANK_POWERDOWN:
+		dsim.mipi_ddi_pd->resume_complete = 0;
+
+		if (dsim.mipi_drv->suspend)
+			dsim.mipi_drv->suspend(dsim.dev);
+
+		clk_disable(dsim.clock);
+
+		if (dsim.pd->mipi_power)
+			dsim.pd->mipi_power(&dsim,dsim.r_mipi_1_1v,
+				dsim.r_mipi_1_8v, 0);
+
+		dev_dbg(dsim.dev, "FB_BLANK_POWERDOWN.\n");
+		break;
+	default:
+		dev_warn(dsim.dev, "unknown FB_BLANK command.\n");
+		break;
+	}
+
+	return 0;
+}
+
+static int s5p_dsim_register_notif(struct device *dev)
+{
+	memset(&dsim.s3cfb_notif, 0, sizeof(struct notifier_block));
+	dsim.s3cfb_notif.notifier_call = s5p_dsim_notifier_callback;
+
+	return 0/*s3cfb_register_client(&dsim.s3cfb_notif)*/;
+}
+
+static irqreturn_t s5p_dsim_interrupt_handler(int irq, void *dev_id)
+{
+	disable_irq(irq);
+
+	/* additional work. */
+
+	enable_irq(irq);
+
+	return IRQ_HANDLED;
+}
+
+int s5p_dsim_register_lcd_driver(struct mipi_lcd_driver *lcd_drv)
+{
+	struct mipi_lcd_info	*lcd_info = NULL;
+
+	lcd_info = kmalloc(sizeof(struct mipi_lcd_info), GFP_KERNEL);
+	if (lcd_info = NULL)
+		return -ENOMEM;
+
+	lcd_info->mipi_drv = kmalloc(sizeof(struct mipi_lcd_driver),
+		GFP_KERNEL);
+	if (lcd_info->mipi_drv = NULL)
+		return -ENOMEM;
+
+
+	memcpy(lcd_info->mipi_drv, lcd_drv, sizeof(struct mipi_lcd_driver));
+
+	mutex_lock(&mipi_lock);
+	list_add_tail(&lcd_info->list, &lcd_info_list);
+	mutex_unlock(&mipi_lock);
+
+	dev_dbg(dsim.dev, "registered panel driver(%s) to mipi-dsi driver.\n",
+		lcd_drv->name);
+
+	return 0;
+}
+
+/*
+ * This function is wrapper for changing transfer mode.
+ * It is used to in panel driver before and after changing gamma value.
+ */
+int s5p_dsim_change_transfer_mode(unsigned int mode)
+{
+	if (mode < 0 || mode > 1) {
+		dev_err(dsim.dev, "mode range should be 0 or 1.\n");
+		return -EFAULT;
+	}
+
+	if (mode = 0)
+		s5p_dsim_set_data_transfer_mode(&dsim,
+			DSIM_TRANSFER_BYCPU, mode);
+	else
+		s5p_dsim_set_data_transfer_mode(&dsim,
+			DSIM_TRANSFER_BYLCDC, mode);
+
+	return 0;
+}
+
+struct mipi_lcd_driver *scan_mipi_driver(const char *name)
+{
+	struct mipi_lcd_info *lcd_info;
+	struct mipi_lcd_driver *mipi_drv = NULL;
+
+	mutex_lock(&mipi_lock);
+
+	dev_dbg(dsim.dev, "find lcd panel driver(%s).\n",
+		name);
+
+	list_for_each_entry(lcd_info, &lcd_info_list, list) {
+		mipi_drv = lcd_info->mipi_drv;
+
+		if ((strcmp(mipi_drv->name, name)) = 0) {
+			mutex_unlock(&mipi_lock);
+			dev_dbg(dsim.dev, "found!!!(%s).\n", mipi_drv->name);
+			return mipi_drv;
+		}
+	}
+
+	dev_warn(dsim.dev, "failed to find lcd panel driver(%s).\n",
+		name);
+
+	mutex_unlock(&mipi_lock);
+
+	return NULL;
+}
+
+static int s5p_dsim_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret = -1;
+
+	dsim.pd = to_dsim_plat(&pdev->dev);
+	dsim.dev = &pdev->dev;
+
+	/* set dsim config data, dsim lcd config data and lcd panel data. */
+	dsim.dsim_info = dsim.pd->dsim_info;
+	dsim.dsim_lcd_info = dsim.pd->dsim_lcd_info;
+	dsim.lcd_panel_info +		(struct fb_videomode *) dsim.dsim_lcd_info->lcd_panel_info;
+	dsim.mipi_ddi_pd +		(struct mipi_ddi_platform_data *)
+			dsim.dsim_lcd_info->mipi_ddi_pd;
+
+	dsim.mipi_ddi_pd->resume_complete = 0;
+
+	WARN_ON(dsim.pd->mipi_1_1v_name = NULL);
+
+	dsim.r_mipi_1_1v = regulator_get(&pdev->dev, dsim.pd->mipi_1_1v_name);
+	if (IS_ERR(dsim.r_mipi_1_1v)) {
+		dev_err(&pdev->dev, "failed to get regulator %s.\n",
+			dsim.pd->mipi_1_1v_name);
+		goto regulator_get_err;
+	}
+
+	WARN_ON(dsim.pd->mipi_1_8v_name = NULL);
+
+	dsim.r_mipi_1_8v = regulator_get(&pdev->dev, dsim.pd->mipi_1_8v_name);
+	if (IS_ERR(dsim.r_mipi_1_8v)) {
+		dev_err(&pdev->dev, "failed to get regulator %s.\n",
+			dsim.pd->mipi_1_8v_name);
+		goto regulator_get_err;
+	}
+
+	/* clock */
+	dsim.clock = clk_get(&pdev->dev, "dsim");
+	if (IS_ERR(dsim.clock)) {
+		dev_err(&pdev->dev, "failed to get dsim clock source\n");
+		return -EINVAL;
+	}
+
+	clk_enable(dsim.clock);
+
+	/* io memory */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get io memory region\n");
+		ret = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	/* request mem region */
+	res = request_mem_region(res->start, resource_size(res), pdev->name);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to request io memory region\n");
+		ret = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	/* ioremap for register block */
+	dsim.reg_base = ioremap(res->start, resource_size(res));
+	if (!dsim.reg_base) {
+		dev_err(&pdev->dev, "failed to remap io region\n");
+		ret = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	/* it is used for MIPI-DSI based lcd panel driver. */
+	dsim.mipi_ddi_pd->dsim_data = (void *)&dsim;
+
+	/*
+	 * it uses frame done interrupt handler
+	 * only in case of MIPI Video mode.
+	 */
+	if (dsim.dsim_lcd_info->e_interface = DSIM_VIDEO) {
+		dsim.irq = platform_get_irq(pdev, 0);
+		if (request_irq(dsim.irq, s5p_dsim_interrupt_handler,
+				IRQF_DISABLED, "mipi-dsi", &dsim)) {
+			dev_err(&pdev->dev, "request_irq failed.\n");
+			goto err_trigger_irq;
+		}
+	}
+
+	if (dsim.pd->mipi_power)
+		dsim.pd->mipi_power(&dsim, dsim.r_mipi_1_1v,
+			dsim.r_mipi_1_8v, 1);
+	else {
+		dev_err(&pdev->dev, "mipi_power is NULL.\n");
+		goto mipi_power_err;
+	}
+
+	/* find lcd panel driver registered to mipi-dsi driver. */
+	dsim.mipi_drv = scan_mipi_driver(dsim.pd->lcd_panel_name);
+	if (dsim.mipi_drv = NULL) {
+		dev_err(&pdev->dev, "mipi_drv is NULL.\n");
+		goto mipi_drv_err;
+	}
+
+	/* set lcd panel driver link */
+	ret = dsim.mipi_drv->set_link(dsim.mipi_ddi_pd);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to set link.\n");
+		goto mipi_drv_err;
+	}
+
+	dsim.mipi_drv->probe(&pdev->dev);
+
+	s5p_dsim_init_dsim(&dsim);
+	s5p_dsim_init_link(&dsim);
+
+	s5p_dsim_set_hs_enable(&dsim);
+	s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYCPU, 1);
+
+	/* it needs delay for stabilization */
+	mdelay(dsim.pd->delay_for_stabilization);
+
+	/* initialize lcd panel */
+	if (dsim.mipi_drv->init)
+		dsim.mipi_drv->init(&pdev->dev);
+	else
+		dev_warn(&pdev->dev, "init func is null.\n");
+
+	if (dsim.mipi_drv->display_on)
+		dsim.mipi_drv->display_on(&pdev->dev);
+	else
+		dev_warn(&pdev->dev, "display_on func is null.\n");
+
+	s5p_dsim_set_display_mode(&dsim, dsim.dsim_lcd_info, NULL);
+
+	s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYLCDC, 1);
+
+	s5p_dsim_register_notif(&pdev->dev);
+
+	/* in case of command mode, trigger. */
+	if (dsim.dsim_lcd_info->e_interface = DSIM_COMMAND) {
+		if (dsim.pd->trigger)
+			dsim.pd->trigger(registered_fb[0]);
+		else
+			dev_warn(&pdev->dev, "trigger is null.\n");
+	}
+
+	dev_info(&pdev->dev, "mipi-dsi driver(%s mode) has been probed.\n",
+		(dsim.dsim_lcd_info->e_interface = DSIM_COMMAND) ?
+			"CPU" : "RGB");
+
+	return 0;
+
+err_trigger_irq:
+mipi_drv_err:
+	dsim.pd->mipi_power(&dsim, dsim.r_mipi_1_1v, dsim.r_mipi_1_8v, 0);
+
+mipi_power_err:
+	iounmap((void __iomem *) dsim.reg_base);
+
+err_clk_disable:
+	clk_disable(dsim.clock);
+
+regulator_get_err:
+
+	return ret;
+
+}
+
+static int s5p_dsim_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+#ifdef CONFIG_PM
+int s5p_dsim_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	dsim.mipi_ddi_pd->resume_complete = 0;
+
+	if (dsim.mipi_drv->suspend)
+		dsim.mipi_drv->suspend(&pdev->dev);
+
+	clk_disable(dsim.clock);
+
+	if (dsim.pd->mipi_power)
+		dsim.pd->mipi_power(&dsim, dsim.r_mipi_1_1v,
+			dsim.r_mipi_1_8v, 0);
+
+	return 0;
+}
+
+int s5p_dsim_resume(struct platform_device *pdev)
+{
+	if (dsim.pd->mipi_power)
+		dsim.pd->mipi_power(&dsim, dsim.r_mipi_1_1v,
+			dsim.r_mipi_1_8v, 1);
+
+	clk_enable(dsim.clock);
+
+	if (dsim.mipi_drv->resume)
+		dsim.mipi_drv->resume(&pdev->dev);
+
+	s5p_dsim_init_dsim(&dsim);
+	s5p_dsim_init_link(&dsim);
+
+	s5p_dsim_set_hs_enable(&dsim);
+	s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYCPU, 1);
+
+	/* it needs delay for stabilization */
+	mdelay(dsim.pd->delay_for_stabilization);
+
+	/* initialize lcd panel */
+	if (dsim.mipi_drv->init)
+		dsim.mipi_drv->init(&pdev->dev);
+	else
+		dev_warn(&pdev->dev, "init func is null.\n");
+
+	s5p_dsim_set_display_mode(&dsim, dsim.dsim_lcd_info, NULL);
+
+	s5p_dsim_set_data_transfer_mode(&dsim, DSIM_TRANSFER_BYLCDC, 1);
+
+	dsim.mipi_ddi_pd->resume_complete = 1;
+
+	return 0;
+}
+#else
+#define s5p_dsim_suspend NULL
+#define s5p_dsim_resume NULL
+#endif
+
+static struct platform_driver s5p_dsim_driver = {
+	.probe = s5p_dsim_probe,
+	.remove = s5p_dsim_remove,
+	.suspend = s5p_dsim_suspend,
+	.resume = s5p_dsim_resume,
+	.driver = {
+		   .name = "s5p-dsim",
+		   .owner = THIS_MODULE,
+	},
+};
+
+static int s5p_dsim_register(void)
+{
+	platform_driver_register(&s5p_dsim_driver);
+
+	return 0;
+}
+
+static void s5p_dsim_unregister(void)
+{
+	platform_driver_unregister(&s5p_dsim_driver);
+}
+
+module_init(s5p_dsim_register);
+module_exit(s5p_dsim_unregister);
+
+MODULE_AUTHOR("InKi Dae <inki.dae@samsung.com>");
+MODULE_DESCRIPTION("Samusung MIPI-DSIM driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/s5p_dsim_common.c b/drivers/video/s5p_dsim_common.c
new file mode 100644
index 0000000..8ec8609
--- /dev/null
+++ b/drivers/video/s5p_dsim_common.c
@@ -0,0 +1,694 @@
+/* linux/drivers/video/s5p_dsim_common.c
+ *
+ * Samsung MIPI-DSIM common driver.
+ *
+ * InKi Dae, <inki.dae@samsung.com>
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
+
+#include <video/mipi_display.h>
+
+#include <plat/fb.h>
+#include <plat/regs-dsim.h>
+
+#include <mach/map.h>
+#include <plat/dsim.h>
+#include <plat/mipi_ddi.h>
+
+#include "s5p_dsim_lowlevel.h"
+
+static unsigned int dpll_table[15] = {
+	100, 120, 170, 220, 270,
+	320, 390, 450, 510, 560,
+	640, 690, 770, 870, 950 };
+
+static void s5p_dsim_long_data_wr(struct dsim_global *dsim, unsigned int data0,
+	unsigned int data1)
+{
+	unsigned int data_cnt = 0, payload = 0;
+
+	WARN_ON(dsim = NULL);
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
+			s5p_dsim_wr_tx_data(dsim, payload);
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
+			s5p_dsim_wr_tx_data(dsim, payload);
+		}
+	}
+}
+
+int s5p_dsim_wr_data(void *dsim_data, unsigned int data_id,
+	unsigned int data0, unsigned int data1)
+{
+	struct dsim_global *dsim = NULL;
+	unsigned int timeout = 5000 * 2;
+	unsigned long delay_val, udelay;
+	unsigned int check_rx_ack = 0;
+
+	dsim = (struct dsim_global *)dsim_data;
+
+	WARN_ON(dsim = NULL);
+
+	if (dsim->state = DSIM_STATE_ULPS) {
+		dev_err(dsim->dev, "state is ULPS.\n");
+
+		return -EINVAL;
+	}
+
+	delay_val = 1000000 / dsim->dsim_info->esc_clk;
+	udelay = 10 * delay_val;
+
+	mdelay(udelay);
+
+	/* only if transfer mode is LPDT, wait SFR becomes empty. */
+	if (dsim->state = DSIM_STATE_STOP) {
+		while (!(s5p_dsim_get_fifo_state(dsim) &
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
+		s5p_dsim_wr_tx_header(dsim, data_id, data0, data1);
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
+		s5p_dsim_wr_tx_header(dsim, data_id, data0, data1);
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
+		s5p_dsim_clear_interrupt(dsim, 0xffffffff);
+		printk("DCS_READ data_id: %d, data0: %x, data1: %x\n", data_id, data0, data1);
+		s5p_dsim_wr_tx_header(dsim, data_id, data0, data1);
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
+			s5p_dsim_wr_tx_data(dsim, payload);
+
+			dev_dbg(dsim->dev, "count = %d payload = %x,%x %x %x\n",
+				data1, payload,
+				*(u8 *)(data0 + data_cnt),
+				*(u8 *)(data0 + (data_cnt + 1)),
+				*(u8 *)(data0 + (data_cnt + 2)));
+		/* in case that data count is more then 4 */
+		} else
+			s5p_dsim_long_data_wr(dsim, data0, data1);
+
+		/* put data into header fifo */
+		s5p_dsim_wr_tx_header(dsim, data_id, data1 & 0xff,
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
+int s5p_dsim_init_header_fifo(struct dsim_global *dsim)
+{
+	unsigned int cnt;
+
+	WARN_ON(dsim = NULL);
+
+	for (cnt = 0; cnt < DSIM_HEADER_FIFO_SZ; cnt++)
+		dsim->header_fifo_index[cnt] = -1;
+
+	return 0;
+}
+
+int s5p_dsim_pll_on(struct dsim_global *dsim, unsigned int enable)
+{
+	WARN_ON(dsim = NULL);
+	printk("@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n");
+	if (enable) {
+		int sw_timeout = 1000;
+		s5p_dsim_clear_interrupt(dsim, DSIM_PLL_STABLE);
+		s5p_dsim_enable_pll(dsim, 1);
+		while (1) {
+			sw_timeout--;
+			if (s5p_dsim_is_pll_stable(dsim))
+				return 0;
+			if (sw_timeout = 0)
+				return -EINVAL;
+		}
+	} else
+		s5p_dsim_enable_pll(dsim, 0);
+
+	return 0;
+}
+
+unsigned long s5p_dsim_change_pll(struct dsim_global *dsim,
+	unsigned int pre_divider, unsigned int main_divider,
+	unsigned int scaler)
+{
+	unsigned long dfin_pll, dfvco, dpll_out;
+	unsigned int i, freq_band = 0xf;
+
+	WARN_ON(dsim = NULL);
+
+	dfin_pll = (MIPI_FIN / pre_divider);
+
+	if (dfin_pll < 6 * 1000 * 1000 || dfin_pll > 12 * 1000 * 1000) {
+		dev_warn(dsim->dev, "warning!!\n");
+		dev_warn(dsim->dev, "fin_pll range is 6MHz ~ 12MHz\n");
+		dev_warn(dsim->dev, "fin_pll of mipi dphy pll is %luMHz\n",
+			(dfin_pll / 1000000));
+
+		s5p_dsim_enable_afc(dsim, 0, 0);
+	} else {
+		if (dfin_pll < 7 * 1000000)
+			s5p_dsim_enable_afc(dsim, 1, 0x1);
+		else if (dfin_pll < 8 * 1000000)
+			s5p_dsim_enable_afc(dsim, 1, 0x0);
+		else if (dfin_pll < 9 * 1000000)
+			s5p_dsim_enable_afc(dsim, 1, 0x3);
+		else if (dfin_pll < 10 * 1000000)
+			s5p_dsim_enable_afc(dsim, 1, 0x2);
+		else if (dfin_pll < 11 * 1000000)
+			s5p_dsim_enable_afc(dsim, 1, 0x5);
+		else
+			s5p_dsim_enable_afc(dsim, 1, 0x4);
+	}
+
+	dfvco = dfin_pll * main_divider;
+	dev_dbg(dsim->dev, "dfvco = %lu, dfin_pll = %lu, main_divider = %d\n",
+		dfvco, dfin_pll, main_divider);
+	if (dfvco < 500000000 || dfvco > 1000000000) {
+		dev_warn(dsim->dev, "Caution!!\n");
+		dev_warn(dsim->dev, "fvco range is 500MHz ~ 1000MHz\n");
+		dev_warn(dsim->dev, "fvco of mipi dphy pll is %luMHz\n",
+			(dfvco / 1000000));
+	}
+
+	dpll_out = dfvco / (1 << scaler);
+	dev_dbg(dsim->dev, "dpll_out = %lu, dfvco = %lu, scaler = %d\n",
+		dpll_out, dfvco, scaler);
+
+	for (i = 0; i < ARRAY_SIZE(dpll_table); i++) {
+		if (dpll_out < dpll_table[i] * 1000000) {
+			freq_band = i;
+			break;
+		}
+	}
+
+	dev_dbg(dsim->dev, "freq_band = %d\n", freq_band);
+
+	s5p_dsim_pll_freq(dsim, pre_divider, main_divider, scaler);
+
+	s5p_dsim_hs_zero_ctrl(dsim, 0);
+	s5p_dsim_prep_ctrl(dsim, 0);
+
+	/* Freq Band */
+	s5p_dsim_pll_freq_band(dsim, freq_band);
+
+	/* Stable time */
+	s5p_dsim_pll_stable_time(dsim,
+		dsim->dsim_info->pll_stable_time);
+
+	/* Enable PLL */
+	dev_info(dsim->dev, "FOUT of mipi dphy pll is %luMHz\n",
+		(dpll_out / 1000000));
+
+	return dpll_out;
+}
+
+int s5p_dsim_set_clock(struct dsim_global *dsim,
+	unsigned int byte_clk_sel, unsigned int enable)
+{
+	unsigned int esc_div;
+	unsigned long esc_clk_error_rate;
+
+	WARN_ON(dsim = NULL);
+
+	if (enable) {
+		dsim->e_clk_src = byte_clk_sel;
+		printk("%s: byte clock src: %d\n", __func__, byte_clk_sel);
+		/* Escape mode clock and byte clock source */
+		s5p_dsim_set_byte_clock_src(dsim, byte_clk_sel);
+
+		/* DPHY, DSIM Link : D-PHY clock out */
+		if (byte_clk_sel = DSIM_PLL_OUT_DIV8) {
+			dsim->hs_clk = s5p_dsim_change_pll(dsim,
+				dsim->dsim_info->p, dsim->dsim_info->m,
+				dsim->dsim_info->s);
+			if (dsim->hs_clk = 0) {
+				dev_err(dsim->dev,
+					"failed to get hs clock.\n");
+				return -EINVAL;
+			}
+
+			dsim->byte_clk = dsim->hs_clk / 8;
+			s5p_dsim_enable_pll_bypass(dsim, 0);
+			s5p_dsim_pll_on(dsim, 1);
+		/* DPHY : D-PHY clock out, DSIM link : external clock out */
+		} else if (byte_clk_sel = DSIM_EXT_CLK_DIV8)
+			dev_warn(dsim->dev,
+				"this project is not support \
+				external clock source for MIPI DSIM\n");
+		else if (byte_clk_sel = DSIM_EXT_CLK_BYPASS)
+			dev_warn(dsim->dev,
+				"this project is not support \
+				external clock source for MIPI DSIM\n");
+
+		/* escape clock divider */
+		esc_div = dsim->byte_clk / (dsim->dsim_info->esc_clk);
+		dev_info(dsim->dev,
+			"esc_div = %d, byte_clk = %lu, esc_clk = %lu\n",
+			esc_div, dsim->byte_clk, dsim->dsim_info->esc_clk);
+		if ((dsim->byte_clk / esc_div) >= 20000000 ||
+			(dsim->byte_clk / esc_div) > dsim->dsim_info->esc_clk)
+			esc_div += 1;
+
+		dsim->escape_clk = dsim->byte_clk / esc_div;
+		dev_info(dsim->dev,
+			"escape_clk = %lu, byte_clk = %lu, esc_div = %d\n",
+			dsim->escape_clk, dsim->byte_clk, esc_div);
+
+		/*
+		 * enable escclk on lane
+		 *
+		 * in case of evt0, DSIM_TRUE is enable and
+		 * DSIM_FALSE is enable for evt1.
+		 */
+		if (dsim->pd->platform_rev = 1)
+			s5p_dsim_enable_byte_clock(dsim, DSIM_FALSE);
+		else
+			s5p_dsim_enable_byte_clock(dsim, DSIM_TRUE);
+
+		/* enable byte clk and escape clock */
+		s5p_dsim_set_esc_clk_prs(dsim, 1, esc_div);
+		/* escape clock on lane */
+		s5p_dsim_enable_esc_clk_on_lane(dsim,
+			(DSIM_LANE_CLOCK | dsim->data_lane), 1);
+
+		dev_dbg(dsim->dev, "byte clock is %luMHz\n",
+			(dsim->byte_clk / 1000000));
+		dev_dbg(dsim->dev, "escape clock that user's need is %lu\n",
+			(dsim->dsim_info->esc_clk / 1000000));
+		dev_dbg(dsim->dev, "escape clock divider is %x\n", esc_div);
+		dev_dbg(dsim->dev, "escape clock is %luMHz\n",
+			((dsim->byte_clk / esc_div) / 1000000));
+
+		if ((dsim->byte_clk / esc_div) > dsim->escape_clk) {
+			esc_clk_error_rate = dsim->escape_clk /
+				(dsim->byte_clk / esc_div);
+			dev_warn(dsim->dev, "error rate is %lu over.\n",
+				(esc_clk_error_rate / 100));
+		} else if ((dsim->byte_clk / esc_div) < (dsim->escape_clk)) {
+			esc_clk_error_rate = (dsim->byte_clk / esc_div) /
+				dsim->escape_clk;
+			dev_warn(dsim->dev, "error rate is %lu under.\n",
+				(esc_clk_error_rate / 100));
+		}
+	} else {
+		s5p_dsim_enable_esc_clk_on_lane(dsim,
+			(DSIM_LANE_CLOCK | dsim->data_lane), 0);
+		s5p_dsim_set_esc_clk_prs(dsim, 0, 0);
+
+		/*
+		 * in case of evt0, DSIM_FALSE is disable and
+		 * DSIM_TRUE is disable for evt1.
+		 */
+		if (dsim->pd->platform_rev = 1)
+			s5p_dsim_enable_byte_clock(dsim, DSIM_TRUE);
+		else
+			s5p_dsim_enable_byte_clock(dsim, DSIM_FALSE);
+
+		if (byte_clk_sel = DSIM_PLL_OUT_DIV8)
+			s5p_dsim_pll_on(dsim, 0);
+	}
+
+	return 0;
+}
+
+int s5p_dsim_init_dsim(struct dsim_global *dsim)
+{
+	WARN_ON(dsim = NULL);
+
+	if (dsim->pd->init_d_phy)
+		dsim->pd->init_d_phy(dsim);
+
+	dsim->state = DSIM_STATE_RESET;
+
+	switch (dsim->dsim_info->e_no_data_lane) {
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
+	s5p_dsim_init_header_fifo(dsim);
+	s5p_dsim_sw_reset(dsim);
+	s5p_dsim_dp_dn_swap(dsim, dsim->dsim_info->e_lane_swap);
+
+	return 0;
+}
+
+int s5p_dsim_enable_frame_done_int(struct dsim_global *dsim, unsigned int enable)
+{
+	/* enable only frame done interrupt */
+	s5p_dsim_set_interrupt_mask(dsim, INTMSK_FRAME_DONE, enable);
+
+	return 0;
+}
+
+int s5p_dsim_set_display_mode(struct dsim_global *dsim,
+	struct dsim_lcd_config *main_lcd, struct dsim_lcd_config *sub_lcd)
+{
+	struct fb_videomode *mlcd_video = NULL;
+	struct fb_cmdmode *mlcd_command = NULL;
+	struct s3c_fb_pd_win *pd;
+	unsigned int width = 0, height = 0;
+
+	WARN_ON(dsim = NULL);
+
+	pd = (struct s3c_fb_pd_win *)main_lcd->lcd_panel_info;
+
+	/* in case of VIDEO MODE (RGB INTERFACE) */
+	if (dsim->dsim_lcd_info->e_interface = (u32) DSIM_VIDEO) {
+		mlcd_video = (struct fb_videomode *)&pd->win_mode;
+		width = mlcd_video->xres;
+		height = mlcd_video->yres;
+
+		if (dsim->dsim_info->auto_vertical_cnt = DSIM_FALSE) {
+			s5p_dsim_set_main_disp_vporch(dsim,
+				mlcd_video->upper_margin,
+				mlcd_video->lower_margin, 0);
+			s5p_dsim_set_main_disp_hporch(dsim,
+				mlcd_video->left_margin,
+				mlcd_video->right_margin);
+			s5p_dsim_set_main_disp_sync_area(dsim,
+				mlcd_video->vsync_len,
+				mlcd_video->hsync_len);
+		}
+	} else {	/* in case of COMMAND MODE (CPU or I80 INTERFACE) */
+		mlcd_command = (struct fb_cmdmode *)&pd->cmd_mode;
+		width = mlcd_command->xres;
+		height = mlcd_command->yres;
+	}
+
+	s5p_dsim_set_main_disp_resol(dsim, height, width);
+
+	if (sub_lcd != NULL)
+			dev_warn(dsim->dev, "sub lcd isn't supported yet.\n");
+
+	s5p_dsim_display_config(dsim, dsim->dsim_lcd_info, NULL);
+
+	return 0;
+}
+
+int s5p_dsim_init_link(struct dsim_global *dsim)
+{
+	unsigned int time_out = 100;
+
+	WARN_ON(dsim = NULL);
+
+	switch (dsim->state) {
+	case DSIM_STATE_RESET:
+		s5p_dsim_sw_reset(dsim);
+	case DSIM_STATE_INIT:
+		s5p_dsim_init_fifo_pointer(dsim, 0x1f);
+
+		/* dsi configuration */
+		s5p_dsim_init_config(dsim, dsim->dsim_lcd_info,
+			NULL, dsim->dsim_info);
+		s5p_dsim_enable_lane(dsim, DSIM_LANE_CLOCK, 1);
+		s5p_dsim_enable_lane(dsim, dsim->data_lane, 1);
+
+		/* set clock configuration */
+		s5p_dsim_set_clock(dsim, dsim->dsim_info->e_byte_clk,
+			1);
+		printk("%s: dsim_lane_state: %d, %d\n", __func__,
+			s5p_dsim_is_lane_state(dsim, DSIM_LANE_CLOCK), DSIM_LANE_STATE_STOP);
+		/* check clock and data lane state is stop state */
+		while (!(s5p_dsim_is_lane_state(dsim, DSIM_LANE_CLOCK)
+			    = DSIM_LANE_STATE_STOP) &&
+			!(s5p_dsim_is_lane_state(dsim,
+				dsim->data_lane) = DSIM_LANE_STATE_STOP)) {
+			printk("%s: %d\n", __func__, __LINE__);
+			time_out--;
+			if (time_out = 0) {
+				dev_info(dsim->dev,
+					"DSI Master is not stop state.\n");
+				dev_info(dsim->dev,
+					"Check initialization process\n");
+
+				return -EINVAL;
+			}
+		}
+
+		if (time_out != 0) {
+			dev_info(dsim->dev,
+				"initialization of DSI Master is successful\n");
+			dev_info(dsim->dev, "DSI Master state is stop state\n");
+		}
+
+		dsim->state = DSIM_STATE_STOP;
+
+		/* BTA sequence counters */
+		s5p_dsim_set_stop_state_counter(dsim,
+			dsim->dsim_info->stop_holding_cnt);
+		s5p_dsim_set_bta_timeout(dsim,
+			dsim->dsim_info->bta_timeout);
+		s5p_dsim_set_lpdr_timeout(dsim,
+			dsim->dsim_info->rx_timeout);
+
+		/* default LPDT by both cpu and lcd controller */
+		s5p_dsim_set_data_mode(dsim, DSIM_TRANSFER_BOTH,
+			DSIM_STATE_STOP);
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
+int s5p_dsim_set_hs_enable(struct dsim_global *dsim)
+{
+	WARN_ON(dsim = NULL);
+
+	if (dsim->state = DSIM_STATE_STOP) {
+		if (dsim->e_clk_src != DSIM_EXT_CLK_BYPASS) {
+			printk("%s : %d\n", __func__, dsim->e_clk_src);
+			dsim->state = DSIM_STATE_HSCLKEN;
+			s5p_dsim_set_data_mode(dsim,
+				DSIM_TRANSFER_BOTH, DSIM_STATE_HSCLKEN);
+			s5p_dsim_enable_hs_clock(dsim, 1);
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
+int s5p_dsim_set_data_transfer_mode(struct dsim_global *dsim,
+	unsigned int data_path, unsigned int hs_enable)
+{
+	int ret = -1;
+
+	WARN_ON(dsim = NULL);
+
+	if (hs_enable) {
+		if (dsim->state = DSIM_STATE_HSCLKEN) {
+			s5p_dsim_set_data_mode(dsim, data_path,
+				DSIM_STATE_HSCLKEN);
+			ret = 0;
+		} else {
+			dev_err(dsim->dev, "HS Clock lane is not enabled.\n");
+			ret = -EINVAL;
+		}
+	} else {
+		if (dsim->state = DSIM_STATE_INIT || dsim->state =
+			DSIM_STATE_ULPS) {
+			dev_err(dsim->dev,
+				"DSI Master is not STOP or HSDT state.\n");
+			ret = -EINVAL;
+		} else {
+			s5p_dsim_set_data_mode(dsim, data_path,
+				DSIM_STATE_STOP);
+			ret = 0;
+		}
+	}
+
+	return ret;
+}
+
+int s5p_dsim_get_frame_done_status(void *dsim_data)
+{
+	struct dsim_global *dsim = NULL;
+
+	dsim = (struct dsim_global *)dsim_data;
+
+	WARN_ON(dsim = NULL);
+
+	return _s5p_dsim_get_frame_done_status(dsim);
+}
+
+int s5p_dsim_clear_frame_done(void *dsim_data)
+{
+	struct dsim_global *dsim = NULL;
+
+	dsim = (struct dsim_global *)dsim_data;
+
+	WARN_ON(dsim = NULL);
+
+	_s5p_dsim_clear_frame_done(dsim);
+
+	return 0;
+}
+
+MODULE_AUTHOR("InKi Dae <inki.dae@samsung.com>");
+MODULE_DESCRIPTION("Samusung MIPI-DSIM common driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/s5p_dsim_common.h b/drivers/video/s5p_dsim_common.h
new file mode 100644
index 0000000..7940216
--- /dev/null
+++ b/drivers/video/s5p_dsim_common.h
@@ -0,0 +1,35 @@
+/* linux/drivers/video/s5p_dsim_common.h
+ *
+ * Header file for Samsung MIPI-DSI common driver.
+ *
+ * Copyright (c) 2009 Samsung Electronics
+ * InKi Dae <inki.dae@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef _S5P_DSIM_COMMON_H
+#define _S5P_DSIM_COMMON_H
+
+extern int s5p_dsim_init_header_fifo(struct dsim_global *dsim);
+extern int s5p_dsim_pll_on(struct dsim_global *dsim, unsigned int enable);
+extern unsigned long s5p_dsim_change_pll(struct dsim_global *dsim,
+	unsigned int pre_divider, unsigned int main_divider,
+	unsigned int scaler);
+extern int s5p_dsim_set_clock(struct dsim_global *dsim,
+	unsigned int byte_clk_sel, unsigned int enable);
+extern int s5p_dsim_init_dsim(struct dsim_global *dsim);
+extern int s5p_dsim_set_display_mode(struct dsim_global *dsim,
+	struct dsim_lcd_config *main_lcd, struct dsim_lcd_config *sub_lcd);
+extern int s5p_dsim_init_link(struct dsim_global *dsim);
+extern int s5p_dsim_set_hs_enable(struct dsim_global *dsim);
+extern int s5p_dsim_set_data_transfer_mode(struct dsim_global *dsim,
+	unsigned int data_path, unsigned int hs_enable);
+extern int s5p_dsim_enable_frame_done_int(struct dsim_global *dsim,
+	unsigned int enable);
+
+extern struct fb_info *registered_fb[FB_MAX] __read_mostly;
+
+#endif /* _S5P_DSIM_COMMON_H */
diff --git a/drivers/video/s5p_dsim_lowlevel.c b/drivers/video/s5p_dsim_lowlevel.c
new file mode 100644
index 0000000..4cb2763
--- /dev/null
+++ b/drivers/video/s5p_dsim_lowlevel.c
@@ -0,0 +1,571 @@
+/* linux/drivers/video/s5p-dsim.c
+ *
+ * Samsung MIPI-DSIM lowlevel driver.
+ *
+ * InKi Dae, <inki.dae@samsung.com>
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
+
+#include <mach/map.h>
+
+#include <plat/dsim.h>
+#include <plat/mipi_ddi.h>
+#include <plat/regs-dsim.h>
+
+void s5p_dsim_func_reset(struct dsim_global *dsim)
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
+void s5p_dsim_sw_reset(struct dsim_global *dsim)
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
+void s5p_dsim_set_interrupt_mask(struct dsim_global *dsim, unsigned int mode,
+	unsigned int mask)
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
+void s5p_dsim_init_fifo_pointer(struct dsim_global *dsim, unsigned int cfg)
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
+void s5p_dsim_set_phy_tunning(struct dsim_global *dsim, unsigned int value)
+{
+	writel(DSIM_AFC_CTL(value), dsim->reg_base + S5P_DSIM_PHYACCHR);
+}
+
+void s5p_dsim_set_main_disp_resol(struct dsim_global *dsim,
+	unsigned int vert_resol, unsigned int hori_resol)
+{
+	unsigned int reg;
+
+	/* standby should be set after configuration so set to not ready*/
+	reg = (readl(dsim->reg_base + S5P_DSIM_MDRESOL)) &
+		~(DSIM_MAIN_STAND_BY);
+	writel(reg, dsim->reg_base + S5P_DSIM_MDRESOL);
+
+	reg &= ~(0x7ff << 16) & ~(0x7ff << 0);
+	reg |= DSIM_MAIN_VRESOL(vert_resol) | DSIM_MAIN_HRESOL(hori_resol);
+
+	reg |= DSIM_MAIN_STAND_BY;
+	writel(reg, dsim->reg_base + S5P_DSIM_MDRESOL);
+}
+
+void s5p_dsim_set_main_disp_vporch(struct dsim_global *dsim,
+	unsigned int cmd_allow, unsigned int vfront, unsigned int vback)
+{
+	unsigned int reg;
+
+	reg = (readl(dsim->reg_base + S5P_DSIM_MVPORCH)) &
+		~(DSIM_CMD_ALLOW_MASK) & ~(DSIM_STABLE_VFP_MASK) &
+		~(DSIM_MAIN_VBP_MASK);
+
+	reg |= ((cmd_allow & 0xf) << DSIM_CMD_ALLOW_SHIFT) |
+		((vfront & 0x7ff) << DSIM_STABLE_VFP_SHIFT) |
+		((vback & 0x7ff) << DSIM_MAIN_VBP_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_MVPORCH);
+}
+
+void s5p_dsim_set_main_disp_hporch(struct dsim_global *dsim,
+	unsigned int front, unsigned int back)
+{
+	unsigned int reg;
+
+	reg = (readl(dsim->reg_base + S5P_DSIM_MHPORCH)) &
+		~(DSIM_MAIN_HFP_MASK) & ~(DSIM_MAIN_HBP_MASK);
+
+	reg |= (front << DSIM_MAIN_HFP_SHIFT) | (back << DSIM_MAIN_HBP_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_MHPORCH);
+}
+
+void s5p_dsim_set_main_disp_sync_area(struct dsim_global *dsim,
+	unsigned int vert, unsigned int hori)
+{
+	unsigned int reg;
+
+	reg = (readl(dsim->reg_base + S5P_DSIM_MSYNC)) &
+		~(DSIM_MAIN_VSA_MASK) & ~(DSIM_MAIN_HSA_MASK);
+
+	reg |= ((vert & 0x3ff) << DSIM_MAIN_VSA_SHIFT) |
+		(hori << DSIM_MAIN_HSA_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_MSYNC);
+}
+
+void s5p_dsim_set_sub_disp_resol(struct dsim_global *dsim,
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
+void s5p_dsim_init_config(struct dsim_global *dsim,
+	struct dsim_lcd_config *main_lcd_info,
+	struct dsim_lcd_config *sub_lcd_info, struct dsim_config *dsim_info)
+{
+	unsigned int cfg = (readl(dsim->reg_base + S5P_DSIM_CONFIG)) &
+		~(1 << 28) & ~(0x1f << 20) & ~(0x3 << 5);
+
+	cfg =	(dsim_info->auto_flush << 29) |
+		(dsim_info->eot_disable << 28) |
+		(dsim_info->auto_vertical_cnt << DSIM_AUTO_MODE_SHIFT) |
+		(dsim_info->hse << DSIM_HSE_MODE_SHIFT) |
+		(dsim_info->hfp << DSIM_HFP_MODE_SHIFT) |
+		(dsim_info->hbp << DSIM_HBP_MODE_SHIFT) |
+		(dsim_info->hsa << DSIM_HSA_MODE_SHIFT) |
+		(dsim_info->e_no_data_lane << DSIM_NUM_OF_DATALANE_SHIFT);
+
+	writel(cfg, dsim->reg_base + S5P_DSIM_CONFIG);
+}
+
+void s5p_dsim_display_config(struct dsim_global *dsim,
+	struct dsim_lcd_config *main_lcd, struct dsim_lcd_config *sub_lcd)
+{
+	u32 reg = (readl(dsim->reg_base + S5P_DSIM_CONFIG)) &
+		~(0x3 << 26) & ~(1 << 25) & ~(0x3 << 18) & ~(0x7 << 12) &
+		~(0x3 << 16) & ~(0x7 << 8);
+
+	if (main_lcd->e_interface = DSIM_VIDEO)
+		reg |= (1 << 25);
+	else if (main_lcd->e_interface = DSIM_COMMAND)
+		reg &= ~(1 << 25);
+	else {
+		dev_err(dsim->dev, "this ddi is not MIPI interface.\n");
+		return;
+	}
+	printk("main_lcd->parameter[DSI_VIDEO_MODE_SEL]) : %d\n", main_lcd->parameter[DSI_VIDEO_MODE_SEL]);
+	printk("main_lcd->parameter[DSI_VIRTUAL_CH_ID]) : %d\n", main_lcd->parameter[DSI_VIRTUAL_CH_ID]);
+	printk("main_lcd->parameter[DSI_FORMAT]) : %d\n", main_lcd->parameter[DSI_FORMAT]);
+	/* main lcd */
+	reg |= ((u8) (main_lcd->parameter[DSI_VIDEO_MODE_SEL]) & 0x3) << 26 |
+		((u8) (main_lcd->parameter[DSI_VIRTUAL_CH_ID]) & 0x3) << 18 |
+		((u8) (main_lcd->parameter[DSI_FORMAT]) & 0x7) << 12;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CONFIG);
+}
+
+void s5p_dsim_enable_lane(struct dsim_global *dsim, unsigned int lane,
+	unsigned int enable)
+{
+	unsigned int reg;
+
+	reg = readl(dsim->reg_base + S5P_DSIM_CONFIG);
+
+	if (lane = DSIM_LANE_CLOCK) {
+		if (enable)
+			reg |= (1 << 0);
+		else
+			reg &= ~(1 << 0);
+	} else {
+		if (enable)
+			reg |= (lane << 1);
+		else
+			reg &= ~(lane << 1);
+	}
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CONFIG);
+}
+
+
+void s5p_dsim_set_data_lane_number(struct dsim_global *dsim,
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
+void s5p_dsim_enable_afc(struct dsim_global *dsim, unsigned int enable,
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
+void s5p_dsim_enable_pll_bypass(struct dsim_global *dsim,
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
+void s5p_dsim_set_pll_pms(struct dsim_global *dsim, unsigned int p,
+	unsigned int m, unsigned int s)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_PLLCTRL);
+
+	reg |= ((p & 0x3f) << 13) | ((m & 0x1ff) << 4) | ((s & 0x7) << 1);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_dsim_pll_freq_band(struct dsim_global *dsim, unsigned int freq_band)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)) &
+		~(0x1f << DSIM_FREQ_BAND_SHIFT);
+
+	reg |= ((freq_band & 0x1f) << DSIM_FREQ_BAND_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_dsim_pll_freq(struct dsim_global *dsim, unsigned int pre_divider,
+	unsigned int main_divider, unsigned int scaler)
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
+void s5p_dsim_pll_stable_time(struct dsim_global *dsim,
+	unsigned int lock_time)
+{
+	writel(lock_time, dsim->reg_base + S5P_DSIM_PLLTMR);
+}
+
+void s5p_dsim_enable_pll(struct dsim_global *dsim, unsigned int enable)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)) &
+		~(0x1 << DSIM_PLL_EN_SHIFT);
+
+	reg |= ((enable & 0x1) << DSIM_PLL_EN_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_dsim_set_byte_clock_src(struct dsim_global *dsim, unsigned int src)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)) &
+		~(0x3 << DSIM_BYTE_CLK_SRC_SHIFT);
+
+	reg |= ((unsigned int) src) << DSIM_BYTE_CLK_SRC_SHIFT;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_dsim_enable_byte_clock(struct dsim_global *dsim,
+	unsigned int enable)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)) &
+		~(1 << DSIM_BYTE_CLKEN_SHIFT);
+
+	reg |= enable << DSIM_BYTE_CLKEN_SHIFT;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_dsim_set_esc_clk_prs(struct dsim_global *dsim, unsigned int enable,
+	unsigned int prs_val)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)) &
+		~(1 << DSIM_ESC_CLKEN_SHIFT) & ~(0xffff);
+
+	reg |= enable << DSIM_ESC_CLKEN_SHIFT;
+	if (enable)
+		reg |= prs_val;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_dsim_enable_esc_clk_on_lane(struct dsim_global *dsim,
+	unsigned int lane_sel, unsigned int enable)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_CLKCTRL);
+
+	if (enable) {
+		if (lane_sel & DSIM_LANE_CLOCK)
+			reg |= 1 << DSIM_LANE_ESC_CLKEN_SHIFT;
+		if (lane_sel & DSIM_LANE_DATA0)
+			reg |= 1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 1);
+		if (lane_sel & DSIM_LANE_DATA1)
+			reg |= 1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 2);
+		if (lane_sel & DSIM_LANE_DATA2)
+			reg |= 1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 3);
+		if (lane_sel & DSIM_LANE_DATA2)
+			reg |= 1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 4);
+	} else {
+		if (lane_sel & DSIM_LANE_CLOCK)
+			reg &= ~(1 << DSIM_LANE_ESC_CLKEN_SHIFT);
+		if (lane_sel & DSIM_LANE_DATA0)
+			reg &= ~(1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 1));
+		if (lane_sel & DSIM_LANE_DATA1)
+			reg &= ~(1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 2));
+		if (lane_sel & DSIM_LANE_DATA2)
+			reg &= ~(1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 3));
+		if (lane_sel & DSIM_LANE_DATA2)
+			reg &= ~(1 << (DSIM_LANE_ESC_CLKEN_SHIFT + 4));
+	}
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_dsim_force_dphy_stop_state(struct dsim_global *dsim,
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
+unsigned int s5p_dsim_is_lane_state(struct dsim_global *dsim,
+	unsigned int lane)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_STATUS);
+
+	if ((lane & DSIM_LANE_ALL) > DSIM_LANE_CLOCK) { /* all lane state */
+		if ((reg & 0x7ff) ^ (((lane & 0xf) << 4) | (1 << 9)))
+			return DSIM_LANE_STATE_ULPS;
+		else if ((reg & 0x7ff) ^ (((lane & 0xf) << 0) | (1 << 8)))
+			return DSIM_LANE_STATE_STOP;
+		else {
+			dev_err(dsim->dev, "land state is unknown.\n");
+			return -1;
+		}
+	} else if (lane & DSIM_LANE_DATA_ALL) {	/* data lane */
+		if (reg & (lane << 4))
+			return DSIM_LANE_STATE_ULPS;
+		else if (reg & (lane << 0))
+			return DSIM_LANE_STATE_STOP;
+		else {
+			dev_err(dsim->dev, "data lane state is unknown.\n");
+			return -1;
+		}
+	} else if (lane & DSIM_LANE_CLOCK) { /* clock lane */
+		if (reg & (1 << 9))
+			return DSIM_LANE_STATE_ULPS;
+		else if (reg & (1 << 8))
+			return DSIM_LANE_STATE_STOP;
+		else if (reg & (1 << 10))
+			return DSIM_LANE_STATE_HS_READY;
+		else {
+			dev_err(dsim->dev, "data lane state is unknown.\n");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+void s5p_dsim_set_stop_state_counter(struct dsim_global *dsim,
+	unsigned int cnt_val)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_ESCMODE)) &
+		~(0x7ff << DSIM_STOP_STATE_CNT_SHIFT);
+
+	reg |= ((cnt_val & 0x7ff) << DSIM_STOP_STATE_CNT_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_ESCMODE);
+}
+
+void s5p_dsim_set_bta_timeout(struct dsim_global *dsim, unsigned int timeout)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_TIMEOUT)) &
+		~(0xff << DSIM_BTA_TOUT_SHIFT);
+
+	reg |= (timeout << DSIM_BTA_TOUT_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_TIMEOUT);
+}
+
+void s5p_dsim_set_lpdr_timeout(struct dsim_global *dsim,
+	unsigned int timeout)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_TIMEOUT)) &
+		~(0xffff << DSIM_LPDR_TOUT_SHIFT);
+
+	reg |= (timeout << DSIM_LPDR_TOUT_SHIFT);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_TIMEOUT);
+}
+
+void s5p_dsim_set_data_mode(struct dsim_global *dsim, unsigned int data,
+	unsigned int state)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_ESCMODE);
+
+	if (state = DSIM_STATE_HSCLKEN)
+		reg &= ~data;
+	else
+		reg |= data;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_ESCMODE);
+}
+
+void s5p_dsim_enable_hs_clock(struct dsim_global *dsim, unsigned int enable)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_CLKCTRL)) &
+		~(1 << DSIM_TX_REQUEST_HSCLK_SHIFT);
+
+	reg |= enable << DSIM_TX_REQUEST_HSCLK_SHIFT;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_CLKCTRL);
+}
+
+void s5p_dsim_dp_dn_swap(struct dsim_global *dsim, unsigned int swap_en)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_PHYACCHR1);
+	printk("###################: %d\n", swap_en);
+	reg &= ~(0x3 << 0);
+	reg |= (swap_en & 0x3) << 0;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PHYACCHR1);
+}
+
+void s5p_dsim_hs_zero_ctrl(struct dsim_global *dsim, unsigned int hs_zero)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)) &
+		~(0xf << 28);
+
+	reg |= ((hs_zero & 0xf) << 28);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_dsim_prep_ctrl(struct dsim_global *dsim, unsigned int prep)
+{
+	unsigned int reg = (readl(dsim->reg_base + S5P_DSIM_PLLCTRL)) &
+		~(0x7 << 20);
+
+	reg |= ((prep & 0x7) << 20);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PLLCTRL);
+}
+
+void s5p_dsim_clear_interrupt(struct dsim_global *dsim, unsigned int int_src)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_INTSRC);
+
+	reg |= int_src;
+
+	writel(reg, dsim->reg_base + S5P_DSIM_INTSRC);
+}
+
+unsigned int s5p_dsim_is_pll_stable(struct dsim_global *dsim)
+{
+	unsigned int reg;
+
+	reg = readl(dsim->reg_base + S5P_DSIM_STATUS);
+
+	return reg & (1 << 31) ? 1 : 0;
+}
+
+unsigned int s5p_dsim_get_fifo_state(struct dsim_global *dsim)
+{
+	unsigned int ret;
+
+	ret = readl(dsim->reg_base + S5P_DSIM_FIFOCTRL) & ~(0x1f);
+
+	return ret;
+}
+
+void s5p_dsim_wr_tx_header(struct dsim_global *dsim,
+	unsigned int di, unsigned int data0, unsigned int data1)
+{
+	unsigned int reg = (data1 << 16) | (data0 << 8) | ((di & 0x3f) << 0);
+
+	writel(reg, dsim->reg_base + S5P_DSIM_PKTHDR);
+}
+
+unsigned int _s5p_dsim_get_frame_done_status(struct dsim_global *dsim)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_INTSRC);
+
+	return (reg & INTSRC_FRAME_DONE) ? 1 : 0;
+}
+
+void _s5p_dsim_clear_frame_done(struct dsim_global *dsim)
+{
+	unsigned int reg = readl(dsim->reg_base + S5P_DSIM_INTSRC);
+
+	writel(reg | INTSRC_FRAME_DONE, dsim->reg_base +
+		S5P_DSIM_INTSRC);
+}
+
+void s5p_dsim_wr_tx_data(struct dsim_global *dsim, unsigned int tx_data)
+{
+	writel(tx_data, dsim->reg_base + S5P_DSIM_PAYLOAD);
+}
diff --git a/drivers/video/s5p_dsim_lowlevel.h b/drivers/video/s5p_dsim_lowlevel.h
new file mode 100644
index 0000000..1e9a7c1
--- /dev/null
+++ b/drivers/video/s5p_dsim_lowlevel.h
@@ -0,0 +1,101 @@
+/* linux/drivers/video/s5p_dsim_lowlevel.h
+ *
+ * Header file for Samsung MIPI-DSIM lowlevel driver.
+ *
+ * Copyright (c) 2009 Samsung Electronics
+ * InKi Dae <inki.dae@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef _S5P_DSIM_LOWLEVEL_H
+#define _S5P_DSIM_LOWLEVEL_H
+
+struct dsim_global;
+
+extern void s5p_dsim_func_reset(struct dsim_global *dsim);
+extern void s5p_dsim_sw_reset(struct dsim_global *dsim);
+extern void s5p_dsim_set_interrupt_mask(struct dsim_global *dsim,
+	unsigned int mode, unsigned int mask);
+extern void s5p_dsim_set_data_lane_number(struct dsim_global *dsim,
+	unsigned int count);
+extern void s5p_dsim_init_fifo_pointer(struct dsim_global *dsim,
+	unsigned int cfg);
+extern void s5p_dsim_set_phy_tunning(struct dsim_global *dsim,
+	unsigned int value);
+extern void s5p_dsim_set_phy_tunning(struct dsim_global *dsim,
+	unsigned int value);
+extern void s5p_dsim_set_main_disp_resol(struct dsim_global *dsim,
+	unsigned int vert_resol, unsigned int hori_resol);
+extern void s5p_dsim_set_main_disp_vporch(struct dsim_global *dsim,
+	unsigned int cmd_allow, unsigned int vfront, unsigned int vback);
+extern void s5p_dsim_set_main_disp_hporch(struct dsim_global *dsim,
+	unsigned int front, unsigned int back);
+extern void s5p_dsim_set_main_disp_sync_area(struct dsim_global *dsim,
+	unsigned int vert, unsigned int hori);
+extern void s5p_dsim_set_sub_disp_resol(struct dsim_global *dsim,
+	unsigned int vert, unsigned int hori);
+extern void s5p_dsim_init_config(struct dsim_global *dsim,
+	struct dsim_lcd_config *main_lcd_info,
+	struct dsim_lcd_config *sub_lcd_info, struct dsim_config *dsim_info);
+extern void s5p_dsim_display_config(struct dsim_global *dsim,
+	struct dsim_lcd_config *main_lcd, struct dsim_lcd_config *sub_lcd);
+extern void s5p_dsim_set_data_lane_number(struct dsim_global *dsim,
+	unsigned int count);
+extern void s5p_dsim_enable_lane(struct dsim_global *dsim, unsigned int lane,
+	unsigned int enable);
+extern void s5p_dsim_enable_afc(struct dsim_global *dsim, unsigned int enable,
+	unsigned int afc_code);
+extern void s5p_dsim_enable_pll_bypass(struct dsim_global *dsim,
+	unsigned int enable);
+extern void s5p_dsim_set_pll_pms(struct dsim_global *dsim, unsigned int p,
+	unsigned int m, unsigned int s);
+extern void s5p_dsim_pll_freq_band(struct dsim_global *dsim,
+	unsigned int freq_band);
+extern void s5p_dsim_pll_freq(struct dsim_global *dsim,
+	unsigned int pre_divider, unsigned int main_divider,
+	unsigned int scaler);
+extern void s5p_dsim_pll_stable_time(struct dsim_global *dsim,
+	unsigned int lock_time);
+extern void s5p_dsim_enable_pll(struct dsim_global *dsim,
+	unsigned int enable);
+extern void s5p_dsim_set_byte_clock_src(struct dsim_global *dsim,
+	unsigned int src);
+extern void s5p_dsim_enable_byte_clock(struct dsim_global *dsim,
+	unsigned int enable);
+extern void s5p_dsim_set_esc_clk_prs(struct dsim_global *dsim,
+	unsigned int enable, unsigned int prs_val);
+extern void s5p_dsim_enable_esc_clk_on_lane(struct dsim_global *dsim,
+	unsigned int lane_sel, unsigned int enable);
+extern void s5p_dsim_force_dphy_stop_state(struct dsim_global *dsim,
+	unsigned int enable);
+extern unsigned int s5p_dsim_is_lane_state(struct dsim_global *dsim,
+	unsigned int lane);
+extern void s5p_dsim_set_stop_state_counter(struct dsim_global *dsim,
+	unsigned int cnt_val);
+extern void s5p_dsim_set_bta_timeout(struct dsim_global *dsim,
+	unsigned int timeout);
+extern void s5p_dsim_set_lpdr_timeout(struct dsim_global *dsim,
+	unsigned int timeout);
+extern void s5p_dsim_set_data_mode(struct dsim_global *dsim,
+	unsigned int data, unsigned int state);
+extern void s5p_dsim_enable_hs_clock(struct dsim_global *dsim,
+	unsigned int enable);
+extern void s5p_dsim_dp_dn_swap(struct dsim_global *dsim,
+	unsigned int swap_en);
+extern void s5p_dsim_hs_zero_ctrl(struct dsim_global *dsim,
+	unsigned int hs_zero);
+extern void s5p_dsim_prep_ctrl(struct dsim_global *dsim, unsigned int prep);
+extern void s5p_dsim_clear_interrupt(struct dsim_global *dsim,
+	unsigned int int_src);
+extern unsigned int s5p_dsim_is_pll_stable(struct dsim_global *dsim);
+extern unsigned int s5p_dsim_get_fifo_state(struct dsim_global *dsim);
+extern unsigned int _s5p_dsim_get_frame_done_status(struct dsim_global *dsim);
+extern void _s5p_dsim_clear_frame_done(struct dsim_global *dsim);
+extern void s5p_dsim_wr_tx_header(struct dsim_global *dsim,
+	unsigned int di, unsigned int data0, unsigned int data1);
+extern void s5p_dsim_wr_tx_data(struct dsim_global *dsim, unsigned int tx_data);
+
+#endif /* _S5P_DSIM_LOWLEVEL_H */
-- 
1.6.0.4


From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Sat, 28 Apr 2012 10:20:00 +0000
Subject: [PATCH v2 2/4] video: auo_k190x: add code shared by controller drivers
Message-Id: <201204281220.01281.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

The AUO-K190X controllers share a very similar set of commands and
can therefore also share most of the driver code.

Signed-off-by: Heiko St=C3=BCbner <heiko@sntech.de>
---
changes since v1: fix Kconfig (depends instead of select)
and catch possible runtime-pm mismatch.

 drivers/video/Kconfig       |   17 +
 drivers/video/Makefile      |    1 +
 drivers/video/auo_k190x.c   | 1046 +++++++++++++++++++++++++++++++++++++++=
++++
 drivers/video/auo_k190x.h   |  129 ++++++
 include/video/auo_k190xfb.h |  106 +++++
 5 files changed, 1299 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/auo_k190x.c
 create mode 100644 drivers/video/auo_k190x.h
 create mode 100644 include/video/auo_k190xfb.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index a290be5..31c029b 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2382,6 +2382,23 @@ config FB_BROADSHEET
 	  and could also have been called by other names when coupled with
 	  a bridge adapter.
=20
+config FB_AUO_K190X
+	tristate "AUO-K190X EPD controller support"
+	depends on FB
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
+	select FB_DEFERRED_IO
+	help
+	  Provides support for epaper controllers from the K190X series
+	  of AUO. These controllers can be used to drive epaper displays
+	  from Sipix.
+
+	  This option enables the common support, shared by the individual
+	  controller drivers. You will also have to enable the driver
+	  for the controller type used in your device.
+
 config FB_JZ4740
 	tristate "JZ4740 LCD framebuffer support"
 	depends on FB && MACH_JZ4740
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 9356add..d5406f2 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -118,6 +118,7 @@ obj-$(CONFIG_FB_PMAGB_B)	  +=3D pmagb-b-fb.o
 obj-$(CONFIG_FB_MAXINE)		  +=3D maxinefb.o
 obj-$(CONFIG_FB_METRONOME)        +=3D metronomefb.o
 obj-$(CONFIG_FB_BROADSHEET)       +=3D broadsheetfb.o
+obj-$(CONFIG_FB_AUO_K190X)	  +=3D auo_k190x.o
 obj-$(CONFIG_FB_S1D13XXX)	  +=3D s1d13xxxfb.o
 obj-$(CONFIG_FB_SH7760)		  +=3D sh7760fb.o
 obj-$(CONFIG_FB_IMX)              +=3D imxfb.o
diff --git a/drivers/video/auo_k190x.c b/drivers/video/auo_k190x.c
new file mode 100644
index 0000000..94ba7e7
--- /dev/null
+++ b/drivers/video/auo_k190x.c
@@ -0,0 +1,1046 @@
+/*
+ * Common code for AUO-K190X framebuffer drivers
+ *
+ * Copyright (C) 2012 Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/gpio.h>
+#include <linux/pm_runtime.h>
+#include <linux/fb.h>
+#include <linux/delay.h>
+#include <linux/uaccess.h>
+#include <linux/vmalloc.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/auo_k190xfb.h>
+
+#include "auo_k190x.h"
+
+struct panel_info {
+	int w;
+	int h;
+};
+
+/* table of panel specific parameters to be indexed into by the board driv=
ers */
+static struct panel_info panel_table[] =3D {
+	/* standard 6" */
+	[AUOK190X_RESOLUTION_800_600] =3D {
+		.w =3D 800,
+		.h =3D 600,
+	},
+	/* standard 9" */
+	[AUOK190X_RESOLUTION_1024_768] =3D {
+		.w =3D 1024,
+		.h =3D 768,
+	},
+};
+
+/*
+ * private I80 interface to the board driver
+ */
+
+static void auok190x_issue_data(struct auok190xfb_par *par, u16 data)
+{
+	par->board->set_ctl(par, AUOK190X_I80_WR, 0);
+	par->board->set_hdb(par, data);
+	par->board->set_ctl(par, AUOK190X_I80_WR, 1);
+}
+
+static void auok190x_issue_cmd(struct auok190xfb_par *par, u16 data)
+{
+	par->board->set_ctl(par, AUOK190X_I80_DC, 0);
+	auok190x_issue_data(par, data);
+	par->board->set_ctl(par, AUOK190X_I80_DC, 1);
+}
+
+static int auok190x_issue_pixels(struct auok190xfb_par *par, int size,
+				 u16 *data)
+{
+	struct device *dev =3D par->info->device;
+	int i;
+	u16 tmp;
+
+	if (size & 3) {
+		dev_err(dev, "issue_pixels: size %d must be a multiple of 4\n",
+			size);
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < (size >> 1); i++) {
+		par->board->set_ctl(par, AUOK190X_I80_WR, 0);
+
+		/* simple reduction of 8bit staticgray to 4bit gray
+		 * combines 4 * 4bit pixel values into a 16bit value
+		 */
+		tmp  =3D (data[2*i] & 0xF0) >> 4;
+		tmp |=3D (data[2*i] & 0xF000) >> 8;
+		tmp |=3D (data[2*i+1] & 0xF0) << 4;
+		tmp |=3D (data[2*i+1] & 0xF000);
+
+		par->board->set_hdb(par, tmp);
+		par->board->set_ctl(par, AUOK190X_I80_WR, 1);
+	}
+
+	return 0;
+}
+
+static u16 auok190x_read_data(struct auok190xfb_par *par)
+{
+	u16 data;
+
+	par->board->set_ctl(par, AUOK190X_I80_OE, 0);
+	data =3D par->board->get_hdb(par);
+	par->board->set_ctl(par, AUOK190X_I80_OE, 1);
+
+	return data;
+}
+
+/*
+ * Command interface for the controller drivers
+ */
+
+void auok190x_send_command_nowait(struct auok190xfb_par *par, u16 data)
+{
+	par->board->set_ctl(par, AUOK190X_I80_CS, 0);
+	auok190x_issue_cmd(par, data);
+	par->board->set_ctl(par, AUOK190X_I80_CS, 1);
+}
+EXPORT_SYMBOL_GPL(auok190x_send_command_nowait);
+
+void auok190x_send_cmdargs_nowait(struct auok190xfb_par *par, u16 cmd,
+				  int argc, u16 *argv)
+{
+	int i;
+
+	par->board->set_ctl(par, AUOK190X_I80_CS, 0);
+	auok190x_issue_cmd(par, cmd);
+
+	for (i =3D 0; i < argc; i++)
+		auok190x_issue_data(par, argv[i]);
+	par->board->set_ctl(par, AUOK190X_I80_CS, 1);
+}
+EXPORT_SYMBOL_GPL(auok190x_send_cmdargs_nowait);
+
+int auok190x_send_command(struct auok190xfb_par *par, u16 data)
+{
+	int ret;
+
+	ret =3D par->board->wait_for_rdy(par);
+	if (ret)
+		return ret;
+
+	auok190x_send_command_nowait(par, data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(auok190x_send_command);
+
+int auok190x_send_cmdargs(struct auok190xfb_par *par, u16 cmd,
+			   int argc, u16 *argv)
+{
+	int ret;
+
+	ret =3D par->board->wait_for_rdy(par);
+	if (ret)
+		return ret;
+
+	auok190x_send_cmdargs_nowait(par, cmd, argc, argv);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(auok190x_send_cmdargs);
+
+int auok190x_read_cmdargs(struct auok190xfb_par *par, u16 cmd,
+			   int argc, u16 *argv)
+{
+	int i, ret;
+
+	ret =3D par->board->wait_for_rdy(par);
+	if (ret)
+		return ret;
+
+	par->board->set_ctl(par, AUOK190X_I80_CS, 0);
+	auok190x_issue_cmd(par, cmd);
+
+	for (i =3D 0; i < argc; i++)
+		argv[i] =3D auok190x_read_data(par);
+	par->board->set_ctl(par, AUOK190X_I80_CS, 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(auok190x_read_cmdargs);
+
+void auok190x_send_cmdargs_pixels_nowait(struct auok190xfb_par *par, u16 c=
md,
+				  int argc, u16 *argv, int size, u16 *data)
+{
+	int i;
+
+	par->board->set_ctl(par, AUOK190X_I80_CS, 0);
+
+	auok190x_issue_cmd(par, cmd);
+
+	for (i =3D 0; i < argc; i++)
+		auok190x_issue_data(par, argv[i]);
+
+	auok190x_issue_pixels(par, size, data);
+
+	par->board->set_ctl(par, AUOK190X_I80_CS, 1);
+}
+EXPORT_SYMBOL_GPL(auok190x_send_cmdargs_pixels_nowait);
+
+int auok190x_send_cmdargs_pixels(struct auok190xfb_par *par, u16 cmd,
+				  int argc, u16 *argv, int size, u16 *data)
+{
+	int ret;
+
+	ret =3D par->board->wait_for_rdy(par);
+	if (ret)
+		return ret;
+
+	auok190x_send_cmdargs_pixels_nowait(par, cmd, argc, argv, size, data);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(auok190x_send_cmdargs_pixels);
+
+/*
+ * fbdefio callbacks - common on both controllers.
+ */
+
+static void auok190xfb_dpy_first_io(struct fb_info *info)
+{
+	/* tell runtime-pm that we wish to use the device in a short time */
+	pm_runtime_get(info->device);
+}
+
+/* this is called back from the deferred io workqueue */
+static void auok190xfb_dpy_deferred_io(struct fb_info *info,
+				struct list_head *pagelist)
+{
+	struct fb_deferred_io *fbdefio =3D info->fbdefio;
+	struct auok190xfb_par *par =3D info->par;
+	u16 yres =3D info->var.yres;
+	u16 xres =3D info->var.xres;
+	u16 y1 =3D 0, h =3D 0;
+	int prev_index =3D -1;
+	struct page *cur;
+	int h_inc;
+	int threshold;
+
+	if (!list_empty(pagelist))
+		/* the device resume should've been requested through first_io,
+		 * if the resume did not finish until now, wait for it.
+		 */
+		pm_runtime_barrier(info->device);
+	else
+		/* We reached this via the fsync or some other way.
+		 * In either case the first_io function did not run,
+		 * so we runtime_resume the device here synchronously.
+		 */
+		pm_runtime_get_sync(info->device);
+
+	/* Do a full screen update every n updates to prevent
+	 * excessive darkening of the Sipix display.
+	 * If we do this, there is no need to walk the pages.
+	 */
+	if (par->need_refresh(par)) {
+		par->update_all(par);
+		goto out;
+	}
+
+	/* height increment is fixed per page */
+	h_inc =3D DIV_ROUND_UP(PAGE_SIZE , xres);
+
+	/* calculate number of pages from pixel height */
+	threshold =3D par->consecutive_threshold / h_inc;
+	if (threshold < 1)
+		threshold =3D 1;
+
+	/* walk the written page list and swizzle the data */
+	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
+		if (prev_index < 0) {
+			/* just starting so assign first page */
+			y1 =3D (cur->index << PAGE_SHIFT) / xres;
+			h =3D h_inc;
+		} else if ((cur->index - prev_index) <=3D threshold) {
+			/* page is within our threshold for single updates */
+			h +=3D h_inc * (cur->index - prev_index);
+		} else {
+			/* page not consecutive, issue previous update first */
+			par->update_partial(par, y1, y1 + h);
+
+			/* start over with our non consecutive page */
+			y1 =3D (cur->index << PAGE_SHIFT) / xres;
+			h =3D h_inc;
+		}
+		prev_index =3D cur->index;
+	}
+
+	/* if we still have any pages to update we do so now */
+	if (h >=3D yres)
+		/* its a full screen update, just do it */
+		par->update_all(par);
+	else
+		par->update_partial(par, y1, min((u16) (y1 + h), yres));
+
+out:
+	pm_runtime_mark_last_busy(info->device);
+	pm_runtime_put_autosuspend(info->device);
+}
+
+/*
+ * framebuffer operations
+ */
+
+/*
+ * this is the slow path from userspace. they can seek and write to
+ * the fb. it's inefficient to do anything less than a full screen draw
+ */
+static ssize_t auok190xfb_write(struct fb_info *info, const char __user *b=
uf,
+				size_t count, loff_t *ppos)
+{
+	struct auok190xfb_par *par =3D info->par;
+	unsigned long p =3D *ppos;
+	void *dst;
+	int err =3D 0;
+	unsigned long total_size;
+
+	if (info->state !=3D FBINFO_STATE_RUNNING)
+		return -EPERM;
+
+	total_size =3D info->fix.smem_len;
+
+	if (p > total_size)
+		return -EFBIG;
+
+	if (count > total_size) {
+		err =3D -EFBIG;
+		count =3D total_size;
+	}
+
+	if (count + p > total_size) {
+		if (!err)
+			err =3D -ENOSPC;
+
+		count =3D total_size - p;
+	}
+
+	dst =3D (void *)(info->screen_base + p);
+
+	if (copy_from_user(dst, buf, count))
+		err =3D -EFAULT;
+
+	if  (!err)
+		*ppos +=3D count;
+
+	par->update_all(par);
+
+	return (err) ? err : count;
+}
+
+static void auok190xfb_fillrect(struct fb_info *info,
+				   const struct fb_fillrect *rect)
+{
+	struct auok190xfb_par *par =3D info->par;
+
+	sys_fillrect(info, rect);
+
+	par->update_all(par);
+}
+
+static void auok190xfb_copyarea(struct fb_info *info,
+				   const struct fb_copyarea *area)
+{
+	struct auok190xfb_par *par =3D info->par;
+
+	sys_copyarea(info, area);
+
+	par->update_all(par);
+}
+
+static void auok190xfb_imageblit(struct fb_info *info,
+				const struct fb_image *image)
+{
+	struct auok190xfb_par *par =3D info->par;
+
+	sys_imageblit(info, image);
+
+	par->update_all(par);
+}
+
+static int auok190xfb_check_var(struct fb_var_screeninfo *var,
+				   struct fb_info *info)
+{
+	if (info->var.xres !=3D var->xres || info->var.yres !=3D var->yres ||
+	    info->var.xres_virtual !=3D var->xres_virtual ||
+	    info->var.yres_virtual !=3D var->yres_virtual) {
+		pr_info("%s: Resolution not supported: X%u x Y%u\n",
+			 __func__, var->xres, var->yres);
+		return -EINVAL;
+	}
+
+	/*
+	 *  Memory limit
+	 */
+
+	if ((info->fix.line_length * var->yres_virtual) > info->fix.smem_len) {
+		pr_info("%s: Memory Limit requested yres_virtual =3D %u\n",
+			 __func__, var->yres_virtual);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static struct fb_ops auok190xfb_ops =3D {
+	.owner		=3D THIS_MODULE,
+	.fb_read	=3D fb_sys_read,
+	.fb_write	=3D auok190xfb_write,
+	.fb_fillrect	=3D auok190xfb_fillrect,
+	.fb_copyarea	=3D auok190xfb_copyarea,
+	.fb_imageblit	=3D auok190xfb_imageblit,
+	.fb_check_var	=3D auok190xfb_check_var,
+};
+
+/*
+ * Controller-functions common to both K1900 and K1901
+ */
+
+static int auok190x_read_temperature(struct auok190xfb_par *par)
+{
+	struct device *dev =3D par->info->device;
+	u16 data[4];
+	int temp;
+
+	pm_runtime_get_sync(dev);
+
+	mutex_lock(&(par->io_lock));
+
+	auok190x_read_cmdargs(par, AUOK190X_CMD_READ_VERSION, 4, data);
+
+	mutex_unlock(&(par->io_lock));
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	/* sanitize and split of half-degrees for now */
+	temp =3D ((data[0] & AUOK190X_VERSION_TEMP_MASK) >> 1);
+
+	/* handle positive and negative temperatures */
+	if (temp >=3D 201)
+		return (255 - temp + 1) * (-1);
+	else
+		return temp;
+}
+
+static void auok190x_identify(struct auok190xfb_par *par)
+{
+	struct device *dev =3D par->info->device;
+	u16 data[4];
+
+	pm_runtime_get_sync(dev);
+
+	mutex_lock(&(par->io_lock));
+
+	auok190x_read_cmdargs(par, AUOK190X_CMD_READ_VERSION, 4, data);
+
+	mutex_unlock(&(par->io_lock));
+
+	par->epd_type =3D data[1] & AUOK190X_VERSION_TEMP_MASK;
+
+	par->panel_size_int =3D AUOK190X_VERSION_SIZE_INT(data[2]);
+	par->panel_size_float =3D AUOK190X_VERSION_SIZE_FLOAT(data[2]);
+	par->panel_model =3D AUOK190X_VERSION_MODEL(data[2]);
+
+	par->tcon_version =3D AUOK190X_VERSION_TCON(data[3]);
+	par->lut_version =3D AUOK190X_VERSION_LUT(data[3]);
+
+	dev_dbg(dev, "panel %d.%din, model 0x%x, EPD 0x%x TCON-rev 0x%x, LUT-rev =
0x%x",
+		par->panel_size_int, par->panel_size_float, par->panel_model,
+		par->epd_type, par->tcon_version, par->lut_version);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+}
+
+/*
+ * Sysfs functions
+ */
+
+static ssize_t update_mode_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct fb_info *info =3D dev_get_drvdata(dev);
+	struct auok190xfb_par *par =3D info->par;
+
+	return sprintf(buf, "%d\n", par->update_mode);
+}
+
+static ssize_t update_mode_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct fb_info *info =3D dev_get_drvdata(dev);
+	struct auok190xfb_par *par =3D info->par;
+	int mode, ret;
+
+	ret =3D kstrtoint(buf, 10, &mode);
+	if (ret)
+		return ret;
+
+	par->update_mode =3D mode;
+
+	/* if we enter a better mode, do a full update */
+	if (par->last_mode > 1 && mode < par->last_mode)
+		par->update_all(par);
+
+	return count;
+}
+
+static ssize_t flash_show(struct device *dev, struct device_attribute *att=
r,
+			  char *buf)
+{
+	struct fb_info *info =3D dev_get_drvdata(dev);
+	struct auok190xfb_par *par =3D info->par;
+
+	return sprintf(buf, "%d\n", par->flash);
+}
+
+static ssize_t flash_store(struct device *dev, struct device_attribute *at=
tr,
+			   const char *buf, size_t count)
+{
+	struct fb_info *info =3D dev_get_drvdata(dev);
+	struct auok190xfb_par *par =3D info->par;
+	int flash, ret;
+
+	ret =3D kstrtoint(buf, 10, &flash);
+	if (ret)
+		return ret;
+
+	if (flash > 0)
+		par->flash =3D 1;
+	else
+		par->flash =3D 0;
+
+	return count;
+}
+
+static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct fb_info *info =3D dev_get_drvdata(dev);
+	struct auok190xfb_par *par =3D info->par;
+	int temp;
+
+	temp =3D auok190x_read_temperature(par);
+	return sprintf(buf, "%d\n", temp);
+}
+
+static DEVICE_ATTR(update_mode, 0644, update_mode_show, update_mode_store);
+static DEVICE_ATTR(flash, 0644, flash_show, flash_store);
+static DEVICE_ATTR(temp, 0644, temp_show, NULL);
+
+static struct attribute *auok190x_attributes[] =3D {
+	&dev_attr_update_mode.attr,
+	&dev_attr_flash.attr,
+	&dev_attr_temp.attr,
+	NULL
+};
+
+static const struct attribute_group auok190x_attr_group =3D {
+	.attrs		=3D auok190x_attributes,
+};
+
+static int auok190x_power(struct auok190xfb_par *par, bool on)
+{
+	struct auok190x_board *board =3D par->board;
+	int ret;
+
+	if (on) {
+		/* We should maintain POWER up for at least 80ms before set
+		 * RST_N and SLP_N to high (TCON spec 20100803_v35 p59)
+		 */
+		ret =3D regulator_enable(par->regulator);
+		if (ret)
+			return ret;
+
+		msleep(200);
+		gpio_set_value(board->gpio_nrst, 1);
+		gpio_set_value(board->gpio_nsleep, 1);
+		msleep(200);
+	} else {
+		regulator_disable(par->regulator);
+		gpio_set_value(board->gpio_nrst, 0);
+		gpio_set_value(board->gpio_nsleep, 0);
+	}
+
+	return 0;
+}
+
+/*
+ * Recovery - powercycle the controller
+ */
+
+static void auok190x_recover(struct auok190xfb_par *par)
+{
+	auok190x_power(par, 0);
+	msleep(100);
+	auok190x_power(par, 1);
+
+	par->init(par);
+
+	/* wait for init to complete */
+	par->board->wait_for_rdy(par);
+}
+
+/*
+ * Power-management
+ */
+
+#ifdef CONFIG_PM
+static int auok190x_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct fb_info *info =3D platform_get_drvdata(pdev);
+	struct auok190xfb_par *par =3D info->par;
+	struct auok190x_board *board =3D par->board;
+	u16 standby_param;
+
+	/* take and keep the lock until we are resumed, as the controller
+	 * will never reach the non-busy state when in standby mode
+	 */
+	mutex_lock(&(par->io_lock));
+
+	if (par->standby) {
+		dev_warn(dev, "already in standby, runtime-pm pairing mismatch\n");
+		mutex_unlock(&(par->io_lock));
+		return 0;
+	}
+
+	/* according to runtime_pm.txt runtime_suspend only means, that the
+	 * device will not process data and will not communicate with the CPU
+	 * As we hold the lock, this stays true even without standby
+	 */
+	if (board->quirks & AUOK190X_QUIRK_STANDBYBROKEN) {
+		dev_dbg(dev, "runtime suspend without standby\n");
+		goto finish;
+	} else if (board->quirks & AUOK190X_QUIRK_STANDBYPARAM) {
+		/* for some TCON versions STANDBY expects a parameter (0) but
+		 * it seems the real tcon version has to be determined yet.
+		 */
+		dev_dbg(dev, "runtime suspend with additional empty param\n");
+		standby_param =3D 0;
+		auok190x_send_cmdargs(par, AUOK190X_CMD_STANDBY, 1,
+				      &standby_param);
+	} else {
+		dev_dbg(dev, "runtime suspend without param\n");
+		auok190x_send_command(par, AUOK190X_CMD_STANDBY);
+	}
+
+	msleep(64);
+
+finish:
+	par->standby =3D 1;
+
+	return 0;
+}
+
+static int auok190x_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct fb_info *info =3D platform_get_drvdata(pdev);
+	struct auok190xfb_par *par =3D info->par;
+	struct auok190x_board *board =3D par->board;
+
+	if (!par->standby) {
+		dev_warn(dev, "not in standby, runtime-pm pairing mismatch\n");
+		return 0;
+	}
+
+	if (board->quirks & AUOK190X_QUIRK_STANDBYBROKEN) {
+		dev_dbg(dev, "runtime resume without standby\n");
+	} else {
+		/* when in standby, controller is always busy
+		 * and only accepts the wakeup command
+		 */
+		dev_dbg(dev, "runtime resume from standby\n");
+		auok190x_send_command_nowait(par, AUOK190X_CMD_WAKEUP);
+
+		msleep(160);
+
+		/* wait for the controller to be ready and release the lock */
+		board->wait_for_rdy(par);
+	}
+
+	par->standby =3D 0;
+
+	mutex_unlock(&(par->io_lock));
+
+	return 0;
+}
+
+static int auok190x_suspend(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct fb_info *info =3D platform_get_drvdata(pdev);
+	struct auok190xfb_par *par =3D info->par;
+	struct auok190x_board *board =3D par->board;
+	int ret;
+
+	dev_dbg(dev, "suspend\n");
+	if (board->quirks & AUOK190X_QUIRK_STANDBYBROKEN) {
+		/* suspend via powering off the ic */
+		dev_dbg(dev, "suspend with broken standby\n");
+
+		auok190x_power(par, 0);
+	} else {
+		dev_dbg(dev, "suspend using sleep\n");
+
+		/* the sleep state can only be entered from the standby state.
+		 * pm_runtime_get_noresume gets called before the suspend call.
+		 * So the devices usage count is >0 but it is not necessarily
+		 * active.
+		 */
+		if (!pm_runtime_status_suspended(dev)) {
+			ret =3D auok190x_runtime_suspend(dev);
+			if (ret < 0) {
+				dev_err(dev, "auok190x_runtime_suspend failed with %d\n",
+					ret);
+				return ret;
+			}
+			par->manual_standby =3D 1;
+		}
+
+		gpio_direction_output(board->gpio_nsleep, 0);
+	}
+
+	msleep(100);
+
+	return 0;
+}
+
+static int auok190x_resume(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct fb_info *info =3D platform_get_drvdata(pdev);
+	struct auok190xfb_par *par =3D info->par;
+	struct auok190x_board *board =3D par->board;
+
+	dev_dbg(dev, "resume\n");
+	if (board->quirks & AUOK190X_QUIRK_STANDBYBROKEN) {
+		dev_dbg(dev, "resume with broken standby\n");
+
+		auok190x_power(par, 1);
+
+		par->init(par);
+	} else {
+		dev_dbg(dev, "resume from sleep\n");
+
+		/* device should be in runtime suspend when we were suspended
+		 * and pm_runtime_put_sync gets called after this function.
+		 * So there is no need to touch the standby mode here at all.
+		 */
+		gpio_direction_output(board->gpio_nsleep, 1);
+		msleep(100);
+
+		/* an additional init call seems to be necessary after sleep */
+		auok190x_runtime_resume(dev);
+		par->init(par);
+
+		/* if we were runtime-suspended before, suspend again*/
+		if (!par->manual_standby)
+			auok190x_runtime_suspend(dev);
+		else
+			par->manual_standby =3D 0;
+	}
+
+	return 0;
+}
+#endif
+
+const struct dev_pm_ops auok190x_pm =3D {
+	SET_RUNTIME_PM_OPS(auok190x_runtime_suspend, auok190x_runtime_resume,
+			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(auok190x_suspend, auok190x_resume)
+};
+EXPORT_SYMBOL_GPL(auok190x_pm);
+
+/*
+ * Common probe and remove code
+ */
+
+int __devinit auok190x_common_probe(struct platform_device *pdev,
+				    struct auok190x_init_data *init)
+{
+	struct auok190x_board *board =3D init->board;
+	struct auok190xfb_par *par;
+	struct fb_info *info;
+	struct panel_info *panel;
+	int videomemorysize, ret;
+	unsigned char *videomemory;
+
+	/* check board contents */
+	if (!board->init || !board->cleanup || !board->wait_for_rdy
+	    || !board->set_ctl || !board->set_hdb || !board->get_hdb
+	    || !board->setup_irq)
+		return -EINVAL;
+
+	info =3D framebuffer_alloc(sizeof(struct auok190xfb_par), &pdev->dev);
+	if (!info)
+		return -ENOMEM;
+
+	par =3D info->par;
+	par->info =3D info;
+	par->board =3D board;
+	par->recover =3D auok190x_recover;
+	par->update_partial =3D init->update_partial;
+	par->update_all =3D init->update_all;
+	par->need_refresh =3D init->need_refresh;
+	par->init =3D init->init;
+
+	/* init update modes */
+	par->update_cnt =3D 0;
+	par->update_mode =3D -1;
+	par->last_mode =3D -1;
+	par->flash =3D 0;
+
+	par->regulator =3D regulator_get(info->device, "vdd");
+	if (IS_ERR(par->regulator)) {
+		ret =3D PTR_ERR(par->regulator);
+		dev_err(info->device, "Failed to get regulator: %d\n", ret);
+		goto err_reg;
+	}
+
+	ret =3D board->init(par);
+	if (ret) {
+		dev_err(info->device, "board init failed, %d\n", ret);
+		goto err_board;
+	}
+
+	ret =3D gpio_request(board->gpio_nsleep, "AUOK190x sleep");
+	if (ret) {
+		dev_err(info->device, "could not request sleep gpio, %d\n",
+			ret);
+		goto err_gpio1;
+	}
+
+	ret =3D gpio_direction_output(board->gpio_nsleep, 0);
+	if (ret) {
+		dev_err(info->device, "could not set sleep gpio, %d\n", ret);
+		goto err_gpio2;
+	}
+
+	ret =3D gpio_request(board->gpio_nrst, "AUOK190x reset");
+	if (ret) {
+		dev_err(info->device, "could not request reset gpio, %d\n",
+			ret);
+		goto err_gpio2;
+	}
+
+	ret =3D gpio_direction_output(board->gpio_nrst, 0);
+	if (ret) {
+		dev_err(info->device, "could not set reset gpio, %d\n", ret);
+		goto err_gpio3;
+	}
+
+	ret =3D auok190x_power(par, 1);
+	if (ret) {
+		dev_err(info->device, "could not power on the device, %d\n",
+			ret);
+		goto err_gpio3;
+	}
+
+	mutex_init(&par->io_lock);
+
+	init_waitqueue_head(&par->waitq);
+
+	ret =3D par->board->setup_irq(par->info);
+	if (ret) {
+		dev_err(info->device, "could not setup ready-irq, %d\n", ret);
+		goto err_irq;
+	}
+
+	/* wait for init to complete */
+	par->board->wait_for_rdy(par);
+
+	/*
+	 * From here on the controller can talk to us
+	 */
+
+	/* initialise fix, var, resolution and rotation */
+
+	strlcpy(info->fix.id, init->id, 16);
+	info->fix.type =3D FB_TYPE_PACKED_PIXELS;
+	info->fix.visual =3D FB_VISUAL_STATIC_PSEUDOCOLOR;
+	info->fix.xpanstep =3D 0;
+	info->fix.ypanstep =3D 0;
+	info->fix.ywrapstep =3D 0;
+	info->fix.accel =3D FB_ACCEL_NONE;
+
+	info->var.bits_per_pixel =3D 8;
+	info->var.grayscale =3D 1;
+	info->var.red.length =3D 8;
+	info->var.green.length =3D 8;
+	info->var.blue.length =3D 8;
+
+	panel =3D &panel_table[board->resolution];
+
+	/* if 90 degree rotation, switch width and height */
+	if (board->rotation & 1) {
+		info->var.xres =3D panel->h;
+		info->var.yres =3D panel->w;
+		info->var.xres_virtual =3D panel->h;
+		info->var.yres_virtual =3D panel->w;
+		info->fix.line_length =3D panel->h;
+	} else {
+		info->var.xres =3D panel->w;
+		info->var.yres =3D panel->h;
+		info->var.xres_virtual =3D panel->w;
+		info->var.yres_virtual =3D panel->h;
+		info->fix.line_length =3D panel->w;
+	}
+
+	par->resolution =3D board->resolution;
+	par->rotation =3D board->rotation;
+
+	/* videomemory handling */
+
+	videomemorysize =3D roundup((panel->w * panel->h), PAGE_SIZE);
+	videomemory =3D vmalloc(videomemorysize);
+	if (!videomemory) {
+		ret =3D -ENOMEM;
+		goto err_irq;
+	}
+
+	memset(videomemory, 0, videomemorysize);
+	info->screen_base =3D (char *)videomemory;
+	info->fix.smem_len =3D videomemorysize;
+
+	info->flags =3D FBINFO_FLAG_DEFAULT | FBINFO_VIRTFB;
+	info->fbops =3D &auok190xfb_ops;
+
+	/* deferred io init */
+
+	info->fbdefio =3D devm_kzalloc(info->device,
+				     sizeof(struct fb_deferred_io),
+				     GFP_KERNEL);
+	if (!info->fbdefio) {
+		dev_err(info->device, "Failed to allocate memory\n");
+		ret =3D -ENOMEM;
+		goto err_defio;
+	}
+
+	dev_dbg(info->device, "targetting %d frames per second\n", board->fps);
+	info->fbdefio->delay =3D HZ / board->fps;
+	info->fbdefio->first_io =3D auok190xfb_dpy_first_io,
+	info->fbdefio->deferred_io =3D auok190xfb_dpy_deferred_io,
+	fb_deferred_io_init(info);
+
+	/* color map */
+
+	ret =3D fb_alloc_cmap(&info->cmap, 256, 0);
+	if (ret < 0) {
+		dev_err(info->device, "Failed to allocate colormap\n");
+		goto err_cmap;
+	}
+
+	/* controller init */
+
+	par->consecutive_threshold =3D 100;
+	par->init(par);
+	auok190x_identify(par);
+
+	platform_set_drvdata(pdev, info);
+
+	ret =3D register_framebuffer(info);
+	if (ret < 0)
+		goto err_regfb;
+
+	ret =3D sysfs_create_group(&info->device->kobj, &auok190x_attr_group);
+	if (ret)
+		goto err_sysfs;
+
+	dev_info(info->device, "fb%d: %dx%d using %dK of video memory\n",
+		 info->node, info->var.xres, info->var.yres,
+		 videomemorysize >> 10);
+
+	/* increase autosuspend_delay when we use alternative methods
+	 * for runtime_pm
+	 */
+	par->autosuspend_delay =3D (board->quirks & AUOK190X_QUIRK_STANDBYBROKEN)
+					? 1000 : 200;
+
+	pm_runtime_set_active(info->device);
+	pm_runtime_enable(info->device);
+	pm_runtime_set_autosuspend_delay(info->device, par->autosuspend_delay);
+	pm_runtime_use_autosuspend(info->device);
+
+	return 0;
+
+err_sysfs:
+	unregister_framebuffer(info);
+err_regfb:
+	fb_dealloc_cmap(&info->cmap);
+err_cmap:
+	fb_deferred_io_cleanup(info);
+	kfree(info->fbdefio);
+err_defio:
+	vfree((void *)info->screen_base);
+err_irq:
+	auok190x_power(par, 0);
+err_gpio3:
+	gpio_free(board->gpio_nrst);
+err_gpio2:
+	gpio_free(board->gpio_nsleep);
+err_gpio1:
+	board->cleanup(par);
+err_board:
+	regulator_put(par->regulator);
+err_reg:
+	framebuffer_release(info);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(auok190x_common_probe);
+
+int  __devexit auok190x_common_remove(struct platform_device *pdev)
+{
+	struct fb_info *info =3D platform_get_drvdata(pdev);
+	struct auok190xfb_par *par =3D info->par;
+	struct auok190x_board *board =3D par->board;
+
+	pm_runtime_disable(info->device);
+
+	sysfs_remove_group(&info->device->kobj, &auok190x_attr_group);
+
+	unregister_framebuffer(info);
+
+	fb_dealloc_cmap(&info->cmap);
+
+	fb_deferred_io_cleanup(info);
+	kfree(info->fbdefio);
+
+	vfree((void *)info->screen_base);
+
+	auok190x_power(par, 0);
+
+	gpio_free(board->gpio_nrst);
+	gpio_free(board->gpio_nsleep);
+
+	board->cleanup(par);
+
+	regulator_put(par->regulator);
+
+	framebuffer_release(info);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(auok190x_common_remove);
+
+MODULE_DESCRIPTION("Common code for AUO-K190X controllers");
+MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/auo_k190x.h b/drivers/video/auo_k190x.h
new file mode 100644
index 0000000..e35af1f
--- /dev/null
+++ b/drivers/video/auo_k190x.h
@@ -0,0 +1,129 @@
+/*
+ * Private common definitions for AUO-K190X framebuffer drivers
+ *
+ * Copyright (C) 2012 Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * I80 interface specific defines
+ */
+
+#define AUOK190X_I80_CS			0x01
+#define AUOK190X_I80_DC			0x02
+#define AUOK190X_I80_WR			0x03
+#define AUOK190X_I80_OE			0x04
+
+/*
+ * AUOK190x commands, common to both controllers
+ */
+
+#define AUOK190X_CMD_INIT		0x0000
+#define AUOK190X_CMD_STANDBY		0x0001
+#define AUOK190X_CMD_WAKEUP		0x0002
+#define AUOK190X_CMD_TCON_RESET		0x0003
+#define AUOK190X_CMD_DATA_STOP		0x1002
+#define AUOK190X_CMD_LUT_START		0x1003
+#define AUOK190X_CMD_DISP_REFRESH	0x1004
+#define AUOK190X_CMD_DISP_RESET		0x1005
+#define AUOK190X_CMD_PRE_DISPLAY_START	0x100D
+#define AUOK190X_CMD_PRE_DISPLAY_STOP	0x100F
+#define AUOK190X_CMD_FLASH_W		0x2000
+#define AUOK190X_CMD_FLASH_E		0x2001
+#define AUOK190X_CMD_FLASH_STS		0x2002
+#define AUOK190X_CMD_FRAMERATE		0x3000
+#define AUOK190X_CMD_READ_VERSION	0x4000
+#define AUOK190X_CMD_READ_STATUS	0x4001
+#define AUOK190X_CMD_READ_LUT		0x4003
+#define AUOK190X_CMD_DRIVERTIMING	0x5000
+#define AUOK190X_CMD_LBALANCE		0x5001
+#define AUOK190X_CMD_AGINGMODE		0x6000
+#define AUOK190X_CMD_AGINGEXIT		0x6001
+
+/*
+ * Common settings for AUOK190X_CMD_INIT
+ */
+
+#define AUOK190X_INIT_DATA_FILTER	(0 << 12)
+#define AUOK190X_INIT_DATA_BYPASS	(1 << 12)
+#define AUOK190X_INIT_INVERSE_WHITE	(0 << 9)
+#define AUOK190X_INIT_INVERSE_BLACK	(1 << 9)
+#define AUOK190X_INIT_SCAN_DOWN		(0 << 1)
+#define AUOK190X_INIT_SCAN_UP		(1 << 1)
+#define AUOK190X_INIT_SHIFT_LEFT	(0 << 0)
+#define AUOK190X_INIT_SHIFT_RIGHT	(1 << 0)
+
+/* Common bits to pixels
+ *   Mode	15-12	11-8	7-4	3-0
+ *   format0	4	3	2	1
+ *   format1	3	4	1	2
+ */
+
+#define AUOK190X_INIT_FORMAT0		0
+#define AUOK190X_INIT_FORMAT1		(1 << 6)
+
+/*
+ * settings for AUOK190X_CMD_RESET
+ */
+
+#define AUOK190X_RESET_TCON		(0 << 0)
+#define AUOK190X_RESET_NORMAL		(1 << 0)
+#define AUOK190X_RESET_PON		(1 << 1)
+
+/*
+ * AUOK190X_CMD_VERSION
+ */
+
+#define AUOK190X_VERSION_TEMP_MASK		(0x1ff)
+#define AUOK190X_VERSION_EPD_MASK		(0xff)
+#define AUOK190X_VERSION_SIZE_INT(_val)		((_val & 0xfc00) >> 10)
+#define AUOK190X_VERSION_SIZE_FLOAT(_val)	((_val & 0x3c0) >> 6)
+#define AUOK190X_VERSION_MODEL(_val)		(_val & 0x3f)
+#define AUOK190X_VERSION_LUT(_val)		(_val & 0xff)
+#define AUOK190X_VERSION_TCON(_val)		((_val & 0xff00) >> 8)
+
+/*
+ * update modes for CMD_PARTIALDISP on K1900 and CMD_DDMA on K1901
+ */
+
+#define AUOK190X_UPDATE_MODE(_res)		((_res & 0x7) << 12)
+#define AUOK190X_UPDATE_NONFLASH		(1 << 15)
+
+/*
+ * track panel specific parameters for common init
+ */
+
+struct auok190x_init_data {
+	char *id;
+	struct auok190x_board *board;
+
+	void (*update_partial)(struct auok190xfb_par *par, u16 y1, u16 y2);
+	void (*update_all)(struct auok190xfb_par *par);
+	bool (*need_refresh)(struct auok190xfb_par *par);
+	void (*init)(struct auok190xfb_par *par);
+};
+
+
+extern void auok190x_send_command_nowait(struct auok190xfb_par *par, u16 d=
ata);
+extern int auok190x_send_command(struct auok190xfb_par *par, u16 data);
+extern void auok190x_send_cmdargs_nowait(struct auok190xfb_par *par, u16 c=
md,
+					 int argc, u16 *argv);
+extern int auok190x_send_cmdargs(struct auok190xfb_par *par, u16 cmd,
+				  int argc, u16 *argv);
+extern void auok190x_send_cmdargs_pixels_nowait(struct auok190xfb_par *par,
+						u16 cmd, int argc, u16 *argv,
+						int size, u16 *data);
+extern int auok190x_send_cmdargs_pixels(struct auok190xfb_par *par, u16 cm=
d,
+					int argc, u16 *argv, int size,
+					u16 *data);
+extern int auok190x_read_cmdargs(struct auok190xfb_par *par, u16 cmd,
+				  int argc, u16 *argv);
+
+extern int auok190x_common_probe(struct platform_device *pdev,
+				 struct auok190x_init_data *init);
+extern int auok190x_common_remove(struct platform_device *pdev);
+
+extern const struct dev_pm_ops auok190x_pm;
diff --git a/include/video/auo_k190xfb.h b/include/video/auo_k190xfb.h
new file mode 100644
index 0000000..609efe8
--- /dev/null
+++ b/include/video/auo_k190xfb.h
@@ -0,0 +1,106 @@
+/*
+ * Definitions for AUO-K190X framebuffer drivers
+ *
+ * Copyright (C) 2012 Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _LINUX_VIDEO_AUO_K190XFB_H_
+#define _LINUX_VIDEO_AUO_K190XFB_H_
+
+/* Controller standby command needs a param */
+#define AUOK190X_QUIRK_STANDBYPARAM	(1 << 0)
+
+/* Controller standby is completely broken */
+#define AUOK190X_QUIRK_STANDBYBROKEN	(1 << 1)
+
+/*
+ * Resolutions for the displays
+ */
+#define AUOK190X_RESOLUTION_800_600		0
+#define AUOK190X_RESOLUTION_1024_768		1
+
+/*
+ * struct used by auok190x. board specific stuff comes from *board
+ */
+struct auok190xfb_par {
+	struct fb_info *info;
+	struct auok190x_board *board;
+
+	struct regulator *regulator;
+
+	struct mutex io_lock;
+	struct delayed_work work;
+	wait_queue_head_t waitq;
+	int resolution;
+	int rotation;
+	int consecutive_threshold;
+	int update_cnt;
+
+	/* panel and controller informations */
+	int epd_type;
+	int panel_size_int;
+	int panel_size_float;
+	int panel_model;
+	int tcon_version;
+	int lut_version;
+
+	/* individual controller callbacks */
+	void (*update_partial)(struct auok190xfb_par *par, u16 y1, u16 y2);
+	void (*update_all)(struct auok190xfb_par *par);
+	bool (*need_refresh)(struct auok190xfb_par *par);
+	void (*init)(struct auok190xfb_par *par);
+	void (*recover)(struct auok190xfb_par *par);
+
+	int update_mode; /* mode to use for updates */
+	int last_mode; /* update mode last used */
+	int flash;
+
+	/* power management */
+	int autosuspend_delay;
+	bool standby;
+	bool manual_standby;
+};
+
+/**
+ * Board specific platform-data
+ * @init:		initialize the controller interface
+ * @cleanup:		cleanup the controller interface
+ * @wait_for_rdy:	wait until the controller is not busy anymore
+ * @set_ctl:		change an interface control
+ * @set_hdb:		write a value to the data register
+ * @get_hdb:		read a value from the data register
+ * @setup_irq:		method to setup the irq handling on the busy gpio
+ * @gpio_nsleep:	sleep gpio
+ * @gpio_nrst:		reset gpio
+ * @gpio_nbusy:		busy gpio
+ * @resolution:		one of the AUOK190X_RESOLUTION constants
+ * @rotation:		rotation of the framebuffer
+ * @quirks:		controller quirks to honor
+ * @fps:		frames per second for defio
+ */
+struct auok190x_board {
+	int (*init)(struct auok190xfb_par *);
+	void (*cleanup)(struct auok190xfb_par *);
+	int (*wait_for_rdy)(struct auok190xfb_par *);
+
+	void (*set_ctl)(struct auok190xfb_par *, unsigned char, u8);
+	void (*set_hdb)(struct auok190xfb_par *, u16);
+	u16 (*get_hdb)(struct auok190xfb_par *);
+
+	int (*setup_irq)(struct fb_info *);
+
+	int gpio_nsleep;
+	int gpio_nrst;
+	int gpio_nbusy;
+
+	int resolution;
+	int rotation;
+	int quirks;
+	int fps;
+};
+
+#endif
--=20
1.7.5.4


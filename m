From: Zhou Zhu <zzhu3@marvell.com>
Date: Fri, 01 Feb 2013 09:19:52 +0000
Subject: [PATCH v6 1/8] video: mmp display subsystem
Message-Id: <1359710392-9200-1-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Added mmp display subsystem to support Marvell MMP display controllers.

This subsystem contains 4 parts:
--fb folder
--core.c
--hw folder
--panel folder

1. fb folder contains implementation of fb.
fb get path and overlay from common interface and operates on these structures.

2. core.c provides common interface for a hardware abstraction.
Major parts of this interface are:
a) Path: path is a output device connected to a panel or HDMI TV.
Main operations of the path is set/get timing/output color.
fb operates output device through path structure.
b) Ovly: Ovly is a buffer shown on the path.
Ovly describes frame buffer and its source/destination size, offset, input
color, buffer address, z-order, and so on.
Each fb device maps to one overlay.

3. hw folder contains implementation of hardware operations defined by core.c.
It registers paths for fb use.

4. panel folder contains implementation of panels.
It's connected to path. Panel drivers would also regiester panels and linked
to path when probe.

Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
Signed-off-by: Lisa Du <cldu@marvell.com>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/video/Kconfig      |    1 +
 drivers/video/Makefile     |    1 +
 drivers/video/mmp/Kconfig  |    5 +
 drivers/video/mmp/Makefile |    1 +
 drivers/video/mmp/core.c   |  258 ++++++++++++++++++++++++++++++++
 include/video/mmp_disp.h   |  352 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 618 insertions(+)
 create mode 100644 drivers/video/mmp/Kconfig
 create mode 100644 drivers/video/mmp/Makefile
 create mode 100644 drivers/video/mmp/core.c
 create mode 100644 include/video/mmp_disp.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e7068c5..4ef75bf 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2422,6 +2422,7 @@ config FB_PUV3_UNIGFX
 source "drivers/video/omap/Kconfig"
 source "drivers/video/omap2/Kconfig"
 source "drivers/video/exynos/Kconfig"
+source "drivers/video/mmp/Kconfig"
 source "drivers/video/backlight/Kconfig"
 
 if VT
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 768a137..2991e59 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_FB_ASILIANT)	  += asiliantfb.o
 obj-$(CONFIG_FB_PXA)		  += pxafb.o
 obj-$(CONFIG_FB_PXA168)		  += pxa168fb.o
 obj-$(CONFIG_PXA3XX_GCU)	  += pxa3xx-gcu.o
+obj-$(CONFIG_MMP_DISP)           += mmp/
 obj-$(CONFIG_FB_W100)		  += w100fb.o
 obj-$(CONFIG_FB_TMIO)		  += tmiofb.o
 obj-$(CONFIG_FB_AU1100)		  += au1100fb.o
diff --git a/drivers/video/mmp/Kconfig b/drivers/video/mmp/Kconfig
new file mode 100644
index 0000000..0554336
--- /dev/null
+++ b/drivers/video/mmp/Kconfig
@@ -0,0 +1,5 @@
+menuconfig MMP_DISP
+        tristate "Marvell MMP Display Subsystem support"
+        depends on CPU_PXA910 || CPU_MMP2 || CPU_MMP3 || CPU_PXA988
+        help
+	  Marvell Display Subsystem support.
diff --git a/drivers/video/mmp/Makefile b/drivers/video/mmp/Makefile
new file mode 100644
index 0000000..820eb10
--- /dev/null
+++ b/drivers/video/mmp/Makefile
@@ -0,0 +1 @@
+obj-y += core.o
diff --git a/drivers/video/mmp/core.c b/drivers/video/mmp/core.c
new file mode 100644
index 0000000..9ed8341
--- /dev/null
+++ b/drivers/video/mmp/core.c
@@ -0,0 +1,258 @@
+/*
+ * linux/drivers/video/mmp/common.c
+ * This driver is a common framework for Marvell Display Controller
+ *
+ * Copyright (C) 2012 Marvell Technology Group Ltd.
+ * Authors: Zhou Zhu <zzhu3@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/export.h>
+#include <video/mmp_disp.h>
+
+static struct mmp_overlay *path_get_overlay(struct mmp_path *path,
+		int overlay_id)
+{
+	if (path && overlay_id < path->overlay_num)
+		return &path->overlays[overlay_id];
+	return 0;
+}
+
+static int path_check_status(struct mmp_path *path)
+{
+	int i;
+	for (i = 0; i < path->overlay_num; i++)
+		if (path->overlays[i].status)
+			return 1;
+
+	return 0;
+}
+
+/*
+ * Get modelist write pointer of modelist.
+ * It also returns modelist number
+ * this function fetches modelist from phy/panel:
+ *   for HDMI/parallel or dsi to hdmi cases, get from phy
+ *   or get from panel
+ */
+static int path_get_modelist(struct mmp_path *path,
+		struct mmp_mode **modelist)
+{
+	BUG_ON(!path || !modelist);
+
+	if (path->panel && path->panel->get_modelist)
+		return path->panel->get_modelist(path->panel, modelist);
+
+	return 0;
+}
+
+/*
+ * panel list is used to pair panel/path when path/panel registered
+ * path list is used for both buffer driver and platdriver
+ * plat driver do path register/unregister
+ * panel driver do panel register/unregister
+ * buffer driver get registered path
+ */
+static LIST_HEAD(panel_list);
+static LIST_HEAD(path_list);
+static DEFINE_MUTEX(disp_lock);
+
+/*
+ * mmp_register_panel - register panel to panel_list and connect to path
+ * @p: panel to be registered
+ *
+ * this function provides interface for panel drivers to register panel
+ * to panel_list and connect to path which matchs panel->plat_path_name.
+ * no error returns when no matching path is found as path register after
+ * panel register is permitted.
+ */
+void mmp_register_panel(struct mmp_panel *panel)
+{
+	struct mmp_path *path;
+
+	mutex_lock(&disp_lock);
+
+	/* add */
+	list_add_tail(&panel->node, &panel_list);
+
+	/* try to register to path */
+	list_for_each_entry(path, &path_list, node) {
+		if (!strcmp(panel->plat_path_name, path->name)) {
+			dev_info(panel->dev, "connect to path %s\n",
+				path->name);
+			path->panel = panel;
+			break;
+		}
+	}
+
+	mutex_unlock(&disp_lock);
+}
+EXPORT_SYMBOL_GPL(mmp_register_panel);
+
+/*
+ * mmp_unregister_panel - unregister panel from panel_list and disconnect
+ * @p: panel to be unregistered
+ *
+ * this function provides interface for panel drivers to unregister panel
+ * from panel_list and disconnect from path.
+ */
+void mmp_unregister_panel(struct mmp_panel *panel)
+{
+	struct mmp_path *path;
+
+	mutex_lock(&disp_lock);
+	list_del(&panel->node);
+
+	list_for_each_entry(path, &path_list, node) {
+		if (path->panel && path->panel = panel) {
+			dev_info(panel->dev, "disconnect from path %s\n",
+				path->name);
+			path->panel = NULL;
+			break;
+		}
+	}
+	mutex_unlock(&disp_lock);
+}
+EXPORT_SYMBOL_GPL(mmp_unregister_panel);
+
+/*
+ * mmp_get_path - get path by name
+ * @p: path name
+ *
+ * this function checks path name in path_list and return matching path
+ * return NULL if no matching path
+ */
+struct mmp_path *mmp_get_path(const char *name)
+{
+	struct mmp_path *path;
+	int found = 0;
+
+	mutex_lock(&disp_lock);
+	list_for_each_entry(path, &path_list, node) {
+		if (!strcmp(name, path->name)) {
+			found = 1;
+			break;
+		}
+	}
+	mutex_unlock(&disp_lock);
+
+	return found ? path : NULL;
+}
+EXPORT_SYMBOL_GPL(mmp_get_path);
+
+/*
+ * mmp_register_path - init and register path by path_info
+ * @p: path info provided by display controller
+ *
+ * this function init by path info and register path to path_list
+ * this function also try to connect path with panel by name
+ */
+struct mmp_path *mmp_register_path(struct mmp_path_info *info)
+{
+	int i;
+	size_t size;
+	struct mmp_path *path = NULL;
+	struct mmp_panel *panel;
+
+	size = sizeof(struct mmp_path)
+		+ sizeof(struct mmp_overlay) * info->overlay_num;
+	path = kzalloc(size, GFP_KERNEL);
+	if (!path)
+		goto failed;
+
+	/* path set */
+	mutex_init(&path->access_ok);
+	path->dev = info->dev;
+	path->id = info->id;
+	path->name = info->name;
+	path->output_type = info->output_type;
+	path->overlay_num = info->overlay_num;
+	path->plat_data = info->plat_data;
+	path->ops.set_mode = info->set_mode;
+
+	mutex_lock(&disp_lock);
+	/* get panel */
+	list_for_each_entry(panel, &panel_list, node) {
+		if (!strcmp(info->name, panel->plat_path_name)) {
+			dev_info(path->dev, "get panel %s\n", panel->name);
+			path->panel = panel;
+			break;
+		}
+	}
+
+	dev_info(path->dev, "register %s, overlay_num %d\n",
+			path->name, path->overlay_num);
+
+	/* default op set: if already set by driver, never cover it */
+	if (!path->ops.check_status)
+		path->ops.check_status = path_check_status;
+	if (!path->ops.get_overlay)
+		path->ops.get_overlay = path_get_overlay;
+	if (!path->ops.get_modelist)
+		path->ops.get_modelist = path_get_modelist;
+
+	/* step3: init overlays */
+	for (i = 0; i < path->overlay_num; i++) {
+		path->overlays[i].path = path;
+		path->overlays[i].id = i;
+		mutex_init(&path->overlays[i].access_ok);
+		path->overlays[i].ops = info->overlay_ops;
+	}
+
+	/* add to pathlist */
+	list_add_tail(&path->node, &path_list);
+
+	mutex_unlock(&disp_lock);
+	return path;
+
+failed:
+	kfree(path);
+	mutex_unlock(&disp_lock);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(mmp_register_path);
+
+/*
+ * mmp_unregister_path - unregister and destory path
+ * @p: path to be destoried.
+ *
+ * this function registers path and destorys it.
+ */
+void mmp_unregister_path(struct mmp_path *path)
+{
+	int i;
+
+	if (!path)
+		return;
+
+	mutex_lock(&disp_lock);
+	/* del from pathlist */
+	list_del(&path->node);
+
+	/* deinit overlays */
+	for (i = 0; i < path->overlay_num; i++)
+		mutex_destroy(&path->overlays[i].access_ok);
+
+	mutex_destroy(&path->access_ok);
+
+	kfree(path);
+	mutex_unlock(&disp_lock);
+
+	dev_info(path->dev, "de-register %s\n", path->name);
+}
+EXPORT_SYMBOL_GPL(mmp_unregister_path);
diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
new file mode 100644
index 0000000..b9dd1fb
--- /dev/null
+++ b/include/video/mmp_disp.h
@@ -0,0 +1,352 @@
+/*
+ * linux/include/video/mmp_disp.h
+ * Header file for Marvell MMP Display Controller
+ *
+ * Copyright (C) 2012 Marvell Technology Group Ltd.
+ * Authors: Zhou Zhu <zzhu3@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef _MMP_DISP_H_
+#define _MMP_DISP_H_
+#include <linux/kthread.h>
+
+enum {
+	PIXFMT_UYVY = 0,
+	PIXFMT_VYUY,
+	PIXFMT_YUYV,
+	PIXFMT_YUV422P,
+	PIXFMT_YVU422P,
+	PIXFMT_YUV420P,
+	PIXFMT_YVU420P,
+	PIXFMT_RGB565 = 0x100,
+	PIXFMT_BGR565,
+	PIXFMT_RGB1555,
+	PIXFMT_BGR1555,
+	PIXFMT_RGB888PACK,
+	PIXFMT_BGR888PACK,
+	PIXFMT_RGB888UNPACK,
+	PIXFMT_BGR888UNPACK,
+	PIXFMT_RGBA888,
+	PIXFMT_BGRA888,
+	PIXFMT_RGB666, /* for output usage */
+	PIXFMT_PSEUDOCOLOR = 0x200,
+};
+
+static inline int pixfmt_to_stride(int pix_fmt)
+{
+	switch (pix_fmt) {
+	case PIXFMT_RGB565:
+	case PIXFMT_BGR565:
+	case PIXFMT_RGB1555:
+	case PIXFMT_BGR1555:
+	case PIXFMT_UYVY:
+	case PIXFMT_VYUY:
+	case PIXFMT_YUYV:
+		return 2;
+	case PIXFMT_RGB888UNPACK:
+	case PIXFMT_BGR888UNPACK:
+	case PIXFMT_RGBA888:
+	case PIXFMT_BGRA888:
+		return 4;
+	case PIXFMT_RGB888PACK:
+	case PIXFMT_BGR888PACK:
+		return 3;
+	case PIXFMT_YUV422P:
+	case PIXFMT_YVU422P:
+	case PIXFMT_YUV420P:
+	case PIXFMT_YVU420P:
+	case PIXFMT_PSEUDOCOLOR:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+/* parameters used by path/overlay */
+/* overlay related para: win/addr */
+struct mmp_win {
+	/* position/size of window */
+	u16	xsrc;
+	u16	ysrc;
+	u16	xdst;
+	u16	ydst;
+	u16	xpos;
+	u16	ypos;
+	u16	left_crop;
+	u16	right_crop;
+	u16	up_crop;
+	u16	bottom_crop;
+	int	pix_fmt;
+};
+
+struct mmp_addr {
+	/* phys address */
+	u32	phys[6];
+};
+
+/* path related para: mode */
+struct mmp_mode {
+	const char *name;
+	u32 refresh;
+	u32 xres;
+	u32 yres;
+	u32 left_margin;
+	u32 right_margin;
+	u32 upper_margin;
+	u32 lower_margin;
+	u32 hsync_len;
+	u32 vsync_len;
+	u32 hsync_invert;
+	u32 vsync_invert;
+	u32 invert_pixclock;
+	u32 pixclock_freq;
+	int pix_fmt_out;
+};
+
+/* main structures */
+struct mmp_path;
+struct mmp_overlay;
+struct mmp_panel;
+
+/* status types */
+enum {
+	MMP_OFF = 0,
+	MMP_ON,
+};
+
+static inline const char *stat_name(int stat)
+{
+	switch (stat) {
+	case MMP_OFF:
+		return "OFF";
+	case MMP_ON:
+		return "ON";
+	default:
+		return "UNKNOWNSTAT";
+	}
+}
+
+struct mmp_overlay_ops {
+	/* should be provided by driver */
+	void (*set_fetch)(struct mmp_overlay *overlay, int fetch_id);
+	void (*set_onoff)(struct mmp_overlay *overlay, int status);
+	void (*set_win)(struct mmp_overlay *overlay, struct mmp_win *win);
+	int (*set_addr)(struct mmp_overlay *overlay, struct mmp_addr *addr);
+};
+
+/* overlay describes a z-order indexed slot in each path. */
+struct mmp_overlay {
+	int id;
+	const char *name;
+	struct mmp_path *path;
+
+	/* overlay info: private data */
+	int dmafetch_id;
+	struct mmp_addr addr;
+	struct mmp_win win;
+
+	/* state */
+	int open_count;
+	int status;
+	struct mutex access_ok;
+
+	struct mmp_overlay_ops *ops;
+};
+
+/* panel type */
+enum {
+	PANELTYPE_ACTIVE = 0,
+	PANELTYPE_SMART,
+	PANELTYPE_TV,
+	PANELTYPE_DSI_CMD,
+	PANELTYPE_DSI_VIDEO,
+};
+
+struct mmp_panel {
+	/* use node to register to list */
+	struct list_head node;
+	const char *name;
+	/* path name used to connect to proper path configed */
+	const char *plat_path_name;
+	struct device *dev;
+	int panel_type;
+	void *plat_data;
+	int (*get_modelist)(struct mmp_panel *panel,
+			struct mmp_mode **modelist);
+	void (*set_mode)(struct mmp_panel *panel,
+			struct mmp_mode *mode);
+	void (*set_onoff)(struct mmp_panel *panel,
+			int status);
+};
+
+struct mmp_path_ops {
+	int (*check_status)(struct mmp_path *path);
+	struct mmp_overlay *(*get_overlay)(struct mmp_path *path,
+			int overlay_id);
+	int (*get_modelist)(struct mmp_path *path,
+			struct mmp_mode **modelist);
+
+	/* follow ops should be provided by driver */
+	void (*set_mode)(struct mmp_path *path, struct mmp_mode *mode);
+	void (*set_onoff)(struct mmp_path *path, int status);
+	/* todo: add query */
+};
+
+/* path output types */
+enum {
+	PATH_OUT_PARALLEL,
+	PATH_OUT_DSI,
+	PATH_OUT_HDMI,
+};
+
+/* path is main part of mmp-disp */
+struct mmp_path {
+	/* use node to register to list */
+	struct list_head node;
+
+	/* init data */
+	struct device *dev;
+
+	int id;
+	const char *name;
+	int output_type;
+	struct mmp_panel *panel;
+	void *plat_data;
+
+	/* dynamic use */
+	struct mmp_mode mode;
+
+	/* state */
+	int open_count;
+	int status;
+	struct mutex access_ok;
+
+	struct mmp_path_ops ops;
+
+	/* layers */
+	int overlay_num;
+	struct mmp_overlay overlays[0];
+};
+
+extern struct mmp_path *mmp_get_path(const char *name);
+static inline void mmp_path_set_mode(struct mmp_path *path,
+		struct mmp_mode *mode)
+{
+	if (path)
+		path->ops.set_mode(path, mode);
+}
+static inline void mmp_path_set_onoff(struct mmp_path *path, int status)
+{
+	if (path)
+		path->ops.set_onoff(path, status);
+}
+static inline int mmp_path_get_modelist(struct mmp_path *path,
+		struct mmp_mode **modelist)
+{
+	if (path)
+		return path->ops.get_modelist(path, modelist);
+	return 0;
+}
+static inline struct mmp_overlay *mmp_path_get_overlay(
+		struct mmp_path *path, int overlay_id)
+{
+	if (path)
+		return path->ops.get_overlay(path, overlay_id);
+	return NULL;
+}
+static inline void mmp_overlay_set_fetch(struct mmp_overlay *overlay,
+		int fetch_id)
+{
+	if (overlay)
+		overlay->ops->set_fetch(overlay, fetch_id);
+}
+static inline void mmp_overlay_set_onoff(struct mmp_overlay *overlay,
+		int status)
+{
+	if (overlay)
+		overlay->ops->set_onoff(overlay, status);
+}
+static inline void mmp_overlay_set_win(struct mmp_overlay *overlay,
+		struct mmp_win *win)
+{
+	if (overlay)
+		overlay->ops->set_win(overlay, win);
+}
+static inline int mmp_overlay_set_addr(struct mmp_overlay *overlay,
+		struct mmp_addr *addr)
+{
+	if (overlay)
+		return overlay->ops->set_addr(overlay, addr);
+	return 0;
+}
+
+/*
+ * driver data is set from each detailed ctrl driver for path usage
+ * it defined a common interface that plat driver need to implement
+ */
+struct mmp_path_info {
+	/* driver data, set when registed*/
+	const char *name;
+	struct device *dev;
+	int id;
+	int output_type;
+	int overlay_num;
+	void (*set_mode)(struct mmp_path *path, struct mmp_mode *mode);
+	void (*set_onoff)(struct mmp_path *path, int status);
+	struct mmp_overlay_ops *overlay_ops;
+	void *plat_data;
+};
+
+extern struct mmp_path *mmp_register_path(
+		struct mmp_path_info *info);
+extern void mmp_unregister_path(struct mmp_path *path);
+extern void mmp_register_panel(struct mmp_panel *panel);
+extern void mmp_unregister_panel(struct mmp_panel *panel);
+
+/* defintions for platform data */
+/* interface for buffer driver */
+struct mmp_buffer_driver_mach_info {
+	const char	*name;
+	const char	*path_name;
+	int	overlay_id;
+	int	dmafetch_id;
+	int	default_pixfmt;
+};
+
+/* interface for controllers driver */
+struct mmp_mach_path_config {
+	const char *name;
+	int overlay_num;
+	int output_type;
+	u32 path_config;
+	u32 link_config;
+};
+
+struct mmp_mach_plat_info {
+	const char *name;
+	const char *clk_name;
+	int path_num;
+	struct mmp_mach_path_config *paths;
+};
+
+/* interface for panel drivers */
+struct mmp_mach_panel_info {
+	const char *name;
+	void (*plat_set_onoff)(int status);
+	const char *plat_path_name;
+};
+#endif	/* _MMP_DISP_H_ */
-- 
1.7.9.5


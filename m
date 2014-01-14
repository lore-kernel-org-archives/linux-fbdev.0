From: Zhou Zhu <zzhu3@marvell.com>
Date: Tue, 14 Jan 2014 11:16:24 +0000
Subject: [PATCH v2 4/4] video: mmp: add device tree support
Message-Id: <1389698184-28761-5-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389698184-28761-1-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1389698184-28761-1-git-send-email-zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Chao Xie <chao.xie-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Guoqing Li <ligq-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Zhou Zhu <zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

add device tree support for mmp fb/controller
the description of DT config is at
Documentation/devicetree/bindings/fb/mmp-disp.txt

Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
---
 Documentation/devicetree/bindings/fb/mmp-disp.txt |   60 ++++++++
 drivers/video/mmp/fb/mmpfb.c                      |   73 ++++++----
 drivers/video/mmp/hw/mmp_ctrl.c                   |  160 ++++++++++++++++-----
 3 files changed, 235 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fb/mmp-disp.txt

diff --git a/Documentation/devicetree/bindings/fb/mmp-disp.txt b/Documentation/devicetree/bindings/fb/mmp-disp.txt
new file mode 100644
index 0000000..80702f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/fb/mmp-disp.txt
@@ -0,0 +1,60 @@
+* Marvell MMP Display (MMP_DISP)
+
+To config mmp display, 3 parts are required to be set in dts:
+1. mmp fb
+Required properties:
+- compatible: Should be "marvell,<soc>-fb".
+- marvell,path: Should be the path this fb connecting to.
+- marvell,overlay-id: Should be the id of overlay this fb is on.
+- marvell,dmafetch-id: Should be the dma fetch id this fb using.
+- marvell,default-pixfmt: Should be the default pixel format when this fb is
+turned on.
+
+2. mmp controller
+Required properties:
+- compatible: Should be "marvell,<soc>-disp".
+- reg: Should be address and length of the register set for this controller.
+- interrupts: Should be interrupt of this controller.
+
+Required sub-node:
+- path:
+Required properties in this sub-node:
+-- marvell,overlay_num: Should be number of overlay this path has.
+-- marvell,output-type: Should be output-type settings
+-- marvell,path-config: Should be path-config settings
+-- marvell,link-config: Should be link-config settings
+-- marvell,rbswap: Should be rbswap settings
+
+3. panel
+Required properties:
+- marvell,path: Should be path that this panel connected to.
+- other properties each panel has.
+
+Examples:
+
+fb: mmp-fb {
+	compatible = "marvell,pxa988-fb";
+	marvell,path = <&path1>;
+	marvell,overlay-id = <0>;
+	marvell,dmafetch-id = <1>;
+	marvell,default-pixfmt = <0x108>;
+};
+
+disp: mmp-disp@d420b000 {
+	compatible = "marvell,pxa988-disp";
+	reg = <0xd420b000 0x1fc>;
+	interrupts = <0 41 0x4>;
+	path1: mmp-pnpath {
+		marvell,overlay-num = <2>;
+		marvell,output-type = <0>;
+		marvell,path-config = <0x20000000>;
+		marvell,link-config = <0x60000001>;
+		marvell,rbswap = <0>;
+	};
+};
+
+panel: <panel-name> {
+	...
+	marvell,path = <&path1>;
+	...
+};
diff --git a/drivers/video/mmp/fb/mmpfb.c b/drivers/video/mmp/fb/mmpfb.c
index 7ab31eb..f919d8e 100644
--- a/drivers/video/mmp/fb/mmpfb.c
+++ b/drivers/video/mmp/fb/mmpfb.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include "mmpfb.h"
 
 static int var_to_pixfmt(struct fb_var_screeninfo *var)
@@ -551,56 +552,79 @@ static void fb_info_clear(struct fb_info *info)
 	fb_dealloc_cmap(&info->cmap);
 }
 
+static const struct of_device_id mmp_fb_dt_match[] = {
+	{ .compatible = "marvell,mmp-fb" },
+	{ .compatible = "marvell,pxa910-fb" },
+	{ .compatible = "marvell,pxa988-fb" },
+	{},
+};
+
 static int mmpfb_probe(struct platform_device *pdev)
 {
 	struct mmp_buffer_driver_mach_info *mi;
+	struct device_node *np;
 	struct fb_info *info = 0;
 	struct mmpfb_info *fbi = 0;
-	int ret, modes_num;
-
-	mi = pdev->dev.platform_data;
-	if (mi = NULL) {
-		dev_err(&pdev->dev, "no platform data defined\n");
-		return -EINVAL;
-	}
+	int ret = -EINVAL, modes_num;
+	int overlay_id = 0, dmafetch_id = 0;
 
 	/* initialize fb */
 	info = framebuffer_alloc(sizeof(struct mmpfb_info), &pdev->dev);
 	if (info = NULL)
 		return -ENOMEM;
 	fbi = info->par;
-	if (!fbi) {
-		ret = -EINVAL;
+	if (!fbi)
 		goto failed;
+
+	np = pdev->dev.of_node;
+	if (np) {
+		fbi->path = devm_mmp_get_path_by_phandle(&pdev->dev,
+					"marvell,path");
+		if (!fbi->path || of_property_read_u32(np,
+				"marvell,default-pixfmt", &fbi->pix_fmt)) {
+			dev_err(&pdev->dev, "unable to get fb setting from dt\n");
+			goto failed;
+		}
+		/* default setting if not set */
+		of_property_read_u32(np, "marvell,overlay-id", &overlay_id);
+		of_property_read_u32(np, "marvell,dmafetch-id", &dmafetch_id);
+		fbi->name = np->name;
+	} else {
+		mi = pdev->dev.platform_data;
+		if (mi = NULL) {
+			dev_err(&pdev->dev, "no platform data defined\n");
+			goto failed;
+		}
+
+		fbi->path = mmp_get_path(mi->path_name);
+		if (!fbi->path) {
+			dev_err(&pdev->dev, "can't get the path %s\n",
+					mi->path_name);
+			goto failed;
+		}
+
+		fbi->name = mi->name;
+		overlay_id = mi->overlay_id;
+		dmafetch_id = mi->dmafetch_id;
+		fbi->pix_fmt = mi->default_pixfmt;
 	}
 
 	/* init fb */
 	fbi->fb_info = info;
 	platform_set_drvdata(pdev, fbi);
 	fbi->dev = &pdev->dev;
-	fbi->name = mi->name;
-	fbi->pix_fmt = mi->default_pixfmt;
 	pixfmt_to_var(&info->var, fbi->pix_fmt);
 	mutex_init(&fbi->access_ok);
 
-	/* get display path by name */
-	fbi->path = mmp_get_path(mi->path_name);
-	if (!fbi->path) {
-		dev_err(&pdev->dev, "can't get the path %s\n", mi->path_name);
-		ret = -EINVAL;
-		goto failed_destroy_mutex;
-	}
-
 	dev_info(fbi->dev, "path %s get\n", fbi->path->name);
 
 	/* get overlay */
-	fbi->overlay = mmp_path_get_overlay(fbi->path, mi->overlay_id);
-	if (!fbi->overlay) {
-		ret = -EINVAL;
+	fbi->overlay = mmp_path_get_overlay(fbi->path, overlay_id);
+	if (!fbi->overlay)
 		goto failed_destroy_mutex;
-	}
+
 	/* set fetch used */
-	mmp_overlay_set_fetch(fbi->overlay, mi->dmafetch_id);
+	mmp_overlay_set_fetch(fbi->overlay, dmafetch_id);
 
 	modes_num = modes_setup(fbi);
 	if (modes_num < 0) {
@@ -679,6 +703,7 @@ static struct platform_driver mmpfb_driver = {
 	.driver		= {
 		.name	= "mmp-fb",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(mmp_fb_dt_match),
 	},
 	.probe		= mmpfb_probe,
 };
diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
index b65913e..08b2ee7 100644
--- a/drivers/video/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/mmp/hw/mmp_ctrl.c
@@ -37,6 +37,7 @@
 #include <linux/uaccess.h>
 #include <linux/kthread.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include "mmp_ctrl.h"
 
@@ -396,26 +397,43 @@ static void path_set_default(struct mmp_path *path)
 	writel_relaxed(tmp, ctrl_regs(path) + dma_ctrl(0, path->id));
 }
 
-static int path_init(struct mmphw_path_plat *path_plat,
-		struct mmp_mach_path_config *config)
+static int of_path_init(struct mmphw_path_plat *path_plat,
+		struct device_node *path_np)
 {
 	struct mmphw_ctrl *ctrl = path_plat->ctrl;
 	struct mmp_path_info *path_info;
 	struct mmp_path *path = NULL;
 
-	dev_info(ctrl->dev, "%s: %s\n", __func__, config->name);
-
 	/* init driver data */
 	path_info = kzalloc(sizeof(struct mmp_path_info), GFP_KERNEL);
 	if (!path_info) {
-		dev_err(ctrl->dev, "%s: unable to alloc path_info for %s\n",
-				__func__, config->name);
-		return 0;
+		dev_err(ctrl->dev, "%s: unable to alloc path_info\n",
+				__func__);
+		return -ENOMEM;
 	}
-	path_info->name = config->name;
+
+	if (!path_np || of_property_read_u32(path_np, "marvell,overlay-num",
+				&path_info->output_type) ||
+			of_property_read_u32(path_np, "marvell,output-type",
+				&path_info->overlay_num)) {
+		dev_err(ctrl->dev, "%s: unable to get path setting from dt\n",
+			__func__);
+		kfree(path_info);
+		return -EINVAL;
+	}
+	/* allow these settings not set */
+	of_property_read_u32(path_np, "marvell,path-config",
+		&path_plat->path_config);
+	of_property_read_u32(path_np, "marvell,link-config",
+		&path_plat->link_config);
+	of_property_read_u32(path_np, "marvell,rbswap",
+		&path_plat->dsi_rbswap);
+	path_info->name = path_np->name;
+
+	dev_info(ctrl->dev, "%s: %s\n", __func__, path_info->name);
+
 	path_info->id = path_plat->id;
 	path_info->dev = ctrl->dev;
-	path_info->overlay_num = config->overlay_num;
 	path_info->overlay_ops = &mmphw_overlay_ops;
 	path_info->set_mode = path_set_mode;
 	path_info->plat_data = path_plat;
@@ -424,16 +442,56 @@ static int path_init(struct mmphw_path_plat *path_plat,
 	path = mmp_register_path(path_info);
 	if (!path) {
 		kfree(path_info);
-		return 0;
+		return -EINVAL;
 	}
 	path_plat->path = path;
+	path_set_default(path);
+
+	kfree(path_info);
+	return 0;
+}
+
+static int path_init(struct mmphw_path_plat *path_plat,
+		struct mmp_mach_path_config *config)
+{
+	struct mmphw_ctrl *ctrl = path_plat->ctrl;
+	struct mmp_path_info *path_info;
+	struct mmp_path *path = NULL;
+
+	/* init driver data */
+	path_info = kzalloc(sizeof(struct mmp_path_info), GFP_KERNEL);
+	if (!path_info) {
+		dev_err(ctrl->dev, "%s: unable to alloc path_info\n",
+				__func__);
+		return -ENOMEM;
+	}
+
+	path_info->name = config->name;
+	path_info->overlay_num = config->overlay_num;
+	path_info->output_type = config->output_type;
 	path_plat->path_config = config->path_config;
 	path_plat->link_config = config->link_config;
 	path_plat->dsi_rbswap = config->dsi_rbswap;
+
+	dev_info(ctrl->dev, "%s: %s\n", __func__, path_info->name);
+
+	path_info->id = path_plat->id;
+	path_info->dev = ctrl->dev;
+	path_info->overlay_ops = &mmphw_overlay_ops;
+	path_info->set_mode = path_set_mode;
+	path_info->plat_data = path_plat;
+
+	/* create/register platform device */
+	path = mmp_register_path(path_info);
+	if (!path) {
+		kfree(path_info);
+		return -EINVAL;
+	}
+	path_plat->path = path;
 	path_set_default(path);
 
 	kfree(path_info);
-	return 1;
+	return 0;
 }
 
 static void path_deinit(struct mmphw_path_plat *path_plat)
@@ -445,13 +503,22 @@ static void path_deinit(struct mmphw_path_plat *path_plat)
 		mmp_unregister_path(path_plat->path);
 }
 
+static const struct of_device_id mmp_disp_dt_match[] = {
+	{ .compatible = "marvell,mmp-disp" },
+	{ .compatible = "marvell,pxa910-disp" },
+	{ .compatible = "marvell,pxa988-disp" },
+	{},
+};
+
 static int mmphw_probe(struct platform_device *pdev)
 {
-	struct mmp_mach_plat_info *mi;
 	struct resource *res;
-	int ret, i, size, irq;
+	int ret, i, size, irq, path_num;
+	const char *disp_name;
 	struct mmphw_path_plat *path_plat;
 	struct mmphw_ctrl *ctrl = NULL;
+	struct mmp_mach_plat_info *mi = pdev->dev.platform_data;
+	struct device_node *np, *path_np = NULL;
 
 	/* get resources from platform data */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -468,25 +535,38 @@ static int mmphw_probe(struct platform_device *pdev)
 		goto failed;
 	}
 
-	/* get configs from platform data */
-	mi = pdev->dev.platform_data;
-	if (mi = NULL || !mi->path_num || !mi->paths) {
-		dev_err(&pdev->dev, "%s: no platform data defined\n", __func__);
-		ret = -EINVAL;
-		goto failed;
+	np = pdev->dev.of_node;
+	if (np) {
+		path_num = of_get_child_count(np);
+		if (path_num <= 0) {
+			dev_err(&pdev->dev, "%s: failed to get settings from dt\n",
+				__func__);
+			ret = -EINVAL;
+			goto failed;
+		}
+		disp_name = np->name;
+	} else {
+		if (mi = NULL || !mi->path_num || !mi->paths) {
+			dev_err(&pdev->dev, "%s: no platform data defined\n",
+				__func__);
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		disp_name = mi->name;
+		path_num = mi->path_num;
 	}
 
 	/* allocate */
 	size = sizeof(struct mmphw_ctrl) + sizeof(struct mmphw_path_plat) *
-	       mi->path_num;
+	       path_num;
 	ctrl = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
 	if (!ctrl) {
 		ret = -ENOMEM;
 		goto failed;
 	}
-
-	ctrl->name = mi->name;
-	ctrl->path_num = mi->path_num;
+	ctrl->path_num = path_num;
+	ctrl->name = disp_name;
 	ctrl->dev = &pdev->dev;
 	ctrl->irq = irq;
 	platform_set_drvdata(pdev, ctrl);
@@ -532,20 +612,31 @@ static int mmphw_probe(struct platform_device *pdev)
 	/* init global regs */
 	ctrl_set_default(ctrl);
 
-	/* init pathes from machine info and register them */
-	for (i = 0; i < ctrl->path_num; i++) {
-		/* get from config and machine info */
-		path_plat = &ctrl->path_plats[i];
-		path_plat->id = i;
-		path_plat->ctrl = ctrl;
-
-		/* path init */
-		if (!path_init(path_plat, &mi->paths[i])) {
-			ret = -EINVAL;
-			goto failed_path_init;
+	if (np) {
+		i = 0;
+		for_each_child_of_node(np, path_np) {
+			path_plat = &ctrl->path_plats[i];
+			path_plat->id = i;
+			path_plat->ctrl = ctrl;
+			i++;
+
+			ret = of_path_init(path_plat, path_np);
+			if (ret)
+				goto failed_path_init;
+		}
+	} else {
+		for (i = 0; i < ctrl->path_num; i++) {
+			path_plat = &ctrl->path_plats[i];
+			path_plat->id = i;
+			path_plat->ctrl = ctrl;
+
+			ret = path_init(path_plat, &mi->paths[i]);
+			if (ret)
+				goto failed_path_init;
 		}
 	}
 
+
 #ifdef CONFIG_MMP_DISP_SPI
 	ret = lcd_spi_register(ctrl);
 	if (ret < 0)
@@ -573,6 +664,7 @@ static struct platform_driver mmphw_driver = {
 	.driver		= {
 		.name	= "mmp-disp",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(mmp_disp_dt_match),
 	},
 	.probe		= mmphw_probe,
 };
-- 
1.7.9.5


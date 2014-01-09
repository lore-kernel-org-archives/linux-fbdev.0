From: Zhou Zhu <zzhu3@marvell.com>
Date: Thu, 09 Jan 2014 05:13:14 +0000
Subject: [PATCH] video: mmp: add device tree support
Message-Id: <1389244394-10779-1-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

add device tree support for mmp fb/controller
the description at Documentation/devicetree/bindings/fb/mmp-disp.txt

Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
---
 Documentation/devicetree/bindings/fb/mmp-disp.txt |   71 ++++++++++++
 drivers/video/mmp/fb/mmpfb.c                      |   71 ++++++++----
 drivers/video/mmp/hw/mmp_ctrl.c                   |  120 ++++++++++++++++-----
 3 files changed, 217 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fb/mmp-disp.txt

diff --git a/Documentation/devicetree/bindings/fb/mmp-disp.txt b/Documentation/devicetree/bindings/fb/mmp-disp.txt
new file mode 100644
index 0000000..3cf2903
--- /dev/null
+++ b/Documentation/devicetree/bindings/fb/mmp-disp.txt
@@ -0,0 +1,71 @@
+* Marvell MMP Display (MMP_DISP)
+
+To config mmp display, 3 parts are required to be set in dts:
+1. mmp fb
+Required properties:
+- compatible: Should be "marvell,mmp-fb".
+- marvell,fb-name: Should be the name of this fb.
+- marvell,path-name: Should be the name of path this fb connecting to.
+- marvell,overlay-id: Should be the id of overlay this fb is on.
+- marvell,dmafetch-id: Should be the dma fetch id this fb using.
+- marvell,default-pixfmt: Should be the default pixel format when this fb is
+turned on.
+
+2. mmp controller
+Required properties:
+- compatible: Should be "marvell,mmp-disp".
+- reg: Should be address and length of the register set for this controller.
+- interrupts: Should be interrupt of this controller.
+- marvell,disp-name: Should be name of this controller
+- marvell,path-num: Should be path number exists in this controller.
+- marvell,clk-name: Should be name of clock this controller using.
+
+Required sub-node:
+- path:
+Required properties in this sub-node:
+-- marvell,path-name: Should be name of this path, fb/panel uses this name to
+connect to this path.
+-- marvell,overlay_num: Should be number of overlay this path has.
+-- marvell,output-type: Should be output-type settings
+-- marvell,path-config: Should be path-config settings
+-- marvell,link-config: Should be link-config settings
+-- marvell,rbswap: Should be rbswap settings
+
+3. panel
+Required properties:
+- marvell,path-name: Should be path name that this panel connected to.
+- other properties each panel has.
+
+Examples:
+
+fb: fb {
+	compatible = "marvell,mmp-fb";
+	marvell,fb-name = "mmp_fb";
+	marvell,path-name = "mmp_pnpath";
+	marvell,overlay-id = <0>;
+	marvell,dmafetch-id = <1>;
+	marvell,default-pixfmt = <0x108>;
+};
+
+disp: disp@d420b000 {
+	compatible = "marvell,mmp-disp";
+	reg = <0xd420b000 0x1fc>;
+	interrupts = <0 41 0x4>;
+	marvell,disp-name = "mmp_disp";
+	marvell,path-num = <1>;
+	marvell,clk-name = "LCDCIHCLK";
+	path1 {
+		marvell,path-name = "mmp_pnpath";
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
+	marvell,path-name = "mmp_pnpath";
+	...
+};
diff --git a/drivers/video/mmp/fb/mmpfb.c b/drivers/video/mmp/fb/mmpfb.c
index 7ab31eb..e84a411 100644
--- a/drivers/video/mmp/fb/mmpfb.c
+++ b/drivers/video/mmp/fb/mmpfb.c
@@ -22,6 +22,8 @@
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include "mmpfb.h"
 
 static int var_to_pixfmt(struct fb_var_screeninfo *var)
@@ -551,56 +553,86 @@ static void fb_info_clear(struct fb_info *info)
 	fb_dealloc_cmap(&info->cmap);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id mmp_fb_dt_match[] = {
+	{ .compatible = "marvell,mmp-fb" },
+	{},
+};
+#endif
+
 static int mmpfb_probe(struct platform_device *pdev)
 {
+#ifdef CONFIG_OF
+	struct device_node *np;
+#else
 	struct mmp_buffer_driver_mach_info *mi;
+#endif
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
+	int overlay_id, dmafetch_id;
+	const char *path_name;
 
 	/* initialize fb */
 	info = framebuffer_alloc(sizeof(struct mmpfb_info), &pdev->dev);
 	if (info = NULL)
 		return -ENOMEM;
 	fbi = info->par;
-	if (!fbi) {
-		ret = -EINVAL;
+	if (!fbi)
+		goto failed;
+
+#ifdef CONFIG_OF
+	np = pdev->dev.of_node;
+
+	if (!np || of_property_read_string(np,
+				"marvell,fb-name", &fbi->name) ||
+			of_property_read_string(np,
+				"marvell,path-name", &path_name) ||
+			of_property_read_u32(np,
+				"marvell,overlay-id", &overlay_id) ||
+			of_property_read_u32(np,
+				"marvell,dmafetch-id", &dmafetch_id) ||
+			of_property_read_u32(np,
+				"marvell,default-pixfmt", &fbi->pix_fmt)) {
+		dev_err(&pdev->dev, "unable to get fb setting from dt\n");
 		goto failed;
 	}
+#else
+	mi = pdev->dev.platform_data;
+	if (mi = NULL) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		goto failed;
+	}
+	fbi->name = mi->name;
+	path_name = mi->path_name;
+	overlay_id = mi->overlay_id;
+	dmafetch_id = mi->dmafetch_id;
+	fbi->pix_fmt = mi->default_pixfmt;
+#endif
 
 	/* init fb */
 	fbi->fb_info = info;
 	platform_set_drvdata(pdev, fbi);
 	fbi->dev = &pdev->dev;
-	fbi->name = mi->name;
-	fbi->pix_fmt = mi->default_pixfmt;
 	pixfmt_to_var(&info->var, fbi->pix_fmt);
 	mutex_init(&fbi->access_ok);
 
 	/* get display path by name */
-	fbi->path = mmp_get_path(mi->path_name);
+	fbi->path = mmp_get_path(path_name);
 	if (!fbi->path) {
-		dev_err(&pdev->dev, "can't get the path %s\n", mi->path_name);
-		ret = -EINVAL;
+		dev_err(&pdev->dev, "can't get the path %s\n", path_name);
 		goto failed_destroy_mutex;
 	}
 
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
@@ -679,6 +711,7 @@ static struct platform_driver mmpfb_driver = {
 	.driver		= {
 		.name	= "mmp-fb",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(mmp_fb_dt_match),
 	},
 	.probe		= mmpfb_probe,
 };
diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
index 8621a9f..19d68bc 100644
--- a/drivers/video/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/mmp/hw/mmp_ctrl.c
@@ -37,6 +37,8 @@
 #include <linux/uaccess.h>
 #include <linux/kthread.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include "mmp_ctrl.h"
 
@@ -396,26 +398,57 @@ static void path_set_default(struct mmp_path *path)
 	writel_relaxed(tmp, ctrl_regs(path) + dma_ctrl(0, path->id));
 }
 
-static int path_init(struct mmphw_path_plat *path_plat,
-		struct mmp_mach_path_config *config)
+static int path_init(struct mmphw_path_plat *path_plat, void *arg)
 {
 	struct mmphw_ctrl *ctrl = path_plat->ctrl;
 	struct mmp_path_info *path_info;
 	struct mmp_path *path = NULL;
-
-	dev_info(ctrl->dev, "%s: %s\n", __func__, config->name);
+#ifdef CONFIG_OF
+	struct device_node *path_np = arg;
+#else
+	struct mmp_mach_path_config *config = arg;
+#endif
 
 	/* init driver data */
 	path_info = kzalloc(sizeof(struct mmp_path_info), GFP_KERNEL);
 	if (!path_info) {
-		dev_err(ctrl->dev, "%s: unable to alloc path_info for %s\n",
-				__func__, config->name);
-		return 0;
+		dev_err(ctrl->dev, "%s: unable to alloc path_info\n",
+				__func__);
+		return -ENOMEM;
+	}
+
+#ifdef CONFIG_OF
+	if (!path_np || of_property_read_string(path_np, "marvell,path-name",
+				&path_info->name) ||
+			of_property_read_u32(path_np, "marvell,overlay-num",
+				&path_info->output_type) ||
+			of_property_read_u32(path_np, "marvell,output-type",
+				&path_info->overlay_num)) {
+		dev_err(ctrl->dev, "%s: unable to get path setting from dt\n",
+			__func__);
+		kfree(path_info);
+		return -EINVAL;
 	}
+	/* allow these settings not set */
+	of_property_read_u32(path_np, "marvell,path-config",
+		&path_plat->path_config);
+	of_property_read_u32(path_np, "marvell,link-config",
+		&path_plat->link_config);
+	of_property_read_u32(path_np, "marvell,rbswap",
+		&path_plat->dsi_rbswap);
+#else
 	path_info->name = config->name;
+	path_info->overlay_num = config->overlay_num;
+	path_info->output_type = config->output_type;
+	path_plat->path_config = config->path_config;
+	path_plat->link_config = config->link_config;
+	path_plat->dsi_rbswap = config->dsi_rbswap;
+#endif
+
+	dev_info(ctrl->dev, "%s: %s\n", __func__, path_info->name);
+
 	path_info->id = path_plat->id;
 	path_info->dev = ctrl->dev;
-	path_info->overlay_num = config->overlay_num;
 	path_info->overlay_ops = &mmphw_overlay_ops;
 	path_info->set_mode = path_set_mode;
 	path_info->plat_data = path_plat;
@@ -424,16 +457,13 @@ static int path_init(struct mmphw_path_plat *path_plat,
 	path = mmp_register_path(path_info);
 	if (!path) {
 		kfree(path_info);
-		return 0;
+		return -EINVAL;
 	}
 	path_plat->path = path;
-	path_plat->path_config = config->path_config;
-	path_plat->link_config = config->link_config;
-	path_plat->dsi_rbswap = config->dsi_rbswap;
 	path_set_default(path);
 
 	kfree(path_info);
-	return 1;
+	return 0;
 }
 
 static void path_deinit(struct mmphw_path_plat *path_plat)
@@ -445,13 +475,25 @@ static void path_deinit(struct mmphw_path_plat *path_plat)
 		mmp_unregister_path(path_plat->path);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id mmp_disp_dt_match[] = {
+	{ .compatible = "marvell,mmp-disp" },
+	{},
+};
+#endif
+
 static int mmphw_probe(struct platform_device *pdev)
 {
-	struct mmp_mach_plat_info *mi;
 	struct resource *res;
-	int ret, i, size, irq;
+	int ret, i, size, irq, path_num;
+	const char *clk_name, *disp_name;
 	struct mmphw_path_plat *path_plat;
 	struct mmphw_ctrl *ctrl = NULL;
+#ifdef CONFIG_OF
+	struct device_node *np, *path_np = NULL;
+#else
+	struct mmp_mach_plat_info *mi;
+#endif
 
 	/* get resources from platform data */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -468,6 +510,22 @@ static int mmphw_probe(struct platform_device *pdev)
 		goto failed;
 	}
 
+#ifdef CONFIG_OF
+	np = pdev->dev.of_node;
+
+	if (!np || of_property_read_u32(np,
+				"marvell,path-num", &path_num) ||
+			of_property_read_string(np,
+				"marvell,disp-name", &disp_name) ||
+			of_property_read_string(np,
+				"marvell,clk-name", &clk_name) ||
+			of_get_child_count(np) != ctrl->path_num) {
+		dev_err(&pdev->dev, "%s: failed to get settings from dt\n",
+			__func__);
+		ret = -EINVAL;
+		goto failed;
+	}
+#else
 	/* get configs from platform data */
 	mi = pdev->dev.platform_data;
 	if (mi = NULL || !mi->path_num || !mi->paths) {
@@ -476,17 +534,21 @@ static int mmphw_probe(struct platform_device *pdev)
 		goto failed;
 	}
 
-	/* allocate */
+	disp_name = mi->name;
+	path_num = mi->path_num;
+	clk_name = mi->clk_name;
+#endif
+
+	/* allocate ctrl */
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
@@ -521,9 +583,9 @@ static int mmphw_probe(struct platform_device *pdev)
 	}
 
 	/* get clock */
-	ctrl->clk = devm_clk_get(ctrl->dev, mi->clk_name);
+	ctrl->clk = devm_clk_get(ctrl->dev, clk_name);
 	if (IS_ERR(ctrl->clk)) {
-		dev_err(ctrl->dev, "unable to get clk %s\n", mi->clk_name);
+		dev_err(ctrl->dev, "unable to get clk %s\n", clk_name);
 		ret = -ENOENT;
 		goto failed;
 	}
@@ -539,11 +601,16 @@ static int mmphw_probe(struct platform_device *pdev)
 		path_plat->id = i;
 		path_plat->ctrl = ctrl;
 
-		/* path init */
-		if (!path_init(path_plat, &mi->paths[i])) {
-			ret = -EINVAL;
+		/* path init from mach info or dt */
+#ifdef CONFIG_OF
+		path_np = of_get_next_child(np, path_np);
+		ret = path_init(path_plat, path_np);
+#else
+		ret = path_init(path_plat, &mi->paths[i]);
+#endif
+
+		if (ret)
 			goto failed_path_init;
-		}
 	}
 
 #ifdef CONFIG_MMP_DISP_SPI
@@ -573,6 +640,7 @@ static struct platform_driver mmphw_driver = {
 	.driver		= {
 		.name	= "mmp-disp",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(mmp_disp_dt_match),
 	},
 	.probe		= mmphw_probe,
 };
-- 
1.7.9.5


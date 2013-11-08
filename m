From: Denis Carikli <denis@eukrea.com>
Date: Fri, 08 Nov 2013 13:01:30 +0000
Subject: [PATCHv5][ 2/5] video: mx3fb: Add device tree suport.
Message-Id: <1383915693-9422-2-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383915693-9422-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1383915693-9422-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Eric B=C3=A9nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v4->v5:
- Added some people in the Cc list.
- The full ipu register range is now passed to the driver,
  the code and the documentation were adapted to it.
- Updated the documentation not to mention the lcd controller, the ipu was
  mentioned instead.
- The ipu patch was removed from this patchset, as a consequence the mx3fb =
code
  has been adapted not to expect the dma ipu driver to be probed trough the=
 device tree.

ChangeLog v3->v4:
- Updated bindings.
- Updated documentation accordinly.
- Updated code accordinly.
- Fixed the lack of "ret =3D" in
  of_property_read_string(display_np, "model", &name);
- Supressed some compilation warnings.

ChangeLog v2->v3:
- The device tree bindings were reworked in order to make it look more like=
 the
  IPUv3 bindings.
- The interface_pix_fmt property now looks like the IPUv3 one.
---
 .../devicetree/bindings/video/fsl,mx3-fb.txt       |   44 +++++++
 drivers/video/Kconfig                              |    2 +
 drivers/video/mx3fb.c                              |  123 ++++++++++++++++=
+---
 3 files changed, 151 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/fsl,mx3-fb.txt

diff --git a/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt b/Docum=
entation/devicetree/bindings/video/fsl,mx3-fb.txt
new file mode 100644
index 0000000..c0409a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
@@ -0,0 +1,44 @@
+Freescale MX3 IPU.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Required properties:
+- compatible: Should be "fsl,<chip>-ipu". compatible chips include the imx=
31 and the
+  imx35.
+- reg: should be register base and length as documented in the datasheet.
+- clocks: Handle to the ipu_gate clock.
+- display: Phandle to a "fsl,mx3-parallel-display" compatible display node
+  which is described below.
+
+Example:
+
+ipu: ipu@53fc0000 {
+	compatible =3D "fsl,imx35-ipu";
+	reg =3D <0x53fc0000 0x4000>;
+	clocks =3D <&clks 55>;
+};
+
+Parallel display support
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Required properties:
+- compatible: Should be "fsl,mx3-parallel-display".
+- model : The user-visible name of the display.
+
+Optional properties:
+- interface_pix_fmt: How this display is connected to the
+  crtc. Currently supported types: "rgb24", "rgb565", "rgb666".
+
+It can also have an optional timing subnode as described in
+  Documentation/devicetree/bindings/video/display-timing.txt.
+
+Example:
+
+display0: display@di0 {
+	compatible =3D "fsl,mx3-parallel-display";
+	interface-pix-fmt =3D "rgb666";
+	model =3D "CMO-QVGA";
+};
+
+&ipu {
+	display =3D <&display0>;
+}
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 84b685f..edcfa33 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2357,6 +2357,8 @@ config FB_MX3
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select VIDEOMODE_HELPERS
+	select FB_MODE_HELPERS
 	default y
 	help
 	  This is a framebuffer device for the i.MX31 LCD Controller. So
diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index cfdb380..7620e4f 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -31,6 +31,8 @@
 #include <linux/platform_data/dma-imx.h>
 #include <linux/platform_data/video-mx3fb.h>
=20
+#include <video/of_display_timing.h>
+
 #include <asm/io.h>
 #include <asm/uaccess.h>
=20
@@ -757,11 +759,13 @@ static int __set_par(struct fb_info *fbi, bool lock)
 			sig_cfg.Hsync_pol =3D true;
 		if (fbi->var.sync & FB_SYNC_VERT_HIGH_ACT)
 			sig_cfg.Vsync_pol =3D true;
-		if (fbi->var.sync & FB_SYNC_CLK_INVERT)
+		if ((fbi->var.sync & FB_SYNC_CLK_INVERT) ||
+		    (fbi->var.sync & FB_SYNC_PIXDAT_HIGH_ACT))
 			sig_cfg.clk_pol =3D true;
 		if (fbi->var.sync & FB_SYNC_DATA_INVERT)
 			sig_cfg.data_pol =3D true;
-		if (fbi->var.sync & FB_SYNC_OE_ACT_HIGH)
+		if ((fbi->var.sync & FB_SYNC_OE_ACT_HIGH) ||
+		    (fbi->var.sync & FB_SYNC_DE_HIGH_ACT))
 			sig_cfg.enable_pol =3D true;
 		if (fbi->var.sync & FB_SYNC_CLK_IDLE_EN)
 			sig_cfg.clkidle_en =3D true;
@@ -1351,21 +1355,69 @@ static struct fb_info *mx3fb_init_fbinfo(struct dev=
ice *dev, struct fb_ops *ops)
 	return fbi;
 }
=20
+static int match_dt_disp_data(const char *property)
+{
+	if (!strcmp("rgb666", property))
+		return IPU_DISP_DATA_MAPPING_RGB666;
+	else if (!strcmp("rgb565", property))
+		return IPU_DISP_DATA_MAPPING_RGB565;
+	else if (!strcmp("rgb24", property))
+		return IPU_DISP_DATA_MAPPING_RGB888;
+	else
+		return -EINVAL;
+}
+
 static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ic=
han)
 {
 	struct device *dev =3D mx3fb->dev;
 	struct mx3fb_platform_data *mx3fb_pdata =3D dev->platform_data;
-	const char *name =3D mx3fb_pdata->name;
+	struct device_node *np =3D dev->of_node;
+	const char *name;
+	const char *ipu_disp_format;
 	unsigned int irq;
 	struct fb_info *fbi;
 	struct mx3fb_info *mx3fbi;
 	const struct fb_videomode *mode;
 	int ret, num_modes;
+	struct fb_videomode of_mode;
+	struct device_node *display_np;
+
+	if (np) {
+		display_np =3D of_parse_phandle(np, "display", 0);
+		if (!display_np) {
+			dev_err(dev, "Can't get the display device node.\n");
+			return -EINVAL;
+		}
+
+		of_property_read_string(display_np, "interface-pix-fmt",
+					&ipu_disp_format);
+		if (!ipu_disp_format) {
+			mx3fb->disp_data_fmt =3D IPU_DISP_DATA_MAPPING_RGB666;
+			dev_warn(dev,
+				"ipu display data mapping was not defined, using the default rgb666.\n=
");
+		} else {
+			mx3fb->disp_data_fmt +				match_dt_disp_data(ipu_disp_format);
+		}
+
+		if (mx3fb->disp_data_fmt =3D -EINVAL) {
+			dev_err(dev, "Illegal display data format \"%s\"\n",
+				ipu_disp_format);
+			return -EINVAL;
+		}
=20
-	if (mx3fb_pdata->disp_data_fmt >=3D ARRAY_SIZE(di_mappings)) {
-		dev_err(dev, "Illegal display data format %d\n",
+		ret =3D of_property_read_string(display_np, "model", &name);
+		if (ret) {
+			dev_err(dev, "Missing display model name\n");
+			return -EINVAL;
+		}
+	} else {
+		name =3D mx3fb_pdata->name;
+		if (mx3fb_pdata->disp_data_fmt >=3D ARRAY_SIZE(di_mappings)) {
+			dev_err(dev, "Illegal display data format %d\n",
 				mx3fb_pdata->disp_data_fmt);
-		return -EINVAL;
+			return -EINVAL;
+		}
 	}
=20
 	ichan->client =3D mx3fb;
@@ -1386,12 +1438,24 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, s=
truct idmac_channel *ichan)
 		goto emode;
 	}
=20
-	if (mx3fb_pdata->mode && mx3fb_pdata->num_modes) {
-		mode =3D mx3fb_pdata->mode;
-		num_modes =3D mx3fb_pdata->num_modes;
+	if (np) {
+		ret =3D of_get_fb_videomode(display_np, &of_mode,
+					  OF_USE_NATIVE_MODE);
+		if (!ret) {
+			mode =3D &of_mode;
+			num_modes =3D 1;
+		} else {
+			mode =3D mx3fb_modedb;
+			num_modes =3D ARRAY_SIZE(mx3fb_modedb);
+		}
 	} else {
-		mode =3D mx3fb_modedb;
-		num_modes =3D ARRAY_SIZE(mx3fb_modedb);
+		if (mx3fb_pdata->mode || !mx3fb_pdata->num_modes) {
+			mode =3D mx3fb_pdata->mode;
+			num_modes =3D mx3fb_pdata->num_modes;
+		} else {
+			mode =3D mx3fb_modedb;
+			num_modes =3D ARRAY_SIZE(mx3fb_modedb);
+		}
 	}
=20
 	if (!fb_find_mode(&fbi->var, fbi, fb_mode, mode,
@@ -1421,7 +1485,8 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, str=
uct idmac_channel *ichan)
 	mx3fbi->mx3fb		=3D mx3fb;
 	mx3fbi->blank		=3D FB_BLANK_NORMAL;
=20
-	mx3fb->disp_data_fmt	=3D mx3fb_pdata->disp_data_fmt;
+	if (!np)
+		mx3fb->disp_data_fmt =3D mx3fb_pdata->disp_data_fmt;
=20
 	init_completion(&mx3fbi->flip_cmpl);
 	disable_irq(ichan->eof_irq);
@@ -1455,17 +1520,21 @@ static bool chan_filter(struct dma_chan *chan, void=
 *arg)
 	struct device *dev;
 	struct mx3fb_platform_data *mx3fb_pdata;
=20
-	if (!imx_dma_is_ipu(chan))
-		return false;
-
 	if (!rq)
 		return false;
=20
 	dev =3D rq->mx3fb->dev;
 	mx3fb_pdata =3D dev->platform_data;
=20
-	return rq->id =3D chan->chan_id &&
-		mx3fb_pdata->dma_dev =3D chan->device->dev;
+	if (!imx_dma_is_ipu(chan) && mx3fb_pdata)
+		return false;
+
+	/* When using the devicetree, mx3fb_pdata is NULL */
+	if (mx3fb_pdata)
+		return rq->id =3D chan->chan_id &&
+			mx3fb_pdata->dma_dev =3D chan->device->dev;
+	else
+		return rq->id =3D chan->chan_id;
 }
=20
 static void release_fbi(struct fb_info *fbi)
@@ -1487,6 +1556,7 @@ static int mx3fb_probe(struct platform_device *pdev)
 	dma_cap_mask_t mask;
 	struct dma_chan *chan;
 	struct dma_chan_request rq;
+	struct device_node *np =3D dev->of_node;
=20
 	/*
 	 * Display Interface (DI) and Synchronous Display Controller (SDC)
@@ -1508,7 +1578,16 @@ static int mx3fb_probe(struct platform_device *pdev)
 		goto eremap;
 	}
=20
-	pr_debug("Remapped %pR at %p\n", sdc_reg, mx3fb->reg_base);
+	/* The full IPU registers range is passed by the device tree,
+	 * whereas the platform data only passes the SDC registers range.
+	 */
+	if (np) {
+		mx3fb->reg_base +=3D MX3FB_REG_OFFSET;
+		pr_debug("Remapped %pR at %p\n", sdc_reg + MX3FB_REG_OFFSET,
+			 mx3fb->reg_base);
+	} else {
+		pr_debug("Remapped %pR at %p\n", sdc_reg, mx3fb->reg_base);
+	}
=20
 	/* IDMAC interface */
 	dmaengine_get();
@@ -1565,9 +1644,17 @@ static int mx3fb_remove(struct platform_device *dev)
 	return 0;
 }
=20
+static struct of_device_id mx3fb_of_dev_id[] =3D {
+	{ .compatible =3D "fsl,imx31-ipu", },
+	{ .compatible =3D "fsl,imx35-ipu", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mx3fb_of_dev_id);
+
 static struct platform_driver mx3fb_driver =3D {
 	.driver =3D {
 		.name =3D MX3FB_NAME,
+		.of_match_table =3D mx3fb_of_dev_id,
 		.owner =3D THIS_MODULE,
 	},
 	.probe =3D mx3fb_probe,
--=20
1.7.9.5


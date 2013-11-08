From: Denis Carikli <denis@eukrea.com>
Date: Fri, 08 Nov 2013 13:01:31 +0000
Subject: [PATCHv5][ 3/5] video: mx3fb: Introduce regulator support.
Message-Id: <1383915693-9422-3-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383915693-9422-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1383915693-9422-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

This commit is based on the following commit by Fabio Estevam:
  4344429 video: mxsfb: Introduce regulator support

Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Eric B=C3=A9nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v4->v5:
- Added Shawn Guo in the Cc list.
- Rebased to make it apply.

ChangeLog v3->v4:
- Some code style fixes.
- Improved error handling in eremap.

ChangeLog v2->v3:
- The prints are now replaced with non line wrapped prints.
- The regulator retrival has been adapted to the new DT bindings which looks
  more like the IPUv3 ones.
- The regulator_is_enabled checks were kept, because regulator_disable do n=
ot
  do such check.
---
 drivers/video/mx3fb.c |   71 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index 7620e4f..8cf9c6f 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -27,6 +27,7 @@
 #include <linux/clk.h>
 #include <linux/mutex.h>
 #include <linux/dma/ipu-dma.h>
+#include <linux/regulator/consumer.h>
=20
 #include <linux/platform_data/dma-imx.h>
 #include <linux/platform_data/video-mx3fb.h>
@@ -269,6 +270,7 @@ struct mx3fb_info {
 	struct dma_async_tx_descriptor	*txd;
 	dma_cookie_t			cookie;
 	struct scatterlist		sg[2];
+	struct regulator		*reg_lcd;
=20
 	struct fb_var_screeninfo	cur_var; /* current var info */
 };
@@ -1005,6 +1007,7 @@ static void __blank(int blank, struct fb_info *fbi)
 	struct mx3fb_info *mx3_fbi =3D fbi->par;
 	struct mx3fb_data *mx3fb =3D mx3_fbi->mx3fb;
 	int was_blank =3D mx3_fbi->blank;
+	int ret;
=20
 	mx3_fbi->blank =3D blank;
=20
@@ -1023,6 +1026,15 @@ static void __blank(int blank, struct fb_info *fbi)
 	case FB_BLANK_HSYNC_SUSPEND:
 	case FB_BLANK_NORMAL:
 		sdc_set_brightness(mx3fb, 0);
+		if (mx3_fbi->reg_lcd) {
+			if (regulator_is_enabled(mx3_fbi->reg_lcd)) {
+				ret =3D regulator_disable(mx3_fbi->reg_lcd);
+				if (ret)
+					dev_warn(fbi->device,
+						 "lcd regulator disable failed with error: %d\n",
+						 ret);
+			}
+		}
 		memset((char *)fbi->screen_base, 0, fbi->fix.smem_len);
 		/* Give LCD time to update - enough for 50 and 60 Hz */
 		msleep(25);
@@ -1030,6 +1042,15 @@ static void __blank(int blank, struct fb_info *fbi)
 		break;
 	case FB_BLANK_UNBLANK:
 		sdc_enable_channel(mx3_fbi);
+		if (mx3_fbi->reg_lcd) {
+			if (!regulator_is_enabled(mx3_fbi->reg_lcd)) {
+				ret =3D regulator_enable(mx3_fbi->reg_lcd);
+				if (ret)
+					dev_warn(fbi->device,
+						 "lcd regulator enable failed with error: %d\n",
+						 ret);
+			}
+		}
 		sdc_set_brightness(mx3fb, mx3fb->backlight_level);
 		break;
 	}
@@ -1206,6 +1227,7 @@ static int mx3fb_suspend(struct platform_device *pdev=
, pm_message_t state)
 {
 	struct mx3fb_data *mx3fb =3D platform_get_drvdata(pdev);
 	struct mx3fb_info *mx3_fbi =3D mx3fb->fbi->par;
+	int ret;
=20
 	console_lock();
 	fb_set_suspend(mx3fb->fbi, 1);
@@ -1214,7 +1236,15 @@ static int mx3fb_suspend(struct platform_device *pde=
v, pm_message_t state)
 	if (mx3_fbi->blank =3D FB_BLANK_UNBLANK) {
 		sdc_disable_channel(mx3_fbi);
 		sdc_set_brightness(mx3fb, 0);
-
+		if (mx3_fbi->reg_lcd) {
+			if (regulator_is_enabled(mx3_fbi->reg_lcd)) {
+				ret =3D regulator_disable(mx3_fbi->reg_lcd);
+				if (ret)
+					dev_warn(&pdev->dev,
+						 "lcd regulator disable failed with error: %d\n",
+						 ret);
+			}
+		}
 	}
 	return 0;
 }
@@ -1226,10 +1256,20 @@ static int mx3fb_resume(struct platform_device *pde=
v)
 {
 	struct mx3fb_data *mx3fb =3D platform_get_drvdata(pdev);
 	struct mx3fb_info *mx3_fbi =3D mx3fb->fbi->par;
+	int ret;
=20
 	if (mx3_fbi->blank =3D FB_BLANK_UNBLANK) {
 		sdc_enable_channel(mx3_fbi);
 		sdc_set_brightness(mx3fb, mx3fb->backlight_level);
+		if (mx3_fbi->reg_lcd) {
+			if (!regulator_is_enabled(mx3_fbi->reg_lcd)) {
+				ret =3D regulator_enable(mx3_fbi->reg_lcd);
+				if (ret)
+					dev_warn(&pdev->dev,
+						 "lcd regulator enable failed with error: %d\n",
+						 ret);
+			}
+		}
 	}
=20
 	console_lock();
@@ -1373,6 +1413,7 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, str=
uct idmac_channel *ichan)
 	struct mx3fb_platform_data *mx3fb_pdata =3D dev->platform_data;
 	struct device_node *np =3D dev->of_node;
 	const char *name;
+	const char *regulator_name;
 	const char *ipu_disp_format;
 	unsigned int irq;
 	struct fb_info *fbi;
@@ -1389,6 +1430,9 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, str=
uct idmac_channel *ichan)
 			return -EINVAL;
 		}
=20
+		of_property_read_string(display_np, "regulator-name",
+					&regulator_name);
+
 		of_property_read_string(display_np, "interface-pix-fmt",
 					&ipu_disp_format);
 		if (!ipu_disp_format) {
@@ -1503,6 +1547,25 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, st=
ruct idmac_channel *ichan)
 	if (ret < 0)
 		goto erfb;
=20
+	/* In dt mode,
+	 * using devm_regulator_get would require that the proprety referencing
+	 * the regulator phandle has to be inside the mx3fb node.
+	 */
+	if (np) {
+		if (regulator_name)
+			mx3fbi->reg_lcd =3D regulator_get(NULL, regulator_name);
+	} else {
+		mx3fbi->reg_lcd =3D devm_regulator_get(dev, "lcd");
+	}
+
+	if (IS_ERR(mx3fbi->reg_lcd)) {
+		dev_warn(mx3fb->dev, "Operating without regulator \"lcd\"\n");
+		mx3fbi->reg_lcd =3D NULL;
+	} else {
+		dev_info(mx3fb->dev, "Using \"%s\" Regulator\n",
+			 regulator_name);
+	}
+
 	return 0;
=20
 erfb:
@@ -1557,6 +1620,7 @@ static int mx3fb_probe(struct platform_device *pdev)
 	struct dma_chan *chan;
 	struct dma_chan_request rq;
 	struct device_node *np =3D dev->of_node;
+	struct mx3fb_info *mx3_fbi;
=20
 	/*
 	 * Display Interface (DI) and Synchronous Display Controller (SDC)
@@ -1621,6 +1685,11 @@ ersdc0:
 	dmaengine_put();
 	iounmap(mx3fb->reg_base);
 eremap:
+	if (mx3fb->fbi) {
+		mx3_fbi =3D mx3fb->fbi->par;
+		if (mx3_fbi->reg_lcd)
+			regulator_put(mx3_fbi->reg_lcd);
+	}
 	kfree(mx3fb);
 	dev_err(dev, "mx3fb: failed to register fb\n");
 	return ret;
--=20
1.7.9.5


From: Denis Carikli <denis@eukrea.com>
Date: Wed, 26 Feb 2014 09:59:57 +0000
Subject: [PATCHv6][ 3/5] video: mx3fb: Introduce regulator support.
Message-Id: <1393408800-8946-3-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393408800-8946-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1393408800-8946-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

This commit is based on the following commit by Fabio Estevam:
  4344429 video: mxsfb: Introduce regulator support

Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Eric B=C3=A9nard <eric@eukrea.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v5->v6:
- Shrinked the Cc list.
- still permit non-dt boards to use that driver without a regulator.

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
 drivers/video/mx3fb.c |   56 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index 952d2b5..40b47dd 100644
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
@@ -273,6 +274,7 @@ struct mx3fb_info {
 	struct dma_async_tx_descriptor	*txd;
 	dma_cookie_t			cookie;
 	struct scatterlist		sg[2];
+	struct regulator		*reg_lcd;
=20
 	struct fb_var_screeninfo	cur_var; /* current var info */
 	uint32_t			flags;
@@ -1042,6 +1044,12 @@ static void __blank(int blank, struct fb_info *fbi)
 	case FB_BLANK_HSYNC_SUSPEND:
 	case FB_BLANK_NORMAL:
 		sdc_set_brightness(mx3fb, 0);
+		if (!IS_ERR(mx3_fbi->reg_lcd)) {
+			if (regulator_disable(mx3_fbi->reg_lcd)) {
+				dev_err(fbi->device,
+					"Failed to disable regulator.\n");
+			}
+		}
 		memset((char *)fbi->screen_base, 0, fbi->fix.smem_len);
 		/* Give LCD time to update - enough for 50 and 60 Hz */
 		msleep(25);
@@ -1049,6 +1057,12 @@ static void __blank(int blank, struct fb_info *fbi)
 		break;
 	case FB_BLANK_UNBLANK:
 		sdc_enable_channel(mx3_fbi);
+		if (!IS_ERR(mx3_fbi->reg_lcd)) {
+			if (regulator_enable(mx3_fbi->reg_lcd)) {
+				dev_err(fbi->device,
+					"Failed to enable regulator.\n");
+			}
+		}
 		sdc_set_brightness(mx3fb, mx3fb->backlight_level);
 		break;
 	}
@@ -1233,7 +1247,12 @@ static int mx3fb_suspend(struct platform_device *pde=
v, pm_message_t state)
 	if (mx3_fbi->blank =3D FB_BLANK_UNBLANK) {
 		sdc_disable_channel(mx3_fbi);
 		sdc_set_brightness(mx3fb, 0);
-
+		if (!IS_ERR(mx3_fbi->reg_lcd)) {
+			if (regulator_disable(mx3_fbi->reg_lcd)) {
+				dev_err(&pdev->dev,
+					"Failed to disable regulator.\n");
+			}
+		}
 	}
 	return 0;
 }
@@ -1249,6 +1268,12 @@ static int mx3fb_resume(struct platform_device *pdev)
 	if (mx3_fbi->blank =3D FB_BLANK_UNBLANK) {
 		sdc_enable_channel(mx3_fbi);
 		sdc_set_brightness(mx3fb, mx3fb->backlight_level);
+		if (!IS_ERR(mx3_fbi->reg_lcd)) {
+			if (regulator_enable(mx3_fbi->reg_lcd)) {
+				dev_err(&pdev->dev,
+					"Failed to enable regulator.\n");
+			}
+		}
 	}
=20
 	console_lock();
@@ -1394,6 +1419,7 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, str=
uct idmac_channel *ichan)
 	struct mx3fb_platform_data *mx3fb_pdata =3D dev_get_platdata(dev);
 	struct device_node *np =3D dev->of_node;
 	const char *name;
+	const char *regulator_name;
 	const char *ipu_disp_format;
 	unsigned int irq;
 	struct fb_info *fbi;
@@ -1409,6 +1435,9 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, str=
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
@@ -1526,6 +1555,21 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, st=
ruct idmac_channel *ichan)
 	if (ret < 0)
 		goto esetpar;
=20
+	/* In dt mode,
+	 * using devm_regulator_get would require that the proprety referencing
+	 * the regulator phandle has to be inside the mx3fb node.
+	 */
+	if (np) {
+		if (regulator_name)
+			mx3fbi->reg_lcd =3D regulator_get(NULL, regulator_name);
+
+		if (IS_ERR(mx3fbi->reg_lcd))
+			return PTR_ERR(mx3fbi->reg_lcd);
+	} else {
+		/* Permit that driver without a regulator in non-dt mode */
+		mx3fbi->reg_lcd =3D regulator_get(dev, "lcd");
+	}
+
 	__blank(FB_BLANK_UNBLANK, fbi);
=20
 	dev_info(dev, "registered, using mode %s\n", fb_mode);
@@ -1589,6 +1633,7 @@ static int mx3fb_probe(struct platform_device *pdev)
 	dma_cap_mask_t mask;
 	struct dma_chan *chan;
 	struct dma_chan_request rq;
+	struct mx3fb_info *mx3_fbi;
 	struct device_node *np =3D dev->of_node;
 	struct videomode *vm;
 	struct fb_videomode *fb_vm;
@@ -1673,6 +1718,12 @@ ersdc0:
 	dmaengine_put();
 	iounmap(mx3fb->reg_base);
 eremap:
+	if (mx3fb->fbi) {
+		mx3_fbi =3D mx3fb->fbi->par;
+
+		if ((!IS_ERR(mx3_fbi->reg_lcd)) && mx3_fbi->reg_lcd)
+			regulator_put(mx3_fbi->reg_lcd);
+	}
 	dev_err(dev, "mx3fb: failed to register fb\n");
 	return ret;
 }
@@ -1684,6 +1735,9 @@ static int mx3fb_remove(struct platform_device *dev)
 	struct mx3fb_info *mx3_fbi =3D fbi->par;
 	struct dma_chan *chan;
=20
+	if ((!IS_ERR(mx3_fbi->reg_lcd)) && mx3_fbi->reg_lcd)
+		regulator_put(mx3_fbi->reg_lcd);
+
 	chan =3D &mx3_fbi->idmac_channel->dma_chan;
 	release_fbi(fbi);
=20
--=20
1.7.9.5


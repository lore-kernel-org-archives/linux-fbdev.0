From: Denis Carikli <denis@eukrea.com>
Date: Thu, 31 Oct 2013 09:15:23 +0000
Subject: [PATCHv9][ 1/6] video: imxfb: Introduce regulator support.
Message-Id: <1383210928-18906-1-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

This commit is based on the following commit by Fabio Estevam:
  4344429 video: mxsfb: Introduce regulator support

Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Eric B=C3=A9nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v8->v9:
- return an error if regulator_{enable,disable} fails in
  imxfb_{enable,disable}_controller, and use it.
---
 drivers/video/imxfb.c |   53 ++++++++++++++++++++++++++++++++++++++-------=
----
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 44ee678..322b358 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -28,6 +28,7 @@
 #include <linux/cpufreq.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/math64.h>
@@ -145,6 +146,7 @@ struct imxfb_info {
 	struct clk		*clk_ipg;
 	struct clk		*clk_ahb;
 	struct clk		*clk_per;
+	struct regulator	*reg_lcd;
 	enum imxfb_type		devtype;
 	bool			enabled;
=20
@@ -561,14 +563,25 @@ static void imxfb_exit_backlight(struct imxfb_info *f=
bi)
 }
 #endif
=20
-static void imxfb_enable_controller(struct imxfb_info *fbi)
+static int imxfb_enable_controller(struct imxfb_info *fbi)
 {
+	int ret;
=20
 	if (fbi->enabled)
-		return;
+		return 0;
=20
 	pr_debug("Enabling LCD controller\n");
=20
+	if (fbi->reg_lcd) {
+		ret =3D regulator_enable(fbi->reg_lcd);
+		if (ret) {
+			dev_err(&fbi->pdev->dev,
+				"lcd regulator enable failed with error: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	writel(fbi->screen_dma, fbi->regs + LCDC_SSA);
=20
 	/* panning offset 0 (0 pixel offset)        */
@@ -593,12 +606,16 @@ static void imxfb_enable_controller(struct imxfb_info=
 *fbi)
 		fbi->backlight_power(1);
 	if (fbi->lcd_power)
 		fbi->lcd_power(1);
+
+	return 0;
 }
=20
-static void imxfb_disable_controller(struct imxfb_info *fbi)
+static int imxfb_disable_controller(struct imxfb_info *fbi)
 {
+	int ret;
+
 	if (!fbi->enabled)
-		return;
+		return 0;
=20
 	pr_debug("Disabling LCD controller\n");
=20
@@ -613,6 +630,15 @@ static void imxfb_disable_controller(struct imxfb_info=
 *fbi)
 	fbi->enabled =3D false;
=20
 	writel(0, fbi->regs + LCDC_RMCR);
+
+	if (fbi->reg_lcd) {
+		ret =3D regulator_disable(fbi->reg_lcd);
+		if (ret)
+			dev_err(&fbi->pdev->dev,
+				"lcd regulator disable failed with error: %d\n",
+				ret);
+			return ret;
+	}
 }
=20
 static int imxfb_blank(int blank, struct fb_info *info)
@@ -626,13 +652,12 @@ static int imxfb_blank(int blank, struct fb_info *inf=
o)
 	case FB_BLANK_VSYNC_SUSPEND:
 	case FB_BLANK_HSYNC_SUSPEND:
 	case FB_BLANK_NORMAL:
-		imxfb_disable_controller(fbi);
-		break;
+		return imxfb_disable_controller(fbi);
=20
 	case FB_BLANK_UNBLANK:
-		imxfb_enable_controller(fbi);
-		break;
+		return imxfb_enable_controller(fbi);
 	}
+
 	return 0;
 }
=20
@@ -734,8 +759,7 @@ static int imxfb_suspend(struct platform_device *dev, p=
m_message_t state)
=20
 	pr_debug("%s\n", __func__);
=20
-	imxfb_disable_controller(fbi);
-	return 0;
+	return imxfb_disable_controller(fbi);
 }
=20
 static int imxfb_resume(struct platform_device *dev)
@@ -745,8 +769,7 @@ static int imxfb_resume(struct platform_device *dev)
=20
 	pr_debug("%s\n", __func__);
=20
-	imxfb_enable_controller(fbi);
-	return 0;
+	return imxfb_enable_controller(fbi);
 }
 #else
 #define imxfb_suspend	NULL
@@ -1020,6 +1043,12 @@ static int imxfb_probe(struct platform_device *pdev)
 		goto failed_register;
 	}
=20
+	fbi->reg_lcd =3D devm_regulator_get(&pdev->dev, "lcd");
+	if (IS_ERR(fbi->reg_lcd)) {
+		dev_info(&pdev->dev, "No lcd regulator used.\n");
+		fbi->reg_lcd =3D NULL;
+	}
+
 	imxfb_enable_controller(fbi);
 	fbi->pdev =3D pdev;
 #ifdef PWMR_BACKLIGHT_AVAILABLE
--=20
1.7.9.5


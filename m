From: Denis Carikli <denis@eukrea.com>
Date: Wed, 23 Oct 2013 08:29:27 +0000
Subject: [PATCHv5][ 2/9] video: imxfb: Introduce regulator support.
Message-Id: <1382516974-13371-2-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382516974-13371-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1382516974-13371-1-git-send-email-denis@eukrea.com>
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
 drivers/video/imxfb.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 44ee678..4bf3837 100644
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
@@ -563,12 +565,23 @@ static void imxfb_exit_backlight(struct imxfb_info *f=
bi)
=20
 static void imxfb_enable_controller(struct imxfb_info *fbi)
 {
+	int ret;
=20
 	if (fbi->enabled)
 		return;
=20
 	pr_debug("Enabling LCD controller\n");
=20
+	if (fbi->reg_lcd) {
+		ret =3D regulator_enable(fbi->reg_lcd);
+		if (ret) {
+			dev_err(&fbi->pdev->dev,
+				"lcd regulator enable failed with error: %d\n",
+				ret);
+			return;
+		}
+	}
+
 	writel(fbi->screen_dma, fbi->regs + LCDC_SSA);
=20
 	/* panning offset 0 (0 pixel offset)        */
@@ -597,6 +610,8 @@ static void imxfb_enable_controller(struct imxfb_info *=
fbi)
=20
 static void imxfb_disable_controller(struct imxfb_info *fbi)
 {
+	int ret;
+
 	if (!fbi->enabled)
 		return;
=20
@@ -613,6 +628,14 @@ static void imxfb_disable_controller(struct imxfb_info=
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
+	}
 }
=20
 static int imxfb_blank(int blank, struct fb_info *info)
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


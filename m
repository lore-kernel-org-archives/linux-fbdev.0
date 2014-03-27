From: =?UTF-8?q?Ga=C3=ABtan=20Carlier?= <gcembed@gmail.com>
Date: Thu, 27 Mar 2014 15:20:36 +0000
Subject: [PATCH 1/1] video: imxfb: Driver depends on status of LCD class device
Message-Id: <1395933636-15704-1-git-send-email-gcembed@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

If LCD_CLASS_DEVICE is disabled, symbol devm_lcd_device_register is
undefined

Signed-off-by: Ga=C3=ABtan Carlier <gcembed@gmail.com>
---
 drivers/video/fbdev/imxfb.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index f6e6216..b979b61 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -30,7 +30,9 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
+#ifdef CONFIG_LCD_CLASS_DEVICE
 #include <linux/lcd.h>
+#endif
 #include <linux/math64.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -718,6 +720,7 @@ static int imxfb_of_read_mode(struct device *dev, struc=
t device_node *np,
 	return 0;
 }
=20
+#ifdef CONFIG_LCD_CLASS_DEVICE
 static int imxfb_lcd_check_fb(struct lcd_device *lcddev, struct fb_info *f=
i)
 {
 	struct imxfb_info *fbi =3D dev_get_drvdata(&lcddev->dev);
@@ -785,6 +788,7 @@ static struct lcd_ops imxfb_lcd_ops =3D {
 	.get_power	=3D imxfb_lcd_get_power,
 	.set_power	=3D imxfb_lcd_set_power,
 };
+#endif
=20
 static int imxfb_setup(void)
 {
@@ -809,7 +813,9 @@ static int imxfb_setup(void)
 static int imxfb_probe(struct platform_device *pdev)
 {
 	struct imxfb_info *fbi;
+#ifdef CONFIG_LCD_CLASS_DEVICE
 	struct lcd_device *lcd;
+#endif
 	struct fb_info *info;
 	struct imx_fb_platform_data *pdata;
 	struct resource *res;
@@ -967,6 +973,7 @@ static int imxfb_probe(struct platform_device *pdev)
 		goto failed_lcd;
 	}
=20
+#ifdef CONFIG_LCD_CLASS_DEVICE
 	lcd =3D devm_lcd_device_register(&pdev->dev, "imxfb-lcd", &pdev->dev, fbi,
 				       &imxfb_lcd_ops);
 	if (IS_ERR(lcd)) {
@@ -975,6 +982,7 @@ static int imxfb_probe(struct platform_device *pdev)
 	}
=20
 	lcd->props.max_contrast =3D 0xff;
+#endif
=20
 	imxfb_enable_controller(fbi);
 	fbi->pdev =3D pdev;
--=20
1.7.7.4


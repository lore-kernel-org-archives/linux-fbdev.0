From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Mon, 16 Mar 2015 17:11:57 +0000
Subject: [PATCHv4 09/10] fbdev: ssd1307fb: add backlight controls for setting the contrast
Message-Id: <1426525918-12745-10-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1426525918-12745-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1426525918-12745-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

The backlight class is used to create userspace handles for
setting the OLED contrast.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
---
 drivers/video/fbdev/Kconfig     |  1 +
 drivers/video/fbdev/ssd1307fb.c | 58 +++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index b3dd417..da70bae 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2478,6 +2478,7 @@ config FB_SSD1307
 	select FB_SYS_IMAGEBLIT
 	select FB_DEFERRED_IO
 	select PWM
+	select FB_BACKLIGHT
 	help
 	  This driver implements support for the Solomon SSD1307
 	  OLED controller over I2C.
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index 0d851f1..4ebfcaf 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -7,6 +7,7 @@
  */
=20
 #include <linux/module.h>
+#include <linux/backlight.h>
 #include <linux/kernel.h>
 #include <linux/i2c.h>
 #include <linux/fb.h>
@@ -42,6 +43,8 @@
 #define	SSD1307FB_SET_COM_PINS_CONFIG	0xda
 #define	SSD1307FB_SET_VCOMH		0xdb
=20
+#define MAX_CONTRAST 255
+
 #define REFRASHRATE 1
=20
 static u_int refreshrate =3D REFRASHRATE;
@@ -431,6 +434,43 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	return 0;
 }
=20
+static int ssd1307fb_update_bl(struct backlight_device *bdev)
+{
+	struct ssd1307fb_par *par =3D bl_get_data(bdev);
+	int ret;
+	int brightness =3D bdev->props.brightness;
+
+	par->contrast =3D brightness;
+
+	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_CONTRAST);
+	if (ret < 0)
+		return ret;
+	ret =3D ssd1307fb_write_cmd(par->client, par->contrast);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int ssd1307fb_get_brightness(struct backlight_device *bdev)
+{
+	struct ssd1307fb_par *par =3D bl_get_data(bdev);
+
+	return par->contrast;
+}
+
+static int ssd1307fb_check_fb(struct backlight_device *bdev,
+				   struct fb_info *info)
+{
+	return (info->bl_dev =3D bdev);
+}
+
+static const struct backlight_ops ssd1307fb_bl_ops =3D {
+	.options	=3D BL_CORE_SUSPENDRESUME,
+	.update_status	=3D ssd1307fb_update_bl,
+	.get_brightness	=3D ssd1307fb_get_brightness,
+	.check_fb	=3D ssd1307fb_check_fb,
+};
+
 static struct ssd1307fb_deviceinfo ssd1307fb_ssd1305_deviceinfo =3D {
 	.device_id  =3D DEVID_SSD1305,
 	.default_vcomh =3D 0x34,
@@ -472,6 +512,8 @@ MODULE_DEVICE_TABLE(of, ssd1307fb_of_match);
 static int ssd1307fb_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
+	struct backlight_device *bl;
+	char bl_name[12];
 	struct fb_info *info;
 	struct device_node *node =3D client->dev.of_node;
 	struct fb_deferred_io *ssd1307fb_defio;
@@ -607,10 +649,24 @@ static int ssd1307fb_probe(struct i2c_client *client,
 		goto panel_init_error;
 	}
=20
+	snprintf(bl_name, sizeof(bl_name), "ssd1307fb%d", info->node);
+	bl =3D backlight_device_register(bl_name, &client->dev, par,
+				       &ssd1307fb_bl_ops, NULL);
+	bl->props.brightness =3D contrast;
+	bl->props.max_brightness =3D MAX_CONTRAST;
+	info->bl_dev =3D bl;
+
+	if (IS_ERR(bl)) {
+		dev_err(&client->dev, "unable to register backlight device: %ld\n",
+			PTR_ERR(bl));
+		goto bl_init_error;
+	}
 	dev_info(&client->dev, "fb%d: %s framebuffer device registered, using %d =
bytes of video memory\n", info->node, info->fix.id, vmem_size);
=20
 	return 0;
=20
+bl_init_error:
+	unregister_framebuffer(info);
 panel_init_error:
 	if (par->device_info->device_id =3D DEVID_SSD1307) {
 		pwm_disable(par->pwm);
@@ -630,6 +686,8 @@ static int ssd1307fb_remove(struct i2c_client *client)
=20
 	ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_OFF);
=20
+	backlight_device_unregister(info->bl_dev);
+
 	unregister_framebuffer(info);
 	if (par->device_info->device_id =3D DEVID_SSD1307) {
 		pwm_disable(par->pwm);
--=20
2.3.0


From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Mon, 16 Mar 2015 17:11:54 +0000
Subject: [PATCHv4 06/10] fbdev: ssd1307fb: Add support for SSD1305
Message-Id: <1426525918-12745-7-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1426525918-12745-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1426525918-12745-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

This patch adds support for the SSD1305 OLED controller.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
---
 Documentation/devicetree/bindings/video/ssd1307fb.txt |  2 +-
 drivers/video/fbdev/ssd1307fb.c                       | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/video/ssd1307fb.txt b/Docume=
ntation/devicetree/bindings/video/ssd1307fb.txt
index be27562..a878fd2 100644
--- a/Documentation/devicetree/bindings/video/ssd1307fb.txt
+++ b/Documentation/devicetree/bindings/video/ssd1307fb.txt
@@ -2,7 +2,7 @@
=20
 Required properties:
   - compatible: Should be "solomon,<chip>fb-<bus>". The only supported bus=
 for
-    now is i2c, and the supported chips are ssd1306 and ssd1307.
+    now is i2c, and the supported chips are ssd1305, ssd1306 and ssd1307.
   - reg: Should contain address of the controller on the I2C bus. Most lik=
ely
          0x3c or 0x3d
   - pwm: Should contain the pwm to use according to the OF device tree PWM
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index 9a66118..6fecec8 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -16,6 +16,7 @@
 #include <linux/pwm.h>
 #include <linux/delay.h>
=20
+#define DEVID_SSD1305 5
 #define DEVID_SSD1306 6
 #define DEVID_SSD1307 7
=20
@@ -430,6 +431,13 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	return 0;
 }
=20
+static struct ssd1307fb_deviceinfo ssd1307fb_ssd1305_deviceinfo =3D {
+	.device_id  =3D DEVID_SSD1305,
+	.default_vcomh =3D 0x34,
+	.default_dclk_div =3D 0,
+	.default_dclk_frq =3D 7,
+};
+
 static struct ssd1307fb_deviceinfo ssd1307fb_ssd1306_deviceinfo =3D {
 	.device_id  =3D DEVID_SSD1306,
 	.default_vcomh =3D 0x20,
@@ -446,6 +454,10 @@ static struct ssd1307fb_deviceinfo ssd1307fb_ssd1307_d=
eviceinfo =3D {
=20
 static const struct of_device_id ssd1307fb_of_match[] =3D {
 	{
+		.compatible =3D "solomon,ssd1305fb-i2c",
+		.data =3D (void *)&ssd1307fb_ssd1305_deviceinfo,
+	},
+	{
 		.compatible =3D "solomon,ssd1306fb-i2c",
 		.data =3D (void *)&ssd1307fb_ssd1306_deviceinfo,
 	},
@@ -618,6 +630,7 @@ static int ssd1307fb_remove(struct i2c_client *client)
 }
=20
 static const struct i2c_device_id ssd1307fb_i2c_id[] =3D {
+	{ "ssd1305fb", 0 },
 	{ "ssd1306fb", 0 },
 	{ "ssd1307fb", 0 },
 	{ }
--=20
2.3.0


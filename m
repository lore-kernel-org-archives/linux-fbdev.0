From: niederp@physik.uni-kl.de
Date: Fri, 06 Feb 2015 22:28:09 +0000
Subject: [PATCH 3/8] fbdev: ssd1307fb: Add support for SSD1305
Message-Id: <1423261694-5939-4-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

From: Thomas Niederprüm <niederp@physik.uni-kl.de>

This patch adds support for the SSD1305 OLED controller.

Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
---
 Documentation/devicetree/bindings/video/ssd1307fb.txt |  2 +-
 drivers/video/fbdev/ssd1307fb.c                       | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/video/ssd1307fb.txt b/Documentation/devicetree/bindings/video/ssd1307fb.txt
index 1230f68..51fa263 100644
--- a/Documentation/devicetree/bindings/video/ssd1307fb.txt
+++ b/Documentation/devicetree/bindings/video/ssd1307fb.txt
@@ -2,7 +2,7 @@
 
 Required properties:
   - compatible: Should be "solomon,<chip>fb-<bus>". The only supported bus for
-    now is i2c, and the supported chips are ssd1306 and ssd1307.
+    now is i2c, and the supported chips are ssd1305, ssd1306 and ssd1307.
   - reg: Should contain address of the controller on the I2C bus. Most likely
          0x3c or 0x3d
   - pwm: Should contain the pwm to use according to the OF device tree PWM
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 4f435aa..01cfb46 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -16,6 +16,7 @@
 #include <linux/pwm.h>
 #include <linux/delay.h>
 
+#define DEVID_SSD1305 5
 #define DEVID_SSD1306 6
 #define DEVID_SSD1307 7
 
@@ -427,6 +428,13 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	return 0;
 }
 
+static struct ssd1307fb_deviceinfo ssd1307fb_ssd1305_deviceinfo = {
+	.device_id  = DEVID_SSD1305,
+	.default_vcomh = 0x34,
+	.default_dclk_div = 0,
+	.default_dclk_frq = 7,
+};
+
 static struct ssd1307fb_deviceinfo ssd1307fb_ssd1306_deviceinfo = {
 	.device_id  = DEVID_SSD1306,
 	.default_vcomh = 0x20,
@@ -443,6 +451,10 @@ static struct ssd1307fb_deviceinfo ssd1307fb_ssd1307_deviceinfo = {
 
 static const struct of_device_id ssd1307fb_of_match[] = {
 	{
+		.compatible = "solomon,ssd1305fb-i2c",
+		.data = (void *)&ssd1307fb_ssd1305_deviceinfo,
+	},
+	{
 		.compatible = "solomon,ssd1306fb-i2c",
 		.data = (void *)&ssd1307fb_ssd1306_deviceinfo,
 	},
@@ -623,6 +635,7 @@ static int ssd1307fb_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ssd1307fb_i2c_id[] = {
+	{ "ssd1305fb", 0 },
 	{ "ssd1306fb", 0 },
 	{ "ssd1307fb", 0 },
 	{ }
-- 
2.1.1


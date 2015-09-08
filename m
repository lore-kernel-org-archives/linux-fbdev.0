From: Olliver Schinagl <o.schinagl@ultimaker.com>
Date: Tue, 08 Sep 2015 19:19:51 +0000
Subject: [PATCH 2/2] fbdev: ssd1307fb: add ssd1309 support
Message-Id: <1441739991-4676-3-git-send-email-o.schinagl@ultimaker.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441739991-4676-1-git-send-email-o.schinagl@ultimaker.com>
In-Reply-To: <1441739991-4676-1-git-send-email-o.schinagl-U3FVU11NWA554TAoqtyWWQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp-PRwTpj6vllL6m1q2wEL4bg@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Prabhakar Lad <prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olliver Schinagl <o.schinagl-U3FVU11NWA554TAoqtyWWQ@public.gmane.org>

The ssd1307fb driver supports a lot of chips from the ssd130xfb series.
This patch adds the ssd1309 chip, a 128x64 OLED driver chip. It is very
similar to the other chips and only has some definitions added to
support it.

Signed-off-by: Olliver Schinagl <o.schinagl@ultimaker.com>
---
 Documentation/devicetree/bindings/video/ssd1307fb.txt |  3 ++-
 drivers/video/fbdev/ssd1307fb.c                       | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/video/ssd1307fb.txt b/Documentation/devicetree/bindings/video/ssd1307fb.txt
index d1be78d..eb31ed4 100644
--- a/Documentation/devicetree/bindings/video/ssd1307fb.txt
+++ b/Documentation/devicetree/bindings/video/ssd1307fb.txt
@@ -2,7 +2,8 @@
 
 Required properties:
   - compatible: Should be "solomon,<chip>fb-<bus>". The only supported bus for
-    now is i2c, and the supported chips are ssd1305, ssd1306 and ssd1307.
+    now is i2c, and the supported chips are ssd1305, ssd1306, ssd1307 and
+    ssd1309.
   - reg: Should contain address of the controller on the I2C bus. Most likely
          0x3c or 0x3d
   - pwm: Should contain the pwm to use according to the OF device tree PWM
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 339615c..8fc7960 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -495,6 +495,12 @@ static struct ssd1307fb_deviceinfo ssd1307fb_ssd1307_deviceinfo = {
 	.need_pwm = 1,
 };
 
+static struct ssd1307fb_deviceinfo ssd1307fb_ssd1309_deviceinfo = {
+	.default_vcomh = 0x34,
+	.default_dclk_div = 1,
+	.default_dclk_frq = 10,
+};
+
 static const struct of_device_id ssd1307fb_of_match[] = {
 	{
 		.compatible = "solomon,ssd1305fb-i2c",
@@ -508,6 +514,10 @@ static const struct of_device_id ssd1307fb_of_match[] = {
 		.compatible = "solomon,ssd1307fb-i2c",
 		.data = (void *)&ssd1307fb_ssd1307_deviceinfo,
 	},
+	{
+		.compatible = "solomon,ssd1309fb-i2c",
+		.data = (void *)&ssd1307fb_ssd1309_deviceinfo,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ssd1307fb_of_match);
@@ -708,6 +718,7 @@ static const struct i2c_device_id ssd1307fb_i2c_id[] = {
 	{ "ssd1305fb", 0 },
 	{ "ssd1306fb", 0 },
 	{ "ssd1307fb", 0 },
+	{ "ssd1309fb", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ssd1307fb_i2c_id);
-- 
2.1.4


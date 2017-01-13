From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 13 Jan 2017 10:35:48 +0000
Subject: [PATCH v2 4/5] fbdev/ssd1307fb: add support to enable VBAT
Message-Id: <214ae9ca86009148f233be71a3606917f3150dcd.1484303628.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1484303628.git.jsarha@ti.com>
In-Reply-To: <cover.1484303628.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

SSD1306 needs VBAT when it is wired in charge pump configuration. This
patch adds support to the driver to enable VBAT regulator at init time.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../devicetree/bindings/display/ssd1307fb.txt        |  1 +
 drivers/video/fbdev/ssd1307fb.c                      | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
index 6617df6..209d931 100644
--- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
+++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
@@ -16,6 +16,7 @@ Required properties:
 Optional properties:
   - reset-gpios: The GPIO used to reset the OLED display, if available. See
                  Documentation/devicetree/bindings/gpio/gpio.txt for details.
+  - vbat-supply: The supply for VBAT
   - solomon,segment-no-remap: Display needs normal (non-inverted) data column
                               to segment mapping
   - solomon,com-seq: Display uses sequential COM pin configuration
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 89372af..616a6a3 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -16,6 +16,7 @@
 #include <linux/of_gpio.h>
 #include <linux/pwm.h>
 #include <linux/uaccess.h>
+#include <linux/regulator/consumer.h>
 
 #define SSD1307FB_DATA			0x40
 #define SSD1307FB_COMMAND		0x80
@@ -74,6 +75,7 @@ struct ssd1307fb_par {
 	struct pwm_device *pwm;
 	u32 pwm_period;
 	struct gpio_desc *reset;
+	struct regulator *vbat_reg;
 	u32 seg_remap;
 	u32 vcomh;
 	u32 width;
@@ -574,6 +576,14 @@ static int ssd1307fb_probe(struct i2c_client *client,
 		goto fb_alloc_error;
 	}
 
+	par->vbat_reg = devm_regulator_get_optional(&client->dev, "vbat");
+	if (IS_ERR(par->vbat_reg)) {
+		dev_err(&client->dev, "failed to get VBAT regulator: %ld\n",
+			PTR_ERR(par->vbat_reg));
+		ret = PTR_ERR(par->vbat_reg);
+		goto fb_alloc_error;
+	}
+
 	if (of_property_read_u32(node, "solomon,width", &par->width))
 		par->width = 96;
 
@@ -658,9 +668,15 @@ static int ssd1307fb_probe(struct i2c_client *client,
 		udelay(4);
 	}
 
+	ret = regulator_enable(par->vbat_reg);
+	if (ret) {
+		dev_err(&client->dev, "failed to enable VBAT: %d\n", ret);
+		goto reset_oled_error;
+	}
+
 	ret = ssd1307fb_init(par);
 	if (ret)
-		goto reset_oled_error;
+		goto regulator_enable_error;
 
 	ret = register_framebuffer(info);
 	if (ret) {
@@ -693,6 +709,8 @@ static int ssd1307fb_probe(struct i2c_client *client,
 		pwm_disable(par->pwm);
 		pwm_put(par->pwm);
 	};
+regulator_enable_error:
+	regulator_disable(par->vbat_reg);
 reset_oled_error:
 	fb_deferred_io_cleanup(info);
 fb_alloc_error:
-- 
1.9.1


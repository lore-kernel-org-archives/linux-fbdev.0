From: Jyri Sarha <jsarha@ti.com>
Date: Thu, 12 Jan 2017 11:16:30 +0000
Subject: [PATCH 4/6] fbdev/ssd1307fb: add support to enable VBAT
Message-Id: <cf61820cc8ed0210346710c3318748b3b647f697.1484219137.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1484219137.git.jsarha@ti.com>
In-Reply-To: <cover.1484219137.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: tomi.valkeinen-l0cyMroinI0@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

SSD1306 needs VBAT when it is wired in charge pump configuration. This
patch adds support to the driver to enable VBAT regulator at init time.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/ssd1307fb.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

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


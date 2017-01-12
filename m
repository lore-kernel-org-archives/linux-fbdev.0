From: Jyri Sarha <jsarha@ti.com>
Date: Thu, 12 Jan 2017 11:16:27 +0000
Subject: [PATCH 1/6] fbdev: ssd1307fb: Start to use gpiod API for reset gpio
Message-Id: <077530ae240ae44ec22253d8b7c0df3244cb69b4.1484219137.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1484219137.git.jsarha@ti.com>
In-Reply-To: <cover.1484219137.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: tomi.valkeinen-l0cyMroinI0@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

Start to use gpiod API for reset gpio.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/ssd1307fb.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 2925d5c..8ffaaee 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -73,7 +73,7 @@ struct ssd1307fb_par {
 	u32 prechargep2;
 	struct pwm_device *pwm;
 	u32 pwm_period;
-	int reset;
+	struct gpio_desc *reset;
 	u32 seg_remap;
 	u32 vcomh;
 	u32 width;
@@ -561,10 +561,11 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	par->device_info = of_device_get_match_data(&client->dev);
 
-	par->reset = of_get_named_gpio(client->dev.of_node,
-					 "reset-gpios", 0);
-	if (!gpio_is_valid(par->reset)) {
-		ret = -EINVAL;
+	par->reset = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(par->reset)) {
+		dev_err(&client->dev, "failed to get reset gpio: %ld\n",
+			PTR_ERR(par->reset));
+		ret = PTR_ERR(par->reset);
 		goto fb_alloc_error;
 	}
 
@@ -642,22 +643,12 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	fb_deferred_io_init(info);
 
-	ret = devm_gpio_request_one(&client->dev, par->reset,
-				    GPIOF_OUT_INIT_HIGH,
-				    "oled-reset");
-	if (ret) {
-		dev_err(&client->dev,
-			"failed to request gpio %d: %d\n",
-			par->reset, ret);
-		goto reset_oled_error;
-	}
-
 	i2c_set_clientdata(client, info);
 
 	/* Reset the screen */
-	gpio_set_value(par->reset, 0);
+	gpiod_set_value(par->reset, 0);
 	udelay(4);
-	gpio_set_value(par->reset, 1);
+	gpiod_set_value(par->reset, 1);
 	udelay(4);
 
 	ret = ssd1307fb_init(par);
-- 
1.9.1


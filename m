From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 13 Jan 2017 10:35:47 +0000
Subject: [PATCH v2 3/5] fbdev: ssd1307fb: Make reset gpio devicetree property optional
Message-Id: <5745ec4b4e5156ae7c7684fce4c7086f91e67c1f.1484303628.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1484303628.git.jsarha@ti.com>
In-Reply-To: <cover.1484303628.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

Make reset gpio devicetree property optional. Depending on the board
designing there may not be a dedicated gpio for resetting the
display. Without a proper reset there may be some junk in the display
memory at probe time, so in such a case the display memory is cleared
before turning it on. The devicetree binding document is also updated.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../devicetree/bindings/display/ssd1307fb.txt         |  4 ++--
 drivers/video/fbdev/ssd1307fb.c                       | 19 +++++++++++++------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
index 4aee67f..6617df6 100644
--- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
+++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
@@ -8,14 +8,14 @@ Required properties:
          0x3c or 0x3d
   - pwm: Should contain the pwm to use according to the OF device tree PWM
          specification [0]. Only required for the ssd1307.
-  - reset-gpios: Should contain the GPIO used to reset the OLED display. See
-                 Documentation/devicetree/bindings/gpio/gpio.txt for details.
   - solomon,height: Height in pixel of the screen driven by the controller
   - solomon,width: Width in pixel of the screen driven by the controller
   - solomon,page-offset: Offset of pages (band of 8 pixels) that the screen is
     mapped to.
 
 Optional properties:
+  - reset-gpios: The GPIO used to reset the OLED display, if available. See
+                 Documentation/devicetree/bindings/gpio/gpio.txt for details.
   - solomon,segment-no-remap: Display needs normal (non-inverted) data column
                               to segment mapping
   - solomon,com-seq: Display uses sequential COM pin configuration
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 8ffaaee..89372af 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -439,6 +439,10 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
 
+	/* Clear the screen if we could not give reset at probe time */
+	if (!par->reset)
+		ssd1307fb_update_display(par);
+
 	/* Turn on the display */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_ON);
 	if (ret < 0)
@@ -561,7 +565,8 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	par->device_info = of_device_get_match_data(&client->dev);
 
-	par->reset = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_LOW);
+	par->reset = devm_gpiod_get_optional(&client->dev, "reset",
+					     GPIOD_OUT_LOW);
 	if (IS_ERR(par->reset)) {
 		dev_err(&client->dev, "failed to get reset gpio: %ld\n",
 			PTR_ERR(par->reset));
@@ -645,11 +650,13 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, info);
 
-	/* Reset the screen */
-	gpiod_set_value(par->reset, 0);
-	udelay(4);
-	gpiod_set_value(par->reset, 1);
-	udelay(4);
+	if (par->reset) {
+		/* Reset the screen */
+		gpiod_set_value(par->reset, 0);
+		udelay(4);
+		gpiod_set_value(par->reset, 1);
+		udelay(4);
+	}
 
 	ret = ssd1307fb_init(par);
 	if (ret)
-- 
1.9.1


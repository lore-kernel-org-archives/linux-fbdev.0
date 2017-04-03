From: Bastian Stender <bst@pengutronix.de>
Date: Mon, 03 Apr 2017 13:53:44 +0000
Subject: [PATCH] fbdev/ssd1307fb: fix optional VBAT support
Message-Id: <20170403135344.31091-1-bst@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

SSD1306 needs VBAT when it is wired in charge pump configuration only.
Other controllers of the SSD1307 family do not need it at all. This was
introduced by commit ba14301e0356c99803e07db60e129a2ca9e50ff0.

Without VBAT configuration the driver now fails with:

	failed to get VBAT regulator: -19

This is caused by misinterpretation of devm_regulator_get_optional
which "returns a struct regulator corresponding to the regulator
producer or IS_ERR() condition".

Handle -ENODEV without bailing out and making VBAT support really
optional.

Signed-off-by: Bastian Stender <bst@pengutronix.de>
---
 drivers/video/fbdev/ssd1307fb.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index bd017b57c47f..1c9e2c51e692 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -578,10 +578,14 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	par->vbat_reg = devm_regulator_get_optional(&client->dev, "vbat");
 	if (IS_ERR(par->vbat_reg)) {
-		dev_err(&client->dev, "failed to get VBAT regulator: %ld\n",
-			PTR_ERR(par->vbat_reg));
 		ret = PTR_ERR(par->vbat_reg);
-		goto fb_alloc_error;
+		if (ret = -ENODEV) {
+			par->vbat_reg = NULL;
+		} else {
+			dev_err(&client->dev, "failed to get VBAT regulator: %ld\n",
+				ret);
+			goto fb_alloc_error;
+		}
 	}
 
 	if (of_property_read_u32(node, "solomon,width", &par->width))
@@ -668,10 +672,13 @@ static int ssd1307fb_probe(struct i2c_client *client,
 		udelay(4);
 	}
 
-	ret = regulator_enable(par->vbat_reg);
-	if (ret) {
-		dev_err(&client->dev, "failed to enable VBAT: %d\n", ret);
-		goto reset_oled_error;
+	if (par->vbat_reg) {
+		ret = regulator_enable(par->vbat_reg);
+		if (ret) {
+			dev_err(&client->dev, "failed to enable VBAT: %d\n",
+				ret);
+			goto reset_oled_error;
+		}
 	}
 
 	ret = ssd1307fb_init(par);
@@ -710,7 +717,8 @@ static int ssd1307fb_probe(struct i2c_client *client,
 		pwm_put(par->pwm);
 	};
 regulator_enable_error:
-	regulator_disable(par->vbat_reg);
+	if (par->vbat_reg)
+		regulator_disable(par->vbat_reg);
 reset_oled_error:
 	fb_deferred_io_cleanup(info);
 fb_alloc_error:
-- 
2.11.0


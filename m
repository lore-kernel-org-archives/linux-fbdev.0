From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 22 Apr 2020 06:51:14 +0000
Subject: [PATCHv3 4/4] backlight: led_bl: fix led -> backlight brightness mapping
Message-Id: <20200422065114.22164-5-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200422065114.22164-1-tomi.valkeinen@ti.com>
In-Reply-To: <20200422065114.22164-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The code that maps the LED default brightness to backlight levels has
two issues: 1) if the default brightness is the first backlight level
(usually 0), the code fails to find it, and 2) when the code fails to
find a backlight level, it ends up using max_brightness + 1 as the
default brightness.

Fix these two issues.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/backlight/led_bl.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index 63693c4f0883..699424b111ec 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -139,7 +139,6 @@ static int led_bl_parse_levels(struct device *dev,
 	num_levels = of_property_count_u32_elems(node, "brightness-levels");
 	if (num_levels > 1) {
 		int i;
-		unsigned int db;
 		u32 *levels;
 
 		levels = devm_kzalloc(dev, sizeof(u32) * num_levels,
@@ -153,15 +152,11 @@ static int led_bl_parse_levels(struct device *dev,
 		if (ret < 0)
 			return ret;
 
-		/*
-		 * Try to map actual LED brightness to backlight brightness
-		 * level
-		 */
-		db = priv->default_brightness;
-		for (i = 0 ; i < num_levels; i++) {
-			if ((i && db > levels[i - 1]) && db <= levels[i])
+		/* Map LED brightness to backlight brightness level */
+		for (i = 0; i < num_levels - 1; i++)
+			if (levels[i] >= priv->default_brightness)
 				break;
-		}
+
 		priv->default_brightness = i;
 		priv->max_brightness = num_levels - 1;
 		priv->levels = levels;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

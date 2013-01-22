From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 22 Jan 2013 13:39:55 +0000
Subject: [PATCH 3/4] pwm_backlight: Refactor the DT parsing code
Message-Id: <1358861996-27194-4-git-send-email-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358861996-27194-1-git-send-email-peter.ujfalusi@ti.com>
In-Reply-To: <1358861996-27194-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

In preparation to support the whole range of the PWM device in a similar way
it is possible when we boot in legacy mode (non DT mode).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/video/backlight/pwm_bl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 2a81c24..df2d115 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -100,7 +100,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
 {
 	struct device_node *node = dev->of_node;
 	struct property *prop;
-	int length;
+	int num_levels = 0;
 	u32 value;
 	int ret;
 
@@ -110,26 +110,27 @@ static int pwm_backlight_parse_dt(struct device *dev,
 	memset(data, 0, sizeof(*data));
 
 	/* determine the number of brightness levels */
-	prop = of_find_property(node, "brightness-levels", &length);
+	prop = of_find_property(node, "brightness-levels", &num_levels);
 	if (!prop)
 		return -EINVAL;
 
-	data->max_brightness = length / sizeof(u32);
+	num_levels /= sizeof(u32);
 
 	/* read brightness levels from DT property */
-	if (data->max_brightness > 0) {
-		size_t size = sizeof(*data->levels) * data->max_brightness;
+	if (num_levels > 0) {
+		size_t size = sizeof(*data->levels) * num_levels;
 
 		data->levels = devm_kzalloc(dev, size, GFP_KERNEL);
 		if (!data->levels)
 			return -ENOMEM;
 
 		ret = of_property_read_u32_array(node, "brightness-levels",
-						 data->levels,
-						 data->max_brightness);
+						 data->levels, num_levels);
 		if (ret < 0)
 			return ret;
 
+		data->max_brightness = num_levels;
+
 		ret = of_property_read_u32(node, "default-brightness-level",
 					   &value);
 		if (ret < 0)
-- 
1.8.1.1


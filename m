From: Sasha Levin <sashal@kernel.org>
Date: Wed, 13 Feb 2019 02:35:39 +0000
Subject: [PATCH AUTOSEL 4.19 01/83] backlight: pwm_bl: Fix devicetree parsing with auto-generated brightness 
Message-Id: <20190213023701.20286-1-sashal@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>, Heiko Stuebner <heiko.stuebner@bq.com>

From: Heiko Stuebner <heiko.stuebner@bq.com>

[ Upstream commit 61170ee9386888f1e6f7e9cc58e8d9a8c2a3c1dd ]

Commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly
to human eye") made the parse-dt function return early when using an auto-
generated brightness-table, but didn't take into account that some more
settings were handled below the brightness handling, like power-on-delays
and also setting the pdata enable-gpio to -EINVAL.

This surfaces for example in the case of a backlight without any
enable-gpio which then tries to use gpio-0 in error.

Fix this by simply moving the trailing settings above the brightness
handling.

Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/pwm_bl.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index bdfcc0a71db1..6bde543452f2 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -262,6 +262,16 @@ static int pwm_backlight_parse_dt(struct device *dev,
 
 	memset(data, 0, sizeof(*data));
 
+	/*
+	 * These values are optional and set as 0 by default, the out values
+	 * are modified only if a valid u32 value can be decoded.
+	 */
+	of_property_read_u32(node, "post-pwm-on-delay-ms",
+			     &data->post_pwm_on_delay);
+	of_property_read_u32(node, "pwm-off-delay-ms", &data->pwm_off_delay);
+
+	data->enable_gpio = -EINVAL;
+
 	/*
 	 * Determine the number of brightness levels, if this property is not
 	 * set a default table of brightness levels will be used.
@@ -374,15 +384,6 @@ static int pwm_backlight_parse_dt(struct device *dev,
 		data->max_brightness--;
 	}
 
-	/*
-	 * These values are optional and set as 0 by default, the out values
-	 * are modified only if a valid u32 value can be decoded.
-	 */
-	of_property_read_u32(node, "post-pwm-on-delay-ms",
-			     &data->post_pwm_on_delay);
-	of_property_read_u32(node, "pwm-off-delay-ms", &data->pwm_off_delay);
-
-	data->enable_gpio = -EINVAL;
 	return 0;
 }
 
-- 
2.19.1

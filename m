From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 19 Jul 2018 16:19:23 +0000
Subject: [PATCH v2] backlight: pwm_bl: Fix uninitialized variable
Message-Id: <20180719161923.21510-1-daniel.thompson@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
In-Reply-To: <20180716210241.9457-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, patches@linaro.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>

Currently, if the DT does not define num-interpolated-steps then
num_steps is undefined and the interpolation code will deploy randomly.
Fix this.

Additionally fix a small grammar error that was identified and
tighten up return code checking of DT properties, both of which came
up during review of this patch.

Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
brightness-levels")
Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

Notes:
    v2:
     - Simplify SoB chain (with Marcel's permission)
     - Separate complex if statement and make other similar calls use same
       return code checking approach
     - Tidy up comment formatting and fix pre-existing grammar error

 drivers/video/backlight/pwm_bl.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 9ee4c1b735b2..f7799f62fea0 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -284,30 +284,29 @@ static int pwm_backlight_parse_dt(struct device *dev,
 		ret = of_property_read_u32_array(node, "brightness-levels",
 						 data->levels,
 						 data->max_brightness);
-		if (ret < 0)
+		if (!ret)
 			return ret;

 		ret = of_property_read_u32(node, "default-brightness-level",
 					   &value);
-		if (ret < 0)
+		if (!ret)
 			return ret;

 		data->dft_brightness = value;

 		/*
 		 * This property is optional, if is set enables linear
-		 * interpolation between each of the values of brightness levels
-		 * and creates a new pre-computed table.
+		 * interpolation between each of the values of brightness
+		 * levels and creates a new pre-computed table.
 		 */
-		of_property_read_u32(node, "num-interpolated-steps",
-				     &num_steps);
-
-		/*
-		 * Make sure that there is at least two entries in the
-		 * brightness-levels table, otherwise we can't interpolate
-		 * between two points.
-		 */
-		if (num_steps) {
+		ret = of_property_read_u32(node, "num-interpolated-steps",
+					   &num_steps);
+		if (!ret || num_steps) {
+			/*
+			 * Make sure that there are at least two entries in
+			 * the brightness-levels table, otherwise we can't
+			 * interpolate between two points.
+			 */
 			if (data->max_brightness < 2) {
 				dev_err(dev, "can't interpolate\n");
 				return -EINVAL;
--
2.17.1


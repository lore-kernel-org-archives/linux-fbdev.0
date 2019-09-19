From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Thu, 19 Sep 2019 14:06:18 +0000
Subject: [PATCH 3/5] backlight: pwm_bl: drop use of int_pow()
Message-Id: <20190919140620.32407-3-linux@rasmusvillemoes.dk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The scheduler uses a (currently private) fixed_power_int() in its load
average computation for computing powers of numbers 0 < x < 1
expressed as fixed-point numbers, which is also what we want here. But
that requires the scale to be a power-of-2.

We could (and a following patch will) change to use a power-of-2 scale,
but for a fixed small exponent of 3, there's no advantage in using
repeated squaring.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/backlight/pwm_bl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 9252d51f31b9..aee6839e024a 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -179,7 +179,8 @@ static u64 cie1931(unsigned int lightness, unsigned int scale)
 	if (lightness <= (8 * scale)) {
 		retval = DIV_ROUND_CLOSEST(lightness * 10, 9033);
 	} else {
-		retval = int_pow((lightness + (16 * scale)) / 116, 3);
+		retval = (lightness + (16 * scale)) / 116;
+		retval *= retval * retval;
 		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
 	}
 
-- 
2.20.1

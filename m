From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Tue, 08 Oct 2019 12:03:25 +0000
Subject: [PATCH v2 2/4] backlight: pwm_bl: eliminate a 64/32 division
Message-Id: <20191008120327.24208-3-linux@rasmusvillemoes.dk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

lightness*1000 is nowhere near overflowing 32 bits, so we can just use
an ordinary 32/32 division, which is much cheaper than the 64/32 done
via do_div().

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/backlight/pwm_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index cc44a02e95c7..672c5e7cfcd1 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -177,7 +177,7 @@ static u64 cie1931(unsigned int lightness, unsigned int scale)
 	 */
 	lightness *= 100;
 	if (lightness <= (8 * scale)) {
-		retval = DIV_ROUND_CLOSEST_ULL(lightness * 10, 9033);
+		retval = DIV_ROUND_CLOSEST(lightness * 10, 9033);
 	} else {
 		retval = int_pow((lightness + (16 * scale)) / 116, 3);
 		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
-- 
2.20.1

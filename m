From: Alexandru Stan <amstan@chromium.org>
Date: Tue, 21 Jul 2020 04:25:21 +0000
Subject: [PATCH 2/3] backlight: pwm_bl: Artificially add 0% during interpolation
Message-Id: <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200721042522.2403410-1-amstan@chromium.org>
In-Reply-To: <20200721042522.2403410-1-amstan@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Alexandru Stan <amstan@chromium.org>, Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>

Some displays need the low end of the curve cropped in order to make
them happy. In that case we still want to have the 0% point, even though
anything between 0% and 5%(example) would be skipped.

Signed-off-by: Alexandru Stan <amstan@chromium.org>
---

 drivers/video/backlight/pwm_bl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 5193a72305a2..b24711ddf504 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -349,6 +349,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
 			/* Fill in the last point, since no line starts here. */
 			table[x2] = y2;
 
+			/*
+			 * If we don't start at 0 yet we're increasing, assume
+			 * the dts wanted to crop the low end of the range, so
+			 * insert a 0 to provide a display off mode.
+			 */
+			if (table[0] > 0 && table[0] < table[num_levels - 1])
+				table[0] = 0;
+
 			/*
 			 * As we use interpolation lets remove current
 			 * brightness levels table and replace for the
-- 
2.27.0

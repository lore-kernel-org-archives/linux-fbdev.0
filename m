From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Thu, 14 Apr 2016 19:17:22 +0000
Subject: [PATCH v5 02/24] pwm: use pwm_get/set_xxx() helpers where appropriate
Message-Id: <1460661464-11216-3-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Milo Kim <milo.kim@ti.com>, Kamil Debski <k.debski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Vetter <daniel.vetter@intel.com>, Stephen Barber <smbarber@chromium.org>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Robert Jarzmik <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-input@vger

Use pwm_get/set_xxx() helpers instead of directly accessing the pwm->xxx
field. Doing that will ease adaptation of the PWM framework to support
atomic update.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Patch generated with the following coccinelle script:

--->8---
virtual patch

@@
struct pwm_device *p;
expression e;
@@
(
-(p)->polarity = e;
+pwm_set_polarity(p, e);
|
-(p)->polarity
+pwm_get_polarity(p)
|
-(p)->period = e;
+pwm_set_period(p, e);
|
-(p)->period
+pwm_get_period(p)
|
-(p)->duty_cycle = e;
+pwm_set_duty_cycle(p, e);
|
-(p)->duty_cycle
+pwm_get_duty_cycle(p)
)
--->8---
---
 drivers/pwm/pwm-crc.c          | 2 +-
 drivers/pwm/pwm-lpc18xx-sct.c  | 2 +-
 drivers/pwm/pwm-omap-dmtimer.c | 2 +-
 drivers/pwm/pwm-sun4i.c        | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 7101c70..bd0ebd0 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -75,7 +75,7 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
 		return -EINVAL;
 	}
 
-	if (pwm->period != period_ns) {
+	if (pwm_get_period(pwm) != period_ns) {
 		int clk_div;
 
 		/* changing the clk divisor, need to disable fisrt */
diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 9861fed..19dc64c 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -249,7 +249,7 @@ static int lpc18xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 			   LPC18XX_PWM_EVSTATEMSK(lpc18xx_data->duty_event),
 			   LPC18XX_PWM_EVSTATEMSK_ALL);
 
-	if (pwm->polarity = PWM_POLARITY_NORMAL) {
+	if (pwm_get_polarity(pwm) = PWM_POLARITY_NORMAL) {
 		set_event = lpc18xx_pwm->period_event;
 		clear_event = lpc18xx_data->duty_event;
 		res_action = LPC18XX_PWM_RES_SET;
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index b7e6ecb..3e95090 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -192,7 +192,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 		load_value, load_value,	match_value, match_value);
 
 	omap->pdata->set_pwm(omap->dm_timer,
-			      pwm->polarity = PWM_POLARITY_INVERSED,
+			      pwm_get_polarity(pwm) = PWM_POLARITY_INVERSED,
 			      true,
 			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
 
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 67af9f6..03a99a5 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -354,7 +354,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	val = sun4i_pwm_readl(pwm, PWM_CTRL_REG);
 	for (i = 0; i < pwm->chip.npwm; i++)
 		if (!(val & BIT_CH(PWM_ACT_STATE, i)))
-			pwm->chip.pwms[i].polarity = PWM_POLARITY_INVERSED;
+			pwm_set_polarity(&pwm->chip.pwms[i],
+					 PWM_POLARITY_INVERSED);
 	clk_disable_unprepare(pwm->clk);
 
 	return 0;
-- 
2.5.0


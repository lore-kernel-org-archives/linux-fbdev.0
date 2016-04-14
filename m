From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Thu, 14 Apr 2016 19:17:38 +0000
Subject: [PATCH v5 18/24] pwm: introduce the pwm_state concept
Message-Id: <1460661464-11216-19-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Milo Kim <milo.kim@ti.com>, Kamil Debski <k.debski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Vetter <daniel.vetter@intel.com>, Stephen Barber <smbarber@chromium.org>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Robert Jarzmik <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-input@vger

The PWM state, represented by its period, duty_cycle and polarity,
is currently directly stored in the PWM device.
Declare a pwm_state structure embedding those field so that we can later
use this struct to atomically update all the PWM parameters at once.

All pwm_get_xxx() helpers are now implemented as wrappers around
pwm_get_state().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c  |  8 ++++----
 include/linux/pwm.h | 54 +++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 26c3cf5..59bcece 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -268,7 +268,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->chip = chip;
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
-		pwm->polarity = polarity;
+		pwm->state.polarity = polarity;
 
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
@@ -446,8 +446,8 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (err)
 		return err;
 
-	pwm->duty_cycle = duty_ns;
-	pwm->period = period_ns;
+	pwm->state.duty_cycle = duty_ns;
+	pwm->state.period = period_ns;
 
 	return 0;
 }
@@ -480,7 +480,7 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 	if (err)
 		return err;
 
-	pwm->polarity = polarity;
+	pwm->state.polarity = polarity;
 
 	return 0;
 }
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 2f500a5..3022c05 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -97,6 +97,18 @@ enum {
 	PWMF_EXPORTED = 1 << 2,
 };
 
+/*
+ * struct pwm_state - state of a PWM channel
+ * @period: PWM period (in nanoseconds)
+ * @duty_cycle: PWM duty cycle (in nanoseconds)
+ * @polarity: PWM polarity
+ */
+struct pwm_state {
+	unsigned int period;
+	unsigned int duty_cycle;
+	enum pwm_polarity polarity;
+};
+
 /**
  * struct pwm_device - PWM channel object
  * @label: name of the PWM device
@@ -105,10 +117,8 @@ enum {
  * @pwm: global index of the PWM device
  * @chip: PWM chip providing this PWM device
  * @chip_data: chip-private data associated with the PWM device
- * @period: period of the PWM signal (in nanoseconds)
- * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
- * @polarity: polarity of the PWM signal
  * @args: PWM arguments
+ * @state: curent PWM channel state
  */
 struct pwm_device {
 	const char *label;
@@ -118,13 +128,21 @@ struct pwm_device {
 	struct pwm_chip *chip;
 	void *chip_data;
 
-	unsigned int period;
-	unsigned int duty_cycle;
-	enum pwm_polarity polarity;
-
 	struct pwm_args args;
+	struct pwm_state state;
 };
 
+/**
+ * pwm_get_state() - retrieve the current PWM state
+ * @pwm: PWM device
+ * @state: state to fill with the current PWM state
+ */
+static inline void pwm_get_state(const struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	*state = pwm->state;
+}
+
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 {
 	return test_bit(PWMF_ENABLED, &pwm->flags);
@@ -133,23 +151,31 @@ static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 {
 	if (pwm)
-		pwm->period = period;
+		pwm->state.period = period;
 }
 
 static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
 {
-	return pwm ? pwm->period : 0;
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return state.period;
 }
 
 static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
 {
 	if (pwm)
-		pwm->duty_cycle = duty;
+		pwm->state.duty_cycle = duty;
 }
 
 static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *pwm)
 {
-	return pwm ? pwm->duty_cycle : 0;
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return state.duty_cycle;
 }
 
 /*
@@ -159,7 +185,11 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity);
 
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 {
-	return pwm ? pwm->polarity : PWM_POLARITY_NORMAL;
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return state.polarity;
 }
 
 static inline void pwm_get_args(const struct pwm_device *pwm,
-- 
2.5.0


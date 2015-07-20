From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 20 Jul 2015 15:31:59 +0000
Subject: [PATCH v2 02/10] pwm: define a new pwm_state struct
Message-Id: <1437406327-6207-3-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The PWM state, represented by its period, duty_cycle and polarity,
is currently directly stored in the PWM device.
Declare a pwm_state structure embedding those field so that we can later
use this struct to atomically update all the PWM parameters at once.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c  |  6 +++---
 include/linux/pwm.h | 26 ++++++++++++++++++--------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 7ffad2b..a6bc8e6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -431,8 +431,8 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (err)
 		return err;
 
-	pwm->duty_cycle = duty_ns;
-	pwm->period = period_ns;
+	pwm->state.duty_cycle = duty_ns;
+	pwm->state.period = period_ns;
 
 	return 0;
 }
@@ -462,7 +462,7 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 	if (err)
 		return err;
 
-	pwm->polarity = polarity;
+	pwm->state.polarity = polarity;
 
 	return 0;
 }
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index ba4b7ed..fafed26 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -79,6 +79,18 @@ enum {
 	PWMF_EXPORTED = 1 << 2,
 };
 
+/**
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
 struct pwm_device {
 	const char		*label;
 	unsigned long		flags;
@@ -87,9 +99,7 @@ struct pwm_device {
 	struct pwm_chip		*chip;
 	void			*chip_data;
 
-	unsigned int		period; 	/* in nanoseconds */
-	unsigned int		duty_cycle;	/* in nanoseconds */
-	enum pwm_polarity	polarity;
+	struct pwm_state	state;
 };
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
@@ -100,7 +110,7 @@ static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 {
 	if (pwm)
-		pwm->period = period;
+		pwm->state.period = period;
 }
 
 static inline void pwm_set_default_period(struct pwm_device *pwm,
@@ -111,7 +121,7 @@ static inline void pwm_set_default_period(struct pwm_device *pwm,
 
 static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
 {
-	return pwm ? pwm->period : 0;
+	return pwm ? pwm->state.period : 0;
 }
 
 static inline unsigned int pwm_get_default_period(const struct pwm_device *pwm)
@@ -122,12 +132,12 @@ static inline unsigned int pwm_get_default_period(const struct pwm_device *pwm)
 static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
 {
 	if (pwm)
-		pwm->duty_cycle = duty;
+		pwm->state.duty_cycle = duty;
 }
 
 static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *pwm)
 {
-	return pwm ? pwm->duty_cycle : 0;
+	return pwm ? pwm->state.duty_cycle : 0;
 }
 
 /*
@@ -143,7 +153,7 @@ static inline void pwm_set_default_polarity(struct pwm_device *pwm,
 
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 {
-	return pwm ? pwm->polarity : PWM_POLARITY_NORMAL;
+	return pwm ? pwm->state.polarity : PWM_POLARITY_NORMAL;
 }
 
 /**
-- 
1.9.1


From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:38 +0000
Subject: [PATCH v4 15/24] pwm: define a new pwm_state struct
Message-Id: <1447664207-24370-16-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
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
 include/linux/pwm.h | 30 +++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 59073a1..f1c6769 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -447,8 +447,8 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (err)
 		return err;
 
-	pwm->duty_cycle = duty_ns;
-	pwm->period = period_ns;
+	pwm->state.duty_cycle = duty_ns;
+	pwm->state.period = period_ns;
 
 	return 0;
 }
@@ -485,7 +485,7 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 	if (err)
 		goto unlock;
 
-	pwm->polarity = polarity;
+	pwm->state.polarity = polarity;
 
 unlock:
 	mutex_unlock(&pwm->lock);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 8ba57fc..af42299 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -80,6 +80,18 @@ enum {
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
@@ -89,9 +101,7 @@ enum {
  * @chip: PWM chip providing this PWM device
  * @chip_data: chip-private data associated with the PWM device
  * @lock: used to serialize accesses to the PWM device where necessary
- * @period: period of the PWM signal (in nanoseconds)
- * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
- * @polarity: polarity of the PWM signal
+ * @state: curent PWM channel state
  */
 struct pwm_device {
 	const char *label;
@@ -102,9 +112,7 @@ struct pwm_device {
 	void *chip_data;
 	struct mutex lock;
 
-	unsigned int period;
-	unsigned int duty_cycle;
-	enum pwm_polarity polarity;
+	struct pwm_state state;
 };
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
@@ -115,7 +123,7 @@ static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 {
 	if (pwm)
-		pwm->period = period;
+		pwm->state.period = period;
 }
 
 static inline void pwm_set_default_period(struct pwm_device *pwm,
@@ -126,7 +134,7 @@ static inline void pwm_set_default_period(struct pwm_device *pwm,
 
 static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
 {
-	return pwm ? pwm->period : 0;
+	return pwm ? pwm->state.period : 0;
 }
 
 static inline unsigned int pwm_get_default_period(const struct pwm_device *pwm)
@@ -137,12 +145,12 @@ static inline unsigned int pwm_get_default_period(const struct pwm_device *pwm)
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
@@ -158,7 +166,7 @@ static inline void pwm_set_default_polarity(struct pwm_device *pwm,
 
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 {
-	return pwm ? pwm->polarity : PWM_POLARITY_NORMAL;
+	return pwm ? pwm->state.polarity : PWM_POLARITY_NORMAL;
 }
 
 /**
-- 
2.1.4


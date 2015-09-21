From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 21 Sep 2015 09:33:22 +0000
Subject: [PATCH v3 05/12] pwm: declare a default PWM state
Message-Id: <1442828009-6241-6-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Prepare the addition of the PWM initial state retrieval by adding a default
state where all the parameters retrieved from DT, platform data or
statically forced by the hardware will be stored.
Once done we will be able to store the initial state in the ->state field
without risking to loose the default parameters.

Update the pwm_set/get_default_xxx helpers accordingly.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/pwm.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 433a097..f8cc460 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -101,6 +101,7 @@ struct pwm_state {
  * @chip: PWM chip providing this PWM device
  * @chip_data: chip-private data associated with the PWM device
  * @state: curent PWM channel state
+ * @default_state: default PWM channel state
  */
 struct pwm_device {
 	const char *label;
@@ -111,6 +112,7 @@ struct pwm_device {
 	void *chip_data;
 
 	struct pwm_state state;
+	struct pwm_state default_state;
 };
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
@@ -127,7 +129,8 @@ static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 static inline void pwm_set_default_period(struct pwm_device *pwm,
 					  unsigned int period)
 {
-	pwm_set_period(pwm, period);
+	if (pwm)
+		pwm->default_state.period = period;
 }
 
 static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
@@ -137,7 +140,7 @@ static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
 
 static inline unsigned int pwm_get_default_period(const struct pwm_device *pwm)
 {
-	return pwm_get_period(pwm);
+	return pwm ? pwm->default_state.period : 0;
 }
 
 static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
@@ -159,7 +162,8 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity);
 static inline void pwm_set_default_polarity(struct pwm_device *pwm,
 					    enum pwm_polarity polarity)
 {
-	pwm_set_polarity(pwm, polarity);
+	if (pwm)
+		pwm->default_state.polarity = polarity;
 }
 
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
-- 
1.9.1


From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 21 Sep 2015 09:33:20 +0000
Subject: [PATCH v3 03/12] pwm: move the enabled/disabled info to pwm_state struct
Message-Id: <1442828009-6241-4-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Prepare the transition to PWM atomic update by moving the enabled/disabled
state into the pwm_state struct. This way we can easily update the whole
PWM state by copying the new state in the ->state field.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c  | 15 ++++++++++++---
 include/linux/pwm.h |  7 ++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 09037de..963238c3 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -494,8 +494,15 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
  */
 int pwm_enable(struct pwm_device *pwm)
 {
-	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
-		return pwm->chip->ops->enable(pwm->chip, pwm);
+	if (pwm && !pwm_is_enabled(pwm)) {
+		int err;
+
+		err = pwm->chip->ops->enable(pwm->chip, pwm);
+		if (!err)
+			pwm->state.enabled = true;
+
+		return err;
+	}
 
 	return pwm ? 0 : -EINVAL;
 }
@@ -507,8 +514,10 @@ EXPORT_SYMBOL_GPL(pwm_enable);
  */
 void pwm_disable(struct pwm_device *pwm)
 {
-	if (pwm && test_and_clear_bit(PWMF_ENABLED, &pwm->flags))
+	if (pwm && pwm_is_enabled(pwm)) {
 		pwm->chip->ops->disable(pwm->chip, pwm);
+		pwm->state.enabled = false;
+	}
 }
 EXPORT_SYMBOL_GPL(pwm_disable);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e0e0ed8..433a097 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -75,8 +75,7 @@ enum pwm_polarity {
 
 enum {
 	PWMF_REQUESTED = 1 << 0,
-	PWMF_ENABLED = 1 << 1,
-	PWMF_EXPORTED = 1 << 2,
+	PWMF_EXPORTED = 1 << 1,
 };
 
 /*
@@ -84,11 +83,13 @@ enum {
  * @period: PWM period (in nanoseconds)
  * @duty_cycle: PWM duty cycle (in nanoseconds)
  * @polarity: PWM polarity
+ * @enabled: PWM enabled status
  */
 struct pwm_state {
 	unsigned int period;
 	unsigned int duty_cycle;
 	enum pwm_polarity polarity;
+	bool enabled;
 };
 
 /**
@@ -114,7 +115,7 @@ struct pwm_device {
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 {
-	return test_bit(PWMF_ENABLED, &pwm->flags);
+	return pwm->state.enabled;
 }
 
 static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
-- 
1.9.1


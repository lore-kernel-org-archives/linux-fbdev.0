From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:39 +0000
Subject: [PATCH v4 16/24] pwm: move the enabled/disabled info to pwm_state struct
Message-Id: <1447664207-24370-17-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Prepare the transition to PWM atomic update by moving the enabled/disabled
state into the pwm_state struct. This way we can easily update the whole
PWM state by copying the new state in the ->state field.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pwm/core.c  | 17 +++++++++++++----
 include/linux/pwm.h |  7 ++++---
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index f1c6769..6bbda6c 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -508,10 +508,10 @@ int pwm_enable(struct pwm_device *pwm)
 
 	mutex_lock(&pwm->lock);
 
-	if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
+	if (!pwm_is_enabled(pwm)) {
 		err = pwm->chip->ops->enable(pwm->chip, pwm);
-		if (err)
-			clear_bit(PWMF_ENABLED, &pwm->flags);
+		if (!err)
+			pwm->state.enabled = true;
 	}
 
 	mutex_unlock(&pwm->lock);
@@ -526,8 +526,17 @@ EXPORT_SYMBOL_GPL(pwm_enable);
  */
 void pwm_disable(struct pwm_device *pwm)
 {
-	if (pwm && test_and_clear_bit(PWMF_ENABLED, &pwm->flags))
+	if (!pwm)
+		return;
+
+	mutex_lock(&pwm->lock);
+
+	if (pwm_is_enabled(pwm)) {
 		pwm->chip->ops->disable(pwm->chip, pwm);
+		pwm->state.enabled = false;
+	}
+
+	mutex_unlock(&pwm->lock);
 }
 EXPORT_SYMBOL_GPL(pwm_disable);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index af42299..398c58c 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -76,8 +76,7 @@ enum pwm_polarity {
 
 enum {
 	PWMF_REQUESTED = 1 << 0,
-	PWMF_ENABLED = 1 << 1,
-	PWMF_EXPORTED = 1 << 2,
+	PWMF_EXPORTED = 1 << 1,
 };
 
 /*
@@ -85,11 +84,13 @@ enum {
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
@@ -117,7 +118,7 @@ struct pwm_device {
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 {
-	return test_bit(PWMF_ENABLED, &pwm->flags);
+	return pwm->state.enabled;
 }
 
 static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
-- 
2.1.4


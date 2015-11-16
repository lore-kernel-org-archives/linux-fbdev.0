From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:29 +0000
Subject: [PATCH v4 06/24] pwm: introduce default period and polarity concepts
Message-Id: <1447664207-24370-7-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

When requested by a user, the PWM is assigned a default period and polarity
extracted from the DT, the platform data or statically set by the driver.
Those default values are currently stored in the period and polarity
fields of the pwm_device struct, but they will be stored somewhere else
once we have introduced the architecture allowing for hardware state
retrieval.

The pwm_set_default_polarity and pwm_set_default_period should only be
used by PWM drivers or the PWM core infrastructure to specify the
default period and polarity values.

PWM users might call the pwm_get_default_period to query the default
period value. There is currently no helper to query the default
polarity, but it might be added later on if there is a need for it.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 include/linux/pwm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index cfc3ed4..8ba57fc 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -118,11 +118,22 @@ static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 		pwm->period = period;
 }
 
+static inline void pwm_set_default_period(struct pwm_device *pwm,
+					  unsigned int period)
+{
+	pwm_set_period(pwm, period);
+}
+
 static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
 {
 	return pwm ? pwm->period : 0;
 }
 
+static inline unsigned int pwm_get_default_period(const struct pwm_device *pwm)
+{
+	return pwm_get_period(pwm);
+}
+
 static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
 {
 	if (pwm)
@@ -139,6 +150,12 @@ static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *pwm)
  */
 int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity);
 
+static inline void pwm_set_default_polarity(struct pwm_device *pwm,
+					    enum pwm_polarity polarity)
+{
+	pwm_set_polarity(pwm, polarity);
+}
+
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 {
 	return pwm ? pwm->polarity : PWM_POLARITY_NORMAL;
-- 
2.1.4


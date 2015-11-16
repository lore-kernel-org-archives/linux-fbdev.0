From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:41 +0000
Subject: [PATCH v4 18/24] pwm: declare a default PWM state
Message-Id: <1447664207-24370-19-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
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
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 include/linux/pwm.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 398c58c..292e7da 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -103,6 +103,7 @@ struct pwm_state {
  * @chip_data: chip-private data associated with the PWM device
  * @lock: used to serialize accesses to the PWM device where necessary
  * @state: curent PWM channel state
+ * @default_state: default PWM channel state
  */
 struct pwm_device {
 	const char *label;
@@ -114,6 +115,7 @@ struct pwm_device {
 	struct mutex lock;
 
 	struct pwm_state state;
+	struct pwm_state default_state;
 };
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
@@ -130,7 +132,8 @@ static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 static inline void pwm_set_default_period(struct pwm_device *pwm,
 					  unsigned int period)
 {
-	pwm_set_period(pwm, period);
+	if (pwm)
+		pwm->default_state.period = period;
 }
 
 static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
@@ -140,7 +143,7 @@ static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
 
 static inline unsigned int pwm_get_default_period(const struct pwm_device *pwm)
 {
-	return pwm_get_period(pwm);
+	return pwm ? pwm->default_state.period : 0;
 }
 
 static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
@@ -162,7 +165,8 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity);
 static inline void pwm_set_default_polarity(struct pwm_device *pwm,
 					    enum pwm_polarity polarity)
 {
-	pwm_set_polarity(pwm, polarity);
+	if (pwm)
+		pwm->default_state.polarity = polarity;
 }
 
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
-- 
2.1.4


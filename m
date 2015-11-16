From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:28 +0000
Subject: [PATCH v4 05/24] misc: max77693-haptic: use pwm_get_xxx() helpers where appropriate
Message-Id: <1447664207-24370-6-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use pwm_get_xxx() helpers instead of directly accessing the pwm->xxx field.
Doing that will ease adaptation of the PWM framework to support atomic
update.

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
+pwm_set_polarity((p), e);
|
-(p)->polarity
+pwm_get_polarity((p))
|
-(p)->period = e;
+pwm_set_period((p), e);
|
-(p)->period
+pwm_get_period((p))
|
-(p)->duty_cycle = e;
+pwm_set_duty_cycle((p), e);
|
-(p)->duty_cycle
+pwm_get_duty_cycle((p))
)
--->8---
---
 drivers/input/misc/max77693-haptic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 6d96bff..a038fb3 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -70,10 +70,11 @@ struct max77693_haptic {
 
 static int max77693_haptic_set_duty_cycle(struct max77693_haptic *haptic)
 {
-	int delta = (haptic->pwm_dev->period + haptic->pwm_duty) / 2;
+	int delta = (pwm_get_period((haptic->pwm_dev)) + haptic->pwm_duty) / 2;
 	int error;
 
-	error = pwm_config(haptic->pwm_dev, delta, haptic->pwm_dev->period);
+	error = pwm_config(haptic->pwm_dev, delta,
+			   pwm_get_period((haptic->pwm_dev)));
 	if (error) {
 		dev_err(haptic->dev, "failed to configure pwm: %d\n", error);
 		return error;
@@ -245,7 +246,7 @@ static int max77693_haptic_play_effect(struct input_dev *dev, void *data,
 	 * The formula to convert magnitude to pwm_duty as follows:
 	 * - pwm_duty = (magnitude * pwm_period) / MAX_MAGNITUDE(0xFFFF)
 	 */
-	period_mag_multi = (u64)haptic->pwm_dev->period * haptic->magnitude;
+	period_mag_multi = (u64)pwm_get_period((haptic->pwm_dev)) * haptic->magnitude;
 	haptic->pwm_duty = (unsigned int)(period_mag_multi >>
 						MAX_MAGNITUDE_SHIFT);
 
-- 
2.1.4


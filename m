From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:35 +0000
Subject: [PATCH v4 12/24] misc: max77693: use pwm_get/set_default_xxx() helpers where appropriate
Message-Id: <1447664207-24370-13-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

pwm_set/get_default_xxx() helpers have been introduced to differentiate
the default PWM states (those retrieved through DT, PWM lookup table or
statically assigned by the driver) and the current ones.
Make use of those helpers where appropriate.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/input/misc/max77693-haptic.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index a038fb3..89f5055 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -70,11 +70,12 @@ struct max77693_haptic {
 
 static int max77693_haptic_set_duty_cycle(struct max77693_haptic *haptic)
 {
-	int delta = (pwm_get_period((haptic->pwm_dev)) + haptic->pwm_duty) / 2;
+	int delta = (pwm_get_default_period((haptic->pwm_dev)) +
+		     haptic->pwm_duty) / 2;
 	int error;
 
 	error = pwm_config(haptic->pwm_dev, delta,
-			   pwm_get_period((haptic->pwm_dev)));
+			   pwm_get_default_period((haptic->pwm_dev)));
 	if (error) {
 		dev_err(haptic->dev, "failed to configure pwm: %d\n", error);
 		return error;
@@ -246,7 +247,8 @@ static int max77693_haptic_play_effect(struct input_dev *dev, void *data,
 	 * The formula to convert magnitude to pwm_duty as follows:
 	 * - pwm_duty = (magnitude * pwm_period) / MAX_MAGNITUDE(0xFFFF)
 	 */
-	period_mag_multi = (u64)pwm_get_period((haptic->pwm_dev)) * haptic->magnitude;
+	period_mag_multi = (u64)pwm_get_default_period((haptic->pwm_dev)) *
+			   haptic->magnitude;
 	haptic->pwm_duty = (unsigned int)(period_mag_multi >>
 						MAX_MAGNITUDE_SHIFT);
 
-- 
2.1.4


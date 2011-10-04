From: Inki Dae <inki.dae@samsung.com>
Date: Tue, 04 Oct 2011 10:32:44 +0000
Subject: [RESEND][PATCH v2 1/2] lcd: add callbacks for early fb event blank
Message-Id: <1317724364-28443-1-git-send-email-inki.dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

this patch adds early_set_power and r_early_set_power callbacks.
early_set_power callback is called prior to fb_blank() of fbmem.c and
r_early_set_power callback is called if fb_blank() was failed to
revert the effects of the early_set_power call of lcd panel driver.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/backlight/lcd.c |   10 ++++++++++
 include/linux/lcd.h           |   10 ++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index 71a11ca..7a03b6c 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -32,6 +32,8 @@ static int fb_notifier_callback(struct notifier_block *self,
 	case FB_EVENT_BLANK:
 	case FB_EVENT_MODE_CHANGE:
 	case FB_EVENT_MODE_CHANGE_ALL:
+	case FB_EARLY_EVENT_BLANK:
+	case FB_R_EARLY_EVENT_BLANK:
 		break;
 	default:
 		return 0;
@@ -46,6 +48,14 @@ static int fb_notifier_callback(struct notifier_block *self,
 		if (event = FB_EVENT_BLANK) {
 			if (ld->ops->set_power)
 				ld->ops->set_power(ld, *(int *)evdata->data);
+		} else if (event = FB_EARLY_EVENT_BLANK) {
+			if (ld->ops->early_set_power)
+				ld->ops->early_set_power(ld,
+						*(int *)evdata->data);
+		} else if (event = FB_R_EARLY_EVENT_BLANK) {
+			if (ld->ops->r_early_set_power)
+				ld->ops->r_early_set_power(ld,
+						*(int *)evdata->data);
 		} else {
 			if (ld->ops->set_mode)
 				ld->ops->set_mode(ld, evdata->data);
diff --git a/include/linux/lcd.h b/include/linux/lcd.h
index 8877123..e00c3b0 100644
--- a/include/linux/lcd.h
+++ b/include/linux/lcd.h
@@ -40,6 +40,16 @@ struct lcd_ops {
 	/* Get the LCD panel power status (0: full on, 1..3: controller
 	   power on, flat panel power off, 4: full off), see FB_BLANK_XXX */
 	int (*get_power)(struct lcd_device *);
+	/*
+	 * Enable or disable power to the LCD(0: on; 4: off, see FB_BLANK_XXX)
+	 * and this callback would be called proir to fb driver's callback.
+	 *
+	 * P.S. note that if early_set_power is not NULL then early fb notifier
+	 *	would be registered.
+	 */
+	int (*early_set_power)(struct lcd_device *, int power);
+	/* revert the effects of the early blank event. */
+	int (*r_early_set_power)(struct lcd_device *, int power);
 	/* Enable or disable power to the LCD (0: on; 4: off, see FB_BLANK_XXX) */
 	int (*set_power)(struct lcd_device *, int power);
 	/* Get the current contrast setting (0-max_contrast) */
-- 
1.7.4.1


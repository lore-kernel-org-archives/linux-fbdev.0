From: Sean Paul <seanpaul@chromium.org>
Date: Mon, 11 May 2015 20:32:05 +0000
Subject: [PATCH] backlight/lp855x: Don't clear level on suspend/blank
Message-Id: <1431376325-25741-1-git-send-email-seanpaul@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Don't clear the backlight level when we're going into suspend or
blanking. Instead, just temporarily set the level to 0 so we retain
the value when we resume.

Reported-by: Benson Leung <bleung@chromium.org>
Tested-by: Stephen Barber <smbarber@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/video/backlight/lp855x_bl.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 08ae72f..74daf7c 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -257,21 +257,15 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 static int lp855x_bl_update_status(struct backlight_device *bl)
 {
 	struct lp855x *lp = bl_get_data(bl);
+	int brightness = bl->props.brightness;
 
 	if (bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
-		bl->props.brightness = 0;
+		brightness = 0;
 
-	if (lp->mode = PWM_BASED) {
-		int br = bl->props.brightness;
-		int max_br = bl->props.max_brightness;
-
-		lp855x_pwm_ctrl(lp, br, max_br);
-
-	} else if (lp->mode = REGISTER_BASED) {
-		u8 val = bl->props.brightness;
-
-		lp855x_write_byte(lp, lp->cfg->reg_brightness, val);
-	}
+	if (lp->mode = PWM_BASED)
+		lp855x_pwm_ctrl(lp, brightness, bl->props.max_brightness);
+	else if (lp->mode = REGISTER_BASED)
+		lp855x_write_byte(lp, lp->cfg->reg_brightness, (u8)brightness);
 
 	return 0;
 }
-- 
2.2.0.rc0.207.ga3a616c


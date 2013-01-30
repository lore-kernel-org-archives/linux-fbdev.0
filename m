From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 30 Jan 2013 06:19:15 +0000
Subject: [PATCH] pwm-backlight: handle BL_CORE_FBBLANK state
Message-Id: <1359526755-21145-1-git-send-email-acourbot@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>, Richard Purdie <rpurdie@rpsys.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, gnurou@gmail.com, Alexandre Courbot <acourbot@nvidia.com>

According to include/linux/backlight.h, the fb_blank field is to be
removed and blank status should preferably be set by setting the
BL_CORE_FBBLANK bit of the state field. This patch ensures this
condition is also taken into account when updating the backlight state.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/video/backlight/pwm_bl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 069983c..4af6d13 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -41,10 +41,9 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 	int brightness = bl->props.brightness;
 	int max = bl->props.max_brightness;
 
-	if (bl->props.power != FB_BLANK_UNBLANK)
-		brightness = 0;
-
-	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
+	if (bl->props.power != FB_BLANK_UNBLANK ||
+	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
+	    bl->props.state & BL_CORE_FBBLANK)
 		brightness = 0;
 
 	if (pb->notify)
-- 
1.8.1.2


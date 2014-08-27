From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 27 Aug 2014 19:45:00 +0000
Subject: [PATCH] backlight: generic_bl: Remove unused function
Message-Id: <1409168700-19042-1-git-send-email-festevam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

genericbl_limit_intensity() is exported, but it is never
called anywhere else.

Fix the following sparse warning:

drivers/video/backlight/generic_bl.c:59:6: warning: symbol 'genericbl_limit_intensity' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/video/backlight/generic_bl.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/video/backlight/generic_bl.c b/drivers/video/backlight/generic_bl.c
index 5d8d652..67dfb93 100644
--- a/drivers/video/backlight/generic_bl.c
+++ b/drivers/video/backlight/generic_bl.c
@@ -52,24 +52,6 @@ static int genericbl_get_intensity(struct backlight_device *bd)
 	return genericbl_intensity;
 }
 
-/*
- * Called when the battery is low to limit the backlight intensity.
- * If limit=0 clear any limit, otherwise limit the intensity
- */
-void genericbl_limit_intensity(int limit)
-{
-	struct backlight_device *bd = generic_backlight_device;
-
-	mutex_lock(&bd->ops_lock);
-	if (limit)
-		bd->props.state |= GENERICBL_BATTLOW;
-	else
-		bd->props.state &= ~GENERICBL_BATTLOW;
-	backlight_update_status(generic_backlight_device);
-	mutex_unlock(&bd->ops_lock);
-}
-EXPORT_SYMBOL(genericbl_limit_intensity);
-
 static const struct backlight_ops genericbl_ops = {
 	.options = BL_CORE_SUSPENDRESUME,
 	.get_brightness = genericbl_get_intensity,
-- 
1.9.1


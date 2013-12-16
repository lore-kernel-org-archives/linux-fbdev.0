From: Rashika Kheria <rashika.kheria@gmail.com>
Date: Mon, 16 Dec 2013 11:33:10 +0000
Subject: [PATCH] drivers: video: Remove unused function genericbl_limit_intensity() in generic_bl.c
Message-Id: <20131216112110.GA4849@rashika>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, josh@joshtriplett.org

Removes unused function genericbl_limit_intensity() in
backlight/generic_bl.c.

This eliminates the following warning in backlight/generic_bl.c:
drivers/video/backlight/generic_bl.c:59:6: warning: no previous prototype for ‘genericbl_limit_intensity’ [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
---
 drivers/video/backlight/generic_bl.c |   18 ------------------
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
1.7.9.5


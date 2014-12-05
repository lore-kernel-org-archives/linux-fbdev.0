From: Sean Paul <seanpaul@chromium.org>
Date: Fri, 05 Dec 2014 18:44:29 +0000
Subject: [PATCH 4/4] backlight/lp855x: Remove CONFIG_OF ifdef in favor of Kconfig depends
Message-Id: <1417805069-20441-4-git-send-email-seanpaul@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Now that we've removed all traces of pdata, remove the CONFIG_OF ifdef
from lp855x and instead make the driver depend on OF.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/video/backlight/Kconfig     | 2 +-
 drivers/video/backlight/lp855x_bl.c | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 8d03924..113c8b3 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -384,7 +384,7 @@ config BACKLIGHT_LM3639
 
 config BACKLIGHT_LP855X
 	tristate "Backlight driver for TI LP855X"
-	depends on BACKLIGHT_CLASS_DEVICE && I2C && PWM
+	depends on BACKLIGHT_CLASS_DEVICE && I2C && PWM && OF
 	help
 	  This supports TI LP8550, LP8551, LP8552, LP8553, LP8555, LP8556 and
 	  LP8557 backlight driver.
diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 8b81d8e..3d3b8cf 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -379,7 +379,6 @@ static const struct attribute_group lp855x_attr_group = {
 	.attrs = lp855x_attributes,
 };
 
-#ifdef CONFIG_OF
 static int lp855x_parse_dt(struct lp855x *lp)
 {
 	struct device *dev = lp->dev;
@@ -425,12 +424,6 @@ static int lp855x_parse_dt(struct lp855x *lp)
 
 	return 0;
 }
-#else
-static int lp855x_parse_dt(struct lp855x *lp)
-{
-	return -EINVAL;
-}
-#endif
 
 static int lp855x_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 {
-- 
2.2.0.rc0.207.ga3a616c


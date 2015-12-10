From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Date: Thu, 10 Dec 2015 13:11:44 +0000
Subject: [PATCH 2/5] fbdev: omap2: panel-dpi: simplify gpio setting
Message-Id: <1449753107-11410-2-git-send-email-uwe@kleine-koenig.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

gpiod_set_value_cansleep is a noop when the passed descriptor is NULL.
So there is no need to duplicate the check for NULL; just call the
function unconditionally instead.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
index 06b6e611e4b2..e780fd4f8b46 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
@@ -83,8 +83,7 @@ static int panel_dpi_enable(struct omap_dss_device *dssdev)
 	if (r)
 		return r;
 
-	if (ddata->enable_gpio)
-		gpiod_set_value_cansleep(ddata->enable_gpio, 1);
+	gpiod_set_value_cansleep(ddata->enable_gpio, 1);
 
 	if (gpio_is_valid(ddata->backlight_gpio))
 		gpio_set_value_cansleep(ddata->backlight_gpio, 1);
@@ -105,8 +104,7 @@ static void panel_dpi_disable(struct omap_dss_device *dssdev)
 	if (gpio_is_valid(ddata->backlight_gpio))
 		gpio_set_value_cansleep(ddata->backlight_gpio, 0);
 
-	if (ddata->enable_gpio)
-		gpiod_set_value_cansleep(ddata->enable_gpio, 0);
+	gpiod_set_value_cansleep(ddata->enable_gpio, 0);
 
 	in->ops.dpi->disable(in);
 
-- 
2.6.2


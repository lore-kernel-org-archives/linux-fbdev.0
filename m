From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Date: Thu, 10 Dec 2015 13:11:43 +0000
Subject: [PATCH 1/5] fbdev: omap2: panel-dpi: in .disable first disable backlight then display
Message-Id: <1449753107-11410-1-git-send-email-uwe@kleine-koenig.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

This makes .disable operate in reverse order compared to .enable.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
index f7be3489f744..06b6e611e4b2 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
@@ -102,12 +102,12 @@ static void panel_dpi_disable(struct omap_dss_device *dssdev)
 	if (!omapdss_device_is_enabled(dssdev))
 		return;
 
-	if (ddata->enable_gpio)
-		gpiod_set_value_cansleep(ddata->enable_gpio, 0);
-
 	if (gpio_is_valid(ddata->backlight_gpio))
 		gpio_set_value_cansleep(ddata->backlight_gpio, 0);
 
+	if (ddata->enable_gpio)
+		gpiod_set_value_cansleep(ddata->enable_gpio, 0);
+
 	in->ops.dpi->disable(in);
 
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-- 
2.6.2


From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Date: Thu, 10 Dec 2015 13:11:45 +0000
Subject: [PATCH 3/5] fbdev: omap2: panel-dpi: drop assignment to local variable
Message-Id: <1449753107-11410-3-git-send-email-uwe@kleine-koenig.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The variable gpio is only used to store the return value of
devm_gpiod_get_optional just to assign it to a member of the driver
data.

Get rid of this local variable and assign to driver data directly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
index e780fd4f8b46..1216341a0d19 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
@@ -205,13 +205,11 @@ static int panel_dpi_probe_of(struct platform_device *pdev)
 	int r;
 	struct display_timing timing;
 	struct videomode vm;
-	struct gpio_desc *gpio;
 
-	gpio = devm_gpiod_get_optional(&pdev->dev, "enable", GPIOD_OUT_LOW);
-	if (IS_ERR(gpio))
-		return PTR_ERR(gpio);
-
-	ddata->enable_gpio = gpio;
+	ddata->enable_gpio = devm_gpiod_get_optional(&pdev->dev,
+						     "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(ddata->enable_gpio))
+		return PTR_ERR(ddata->enable_gpio);
 
 	ddata->backlight_gpio = -ENOENT;
 
-- 
2.6.2


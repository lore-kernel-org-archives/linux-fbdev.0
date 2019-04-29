From: Lucas Stach <l.stach@pengutronix.de>
Date: Mon, 29 Apr 2019 15:29:19 +0000
Subject: [PATCH] backlight: rave-sp: don't touch initial state and register with correct device
Message-Id: <20190429152919.27277-1-l.stach@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-fbdev@vger.kernel.org, kernel@pengutronix.de, dri-devel@lists.freedesktop.org, patchwork-lst@pengutronix.de

This way the backlight can be referenced through its device node and
enabling/disabling can be managed through the panel driver.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/video/backlight/rave-sp-backlight.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/backlight/rave-sp-backlight.c b/drivers/video/backlight/rave-sp-backlight.c
index 462f14a1b19d..d296bfcf4396 100644
--- a/drivers/video/backlight/rave-sp-backlight.c
+++ b/drivers/video/backlight/rave-sp-backlight.c
@@ -48,15 +48,13 @@ static int rave_sp_backlight_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct backlight_device *bd;
 
-	bd = devm_backlight_device_register(dev, pdev->name, dev->parent,
+	bd = devm_backlight_device_register(dev, pdev->name, dev,
 					    dev_get_drvdata(dev->parent),
 					    &rave_sp_backlight_ops,
 					    &rave_sp_backlight_props);
 	if (IS_ERR(bd))
 		return PTR_ERR(bd);
 
-	backlight_update_status(bd);
-
 	return 0;
 }
 
-- 
2.20.1

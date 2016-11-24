From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 24 Nov 2016 14:06:56 +0000
Subject: [PATCH] backlight: gpio-backlight: Correct initial power state handling
Message-Id: <20161124140656.27441-1-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jingoohan1@gmail.com, lee.jones@linaro.org
Cc: tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The default-on property - or the def_value via legacy pdata) should be
handled as:
if it is 1, the backlight must be enabled (kept enabled)
if it is 0, the backlight must be disabled (kept disabled)

This only works for the case when default-on is set. If it is not set then
the brightness of the backlight is set to 0. Now if the backlight is
enabled by external driver (graphics) the backlight will stay disabled since
the brightness is configured as 0. The backlight will not turn on.

The correct action at probe time is to configure the props.power to
FB_BLANK_UNBLANK if we want the backlight on by default or to
FB_BLANK_POWERDOWN if the backlight should be off by default.

The initial brightness should be set to 1.
---
 drivers/video/backlight/gpio_backlight.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 18134416b154..8be7d4d194d3 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -138,7 +138,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.brightness = gbl->def_value;
+	bl->props.power = gbl->def_value ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
+	bl->props.brightness = 1;
+
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
2.11.0.rc2


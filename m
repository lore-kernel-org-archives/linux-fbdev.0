From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 08 May 2018 07:04:26 +0000
Subject: [PATCH RESEND] backlight: gpio-backlight: Correct initial power state handling
Message-Id: <20180508070426.32211-1-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

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

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

for some reason the original patch got lost:
https://patchwork.kernel.org/patch/9445539/

But it is still valid, so I'm resending it.

Regards,
Peter

 drivers/video/backlight/gpio_backlight.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index e470da95d806..904a4462cefe 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -142,7 +142,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.brightness = gbl->def_value;
+	bl->props.power = gbl->def_value ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
+	bl->props.brightness = 1;
+
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


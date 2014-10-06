From: Markus Pargmann <mpa@pengutronix.de>
Date: Mon, 06 Oct 2014 19:22:44 +0000
Subject: [PATCH] pwm-backlight: Turn off pwm backlight in probe
Message-Id: <1412623364-14583-1-git-send-email-mpa@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The backlight will be enabled by the panel again if it is used. So we
can save the default brightness and disable the pwm backlight when
probing.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/video/backlight/pwm_bl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 336b83be7e2d..b4f433a6f106 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -317,9 +317,11 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		data->dft_brightness = data->max_brightness;
 	}
 
-	bl->props.brightness = data->dft_brightness;
+	bl->props.brightness = 0;
 	backlight_update_status(bl);
 
+	bl->props.brightness = data->dft_brightness;
+
 	platform_set_drvdata(pdev, bl);
 	return 0;
 
-- 
2.1.0


From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 22 Jan 2013 13:39:54 +0000
Subject: [PATCH 2/4] pwm_backlight: Validate dft_brightness in main probe function
Message-Id: <1358861996-27194-3-git-send-email-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358861996-27194-1-git-send-email-peter.ujfalusi@ti.com>
In-Reply-To: <1358861996-27194-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

Move the dft_brightness validity check from the DT parsing function to the
main probe. In this way we can validate it in case we are booting with or
without DT.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/video/backlight/pwm_bl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index f0d6854..2a81c24 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -135,12 +135,6 @@ static int pwm_backlight_parse_dt(struct device *dev,
 		if (ret < 0)
 			return ret;
 
-		if (value >= data->max_brightness) {
-			dev_warn(dev, "invalid default brightness level: %u, using %u\n",
-				 value, data->max_brightness - 1);
-			value = data->max_brightness - 1;
-		}
-
 		data->dft_brightness = value;
 	}
 
@@ -249,6 +243,12 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
+	if (data->dft_brightness > data->max_brightness) {
+		dev_warn(&pdev->dev,
+			 "invalid default brightness level: %u, using %u\n",
+			 data->dft_brightness, data->max_brightness);
+		data->dft_brightness = data->max_brightness;
+	}
 	bl->props.brightness = data->dft_brightness;
 	backlight_update_status(bl);
 
-- 
1.8.1.1


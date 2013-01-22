From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 22 Jan 2013 13:39:53 +0000
Subject: [PATCH 1/4] pwm_backlight: Fix PWM levels support in non DT case
Message-Id: <1358861996-27194-2-git-send-email-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358861996-27194-1-git-send-email-peter.ujfalusi@ti.com>
In-Reply-To: <1358861996-27194-1-git-send-email-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Thierry Reding <thierry.reding@avionic-design.de>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

It is expected that board files would have:
static unsigned int bl_levels[] = { 0, 50, 100, 150, 200, 250, };

static struct platform_pwm_backlight_data bl_data = {
	.levels = bl_levels,
	.max_brightness = ARRAY_SIZE(bl_levels),
	.dft_brightness = 4,
	.pwm_period_ns = 7812500,
};

In this case the max_brightness would be out of range in the levels array.
Decrement the received max_brightness in every case (DT or non DT) when the
levels has been provided.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/video/backlight/pwm_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 069983c..f0d6854 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -142,7 +142,6 @@ static int pwm_backlight_parse_dt(struct device *dev,
 		}
 
 		data->dft_brightness = value;
-		data->max_brightness--;
 	}
 
 	/*
@@ -202,6 +201,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	}
 
 	if (data->levels) {
+		data->max_brightness--;
 		max = data->levels[data->max_brightness];
 		pb->levels = data->levels;
 	} else
-- 
1.8.1.1


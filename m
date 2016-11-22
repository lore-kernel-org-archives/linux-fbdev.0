From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 22 Nov 2016 13:41:23 +0000
Subject: [PATCH v4 2/2] backlight: pwm_bl: Check the PWM state for initial backlight power state
Message-Id: <20161122134123.1209-3-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161122134123.1209-1-peter.ujfalusi@ti.com>
In-Reply-To: <20161122134123.1209-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thierry.reding@gmail.com, lee.jones@linaro.org
Cc: tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de

If the PWM is not enabled the backlight initially should not be enabled
either if we have booted with DT and there is a phandle pointing to the
backlight node.

The patch extends the checks to decide if we should keep the backlight off
initially.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
 drivers/video/backlight/pwm_bl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 5712ddd053dd..d7efcb632f7d 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -215,6 +215,10 @@ static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
 	if (!regulator_is_enabled(pb->power_supply))
 		return FB_BLANK_POWERDOWN;
 
+	/* The PWM is disabled, keep it like this */
+	if (!pwm_is_enabled(pb->pwm))
+		return FB_BLANK_POWERDOWN;
+
 	return FB_BLANK_UNBLANK;
 }
 
-- 
2.11.0.rc2


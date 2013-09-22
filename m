From: Mike Dunn <mikedunn@newsguy.com>
Date: Sun, 22 Sep 2013 16:59:56 +0000
Subject: [PATCH v2] pwm-backlight: allow for non-increasing brightness levels
Message-Id: <1379869196-19377-1-git-send-email-mikedunn@newsguy.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Mike Dunn <mikedunn-kFrNdAxtuftBDgjK7y7TUQ@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Currently the driver assumes that the values specified in the
brightness-levels device tree property increase as they are parsed from
left to right.  But boards that invert the signal between the PWM output
and the backlight will need to specify decreasing brightness-levels.
This patch removes the assumption that the last element of the array is
the maximum value, and instead searches the array for the maximum value
and uses that in the duty cycle calculation.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
Changelog:
v2: 
- commit message reworded; correct line wrap used
- 'max_level' variable renamed to 'scale'
- loop counter variable type changed to unsigned int
- value held in scale changed from array index to actual maximum level
- blank lines added around loop for readability

 drivers/video/backlight/pwm_bl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 1fea627..5e99b88 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -27,6 +27,7 @@ struct pwm_bl_data {
 	unsigned int		period;
 	unsigned int		lth_brightness;
 	unsigned int		*levels;
+	unsigned int		scale;
 	int			(*notify)(struct device *,
 					  int brightness);
 	void			(*notify_after)(struct device *,
@@ -57,7 +58,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 
 		if (pb->levels) {
 			duty_cycle = pb->levels[brightness];
-			max = pb->levels[max];
+			max = pb->scale;
 		} else {
 			duty_cycle = brightness;
 		}
@@ -195,7 +196,14 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	}
 
 	if (data->levels) {
-		max = data->levels[data->max_brightness];
+		unsigned int i;
+
+		for (i = 0; i <= data->max_brightness; i++) {
+			if (data->levels[i] > pb->scale)
+				pb->scale = data->levels[i];
+		}
+
+		max = pb->scale;
 		pb->levels = data->levels;
 	} else
 		max = data->max_brightness;
-- 
1.8.1.5


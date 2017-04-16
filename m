From: Paul Kocialkowski <contact@paulk.fr>
Date: Sun, 16 Apr 2017 10:35:46 +0000
Subject: [PATCH] backlight: pwm_bl: Fix condition to set enable gpio as output
Message-Id: <20170416103546.3021-1-contact@paulk.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>

The move to a dedicated pwm_backlight_initial_power_state function in
commit 7613c922315e308a6486d802abed2eb74443dffd modified the condition
to set the enable gpio as output. This breaks specific use cases using
that GPIO, such as tegra124-based nyan Chromebooks where backlight
stopped working.

This puts the condition back to the way it was before the move.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/video/backlight/pwm_bl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index d7efcb632f7d..e81b2b55be2b 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -304,7 +304,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	 * early. Leave the decision of the initial backlight state for later.
 	 */
 	if (pb->enable_gpio &&
-	    gpiod_get_direction(pb->enable_gpio) = GPIOF_DIR_IN)
+	   (gpiod_get_direction(pb->enable_gpio) = GPIOF_DIR_IN ||
+	    gpiod_get_value(pb->enable_gpio) != 0))
 		gpiod_direction_output(pb->enable_gpio, 1);
 
 	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
-- 
2.12.2


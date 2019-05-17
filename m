From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Date: Fri, 17 May 2019 15:05:46 +0000
Subject: [PATCH] backlight: gpio-backlight: Set power state instead of brightness at probe
Message-Id: <20190517150546.4508-1-paul.kocialkowski@bootlin.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>

On a trivial gpio-backlight setup with a panel using the backlight but
no boot software to enable it beforehand, we fall in a case where the
backlight is disabled (not just blanked) and thus remains disabled when
the panel gets enabled.

Setting gbl->def_value via the device-tree prop allows enabling the
backlight in this situation, but it will be unblanked straight away,
in compliance with the binding. This does not work well when there was no
boot software to display something before, since we really need to unblank
by the time the panel is enabled, not before.

Resolve the situation by setting the brightness to 1 at probe and
managing the power state accordingly, a bit like it's done in
pwm-backlight.

Fixes: 8b770e3c9824 ("backlight: Add GPIO-based backlight driver")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/video/backlight/gpio_backlight.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index e470da95d806..c9cb97fa13d0 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -57,6 +57,21 @@ static const struct backlight_ops gpio_backlight_ops = {
 	.check_fb	= gpio_backlight_check_fb,
 };
 
+static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
+{
+	struct device_node *node = gbl->dev->of_node;
+
+	/* If we absolutely want the backlight enabled at boot. */
+	if (gbl->def_value)
+		return FB_BLANK_UNBLANK;
+
+	/* If there's no panel to unblank the backlight later. */
+	if (!node || !node->phandle)
+		return FB_BLANK_UNBLANK;
+
+	return FB_BLANK_POWERDOWN;
+}
+
 static int gpio_backlight_probe_dt(struct platform_device *pdev,
 				   struct gpio_backlight *gbl)
 {
@@ -142,7 +157,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.brightness = gbl->def_value;
+	bl->props.brightness = 1;
+	bl->props.power = gpio_backlight_initial_power_state(gbl);
+
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
2.21.0

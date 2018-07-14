From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 14 Jul 2018 20:56:15 +0000
Subject: [PATCH 1/1] atmel_lcdfb: support native-mode display-timings
Message-Id: <20180714205615.GA21579@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

From 8aded81852666b591624001ec02aa4dc0d8f4cfb Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 14 Jul 2018 22:17:18 +0200
Subject: [PATCH 1/1] atmel_lcdfb: support native-mode display-timings

When a device tree set a display-timing using native-mode
then according to the bindings doc this should:

    native-mode:
    The native mode for the display, in case multiple
    modes are provided.
    When omitted, assume the first node is the native.

The atmel_lcdfb used the last timing subnode and did not
respect the timing mode specified with native-mode.

Introduce use of of_get_videomode() which allowed
a nice simplification of the code while also
added support for native-mode.

As a nice side-effect this fixes a memory leak where the
data used for timings and the display_np was not freed.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

Tested on a proprietary board utilizing an at91sam9263.
Problem was found because I uses the bootloader to
set the native-mode depending on the mounted display.

Please note - I may have missed some magic around selecting
the correct videomode.
The patch was to some extend based on what was done in
the mxsfb driver.

I am away a few days after sunday, but decided to send
out the patch in order to collect potential review feedback.

        Sam

 drivers/video/fbdev/atmel_lcdfb.c | 43 ++++++++---------------------------=
----
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_=
lcdfb.c
index 076d24afbd72..4ed55e6bbb84 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <video/of_videomode.h>
 #include <video/of_display_timing.h>
 #include <linux/regulator/consumer.h>
 #include <video/videomode.h>
@@ -1028,11 +1029,11 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_i=
nfo *sinfo)
 	struct device *dev =3D &sinfo->pdev->dev;
 	struct device_node *np =DEv->of_node;
 	struct device_node *display_np;
-	struct device_node *timings_np;
-	struct display_timings *timings;
 	struct atmel_lcdfb_power_ctrl_gpio *og;
 	bool is_gpio_power =3D false;
+	struct fb_videomode fb_vm;
 	struct gpio_desc *gpiod;
+	struct videomode vm;
 	int ret =3D -ENOENT;
 	int i;
=20
@@ -1105,44 +1106,18 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_i=
nfo *sinfo)
 	pdata->lcdcon_is_backlight =3D of_property_read_bool(display_np, "atmel,l=
cdcon-backlight");
 	pdata->lcdcon_pol_negative =3D of_property_read_bool(display_np, "atmel,l=
cdcon-backlight-inverted");
=20
-	timings =3D of_get_display_timings(display_np);
-	if (!timings) {
-		dev_err(dev, "failed to get display timings\n");
-		ret =3D -EINVAL;
+	ret =3D of_get_videomode(display_np, &vm, OF_USE_NATIVE_MODE);
+	if (ret) {
+		dev_err(dev, "failed to get videomode from DT\n");
 		goto put_display_node;
 	}
=20
-	timings_np =3D of_get_child_by_name(display_np, "display-timings");
-	if (!timings_np) {
-		dev_err(dev, "failed to find display-timings node\n");
-		ret =3D -ENODEV;
+	ret =3D fb_videomode_from_videomode(&vm, &fb_vm);
+	if (ret < 0)
 		goto put_display_node;
-	}
=20
-	for (i =3D 0; i < of_get_child_count(timings_np); i++) {
-		struct videomode vm;
-		struct fb_videomode fb_vm;
-
-		ret =3D videomode_from_timings(timings, &vm, i);
-		if (ret < 0)
-			goto put_timings_node;
-		ret =3D fb_videomode_from_videomode(&vm, &fb_vm);
-		if (ret < 0)
-			goto put_timings_node;
-
-		fb_add_videomode(&fb_vm, &info->modelist);
-	}
-
-	/*
-	 * FIXME: Make sure we are not referencing any fields in display_np
-	 * and timings_np and drop our references to them before returning to
-	 * avoid leaking the nodes on probe deferral and driver unbind.
-	 */
-
-	return 0;
+	fb_add_videomode(&fb_vm, &info->modelist);
=20
-put_timings_node:
-	of_node_put(timings_np);
 put_display_node:
 	of_node_put(display_np);
 	return ret;
--=20
2.12.0


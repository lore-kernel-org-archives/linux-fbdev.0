From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 06 Nov 2017 18:14:22 +0000
Subject: [PATCH v2] video: atmel_lcdfb: Use unique error messages in atmel_lcdfb_of_init()
Message-Id: <a768c806-8c15-5d74-02ac-38724482ac67@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2db677d2-ad4e-1f79-344b-dfa38ce948c9@users.sourceforge.net>
 <5477205e-2067-de4f-8736-71a2c9dc1653@microchip.com>
 <8d297cae-5dd1-d345-8d9d-9bf3ec32d4f8@users.sourceforge.net>
 <2d650d87-034c-d05b-b3aa-f689f25ab184@microchip.com>
In-Reply-To: <2d650d87-034c-d05b-b3aa-f689f25ab184@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 6 Nov 2017 19:00:58 +0100

A duplicate error message was used so far in this function implementation.
Thus use a consistent message format instead together with property names
where constant merging can be applied by the compiler in four cases.

This issue was detected by using the Coccinelle software.


This software update supersedes the suggestion "video: atmel_lcdfb:
Use common error handling code in atmel_lcdfb_of_init()" from 2017-11-05.
https://patchwork.kernel.org/patch/10042131/

Fixes: b985172b328abc6de495a87ab998b267c5a09c16 ("video: atmel_lcdfb: add device tree suport")

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/atmel_lcdfb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index e06358da4b99..44146aec3596 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1021,6 +1021,8 @@ static void atmel_lcdfb_power_control_gpio(struct atmel_lcdfb_pdata *pdata, int
 		gpio_set_value(og->gpio, on);
 }
 
+static char const property_failure[] = "failed to get property %s\n";
+
 static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 {
 	struct fb_info *info = sinfo->info;
@@ -1048,25 +1050,25 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 
 	ret = of_property_read_u32(display_np, "bits-per-pixel", &var->bits_per_pixel);
 	if (ret < 0) {
-		dev_err(dev, "failed to get property bits-per-pixel\n");
+		dev_err(dev, property_failure, "bits-per-pixel");
 		goto put_display_node;
 	}
 
 	ret = of_property_read_u32(display_np, "atmel,guard-time", &pdata->guard_time);
 	if (ret < 0) {
-		dev_err(dev, "failed to get property atmel,guard-time\n");
+		dev_err(dev, property_failure, "atmel,guard-time");
 		goto put_display_node;
 	}
 
 	ret = of_property_read_u32(display_np, "atmel,lcdcon2", &pdata->default_lcdcon2);
 	if (ret < 0) {
-		dev_err(dev, "failed to get property atmel,lcdcon2\n");
+		dev_err(dev, property_failure, "atmel,lcdcon2");
 		goto put_display_node;
 	}
 
 	ret = of_property_read_u32(display_np, "atmel,dmacon", &pdata->default_dmacon);
 	if (ret < 0) {
-		dev_err(dev, "failed to get property bits-per-pixel\n");
+		dev_err(dev, property_failure, "atmel,dmacon");
 		goto put_display_node;
 	}
 
-- 
2.15.0


From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 26 Jan 2012 10:32:34 +0000
Subject: [PATCH] video: use gpio_request_one
Message-Id: <000d01ccdc15$d0e2a500$72a7ef00$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Using gpio_request_one can make the code simpler because it can
set the direction and initial value in one shot.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/bf537-lq035.c                        |   12 +++---------
 drivers/video/bf54x-lq043fb.c                      |    4 +---
 drivers/video/bfin-lq035q1-fb.c                    |    8 ++++----
 drivers/video/bfin_adv7393fb.c                     |    5 +++--
 drivers/video/msm/mddi_client_nt35399.c            |    7 +------
 drivers/video/msm/mddi_client_toshiba.c            |    7 +------
 drivers/video/omap/lcd_inn1610.c                   |   10 ++++------
 drivers/video/omap2/displays/panel-taal.c          |    4 +---
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |   11 ++---------
 9 files changed, 20 insertions(+), 48 deletions(-)

diff --git a/drivers/video/bf537-lq035.c b/drivers/video/bf537-lq035.c
index bea53c1..befbc80 100644
--- a/drivers/video/bf537-lq035.c
+++ b/drivers/video/bf537-lq035.c
@@ -383,23 +383,19 @@ static int __devinit request_ports(void)
 	}
 
 #if (defined(UD) && defined(LBR))
-	if (gpio_request(UD, KBUILD_MODNAME)) {
+	if (gpio_request_one(UD, GPIOF_OUT_INIT_LOW, KBUILD_MODNAME)) {
 		pr_err("requesting GPIO %d failed\n", UD);
 		return -EBUSY;
 	}
 
-	if (gpio_request(LBR, KBUILD_MODNAME)) {
+	if (gpio_request_one(LBR, GPIOF_OUT_INIT_HIGH, KBUILD_MODNAME)) {
 		pr_err("requesting GPIO %d failed\n", LBR);
 		gpio_free(UD);
 		return -EBUSY;
 	}
-
-	gpio_direction_output(UD, 0);
-	gpio_direction_output(LBR, 1);
-
 #endif
 
-	if (gpio_request(MOD, KBUILD_MODNAME)) {
+	if (gpio_request_one(MOD, GPIOF_OUT_INIT_HIGH, KBUILD_MODNAME)) {
 		pr_err("requesting GPIO %d failed\n", MOD);
 #if (defined(UD) && defined(LBR))
 		gpio_free(LBR);
@@ -408,8 +404,6 @@ static int __devinit request_ports(void)
 		return -EBUSY;
 	}
 
-	gpio_direction_output(MOD, 1);
-
 	SSYNC();
 	return 0;
 }
diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index 46b03f5..dc2f004 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -240,7 +240,7 @@ static int request_ports(struct bfin_bf54xfb_info *fbi)
 	u16 eppi_req_18[] = EPPI0_18;
 	u16 disp = fbi->mach_info->disp;
 
-	if (gpio_request(disp, DRIVER_NAME)) {
+	if (gpio_request_one(disp, GPIOF_OUT_INIT_HIGH, DRIVER_NAME)) {
 		printk(KERN_ERR "Requesting GPIO %d failed\n", disp);
 		return -EFAULT;
 	}
@@ -263,8 +263,6 @@ static int request_ports(struct bfin_bf54xfb_info *fbi)
 		}
 	}
 
-	gpio_direction_output(disp, 1);
-
 	return 0;
 }
 
diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
index c633068..86922ac 100644
--- a/drivers/video/bfin-lq035q1-fb.c
+++ b/drivers/video/bfin-lq035q1-fb.c
@@ -365,10 +365,10 @@ static int __devinit bfin_lq035q1_request_ports(struct platform_device *pdev,
 	 * Drive PPI_FS3 Low
 	 */
 	if (ANOMALY_05000400) {
-		int ret = gpio_request(P_IDENT(P_PPI0_FS3), "PPI_FS3");
+		int ret = gpio_request_one(P_IDENT(P_PPI0_FS3),
+					GPIOF_OUT_INIT_LOW, "PPI_FS3");
 		if (ret)
 			return ret;
-		gpio_direction_output(P_IDENT(P_PPI0_FS3), 0);
 	}
 
 	if (ppi16)
@@ -716,14 +716,14 @@ static int __devinit bfin_lq035q1_probe(struct platform_device *pdev)
 	}
 
 	if (info->disp_info->use_bl) {
-		ret = gpio_request(info->disp_info->gpio_bl, "LQ035 Backlight");
+		ret = gpio_request_one(info->disp_info->gpio_bl,
+					GPIOF_OUT_INIT_LOW, "LQ035 Backlight");
 
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request GPIO %d\n",
 				info->disp_info->gpio_bl);
 			goto out9;
 		}
-		gpio_direction_output(info->disp_info->gpio_bl, 0);
 	}
 
 	ret = register_framebuffer(fbinfo);
diff --git a/drivers/video/bfin_adv7393fb.c b/drivers/video/bfin_adv7393fb.c
index 811dd7f..c992814 100644
--- a/drivers/video/bfin_adv7393fb.c
+++ b/drivers/video/bfin_adv7393fb.c
@@ -411,12 +411,13 @@ static int __devinit bfin_adv7393_fb_probe(struct i2c_client *client,
 
 	/* Workaround "PPI Does Not Start Properly In Specific Mode" */
 	if (ANOMALY_05000400) {
-		if (gpio_request(P_IDENT(P_PPI0_FS3), "PPI0_FS3")) {
+		ret = gpio_request_one(P_IDENT(P_PPI0_FS3), GPIOF_OUT_INIT_LOW,
+					"PPI0_FS3")
+		if (ret) {
 			dev_err(&client->dev, "PPI0_FS3 GPIO request failed\n");
 			ret = -EBUSY;
 			goto out_8;
 		}
-		gpio_direction_output(P_IDENT(P_PPI0_FS3), 0);
 	}
 
 	if (peripheral_request_list(ppi_pins, DRIVER_NAME)) {
diff --git a/drivers/video/msm/mddi_client_nt35399.c b/drivers/video/msm/mddi_client_nt35399.c
index f239f4a..7fcd67e 100644
--- a/drivers/video/msm/mddi_client_nt35399.c
+++ b/drivers/video/msm/mddi_client_nt35399.c
@@ -155,14 +155,10 @@ static int setup_vsync(struct panel_info *panel, int init)
 		ret = 0;
 		goto uninit;
 	}
-	ret = gpio_request(gpio, "vsync");
+	ret = gpio_request_one(gpio, GPIOF_IN, "vsync");
 	if (ret)
 		goto err_request_gpio_failed;
 
-	ret = gpio_direction_input(gpio);
-	if (ret)
-		goto err_gpio_direction_input_failed;
-
 	ret = irq = gpio_to_irq(gpio);
 	if (ret < 0)
 		goto err_get_irq_num_failed;
@@ -180,7 +176,6 @@ uninit:
 	free_irq(gpio_to_irq(gpio), panel->client_data);
 err_request_irq_failed:
 err_get_irq_num_failed:
-err_gpio_direction_input_failed:
 	gpio_free(gpio);
 err_request_gpio_failed:
 	return ret;
diff --git a/drivers/video/msm/mddi_client_toshiba.c b/drivers/video/msm/mddi_client_toshiba.c
index f9bc932..053eb68 100644
--- a/drivers/video/msm/mddi_client_toshiba.c
+++ b/drivers/video/msm/mddi_client_toshiba.c
@@ -186,14 +186,10 @@ static int setup_vsync(struct panel_info *panel,
 		ret = 0;
 		goto uninit;
 	}
-	ret = gpio_request(gpio, "vsync");
+	ret = gpio_request_one(gpio, GPIOF_IN, "vsync");
 	if (ret)
 		goto err_request_gpio_failed;
 
-	ret = gpio_direction_input(gpio);
-	if (ret)
-		goto err_gpio_direction_input_failed;
-
 	ret = irq = gpio_to_irq(gpio);
 	if (ret < 0)
 		goto err_get_irq_num_failed;
@@ -210,7 +206,6 @@ uninit:
 	free_irq(gpio_to_irq(gpio), panel);
 err_request_irq_failed:
 err_get_irq_num_failed:
-err_gpio_direction_input_failed:
 	gpio_free(gpio);
 err_request_gpio_failed:
 	return ret;
diff --git a/drivers/video/omap/lcd_inn1610.c b/drivers/video/omap/lcd_inn1610.c
index 7e8bd8e..e3d3d13 100644
--- a/drivers/video/omap/lcd_inn1610.c
+++ b/drivers/video/omap/lcd_inn1610.c
@@ -22,7 +22,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-#include <asm/gpio.h>
+#include <linux/gpio.h>
 #include "omapfb.h"
 
 #define MODULE_NAME	"omapfb-lcd_h3"
@@ -32,20 +32,18 @@ static int innovator1610_panel_init(struct lcd_panel *panel,
 {
 	int r = 0;
 
-	if (gpio_request(14, "lcd_en0")) {
+	/* configure GPIO(14, 15) as outputs */
+	if (gpio_request_one(14, GPIOF_OUT_INIT_LOW, "lcd_en0")) {
 		pr_err(MODULE_NAME ": can't request GPIO 14\n");
 		r = -1;
 		goto exit;
 	}
-	if (gpio_request(15, "lcd_en1")) {
+	if (gpio_request_one(15, GPIOF_OUT_INIT_LOW, "lcd_en1")) {
 		pr_err(MODULE_NAME ": can't request GPIO 15\n");
 		gpio_free(14);
 		r = -1;
 		goto exit;
 	}
-	/* configure GPIO(14, 15) as outputs */
-	gpio_direction_output(14, 0);
-	gpio_direction_output(15, 0);
 exit:
 	return r;
 }
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 00c5c61..0f21fa5 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1019,14 +1019,12 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	if (panel_data->use_ext_te) {
 		int gpio = panel_data->ext_te_gpio;
 
-		r = gpio_request(gpio, "taal irq");
+		r = gpio_request_one(gpio, GPIOF_IN, "taal irq");
 		if (r) {
 			dev_err(&dssdev->dev, "GPIO request failed\n");
 			goto err_gpio;
 		}
 
-		gpio_direction_input(gpio);
-
 		r = request_irq(gpio_to_irq(gpio), taal_te_isr,
 				IRQF_TRIGGER_RISING,
 				"taal vsync", dssdev);
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index e6649aa..880c313 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -408,17 +408,12 @@ static int tpo_td043_probe(struct omap_dss_device *dssdev)
 	}
 
 	if (gpio_is_valid(nreset_gpio)) {
-		ret = gpio_request(nreset_gpio, "lcd reset");
+		ret = gpio_request_one(nreset_gpio, GPIOF_OUT_INIT_LOW,
+					"lcd reset");
 		if (ret < 0) {
 			dev_err(&dssdev->dev, "couldn't request reset GPIO\n");
 			goto fail_gpio_req;
 		}
-
-		ret = gpio_direction_output(nreset_gpio, 0);
-		if (ret < 0) {
-			dev_err(&dssdev->dev, "couldn't set GPIO direction\n");
-			goto fail_gpio_direction;
-		}
 	}
 
 	ret = sysfs_create_group(&dssdev->dev.kobj, &tpo_td043_attr_group);
@@ -427,8 +422,6 @@ static int tpo_td043_probe(struct omap_dss_device *dssdev)
 
 	return 0;
 
-fail_gpio_direction:
-	gpio_free(nreset_gpio);
 fail_gpio_req:
 	regulator_put(tpo_td043->vcc_reg);
 fail_regulator:
-- 
1.7.1



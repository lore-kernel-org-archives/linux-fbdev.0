From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Sun, 25 Nov 2018 11:52:24 +0000
Subject: [PATCH 21/26] Staging: fbtft: fb_agm1264k-fl: Switch to the gpio descriptor interface
Message-Id: <0cb80f07d535f9344497960c6efa6a90ce26359a.1543142441.git.nishadkamdar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

This switches the fb_agm1264k-fl.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_agm1264k-fl.c | 52 +++++++++++++-------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index f6f30f5bf15a..8f27bd8da17d 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 
@@ -79,14 +79,14 @@ static int init_display(struct fbtft_par *par)
 
 static void reset(struct fbtft_par *par)
 {
-	if (par->gpio.reset = -1)
+	if (!par->gpio.reset)
 		return;
 
 	dev_dbg(par->info->device, "%s()\n", __func__);
 
-	gpio_set_value(par->gpio.reset, 0);
+	gpiod_set_value(par->gpio.reset, 0);
 	udelay(20);
-	gpio_set_value(par->gpio.reset, 1);
+	gpiod_set_value(par->gpio.reset, 1);
 	mdelay(120);
 }
 
@@ -98,30 +98,30 @@ static int verify_gpios(struct fbtft_par *par)
 	dev_dbg(par->info->device,
 		"%s()\n", __func__);
 
-	if (par->EPIN < 0) {
+	if (!par->EPIN) {
 		dev_err(par->info->device,
 			"Missing info about 'wr' (aka E) gpio. Aborting.\n");
 		return -EINVAL;
 	}
 	for (i = 0; i < 8; ++i) {
-		if (par->gpio.db[i] < 0) {
+		if (!par->gpio.db[i]) {
 			dev_err(par->info->device,
 				"Missing info about 'db[%i]' gpio. Aborting.\n",
 				i);
 			return -EINVAL;
 		}
 	}
-	if (par->CS0 < 0) {
+	if (!par->CS0) {
 		dev_err(par->info->device,
 			"Missing info about 'cs0' gpio. Aborting.\n");
 		return -EINVAL;
 	}
-	if (par->CS1 < 0) {
+	if (!par->CS1) {
 		dev_err(par->info->device,
 			"Missing info about 'cs1' gpio. Aborting.\n");
 		return -EINVAL;
 	}
-	if (par->RW < 0) {
+	if (!par->RW) {
 		dev_err(par->info->device,
 			"Missing info about 'rw' gpio. Aborting.\n");
 		return -EINVAL;
@@ -139,22 +139,22 @@ request_gpios_match(struct fbtft_par *par, const struct fbtft_gpio *gpio)
 	if (strcasecmp(gpio->name, "wr") = 0) {
 		/* left ks0108 E pin */
 		par->EPIN = gpio->gpio;
-		return GPIOF_OUT_INIT_LOW;
+		return GPIOD_OUT_LOW;
 	} else if (strcasecmp(gpio->name, "cs0") = 0) {
 		/* left ks0108 controller pin */
 		par->CS0 = gpio->gpio;
-		return GPIOF_OUT_INIT_HIGH;
+		return GPIOD_OUT_HIGH;
 	} else if (strcasecmp(gpio->name, "cs1") = 0) {
 		/* right ks0108 controller pin */
 		par->CS1 = gpio->gpio;
-		return GPIOF_OUT_INIT_HIGH;
+		return GPIOD_OUT_HIGH;
 	}
 
 	/* if write (rw = 0) e(1->0) perform write */
 	/* if read (rw = 1) e(0->1) set data on D0-7*/
 	else if (strcasecmp(gpio->name, "rw") = 0) {
 		par->RW = gpio->gpio;
-		return GPIOF_OUT_INIT_LOW;
+		return GPIOD_OUT_LOW;
 	}
 
 	return FBTFT_GPIO_NO_MATCH;
@@ -194,15 +194,15 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	/* select chip */
 	if (*buf) {
 		/* cs1 */
-		gpio_set_value(par->CS0, 1);
-		gpio_set_value(par->CS1, 0);
+		gpiod_set_value(par->CS0, 1);
+		gpiod_set_value(par->CS1, 0);
 	} else {
 		/* cs0 */
-		gpio_set_value(par->CS0, 0);
-		gpio_set_value(par->CS1, 1);
+		gpiod_set_value(par->CS0, 0);
+		gpiod_set_value(par->CS1, 1);
 	}
 
-	gpio_set_value(par->RS, 0); /* RS->0 (command mode) */
+	gpiod_set_value(par->RS, 0); /* RS->0 (command mode) */
 	len--;
 
 	if (len) {
@@ -364,7 +364,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 			write_reg(par, 0x00, (0x17 << 3) | (u8)y);
 
 			/* write bitmap */
-			gpio_set_value(par->RS, 1); /* RS->1 (data mode) */
+			gpiod_set_value(par->RS, 1); /* RS->1 (data mode) */
 			ret = par->fbtftops.write(par, buf, len);
 			if (ret < 0)
 				dev_err(par->info->device,
@@ -387,7 +387,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 			write_reg(par, 0x01, (0x17 << 3) | (u8)y);
 
 			/* write bitmap */
-			gpio_set_value(par->RS, 1); /* RS->1 (data mode) */
+			gpiod_set_value(par->RS, 1); /* RS->1 (data mode) */
 			par->fbtftops.write(par, buf, len);
 			if (ret < 0)
 				dev_err(par->info->device,
@@ -397,8 +397,8 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 	}
 	kfree(convert_buf);
 
-	gpio_set_value(par->CS0, 1);
-	gpio_set_value(par->CS1, 1);
+	gpiod_set_value(par->CS0, 1);
+	gpiod_set_value(par->CS1, 1);
 
 	return ret;
 }
@@ -408,7 +408,7 @@ static int write(struct fbtft_par *par, void *buf, size_t len)
 	fbtft_par_dbg_hex(DEBUG_WRITE, par, par->info->device, u8, buf, len,
 			  "%s(len=%d): ", __func__, len);
 
-	gpio_set_value(par->RW, 0); /* set write mode */
+	gpiod_set_value(par->RW, 0); /* set write mode */
 
 	while (len--) {
 		u8 i, data;
@@ -417,12 +417,12 @@ static int write(struct fbtft_par *par, void *buf, size_t len)
 
 		/* set data bus */
 		for (i = 0; i < 8; ++i)
-			gpio_set_value(par->gpio.db[i], data & (1 << i));
+			gpiod_set_value(par->gpio.db[i], data & (1 << i));
 		/* set E */
-		gpio_set_value(par->EPIN, 1);
+		gpiod_set_value(par->EPIN, 1);
 		udelay(5);
 		/* unset E - write */
-		gpio_set_value(par->EPIN, 0);
+		gpiod_set_value(par->EPIN, 0);
 		udelay(1);
 	}
 
-- 
2.17.1

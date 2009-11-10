From: Jun Nie <niej0001@gmail.com>
Date: Tue, 10 Nov 2009 08:12:30 +0000
Subject: [PATCH 6/8] pxa: add gpio expander on pxa168 aspenite platform
Message-Id: <7c34ac520911100012s176bff7bk7d57e86cd660632f@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From 0815be7cf3458a14da1462b40247dc7a3231142a Mon Sep 17 00:00:00 2001
From: Jun Nie <njun@marvell.com>
Date: Tue, 3 Nov 2009 14:08:50 +0800
Subject: [PATCH] pxa: add gpio expander on pxa168 aspenite platform

Signed-off-by: Jun Nie <njun@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c |   45 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/pca953x.c       |    1 +
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 115f728..b422bb5 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -16,6 +16,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
+#include <linux/i2c/pca953x.h>

 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -24,9 +25,14 @@
 #include <mach/pxa168.h>
 #include <mach/gpio.h>
 #include <plat/pxa3xx_nand.h>
+#include <video/pxa168fb.h>

 #include "common.h"

+/*used by expander max7312, 16 pins gpio expander */
+#define GPIO_EXT0(x)		(NR_BUILTIN_GPIO + (x))
+#define GPIO_EXT1(x)		(NR_BUILTIN_GPIO + 16 + (x))
+
 static unsigned long common_pin_config[] __initdata = {
 	/* Data Flash Interface */
 	GPIO0_DFI_D15,
@@ -134,6 +140,44 @@ static void __init apn_init_nand(void)
 static void __init apn_init_nand(void) {}
 #endif

+static struct i2c_pxa_platform_data pwri2c_info __initdata = {
+	.use_pio		= 1,
+};
+
+#if defined(CONFIG_GPIO_PCA953X)
+/* GPIO expander max7312 could reuse PCA953X */
+static struct pca953x_platform_data max7312_data[] = {
+	/* two max7312 in system */
+
+	[0] = {
+		.gpio_base      = GPIO_EXT0(0),
+	},
+
+	[1] = {
+		.gpio_base      = GPIO_EXT1(0),
+	},
+};
+#endif
+
+static struct i2c_board_info aspenite_i2c_board_info[] = {
+
+#if defined(CONFIG_GPIO_PCA953X)
+	{
+		.type           = "max7312",
+		.addr           = 0x10,                 /* 0x20/0x21 */
+		.irq            = IRQ_GPIO(122),
+		.platform_data  = &max7312_data[0],
+	},
+
+	{
+		.type           = "max7312",
+		.addr           = 0x20,                 /* 0x40/0x41 */
+		.irq            = IRQ_GPIO(120),
+		.platform_data  = &max7312_data[1],
+	},
+#endif
+};
+
 static void __init common_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(common_pin_config));
@@ -142,6 +186,7 @@ static void __init common_init(void)
 	pxa168_add_uart(1);

 	apn_init_nand();
+	pxa168_add_twsi(0, &pwri2c_info, ARRAY_AND_SIZE(aspenite_i2c_board_info));

 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index 6a2fb3f..7822684 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -39,6 +39,7 @@ static const struct i2c_device_id pca953x_id[] = {
 	{ "pca9557", 8, },

 	{ "max7310", 8, },
+	{ "max7312", 16, },
 	{ "max7315", 8, },
 	{ "pca6107", 8, },
 	{ "tca6408", 8, },
-- 
1.5.4.3

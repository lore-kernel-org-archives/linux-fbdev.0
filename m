From: Alexander Shiyan <shc_work@mail.ru>
Date: Thu, 17 Jan 2019 13:33:36 +0000
Subject: [PATCH v2 2/2] video: lcd: Remove useless BACKLIGHT_CLASS_DEVICE dependencies
Message-Id: <20190117133336.19737-2-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190117133336.19737-1-shc_work@mail.ru>
In-Reply-To: <20190117133336.19737-1-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Daniel Thompson <daniel.thompson@linaro.org>, Lee Jones <lee.jones@linaro.org>

This patch removes dependencies on BACKLIGHT_CLASS_DEVICE for items
that are already placed under #if BACKLIGHT_CLASS_DEVICE.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/video/backlight/Kconfig | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 3fdc18e..3ed1d90 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -193,7 +193,6 @@ config BACKLIGHT_IPAQ_MICRO
 
 config BACKLIGHT_LM3533
 	tristate "Backlight Driver for LM3533"
-	depends on BACKLIGHT_CLASS_DEVICE
 	depends on MFD_LM3533
 	help
 	  Say Y to enable the backlight driver for National Semiconductor / TI
@@ -317,7 +316,7 @@ config BACKLIGHT_ADP5520
 
 config BACKLIGHT_ADP8860
 	tristate "Backlight Driver for ADP8860/ADP8861/ADP8863 using WLED"
-	depends on BACKLIGHT_CLASS_DEVICE && I2C
+	depends on I2C
 	select NEW_LEDS
 	select LEDS_CLASS
 	help
@@ -329,7 +328,7 @@ config BACKLIGHT_ADP8860
 
 config BACKLIGHT_ADP8870
 	tristate "Backlight Driver for ADP8870 using WLED"
-	depends on BACKLIGHT_CLASS_DEVICE && I2C
+	depends on I2C
 	select NEW_LEDS
 	select LEDS_CLASS
 	help
@@ -347,28 +346,28 @@ config BACKLIGHT_88PM860X
 
 config BACKLIGHT_PCF50633
 	tristate "Backlight driver for NXP PCF50633 MFD"
-	depends on BACKLIGHT_CLASS_DEVICE && MFD_PCF50633
+	depends on MFD_PCF50633
 	help
 	  If you have a backlight driven by a NXP PCF50633 MFD, say Y here to
 	  enable its driver.
 
 config BACKLIGHT_AAT2870
 	tristate "AnalogicTech AAT2870 Backlight"
-	depends on BACKLIGHT_CLASS_DEVICE && MFD_AAT2870_CORE
+	depends on MFD_AAT2870_CORE
 	help
 	  If you have a AnalogicTech AAT2870 say Y to enable the
 	  backlight driver.
 
 config BACKLIGHT_LM3630A
 	tristate "Backlight Driver for LM3630A"
-	depends on BACKLIGHT_CLASS_DEVICE && I2C && PWM
+	depends on I2C && PWM
 	select REGMAP_I2C
 	help
 	  This supports TI LM3630A Backlight Driver
 
 config BACKLIGHT_LM3639
 	tristate "Backlight Driver for LM3639"
-	depends on BACKLIGHT_CLASS_DEVICE && I2C
+	depends on I2C
 	select REGMAP_I2C
 	select NEW_LEDS
 	select LEDS_CLASS
@@ -377,20 +376,20 @@ config BACKLIGHT_LM3639
 
 config BACKLIGHT_LP855X
 	tristate "Backlight driver for TI LP855X"
-	depends on BACKLIGHT_CLASS_DEVICE && I2C && PWM
+	depends on I2C && PWM
 	help
 	  This supports TI LP8550, LP8551, LP8552, LP8553, LP8555, LP8556 and
 	  LP8557 backlight driver.
 
 config BACKLIGHT_LP8788
 	tristate "Backlight driver for TI LP8788 MFD"
-	depends on BACKLIGHT_CLASS_DEVICE && MFD_LP8788 && PWM
+	depends on MFD_LP8788 && PWM
 	help
 	  This supports TI LP8788 backlight driver.
 
 config BACKLIGHT_OT200
 	tristate "Backlight driver for ot200 visualisation device"
-	depends on BACKLIGHT_CLASS_DEVICE && CS5535_MFGPT && GPIO_CS5535
+	depends on CS5535_MFGPT && GPIO_CS5535
 	help
 	  To compile this driver as a module, choose M here: the module will be
 	  called ot200_bl.
@@ -404,7 +403,7 @@ config BACKLIGHT_PANDORA
 
 config BACKLIGHT_SKY81452
 	tristate "Backlight driver for SKY81452"
-	depends on BACKLIGHT_CLASS_DEVICE && MFD_SKY81452
+	depends on MFD_SKY81452
 	help
 	  If you have a Skyworks SKY81452, say Y to enable the
 	  backlight driver.
@@ -414,14 +413,14 @@ config BACKLIGHT_SKY81452
 
 config BACKLIGHT_TPS65217
 	tristate "TPS65217 Backlight"
-	depends on BACKLIGHT_CLASS_DEVICE && MFD_TPS65217
+	depends on MFD_TPS65217
 	help
 	  If you have a Texas Instruments TPS65217 say Y to enable the
 	  backlight driver.
 
 config BACKLIGHT_AS3711
 	tristate "AS3711 Backlight"
-	depends on BACKLIGHT_CLASS_DEVICE && MFD_AS3711
+	depends on MFD_AS3711
 	help
 	  If you have an Austrian Microsystems AS3711 say Y to enable the
 	  backlight driver.
-- 
2.10.2

From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:21:09 +0000
Subject: [PATCH 120/493] backlight: remove use of __devexit_p
Message-Id: <1353349642-3677-120-git-send-email-wfp5p@virginia.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Richard Purdie <rpurdie@rpsys.net> 
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de> 
Cc: device-drivers-devel@blackfin.uclinux.org 
Cc: linux-fbdev@vger.kernel.org 
---
 drivers/video/backlight/adp5520_bl.c         | 2 +-
 drivers/video/backlight/adp8860_bl.c         | 2 +-
 drivers/video/backlight/adp8870_bl.c         | 2 +-
 drivers/video/backlight/ams369fg06.c         | 2 +-
 drivers/video/backlight/corgi_lcd.c          | 2 +-
 drivers/video/backlight/ep93xx_bl.c          | 2 +-
 drivers/video/backlight/hp680_bl.c           | 2 +-
 drivers/video/backlight/l4f00242t03.c        | 2 +-
 drivers/video/backlight/ld9040.c             | 2 +-
 drivers/video/backlight/lm3533_bl.c          | 2 +-
 drivers/video/backlight/lm3630_bl.c          | 2 +-
 drivers/video/backlight/lm3639_bl.c          | 2 +-
 drivers/video/backlight/lms283gf05.c         | 2 +-
 drivers/video/backlight/lp855x_bl.c          | 2 +-
 drivers/video/backlight/ltv350qv.c           | 2 +-
 drivers/video/backlight/max8925_bl.c         | 2 +-
 drivers/video/backlight/pcf50633-backlight.c | 2 +-
 drivers/video/backlight/platform_lcd.c       | 2 +-
 drivers/video/backlight/s6e63m0.c            | 2 +-
 drivers/video/backlight/tdo24m.c             | 2 +-
 drivers/video/backlight/tosa_bl.c            | 2 +-
 drivers/video/backlight/tosa_lcd.c           | 2 +-
 drivers/video/backlight/vgg2432a4.c          | 2 +-
 23 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
index df5db99..e2a0da3 100644
--- a/drivers/video/backlight/adp5520_bl.c
+++ b/drivers/video/backlight/adp5520_bl.c
@@ -375,7 +375,7 @@ static struct platform_driver adp5520_bl_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= adp5520_bl_probe,
-	.remove		= __devexit_p(adp5520_bl_remove),
+	.remove		= adp5520_bl_remove,
 	.suspend	= adp5520_bl_suspend,
 	.resume		= adp5520_bl_resume,
 };
diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
index 77d1fdb..953c521 100644
--- a/drivers/video/backlight/adp8860_bl.c
+++ b/drivers/video/backlight/adp8860_bl.c
@@ -805,7 +805,7 @@ static struct i2c_driver adp8860_driver = {
 		.name = KBUILD_MODNAME,
 	},
 	.probe    = adp8860_probe,
-	.remove   = __devexit_p(adp8860_remove),
+	.remove   = adp8860_remove,
 	.suspend = adp8860_i2c_suspend,
 	.resume  = adp8860_i2c_resume,
 	.id_table = adp8860_id,
diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index edf7f91..558772b 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -977,7 +977,7 @@ static struct i2c_driver adp8870_driver = {
 		.name = KBUILD_MODNAME,
 	},
 	.probe    = adp8870_probe,
-	.remove   = __devexit_p(adp8870_remove),
+	.remove   = adp8870_remove,
 	.suspend = adp8870_i2c_suspend,
 	.resume  = adp8870_i2c_resume,
 	.id_table = adp8870_id,
diff --git a/drivers/video/backlight/ams369fg06.c b/drivers/video/backlight/ams369fg06.c
index 3729238..e48f4b1 100644
--- a/drivers/video/backlight/ams369fg06.c
+++ b/drivers/video/backlight/ams369fg06.c
@@ -617,7 +617,7 @@ static struct spi_driver ams369fg06_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ams369fg06_probe,
-	.remove		= __devexit_p(ams369fg06_remove),
+	.remove		= ams369fg06_remove,
 	.shutdown	= ams369fg06_shutdown,
 	.suspend	= ams369fg06_suspend,
 	.resume		= ams369fg06_resume,
diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
index 7171815..476dcb0 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -613,7 +613,7 @@ static struct spi_driver corgi_lcd_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= corgi_lcd_probe,
-	.remove		= __devexit_p(corgi_lcd_remove),
+	.remove		= corgi_lcd_remove,
 	.suspend	= corgi_lcd_suspend,
 	.resume		= corgi_lcd_resume,
 };
diff --git a/drivers/video/backlight/ep93xx_bl.c b/drivers/video/backlight/ep93xx_bl.c
index d0c688b..f50b580 100644
--- a/drivers/video/backlight/ep93xx_bl.c
+++ b/drivers/video/backlight/ep93xx_bl.c
@@ -141,7 +141,7 @@ static struct platform_driver ep93xxbl_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ep93xxbl_probe,
-	.remove		= __devexit_p(ep93xxbl_remove),
+	.remove		= ep93xxbl_remove,
 	.suspend	= ep93xxbl_suspend,
 	.resume		= ep93xxbl_resume,
 };
diff --git a/drivers/video/backlight/hp680_bl.c b/drivers/video/backlight/hp680_bl.c
index 31d3a1f..a8274ed 100644
--- a/drivers/video/backlight/hp680_bl.c
+++ b/drivers/video/backlight/hp680_bl.c
@@ -139,7 +139,7 @@ static int __devexit hp680bl_remove(struct platform_device *pdev)
 
 static struct platform_driver hp680bl_driver = {
 	.probe		= hp680bl_probe,
-	.remove		= __devexit_p(hp680bl_remove),
+	.remove		= hp680bl_remove,
 	.suspend	= hp680bl_suspend,
 	.resume		= hp680bl_resume,
 	.driver		= {
diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index 472c7dc..052cdac 100644
--- a/drivers/video/backlight/l4f00242t03.c
+++ b/drivers/video/backlight/l4f00242t03.c
@@ -259,7 +259,7 @@ static struct spi_driver l4f00242t03_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= l4f00242t03_probe,
-	.remove		= __devexit_p(l4f00242t03_remove),
+	.remove		= l4f00242t03_remove,
 	.shutdown	= l4f00242t03_shutdown,
 };
 
diff --git a/drivers/video/backlight/ld9040.c b/drivers/video/backlight/ld9040.c
index 58f517f..77ba103 100644
--- a/drivers/video/backlight/ld9040.c
+++ b/drivers/video/backlight/ld9040.c
@@ -847,7 +847,7 @@ static struct spi_driver ld9040_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ld9040_probe,
-	.remove		= __devexit_p(ld9040_remove),
+	.remove		= ld9040_remove,
 	.shutdown	= ld9040_shutdown,
 	.suspend	= ld9040_suspend,
 	.resume		= ld9040_resume,
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 18dca0c..c9a0b51 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -406,7 +406,7 @@ static struct platform_driver lm3533_bl_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= lm3533_bl_probe,
-	.remove		= __devexit_p(lm3533_bl_remove),
+	.remove		= lm3533_bl_remove,
 	.shutdown	= lm3533_bl_shutdown,
 	.suspend	= lm3533_bl_suspend,
 	.resume		= lm3533_bl_resume,
diff --git a/drivers/video/backlight/lm3630_bl.c b/drivers/video/backlight/lm3630_bl.c
index a56f6a8..39981ba 100644
--- a/drivers/video/backlight/lm3630_bl.c
+++ b/drivers/video/backlight/lm3630_bl.c
@@ -463,7 +463,7 @@ static struct i2c_driver lm3630_i2c_driver = {
 		   .name = LM3630_NAME,
 		   },
 	.probe = lm3630_probe,
-	.remove = __devexit_p(lm3630_remove),
+	.remove = lm3630_remove,
 	.id_table = lm3630_id,
 };
 
diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 6f7a20e..0e8d9ca 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -425,7 +425,7 @@ static struct i2c_driver lm3639_i2c_driver = {
 		   .name = LM3639_NAME,
 		   },
 	.probe = lm3639_probe,
-	.remove = __devexit_p(lm3639_remove),
+	.remove = lm3639_remove,
 	.id_table = lm3639_id,
 };
 
diff --git a/drivers/video/backlight/lms283gf05.c b/drivers/video/backlight/lms283gf05.c
index d317730..a9afb82 100644
--- a/drivers/video/backlight/lms283gf05.c
+++ b/drivers/video/backlight/lms283gf05.c
@@ -204,7 +204,7 @@ static struct spi_driver lms283gf05_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= lms283gf05_probe,
-	.remove		= __devexit_p(lms283gf05_remove),
+	.remove		= lms283gf05_remove,
 };
 
 module_spi_driver(lms283gf05_driver);
diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index f7757cf..b90ec2b 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -327,7 +327,7 @@ static struct i2c_driver lp855x_driver = {
 		   .name = "lp855x",
 		   },
 	.probe = lp855x_probe,
-	.remove = __devexit_p(lp855x_remove),
+	.remove = lp855x_remove,
 	.id_table = lp855x_ids,
 };
 
diff --git a/drivers/video/backlight/ltv350qv.c b/drivers/video/backlight/ltv350qv.c
index 4066a5b..c63ce6e 100644
--- a/drivers/video/backlight/ltv350qv.c
+++ b/drivers/video/backlight/ltv350qv.c
@@ -305,7 +305,7 @@ static struct spi_driver ltv350qv_driver = {
 	},
 
 	.probe		= ltv350qv_probe,
-	.remove		= __devexit_p(ltv350qv_remove),
+	.remove		= ltv350qv_remove,
 	.shutdown	= ltv350qv_shutdown,
 	.suspend	= ltv350qv_suspend,
 	.resume		= ltv350qv_resume,
diff --git a/drivers/video/backlight/max8925_bl.c b/drivers/video/backlight/max8925_bl.c
index 01e9f7d..b509c4c 100644
--- a/drivers/video/backlight/max8925_bl.c
+++ b/drivers/video/backlight/max8925_bl.c
@@ -180,7 +180,7 @@ static struct platform_driver max8925_backlight_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= max8925_backlight_probe,
-	.remove		= __devexit_p(max8925_backlight_remove),
+	.remove		= max8925_backlight_remove,
 };
 
 module_platform_driver(max8925_backlight_driver);
diff --git a/drivers/video/backlight/pcf50633-backlight.c b/drivers/video/backlight/pcf50633-backlight.c
index 930fc2a..d05196d 100644
--- a/drivers/video/backlight/pcf50633-backlight.c
+++ b/drivers/video/backlight/pcf50633-backlight.c
@@ -160,7 +160,7 @@ static int __devexit pcf50633_bl_remove(struct platform_device *pdev)
 
 static struct platform_driver pcf50633_bl_driver = {
 	.probe =	pcf50633_bl_probe,
-	.remove =	__devexit_p(pcf50633_bl_remove),
+	.remove =	pcf50633_bl_remove,
 	.driver = {
 		.name = "pcf50633-backlight",
 	},
diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backlight/platform_lcd.c
index 74cfca4..8e584fe 100644
--- a/drivers/video/backlight/platform_lcd.c
+++ b/drivers/video/backlight/platform_lcd.c
@@ -164,7 +164,7 @@ static struct platform_driver platform_lcd_driver = {
 		.of_match_table = of_match_ptr(platform_lcd_of_match),
 	},
 	.probe		= platform_lcd_probe,
-	.remove		= __devexit_p(platform_lcd_remove),
+	.remove		= platform_lcd_remove,
 };
 
 module_platform_driver(platform_lcd_driver);
diff --git a/drivers/video/backlight/s6e63m0.c b/drivers/video/backlight/s6e63m0.c
index 1f435e2..7ca5a88 100644
--- a/drivers/video/backlight/s6e63m0.c
+++ b/drivers/video/backlight/s6e63m0.c
@@ -897,7 +897,7 @@ static struct spi_driver s6e63m0_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= s6e63m0_probe,
-	.remove		= __devexit_p(s6e63m0_remove),
+	.remove		= s6e63m0_remove,
 	.shutdown	= s6e63m0_shutdown,
 	.suspend	= s6e63m0_suspend,
 	.resume		= s6e63m0_resume,
diff --git a/drivers/video/backlight/tdo24m.c b/drivers/video/backlight/tdo24m.c
index 13e5f2c..0e707a3 100644
--- a/drivers/video/backlight/tdo24m.c
+++ b/drivers/video/backlight/tdo24m.c
@@ -445,7 +445,7 @@ static struct spi_driver tdo24m_driver = {
 		.owner		= THIS_MODULE,
 	},
 	.probe		= tdo24m_probe,
-	.remove		= __devexit_p(tdo24m_remove),
+	.remove		= tdo24m_remove,
 	.shutdown	= tdo24m_shutdown,
 	.suspend	= tdo24m_suspend,
 	.resume		= tdo24m_resume,
diff --git a/drivers/video/backlight/tosa_bl.c b/drivers/video/backlight/tosa_bl.c
index 3fd5292..b692eec 100644
--- a/drivers/video/backlight/tosa_bl.c
+++ b/drivers/video/backlight/tosa_bl.c
@@ -168,7 +168,7 @@ static struct i2c_driver tosa_bl_driver = {
 		.owner		= THIS_MODULE,
 	},
 	.probe		= tosa_bl_probe,
-	.remove		= __devexit_p(tosa_bl_remove),
+	.remove		= tosa_bl_remove,
 	.suspend	= tosa_bl_suspend,
 	.resume		= tosa_bl_resume,
 	.id_table	= tosa_bl_id,
diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
index 301687a..9e9716b 100644
--- a/drivers/video/backlight/tosa_lcd.c
+++ b/drivers/video/backlight/tosa_lcd.c
@@ -273,7 +273,7 @@ static struct spi_driver tosa_lcd_driver = {
 		.owner		= THIS_MODULE,
 	},
 	.probe		= tosa_lcd_probe,
-	.remove		= __devexit_p(tosa_lcd_remove),
+	.remove		= tosa_lcd_remove,
 	.suspend	= tosa_lcd_suspend,
 	.resume		= tosa_lcd_resume,
 };
diff --git a/drivers/video/backlight/vgg2432a4.c b/drivers/video/backlight/vgg2432a4.c
index 83d84f6..b7255c9 100644
--- a/drivers/video/backlight/vgg2432a4.c
+++ b/drivers/video/backlight/vgg2432a4.c
@@ -256,7 +256,7 @@ static struct spi_driver vgg2432a4_driver = {
 		.owner		= THIS_MODULE,
 	},
 	.probe		= vgg2432a4_probe,
-	.remove		= __devexit_p(vgg2432a4_remove),
+	.remove		= vgg2432a4_remove,
 	.shutdown	= vgg2432a4_shutdown,
 	.suspend	= vgg2432a4_suspend,
 	.resume		= vgg2432a4_resume,
-- 
1.8.0


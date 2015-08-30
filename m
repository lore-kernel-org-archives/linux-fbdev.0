From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Sun, 30 Aug 2015 21:34:24 +0000
Subject: [PATCH 1/2] backlight: adp8860: Remove unnecessary MODULE_ALIAS()
Message-Id: <1440970465-11651-1-git-send-email-javier@osg.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-fbdev@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Lee Jones <lee.jones@linaro.org>

The driver has a I2C device id table that is used to create the modaliases
and also "adp8860-backlight" is not a supported I2C id, so it's never used.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/video/backlight/adp8860_bl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
index 71147f4461b8..98ffe71e8af2 100644
--- a/drivers/video/backlight/adp8860_bl.c
+++ b/drivers/video/backlight/adp8860_bl.c
@@ -819,4 +819,3 @@ module_i2c_driver(adp8860_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("ADP8860 Backlight driver");
-MODULE_ALIAS("i2c:adp8860-backlight");
-- 
2.4.3


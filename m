From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Mon, 11 Jul 2016 20:44:37 +0000
Subject: [PATCH] fb: adv7393: Use IS_ENABLED() instead of checking for built-in or module
Message-Id: <1468269877-9900-1-git-send-email-javier@osg.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
built-in or as a module, use that macro instead of open coding the same.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/video/fbdev/bfin_adv7393fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/bfin_adv7393fb.c b/drivers/video/fbdev/bfin_adv7393fb.c
index 8fe41caac38e..9a01cd7ca73c 100644
--- a/drivers/video/fbdev/bfin_adv7393fb.c
+++ b/drivers/video/fbdev/bfin_adv7393fb.c
@@ -795,7 +795,7 @@ static struct i2c_driver bfin_adv7393_fb_driver = {
 
 static int __init bfin_adv7393_fb_driver_init(void)
 {
-#if  defined(CONFIG_I2C_BLACKFIN_TWI) || defined(CONFIG_I2C_BLACKFIN_TWI_MODULE)
+#if IS_ENABLED(CONFIG_I2C_BLACKFIN_TWI)
 	request_module("i2c-bfin-twi");
 #else
 	request_module("i2c-gpio");
-- 
2.5.5


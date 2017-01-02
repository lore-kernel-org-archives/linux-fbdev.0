From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Mon, 02 Jan 2017 16:03:27 +0000
Subject: [PATCH] backlight: da9052: Fix module autoload
Message-Id: <1483373008-9905-1-git-send-email-javier@osg.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>

The driver has a platform device ID table with multiple device entries,
each setting a different register address in its driver_data to control
the WLED brightness.

But the driver doesn't export these as aliases with MODULE_DEVICE_TABLE()
when the driver is built as a module, instead it just has a single alias
using MODULE_ALIAS("platform:da9052-backlight"). That is clearly wrong
since there isn't a "da9052-backlight" in the platform device ID table,
so if that device name is used, the device won't even match the driver.

So instead of having a wrong alias, export the ones in the dev ID table.

Before this patch:

$ modinfo drivers/video/backlight/da9052_bl.ko | grep alias
alias:          platform:da9052-backlight

After this patch:

$ modinfo drivers/video/backlight/da9052_bl.ko | grep alias
alias:          platform:da9052-wled3
alias:          platform:da9052-wled2
alias:          platform:da9052-wled1

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/video/backlight/da9052_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
index fd2be417aa64..49035c12739a 100644
--- a/drivers/video/backlight/da9052_bl.c
+++ b/drivers/video/backlight/da9052_bl.c
@@ -167,6 +167,7 @@ static const struct platform_device_id da9052_wled_ids[] = {
 	},
 	{ },
 };
+MODULE_DEVICE_TABLE(platform, da9052_wled_ids);
 
 static struct platform_driver da9052_wled_driver = {
 	.probe		= da9052_backlight_probe,
@@ -182,4 +183,3 @@ module_platform_driver(da9052_wled_driver);
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("Backlight driver for DA9052 PMIC");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:da9052-backlight");
-- 
2.7.4


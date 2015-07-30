From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Thu, 30 Jul 2015 16:18:35 +0000
Subject: [PATCH 10/27] backlight: tosa: Export I2C module alias information
Message-Id: <1438273132-20926-11-git-send-email-javier@osg.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

The I2C core always reports the MODALIAS uevent as "i2c:<client name"
regardless if the driver was matched using the I2C id_table or the
of_match_table. So the driver needs to export the I2C table and this
be built into the module or udev won't have the necessary information
to auto load the correct module when the device is added.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/video/backlight/tosa_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/tosa_bl.c b/drivers/video/backlight/tosa_bl.c
index 3ad676558c80..83742d806391 100644
--- a/drivers/video/backlight/tosa_bl.c
+++ b/drivers/video/backlight/tosa_bl.c
@@ -158,6 +158,7 @@ static const struct i2c_device_id tosa_bl_id[] = {
 	{ "tosa-bl", 0 },
 	{ },
 };
+MODULE_DEVICE_TABLE(i2c, tosa_bl_id);
 
 static struct i2c_driver tosa_bl_driver = {
 	.driver = {
-- 
2.4.3


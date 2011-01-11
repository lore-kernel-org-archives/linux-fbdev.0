From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Jan 2011 15:23:52 +0000
Subject: [PATCH] radeonfb: Let hwmon driver probe the "monid" I2C bus
Message-Id: <20110111162352.5a634e9e@endymion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Some Radeon cards have an I2C-based thermal sensor chip connected to
the "monid" I2C bus. Set the I2C probing class of this bus properly so
that hwmon drivers can detect devices on it and bind to them.

This closes kernel.org bug #26172.

Reported-by: Alexander Goomenyuk <emerg.reanimator@gmail.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Ben, please let me know if you have any objection, and if you don't,
please let me know if you want to pick this patch or if you prefer that
I push it through my hwmon tree.

 drivers/video/aty/radeon_i2c.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.38-rc0.orig/drivers/video/aty/radeon_i2c.c	2011-01-05 21:24:24.000000000 +0100
+++ linux-2.6.38-rc0/drivers/video/aty/radeon_i2c.c	2011-01-11 13:51:34.000000000 +0100
@@ -100,6 +100,7 @@ void radeon_create_i2c_busses(struct rad
 {
 	rinfo->i2c[0].rinfo	= rinfo;
 	rinfo->i2c[0].ddc_reg	= GPIO_MONID;
+	rinfo->i2c[0].adapter.class = I2C_CLASS_HWMON;
 	radeon_setup_i2c_bus(&rinfo->i2c[0], "monid");
 
 	rinfo->i2c[1].rinfo	= rinfo;


-- 
Jean Delvare

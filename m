From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Feb 2011 08:23:10 +0000
Subject: [PATCH v2] radeonfb: Let hwmon driver probe the "monid" I2C bus
Message-Id: <20110203092310.74f3c690@endymion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Some Radeon cards have an I2C-based thermal sensor chip connected to
the "monid" I2C bus. Set the I2C probing class of this bus properly so
that hwmon drivers can detect devices on it and bind to them.

This closes kernel.org bug #26172.

We exclude PPC for the time being, as Benjamin doesn't want us to
mess up with them without explicit testing, and there is no evidence
that this change is needed for them either.

Reported-by: Alexander Goomenyuk <emerg.reanimator@gmail.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Changes since v1:
* Excluded CONFIG_PPC as requested by Benjamin H.

 drivers/video/aty/radeon_i2c.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.38-rc3.orig/drivers/video/aty/radeon_i2c.c	2011-02-03 08:42:36.000000000 +0100
+++ linux-2.6.38-rc3/drivers/video/aty/radeon_i2c.c	2011-02-03 09:13:41.000000000 +0100
@@ -100,6 +100,9 @@ void radeon_create_i2c_busses(struct rad
 {
 	rinfo->i2c[0].rinfo	= rinfo;
 	rinfo->i2c[0].ddc_reg	= GPIO_MONID;
+#ifndef CONFIG_PPC
+	rinfo->i2c[0].adapter.class = I2C_CLASS_HWMON;
+#endif
 	radeon_setup_i2c_bus(&rinfo->i2c[0], "monid");
 
 	rinfo->i2c[1].rinfo	= rinfo;


-- 
Jean Delvare

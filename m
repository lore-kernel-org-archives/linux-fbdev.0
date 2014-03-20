From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 20 Mar 2014 15:16:00 +0000
Subject: [PATCH] drivers/video: fix mb862xx_i2c depends issue build failure
Message-Id: <1395328560-48497-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jim Davis <jim.epost@gmail.com>, Fengguang Wu <fengguang.wu@intel.com>, Paul Gortmaker <paul.gortmaker@windriver.com>

Any randconfig that sets I2C=m and FB_MB862XX_I2C=y will
encounter a final link failure that looks like this:

drivers/built-in.o: In function `mb862xx_i2c_init':
drivers/video/mb862xx/mb862xx-i2c.c:165: undefined reference to `i2c_add_adapter'
drivers/built-in.o: In function `mb862xx_i2c_exit':
drivers/video/mb862xx/mb862xx-i2c.c:176: undefined reference to `i2c_del_adapter'

Since FB_MB862XX_I2C is a bool and not tristate, simply
don't offer it at all if core I2C support is not built in.

Reported-by: Jim Davis <jim.epost@gmail.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index dade5b7699bc..aefd1b9a3cbd 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2338,7 +2338,7 @@ endchoice
 
 config FB_MB862XX_I2C
 	bool "Support I2C bus on MB862XX GDC"
-	depends on FB_MB862XX && I2C
+	depends on FB_MB862XX && I2C=y
 	default y
 	help
 	  Selecting this option adds Coral-P(A)/Lime GDC I2C bus adapter
-- 
1.9.0


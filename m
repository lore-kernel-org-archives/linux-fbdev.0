From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 24 Apr 2014 12:28:26 +0000
Subject: [PATCH 10/13] video/pxa: LCD_CORGI needs BACKLIGHT_CLASS_DEVICE
Message-Id: <1398342509-10243-11-git-send-email-peter.griffin@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linaro-kernel@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Peter Griffin <peter.griffin@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This fixes a randconfig build error when BACKLIGHT_CLASS_DEVICE
is disabled, by describing the dependency in Kconfig,
as we do for the other drivers in this directory.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Bryan Wu <cooloney@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/backlight/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index ac6bc28..5675511 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -29,7 +29,7 @@ if LCD_CLASS_DEVICE
 
 config LCD_CORGI
 	tristate "LCD Panel support for SHARP corgi/spitz model"
-	depends on SPI_MASTER && PXA_SHARPSL
+	depends on SPI_MASTER && PXA_SHARPSL && BACKLIGHT_CLASS_DEVICE
 	help
 	  Say y here to support the LCD panels usually found on SHARP
 	  corgi (C7x0) and spitz (Cxx00) models.
-- 
1.7.9.5


From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 24 Apr 2014 12:28:25 +0000
Subject: [PATCH 09/13] video/backlight: LP8788 needs PWM
Message-Id: <1398342509-10243-10-git-send-email-peter.griffin@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linaro-kernel@lists.linaro.org, Peter Griffin <peter.griffin@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Milo Kim <milo.kim@ti.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

The LP8788 driver cannot be successfully built if we don't
enable the PWM subsystem. This patch makes that dependency
explicit in Kconfig and prevents broken randconfig builds.

Based on Arnd Bergmann patch but split out into seperate
commits per driver based on feedback.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: Milo Kim <milo.kim@ti.com>
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
index 4791af7..ac6bc28 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -393,7 +393,7 @@ config BACKLIGHT_LP855X
 
 config BACKLIGHT_LP8788
 	tristate "Backlight driver for TI LP8788 MFD"
-	depends on BACKLIGHT_CLASS_DEVICE && MFD_LP8788
+	depends on BACKLIGHT_CLASS_DEVICE && MFD_LP8788 && PWM
 	help
 	  This supports TI LP8788 backlight driver.
 
-- 
1.7.9.5


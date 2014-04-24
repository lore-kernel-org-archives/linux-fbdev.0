From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 24 Apr 2014 12:28:23 +0000
Subject: [PATCH 07/13] video: atmel needs FB_BACKLIGHT
Message-Id: <1398342509-10243-8-git-send-email-peter.griffin@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linaro-kernel@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Peter Griffin <peter.griffin@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The atmel frame buffer driver doesn't build if FB_BACKLIGHT
is disabled, so select it here as we do for lots of other
drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 5577a94..e593365 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -967,6 +967,7 @@ config FB_S1D13XXX
 config FB_ATMEL
 	tristate "AT91/AT32 LCD Controller support"
 	depends on FB && HAVE_FB_ATMEL
+	select FB_BACKLIGHT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.7.9.5


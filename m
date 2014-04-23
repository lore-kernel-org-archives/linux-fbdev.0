From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 23 Apr 2014 10:42:10 +0000
Subject: [PATCH] video: Kconfig: Add a dependency to the Goldfish framebuffer driver
Message-Id: <20140423124210.3e3e072f@endymion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

All other Goldfish drivers depend on GOLDFISH, I see no reason why the
framebuffer driver would be an exception.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.15-rc2.orig/drivers/video/fbdev/Kconfig	2014-04-22 14:20:30.949107522 +0200
+++ linux-3.15-rc2/drivers/video/fbdev/Kconfig	2014-04-23 11:51:17.163933232 +0200
@@ -2169,7 +2169,7 @@ config FB_XILINX
 
 config FB_GOLDFISH
 	tristate "Goldfish Framebuffer"
-	depends on FB && HAS_DMA
+	depends on FB && HAS_DMA && (GOLDFISH || COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT


-- 
Jean Delvare
SUSE L3 Support

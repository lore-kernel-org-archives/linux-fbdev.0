From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 24 Apr 2014 08:32:58 +0000
Subject: [PATCH v2] fbdev: Fix tmiofb driver dependencies
Message-Id: <20140424103258.4083cb69@endymion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The tmiofb driver should not depend on MFD_CORE but on MFD_TMIO.
Without the tmio_core driver, tmiofb has no platform device to bind
to and is thus useless.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
I suspect that MFD_TMIO was originally intended and MFD_CORE was a
typo.

Changes since v1:
 * Added COMPILE_TEST as suggested by Geert Uytterhoeven.

 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.15-rc2.orig/drivers/video/fbdev/Kconfig	2014-04-23 11:51:17.163933232 +0200
+++ linux-3.15-rc2/drivers/video/fbdev/Kconfig	2014-04-24 09:49:07.433062918 +0200
@@ -1993,7 +1993,7 @@ config FB_SH_MOBILE_HDMI
 
 config FB_TMIO
 	tristate "Toshiba Mobile IO FrameBuffer support"
-	depends on FB && MFD_CORE
+	depends on FB && (MFD_TMIO || COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT


-- 
Jean Delvare
SUSE L3 Support

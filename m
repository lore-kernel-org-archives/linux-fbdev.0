From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 23 Apr 2014 11:51:04 +0000
Subject: [PATCH] fbdev: Fix tmiofb driver dependencies
Message-Id: <20140423135104.2974008f@endymion.delvare>
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

 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.15-rc2.orig/drivers/video/fbdev/Kconfig	2014-04-23 11:51:17.163933232 +0200
+++ linux-3.15-rc2/drivers/video/fbdev/Kconfig	2014-04-23 13:40:01.170774059 +0200
@@ -1993,7 +1993,7 @@ config FB_SH_MOBILE_HDMI
 
 config FB_TMIO
 	tristate "Toshiba Mobile IO FrameBuffer support"
-	depends on FB && MFD_CORE
+	depends on FB && MFD_TMIO
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT

-- 
Jean Delvare
SUSE L3 Support

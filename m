From: Alexander Shiyan <shc_work@mail.ru>
Date: Thu, 20 Mar 2014 06:58:31 +0000
Subject: [PATCH] video: imxfb: Select LCD_CLASS_DEVICE unconditionally
Message-Id: <1395298711-14619-1-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

FB driver uses lowlevel controls for LCD powering and contrast changing.
Since LCD class cannot be used as an optional feature and should be
compiled for using in the driver, this patch selects LCD_CLASS_DEVICE
symbol for the driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/video/fbdev/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 67409e0..b7cb0af 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -328,6 +328,8 @@ config FB_SA1100
 config FB_IMX
 	tristate "Freescale i.MX1/21/25/27 LCD support"
 	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
+	select BACKLIGHT_LCD_SUPPORT
+	select LCD_CLASS_DEVICE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.8.3.2


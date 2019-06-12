From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Date: Wed, 12 Jun 2019 13:27:01 +0000
Subject: [PATCH v1] backlight: Don't build support by default
Message-Id: <70bd61f9-8fc5-75b1-9f32-7a5826ce6b48@free.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: DRI <dri-devel@lists.freedesktop.org>, fbdev <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Antonino Daplas <adaplas@gmail.com>

b20c5249aa6a ("backlight: Fix compile error if CONFIG_FB is unset")
added 'default m' for BACKLIGHT_CLASS_DEVICE and LCD_CLASS_DEVICE.

Let's go back to not building support by default.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 drivers/video/backlight/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 8b081d61773e..40676be2e46a 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -10,7 +10,6 @@ menu "Backlight & LCD device support"
 #
 config LCD_CLASS_DEVICE
         tristate "Lowlevel LCD controls"
-	default m
 	help
 	  This framework adds support for low-level control of LCD.
 	  Some framebuffer devices connect to platform-specific LCD modules
@@ -143,7 +142,6 @@ endif # LCD_CLASS_DEVICE
 #
 config BACKLIGHT_CLASS_DEVICE
         tristate "Lowlevel Backlight controls"
-	default m
 	help
 	  This framework adds support for low-level control of the LCD
           backlight. This includes support for brightness and power.
-- 
2.17.1

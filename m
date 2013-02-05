From: Johan Hovold <jhovold@gmail.com>
Date: Tue, 05 Feb 2013 13:35:12 +0000
Subject: [PATCH 2/5] ARM: at91/neocore926: fix LCD-wiring mode
Message-Id: <1360071315-4032-3-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130129135435.GN7360@game.jcrosoft.org>
 <1360071315-4032-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1360071315-4032-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Fix regression introduced by commit 787f9fd23283 ("atmel_lcdfb: support
16bit BGR:565 mode, remove unsupported 15bit modes") which broke 16-bpp
modes for older SOCs which use IBGR:555 (msb is intensity) rather than
BGR:565.

The above commit also removed the RGB:555-wiring hack without fixing the
neocore926 board which used it. Fix by specifying RGB-wiring and let the
driver handle the final SOC-dependant layout.

Remove the no longer used ATMEL_LCDC_WIRING_RGB555 define.

Compile-only tested.

Cc: <stable@vger.kernel.org>
Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 arch/arm/mach-at91/board-neocore926.c | 2 +-
 include/video/atmel_lcdc.h            | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index bc7a1c4..4726297 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -266,7 +266,7 @@ static struct atmel_lcdfb_info __initdata neocore926_lcdc_data = {
 	.default_monspecs		= &at91fb_default_monspecs,
 	.atmel_lcdfb_power_control	= at91_lcdc_power_control,
 	.guard_time			= 1,
-	.lcd_wiring_mode		= ATMEL_LCDC_WIRING_RGB555,
+	.lcd_wiring_mode		= ATMEL_LCDC_WIRING_RGB,
 };
 
 #else
diff --git a/include/video/atmel_lcdc.h b/include/video/atmel_lcdc.h
index 5f0e234..8deb226 100644
--- a/include/video/atmel_lcdc.h
+++ b/include/video/atmel_lcdc.h
@@ -30,7 +30,6 @@
  */
 #define ATMEL_LCDC_WIRING_BGR	0
 #define ATMEL_LCDC_WIRING_RGB	1
-#define ATMEL_LCDC_WIRING_RGB555	2
 
 
  /* LCD Controller info data structure, stored in device platform_data */
-- 
1.8.1.1


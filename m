From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:49 +0000
Subject: [PATCH 14/19] sh: ap325rxa: Remove unused get_brightness LCDC callback
Message-Id: <1345122054-16013-15-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/sh/boards/mach-ap325rxa/setup.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index f33ebf4..8a5ea1a 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -171,11 +171,6 @@ static int ap320_wvga_set_brightness(int brightness)
 	return 0;
 }
 
-static int ap320_wvga_get_brightness(void)
-{
-	return gpio_get_value(GPIO_PTS3);
-}
-
 static void ap320_wvga_power_on(void)
 {
 	msleep(100);
@@ -224,7 +219,6 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 			.name = "sh_mobile_lcdc_bl",
 			.max_brightness = 1,
 			.set_brightness = ap320_wvga_set_brightness,
-			.get_brightness = ap320_wvga_get_brightness,
 		},
 	}
 };
-- 
1.7.8.6


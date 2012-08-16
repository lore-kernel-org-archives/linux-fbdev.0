From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:48 +0000
Subject: [PATCH 13/19] ARM: mach-shmobile: mackerel: Removed unused get_brightness callback
Message-Id: <1345122054-16013-14-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index b577f7c..10d9a63 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -365,11 +365,6 @@ static int mackerel_set_brightness(int brightness)
 	return 0;
 }
 
-static int mackerel_get_brightness(void)
-{
-	return gpio_get_value(GPIO_PORT31);
-}
-
 static const struct sh_mobile_meram_cfg lcd_meram_cfg = {
 	.icb[0] = {
 		.meram_size     = 0x40,
@@ -398,7 +393,6 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 			.name = "sh_mobile_lcdc_bl",
 			.max_brightness = 1,
 			.set_brightness = mackerel_set_brightness,
-			.get_brightness = mackerel_get_brightness,
 		},
 		.meram_cfg = &lcd_meram_cfg,
 	}
-- 
1.7.8.6


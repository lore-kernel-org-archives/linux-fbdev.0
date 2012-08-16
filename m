From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:50 +0000
Subject: [PATCH 15/19] sh: ecovec24: Remove unused get_brightness LCDC callback
Message-Id: <1345122054-16013-16-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 4158d70..d9b0a76 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -319,11 +319,6 @@ static int ecovec24_set_brightness(int brightness)
 	return 0;
 }
 
-static int ecovec24_get_brightness(void)
-{
-	return gpio_get_value(GPIO_PTR1);
-}
-
 static struct sh_mobile_lcdc_info lcdc_info = {
 	.ch[0] = {
 		.interface_type = RGB18,
@@ -337,7 +332,6 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 			.name = "sh_mobile_lcdc_bl",
 			.max_brightness = 1,
 			.set_brightness = ecovec24_set_brightness,
-			.get_brightness = ecovec24_get_brightness,
 		},
 	}
 };
-- 
1.7.8.6


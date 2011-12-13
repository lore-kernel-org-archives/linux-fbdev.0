From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:47 +0000
Subject: [PATCH 52/57] arm: mach-shmobile: Constify sh_mobile_meram_cfg structures
Message-Id: <1323784972-24205-53-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The structures, passed to the sh_mobile_lcdcfb driver through platform
data, are read only by the driver. Make them const.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c   |    5 +++--
 arch/arm/mach-shmobile/board-mackerel.c |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index d6d9e0f..8dc6f4e 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -587,7 +587,8 @@ static const struct fb_videomode ap4evb_lcdc_modes[] = {
 #endif
 	},
 };
-static struct sh_mobile_meram_cfg lcd_meram_cfg = {
+
+static const struct sh_mobile_meram_cfg lcd_meram_cfg = {
 	.icb[0] = {
 		.meram_size     = 0x40,
 	},
@@ -852,7 +853,7 @@ static long ap4evb_clk_optimize(unsigned long target, unsigned long *best_freq,
 	return error;
 }
 
-static struct sh_mobile_meram_cfg hdmi_meram_cfg = {
+static const struct sh_mobile_meram_cfg hdmi_meram_cfg = {
 	.icb[0] = {
 		.meram_size     = 0x100,
 	},
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 6e0db88..53b32c2 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -374,7 +374,7 @@ static int mackerel_get_brightness(void)
 	return gpio_get_value(GPIO_PORT31);
 }
 
-static struct sh_mobile_meram_cfg lcd_meram_cfg = {
+static const struct sh_mobile_meram_cfg lcd_meram_cfg = {
 	.icb[0] = {
 		.meram_size     = 0x40,
 	},
@@ -460,7 +460,7 @@ static struct platform_device hdmi_device = {
 	},
 };
 
-static struct sh_mobile_meram_cfg hdmi_meram_cfg = {
+static const struct sh_mobile_meram_cfg hdmi_meram_cfg = {
 	.icb[0] = {
 		.meram_size     = 0x100,
 	},
-- 
1.7.3.4


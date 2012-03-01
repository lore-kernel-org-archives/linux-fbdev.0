From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 01 Mar 2012 15:08:02 +0000
Subject: [PATCH v2 49/57] arm: mach-shmobile: Don't set MERAM ICB numbers in platform data
Message-Id: <1330614490-14149-50-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The marker and cache ICBs are now allocated automatically, there's no
need to specify them manually anymore.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c   |    8 --------
 arch/arm/mach-shmobile/board-mackerel.c |    8 --------
 2 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index f215818..9d6ad2d 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -589,13 +589,9 @@ static const struct fb_videomode ap4evb_lcdc_modes[] = {
 };
 static struct sh_mobile_meram_cfg lcd_meram_cfg = {
 	.icb[0] = {
-		.marker_icb     = 28,
-		.cache_icb      = 24,
 		.meram_size     = 0x40,
 	},
 	.icb[1] = {
-		.marker_icb     = 29,
-		.cache_icb      = 25,
 		.meram_size     = 0x40,
 	},
 };
@@ -870,13 +866,9 @@ static long ap4evb_clk_optimize(unsigned long target, unsigned long *best_freq,
 
 static struct sh_mobile_meram_cfg hdmi_meram_cfg = {
 	.icb[0] = {
-		.marker_icb     = 30,
-		.cache_icb      = 26,
 		.meram_size     = 0x100,
 	},
 	.icb[1] = {
-		.marker_icb     = 31,
-		.cache_icb      = 27,
 		.meram_size     = 0x100,
 	},
 };
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 3b85509..4acd748 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -376,13 +376,9 @@ static int mackerel_get_brightness(void)
 
 static struct sh_mobile_meram_cfg lcd_meram_cfg = {
 	.icb[0] = {
-		.marker_icb     = 28,
-		.cache_icb      = 24,
 		.meram_size     = 0x40,
 	},
 	.icb[1] = {
-		.marker_icb     = 29,
-		.cache_icb      = 25,
 		.meram_size     = 0x40,
 	},
 };
@@ -466,13 +462,9 @@ static struct platform_device hdmi_device = {
 
 static struct sh_mobile_meram_cfg hdmi_meram_cfg = {
 	.icb[0] = {
-		.marker_icb     = 30,
-		.cache_icb      = 26,
 		.meram_size     = 0x100,
 	},
 	.icb[1] = {
-		.marker_icb     = 31,
-		.cache_icb      = 27,
 		.meram_size     = 0x100,
 	},
 };
-- 
1.7.3.4


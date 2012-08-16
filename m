From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:45 +0000
Subject: [PATCH 10/19] ARM: mach-shmobile: Remove the unused sh_mipi_dsi_info lcd_chan field
Message-Id: <1345122054-16013-11-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |    3 ---
 arch/arm/mach-shmobile/board-ap4evb.c |    3 ---
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 5523bc8..7d6b96b 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -253,11 +253,8 @@ sh_mipi_set_dot_clock_pck_err:
 	return ret;
 }
 
-static struct sh_mobile_lcdc_info lcdc0_info;
-
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
-	.lcd_chan	= &lcdc0_info.ch[0],
 	.channel	= LCDC_CHAN_MAINLCD,
 	.lane		= 2,
 	.vsynw_offset	= 20,
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 5fbd176..09f4e0a 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -527,11 +527,8 @@ static struct resource mipidsi0_resources[] = {
 	},
 };
 
-static struct sh_mobile_lcdc_info lcdc_info;
-
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
-	.lcd_chan	= &lcdc_info.ch[0],
 	.channel	= LCDC_CHAN_MAINLCD,
 	.lane		= 2,
 	.vsynw_offset	= 17,
-- 
1.7.8.6


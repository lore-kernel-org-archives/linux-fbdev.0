From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:41 +0000
Subject: [PATCH 06/19] ARM: mach-shmobile: Initiliaze the new sh_mipi_dsi_info channel field
Message-Id: <1345122054-16013-7-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |    1 +
 arch/arm/mach-shmobile/board-ap4evb.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index afae573..5523bc8 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -258,6 +258,7 @@ static struct sh_mobile_lcdc_info lcdc0_info;
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
 	.lcd_chan	= &lcdc0_info.ch[0],
+	.channel	= LCDC_CHAN_MAINLCD,
 	.lane		= 2,
 	.vsynw_offset	= 20,
 	.clksrc		= 1,
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index ace6024..5fbd176 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -532,6 +532,7 @@ static struct sh_mobile_lcdc_info lcdc_info;
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
 	.lcd_chan	= &lcdc_info.ch[0],
+	.channel	= LCDC_CHAN_MAINLCD,
 	.lane		= 2,
 	.vsynw_offset	= 17,
 	.phyctrl	= 0x6 << 8,
-- 
1.7.8.6


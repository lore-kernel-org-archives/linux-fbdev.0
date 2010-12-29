From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 29 Dec 2010 08:12:26 +0000
Subject: [PATCH 2/3] ARM: mach-shmobile: specify sh7372 MIPI DSI register
Message-Id: <Pine.LNX.4.64.1012290908350.14233@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Prepare the ap4evb board for the MIPI DSI driver transition to support
different register layouts.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index f0b8650..b1b372e 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -519,6 +519,7 @@ static struct resource mipidsi0_resources[] = {
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
 	.lcd_chan	= &lcdc_info.ch[0],
+	.vsynw_offset	= 17,
 };
 
 static struct platform_device mipidsi0_device = {
-- 
1.7.2.3


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 09 Nov 2011 04:35:27 +0000
Subject: [PATCH 11/15] fbdev: sh_mipi_dsi: add HSxxCLK support
Message-Id: <87obwlap6c.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

SH MIPI manual explains the calculation method of HBP/HFP.
it is based on HSbyteCLK settings.
SH73a0 chip can use HS6divCLK/HS4divCLK for it.
This patch has compatibility to SH7372 mipi

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |    5 +++--
 arch/arm/mach-shmobile/board-ap4evb.c |    3 ++-
 drivers/video/sh_mipi_dsi.c           |   14 ++++++++++----
 include/video/sh_mipi_dsi.h           |    4 ++++
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index a0b7f8d..d109bed 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -357,8 +357,9 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
 	.lane		= 2,
 	.vsynw_offset	= 20,
 	.clksrc		= 1,
-	.flags		= SH_MIPI_DSI_HSABM |
-			  SH_MIPI_DSI_SYNC_PULSES_MODE,
+	.flags		= SH_MIPI_DSI_HSABM		|
+			  SH_MIPI_DSI_SYNC_PULSES_MODE	|
+			  SH_MIPI_DSI_HSbyteCLK,
 	.set_dot_clock	= sh_mipi_set_dot_clock,
 };
 
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 47f899b..e677c72 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -606,7 +606,8 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
 	.lcd_chan	= &lcdc_info.ch[0],
 	.lane		= 2,
 	.vsynw_offset	= 17,
-	.flags		= SH_MIPI_DSI_SYNC_PULSES_MODE,
+	.flags		= SH_MIPI_DSI_SYNC_PULSES_MODE |
+			  SH_MIPI_DSI_HSbyteCLK,
 	.set_dot_clock	= sh_mipi_set_dot_clock,
 };
 
diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 77743f4..b8aea8c 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -153,7 +153,7 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	void __iomem *base = mipi->base;
 	struct sh_mobile_lcdc_chan_cfg *ch = pdata->lcd_chan;
 	u32 pctype, datatype, pixfmt, linelength, vmctr2;
-	u32 tmp, top, bottom, delay;
+	u32 tmp, top, bottom, delay, div;
 	bool yuv;
 	int bpp;
 
@@ -364,17 +364,23 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	bottom	= 0x00000001;
 	delay	= 0;
 
+	div = 1;	/* HSbyteCLK is calculation base
+			 * HS4divCLK = HSbyteCLK/2
+			 * HS6divCLK is not supported for now */
+	if (pdata->flags & SH_MIPI_DSI_HS4divCLK)
+		div = 2;
+
 	if (pdata->flags & SH_MIPI_DSI_HFPBM) {	/* HBPLEN */
 		top = ch->lcd_cfg[0].hsync_len + ch->lcd_cfg[0].left_margin;
-		top = ((pdata->lane * top) - 10) << 16;
+		top = ((pdata->lane * top / div) - 10) << 16;
 	}
 	if (pdata->flags & SH_MIPI_DSI_HBPBM) { /* HFPLEN */
 		bottom = ch->lcd_cfg[0].right_margin;
-		bottom = (pdata->lane * bottom) - 12;
+		bottom = (pdata->lane * bottom / div) - 12;
 	}
 
 	bpp = linelength / ch->lcd_cfg[0].xres; /* byte / pixel */
-	if (pdata->lane > bpp) {
+	if ((pdata->lane / div) > bpp) {
 		tmp = ch->lcd_cfg[0].xres / bpp; /* output cycle */
 		tmp = ch->lcd_cfg[0].xres - tmp; /* (input - output) cycle */
 		delay = (pdata->lane * tmp);
diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index 310b883..434d56b 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -35,6 +35,10 @@ struct sh_mobile_lcdc_chan_cfg;
 #define SH_MIPI_DSI_HSEE	(1 << 5)
 #define SH_MIPI_DSI_HSAE	(1 << 6)
 
+#define SH_MIPI_DSI_HSbyteCLK	(1 << 24)
+#define SH_MIPI_DSI_HS6divCLK	(1 << 25)
+#define SH_MIPI_DSI_HS4divCLK	(1 << 26)
+
 #define SH_MIPI_DSI_SYNC_PULSES_MODE	(SH_MIPI_DSI_VSEE | \
 					 SH_MIPI_DSI_HSEE | \
 					 SH_MIPI_DSI_HSAE)
-- 
1.7.5.4


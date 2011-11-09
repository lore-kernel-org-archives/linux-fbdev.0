From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 09 Nov 2011 04:34:55 +0000
Subject: [PATCH 08/15] fbdev: sh_mipi_dsi: add sync_pulses/sync_events/burst mode
Message-Id: <87sjlxap77.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |    3 ++-
 arch/arm/mach-shmobile/board-ap4evb.c |    1 +
 drivers/video/sh_mipi_dsi.c           |    9 ++++++++-
 include/video/sh_mipi_dsi.h           |    9 +++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index dd3881a..0895671 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -327,7 +327,8 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
 	.lane		= 2,
 	.vsynw_offset	= 20,
 	.clksrc		= 1,
-	.flags		= SH_MIPI_DSI_HSABM,
+	.flags		= SH_MIPI_DSI_HSABM |
+			  SH_MIPI_DSI_SYNC_PULSES_MODE,
 };
 
 static struct platform_device mipidsi0_device = {
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 187d6fc..9b39e86 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -582,6 +582,7 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
 	.lcd_chan	= &lcdc_info.ch[0],
 	.lane		= 2,
 	.vsynw_offset	= 17,
+	.flags		= SH_MIPI_DSI_SYNC_PULSES_MODE,
 };
 
 static struct platform_device mipidsi0_device = {
diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index af6bec2..b8c4873 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -152,7 +152,7 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 {
 	void __iomem *base = mipi->base;
 	struct sh_mobile_lcdc_chan_cfg *ch = pdata->lcd_chan;
-	u32 pctype, datatype, pixfmt, linelength, vmctr2 = 0x00e00000;
+	u32 pctype, datatype, pixfmt, linelength, vmctr2;
 	bool yuv;
 	u32 tmp;
 
@@ -324,6 +324,13 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	 * Non-burst mode with sync pulses: VSE and HSE are output,
 	 * HSA period allowed, no commands in LP
 	 */
+	vmctr2 = 0;
+	if (pdata->flags & SH_MIPI_DSI_VSEE)
+		vmctr2 |= 1 << 23;
+	if (pdata->flags & SH_MIPI_DSI_HSEE)
+		vmctr2 |= 1 << 22;
+	if (pdata->flags & SH_MIPI_DSI_HSAE)
+		vmctr2 |= 1 << 21;
 	if (pdata->flags & SH_MIPI_DSI_BL2E)
 		vmctr2 |= 1 << 17;
 	if (pdata->flags & SH_MIPI_DSI_HSABM)
diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index 3d0ec50..c8225b4 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -31,6 +31,15 @@ struct sh_mobile_lcdc_chan_cfg;
 #define SH_MIPI_DSI_HBPBM	(1 << 1)
 #define SH_MIPI_DSI_HFPBM	(1 << 2)
 #define SH_MIPI_DSI_BL2E	(1 << 3)
+#define SH_MIPI_DSI_VSEE	(1 << 4)
+#define SH_MIPI_DSI_HSEE	(1 << 5)
+#define SH_MIPI_DSI_HSAE	(1 << 6)
+
+#define SH_MIPI_DSI_SYNC_PULSES_MODE	(SH_MIPI_DSI_VSEE | \
+					 SH_MIPI_DSI_HSEE | \
+					 SH_MIPI_DSI_HSAE)
+#define SH_MIPI_DSI_SYNC_EVENTS_MODE	(0)
+#define SH_MIPI_DSI_SYNC_BURST_MODE	(SH_MIPI_DSI_BL2E)
 
 struct sh_mipi_dsi_info {
 	enum sh_mipi_dsi_data_fmt	data_format;
-- 
1.7.5.4


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 09 Nov 2011 04:34:43 +0000
Subject: [PATCH 07/15] fbdev: sh_mipi_dsi: add lane control support
Message-Id: <87ty6dap7k.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

SH MIPI DSI can use 0-4 lane

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |    1 +
 arch/arm/mach-shmobile/board-ap4evb.c |    1 +
 drivers/video/sh_mipi_dsi.c           |   10 +++++++++-
 include/video/sh_mipi_dsi.h           |    1 +
 4 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 83624e2..dd3881a 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -324,6 +324,7 @@ static struct resource mipidsi0_resources[] = {
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
 	.lcd_chan	= &lcdc0_info.ch[0],
+	.lane		= 2,
 	.vsynw_offset	= 20,
 	.clksrc		= 1,
 	.flags		= SH_MIPI_DSI_HSABM,
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index a3aa0f6..187d6fc 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -580,6 +580,7 @@ static struct resource mipidsi0_resources[] = {
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
 	.lcd_chan	= &lcdc_info.ch[0],
+	.lane		= 2,
 	.vsynw_offset	= 17,
 };
 
diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index dfd5154..af6bec2 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/bitmap.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -153,6 +154,7 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	struct sh_mobile_lcdc_chan_cfg *ch = pdata->lcd_chan;
 	u32 pctype, datatype, pixfmt, linelength, vmctr2 = 0x00e00000;
 	bool yuv;
+	u32 tmp;
 
 	/*
 	 * Select data format. MIPI DSI is not hot-pluggable, so, we just use
@@ -253,6 +255,9 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	    (!yuv && ch->interface_type != RGB24))
 		return -EINVAL;
 
+	if (!pdata->lane)
+		return -EINVAL;
+
 	/* reset DSI link */
 	iowrite32(0x00000001, base + SYSCTRL);
 	/* Hold reset for 100 cycles of the slowest of bus, HS byte and LP clock */
@@ -269,7 +274,10 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	 *	ECC check enable
 	 * additionally enable first two lanes
 	 */
-	iowrite32(0x00003703, base + SYSCONF);
+	bitmap_fill((unsigned long *)&tmp, pdata->lane);
+	tmp |= 0x00003700;
+	iowrite32(tmp, base + SYSCONF);
+
 	/*
 	 * T_wakeup = 0x7000
 	 * T_hs-trail = 3
diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index 58b78f8..3d0ec50 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -35,6 +35,7 @@ struct sh_mobile_lcdc_chan_cfg;
 struct sh_mipi_dsi_info {
 	enum sh_mipi_dsi_data_fmt	data_format;
 	struct sh_mobile_lcdc_chan_cfg	*lcd_chan;
+	int				lane;
 	unsigned long			flags;
 	u32				clksrc;
 	unsigned int			vsynw_offset;
-- 
1.7.5.4


From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 29 Dec 2010 08:12:29 +0000
Subject: [PATCH 3/3] fbdev: sh_mipi_dsi: use platform provided register layout
Message-Id: <Pine.LNX.4.64.1012290909220.14233@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Different sh-mobile SoCs have variations in their MIPI DSI register layouts,
besides, different LCD panels require different configuration parameters. This
patch switches the driver to use platform-provided MIPI DSI parameters.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mipi_dsi.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 3563188..884af92 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -123,8 +123,7 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 {
 	void __iomem *base = mipi->base;
 	struct sh_mobile_lcdc_chan_cfg *ch = pdata->lcd_chan;
-	u32 pctype, datatype, pixfmt;
-	u32 linelength;
+	u32 pctype, datatype, pixfmt, linelength, vmctr2 = 0x00e00000;
 	bool yuv;
 
 	/*
@@ -281,16 +280,22 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	 */
 	iowrite32(0x00000006, base + 0x8000); /* DTCTR */
 	/* VSYNC width = 2 (<< 17) */
-	iowrite32(0x00040000 | (pctype << 12) | datatype, base + 0x8020); /* VMCTR1 */
+	iowrite32((ch->lcd_cfg[0].vsync_len << pdata->vsynw_offset) |
+		  (pdata->clksrc << 16) | (pctype << 12) | datatype,
+		  base + 0x8020); /* VMCTR1 */
 	/*
 	 * Non-burst mode with sync pulses: VSE and HSE are output,
 	 * HSA period allowed, no commands in LP
 	 */
-	iowrite32(0x00e00000, base + 0x8024); /* VMCTR2 */
+	if (pdata->flags & SH_MIPI_DSI_HSABM)
+		vmctr2 |= 0x20;
+	if (pdata->flags & SH_MIPI_DSI_HSPBM)
+		vmctr2 |= 0x10;
+	iowrite32(vmctr2, base + 0x8024); /* VMCTR2 */
 	/*
 	 * 0x660 = 1632 bytes per line (RGB24, 544 pixels: see
 	 * sh_mobile_lcdc_info.ch[0].lcd_cfg[0].xres), HSALEN = 1 - default
-	 * (unused, since VMCTR2[HSABM] = 0)
+	 * (unused, if VMCTR2[HSABM] = 0)
 	 */
 	iowrite32(1 | (linelength << 16), base + 0x8028); /* VMLEN1 */
 
-- 
1.7.2.3


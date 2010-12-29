From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 29 Dec 2010 08:12:22 +0000
Subject: [PATCH 1/3] fbdev: sh_mipi_dsi: support different register layouts
Message-Id: <Pine.LNX.4.64.1012290907440.14233@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The register layout of the MIPI DSI unit on sh-mobile SoCs differ. Add platform
parameters to support such variations.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/video/sh_mipi_dsi.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index 18bca08..6cb95c9 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -27,9 +27,15 @@ enum sh_mipi_dsi_data_fmt {
 
 struct sh_mobile_lcdc_chan_cfg;
 
+#define SH_MIPI_DSI_HSABM	(1 << 0)
+#define SH_MIPI_DSI_HSPBM	(1 << 1)
+
 struct sh_mipi_dsi_info {
 	enum sh_mipi_dsi_data_fmt	data_format;
 	struct sh_mobile_lcdc_chan_cfg	*lcd_chan;
+	unsigned long			flags;
+	u32				clksrc;
+	unsigned int			vsynw_offset;
 };
 
 #endif
-- 
1.7.2.3


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 09 Nov 2011 04:34:33 +0000
Subject: [PATCH 06/15] fbdev: sh_mipi_dsi: add SH_MIPI_DSI_BL2E flag
Message-Id: <87vcqtap7t.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mipi_dsi.c |    2 ++
 include/video/sh_mipi_dsi.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index c9fac13..dfd5154 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -316,6 +316,8 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	 * Non-burst mode with sync pulses: VSE and HSE are output,
 	 * HSA period allowed, no commands in LP
 	 */
+	if (pdata->flags & SH_MIPI_DSI_BL2E)
+		vmctr2 |= 1 << 17;
 	if (pdata->flags & SH_MIPI_DSI_HSABM)
 		vmctr2 |= 1 << 5;
 	if (pdata->flags & SH_MIPI_DSI_HBPBM)
diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index 86a72c0..58b78f8 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -30,6 +30,7 @@ struct sh_mobile_lcdc_chan_cfg;
 #define SH_MIPI_DSI_HSABM	(1 << 0)
 #define SH_MIPI_DSI_HBPBM	(1 << 1)
 #define SH_MIPI_DSI_HFPBM	(1 << 2)
+#define SH_MIPI_DSI_BL2E	(1 << 3)
 
 struct sh_mipi_dsi_info {
 	enum sh_mipi_dsi_data_fmt	data_format;
-- 
1.7.5.4


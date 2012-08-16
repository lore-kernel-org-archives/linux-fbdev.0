From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:46 +0000
Subject: [PATCH 11/19] fbdev: sh_mipi_dsi: Remove the unused sh_mipi_dsi_info lcd_chan field
Message-Id: <1345122054-16013-12-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The field is unused, remove it from the structure.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/video/sh_mipi_dsi.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index eae71d9..a01f197 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -25,8 +25,6 @@ enum sh_mipi_dsi_data_fmt {
 	MIPI_YUV420,
 };
 
-struct sh_mobile_lcdc_chan_cfg;
-
 #define SH_MIPI_DSI_HSABM	(1 << 0)
 #define SH_MIPI_DSI_HBPBM	(1 << 1)
 #define SH_MIPI_DSI_HFPBM	(1 << 2)
@@ -47,7 +45,6 @@ struct sh_mobile_lcdc_chan_cfg;
 
 struct sh_mipi_dsi_info {
 	enum sh_mipi_dsi_data_fmt	data_format;
-	struct sh_mobile_lcdc_chan_cfg	*lcd_chan;
 	int				channel;
 	int				lane;
 	unsigned long			flags;
-- 
1.7.8.6


From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:40 +0000
Subject: [PATCH 05/19] fbdev: sh_mipi_dsi: Add channel field to platform data
Message-Id: <1345122054-16013-6-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The channel field stores the LCDC channel corresponding to the MIPI-DSI
transmitter. The information is currently obtained through the lcd_chan
field that will be removed.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/video/sh_mipi_dsi.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index 06c67fb..eae71d9 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -48,6 +48,7 @@ struct sh_mobile_lcdc_chan_cfg;
 struct sh_mipi_dsi_info {
 	enum sh_mipi_dsi_data_fmt	data_format;
 	struct sh_mobile_lcdc_chan_cfg	*lcd_chan;
+	int				channel;
 	int				lane;
 	unsigned long			flags;
 	u32				clksrc;
-- 
1.7.8.6


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Apr 2014 10:17:11 +0000
Subject: [PATCH 15/23] OMAPDSS: DPI: fix LCD3 DSI source
Message-Id: <1398334639-14172-16-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

At the moment the dpi driver does not handle LCD3 clock source at all.

LCD3 channel gets the DSI PLL clock from DSI2 instance. Add support for
LCD3's clock source in the dpi driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 157921db447a..8e097fb58a9c 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -103,6 +103,8 @@ static enum omap_dss_clk_source dpi_get_alt_clk_src(enum omap_channel channel)
 		return OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC;
 	default:
 		/* this shouldn't happen */
 		WARN_ON(1);
-- 
1.9.1


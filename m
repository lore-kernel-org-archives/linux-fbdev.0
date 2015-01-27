From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Jan 2015 10:50:32 +0000
Subject: [PATCH 04/14] OMAPDSS: OMAP5: fix digit output's allowed mgrs
Message-Id: <1422355842-11234-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The OMAP5 HW supports directing DIGIT channel to DPI output, but the
driver doesn't support that. However, we have marked that configuration
as possible in the dss features, so in certain cases the driver tries to
use that configuration, leading to broken display.

Fix the problem by allowing DIGIT channel to go only to HDMI output.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss_features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss_features.c b/drivers/video/fbdev/omap2/dss/dss_features.c
index 0e3da809473c..0e6f3f54749f 100644
--- a/drivers/video/fbdev/omap2/dss/dss_features.c
+++ b/drivers/video/fbdev/omap2/dss/dss_features.c
@@ -223,7 +223,7 @@ static const enum omap_dss_output_id omap5_dss_supported_outputs[] = {
 	OMAP_DSS_OUTPUT_DSI1 | OMAP_DSS_OUTPUT_DSI2,
 
 	/* OMAP_DSS_CHANNEL_DIGIT */
-	OMAP_DSS_OUTPUT_HDMI | OMAP_DSS_OUTPUT_DPI,
+	OMAP_DSS_OUTPUT_HDMI,
 
 	/* OMAP_DSS_CHANNEL_LCD2 */
 	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
-- 
2.2.2


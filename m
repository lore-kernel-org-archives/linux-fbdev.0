From: Archit Taneja <archit@ti.com>
Date: Wed, 07 Nov 2012 14:56:27 +0000
Subject: [RFC 09/11] OMAPDSS: FEATURES: Add writeback as supported outputs for OMAP4 managers
Message-Id: <1352299469-17609-10-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <n>
 <1352299469-17609-1-git-send-email-archit@ti.com>
In-Reply-To: <1352299469-17609-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The writeback pipeline can connect to any of the OMAP4 overlay managers. Add it
as a supported output in dss features.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 3e8287c..e8d10cb 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -202,15 +202,15 @@ static const enum omap_dss_output_id omap3630_dss_supported_outputs[] = {
 static const enum omap_dss_output_id omap4_dss_supported_outputs[] = {
 	/* OMAP_DSS_CHANNEL_LCD */
 	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
-	OMAP_DSS_OUTPUT_DSI1,
+	OMAP_DSS_OUTPUT_DSI1 | OMAP_DSS_OUTPUT_WB,
 
 	/* OMAP_DSS_CHANNEL_DIGIT */
 	OMAP_DSS_OUTPUT_VENC | OMAP_DSS_OUTPUT_HDMI |
-	OMAP_DSS_OUTPUT_DPI,
+	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_WB,
 
 	/* OMAP_DSS_CHANNEL_LCD2 */
 	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
-	OMAP_DSS_OUTPUT_DSI2,
+	OMAP_DSS_OUTPUT_DSI2 | OMAP_DSS_OUTPUT_WB,
 };
 
 static const enum omap_dss_output_id omap5_dss_supported_outputs[] = {
-- 
1.7.9.5


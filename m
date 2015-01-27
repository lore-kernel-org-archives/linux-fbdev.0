From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Jan 2015 10:50:31 +0000
Subject: [PATCH 03/14] OMAPDSS: constify port arrays
Message-Id: <1422355842-11234-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The port arrays are constant data, so set them as 'const'.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 9987154d50b4..1884c29ef482 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -70,7 +70,7 @@ struct dss_features {
 	u8 fck_div_max;
 	u8 dss_fck_multiplier;
 	const char *parent_clk_name;
-	enum omap_display_type *ports;
+	const enum omap_display_type *ports;
 	int num_ports;
 	int (*dpi_select_source)(int port, enum omap_channel channel);
 };
@@ -677,11 +677,11 @@ void dss_debug_dump_clocks(struct seq_file *s)
 #endif
 
 
-static enum omap_display_type omap2plus_ports[] = {
+static const enum omap_display_type omap2plus_ports[] = {
 	OMAP_DISPLAY_TYPE_DPI,
 };
 
-static enum omap_display_type omap34xx_ports[] = {
+static const enum omap_display_type omap34xx_ports[] = {
 	OMAP_DISPLAY_TYPE_DPI,
 	OMAP_DISPLAY_TYPE_SDI,
 };
-- 
2.2.2


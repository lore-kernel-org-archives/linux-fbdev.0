From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 09 Jun 2011 13:56:44 +0000
Subject: [PATCHv2 22/28] OMAP: DSS2: Remove unused opt_clock_available
Message-Id: <1307627810-3768-23-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

opt_clock_available() is no longer needed, so remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |   12 ------------
 include/video/omapdss.h       |    2 --
 2 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index c7e19c4..af43620 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -46,17 +46,6 @@ static struct omap_device_pm_latency omap_dss_latency[] = {
 /* oh_core is used for getting opt-clocks */
 static struct omap_hwmod	*oh_core;
 
-static bool opt_clock_available(const char *clk_role)
-{
-	int i;
-
-	for (i = 0; i < oh_core->opt_clks_cnt; i++) {
-		if (!strcmp(oh_core->opt_clks[i].role, clk_role))
-			return true;
-	}
-	return false;
-}
-
 struct omap_dss_hwmod_data {
 	const char *oh_name;
 	const char *dev_name;
@@ -120,7 +109,6 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 	pdata.board_data = board_data;
 	pdata.board_data->get_context_loss_count  		omap_pm_get_dev_context_loss_count;
-	pdata.opt_clock_available = opt_clock_available;
 
 	for (i = 0; i < oh_count; i++) {
 		oh = omap_hwmod_lookup(curr_dss_hwmod[i].oh_name);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 4f914a5..06914b1 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -264,8 +264,6 @@ static inline int omap_display_init(struct omap_dss_board_info *board_data)
 struct omap_display_platform_data {
 	struct omap_dss_board_info *board_data;
 	/* TODO: Additional members to be added when PM is considered */
-
-	bool (*opt_clock_available)(const char *clk_role);
 };
 
 struct omap_video_timings {
-- 
1.7.4.1


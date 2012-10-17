From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Oct 2012 11:20:33 +0000
Subject: [PATCH 7/9] OMAPDSS: DISPC: cleanup lcd and digit enable
Message-Id: <1350472835-28727-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dispc.c's functions to enable LCD and DIGIT outputs can be cleaned up a
bit by using common functions to set the enable bit and to check if the
output is enabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 9f0ce18..492740e 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2591,13 +2591,18 @@ static void dispc_disable_isr(void *data, u32 mask)
 	complete(compl);
 }
 
-static void _enable_lcd_out(enum omap_channel channel, bool enable)
+static void _enable_mgr_out(enum omap_channel channel, bool enable)
 {
 	mgr_fld_write(channel, DISPC_MGR_FLD_ENABLE, enable);
 	/* flush posted write */
 	mgr_fld_read(channel, DISPC_MGR_FLD_ENABLE);
 }
 
+bool dispc_mgr_is_enabled(enum omap_channel channel)
+{
+	return !!mgr_fld_read(channel, DISPC_MGR_FLD_ENABLE);
+}
+
 static void dispc_mgr_enable_lcd_out(enum omap_channel channel, bool enable)
 {
 	struct completion frame_done_completion;
@@ -2608,7 +2613,7 @@ static void dispc_mgr_enable_lcd_out(enum omap_channel channel, bool enable)
 	/* When we disable LCD output, we need to wait until frame is done.
 	 * Otherwise the DSS is still working, and turning off the clocks
 	 * prevents DSS from going to OFF mode */
-	is_on = mgr_fld_read(channel, DISPC_MGR_FLD_ENABLE);
+	is_on = dispc_mgr_is_enabled(channel);
 
 	irq = mgr_desc[channel].framedone_irq;
 
@@ -2622,7 +2627,7 @@ static void dispc_mgr_enable_lcd_out(enum omap_channel channel, bool enable)
 			DSSERR("failed to register FRAMEDONE isr\n");
 	}
 
-	_enable_lcd_out(channel, enable);
+	_enable_mgr_out(channel, enable);
 
 	if (!enable && is_on) {
 		if (!wait_for_completion_timeout(&frame_done_completion,
@@ -2637,13 +2642,6 @@ static void dispc_mgr_enable_lcd_out(enum omap_channel channel, bool enable)
 	}
 }
 
-static void _enable_digit_out(bool enable)
-{
-	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 1, 1);
-	/* flush posted write */
-	dispc_read_reg(DISPC_CONTROL);
-}
-
 static void dispc_mgr_enable_digit_out(bool enable)
 {
 	struct completion frame_done_completion;
@@ -2652,7 +2650,7 @@ static void dispc_mgr_enable_digit_out(bool enable)
 	u32 irq_mask;
 	int num_irqs;
 
-	if (REG_GET(DISPC_CONTROL, 1, 1) = enable)
+	if (dispc_mgr_is_enabled(OMAP_DSS_CHANNEL_DIGIT) = enable)
 		return;
 
 	src = dss_get_hdmi_venc_clk_source();
@@ -2689,7 +2687,7 @@ static void dispc_mgr_enable_digit_out(bool enable)
 	if (r)
 		DSSERR("failed to register %x isr\n", irq_mask);
 
-	_enable_digit_out(enable);
+	_enable_mgr_out(OMAP_DSS_CHANNEL_DIGIT, enable);
 
 	for (i = 0; i < num_irqs; ++i) {
 		if (!wait_for_completion_timeout(&frame_done_completion,
@@ -2713,11 +2711,6 @@ static void dispc_mgr_enable_digit_out(bool enable)
 	}
 }
 
-bool dispc_mgr_is_enabled(enum omap_channel channel)
-{
-	return !!mgr_fld_read(channel, DISPC_MGR_FLD_ENABLE);
-}
-
 void dispc_mgr_enable(enum omap_channel channel, bool enable)
 {
 	if (dss_mgr_is_lcd(channel))
-- 
1.7.9.5


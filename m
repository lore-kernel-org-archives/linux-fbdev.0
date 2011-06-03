From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 03 Jun 2011 10:00:37 +0000
Subject: [PATCH 27/27] OMAP: DSS2: DSS: Fix context save/restore
Message-Id: <1307095237-14805-28-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The current method of saving and restoring the context could cause a
restore before saving, effectively "restoring" zero values to registers.

Add ctx_valid field to indicate if the saved context is valid and can be
restored.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 91572b6..964eb08 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -77,6 +77,7 @@ static struct {
 	enum omap_dss_clk_source dispc_clk_source;
 	enum omap_dss_clk_source lcd_clk_source[MAX_DSS_LCD_MANAGERS];
 
+	bool		ctx_valid;
 	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
 } dss;
 
@@ -112,12 +113,19 @@ static void dss_save_context(void)
 		SR(SDI_CONTROL);
 		SR(PLL_CONTROL);
 	}
+
+	dss.ctx_valid = true;
+
+	DSSDBG("context saved\n");
 }
 
 static void dss_restore_context(void)
 {
 	DSSDBG("dss_restore_context\n");
 
+	if (!dss.ctx_valid)
+		return;
+
 	RR(CONTROL);
 
 	if (dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_LCD) &
@@ -125,6 +133,8 @@ static void dss_restore_context(void)
 		RR(SDI_CONTROL);
 		RR(PLL_CONTROL);
 	}
+
+	DSSDBG("context restored\n");
 }
 
 #undef SR
-- 
1.7.4.1


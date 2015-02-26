From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Feb 2015 12:49:04 +0000
Subject: [PATCH 10/15] OMAPDSS: DISPC: lock access to DISPC_CONTROL & DISPC_CONFIG
Message-Id: <1424954949-12801-10-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Dispc driver presumes that the callers handle locking for all normal
functions. However, omapdrm doesn't handle this, and presumes that all
overlay manager registers are private to that overlay manager, and thus
presumes that configurations for overlay managers can be written via
different threads freely.

For many registers the above is true. The exceptions are DISPC_CONTROL
and DISPC_CONFIG registers, which contain bits for both LCD and TV
overlay managers.

Fixing this properly in omapdrm means a big omapdrm rewrite. So, for
now, add locking to dispc for the problematic registers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reported-by: Somnath Mukherjee <somnath@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 1123111d3940..766c985cbfa7 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -123,6 +123,9 @@ static struct {
 
 	struct regmap *syscon_pol;
 	u32 syscon_pol_offset;
+
+	/* DISPC_CONTROL & DISPC_CONFIG lock*/
+	spinlock_t control_lock;
 } dispc;
 
 enum omap_color_component {
@@ -261,7 +264,16 @@ static u32 mgr_fld_read(enum omap_channel channel, enum mgr_reg_fields regfld)
 static void mgr_fld_write(enum omap_channel channel,
 					enum mgr_reg_fields regfld, int val) {
 	const struct dispc_reg_field rfld = mgr_desc[channel].reg_desc[regfld];
+	const bool need_lock = rfld.reg = DISPC_CONTROL || rfld.reg = DISPC_CONFIG;
+	unsigned long flags;
+
+	if (need_lock)
+		spin_lock_irqsave(&dispc.control_lock, flags);
+
 	REG_FLD_MOD(rfld.reg, val, rfld.high, rfld.low);
+
+	if (need_lock)
+		spin_unlock_irqrestore(&dispc.control_lock, flags);
 }
 
 #define SR(reg) \
@@ -3804,6 +3816,8 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 
 	dispc.pdev = pdev;
 
+	spin_lock_init(&dispc.control_lock);
+
 	r = dispc_init_features(dispc.pdev);
 	if (r)
 		return r;
-- 
2.3.0


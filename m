From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Oct 2012 11:20:28 +0000
Subject: [PATCH 2/9] OMAPDSS: fix registering the vsync isr in apply
Message-Id: <1350472835-28727-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

When we enable an output we don't check if we need to register the vsync
isr. This causes us to miss vsync interrupts until somebody changes the
configuration of an overlay or an overlay manager.

Add the registration to dss_mgr_enable to fix the problem.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 19d66f4..29ce5a8 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1035,6 +1035,9 @@ int dss_mgr_enable(struct omap_overlay_manager *mgr)
 	if (!mgr_manual_update(mgr))
 		mp->updating = true;
 
+	if (!dss_data.irq_enabled && need_isr())
+		dss_register_vsync_isr();
+
 	spin_unlock_irqrestore(&data_lock, flags);
 
 	if (!mgr_manual_update(mgr))
-- 
1.7.9.5


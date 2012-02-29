From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 29 Feb 2012 08:48:22 +0000
Subject: [PATCH 2/2] OMAPDSS: APPLY: make ovl_enable/disable synchronous
Message-Id: <1330505302-8258-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

ovl->enable/disable are meant to be synchronous so that they can handle
the configuration of fifo sizes. The current kernel doesn't configure
fifo sizes yet, and so the code doesn't need to block to function (from
omapdss driver's perspective).

However, for the users of omapdss a non-blocking ovl->disable is
confusing, because they don't know when the memory area is not used
any more.

Furthermore, when the fifo size configuration is added in the next merge
window, the change from non-blocking to blocking could cause side
effects to the users of omapdss. So by making the functions block
already will keep them behaving in the same manner.

And, while not the main purpose of this patch, this will also remove the
compile warning:

drivers/video/omap2/dss/apply.c:350: warning:
'wait_pending_extra_info_updates' defined but not used

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 052dc87..87b3e25 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1276,6 +1276,9 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
+	/* wait for overlay to be enabled */
+	wait_pending_extra_info_updates();
+
 	mutex_unlock(&apply_lock);
 
 	return 0;
@@ -1313,6 +1316,9 @@ int dss_ovl_disable(struct omap_overlay *ovl)
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
+	/* wait for the overlay to be disabled */
+	wait_pending_extra_info_updates();
+
 	mutex_unlock(&apply_lock);
 
 	return 0;
-- 
1.7.4.1


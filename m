From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:22:01 +0000
Subject: [PATCH 62/65] OMAPDSS: APPLY: add dss_mgr_simple_check()
Message-Id: <1321953724-6350-63-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add dss_mgr_simple_check() which is used to check the validity of
certain manager attributes. Only attributes that can be checked
independently, without knowing the display being used, is done here
(thus "simple").

We can use this function in dss_mgr_set_info().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index c1c4597..5d933b9 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -834,11 +834,35 @@ out:
 	mutex_unlock(&apply_lock);
 }
 
+static int dss_mgr_simple_check(struct omap_overlay_manager *mgr,
+		const struct omap_overlay_manager_info *info)
+{
+	if (dss_has_feature(FEAT_ALPHA_FIXED_ZORDER)) {
+		/*
+		 * OMAP3 supports only graphics source transparency color key
+		 * and alpha blending simultaneously. See TRM 15.4.2.4.2.2
+		 * Alpha Mode.
+		 */
+		if (info->partial_alpha_enabled && info->trans_enabled
+			&& info->trans_key_type != OMAP_DSS_COLOR_KEY_GFX_DST) {
+			DSSERR("check_manager: illegal transparency key\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 int dss_mgr_set_info(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	unsigned long flags;
+	int r;
+
+	r = dss_mgr_simple_check(mgr, info);
+	if (r)
+		return r;
 
 	spin_lock_irqsave(&data_lock, flags);
 
-- 
1.7.4.1


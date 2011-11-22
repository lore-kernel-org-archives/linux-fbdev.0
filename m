From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:22:00 +0000
Subject: [PATCH 61/65] OMAPDSS: APPLY: add dss_ovl_simple_check()
Message-Id: <1321953724-6350-62-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add dss_ovl_simple_check() which is used to check the validity of
certain overlay attributes. Only attributes that can be checked
independently, without knowing the display being used, is done here
(thus "simple").

We can use this function in dss_ovl_set_info().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   40 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 6a50ee0..c1c4597 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -928,12 +928,52 @@ err:
 }
 
 
+static int dss_ovl_simple_check(struct omap_overlay *ovl,
+		const struct omap_overlay_info *info)
+{
+	if (info->paddr = 0) {
+		DSSERR("check_overlay: paddr cannot be 0\n");
+		return -EINVAL;
+	}
+
+	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) = 0) {
+		if (info->out_width != 0 && info->width != info->out_width) {
+			DSSERR("check_overlay: overlay %d doesn't support "
+					"scaling\n", ovl->id);
+			return -EINVAL;
+		}
+
+		if (info->out_height != 0 && info->height != info->out_height) {
+			DSSERR("check_overlay: overlay %d doesn't support "
+					"scaling\n", ovl->id);
+			return -EINVAL;
+		}
+	}
+
+	if ((ovl->supported_modes & info->color_mode) = 0) {
+		DSSERR("check_overlay: overlay %d doesn't support mode %d\n",
+				ovl->id, info->color_mode);
+		return -EINVAL;
+	}
+
+	if (info->zorder >= omap_dss_get_num_overlays()) {
+		DSSERR("check_overlay: zorder %d too high\n", info->zorder);
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
 int dss_ovl_set_info(struct omap_overlay *ovl,
 		struct omap_overlay_info *info)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	unsigned long flags;
+	int r;
+
+	r = dss_ovl_simple_check(ovl, info);
+	if (r)
+		return r;
 
 	spin_lock_irqsave(&data_lock, flags);
 
-- 
1.7.4.1


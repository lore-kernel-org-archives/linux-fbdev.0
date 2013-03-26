From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Mar 2013 13:33:32 +0000
Subject: [PATCH 02/26] OMAPDSS: add omap_dss_find_output()
Message-Id: <1364304836-18134-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add a support function to find a DSS output by given name. This is used
in later patches to link the panels to DSS outputs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/output.c |   13 +++++++++++++
 include/video/omapdss.h          |    1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index 5214df6..3274628 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -115,6 +115,19 @@ struct omap_dss_output *omap_dss_get_output(enum omap_dss_output_id id)
 }
 EXPORT_SYMBOL(omap_dss_get_output);
 
+struct omap_dss_output *omap_dss_find_output(const char *name)
+{
+	struct omap_dss_output *out;
+
+	list_for_each_entry(out, &output_list, list) {
+		if (strcmp(out->name, name) = 0)
+			return out;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(omap_dss_find_output);
+
 static const struct dss_mgr_ops *dss_mgr_ops;
 
 int dss_install_mgr_ops(const struct dss_mgr_ops *mgr_ops)
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index d5f1fff..aad47a2 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -779,6 +779,7 @@ int omap_dss_get_num_overlays(void);
 struct omap_overlay *omap_dss_get_overlay(int num);
 
 struct omap_dss_output *omap_dss_get_output(enum omap_dss_output_id id);
+struct omap_dss_output *omap_dss_find_output(const char *name);
 int omapdss_output_set_device(struct omap_dss_output *out,
 		struct omap_dss_device *dssdev);
 int omapdss_output_unset_device(struct omap_dss_output *out);
-- 
1.7.10.4


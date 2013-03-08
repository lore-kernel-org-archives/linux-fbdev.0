From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 08 Mar 2013 11:51:42 +0000
Subject: [PATCH 07/20] OMAPDSS: add missing export for omap_dss_get_output()
Message-Id: <1362743515-10152-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omap_dss_get_output() is a public function, but was missing
EXPORT_SYMBOL().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/output.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index 79dea1a..5214df6 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -113,6 +113,7 @@ struct omap_dss_output *omap_dss_get_output(enum omap_dss_output_id id)
 
 	return NULL;
 }
+EXPORT_SYMBOL(omap_dss_get_output);
 
 static const struct dss_mgr_ops *dss_mgr_ops;
 
-- 
1.7.10.4


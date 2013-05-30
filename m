From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 May 2013 09:34:49 +0000
Subject: [PATCH 28/32] OMAPDSS: omapdss.h: add owner field to omap_dss_device
Message-Id: <1369906493-27538-29-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add struct module *owner field to omap_dss_device, which points to the
module containing the ops for this omap_dss_device. This will be used to
manage the ref count for the module.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 5046264..c32d90e 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -579,6 +579,8 @@ struct omap_dss_device {
 	/* new device, pointer to panel device */
 	struct device *dev;
 
+	struct module *owner;
+
 	struct list_head panel_list;
 
 	/* alias in the form of "display%d" */
-- 
1.8.1.2


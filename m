From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 16 Dec 2013 14:56:14 +0000
Subject: [PATCHv2 07/27] OMAPFB: search for default display with DT alias
Message-Id: <1387205794-32246-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

Improve the search for the default display in two ways:
* compare the given display name to the display's alias
* if no display name is given, look for "display0" DT alias

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 8bfe973e55ec..961c5c251f63 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2413,7 +2413,10 @@ omapfb_find_default_display(struct omapfb2_device *fbdev)
 	const char *def_name;
 	int i;
 
-	/* search with the display name from the user or the board file */
+	/*
+	 * Search with the display name from the user or the board file,
+	 * comparing to display names and aliases
+	 */
 
 	def_name = omapdss_get_default_display_name();
 
@@ -2425,12 +2428,30 @@ omapfb_find_default_display(struct omapfb2_device *fbdev)
 
 			if (dssdev->name && strcmp(def_name, dssdev->name) = 0)
 				return dssdev;
+
+			if (strcmp(def_name, dssdev->alias) = 0)
+				return dssdev;
 		}
 
 		/* def_name given but not found */
 		return NULL;
 	}
 
+	/* then look for DT alias display0 */
+	for (i = 0; i < fbdev->num_displays; ++i) {
+		struct omap_dss_device *dssdev;
+		int id;
+
+		dssdev = fbdev->displays[i].dssdev;
+
+		if (dssdev->dev->of_node = NULL)
+			continue;
+
+		id = of_alias_get_id(dssdev->dev->of_node, "display");
+		if (id = 0)
+			return dssdev;
+	}
+
 	/* return the first display we have in the list */
 	return fbdev->displays[0].dssdev;
 }
-- 
1.8.3.2


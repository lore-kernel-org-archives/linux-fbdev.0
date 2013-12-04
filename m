From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 04 Dec 2013 12:28:35 +0000
Subject: [PATCH 08/26] OMAPFB: clean up default display search
Message-Id: <1386160133-24026-9-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Separate the code for finding the default display into a function for
clarity and to make it easier to extend it in the future.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c | 46 ++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 27d6905683f3..8bfe973e55ec 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2407,6 +2407,34 @@ static int omapfb_init_connections(struct omapfb2_device *fbdev,
 	return 0;
 }
 
+static struct omap_dss_device *
+omapfb_find_default_display(struct omapfb2_device *fbdev)
+{
+	const char *def_name;
+	int i;
+
+	/* search with the display name from the user or the board file */
+
+	def_name = omapdss_get_default_display_name();
+
+	if (def_name) {
+		for (i = 0; i < fbdev->num_displays; ++i) {
+			struct omap_dss_device *dssdev;
+
+			dssdev = fbdev->displays[i].dssdev;
+
+			if (dssdev->name && strcmp(def_name, dssdev->name) = 0)
+				return dssdev;
+		}
+
+		/* def_name given but not found */
+		return NULL;
+	}
+
+	/* return the first display we have in the list */
+	return fbdev->displays[0].dssdev;
+}
+
 static int omapfb_probe(struct platform_device *pdev)
 {
 	struct omapfb2_device *fbdev = NULL;
@@ -2484,23 +2512,7 @@ static int omapfb_probe(struct platform_device *pdev)
 	for (i = 0; i < fbdev->num_managers; i++)
 		fbdev->managers[i] = omap_dss_get_overlay_manager(i);
 
-	def_display = NULL;
-
-	for (i = 0; i < fbdev->num_displays; ++i) {
-		struct omap_dss_device *dssdev;
-		const char *def_name;
-
-		def_name = omapdss_get_default_display_name();
-
-		dssdev = fbdev->displays[i].dssdev;
-
-		if (def_name = NULL ||
-			(dssdev->name && strcmp(def_name, dssdev->name) = 0)) {
-			def_display = dssdev;
-			break;
-		}
-	}
-
+	def_display = omapfb_find_default_display(fbdev);
 	if (def_display = NULL) {
 		dev_err(fbdev->dev, "failed to find default display\n");
 		r = -EPROBE_DEFER;
-- 
1.8.3.2


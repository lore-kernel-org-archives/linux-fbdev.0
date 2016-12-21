From: Vladimir Zapolskiy <vz@mleia.com>
Date: Wed, 21 Dec 2016 03:27:16 +0000
Subject: [PATCH 3/4] video: ARM CLCD: use panel device node for getting backlight and mode
Message-Id: <20161221032717.13154-4-vz@mleia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161221032717.13154-1-vz@mleia.com>
In-Reply-To: <20161221032717.13154-1-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Having obtained panel device node in clcdfb_of_init_display() it allows to
generalize and simplify two more helper functions clcdfb_of_get_backlight()
and clcdfb_of_get_mode().

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/video/fbdev/amba-clcd.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index f25b5fc..0fab92c 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -624,16 +624,11 @@ static int clcdfb_snprintf_mode(char *buf, int size, struct fb_videomode *mode)
 			mode->refresh);
 }
 
-static int clcdfb_of_get_backlight(struct device_node *endpoint,
+static int clcdfb_of_get_backlight(struct device_node *panel,
 				   struct clcd_panel *clcd_panel)
 {
-	struct device_node *panel;
 	struct device_node *backlight;
 
-	panel = of_graph_get_remote_port_parent(endpoint);
-	if (!panel)
-		return -ENODEV;
-
 	/* Look up the optional backlight phandle */
 	backlight = of_parse_phandle(panel, "backlight", 0);
 	if (backlight) {
@@ -646,19 +641,14 @@ static int clcdfb_of_get_backlight(struct device_node *endpoint,
 	return 0;
 }
 
-static int clcdfb_of_get_mode(struct device *dev, struct device_node *endpoint,
-		struct clcd_panel *clcd_panel)
+static int clcdfb_of_get_mode(struct device *dev, struct device_node *panel,
+			      struct clcd_panel *clcd_panel)
 {
 	int err;
-	struct device_node *panel;
 	struct fb_videomode *mode;
 	char *name;
 	int len;
 
-	panel = of_graph_get_remote_port_parent(endpoint);
-	if (!panel)
-		return -ENODEV;
-
 	/* Only directly connected DPI panels supported for now */
 	if (of_device_is_compatible(panel, "panel-dpi"))
 		err = clcdfb_of_get_dpi_panel_mode(panel, clcd_panel);
@@ -791,11 +781,11 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 			return err;
 	}
 
-	err = clcdfb_of_get_backlight(endpoint, fb->panel);
+	err = clcdfb_of_get_backlight(panel, fb->panel);
 	if (err)
 		return err;
 
-	err = clcdfb_of_get_mode(&fb->dev->dev, endpoint, fb->panel);
+	err = clcdfb_of_get_mode(&fb->dev->dev, panel, fb->panel);
 	if (err)
 		return err;
 
-- 
2.10.2


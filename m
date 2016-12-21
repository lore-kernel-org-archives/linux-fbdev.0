From: Vladimir Zapolskiy <vz@mleia.com>
Date: Wed, 21 Dec 2016 03:27:15 +0000
Subject: [PATCH 2/4] video: ARM CLCD: use panel device node for panel initialization
Message-Id: <20161221032717.13154-3-vz@mleia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161221032717.13154-1-vz@mleia.com>
In-Reply-To: <20161221032717.13154-1-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

There is no necessity to pass an endpoint device node to custom panel
initialization functions, because a child panel device node should be
sufficient, note that the existing init_panel() callback declaration from
linux/amba/clcd.h already prompts to use the panel device node here.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/video/fbdev/amba-clcd-nomadik.c   |  9 +--------
 drivers/video/fbdev/amba-clcd-nomadik.h   |  5 ++---
 drivers/video/fbdev/amba-clcd-versatile.c | 14 +++-----------
 drivers/video/fbdev/amba-clcd-versatile.h |  5 ++---
 drivers/video/fbdev/amba-clcd.c           |  8 ++++++--
 5 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd-nomadik.c b/drivers/video/fbdev/amba-clcd-nomadik.c
index 0c06fca..a9a8f75 100644
--- a/drivers/video/fbdev/amba-clcd-nomadik.c
+++ b/drivers/video/fbdev/amba-clcd-nomadik.c
@@ -214,15 +214,8 @@ static void tpg110_init(struct device *dev, struct device_node *np,
 	board->disable = tpg110_disable;
 }
 
-int nomadik_clcd_init_panel(struct clcd_fb *fb,
-			    struct device_node *endpoint)
+int nomadik_clcd_init_panel(struct clcd_fb *fb, struct device_node *panel)
 {
-	struct device_node *panel;
-
-	panel = of_graph_get_remote_port_parent(endpoint);
-	if (!panel)
-		return -ENODEV;
-
 	if (of_device_is_compatible(panel, "tpo,tpg110"))
 		tpg110_init(&fb->dev->dev, panel, fb->board);
 	else
diff --git a/drivers/video/fbdev/amba-clcd-nomadik.h b/drivers/video/fbdev/amba-clcd-nomadik.h
index 50aa9bd..a24032c 100644
--- a/drivers/video/fbdev/amba-clcd-nomadik.h
+++ b/drivers/video/fbdev/amba-clcd-nomadik.h
@@ -6,8 +6,7 @@
 #ifdef CONFIG_ARCH_NOMADIK
 int nomadik_clcd_init_board(struct amba_device *adev,
 			     struct clcd_board *board);
-int nomadik_clcd_init_panel(struct clcd_fb *fb,
-			    struct device_node *endpoint);
+int nomadik_clcd_init_panel(struct clcd_fb *fb, struct device_node *panel);
 #else
 static inline int nomadik_clcd_init_board(struct amba_device *adev,
 					  struct clcd_board *board)
@@ -15,7 +14,7 @@ static inline int nomadik_clcd_init_board(struct amba_device *adev,
 	return 0;
 }
 static inline int nomadik_clcd_init_panel(struct clcd_fb *fb,
-					  struct device_node *endpoint)
+					  struct device_node *panel)
 {
 	return 0;
 }
diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/fbdev/amba-clcd-versatile.c
index e5d9bfc..d42047d 100644
--- a/drivers/video/fbdev/amba-clcd-versatile.c
+++ b/drivers/video/fbdev/amba-clcd-versatile.c
@@ -452,11 +452,9 @@ static const struct versatile_panel versatile_panels[] = {
 	},
 };
 
-static void versatile_panel_probe(struct device *dev,
-				  struct device_node *endpoint)
+static void versatile_panel_probe(struct device *dev, struct device_node *panel)
 {
 	struct versatile_panel const *vpanel = NULL;
-	struct device_node *panel = NULL;
 	u32 val;
 	int ret;
 	int i;
@@ -488,11 +486,6 @@ static void versatile_panel_probe(struct device *dev,
 		return;
 	}
 
-	panel = of_graph_get_remote_port_parent(endpoint);
-	if (!panel) {
-		dev_err(dev, "could not locate panel in DT\n");
-		return;
-	}
 	if (!of_device_is_compatible(panel, vpanel->compatible))
 		dev_err(dev, "panel in DT is not compatible with the "
 			"auto-detected panel, continuing anyway\n");
@@ -514,8 +507,7 @@ static void versatile_panel_probe(struct device *dev,
 	}
 }
 
-int versatile_clcd_init_panel(struct clcd_fb *fb,
-			      struct device_node *endpoint)
+int versatile_clcd_init_panel(struct clcd_fb *fb, struct device_node *panel)
 {
 	const struct of_device_id *clcd_id;
 	enum versatile_clcd versatile_clcd_type;
@@ -551,7 +543,7 @@ int versatile_clcd_init_panel(struct clcd_fb *fb,
 		fb->board->enable = versatile_clcd_enable;
 		fb->board->disable = versatile_clcd_disable;
 		fb->board->decode = versatile_clcd_decode;
-		versatile_panel_probe(dev, endpoint);
+		versatile_panel_probe(dev, panel);
 		dev_info(dev, "set up callbacks for Versatile\n");
 		break;
 	case REALVIEW_CLCD_EB:
diff --git a/drivers/video/fbdev/amba-clcd-versatile.h b/drivers/video/fbdev/amba-clcd-versatile.h
index 1b14359..4692c30 100644
--- a/drivers/video/fbdev/amba-clcd-versatile.h
+++ b/drivers/video/fbdev/amba-clcd-versatile.h
@@ -6,11 +6,10 @@
 #include <linux/platform_data/video-clcd-versatile.h>
 
 #if defined(CONFIG_PLAT_VERSATILE_CLCD) && defined(CONFIG_OF)
-int versatile_clcd_init_panel(struct clcd_fb *fb,
-			      struct device_node *endpoint);
+int versatile_clcd_init_panel(struct clcd_fb *fb, struct device_node *panel);
 #else
 static inline int versatile_clcd_init_panel(struct clcd_fb *fb,
-				struct device_node *endpoint)
+					    struct device_node *panel)
 {
 	return 0;
 }
diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index a806fb8..f25b5fc 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -764,7 +764,7 @@ static int clcdfb_of_init_tft_panel(struct clcd_fb *fb, u32 r0, u32 g0, u32 b0)
 
 static int clcdfb_of_init_display(struct clcd_fb *fb)
 {
-	struct device_node *endpoint;
+	struct device_node *endpoint, *panel;
 	int err;
 	unsigned int bpp;
 	u32 max_bandwidth;
@@ -781,8 +781,12 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 	if (!endpoint)
 		return -ENODEV;
 
+	panel = of_graph_get_remote_port_parent(endpoint);
+	if (!panel)
+		return -ENODEV;
+
 	if (fb->vendor->init_panel) {
-		err = fb->vendor->init_panel(fb, endpoint);
+		err = fb->vendor->init_panel(fb, panel);
 		if (err)
 			return err;
 	}
-- 
2.10.2


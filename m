From: Rob Herring <robh@kernel.org>
Date: Wed, 05 Dec 2018 19:50:45 +0000
Subject: [PATCH] fbdev: Use of_node_name_eq for node name comparisons
Message-Id: <20181205195050.4759-29-robh@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which omap is.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/video/fbdev/aty/radeon_pm.c           | 6 +++---
 drivers/video/fbdev/cg14.c                    | 4 ++--
 drivers/video/fbdev/cg3.c                     | 2 +-
 drivers/video/fbdev/ffb.c                     | 2 +-
 drivers/video/fbdev/imsttfb.c                 | 4 ++--
 drivers/video/fbdev/offb.c                    | 2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c | 4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_pm.c b/drivers/video/fbdev/aty/radeon_pm.c
index e695adb0e573..2dc5703eac51 100644
--- a/drivers/video/fbdev/aty/radeon_pm.c
+++ b/drivers/video/fbdev/aty/radeon_pm.c
@@ -2844,8 +2844,8 @@ void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk, int ignore_devlis
 		 * in some desktop G4s), Via (M9+ chip on iBook G4) and
 		 * Snowy (M11 chip on iBook G4 manufactured after July 2005)
 		 */
-		if (!strcmp(rinfo->of_node->name, "ATY,JasperParent") ||
-		    !strcmp(rinfo->of_node->name, "ATY,SnowyParent")) {
+		if (of_node_name_eq(rinfo->of_node, "ATY,JasperParent") ||
+		    of_node_name_eq(rinfo->of_node, "ATY,SnowyParent")) {
 			rinfo->reinit_func = radeon_reinitialize_M10;
 			rinfo->pm_mode |= radeon_pm_off;
 		}
@@ -2855,7 +2855,7 @@ void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk, int ignore_devlis
 			rinfo->pm_mode |= radeon_pm_off;
 		}
 #endif
-		if (!strcmp(rinfo->of_node->name, "ATY,ViaParent")) {
+		if (of_node_name_eq(rinfo->of_node, "ATY,ViaParent")) {
 			rinfo->reinit_func = radeon_reinitialize_M9P;
 			rinfo->pm_mode |= radeon_pm_off;
 		}
diff --git a/drivers/video/fbdev/cg14.c b/drivers/video/fbdev/cg14.c
index 9af54c2368fd..a6dce1a78490 100644
--- a/drivers/video/fbdev/cg14.c
+++ b/drivers/video/fbdev/cg14.c
@@ -486,8 +486,8 @@ static int cg14_probe(struct platform_device *op)
 					  info->var.xres);
 	info->fix.smem_len = PAGE_ALIGN(linebytes * info->var.yres);
 
-	if (!strcmp(dp->parent->name, "sbus") ||
-	    !strcmp(dp->parent->name, "sbi")) {
+	if (of_node_name_eq(dp->parent, "sbus") ||
+	    of_node_name_eq(dp->parent, "sbi")) {
 		info->fix.smem_start = op->resource[0].start;
 		par->iospace = op->resource[0].flags & IORESOURCE_BITS;
 	} else {
diff --git a/drivers/video/fbdev/cg3.c b/drivers/video/fbdev/cg3.c
index 1bd95b02f3aa..6d42def8436b 100644
--- a/drivers/video/fbdev/cg3.c
+++ b/drivers/video/fbdev/cg3.c
@@ -369,7 +369,7 @@ static int cg3_probe(struct platform_device *op)
 	info->var.red.length = 8;
 	info->var.green.length = 8;
 	info->var.blue.length = 8;
-	if (!strcmp(dp->name, "cgRDI"))
+	if (of_node_name_eq(dp, "cgRDI"))
 		par->flags |= CG3_FLAG_RDI;
 	if (par->flags & CG3_FLAG_RDI)
 		cg3_rdi_maybe_fixup_var(&info->var, dp);
diff --git a/drivers/video/fbdev/ffb.c b/drivers/video/fbdev/ffb.c
index 6b1915872af1..b7aee0c427a8 100644
--- a/drivers/video/fbdev/ffb.c
+++ b/drivers/video/fbdev/ffb.c
@@ -944,7 +944,7 @@ static int ffb_probe(struct platform_device *op)
 
 	info->var.accel_flags = FB_ACCELF_TEXT;
 
-	if (!strcmp(dp->name, "SUNW,afb"))
+	if (of_node_name_eq(dp, "SUNW,afb"))
 		par->flags |= FFB_FLAG_AFB;
 
 	par->board_type = of_getintprop_default(dp, "board_type", 0);
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 901ca4ed10e9..b268570b019d 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1498,8 +1498,8 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	switch (pdev->device) {
 		case PCI_DEVICE_ID_IMS_TT128: /* IMS,tt128mbA */
 			par->ramdac = IBM;
-			if (dp && ((strcmp(dp->name, "IMS,tt128mb8") = 0) ||
-				   (strcmp(dp->name, "IMS,tt128mb8A") = 0)))
+			if (of_node_name_eq(dp, "IMS,tt128mb8") ||
+			    of_node_name_eq(dp, "IMS,tt128mb8A"))
 				par->ramdac = TVP;
 			break;
 		case PCI_DEVICE_ID_IMS_TT3D:  /* IMS,tt3d */
diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 31f769d67195..7b452a520e85 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -646,7 +646,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 		}
 #endif
 		/* kludge for valkyrie */
-		if (strcmp(dp->name, "valkyrie") = 0)
+		if (of_node_name_eq(dp, "valkyrie"))
 			address += 0x1000;
 		offb_init_fb(no_real_node ? "bootx" : NULL,
 			     width, height, depth, pitch, address,
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c b/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
index f1eb8b0f8a2a..5ce893c1923d 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
@@ -60,7 +60,7 @@ omapdss_of_get_next_port(const struct device_node *parent,
 				return NULL;
 			}
 			prev = port;
-		} while (of_node_cmp(port->name, "port") != 0);
+		} while (!of_node_name_eq(port, "port"));
 
 		of_node_put(ports);
 	}
@@ -83,7 +83,7 @@ omapdss_of_get_next_endpoint(const struct device_node *parent,
 		if (!ep)
 			return NULL;
 		prev = ep;
-	} while (of_node_cmp(ep->name, "endpoint") != 0);
+	} while (!of_node_name_eq(ep, "endpoint"));
 
 	return ep;
 }
-- 
2.19.1

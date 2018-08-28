From: Rob Herring <robh@kernel.org>
Date: Tue, 28 Aug 2018 01:52:50 +0000
Subject: [PATCH] fbdev: Convert to using %pOFn instead of device_node.name
Message-Id: <20180828015252.28511-49-robh@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/video/fbdev/cg14.c        |  4 +---
 drivers/video/fbdev/cg3.c         |  2 +-
 drivers/video/fbdev/core/fbmon.c  |  4 ++--
 drivers/video/fbdev/imsttfb.c     |  2 +-
 drivers/video/fbdev/leo.c         |  2 +-
 drivers/video/fbdev/offb.c        | 12 ++++++++----
 drivers/video/fbdev/p9100.c       |  2 +-
 drivers/video/of_display_timing.c |  2 +-
 8 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/cg14.c b/drivers/video/fbdev/cg14.c
index 8de88b129b62..9af54c2368fd 100644
--- a/drivers/video/fbdev/cg14.c
+++ b/drivers/video/fbdev/cg14.c
@@ -355,9 +355,7 @@ static int cg14_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 static void cg14_init_fix(struct fb_info *info, int linebytes,
 			  struct device_node *dp)
 {
-	const char *name = dp->name;
-
-	strlcpy(info->fix.id, name, sizeof(info->fix.id));
+	snprintf(info->fix.id, sizeof(info->fix.id), "%pOFn", dp);
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
diff --git a/drivers/video/fbdev/cg3.c b/drivers/video/fbdev/cg3.c
index 6c334260cf53..1bd95b02f3aa 100644
--- a/drivers/video/fbdev/cg3.c
+++ b/drivers/video/fbdev/cg3.c
@@ -246,7 +246,7 @@ static int cg3_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 static void cg3_init_fix(struct fb_info *info, int linebytes,
 			 struct device_node *dp)
 {
-	strlcpy(info->fix.id, dp->name, sizeof(info->fix.id));
+	snprintf(info->fix.id, sizeof(info->fix.id), "%pOFn", dp);
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 852d86c1c527..dd3128990776 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1480,8 +1480,8 @@ int of_get_fb_videomode(struct device_node *np, struct fb_videomode *fb,
 	if (ret)
 		return ret;
 
-	pr_debug("%pOF: got %dx%d display mode from %s\n",
-		np, vm.hactive, vm.vactive, np->name);
+	pr_debug("%pOF: got %dx%d display mode\n",
+		np, vm.hactive, vm.vactive);
 	dump_fb_videomode(fb);
 
 	return 0;
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index ecdcf358ad5e..901ca4ed10e9 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1473,7 +1473,7 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	
 	dp = pci_device_to_OF_node(pdev);
 	if(dp)
-		printk(KERN_INFO "%s: OF name %s\n",__func__, dp->name);
+		printk(KERN_INFO "%s: OF name %pOFn\n",__func__, dp);
 	else if (IS_ENABLED(CONFIG_OF))
 		printk(KERN_ERR "imsttfb: no OF node for pci device\n");
 
diff --git a/drivers/video/fbdev/leo.c b/drivers/video/fbdev/leo.c
index 71862188f528..446ac3364bad 100644
--- a/drivers/video/fbdev/leo.c
+++ b/drivers/video/fbdev/leo.c
@@ -434,7 +434,7 @@ static int leo_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 static void
 leo_init_fix(struct fb_info *info, struct device_node *dp)
 {
-	strlcpy(info->fix.id, dp->name, sizeof(info->fix.id));
+	snprintf(info->fix.id, sizeof(info->fix.id), "%pOFn", dp);
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_TRUECOLOR;
diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 77c0a2f45b3b..31f769d67195 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -419,9 +419,13 @@ static void __init offb_init_fb(const char *name,
 	var = &info->var;
 	info->par = par;
 
-	strcpy(fix->id, "OFfb ");
-	strncat(fix->id, name, sizeof(fix->id) - sizeof("OFfb "));
-	fix->id[sizeof(fix->id) - 1] = '\0';
+	if (name) {
+		strcpy(fix->id, "OFfb ");
+		strncat(fix->id, name, sizeof(fix->id) - sizeof("OFfb "));
+		fix->id[sizeof(fix->id) - 1] = '\0';
+	} else
+		snprintf(fix->id, sizeof(fix->id), "OFfb %pOFn", dp);
+
 
 	var->xres = var->xres_virtual = width;
 	var->yres = var->yres_virtual = height;
@@ -644,7 +648,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 		/* kludge for valkyrie */
 		if (strcmp(dp->name, "valkyrie") = 0)
 			address += 0x1000;
-		offb_init_fb(no_real_node ? "bootx" : dp->name,
+		offb_init_fb(no_real_node ? "bootx" : NULL,
 			     width, height, depth, pitch, address,
 			     foreign_endian, no_real_node ? NULL : dp);
 	}
diff --git a/drivers/video/fbdev/p9100.c b/drivers/video/fbdev/p9100.c
index 64de5cda541d..c4283e9e95af 100644
--- a/drivers/video/fbdev/p9100.c
+++ b/drivers/video/fbdev/p9100.c
@@ -239,7 +239,7 @@ static int p9100_ioctl(struct fb_info *info, unsigned int cmd,
 
 static void p9100_init_fix(struct fb_info *info, int linebytes, struct device_node *dp)
 {
-	strlcpy(info->fix.id, dp->name, sizeof(info->fix.id));
+	snprintf(info->fix.id, sizeof(info->fix.id), "%pOFn", dp);
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index 5244e93ceafc..c2e7aa103fa5 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -170,7 +170,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 		goto entryfail;
 	}
 
-	pr_debug("%pOF: using %s as default timing\n", np, entry->name);
+	pr_debug("%pOF: using %pOFn as default timing\n", np, entry);
 
 	native_mode = entry;
 
-- 
2.17.1

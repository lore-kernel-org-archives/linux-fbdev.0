From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Jul 2017 21:43:36 +0000
Subject: [PATCH] video: fbdev: Convert to using %pOF instead of full_name
Message-Id: <20170718214339.7774-56-robh@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/bw2.c         |  4 ++--
 drivers/video/fbdev/cg14.c        |  4 ++--
 drivers/video/fbdev/cg3.c         |  4 ++--
 drivers/video/fbdev/cg6.c         |  4 ++--
 drivers/video/fbdev/core/fbmon.c  |  4 ++--
 drivers/video/fbdev/ffb.c         |  4 ++--
 drivers/video/fbdev/leo.c         |  4 ++--
 drivers/video/fbdev/offb.c        | 10 ++++------
 drivers/video/fbdev/p9100.c       |  4 ++--
 drivers/video/fbdev/sunxvr1000.c  | 10 +++++-----
 drivers/video/fbdev/tcx.c         |  4 ++--
 drivers/video/of_display_timing.c | 41 +++++++++++++++------------------------
 drivers/video/of_videomode.c      |  2 +-
 13 files changed, 44 insertions(+), 55 deletions(-)

diff --git a/drivers/video/fbdev/bw2.c b/drivers/video/fbdev/bw2.c
index 8c5b281f0b29..7aa972072357 100644
--- a/drivers/video/fbdev/bw2.c
+++ b/drivers/video/fbdev/bw2.c
@@ -333,8 +333,8 @@ static int bw2_probe(struct platform_device *op)

 	dev_set_drvdata(&op->dev, info);

-	printk(KERN_INFO "%s: bwtwo at %lx:%lx\n",
-	       dp->full_name, par->which_io, info->fix.smem_start);
+	printk(KERN_INFO "%pOF: bwtwo at %lx:%lx\n",
+	       dp, par->which_io, info->fix.smem_start);

 	return 0;

diff --git a/drivers/video/fbdev/cg14.c b/drivers/video/fbdev/cg14.c
index 43e915eaf606..8de88b129b62 100644
--- a/drivers/video/fbdev/cg14.c
+++ b/drivers/video/fbdev/cg14.c
@@ -553,8 +553,8 @@ static int cg14_probe(struct platform_device *op)

 	dev_set_drvdata(&op->dev, info);

-	printk(KERN_INFO "%s: cgfourteen at %lx:%lx, %dMB\n",
-	       dp->full_name,
+	printk(KERN_INFO "%pOF: cgfourteen at %lx:%lx, %dMB\n",
+	       dp,
 	       par->iospace, info->fix.smem_start,
 	       par->ramsize >> 20);

diff --git a/drivers/video/fbdev/cg3.c b/drivers/video/fbdev/cg3.c
index 716391f22e75..6c334260cf53 100644
--- a/drivers/video/fbdev/cg3.c
+++ b/drivers/video/fbdev/cg3.c
@@ -412,8 +412,8 @@ static int cg3_probe(struct platform_device *op)

 	dev_set_drvdata(&op->dev, info);

-	printk(KERN_INFO "%s: cg3 at %lx:%lx\n",
-	       dp->full_name, par->which_io, info->fix.smem_start);
+	printk(KERN_INFO "%pOF: cg3 at %lx:%lx\n",
+	       dp, par->which_io, info->fix.smem_start);

 	return 0;

diff --git a/drivers/video/fbdev/cg6.c b/drivers/video/fbdev/cg6.c
index bdf901ed5291..0296c21acc78 100644
--- a/drivers/video/fbdev/cg6.c
+++ b/drivers/video/fbdev/cg6.c
@@ -810,8 +810,8 @@ static int cg6_probe(struct platform_device *op)

 	dev_set_drvdata(&op->dev, info);

-	printk(KERN_INFO "%s: CGsix [%s] at %lx:%lx\n",
-	       dp->full_name, info->fix.id,
+	printk(KERN_INFO "%pOF: CGsix [%s] at %lx:%lx\n",
+	       dp, info->fix.id,
 	       par->which_io, info->fix.smem_start);

 	return 0;
diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 41d7979d81c5..2b2d67328514 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1479,8 +1479,8 @@ int of_get_fb_videomode(struct device_node *np, struct fb_videomode *fb,
 	if (ret)
 		return ret;

-	pr_debug("%s: got %dx%d display mode from %s\n",
-		of_node_full_name(np), vm.hactive, vm.vactive, np->name);
+	pr_debug("%pOF: got %dx%d display mode from %s\n",
+		np, vm.hactive, vm.vactive, np->name);
 	dump_fb_videomode(fb);

 	return 0;
diff --git a/drivers/video/fbdev/ffb.c b/drivers/video/fbdev/ffb.c
index dda31e0a45af..6b1915872af1 100644
--- a/drivers/video/fbdev/ffb.c
+++ b/drivers/video/fbdev/ffb.c
@@ -997,9 +997,9 @@ static int ffb_probe(struct platform_device *op)

 	dev_set_drvdata(&op->dev, info);

-	printk(KERN_INFO "%s: %s at %016lx, type %d, "
+	printk(KERN_INFO "%pOF: %s at %016lx, type %d, "
 	       "DAC pnum[%x] rev[%d] manuf_rev[%d]\n",
-	       dp->full_name,
+	       dp,
 	       ((par->flags & FFB_FLAG_AFB) ? "AFB" : "FFB"),
 	       par->physbase, par->board_type,
 	       dac_pnum, dac_rev, dac_mrev);
diff --git a/drivers/video/fbdev/leo.c b/drivers/video/fbdev/leo.c
index 62e59dc90ee6..71862188f528 100644
--- a/drivers/video/fbdev/leo.c
+++ b/drivers/video/fbdev/leo.c
@@ -619,8 +619,8 @@ static int leo_probe(struct platform_device *op)

 	dev_set_drvdata(&op->dev, info);

-	printk(KERN_INFO "%s: leo at %lx:%lx\n",
-	       dp->full_name,
+	printk(KERN_INFO "%pOF: leo at %lx:%lx\n",
+	       dp,
 	       par->which_io, info->fix.smem_start);

 	return 0;
diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 9be884b0c778..90d38de34479 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -383,7 +383,7 @@ static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_STATIC_PSEUDOCOLOR;
 }

-static void __init offb_init_fb(const char *name, const char *full_name,
+static void __init offb_init_fb(const char *name,
 				int width, int height, int depth,
 				int pitch, unsigned long address,
 				int foreign_endian, struct device_node *dp)
@@ -402,14 +402,13 @@ static void __init offb_init_fb(const char *name, const char *full_name,
 	       "Using unsupported %dx%d %s at %lx, depth=%d, pitch=%d\n",
 	       width, height, name, address, depth, pitch);
 	if (depth != 8 && depth != 15 && depth != 16 && depth != 32) {
-		printk(KERN_ERR "%s: can't use depth = %d\n", full_name,
-		       depth);
+		printk(KERN_ERR "%pOF: can't use depth = %d\n", dp, depth);
 		release_mem_region(res_start, res_size);
 		return;
 	}

 	info = framebuffer_alloc(sizeof(u32) * 16, NULL);
-
+
 	if (info = 0) {
 		release_mem_region(res_start, res_size);
 		return;
@@ -515,7 +514,7 @@ static void __init offb_init_fb(const char *name, const char *full_name,
 	if (register_framebuffer(info) < 0)
 		goto out_err;

-	fb_info(info, "Open Firmware frame buffer device on %s\n", full_name);
+	fb_info(info, "Open Firmware frame buffer device on %pOF\n", dp);
 	return;

 out_err:
@@ -644,7 +643,6 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 		if (strcmp(dp->name, "valkyrie") = 0)
 			address += 0x1000;
 		offb_init_fb(no_real_node ? "bootx" : dp->name,
-			     no_real_node ? "display" : dp->full_name,
 			     width, height, depth, pitch, address,
 			     foreign_endian, no_real_node ? NULL : dp);
 	}
diff --git a/drivers/video/fbdev/p9100.c b/drivers/video/fbdev/p9100.c
index 1f6ee76af878..64de5cda541d 100644
--- a/drivers/video/fbdev/p9100.c
+++ b/drivers/video/fbdev/p9100.c
@@ -304,8 +304,8 @@ static int p9100_probe(struct platform_device *op)

 	dev_set_drvdata(&op->dev, info);

-	printk(KERN_INFO "%s: p9100 at %lx:%lx\n",
-	       dp->full_name,
+	printk(KERN_INFO "%pOF: p9100 at %lx:%lx\n",
+	       dp,
 	       par->which_io, info->fix.smem_start);

 	return 0;
diff --git a/drivers/video/fbdev/sunxvr1000.c b/drivers/video/fbdev/sunxvr1000.c
index fb37f6e05391..8fe37c0ef2f5 100644
--- a/drivers/video/fbdev/sunxvr1000.c
+++ b/drivers/video/fbdev/sunxvr1000.c
@@ -33,8 +33,8 @@ static int gfb_get_props(struct gfb_info *gp)
 	gp->depth = of_getintprop_default(gp->of_node, "depth", 32);

 	if (!gp->width || !gp->height) {
-		printk(KERN_ERR "gfb: Critical properties missing for %s\n",
-		       gp->of_node->full_name);
+		printk(KERN_ERR "gfb: Critical properties missing for %pOF\n",
+		       gp->of_node);
 		return -EINVAL;
 	}

@@ -151,12 +151,12 @@ static int gfb_probe(struct platform_device *op)
 	if (err)
 		goto err_unmap_fb;

-	printk("gfb: Found device at %s\n", dp->full_name);
+	printk("gfb: Found device at %pOF\n", dp);

 	err = register_framebuffer(info);
 	if (err < 0) {
-		printk(KERN_ERR "gfb: Could not register framebuffer %s\n",
-		       dp->full_name);
+		printk(KERN_ERR "gfb: Could not register framebuffer %pOF\n",
+		       dp);
 		goto err_unmap_fb;
 	}

diff --git a/drivers/video/fbdev/tcx.c b/drivers/video/fbdev/tcx.c
index 54ad08854c94..c98d8a569ccd 100644
--- a/drivers/video/fbdev/tcx.c
+++ b/drivers/video/fbdev/tcx.c
@@ -467,8 +467,8 @@ static int tcx_probe(struct platform_device *op)

 	dev_set_drvdata(&op->dev, info);

-	printk(KERN_INFO "%s: TCX at %lx:%lx, %s\n",
-	       dp->full_name,
+	printk(KERN_INFO "%pOF: TCX at %lx:%lx, %s\n",
+	       dp,
 	       par->which_io,
 	       info->fix.smem_start,
 	       par->lowdepth ? "8-bit only" : "24-bit depth");
diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index 32b0a7543433..8ce0a99bf17c 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -31,8 +31,7 @@ static int parse_timing_property(const struct device_node *np, const char *name,

 	prop = of_find_property(np, name, &length);
 	if (!prop) {
-		pr_err("%s: could not find property %s\n",
-			of_node_full_name(np), name);
+		pr_err("%pOF: could not find property %s\n", np, name);
 		return -EINVAL;
 	}

@@ -44,8 +43,7 @@ static int parse_timing_property(const struct device_node *np, const char *name,
 	} else if (cells = 3) {
 		ret = of_property_read_u32_array(np, name, &result->min, cells);
 	} else {
-		pr_err("%s: illegal timing specification in %s\n",
-			of_node_full_name(np), name);
+		pr_err("%pOF: illegal timing specification in %s\n", np, name);
 		return -EINVAL;
 	}

@@ -105,8 +103,7 @@ static int of_parse_display_timing(const struct device_node *np,
 		dt->flags |= DISPLAY_FLAGS_DOUBLECLK;

 	if (ret) {
-		pr_err("%s: error reading timing properties\n",
-			of_node_full_name(np));
+		pr_err("%pOF: error reading timing properties\n", np);
 		return -EINVAL;
 	}

@@ -129,8 +126,7 @@ int of_get_display_timing(const struct device_node *np, const char *name,

 	timing_np = of_get_child_by_name(np, name);
 	if (!timing_np) {
-		pr_err("%s: could not find node '%s'\n",
-			of_node_full_name(np), name);
+		pr_err("%pOF: could not find node '%s'\n", np, name);
 		return -ENOENT;
 	}

@@ -154,15 +150,13 @@ struct display_timings *of_get_display_timings(const struct device_node *np)

 	timings_np = of_get_child_by_name(np, "display-timings");
 	if (!timings_np) {
-		pr_err("%s: could not find display-timings node\n",
-			of_node_full_name(np));
+		pr_err("%pOF: could not find display-timings node\n", np);
 		return NULL;
 	}

 	disp = kzalloc(sizeof(*disp), GFP_KERNEL);
 	if (!disp) {
-		pr_err("%s: could not allocate struct disp'\n",
-			of_node_full_name(np));
+		pr_err("%pOF: could not allocate struct disp'\n", np);
 		goto dispfail;
 	}

@@ -172,28 +166,25 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 		entry = of_get_next_child(timings_np, NULL);
 	/* if there is no child, it is useless to go on */
 	if (!entry) {
-		pr_err("%s: no timing specifications given\n",
-			of_node_full_name(np));
+		pr_err("%pOF: no timing specifications given\n", np);
 		goto entryfail;
 	}

-	pr_debug("%s: using %s as default timing\n",
-		of_node_full_name(np), entry->name);
+	pr_debug("%pOF: using %s as default timing\n", np, entry->name);

 	native_mode = entry;

 	disp->num_timings = of_get_child_count(timings_np);
 	if (disp->num_timings = 0) {
 		/* should never happen, as entry was already found above */
-		pr_err("%s: no timings specified\n", of_node_full_name(np));
+		pr_err("%pOF: no timings specified\n", np);
 		goto entryfail;
 	}

 	disp->timings = kzalloc(sizeof(struct display_timing *) *
 				disp->num_timings, GFP_KERNEL);
 	if (!disp->timings) {
-		pr_err("%s: could not allocate timings array\n",
-			of_node_full_name(np));
+		pr_err("%pOF: could not allocate timings array\n", np);
 		goto entryfail;
 	}

@@ -206,8 +197,8 @@ struct display_timings *of_get_display_timings(const struct device_node *np)

 		dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 		if (!dt) {
-			pr_err("%s: could not allocate display_timing struct\n",
-					of_node_full_name(np));
+			pr_err("%pOF: could not allocate display_timing struct\n",
+				np);
 			goto timingfail;
 		}

@@ -217,8 +208,8 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 			 * to not encourage wrong devicetrees, fail in case of
 			 * an error
 			 */
-			pr_err("%s: error in timing %d\n",
-				of_node_full_name(np), disp->num_timings + 1);
+			pr_err("%pOF: error in timing %d\n",
+				np, disp->num_timings + 1);
 			kfree(dt);
 			goto timingfail;
 		}
@@ -236,8 +227,8 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 	 */
 	of_node_put(native_mode);

-	pr_debug("%s: got %d timings. Using timing #%d as default\n",
-		of_node_full_name(np), disp->num_timings,
+	pr_debug("%pOF: got %d timings. Using timing #%d as default\n",
+		np, disp->num_timings,
 		disp->native_mode + 1);

 	return disp;
diff --git a/drivers/video/of_videomode.c b/drivers/video/of_videomode.c
index b5102aa6090d..9b5f9de88fec 100644
--- a/drivers/video/of_videomode.c
+++ b/drivers/video/of_videomode.c
@@ -36,7 +36,7 @@ int of_get_videomode(struct device_node *np, struct videomode *vm,

 	disp = of_get_display_timings(np);
 	if (!disp) {
-		pr_err("%s: no timings specified\n", of_node_full_name(np));
+		pr_err("%pOF: no timings specified\n", np);
 		return -EINVAL;
 	}

--
2.11.0


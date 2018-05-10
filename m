From: Joe Perches <joe@perches.com>
Date: Thu, 10 May 2018 15:45:36 +0000
Subject: [PATCH 10/18] efifb: Remove pr_fmt duplicate logging prefixes
Message-Id: <b424c8d20ebdfe54adca5ceee86fd21e8a144f6e.1525964385.git.joe@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1525964381.git.joe@perches.com>
In-Reply-To: <cover.1525964381.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Jones <pjones@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Converting pr_fmt from a simple define to use KBUILD_MODNAME added
some duplicate logging prefixes to existing uses.

Remove them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/fbdev/efifb.c | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 46a4484e3da7..3a11174f194b 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -250,13 +250,13 @@ static int efifb_probe(struct platform_device *dev)
 	} else {
 		/* We cannot make this fatal. Sometimes this comes from magic
 		   spaces our resource handlers simply don't know about */
-		pr_warn("efifb: cannot reserve video memory at 0x%lx\n",
+		pr_warn("cannot reserve video memory at 0x%lx\n",
 			efifb_fix.smem_start);
 	}
 
 	info = framebuffer_alloc(sizeof(u32) * 16, &dev->dev);
 	if (!info) {
-		pr_err("efifb: cannot allocate framebuffer\n");
+		pr_err("cannot allocate framebuffer\n");
 		err = -ENOMEM;
 		goto err_release_mem;
 	}
@@ -277,23 +277,23 @@ static int efifb_probe(struct platform_device *dev)
 	else
 		info->screen_base = ioremap_wc(efifb_fix.smem_start, efifb_fix.smem_len);
 	if (!info->screen_base) {
-		pr_err("efifb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
-			efifb_fix.smem_len, efifb_fix.smem_start);
+		pr_err("abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
+		       efifb_fix.smem_len, efifb_fix.smem_start);
 		err = -EIO;
 		goto err_release_fb;
 	}
 
-	pr_info("efifb: framebuffer at 0x%lx, using %dk, total %dk\n",
-	       efifb_fix.smem_start, size_remap/1024, size_total/1024);
-	pr_info("efifb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
-	       efifb_defined.xres, efifb_defined.yres,
-	       efifb_defined.bits_per_pixel, efifb_fix.line_length,
-	       screen_info.pages);
+	pr_info("framebuffer at 0x%lx, using %dk, total %dk\n",
+		efifb_fix.smem_start, size_remap/1024, size_total/1024);
+	pr_info("mode is %dx%dx%d, linelength=%d, pages=%d\n",
+		efifb_defined.xres, efifb_defined.yres,
+		efifb_defined.bits_per_pixel, efifb_fix.line_length,
+		screen_info.pages);
 
 	efifb_defined.xres_virtual = efifb_defined.xres;
 	efifb_defined.yres_virtual = efifb_fix.smem_len /
 					efifb_fix.line_length;
-	pr_info("efifb: scrolling: redraw\n");
+	pr_info("scrolling: redraw\n");
 	efifb_defined.yres_virtual = efifb_defined.yres;
 
 	/* some dummy values for timing to make fbset happy */
@@ -311,17 +311,15 @@ static int efifb_probe(struct platform_device *dev)
 	efifb_defined.transp.offset = screen_info.rsvd_pos;
 	efifb_defined.transp.length = screen_info.rsvd_size;
 
-	pr_info("efifb: %s: "
-	       "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
-	       "Truecolor",
-	       screen_info.rsvd_size,
-	       screen_info.red_size,
-	       screen_info.green_size,
-	       screen_info.blue_size,
-	       screen_info.rsvd_pos,
-	       screen_info.red_pos,
-	       screen_info.green_pos,
-	       screen_info.blue_pos);
+	pr_info("Truecolor: size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
+		screen_info.rsvd_size,
+		screen_info.red_size,
+		screen_info.green_size,
+		screen_info.blue_size,
+		screen_info.rsvd_pos,
+		screen_info.red_pos,
+		screen_info.green_pos,
+		screen_info.blue_pos);
 
 	efifb_fix.ypanstep  = 0;
 	efifb_fix.ywrapstep = 0;
@@ -350,17 +348,17 @@ static int efifb_probe(struct platform_device *dev)
 
 	err = sysfs_create_groups(&dev->dev.kobj, efifb_groups);
 	if (err) {
-		pr_err("efifb: cannot add sysfs attrs\n");
+		pr_err("cannot add sysfs attrs\n");
 		goto err_unmap;
 	}
 	err = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (err < 0) {
-		pr_err("efifb: cannot allocate colormap\n");
+		pr_err("cannot allocate colormap\n");
 		goto err_groups;
 	}
 	err = register_framebuffer(info);
 	if (err < 0) {
-		pr_err("efifb: cannot register framebuffer\n");
+		pr_err("cannot register framebuffer\n");
 		goto err_fb_dealoc;
 	}
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
-- 
2.15.0


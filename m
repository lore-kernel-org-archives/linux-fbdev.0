From: Chuhong Yuan <hslester96@gmail.com>
Date: Sun, 29 Mar 2020 14:58:39 +0000
Subject: [PATCH v4] video: fbdev: vesafb: add missed release_region
Message-Id: <20200329145839.20076-1-hslester96@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-fbdev@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The driver forgets to free the I/O region in remove and probe
failure.
Add the missed calls to fix it.

Since the success of request_region() is optional, add the "region" field
in vesafb_par to represent whether request_region() succeeds.
Then only call release_region() when "region" is not null.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v4:
  - Add a field in vesafb_par to represent whether request_region() succeeds.
  - Only call release_region() when request_region() succeeds.
  - Adjust the order in the error handler of probe.
  - Modify commit message.

 drivers/video/fbdev/vesafb.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index a1fe24ea869b..df6de5a9dd4c 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -32,6 +32,7 @@
 struct vesafb_par {
 	u32 pseudo_palette[256];
 	int wc_cookie;
+	struct resource *region;
 };
 
 static struct fb_var_screeninfo vesafb_defined = {
@@ -411,7 +412,7 @@ static int vesafb_probe(struct platform_device *dev)
 
 	/* request failure does not faze us, as vgacon probably has this
 	 * region already (FIXME) */
-	request_region(0x3c0, 32, "vesafb");
+	par->region = request_region(0x3c0, 32, "vesafb");
 
 	if (mtrr = 3) {
 		unsigned int temp_size = size_total;
@@ -439,7 +440,7 @@ static int vesafb_probe(struct platform_device *dev)
 		       "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
 			vesafb_fix.smem_len, vesafb_fix.smem_start);
 		err = -EIO;
-		goto err;
+		goto err_release_region;
 	}
 
 	printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, "
@@ -458,19 +459,22 @@ static int vesafb_probe(struct platform_device *dev)
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		err = -ENOMEM;
-		goto err;
+		goto err_release_region;
 	}
 	if (register_framebuffer(info)<0) {
 		err = -EINVAL;
 		fb_dealloc_cmap(&info->cmap);
-		goto err;
+		goto err_release_region;
 	}
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
 	return 0;
-err:
+err_release_region:
 	arch_phys_wc_del(par->wc_cookie);
 	if (info->screen_base)
 		iounmap(info->screen_base);
+	if (par->region)
+		release_region(0x3c0, 32);
+err:
 	framebuffer_release(info);
 	release_mem_region(vesafb_fix.smem_start, size_total);
 	return err;
@@ -481,6 +485,8 @@ static int vesafb_remove(struct platform_device *pdev)
 	struct fb_info *info = platform_get_drvdata(pdev);
 
 	unregister_framebuffer(info);
+	if (((struct vesafb_par *)(info->par))->region)
+		release_region(0x3c0, 32);
 	framebuffer_release(info);
 
 	return 0;
-- 
2.26.0

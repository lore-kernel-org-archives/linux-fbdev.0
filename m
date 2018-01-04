From: Ladislav Michl <ladis@linux-mips.org>
Date: Thu, 04 Jan 2018 19:38:33 +0000
Subject: [PATCH v2 3/5] video: udlfb: Remove noisy warnings
Message-Id: <20180104193833.GD22612@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

These warnings comes from times of driver development and do
not carry any usefull debugging information.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 - v2: New patch

 drivers/video/fbdev/udlfb.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index d4e15d97a264..4a6644432970 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -921,11 +921,7 @@ static void dlfb_free(struct kref *kref)
 	struct dlfb_data *dev = container_of(kref, struct dlfb_data, kref);
 
 	vfree(dev->backing_buffer);
-
 	kfree(dev->edid);
-
-	pr_warn("freeing dlfb_data %p\n", dev);
-
 	kfree(dev);
 }
 
@@ -942,8 +938,6 @@ static void dlfb_free_framebuffer(struct dlfb_data *dev)
 	struct fb_info *info = dev->info;
 
 	if (info) {
-		int node = info->node;
-
 		unregister_framebuffer(info);
 
 		if (info->cmap.len != 0)
@@ -958,8 +952,6 @@ static void dlfb_free_framebuffer(struct dlfb_data *dev)
 
 		/* Assume info structure is freed after this point */
 		framebuffer_release(info);
-
-		pr_warn("fb_info for /dev/fb%d has been freed\n", node);
 	}
 
 	/* ref taken in probe() as part of registering framebfufer */
@@ -1060,8 +1052,6 @@ static int dlfb_ops_set_par(struct fb_info *info)
 	u16 *pix_framebuffer;
 	int i;
 
-	pr_notice("set_par mode %dx%d\n", info->var.xres, info->var.yres);
-
 	result = dlfb_set_video_mode(dev, &info->var);
 
 	if ((result = 0) && (dev->fb_count = 0)) {
@@ -1164,8 +1154,6 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dev, struct fb_info *info)
 	unsigned char *new_fb;
 	unsigned char *new_back = NULL;
 
-	pr_warn("Reallocating framebuffer. Addresses will change!\n");
-
 	new_len = info->fix.line_length * info->var.yres;
 
 	if (PAGE_ALIGN(new_len) > old_len) {
@@ -1415,9 +1403,6 @@ static ssize_t edid_show(
 	if (off + count > dev->edid_size)
 		count = dev->edid_size - off;
 
-	pr_info("sysfs edid copy %p to %p, %d bytes\n",
-		dev->edid, buf, (int) count);
-
 	memcpy(buf, dev->edid, count);
 
 	return count;
@@ -1443,7 +1428,6 @@ static ssize_t edid_store(
 	if (!dev->edid || memcmp(src, dev->edid, src_size))
 		return -EINVAL;
 
-	pr_info("sysfs written EDID is new default\n");
 	dlfb_ops_set_par(fb_info);
 	return src_size;
 }
@@ -1827,8 +1811,6 @@ static void dlfb_free_urb_list(struct dlfb_data *dev)
 	int ret;
 	unsigned long flags;
 
-	pr_notice("Freeing all render urbs\n");
-
 	/* keep waiting and freeing, until we've got 'em all */
 	while (count--) {
 
@@ -1907,8 +1889,6 @@ static int dlfb_alloc_urb_list(struct dlfb_data *dev, int count, size_t size)
 	dev->urbs.count = i;
 	dev->urbs.available = i;
 
-	pr_notice("allocated %d %d byte urbs\n", i, (int) size);
-
 	return i;
 }
 
-- 
2.15.1


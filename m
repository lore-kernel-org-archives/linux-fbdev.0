From: Dan Carpenter <error27@gmail.com>
Date: Sat, 13 Nov 2010 10:07:18 +0000
Subject: [patch 2/2] fbcmap: integer overflow bug
Message-Id: <20101113100718.GB1795@bicker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101027093716.GD6062@bicker>
 <20101105134018.2c11f283.akpm@linux-foundation.org>
In-Reply-To: <20101105134018.2c11f283.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

There is an integer overflow in fb_set_user_cmap() because cmap->len * 2
can wrap.  It's basically harmless.  Your terminal will be messed up
until you type reset.

This patch does three things to fix the bug.

First, it checks the return value of fb_copy_cmap() in fb_alloc_cmap().
That is enough to fix address the overflow.

Second it checks for the integer overflow in fb_set_user_cmap().

Lastly I wanted to cap "cmap->len" in fb_set_user_cmap() much lower
because it gets used to determine the size of allocation.  Unfortunately
no one knows what the limit should be.  Instead what this patch does
is makes the allocation happen with GFP_KERNEL instead of GFP_ATOMIC
and lets the kmalloc() decide what values of cmap->len are reasonable.
To do this, the patch introduces a function called fb_alloc_cmap_gfp()
which is like fb_alloc_cmap() except that it takes a GFP flag.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 7fca3dc..d1631d3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -1122,6 +1122,7 @@ extern const struct fb_videomode *fb_find_best_display(const struct fb_monspecs
 
 /* drivers/video/fbcmap.c */
 extern int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp);
+extern int fb_alloc_cmap_gfp(struct fb_cmap *cmap, int len, int transp, gfp_t flags);
 extern void fb_dealloc_cmap(struct fb_cmap *cmap);
 extern int fb_copy_cmap(const struct fb_cmap *from, struct fb_cmap *to);
 extern int fb_cmap_to_user(const struct fb_cmap *from, struct fb_cmap_user *to);
diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
index a79b976..e6a01bf 100644
--- a/drivers/video/fbcmap.c
+++ b/drivers/video/fbcmap.c
@@ -88,26 +88,27 @@ static const struct fb_cmap default_16_colors = {
  *
  */
 
-int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp)
+int fb_alloc_cmap_gfp(struct fb_cmap *cmap, int len, int transp, gfp_t flags)
 {
 	int size = len * sizeof(u16);
+	int ret = -ENOMEM;
 
 	if (cmap->len != len) {
 		fb_dealloc_cmap(cmap);
 		if (!len)
 			return 0;
 
-		cmap->red = kmalloc(size, GFP_ATOMIC);
+		cmap->red = kmalloc(size, flags);
 		if (!cmap->red)
 			goto fail;
-		cmap->green = kmalloc(size, GFP_ATOMIC);
+		cmap->green = kmalloc(size, flags);
 		if (!cmap->green)
 			goto fail;
-		cmap->blue = kmalloc(size, GFP_ATOMIC);
+		cmap->blue = kmalloc(size, flags);
 		if (!cmap->blue)
 			goto fail;
 		if (transp) {
-			cmap->transp = kmalloc(size, GFP_ATOMIC);
+			cmap->transp = kmalloc(size, flags);
 			if (!cmap->transp)
 				goto fail;
 		} else {
@@ -116,12 +117,19 @@ int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp)
 	}
 	cmap->start = 0;
 	cmap->len = len;
-	fb_copy_cmap(fb_default_cmap(len), cmap);
+	ret = fb_copy_cmap(fb_default_cmap(len), cmap);
+	if (ret)
+		goto fail;
 	return 0;
 
 fail:
 	fb_dealloc_cmap(cmap);
-	return -ENOMEM;
+	return ret;
+}
+
+int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp)
+{
+	return fb_alloc_cmap_gfp(cmap, len, transp, GFP_ATOMIC);
 }
 
 /**
@@ -256,8 +264,12 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
 	int rc, size = cmap->len * sizeof(u16);
 	struct fb_cmap umap;
 
+	if (cmap->len * 2 > INT_MAX)
+		return -EINVAL;
+
 	memset(&umap, 0, sizeof(struct fb_cmap));
-	rc = fb_alloc_cmap(&umap, cmap->len, cmap->transp != NULL);
+	rc = fb_alloc_cmap_gfp(&umap, cmap->len, cmap->transp != NULL,
+				GFP_KERNEL);
 	if (rc)
 		return rc;
 	if (copy_from_user(umap.red, cmap->red, size) ||

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Sep 2020 10:09:04 +0000
Subject: [PATCH 1/3] fbdev: simplify fb_getput_cmap()
Message-Id: <20200918100926.1447563-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200918100812.1447443-1-arnd@arndb.de>
In-Reply-To: <20200918100812.1447443-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de, Geert Uytterhoeven <geert@linux-m68k.org>, "David S . Miller" <davem@davemloft.net>

This function is one of the remaining users of compat_alloc_user_space()
and copy_in_user().

Clean it up by copying to a local data structure copy instead,
which also leads to more readable code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/core/fbmem.c | 44 ++++++++++++++------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index da7c88ffaa6a..4e162e3d3538 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1211,36 +1211,30 @@ struct fb_cmap32 {
 static int fb_getput_cmap(struct fb_info *info, unsigned int cmd,
 			  unsigned long arg)
 {
-	struct fb_cmap_user __user *cmap;
-	struct fb_cmap32 __user *cmap32;
-	__u32 data;
-	int err;
-
-	cmap = compat_alloc_user_space(sizeof(*cmap));
-	cmap32 = compat_ptr(arg);
+	struct fb_cmap32 cmap32;
+	struct fb_cmap cmap_from;
+	struct fb_cmap_user cmap;
 
-	if (copy_in_user(&cmap->start, &cmap32->start, 2 * sizeof(__u32)))
+	if (copy_from_user(&cmap32, compat_ptr(arg), sizeof(cmap32)))
 		return -EFAULT;
 
-	if (get_user(data, &cmap32->red) ||
-	    put_user(compat_ptr(data), &cmap->red) ||
-	    get_user(data, &cmap32->green) ||
-	    put_user(compat_ptr(data), &cmap->green) ||
-	    get_user(data, &cmap32->blue) ||
-	    put_user(compat_ptr(data), &cmap->blue) ||
-	    get_user(data, &cmap32->transp) ||
-	    put_user(compat_ptr(data), &cmap->transp))
-		return -EFAULT;
+	cmap = (struct fb_cmap_user) {
+		.start	= cmap32.start,
+		.len	= cmap32.len,
+		.red	= compat_ptr(cmap32.red),
+		.green	= compat_ptr(cmap32.green),
+		.blue	= compat_ptr(cmap32.blue),
+		.transp	= compat_ptr(cmap32.transp),
+	};
 
-	err = do_fb_ioctl(info, cmd, (unsigned long) cmap);
+	if (cmd = FBIOPUTCMAP)
+		return fb_set_user_cmap(&cmap, info);
 
-	if (!err) {
-		if (copy_in_user(&cmap32->start,
-				 &cmap->start,
-				 2 * sizeof(__u32)))
-			err = -EFAULT;
-	}
-	return err;
+	lock_fb_info(info);
+	cmap_from = info->cmap;
+	unlock_fb_info(info);
+
+	return fb_cmap_to_user(&cmap_from, &cmap);
 }
 
 static int do_fscreeninfo_to_user(struct fb_fix_screeninfo *fix,
-- 
2.27.0

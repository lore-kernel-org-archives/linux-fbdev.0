From: Dan Carpenter <error27@gmail.com>
Date: Wed, 27 Oct 2010 09:37:16 +0000
Subject: [RFC] [patch] fbcmap: integer overflow bug
Message-Id: <20101027093716.GD6062@bicker>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

There is an integer overflow bug in the FBIOPUTCMAP ioctl if
cmap->len * 2 overflows.

It's harmless, except that it messes up the cmap until someone types
`reset`.  It could have been caught by checking the return from
fb_copy_cmap().

Or it could have been caught by limiting the size of the cmaps to one
page.  The cmaps are allocated with GFP_ATOMIC and it makes sense to
limit them.

Different drivers use different sizes of cmaps.  There are about 150
drivers.  I've checked a bunch (50) of them and the larges cmap.len I've
found is gxt4500 which maxes out at 1024 so PAGE_SIZE is about twice that
length.  For some of the 50 I wasn't sure on the limit.

Is PAGE_SIZE a reasonable limit?  Does anyone know or do I have to audit
all 150 drivers?

diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
index f53b9f1..6dc5817 100644
--- a/drivers/video/fbcmap.c
+++ b/drivers/video/fbcmap.c
@@ -110,7 +110,9 @@ int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp)
     }
     cmap->start = 0;
     cmap->len = len;
-    fb_copy_cmap(fb_default_cmap(len), cmap);
+    if (fb_copy_cmap(fb_default_cmap(len), cmap))
+	goto fail;
+
     return 0;
 
 fail:
@@ -250,6 +252,9 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
 	int rc, size = cmap->len * sizeof(u16);
 	struct fb_cmap umap;
 
+	if (cmap->len > PAGE_SIZE || cmap->len * sizeof(u16) > PAGE_SIZE)
+		return -EINVAL;
+
 	memset(&umap, 0, sizeof(struct fb_cmap));
 	rc = fb_alloc_cmap(&umap, cmap->len, cmap->transp != NULL);
 	if (rc)

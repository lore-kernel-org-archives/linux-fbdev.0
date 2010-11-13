From: Dan Carpenter <error27@gmail.com>
Date: Sat, 13 Nov 2010 10:06:38 +0000
Subject: [patch 1/2] fbcmap: cleanup white space in fb_alloc_cmap()
Message-Id: <20101113100638.GA1795@bicker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101027093716.GD6062@bicker>
 <20101105134018.2c11f283.akpm@linux-foundation.org>
In-Reply-To: <20101105134018.2c11f283.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

checkpatch.pl and Andrew Morton both complained about the indenting in
fb_alloc_cmap()

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
index f53b9f1..a79b976 100644
--- a/drivers/video/fbcmap.c
+++ b/drivers/video/fbcmap.c
@@ -90,32 +90,38 @@ static const struct fb_cmap default_16_colors = {
 
 int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp)
 {
-    int size = len*sizeof(u16);
-
-    if (cmap->len != len) {
-	fb_dealloc_cmap(cmap);
-	if (!len)
-	    return 0;
-	if (!(cmap->red = kmalloc(size, GFP_ATOMIC)))
-	    goto fail;
-	if (!(cmap->green = kmalloc(size, GFP_ATOMIC)))
-	    goto fail;
-	if (!(cmap->blue = kmalloc(size, GFP_ATOMIC)))
-	    goto fail;
-	if (transp) {
-	    if (!(cmap->transp = kmalloc(size, GFP_ATOMIC)))
-		goto fail;
-	} else
-	    cmap->transp = NULL;
-    }
-    cmap->start = 0;
-    cmap->len = len;
-    fb_copy_cmap(fb_default_cmap(len), cmap);
-    return 0;
+	int size = len * sizeof(u16);
+
+	if (cmap->len != len) {
+		fb_dealloc_cmap(cmap);
+		if (!len)
+			return 0;
+
+		cmap->red = kmalloc(size, GFP_ATOMIC);
+		if (!cmap->red)
+			goto fail;
+		cmap->green = kmalloc(size, GFP_ATOMIC);
+		if (!cmap->green)
+			goto fail;
+		cmap->blue = kmalloc(size, GFP_ATOMIC);
+		if (!cmap->blue)
+			goto fail;
+		if (transp) {
+			cmap->transp = kmalloc(size, GFP_ATOMIC);
+			if (!cmap->transp)
+				goto fail;
+		} else {
+			cmap->transp = NULL;
+		}
+	}
+	cmap->start = 0;
+	cmap->len = len;
+	fb_copy_cmap(fb_default_cmap(len), cmap);
+	return 0;
 
 fail:
-    fb_dealloc_cmap(cmap);
-    return -ENOMEM;
+	fb_dealloc_cmap(cmap);
+	return -ENOMEM;
 }
 
 /**

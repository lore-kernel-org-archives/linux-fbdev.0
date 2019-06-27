From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 27 Jun 2019 12:58:01 +0000
Subject: [PATCH] video: fbdev: s3c-fb: fix sparse warnings about using incorrect types
Message-Id: <908fc26e-3bfa-c204-6c32-7d814fdcb37b@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190627125803eucas1p1eb6a37f5fa96fd732e41ab1501367de5@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jingoo Han <jingoohan1@gmail.com>

Use ->screen_buffer instead of ->screen_base to fix sparse warnings.

[ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
  pointer") for details. ]

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/s3c-fb.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: b/drivers/video/fbdev/s3c-fb.c
=================================--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1105,14 +1105,14 @@ static int s3c_fb_alloc_memory(struct s3
 
 	dev_dbg(sfb->dev, "want %u bytes for window\n", size);
 
-	fbi->screen_base = dma_alloc_wc(sfb->dev, size, &map_dma, GFP_KERNEL);
-	if (!fbi->screen_base)
+	fbi->screen_buffer = dma_alloc_wc(sfb->dev, size, &map_dma, GFP_KERNEL);
+	if (!fbi->screen_buffer)
 		return -ENOMEM;
 
 	dev_dbg(sfb->dev, "mapped %x to %p\n",
-		(unsigned int)map_dma, fbi->screen_base);
+		(unsigned int)map_dma, fbi->screen_buffer);
 
-	memset(fbi->screen_base, 0x0, size);
+	memset(fbi->screen_buffer, 0x0, size);
 	fbi->fix.smem_start = map_dma;
 
 	return 0;
@@ -1129,9 +1129,9 @@ static void s3c_fb_free_memory(struct s3
 {
 	struct fb_info *fbi = win->fbinfo;
 
-	if (fbi->screen_base)
+	if (fbi->screen_buffer)
 		dma_free_wc(sfb->dev, PAGE_ALIGN(fbi->fix.smem_len),
-		            fbi->screen_base, fbi->fix.smem_start);
+			    fbi->screen_buffer, fbi->fix.smem_start);
 }
 
 /**

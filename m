From: Manuel Lauss <manuel.lauss@gmail.com>
Date: Tue, 06 Oct 2015 16:23:23 +0000
Subject: [PATCH 3/3] video: fbdev: au1200fb: alloc mem from coherent pool/CMA
Message-Id: <1444148603-45454-3-git-send-email-manuel.lauss@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444148603-45454-1-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1444148603-45454-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-MIPS <linux-mips@linux-mips.org>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, linux-fbdev <linux-fbdev@vger.kernel.org>

Change framebuffer memory allocation to grab some memory from the
coherent pool, which on MIPS causes the allocator to first try
to look for CMA-reserved memory.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>
---
Tested on Db1200 and Db1300 boards, with no issues

 drivers/video/fbdev/au1200fb.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index f9507b1..0884197 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1647,7 +1647,6 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 	struct au1200fb_device *fbdev;
 	struct au1200fb_platdata *pd;
 	struct fb_info *fbi = NULL;
-	unsigned long page;
 	int bpp, plane, ret, irq;
 
 	print_info("" DRIVER_DESC "");
@@ -1693,7 +1692,7 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 		/* Allocate the framebuffer to the maximum screen size */
 		fbdev->fb_len = (win->w[plane].xres * win->w[plane].yres * bpp) / 8;
 
-		fbdev->fb_mem = dmam_alloc_noncoherent(&dev->dev,
+		fbdev->fb_mem = dmam_alloc_coherent(&dev->dev,
 				PAGE_ALIGN(fbdev->fb_len),
 				&fbdev->fb_phys, GFP_KERNEL);
 		if (!fbdev->fb_mem) {
@@ -1702,16 +1701,6 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 			return -ENOMEM;
 		}
 
-		/*
-		 * Set page reserved so that mmap will work. This is necessary
-		 * since we'll be remapping normal memory.
-		 */
-		for (page = (unsigned long)fbdev->fb_phys;
-		     page < PAGE_ALIGN((unsigned long)fbdev->fb_phys +
-			     fbdev->fb_len);
-		     page += PAGE_SIZE) {
-			SetPageReserved(pfn_to_page(page >> PAGE_SHIFT)); /* LCD DMA is NOT coherent on Au1200 */
-		}
 		print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
 		print_dbg("phys=0x%08x, size=%dK", fbdev->fb_phys, fbdev->fb_len / 1024);
 
-- 
2.5.3


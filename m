From: Christoph Hellwig <hch@lst.de>
Date: Thu, 09 May 2019 17:38:48 +0000
Subject: [PATCH 2/3] au1200fb: fix DMA API abuse
Message-Id: <20190509173849.11825-3-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190509173849.11825-1-hch@lst.de>
In-Reply-To: <20190509173849.11825-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Manuel Lauss <manuel.lauss@gmail.com>
Cc: linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Virtual addresses return from dma(m)_alloc_attrs are opaque in what
backs then, and drivers must not poke into them.  Similarly caching
modes are not supposed to be directly set by the driver.  Switch the
driver to use the generic DMA API mmap helper to avoid these problems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/video/fbdev/au1200fb.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 3872ccef4cb2..26caffb02b7e 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -147,6 +147,7 @@ struct au1200_lcd_iodata_t {
 struct au1200fb_device {
 	struct fb_info *fb_info;		/* FB driver info record */
 	struct au1200fb_platdata *pd;
+	struct device *dev;
 
 	int					plane;
 	unsigned char* 		fb_mem;		/* FrameBuffer memory map */
@@ -1232,10 +1233,8 @@ static int au1200fb_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct au1200fb_device *fbdev = info->par;
 
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	pgprot_val(vma->vm_page_prot) |= _CACHE_MASK; /* CCA=7 */
-
-	return vm_iomap_memory(vma, fbdev->fb_phys, fbdev->fb_len);
+	return dma_mmap_attrs(fbdev->dev, vma, fbdev->fb_mem, fbdev->fb_phys,
+			fbdev->fb_len, DMA_ATTR_NON_CONSISTENT);
 }
 
 static void set_global(u_int cmd, struct au1200_lcd_global_regs_t *pdata)
@@ -1647,7 +1646,6 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 	struct au1200fb_device *fbdev;
 	struct au1200fb_platdata *pd;
 	struct fb_info *fbi = NULL;
-	unsigned long page;
 	int bpp, plane, ret, irq;
 
 	print_info("" DRIVER_DESC "");
@@ -1685,6 +1683,7 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 		fbdev = fbi->par;
 		fbdev->fb_info = fbi;
 		fbdev->pd = pd;
+		fbdev->dev = &dev->dev;
 
 		fbdev->plane = plane;
 
@@ -1702,16 +1701,6 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 			goto failed;
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
2.20.1

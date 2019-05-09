From: Christoph Hellwig <hch@lst.de>
Date: Thu, 09 May 2019 17:38:47 +0000
Subject: [PATCH 1/3] au1100fb: fix DMA API abuse
Message-Id: <20190509173849.11825-2-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190509173849.11825-1-hch@lst.de>
In-Reply-To: <20190509173849.11825-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Manuel Lauss <manuel.lauss@gmail.com>
Cc: linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Virtual addresses return from dma(m)_alloc_coherent are opaque in what
backs then, and drivers must not poke into them.  Switch the driver
to use the generic DMA API mmap helper to avoid these problems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/au1100fb.c | 24 ++++--------------------
 drivers/video/fbdev/au1100fb.h |  1 +
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 0adf0683cf08..99941ae1f3a1 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -340,14 +340,12 @@ int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
  */
 int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 {
-	struct au1100fb_device *fbdev;
-
-	fbdev = to_au1100fb_device(fbi);
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
 
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	pgprot_val(vma->vm_page_prot) |= (6 << 9); //CCA=6
 
-	return vm_iomap_memory(vma, fbdev->fb_phys, fbdev->fb_len);
+	return dma_mmap_coherent(fbdev->dev, vma, fbdev->fb_mem, fbdev->fb_phys,
+			fbdev->fb_len);
 }
 
 static struct fb_ops au1100fb_ops @@ -412,7 +410,6 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 {
 	struct au1100fb_device *fbdev;
 	struct resource *regs_res;
-	unsigned long page;
 	struct clk *c;
 
 	/* Allocate new device private */
@@ -424,6 +421,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 		goto failed;
 
 	platform_set_drvdata(dev, (void *)fbdev);
+	fbdev->dev = &dev->dev;
 
 	/* Allocate region for our registers and map them */
 	regs_res = platform_get_resource(dev, IORESOURCE_MEM, 0);
@@ -472,20 +470,6 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	au1100fb_fix.smem_start = fbdev->fb_phys;
 	au1100fb_fix.smem_len = fbdev->fb_len;
 
-	/*
-	 * Set page reserved so that mmap will work. This is necessary
-	 * since we'll be remapping normal memory.
-	 */
-	for (page = (unsigned long)fbdev->fb_mem;
-	     page < PAGE_ALIGN((unsigned long)fbdev->fb_mem + fbdev->fb_len);
-	     page += PAGE_SIZE) {
-#ifdef CONFIG_DMA_NONCOHERENT
-		SetPageReserved(virt_to_page(CAC_ADDR((void *)page)));
-#else
-		SetPageReserved(virt_to_page(page));
-#endif
-	}
-
 	print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
 	print_dbg("phys=0x%08x, size=%dK", fbdev->fb_phys, fbdev->fb_len / 1024);
 
diff --git a/drivers/video/fbdev/au1100fb.h b/drivers/video/fbdev/au1100fb.h
index 9af19939a9c6..e7239bceefd3 100644
--- a/drivers/video/fbdev/au1100fb.h
+++ b/drivers/video/fbdev/au1100fb.h
@@ -110,6 +110,7 @@ struct au1100fb_device {
 	dma_addr_t    		fb_phys;
 	int			panel_idx;
 	struct clk		*lcdclk;
+	struct device		*dev;
 };
 
 /********************************************************************/
-- 
2.20.1

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 25 Jun 2019 12:13:21 +0000
Subject: [PATCH] au1200fb: don't use DMA_ATTR_NON_CONSISTENT
Message-Id: <20190625121321.10197-1-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

au1200fb allocates DMA memory using DMA_ATTR_NON_CONSISTENT, but never
calls dma_cache_sync to synchronize the memory between the CPU and the
device.  If it was use on a not cache coherent bus that would be fatal,
but as far as I can tell from the naming and the mips platform
implementation it always is used in cache coherent systems.  Remove
the DMA_ATTR_NON_CONSISTENT flag, which is a no-op in that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/video/fbdev/au1200fb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 26caffb02b7e..265d3b45efd0 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1234,7 +1234,7 @@ static int au1200fb_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	struct au1200fb_device *fbdev = info->par;
 
 	return dma_mmap_attrs(fbdev->dev, vma, fbdev->fb_mem, fbdev->fb_phys,
-			fbdev->fb_len, DMA_ATTR_NON_CONSISTENT);
+			fbdev->fb_len, 0);
 }
 
 static void set_global(u_int cmd, struct au1200_lcd_global_regs_t *pdata)
@@ -1692,8 +1692,7 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 
 		fbdev->fb_mem = dmam_alloc_attrs(&dev->dev,
 				PAGE_ALIGN(fbdev->fb_len),
-				&fbdev->fb_phys, GFP_KERNEL,
-				DMA_ATTR_NON_CONSISTENT);
+				&fbdev->fb_phys, GFP_KERNEL, 0);
 		if (!fbdev->fb_mem) {
 			print_err("fail to allocate framebuffer (size: %dK))",
 				  fbdev->fb_len / 1024);
-- 
2.20.1

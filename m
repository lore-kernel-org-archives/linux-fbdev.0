From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 23 Apr 2013 06:36:49 +0000
Subject: [PATCH 02/11] fbdev/omapfb: use vm_iomap_memory()
Message-Id: <1366699018-5439-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366699018-5439-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1366699018-5439-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use vm_iomap_memory() instead of [io_]remap_pfn_range().
vm_iomap_memory() gives us much simpler API to map memory to userspace,
and reduces possibilities for bugs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index ca585ef..717f13a 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1101,41 +1101,25 @@ static int omapfb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 	struct omapfb_info *ofbi = FB2OFB(fbi);
 	struct fb_fix_screeninfo *fix = &fbi->fix;
 	struct omapfb2_mem_region *rg;
-	unsigned long off;
 	unsigned long start;
 	u32 len;
-	int r = -EINVAL;
-
-	if (vma->vm_end - vma->vm_start = 0)
-		return 0;
-	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
-		return -EINVAL;
-	off = vma->vm_pgoff << PAGE_SHIFT;
+	int r;
 
 	rg = omapfb_get_mem_region(ofbi->region);
 
 	start = omapfb_get_region_paddr(ofbi);
 	len = fix->smem_len;
-	if (off >= len)
-		goto error;
-	if ((vma->vm_end - vma->vm_start + off) > len)
-		goto error;
-
-	off += start;
 
-	DBG("user mmap region start %lx, len %d, off %lx\n", start, len, off);
+	DBG("user mmap region start %lx, len %d, off %lx\n", start, len,
+			vma->vm_pgoff << PAGE_SHIFT);
 
-	vma->vm_pgoff = off >> PAGE_SHIFT;
-	/* VM_IO | VM_DONTEXPAND | VM_DONTDUMP are set by remap_pfn_range() */
 	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 	vma->vm_ops = &mmap_user_ops;
 	vma->vm_private_data = rg;
-	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
-			       vma->vm_end - vma->vm_start,
-			       vma->vm_page_prot)) {
-		r = -EAGAIN;
+
+	r = vm_iomap_memory(vma, start, len);
+	if (r)
 		goto error;
-	}
 
 	/* vm_ops.open won't be called for mmap itself. */
 	atomic_inc(&rg->map_count);
@@ -1144,7 +1128,7 @@ static int omapfb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 
 	return 0;
 
- error:
+error:
 	omapfb_put_mem_region(ofbi->region);
 
 	return r;
-- 
1.7.10.4


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 23 Apr 2013 06:36:55 +0000
Subject: [PATCH 08/11] fbdev/vermillion: use vm_iomap_memory()
Message-Id: <1366699018-5439-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366699018-5439-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1366699018-5439-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Alan Hourihane <alanh@fairlite.demon.co.uk>

Use vm_iomap_memory() instead of [io_]remap_pfn_range().
vm_iomap_memory() gives us much simpler API to map memory to userspace,
and reduces possibilities for bugs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Alan Hourihane <alanh@fairlite.demon.co.uk>
---
 drivers/video/vermilion/vermilion.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/video/vermilion/vermilion.c b/drivers/video/vermilion/vermilion.c
index 0aa516f..09a1366 100644
--- a/drivers/video/vermilion/vermilion.c
+++ b/drivers/video/vermilion/vermilion.c
@@ -1003,24 +1003,18 @@ static int vmlfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 static int vmlfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct vml_info *vinfo = container_of(info, struct vml_info, info);
-	unsigned long size = vma->vm_end - vma->vm_start;
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	int ret;
 
-	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
-		return -EINVAL;
-	if (offset + size > vinfo->vram_contig_size)
-		return -EINVAL;
 	ret = vmlfb_vram_offset(vinfo, offset);
 	if (ret)
 		return -EINVAL;
-	offset += vinfo->vram_start;
+
 	pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
 	pgprot_val(vma->vm_page_prot) &= ~_PAGE_PWT;
-	if (remap_pfn_range(vma, vma->vm_start, offset >> PAGE_SHIFT,
-						size, vma->vm_page_prot))
-		return -EAGAIN;
-	return 0;
+
+	return vm_iomap_memory(vma, vinfo->vram_start,
+			vinfo->vram_contig_size);
 }
 
 static int vmlfb_sync(struct fb_info *info)
-- 
1.7.10.4


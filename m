From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 23 Apr 2013 06:36:57 +0000
Subject: [PATCH 10/11] fbdev/ps3fb: use vm_iomap_memory()
Message-Id: <1366699018-5439-10-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366699018-5439-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1366699018-5439-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Use vm_iomap_memory() instead of [io_]remap_pfn_range().
vm_iomap_memory() gives us much simpler API to map memory to userspace,
and reduces possibilities for bugs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 920c27b..1bdeb08 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -705,21 +705,14 @@ static int ps3fb_pan_display(struct fb_var_screeninfo *var,
 
 static int ps3fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
-	unsigned long size, offset;
+	int r;
 
-	size = vma->vm_end - vma->vm_start;
-	offset = vma->vm_pgoff << PAGE_SHIFT;
-	if (offset + size > info->fix.smem_len)
-		return -EINVAL;
-
-	offset += info->fix.smem_start;
-	if (remap_pfn_range(vma, vma->vm_start, offset >> PAGE_SHIFT,
-			    size, vma->vm_page_prot))
-		return -EAGAIN;
+	r = vm_ioremap_memory(vma, info->fix.smem_start, info->fix.smem_len);
 
 	dev_dbg(info->device, "ps3fb: mmap framebuffer P(%lx)->V(%lx)\n",
 		offset, vma->vm_start);
-	return 0;
+
+	return r;
 }
 
     /*
-- 
1.7.10.4


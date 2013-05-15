From: Geoff Levand <geoff@infradead.org>
Date: Wed, 15 May 2013 03:12:37 +0000
Subject: [PATCH] ps3fb: Fix compile warning
Message-Id: <1368587557.4004.3.camel@clam>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Fix the following compile warning when -Wparentheses is set:

 drivers/video/ps3fb.c: warning: suggest parentheses around ‘+’ inside ‘<<’

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Hi Florian,

Please apply.

-Geoff

 drivers/video/ps3fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index d9f08c6..a397271d 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -710,7 +710,7 @@ static int ps3fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	r = vm_iomap_memory(vma, info->fix.smem_start, info->fix.smem_len);
 
 	dev_dbg(info->device, "ps3fb: mmap framebuffer P(%lx)->V(%lx)\n",
-		info->fix.smem_start + vma->vm_pgoff << PAGE_SHIFT,
+		(info->fix.smem_start + vma->vm_pgoff) << PAGE_SHIFT,
 		vma->vm_start);
 
 	return r;
-- 
1.8.1.2



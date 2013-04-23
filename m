From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 23 Apr 2013 06:36:58 +0000
Subject: [PATCH 11/11] fbdev: improve fb_mmap bounds checks
Message-Id: <1366699018-5439-11-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366699018-5439-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1366699018-5439-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Steve Glendinning <steve.glendinning@smsc.com>, Bernie Thompson <bernie@plugable.com>

Improve fb_mmap bounds checks in gbefb, smscufx, udlfb and vfb drivers to
prevent possible uint overflows.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Steve Glendinning <steve.glendinning@smsc.com>
Cc: Bernie Thompson <bernie@plugable.com>
---
 drivers/video/gbefb.c   |    4 +++-
 drivers/video/smscufx.c |    6 +++++-
 drivers/video/udlfb.c   |    6 +++++-
 drivers/video/vfb.c     |    7 +++++--
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
index bda5e39..ceab370 100644
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -1016,7 +1016,9 @@ static int gbefb_mmap(struct fb_info *info,
 	/* check range */
 	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
 		return -EINVAL;
-	if (offset + size > gbe_mem_size)
+	if (size > gbe_mem_size)
+		return -EINVAL;
+	if (offset > gbe_mem_size - size)
 		return -EINVAL;
 
 	/* remap using the fastest write-through mode on architecture */
diff --git a/drivers/video/smscufx.c b/drivers/video/smscufx.c
index 97bd662..b2b33fc 100644
--- a/drivers/video/smscufx.c
+++ b/drivers/video/smscufx.c
@@ -782,7 +782,11 @@ static int ufx_ops_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long page, pos;
 
-	if (offset + size > info->fix.smem_len)
+	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
+		return -EINVAL;
+	if (size > info->fix.smem_len)
+		return -EINVAL;
+	if (offset > info->fix.smem_len - size)
 		return -EINVAL;
 
 	pos = (unsigned long)info->fix.smem_start + offset;
diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index 86d449e..ec03e72 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -324,7 +324,11 @@ static int dlfb_ops_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long page, pos;
 
-	if (offset + size > info->fix.smem_len)
+	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
+		return -EINVAL;
+	if (size > info->fix.smem_len)
+		return -EINVAL;
+	if (offset > info->fix.smem_len - size)
 		return -EINVAL;
 
 	pos = (unsigned long)info->fix.smem_start + offset;
diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index 8bc1f93..ee5985e 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -420,9 +420,12 @@ static int vfb_mmap(struct fb_info *info,
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long page, pos;
 
-	if (offset + size > info->fix.smem_len) {
+	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
+		return -EINVAL;
+	if (size > info->fix.smem_len)
+		return -EINVAL;
+	if (offset > info->fix.smem_len - size)
 		return -EINVAL;
-	}
 
 	pos = (unsigned long)info->fix.smem_start + offset;
 
-- 
1.7.10.4


From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] fbdev: bf54x-lq043fb/bfin-t350mcqb-fb: drop custom mmap() handler
Date: Mon, 21 Dec 2009 09:25:42 -0500
Message-ID: <1261405542-7079-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754141AbZLUOYo@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

The common Blackfin code implements the get_fb_unmapped_area() function,
so we no longer need to have our own mmap() handler.  The common fb code
will take care of everything for us now.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/video/bf54x-lq043fb.c    |   30 ------------------------------
 drivers/video/bfin-t350mcqb-fb.c |   29 -----------------------------
 2 files changed, 0 insertions(+), 59 deletions(-)

diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index e49ae5e..814312a 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -82,7 +82,6 @@ struct bfin_bf54xfb_info {
 	unsigned char *fb_buffer;	/* RGB Buffer */
 
 	dma_addr_t dma_handle;
-	int lq043_mmap;
 	int lq043_open_cnt;
 	int irq;
 	spinlock_t lock;	/* lock */
@@ -316,7 +315,6 @@ static int bfin_bf54x_fb_release(struct fb_info *info, int user)
 	spin_lock(&fbi->lock);
 
 	fbi->lq043_open_cnt--;
-	fbi->lq043_mmap = 0;
 
 	if (fbi->lq043_open_cnt <= 0) {
 
@@ -374,33 +372,6 @@ static int bfin_bf54x_fb_check_var(struct fb_var_screeninfo *var,
 	return 0;
 }
 
-static int bfin_bf54x_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
-{
-
-	struct bfin_bf54xfb_info *fbi = info->par;
-
-	if (fbi->lq043_mmap)
-		return -1;
-
-	spin_lock(&fbi->lock);
-	fbi->lq043_mmap = 1;
-	spin_unlock(&fbi->lock);
-
-	vma->vm_start = (unsigned long)(fbi->fb_buffer);
-
-	vma->vm_end = vma->vm_start + info->fix.smem_len;
-	/* For those who don't understand how mmap works, go read
-	 *   Documentation/nommu-mmap.txt.
-	 * For those that do, you will know that the VM_MAYSHARE flag
-	 * must be set in the vma->vm_flags structure on noMMU
-	 *   Other flags can be set, and are documented in
-	 *   include/linux/mm.h
-	 */
-	vma->vm_flags |=  VM_MAYSHARE | VM_SHARED;
-
-	return 0;
-}
-
 int bfin_bf54x_fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	if (nocursor)
@@ -452,7 +423,6 @@ static struct fb_ops bfin_bf54x_fb_ops = {
 	.fb_fillrect = cfb_fillrect,
 	.fb_copyarea = cfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
-	.fb_mmap = bfin_bf54x_fb_mmap,
 	.fb_cursor = bfin_bf54x_fb_cursor,
 	.fb_setcolreg = bfin_bf54x_fb_setcolreg,
 };
diff --git a/drivers/video/bfin-t350mcqb-fb.c b/drivers/video/bfin-t350mcqb-fb.c
index 2549c53..5653d08 100644
--- a/drivers/video/bfin-t350mcqb-fb.c
+++ b/drivers/video/bfin-t350mcqb-fb.c
@@ -87,7 +87,6 @@ struct bfin_t350mcqbfb_info {
 	struct device *dev;
 	unsigned char *fb_buffer;	/* RGB Buffer */
 	dma_addr_t dma_handle;
-	int lq043_mmap;
 	int lq043_open_cnt;
 	int irq;
 	spinlock_t lock;	/* lock */
@@ -235,7 +234,6 @@ static int bfin_t350mcqb_fb_release(struct fb_info *info, int user)
 	spin_lock(&fbi->lock);
 
 	fbi->lq043_open_cnt--;
-	fbi->lq043_mmap = 0;
 
 	if (fbi->lq043_open_cnt <= 0) {
 		bfin_t350mcqb_disable_ppi();
@@ -293,32 +291,6 @@ static int bfin_t350mcqb_fb_check_var(struct fb_var_screeninfo *var,
 	return 0;
 }
 
-static int bfin_t350mcqb_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
-{
-	struct bfin_t350mcqbfb_info *fbi = info->par;
-
-	if (fbi->lq043_mmap)
-		return -1;
-
-	spin_lock(&fbi->lock);
-	fbi->lq043_mmap = 1;
-	spin_unlock(&fbi->lock);
-
-	vma->vm_start = (unsigned long)(fbi->fb_buffer + ACTIVE_VIDEO_MEM_OFFSET);
-
-	vma->vm_end = vma->vm_start + info->fix.smem_len;
-	/* For those who don't understand how mmap works, go read
-	 *   Documentation/nommu-mmap.txt.
-	 * For those that do, you will know that the VM_MAYSHARE flag
-	 * must be set in the vma->vm_flags structure on noMMU
-	 *   Other flags can be set, and are documented in
-	 *   include/linux/mm.h
-	 */
-	vma->vm_flags |= VM_MAYSHARE | VM_SHARED;
-
-	return 0;
-}
-
 int bfin_t350mcqb_fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	if (nocursor)
@@ -370,7 +342,6 @@ static struct fb_ops bfin_t350mcqb_fb_ops = {
 	.fb_fillrect = cfb_fillrect,
 	.fb_copyarea = cfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
-	.fb_mmap = bfin_t350mcqb_fb_mmap,
 	.fb_cursor = bfin_t350mcqb_fb_cursor,
 	.fb_setcolreg = bfin_t350mcqb_fb_setcolreg,
 };
-- 
1.6.5.4

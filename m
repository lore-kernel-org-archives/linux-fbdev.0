From: Timur Tabi <timur@freescale.com>
Date: Mon, 19 Dec 2011 22:26:18 +0000
Subject: [PATCH 5/5] drivers/video: fsl-diu-fb: merge fsl_diu_alloc() into map_video_memory()
Message-Id: <1324333578-23992-5-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Functions fsl_diu_alloc() and fsl_diu_free() were only being called by
map_video_memory() and unmap_video_memory(), respectively.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   47 ++++++++++---------------------------------
 1 files changed, 11 insertions(+), 36 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index e2f4f32..acf292b 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -461,37 +461,6 @@ static enum fsl_diu_monitor_port fsl_diu_name_to_port(const char *s)
 	return diu_ops.valid_monitor_port(port);
 }
 
-/**
- * fsl_diu_alloc - allocate memory for the DIU
- * @size: number of bytes to allocate
- * @param: returned physical address of memory
- *
- * This function allocates a physically-contiguous block of memory.
- */
-static void *fsl_diu_alloc(size_t size, phys_addr_t *phys)
-{
-	void *virt;
-
-	virt = alloc_pages_exact(size, GFP_DMA | __GFP_ZERO);
-	if (virt)
-		*phys = virt_to_phys(virt);
-
-	return virt;
-}
-
-/**
- * fsl_diu_free - release DIU memory
- * @virt: pointer returned by fsl_diu_alloc()
- * @size: number of bytes allocated by fsl_diu_alloc()
- *
- * This function releases memory allocated by fsl_diu_alloc().
- */
-static void fsl_diu_free(void *virt, size_t size)
-{
-	if (virt && size)
-		free_pages_exact(virt, size);
-}
-
 /*
  * Workaround for failed writing desc register of planes.
  * Needed with MPC5121 DIU rev 2.0 silicon.
@@ -875,16 +844,17 @@ static void update_lcdc(struct fb_info *info)
 
 static int map_video_memory(struct fb_info *info)
 {
-	phys_addr_t phys;
 	u32 smem_len = info->fix.line_length * info->var.yres_virtual;
+	void *p;
 
-	info->screen_base = fsl_diu_alloc(smem_len, &phys);
-	if (info->screen_base = NULL) {
+	p = alloc_pages_exact(smem_len, GFP_DMA | __GFP_ZERO);
+	if (!p) {
 		dev_err(info->dev, "unable to allocate fb memory\n");
 		return -ENOMEM;
 	}
 	mutex_lock(&info->mm_lock);
-	info->fix.smem_start = (unsigned long) phys;
+	info->screen_base = p;
+	info->fix.smem_start = virt_to_phys(info->screen_base);
 	info->fix.smem_len = smem_len;
 	mutex_unlock(&info->mm_lock);
 	info->screen_size = info->fix.smem_len;
@@ -894,12 +864,17 @@ static int map_video_memory(struct fb_info *info)
 
 static void unmap_video_memory(struct fb_info *info)
 {
-	fsl_diu_free(info->screen_base, info->fix.smem_len);
+	void *p = info->screen_base;
+	size_t l = info->fix.smem_len;
+
 	mutex_lock(&info->mm_lock);
 	info->screen_base = NULL;
 	info->fix.smem_start = 0;
 	info->fix.smem_len = 0;
 	mutex_unlock(&info->mm_lock);
+
+	if (p)
+		free_pages_exact(p, l);
 }
 
 /*
-- 
1.7.3.4



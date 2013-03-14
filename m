From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 14 Mar 2013 05:53:26 +0000
Subject: [PATCH 2/6] video: mxsfb: remove fb_phys/fb_size from platform_data
Message-Id: <1363240410-16865-3-git-send-email-shawn.guo@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363240410-16865-1-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1363240410-16865-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

There is no in-tree users of mxsfb_platform_data fb_phys/fb_size.
With CMA support in the kernel, there is no real need for platform to
reserve memory and pass address and size into driver via platform_data.
So let's remove fb_phys/fb_size from mxsfb_platform_data to ease full
device tree adoption.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/video/mxsfb.c |   39 +++++++--------------------------------
 include/linux/mxsfb.h |    9 ---------
 2 files changed, 7 insertions(+), 41 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 2c5ab15..776d0d5 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -168,7 +168,6 @@ struct mxsfb_info {
 	unsigned ld_intf_width;
 	unsigned dotclk_delay;
 	const struct mxsfb_devdata *devdata;
-	int mapped;
 };
 
 #define mxsfb_is_v3(host) (host->devdata->ipversion = 3)
@@ -685,7 +684,7 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host)
 	struct mxsfb_platform_data *pdata = host->pdev->dev.platform_data;
 	dma_addr_t fb_phys;
 	void *fb_virt;
-	unsigned fb_size = pdata->fb_size;
+	unsigned fb_size;
 
 	fb_info->fbops = &mxsfb_ops;
 	fb_info->flags = FBINFO_FLAG_DEFAULT | FBINFO_READS_FAST;
@@ -705,30 +704,12 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host)
 	host->ld_intf_width = pdata->ld_intf_width;
 
 	/* Memory allocation for framebuffer */
-	if (pdata->fb_phys) {
-		if (!fb_size)
-			return -EINVAL;
-
-		fb_phys = pdata->fb_phys;
+	fb_size = SZ_2M;
+	fb_virt = alloc_pages_exact(fb_size, GFP_DMA);
+	if (!fb_virt)
+		return -ENOMEM;
 
-		if (!request_mem_region(fb_phys, fb_size, host->pdev->name))
-			return -ENOMEM;
-
-		fb_virt = ioremap(fb_phys, fb_size);
-		if (!fb_virt) {
-			release_mem_region(fb_phys, fb_size);
-			return -ENOMEM;
-		}
-		host->mapped = 1;
-	} else {
-		if (!fb_size)
-			fb_size = SZ_2M; /* default */
-		fb_virt = alloc_pages_exact(fb_size, GFP_DMA);
-		if (!fb_virt)
-			return -ENOMEM;
-
-		fb_phys = virt_to_phys(fb_virt);
-	}
+	fb_phys = virt_to_phys(fb_virt);
 
 	fb_info->fix.smem_start = fb_phys;
 	fb_info->screen_base = fb_virt;
@@ -744,13 +725,7 @@ static void mxsfb_free_videomem(struct mxsfb_info *host)
 {
 	struct fb_info *fb_info = &host->fb_info;
 
-	if (host->mapped) {
-		iounmap(fb_info->screen_base);
-		release_mem_region(fb_info->fix.smem_start,
-				fb_info->screen_size);
-	} else {
-		free_pages_exact(fb_info->screen_base, fb_info->fix.smem_len);
-	}
+	free_pages_exact(fb_info->screen_base, fb_info->fix.smem_len);
 }
 
 static struct platform_device_id mxsfb_devtype[] = {
diff --git a/include/linux/mxsfb.h b/include/linux/mxsfb.h
index f14943d..93fc34b 100644
--- a/include/linux/mxsfb.h
+++ b/include/linux/mxsfb.h
@@ -35,15 +35,6 @@ struct mxsfb_platform_data {
 
 	unsigned dotclk_delay;	/* refer manual HW_LCDIF_VDCTRL4 register */
 	unsigned ld_intf_width;	/* refer STMLCDIF_* macros */
-
-	unsigned fb_size;	/* Size of the video memory. If zero a
-				 * default will be used
-				 */
-	unsigned long fb_phys;	/* physical address for the video memory. If
-				 * zero the framebuffer memory will be dynamically
-				 * allocated. If specified,fb_size must also be specified.
-				 * fb_phys must be unused by Linux.
-				 */
 };
 
 #endif /* __LINUX_MXSFB_H */
-- 
1.7.9.5



From: Rob Clark <robdclark@gmail.com>
Date: Tue, 11 Jul 2017 13:38:22 +0000
Subject: [PATCH 3/3] drm/msm: hijack firmware fb's memory
Message-Id: <20170711133822.31978-4-robdclark@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170711133822.31978-1-robdclark@gmail.com>
In-Reply-To: <20170711133822.31978-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

If we are kicking out efifb or simplefb then we want to hijack the
outgoing fb's memory and wrap it in a gem object so that it can
be allocated for use by fbdev helpers.  This way we keep the same
scanout buffer that the display is already using.

This is prep-work for enabling drm/msm to take over a display that
is enabled already by the bootloader.

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 82 +++++++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index f487437fb9d0..7c1ff26a3c13 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -304,6 +304,45 @@ static void kick_out_firmware_fb(void)
 	kfree(ap);
 }
 
+static unsigned long hijack_firmware_fb(struct drm_device *dev)
+{
+	struct msm_drm_private *priv = dev->dev_private;
+	unsigned long size;
+	int i;
+
+	/* if we have simplefb/efifb, find it's aperture and hijack
+	 * that before we kick out the firmware fb's.
+	 *
+	 * TODO we probably should hold registration_lock
+	 */
+	for (i = 0; i < FB_MAX; i++) {
+		struct fb_info *fb = get_fb_info(i);
+
+		if (IS_ERR_OR_NULL(fb))
+			continue;
+
+		if (!fb->apertures->count)
+			continue;
+
+		/* if we find efifb or simplefb, we are about to
+		 * kick them out, so hijack their memory:
+		 */
+		if ((strcmp(fb->fix.id, "EFI VGA") = 0) ||
+				(strcmp(fb->fix.id, "simple") = 0)) {
+
+			priv->vram.paddr = fb->apertures->ranges[0].base;
+			size = fb->apertures->ranges[0].size;
+		}
+
+		put_fb_info(fb);
+
+		if (size)
+			return size;
+	}
+
+	return 0;
+}
+
 static int msm_init_vram(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
@@ -335,39 +374,46 @@ static int msm_init_vram(struct drm_device *dev)
 		of_node_put(node);
 		if (ret)
 			return ret;
-		size = r.end - r.start;
+		size = r.end - r.start - 1;
 		DRM_INFO("using VRAM carveout: %lx@%pa\n", size, &r.start);
 
+	} else if ((size = hijack_firmware_fb(dev))) {
+		DRM_INFO("hijacking VRAM carveout: %lx@%pa\n",
+				size, &priv->vram.paddr);
+	} else if (!iommu_present(&platform_bus_type)) {
 		/* if we have no IOMMU, then we need to use carveout allocator.
 		 * Grab the entire CMA chunk carved out in early startup in
 		 * mach-msm:
 		 */
-	} else if (!iommu_present(&platform_bus_type)) {
 		DRM_INFO("using %s VRAM carveout\n", vram);
 		size = memparse(vram, NULL);
 	}
 
 	if (size) {
-		unsigned long attrs = 0;
-		void *p;
-
 		priv->vram.size = size;
 
-		drm_mm_init(&priv->vram.mm, 0, (size >> PAGE_SHIFT) - 1);
+		drm_mm_init(&priv->vram.mm, 0, (size >> PAGE_SHIFT));
 		spin_lock_init(&priv->vram.lock);
 
-		attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
-		attrs |= DMA_ATTR_WRITE_COMBINE;
-
-		/* note that for no-kernel-mapping, the vaddr returned
-		 * is bogus, but non-null if allocation succeeded:
-		 */
-		p = dma_alloc_attrs(dev->dev, size,
-				&priv->vram.paddr, GFP_KERNEL, attrs);
-		if (!p) {
-			dev_err(dev->dev, "failed to allocate VRAM\n");
-			priv->vram.paddr = 0;
-			return -ENOMEM;
+		if (!priv->vram.paddr) {
+			unsigned long attrs = 0;
+			void *p;
+
+			attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
+			attrs |= DMA_ATTR_WRITE_COMBINE;
+
+			/* note that for no-kernel-mapping, the vaddr returned
+			 * is bogus, but non-null if allocation succeeded:
+			 */
+			p = dma_alloc_attrs(dev->dev, size,
+					&priv->vram.paddr, GFP_KERNEL, attrs);
+			if (!p) {
+				dev_err(dev->dev, "failed to allocate VRAM\n");
+				priv->vram.paddr = 0;
+				return -ENOMEM;
+			}
+		} else {
+			request_region(priv->vram.paddr, size, "stolen");
 		}
 
 		dev_info(dev->dev, "VRAM: %08x->%08x\n",
-- 
2.13.0


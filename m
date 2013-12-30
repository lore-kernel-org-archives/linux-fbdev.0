From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 30 Dec 2013 13:19:10 +0000
Subject: [PATCH 2/2] omapfb: add support to reserve fb at specified phys address
Message-Id: <1388409550-10720-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The previous patch added support to reserve an exclusive coherent area
for omapfb. This patch adds support to allocate a fb from a specified
physical address inside that coherent area.

This can be used to "pass" a framebuffer from the bootloader to the
kernel: the bootloader sets up the DSS hardware to display a piece of
memory, and gives the address and size of the used piece of memory to
the kernel via omapfb_vram and omapfb.vram cmdline parameters.

Note that the DSS driver itself does not yet support this, and the DSS
hardware is reset at kernel init. This means that the display will be
off until later omapfb is started, which will set up the DSS again.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c | 36 ++++++++++++++++++++++++--------
 drivers/video/omap2/omapfb/omapfb.h      |  1 +
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 27d6905683f3..88c1fe92d2c6 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1383,18 +1383,36 @@ static int omapfb_alloc_fbmem(struct fb_info *fbi, unsigned long size,
 	rg->type = 0;
 	rg->alloc = false;
 	rg->map = false;
+	rg->noclear = 0;
 
 	size = PAGE_ALIGN(size);
 
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
+	if (paddr) {
+		DBG("reserving %#lx bytes at %#lx\n", size, paddr);
 
-	if (ofbi->rotation_type = OMAP_DSS_ROT_VRFB)
-		dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &attrs);
+		token = dma_mark_declared_memory_occupied(fbdev->dev,
+			paddr, size);
+
+		if (IS_ERR(token)) {
+			dev_err(fbdev->dev,
+				"dma_mark_declared_memory_occupied failed: %ld\n",
+				PTR_ERR(token));
+			return PTR_ERR(token);
+		}
+
+		dma_handle = paddr;
+		rg->noclear = 1;
+	} else {
+		dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
 
-	DBG("allocating %lu bytes for fb %d\n", size, ofbi->id);
+		if (ofbi->rotation_type = OMAP_DSS_ROT_VRFB)
+			dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &attrs);
 
-	token = dma_alloc_attrs(fbdev->dev, size, &dma_handle,
-			GFP_KERNEL, &attrs);
+		DBG("allocating %lu bytes for fb %d\n", size, ofbi->id);
+
+		token = dma_alloc_attrs(fbdev->dev, size, &dma_handle,
+				GFP_KERNEL, &attrs);
+	}
 
 	if (token = NULL) {
 		dev_err(fbdev->dev, "failed to allocate framebuffer\n");
@@ -1513,9 +1531,6 @@ static int omapfb_parse_vram_param(const char *param, int max_entries,
 
 		}
 
-		WARN_ONCE(paddr,
-			"reserving memory at predefined address not supported\n");
-
 		paddrs[fbnum] = paddr;
 		sizes[fbnum] = size;
 
@@ -1950,6 +1965,9 @@ static int omapfb_create_framebuffers(struct omapfb2_device *fbdev)
 		if (ofbi->region->size = 0)
 			continue;
 
+		if (ofbi->region->noclear)
+			continue;
+
 		omapfb_clear_fb(fbi);
 	}
 
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/omapfb/omapfb.h
index 623cd872a367..69642944f453 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -64,6 +64,7 @@ struct omapfb2_mem_region {
 	atomic_t	map_count;
 	struct rw_semaphore lock;
 	atomic_t	lock_count;
+	bool		noclear;	/* don't clear the fb on alloc */
 };
 
 /* appended to fb_info */
-- 
1.8.3.2


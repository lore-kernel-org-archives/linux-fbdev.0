From: Qiang Chen <qiang2.chen@sonymobile.com>
Date: Fri, 05 Dec 2014 08:18:30 +0000
Subject: [PATCH] video: ocfb: Fix data type warning
Message-Id: <1417767510-31462-1-git-send-email-qiang2.chen@sonymobile.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Qiang Chen <qcwj.lk@gmail.com>

When allocate framebuffer memory using dma_alloc_coherent(),
we'd better use dma_addr_t instead of phys_addr_t. Because the
address we got in fact is DMA or bus address for the platform.

This patch also fixes below build warning:
drivers/video/fbdev/ocfb.c:335:2:
	warning: passing argument 3 of ‘dma_alloc_attrs’
	from incompatible pointer type [enabled by default]

Signed-off-by: Qiang Chen <qiang2.chen@sonymobile.com>
---
 drivers/video/fbdev/ocfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ocfb.c b/drivers/video/fbdev/ocfb.c
index 7f9dc9b..de98196 100644
--- a/drivers/video/fbdev/ocfb.c
+++ b/drivers/video/fbdev/ocfb.c
@@ -61,7 +61,7 @@ struct ocfb_dev {
 	/* flag indicating whether the regs are little endian accessed */
 	int little_endian;
 	/* Physical and virtual addresses of framebuffer */
-	phys_addr_t fb_phys;
+	dma_addr_t fb_phys;
 	void __iomem *fb_virt;
 	u32 pseudo_palette[PALETTE_SIZE];
 };
-- 
1.8.2.2


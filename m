From: Christoph Hellwig <hch@lst.de>
Date: Mon, 17 Aug 2015 08:10:56 +0000
Subject: [PATCH] ocfb: remove incorrect __iomem annotation
Message-Id: <1439799056-16509-1-git-send-email-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Make sparse happy:

drivers/video/fbdev/ocfb.c:375:64: sparse: incorrect type in argument 3 (different address spaces)

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/video/fbdev/ocfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ocfb.c b/drivers/video/fbdev/ocfb.c
index de98196..97f11d2 100644
--- a/drivers/video/fbdev/ocfb.c
+++ b/drivers/video/fbdev/ocfb.c
@@ -62,7 +62,7 @@ struct ocfb_dev {
 	int little_endian;
 	/* Physical and virtual addresses of framebuffer */
 	dma_addr_t fb_phys;
-	void __iomem *fb_virt;
+	void *fb_virt;
 	u32 pseudo_palette[PALETTE_SIZE];
 };
 
-- 
1.9.1


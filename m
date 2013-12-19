From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 19 Dec 2013 08:23:08 +0000
Subject: [PATCH] video: mx3fb: Allow blocking during framebuffer allocation
Message-Id: <1387441388-10962-1-git-send-email-s.hauer@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org

No need to allocate the framebuffer from the atomic pool, we are not
in interrupt context. Adding GFP_KERNEL to the framebuffer allocation
allows to use the much bigger CMA pool to allocate the framebuffer.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/video/mx3fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index cfdb380..c882bec 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -1263,7 +1263,7 @@ static int mx3fb_map_video_memory(struct fb_info *fbi, unsigned int mem_len,
 
 	fbi->screen_base = dma_alloc_writecombine(fbi->device,
 						  mem_len,
-						  &addr, GFP_DMA);
+						  &addr, GFP_DMA | GFP_KERNEL);
 
 	if (!fbi->screen_base) {
 		dev_err(fbi->device, "Cannot allocate %u bytes framebuffer memory\n",
-- 
1.8.5.1


From: Christoph Hellwig <hch@lst.de>
Date: Thu, 09 May 2019 17:38:49 +0000
Subject: [PATCH 3/3] jz4740_fb: fix DMA API abuse
Message-Id: <20190509173849.11825-4-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190509173849.11825-1-hch@lst.de>
In-Reply-To: <20190509173849.11825-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Manuel Lauss <manuel.lauss@gmail.com>
Cc: linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Virtual addresses return from dma(m)_alloc_coherent are opaque in what
backs then, and drivers must not poke into them.  Switch the driver
to use the generic DMA API mmap helper to avoid these problems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/video/fbdev/jz4740_fb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/video/fbdev/jz4740_fb.c b/drivers/video/fbdev/jz4740_fb.c
index b57df83fdbd3..b95cdfa9e0a1 100644
--- a/drivers/video/fbdev/jz4740_fb.c
+++ b/drivers/video/fbdev/jz4740_fb.c
@@ -466,7 +466,6 @@ static int jzfb_alloc_devmem(struct jzfb *jzfb)
 {
 	int max_videosize = 0;
 	struct fb_videomode *mode = jzfb->pdata->modes;
-	void *page;
 	int i;
 
 	for (i = 0; i < jzfb->pdata->num_modes; ++mode, ++i) {
@@ -491,12 +490,6 @@ static int jzfb_alloc_devmem(struct jzfb *jzfb)
 	if (!jzfb->vidmem)
 		goto err_free_framedesc;
 
-	for (page = jzfb->vidmem;
-		 page < jzfb->vidmem + PAGE_ALIGN(jzfb->vidmem_size);
-		 page += PAGE_SIZE) {
-		SetPageReserved(virt_to_page(page));
-	}
-
 	jzfb->framedesc->next = jzfb->framedesc_phys;
 	jzfb->framedesc->addr = jzfb->vidmem_phys;
 	jzfb->framedesc->id = 0xdeafbead;
-- 
2.20.1

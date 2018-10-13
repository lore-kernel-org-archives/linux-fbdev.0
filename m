From: Christoph Hellwig <hch@lst.de>
Date: Sat, 13 Oct 2018 15:17:07 +0000
Subject: [PATCH 8/8] fsl-diu-fb: don't pass GFP_DMA32 to dmam_alloc_coherent
Message-Id: <20181013151707.32210-9-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181013151707.32210-1-hch@lst.de>
In-Reply-To: <20181013151707.32210-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org

The DMA API does its own zone decisions based on the coherent_dma_mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/video/fbdev/fsl-diu-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index bc9eb8afc313..6a49fe917bdb 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1697,7 +1697,7 @@ static int fsl_diu_probe(struct platform_device *pdev)
 	int ret;
 
 	data = dmam_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
-				   &dma_addr, GFP_DMA | __GFP_ZERO);
+				   &dma_addr, GFP_KERNEL | __GFP_ZERO);
 	if (!data)
 		return -ENOMEM;
 	data->dma_addr = dma_addr;
-- 
2.19.1

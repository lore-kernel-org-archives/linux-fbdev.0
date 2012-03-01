From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 01 Mar 2012 15:07:49 +0000
Subject: [PATCH v2 36/57] fbdev: sh_mobile_lcdc: Pass physical device pointer to DMA functions
Message-Id: <1330614490-14149-37-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The dma_map_sg() and dma_unmap_sg() functions need a pointer to the
physical device.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 1f8dd83..fc12e37 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -313,11 +313,12 @@ static void sh_mobile_lcdc_deferred_io(struct fb_info *info,
 		unsigned int nr_pages = sh_mobile_lcdc_sginit(info, pagelist);
 
 		/* trigger panel update */
-		dma_map_sg(info->dev, ch->sglist, nr_pages, DMA_TO_DEVICE);
+		dma_map_sg(ch->lcdc->dev, ch->sglist, nr_pages, DMA_TO_DEVICE);
 		if (panel->start_transfer)
 			panel->start_transfer(ch, &sh_mobile_lcdc_sys_bus_ops);
 		lcdc_write_chan(ch, LDSM2R, LDSM2R_OSTRG);
-		dma_unmap_sg(info->dev, ch->sglist, nr_pages, DMA_TO_DEVICE);
+		dma_unmap_sg(ch->lcdc->dev, ch->sglist, nr_pages,
+			     DMA_TO_DEVICE);
 	} else {
 		if (panel->start_transfer)
 			panel->start_transfer(ch, &sh_mobile_lcdc_sys_bus_ops);
-- 
1.7.3.4


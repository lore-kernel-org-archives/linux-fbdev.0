From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] video: add sh_mobile_lcdcfb memory resource
Date: Tue, 12 May 2009 18:57:45 +0900
Message-ID: <20090512095745.25477.87326.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, linux-fbdev-devel@lists.sourceforge.net

From: Magnus Damm <damm@igel.co.jp>

This patch adds memory resource support to the LCDC driver.
With this applied the physical memory range used for framebuffer
data will show up in /proc/iomem together with other SuperH
Mobile devices.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/sh_mobile_lcdcfb.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2009-05-11 21:14:35.000000000 +0900
@@ -35,6 +35,7 @@ struct sh_mobile_lcdc_chan {
 	struct fb_deferred_io defio;
 	unsigned long frame_end;
 	wait_queue_head_t frame_end_wait;
+	struct resource memory;
 };
 
 struct sh_mobile_lcdc_priv {
@@ -813,12 +814,26 @@ static int __init sh_mobile_lcdc_probe(s
 			break;
 		}
 
+		res = &priv->ch[i].memory;
+		res->name = "lcdc";
+		res->start = priv->ch[i].dma_handle;
+		res->end = res->start + info->fix.smem_len - 1;
+		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		error = insert_resource(&iomem_resource, res);
+		if (error) {
+			dev_err(&pdev->dev, "unable to request resource\n");
+			dma_free_coherent(&pdev->dev, info->fix.smem_len,
+					  buf, priv->ch[i].dma_handle);
+			break;
+		}
+
 		info->pseudo_palette = &priv->ch[i].pseudo_palette;
 		info->flags = FBINFO_FLAG_DEFAULT;
 
 		error = fb_alloc_cmap(&info->cmap, PALETTE_NR, 0);
 		if (error < 0) {
 			dev_err(&pdev->dev, "unable to allocate cmap\n");
+			release_resource(res);
 			dma_free_coherent(&pdev->dev, info->fix.smem_len,
 					  buf, priv->ch[i].dma_handle);
 			break;
@@ -887,6 +902,7 @@ static int sh_mobile_lcdc_remove(struct 
 		if (!info->device)
 			continue;
 
+		release_resource(&priv->ch[i].memory);
 		dma_free_coherent(&pdev->dev, info->fix.smem_len,
 				  info->screen_base, priv->ch[i].dma_handle);
 		fb_dealloc_cmap(&info->cmap);

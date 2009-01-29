From: Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
Subject: [PATCH 3/3] gx1fb: properly alloc cmap and plug cmap leak
Date: Thu, 29 Jan 2009 18:46:02 +0000
Message-ID: <20090129184602.6005697a@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-geode-bounces-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://bombadil.infradead.org/mailman/listinfo/linux-geode>, 
	<mailto:linux-geode-request-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://bombadil.infradead.org/pipermail/linux-geode>
List-Post: <mailto:linux-geode-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org>
List-Help: <mailto:linux-geode-request-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org?subject=help>
List-Subscribe: <http://bombadil.infradead.org/mailman/listinfo/linux-geode>, 
	<mailto:linux-geode-request-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org?subject=subscribe>
Sender: linux-geode-bounces-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org
Errors-To: linux-geode-bounces-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: adaplas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lkml-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-geode-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org


We weren't properly allocating the cmap for depths greater than 8bpp,
which caused pain for things like DirectFB.  Also, we never freed the
cmap memory upon module unload..

Signed-off-by: Andres Salomon <dilinger-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
---
 drivers/video/geode/gx1fb_core.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
index 751e491..f20eff8 100644
--- a/drivers/video/geode/gx1fb_core.c
+++ b/drivers/video/geode/gx1fb_core.c
@@ -136,13 +136,10 @@ static int gx1fb_set_par(struct fb_info *info)
 {
 	struct geodefb_par *par = info->par;
 
-	if (info->var.bits_per_pixel == 16) {
+	if (info->var.bits_per_pixel == 16)
 		info->fix.visual = FB_VISUAL_TRUECOLOR;
-		fb_dealloc_cmap(&info->cmap);
-	} else {
+	else
 		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
-		fb_alloc_cmap(&info->cmap, 1<<info->var.bits_per_pixel, 0);
-	}
 
 	info->fix.line_length = gx1_line_delta(info->var.xres, info->var.bits_per_pixel);
 
@@ -315,6 +312,10 @@ static struct fb_info * __init gx1fb_init_fbinfo(struct device *dev)
 	if (!par->panel_x)
 		par->enable_crt = 1; /* fall back to CRT if no panel is specified */
 
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
+		framebuffer_release(info);
+		return NULL;
+	}
 	return info;
 }
 
@@ -374,8 +375,11 @@ static int __init gx1fb_probe(struct pci_dev *pdev, const struct pci_device_id *
 		release_mem_region(gx1_gx_base() + 0x8300, 0x100);
 	}
 
-	if (info)
+	if (info) {
+		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
+	}
+
 	return ret;
 }
 
@@ -395,6 +399,7 @@ static void gx1fb_remove(struct pci_dev *pdev)
 	iounmap(par->dc_regs);
 	release_mem_region(gx1_gx_base() + 0x8300, 0x100);
 
+	fb_dealloc_cmap(&info->cmap);
 	pci_set_drvdata(pdev, NULL);
 
 	framebuffer_release(info);
-- 
1.5.6.5

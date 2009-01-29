From: Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
Subject: [PATCH 1/3] lxfb: properly alloc cmap in all cases and don't leak
	the memory
Date: Thu, 29 Jan 2009 18:45:34 +0000
Message-ID: <20090129184534.45de4b19@ephemeral>
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
Cc: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lkml-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adaplas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-geode-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Marco La Porta <marco-laporta-IWqWACnzNjyonA0d6jMUrA@public.gmane.org>

Hi Andrew,

Can you please replace Marco's patch with this one?  Marco, can you please
verify that this fixes your DirectFB issues?  Linux-fb folks, can you please
verify that we should always have a cmap allocated (if so, there are other
drivers that need fixing as well)?




From: Marco La Porta <marco-laporta-IWqWACnzNjyonA0d6jMUrA@public.gmane.org>

We weren't properly allocating the cmap for depths greater than 8bpp,
which caused pain for things like DirectFB.  Also, we never freed the
cmap memory upon module unload..

[dilinger-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org: dropped unnecessary code and clean up patch]
[dilinger-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org: add error checking and handling]

Signed-off-by: Andres Salomon <dilinger-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
---
 drivers/video/geode/lxfb_core.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/video/geode/lxfb_core.c b/drivers/video/geode/lxfb_core.c
index b965ecd..889cbe3 100644
--- a/drivers/video/geode/lxfb_core.c
+++ b/drivers/video/geode/lxfb_core.c
@@ -278,13 +278,10 @@ static int lxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 static int lxfb_set_par(struct fb_info *info)
 {
-	if (info->var.bits_per_pixel > 8) {
+	if (info->var.bits_per_pixel > 8)
 		info->fix.visual = FB_VISUAL_TRUECOLOR;
-		fb_dealloc_cmap(&info->cmap);
-	} else {
+	else
 		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
-		fb_alloc_cmap(&info->cmap, 1<<info->var.bits_per_pixel, 0);
-	}
 
 	info->fix.line_length = lx_get_pitch(info->var.xres,
 		info->var.bits_per_pixel);
@@ -451,6 +448,11 @@ static struct fb_info * __init lxfb_init_fbinfo(struct device *dev)
 
 	info->pseudo_palette	= (void *)par + sizeof(struct lxfb_par);
 
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
+		framebuffer_release(info);
+		return NULL;
+	}
+
 	info->var.grayscale	= 0;
 
 	return info;
@@ -579,8 +581,10 @@ err:
 		pci_release_region(pdev, 3);
 	}
 
-	if (info)
+	if (info) {
+		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
+	}
 
 	return ret;
 }
@@ -604,6 +608,7 @@ static void lxfb_remove(struct pci_dev *pdev)
 	iounmap(par->vp_regs);
 	pci_release_region(pdev, 3);
 
+	fb_dealloc_cmap(&info->cmap);
 	pci_set_drvdata(pdev, NULL);
 	framebuffer_release(info);
 }
-- 
1.5.6.5

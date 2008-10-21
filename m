From: Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH] pci: use pci_ioremap_bar() in
	drivers/video
Date: Mon, 20 Oct 2008 22:01:00 -0700
Message-ID: <20081020220100.57da1df5@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69) (envelope-from
	<SRS0+80749671ca352d596c14+1885+infradead.org+arjan@casper.srs.infradead.org>)
	id 1Ks9Mo-0001Py-3m for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Oct 2008 05:01:14 +0000
Received: from casper.infradead.org ([85.118.1.10])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ks9Mh-0001wp-WF
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Oct 2008 05:01:14 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org

From a7e1803c8c6534c0b432cec494cf8bc9ea12d972 Mon Sep 17 00:00:00 2001
From: Arjan van de Ven <arjan@linux.intel.com>
Date: Sun, 28 Sep 2008 16:21:24 -0700
Subject: [PATCH] pci: use pci_ioremap_bar() in drivers/video

Use the newly introduced pci_ioremap_bar() function in drivers/video.
pci_ioremap_bar() just takes a pci device and a bar number, with the goal
of making it really hard to get wrong, while also having a central place
to stick sanity checks.


Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/video/aty/aty128fb.c     |    2 +-
 drivers/video/cyber2000fb.c      |    3 +--
 drivers/video/geode/gx1fb_core.c |    3 +--
 drivers/video/geode/gxfb_core.c  |    8 +++-----
 drivers/video/geode/lxfb_core.c  |    9 +++------
 drivers/video/gxt4500.c          |    4 ++--
 6 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index 243ea4a..db16112 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -2051,7 +2051,7 @@ static int __devinit aty128_probe(struct pci_dev *pdev, const struct pci_device_
 
 	/* Virtualize mmio region */
 	info->fix.mmio_start = reg_addr;
-	par->regbase = ioremap(reg_addr, pci_resource_len(pdev, 2));
+	par->regbase = pci_ioremap_bar(pdev, 2);
 	if (!par->regbase)
 		goto err_free_info;
 
diff --git a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
index 41d6263..8cc038b 100644
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -1583,8 +1583,7 @@ cyberpro_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		goto failed_release;
 
 	cfb->dev = dev;
-	cfb->region = ioremap(pci_resource_start(dev, 0),
-			      pci_resource_len(dev, 0));
+	cfb->region = pci_ioremap_bar(dev, 0);
 	if (!cfb->region)
 		goto failed_ioremap;
 
diff --git a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
index bb20a22..751e491 100644
--- a/drivers/video/geode/gx1fb_core.c
+++ b/drivers/video/geode/gx1fb_core.c
@@ -217,8 +217,7 @@ static int __init gx1fb_map_video_memory(struct fb_info *info, struct pci_dev *d
 	ret = pci_request_region(dev, 0, "gx1fb (video)");
 	if (ret < 0)
 		return ret;
-	par->vid_regs = ioremap(pci_resource_start(dev, 0),
-				pci_resource_len(dev, 0));
+	par->vid_regs = pci_ioremap_bar(dev, 0);
 	if (!par->vid_regs)
 		return -ENOMEM;
 
diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index de2b8f9..4841189 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -242,23 +242,21 @@ static int __init gxfb_map_video_memory(struct fb_info *info, struct pci_dev *de
 	ret = pci_request_region(dev, 3, "gxfb (video processor)");
 	if (ret < 0)
 		return ret;
-	par->vid_regs = ioremap(pci_resource_start(dev, 3),
-				pci_resource_len(dev, 3));
+	par->vid_regs = pci_ioremap_bar(dev, 3);
 	if (!par->vid_regs)
 		return -ENOMEM;
 
 	ret = pci_request_region(dev, 2, "gxfb (display controller)");
 	if (ret < 0)
 		return ret;
-	par->dc_regs = ioremap(pci_resource_start(dev, 2), pci_resource_len(dev, 2));
+	par->dc_regs = pci_ioremap_bar(dev, 2);
 	if (!par->dc_regs)
 		return -ENOMEM;
 
 	ret = pci_request_region(dev, 1, "gxfb (graphics processor)");
 	if (ret < 0)
 		return ret;
-	par->gp_regs = ioremap(pci_resource_start(dev, 1),
-	pci_resource_len(dev, 1));
+	par->gp_regs = pci_ioremap_bar(dev, 1);
 
 	if (!par->gp_regs)
 		return -ENOMEM;
diff --git a/drivers/video/geode/lxfb_core.c b/drivers/video/geode/lxfb_core.c
index 2cd9b74..b965ecd 100644
--- a/drivers/video/geode/lxfb_core.c
+++ b/drivers/video/geode/lxfb_core.c
@@ -379,20 +379,17 @@ static int __init lxfb_map_video_memory(struct fb_info *info,
 	if (info->screen_base == NULL)
 		return ret;
 
-	par->gp_regs = ioremap(pci_resource_start(dev, 1),
-				pci_resource_len(dev, 1));
+	par->gp_regs = pci_ioremap_bar(dev, 1);
 
 	if (par->gp_regs == NULL)
 		return ret;
 
-	par->dc_regs = ioremap(pci_resource_start(dev, 2),
-			       pci_resource_len(dev, 2));
+	par->dc_regs = pci_ioremap_bar(dev, 2);
 
 	if (par->dc_regs == NULL)
 		return ret;
 
-	par->vp_regs = ioremap(pci_resource_start(dev, 3),
-			       pci_resource_len(dev, 3));
+	par->vp_regs = pci_ioremap_bar(dev, 3);
 
 	if (par->vp_regs == NULL)
 		return ret;
diff --git a/drivers/video/gxt4500.c b/drivers/video/gxt4500.c
index 5645577..896e53d 100644
--- a/drivers/video/gxt4500.c
+++ b/drivers/video/gxt4500.c
@@ -648,7 +648,7 @@ static int __devinit gxt4500_probe(struct pci_dev *pdev,
 	info->pseudo_palette = par->pseudo_palette;
 
 	info->fix.mmio_start = reg_phys;
-	par->regs = ioremap(reg_phys, pci_resource_len(pdev, 0));
+	par->regs = pci_ioremap_bar(pdev, 0);
 	if (!par->regs) {
 		dev_err(&pdev->dev, "gxt4500: cannot map registers\n");
 		goto err_free_all;
@@ -656,7 +656,7 @@ static int __devinit gxt4500_probe(struct pci_dev *pdev,
 
 	info->fix.smem_start = fb_phys;
 	info->fix.smem_len = pci_resource_len(pdev, 1);
-	info->screen_base = ioremap(fb_phys, pci_resource_len(pdev, 1));
+	info->screen_base = pci_ioremap_bar(pdev, 1);
 	if (!info->screen_base) {
 		dev_err(&pdev->dev, "gxt4500: cannot map framebuffer\n");
 		goto err_unmap_regs;
-- 
1.5.5.1



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

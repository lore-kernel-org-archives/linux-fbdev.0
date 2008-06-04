From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH] atyfb: Report probe errors
Date: Wed,  4 Jun 2008 12:14:24 +0300
Message-ID: <1212570865-31419-6-git-send-email-syrjala@sci.fi>
References: <1212570865-31419-1-git-send-email-syrjala@sci.fi>
	<1212570865-31419-2-git-send-email-syrjala@sci.fi>
	<1212570865-31419-3-git-send-email-syrjala@sci.fi>
	<1212570865-31419-4-git-send-email-syrjala@sci.fi>
	<1212570865-31419-5-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3p4j-0008Hp-Dh for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 02:14:33 -0700
Received: from smtp5.pp.htv.fi ([213.243.153.39])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K3p4i-00016a-Me
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 02:14:33 -0700
In-Reply-To: <1212570865-31419-5-git-send-email-syrjala@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Ville Syrjala <syrjala@sci.fi>, adaplas@gmail.com

Properly propagate errors to the probe function.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/video/aty/atyfb_base.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 872760a..e38398f 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2231,6 +2231,7 @@ static int __devinit aty_init(struct fb_info *info)
 	const char *ramname = NULL, *xtal;
 	int gtb_memsize, has_var = 0;
 	struct fb_var_screeninfo var;
+	int ret;
 
 	init_waitqueue_head(&par->vblank.wait);
 	spin_lock_init(&par->int_lock);
@@ -2612,7 +2613,8 @@ static int __devinit aty_init(struct fb_info *info)
 			var.yres_virtual = var.yres;
 	}
 
-	if (atyfb_check_var(&var, info)) {
+	ret = atyfb_check_var(&var, info);
+	if (ret) {
 		PRINTKE("can't set default video mode\n");
 		goto aty_init_exit;
 	}
@@ -2623,10 +2625,12 @@ static int __devinit aty_init(struct fb_info *info)
 #endif /* CONFIG_FB_ATY_CT */
 	info->var = var;
 
-	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
+	ret = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (ret < 0)
 		goto aty_init_exit;
 
-	if (register_framebuffer(info) < 0) {
+	ret = register_framebuffer(info);
+	if (ret < 0) {
 		fb_dealloc_cmap(&info->cmap);
 		goto aty_init_exit;
 	}
@@ -2652,7 +2656,7 @@ aty_init_exit:
 	    par->mtrr_aper = -1;
 	}
 #endif
-	return -1;
+	return ret;
 }
 
 static void aty_resume_chip(struct fb_info *info)
@@ -3467,7 +3471,8 @@ static int __devinit atyfb_pci_probe(struct pci_dev *pdev, const struct pci_devi
 	pci_set_drvdata(pdev, info);
 
 	/* Init chip & register framebuffer */
-	if (aty_init(info))
+	rc = aty_init(info);
+	if (rc)
 		goto err_release_io;
 
 #ifdef __sparc__
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php

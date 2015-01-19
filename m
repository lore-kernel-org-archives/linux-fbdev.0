From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 19 Jan 2015 18:41:01 +0000
Subject: [PATCH 6/9] video: One function call less in pvr2fb_common_init() after error detection
Message-Id: <54BD4FBD.3020308@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net> <54BD44F0.3040705@users.sourceforge.net>
In-Reply-To: <54BD44F0.3040705@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 19 Jan 2015 14:50:44 +0100

The iounmap() function could be called in two cases by the pvr2fb_common_init()
function during error handling even if the passed data structure element
contained still a null pointer.

This implementation detail could be improved by adjustments for jump labels.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/pvr2fb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 7aa4ef1..9fb8bbf 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -773,14 +773,14 @@ static int pvr2fb_common_init(void)
 
 	if (!fb_info->screen_base) {
 		printk(KERN_ERR "pvr2fb: Failed to remap smem space\n");
-		goto out_err;
+		return -ENXIO;
 	}
 
 	par->mmio_base = (unsigned long)ioremap_nocache(pvr2_fix.mmio_start,
 							pvr2_fix.mmio_len);
 	if (!par->mmio_base) {
 		printk(KERN_ERR "pvr2fb: Failed to remap mmio space\n");
-		goto out_err;
+		goto io_unmap_screen;
 	}
 
 	fb_memset(fb_info->screen_base, 0, pvr2_fix.smem_len);
@@ -807,7 +807,7 @@ static int pvr2fb_common_init(void)
 	fb_alloc_cmap(&fb_info->cmap, 256, 0);
 
 	if (register_framebuffer(fb_info) < 0)
-		goto out_err;
+		goto io_unmap_mmio;
 	/*Must write PIXDEPTH to register before anything is displayed - so force init */
 	pvr2_init_display(fb_info);
 
@@ -840,10 +840,10 @@ static int pvr2fb_common_init(void)
 
 	return 0;
 
-out_err:
+io_unmap_mmio:
+	iounmap((void *)par->mmio_base);
+io_unmap_screen:
 	iounmap(fb_info->screen_base);
-	if (par->mmio_base)
-		iounmap((void *)par->mmio_base);
 
 	return -ENXIO;
 }
-- 
2.2.2


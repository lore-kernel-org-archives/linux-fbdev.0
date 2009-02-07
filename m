From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 5/15] skeletonfb: check fb_alloc_cmap
 return value and handle failure properly
Date: Sat, 7 Feb 2009 12:13:02 -0500
Message-ID: <20090207121302.55db6a87@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dilinger@queued.net>) id 1LVqjr-0002yg-Pd
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:13:07 +0000
Received: from lunge.mit.edu ([18.54.1.69] helo=lunge.queued.net)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LVqjq-0001F8-32 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:13:07 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com


Bad example code, no cookie!

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/skeletonfb.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
index df53365..a439159 100644
--- a/drivers/video/skeletonfb.c
+++ b/drivers/video/skeletonfb.c
@@ -795,8 +795,9 @@ static int __devinit xxxfb_probe(struct pci_dev *dev,
     if (!retval || retval == 4)
 	return -EINVAL;			
 
-    /* This has to been done !!! */	
-    fb_alloc_cmap(&info->cmap, cmap_len, 0);
+    /* This has to be done! */
+    if (fb_alloc_cmap(&info->cmap, cmap_len, 0))
+	return -ENOMEM;
 	
     /* 
      * The following is done in the case of having hardware with a static 
@@ -820,8 +821,10 @@ static int __devinit xxxfb_probe(struct pci_dev *dev,
      */
     /* xxxfb_set_par(info); */
 
-    if (register_framebuffer(info) < 0)
+    if (register_framebuffer(info) < 0) {
+	fb_dealloc_cmap(&info->cmap);
 	return -EINVAL;
+    }
     printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node,
 	   info->fix.id);
     pci_set_drvdata(dev, info); /* or platform_set_drvdata(pdev, info) */
-- 
1.5.6.5


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com

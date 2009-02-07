From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 15/15] asiliantfb: fix cmap memory leaks
Date: Sat, 7 Feb 2009 12:19:05 -0500
Message-ID: <20090207121905.6d2d9575@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dilinger@queued.net>) id 1LVqph-00023t-Qq
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:19:09 +0000
Received: from lunge.mit.edu ([18.54.1.69] helo=lunge.queued.net)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LVqpg-0003m8-Cq for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:19:09 +0000
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


 - fix cmap leak in removal path
 - fix cmap leak when register_framebuffer fails
 - check return value of fb_alloc_cmap
 - don't continue with driver setup if register_framebuffer fails

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/asiliantfb.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
index 1fd22f4..cb89100 100644
--- a/drivers/video/asiliantfb.c
+++ b/drivers/video/asiliantfb.c
@@ -505,19 +505,26 @@ static struct fb_var_screeninfo asiliantfb_var __devinitdata = {
 	.vsync_len 	= 2,
 };
 
-static void __devinit init_asiliant(struct fb_info *p, unsigned long addr)
+static int __devinit init_asiliant(struct fb_info *p, unsigned long addr)
 {
 	p->fix			= asiliantfb_fix;
 	p->fix.smem_start	= addr;
 	p->var			= asiliantfb_var;
 	p->fbops		= &asiliantfb_ops;
 	p->flags		= FBINFO_DEFAULT;
+	int err;
 
-	fb_alloc_cmap(&p->cmap, 256, 0);
+	err = fb_alloc_cmap(&p->cmap, 256, 0);
+	if (err) {
+		printk(KERN_ERR "C&T 69000 fb failed to alloc cmap memory\n");
+		return err;
+	}
 
-	if (register_framebuffer(p) < 0) {
+	err = register_framebuffer(p);
+	if (err < 0) {
 		printk(KERN_ERR "C&T 69000 framebuffer failed to register\n");
-		return;
+		fb_dealloc_cmap(&p->cmap);
+		return err;
 	}
 
 	printk(KERN_INFO "fb%d: Asiliant 69000 frame buffer (%dK RAM detected)\n",
@@ -532,6 +539,7 @@ asiliantfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 {
 	unsigned long addr, size;
 	struct fb_info *p;
+	int err;
 
 	if ((dp->resource[0].flags & IORESOURCE_MEM) == 0)
 		return -ENODEV;
@@ -560,7 +568,12 @@ asiliantfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 	pci_write_config_dword(dp, 4, 0x02800083);
 	writeb(3, p->screen_base + 0x400784);
 
-	init_asiliant(p, addr);
+	err = init_asiliant(p, addr);
+	if (err) {
+		release_mem_region(addr, size);
+		framebuffer_release(p);
+		return err;
+	}
 
 	pci_set_drvdata(dp, p);
 	return 0;
@@ -571,6 +584,7 @@ static void __devexit asiliantfb_remove(struct pci_dev *dp)
 	struct fb_info *p = pci_get_drvdata(dp);
 
 	unregister_framebuffer(p);
+	fb_dealloc_cmap(&p->cmap);
 	iounmap(p->screen_base);
 	release_mem_region(pci_resource_start(dp, 0), pci_resource_len(dp, 0));
 	pci_set_drvdata(dp, NULL);
-- 
1.5.6.5


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com

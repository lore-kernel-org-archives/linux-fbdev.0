From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc3 1/5] pxafb: module unloading
	support
Date: Fri, 30 May 2008 08:28:46 -0400
Message-ID: <1212150530-14941-2-git-send-email-jayakumar.lkml@gmail.com>
References: <1212150530-14941-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K24cO-0003Dv-Mq for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 06:26:04 -0700
Received: from wf-out-1314.google.com ([209.85.200.175])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K24cO-0002k6-BG
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 06:26:04 -0700
Received: by wf-out-1314.google.com with SMTP id 27so3329168wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 30 May 2008 06:26:04 -0700 (PDT)
In-Reply-To: <1212150530-14941-1-git-send-email-jayakumar.lkml@gmail.com>
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
To: ymiao3@marvell.com
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

This patch to pxafb adds:
 - exit and remove handlers
 - changes to use __devinit/exit for probe functions and __init/exit for
   init/exit functions
 - set g_options to initdata since it is only accessed from pxafb_init
in order to enable module loading/unloading of pxafb.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 drivers/video/pxafb.c |   52 ++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 274bc93..a4bb733 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -1246,7 +1246,7 @@ static int pxafb_resume(struct platform_device *dev)
  *      cache.  Once this area is remapped, all virtual memory
  *      access to the video memory should occur at the new region.
  */
-static int __init pxafb_map_video_memory(struct pxafb_info *fbi)
+static int __devinit pxafb_map_video_memory(struct pxafb_info *fbi)
 {
 	/*
 	 * We reserve one page for the palette, plus the size
@@ -1346,7 +1346,7 @@ decode_mode:
 	pxafb_decode_mode_info(fbi, inf->modes, inf->num_modes);
 }
 
-static struct pxafb_info * __init pxafb_init_fbinfo(struct device *dev)
+static struct pxafb_info * __devinit pxafb_init_fbinfo(struct device *dev)
 {
 	struct pxafb_info *fbi;
 	void *addr;
@@ -1408,7 +1408,7 @@ static struct pxafb_info * __init pxafb_init_fbinfo(struct device *dev)
 }
 
 #ifdef CONFIG_FB_PXA_PARAMETERS
-static int __init parse_opt_mode(struct device *dev, const char *this_opt)
+static int __devinit parse_opt_mode(struct device *dev, const char *this_opt)
 {
 	struct pxafb_mach_info *inf = dev->platform_data;
 
@@ -1467,7 +1467,7 @@ done:
 	return 0;
 }
 
-static int __init parse_opt(struct device *dev, char *this_opt)
+static int __devinit parse_opt(struct device *dev, char *this_opt)
 {
 	struct pxafb_mach_info *inf = dev->platform_data;
 	struct pxafb_mode_info *mode = &inf->modes[0];
@@ -1565,7 +1565,7 @@ static int __init parse_opt(struct device *dev, char *this_opt)
 	return 0;
 }
 
-static int __init pxafb_parse_options(struct device *dev, char *options)
+static int __devinit pxafb_parse_options(struct device *dev, char *options)
 {
 	char *this_opt;
 	int ret;
@@ -1584,10 +1584,10 @@ static int __init pxafb_parse_options(struct device *dev, char *options)
 	return 0;
 }
 
-static char g_options[256] __devinitdata = "";
+static char g_options[256] __initdata = "";
 
 #ifndef CONFIG_MODULES
-static int __devinit pxafb_setup_options(void)
+static int __init pxafb_setup_options(void)
 {
 	char *options = NULL;
 
@@ -1611,7 +1611,7 @@ MODULE_PARM_DESC(options, "LCD parameters (see Documentation/fb/pxafb.txt)");
 #define pxafb_setup_options()		(0)
 #endif
 
-static int __init pxafb_probe(struct platform_device *dev)
+static int __devinit pxafb_probe(struct platform_device *dev)
 {
 	struct pxafb_info *fbi;
 	struct pxafb_mach_info *inf;
@@ -1776,16 +1776,44 @@ failed:
 	return ret;
 }
 
+static int __devexit pxafb_remove(struct platform_device *dev)
+{
+	struct pxafb_info *fbi = platform_get_drvdata(dev);
+	struct resource *r;
+	int irq;
+
+	if (fbi) {
+		struct fb_info *info = &fbi->fb;
+
+		irq = platform_get_irq(dev, 0);
+		free_irq(irq, fbi);
+
+		r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+		release_mem_region(r->start, r->end - r->start + 1);
+
+		iounmap(fbi->mmio_base);
+
+		dma_free_writecombine(&dev->dev, fbi->map_size,
+					fbi->map_cpu, fbi->map_dma);
+		fb_dealloc_cmap(&info->cmap);
+		unregister_framebuffer(info);
+		kfree(fbi);
+	}
+	return 0;
+}
+
 static struct platform_driver pxafb_driver = {
 	.probe		= pxafb_probe,
+	.remove 	= pxafb_remove,
 	.suspend	= pxafb_suspend,
 	.resume		= pxafb_resume,
 	.driver		= {
+		.owner	= THIS_MODULE,
 		.name	= "pxa2xx-fb",
 	},
 };
 
-static int __devinit pxafb_init(void)
+static int __init pxafb_init(void)
 {
 	if (pxafb_setup_options())
 		return -EINVAL;
@@ -1793,7 +1821,13 @@ static int __devinit pxafb_init(void)
 	return platform_driver_register(&pxafb_driver);
 }
 
+static void __exit pxafb_exit(void)
+{
+	platform_driver_unregister(&pxafb_driver);
+}
+
 module_init(pxafb_init);
+module_exit(pxafb_exit);
 
 MODULE_DESCRIPTION("loadable framebuffer driver for PXA");
 MODULE_LICENSE("GPL");
-- 
1.5.3.6


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

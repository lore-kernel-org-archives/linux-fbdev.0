From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 10/15] fbdev: Add __iomem annotations to pm2fb
Date: Fri, 29 Oct 2004 09:58:45 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290958.45897.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM2z-00066c-B9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:21 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM2y-0001Wn-FX
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:21 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id B7C91954DE8
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:59:13 +0000 (UTC)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jim Hague <jim.hague@acm.org>

Add __iomem annotations to pm2fb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 pm2fb.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff -Nru a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
--- a/drivers/video/pm2fb.c	2004-10-27 14:58:08 +08:00
+++ b/drivers/video/pm2fb.c	2004-10-28 23:10:51 +08:00
@@ -97,8 +97,8 @@
 {
 	pm2type_t	type;		/* Board type */
 	u32		fb_size;	/* framebuffer memory size */
-	unsigned char*	v_fb;		/* virtual address of frame buffer */
-	unsigned char*	v_regs;		/* virtual address of p_regs */
+	unsigned char	__iomem *v_fb;  /* virtual address of frame buffer */
+	unsigned char	__iomem *v_regs;/* virtual address of p_regs */
 	u32 	   	memclock;	/* memclock */
 	u32		video;		/* video flags before blanking */
 };
@@ -149,12 +149,12 @@
  * Utility functions
  */
 
-inline static u32 RD32(unsigned char* base, s32 off)
+inline static u32 RD32(unsigned char __iomem *base, s32 off)
 {
 	return fb_readl(base + off);
 }
 
-inline static void WR32(unsigned char* base, s32 off, u32 v)
+inline static void WR32(unsigned char __iomem *base, s32 off, u32 v)
 {
 	fb_writel(v, base + off);
 }
@@ -1154,10 +1154,10 @@
  err_exit_all:
 	fb_dealloc_cmap(&info->cmap);	
  err_exit_both:    
-	iounmap((void*) pm2fb_fix.smem_start);
+	iounmap(info->screen_base);
 	release_mem_region(pm2fb_fix.smem_start, pm2fb_fix.smem_len);
  err_exit_mmio:
-	iounmap((void*) pm2fb_fix.mmio_start);
+	iounmap(default_par->v_regs);
 	release_mem_region(pm2fb_fix.mmio_start, pm2fb_fix.mmio_len);
  err_exit_neither:
 	framebuffer_release(info);
@@ -1175,12 +1175,13 @@
 {
 	struct fb_info* info = pci_get_drvdata(pdev);
 	struct fb_fix_screeninfo* fix = &info->fix;
-    
+	struct pm2fb_par *par = info->par;
+
 	unregister_framebuffer(info);
     
-	iounmap((void*) fix->smem_start);
+	iounmap(info->screen_base);
 	release_mem_region(fix->smem_start, fix->smem_len);
-	iounmap((void*) fix->mmio_start);
+	iounmap(par->v_regs);
 	release_mem_region(fix->mmio_start, fix->mmio_len);
 
 	pci_set_drvdata(pdev, NULL);





-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/

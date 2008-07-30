From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc9 3/5] pxafb: add shared
	framebuffer interface
Date: Wed, 30 Jul 2008 08:51:07 -0400
Message-ID: <1217422269-11093-4-git-send-email-jayakumar.lkml@gmail.com>
References: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOC1r-00011U-7m for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jul 2008 06:47:47 -0700
Received: from yw-out-1718.google.com ([74.125.46.156])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOC1q-0001fS-Fc
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jul 2008 06:47:46 -0700
Received: by yw-out-1718.google.com with SMTP id 6so10226ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 30 Jul 2008 06:47:46 -0700 (PDT)
In-Reply-To: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
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

These changes are to make it possible for a secondary driver to share the
pxafb framebuffer. The changes include:
- adding extra_video_mem entry so that a driver can tell pxafb of its
  additional needs.
- adding share_video_mem/unshare_video_mem callbacks to notify the secondary
  driver of the framebuffer address, to allow refcounting, and to cleanup on
  completion.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 drivers/video/pxafb.c            |   31 ++++++++++++++++++++++++++-----
 include/asm-arm/arch-pxa/pxafb.h |    7 +++++++
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index bb25143..f799c52 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -57,6 +57,8 @@
  */
 #define DEBUG_VAR 1
 
+static struct platform_driver pxafb_driver;
+
 #include "pxafb.h"
 
 /* Bits which should not be set in machine configuration structures */
@@ -870,6 +872,7 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 {
 	u_long flags;
 	size_t nbytes;
+	struct pxafb_mach_info *inf = fbi->dev->platform_data;
 
 #if DEBUG_VAR
 	if (!(fbi->lccr0 & LCCR0_LCDT)) {
@@ -1304,14 +1307,17 @@ static int pxafb_resume(struct platform_device *dev)
  *      cache.  Once this area is remapped, all virtual memory
  *      access to the video memory should occur at the new region.
  */
-static int __devinit pxafb_map_video_memory(struct pxafb_info *fbi)
+static int __devinit pxafb_map_video_memory(struct pxafb_info *fbi,
+						struct pxafb_mach_info *inf)
 {
+	int ret;
 	/*
 	 * We reserve one page for the palette, plus the size
 	 * of the framebuffer.
 	 */
 	fbi->video_offset = PAGE_ALIGN(sizeof(struct pxafb_dma_buff));
-	fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len + fbi->video_offset);
+	fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len + fbi->video_offset +
+					inf->extra_video_mem);
 	fbi->map_cpu = dma_alloc_writecombine(fbi->dev, fbi->map_size,
 					      &fbi->map_dma, GFP_KERNEL);
 
@@ -1340,6 +1346,13 @@ static int __devinit pxafb_map_video_memory(struct pxafb_info *fbi)
 		fbi->smart_cmds = (uint16_t *) fbi->dma_buff->cmd_buff;
 		fbi->n_smart_cmds = 0;
 #endif
+		if (inf->share_video_mem) {
+			ret = inf->share_video_mem(fbi->fb.screen_base,
+				fbi->screen_dma, pxafb_driver.driver.owner,
+				inf->extra_data);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return fbi->map_cpu ? 0 : -ENOMEM;
@@ -1761,10 +1774,12 @@ static int __devinit pxafb_probe(struct platform_device *dev)
 	}
 
 	/* Initialize video memory */
-	ret = pxafb_map_video_memory(fbi);
-	if (ret) {
+	ret = pxafb_map_video_memory(fbi, inf);
+	if (ret == -ENODEV) {
+		dev_err(&dev->dev, "Failed device binding: %d\n", ret);
+		goto failed_free_mem;
+	} else if (ret) {
 		dev_err(&dev->dev, "Failed to allocate video RAM: %d\n", ret);
-		ret = -ENOMEM;
 		goto failed_free_io;
 	}
 
@@ -1836,6 +1851,8 @@ failed_free_cmap:
 failed_free_irq:
 	free_irq(irq, fbi);
 failed_free_mem:
+	if (inf->unshare_video_mem)
+		inf->unshare_video_mem(inf->extra_data);
 	dma_free_writecombine(&dev->dev, fbi->map_size,
 			fbi->map_cpu, fbi->map_dma);
 failed_free_io:
@@ -1856,6 +1873,7 @@ static int __devexit pxafb_remove(struct platform_device *dev)
 	struct resource *r;
 	int irq;
 	struct fb_info *info;
+	struct pxafb_mach_info *inf;
 
 	if (!fbi)
 		return 0;
@@ -1872,6 +1890,9 @@ static int __devexit pxafb_remove(struct platform_device *dev)
 	irq = platform_get_irq(dev, 0);
 	free_irq(irq, fbi);
 
+	inf = dev->dev.platform_data;
+	if (inf->unshare_video_mem)
+		inf->unshare_video_mem(inf->extra_data);
 	dma_free_writecombine(&dev->dev, fbi->map_size,
 					fbi->map_cpu, fbi->map_dma);
 
diff --git a/include/asm-arm/arch-pxa/pxafb.h b/include/asm-arm/arch-pxa/pxafb.h
index daf018d..1ff9281 100644
--- a/include/asm-arm/arch-pxa/pxafb.h
+++ b/include/asm-arm/arch-pxa/pxafb.h
@@ -139,9 +139,16 @@ struct pxafb_mach_info {
 	 * All other bits in LCCR4 should be left alone.
 	 */
 	u_int		lccr4;
+	/* size of extra mem needed for secondary driver */
+	unsigned int	extra_video_mem;
+	void		*extra_data; /* extra data for secondary */
 	void (*pxafb_backlight_power)(int);
 	void (*pxafb_lcd_power)(int, struct fb_var_screeninfo *);
 	void (*smart_update)(struct fb_info *);
+	/* share_video_mem allows client drivers to get our framebuffer */
+	int (*share_video_mem)(char __iomem *, dma_addr_t, struct module *,
+				void *);
+	void (*unshare_video_mem)(void *);
 };
 void set_pxa_fb_info(struct pxafb_mach_info *hard_pxa_fb_info);
 void set_pxa_fb_parent(struct device *parent_dev);
-- 
1.5.3.6


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/3] radeonfb: Fix 64 bits resources on
	32 bits archs
Date: Tue, 22 Apr 2008 11:26:07 +1000
Message-ID: <20080422012723.BA9F2DE13F@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jo7I8-0000tm-Hd for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 18:27:29 -0700
Received: from ozlabs.org ([203.10.76.45])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jo7I7-0002z1-3e
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 18:27:28 -0700
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
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, adaplas@gmail.com

This fixes radeonfb to not truncate 64 bits resources on 32 bits
platforms. Unfortunately, there are still issues with addresses
returned to userspace via struct fb_fix_screeninfo. This will
have to be dealt with separately.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/video/aty/radeon_base.c |    4 ++--
 drivers/video/aty/radeonfb.h    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-work.orig/drivers/video/aty/radeon_base.c	2008-04-22 11:04:19.000000000 +1000
+++ linux-work/drivers/video/aty/radeon_base.c	2008-04-22 11:05:00.000000000 +1000
@@ -1886,7 +1886,7 @@ static int __devinit radeon_set_fbinfo (
 	info->screen_size = rinfo->mapped_vram;
 	/* Fill fix common fields */
 	strlcpy(info->fix.id, rinfo->name, sizeof(info->fix.id));
-        info->fix.smem_start = rinfo->fb_base_phys;
+        info->fix.smem_start = (unsigned long)rinfo->fb_base_phys;
         info->fix.smem_len = rinfo->video_ram;
         info->fix.type = FB_TYPE_PACKED_PIXELS;
         info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
@@ -1894,7 +1894,7 @@ static int __devinit radeon_set_fbinfo (
         info->fix.ypanstep = 1;
         info->fix.ywrapstep = 0;
         info->fix.type_aux = 0;
-        info->fix.mmio_start = rinfo->mmio_base_phys;
+        info->fix.mmio_start = (unsigned long)rinfo->mmio_base_phys;
         info->fix.mmio_len = RADEON_REGSIZE;
 	info->fix.accel = FB_ACCEL_ATI_RADEON;
 
Index: linux-work/drivers/video/aty/radeonfb.h
===================================================================
--- linux-work.orig/drivers/video/aty/radeonfb.h	2008-04-22 11:03:17.000000000 +1000
+++ linux-work/drivers/video/aty/radeonfb.h	2008-04-22 11:03:27.000000000 +1000
@@ -287,8 +287,8 @@ struct radeonfb_info {
 
 	char			name[DEVICE_NAME_SIZE];
 
-	unsigned long		mmio_base_phys;
-	unsigned long		fb_base_phys;
+	resource_size_t		mmio_base_phys;
+	resource_size_t		fb_base_phys;
 
 	void __iomem		*mmio_base;
 	void __iomem		*fb_base;

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/3] aty128fb: Fix 64 bits resources on
	32 bits archs
Date: Tue, 22 Apr 2008 11:26:08 +1000
Message-ID: <20080422012724.C22F5DE1AF@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jo7I8-0000tk-Hc for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 18:27:29 -0700
Received: from ozlabs.org ([203.10.76.45])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jo7I7-00057u-FV
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 18:27:27 -0700
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

This fixes aty128fb to not truncate 64 bits resources on 32 bits
platforms. Unfortunately, there are still issues with addresses
returned to userspace via struct fb_fix_screeninfo. This will
have to be dealt with separately.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/video/aty/aty128fb.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-work.orig/drivers/video/aty/aty128fb.c	2008-04-22 11:18:41.000000000 +1000
+++ linux-work/drivers/video/aty/aty128fb.c	2008-04-22 11:19:31.000000000 +1000
@@ -2011,7 +2011,7 @@ static int __devinit aty128_init(struct 
 /* register a card    ++ajoshi */
 static int __devinit aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	unsigned long fb_addr, reg_addr;
+	resource_size_t fb_addr, reg_addr;
 	struct aty128fb_par *par;
 	struct fb_info *info;
 	int err;
@@ -2052,7 +2052,6 @@ static int __devinit aty128_probe(struct
 	info->pseudo_palette = par->pseudo_palette;
 
 	/* Virtualize mmio region */
-	info->fix.mmio_start = reg_addr;
 	par->regbase = ioremap(reg_addr, pci_resource_len(pdev, 2));
 	if (!par->regbase)
 		goto err_free_info;
@@ -2068,9 +2067,9 @@ static int __devinit aty128_probe(struct
 
 	/* Set up info->fix */
 	info->fix = aty128fb_fix;
-	info->fix.smem_start = fb_addr;
+	info->fix.smem_start = (unsigned long)fb_addr;
 	info->fix.smem_len = par->vram_size;
-	info->fix.mmio_start = reg_addr;
+	info->fix.mmio_start = (unsigned long)reg_addr;
 
 	/* If we can't test scratch registers, something is seriously wrong */
 	if (!register_test(par)) {

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone

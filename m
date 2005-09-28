From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] intelfb: Fix regression (blank display) from ioremap patch
Date: Thu, 29 Sep 2005 05:19:51 +0800
Message-ID: <433B08F7.6060608@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKlYf-0001uL-A1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Sep 2005 16:41:53 -0700
Received: from xproxy.gmail.com ([66.249.82.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EKlYd-0000mh-4M
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Sep 2005 16:41:53 -0700
Received: by xproxy.gmail.com with SMTP id s7so146062wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Sep 2005 16:41:44 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Sylvain Meyer <sylvain.meyer@worldonline.fr>

- Workaround for the ioremap patch that produces a blank display on some
  chipsets
- Make hwcursor = 0 the default.  The hardware cursor does not work with all
  hardware.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 Kconfig              |    1 +
 intelfb/intelfbdrv.c |   21 ++++++++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)


diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -768,6 +768,7 @@ config FB_INTEL
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports the on-board graphics built in to the Intel
           830M/845G/852GM/855GM/865G chipsets.
diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -226,7 +226,7 @@ MODULE_DEVICE_TABLE(pci, intelfb_pci_tab
 
 static int accel        = 1;
 static int vram         = 4;
-static int hwcursor     = 1;
+static int hwcursor     = 0;
 static int mtrr         = 1;
 static int fixed        = 0;
 static int noinit       = 0;
@@ -609,15 +609,9 @@ intelfb_pci_register(struct pci_dev *pde
 		dinfo->accel = 0;
 	}
 
-	if (MB(voffset) < stolen_size)
-		offset = (stolen_size >> 12);
-	else
-		offset = ROUND_UP_TO_PAGE(MB(voffset))/GTT_PAGE_SIZE;
-
 	/* Framebuffer parameters - Use all the stolen memory if >= vram */
-	if (ROUND_UP_TO_PAGE(stolen_size) >= ((offset << 12) +  MB(vram))) {
+	if (ROUND_UP_TO_PAGE(stolen_size) >= MB(vram)) {
 		dinfo->fb.size = ROUND_UP_TO_PAGE(stolen_size);
-		dinfo->fb.offset = 0;
 		dinfo->fbmem_gart = 0;
 	} else {
 		dinfo->fb.size =  MB(vram);
@@ -648,6 +642,11 @@ intelfb_pci_register(struct pci_dev *pde
 		return -ENODEV;
 	}
 
+	if (MB(voffset) < stolen_size)
+		offset = (stolen_size >> 12);
+	else
+		offset = ROUND_UP_TO_PAGE(MB(voffset))/GTT_PAGE_SIZE;
+
 	/* set the mem offsets - set them after the already used pages */
 	if (dinfo->accel) {
 		dinfo->ring.offset = offset + gtt_info.current_memory;
@@ -662,10 +661,11 @@ intelfb_pci_register(struct pci_dev *pde
 			+ (dinfo->cursor.size >> 12);
 	}
 
+	/* Allocate memories (which aren't stolen) */
 	/* Map the fb and MMIO regions */
 	/* ioremap only up to the end of used aperture */
 	dinfo->aperture.virtual = (u8 __iomem *)ioremap_nocache
-		(dinfo->aperture.physical, (dinfo->fb.offset << 12)
+		(dinfo->aperture.physical, ((offset + dinfo->fb.offset) << 12)
 		 + dinfo->fb.size);
 	if (!dinfo->aperture.virtual) {
 		ERR_MSG("Cannot remap FB region.\n");
@@ -682,7 +682,6 @@ intelfb_pci_register(struct pci_dev *pde
 		return -ENODEV;
 	}
 
-	/* Allocate memories (which aren't stolen) */
 	if (dinfo->accel) {
 		if (!(dinfo->gtt_ring_mem =
 		      agp_allocate_memory(bridge, dinfo->ring.size >> 12,
@@ -1484,7 +1483,7 @@ intelfb_cursor(struct fb_info *info, str
 #endif
 
 	if (!dinfo->hwcursor)
-		return -ENXIO;
+		return soft_cursor(info, cursor);
 
 	intelfbhw_cursor_hide(dinfo);
 



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

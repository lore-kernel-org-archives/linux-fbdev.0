From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/8] fbdev: Remove inter_module_get/put from i810fb
Date: Wed, 20 Oct 2004 08:15:26 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410200815.26351.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CK42R-0002D0-Gs
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:09:11 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CK42Q-00055C-F7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:09:11 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 2F0E77655F
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Oct 2004 00:09:00 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

  The function inter_module_get/put is to be deprecated. Remove.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 i810.h      |    1 -
 i810_main.c |   57 ++++++++++++++++++++++++---------------------------------
 2 files changed, 24 insertions(+), 34 deletions(-)

diff -Nru a/drivers/video/i810/i810.h b/drivers/video/i810/i810.h
--- a/drivers/video/i810/i810.h	2004-10-19 20:23:19 +08:00
+++ b/drivers/video/i810/i810.h	2004-10-05 05:48:01 +08:00
@@ -251,7 +251,6 @@
 	struct heap_data         iring;
 	struct heap_data         cursor_heap;
 	struct vgastate          state;
-	drm_agp_t                *drm_agp;
 	atomic_t                 use_count;
 	u32 pseudo_palette[17];
 	unsigned long mmio_start_phys;
diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	2004-10-17 13:37:00 +08:00
+++ b/drivers/video/i810/i810_main.c	2004-10-05 05:47:26 +08:00
@@ -1523,8 +1523,8 @@
 	info->fbops->fb_blank(blank, info);
 
 	if (!prev_state) { 
-		par->drm_agp->unbind_memory(par->i810_gtt.i810_fb_memory);
-		par->drm_agp->unbind_memory(par->i810_gtt.i810_cursor_memory);
+		agp_unbind_memory(par->i810_gtt.i810_fb_memory);
+		agp_unbind_memory(par->i810_gtt.i810_cursor_memory);
 		pci_disable_device(dev);
 	}
 	pci_save_state(dev);
@@ -1544,10 +1544,10 @@
 	pci_restore_state(dev);
 	pci_set_power_state(dev, 0);
 	pci_enable_device(dev);
-	par->drm_agp->bind_memory(par->i810_gtt.i810_fb_memory, 
-				  par->fb.offset);
-	par->drm_agp->bind_memory(par->i810_gtt.i810_cursor_memory, 
-				  par->cursor_heap.offset);
+	agp_bind_memory(par->i810_gtt.i810_fb_memory,
+			par->fb.offset);
+	agp_bind_memory(par->i810_gtt.i810_cursor_memory,
+			par->cursor_heap.offset);
 
 	info->fbops->fb_blank(VESA_NO_BLANKING, info);
 
@@ -1599,39 +1599,36 @@
 	i810_fix_offsets(par);
 	size = par->fb.size + par->iring.size;
 
-	par->drm_agp = (drm_agp_t *) inter_module_get("drm_agp");
-	if (!par->drm_agp) {
-		printk("i810fb: cannot acquire agp\n");
+	if (agp_backend_acquire()) {
+		printk("i810fb_alloc_fbmem: cannot acquire agpgart\n");
 		return -ENODEV;
 	}
-	par->drm_agp->acquire(); 
-
 	if (!(par->i810_gtt.i810_fb_memory = 
-	      par->drm_agp->allocate_memory(size >> 12, AGP_NORMAL_MEMORY))) {
+	      agp_allocate_memory(size >> 12, AGP_NORMAL_MEMORY))) {
 		printk("i810fb_alloc_fbmem: can't allocate framebuffer "
 		       "memory\n");
-		par->drm_agp->release();
+		agp_backend_release();
 		return -ENOMEM;
 	}
-	if (par->drm_agp->bind_memory(par->i810_gtt.i810_fb_memory, 
-				      par->fb.offset)) {
+	if (agp_bind_memory(par->i810_gtt.i810_fb_memory,
+			    par->fb.offset)) {
 		printk("i810fb_alloc_fbmem: can't bind framebuffer memory\n");
-		par->drm_agp->release();
+		agp_backend_release();
 		return -EBUSY;
 	}	
 	
 	if (!(par->i810_gtt.i810_cursor_memory = 
-	      par->drm_agp->allocate_memory(par->cursor_heap.size >> 12, 
-					    AGP_PHYSICAL_MEMORY))) {
+	      agp_allocate_memory(par->cursor_heap.size >> 12,
+				  AGP_PHYSICAL_MEMORY))) {
 		printk("i810fb_alloc_cursormem:  can't allocate" 
 		       "cursor memory\n");
-		par->drm_agp->release();
+		agp_backend_release();
 		return -ENOMEM;
 	}
-	if (par->drm_agp->bind_memory(par->i810_gtt.i810_cursor_memory, 
+	if (agp_bind_memory(par->i810_gtt.i810_cursor_memory,
 			    par->cursor_heap.offset)) {
 		printk("i810fb_alloc_cursormem: cannot bind cursor memory\n");
-		par->drm_agp->release();
+		agp_backend_release();
 		return -EBUSY;
 	}	
 
@@ -1639,7 +1636,7 @@
 
 	i810_fix_pointers(par);
 
-	par->drm_agp->release();
+	agp_backend_release();
 
 	return 0;
 }
@@ -1945,19 +1942,13 @@
 static void i810fb_release_resource(struct fb_info *info, 
 				    struct i810fb_par *par)
 {
+	struct gtt_data *gtt = &par->i810_gtt;
 	unset_mtrr(par);
-	if (par->drm_agp) {
-		drm_agp_t *agp = par->drm_agp;
-		struct gtt_data *gtt = &par->i810_gtt;
-
-		if (par->i810_gtt.i810_cursor_memory)
-			agp->free_memory(gtt->i810_cursor_memory);
-		if (par->i810_gtt.i810_fb_memory)
-			agp->free_memory(gtt->i810_fb_memory);
 
-		inter_module_put("drm_agp");
-		par->drm_agp = NULL;
-	}
+	if (par->i810_gtt.i810_cursor_memory)
+		agp_free_memory(gtt->i810_cursor_memory);
+	if (par->i810_gtt.i810_fb_memory)
+		agp_free_memory(gtt->i810_fb_memory);
 
 	if (par->mmio_start_virtual)
 		iounmap(par->mmio_start_virtual);




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

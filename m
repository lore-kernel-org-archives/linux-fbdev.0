From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] radeonfb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:47:49 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915204749.GF23294@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z0GW-0000pZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:48:08 -0700
Received: from mail-7.tiscali.it ([195.130.225.153])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z0GV-00014R-Ld
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:48:07 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/radeonfb.c to framebuffer_alloc:

======== drivers/video/radeonfb.c 1.33 ========
D 1.33 03/09/15 18:21:29+02:00 kronos@kronoz.cjb.net 34 33 38/33/3142
P drivers/video/radeonfb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/radeonfb.c 1.32 vs 1.33 =====
--- 1.32/drivers/video/radeonfb.c	Fri Sep  5 00:20:13 2003
+++ 1.33/drivers/video/radeonfb.c	Mon Sep 15 18:21:29 2003
@@ -345,7 +345,7 @@
 
 
 struct radeonfb_info {
-	struct fb_info info;
+	struct fb_info *info;
 
 	struct radeon_regs state;
 	struct radeon_regs init_state;
@@ -730,6 +730,7 @@
 
 #endif /* CONFIG_PPC_OF */
 
+static void release_radeonfb(struct fb_info *info);
 
 static char *radeon_find_rom(struct radeonfb_info *rinfo)
 {       
@@ -1286,7 +1287,7 @@
 
 static int __devinit radeon_init_disp (struct radeonfb_info *rinfo)
 {
-        struct fb_info *info = &rinfo->info;
+        struct fb_info *info = rinfo->info;
 	struct fb_var_screeninfo var;
 
         var = radeonfb_default_var;
@@ -1309,7 +1310,7 @@
 {
 #ifndef MODULE
         if (mode_option)
-                fb_find_mode (var, &rinfo->info, mode_option,
+                fb_find_mode (var, rinfo->info, mode_option,
                               NULL, 0, NULL, 8);
         else
 #endif
@@ -1318,7 +1319,7 @@
 		*var = radeonfb_default_var;
 	else
 
-                fb_find_mode (var, &rinfo->info, "640x480-8@60",
+                fb_find_mode (var, rinfo->info, "640x480-8@60",
                               NULL, 0, NULL, 0);
 
 	if (noaccel)
@@ -1502,7 +1503,7 @@
 static int radeonfb_pan_display (struct fb_var_screeninfo *var,
                                  struct fb_info *info)
 {
-        struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
+        struct radeonfb_info *rinfo = info->par;
 
         if ((var->xoffset + var->xres > var->xres_virtual)
 	    || (var->yoffset + var->yres > var->yres_virtual))
@@ -1520,7 +1521,7 @@
 static int radeonfb_ioctl (struct inode *inode, struct file *file, unsigned int cmd,
                            unsigned long arg, struct fb_info *info)
 {
-        struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
+        struct radeonfb_info *rinfo = info->par;
 	unsigned int tmp;
 	u32 value = 0;
 	int rc;
@@ -1608,7 +1609,7 @@
 
 static int radeonfb_blank (int blank, struct fb_info *info)
 {
-        struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
+        struct radeonfb_info *rinfo = info->par;
         u32 val = INREG(CRTC_EXT_CNTL);
 	u32 val2 = INREG(LVDS_GEN_CNTL);
 
@@ -1660,7 +1661,7 @@
 static int radeonfb_setcolreg (unsigned regno, unsigned red, unsigned green,
                              unsigned blue, unsigned transp, struct fb_info *info)
 {
-        struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
+        struct radeonfb_info *rinfo = info->par;
 	u32 pindex, vclk_cntl;
 	unsigned int i;
 	
@@ -2232,13 +2233,14 @@
 {
 	struct fb_info *info;
 
-	info = &rinfo->info;
+	info = rinfo->info;
 
 	info->par = rinfo;
 	info->pseudo_palette = rinfo->pseudo_palette;
         info->flags = FBINFO_FLAG_DEFAULT;
         info->fbops = &radeonfb_ops;
         info->screen_base = (char *)rinfo->fb_base;
+	info->release = &release_radeonfb;
 
 	/* Fill fix common fields */
 	strlcpy(info->fix.id, rinfo->name, sizeof(info->fix.id));
@@ -2792,6 +2794,7 @@
 				  const struct pci_device_id *ent)
 {
 	struct radeonfb_info *rinfo;
+	struct fb_info *fb_info;
 	struct radeon_chip_info *rci = &radeon_chip_info[ent->driver_data];
 	u32 tmp;
 
@@ -2803,14 +2806,14 @@
 		return -ENODEV;
 	}
 
-	rinfo = kmalloc (sizeof (struct radeonfb_info), GFP_KERNEL);
-	if (!rinfo) {
+	fb_info = framebuffer_alloc(sizeof(struct radeonfb_info),  &pdev->dev);
+	if (!fb_info) {
 		printk ("radeonfb: could not allocate memory\n");
 		return -ENODEV;
 	}
 
-	memset (rinfo, 0, sizeof (struct radeonfb_info));
-	//info = &rinfo->info;
+	rinfo = fb_info->par;
+	rinfo->info = fb_info;
 	rinfo->pdev = pdev;
 	strcpy(rinfo->name, rci->name);
 	rinfo->arch = rci->arch;
@@ -2823,7 +2826,7 @@
 	if (!request_mem_region (rinfo->fb_base_phys,
 				 pci_resource_len(pdev, 0), "radeonfb")) {
 		printk ("radeonfb: cannot reserve FB region\n");
-		kfree (rinfo);
+		kfree (fb_info);
 		return -ENODEV;
 	}
 
@@ -2832,7 +2835,7 @@
 		printk ("radeonfb: cannot reserve MMIO region\n");
 		release_mem_region (rinfo->fb_base_phys,
 				    pci_resource_len(pdev, 0));
-		kfree (rinfo);
+		kfree (fb_info);
 		return -ENODEV;
 	}
 
@@ -2844,7 +2847,7 @@
 				    pci_resource_len(pdev, 2));
 		release_mem_region (rinfo->fb_base_phys,
 				    pci_resource_len(pdev, 0));
-		kfree (rinfo);
+		kfree (fb_info);
 		return -ENODEV;
 	}
 
@@ -2969,7 +2972,7 @@
 					    pci_resource_len(pdev, 2));
 			release_mem_region (rinfo->fb_base_phys,
 					    pci_resource_len(pdev, 0));
-			kfree (rinfo);
+			kfree (fb_info);
 			return -ENODEV;
 		}
 	}
@@ -2982,7 +2985,7 @@
 				    pci_resource_len(pdev, 2));
 		release_mem_region (rinfo->fb_base_phys,
 				    pci_resource_len(pdev, 0));
-		kfree (rinfo);
+		kfree (fb_info);
 		return -ENODEV;
 	}
 
@@ -3031,9 +3034,8 @@
 	pci_set_drvdata(pdev, rinfo);
 	rinfo->next = board_list;
 	board_list = rinfo;
-	rinfo->info.dev = &pdev->dev;
 
-	if (register_framebuffer ((struct fb_info *) rinfo) < 0) {
+	if (register_framebuffer (rinfo->info) < 0) {
 		printk ("radeonfb: could not register framebuffer\n");
 		iounmap ((void*)rinfo->fb_base);
 		iounmap ((void*)rinfo->mmio_base);
@@ -3041,7 +3043,7 @@
 				    pci_resource_len(pdev, 2));
 		release_mem_region (rinfo->fb_base_phys,
 				    pci_resource_len(pdev, 0));
-		kfree (rinfo);
+		kfree (fb_info);
 		return -ENODEV;
 	}
 
@@ -3082,15 +3084,10 @@
 	return 0;
 }
 
+static void release_radeonfb(struct fb_info *info) {
+	struct radeonfb_info *rinfo = info->par;
+	struct pci_dev *pdev = rinfo->pdev;
 
-
-static void __devexit radeonfb_pci_unregister (struct pci_dev *pdev)
-{
-        struct radeonfb_info *rinfo = pci_get_drvdata(pdev);
- 
-        if (!rinfo)
-                return;
- 
 	/* restore original state
 	 * 
 	 * Doesn't quite work yet, possibly because of the PPC hacking
@@ -3103,8 +3100,6 @@
 		mtrr_del(rinfo->mtrr_hdl, 0, 0);
 #endif
 
-        unregister_framebuffer ((struct fb_info *) rinfo);
-                
         iounmap ((void*)rinfo->mmio_base);
         iounmap ((void*)rinfo->fb_base);
  
@@ -3112,8 +3107,18 @@
 			    pci_resource_len(pdev, 2));
 	release_mem_region (rinfo->fb_base_phys,
 			    pci_resource_len(pdev, 0));
-        
-        kfree (rinfo);
+}
+
+static void __devexit radeonfb_pci_unregister (struct pci_dev *pdev)
+{
+        struct radeonfb_info *rinfo = pci_get_drvdata(pdev);
+ 
+        if (!rinfo)
+                return;
+ 
+        unregister_framebuffer (rinfo->info);
+
+	pci_set_drvdata(pdev, NULL);
 }
 
 


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
La differenza fra l'intelligenza e la stupidita`?
All'intelligenza c'e` un limite.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

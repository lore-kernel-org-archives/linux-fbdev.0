From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] i810fb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:15:23 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915201523.GQ16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzlZ-0006nv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:16:09 -0700
Received: from mail-6.tiscali.it ([195.130.225.152])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzlY-00055J-KA
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:16:08 -0700
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/i810fb.c to framebuffer_alloc:

======== drivers/video/i810/i810_main.c 1.16 ========
D 1.16 03/09/15 18:57:46+02:00 kronos@kronoz.cjb.net 20 18 0/0/2058
P drivers/video/i810/i810_main.c
C Auto merged
------------------------------------------------

===== drivers/video/i810/i810_main.c 1.15 vs 1.16 =====
--- 1.15/drivers/video/i810/i810_main.c	Thu Sep 11 23:04:58 2003
+++ 1.16/drivers/video/i810/i810_main.c	Mon Sep 15 18:57:46 2003
@@ -1838,23 +1838,15 @@
 	struct i810fb_par *par = NULL;
 	int err, vfreq, hfreq, pixclock;
 
-	if (!(info = kmalloc(sizeof(struct fb_info), GFP_KERNEL))) {
-		i810fb_release_resource(info, par);
+	info = framebuffer_alloc(sizeof(struct i810fb_par), &dev->dev);
+	if (!info)
 		return -ENOMEM;
-	}
-	memset(info, 0, sizeof(struct fb_info));
-
-	if(!(par = kmalloc(sizeof(struct i810fb_par), GFP_KERNEL))) {
-		i810fb_release_resource(info, par);
-		return -ENOMEM;
-	}
-	memset(par, 0, sizeof(struct i810fb_par));
-
+	par = info->par;
 	par->dev = dev;
-	info->par = par;
-
+	info->release = &i810fb_release_resource;
+	
 	if (!(info->pixmap.addr = kmalloc(64*1024, GFP_KERNEL))) {
-		i810fb_release_resource(info, par);
+		i810fb_release_resource(info);
 		return -ENOMEM;
 	}
 	memset(info->pixmap.addr, 0, 64*1024);
@@ -1863,14 +1855,16 @@
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
 	if ((err = i810_allocate_pci_resource(par, entry))) {
-		i810fb_release_resource(info, par);
+		i810fb_release_resource(info);
+		kfree(info);
 		return err;
 	}
 
 	i810_init_defaults(par, info);
 
 	if ((err = i810_alloc_agp_mem(info))) {
-		i810fb_release_resource(info, par);
+		i810fb_release_resource(info);
+		kfree(info);
 		return err;
 	}
 
@@ -1880,12 +1874,12 @@
 	info->fbops = &par->i810fb_ops;
 	info->pseudo_palette = par->pseudo_palette;
 	info->flags = FBINFO_FLAG_DEFAULT;
-	info->dev = &dev->dev;
 	
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
 	if ((err = info->fbops->fb_check_var(&info->var, info))) {
-		i810fb_release_resource(info, par);
+		i810fb_release_resource(info);
+		kfree(info);
 		return err;
 	}
 	encode_fix(&info->fix, info); 
@@ -1893,8 +1887,9 @@
 	i810fb_init_ringbuffer(info);
 	err = register_framebuffer(info);
 	if (err < 0) {
-    		i810fb_release_resource(info, par); 
+    		i810fb_release_resource(info); 
 		printk("i810fb_init: cannot register framebuffer device\n");
+		kfree(info);
     		return err;  
     	}   
 
@@ -1924,10 +1919,13 @@
  *                     De-initialization                        *
  ***************************************************************/
 
-static void i810fb_release_resource(struct fb_info *info, 
-				    struct i810fb_par *par)
+static void i810fb_release_resource(struct fb_info *info) 
 {
-	if (par) {
+	if (!info)
+		return;
+	
+	if (info->par) {
+		struct i810fb_par *par = info->par;
 		unset_mtrr(par);
 		if (par->drm_agp) {
 			drm_agp_t *agp = par->drm_agp;
@@ -1956,19 +1954,16 @@
 		if (par->res_flags & PCI_DEVICE_ENABLED)
 			pci_disable_device(par->dev); 
 
-		kfree(par);
+		if (info->pixmap.addr)
+			kfree(info->pixmap.addr);
 	}
-	if (info) 
-		kfree(info);
 }
 
 static void __exit i810fb_remove_pci(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
-	struct i810fb_par *par = (struct i810fb_par *) info->par;
 
 	unregister_framebuffer(info);  
-	i810fb_release_resource(info, par);
 	pci_set_drvdata(dev, NULL);
 	printk("cleanup_module:  unloaded i810 framebuffer device\n");
 }                                                	


======== drivers/video/i810/i810_main.h 1.11 ========
D 1.11 03/09/15 18:57:46+02:00 kronos@kronoz.cjb.net 14 12 0/0/127
P drivers/video/i810/i810_main.h
C Auto merged
------------------------------------------------

===== drivers/video/i810/i810_main.h 1.10 vs 1.11 =====
--- 1.10/drivers/video/i810/i810_main.h	Fri Sep 12 00:46:11 2003
+++ 1.11/drivers/video/i810/i810_main.h	Mon Sep 15 18:57:46 2003
@@ -59,7 +59,7 @@
 static int i810fb_blank      (int blank_mode, struct fb_info *info);
 
 /* Initialization */
-static void i810fb_release_resource       (struct fb_info *info, struct i810fb_par *par);
+static void i810fb_release_resource       (struct fb_info *info);
 extern int __init agp_intel_init(void);
 
 

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
You and me baby ain't nothin' but mammals
So let's do it like they do on the Discovery Channel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

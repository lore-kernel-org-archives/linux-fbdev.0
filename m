From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: New radeonfb, mostly untested
Date: Tue, 9 Sep 2003 21:24:30 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030909192430.GA10981@dreamland.darkstar.lan>
References: <1062960554.647.34.camel@gaston> <Pine.LNX.4.44.0309090054470.23354-100000@phoenix.infradead.org> <20030909175404.GA8039@dreamland.darkstar.lan> <1063131198.642.5.camel@gaston>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wo7r-0004D0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 12:26:07 -0700
Received: from mail-3.tiscali.it ([195.130.225.149])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wo7q-0000YH-AQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 12:26:06 -0700
Content-Disposition: inline
In-Reply-To: <1063131198.642.5.camel@gaston>
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
Cc: James Simmons <jsimmons@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Tue, Sep 09, 2003 at 08:13:19PM +0200, Benjamin Herrenschmidt ha scritto: 
> > Ok, but the class_dev stuff isn't a bug fix, it's an API change...
> > If you really want it I can start sending patches against your bk tree.
> 
> If it's easy enough to fix existing drivers, we can cope with it,

Most of work consists in changing "." into "->" ;)
Changes to fbmem.c are very similar to Greg KH's patch:

===== drivers/video/fbmem.c 1.80 vs edited =====
--- 1.80/drivers/video/fbmem.c	Mon Sep  1 18:28:09 2003
+++ edited/drivers/video/fbmem.c	Sat Sep  6 17:44:25 2003
@@ -1199,6 +1199,42 @@
 #endif
 };
 
+#define to_fb_info(d) container_of(d, struct fb_info, class_dev)
+static void release_fb_info(struct class_device *class_dev) {
+	struct fb_info *info = to_fb_info(class_dev);
+
+	if (info->release)
+		info->release(info);
+	
+	kfree(info);
+}
+
+static struct class fb_class = {
+	.name		= "video",
+	.release	= &release_fb_info,
+};
+
+static ssize_t show_dev(struct class_device *class_dev, char *buf) {
+	struct fb_info *info = to_fb_info(class_dev);
+	return sprintf(buf, "%u:%u\n", FB_MAJOR, info->node);
+}
+
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
+
+static void fb_add_class_device(struct fb_info *info) {
+	info->class_dev.class = &fb_class;
+	snprintf(info->class_dev.class_id, BUS_ID_SIZE, "fb%d", info->node);
+	
+	if (class_device_register(&info->class_dev))
+		return;
+	
+	class_device_create_file(&info->class_dev, &class_device_attr_dev);
+}
+
+void fb_remove_class_device(struct fb_info *info) {
+	class_device_unregister(&info->class_dev);
+}
+
 /**
  *	register_framebuffer - registers a frame buffer device
  *	@fb_info: frame buffer info structure
@@ -1242,6 +1278,7 @@
 
 	devfs_mk_cdev(MKDEV(FB_MAJOR, i),
 			S_IFCHR | S_IRUGO | S_IWUGO, "fb/%d", i);
+	fb_add_class_device(fb_info);
 	return 0;
 }
 
@@ -1270,6 +1307,7 @@
 		kfree(fb_info->pixmap.addr);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
+	fb_remove_class_device(fb_info);
 	return 0;
 }
 
@@ -1293,6 +1331,8 @@
 	devfs_mk_dir("fb");
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
+
+	class_register(&fb_class);
 
 #ifdef CONFIG_FB_OF
 	if (ofonly) {
===== include/linux/fb.h 1.53 vs edited =====
--- 1.53/include/linux/fb.h	Thu Apr 24 12:30:41 2003
+++ edited/include/linux/fb.h	Tue Sep  9 20:49:12 2003
@@ -3,6 +3,7 @@
 
 #include <linux/tty.h>
 #include <linux/workqueue.h>
+#include <linux/device.h>
 #include <asm/types.h>
 #include <asm/io.h>
 
@@ -412,6 +413,8 @@
    struct vc_data *display_fg;		/* Console visible on this display */
    int currcon;				/* Current VC. */	
    void *pseudo_palette;                /* Fake palette of 16 colors */ 
+   struct class_device class_dev;
+   void (*release)(struct fb_info *);	/* Do driver specific clean up */
    /* From here on everything is device dependent */
    void *par;	
 };


And this is radeonfb (the one from mesa3d):

===== drivers/video/radeonfb.c 1.44 vs edited =====
--- 1.44/drivers/video/radeonfb.c	Fri Sep  5 17:51:41 2003
+++ edited/drivers/video/radeonfb.c	Tue Sep  9 21:06:46 2003
@@ -30,6 +30,7 @@
  *	Other changes (Luca Tettamanti <kronos@kronoz.cjb.net>):
  *	
  *	2003-08-20	support for DDC2b via I2C
+ *	2003-09-06	switch to dynamically allocated fb_info
  *
  *	Special thanks to ATI DevRel team for their hardware donations.
  *
@@ -344,7 +345,7 @@
 
 
 struct radeonfb_info {
-	struct fb_info info;
+	struct fb_info *info;
 
 	struct radeon_regs state;
 	struct radeon_regs init_state;
@@ -994,6 +995,7 @@
 
 #endif /* CONFIG_PPC_OF */
 
+static void release_radeonfb_info(struct fb_info *info);
 
 #if defined(__i386__)
 static void * __init radeon_map_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
@@ -1661,7 +1663,7 @@
 
 static int __devinit radeon_init_disp (struct radeonfb_info *rinfo)
 {
-        struct fb_info *info = &rinfo->info;
+        struct fb_info *info = rinfo->info;
 	struct fb_var_screeninfo var;
 
         var = radeonfb_default_var;
@@ -1684,7 +1686,7 @@
 {
 #ifndef MODULE
         if (mode_option)
-                fb_find_mode (var, &rinfo->info, mode_option,
+                fb_find_mode (var, rinfo->info, mode_option,
                               rinfo->modedb, rinfo->dbsize, NULL, 8);
         else
 #endif
@@ -1693,7 +1695,7 @@
 		*var = radeonfb_default_var;
 	else
 
-                fb_find_mode (var, &rinfo->info, "640x480-8@60",
+                fb_find_mode (var, rinfo->info, "640x480-8@60",
                               NULL, 0, NULL, 0);
 
 	if (noaccel)
@@ -1769,7 +1771,7 @@
 
 static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *info)
 {
-        struct radeonfb_info *rinfo = (struct radeonfb_info *) info->par;
+        struct radeonfb_info *rinfo = info->par;
         struct fb_var_screeninfo v;
         int nom, den;
 
@@ -1877,7 +1879,7 @@
 static int radeonfb_pan_display (struct fb_var_screeninfo *var,
                                  struct fb_info *info)
 {
-        struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
+        struct radeonfb_info *rinfo = info->par;
 
         if ((var->xoffset + var->xres > var->xres_virtual)
 	    || (var->yoffset + var->yres > var->yres_virtual))
@@ -1895,7 +1897,7 @@
 static int radeonfb_ioctl (struct inode *inode, struct file *file, unsigned int cmd,
                            unsigned long arg, struct fb_info *info)
 {
-        struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
+        struct radeonfb_info *rinfo = info->par;
 	unsigned int tmp;
 	u32 value = 0;
 	int rc;
@@ -1983,7 +1985,7 @@
 
 static int radeonfb_blank (int blank, struct fb_info *info)
 {
-        struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
+        struct radeonfb_info *rinfo = info->par;
         u32 val = INREG(CRTC_EXT_CNTL);
 	u32 val2 = INREG(LVDS_GEN_CNTL);
 
@@ -2035,7 +2037,7 @@
 static int radeonfb_setcolreg (unsigned regno, unsigned red, unsigned green,
                              unsigned blue, unsigned transp, struct fb_info *info)
 {
-        struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
+        struct radeonfb_info *rinfo = info->par;
 	u32 pindex, vclk_cntl;
 	unsigned int i;
 	
@@ -2607,8 +2609,15 @@
 {
 	struct fb_info *info;
 
-	info = &rinfo->info;
+	rinfo->info = kmalloc(sizeof(struct fb_info), GFP_KERNEL);
+	if (!rinfo->info)
+		return -ENOMEM;
+	memset(rinfo->info, 0, sizeof(struct fb_info));
+
+	info = rinfo->info;
 
+	info->class_dev.dev = &rinfo->pdev->dev;
+	info->release = &release_radeonfb_info;
 	info->currcon = -1;
 	info->par = rinfo;
 	info->pseudo_palette = rinfo->pseudo_palette;
@@ -3429,13 +3438,14 @@
 	}
 
 	/* set all the vital stuff */
-	radeon_set_fbinfo (rinfo);
+	if (radeon_set_fbinfo (rinfo))
+		goto unmap_rom;
 
 	pci_set_drvdata(pdev, rinfo);
 	rinfo->next = board_list;
 	board_list = rinfo;
 
-	if (register_framebuffer ((struct fb_info *) rinfo) < 0) {
+	if (register_framebuffer (rinfo->info) < 0) {
 		printk (KERN_ERR "radeonfb: could not register framebuffer\n");
 		goto unmap_fb;
 	}
@@ -3481,6 +3491,7 @@
 unmap_rom:	
 	if (rinfo->EDID)
 	    kfree(rinfo->EDID);
+	kfree(rinfo->info);
 	fb_destroy_modedb(rinfo->modedb);
 	radeonfb_i2c_bus_del();
 	radeon_unmap_ROM(pdev, rinfo->bios_seg);
@@ -3496,15 +3507,10 @@
 	return -ENODEV;
 }
 
+static void release_radeonfb_info(struct fb_info *info) {
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
@@ -3516,9 +3522,6 @@
 	if (rinfo->mtrr_hdl >= 0)
 		mtrr_del(rinfo->mtrr_hdl, 0, 0);
 #endif
-
-        unregister_framebuffer ((struct fb_info *) rinfo);
-                
         iounmap ((void*)rinfo->mmio_base);
         iounmap ((void*)rinfo->fb_base);
  
@@ -3533,7 +3536,19 @@
 
 	fb_destroy_modedb(rinfo->modedb);
         
-        kfree (rinfo);
+        kfree(rinfo);
+}
+
+static void __devexit radeonfb_pci_unregister (struct pci_dev *pdev)
+{
+        struct radeonfb_info *rinfo = pci_get_drvdata(pdev);
+ 
+        if (!rinfo)
+                return;
+
+	sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid_attr);
+			
+        unregister_framebuffer (rinfo->info);
 }
 

sysfs attributes can  then be attacched to class_dev, they  will show up
under /sys/class/video/fbX/.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Recursion n.:
	See Recursion.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

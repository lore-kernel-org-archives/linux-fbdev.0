From: James Simmons <jsimmons@www.infradead.org>
Subject: VGA16 fbdev updates.
Date: Fri, 21 Jan 2005 22:22:43 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0501212212210.31273@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cs7B5-0006Yh-CP
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Jan 2005 14:22:51 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Cs7B3-0001dL-QK
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Jan 2005 14:22:51 -0800
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Here are the updates to the VGA16 framebuffer driver. The new driver now 
uses the framebuffer_alloc[release] functions. The driver also works with 
the new logo drawing code from the other patch I sent in earlier. The 
final fix is that it can alomst work with non 8 bit wide fonts. Its 
readale now but not perfect.

--- linus-2.6/drivers/video/vga16fb.c	2005-01-21 10:23:51.000000000 -0800
+++ fbdev-2.6/drivers/video/vga16fb.c	2005-01-20 11:07:14.000000000 -0800
@@ -51,9 +51,7 @@
  * card parameters
  */
 
-static struct fb_info vga16fb; 
-
-static struct vga16fb_par {
+struct vga16fb_par {
 	/* structure holding original VGA register settings when the
            screen is blanked */
 	struct {
@@ -75,7 +73,7 @@
 	int palette_blanked, vesa_blanked, mode, isVGA;
 	u8 misc, pel_msk, vss, clkdiv;
 	u8 crtc[VGA_CRT_C];
-} vga16_par;
+};
 
 /* --------------------------------------------------------------------- */
 
@@ -853,7 +851,7 @@
 	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
 
 	switch (blank) {
-	case FB_BLANK_UNBLANK:				/* Unblank */
+	case FB_BLANK_UNBLANK:			/* Unblank */
 		if (par->vesa_blanked) {
 			vga_vesa_unblank(par);
 			par->vesa_blanked = 0;
@@ -862,7 +860,7 @@
 			par->palette_blanked = 0;
 		}
 		break;
-	case FB_BLANK_NORMAL:				/* blank */
+	case FB_BLANK_NORMAL:			/* blank */
 		vga_pal_blank();
 		par->palette_blanked = 1;
 		break;
@@ -881,8 +879,8 @@
         char oldmode = setmode(0x40);
         char oldmask = selectmask();
         int line_ofs, height;
-        char oldop, oldsr;
         char __iomem *where;
+        char oldop, oldsr;
 
         dx /= 4;
         where = info->screen_base + dx + rect->dy * info->fix.line_length;
@@ -1005,14 +1003,13 @@
 
 void vga_8planes_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
+	char __iomem *dest, *src;
         char oldindex = getindex();
         char oldmode = setmode(0x41);
         char oldop = setop(0);
         char oldsr = setsr(0xf);
         int height, line_ofs, x;
 	u32 sx, dx, width;
-	char __iomem *dest;
-	char __iomem *src;
 
         height = area->height;
 
@@ -1061,10 +1058,9 @@
 void vga16fb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
 	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy; 
+	char __iomem *dst = NULL, __iomem *src = NULL;
 	int x, x2, y2, old_dx, old_dy, vxres, vyres;
 	int height, width, line_ofs;
-	char __iomem *dst = NULL;
-	char __iomem *src = NULL;
 
 	vxres = info->var.xres_virtual;
 	vyres = info->var.yres_virtual;
@@ -1174,8 +1170,8 @@
         char oldsr = setsr(0);
         char oldmask = selectmask();
         const char *cdat = image->data;
+	char __iomem *where;
 	u32 dx = image->dx;
-        char __iomem *where;
         int y;
 
         dx /= 4;
@@ -1199,12 +1195,11 @@
 
 void vga_imageblit_expand(struct fb_info *info, const struct fb_image *image)
 {
-	char __iomem *where = info->screen_base + (image->dx/8) +
-		image->dy * info->fix.line_length;
+	char __iomem *where = info->screen_base + ((image->dx + 7) >> 3) + image->dy * info->fix.line_length;
 	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
+	int width = (image->width + 7) >> 3, x, y;
 	char *cdat = (char *) image->data;
 	char __iomem *dst;
-	int x, y;
 
 	switch (info->fix.type) {
 	case FB_TYPE_VGA_PLANES:
@@ -1224,7 +1219,7 @@
 				wmb();
 				for (y = 0; y < image->height; y++) {
 					dst = where;
-					for (x = image->width/8; x--;) 
+					for (x = width; x--;)
 						writeb(*cdat++, dst++);
 					where += info->fix.line_length;
 				}
@@ -1239,7 +1234,7 @@
 				setmask(0xff);
 				for (y = 0; y < image->height; y++) {
 					dst = where;
-					for (x=image->width/8; x--;){
+					for (x = width; x--;){
 						rmw(dst);
 						setcolor(image->fg_color);
 						selectmask();
@@ -1266,18 +1261,15 @@
 	/*
 	 * Draw logo 
 	 */
+	char __iomem *where = info->screen_base + image->dy * info->fix.line_length + (image->dx >> 3);
 	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
-	char __iomem *where =
-		info->screen_base + image->dy * info->fix.line_length +
-		image->dx/8;
 	const char *cdat = image->data;
 	char __iomem *dst;
 	int x, y;
 
 	switch (info->fix.type) {
 	case FB_TYPE_VGA_PLANES:
-		if (info->fix.type_aux == FB_AUX_VGA_PLANES_VGA4 &&
-		    par->isVGA) {
+		if (info->fix.type_aux == FB_AUX_VGA_PLANES_VGA4 && par->isVGA) {
 			setsr(0xf);
 			setop(0);
 			setmode(0);
@@ -1329,7 +1321,7 @@
 	.fb_cursor      = soft_cursor,
 };
 
-int vga16fb_setup(char *options)
+int __init vga16fb_setup(char *options)
 {
 	char *this_opt;
 	
@@ -1342,97 +1334,150 @@
 	return 0;
 }
 
-int __init vga16fb_init(void)
+static int __init vga16fb_probe(struct device *device)
 {
-	int i;
-	int ret;
-#ifndef MODULE
-	char *option = NULL;
-
-	if (fb_get_options("vga16fb", &option))
-		return -ENODEV;
-
-	vga16fb_setup(option);
-#endif
+	struct platform_device *dev = to_platform_device(device);
+	struct vga16fb_par *par;
+	struct fb_info *info;
+	int ret, i;
+	
 	printk(KERN_DEBUG "vga16fb: initializing\n");
-
+	
+	info = framebuffer_alloc(sizeof(struct vga16fb_par), &dev->dev);
+	if (!info)
+		return -ENOMEM;
+	
 	/* XXX share VGA_FB_PHYS and I/O region with vgacon and others */
-
-	vga16fb.screen_base = (void __iomem *)VGA_MAP_MEM(VGA_FB_PHYS);
-	if (!vga16fb.screen_base) {
+	info->screen_base = (void __iomem *)VGA_MAP_MEM(VGA_FB_PHYS);
+	if (!info->screen_base) {
 		printk(KERN_ERR "vga16fb: unable to map device\n");
 		ret = -ENOMEM;
 		goto err_ioremap;
 	}
-	printk(KERN_INFO "vga16fb: mapped to 0x%p\n", vga16fb.screen_base);
-
-	vga16_par.isVGA = ORIG_VIDEO_ISVGA;
-	vga16_par.palette_blanked = 0;
-	vga16_par.vesa_blanked = 0;
+	printk(KERN_INFO "vga16fb: mapped to 0x%p\n", info->screen_base);
+	
+	par = info->par;
+	
+	par->isVGA = ORIG_VIDEO_ISVGA;
+	par->palette_blanked = 0;
+	par->vesa_blanked = 0;
 
-	i = vga16_par.isVGA? 6 : 2;
+	i = par->isVGA? 6 : 2;
 	
 	vga16fb_defined.red.length   = i;
 	vga16fb_defined.green.length = i;
 	vga16fb_defined.blue.length  = i;	
 
 	/* name should not depend on EGA/VGA */
-	vga16fb.fbops = &vga16fb_ops;
-	vga16fb.var = vga16fb_defined;
-	vga16fb.fix = vga16fb_fix;
-	vga16fb.par = &vga16_par;
-	vga16fb.flags = FBINFO_FLAG_DEFAULT |
+	info->fbops = &vga16fb_ops;
+	info->var = vga16fb_defined;
+	info->fix = vga16fb_fix;
+	info->flags = FBINFO_FLAG_DEFAULT |
 		FBINFO_HWACCEL_YPAN;
-
+	
 	i = (vga16fb_defined.bits_per_pixel == 8) ? 256 : 16;
-	ret = fb_alloc_cmap(&vga16fb.cmap, i, 0);
+	ret = fb_alloc_cmap(&info->cmap, i, 0);
 	if (ret) {
 		printk(KERN_ERR "vga16fb: unable to allocate colormap\n");
 		ret = -ENOMEM;
 		goto err_alloc_cmap;
 	}
 
-	if (vga16fb_check_var(&vga16fb.var, &vga16fb)) {
+	if (vga16fb_check_var(&info->var, info)) {
 		printk(KERN_ERR "vga16fb: unable to validate variable\n");
 		ret = -EINVAL;
 		goto err_check_var;
 	}
 
-	vga16fb_update_fix(&vga16fb);
+	vga16fb_update_fix(info);
 
-	if (register_framebuffer(&vga16fb) < 0) {
+	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "vga16fb: unable to register framebuffer\n");
 		ret = -EINVAL;
 		goto err_check_var;
 	}
 
+	dev_set_drvdata(&dev->dev, info);
+	
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
-	       vga16fb.node, vga16fb.fix.id);
-
+	       info->node, info->fix.id);
 	return 0;
 
  err_check_var:
-	fb_dealloc_cmap(&vga16fb.cmap);
+	fb_dealloc_cmap(&info->cmap);
  err_alloc_cmap:
-	iounmap(vga16fb.screen_base);
+	//iounmap(info->screen_base);
  err_ioremap:
+	framebuffer_release(info);
 	return ret;
 }
 
-static void __exit vga16fb_exit(void)
+static int __devexit vga16fb_remove(struct device *device)
 {
-    unregister_framebuffer(&vga16fb);
-    iounmap(vga16fb.screen_base);
-    fb_dealloc_cmap(&vga16fb.cmap);
-    /* XXX unshare VGA regions */
+	struct fb_info *info = dev_get_drvdata(device);
+
+	if (info) {
+		unregister_framebuffer(info);
+		iounmap(info->screen_base);
+		fb_dealloc_cmap(&info->cmap);
+		framebuffer_release(info);
+	}	
+	/* XXX unshare VGA regions */
+	return 0;
 }
 
-#ifdef MODULE
+static void vga16fb_platform_release(struct device *device)
+{
+}	
+
+static struct platform_device vga16fb_device = {
+	.name	= "vga16fb",
+	.id	= 0,
+	.dev	= {
+		.release = vga16fb_platform_release,
+	}
+};	
+
+static struct device_driver vga16fb_driver = {
+	.name	= "vga16fb",
+	.bus	= &platform_bus_type,
+	.probe	= vga16fb_probe,
+	.remove	= __devexit_p(vga16fb_remove),
+};
+
+int __init vga16fb_init(void)
+{
+	int ret;
+#ifndef MODULE
+	char *option = NULL;
+
+	if (fb_get_options("vga16fb", &option))
+		return -ENODEV;
+	vga16fb_setup(option);
+#endif	
+	ret = driver_register(&vga16fb_driver);
+
+	if (!ret) {
+		ret = platform_device_register(&vga16fb_device);
+		if (ret)
+			driver_unregister(&vga16fb_driver);
+	}
+	return ret;
+}
+
+void __exit vga16fb_exit(void)
+{
+	driver_unregister(&vga16fb_driver);
+	platform_device_unregister(&vga16fb_device);
+}	
+
 MODULE_LICENSE("GPL");
-#endif
+MODULE_DESCRIPTION("Standard VGA graphics framebuffer driver");
+
 module_init(vga16fb_init);
+#ifdef MODULE
 module_exit(vga16fb_exit);
-
+#endif
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl

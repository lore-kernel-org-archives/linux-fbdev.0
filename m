From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/7] vga16fb: Convert vga16fb as a platform device
Date: Mon, 07 Nov 2005 19:15:57 +0800
Message-ID: <436F376D.5000208@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZ5BX-0004Uk-Cr
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:29:11 -0800
Received: from xproxy.gmail.com ([66.249.82.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZ5BW-0006Hq-ML
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:29:11 -0800
Received: by xproxy.gmail.com with SMTP id i28so364656wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Nov 2005 03:29:10 -0800 (PST)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- Convert vga16fb as a platform device
- use framebuffer_alloc() to dynamically allocate resources, and
framebuffer_release() to free
- remove unneeded casts
- trivial whitespace changes

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 vga16fb.c |  169 ++++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 110 insertions(+), 59 deletions(-)


diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 690bb6f..226ae8a 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -21,6 +21,7 @@
 #include <linux/fb.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/platform_device.h>
 
 #include <asm/io.h>
 #include <video/vga.h>
@@ -51,35 +52,33 @@
  * card parameters
  */
 
-static struct fb_info vga16fb; 
-
-static struct vga16fb_par {
+struct vga16fb_par {
 	/* structure holding original VGA register settings when the
            screen is blanked */
 	struct {
-		unsigned char	SeqCtrlIndex;		/* Sequencer Index reg.   */
-		unsigned char	CrtCtrlIndex;		/* CRT-Contr. Index reg.  */
-		unsigned char	CrtMiscIO;		/* Miscellaneous register */
-		unsigned char	HorizontalTotal;	/* CRT-Controller:00h */
-		unsigned char	HorizDisplayEnd;	/* CRT-Controller:01h */
-		unsigned char	StartHorizRetrace;	/* CRT-Controller:04h */
-		unsigned char	EndHorizRetrace;	/* CRT-Controller:05h */
-		unsigned char	Overflow;		/* CRT-Controller:07h */
-		unsigned char	StartVertRetrace;	/* CRT-Controller:10h */
-		unsigned char	EndVertRetrace;		/* CRT-Controller:11h */
-		unsigned char	ModeControl;		/* CRT-Controller:17h */
-		unsigned char	ClockingMode;		/* Seq-Controller:01h */
+		unsigned char	SeqCtrlIndex;	  /* Sequencer Index reg.   */
+		unsigned char	CrtCtrlIndex;	  /* CRT-Contr. Index reg.  */
+		unsigned char	CrtMiscIO;	  /* Miscellaneous register */
+		unsigned char	HorizontalTotal;  /* CRT-Controller:00h */
+		unsigned char	HorizDisplayEnd;  /* CRT-Controller:01h */
+		unsigned char	StartHorizRetrace;/* CRT-Controller:04h */
+		unsigned char	EndHorizRetrace;  /* CRT-Controller:05h */
+		unsigned char	Overflow;	  /* CRT-Controller:07h */
+		unsigned char	StartVertRetrace; /* CRT-Controller:10h */
+		unsigned char	EndVertRetrace;	  /* CRT-Controller:11h */
+		unsigned char	ModeControl;	  /* CRT-Controller:17h */
+		unsigned char	ClockingMode;	  /* Seq-Controller:01h */
 	} vga_state;
 	struct vgastate state;
 	atomic_t ref_count;
 	int palette_blanked, vesa_blanked, mode, isVGA;
 	u8 misc, pel_msk, vss, clkdiv;
 	u8 crtc[VGA_CRT_C];
-} vga16_par;
+};
 
 /* --------------------------------------------------------------------- */
 
-static struct fb_var_screeninfo vga16fb_defined = {
+static struct fb_var_screeninfo vga16fb_defined __initdata = {
 	.xres		= 640,
 	.yres		= 480,
 	.xres_virtual	= 640,
@@ -205,7 +204,7 @@ static inline void setindex(int index)
 static void vga16fb_pan_var(struct fb_info *info, 
 			    struct fb_var_screeninfo *var)
 {
-	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
+	struct vga16fb_par *par = info->par;
 	u32 xoffset, pos;
 
 	xoffset = var->xoffset;
@@ -300,7 +299,7 @@ static void vga16fb_clock_chip(struct vg
 
 static int vga16fb_open(struct fb_info *info, int user)
 {
-	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
+	struct vga16fb_par *par = info->par;
 	int cnt = atomic_read(&par->ref_count);
 
 	if (!cnt) {
@@ -315,7 +314,7 @@ static int vga16fb_open(struct fb_info *
 
 static int vga16fb_release(struct fb_info *info, int user)
 {
-	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
+	struct vga16fb_par *par = info->par;
 	int cnt = atomic_read(&par->ref_count);
 
 	if (!cnt)
@@ -330,7 +329,7 @@ static int vga16fb_release(struct fb_inf
 static int vga16fb_check_var(struct fb_var_screeninfo *var,
 			     struct fb_info *info)
 {
-	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
+	struct vga16fb_par *par = info->par;
 	u32 xres, right, hslen, left, xtotal;
 	u32 yres, lower, vslen, upper, ytotal;
 	u32 vxres, xoffset, vyres, yoffset;
@@ -535,7 +534,7 @@ static int vga16fb_check_var(struct fb_v
 
 static int vga16fb_set_par(struct fb_info *info)
 {
-	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
+	struct vga16fb_par *par = info->par;
 	u8 gdc[VGA_GFX_C];
 	u8 seq[VGA_SEQ_C];
 	u8 atc[VGA_ATT_C];
@@ -677,7 +676,7 @@ static int vga16fb_setcolreg(unsigned re
 			     unsigned blue, unsigned transp,
 			     struct fb_info *info)
 {
-	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
+	struct vga16fb_par *par = info->par;
 	int gray;
 
 	/*
@@ -850,7 +849,7 @@ static void vga_pal_blank(void)
 /* 0 unblank, 1 blank, 2 no vsync, 3 no hsync, 4 off */
 static int vga16fb_blank(int blank, struct fb_info *info)
 {
-	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
+	struct vga16fb_par *par = info->par;
 
 	switch (blank) {
 	case FB_BLANK_UNBLANK:				/* Unblank */
@@ -1201,7 +1200,7 @@ static void vga_imageblit_expand(struct 
 {
 	char __iomem *where = info->screen_base + (image->dx/8) +
 		image->dy * info->fix.line_length;
-	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
+	struct vga16fb_par *par = info->par;
 	char *cdat = (char *) image->data;
 	char __iomem *dst;
 	int x, y;
@@ -1266,7 +1265,7 @@ static void vga_imageblit_color(struct f
 	/*
 	 * Draw logo 
 	 */
-	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
+	struct vga16fb_par *par = info->par;
 	char __iomem *where =
 		info->screen_base + image->dy * info->fix.line_length +
 		image->dx/8;
@@ -1343,89 +1342,141 @@ static int vga16fb_setup(char *options)
 }
 #endif
 
-static int __init vga16fb_init(void)
+static int __init vga16fb_probe(struct device *device)
 {
+	struct platform_device *dev = to_platform_device(device);
+	struct fb_info *info;
+	struct vga16fb_par *par;
 	int i;
-	int ret;
-#ifndef MODULE
-	char *option = NULL;
+	int ret = 0;
 
-	if (fb_get_options("vga16fb", &option))
-		return -ENODEV;
-
-	vga16fb_setup(option);
-#endif
 	printk(KERN_DEBUG "vga16fb: initializing\n");
+	info = framebuffer_alloc(sizeof(struct vga16fb_par), &dev->dev);
+
+	if (!info) {
+		ret = -ENOMEM;
+		goto err_fb_alloc;
+	}
 
 	/* XXX share VGA_FB_PHYS and I/O region with vgacon and others */
+	info->screen_base = (void __iomem *)VGA_MAP_MEM(VGA_FB_PHYS);
 
-	vga16fb.screen_base = (void __iomem *)VGA_MAP_MEM(VGA_FB_PHYS);
-	if (!vga16fb.screen_base) {
+	if (!info->screen_base) {
 		printk(KERN_ERR "vga16fb: unable to map device\n");
 		ret = -ENOMEM;
 		goto err_ioremap;
 	}
-	printk(KERN_INFO "vga16fb: mapped to 0x%p\n", vga16fb.screen_base);
 
-	vga16_par.isVGA = ORIG_VIDEO_ISVGA;
-	vga16_par.palette_blanked = 0;
-	vga16_par.vesa_blanked = 0;
+	printk(KERN_INFO "vga16fb: mapped to 0x%p\n", info->screen_base);
+	par = info->par;
 
-	i = vga16_par.isVGA? 6 : 2;
+	par->isVGA = ORIG_VIDEO_ISVGA;
+	par->palette_blanked = 0;
+	par->vesa_blanked = 0;
+
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
 
-	i = (vga16fb_defined.bits_per_pixel == 8) ? 256 : 16;
-	ret = fb_alloc_cmap(&vga16fb.cmap, i, 0);
+	i = (info->var.bits_per_pixel == 8) ? 256 : 16;
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
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
-	       vga16fb.node, vga16fb.fix.id);
+	       info->node, info->fix.id);
+	dev_set_drvdata(device, info);
 
 	return 0;
 
  err_check_var:
-	fb_dealloc_cmap(&vga16fb.cmap);
+	fb_dealloc_cmap(&info->cmap);
  err_alloc_cmap:
-	iounmap(vga16fb.screen_base);
+	iounmap(info->screen_base);
  err_ioremap:
+	framebuffer_release(info);
+ err_fb_alloc:
+	return ret;
+}
+
+static int vga16fb_remove(struct device *device)
+{
+	struct fb_info *info = dev_get_drvdata(device);
+
+	if (info) {
+		unregister_framebuffer(info);
+		iounmap(info->screen_base);
+		fb_dealloc_cmap(&info->cmap);
+	/* XXX unshare VGA regions */
+		framebuffer_release(info);
+	}
+
+	return 0;
+}
+
+static struct device_driver vga16fb_driver = {
+	.name = "vga16fb",
+	.bus  = &platform_bus_type,
+	.probe = vga16fb_probe,
+	.remove = vga16fb_remove,
+};
+
+static struct platform_device vga16fb_device = {
+	.name = "vga16fb",
+};
+
+static int __init vga16fb_init(void)
+{
+	int ret;
+#ifndef MODULE
+	char *option = NULL;
+
+	if (fb_get_options("vga16fb", &option))
+		return -ENODEV;
+
+	vga16fb_setup(option);
+#endif
+	ret = driver_register(&vga16fb_driver);
+
+	if (!ret) {
+		ret = platform_device_register(&vga16fb_device);
+		if (ret)
+			driver_unregister(&vga16fb_driver);
+	}
+
 	return ret;
 }
 
 static void __exit vga16fb_exit(void)
 {
-    unregister_framebuffer(&vga16fb);
-    iounmap(vga16fb.screen_base);
-    fb_dealloc_cmap(&vga16fb.cmap);
-    /* XXX unshare VGA regions */
+	platform_device_unregister(&vga16fb_device);
+	driver_unregister(&vga16fb_driver);
 }
 
 MODULE_LICENSE("GPL");



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

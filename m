From: James Simmons <jsimmons@infradead.org>
Subject: Re: Q40 fbdev updates.
Date: Fri, 7 May 2004 18:32:37 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405071828320.32488-100000@phoenix.infradead.org>
References: <20040505205133.GA23557@linux-m68k.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BM9DF-0000jw-BL
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 May 2004 10:32:41 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BM9DE-0004qh-CB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 May 2004 10:32:41 -0700
In-Reply-To: <20040505205133.GA23557@linux-m68k.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, rz@linux-m68k.org

On Wed, 5 May 2004, Richard Zidlicky wrote:

> Thanks guys, works perfectly, especially the odd colormap
> problem is now gone :)

Andrew please apply this patch. It ports this driver to sysfs api and 
fixes a colormap issue.

--- linus-2.6/drivers/video/q40fb.c	2004-05-06 17:02:06.000000000 -0700
+++ fbdev-2.6/drivers/video/q40fb.c	2004-05-07 09:52:22.000000000 -0700
@@ -1,9 +1,9 @@
-/* 
+/*
  * linux/drivers/video/q40fb.c -- Q40 frame buffer device
  *
- * Copyright (C) 2001 
+ * Copyright (C) 2001
  *
- *      Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>
+ *      Richard Zidlicky <rz@linux-m68k.org>
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for
@@ -30,9 +30,6 @@
 
 #define Q40_PHYS_SCREEN_ADDR 0xFE800000
 
-static u32 pseudo_palette[17];
-static struct fb_info fb_info;
-
 static struct fb_fix_screeninfo q40fb_fix __initdata = {
 	.id		= "Q40",
 	.smem_len	= 1024*1024,
@@ -48,7 +45,7 @@
 	.xres_virtual	= 1024,
 	.yres_virtual	= 512,
 	.bits_per_pixel	= 16,
-    	.red		= {6, 5, 0}, 
+    	.red		= {6, 5, 0},
 	.green		= {11, 5, 0},
 	.blue		= {0, 6, 0},
 	.activate	= FB_ACTIVATE_NOW,
@@ -57,24 +54,8 @@
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-/* frame buffer operations */
-int q40fb_init(void);
-
-static int q40fb_setcolreg(unsigned regno, unsigned red, unsigned green,
-                           unsigned blue, unsigned transp,
-                           struct fb_info *info);
-
-static struct fb_ops q40fb_ops = {
-	.owner		= THIS_MODULE,
-	.fb_setcolreg	= q40fb_setcolreg,
-	.fb_fillrect	= cfb_fillrect,
-	.fb_copyarea	= cfb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
-};
-
 static int q40fb_setcolreg(unsigned regno, unsigned red, unsigned green,
-		  	   unsigned blue, unsigned transp,
+			   unsigned blue, unsigned transp,
 			   struct fb_info *info)
 {
     /*
@@ -82,46 +63,94 @@
      *  magnitude.
      *  Return != 0 for invalid regno.
      */
-  
+
+    if (regno > 255)
+	    return 1;
     red>>=11;
     green>>=11;
     blue>>=10;
 
     if (regno < 16) {
-	((u16 *)info->pseudo_palette)[regno] = ((red & 31) <<6) |
+	((u32 *)info->pseudo_palette)[regno] = ((red & 31) <<6) |
 					       ((green & 31) << 11) |
 					       (blue & 63);
     }
     return 0;
 }
 
-int q40fb_init(void)
+static struct fb_ops q40fb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_setcolreg	= q40fb_setcolreg,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+	.fb_cursor	= soft_cursor,
+};
+
+static int __init q40fb_probe(struct device *device)
 {
-        if ( !MACH_IS_Q40)
-	  return -ENXIO;
+	struct platform_device *dev = to_platform_device(device);
+	struct fb_info *info;
+	
+	if (!MACH_IS_Q40)
+		return -ENXIO;
 
 	/* mapped in q40/config.c */
 	q40fb_fix.smem_start = Q40_PHYS_SCREEN_ADDR;
-	
-	fb_info.var = q40fb_var;
-	fb_info.fix = q40fb_fix;
-	fb_info.fbops = &q40fb_ops;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;  /* not as module for now */
-	fb_info.pseudo_palette = pseudo_palette;	
-   	fb_info.screen_base = (char *) q40fb_fix.smem_start;
 
-	fb_alloc_cmap(&fb_info.cmap, 16, 0);
+	info = framebuffer_alloc(sizeof(u32) * 256, &dev->dev);
+	if (!info)
+		return -ENOMEM;
+
+	info->var = q40fb_var;
+	info->fix = q40fb_fix;
+	info->fbops = &q40fb_ops;
+	info->flags = FBINFO_FLAG_DEFAULT;  /* not as module for now */
+	info->pseudo_palette = info->par;
+	info->par = NULL;
+	info->screen_base = (char *) q40fb_fix.smem_start;
+
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
+		framebuffer_release(info);
+		return -ENOMEM;
+	}
 
 	master_outb(3, DISPLAY_CONTROL_REG);
 
-	if (register_framebuffer(&fb_info) < 0) {
+	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "Unable to register Q40 frame buffer\n");
+		fb_dealloc_cmap(&info->cmap);
+		framebuffer_release(info);
 		return -EINVAL;
 	}
 
         printk(KERN_INFO "fb%d: Q40 frame buffer alive and kicking !\n",
-	       fb_info.node);
+	       info->node);
 	return 0;
 }
 
-MODULE_LICENSE("GPL");	
+static struct device_driver q40fb_driver = {
+	.name	= "q40fb",
+	.bus	= &platform_bus_type,
+	.probe	= q40fb_probe,
+};
+
+static struct platform_device q40fb_device = {
+	.name	= "q40fb",
+};
+
+int __init q40fb_init(void)
+{
+	int ret = 0;
+
+	ret = driver_register(&q40fb_driver);
+
+	if (!ret) {
+		ret = platform_device_register(&q40fb_device);
+		if (ret)
+			driver_unregister(&q40fb_driver);
+	}
+	return ret;
+}
+
+MODULE_LICENSE("GPL");



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3

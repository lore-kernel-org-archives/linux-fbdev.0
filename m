From: James Simmons <jsimmons@infradead.org>
Subject: Vesa Fbdev update.
Date: Sun, 25 Apr 2004 03:32:02 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404250329200.15965-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BHZR9-0006UP-DO
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 24 Apr 2004 19:32:07 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BHZR8-0000zb-Gm
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 24 Apr 2004 19:32:07 -0700
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


This patch migrates the Vesa Framebuffer driver over to the 
framebuffer_alloc/framebuffer_release api. It also fixes the error
handling paths. The mtrr issue that Geert brought up has been fixed. 
With your approval Geert, Ben please apply this patch.

--- linus-2.6/drivers/video/vesafb.c	2004-04-23 15:01:43.000000000 -0700
+++ fbdev-2.6/drivers/video/vesafb.c	2004-04-24 17:00:59.000000000 -0700
@@ -47,12 +47,9 @@
 	.accel	= FB_ACCEL_NONE,
 };
 
-static struct fb_info fb_info;
-static u32 pseudo_palette[17];
-
 static int             inverse   = 0;
 static int             mtrr      = 1;
-
+static int	       vram __initdata = 0; /* Set amount of memory to be used */
 static int             pmi_setpal = 0;	/* pmi for palette changes ??? */
 static int             ypan       = 0;  /* 0..nothing, 1..ypan, 2..ywrap */
 static unsigned short  *pmi_base  = 0;
@@ -210,15 +207,18 @@
 			mtrr=1;
 		else if (! strcmp(this_opt, "nomtrr"))
 			mtrr=0;
+		else if (! strcmp(this_opt, "vram"))
+			vram = simple_strtoul(this_opt+5, NULL, 0);
 	}
 	return 0;
 }
 
-int __init vesafb_init(void)
+static int __init vesafb_probe(struct device *device)
 {
-	int video_cmap_len;
-	int i;
-
+	struct platform_device *dev = to_platform_device(device);
+	struct fb_info *info;
+	int i, err;
+	
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_VLFB)
 		return -ENXIO;
 
@@ -229,7 +229,18 @@
 	vesafb_defined.xres = screen_info.lfb_width;
 	vesafb_defined.yres = screen_info.lfb_height;
 	vesafb_fix.line_length = screen_info.lfb_linelength;
-	vesafb_fix.smem_len = screen_info.lfb_size * 65536;
+	
+	/* Allocate enough memory for double buffering */
+	vesafb_fix.smem_len = screen_info.lfb_width * screen_info.lfb_height * vesafb_defined.bits_per_pixel >> 2; 
+
+	/* check that we don't remap more memory than old cards have */
+	if (vesafb_fix.smem_len > (screen_info.lfb_size * 65536))
+		vesafb_fix.smem_len = screen_info.lfb_size * 65536;
+
+	/* Set video size according to vram boot option */
+	if (vram && vram * 1024 * 1024 != vesafb_fix.smem_len)
+		vesafb_fix.smem_len = vram * 1024 * 1024;
+	
 	vesafb_fix.visual   = (vesafb_defined.bits_per_pixel == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 
@@ -251,17 +262,25 @@
 		   spaces our resource handlers simply don't know about */
 	}
 
-        fb_info.screen_base = ioremap(vesafb_fix.smem_start, vesafb_fix.smem_len);
-	if (!fb_info.screen_base) {
+	info = framebuffer_alloc(sizeof(u32) * 256, &dev->dev);
+	if (!info) {
 		release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
+		return -ENOMEM;
+	}
+	info->pseudo_palette = info->par;
+	info->par = NULL;
+	
+        info->screen_base = ioremap(vesafb_fix.smem_start, vesafb_fix.smem_len);
+	if (!info->screen_base) {
 		printk(KERN_ERR
 		       "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
 			vesafb_fix.smem_len, vesafb_fix.smem_start);
-		return -EIO;
+		err = -EIO;
+		goto err;
 	}
 
 	printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, size %dk\n",
-	       vesafb_fix.smem_start, fb_info.screen_base, vesafb_fix.smem_len/1024);
+	       vesafb_fix.smem_start, info->screen_base, vesafb_fix.smem_len/1024);
 	printk(KERN_INFO "vesafb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
 	       vesafb_defined.xres, vesafb_defined.yres, vesafb_defined.bits_per_pixel, vesafb_fix.line_length, screen_info.pages);
 
@@ -331,12 +350,10 @@
 		       screen_info.red_pos,
 		       screen_info.green_pos,
 		       screen_info.blue_pos);
-		video_cmap_len = 16;
 	} else {
 		vesafb_defined.red.length   = 6;
 		vesafb_defined.green.length = 6;
 		vesafb_defined.blue.length  = 6;
-		video_cmap_len = 256;
 	}
 
 	vesafb_fix.ypanstep  = ypan     ? 1 : 0;
@@ -358,22 +375,53 @@
 		}
 	}
 	
-	fb_info.fbops = &vesafb_ops;
-	fb_info.var = vesafb_defined;
-	fb_info.fix = vesafb_fix;
-	fb_info.pseudo_palette = pseudo_palette;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
-
-	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
-
-	if (register_framebuffer(&fb_info)<0)
-		return -EINVAL;
-
+	info->fbops = &vesafb_ops;
+	info->var = vesafb_defined;
+	info->fix = vesafb_fix;
+	info->flags = FBINFO_FLAG_DEFAULT;
+
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
+		err = -ENXIO;
+		goto err;
+	}	
+	if (register_framebuffer(info)<0) {
+		err = -EINVAL;
+		fb_dealloc_cmap(&info->cmap);
+		goto err;
+	}
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
-	       fb_info.node, fb_info.fix.id);
+	       info->node, info->fix.id);
 	return 0;
+err:
+	framebuffer_release(info);
+	release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
+	return err;
 }
 
+static struct device_driver vesafb_driver = {
+	.name	= "vesafb",
+	.bus	= &platform_bus_type,
+	.probe	= vesafb_probe,
+};
+
+static struct platform_device vesafb_device = {
+	.name	= "vesafb",
+};
+
+int __init vesafb_init(void)
+{
+	int ret;
+
+	ret = driver_register(&vesafb_driver);
+
+	if (!ret) {
+		ret = platform_device_register(&vesafb_device);
+		if (ret)
+			driver_unregister(&vesafb_driver);
+	}
+	return ret;
+}
+	
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * ---------------------------------------------------------------------------



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297

From: James Simmons <jsimmons@infradead.org>
Subject: Q40 fbdev updates.
Date: Sat, 24 Apr 2004 00:01:50 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404240000270.5826-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BH9gA-00067J-29
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 16:01:54 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BH9g9-0005iv-5U
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 16:01:53 -0700
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Richard.Zidlicky@stud.informatik.uni-erlangen.de


Could you examine and test my code for the Q40 fbdev driver. Thanks.


diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/q40fb.c fbdev-2.6/drivers/video/q40fb.c
--- linus-2.6/drivers/video/q40fb.c	2004-04-23 15:01:42.000000000 -0700
+++ fbdev-2.6/drivers/video/q40fb.c	2004-04-23 10:52:56.000000000 -0700
@@ -30,9 +30,6 @@
 
 #define Q40_PHYS_SCREEN_ADDR 0xFE800000
 
-static u32 pseudo_palette[17];
-static struct fb_info fb_info;
-
 static struct fb_fix_screeninfo q40fb_fix __initdata = {
 	.id		= "Q40",
 	.smem_len	= 1024*1024,
@@ -57,22 +54,6 @@
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
 		  	   unsigned blue, unsigned transp,
 			   struct fb_info *info)
@@ -82,46 +63,91 @@
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
         if ( !MACH_IS_Q40)
 	  return -ENXIO;
 
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
+   	info->screen_base = (char *) q40fb_fix.smem_start;
+
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) 
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
 MODULE_LICENSE("GPL");	



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297

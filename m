From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Q40 fbdev updates.
Date: Sun, 25 Apr 2004 13:23:38 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404251320190.11039@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404240000270.5826-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BHhqI-0004LZ-3y
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Apr 2004 04:30:38 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BHhja-0007iz-0p
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Apr 2004 04:23:42 -0700
In-Reply-To: <Pine.LNX.4.44.0404240000270.5826-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Richard.Zidlicky@stud.informatik.uni-erlangen.de

On Sat, 24 Apr 2004, James Simmons wrote:
> Could you examine and test my code for the Q40 fbdev driver. Thanks.

I gave it a run through my cross-compiler...

A few fixes for q40fb_probe():
  - Add missing variable `info'
  - Add missing variable 'dev' and its initialization
  - Add missing opening curly brace

I also removed all c_space_errors according to vim.

--- linux-m68k-2.6.6-rc2/drivers/video/q40fb.c.orig	2004-04-25 12:23:15.000000000 +0200
+++ linux-m68k-2.6.6-rc2/drivers/video/q40fb.c	2004-04-25 13:17:52.000000000 +0200
@@ -1,7 +1,7 @@
-/*
+/*
  * linux/drivers/video/q40fb.c -- Q40 frame buffer device
  *
- * Copyright (C) 2001
+ * Copyright (C) 2001
  *
  *      Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>
  *
@@ -45,7 +45,7 @@
 	.xres_virtual	= 1024,
 	.yres_virtual	= 512,
 	.bits_per_pixel	= 16,
-    	.red		= {6, 5, 0},
+	.red		= {6, 5, 0},
 	.green		= {11, 5, 0},
 	.blue		= {0, 6, 0},
 	.activate	= FB_ACTIVATE_NOW,
@@ -55,7 +55,7 @@
 };

 static int q40fb_setcolreg(unsigned regno, unsigned red, unsigned green,
-		  	   unsigned blue, unsigned transp,
+			   unsigned blue, unsigned transp,
 			   struct fb_info *info)
 {
     /*
@@ -63,7 +63,7 @@
      *  magnitude.
      *  Return != 0 for invalid regno.
      */
-
+
     if (regno > 255)
 	    return 1;
     red>>=11;
@@ -89,8 +89,11 @@

 static int __init q40fb_probe(struct device *device)
 {
-        if ( !MACH_IS_Q40)
-	  return -ENXIO;
+	struct platform_device *dev = to_platform_device(device);
+	struct fb_info *info;
+
+        if (!MACH_IS_Q40)
+		return -ENXIO;

 	/* mapped in q40/config.c */
 	q40fb_fix.smem_start = Q40_PHYS_SCREEN_ADDR;
@@ -98,19 +101,19 @@
 	info = framebuffer_alloc(sizeof(u32) * 256, &dev->dev);
 	if (!info)
 		return -ENOMEM;
-
+
 	info->var = q40fb_var;
 	info->fix = q40fb_fix;
 	info->fbops = &q40fb_ops;
 	info->flags = FBINFO_FLAG_DEFAULT;  /* not as module for now */
 	info->pseudo_palette = info->par;
 	info->par = NULL;
-   	info->screen_base = (char *) q40fb_fix.smem_start;
+	info->screen_base = (char *) q40fb_fix.smem_start;

-	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		framebuffer_release(info);
 		return -ENOMEM;
-	}
+	}

 	master_outb(3, DISPLAY_CONTROL_REG);

@@ -139,7 +142,7 @@
 int __init q40fb_init(void)
 {
 	int ret = 0;
-
+
 	ret = driver_register(&q40fb_driver);

 	if (!ret) {
@@ -150,4 +153,4 @@
 	return ret;
 }

-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL");

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297

From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Fri, 24 Jun 2005 01:09:54 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0506240015300.24330@pentafluge.infradead.org>
References: <9e47339105061021571f479b10@mail.gmail.com> 
 <Pine.LNX.4.62.0506120942100.11197@numbat.sonytel.be> 
 <9e47339105061518346d1df105@mail.gmail.com>  <200506161111.27115.adaplas@hotpop.com>
  <9e4733910506152037193300fa@mail.gmail.com> 
 <Pine.LNX.4.56.0506210103540.18685@pentafluge.infradead.org>
 <9e473391050620173132ea1ce6@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dlblk-0005R8-Dj
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 17:10:04 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Dlblh-00069W-5f
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 17:10:04 -0700
In-Reply-To: <9e473391050620173132ea1ce6@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> For example I don't think we have enough info to implement X's
> software cursor in the fbdev driver. We would need some way to know
> when X is updating the screen via paint or buffer swaps. Wouldn't that
> be a total mess for fbdev to track and a new API would be needed.

    I was pondering this and you are right. For the software cursor you 
need to blend the cursor image with what data is in the framebuffer at that 
location. If we have a concurrent thread that updates that area of the 
framebuffer then we would have to notify the cursor of the change to 
update that region of the screen with proper data. There is no clean way 
to do this. 
	Now I was thinking instead of a massive move of the the software 
cursor we add a flag FBINFO_HWACCEL_CURSOR to tell us if we are using a
hardware cursor. This way for the sysfs interface you can test to see if 
it is a hardware cursor and only allow userland to access a hardware 
cursor. Here is a patch for that. People please try it out.


diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/aty/mach64_cursor.c fbdev-2.6/drivers/video/aty/mach64_cursor.c
--- linus-2.6/drivers/video/aty/mach64_cursor.c	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/aty/mach64_cursor.c	2005-06-23 16:45:21.000000000 -0700
@@ -219,8 +219,8 @@
 	info->sprite.buf_align = 16; 	/* and 64 lines tall. */
 	info->sprite.flags = FB_PIXMAP_IO;
 
+	info->flags |= FBINFO_HWACCEL_CURSOR;
 	info->fbops->fb_cursor = atyfb_cursor;
-
 	return 0;
 }
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/i810/i810_main.c fbdev-2.6/drivers/video/i810/i810_main.c
--- linus-2.6/drivers/video/i810/i810_main.c	2005-06-22 17:09:52.000000000 -0700
+++ fbdev-2.6/drivers/video/i810/i810_main.c	2005-06-23 16:47:50.000000000 -0700
@@ -1375,7 +1375,6 @@
 	decode_var(&info->var, par);
 	i810_load_regs(par);
 	i810_init_cursor(par);
-
 	encode_fix(&info->fix, info);
 
 	if (info->var.accel_flags && !(par->dev_flags & LOCKUP)) {
@@ -1387,6 +1386,7 @@
 		info->pixmap.scan_align = 1;
 		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 	}
+	info->flags |= FBINFO_HWACCEL_CURSOR;
 	return 0;
 }
 
@@ -1420,7 +1420,7 @@
 
 	if (!(par->dev_flags & USE_HWCUR) || !info->var.accel_flags ||
 	    par->dev_flags & LOCKUP)
-		return soft_cursor(info, cursor);
+		return -ENXIO;
 
 	if (cursor->image.width > 64 || cursor->image.height > 64)
 		return -ENXIO;
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/intelfbdrv.c fbdev-2.6/drivers/video/intelfb/intelfbdrv.c
--- linus-2.6/drivers/video/intelfb/intelfbdrv.c	2005-06-22 17:09:52.000000000 -0700
+++ fbdev-2.6/drivers/video/intelfb/intelfbdrv.c	2005-06-23 17:04:24.000000000 -0700
@@ -117,14 +117,10 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
-#include <linux/console.h>
-#include <linux/selection.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
-#include <linux/kd.h>
-#include <linux/vt_kern.h>
 #include <linux/pagemap.h>
 #include <linux/version.h>
 
@@ -242,7 +238,7 @@
 static char *mode       = NULL;
 
 module_param(accel, bool, S_IRUGO);
-MODULE_PARM_DESC(accel, "Enable console acceleration");
+MODULE_PARM_DESC(accel, "Enable hardware acceleration");
 module_param(vram, int, S_IRUGO);
 MODULE_PARM_DESC(vram, "System RAM to allocate to framebuffer in MiB");
 module_param(voffset, int, S_IRUGO);
@@ -498,7 +494,7 @@
 {
 	struct fb_info *info;
 	struct intelfb_info *dinfo;
-	int i, j, err, dvo;
+	int i, err, dvo;
 	int aperture_size, stolen_size;
 	struct agp_kern_info gtt_info;
 	int agp_memtype;
@@ -841,13 +837,6 @@
 	if (bailearly == 5)
 		bailout(dinfo);
 
-	for (i = 0; i < 16; i++) {
-		j = color_table[i];
-		dinfo->palette[i].red = default_red[j];
-		dinfo->palette[i].green = default_grn[j];
-		dinfo->palette[i].blue = default_blu[j];
-	}
-
 	if (bailearly == 6)
 		bailout(dinfo);
 
@@ -1328,9 +1317,10 @@
 	if (ACCEL(dinfo, info)) {
 		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
 		FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
-		FBINFO_HWACCEL_IMAGEBLIT;
+		FBINFO_HWACCEL_IMAGEBLIT | FBINFO_HWACCEL_CURSOR;
 	} else {
-		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN | 
+		FBINFO_HWACCEL_CURSOR;
 	}
 	kfree(hw);
 	return 0;
@@ -1359,10 +1349,6 @@
 			green >>= 8;
 			blue >>= 8;
 
-			dinfo->palette[regno].red = red;
-			dinfo->palette[regno].green = green;
-			dinfo->palette[regno].blue = blue;
-
 			intelfbhw_setcolreg(dinfo, regno, red, green, blue,
 					    transp);
 		}
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/intelfb.h fbdev-2.6/drivers/video/intelfb/intelfb.h
--- linus-2.6/drivers/video/intelfb/intelfb.h	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/intelfb/intelfb.h	2005-06-23 17:03:59.000000000 -0700
@@ -234,7 +234,6 @@
 
 	/* palette */
 	u32 pseudo_palette[17];
-	struct { u8 red, green, blue, pad; } palette[256];
 
 	/* chip info */
 	int pci_chipset;
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/intelfbhw.c fbdev-2.6/drivers/video/intelfb/intelfbhw.c
--- linus-2.6/drivers/video/intelfb/intelfbhw.c	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/intelfb/intelfbhw.c	2005-06-23 16:32:22.000000000 -0700
@@ -29,14 +29,10 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
-#include <linux/console.h>
-#include <linux/selection.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
-#include <linux/kd.h>
-#include <linux/vt_kern.h>
 #include <linux/pagemap.h>
 #include <linux/version.h>
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/nvidia/nvidia.c fbdev-2.6/drivers/video/nvidia/nvidia.c
--- linus-2.6/drivers/video/nvidia/nvidia.c	2005-06-22 17:09:52.000000000 -0700
+++ fbdev-2.6/drivers/video/nvidia/nvidia.c	2005-06-23 16:51:38.000000000 -0700
@@ -1300,6 +1300,7 @@
 	    | FBINFO_HWACCEL_IMAGEBLIT
 	    | FBINFO_HWACCEL_FILLRECT
 	    | FBINFO_HWACCEL_COPYAREA
+	    | FBINFO_HWACCEL_CURSOR
 	    | FBINFO_HWACCEL_YPAN;
 
 	fb_videomode_to_modelist(info->monspecs.modedb,
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/riva/fbdev.c fbdev-2.6/drivers/video/riva/fbdev.c
--- linus-2.6/drivers/video/riva/fbdev.c	2005-06-22 17:09:52.000000000 -0700
+++ fbdev-2.6/drivers/video/riva/fbdev.c	2005-06-23 16:51:14.000000000 -0700
@@ -1704,7 +1704,8 @@
 		    | FBINFO_HWACCEL_YPAN
 		    | FBINFO_HWACCEL_COPYAREA
 		    | FBINFO_HWACCEL_FILLRECT
-	            | FBINFO_HWACCEL_IMAGEBLIT;
+	            | FBINFO_HWACCEL_IMAGEBLIT
+		    | FBINFO_HWACCEL_CURSOR;
 
 	/* Accel seems to not work properly on NV30 yet...*/
 	if ((par->riva.Architecture == NV_ARCH_30) || noaccel) {
diff -urN -X /home/jsimmons/dontdiff linus-2.6/include/linux/fb.h fbdev-2.6/include/linux/fb.h
--- linus-2.6/include/linux/fb.h	2005-06-22 17:09:52.000000000 -0700
+++ fbdev-2.6/include/linux/fb.h	2005-06-23 16:44:55.000000000 -0700
@@ -702,6 +702,7 @@
 #define FBINFO_HWACCEL_XPAN		0x1000 /* optional */
 #define FBINFO_HWACCEL_YPAN		0x2000 /* optional */
 #define FBINFO_HWACCEL_YWRAP		0x4000 /* optional */
+#define FBINFO_HWACCEL_CURSOR		0x8000 /* optional */
 
 #define FBINFO_MISC_USEREVENT          0x10000 /* event request
 						  from userspace */




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click

From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Fri, 24 Jun 2005 18:13:21 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0506241740220.15430@pentafluge.infradead.org>
References: <9e47339105061021571f479b10@mail.gmail.com> 
 <Pine.LNX.4.62.0506120942100.11197@numbat.sonytel.be> 
 <9e47339105061518346d1df105@mail.gmail.com>  <200506161111.27115.adaplas@hotpop.com>
  <9e4733910506152037193300fa@mail.gmail.com> 
 <Pine.LNX.4.56.0506210103540.18685@pentafluge.infradead.org> 
 <9e473391050620173132ea1ce6@mail.gmail.com> 
 <Pine.LNX.4.56.0506240015300.24330@pentafluge.infradead.org> 
 <9e473391050624052640aa5279@mail.gmail.com> 
 <Pine.LNX.4.56.0506241713210.14981@pentafluge.infradead.org>
 <9e47339105062409276fcd5223@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlrkA-0001yU-9c
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Jun 2005 10:13:30 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Dlrk8-0001pq-R1
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Jun 2005 10:13:30 -0700
In-Reply-To: <9e47339105062409276fcd5223@mail.gmail.com>
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
Cc: James Simmons <jsimmons@pentafluge.infradead.org>, adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> To address your concern, leave softcursor as an fbdev module. But we
> do need to remove all of those .fb_cursor = softcursor from all of the
> fbdev modules. As long as those are there we can only have one
> softcursor implementation.

Does this patch work for you? It reports to userland that no cursor is 
avaiable if the fbdev driver is using the software cursor.

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/aty/mach64_cursor.c fbdev-2.6/drivers/video/aty/mach64_cursor.c
--- linus-2.6/drivers/video/aty/mach64_cursor.c	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/aty/mach64_cursor.c	2005-06-24 09:04:12.000000000 -0700
@@ -219,8 +219,8 @@
 	info->sprite.buf_align = 16; 	/* and 64 lines tall. */
 	info->sprite.flags = FB_PIXMAP_IO;
 
+	info->flags |= FBINFO_HWACCEL_CURSOR;
 	info->fbops->fb_cursor = atyfb_cursor;
-
 	return 0;
 }
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbsysfs.c fbdev-2.6/drivers/video/fbsysfs.c
--- linus-2.6/drivers/video/fbsysfs.c	2005-06-14 11:51:24.000000000 -0700
+++ fbdev-2.6/drivers/video/fbsysfs.c	2005-06-24 09:46:33.000000000 -0700
@@ -311,13 +311,19 @@
 static ssize_t store_cursor(struct class_device *class_device,
 			    const char * buf, size_t count)
 {
-//	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+
+	if (!(fb_info->flags & FBINFO_HWACCEL_CURSOR))
+		return -ENXIO;
 	return 0;
 }
 
 static ssize_t show_cursor(struct class_device *class_device, char *buf)
 {
-//	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+
+	if (!(fb_info->flags & FBINFO_HWACCEL_CURSOR))
+		return -ENXIO;
 	return 0;
 }
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/i810/i810.h fbdev-2.6/drivers/video/i810/i810.h
--- linus-2.6/drivers/video/i810/i810.h	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/i810/i810.h	2005-06-24 09:04:12.000000000 -0700
@@ -201,7 +201,6 @@
 #define HAS_ACCELERATION            2
 #define ALWAYS_SYNC                 4
 #define LOCKUP                      8
-#define USE_HWCUR                  16
 
 struct gtt_data {
 	struct agp_memory *i810_fb_memory;
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/i810/i810_main.c fbdev-2.6/drivers/video/i810/i810_main.c
--- linus-2.6/drivers/video/i810/i810_main.c	2005-06-22 17:09:52.000000000 -0700
+++ fbdev-2.6/drivers/video/i810/i810_main.c	2005-06-24 09:04:12.000000000 -0700
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
 
@@ -1418,9 +1418,8 @@
 	struct i810fb_par *par = (struct i810fb_par *)info->par;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 
-	if (!(par->dev_flags & USE_HWCUR) || !info->var.accel_flags ||
-	    par->dev_flags & LOCKUP)
-		return soft_cursor(info, cursor);
+	if (!par->dev_flags & LOCKUP)
+		return -ENXIO;
 
 	if (cursor->image.width > 64 || cursor->image.height > 64)
 		return -ENXIO;
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/intelfbdrv.c fbdev-2.6/drivers/video/intelfb/intelfbdrv.c
--- linus-2.6/drivers/video/intelfb/intelfbdrv.c	2005-06-22 17:09:52.000000000 -0700
+++ fbdev-2.6/drivers/video/intelfb/intelfbdrv.c	2005-06-24 09:04:12.000000000 -0700
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
+++ fbdev-2.6/drivers/video/intelfb/intelfb.h	2005-06-24 09:04:12.000000000 -0700
@@ -234,7 +234,6 @@
 
 	/* palette */
 	u32 pseudo_palette[17];
-	struct { u8 red, green, blue, pad; } palette[256];
 
 	/* chip info */
 	int pci_chipset;
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/intelfbhw.c fbdev-2.6/drivers/video/intelfb/intelfbhw.c
--- linus-2.6/drivers/video/intelfb/intelfbhw.c	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/intelfb/intelfbhw.c	2005-06-24 09:04:13.000000000 -0700
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
+++ fbdev-2.6/drivers/video/nvidia/nvidia.c	2005-06-24 09:04:13.000000000 -0700
@@ -1300,6 +1300,7 @@
 	    | FBINFO_HWACCEL_IMAGEBLIT
 	    | FBINFO_HWACCEL_FILLRECT
 	    | FBINFO_HWACCEL_COPYAREA
+	    | FBINFO_HWACCEL_CURSOR
 	    | FBINFO_HWACCEL_YPAN;
 
 	fb_videomode_to_modelist(info->monspecs.modedb,
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/riva/fbdev.c fbdev-2.6/drivers/video/riva/fbdev.c
--- linus-2.6/drivers/video/riva/fbdev.c	2005-06-22 17:09:52.000000000 -0700
+++ fbdev-2.6/drivers/video/riva/fbdev.c	2005-06-24 09:04:13.000000000 -0700
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
+++ fbdev-2.6/include/linux/fb.h	2005-06-24 09:04:13.000000000 -0700
@@ -702,6 +702,7 @@
 #define FBINFO_HWACCEL_XPAN		0x1000 /* optional */
 #define FBINFO_HWACCEL_YPAN		0x2000 /* optional */
 #define FBINFO_HWACCEL_YWRAP		0x4000 /* optional */
+#define FBINFO_HWACCEL_CURSOR		0x8000 /* required */
 
 #define FBINFO_MISC_USEREVENT          0x10000 /* event request
 						  from userspace */


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click

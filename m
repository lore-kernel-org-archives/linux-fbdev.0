From: James Simmons <jsimmons@infradead.org>
Subject: [PATCH] cursor cleanup
Date: Fri, 12 Aug 2005 19:21:07 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508121919420.32142@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e9a-00059A-HI
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Aug 2005 11:21:14 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E3e9Z-00024K-8M
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Aug 2005 11:21:14 -0700
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>


Removes softcursor from several drivers using a hwcursor. Also the drivers 
no hardware cursor flags now make there fb_cursor function return a ENXIO;


diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/i810/i810.h fbdev-2.6/drivers/video/i810/i810.h
--- linus-2.6/drivers/video/i810/i810.h	2005-07-11 10:07:21.000000000 -0700
+++ fbdev-2.6/drivers/video/i810/i810.h	2005-08-11 13:34:58.000000000 -0700
@@ -201,7 +201,6 @@
 #define HAS_ACCELERATION            2
 #define ALWAYS_SYNC                 4
 #define LOCKUP                      8
-#define USE_HWCUR                  16
 
 struct gtt_data {
 	struct agp_memory *i810_fb_memory;
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/i810/i810_main.c fbdev-2.6/drivers/video/i810/i810_main.c
--- linus-2.6/drivers/video/i810/i810_main.c	2005-07-11 10:07:21.000000000 -0700
+++ fbdev-2.6/drivers/video/i810/i810_main.c	2005-08-12 09:36:50.000000000 -0700
@@ -1375,7 +1375,6 @@
 	decode_var(&info->var, par);
 	i810_load_regs(par);
 	i810_init_cursor(par);
-
 	encode_fix(&info->fix, info);
 
 	if (info->var.accel_flags && !(par->dev_flags & LOCKUP)) {
@@ -1418,9 +1417,8 @@
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
--- linus-2.6/drivers/video/intelfb/intelfbdrv.c	2005-07-11 10:07:21.000000000 -0700
+++ fbdev-2.6/drivers/video/intelfb/intelfbdrv.c	2005-08-12 09:38:29.000000000 -0700
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
 
@@ -1359,10 +1348,6 @@
 			green >>= 8;
 			blue >>= 8;
 
-			dinfo->palette[regno].red = red;
-			dinfo->palette[regno].green = green;
-			dinfo->palette[regno].blue = blue;
-
 			intelfbhw_setcolreg(dinfo, regno, red, green, blue,
 					    transp);
 		}
@@ -1495,7 +1480,7 @@
 #endif
 
 	if (!dinfo->hwcursor)
-		return soft_cursor(info, cursor);
+		return -ENXIO;
 
 	intelfbhw_cursor_hide(dinfo);
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/intelfb.h fbdev-2.6/drivers/video/intelfb/intelfb.h
--- linus-2.6/drivers/video/intelfb/intelfb.h	2005-07-11 10:07:21.000000000 -0700
+++ fbdev-2.6/drivers/video/intelfb/intelfb.h	2005-08-11 13:34:58.000000000 -0700
@@ -234,7 +234,6 @@
 
 	/* palette */
 	u32 pseudo_palette[17];
-	struct { u8 red, green, blue, pad; } palette[256];
 
 	/* chip info */
 	int pci_chipset;
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/intelfbhw.c fbdev-2.6/drivers/video/intelfb/intelfbhw.c
--- linus-2.6/drivers/video/intelfb/intelfbhw.c	2005-07-11 10:07:21.000000000 -0700
+++ fbdev-2.6/drivers/video/intelfb/intelfbhw.c	2005-08-11 13:34:58.000000000 -0700
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
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/Kconfig fbdev-2.6/drivers/video/Kconfig
--- linus-2.6/drivers/video/Kconfig	2005-07-28 10:24:11.000000000 -0700
+++ fbdev-2.6/drivers/video/Kconfig	2005-08-12 11:10:34.000000000 -0700
@@ -650,7 +650,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports graphics boards with the nVidia chips, TNT
 	  and newer. For very old chipsets, such as the RIVA128, then use
@@ -681,7 +680,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports graphics boards with the nVidia Riva/Geforce
 	  chips.
@@ -720,7 +718,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports the on-board graphics built in to the Intel 810 
           and 815 chipsets.  Say Y if you have and plan to use such a board.
@@ -763,7 +760,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports the on-board graphics built in to the Intel
           830M/845G/852GM/855GM/865G chipsets.
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/nvidia/nvidia.c fbdev-2.6/drivers/video/nvidia/nvidia.c
--- linus-2.6/drivers/video/nvidia/nvidia.c	2005-08-11 13:32:45.000000000 -0700
+++ fbdev-2.6/drivers/video/nvidia/nvidia.c	2005-08-12 11:09:09.000000000 -0700
@@ -893,7 +893,7 @@
 	int i, set = cursor->set;
 	u16 fg, bg;
 
-	if (cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
+	if (!hwcur || cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
 		return -ENXIO;
 
 	NVShowHideCursor(par, 0);
@@ -1356,8 +1356,6 @@
 	info->pixmap.size = 8 * 1024;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
-	if (!hwcur)
-		info->fbops->fb_cursor = soft_cursor;
 	info->var.accel_flags = (!noaccel);
 
 	switch (par->Architecture) {


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

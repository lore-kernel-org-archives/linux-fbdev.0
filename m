From: Jim Hague <jim.hague@acm.org>
Subject: pm2fb fixes
Date: Wed, 21 Apr 2004 00:46:44 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040421004644.jim.hague@acm.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BG4x6-0005oe-6t
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 16:46:56 -0700
Received: from cpc3-oxfd2-6-0-cust100.oxfd.cable.ntl.com ([81.103.193.100] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BG4x5-0000nI-IW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 16:46:56 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@infradead.org>

The conversion of pm2fb to using framebuffer_alloc() introduced a null pointer
dereference bug.

This patch fixes this bug, and a silly problem in pm2fb_blank(). There's also
some minor tidying.

The patch is against 2.6.6-rc1.

===== drivers/video/pm2fb.c 1.25 vs edited =====
--- 1.25/drivers/video/pm2fb.c  Fri Apr 16 17:30:02 2004
+++ edited/drivers/video/pm2fb.c        Tue Apr 20 11:56:53 2004
@@ -63,6 +63,16 @@
 #endif
 
 /*
+ * The 2.4 driver calls reset_card() at init time, where it also sets the
+ * initial mode. I don't think the driver should touch the chip until
+ * the console sets a video mode. So I was calling this at the start
+ * of setting a mode. However, certainly on 1280x1024 depth 16 on my
+ * PCI Graphics Blaster Exxtreme this causes the display to smear
+ * slightly.  I don't know why. Guesses to jim.hague@acm.org.
+ */
+#undef RESET_CARD_ON_MODE_SET
+
+/*
  * Driver data 
  */
 static char *mode __initdata = NULL;
@@ -340,16 +350,7 @@
        }
 }
 
-#if 0
-/*
- * FIXME:
- * The 2.4 driver calls this at init time, where it also sets the
- * initial mode. I don't think the driver should touch the chip
- * until the console sets a video mode. So I was calling this
- * at the start of setting a mode. However, certainly on 1280x1024
- * depth 16 this causes the display to smear slightly.
- * I don't know why. Guesses to jim.hague@acm.org.
- */
+#ifdef RESET_CARD_ON_MODE_SET
 static void reset_card(struct pm2fb_par* p)
 {
        if (p->type == PM2_TYPE_PERMEDIA2V)
@@ -501,6 +502,8 @@
        u32 vsync;
 
        vsync = video;
+
+       DPRINTK("video = 0x%x\n", video);
        
        /*
         * The hardware cursor needs +vsync to recognise vert retrace.
@@ -660,6 +663,9 @@
        u32 xres;
        int data64;
 
+#ifdef RESET_CARD_ON_MODE_SET
+       reset_card(par);
+#endif 
        reset_config(par);
        clear_palette(par);
     
@@ -721,8 +727,7 @@
 
        info->fix.visual =
                (depth == 8) ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
-       info->fix.line_length =
-               info->var.xres * ((info->var.bits_per_pixel + 7) >> 3);
+       info->fix.line_length = info->var.xres * depth / 8;
        info->cmap.len = 256;
 
        /*
@@ -803,6 +808,8 @@
                break;
        }
        set_pixclock(par, pixclock);
+       DPRINTK("Setting graphics mode at %dx%d depth %d\n",
+               info->var.xres, info->var.yres, info->var.bits_per_pixel);
        return 0;       
 }
 
@@ -843,7 +850,8 @@
         *   var->{color}.offset contains start of bitfield
         *   var->{color}.length contains length of bitfield
         *   {hardwarespecific} contains width of DAC
-        *   cmap[X] is programmed to (X << red.offset) | (X << green.offset) | 
(X << blue.offset)
+        *   cmap[X] is programmed to
+        *   (X << red.offset) | (X << green.offset) | (X << blue.offset)
         *   RAMDAC[X] is programmed to (red, green, blue)
         *
         * Pseudocolor:
@@ -856,8 +864,9 @@
         *    does not use RAMDAC (usually has 3 of them).
         *    var->{color}.offset contains start of bitfield
         *    var->{color}.length contains length of bitfield
-        *    cmap is programmed to (red << red.offset) | (green << green.offset
) |
-        *                      (blue << blue.offset) | (transp << transp.offset
)
+        *    cmap is programmed to
+        *    (red << red.offset) | (green << green.offset) |
+        *    (blue << blue.offset) | (transp << transp.offset)
         *    RAMDAC does not exist
         */
 #define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
@@ -962,6 +971,11 @@
        struct pm2fb_par *par = (struct pm2fb_par *) info->par;
        u32 video = par->video;
 
+       DPRINTK("blank_mode %d\n", blank_mode);
+
+       /* Turn everything on, then disable as requested. */
+       video |= (PM2F_VIDEO_ENABLE | PM2F_HSYNC_MASK | PM2F_VSYNC_MASK);
+
        switch (blank_mode) {
        case 0:         /* Screen: On; HSync: On, VSync: On */
                break;
@@ -1030,15 +1044,12 @@
                return err;
        }
 
-       size = sizeof(struct fb_info) + sizeof(struct pm2fb_par) + 256 * sizeof(
u32);
-
+       size = sizeof(struct pm2fb_par) + 256 * sizeof(u32);
        info = framebuffer_alloc(size, &pdev->dev);
        if ( !info )
                return -ENOMEM;
-       memset(info, 0, size);
-    
-       default_par = info->par;
- 
+       default_par = (struct pm2fb_par *) info->par;
+
        switch (pdev->device) {
        case  PCI_DEVICE_ID_TI_TVP4020:
                strcpy(pm2fb_fix.id, "TVP4020");
@@ -1112,7 +1123,6 @@
 
        info->fbops             = &pm2fb_ops;
        info->fix               = pm2fb_fix;    
-       info->par               = default_par;
        info->pseudo_palette    = (void *)(default_par + 1); 
        info->flags             = FBINFO_FLAG_DEFAULT;
 

-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

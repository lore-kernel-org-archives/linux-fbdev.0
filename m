From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH]: Fix NULL-ptr dereference in pm2fb_probe (fwd)
Date: Sun, 25 Apr 2004 03:08:05 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404250307260.15965-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BHZ43-0007M3-6e
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 24 Apr 2004 19:08:15 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BHZ42-0003sN-68
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 24 Apr 2004 19:08:14 -0700
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, jim.hague@acm.org



---------- Forwarded message ----------
Date: Sat, 24 Apr 2004 13:19:04 +0100 (BST)
From: Jim Hague <jim.hague@acm.org>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH]: Fix NULL-ptr dereference in pm2fb_probe

On 23-Apr-2004 James Simmons wrote:
> Okay I seen alot of patches going around. So the patch doesn't get lost 
> can someone send me the final patch. I can then forward it to Andrew.

This patch (against 2.6.6-rc1) please. It fixes the NULL pointer dereference
and also a problem in pm2fb_blank().


===== pm2fb.c 1.25 vs 1.26 =====
--- 1.25/drivers/video/pm2fb.c  Fri Apr 16 17:30:02 2004
+++ 1.26/drivers/video/pm2fb.c  Wed Apr 21 00:26:58 2004
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
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297

From: John Zielinski <grim@undead.cc>
Subject: Text corruption on bootup
Date: Sat, 15 Nov 2003 04:25:32 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FB5F10C.6070903@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AKwgV-0001zm-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 01:25:40 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AKwgV-00017z-G1
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 15 Nov 2003 01:25:39 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

When booting my system, the text that is displayed before the switch to 
graphics mode ends up being corrupted after the switch.  Something was 
corrupting it before the console driver could copy and adjust it to the 
new screen size.  I finally tracked down what was causing this!  :)

Unlike in graphics mode where the char/atrib pairs are stored in a 
separate buffer at all times, the text mode driver keeps the foreground 
window's contents in video memory.  When the frame buffer driver 
switches to graphics mode, the aperture to video memory mappings are 
altered and the text now looks scrambled.  I finally found an simple and 
elegant solution: tell the console driver that we're switching to 
graphics mode.   All we need to do is call do_blank_screen(1) immediatly 
before switching to graphics mode.

Here's a patch to do this.  The minor changes to fbcon.c and fb.h are a 
relay function so that the frame buffer drivers don't have to include an 
extra inlude file just for the definition of do_blank_screen.  I've only 
added the call to fb_graphics_mode() to the radeon driver as that's what 
I tested it with.  That one line just needs to be added to the other 
drivers as well.

diff -urN -X dontdiff fbdev-2.6/drivers/video/aty/radeon_base.c fbdev/drivers/video/aty/radeon_base.c
--- fbdev-2.6/drivers/video/aty/radeon_base.c	2003-11-15 03:24:10.000000000 -0500
+++ fbdev/drivers/video/aty/radeon_base.c	2003-11-15 03:32:10.000000000 -0500
@@ -1740,6 +1740,9 @@
 				(vsync_wid << 16) | (v_sync_pol  << 23));
 	}
 
+	/* Tell VGA driver to stop using video memory */
+	fb_graphics_mode();
+		
 	/* do it! */
 	if (!rinfo->asleep) {
 		radeon_write_mode (rinfo, &newmode);
diff -urN -X dontdiff fbdev-2.6/drivers/video/console/fbcon.c fbdev/drivers/video/console/fbcon.c
--- fbdev-2.6/drivers/video/console/fbcon.c	2003-11-15 03:24:10.000000000 -0500
+++ fbdev/drivers/video/console/fbcon.c	2003-11-15 03:31:27.000000000 -0500
@@ -306,6 +306,16 @@
 }
 
 /*
+ *	This function is used by a frame buffer driver when it is about to 
+ *	switch to graphics mode.  This will force the VGA text mode driver 
+ *	to stop using video memory for its foreground display buffer.
+ */
+void fb_graphics_mode(void)
+{
+	do_blank_screen(1);
+}
+
+/*
  * Accelerated handlers.
  */
 void accel_bmove(struct vc_data *vc, struct fb_info *info, int sy, 
diff -urN -X dontdiff fbdev-2.6/include/linux/fb.h fbdev/include/linux/fb.h
--- fbdev-2.6/include/linux/fb.h	2003-11-15 03:24:10.000000000 -0500
+++ fbdev/include/linux/fb.h	2003-11-15 03:30:03.000000000 -0500
@@ -508,6 +508,9 @@
 extern void cfb_copyarea(struct fb_info *info, const struct fb_copyarea *area); 
 extern void cfb_imageblit(struct fb_info *info, const struct fb_image *image);
 
+/* drivers/video/fbcon.c */
+void fb_graphics_mode(void);
+
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);

 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);


Please let me know what you think.

John





-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl

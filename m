From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Fix switch from XFree
Date: Tue, 10 Feb 2004 21:36:42 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1076409397.873.6.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqVG7-00035M-5o
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 02:36:51 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AqVGD-0001e2-AX
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 02:36:57 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi James !

(This patch includes the one adding the lock around the notifier
registration so you can drop that previous one)

Currently, there is a problem when switching from XFree to a console
that became especially annoying now that we have some accelerations
in radeonfb 2.6. XFree leaves the accel engine in a state that is
incorrect for our accel operations. This problem is generic with most
drivers, we can't expect X to leave the accel engine in the right
state, that's simply unrealistic.

The approach I've taken is from fbcon_switch, to check wether we
are switching from KD_GRAPHICS to a KD_TEXT console, and in this
case, cause fb_set_var with an additional flag I defined,
FB_ACTIVATE_FORCE, which will just bypass the comparison on the
var structure, forcing set_par to be called again.

That works for normal switches. That doesn't quite deal with a
console beeing switched from KD_GRAPHICS to KD_TEXT, there is
no consw hook for that, so one would have to be added for this
purpose I suspect... But that part of the problem is much less
annoying in practice.

The patch also include a couple of leftover fixes from my tree,
it's too late for me to split things up ;) Mostly dealing with
the cursor when the fb is sleeping

(Oh, and that FB_PIXMAP_IO seemed wrong, I switched back to
_DEFAULT, as it's not mapped into card space afaik)

Ben.

diff -urN fbdev-2.5/drivers/video/console/fbcon.c linuxppc-2.5-benh/drivers/video/console/fbcon.c
--- fbdev-2.5/drivers/video/console/fbcon.c	2004-02-09 14:48:31.000000000 +1100
+++ linuxppc-2.5-benh/drivers/video/console/fbcon.c	2004-02-10 21:05:25.000000000 +1100
@@ -196,7 +196,7 @@
 {
 	struct fb_info *info = (struct fb_info *) private;
 
-	if (!info)
+	if (!info || info->state != FBINFO_STATE_RUNNING)
 		return;
 	info->cursor.enable ^= 1;
 	info->fbops->fb_cursor(info, &info->cursor);
@@ -602,7 +602,6 @@
 
 	/* on which frame buffer will we open this console? */
 	info = registered_fb[(int) con2fb_map[unit]];
-	
 	if (info->var.accel_flags)
 		fb_display[unit].scrollmode = SCROLL_YNOMOVE;
 	else
@@ -1564,8 +1563,8 @@
 			height, width);
 }
 
-static int fbcon_resize(struct vc_data *vc, unsigned int width, 
-			unsigned int height)
+static int fbcon_do_resize(struct vc_data *vc, unsigned int width, 
+			   unsigned int height, int force)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
@@ -1573,13 +1572,14 @@
 	int err; int x_diff, y_diff;
 	int fw = vc->vc_font.width;
 	int fh = vc->vc_font.height;
+	int rc = 0;
 
 	var.xres = width * fw;
 	var.yres = height * fh;
 	x_diff = info->var.xres - var.xres;
 	y_diff = info->var.yres - var.yres;
 	if (x_diff < 0 || x_diff > fw ||
-	   (y_diff < 0 || y_diff > fh)) {
+	   (y_diff < 0 || y_diff > fh) || force) {
 		var.activate = FB_ACTIVATE_FIND;
 		err = fb_set_var(info, &var);
 		if (err || width > var.xres/fw ||
@@ -1587,6 +1587,8 @@
 			return -EINVAL;
        		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 		var.activate = FB_ACTIVATE_NOW;
+		if (force)
+			var.activate |= FB_ACTIVATE_FORCE;
 		/* This flag is enough for now as we are supposed to hold
 		 * the console semaphore at this point. I agree it's a bit
 		 * ugly but it does the job until some better solution is
@@ -1595,17 +1597,25 @@
 		console_resizing = 1;
 		fb_set_var(info, &var);
 		console_resizing = 0;
+		rc = 1;
 	}
 	p->vrows = var.yres_virtual/fh;
 	if (var.yres > (fh * (height + 1)))
 		p->vrows -= (var.yres - (fh * height)) / fh;
-	return 0;
+	return rc;
+}
+
+static int fbcon_resize(struct vc_data *vc, unsigned int width, 
+			unsigned int height)
+{
+	return fbcon_do_resize(vc, width, height, 0);
 }
 
 static int fbcon_switch(struct vc_data *vc)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
+	int gfx_to_text = 0;
 
 	if (softback_top) {
 		int l = fbcon_softback_size / vc->vc_size_row;
@@ -1633,12 +1643,17 @@
 	if (info)
 		info->var.yoffset = p->yscroll = 0;
 
+	if (info->currcon == -1 ||
+	    (vt_cons[info->currcon]->vc_mode != KD_TEXT &&
+	     vt_cons[vc->vc_num]->vc_mode == KD_TEXT))
+		gfx_to_text = 1;
+
 	/* Set currcon before fbcon_resize or we'll do bad things
 	 * when fbdev calls us back on mode changed notification
 	 */
 	info->currcon = vc->vc_num;
 
-        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
+        fbcon_do_resize(vc, vc->vc_cols, vc->vc_rows, gfx_to_text);
 	switch (p->scrollmode & __SCROLL_YMASK) {
 	case __SCROLL_YWRAP:
 		scrollback_phys_max = p->vrows - vc->vc_rows;
@@ -2247,24 +2262,31 @@
 
 static void fbcon_suspended(struct fb_info *info)
 {
-	/* Here, we should do something to properly erase the
-	 * cursor and synchronize with the cursor interrupt on
-	 * SMP... (may not be that critical though...)
-	 */
+	/* Clear cursor, restore saved data */
+	info->cursor.enable = 0;
+	info->fbops->fb_cursor(info, &info->cursor);
 }
 
 static void fbcon_resumed(struct fb_info *info)
 {
-	struct vc_data *vc = vc_cons[info->currcon].d;
+	struct vc_data *vc;
+
+	if (info->currcon < 0)
+		return;
+	vc = vc_cons[info->currcon].d;
 
 	update_screen(vc->vc_num);
 }
 
 static void fbcon_mode_changed(struct fb_info *info)
 {
-	struct vc_data *vc = vc_cons[info->currcon].d;
+	struct vc_data *vc;
 	int rows, cols;
 
+	if (info->currcon < 0)
+		return;
+	vc = vc_cons[info->currcon].d;
+
 	/* This isn't perfect yet. If we change one console, we
 	 * don't change them all and we switch back to the wrong
 	 * mode on next console switch. We need to either keep a
@@ -2339,6 +2361,7 @@
 	.notifier_call	= fbcon_event_notify,
 };
 
+static int fbcon_event_notifier_registered;
 
 int __init fb_console_init(void)
 {
@@ -2349,14 +2372,24 @@
 	take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default);
 	info = registered_fb[num_registered_fb-1];	
 
-	fb_register_client(&fbcon_event_notifer);
+	acquire_console_sem();
+	if (!fbcon_event_notifier_registered) {
+		fb_register_client(&fbcon_event_notifer);
+		fbcon_event_notifier_registered = 1;
+	} 
+	release_console_sem();
 
 	return 0;
 }
 
 void __exit fb_console_exit(void)
 {
-	fb_unregister_client(&fbcon_event_notifer);
+	acquire_console_sem();
+	if (fbcon_event_notifier_registered) {
+		fb_unregister_client(&fbcon_event_notifer);
+		fbcon_event_notifier_registered = 0;
+	}
+	release_console_sem();
 	give_up_console(&fb_con);
 }	
 
diff -urN fbdev-2.5/drivers/video/fbmem.c linuxppc-2.5-benh/drivers/video/fbmem.c
--- fbdev-2.5/drivers/video/fbmem.c	2004-02-10 21:15:18.000000000 +1100
+++ linuxppc-2.5-benh/drivers/video/fbmem.c	2004-02-10 21:01:47.000000000 +1100
@@ -965,7 +965,8 @@
 {
 	int err;
 
-	if (memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
+	if ((var->activate & FB_ACTIVATE_FORCE) ||
+	    memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
 		if (!info->fbops->fb_check_var) {
 			*var = info->var;
 			return 0;
@@ -1023,7 +1024,7 @@
 	struct fb_con2fbmap con2fb;
 #endif
 	struct fb_cmap cmap;
-	int i;
+	int i, rc;
 	
 	if (!fb)
 		return -ENODEV;
@@ -1064,7 +1065,10 @@
 			return -EFAULT;
 		return 0;
 	case FBIO_CURSOR:
-		return (fb_cursor(info, (struct fb_cursor *) arg));
+		acquire_console_sem();
+		rc = fb_cursor(info, (struct fb_cursor *) arg);
+		release_console_sem();
+		return rc;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE
 	case FBIOGET_CON2FBMAP:
 		if (copy_from_user(&con2fb, (void *)arg, sizeof(con2fb)))
@@ -1304,7 +1308,7 @@
 			fb_info->sprite.size = FBPIXMAPSIZE;
 			fb_info->sprite.buf_align = sizeof(unsigned long);
 			fb_info->sprite.scan_align = sizeof(unsigned long);
-			fb_info->sprite.flags = FB_PIXMAP_IO;
+			fb_info->sprite.flags = FB_PIXMAP_DEFAULT;
 		}
 	}	
 	fb_info->sprite.offset = 0;
@@ -1411,7 +1415,7 @@
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
 
 	class_register(&fb_class);
-	
+
 #ifdef CONFIG_FB_OF
 	if (ofonly) {
 		offb_init();
diff -urN fbdev-2.5/include/linux/fb.h linuxppc-2.5-benh/include/linux/fb.h
--- fbdev-2.5/include/linux/fb.h	2004-02-10 21:15:19.000000000 +1100
+++ linuxppc-2.5-benh/include/linux/fb.h	2004-02-10 20:58:22.000000000 +1100
@@ -153,6 +153,7 @@
 #define FB_ACTIVATE_VBL	       16	/* activate values on next vbl  */
 #define FB_CHANGE_CMAP_VBL     32	/* change colormap on vbl	*/
 #define FB_ACTIVATE_ALL	       64	/* change all VCs on this fb	*/
+#define FB_ACTIVATE_FORCE     128	/* force apply even when no change*/
 
 #define FB_ACCELF_TEXT		1	/* text mode acceleration */
 
@@ -391,10 +392,10 @@
 #include <linux/notifier.h>
 #include <asm/io.h>
 
-struct vm_area_struct;
 struct fb_info;
-struct device;
+struct vm_area_struct;
 struct file;
+struct device;
 
 /*
  * Register/unregister for framebuffer events
@@ -418,9 +419,9 @@
  * Pixmap structure definition
  *
  * The purpose of this structure is to translate data
- * from the hardware independent format of fbdev to what 
+ * from the hardware independent format of fbdev to what
  * format the hardware needs.
- */ 
+ */
 
 #define FB_PIXMAP_DEFAULT 1     /* used internally by fbcon */
 #define FB_PIXMAP_SYSTEM  2     /* memory is in system RAM  */




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

From: jsimmons@pentafluge.infradead.org
Subject: Re: [PATCH 2/4][RESEND][FBDEV]: Video mode change notify (fbset)
Date: Thu, 24 Jun 2004 00:43:12 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0406240041490.31199@pentafluge.infradead.org>
References: <200406220639.20791.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdHOe-0007Nf-PU
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 16:43:16 -0700
Received: from [213.146.154.40] (helo=pentafluge.infradead.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BdHOd-0004g1-RE
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 16:43:16 -0700
In-Reply-To: <200406220639.20791.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Hi James, Andrew
> 
> This patch allows fbset to change the video mode and the console
> window size via the notifier call chain.  It will only notify fbcon of
> mode changes from user space.  Changes coming from
> upstream will be ignored.
> 
> The code will only update the current console.

How about this. It has a few more cleanups and a fix for the suspend code.


diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/console/fbcon.c fbdev-2.6/drivers/video/console/fbcon.c
--- linus-2.6/drivers/video/console/fbcon.c	2004-06-23 09:38:19.000000000 -0700
+++ fbdev-2.6/drivers/video/console/fbcon.c	2004-06-23 15:11:19.000000000 -0700
@@ -1470,11 +1470,11 @@
 {
 	int cap = info->flags;
 	int good_pan = (cap & FBINFO_HWACCEL_YPAN)
-		 && divides(info->fix.ypanstep, vc->vc_font.height)
-		 && info->var.yres_virtual >= 2*info->var.yres;
+		&& divides(info->fix.ypanstep, vc->vc_font.height)
+		&& info->var.yres_virtual >= 2*info->var.yres;
 	int good_wrap = (cap & FBINFO_HWACCEL_YWRAP)
-		 && divides(info->fix.ywrapstep, vc->vc_font.height)
-		 && divides(vc->vc_font.height, info->var.yres_virtual);
+		&& divides(info->fix.ywrapstep, vc->vc_font.height)
+		&& divides(vc->vc_font.height, info->var.yres_virtual);
 	int reading_fast = cap & FBINFO_READS_FAST;
 	int fast_copyarea = (cap & FBINFO_HWACCEL_COPYAREA) && !(cap & FBINFO_HWACCEL_DISABLED);
 
@@ -1514,8 +1514,8 @@
 
 		snprintf(mode, 40, "%ix%i", var.xres, var.yres);
 		err = fb_find_mode(&var, info, mode, info->monspecs.modedb,
-				   info->monspecs.modedb_len, NULL,
-				   info->var.bits_per_pixel);
+					info->monspecs.modedb_len, NULL,
+					info->var.bits_per_pixel);
 		if (!err || width > var.xres/fw || height > var.yres/fh)
 			return -EINVAL;
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
@@ -1563,7 +1563,7 @@
 	}
 	if (info)
 		info->var.yoffset = p->yscroll = 0;
- 	fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
+        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
 	switch (p->scrollmode) {
 	case SCROLL_WRAP:
 		scrollback_phys_max = p->vrows - vc->vc_rows;
@@ -2169,34 +2169,72 @@
 	return 0;
 }
 
-static void fbcon_suspended(struct fb_info *info)
+static void fbcon_suspended(struct fb_info *info, struct vc_data *vc)
 {
 	/* Clear cursor, restore saved data */
-	info->cursor.enable = 0;
-	info->fbops->fb_cursor(info, &info->cursor);
+	fbcon_cursor(vc, CM_ERASE);
 }
 
-static void fbcon_resumed(struct fb_info *info)
+static void fbcon_resumed(struct fb_info *info, struct vc_data *vc)
 {
-	struct vc_data *vc;
+	update_screen(vc->vc_num);
+}
 
-	if (info->currcon < 0)
+static void fbcon_modechanged(struct fb_info *info, struct vc_data *vc)
+{
+	struct display *p = &fb_display[vc->vc_num];
+	int rows, cols;
+
+	if (info->currcon < 0 || vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
 		return;
-	vc = vc_cons[info->currcon].d;
 
-	update_screen(vc->vc_num);
+	info->var.xoffset = info->var.yoffset = p->yscroll = 0;
+	vc->vc_can_do_color = info->var.bits_per_pixel != 1;
+	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
+
+	if (CON_IS_VISIBLE(vc)) {
+		cols = info->var.xres / vc->vc_font.width;
+		rows = info->var.yres / vc->vc_font.height;
+		vc_resize(vc->vc_num, cols, rows);
+		scrollback_max = 0;
+		scrollback_current = 0;
+		update_var(vc->vc_num, info);
+		update_screen(vc->vc_num);
+		if (softback_buf) {
+			int l = fbcon_softback_size / vc->vc_size_row;
+			if (l > 5)
+				softback_end = softback_buf + l * vc->vc_size_row;
+			else {
+				/* Smaller scrollback makes no sense, and 0
+				   would screw the operation totally */
+				softback_top = 0;
+			}
+		}
+	}
 }
+
 static int fbcon_event_notify(struct notifier_block *self, 
 			      unsigned long action, void *data)
 {
 	struct fb_info *info = (struct fb_info *) data;
+	struct vc_data *vc;
+	
+	if (info->currcon < 0)
+		return 0;
 
+	vc = vc_cons[info->currcon].d;
+	if (!vc)
+		return 0;
+	
 	switch(action) {
 	case FB_EVENT_SUSPEND:
-		fbcon_suspended(info);
+		fbcon_suspended(info, vc);
 		break;
 	case FB_EVENT_RESUME:
-		fbcon_resumed(info);
+		fbcon_resumed(info, vc);
+		break;
+	case FB_EVENT_MODE_CHANGE:
+		fbcon_modechanged(info, vc);
 		break;
 	}
 	return 0;
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbmem.c fbdev-2.6/drivers/video/fbmem.c
--- linus-2.6/drivers/video/fbmem.c	2004-06-23 09:38:17.000000000 -0700
+++ fbdev-2.6/drivers/video/fbmem.c	2004-06-23 15:11:27.000000000 -0700
@@ -998,8 +1001,11 @@
 
 			fb_set_cmap(&info->cmap, 1, info);
 
-			notifier_call_chain(&fb_notifier_list, FB_EVENT_MODE_CHANGE, info);
-		}
+			if (info->flags & FBINFO_MISC_MODECHANGEUSER) {
+				info->flags &= ~FBINFO_MISC_MODECHANGEUSER;
+				notifier_call_chain(&fb_notifier_list, FB_EVENT_MODE_CHANGE, info);
+			}
+		}		
 	}
 	return 0;
 }
@@ -1049,7 +1055,9 @@
 		if (copy_from_user(&var, (void *) arg, sizeof(var)))
 			return -EFAULT;
 		acquire_console_sem();
+		info->flags |= FBINFO_MISC_MODECHANGEUSER;
 		i = fb_set_var(info, &var);
+		info->flags &= ~FBINFO_MISC_MODECHANGEUSER;
 		release_console_sem();
 		if (i) return i;
 		if (copy_to_user((void *) arg, &var, sizeof(var)))
diff -urN -X /home/jsimmons/dontdiff linus-2.6/include/linux/fb.h fbdev-2.6/include/linux/fb.h
--- linus-2.6/include/linux/fb.h	2004-06-23 09:39:30.000000000 -0700
+++ fbdev-2.6/include/linux/fb.h	2004-06-23 15:11:11.000000000 -0700
@@ -530,6 +530,8 @@
 #define FBINFO_HWACCEL_YPAN		0x2000 /* optional */
 #define FBINFO_HWACCEL_YWRAP		0x4000 /* optional */
 
+/* mode change request from userspace */
+#define FBINFO_MISC_MODECHANGEUSER	0x10000
 
 struct fb_info {
 	int node;


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH][FBCON]: Mode Switch in fbcon_blank()
Date: Wed, 30 Jun 2004 10:47:57 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406301047.57423.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfVDl-0005Mb-Hk
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 19:53:13 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BfVDk-0002Xw-5L
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 19:53:13 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id EE1EC788A7
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Jun 2004 01:44:59 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi Ben,

As we've discussed in another thread, below is a diff that will do a
set_par() as late as possible when there is KD_TEXT<->KD_GRAPHICS
switch.  The set_par() will be forced in fbcon_resize() instead.

Not sure if this has repercussions with the other drivers, but this patch
fixed the X nv driver hanging when switching to the console. (I believe
the crash is actually caused by an early set_par() -- while in
fbcon_blank. Removing the set_par in fbcon_blank fixed the hang but
caused cursor sprite and display corruption).

What do you think?

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

diff -Naur linux-2.6.7-mm4-orig/drivers/video/console/fbcon.c linux-2.6.7-mm4/drivers/video/console/fbcon.c
--- linux-2.6.7-mm4-orig/drivers/video/console/fbcon.c	2004-06-30 01:45:21.015306888 +0000
+++ linux-2.6.7-mm4/drivers/video/console/fbcon.c	2004-06-30 01:45:58.306637744 +0000
@@ -1679,7 +1679,8 @@
 	var.yres = height * fh;
 	x_diff = info->var.xres - var.xres;
 	y_diff = info->var.yres - var.yres;
-	if (x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh)) {
+	if (x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh) ||
+	    (info->flags & FBINFO_MISC_MODESWITCH)) {
 		char mode[40];
 
 		DPRINTK("attempting resize %ix%i\n", var.xres, var.yres);
@@ -1694,9 +1695,12 @@
 			return -EINVAL;
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 		if (CON_IS_VISIBLE(vc)) {
-			var.activate = FB_ACTIVATE_NOW;
+			var.activate = FB_ACTIVATE_NOW |
+				(info->flags & FBINFO_MISC_MODESWITCH) ? 
+				FB_ACTIVATE_FORCE : 0;
 			fb_set_var(info, &var);
 		}
+		info->flags &= ~FBINFO_MISC_MODESWITCH;
 	}
 	updatescrollmode(p, info, vc);
 	return 0;
@@ -1798,17 +1802,8 @@
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 
-	if (mode_switch) {
-		struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-		struct fb_var_screeninfo var = info->var;
-
-		if (blank) {
-			fbcon_cursor(vc, CM_ERASE);
-			return 0;
-		}
-		var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE;
-		fb_set_var(info, &var);
-	}
+	if (mode_switch)
+		info->flags |= FBINFO_MISC_MODESWITCH;
 
 	fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
 
diff -Naur linux-2.6.7-mm4-orig/include/linux/fb.h linux-2.6.7-mm4/include/linux/fb.h
--- linux-2.6.7-mm4-orig/include/linux/fb.h	2004-06-30 01:47:22.785794960 +0000
+++ linux-2.6.7-mm4/include/linux/fb.h	2004-06-30 01:46:24.799610200 +0000
@@ -532,6 +532,7 @@
 
 #define FBINFO_MISC_MODECHANGEUSER     0x10000 /* mode change request
 						  from userspace */
+#define FBINFO_MISC_MODESWITCH         0x20000 /* mode switch */
 
 struct fb_info {
 	int node;




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

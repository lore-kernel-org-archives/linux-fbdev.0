From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/6] fbcon: Stop framebuffer operations before hardware is properly initialized
Date: Sun, 13 Mar 2005 08:33:44 +0800
Message-ID: <200503130833.44469.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAH5c-0003pr-Ax
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 16:36:16 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAH5a-0008Q8-6K
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 16:36:16 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6142FF9EBE9
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Mar 2005 00:36:08 +0000 (UTC)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

  Accessing the hardware before it is properly initialized can lead to crashes
  or screen corruption.  This happens when switching to X then back to console.
  When console comes back from X, the device is in an undefined state. During
  this window, accessing the hardware is disallowed.

  A new field in fbcon_par is added (graphics), which will be set to nonzero
  just before initialization of the framebuffer and when coming back from
  KD_GRAPHICS, then unset when an fb_set_var/fb_set_par is done.  While this
  field is set, no accesses to the hardware is done. The consequence of
  this change is, hopefully, more robust switching between KD_GRAPHICS<->
  KD_TEXT.

  An added benefit coming from this change is that the MODESWITCHLATE hack
  is not needed anymore and thus removed.  This hack is used by savagefb,
  rivafb and nvidiafb.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c          |   41 ++++++++++++---------------------
 drivers/video/console/fbcon.h          |    1
 drivers/video/nvidia/nvidia.c          |    3 +-
 drivers/video/riva/fbdev.c             |    3 --
 drivers/video/savage/savagefb_driver.c |    3 --
 include/linux/fb.h                     |    4 ---
 6 files changed, 22 insertions(+), 33 deletions(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-03-12 23:24:05 +08:00
+++ b/drivers/video/console/fbcon.c	2005-03-10 06:29:05 +08:00
@@ -204,8 +204,10 @@
 
 static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
 {
+	struct fbcon_ops *ops = info->fbcon_par;
+
 	return (info->state != FBINFO_STATE_RUNNING ||
-		vc->vc_mode != KD_TEXT);
+		vc->vc_mode != KD_TEXT || ops->graphics);
 }
 
 static inline int get_color(struct vc_data *vc, struct fb_info *info,
@@ -596,6 +598,8 @@
 	if (info->fbops->fb_set_par)
 		info->fbops->fb_set_par(info);
 
+	ops->graphics = 0;
+
 	if (vc)
 		fbcon_set_disp(info, &info->var, vc);
 	else
@@ -763,6 +767,7 @@
 
 	memset(ops, 0, sizeof(struct fbcon_ops));
 	ops->currcon = -1;
+	ops->graphics = 1;
 	info->fbcon_par = ops;
 	set_blitting_type(vc, info, NULL);
 
@@ -949,6 +954,7 @@
 	if (CON_IS_VISIBLE(vc) && info->fbops->fb_set_par)
 		info->fbops->fb_set_par(info);
 
+	((struct fbcon_ops *) info->fbcon_par)->graphics = 0;
 
 	if ((cap & FBINFO_HWACCEL_COPYAREA) &&
 	    !(cap & FBINFO_HWACCEL_DISABLED))
@@ -1871,7 +1877,6 @@
 			var.activate = FB_ACTIVATE_NOW |
 				FB_ACTIVATE_FORCE;
 			fb_set_var(info, &var);
-			info->flags &= ~FBINFO_MISC_MODESWITCH;
 		}
 		var_to_display(p, &info->var, info);
 	}
@@ -1884,7 +1889,7 @@
 	struct fb_info *info;
 	struct display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var;
-	int i, prev_console, do_set_par = 0;
+	int i, prev_console;
 
 	info = registered_fb[con2fb_map[vc->vc_num]];
 
@@ -1943,14 +1948,9 @@
 	fb_set_var(info, &var);
 
 	if (prev_console != -1 &&
-	    registered_fb[con2fb_map[prev_console]] != info)
-		do_set_par = 1;
-
-	if (do_set_par || info->flags & FBINFO_MISC_MODESWITCH) {
-		if (info->fbops->fb_set_par)
-			info->fbops->fb_set_par(info);
-		info->flags &= ~FBINFO_MISC_MODESWITCH;
-	}
+	    registered_fb[con2fb_map[prev_console]] != info &&
+	    info->fbops->fb_set_par)
+		info->fbops->fb_set_par(info);
 
 	set_blitting_type(vc, info, p);
 	((struct fbcon_ops *)info->fbcon_par)->cursor_reset = 1;
@@ -2013,29 +2013,20 @@
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
-	int active = !fbcon_is_inactive(vc, info);
 
 	if (mode_switch) {
 		struct fb_var_screeninfo var = info->var;
-/*
- * HACK ALERT: Some hardware will require reinitializion at this stage,
- *             others will require it to be done as late as possible.
- *             For now, we differentiate this with the
- *             FBINFO_MISC_MODESWITCHLATE bitflag.  Worst case will be
- *             hardware that requires it here and another one later.
- *             A definitive solution may require fixing X or the VT
- *             system.
- */
-		if (info->flags & FBINFO_MISC_MODESWITCHLATE)
-			info->flags |= FBINFO_MISC_MODESWITCH;
 
-		if (!blank && !(info->flags & FBINFO_MISC_MODESWITCHLATE)) {
+		ops->graphics = 1;
+
+		if (!blank) {
 			var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE;
 			fb_set_var(info, &var);
+			ops->graphics = 0;
 		}
 	}
 
- 	if (active) {
+ 	if (!fbcon_is_inactive(vc, info)) {
 		if (ops->blank_state != blank) {
 			ops->blank_state = blank;
 			fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	2005-03-12 23:24:05 +08:00
+++ b/drivers/video/console/fbcon.h	2005-03-10 06:29:05 +08:00
@@ -67,6 +67,7 @@
 	int    cursor_flash;
 	int    cursor_reset;
 	int    blank_state;
+	int    graphics;
 	char  *cursor_data;
 };
     /*
diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c	2005-03-12 23:25:14 +08:00
+++ b/drivers/video/nvidia/nvidia.c	2005-03-10 06:29:05 +08:00
@@ -1191,6 +1191,7 @@
 			var->yres_virtual = var->yres;
 			var->xres_virtual = vramlen / var->yres_virtual;
 			var->xres_virtual /= var->bits_per_pixel / 8;
+			var->xres_virtual &= ~63;
 			pitch = (var->xres_virtual *
 				 var->bits_per_pixel + 7) / 8;
 			memlen = pitch * var->yres;
@@ -1301,7 +1302,7 @@
 	    | FBINFO_HWACCEL_IMAGEBLIT
 	    | FBINFO_HWACCEL_FILLRECT
 	    | FBINFO_HWACCEL_COPYAREA
-	    | FBINFO_HWACCEL_YPAN | FBINFO_MISC_MODESWITCHLATE;
+	    | FBINFO_HWACCEL_YPAN;
 
 	fb_videomode_to_modelist(info->monspecs.modedb,
 				 info->monspecs.modedb_len, &info->modelist);
diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	2005-03-12 23:25:16 +08:00
+++ b/drivers/video/riva/fbdev.c	2005-03-10 06:29:05 +08:00
@@ -1708,8 +1708,7 @@
 		    | FBINFO_HWACCEL_YPAN
 		    | FBINFO_HWACCEL_COPYAREA
 		    | FBINFO_HWACCEL_FILLRECT
-		    | FBINFO_HWACCEL_IMAGEBLIT
-	            | FBINFO_MISC_MODESWITCHLATE;
+	            | FBINFO_HWACCEL_IMAGEBLIT;
 
 	/* Accel seems to not work properly on NV30 yet...*/
 	if ((par->riva.Architecture == NV_ARCH_30) || noaccel) {
diff -Nru a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
--- a/drivers/video/savage/savagefb_driver.c	2005-03-12 23:25:26 +08:00
+++ b/drivers/video/savage/savagefb_driver.c	2005-03-10 06:29:05 +08:00
@@ -1883,8 +1883,7 @@
 	info->fbops          = &savagefb_ops;
 	info->flags          = FBINFO_DEFAULT |
 		               FBINFO_HWACCEL_YPAN |
-		               FBINFO_HWACCEL_XPAN |
-	                       FBINFO_MISC_MODESWITCHLATE;
+		               FBINFO_HWACCEL_XPAN;
 
 	info->pseudo_palette = par->pseudo_palette;
 
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	2005-03-13 00:38:53 +08:00
+++ b/include/linux/fb.h	2005-03-10 06:29:05 +08:00
@@ -702,9 +702,7 @@
 
 #define FBINFO_MISC_USEREVENT          0x10000 /* event request
 						  from userspace */
-#define FBINFO_MISC_MODESWITCH         0x20000 /* mode switch */
-#define FBINFO_MISC_MODESWITCHLATE     0x40000 /* init hardware later */
-#define FBINFO_MISC_TILEBLITTING       0x80000 /* use tile blitting */
+#define FBINFO_MISC_TILEBLITTING       0x20000 /* use tile blitting */
 
 struct fb_info {
 	int node;





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

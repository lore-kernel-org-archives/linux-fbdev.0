From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 6/7] fbdev: Introduce FB_BLANK_* constants
Date: Mon, 8 Nov 2004 05:29:44 +0800
Message-ID: <20041107213333.722CC11C606C@smtp-3.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQufa-00043A-Sm
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:33:54 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CQufX-00072o-Nq
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:33:54 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id CA62C11C5FF8
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  7 Nov 2004 21:33:36 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The VESA_* constants in fb.h used for power management of the display is
confusing to use. The constants seems to be meant for userspace, because
within the kernel (vt and fbdev), the constants have to be incremented by 1.
Implementation of fb_blank() varies from driver to driver:
- if-else on blank/!blank
- switch case on hardcoded numbers
- switch case on the constants + 1
- switch -1, case  on constants as is
- switch case on the constants as is (broken)

To make usage clearer, new constants are defined in fb.h:

FB_BLANK_UNBLANK  = VESA_UNBLANKING = 0;
FB_BLANK_NORMAL = VESA_UNBLANKING + 1 = 1;
FB_BLANK_VSYNC_SUSPEND = VESA_VSYNC_SUSPEND + 1 = 2;
FB_BLANK_HSYNC_SUSPEND = VESA_HSYNC_SUSPEND + 1 = 3;
FB_BLANK_POWERDOWN = VESA_POWERDOWN + 1 = 4;

Other changes:
- generic blanking code in fbcon.c (for drivers without an fb_blank hook) 
  which either sets the palette to all black, or clear the screen with black.
- make fb_display an unexportable symbol
 
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |   93 ++++++++++++++++++++++++++----------------
 drivers/video/fbmem.c         |    7 +--
 include/linux/fb.h            |   18 ++++++++
 3 files changed, 79 insertions(+), 39 deletions(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2004-11-07 21:37:05 +08:00
+++ b/drivers/video/console/fbcon.c	2004-11-07 19:56:58 +08:00
@@ -212,7 +212,7 @@
 	int depth = fb_get_color_depth(info);
 	int color = 0;
 
-	if (!info->fbops->fb_blank && console_blanked) {
+	if (console_blanked) {
 		unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 
 		c = vc->vc_video_erase_char & charmask;
@@ -229,7 +229,7 @@
 		int fg = (info->fix.visual != FB_VISUAL_MONO01) ? 1 : 0;
 		int bg = (info->fix.visual != FB_VISUAL_MONO01) ? 0 : 1;
 
-		if (!info->fbops->fb_blank && console_blanked)
+		if (console_blanked)
 			fg = bg;
 
 		color = (is_fg) ? fg : bg;
@@ -1993,17 +1993,52 @@
 	return 1;
 }
 
+static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
+				int blank)
+{
+	if (blank) {
+		if (info->fix.visual == FB_VISUAL_DIRECTCOLOR ||
+		    info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
+			struct fb_cmap cmap;
+			u16 *black;
+
+			black = kmalloc(sizeof(u16) * info->cmap.len,
+					GFP_KERNEL);
+			if (black) {
+				memset(black, 0, info->cmap.len * sizeof(u16));
+				cmap.red = cmap.green = cmap.blue = black;
+				cmap.transp = info->cmap.transp ? black : NULL;
+				cmap.start = info->cmap.start;
+				cmap.len = info->cmap.len;
+				fb_set_cmap(&cmap, info);
+			}
+
+			kfree(black);
+		} else {
+			unsigned short charmask = vc->vc_hi_font_mask ?
+				0x1ff : 0xff;
+			unsigned short oldc;
+
+			oldc = vc->vc_video_erase_char;
+			vc->vc_video_erase_char &= charmask;
+			fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
+			vc->vc_video_erase_char = oldc;
+		}
+	} else {
+		if (info->fix.visual == FB_VISUAL_DIRECTCOLOR ||
+		    info->fix.visual == FB_VISUAL_PSEUDOCOLOR)
+			fb_set_cmap(&info->cmap, info);
+	}
+}
+
 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 {
-	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
-	struct display *p = &fb_display[vc->vc_num];
-	int retval = 0;
+	int active = !fbcon_is_inactive(vc, info);
 
 	if (mode_switch) {
 		struct fb_var_screeninfo var = info->var;
-
 /*
  * HACK ALERT: Some hardware will require reinitializion at this stage,
  *             others will require it to be done as late as possible.
@@ -2020,36 +2055,25 @@
 			var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE;
 			fb_set_var(info, &var);
 		}
-
-		return 0;
 	}
 
-	fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
-	ops->cursor_flash = (!blank);
-
-	if (!info->fbops->fb_blank) {
-		if (blank) {
-			unsigned short oldc;
-			u_int height;
-			u_int y_break;
-
-			oldc = vc->vc_video_erase_char;
-			vc->vc_video_erase_char &= charmask;
-			height = vc->vc_rows;
-			y_break = p->vrows - p->yscroll;
-			if (height > y_break) {
-				fbcon_clear(vc, 0, 0, y_break, vc->vc_cols);
-				fbcon_clear(vc, y_break, 0, height - y_break,
-					    vc->vc_cols);
-			} else
-				fbcon_clear(vc, 0, 0, height, vc->vc_cols);
-			vc->vc_video_erase_char = oldc;
- 		} else if (!fbcon_is_inactive(vc, info))
-			update_screen(vc->vc_num);
-	} else if (vt_cons[vc->vc_num]->vc_mode == KD_TEXT)
- 		retval = info->fbops->fb_blank(blank, info);
-
-	return retval;
+ 	if (active) {
+ 		int ret = -1;
+ 
+ 		fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
+ 		ops->cursor_flash = (!blank);
+  
+ 		if (info->fbops->fb_blank)
+ 			ret = info->fbops->fb_blank(blank, info);
+ 
+ 		if (ret)
+ 			fbcon_generic_blank(vc, info, blank);
+ 
+ 		if (!blank)
+  			update_screen(vc->vc_num);
+ 	}
+ 
+ 	return 0;
 }
 
 static void fbcon_free_font(struct display *p)
@@ -2786,7 +2810,6 @@
  *  Visible symbols for modules
  */
 
-EXPORT_SYMBOL(fb_display);
 EXPORT_SYMBOL(fb_con);
 
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/fbmem.c	2004-11-07 19:54:52 +08:00
@@ -745,10 +745,9 @@
 {	
 	int err = -EINVAL;
 	
-	/* Workaround for broken X servers */
-	if (blank > VESA_POWERDOWN)
-		blank = VESA_POWERDOWN;
-
+ 	if (blank > FB_BLANK_POWERDOWN)
+ 		blank = FB_BLANK_POWERDOWN;
+ 
 	if (info->fbops->fb_blank)
  		err = info->fbops->fb_blank(blank, info);
 
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	2004-11-06 06:21:33 +08:00
+++ b/include/linux/fb.h	2004-11-06 17:49:49 +08:00
@@ -258,6 +258,24 @@
 #define VESA_HSYNC_SUSPEND      2
 #define VESA_POWERDOWN          3
 
+
+enum {
+	/* screen: unblanked, hsync: on,  vsync: on */
+	FB_BLANK_UNBLANK       = VESA_NO_BLANKING,
+
+	/* screen: blanked,   hsync: on,  vsync: on */
+	FB_BLANK_NORMAL        = VESA_NO_BLANKING + 1,
+
+	/* screen: blanked,   hsync: on,  vsync: off */
+	FB_BLANK_VSYNC_SUSPEND = VESA_VSYNC_SUSPEND + 1,
+
+	/* screen: blanked,   hsync: off, vsync: on */
+	FB_BLANK_HSYNC_SUSPEND = VESA_HSYNC_SUSPEND + 1,
+
+	/* screen: blanked,   hsync: off, vsync: off */
+	FB_BLANK_POWERDOWN     = VESA_POWERDOWN + 1
+};
+
 #define FB_VBLANK_VBLANKING	0x001	/* currently in a vertical blank */
 #define FB_VBLANK_HBLANKING	0x002	/* currently in a horizontal blank */
 #define FB_VBLANK_HAVE_VBLANK	0x004	/* vertical blanks can be detected */






-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click

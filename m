From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/8] fbcon: Do not touch hardware if vc_mode != KD_TEXT
Date: Wed, 3 Nov 2004 10:30:10 +0800
Message-ID: <200411031030.11430.adaplas@hotpop.com>
References: <200411021946.06302.adaplas@hotpop.com> <1099434421.20294.19.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPB1Q-00040s-A1
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 18:37:16 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPB1O-0001FQ-KX
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 18:37:16 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6EE97941F20
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  3 Nov 2004 02:37:06 +0000 (UTC)
In-Reply-To: <1099434421.20294.19.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wednesday 03 November 2004 06:27, Benjamin Herrenschmidt wrote:
> On Tue, 2004-11-02 at 19:46 +0800, Antonino A. Daplas wrote:
>
> Since the exact same thing must be done if the fbdev are "asleep", can't
> we just have a kind of inline helper fbcon_useable() that does both test
> and make sure every place is properly dealt with ?
>

Hi Ben, Andrew,

Sigh, this patch uncovered a can of worms.  I tested different combinations,
those with/without xxxfb_blank implementation, framebuffers in directcolor
or truecolor, etc. I find that there is a problem unblanking if the hardware
has no xxxfb_blank() implementation, and also that the generic fb_blank() in
fbmem.c is problematic with drivers in directcolor or pseudocolor mode when
called by an fb application such as X.

Display blanking is implemented in three ways:

    1. using the drivers blanking implementation - info->fbops->fb_blank()
    2. clearing the screen with the console erase character - fbcon_blank()
    3. setting the color map to all black - fb_blank()

The third method is problematic for these reasons:

    - Setting the colormap to all black will not work in truecolor mode
    - In directcolor or pseudocolor, it will overwrite the fb application's
      color map, producing wrong colors.

So, remove the generic implementation in fb_blank() and just return -EINVAL
if there is no hardware implementation.  This will be only used by apps doing
an FBIO_BLANK ioctl, and is a more robust approach.

Other changes:

- Consolidated all tests and created an inlined helper function to check if
  the framebuffer console is inactive or not.
- fix unblanking if driver has no xxxfb_blank() hook.

I'm probably missing a few more things, but this patch should be generally
correct. Please apply after the entire patch series to avoid rejects.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 console/fbcon.c |   63 +++++++++++++++++++++++---------------------------------
 fbmem.c         |   25 ++--------------------
 2 files changed, 29 insertions(+), 59 deletions(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2004-11-01 13:45:03 +08:00
+++ b/drivers/video/console/fbcon.c	2004-11-03 10:19:37 +08:00
@@ -200,6 +200,13 @@
 }
 #endif
 
+static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
+{
+	return (info->state != FBINFO_STATE_RUNNING ||
+		vt_cons[vc->vc_num]->vc_mode != KD_TEXT ||
+		(console_blanked && info->fbops->fb_blank));
+}
+
 static inline int get_color(struct vc_data *vc, struct fb_info *info,
 	      u16 c, int is_fg)
 {
@@ -252,9 +259,8 @@
 	if (ops->currcon != -1)
 		vc = vc_cons[ops->currcon].d;
 
-	if (info->state != FBINFO_STATE_RUNNING ||
-	    !vc || !CON_IS_VISIBLE(vc) ||
-	    vt_cons[vc->vc_num]->vc_mode != KD_TEXT ||
+	if (!vc || !CON_IS_VISIBLE(vc) ||
+	    fbcon_is_inactive(vc, info) ||
  	    registered_fb[con2fb_map[vc->vc_num]] != info)
 		return;
 	acquire_console_sem();
@@ -988,12 +994,7 @@
 	struct display *p = &fb_display[vc->vc_num];
 	u_int y_break;
 
-	if (!info->fbops->fb_blank && console_blanked)
-		return;
-	if (info->state != FBINFO_STATE_RUNNING)
-		return;
-
-	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
+	if (fbcon_is_inactive(vc, info))
 		return;
 
 	if (!height || !width)
@@ -1018,18 +1019,10 @@
 	struct display *p = &fb_display[vc->vc_num];
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	if (!info->fbops->fb_blank && console_blanked)
-		return;
-
-	if (info->state != FBINFO_STATE_RUNNING)
-		return;
-
-	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
-		return;
-
-	ops->putcs(vc, info, s, count, real_y(p, ypos), xpos,
-		   get_color(vc, info, scr_readw(s), 1),
-		   get_color(vc, info, scr_readw(s), 0));
+	if (!fbcon_is_inactive(vc, info))
+		ops->putcs(vc, info, s, count, real_y(p, ypos), xpos,
+			   get_color(vc, info, scr_readw(s), 1),
+			   get_color(vc, info, scr_readw(s), 0));
 }
 
 static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
@@ -1045,7 +1038,8 @@
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	ops->clear_margins(vc, info, bottom_only);
+	if (!fbcon_is_inactive(vc, info))
+		ops->clear_margins(vc, info, bottom_only);
 }
 
 static void fbcon_cursor(struct vc_data *vc, int mode)
@@ -1056,7 +1050,7 @@
 	int y = real_y(p, vc->vc_y);
  	int c = scr_readw((u16 *) vc->vc_pos);
 
-	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
+	if (fbcon_is_inactive(vc, info))
 		return;
 
 	ops->cursor_flash = 1;
@@ -1511,11 +1505,8 @@
 	struct fbcon_ops *ops = info->fbcon_par;
 	int scroll_partial = info->flags & FBINFO_PARTIAL_PAN_OK;
 
-	if (!info->fbops->fb_blank && console_blanked)
-		return 0;
-
-	if (!count || vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
-		return 0;
+	if (fbcon_is_inactive(vc, info))
+		return -EINVAL;
 
 	fbcon_cursor(vc, CM_ERASE);
 
@@ -1704,12 +1695,9 @@
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 	
-	if (!info->fbops->fb_blank && console_blanked)
+	if (fbcon_is_inactive(vc, info))
 		return;
-
-	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
-		return;
-
+	    
 	if (!width || !height)
 		return;
 
@@ -1999,8 +1987,8 @@
 		return 0;
 	}
 
-	ops->cursor_flash = (!blank);
 	fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
+	ops->cursor_flash = (!blank);
 
 	if (!info->fbops->fb_blank) {
 		if (blank) {
@@ -2019,10 +2007,10 @@
 			} else
 				fbcon_clear(vc, 0, 0, height, vc->vc_cols);
 			vc->vc_video_erase_char = oldc;
-		} else
+ 		} else if (!fbcon_is_inactive(vc, info))
 			update_screen(vc->vc_num);
 	} else if (vt_cons[vc->vc_num]->vc_mode == KD_TEXT)
-		retval = fb_blank(info, blank);
+ 		retval = info->fbops->fb_blank(blank, info);
 
 	return retval;
 }
@@ -2328,8 +2316,9 @@
 	int i, j, k, depth;
 	u8 val;
 
-	if (!info->fbops->fb_blank && console_blanked)
+	if (fbcon_is_inactive(vc, info))
 		return -EINVAL;
+
 	depth = fb_get_color_depth(info);
 	if (depth > 3) {
 		for (i = j = 0; i < 16; i++) {
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2004-10-27 14:58:07 +08:00
+++ b/drivers/video/fbmem.c	2004-11-03 10:04:59 +08:00
@@ -743,29 +743,10 @@
 int
 fb_blank(struct fb_info *info, int blank)
 {	
-	/* ??? Variable sized stack allocation.  */
-	struct fb_cmap cmap;
-	u16 *black = NULL;
-	int err = 0;
+	int err = -EINVAL;
 	
-	if (info->fbops->fb_blank && !info->fbops->fb_blank(blank, info))
-		return 0;
-
-	cmap = info->cmap;
-
-	if (blank) { 
-		black = kmalloc(sizeof(u16) * info->cmap.len, GFP_KERNEL);
-		if (black) {
-			memset(black, 0, info->cmap.len * sizeof(u16));
-			cmap.red = cmap.green = cmap.blue = black;
-			cmap.transp = info->cmap.transp ? black : NULL;
-			cmap.start = info->cmap.start;
-			cmap.len = info->cmap.len;
-		}
-	}
-
-	err = fb_set_cmap(&cmap, info);
-	kfree(black);
+	if (info->fbops->fb_blank)
+		err = info->fbops->fb_blank(blank, info);
 
 	return err;
 }





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click

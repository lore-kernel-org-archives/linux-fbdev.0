From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/3][FBCON]: Refinements for fbcon
Date: Tue, 6 Jul 2004 06:34:31 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407060634.31419.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bhc2N-0005U5-UG
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 15:34:11 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bhc2N-0002Ek-C2
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 15:34:11 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id BB8F570B3B
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  5 Jul 2004 21:28:13 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>, jsimmons@pentafluge.infradead.org
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

1.  From Petr Vandrovec <vandrove@vc.cvut.cz>.

Begin quote
  	yesterday I finally found why 2.6.x has problems with taking over vgacon.
	Problem is that take_over_console does:


  	if (IS_VISIBLE)
    	save_screen(i);
  	...
  	visual_init(i, 0);
  	...

	so code nicely saves screen contents, and calls visual_init, which calls 	
	fbcon's init, which in turn can issue vc_resize. And this vc_resize will
	trigger read from vc->vc_origin. But vc_origin still points to videomemory,
	not to the buffer where save_screen() copied its data.
End quote

So updating vc->vc_origin to point to screenbuf after the previous console deinitializes
allows fbcon to correctly update the screen from the screen buffer.  This change makes the
clearing of vram (using fillrect) unnecessary.

2. If FBINFO_MISC_MODESWITCH flag is set in info, do the set_par() in fbcon_switch()
instead of piggy-backing the set_par() on fbcon_resize().  This preserves the current var,
skipping the unnecessary fb_find_mode() step.


Signed-off-by: Antonino Daplas <adaplas@pol.net>

diff -Naur linux-2.6.7-mm6-orig/drivers/char/vt.c linux-2.6.7-mm6/drivers/char/vt.c
--- linux-2.6.7-mm6-orig/drivers/char/vt.c	2004-07-05 13:29:51.045194880 +0000
+++ linux-2.6.7-mm6/drivers/char/vt.c	2004-07-05 13:30:37.615115176 +0000
@@ -2711,6 +2711,10 @@
 			save_screen(i);
 		old_was_color = vc_cons[i].d->vc_can_do_color;
 		vc_cons[i].d->vc_sw->con_deinit(vc_cons[i].d);
+		origin = (unsigned long) screenbuf;
+		visible_origin = origin;
+		scr_end = origin + screenbuf_size;
+		pos = origin + video_size_row*y + 2*x;
 		visual_init(i, 0);
 		update_attr(i);
 
diff -Naur linux-2.6.7-mm6-orig/drivers/video/console/fbcon.c linux-2.6.7-mm6/drivers/video/console/fbcon.c
--- linux-2.6.7-mm6-orig/drivers/video/console/fbcon.c	2004-07-05 13:30:09.068454928 +0000
+++ linux-2.6.7-mm6/drivers/video/console/fbcon.c	2004-07-05 13:30:48.084523584 +0000
@@ -815,14 +815,14 @@
 				vc->vc_pos += logo_lines * vc->vc_size_row;
 			}
 		}
-		if (CON_IS_VISIBLE(vc) && vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
-			accel_clear_margins(vc, info, 0);
-			update_screen(vc->vc_num);
-		}
 		scr_memsetw((unsigned short *) vc->vc_origin,
 			    vc->vc_video_erase_char,
 			    vc->vc_size_row * logo_lines);
 
+		if (CON_IS_VISIBLE(vc) && vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
+			accel_clear_margins(vc, info, 0);
+			update_screen(vc->vc_num);
+		}
 		if (save) {
 			q = (unsigned short *) (vc->vc_origin +
 						vc->vc_size_row *
@@ -1698,14 +1698,10 @@
 	var.yres = height * fh;
 	x_diff = info->var.xres - var.xres;
 	y_diff = info->var.yres - var.yres;
-	if (x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh) ||
-	    (info->flags & FBINFO_MISC_MODESWITCH)) {
+	if (x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh)) {
 		char mode[40];
 
 		DPRINTK("attempting resize %ix%i\n", var.xres, var.yres);
-		if (!info->fbops->fb_set_par)
-			return -EINVAL;
-
 		snprintf(mode, 40, "%ix%i", var.xres, var.yres);
 		err = fb_find_mode(&var, info, mode, info->monspecs.modedb,
 				   info->monspecs.modedb_len, NULL,
@@ -1714,12 +1710,11 @@
 			return -EINVAL;
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 		if (CON_IS_VISIBLE(vc)) {
-			var.activate = FB_ACTIVATE_NOW |
-				(info->flags & FBINFO_MISC_MODESWITCH) ?
-				FB_ACTIVATE_FORCE : 0;
+			var.activate = FB_ACTIVATE_NOW | 
+				FB_ACTIVATE_FORCE;
 			fb_set_var(info, &var);
+			info->flags &= ~FBINFO_MISC_MODESWITCH;
 		}
-		info->flags &= ~FBINFO_MISC_MODESWITCH;
 	}
 	updatescrollmode(p, info, vc);
 	return 0;
@@ -1771,6 +1766,13 @@
 	}
 
  	fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
+
+	if (info->flags & FBINFO_MISC_MODESWITCH) {
+		if (info->fbops->fb_set_par)
+			info->fbops->fb_set_par(info);
+		info->flags &= ~FBINFO_MISC_MODESWITCH;
+	}
+
 	switch (p->scrollmode) {
 	case SCROLL_WRAP:
 		scrollback_phys_max = p->vrows - vc->vc_rows;
@@ -1793,16 +1795,6 @@
 	if (vt_cons[vc->vc_num]->vc_mode == KD_TEXT)
 		accel_clear_margins(vc, info, 0);
 	if (logo_shown == -2) {
-		struct fb_fillrect rect;
-		int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-
-		rect.color = attr_bgcol_ec(bgshift, vc);
-		rect.rop = ROP_COPY;
-		rect.dx = rect.dy = 0;
-		rect.width = info->var.xres;
-		rect.height = logo_lines * vc->vc_font.height;
-		info->fbops->fb_fillrect(info, &rect);
-
 		logo_shown = fg_console;
 		/* This is protected above by initmem_freed */
 		fb_show_logo(info);




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

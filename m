From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: 2.6.7 still garbage upon start
Date: Sat, 19 Jun 2004 02:40:31 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406190240.31144.adaplas@hotpop.com>
References: <40D21E31.5070904@winischhofer.net> <40D2E96A.9000605@undead.cc> <Pine.GSO.4.58.0406181516460.11779@waterleaf.sonytel.be>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fcz0Aq4x1tkzTqw"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbOHx-0001zB-D4
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 11:40:33 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BbOHw-0003DN-Bb
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 11:40:32 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id C50BD618B46
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Jun 2004 18:01:52 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0406181516460.11779@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Geert Uytterhoeven <geert@linux-m68k.org>, John Zielinski <grim@undead.cc>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


--Boundary-00=_fcz0Aq4x1tkzTqw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 18 June 2004 21:18, Geert Uytterhoeven wrote:
> On Fri, 18 Jun 2004, John Zielinski wrote:
> > Geert Uytterhoeven wrote:
> > >Solution: before initializing and switching to a fbdev, save the
> > > contents of the VGA text memory to the `shadow screen', so the fbdev
> > > can clear the frame buffer memory, and fbcon can recover the current VC
> > > contents.
> > >
> > >However, it makes things more complex and adds a vgacon dependency to
> > > some code, since you want it to behave differently if people don't
> > > compile in vgacon.
> >
> > That was the old solution.  I found the root cause of the problem.
> > There is no code in the vt subsystem to prevent output going to a
> > console driver after it has been deinitialized.  The vga console does
> > save the VGA memory to it's shadow screen when it's deinitialized but
> > any printk's after that screw things up as it starts to output again to
> > the screen.  Now the shadow screen and the real screen doesn't match
> > anymore.
>
> Hence vgacon should be replaced by dummycon when it's deinitialized.
>

Actually, to eliminate the white rectangle, we just need to initialize fbdev 
_after_ vgacon.  Currently, there is a set_par call in fbcon_startup()) which is
 called prior to vgacon_deinit.  

1. Solution: Move this set_par call to fbcon_init instead.

If the boot logo is not enabled, then everything is okay.  With the boot logo
enabled, you will see remnants of old text (not garbage) in the space 
provided for the logo.  

2. Solution:  Issue a fillrect to remove the remnants.

Finally, the current steps for making space for the logo is like this:

1. allocate save memory
2. save screen
3. clear space for boot logo in screen
4. redraw saved screen at origin + logo_height

The problem is between 3 and 4.  During 'redraw saved screen', vgacon 
copies contents from shadow screen to actual screen, so the cleared space
we created in step 4 is redrawn again.

3. Solution: Reverse steps 3 and 4.

I've include a patch that incorporates all of the above.  (It also has some fixes
for problems with creation of logo space -- the code does not consider that the
new VC window size is different or even smaller than the old VC window size).
Please test, and if it works for you, I'll push it upstream.

Diffs are against 2.6.7 and 2.6.7-rc3-mm2.

Tony


--Boundary-00=_fcz0Aq4x1tkzTqw
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="screen-2.6.7.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="screen-2.6.7.diff"

diff -Naur linux-2.6.7-orig/drivers/video/console/fbcon.c linux-2.6.7/drivers/video/console/fbcon.c
--- linux-2.6.7-orig/drivers/video/console/fbcon.c	2004-06-18 17:41:19.161273824 +0000
+++ linux-2.6.7/drivers/video/console/fbcon.c	2004-06-18 17:42:02.253722776 +0000
@@ -503,13 +503,6 @@
 		vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
 	}
 
-	/*
-	 * We must always set the mode. The mode of the previous console
-	 * driver could be in the same resolution but we are using different
-	 * hardware so we have to initialize the hardware.
-	 */
-	if (info->fbops->fb_set_par)
-		info->fbops->fb_set_par(info);
 	cols = info->var.xres/vc->vc_font.width;
 	rows = info->var.yres/vc->vc_font.height;
 	vc_resize(vc->vc_num, cols, rows);
@@ -599,13 +592,24 @@
 	struct vc_data **default_mode = vc->vc_display_fg;
 	struct display *t, *p = &fb_display[vc->vc_num];
 	int display_fg = (*default_mode)->vc_num;
-	int logo = 1, rows, cols, charcnt = 256;
+	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
 	unsigned short *save = NULL, *r, *q;
 
 	if (vc->vc_num != display_fg || (info->flags & FBINFO_FLAG_MODULE) ||
 	    (info->fix.type == FB_TYPE_TEXT))
 		logo = 0;
 
+	/*
+	 * We must always set the mode. The mode of the previous console
+	 * driver could be in the same resolution but we are using different
+	 * hardware so we have to initialize the hardware.
+	 * 
+	 * We need to do it in fbcon_init() to prevent screen corruption.
+	 */
+	if (CON_IS_VISIBLE(vc))
+		if (info->fbops->fb_set_par)
+			info->fbops->fb_set_par(info);
+	
 	info->var.xoffset = info->var.yoffset = p->yscroll = 0;	/* reset wrap/pan */
 
 	/* If we are not the first console on this
@@ -631,9 +635,11 @@
 			vc->vc_complement_mask <<= 1;
 	}
 
-	cols = info->var.xres / vc->vc_font.width;
-	rows = info->var.yres / vc->vc_font.height;
-	vc_resize(vc->vc_num, cols, rows);
+	cols = vc->vc_cols;
+	rows = vc->vc_rows;
+	new_cols = info->var.xres / vc->vc_font.width;
+	new_rows = info->var.yres / vc->vc_font.height;
+	vc_resize(vc->vc_num, new_cols, new_rows);
 
 	if (info->var.accel_flags)
 		p->scrollmode = SCROLL_YNOMOVE;
@@ -645,9 +651,9 @@
 	 *  vc_{cols,rows}, but we must not set those if we are only
 	 *  resizing the console.
 	 */
-	if (init) {
-		vc->vc_cols = cols;
-		vc->vc_rows = rows;
+	if (!init) {
+		vc->vc_cols = new_cols;
+		vc->vc_rows = new_rows;
 	}
 
 	if (logo) {
@@ -664,14 +670,15 @@
 		for (r = q - logo_lines * cols; r < q; r++)
 			if (scr_readw(r) != vc->vc_video_erase_char)
 				break;
-		if (r != q && rows >= rows + logo_lines) {
-			save = kmalloc(logo_lines * cols * 2, GFP_KERNEL);
+		if (r != q && new_rows >= rows + logo_lines) {
+			save = kmalloc(logo_lines * new_cols * 2, GFP_KERNEL);
 			if (save) {
+				int i = cols < new_cols ? cols : new_cols;
 				scr_memsetw(save, vc->vc_video_erase_char,
-					    logo_lines * cols * 2);
+					    logo_lines * new_cols * 2);
 				r = q - step;
-				for (cnt = 0; cnt < logo_lines; cnt++, r += cols)
-					scr_memcpyw(save + cnt * cols, r, 2 * cols);
+				for (cnt = 0; cnt < logo_lines; cnt++, r += i)
+					scr_memcpyw(save + cnt * new_cols, r, 2 * i);
 				r = q;
 			}
 		}
@@ -687,19 +694,19 @@
 				vc->vc_pos += logo_lines * vc->vc_size_row;
 			}
 		}
-		scr_memsetw((unsigned short *) vc->vc_origin,
-			    vc->vc_video_erase_char,
-			    vc->vc_size_row * logo_lines);
-
 		if (CON_IS_VISIBLE(vc) && vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
 			accel_clear_margins(vc, info, 0);
 			update_screen(vc->vc_num);
 		}
+		scr_memsetw((unsigned short *) vc->vc_origin,
+			    vc->vc_video_erase_char,
+			    vc->vc_size_row * logo_lines);
+
 		if (save) {
 			q = (unsigned short *) (vc->vc_origin +
 						vc->vc_size_row *
 						rows);
-			scr_memcpyw(q, save, logo_lines * cols * 2);
+			scr_memcpyw(q, save, logo_lines * new_cols * 2);
 			vc->vc_y += logo_lines;
 			vc->vc_pos += logo_lines * vc->vc_size_row;
 			kfree(save);
diff -Naur linux-2.6.7-orig/drivers/video/fbmem.c linux-2.6.7/drivers/video/fbmem.c
--- linux-2.6.7-orig/drivers/video/fbmem.c	2004-06-18 17:40:59.894202864 +0000
+++ linux-2.6.7/drivers/video/fbmem.c	2004-06-18 17:41:52.812158112 +0000
@@ -717,6 +717,7 @@
 	u32 *palette = NULL, *saved_pseudo_palette = NULL;
 	unsigned char *logo_new = NULL;
 	struct fb_image image;
+	struct fb_fillrect rect;
 	int x;
 
 	/* Return if the frame buffer is not mapped or suspended */
@@ -762,6 +763,12 @@
 	image.height = fb_logo.logo->height;
 	image.dy = 0;
 
+	rect.dx = 0;
+	rect.dy = 0;
+	rect.color = 0;
+	rect.width = info->var.xres;
+	rect.height = fb_logo.logo->height;
+	info->fbops->fb_fillrect(info, &rect);
 	for (x = 0; x < num_online_cpus() * (fb_logo.logo->width + 8) &&
 	     x <= info->var.xres-fb_logo.logo->width; x += (fb_logo.logo->width + 8)) {
 		image.dx = x;

--Boundary-00=_fcz0Aq4x1tkzTqw
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="screen-2.6.7-rc3-mm2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="screen-2.6.7-rc3-mm2.diff"

diff -Naur linux-2.6.7-rc3-mm2-orig/drivers/video/console/fbcon.c linux-2.6.7-rc3-mm2/drivers/video/console/fbcon.c
--- linux-2.6.7-rc3-mm2-orig/drivers/video/console/fbcon.c	2004-06-18 17:47:06.374489392 +0000
+++ linux-2.6.7-rc3-mm2/drivers/video/console/fbcon.c	2004-06-18 17:50:24.310398560 +0000
@@ -503,13 +503,6 @@
 		vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
 	}
 
-	/*
-	 * We must always set the mode. The mode of the previous console
-	 * driver could be in the same resolution but we are using different
-	 * hardware so we have to initialize the hardware.
-	 */
-	if (info->fbops->fb_set_par)
-		info->fbops->fb_set_par(info);
 	cols = info->var.xres/vc->vc_font.width;
 	rows = info->var.yres/vc->vc_font.height;
 	vc_resize(vc->vc_num, cols, rows);
@@ -599,7 +592,7 @@
 	struct vc_data **default_mode = vc->vc_display_fg;
 	struct display *t, *p = &fb_display[vc->vc_num];
 	int display_fg = (*default_mode)->vc_num;
-	int logo = 1, rows, cols, charcnt = 256;
+	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
 	unsigned short *save = NULL, *r, *q;
 	int cap = info->flags;
 
@@ -607,6 +600,17 @@
 	    (info->fix.type == FB_TYPE_TEXT))
 		logo = 0;
 
+	/*
+	 * We must always set the mode. The mode of the previous console
+	 * driver could be in the same resolution but we are using different
+	 * hardware so we have to initialize the hardware.
+	 * 
+	 * We need to do it in fbcon_init() to prevent screen corruption.
+	 */
+	if (CON_IS_VISIBLE(vc))
+		if (info->fbops->fb_set_par)
+			info->fbops->fb_set_par(info);
+	
 	info->var.xoffset = info->var.yoffset = p->yscroll = 0;	/* reset wrap/pan */
 
 	/* If we are not the first console on this
@@ -632,9 +636,11 @@
 			vc->vc_complement_mask <<= 1;
 	}
 
-	cols = info->var.xres / vc->vc_font.width;
-	rows = info->var.yres / vc->vc_font.height;
-	vc_resize(vc->vc_num, cols, rows);
+	cols = vc->vc_cols;
+	rows = vc->vc_rows;
+	new_cols = info->var.xres / vc->vc_font.width;
+	new_rows = info->var.yres / vc->vc_font.height;
+	vc_resize(vc->vc_num, new_cols, new_rows);
 
 	if ((cap & FBINFO_HWACCEL_COPYAREA) && !(cap & FBINFO_HWACCEL_DISABLED))
 		p->scrollmode = SCROLL_ACCEL;
@@ -646,9 +652,9 @@
 	 *  vc_{cols,rows}, but we must not set those if we are only
 	 *  resizing the console.
 	 */
-	if (init) {
-		vc->vc_cols = cols;
-		vc->vc_rows = rows;
+	if (!init) {
+		vc->vc_cols = new_cols;
+		vc->vc_rows = new_rows;
 	}
 
 	if (logo) {
@@ -665,14 +671,15 @@
 		for (r = q - logo_lines * cols; r < q; r++)
 			if (scr_readw(r) != vc->vc_video_erase_char)
 				break;
-		if (r != q && rows >= rows + logo_lines) {
-			save = kmalloc(logo_lines * cols * 2, GFP_KERNEL);
+		if (r != q && new_rows >= rows + logo_lines) {
+			save = kmalloc(logo_lines * new_cols * 2, GFP_KERNEL);
 			if (save) {
+				int i = cols < new_cols ? cols : new_cols;
 				scr_memsetw(save, vc->vc_video_erase_char,
-					    logo_lines * cols * 2);
+					    logo_lines * new_cols * 2);
 				r = q - step;
-				for (cnt = 0; cnt < logo_lines; cnt++, r += cols)
-					scr_memcpyw(save + cnt * cols, r, 2 * cols);
+				for (cnt = 0; cnt < logo_lines; cnt++, r += i)
+					scr_memcpyw(save + cnt * new_cols, r, 2 * i);
 				r = q;
 			}
 		}
@@ -688,19 +695,19 @@
 				vc->vc_pos += logo_lines * vc->vc_size_row;
 			}
 		}
-		scr_memsetw((unsigned short *) vc->vc_origin,
-			    vc->vc_video_erase_char,
-			    vc->vc_size_row * logo_lines);
-
 		if (CON_IS_VISIBLE(vc) && vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
 			accel_clear_margins(vc, info, 0);
 			update_screen(vc->vc_num);
 		}
+		scr_memsetw((unsigned short *) vc->vc_origin,
+			    vc->vc_video_erase_char,
+			    vc->vc_size_row * logo_lines);
+
 		if (save) {
 			q = (unsigned short *) (vc->vc_origin +
 						vc->vc_size_row *
 						rows);
-			scr_memcpyw(q, save, logo_lines * cols * 2);
+			scr_memcpyw(q, save, logo_lines * new_cols * 2);
 			vc->vc_y += logo_lines;
 			vc->vc_pos += logo_lines * vc->vc_size_row;
 			kfree(save);
diff -Naur linux-2.6.7-rc3-mm2-orig/drivers/video/fbmem.c linux-2.6.7-rc3-mm2/drivers/video/fbmem.c
--- linux-2.6.7-rc3-mm2-orig/drivers/video/fbmem.c	2004-06-18 17:46:47.927293792 +0000
+++ linux-2.6.7-rc3-mm2/drivers/video/fbmem.c	2004-06-18 17:51:14.754729856 +0000
@@ -717,6 +717,7 @@
 	u32 *palette = NULL, *saved_pseudo_palette = NULL;
 	unsigned char *logo_new = NULL;
 	struct fb_image image;
+	struct fb_fillrect rect;
 	int x;
 
 	/* Return if the frame buffer is not mapped or suspended */
@@ -762,6 +763,12 @@
 	image.height = fb_logo.logo->height;
 	image.dy = 0;
 
+	rect.dx = 0;
+	rect.dy = 0;
+	rect.color = 0;
+	rect.width = info->var.xres;
+	rect.height = fb_logo.logo->height;
+	info->fbops->fb_fillrect(info, &rect);
 	for (x = 0; x < num_online_cpus() * (fb_logo.logo->width + 8) &&
 	     x <= info->var.xres-fb_logo.logo->width; x += (fb_logo.logo->width + 8)) {
 		image.dx = x;

--Boundary-00=_fcz0Aq4x1tkzTqw--




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND

From: James Simmons <jsimmons@infradead.org>
Subject: Mode switching fix.
Date: Fri, 14 May 2004 19:21:29 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405141908410.25927-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOhJO-0008P0-Vm
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 11:21:34 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BOhJN-0001il-4f
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 11:21:33 -0700
Received: from localhost ([127.0.0.1])
	by phoenix.infradead.org with esmtp (Exim 4.30 #5 (Red Hat Linux))
	id 1BOhJK-000772-Em
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 May 2004 19:21:30 +0100
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi folks. Here is a patch that fixes the mode switching via stty. Note 
stty has a bug in it which I have to submit to the GNU foundation. Does 
any one no how to submit it to? Well here is the patch.

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/char/vt.c fbdev-2.6/drivers/char/vt.c
--- linus-2.6/drivers/char/vt.c	2004-05-13 21:06:17.000000000 -0700
+++ fbdev-2.6/drivers/char/vt.c	2004-05-08 11:40:38.000000000 -0700
@@ -773,17 +773,17 @@
 	old_row_size = video_size_row;
 	old_screen_size = screenbuf_size;
 
-	video_num_lines = new_rows;
-	video_num_columns = new_cols;
-	video_size_row = new_row_size;
-	screenbuf_size = new_screen_size;
-
 	err = resize_screen(currcons, new_cols, new_rows);
 	if (err) {
 		kfree(newscreen);
 		return err;
-	}
+	}	
 
+	video_num_lines = new_rows;
+	video_num_columns = new_cols;
+	video_size_row = new_row_size;
+	screenbuf_size = new_screen_size;
+	
 	rlth = min(old_row_size, new_row_size);
 	rrem = new_row_size - rlth;
 	old_origin = origin;
@@ -808,8 +808,6 @@
 	screenbuf = newscreen;
 	kmalloced = 1;
 	screenbuf_size = new_screen_size;
-	if (IS_VISIBLE)
-		err = resize_screen(currcons, new_cols, new_rows);
 	set_origin(currcons);
 
 	/* do part of a reset_terminal() */
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/aty/atyfb_base.c fbdev-2.6/drivers/video/aty/atyfb_base.c
--- linus-2.6/drivers/video/aty/atyfb_base.c	2004-05-13 21:07:30.000000000 -0700
+++ fbdev-2.6/drivers/video/aty/atyfb_base.c	2004-05-13 21:21:25.000000000 -0700
@@ -1231,10 +1231,7 @@
 
 	for (i = 0; i < FB_MAX; i++) {
 		info = registered_fb[i];
-		if (info &&
-		    info->fbops == &atyfb_ops &&
-		    info->display_fg &&
-		    info->display_fg->vc_num == i) {
+		if (info && info->fbops == &atyfb_ops) {
 			par = (struct atyfb_par *) info->par;
 			
 			atyfb_save_palette(par, enter);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/aty/radeon_base.c fbdev-2.6/drivers/video/aty/radeon_base.c
--- linus-2.6/drivers/video/aty/radeon_base.c	2004-05-13 21:07:30.000000000 -0700
+++ fbdev-2.6/drivers/video/aty/radeon_base.c	2004-05-13 21:21:37.000000000 -0700
@@ -1783,7 +1783,6 @@
 	info->pseudo_palette = rinfo->pseudo_palette;
         info->flags = FBINFO_FLAG_DEFAULT;
         info->fbops = &radeonfb_ops;
-        info->display_fg = NULL;
         info->screen_base = (char *)rinfo->fb_base;
 
 	/* Fill fix common fields */
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/console/fbcon.c fbdev-2.6/drivers/video/console/fbcon.c
--- linus-2.6/drivers/video/console/fbcon.c	2004-05-13 21:07:30.000000000 -0700
+++ fbdev-2.6/drivers/video/console/fbcon.c	2004-05-13 03:38:45.000000000 -0700
@@ -115,6 +115,8 @@
 static int first_fb_vc;
 static int last_fb_vc = MAX_NR_CONSOLES - 1;
 static int fbcon_is_default = 1; 
+/* font data */
+static char fontname[40];
 
 #define REFCOUNT(fd)	(((int *)(fd))[-1])
 #define FNTSIZE(fd)	(((int *)(fd))[-2])
@@ -168,9 +170,7 @@
 /*
  *  Internal routines
  */
-static void fbcon_set_display(struct vc_data *vc, int init, int logo);
 static __inline__ int real_y(struct display *p, int ypos);
-static __inline__ void updatescrollmode(struct display *p, struct vc_data *vc);
 static __inline__ void ywrap_up(struct vc_data *vc, int count);
 static __inline__ void ywrap_down(struct vc_data *vc, int count);
 static __inline__ void ypan_up(struct vc_data *vc, int count);
@@ -233,18 +233,15 @@
 
 int __init fb_console_setup(char *this_opt)
 {
-	int unit, i, j;
 	char *options;
-
+	int i, j;
+	
 	if (!this_opt || !*this_opt)
 		return 0;
 
 	while ((options = strsep(&this_opt, ",")) != NULL) {
-		if (!strncmp(options, "font:", 5)) {
-			for (unit = 0; unit < MAX_NR_CONSOLES; unit++)
-				strcpy(fb_display[unit].fontname,
-				       options + 5);
-		}
+		if (!strncmp(options, "font:", 5))
+			strcpy(fontname, options + 5);
 		
 		if (!strncmp(options, "scrollback:", 11)) {
 			options += 11;
@@ -443,11 +440,13 @@
 static const char *fbcon_startup(void)
 {
 	const char *display_desc = "frame buffer device";
+	struct display *p = &fb_display[fg_console];
+	struct vc_data *vc = vc_cons[fg_console].d;
 	struct font_desc *font = NULL;
 	struct module *owner;
 	struct fb_info *info;
-	struct vc_data *vc;
 	static int done = 0;
+	int cols, rows;
 	int irqres;
 
 	irqres = 1;
@@ -494,28 +493,27 @@
 		softback_lines = 0;
 	}
 
-	font = get_default_font(info->var.xres, info->var.yres);	
-
-	vc = (struct vc_data *) kmalloc(sizeof(struct vc_data), GFP_ATOMIC); 
-
-	if (!vc) {
-		if (softback_buf)
-			kfree((void *) softback_buf);
-		return NULL;
-	}
-
 	/* Setup default font */
-	vc->vc_font.data = font->data;
-	vc->vc_font.width = font->width;
-	vc->vc_font.height = font->height;
-	vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
-
-	vc->vc_cols = info->var.xres/vc->vc_font.width;
-	vc->vc_rows = info->var.yres/vc->vc_font.height;
+	if (!p->fontdata) {
+		if (!fontname[0] || !(font = find_font(fontname)))
+			font = get_default_font(info->var.xres,
+						   info->var.yres);
+		vc->vc_font.width = font->width;
+		vc->vc_font.height = font->height;
+		vc->vc_font.data = p->fontdata = font->data;
+		vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
+	}
 
-	/* We trust the mode the driver supplies. */
+	/*
+	 * We must always set the mode. The mode of the previous console
+	 * driver could be in the same resolution but we are using different
+	 * hardware so we have to initialize the hardware.
+	 */
 	if (info->fbops->fb_set_par)
 		info->fbops->fb_set_par(info);
+	cols = info->var.xres/vc->vc_font.width;
+	rows = info->var.yres/vc->vc_font.height;
+	vc_resize(vc->vc_num, cols, rows);
 
 	DPRINTK("mode:   %s\n", info->fix.id);
 	DPRINTK("visual: %d\n", info->fix.visual);
@@ -523,8 +521,6 @@
 		info->var.yres,
 		info->var.bits_per_pixel);
 
-	info->display_fg = vc;
-	
 #ifdef CONFIG_ATARI
 	if (MACH_IS_ATARI) {
 		cursor_blink_rate = ATARI_CURSOR_BLINK_RATE;
@@ -599,98 +595,60 @@
 
 static void fbcon_init(struct vc_data *vc, int init)
 {
-	int unit = vc->vc_num;
-	struct fb_info *info;
-
-	/* on which frame buffer will we open this console? */
-	info = registered_fb[(int) con2fb_map[unit]];
-	
-	if (info->var.accel_flags)
-		fb_display[unit].scrollmode = SCROLL_YNOMOVE;
-	else
-		fb_display[unit].scrollmode = SCROLL_YREDRAW;
-	fbcon_set_display(vc, init, !init);
-}
-
-static void fbcon_deinit(struct vc_data *vc)
-{
-	struct display *p = &fb_display[vc->vc_num];
-
-	fbcon_free_font(p);
-}
-
-static __inline__ void updatescrollmode(struct display *p, struct vc_data *vc)
-{
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-
-	int m;
-	if (p->scrollmode & __SCROLL_YFIXED)
-		return;
-	if (divides(info->fix.ywrapstep, vc->vc_font.height) &&
-	    divides(vc->vc_font.height, info->var.yres_virtual))
-		m = __SCROLL_YWRAP;
-	else if (divides(info->fix.ypanstep, vc->vc_font.height) &&
-		 info->var.yres_virtual >= info->var.yres + vc->vc_font.height)
-		m = __SCROLL_YPAN;
-	else if (p->scrollmode & __SCROLL_YNOMOVE)
-		m = __SCROLL_YREDRAW;
-	else
-		m = __SCROLL_YMOVE;
-	p->scrollmode = (p->scrollmode & ~__SCROLL_YMASK) | m;
-}
-
-static void fbcon_set_display(struct vc_data *vc, int init, int logo)
-{
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-	int nr_rows, nr_cols, old_rows, old_cols, i, charcnt = 256;
-	struct display *p = &fb_display[vc->vc_num];
+	struct vc_data **default_mode = vc->vc_display_fg;
+	struct display *t, *p = &fb_display[vc->vc_num];
+	int display_fg = (*default_mode)->vc_num;
+	int logo = 1, rows, cols, charcnt = 256;
 	unsigned short *save = NULL, *r, *q;
-	struct font_desc *font;
 
-	if (vc->vc_num != fg_console || (info->flags & FBINFO_FLAG_MODULE) ||
+	if (vc->vc_num != display_fg || (info->flags & FBINFO_FLAG_MODULE) ||
 	    (info->fix.type == FB_TYPE_TEXT))
 		logo = 0;
 
 	info->var.xoffset = info->var.yoffset = p->yscroll = 0;	/* reset wrap/pan */
 
-	for (i = 0; i < MAX_NR_CONSOLES; i++)
-		if (vc && i != vc->vc_num && fb_display[i].fontdata) 
-			break;
-
-	fbcon_free_font(p);
-	if (i < MAX_NR_CONSOLES) {
-		struct display *q = &fb_display[i];
-		struct vc_data *tmp = vc_cons[i].d;
-		
-		/* If we are not the first console on this
-		   fb, copy the font from that console */
-		vc->vc_font.width = tmp->vc_font.width;
-		vc->vc_font.height = tmp->vc_font.height;
-		vc->vc_font.data = p->fontdata = q->fontdata;
-		p->userfont = q->userfont;
-		if (p->userfont) {
-			REFCOUNT(p->fontdata)++;
-			charcnt = FNTCHARCNT(p->fontdata);
-		}
-		con_copy_unimap(vc->vc_num, i);
+	/* If we are not the first console on this
+	   fb, copy the font from that console */
+	t = &fb_display[display_fg];
+	vc->vc_font.width = (*default_mode)->vc_font.width;
+	vc->vc_font.height = (*default_mode)->vc_font.height;
+	vc->vc_font.data = p->fontdata = t->fontdata;
+	p->userfont = t->userfont;
+	if (p->userfont) {
+		REFCOUNT(p->fontdata)++;
+		charcnt = FNTCHARCNT(p->fontdata);
 	}
+	con_copy_unimap(vc->vc_num, display_fg);
 
-	if (!p->fontdata) {
-		if (!p->fontname[0] || !(font = find_font(p->fontname)))
-			font = get_default_font(info->var.xres,
-						   info->var.yres);
-		vc->vc_font.width = font->width;
-		vc->vc_font.height = font->height;
-		vc->vc_font.data = p->fontdata = font->data;
+	vc->vc_can_do_color = info->var.bits_per_pixel != 1;
+	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
+	if (charcnt == 256) {
+		vc->vc_hi_font_mask = 0;
+	} else {
+		vc->vc_hi_font_mask = 0x100;
+		if (vc->vc_can_do_color)
+			vc->vc_complement_mask <<= 1;
 	}
 
-	updatescrollmode(p, vc);
-
-	old_cols = vc->vc_cols;
-	old_rows = vc->vc_rows;
+	cols = info->var.xres / vc->vc_font.width;
+	rows = info->var.yres / vc->vc_font.height;
+	vc_resize(vc->vc_num, cols, rows);
 
-	nr_cols = info->var.xres / vc->vc_font.width;
-	nr_rows = info->var.yres / vc->vc_font.height;
+	if (info->var.accel_flags)
+		p->scrollmode = SCROLL_YNOMOVE;
+	else
+		p->scrollmode = SCROLL_YREDRAW;
+	
+	/*
+	 *  ++guenther: console.c:vc_allocate() relies on initializing
+	 *  vc_{cols,rows}, but we must not set those if we are only
+	 *  resizing the console.
+	 */
+	if (init) {
+		vc->vc_cols = cols;
+		vc->vc_rows = rows;
+	}
 
 	if (logo) {
 		/* Need to make room for the logo */
@@ -701,34 +659,28 @@
 		logo_lines = (logo_height + vc->vc_font.height - 1) /
 			     vc->vc_font.height;
 		q = (unsigned short *) (vc->vc_origin +
-					vc->vc_size_row * old_rows);
-		step = logo_lines * old_cols;
-		for (r = q - logo_lines * old_cols; r < q; r++)
+					vc->vc_size_row * rows);
+		step = logo_lines * cols;
+		for (r = q - logo_lines * cols; r < q; r++)
 			if (scr_readw(r) != vc->vc_video_erase_char)
 				break;
-		if (r != q && nr_rows >= old_rows + logo_lines) {
-			save =
-			    kmalloc(logo_lines * nr_cols * 2, GFP_KERNEL);
+		if (r != q && rows >= rows + logo_lines) {
+			save = kmalloc(logo_lines * cols * 2, GFP_KERNEL);
 			if (save) {
-				int i =
-				    old_cols <
-				    nr_cols ? old_cols : nr_cols;
 				scr_memsetw(save, vc->vc_video_erase_char,
-					    logo_lines * nr_cols * 2);
+					    logo_lines * cols * 2);
 				r = q - step;
-				for (cnt = 0; cnt < logo_lines;
-				     cnt++, r += i)
-					scr_memcpyw(save + cnt * nr_cols,
-						    r, 2 * i);
+				for (cnt = 0; cnt < logo_lines; cnt++, r += cols)
+					scr_memcpyw(save + cnt * cols, r, 2 * cols);
 				r = q;
 			}
 		}
 		if (r == q) {
 			/* We can scroll screen down */
-			r = q - step - old_cols;
-			for (cnt = old_rows - logo_lines; cnt > 0; cnt--) {
+			r = q - step - cols;
+			for (cnt = rows - logo_lines; cnt > 0; cnt--) {
 				scr_memcpyw(r + step, r, vc->vc_size_row);
-				r -= old_cols;
+				r -= cols;
 			}
 			if (!save) {
 				vc->vc_y += logo_lines;
@@ -738,55 +690,20 @@
 		scr_memsetw((unsigned short *) vc->vc_origin,
 			    vc->vc_video_erase_char,
 			    vc->vc_size_row * logo_lines);
-	}
-
-	/*
-	 *  ++guenther: console.c:vc_allocate() relies on initializing
-	 *  vc_{cols,rows}, but we must not set those if we are only
-	 *  resizing the console.
-	 */
-	if (init) {
-		vc->vc_cols = nr_cols;
-		vc->vc_rows = nr_rows;
-	}
-	p->vrows = info->var.yres_virtual / vc->vc_font.height;
-	if(info->var.yres > (vc->vc_font.height * (vc->vc_rows + 1))) {
-		p->vrows -= (info->var.yres - (vc->vc_font.height * vc->vc_rows)) / vc->vc_font.height;
-	}
-	if ((info->var.yres % vc->vc_font.height) &&
-	    (info->var.yres_virtual % vc->vc_font.height <
-	     info->var.yres % vc->vc_font.height))
-		p->vrows--;
-	vc->vc_can_do_color = info->var.bits_per_pixel != 1;
-	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
-	if (charcnt == 256) {
-		vc->vc_hi_font_mask = 0;
-	} else {
-		vc->vc_hi_font_mask = 0x100;
-		if (vc->vc_can_do_color)
-			vc->vc_complement_mask <<= 1;
-	}
 
-	if (!init) {
-		if (vc->vc_cols != nr_cols || vc->vc_rows != nr_rows)
-			vc_resize(vc->vc_num, nr_cols, nr_rows);
-		else if (CON_IS_VISIBLE(vc) &&
-			 vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
+		if (CON_IS_VISIBLE(vc) && vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
 			accel_clear_margins(vc, info, 0);
 			update_screen(vc->vc_num);
 		}
 		if (save) {
 			q = (unsigned short *) (vc->vc_origin +
 						vc->vc_size_row *
-						old_rows);
-			scr_memcpyw(q, save, logo_lines * nr_cols * 2);
+						rows);
+			scr_memcpyw(q, save, logo_lines * cols * 2);
 			vc->vc_y += logo_lines;
 			vc->vc_pos += logo_lines * vc->vc_size_row;
 			kfree(save);
 		}
-	}
-
-	if (logo) {
 		if (logo_lines > vc->vc_bottom) {
 			logo_shown = -1;
 			printk(KERN_INFO
@@ -797,7 +714,7 @@
 		}
 	}
 
-	if (vc->vc_num == fg_console && softback_buf) {
+	if (vc->vc_num == display_fg && softback_buf) {
 		int l = fbcon_softback_size / vc->vc_size_row;
 		if (l > 5)
 			softback_end = softback_buf + l * vc->vc_size_row;
@@ -809,6 +726,12 @@
 	}
 }
 
+static void fbcon_deinit(struct vc_data *vc)
+{
+	struct display *p = &fb_display[vc->vc_num];
+
+	fbcon_free_font(p);
+}
 
 /* ====================================================================== */
 
@@ -1542,6 +1465,25 @@
 			height, width);
 }
 
+static __inline__ void updatescrollmode(struct display *p, struct fb_info *info, struct vc_data *vc)
+{
+	int m;
+
+	if (p->scrollmode & __SCROLL_YFIXED)
+		return;
+	if (divides(info->fix.ywrapstep, vc->vc_font.height) &&
+	    divides(vc->vc_font.height, info->var.yres_virtual))
+		m = __SCROLL_YWRAP;
+	else if (divides(info->fix.ypanstep, vc->vc_font.height) &&
+		 info->var.yres_virtual >= info->var.yres + vc->vc_font.height)
+		m = __SCROLL_YPAN;
+	else if (p->scrollmode & __SCROLL_YNOMOVE)
+		m = __SCROLL_YREDRAW;
+	else
+		m = __SCROLL_YMOVE;
+	p->scrollmode = (p->scrollmode & ~__SCROLL_YMASK) | m;
+}
+
 static int fbcon_resize(struct vc_data *vc, unsigned int width, 
 			unsigned int height)
 {
@@ -1556,20 +1498,30 @@
 	var.yres = height * fh;
 	x_diff = info->var.xres - var.xres;
 	y_diff = info->var.yres - var.yres;
-	if (x_diff < 0 || x_diff > fw ||
-	   (y_diff < 0 || y_diff > fh)) {
-		var.activate = FB_ACTIVATE_TEST;
-		err = fb_set_var(info, &var);
-		if (err || width > var.xres/fw ||
-		    height > var.yres/fh)
+	if (x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh)) {
+		char mode[40];
+
+		DPRINTK("attempting resize %ix%i\n", var.xres, var.yres);
+		if (!info->fbops->fb_set_par)
+			return -EINVAL;
+
+		sprintf(mode, "%dx%d", var.xres, var.yres);
+		err = fb_find_mode(&var, info, mode, NULL, 0, NULL,
+					info->var.bits_per_pixel);
+		if (!err || width > var.xres/fw || height > var.yres/fh)
 			return -EINVAL;
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
-		var.activate = FB_ACTIVATE_NOW;
-		fb_set_var(info, &var);
+		if (CON_IS_VISIBLE(vc)) {
+			var.activate = FB_ACTIVATE_NOW;
+			fb_set_var(info, &var);
+		}
 	}
 	p->vrows = var.yres_virtual/fh;
 	if (var.yres > (fh * (height + 1)))
 		p->vrows -= (var.yres - (fh * height)) / fh;
+	if ((var.yres % fh) && (var.yres_virtual % fh < var.yres % fh))
+		p->vrows--;
+	updatescrollmode(p, info, vc);
 	return 0;
 }
 
@@ -1839,16 +1791,6 @@
 	if (resize) {
 		/* reset wrap/pan */
 		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
-		p->vrows = info->var.yres_virtual / h;
-
-#if 0          /* INCOMPLETE - let the console gurus handle this */
-		if(info->var.yres > (h * (vc->vc_rows + 1))
-			p->vrows -= (info->var.yres - (h * vc->vc_rows)) / h;
-#endif
-		if ((info->var.yres % h)
-		    && (info->var.yres_virtual % h < info->var.yres % h))
-			p->vrows--;
-		updatescrollmode(p, vc);
 		vc_resize(vc->vc_num, info->var.xres / w, info->var.yres / h);
 		if (CON_IS_VISIBLE(vc) && softback_buf) {
 			int l = fbcon_softback_size / vc->vc_size_row;
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/console/fbcon.h fbdev-2.6/drivers/video/console/fbcon.h
--- linus-2.6/drivers/video/console/fbcon.h	2004-05-13 21:07:31.000000000 -0700
+++ fbdev-2.6/drivers/video/console/fbcon.h	2004-05-12 20:24:38.000000000 -0700
@@ -27,7 +27,6 @@
     /* Filled in by the frame buffer device */
     u_short inverse;                /* != 0 text black on white as default */
     /* Filled in by the low-level console driver */
-    char fontname[40];              /* Font associated to this display */	
     u_char *fontdata;
     int userfont;                   /* != 0 if fontdata kmalloc()ed */
     u_short scrollmode;             /* Scroll Method */
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/modedb.c fbdev-2.6/drivers/video/modedb.c
--- linus-2.6/drivers/video/modedb.c	2004-05-13 21:07:28.000000000 -0700
+++ fbdev-2.6/drivers/video/modedb.c	2004-05-07 17:05:27.000000000 -0700
@@ -391,7 +391,7 @@
 }
 
 /**
- *	__fb_try_mode - test a video mode
+ *	fb_try_mode - test a video mode
  *	@var: frame buffer user defined part of display
  *	@info: frame buffer info structure
  *	@mode: frame buffer video mode structure
@@ -403,10 +403,10 @@
  *
  */
 
-int __fb_try_mode(struct fb_var_screeninfo *var, struct fb_info *info,
+int fb_try_mode(struct fb_var_screeninfo *var, struct fb_info *info,
 		  const struct fb_videomode *mode, unsigned int bpp)
 {
-    int err = 1;
+    int err = 0;
 
     DPRINTK("Trying mode %s %dx%d-%d@%d\n", mode->name ? mode->name : "noname",
 	    mode->xres, mode->yres, bpp, mode->refresh);
@@ -430,10 +430,9 @@
     if (info->fbops->fb_check_var)
     	err = info->fbops->fb_check_var(var, info);
     var->activate &= ~FB_ACTIVATE_TEST;
-    return !err;
+    return err;
 }
 
-
 /**
  *	fb_find_mode - finds a valid video mode
  *	@var: frame buffer user defined part of display
@@ -536,18 +535,18 @@
 		if ((name_matches(db[j], name, namelen) ||
 		     (res_specified && res_matches(db[j], xres, yres))) &&
 		    (!i || db[j].refresh == refresh) &&
-		    __fb_try_mode(var, info, &db[j], bpp))
+		    !fb_try_mode(var, info, &db[j], bpp))
 		    return 2-i;
 	}
     }
 
     DPRINTK("Trying default video mode\n");
-    if (__fb_try_mode(var, info, default_mode, default_bpp))
+    if (!fb_try_mode(var, info, default_mode, default_bpp))
 	return 3;
 
     DPRINTK("Trying all modes\n");
     for (i = 0; i < dbsize; i++)
-	if (__fb_try_mode(var, info, &db[i], default_bpp))
+	if (!fb_try_mode(var, info, &db[i], default_bpp))
 	    return 4;
 
     DPRINTK("No valid mode found\n");
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/radeonfb.c fbdev-2.6/drivers/video/radeonfb.c
--- linus-2.6/drivers/video/radeonfb.c	2004-05-13 21:07:29.000000000 -0700
+++ fbdev-2.6/drivers/video/radeonfb.c	2004-05-13 21:21:54.000000000 -0700
@@ -2252,7 +2252,6 @@
 	info->pseudo_palette = rinfo->pseudo_palette;
         info->flags = FBINFO_FLAG_DEFAULT;
         info->fbops = &radeonfb_ops;
-        info->display_fg = NULL;
         info->screen_base = (char *)rinfo->fb_base;
 
 	/* Fill fix common fields */
diff -urN -X /home/jsimmons/dontdiff linus-2.6/include/linux/fb.h fbdev-2.6/include/linux/fb.h
--- linus-2.6/include/linux/fb.h	2004-05-13 21:08:20.000000000 -0700
+++ fbdev-2.6/include/linux/fb.h	2004-05-13 21:22:08.000000000 -0700
@@ -516,7 +516,6 @@
 	struct fb_cmap cmap;		/* Current cmap */
 	struct fb_ops *fbops;
 	char *screen_base;		/* Virtual address */
-	struct vc_data *display_fg;	/* Console visible on this display */
 	int currcon;			/* Current VC. */
 	void *pseudo_palette;		/* Fake palette of 16 colors */ 
 #define FBINFO_STATE_RUNNING	0



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click

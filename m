From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 6/8] fbcon/fbdev: Remove fbcon-specific fields from struct fb_info
Date: Tue, 2 Nov 2004 19:46:23 +0800
Message-ID: <200411021946.23848.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1COx87-0002ou-Am
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 03:47:15 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1COx85-0005Cb-Td
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 03:47:15 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 13727117021B
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  2 Nov 2004 11:46:54 +0000 (UTC)
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

The following fields in struct fb_info is specific only to fbcon:
- struct timer_ cursor_timer
- int currcon

Remove them from struct fb_info and place them in fbcon_par so they
become invisible from the drivers.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/acornfb.c               |    1
 drivers/video/aty/radeon_base.c       |    1
 drivers/video/bw2.c                   |    1
 drivers/video/cg14.c                  |    1
 drivers/video/cg3.c                   |    1
 drivers/video/cg6.c                   |    1
 drivers/video/cirrusfb.c              |    1
 drivers/video/console/fbcon.c         |   82 +++++++++++++++++++++-------------
 drivers/video/console/fbcon.h         |    2
 drivers/video/ffb.c                   |    1
 drivers/video/gbefb.c                 |    1
 drivers/video/intelfb/intelfbdrv.c    |    1
 drivers/video/leo.c                   |    1
 drivers/video/matrox/matroxfb_base.c  |   26 ++++++----
 drivers/video/matrox/matroxfb_crtc2.c |    5 --
 drivers/video/p9100.c                 |    1
 drivers/video/pxafb.c                 |    1
 drivers/video/radeonfb.c              |    1
 drivers/video/sa1100fb.c              |    1
 drivers/video/sis/sis_main.c          |    5 +-
 drivers/video/sstfb.c                 |    1
 drivers/video/stifb.c                 |    1
 drivers/video/tcx.c                   |    1
 drivers/video/tgafb.c                 |    1
 drivers/video/vga16fb.c               |    1
 include/linux/fb.h                    |    2
 26 files changed, 73 insertions(+), 69 deletions(-)

diff -Nru a/drivers/video/acornfb.c b/drivers/video/acornfb.c
--- a/drivers/video/acornfb.c	2004-10-19 20:21:12 +08:00
+++ b/drivers/video/acornfb.c	2004-11-01 08:32:53 +08:00
@@ -1332,7 +1332,6 @@
 		}
 	}
 
-	fb_info.currcon	       = -1;
 	fb_info.screen_base    = (char *)SCREEN_BASE;
 	fb_info.fix.smem_start = SCREEN_START;
 	current_par.using_vram = 0;
diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	2004-10-27 14:58:07 +08:00
+++ b/drivers/video/aty/radeon_base.c	2004-11-01 08:32:53 +08:00
@@ -1749,7 +1749,6 @@
 {
 	struct fb_info *info = rinfo->info;
 
-	info->currcon = -1;
 	info->par = rinfo;
 	info->pseudo_palette = rinfo->pseudo_palette;
 	info->flags = FBINFO_DEFAULT
diff -Nru a/drivers/video/bw2.c b/drivers/video/bw2.c
--- a/drivers/video/bw2.c	2004-10-23 02:52:37 +08:00
+++ b/drivers/video/bw2.c	2004-11-01 08:32:53 +08:00
@@ -361,7 +361,6 @@
 	if (!all->info.screen_base)
 		all->info.screen_base = (char *)
 			sbus_ioremap(resp, 0, all->par.fbsize, "bw2 ram");
-	all->info.currcon = -1;
 	all->info.par = &all->par;
 
 	bw2_blank(0, &all->info);
diff -Nru a/drivers/video/cg14.c b/drivers/video/cg14.c
--- a/drivers/video/cg14.c	2004-10-19 20:21:24 +08:00
+++ b/drivers/video/cg14.c	2004-11-01 08:32:53 +08:00
@@ -552,7 +552,6 @@
 
 	all->info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 	all->info.fbops = &cg14_ops;
-	all->info.currcon = -1;
 	all->info.par = &all->par;
 
 	__cg14_reset(&all->par);
diff -Nru a/drivers/video/cg3.c b/drivers/video/cg3.c
--- a/drivers/video/cg3.c	2004-10-19 20:21:25 +08:00
+++ b/drivers/video/cg3.c	2004-11-01 08:32:54 +08:00
@@ -408,7 +408,6 @@
 		all->info.screen_base = (char *)
 			sbus_ioremap(&sdev->resource[0], CG3_RAM_OFFSET,
 				     all->par.fbsize, "cg3 ram");
-	all->info.currcon = -1;
 	all->info.par = &all->par;
 
 	cg3_blank(0, &all->info);
diff -Nru a/drivers/video/cg6.c b/drivers/video/cg6.c
--- a/drivers/video/cg6.c	2004-10-19 20:21:26 +08:00
+++ b/drivers/video/cg6.c	2004-11-01 08:32:54 +08:00
@@ -723,7 +723,6 @@
 		all->info.screen_base = (char *)
 			sbus_ioremap(&sdev->resource[0], CG6_RAM_OFFSET,
 				     all->par.fbsize, "cgsix ram");
-	all->info.currcon = -1;
 	all->info.par = &all->par;
 
 	all->info.var.accel_flags = FB_ACCELF_TEXT;
diff -Nru a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
--- a/drivers/video/cirrusfb.c	2004-10-30 19:10:42 +08:00
+++ b/drivers/video/cirrusfb.c	2004-11-01 08:32:54 +08:00
@@ -2246,7 +2246,6 @@
 	struct fb_info *info = cinfo->info;
 	struct fb_var_screeninfo *var = &info->var;
 
-	info->currcon = -1;
 	info->par = cinfo;
 	info->pseudo_palette = cinfo->pseudo_palette;
 	info->flags = FBINFO_DEFAULT
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2004-11-02 18:58:15 +08:00
+++ b/drivers/video/console/fbcon.c	2004-11-01 13:45:03 +08:00
@@ -249,8 +249,8 @@
 	int c;
 	int mode;
 
-	if (info->currcon != -1)
-		vc = vc_cons[info->currcon].d;
+	if (ops->currcon != -1)
+		vc = vc_cons[ops->currcon].d;
 
 	if (info->state != FBINFO_STATE_RUNNING ||
 	    !vc || !CON_IS_VISIBLE(vc) ||
@@ -284,9 +284,10 @@
 static void cursor_timer_handler(unsigned long dev_addr)
 {
 	struct fb_info *info = (struct fb_info *) dev_addr;
-	
+	struct fbcon_ops *ops = info->fbcon_par;
+
 	schedule_work(&info->queue);
-	mod_timer(&info->cursor_timer, jiffies + HZ/5);
+	mod_timer(&ops->cursor_timer, jiffies + HZ/5);
 }
 
 int __init fb_console_setup(char *this_opt)
@@ -502,6 +503,7 @@
 	int oldidx = con2fb_map[unit];
 	struct fb_info *info = registered_fb[newidx];
 	struct fb_info *oldinfo = NULL;
+	struct fbcon_ops *ops;
 	int found;
 
 	if (oldidx == newidx)
@@ -524,8 +526,10 @@
 	con2fb_map[unit] = newidx;
 
 	if (!found) {
-		struct fbcon_ops *ops = NULL;
 		int err = 0;
+
+		ops = NULL;
+
 		if (!try_module_get(info->fbops->owner)) {
 			err = -ENODEV;
 		}
@@ -560,7 +564,8 @@
 	 * fbcon should release it.
 	 */
 	if (oldinfo && !search_fb_in_map(oldidx)) {
-		struct fbcon_ops *ops = (struct fbcon_ops *) oldinfo->fbcon_par;
+
+		ops = oldinfo->fbcon_par;
 
 		if (oldinfo->fbops->fb_release &&
 		    oldinfo->fbops->fb_release(oldinfo, 0)) {
@@ -574,28 +579,33 @@
 		}
 
 		if (oldinfo->queue.func == fb_flashcursor)
-			del_timer_sync(&oldinfo->cursor_timer);
+			del_timer_sync(&ops->cursor_timer);
 
 		kfree(ops->cursor_state.mask);
 		kfree(ops->cursor_data);
 		kfree(oldinfo->fbcon_par);
+		oldinfo->fbcon_par = NULL;
 		module_put(oldinfo->fbops->owner);
 	}
 
 	if (!found) {
 		if (!info->queue.func || info->queue.func == fb_flashcursor) {
+
+			ops = info->fbcon_par;
+
 			if (!info->queue.func)
 				INIT_WORK(&info->queue, fb_flashcursor, info);
 
-			init_timer(&info->cursor_timer);
-			info->cursor_timer.function = cursor_timer_handler;
-			info->cursor_timer.expires = jiffies + HZ / 5;
-			info->cursor_timer.data = (unsigned long ) info;
-			add_timer(&info->cursor_timer);
+			init_timer(&ops->cursor_timer);
+			ops->cursor_timer.function = cursor_timer_handler;
+			ops->cursor_timer.expires = jiffies + HZ / 5;
+			ops->cursor_timer.data = (unsigned long ) info;
+			add_timer(&ops->cursor_timer);
 		}
 	}
 
-	info->currcon = fg_console;
+	ops = info->fbcon_par;
+	ops->currcon = fg_console;
 	con2fb_map_boot[unit] = newidx;
 
 	if (info->fbops->fb_set_par)
@@ -690,7 +700,6 @@
 	info = registered_fb[info_idx];
 	if (!info)
 		return NULL;
-	info->currcon = -1;
 	
 	owner = info->fbops->owner;
 	if (!try_module_get(owner))
@@ -707,6 +716,7 @@
 	}
 
 	memset(ops, 0, sizeof(struct fbcon_ops));
+	ops->currcon = -1;
 	info->fbcon_par = ops;
 	set_blitting_type(vc, info, NULL);
 
@@ -821,11 +831,11 @@
 	if (!info->queue.func) {
 		INIT_WORK(&info->queue, fb_flashcursor, info);
 
-		init_timer(&info->cursor_timer);
-		info->cursor_timer.function = cursor_timer_handler;
-		info->cursor_timer.expires = jiffies + HZ / 5;
-		info->cursor_timer.data = (unsigned long ) info;
-		add_timer(&info->cursor_timer);
+		init_timer(&ops->cursor_timer);
+		ops->cursor_timer.function = cursor_timer_handler;
+		ops->cursor_timer.expires = jiffies + HZ / 5;
+		ops->cursor_timer.data = (unsigned long ) info;
+		add_timer(&ops->cursor_timer);
 	}
 	return display_desc;
 }
@@ -1074,7 +1084,7 @@
 
 int update_var(int con, struct fb_info *info)
 {
-	if (con == info->currcon) 
+	if (con == ((struct fbcon_ops *)info->fbcon_par)->currcon)
 		return fb_pan_display(info, &info->var);
 	return 0;
 }
@@ -1877,7 +1887,7 @@
 		logo_shown = FBCON_LOGO_CANSHOW;
 	}
 
-	prev_console = info->currcon;
+	prev_console = ((struct fbcon_ops *)info->fbcon_par)->currcon;
 
 	/*
 	 * FIXME: If we have multiple fbdev's loaded, we need to
@@ -1888,10 +1898,12 @@
 	 * info->currcon = vc->vc_num;
 	 */
 	for (i = 0; i < FB_MAX; i++) {
-		if (registered_fb[i] != NULL)
-			registered_fb[i]->currcon = vc->vc_num;
-	}
+		if (registered_fb[i] != NULL && registered_fb[i]->fbcon_par) {
+			struct fbcon_ops *ops = registered_fb[i]->fbcon_par;
 
+			ops->currcon = vc->vc_num;
+		}
+	}
 	memset(&var, 0, sizeof(struct fb_var_screeninfo));
 	display_to_var(&var, p);
 	var.activate = FB_ACTIVATE_NOW;
@@ -1960,7 +1972,7 @@
 {
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct display *p = &fb_display[vc->vc_num];
 	int retval = 0;
 
@@ -2517,10 +2529,11 @@
 static void fbcon_suspended(struct fb_info *info)
 {
 	struct vc_data *vc = NULL;
+	struct fbcon_ops *ops = info->fbcon_par;
 
-	if (info->currcon < 0)
+	if (!ops || ops->currcon < 0)
 		return;
-	vc = vc_cons[info->currcon].d;
+	vc = vc_cons[ops->currcon].d;
 
 	/* Clear cursor, restore saved data */
 	fbcon_cursor(vc, CM_ERASE);
@@ -2529,21 +2542,28 @@
 static void fbcon_resumed(struct fb_info *info)
 {
 	struct vc_data *vc;
+	struct fbcon_ops *ops = info->fbcon_par;
 
-	if (info->currcon < 0)
+	if (!ops || ops->currcon < 0)
 		return;
-	vc = vc_cons[info->currcon].d;
+	vc = vc_cons[ops->currcon].d;
 
 	update_screen(vc->vc_num);
 }
 
 static void fbcon_modechanged(struct fb_info *info)
 {
-	struct vc_data *vc = vc_cons[info->currcon].d;
+	struct fbcon_ops *ops = info->fbcon_par;
+	struct vc_data *vc;
 	struct display *p;
 	int rows, cols;
 
-	if (info->currcon < 0 || vt_cons[info->currcon]->vc_mode !=
+	if (!ops)
+		return;
+
+	vc = vc_cons[ops->currcon].d;
+
+	if (ops->currcon < 0 || vt_cons[ops->currcon]->vc_mode !=
 	    KD_TEXT)
 		return;
 	p = &fb_display[vc->vc_num];
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	2004-10-23 02:52:37 +08:00
+++ b/drivers/video/console/fbcon.h	2004-11-01 10:37:51 +08:00
@@ -61,7 +61,9 @@
 	void (*cursor)(struct vc_data *vc, struct fb_info *info,
 		       struct display *p, int mode, int fg, int bg);
 
+	struct timer_list cursor_timer; /* Cursor timer */
 	struct fb_cursor cursor_state;
+        int    currcon;	                /* Current VC. */
 	int    cursor_flash;
 	char  *cursor_data;
 };
diff -Nru a/drivers/video/ffb.c b/drivers/video/ffb.c
--- a/drivers/video/ffb.c	2004-10-19 20:21:43 +08:00
+++ b/drivers/video/ffb.c	2004-11-01 08:32:54 +08:00
@@ -969,7 +969,6 @@
 			   FBINFO_HWACCEL_IMAGEBLIT);
 	all->info.fbops = &ffb_ops;
 	all->info.screen_base = (char *) all->par.physbase + FFB_DFB24_POFF;
-	all->info.currcon = -1;
 	all->info.par = &all->par;
 	all->info.pseudo_palette = all->pseudo_palette;
 
diff -Nru a/drivers/video/gbefb.c b/drivers/video/gbefb.c
--- a/drivers/video/gbefb.c	2004-10-19 20:21:46 +08:00
+++ b/drivers/video/gbefb.c	2004-11-01 08:32:54 +08:00
@@ -1140,7 +1140,6 @@
 	for (i = 0; i < (gbe_mem_size >> TILE_SHIFT); i++)
 		gbe_tiles.cpu[i] = (gbe_mem_phys >> TILE_SHIFT) + i;
 
-	fb_info.currcon = -1;
 	fb_info.fbops = &gbefb_ops;
 	fb_info.pseudo_palette = pseudo_palette;
 	fb_info.flags = FBINFO_DEFAULT;
diff -Nru a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c	2004-10-30 19:10:42 +08:00
+++ b/drivers/video/intelfb/intelfbdrv.c	2004-11-01 08:32:54 +08:00
@@ -1108,7 +1108,6 @@
 
 	DBG_MSG("intelfb_set_fbinfo\n");
 
-	//info->currcon = -1;
 	info->flags = FBINFO_FLAG_DEFAULT;
 	info->fbops = &intel_fb_ops;
 	info->pseudo_palette = dinfo->pseudo_palette;
diff -Nru a/drivers/video/leo.c b/drivers/video/leo.c
--- a/drivers/video/leo.c	2004-10-19 20:21:52 +08:00
+++ b/drivers/video/leo.c	2004-11-01 08:32:54 +08:00
@@ -590,7 +590,6 @@
 
 	all->info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 	all->info.fbops = &leo_ops;
-	all->info.currcon = -1;
 	all->info.par = &all->par;
 
 	leo_init_wids(&all->info);
diff -Nru a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
--- a/drivers/video/matrox/matroxfb_base.c	2004-10-23 02:52:37 +08:00
+++ b/drivers/video/matrox/matroxfb_base.c	2004-11-01 08:32:54 +08:00
@@ -1712,7 +1712,6 @@
 	}
 	ACCESS_FBINFO(devflags.ydstorg) = 0;
 
-	ACCESS_FBINFO(fbcon.currcon) = -1;
 	ACCESS_FBINFO(video.base) = video_base_phys;
 	ACCESS_FBINFO(video.len_usable) = ACCESS_FBINFO(video.len);
 	if (ACCESS_FBINFO(video.len_usable) > b->base->maxdisplayable)
@@ -1877,16 +1876,21 @@
 	}
 	printk("fb%d: %s frame buffer device\n",
 	       ACCESS_FBINFO(fbcon.node), ACCESS_FBINFO(fbcon.fix.id));
-	if (ACCESS_FBINFO(fbcon.currcon) < 0) {
-		/* there is no console on this fb... but we have to initialize hardware
-		 * until someone tells me what is proper thing to do */
-		printk(KERN_INFO "fb%d: initializing hardware\n",
-			ACCESS_FBINFO(fbcon.node));
-		/* We have to use FB_ACTIVATE_FORCE, as we had to put vesafb_defined to the fbcon.var
-		 * already before, so register_framebuffer works correctly. */
-		vesafb_defined.activate |= FB_ACTIVATE_FORCE;
-		fb_set_var(&ACCESS_FBINFO(fbcon), &vesafb_defined);
-	}
+	/*
+	 * Tony: If this driver is to be mapped to the console, then
+	 *       fbcon will automatically do a set_par for us.  The code below
+	 *       may not be needed.
+	 */
+
+	/* there is no console on this fb... but we have to initialize hardware
+	 * until someone tells me what is proper thing to do */
+	printk(KERN_INFO "fb%d: initializing hardware\n",
+	       ACCESS_FBINFO(fbcon.node));
+	/* We have to use FB_ACTIVATE_FORCE, as we had to put vesafb_defined to the fbcon.var
+	 * already before, so register_framebuffer works correctly. */
+	vesafb_defined.activate |= FB_ACTIVATE_FORCE;
+	fb_set_var(&ACCESS_FBINFO(fbcon), &vesafb_defined);
+
 	return 0;
 failVideoIO:;
 	matroxfb_g450_shutdown(PMINFO2);
diff -Nru a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
--- a/drivers/video/matrox/matroxfb_crtc2.c	2004-10-27 14:58:08 +08:00
+++ b/drivers/video/matrox/matroxfb_crtc2.c	2004-11-01 08:32:54 +08:00
@@ -605,7 +605,6 @@
 	m2info->fbcon.flags = FBINFO_FLAG_DEFAULT;
 	m2info->fbcon.flags |= FBINFO_HWACCEL_XPAN |
 			       FBINFO_HWACCEL_YPAN;
-	m2info->fbcon.currcon = -1;
 	m2info->fbcon.pseudo_palette = m2info->cmap;
 	fb_alloc_cmap(&m2info->fbcon.cmap, 256, 1);
 
@@ -634,9 +633,7 @@
 	if (register_framebuffer(&m2info->fbcon)) {
 		return -ENXIO;
 	}
-	if (m2info->fbcon.currcon < 0) {
-		fb_set_var(&m2info->fbcon, &matroxfb_dh_defined);
-	}
+	fb_set_var(&m2info->fbcon, &matroxfb_dh_defined);
 	down_write(&ACCESS_FBINFO(crtc2.lock));
 	oldcrtc2 = ACCESS_FBINFO(crtc2.info);
 	ACCESS_FBINFO(crtc2.info) = m2info;
diff -Nru a/drivers/video/p9100.c b/drivers/video/p9100.c
--- a/drivers/video/p9100.c	2004-10-19 20:22:00 +08:00
+++ b/drivers/video/p9100.c	2004-11-01 08:32:54 +08:00
@@ -307,7 +307,6 @@
 		all->info.screen_base = (char *)
 			sbus_ioremap(&sdev->resource[2], 0,
 				     all->par.fbsize, "p9100 ram");
-	all->info.currcon = -1;
 	all->info.par = &all->par;
 
 	p9100_blank(0, &all->info);
diff -Nru a/drivers/video/pxafb.c b/drivers/video/pxafb.c
--- a/drivers/video/pxafb.c	2004-10-19 20:22:07 +08:00
+++ b/drivers/video/pxafb.c	2004-11-01 08:32:54 +08:00
@@ -1043,7 +1043,6 @@
 	fbi->fb.fbops		= &pxafb_ops;
 	fbi->fb.flags		= FBINFO_DEFAULT;
 	fbi->fb.node		= -1;
-	fbi->fb.currcon		= -1;
 
 	addr = fbi;
 	addr = addr + sizeof(struct pxafb_info);
diff -Nru a/drivers/video/radeonfb.c b/drivers/video/radeonfb.c
--- a/drivers/video/radeonfb.c	2004-10-19 20:22:10 +08:00
+++ b/drivers/video/radeonfb.c	2004-11-01 08:32:54 +08:00
@@ -2247,7 +2247,6 @@
 
 	info = &rinfo->info;
 
-	info->currcon = -1;
 	info->par = rinfo;
 	info->pseudo_palette = rinfo->pseudo_palette;
         info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
diff -Nru a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
--- a/drivers/video/sa1100fb.c	2004-10-19 20:22:13 +08:00
+++ b/drivers/video/sa1100fb.c	2004-11-01 08:32:54 +08:00
@@ -1673,7 +1673,6 @@
 	fbi->fb.fbops		= &sa1100fb_ops;
 	fbi->fb.flags		= FBINFO_DEFAULT;
 	fbi->fb.monspecs	= monspecs;
-	fbi->fb.currcon		= -1;
 	fbi->fb.pseudo_palette	= (fbi + 1);
 
 	fbi->rgb[RGB_8]		= &rgb_8;
diff -Nru a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
--- a/drivers/video/sis/sis_main.c	2004-10-19 20:24:34 +08:00
+++ b/drivers/video/sis/sis_main.c	2004-11-01 08:32:54 +08:00
@@ -1813,8 +1813,11 @@
 		return err;
 	}
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
 	sisfb_get_fix(&info->fix, info->currcon, info);
-
+#else
+	sisfb_get_fix(&info->fix, -1, info);
+#endif
 	return 0;
 }
 
diff -Nru a/drivers/video/sstfb.c b/drivers/video/sstfb.c
--- a/drivers/video/sstfb.c	2004-10-30 19:10:43 +08:00
+++ b/drivers/video/sstfb.c	2004-11-01 08:32:54 +08:00
@@ -1471,7 +1471,6 @@
 
 	info->flags	= FBINFO_DEFAULT;
 	info->fbops	= &sstfb_ops;
-	info->currcon	= -1;
 	info->pseudo_palette = &all->pseudo_palette;
 
 	fix->type	= FB_TYPE_PACKED_PIXELS;
diff -Nru a/drivers/video/stifb.c b/drivers/video/stifb.c
--- a/drivers/video/stifb.c	2004-10-19 20:22:22 +08:00
+++ b/drivers/video/stifb.c	2004-11-01 08:32:54 +08:00
@@ -1326,7 +1326,6 @@
 	info->fbops = &stifb_ops;
 	info->screen_base = (void*) REGION_BASE(fb,1);
 	info->flags = FBINFO_DEFAULT;
-	info->currcon = -1;
 
 	/* This has to been done !!! */
 	fb_alloc_cmap(&info->cmap, 256, 0);
diff -Nru a/drivers/video/tcx.c b/drivers/video/tcx.c
--- a/drivers/video/tcx.c	2004-10-19 20:22:24 +08:00
+++ b/drivers/video/tcx.c	2004-11-01 08:32:54 +08:00
@@ -422,7 +422,6 @@
 		all->info.screen_base = (char *)
 			sbus_ioremap(&sdev->resource[0], 0,
 				     all->par.fbsize, "tcx ram");
-	all->info.currcon = -1;
 	all->info.par = &all->par;
 
 	/* Initialize brooktree DAC. */
diff -Nru a/drivers/video/tgafb.c b/drivers/video/tgafb.c
--- a/drivers/video/tgafb.c	2004-10-19 20:22:26 +08:00
+++ b/drivers/video/tgafb.c	2004-11-01 08:32:54 +08:00
@@ -1430,7 +1430,6 @@
                           FBINFO_HWACCEL_IMAGEBLIT | FBINFO_HWACCEL_FILLRECT;
 	all->info.fbops = &tgafb_ops;
 	all->info.screen_base = (char *) all->par.tga_fb_base;
-	all->info.currcon = -1;
 	all->info.par = &all->par;
 	all->info.pseudo_palette = all->pseudo_palette;
 
diff -Nru a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
--- a/drivers/video/vga16fb.c	2004-10-19 20:22:33 +08:00
+++ b/drivers/video/vga16fb.c	2004-11-01 08:32:54 +08:00
@@ -859,7 +859,6 @@
 			par->vesa_blanked = 0;
 		}
 		if (par->palette_blanked) {
-			//do_install_cmap(info->currcon, info);
 			par->palette_blanked = 0;
 		}
 		break;
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	2004-10-27 14:58:17 +08:00
+++ b/include/linux/fb.h	2004-11-01 10:37:51 +08:00
@@ -685,7 +685,6 @@
 	struct fb_fix_screeninfo fix;	/* Current fix */
 	struct fb_monspecs monspecs;	/* Current Monitor specs */
 	struct work_struct queue;	/* Framebuffer event queue */
-	struct timer_list cursor_timer; /* Cursor timer */
 	struct fb_pixmap pixmap;	/* Image hardware mapper */
 	struct fb_pixmap sprite;	/* Cursor hardware mapper */
 	struct fb_cmap cmap;		/* Current cmap */
@@ -697,7 +696,6 @@
 #endif
 	char __iomem *screen_base;	/* Virtual address */
 	unsigned long screen_size;	/* Amount of ioremapped VRAM or 0 */ 
-	int currcon;			/* Current VC. */
 	void *pseudo_palette;		/* Fake palette of 16 colors */ 
 #define FBINFO_STATE_RUNNING	0
 #define FBINFO_STATE_SUSPENDED	1




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click

From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 3/3] [FBDEV]: Hardware State Notification
Date: Tue, 22 Jun 2004 06:51:44 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406220651.44132.adaplas@hotpop.com>
References: <200406220639.26576.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcXbx-0003ph-54
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Jun 2004 15:49:57 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcXbw-0007Cs-BS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Jun 2004 15:49:56 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id C7AB0633A65
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Jun 2004 22:10:23 +0000 (UTC)
In-Reply-To: <200406220639.26576.adaplas@hotpop.com>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tuesday 22 June 2004 06:39, Antonino A. Daplas wrote:
> Hi,
>
> **This patch is more of an RFC.  BenH probably has similar code.
>
> This patch adds a method (con_notify) that will notify console drivers of
> impending console switches, passing them with the about-to-be-old (last)
> vc structure and about-to-be-new (wanted) vc structure.  The console
> drivers can then elect to pass selected information to low-level drivers.

Oops, try this one.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

diff -Naur linux-2.6.7-mm1-orig/drivers/char/vt.c linux-2.6.7-mm1/drivers/char/vt.c
--- linux-2.6.7-mm1-orig/drivers/char/vt.c	2004-06-21 13:26:48.000000000 +0000
+++ linux-2.6.7-mm1/drivers/char/vt.c	2004-06-21 18:02:33.000000000 +0000
@@ -617,6 +617,9 @@
 		hide_cursor(currcons);
 		if (fg_console != new_console) {
 			struct vc_data **display = vc_cons[new_console].d->vc_display_fg;
+			if (sw->con_notify)
+				sw->con_notify(vc_cons[fg_console].d,
+					       vc_cons[new_console].d);
 			old_console = (*display) ? (*display)->vc_num : fg_console;
 			*display = vc_cons[new_console].d;
 			fg_console = new_console;
diff -Naur linux-2.6.7-mm1-orig/drivers/video/console/fbcon.c linux-2.6.7-mm1/drivers/video/console/fbcon.c
--- linux-2.6.7-mm1-orig/drivers/video/console/fbcon.c	2004-06-21 18:01:10.000000000 +0000
+++ linux-2.6.7-mm1/drivers/video/console/fbcon.c	2004-06-21 22:24:55.000000000 +0000
@@ -2428,6 +2428,31 @@
 	return 0;
 }
 
+static void fbcon_notify(struct vc_data *old_vc, struct vc_data *new_vc)
+{
+	struct fb_info *old_info = registered_fb[(int) con2fb_map[old_vc->vc_num]];
+	struct fb_info *new_info = registered_fb[(int) con2fb_map[new_vc->vc_num]];
+	int old_vcmode = vt_cons[old_vc->vc_num]->vc_mode;
+	int new_vcmode = vt_cons[new_vc->vc_num]->vc_mode;
+
+	if (old_info != new_info || vt_cons[old_vc->vc_num]->vc_mode != 
+	    vt_cons[new_vc->vc_num]->vc_mode) {
+	    if (old_info && old_info->fbops->fb_state_switch)
+		old_info->fbops->fb_state_switch(old_info, 1, 
+						 (old_vcmode == KD_GRAPHICS) ? 1 : 0);
+	    /*
+	     * If old console is in graphics, we call a set_par by default 
+	     */
+	    else if (old_vcmode == KD_GRAPHICS && old_info &&
+		     old_info->fbops->fb_set_par)
+		old_info->fbops->fb_set_par(old_info);
+
+	    if (new_info && new_info->fbops->fb_state_switch)
+		new_info->fbops->fb_state_switch(new_info, 0,
+						 (new_vcmode == KD_GRAPHICS) ? 1 : 0);
+	}
+}
+
 /*
  *  The console `switch' structure for the frame buffer based console
  */
@@ -2453,6 +2478,7 @@
 	.con_screen_pos 	= fbcon_screen_pos,
 	.con_getxy 		= fbcon_getxy,
 	.con_resize             = fbcon_resize,
+	.con_notify             = fbcon_notify,
 };
 
 static struct notifier_block fbcon_event_notifier = {
diff -Naur linux-2.6.7-mm1-orig/drivers/video/riva/fbdev.c linux-2.6.7-mm1/drivers/video/riva/fbdev.c
--- linux-2.6.7-mm1-orig/drivers/video/riva/fbdev.c	2004-06-21 13:27:47.000000000 +0000
+++ linux-2.6.7-mm1/drivers/video/riva/fbdev.c	2004-06-21 18:02:18.000000000 +0000
@@ -498,6 +498,8 @@
 	u32 b, tmp;
 	u32 *data = (u32 *)data8;
 
+	memset_io(par->riva.CURSOR, 0, MAX_CURS * MAX_CURS * 2);
+
 	for (i = 0; i < h; i++) {
 		b = *data++;
 		reverse_order(&b);
@@ -1444,8 +1446,8 @@
 
 static inline void convert_bgcolor_16(u32 *col)
 {
-	*col = ((*col & 0x00007C00) << 9)
-		| ((*col & 0x000003E0) << 6)
+	*col = ((*col & 0x0000F800) << 8)
+		| ((*col & 0x00007E0) << 5)
 		| ((*col & 0x0000001F) << 3)
 		|	   0xFF000000;
 	mb();
@@ -1573,27 +1575,29 @@
 		par->riva.PRAMDAC[0x0000300/4] = temp;
 	}
 
-	if (cursor->set & FB_CUR_SETSIZE) {
-		info->cursor.image.height = cursor->image.height;
-		info->cursor.image.width = cursor->image.width;
-		memset_io(par->riva.CURSOR, 0, MAX_CURS * MAX_CURS * 2);
-	}
-
 	if (cursor->set & FB_CUR_SETCMAP) {
 		info->cursor.image.bg_color = cursor->image.bg_color;
 		info->cursor.image.fg_color = cursor->image.fg_color;
 	}
 
+	if (cursor->set & FB_CUR_SETSIZE) {
+	    info->cursor.image.height = cursor->image.height;
+	    info->cursor.image.width = cursor->image.width;
+	}
+
 	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETCMAP | FB_CUR_SETCUR)) {
+		info->cursor.image.data = cursor->image.data;
+	}
+
+	if (info->cursor.enable) {
 		u32 bg_idx = info->cursor.image.bg_color;
 		u32 fg_idx = info->cursor.image.fg_color;
 		u32 s_pitch = (info->cursor.image.width+7) >> 3;
 		u32 d_pitch = MAX_CURS/8;
-		u8 *dat = (u8 *) cursor->image.data;
+		u8 *dat = (u8 *) info->cursor.image.data;
 		u8 *msk = (u8 *) info->cursor.mask;
 		u8 src[64];	
-		
-		info->cursor.image.data = cursor->image.data;
+
 		switch (info->cursor.rop) {
 		case ROP_XOR:
 			for (i = 0; i < s_pitch * info->cursor.image.height;
@@ -1624,9 +1628,9 @@
 		rivafb_load_cursor_image(par, data, bg, fg,
 					 info->cursor.image.width, 
 					 info->cursor.image.height);
-	}
-	if (info->cursor.enable)
+		
 		par->riva.ShowHideCursor(&par->riva, 1);
+	}
 	return 0;
 }
 
@@ -1638,6 +1642,31 @@
 	return 0;
 }
 
+static void rivafb_state_switch(struct fb_info *info, int out, int graphics)
+{
+	struct riva_par *par = (struct riva_par *) info->par;
+
+	if (out) {
+	    if (!graphics) 
+		    par->save_state = par->initial_state;
+	} else {
+		if (graphics) {
+			par->riva.LockUnlock(&par->riva, 0);
+			riva_load_state(par, &par->save_state);
+			par->riva.LockUnlock(&par->riva, 1);
+		} else {
+			riva_common_setup(par);
+			RivaGetConfig(&par->riva, par->Chipset);
+			/* vgaHWunlock() + riva unlock (0x7F) */
+			CRTCout(par, 0x11, 0xFF);
+			par->riva.LockUnlock(&par->riva, 0);
+			
+			info->fbops->fb_set_par(info);
+		}
+	}
+	par->reset = 1;
+}
+
 /* ------------------------------------------------------------------------- *
  *
  * initialization helper functions
@@ -1659,6 +1688,7 @@
 	.fb_imageblit 	= rivafb_imageblit,
 	.fb_cursor	= rivafb_cursor,	
 	.fb_sync 	= rivafb_sync,
+	.fb_state_switch= rivafb_state_switch,
 };
 
 static int __devinit riva_set_fbinfo(struct fb_info *info)
@@ -1758,10 +1788,18 @@
 #else
 	/* XXX use other methods later */
 #ifdef CONFIG_FB_RIVA_I2C
+	int i;
+
 	struct riva_par *par = (struct riva_par *) info->par;
 
 	riva_create_i2c_busses(par);
-	riva_probe_i2c_connector(par, 1, &par->EDID);
+	for (i = par->bus; i >= 1; i--) {
+		riva_probe_i2c_connector(par, i, &par->EDID);
+		if (par->EDID) {
+			printk("rivafb: Found EDID Block from BUS %i\n", i);
+			break;
+		}
+	}
 	riva_delete_i2c_busses(par);
 #endif
 #endif
@@ -1872,6 +1910,7 @@
 			goto err_out_free_nv3_pramin;
 		}
 		rivafb_fix.accel = FB_ACCEL_NV3;
+		default_par->bus = 1;
 		break;
 	case NV_ARCH_04:
 	case NV_ARCH_10:
@@ -1879,6 +1918,7 @@
 		default_par->riva.PCRTC0 = (unsigned *)(default_par->ctrl_base + 0x00600000);
 		default_par->riva.PRAMIN = (unsigned *)(default_par->ctrl_base + 0x00710000);
 		rivafb_fix.accel = FB_ACCEL_NV4;
+		default_par->bus = 2;
 		break;
 	}
 
@@ -1997,6 +2037,8 @@
 		iounmap((caddr_t)par->riva.PRAMIN);
 		release_mem_region(info->fix.smem_start + 0x00C00000, 0x00008000);
 	}
+	if (info->monspecs.modedb) 
+		fb_destroy_modedb(info->monspecs.modedb);
 	kfree(info->pixmap.addr);
 	kfree(par);
 	kfree(info);
diff -Naur linux-2.6.7-mm1-orig/drivers/video/riva/rivafb.h linux-2.6.7-mm1/drivers/video/riva/rivafb.h
--- linux-2.6.7-mm1-orig/drivers/video/riva/rivafb.h	2004-06-21 13:27:47.000000000 +0000
+++ linux-2.6.7-mm1/drivers/video/riva/rivafb.h	2004-06-21 18:02:22.000000000 +0000
@@ -50,6 +50,7 @@
 
 	struct riva_regs initial_state;	/* initial startup video mode */
 	struct riva_regs current_state;
+	struct riva_regs save_state;
 	struct vgastate state;
 	atomic_t ref_count;
 	u32 cursor_data[32 * 32/4];
@@ -60,6 +61,8 @@
 	Bool SecondCRTC;
 	int FlatPanel;
 	struct pci_dev *pdev;
+	int bus;
+	int reset;
 #ifdef CONFIG_MTRR
 	struct { int vram; int vram_valid; } mtrr;
 #endif
diff -Naur linux-2.6.7-mm1-orig/include/linux/console.h linux-2.6.7-mm1/include/linux/console.h
--- linux-2.6.7-mm1-orig/include/linux/console.h	2004-06-21 13:27:00.000000000 +0000
+++ linux-2.6.7-mm1/include/linux/console.h	2004-06-21 18:03:12.000000000 +0000
@@ -50,6 +50,7 @@
 	void	(*con_invert_region)(struct vc_data *, u16 *, int);
 	u16    *(*con_screen_pos)(struct vc_data *, int);
 	unsigned long (*con_getxy)(struct vc_data *, unsigned long, int *, int *);
+	void    (*con_notify)(struct vc_data *, struct vc_data *);
 };
 
 extern const struct consw *conswitchp;
diff -Naur linux-2.6.7-mm1-orig/include/linux/fb.h linux-2.6.7-mm1/include/linux/fb.h
--- linux-2.6.7-mm1-orig/include/linux/fb.h	2004-06-21 18:01:10.000000000 +0000
+++ linux-2.6.7-mm1/include/linux/fb.h	2004-06-21 22:42:14.244562096 +0000
@@ -501,6 +501,9 @@
 
 	/* perform fb specific mmap */
 	int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
+
+	/* hardware state change */
+	void (*fb_state_switch)(struct fb_info *info, int out, int vc_mode);
 };
 
 /* FBINFO_* = fb_info.flags bit flags */




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

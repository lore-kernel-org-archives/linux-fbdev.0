From: Antonino Daplas <adaplas@subdimension.com>
Subject: Re: [PATCH 5/5]: fbcon module unloading
Date: 16 Feb 2003 14:23:44 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045376614.2755.4.camel@localhost.localdomain>
References: <1045375704.1823.79.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3qEHLY2Qm0LYXkT9O4qX"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kIDP-0008Ij-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Feb 2003 22:23:51 -0800
In-Reply-To: <1045375704.1823.79.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-3qEHLY2Qm0LYXkT9O4qX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2003-02-16 at 14:09, Antonino Daplas wrote:
> Attached is a rediff (linux-2.5.61 + James' fbdev.diff) to enable fbcon module unloading.
> 

Oops.  Please disregard the previous patch.  Attached is an updated
diff.

Tony

--=-3qEHLY2Qm0LYXkT9O4qX
Content-Disposition: attachment; filename=fbcon_unload.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=fbcon_unload.diff; charset=ANSI_X3.4-1968

diff -Naur linux-2.5.61-fbdev/drivers/char/vt.c linux-2.5.61-ad/drivers/cha=
r/vt.c
--- linux-2.5.61-fbdev/drivers/char/vt.c	2003-02-16 00:55:52.000000000 +000=
0
+++ linux-2.5.61-ad/drivers/char/vt.c	2003-02-16 06:17:36.000000000 +0000
@@ -109,6 +109,7 @@
=20
=20
 const struct consw *conswitchp;
+const struct consw *defcsw =3D NULL; /* for recovery of default console */
=20
 /* A bitmap for codes <32. A bit of 1 indicates that the code
  * corresponding to that bit number invokes some special action
@@ -2571,10 +2572,14 @@
 	int i, j =3D -1;
 	const char *desc;
=20
+	if (deflt && defcsw !=3D NULL)
+		return;
 	desc =3D csw->con_startup();
 	if (!desc) return;
-	if (deflt)
+	if (deflt) {
+		defcsw =3D conswitchp;
 		conswitchp =3D csw;
+	}
=20
 	for (i =3D first; i <=3D last; i++) {
 		int old_was_color;
@@ -2616,11 +2621,78 @@
=20
 void give_up_console(const struct consw *csw)
 {
-	int i;
+	const char *desc;
+	int i, j =3D -1, first =3D -1, last =3D -1;
=20
-	for(i =3D 0; i < MAX_NR_CONSOLES; i++)
-		if (con_driver_map[i] =3D=3D csw)
+	for(i =3D 0; i < MAX_NR_CONSOLES; i++) {
+		if (con_driver_map[i] =3D=3D csw) {
+			if (first =3D=3D -1)
+				first =3D i;
+			last =3D i;
 			con_driver_map[i] =3D NULL;
+		}
+	}
+
+	if (defcsw =3D=3D NULL)
+		return;
+	conswitchp =3D defcsw;
+	defcsw =3D NULL;
+
+	desc =3D conswitchp->con_startup();
+	if (!desc) return;
+
+	for (i =3D first; i <=3D last; i++) {
+		int old_was_color;
+		int currcons =3D i;
+
+		con_driver_map[i] =3D conswitchp;
+
+		if (!vc_cons[i].d || !vc_cons[i].d->vc_sw)
+			continue;
+		j =3D i;
+		if (IS_VISIBLE)
+			save_screen(i);
+		old_was_color =3D vc_cons[i].d->vc_can_do_color;
+		vc_cons[i].d->vc_sw->con_deinit(vc_cons[i].d);
+		visual_init(i, 0);
+		set_origin(i);
+
+		/*
+		 * partial reset_terminal()
+		 */
+		top =3D 0;
+		bottom =3D video_num_lines;
+		gotoxy(i, x, y);
+		save_cur(i);
+		update_attr(i);
+
+
+		/* If the console changed between mono <-> color, then
+		 * the attributes in the screenbuf will be wrong.  The
+		 * following resets all attributes to something sane.
+		 */
+		if (old_was_color !=3D vc_cons[i].d->vc_can_do_color ||
+		    IS_VISIBLE)
+			clear_buffer_attributes(i);
+
+		if (IS_VISIBLE)
+			update_screen(i);
+		if (vc_cons[i].d->vc_tty) {
+			kill_pg(vc_cons[i].d->vc_tty->pgrp, SIGWINCH, 1);
+			vc_cons[i].d->vc_tty->winsize.ws_col =3D=20
+				video_num_columns;
+			vc_cons[i].d->vc_tty->winsize.ws_row =3D=20
+				video_num_lines;
+		}
+	}
+	printk("Console: switching ");
+	if (j >=3D 0)
+		printk("to %s %s %dx%d\n",
+		       vc_cons[j].d->vc_can_do_color ? "colour" : "mono",
+		       desc, vc_cons[j].d->vc_cols, vc_cons[j].d->vc_rows);
+	else
+		printk("to %s\n", desc);
+
 }
=20
 #endif
diff -Naur linux-2.5.61-fbdev/drivers/video/console/Kconfig linux-2.5.61-ad=
/drivers/video/console/Kconfig
--- linux-2.5.61-fbdev/drivers/video/console/Kconfig	2003-02-16 00:49:23.00=
0000000 +0000
+++ linux-2.5.61-ad/drivers/video/console/Kconfig	2003-02-16 06:17:36.00000=
0000 +0000
@@ -106,6 +106,19 @@
 	tristate "Framebuffer Console support"
 	depends on FB
=20
+config FRAMEBUFFER_CONSOLE_UNLOAD
+	bool "Allow Framebuffer Console Module Unloading (DANGEROUS)"
+	depends on FRAMEBUFFER_CONSOLE=3Dm
+	default n
+	---help---
+          If you say Y, the framebuffer console module can be unloaded=20
+          and the console reverted to the default console driver that was
+          loaded at boot time.  Not all drivers support unloading, and eve=
n
+          if it does, it might leave you with a corrupted display.
+
+          Unless you are a framebuffer driver developer, or you really kno=
w
+          what you're doing, say N here.
+
 config PCI_CONSOLE
 	bool
 	depends on FRAMEBUFFER_CONSOLE
diff -Naur linux-2.5.61-fbdev/drivers/video/console/fbcon.c linux-2.5.61-ad=
/drivers/video/console/fbcon.c
--- linux-2.5.61-fbdev/drivers/video/console/fbcon.c	2003-02-16 00:55:52.00=
0000000 +0000
+++ linux-2.5.61-ad/drivers/video/console/fbcon.c	2003-02-16 06:18:29.00000=
0000 +0000
@@ -146,6 +146,7 @@
 static int vbl_cursor_cnt;
 static int cursor_on;
 static int cursor_blink_rate;
+static int irqres =3D 1;
=20
 static inline void cursor_undrawn(void)
 {
@@ -199,6 +200,23 @@
 static void fbcon_bmove_rec(struct display *p, int sy, int sx, int dy,
 			    int dx, int height, int width, u_int y_break);
=20
+/*
+ * fbcon module unloading=20
+ */
+
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_UNLOAD
+static void __init fbcon_mod_unload(struct fb_info *info)
+{
+	if (!info->fbops->fb_release)
+		__unsafe(THIS_MODULE);
+}
+#else
+static void __init fbcon_mod_unload(struct fb_info *info)
+{
+	__unsafe(THIS_MODULE);
+}
+#endif /* CONFIG_FRAMEBUFFER_CONSOLE_UNLOAD */
+
 #ifdef CONFIG_MAC
 /*
  * On the Macintoy, there may or may not be a working VBL int. We need to =
probe
@@ -580,7 +598,7 @@
 	struct fb_info *info;
 	struct vc_data *vc;
 	static int done =3D 0;
-	int irqres =3D 1;
+	int i;
=20
 	/*
 	 *  If num_registered_fb is zero, this is a call for the dummy part.
@@ -590,8 +608,11 @@
 		return display_desc;
 	done =3D 1;
=20
-	info =3D registered_fb[num_registered_fb-1];=09
-	if (!info)	return NULL;
+	for (i =3D 0; i < FB_MAX; i++) {
+		info =3D registered_fb[i];=09
+		if (info !=3D NULL)
+			break;
+	}
 	info->currcon =3D -1;
 =09
 	owner =3D info->fbops->owner;
@@ -2558,19 +2579,89 @@
=20
 int __init fb_console_init(void)
 {
+	struct fb_info *info =3D NULL;
+	int i, unit =3D 0;
+
 	if (!num_registered_fb)
 		return -ENODEV;
+	for (i =3D 0; i < FB_MAX; i++) {
+		info =3D registered_fb[i];
+		if (info !=3D NULL) {
+			unit =3D i;
+			break;
+		}
+	}
+	for (i =3D 0; i < MAX_NR_CONSOLES; i++)
+		con2fb_map[i] =3D unit;
 	take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default);
+	fbcon_mod_unload(info);
+	return 0;
+}
+
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_UNLOAD
+static int __exit fbcon_exit(void)=20
+{
+	struct fb_info *info;
+	int i, j, mapped;
+
+	for (i =3D 0; i < FB_MAX; i++) {
+		info =3D registered_fb[i];
+		if (info !=3D NULL && !info->fbops->fb_release)
+			return -EINVAL;
+	}
+
+	if (irqres) {
+		del_timer_sync(&cursor_timer);
+	} else {
+#ifdef CONFIG_AMIGA
+		if (MACH_IS_AMIGA)=20
+			free_irq(IRQ_AMIGA_VERTB, fbcon_vbl_handler);
+#endif				/* CONFIG_AMIGA */
+#ifdef CONFIG_ATARI
+		if (MACH_IS_ATARI)=20
+			free_irq(IRQ_AUTO_4, fbcon_vbl_handler);
+#endif				/* CONFIG_ATARI */
+#ifdef CONFIG_MAC
+		if (MACH_IS_MAC && vbl_detected)=20
+			free_irq(IRQ_MAC_VBL, fbcon_vbl_handler);
+#endif				/* CONFIG_MAC */
+#if defined(__arm__) && defined(IRQ_VSYNCPULSE)
+		free_irq(IRQ_VSYNCPULSE, fbcon_vbl_handler);
+#endif
+	}
+	if (softback_buf)=20
+		kfree((void *) softback_buf);
+
+	for (i =3D 0; i < FB_MAX; i++) {
+		mapped =3D 0;
+		info =3D registered_fb[i];
+		if (info =3D=3D NULL)
+			continue;
+		for (j =3D 0; j < MAX_NR_CONSOLES; j++) {
+			if (con2fb_map[j] =3D=3D i) {
+				con2fb_map[j] =3D -1;
+				mapped =3D 1;
+			}
+		}
+		if (mapped) {
+			info->fbops->fb_release(info, 0);=20
+			module_put(info->fbops->owner);
+			kfree(info->display_fg);
+		}
+	}
 	return 0;
 }
=20
 void __exit fb_console_exit(void)
 {
+	if (fbcon_exit())
+		return;
 	give_up_console(&fb_con);
 }=09
+module_exit(fb_console_exit);
+#endif /* CONFIG_FRAMEBUFFER_CONSOLE_UNLOAD */
=20
 module_init(fb_console_init);
-module_exit(fb_console_exit);
=20
 /*
  *  Visible symbols for modules

--=-3qEHLY2Qm0LYXkT9O4qX--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

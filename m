From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 6/6] fbdev: Cleanups in drivers/video part 2
Date: Sun, 13 Mar 2005 08:34:59 +0800
Message-ID: <200503130834.59164.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAH5y-0003qT-4L
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 16:36:38 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAH5x-0008S7-6F
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 16:36:37 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 153BD14AD9FE
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Mar 2005 00:36:31 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Adrian Bunk <bunk@stusta.de>

  This patch contains cleanups under drivers/video/ including:
  - make some needlessly global code static
  - the following was needlessly EXPORT_SYMBOL'ed:
    - fbcon.c: fb_con
    - fbmon.c: get_EDID_from_firmware (completely unused)

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 arch/frv/kernel/setup.c        |    3 ---
 drivers/video/console/fbcon.c  |   26 ++++++++++++--------------
 drivers/video/console/fbcon.h  |    1 -
 drivers/video/console/mdacon.c |    4 ++--
 drivers/video/fbmon.c          |   20 +-------------------
 drivers/video/modedb.c         |    4 ++--
 drivers/video/vga16fb.c        |   24 ++++++++++++------------
 include/linux/console.h        |    1 -
 8 files changed, 29 insertions(+), 54 deletions(-)

diff -Nru a/arch/frv/kernel/setup.c b/arch/frv/kernel/setup.c
--- a/arch/frv/kernel/setup.c	2005-03-12 22:25:57 +08:00
+++ b/arch/frv/kernel/setup.c	2005-03-13 03:12:36 +08:00
@@ -65,9 +65,6 @@
 
 #ifdef CONFIG_CONSOLE
 extern struct consw *conswitchp;
-#ifdef CONFIG_FRAMEBUFFER
-extern struct consw fb_con;
-#endif
 #endif
 
 #ifdef CONFIG_MB93090_MB00
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-03-10 06:29:05 +08:00
+++ b/drivers/video/console/fbcon.c	2004-11-21 22:54:54 +08:00
@@ -107,15 +107,15 @@
 };
 
 struct display fb_display[MAX_NR_CONSOLES];
-signed char con2fb_map[MAX_NR_CONSOLES];
-signed char con2fb_map_boot[MAX_NR_CONSOLES];
+static signed char con2fb_map[MAX_NR_CONSOLES];
+static signed char con2fb_map_boot[MAX_NR_CONSOLES];
 static int logo_height;
 static int logo_lines;
 /* logo_shown is an index to vc_cons when >= 0; otherwise follows FBCON_LOGO
    enums.  */
 static int logo_shown = FBCON_LOGO_CANSHOW;
 /* Software scrollback */
-int fbcon_softback_size = 32768;
+static int fbcon_softback_size = 32768;
 static unsigned long softback_buf, softback_curr;
 static unsigned long softback_in;
 static unsigned long softback_top, softback_end;
@@ -130,6 +130,8 @@
 /* current fb_info */
 static int info_idx = -1;
 
+static const struct consw fb_con;
+
 #define CM_SOFTBACK	(8)
 
 #define advance_row(p, delta) (unsigned short *)((unsigned long)(p) + (delta) * vc->vc_size_row)
@@ -309,7 +311,8 @@
 	mod_timer(&ops->cursor_timer, jiffies + HZ/5);
 }
 
-int __init fb_console_setup(char *this_opt)
+#ifndef MODULE
+static int __init fb_console_setup(char *this_opt)
 {
 	char *options;
 	int i, j;
@@ -363,6 +366,7 @@
 }
 
 __setup("fbcon=", fb_console_setup);
+#endif
 
 static int search_fb_in_map(int idx)
 {
@@ -1117,7 +1121,7 @@
 static int scrollback_max = 0;
 static int scrollback_current = 0;
 
-int update_var(int con, struct fb_info *info)
+static int update_var(int con, struct fb_info *info)
 {
 	if (con == ((struct fbcon_ops *)info->fbcon_par)->currcon)
 		return fb_pan_display(info, &info->var);
@@ -2724,7 +2728,7 @@
  *  The console `switch' structure for the frame buffer based console
  */
 
-const struct consw fb_con = {
+static const struct consw fb_con = {
 	.owner			= THIS_MODULE,
 	.con_startup 		= fbcon_startup,
 	.con_init 		= fbcon_init,
@@ -2754,7 +2758,7 @@
 	.notifier_call	= fbcon_event_notify,
 };
 
-int __init fb_console_init(void)
+static int __init fb_console_init(void)
 {
 	int i;
 
@@ -2782,7 +2786,7 @@
 
 #ifdef MODULE
 
-void __exit fb_console_exit(void)
+static void __exit fb_console_exit(void)
 {
 	acquire_console_sem();
 	fb_unregister_client(&fbcon_event_notifier);
@@ -2793,11 +2797,5 @@
 module_exit(fb_console_exit);
 
 #endif
-
-/*
- *  Visible symbols for modules
- */
-
-EXPORT_SYMBOL(fb_con);
 
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	2005-03-10 06:29:05 +08:00
+++ b/drivers/video/console/fbcon.h	2004-11-21 22:26:19 +08:00
@@ -157,7 +157,6 @@
 #define SCROLL_REDRAW	   0x004
 #define SCROLL_PAN_REDRAW  0x005
 
-extern int fb_console_init(void);
 #ifdef CONFIG_FB_TILEBLITTING
 extern void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info,
 			      struct display *p, struct fbcon_ops *ops);
diff -Nru a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
--- a/drivers/video/console/mdacon.c	2005-03-12 23:24:13 +08:00
+++ b/drivers/video/console/mdacon.c	2004-11-21 22:28:21 +08:00
@@ -564,7 +564,7 @@
  *  The console `switch' structure for the MDA based console
  */
 
-const struct consw mda_con = {
+static const struct consw mda_con = {
 	.owner =		THIS_MODULE,
 	.con_startup =		mdacon_startup,
 	.con_init =		mdacon_init,
@@ -591,7 +591,7 @@
 	return take_over_console(&mda_con, mda_first_vc-1, mda_last_vc-1, 0);
 }
 
-void __exit mda_console_exit(void)
+static void __exit mda_console_exit(void)
 {
 	give_up_console(&mda_con);
 }
diff -Nru a/drivers/video/fbmon.c b/drivers/video/fbmon.c
--- a/drivers/video/fbmon.c	2005-03-12 23:23:02 +08:00
+++ b/drivers/video/fbmon.c	2005-03-13 03:11:38 +08:00
@@ -74,10 +74,9 @@
 	},
 };
 
-const unsigned char edid_v1_header[] = { 0x00, 0xff, 0xff, 0xff,
+static const unsigned char edid_v1_header[] = { 0x00, 0xff, 0xff, 0xff,
 	0xff, 0xff, 0xff, 0x00
 };
-const unsigned char edid_v1_descriptor_flag[] = { 0x00, 0x00 };
 
 static void copy_string(unsigned char *c, unsigned char *s)
 {
@@ -872,18 +871,6 @@
 	DPRINTK("========================================\n");
 }
 
-char *get_EDID_from_firmware(struct device *dev)
-{
-	unsigned char *pedid = NULL;
-
-#if defined(CONFIG_EDID_FIRMWARE) && defined(CONFIG_X86)
-	pedid = edid_info.dummy;
-	if (!pedid)
-		return NULL;
-#endif
-	return pedid;
-}
-
 /* 
  * VESA Generalized Timing Formula (GTF) 
  */
@@ -1193,10 +1180,6 @@
 {
 	specs = NULL;
 }
-char *get_EDID_from_firmware(struct device *dev)
-{
-	return NULL;
-}
 void fb_destroy_modedb(struct fb_videomode *modedb)
 {
 }
@@ -1270,7 +1253,6 @@
 
 EXPORT_SYMBOL(fb_parse_edid);
 EXPORT_SYMBOL(fb_edid_to_monspecs);
-EXPORT_SYMBOL(get_EDID_from_firmware);
 
 EXPORT_SYMBOL(fb_get_mode);
 EXPORT_SYMBOL(fb_validate_mode);
diff -Nru a/drivers/video/modedb.c b/drivers/video/modedb.c
--- a/drivers/video/modedb.c	2005-03-12 23:23:14 +08:00
+++ b/drivers/video/modedb.c	2005-02-11 23:49:36 +08:00
@@ -404,8 +404,8 @@
  *
  */
 
-int fb_try_mode(struct fb_var_screeninfo *var, struct fb_info *info,
-		const struct fb_videomode *mode, unsigned int bpp)
+static int fb_try_mode(struct fb_var_screeninfo *var, struct fb_info *info,
+		       const struct fb_videomode *mode, unsigned int bpp)
 {
     int err = 0;
 
diff -Nru a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
--- a/drivers/video/vga16fb.c	2005-03-12 23:23:42 +08:00
+++ b/drivers/video/vga16fb.c	2004-11-21 22:38:46 +08:00
@@ -874,7 +874,7 @@
 	return 0;
 }
 
-void vga_8planes_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+static void vga_8planes_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
 	u32 dx = rect->dx, width = rect->width;
         char oldindex = getindex();
@@ -928,7 +928,7 @@
         setindex(oldindex);
 }
 
-void vga16fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+static void vga16fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
 	int x, x2, y2, vxres, vyres, width, height, line_ofs;
 	char __iomem *dst;
@@ -1003,7 +1003,7 @@
 	}
 }
 
-void vga_8planes_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+static void vga_8planes_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
         char oldindex = getindex();
         char oldmode = setmode(0x41);
@@ -1058,7 +1058,7 @@
         setindex(oldindex);
 }
 
-void vga16fb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+static void vga16fb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
 	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy; 
 	int x, x2, y2, old_dx, old_dy, vxres, vyres;
@@ -1166,7 +1166,7 @@
 #endif
 #endif
 
-void vga_8planes_imageblit(struct fb_info *info, const struct fb_image *image)
+static void vga_8planes_imageblit(struct fb_info *info, const struct fb_image *image)
 {
         char oldindex = getindex();
         char oldmode = setmode(0x40);
@@ -1197,7 +1197,7 @@
         setindex(oldindex);
 }
 
-void vga_imageblit_expand(struct fb_info *info, const struct fb_image *image)
+static void vga_imageblit_expand(struct fb_info *info, const struct fb_image *image)
 {
 	char __iomem *where = info->screen_base + (image->dx/8) +
 		image->dy * info->fix.line_length;
@@ -1261,7 +1261,7 @@
 	}
 }
 
-void vga_imageblit_color(struct fb_info *info, const struct fb_image *image) 
+static void vga_imageblit_color(struct fb_info *info, const struct fb_image *image)
 {
 	/*
 	 * Draw logo 
@@ -1306,7 +1306,7 @@
 	}
 }
 				
-void vga16fb_imageblit(struct fb_info *info, const struct fb_image *image)
+static void vga16fb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	if (image->depth == 1)
 		vga_imageblit_expand(info, image);
@@ -1329,7 +1329,8 @@
 	.fb_cursor      = soft_cursor,
 };
 
-int vga16fb_setup(char *options)
+#ifndef MODULE
+static int vga16fb_setup(char *options)
 {
 	char *this_opt;
 	
@@ -1341,8 +1342,9 @@
 	}
 	return 0;
 }
+#endif
 
-int __init vga16fb_init(void)
+static int __init vga16fb_init(void)
 {
 	int i;
 	int ret;
@@ -1427,9 +1429,7 @@
     /* XXX unshare VGA regions */
 }
 
-#ifdef MODULE
 MODULE_LICENSE("GPL");
-#endif
 module_init(vga16fb_init);
 module_exit(vga16fb_exit);
 
diff -Nru a/include/linux/console.h b/include/linux/console.h
--- a/include/linux/console.h	2005-03-13 00:37:37 +08:00
+++ b/include/linux/console.h	2004-11-21 22:20:46 +08:00
@@ -59,7 +59,6 @@
 extern const struct consw *conswitchp;
 
 extern const struct consw dummy_con;	/* dummy console buffer */
-extern const struct consw fb_con;	/* frame buffer based console */
 extern const struct consw vga_con;	/* VGA text console */
 extern const struct consw newport_con;	/* SGI Newport console  */
 extern const struct consw prom_con;	/* SPARC PROM console */





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

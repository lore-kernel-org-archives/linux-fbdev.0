From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 10/10] fbdev: Cleanups in driver/video
Date: Sun, 6 Mar 2005 08:17:04 +0800
Message-ID: <200503060817.05006.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7jUw-00075T-Ph
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:19:54 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D7jUv-0000G9-6e
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:19:54 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id CF9EF147878C
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  6 Mar 2005 00:19:42 +0000 (UTC)
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

  This patch contains cleanups including the following:
  - make needlessly global code static
  - remove the needlessly #ifdef MODULE from several module_exit
  - remove or #if 0 the following unused global functions:
    - fbmon.c: fb_create_modedb
    - fbmon.c: fb_get_monitor_limits
    - nvidia/nv_i2c.c: nvidia_delete_i2c_busses
    - nvidia/nv_setup.c: NVEnablePalette
    - nvidia/nv_setup.c: NVReadDacMask
  - remove the following unneeded EXPORT_SYMBOL's:
    - fbmon.c: fb_create_modedb
    - fbmon.c: fb_get_monitor_limits
    - hgafb.c: hgafb_setup

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/aty128fb.c        |   13 +-----
 drivers/video/aty/atyfb.h           |    1
 drivers/video/aty/atyfb_base.c      |   14 +++---
 drivers/video/aty/mach64_ct.c       |    7 ++-
 drivers/video/aty/mach64_cursor.c   |    2
 drivers/video/aty/radeon_base.c     |   46 ++++++++++------------
 drivers/video/aty/radeon_pm.c       |    4 -
 drivers/video/aty/radeonfb.h        |    1
 drivers/video/backlight/backlight.c |    2
 drivers/video/backlight/lcd.c       |    2
 drivers/video/cyber2000fb.c         |    6 +-
 drivers/video/fbmem.c               |    9 +---
 drivers/video/fbmon.c               |   14 ------
 drivers/video/geode/gx1fb_core.c    |    4 -
 drivers/video/hgafb.c               |   14 +-----
 drivers/video/i810/i810_main.c      |    2
 drivers/video/imsttfb.c             |    7 +--
 drivers/video/intelfb/intelfbdrv.c  |   73 ++++++++++++++++--------------------
 drivers/video/intelfb/intelfbdrv.h  |    2
 drivers/video/neofb.c               |   16 ++++---
 drivers/video/nvidia/nv_accel.c     |    4 -
 drivers/video/nvidia/nv_i2c.c       |    2
 drivers/video/nvidia/nv_of.c        |    1
 drivers/video/nvidia/nv_proto.h     |    5 --
 drivers/video/nvidia/nv_setup.c     |    4 +
 drivers/video/nvidia/nvidia.c       |    4 -
 drivers/video/pm2fb.c               |   60 ++++++++++-------------------
 drivers/video/radeonfb.c            |   44 +++++++++------------
 drivers/video/riva/fbdev.c          |    8 +--
 drivers/video/tdfxfb.c              |   51 +++++++++++--------------
 drivers/video/vesafb.c              |   12 -----
 drivers/video/vfb.c                 |   12 +----
 include/linux/fb.h                  |    3 -
 33 files changed, 190 insertions(+), 259 deletions(-)

diff -Nru a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c	2005-03-05 00:18:23 +08:00
+++ b/drivers/video/aty/aty128fb.c	2005-03-01 09:59:50 +08:00
@@ -425,11 +425,6 @@
 
 #define round_div(n, d) ((n+(d/2))/d)
 
-    /*
-     *  Interface used by the world
-     */
-int aty128fb_init(void);
-
 static int aty128fb_check_var(struct fb_var_screeninfo *var,
 			      struct fb_info *info);
 static int aty128fb_set_par(struct fb_info *info);
@@ -1648,7 +1643,8 @@
 	return 0;
 }
 
-int __init aty128fb_setup(char *options)
+#ifndef MODULE
+static int __init aty128fb_setup(char *options)
 {
 	char *this_opt;
 
@@ -1701,6 +1697,7 @@
 	}
 	return 0;
 }
+#endif  /*  MODULE  */
 
 
 /*
@@ -2454,7 +2451,7 @@
 }
 
 
-int __init aty128fb_init(void)
+static int __init aty128fb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -2474,7 +2471,6 @@
 
 module_init(aty128fb_init);
 
-#ifdef MODULE
 module_exit(aty128fb_exit);
 
 MODULE_AUTHOR("(c)1999-2003 Brad Douglas <brad@neruo.com>");
@@ -2485,6 +2481,5 @@
 #ifdef CONFIG_MTRR
 module_param_named(nomtrr, mtrr, invbool, 0);
 MODULE_PARM_DESC(nomtrr, "bool: Disable MTRR support (0 or 1=disabled) (default=0)");
-#endif
 #endif
 
diff -Nru a/drivers/video/aty/atyfb.h b/drivers/video/aty/atyfb.h
--- a/drivers/video/aty/atyfb.h	2005-01-12 06:10:17 +08:00
+++ b/drivers/video/aty/atyfb.h	2005-03-01 09:21:51 +08:00
@@ -334,7 +334,6 @@
      */
 
 extern int aty_init_cursor(struct fb_info *info);
-extern int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor);
 
     /*
      *  Hardware acceleration
diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	2005-03-05 00:18:23 +08:00
+++ b/drivers/video/aty/atyfb_base.c	2005-03-01 09:59:45 +08:00
@@ -265,7 +265,7 @@
      *  Interface used by the world
      */
 
-struct fb_var_screeninfo default_var = {
+static struct fb_var_screeninfo default_var = {
 	/* 640x480, 60 Hz, Non-Interlaced (25.175 MHz dotclock) */
 	640, 480, 640, 480, 0, 0, 8, 0,
 	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
@@ -2990,7 +2990,7 @@
 
 #ifdef __i386__
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
-void aty_init_lcd(struct atyfb_par *par, u32 bios_base)
+static void aty_init_lcd(struct atyfb_par *par, u32 bios_base)
 {
 	u32 driv_inf_tab, sig;
 	u16 lcd_ofs;
@@ -3589,7 +3589,8 @@
 
 #endif /* CONFIG_PCI */
 
-int __init atyfb_setup(char *options)
+#ifndef MODULE
+static int __init atyfb_setup(char *options)
 {
 	char *this_opt;
 
@@ -3657,8 +3658,9 @@
 	}
 	return 0;
 }
+#endif  /*  MODULE  */
 
-int __init atyfb_init(void)
+static int __init atyfb_init(void)
 {
 #ifndef MODULE
     char *option = NULL;
@@ -3677,7 +3679,7 @@
     return 0;
 }
 
-void __exit atyfb_exit(void)
+static void __exit atyfb_exit(void)
 {
 #ifdef CONFIG_PCI
 	pci_unregister_driver(&atyfb_driver);
@@ -3685,9 +3687,7 @@
 }
 
 module_init(atyfb_init);
-#ifdef MODULE
 module_exit(atyfb_exit);
-#endif
 
 MODULE_DESCRIPTION("FBDev driver for ATI Mach64 cards");
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/video/aty/mach64_ct.c b/drivers/video/aty/mach64_ct.c
--- a/drivers/video/aty/mach64_ct.c	2004-10-27 14:58:07 +08:00
+++ b/drivers/video/aty/mach64_ct.c	2005-03-06 06:45:07 +08:00
@@ -359,7 +359,8 @@
 #endif
 }
 
-void __init aty_get_pll_ct(const struct fb_info *info, union aty_pll *pll)
+static void __init aty_get_pll_ct(const struct fb_info *info,
+				  union aty_pll *pll)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u8 tmp, clock;
@@ -382,7 +383,9 @@
 	}
 }
 
-int __init aty_init_pll_ct(const struct fb_info *info, union aty_pll *pll) {
+static int __init aty_init_pll_ct(const struct fb_info *info,
+				 union aty_pll *pll)
+{
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u8 mpost_div, xpost_div, sclk_post_div_real, sclk_fb_div, spll_cntl2;
 	u32 q, i, memcntl, trp;
diff -Nru a/drivers/video/aty/mach64_cursor.c b/drivers/video/aty/mach64_cursor.c
--- a/drivers/video/aty/mach64_cursor.c	2004-11-17 18:15:17 +08:00
+++ b/drivers/video/aty/mach64_cursor.c	2005-03-01 09:22:10 +08:00
@@ -71,7 +71,7 @@
 	0xa8, 0x28, 0x88, 0x08, 0xa0, 0x20, 0x80, 0x00
 };
 
-int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
+static int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u16 xoff, yoff;
diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	2005-03-05 00:18:23 +08:00
+++ b/drivers/video/aty/radeon_base.c	2005-03-01 10:00:55 +08:00
@@ -1139,7 +1139,8 @@
 }
 
 
-void radeon_save_state (struct radeonfb_info *rinfo, struct radeon_regs *save)
+static void radeon_save_state (struct radeonfb_info *rinfo,
+			       struct radeon_regs *save)
 {
 	/* CRTC regs */
 	save->crtc_gen_cntl = INREG(CRTC_GEN_CNTL);
@@ -2486,27 +2487,8 @@
 #endif /* CONFIG_PM */
 };
 
-int __init radeonfb_setup (char *options);
-
-int __init radeonfb_init (void)
-{
 #ifndef MODULE
-	char *option = NULL;
-
-	if (fb_get_options("radeonfb", &option))
-		return -ENODEV;
-	radeonfb_setup(option);
-#endif
-	return pci_module_init (&radeonfb_driver);
-}
-
-
-void __exit radeonfb_exit (void)
-{
-	pci_unregister_driver (&radeonfb_driver);
-}
-
-int __init radeonfb_setup (char *options)
+static int __init radeonfb_setup (char *options)
 {
 	char *this_opt;
 
@@ -2540,12 +2522,28 @@
 	}
 	return 0;
 }
+#endif  /*  MODULE  */
 
-module_init(radeonfb_init);
+static int __init radeonfb_init (void)
+{
+#ifndef MODULE
+	char *option = NULL;
 
-#ifdef MODULE
-module_exit(radeonfb_exit);
+	if (fb_get_options("radeonfb", &option))
+		return -ENODEV;
+	radeonfb_setup(option);
 #endif
+	return pci_module_init (&radeonfb_driver);
+}
+
+
+static void __exit radeonfb_exit (void)
+{
+	pci_unregister_driver (&radeonfb_driver);
+}
+
+module_init(radeonfb_init);
+module_exit(radeonfb_exit);
 
 MODULE_AUTHOR("Ani Joshi");
 MODULE_DESCRIPTION("framebuffer driver for ATI Radeon chipset");
diff -Nru a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
--- a/drivers/video/aty/radeon_pm.c	2005-03-05 00:18:24 +08:00
+++ b/drivers/video/aty/radeon_pm.c	2005-03-01 09:31:44 +08:00
@@ -27,7 +27,7 @@
 
 #include "ati_ids.h"
 
-void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo)
+static void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo)
 {
 	u32 tmp;
 
@@ -229,7 +229,7 @@
 	radeon_msleep(16);
 }
 
-void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
+static void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
 {
 	u32 tmp;
 
diff -Nru a/drivers/video/aty/radeonfb.h b/drivers/video/aty/radeonfb.h
--- a/drivers/video/aty/radeonfb.h	2005-03-05 00:18:24 +08:00
+++ b/drivers/video/aty/radeonfb.h	2005-03-01 09:24:32 +08:00
@@ -647,7 +647,6 @@
 
 /* Other functions */
 extern int radeon_screen_blank(struct radeonfb_info *rinfo, int blank, int mode_switch);
-extern void radeon_save_state (struct radeonfb_info *rinfo, struct radeon_regs *save);
 extern void radeon_write_mode (struct radeonfb_info *rinfo, struct radeon_regs *mode,
 			       int reg_only);
 
diff -Nru a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
--- a/drivers/video/backlight/backlight.c	2005-01-15 04:10:38 +08:00
+++ b/drivers/video/backlight/backlight.c	2005-03-01 09:32:25 +08:00
@@ -111,7 +111,7 @@
 	kfree(bd);
 }
 
-struct class backlight_class = {
+static struct class backlight_class = {
 	.name = "backlight",
 	.release = backlight_class_release,
 };
diff -Nru a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
--- a/drivers/video/backlight/lcd.c	2005-01-15 04:10:38 +08:00
+++ b/drivers/video/backlight/lcd.c	2005-03-01 09:33:50 +08:00
@@ -111,7 +111,7 @@
 	kfree(ld);
 }
 
-struct class lcd_class = {
+static struct class lcd_class = {
 	.name = "lcd",
 	.release = lcd_class_release,
 };
diff -Nru a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
--- a/drivers/video/cyber2000fb.c	2005-03-05 00:18:24 +08:00
+++ b/drivers/video/cyber2000fb.c	2005-03-01 10:01:44 +08:00
@@ -1306,7 +1306,8 @@
  * Parse Cyber2000fb options.  Usage:
  *  video=cyber2000:font:fontname
  */
-int
+#ifndef MODULE
+static int
 cyber2000fb_setup(char *options)
 {
 	char *opt;
@@ -1328,6 +1329,7 @@
 	}
 	return 0;
 }
+#endif  /*  MODULE  */
 
 /*
  * The CyberPro chips can be placed on many different bus types.
@@ -1717,7 +1719,7 @@
  *
  * Tony: "module_init" is now required
  */
-int __init cyber2000fb_init(void)
+static int __init cyber2000fb_init(void)
 {
 	int ret = -1, err;
 
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2005-03-03 07:21:47 +08:00
+++ b/drivers/video/fbmem.c	2005-03-06 06:45:06 +08:00
@@ -1189,7 +1189,7 @@
  *
  */
 
-int __init
+static int __init
 fbmem_init(void)
 {
 	create_proc_read_entry("fb", 0, NULL, fbmem_read_proc, NULL);
@@ -1206,20 +1206,19 @@
 	return 0;
 }
 
-void __exit
+#ifdef MODULE
+module_init(fbmem_init);
+static void __exit
 fbmem_exit(void)
 {
 	class_simple_destroy(fb_class);
 }
 
-#ifdef MODULE
-module_init(fbmem_init);
 module_exit(fbmem_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Framebuffer base");
 #else
 subsys_initcall(fbmem_init);
-subsys_exitcall(fbmem_exit);
 #endif
 
 int fb_new_modelist(struct fb_info *info)
diff -Nru a/drivers/video/fbmon.c b/drivers/video/fbmon.c
--- a/drivers/video/fbmon.c	2005-02-01 23:21:28 +08:00
+++ b/drivers/video/fbmon.c	2005-03-01 09:41:54 +08:00
@@ -518,7 +518,7 @@
  * This function builds a mode database using the contents of the EDID
  * data
  */
-struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
+static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
 {
 	struct fb_videomode *mode, *m;
 	unsigned char *block;
@@ -593,7 +593,7 @@
 		kfree(modedb);
 }
 
-int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
+static int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
 {
 	int i, retval = 1;
 	unsigned char *block;
@@ -1197,17 +1197,9 @@
 {
 	return NULL;
 }
-struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
-{
-	return NULL;
-}
 void fb_destroy_modedb(struct fb_videomode *modedb)
 {
 }
-int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
-{
-	return 1;
-}
 int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var,
 		struct fb_info *info)
 {
@@ -1282,6 +1274,4 @@
 
 EXPORT_SYMBOL(fb_get_mode);
 EXPORT_SYMBOL(fb_validate_mode);
-EXPORT_SYMBOL(fb_create_modedb);
 EXPORT_SYMBOL(fb_destroy_modedb);
-EXPORT_SYMBOL(fb_get_monitor_limits);
diff -Nru a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
--- a/drivers/video/geode/gx1fb_core.c	2005-03-05 00:35:04 +08:00
+++ b/drivers/video/geode/gx1fb_core.c	2005-03-01 09:42:31 +08:00
@@ -264,9 +264,9 @@
 }
 
 
-struct fb_info *gx1fb_info;
+static struct fb_info *gx1fb_info;
 
-int __init gx1fb_init(void)
+static int __init gx1fb_init(void)
 {
 	struct fb_info *info;
         struct geodefb_par *par;
diff -Nru a/drivers/video/hgafb.c b/drivers/video/hgafb.c
--- a/drivers/video/hgafb.c	2005-01-15 04:01:47 +08:00
+++ b/drivers/video/hgafb.c	2005-03-01 09:43:41 +08:00
@@ -412,7 +412,8 @@
  *	A zero is returned on success and %-EINVAL for failure.
  */
 
-int hgafb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
+static int hgafb_pan_display(struct fb_var_screeninfo *var,
+			     struct fb_info *info)
 {
 	if (var->vmode & FB_VMODE_YWRAP) {
 		if (var->yoffset < 0 || 
@@ -548,7 +549,7 @@
 	 *  Initialization
 	 */
 
-int __init hgafb_init(void)
+static int __init hgafb_init(void)
 {
 	if (fb_get_options("hgafb", NULL))
 		return -ENODEV;
@@ -584,15 +585,6 @@
 
         printk(KERN_INFO "fb%d: %s frame buffer device\n",
                fb_info.node, fb_info.fix.id);
-	return 0;
-}
-
-	/*
-	 *  Setup
-	 */
-
-int __init hgafb_setup(char *options)
-{
 	return 0;
 }
 
diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	2005-03-05 00:18:24 +08:00
+++ b/drivers/video/i810/i810_main.c	2005-03-01 09:45:32 +08:00
@@ -1997,7 +1997,7 @@
 
 #ifdef MODULE
 
-int __init i810fb_init(void)
+static int __init i810fb_init(void)
 {
 	hsync1 *= 1000;
 	hsync2 *= 1000;
diff -Nru a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
--- a/drivers/video/imsttfb.c	2004-11-23 07:50:39 +08:00
+++ b/drivers/video/imsttfb.c	2005-03-01 10:02:22 +08:00
@@ -1547,7 +1547,7 @@
 }
 
 #ifndef MODULE
-int __init 
+static int __init
 imsttfb_setup(char *options)
 {
 	char *this_opt;
@@ -1601,7 +1601,7 @@
 
 #endif /* MODULE */
 
-int __init imsttfb_init(void)
+static int __init imsttfb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -1619,9 +1619,8 @@
 	pci_unregister_driver(&imsttfb_pci_driver);
 }
 
-#ifdef MODULE
 MODULE_LICENSE("GPL");
-#endif
+
 module_init(imsttfb_init);
 module_exit(imsttfb_exit);
 
diff -Nru a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c	2005-03-05 00:18:24 +08:00
+++ b/drivers/video/intelfb/intelfbdrv.c	2005-03-01 10:04:13 +08:00
@@ -227,42 +227,6 @@
 module_param(mode, charp, S_IRUGO);
 MODULE_PARM_DESC(mode,
 		 "Initial video mode \"<xres>x<yres>[-<depth>][@<refresh>]\"");
-/***************************************************************
- *                     modules entry points                    *
- ***************************************************************/
-
-/* module load/unload entry points */
-int __init
-intelfb_init(void)
-{
-#ifndef MODULE
-	char *option = NULL;
-#endif
-
-	DBG_MSG("intelfb_init\n");
-
-	INF_MSG("Framebuffer driver for "
-		"Intel(R) " SUPPORTED_CHIPSETS " chipsets\n");
-	INF_MSG("Version " INTELFB_VERSION "\n");
-
-	if (idonly)
-		return -ENODEV;
-
-#ifndef MODULE
-	if (fb_get_options("intelfb", &option))
-		return -ENODEV;
-	intelfb_setup(option);
-#endif
-
-	return pci_module_init(&intelfb_driver);
-}
-
-static void __exit
-intelfb_exit(void)
-{
-	DBG_MSG("intelfb_exit\n");
-	pci_unregister_driver(&intelfb_driver);
-}
 
 #ifndef MODULE
 #define OPT_EQUAL(opt, name) (!strncmp(opt, name, strlen(name)))
@@ -322,7 +286,7 @@
 	return 1;
 }
 
-int __init
+static int __init
 intelfb_setup(char *options)
 {
 	char *this_opt;
@@ -374,11 +338,40 @@
 
 #endif
 
-module_init(intelfb_init);
+static int __init
+intelfb_init(void)
+{
+#ifndef MODULE
+	char *option = NULL;
+#endif
 
-#ifdef MODULE
-module_exit(intelfb_exit);
+	DBG_MSG("intelfb_init\n");
+
+	INF_MSG("Framebuffer driver for "
+		"Intel(R) " SUPPORTED_CHIPSETS " chipsets\n");
+	INF_MSG("Version " INTELFB_VERSION "\n");
+
+	if (idonly)
+		return -ENODEV;
+
+#ifndef MODULE
+	if (fb_get_options("intelfb", &option))
+		return -ENODEV;
+	intelfb_setup(option);
 #endif
+
+	return pci_module_init(&intelfb_driver);
+}
+
+static void __exit
+intelfb_exit(void)
+{
+	DBG_MSG("intelfb_exit\n");
+	pci_unregister_driver(&intelfb_driver);
+}
+
+module_init(intelfb_init);
+module_exit(intelfb_exit);
 
 /***************************************************************
  *                     mtrr support functions                  *
diff -Nru a/drivers/video/intelfb/intelfbdrv.h b/drivers/video/intelfb/intelfbdrv.h
--- a/drivers/video/intelfb/intelfbdrv.h	2005-02-15 21:06:47 +08:00
+++ b/drivers/video/intelfb/intelfbdrv.h	2005-03-06 06:45:07 +08:00
@@ -28,7 +28,7 @@
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-int __init intelfb_setup(char *options);
+static int __init intelfb_setup(char *options);
 static void __devinit get_initial_mode(struct intelfb_info *dinfo);
 static void update_dinfo(struct intelfb_info *dinfo,
 			 struct fb_var_screeninfo *var);
diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	2004-12-18 20:38:35 +08:00
+++ b/drivers/video/neofb.c	2005-03-01 10:04:44 +08:00
@@ -400,21 +400,21 @@
  */
 static int paletteEnabled = 0;
 
-inline void VGAenablePalette(void)
+static inline void VGAenablePalette(void)
 {
 	vga_r(NULL, VGA_IS1_RC);
 	vga_w(NULL, VGA_ATT_W, 0x00);
 	paletteEnabled = 1;
 }
 
-inline void VGAdisablePalette(void)
+static inline void VGAdisablePalette(void)
 {
 	vga_r(NULL, VGA_IS1_RC);
 	vga_w(NULL, VGA_ATT_W, 0x20);
 	paletteEnabled = 0;
 }
 
-inline void VGAwATTR(u8 index, u8 value)
+static inline void VGAwATTR(u8 index, u8 value)
 {
 	if (paletteEnabled)
 		index &= ~0x20;
@@ -425,7 +425,7 @@
 	vga_wattr(NULL, index, value);
 }
 
-void vgaHWProtect(int on)
+static void vgaHWProtect(int on)
 {
 	unsigned char tmp;
 
@@ -1315,7 +1315,7 @@
 /*
  *    (Un)Blank the display.
  */
-int neofb_blank(int blank_mode, struct fb_info *info)
+static int neofb_blank(int blank_mode, struct fb_info *info)
 {
 	/*
 	 *  Blank the screen if blank_mode != 0, else unblank.
@@ -2230,7 +2230,8 @@
 
 /* ************************* init in-kernel code ************************** */
 
-int __init neofb_setup(char *options)
+#ifndef MODULE
+static int __init neofb_setup(char *options)
 {
 	char *this_opt;
 
@@ -2258,8 +2259,9 @@
 	}
 	return 0;
 }
+#endif  /*  MODULE  */
 
-int __init neofb_init(void)
+static int __init neofb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
diff -Nru a/drivers/video/nvidia/nv_accel.c b/drivers/video/nvidia/nv_accel.c
--- a/drivers/video/nvidia/nv_accel.c	2005-03-05 00:35:05 +08:00
+++ b/drivers/video/nvidia/nv_accel.c	2005-03-01 09:51:05 +08:00
@@ -55,7 +55,7 @@
 	}
 }
 
-void NVDmaKickoff(struct nvidia_par *par)
+static void NVDmaKickoff(struct nvidia_par *par)
 {
 	if (par->dmaCurrent != par->dmaPut) {
 		par->dmaPut = par->dmaCurrent;
@@ -63,7 +63,7 @@
 	}
 }
 
-void NVDmaWait(struct nvidia_par *par, int size)
+static void NVDmaWait(struct nvidia_par *par, int size)
 {
 	int dmaGet;
 	int count = 1000000000, cnt;
diff -Nru a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
--- a/drivers/video/nvidia/nv_i2c.c	2005-03-05 00:45:44 +08:00
+++ b/drivers/video/nvidia/nv_i2c.c	2005-03-01 09:52:50 +08:00
@@ -146,6 +146,7 @@
 	nvidia_setup_i2c_bus(&par->chan[2], "BUS3");
 }
 
+#if 0
 void nvidia_delete_i2c_busses(struct nvidia_par *par)
 {
 	if (par->chan[0].par)
@@ -161,6 +162,7 @@
 	par->chan[2].par = NULL;
 
 }
+#endif  /*  0  */
 
 static u8 *nvidia_do_probe_i2c_edid(struct nvidia_i2c_chan *chan)
 {
diff -Nru a/drivers/video/nvidia/nv_of.c b/drivers/video/nvidia/nv_of.c
--- a/drivers/video/nvidia/nv_of.c	2005-03-05 00:35:05 +08:00
+++ b/drivers/video/nvidia/nv_of.c	2005-03-01 09:53:01 +08:00
@@ -28,7 +28,6 @@
 #include "nv_proto.h"
 
 void nvidia_create_i2c_busses(struct nvidia_par *par) {}
-void nvidia_delete_i2c_busses(struct nvidia_par *par) {}
 
 int nvidia_probe_i2c_connector(struct nvidia_par *par, int conn, u8 **out_edid)
 {
diff -Nru a/drivers/video/nvidia/nv_proto.h b/drivers/video/nvidia/nv_proto.h
--- a/drivers/video/nvidia/nv_proto.h	2005-03-05 00:35:05 +08:00
+++ b/drivers/video/nvidia/nv_proto.h	2005-03-01 09:54:17 +08:00
@@ -15,10 +15,7 @@
 u8 NVReadAttr(struct nvidia_par *par, u8 index);
 void NVWriteMiscOut(struct nvidia_par *par, u8 value);
 u8 NVReadMiscOut(struct nvidia_par *par);
-void NVEnablePalette(struct nvidia_par *par);
-void NVDisablePalette(struct nvidia_par *par);
 void NVWriteDacMask(struct nvidia_par *par, u8 value);
-u8 NVReadDacMask(struct nvidia_par *par);
 void NVWriteDacReadAddr(struct nvidia_par *par, u8 value);
 void NVWriteDacWriteAddr(struct nvidia_par *par, u8 value);
 void NVWriteDacData(struct nvidia_par *par, u8 value);
@@ -36,12 +33,10 @@
 /* in nvidia-i2c.c */
 #if defined(CONFIG_FB_NVIDIA_I2C) || defined (CONFIG_PPC_OF)
 void nvidia_create_i2c_busses(struct nvidia_par *par);
-void nvidia_delete_i2c_busses(struct nvidia_par *par);
 int nvidia_probe_i2c_connector(struct nvidia_par *par, int conn,
 			       u8 ** out_edid);
 #else
 #define nvidia_create_i2c_busses(...)
-#define nvidia_delete_i2c_busses(...)
 #define nvidia_probe_i2c_connector(p, c, edid) \
 do {                                           \
 	*(edid) = NULL;                        \
diff -Nru a/drivers/video/nvidia/nv_setup.c b/drivers/video/nvidia/nv_setup.c
--- a/drivers/video/nvidia/nv_setup.c	2005-03-05 00:35:05 +08:00
+++ b/drivers/video/nvidia/nv_setup.c	2005-03-01 09:54:32 +08:00
@@ -108,6 +108,7 @@
 {
 	return (VGA_RD08(par->PVIO, VGA_MIS_R));
 }
+#if 0
 void NVEnablePalette(struct nvidia_par *par)
 {
 	volatile u8 tmp;
@@ -124,14 +125,17 @@
 	VGA_WR08(par->PCIO, VGA_ATT_IW, 0x20);
 	par->paletteEnabled = 0;
 }
+#endif  /*  0  */
 void NVWriteDacMask(struct nvidia_par *par, u8 value)
 {
 	VGA_WR08(par->PDIO, VGA_PEL_MSK, value);
 }
+#if 0
 u8 NVReadDacMask(struct nvidia_par *par)
 {
 	return (VGA_RD08(par->PDIO, VGA_PEL_MSK));
 }
+#endif  /*  0  */
 void NVWriteDacReadAddr(struct nvidia_par *par, u8 value)
 {
 	VGA_WR08(par->PDIO, VGA_PEL_IR, value);
diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c	2005-03-01 00:12:38 +08:00
+++ b/drivers/video/nvidia/nvidia.c	2005-03-01 10:05:14 +08:00
@@ -1614,7 +1614,7 @@
  * ------------------------------------------------------------------------- */
 
 #ifndef MODULE
-int __init nvidiafb_setup(char *options)
+static int __init nvidiafb_setup(char *options)
 {
 	char *this_opt;
 
@@ -1667,7 +1667,7 @@
  *
  * ------------------------------------------------------------------------- */
 
-int __devinit nvidiafb_init(void)
+static int __devinit nvidiafb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
diff -Nru a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
--- a/drivers/video/pm2fb.c	2004-12-18 20:38:35 +08:00
+++ b/drivers/video/pm2fb.c	2005-03-06 06:45:07 +08:00
@@ -1243,47 +1243,13 @@
 MODULE_DEVICE_TABLE(pci, pm2fb_id_table);
 
 
-/*
- *  Initialization
- */
-
-int __init pm2fb_setup(char *options);
-
-int __init pm2fb_init(void)
-{
-#ifndef MODULE
-	char *option = NULL;
-
-	if (fb_get_options("pm2fb", &option))
-		return -ENODEV;
-	pm2fb_setup(option);
-#endif
-
-	return pci_module_init(&pm2fb_driver);
-}
-
-#ifdef MODULE
-/*
- *  Cleanup
- */
-
-static void __exit pm2fb_exit(void)
-{
-	pci_unregister_driver(&pm2fb_driver);
-}
-#endif
-
-/*
- *  Setup
- */
-
 #ifndef MODULE
 /**
  * Parse user speficied options.
  *
  * This is, comma-separated options following `video=pm2fb:'.
  */
-int __init pm2fb_setup(char *options)
+static int __init pm2fb_setup(char *options)
 {
 	char* this_opt;
 
@@ -1306,13 +1272,31 @@
 #endif
 
 
-/* ------------------------------------------------------------------------- */
-
-/* ------------------------------------------------------------------------- */
+static int __init pm2fb_init(void)
+{
+#ifndef MODULE
+	char *option = NULL;
 
+	if (fb_get_options("pm2fb", &option))
+		return -ENODEV;
+	pm2fb_setup(option);
+#endif
 
+	return pci_module_init(&pm2fb_driver);
+}
 
 module_init(pm2fb_init);
+
+#ifdef MODULE
+/*
+ *  Cleanup
+ */
+
+static void __exit pm2fb_exit(void)
+{
+	pci_unregister_driver(&pm2fb_driver);
+}
+#endif
 
 #ifdef MODULE
 module_exit(pm2fb_exit);
diff -Nru a/drivers/video/radeonfb.c b/drivers/video/radeonfb.c
--- a/drivers/video/radeonfb.c	2005-01-21 19:54:15 +08:00
+++ b/drivers/video/radeonfb.c	2005-03-01 10:07:31 +08:00
@@ -3109,28 +3109,8 @@
 	.remove		= __devexit_p(radeonfb_pci_unregister),
 };
 
-int __init radeonfb_old_setup (char *options);
-
-int __init radeonfb_old_init (void)
-{
 #ifndef MODULE
-	char *option = NULL;
-
-	if (fb_get_options("radeonfb_old", &option))
-		return -ENODEV;
-	radeonfb_old_setup(option);
-#endif
-	return pci_module_init (&radeonfb_driver);
-}
-
-
-void __exit radeonfb_old_exit (void)
-{
-	pci_unregister_driver (&radeonfb_driver);
-}
-
-
-int __init radeonfb_old_setup (char *options)
+static int __init radeonfb_old_setup (char *options)
 {
         char *this_opt;
 
@@ -3156,12 +3136,28 @@
 
 	return 0;
 }
+#endif  /*  MODULE  */
 
-module_init(radeonfb_old_init);
+static int __init radeonfb_old_init (void)
+{
+#ifndef MODULE
+	char *option = NULL;
 
-#ifdef MODULE
-module_exit(radeonfb_old_exit);
+	if (fb_get_options("radeonfb_old", &option))
+		return -ENODEV;
+	radeonfb_old_setup(option);
 #endif
+	return pci_module_init (&radeonfb_driver);
+}
+
+
+static void __exit radeonfb_old_exit (void)
+{
+	pci_unregister_driver (&radeonfb_driver);
+}
+
+module_init(radeonfb_old_init);
+module_exit(radeonfb_old_exit);
 
 
 MODULE_AUTHOR("Ani Joshi");
diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	2005-01-12 06:10:17 +08:00
+++ b/drivers/video/riva/fbdev.c	2005-03-01 09:58:25 +08:00
@@ -906,7 +906,7 @@
 }
 
 /* acceleration routines */
-inline void wait_for_idle(struct riva_par *par)
+static inline void wait_for_idle(struct riva_par *par)
 {
 	while (par->riva.Busy(&par->riva));
 }
@@ -923,7 +923,7 @@
 
 }
 
-void riva_setup_accel(struct fb_info *info)
+static void riva_setup_accel(struct fb_info *info)
 {
 	struct riva_par *par = (struct riva_par *) info->par;
 
@@ -2139,7 +2139,7 @@
  * ------------------------------------------------------------------------- */
 
 #ifndef MODULE
-int __init rivafb_setup(char *options)
+static int __init rivafb_setup(char *options)
 {
 	char *this_opt;
 
@@ -2189,7 +2189,7 @@
  *
  * ------------------------------------------------------------------------- */
 
-int __devinit rivafb_init(void)
+static int __devinit rivafb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
diff -Nru a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
--- a/drivers/video/tdfxfb.c	2004-12-18 20:38:36 +08:00
+++ b/drivers/video/tdfxfb.c	2005-03-01 10:22:40 +08:00
@@ -154,9 +154,6 @@
 /*
  *  Frame buffer device API
  */
-int tdfxfb_init(void);
-void tdfxfb_setup(char *options);
-
 static int tdfxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *fb); 
 static int tdfxfb_set_par(struct fb_info *info); 
 static int tdfxfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue, 
@@ -1292,6 +1289,28 @@
 	return -ENXIO;
 }
 
+#ifndef MODULE
+void tdfxfb_setup(char *options)
+{
+	char* this_opt;
+
+	if (!options || !*options)
+		return;
+
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
+		if(!strcmp(this_opt, "nopan")) {
+			nopan = 1;
+		} else if(!strcmp(this_opt, "nowrap")) {
+			nowrap = 1;
+		} else {
+			mode_option = this_opt;
+		}
+	}
+}
+#endif
+
 /**
  *      tdfxfb_remove - Device removal
  *
@@ -1321,7 +1340,7 @@
 	framebuffer_release(info);
 }
 
-int __init tdfxfb_init(void)
+static int __init tdfxfb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -1345,27 +1364,3 @@
  
 module_init(tdfxfb_init);
 module_exit(tdfxfb_exit);
-
-
-#ifndef MODULE
-void tdfxfb_setup(char *options)
-{ 
-	char* this_opt;
-
-	if (!options || !*options)
-		return;
-
-	while ((this_opt = strsep(&options, ",")) != NULL) {	
-		if (!*this_opt)
-			continue;
-		if(!strcmp(this_opt, "nopan")) {
-			nopan = 1;
-		} else if(!strcmp(this_opt, "nowrap")) {
-			nowrap = 1;
-		} else {
-			mode_option = this_opt;
-		}
-	} 
-}
-#endif
-
diff -Nru a/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- a/drivers/video/vesafb.c	2005-01-21 19:54:15 +08:00
+++ b/drivers/video/vesafb.c	2005-03-01 10:42:05 +08:00
@@ -185,7 +185,7 @@
 	.fb_cursor	= soft_cursor,
 };
 
-int __init vesafb_setup(char *options)
+static int __init vesafb_setup(char *options)
 {
 	char *this_opt;
 	
@@ -434,7 +434,7 @@
 	.name	= "vesafb",
 };
 
-int __init vesafb_init(void)
+static int __init vesafb_init(void)
 {
 	int ret;
 	char *option = NULL;
@@ -452,13 +452,5 @@
 	return ret;
 }
 module_init(vesafb_init);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-basic-offset: 8
- * End:
- */
 
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/video/vfb.c b/drivers/video/vfb.c
--- a/drivers/video/vfb.c	2004-12-01 19:35:52 +08:00
+++ b/drivers/video/vfb.c	2005-03-01 10:43:51 +08:00
@@ -72,12 +72,6 @@
 static int vfb_enable __initdata = 0;	/* disabled by default */
 module_param(vfb_enable, bool, 0);
 
-    /*
-     *  Interface used by the world
-     */
-int vfb_init(void);
-int vfb_setup(char *);
-
 static int vfb_check_var(struct fb_var_screeninfo *var,
 			 struct fb_info *info);
 static int vfb_set_par(struct fb_info *info);
@@ -379,7 +373,8 @@
 	return -EINVAL;
 }
 
-int __init vfb_setup(char *options)
+#ifndef MODULE
+static int __init vfb_setup(char *options)
 {
 	char *this_opt;
 
@@ -396,6 +391,7 @@
 	}
 	return 1;
 }
+#endif  /*  MODULE  */
 
     /*
      *  Initialisation
@@ -492,7 +488,7 @@
 	}
 };
 
-int __init vfb_init(void)
+static int __init vfb_init(void)
 {
 	int ret = 0;
 
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	2005-03-06 07:06:39 +08:00
+++ b/include/linux/fb.h	2005-03-06 06:45:09 +08:00
@@ -864,10 +864,7 @@
 extern int fb_validate_mode(const struct fb_var_screeninfo *var,
 			    struct fb_info *info);
 extern int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var);
-extern int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs);
 extern void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs);
-extern int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs);
-extern struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize);
 extern void fb_destroy_modedb(struct fb_videomode *modedb);
 
 /* drivers/video/modedb.c */




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

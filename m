From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/7] fbdev: Fix userland compile breakage
Date: Fri, 10 Sep 2004 05:34:45 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409100534.45467.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5WYq-0000Eq-JS
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 14:34:32 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C5WYn-0005hA-Gg
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 14:34:30 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id DC9C68136AE
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  9 Sep 2004 21:34:10 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org, Michal Januszewski <spock@gentoo.org>

=46rom Michal Januszewski <spock@gentoo.org>

"The latest changes introduced to the fb structs in linux/fb.h make
compilation of userspace programs break with:

include/linux/fb.h:305: error: field `modelist' has incomplete type

This is caused by struct list_head not being seen from userspace."

This patch removes struct list_head modelist from struct fb_monspecs and
moves it to struct fb_info instead, and for now, enclosed struct
fb_monspecs by #ifdef __KERNEL__/#endif.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
=2D--

 drivers/video/console/fbcon.c |    4 -
 drivers/video/fbmem.c         |   16 ++--
 drivers/video/modedb.c        |    2
 drivers/video/riva/fbdev.c    |    6 -
 include/linux/fb.h            |  137 ++++++++++++++++++++-----------------=
=2D----
 5 files changed, 82 insertions(+), 83 deletions(-)

diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/console/fbcon.c linux-2.6=
=2E9-rc1-mm4/drivers/video/console/fbcon.c
=2D-- linux-2.6.9-rc1-mm4-orig/drivers/video/console/fbcon.c	2004-09-10 04:=
43:53.017825616 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/console/fbcon.c	2004-09-10 04:44:19.9=
23735296 +0800
@@ -689,7 +689,7 @@ static int var_to_display(struct display
 	disp->green =3D var->green;
 	disp->blue =3D var->blue;
 	disp->transp =3D var->transp;
=2D	disp->mode =3D fb_match_mode(var, &info->monspecs.modelist);
+	disp->mode =3D fb_match_mode(var, &info->modelist);
 	if (disp->mode =3D=3D NULL)
 		/* This should not happen */
 		return -EINVAL;
@@ -1973,7 +1973,7 @@ static int fbcon_resize(struct vc_data *
 		struct fb_videomode *mode;
=20
 		DPRINTK("attempting resize %ix%i\n", var.xres, var.yres);
=2D		mode =3D fb_find_best_mode(&var, &info->monspecs.modelist);
+		mode =3D fb_find_best_mode(&var, &info->modelist);
 		if (mode =3D=3D NULL)
 			return -EINVAL;
 		fb_videomode_to_var(&var, mode);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/fbmem.c linux-2.6.9-rc1-m=
m4/drivers/video/fbmem.c
=2D-- linux-2.6.9-rc1-mm4-orig/drivers/video/fbmem.c	2004-09-10 04:43:53.01=
9825312 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/fbmem.c	2004-09-10 04:44:19.927734688=
 +0800
@@ -791,7 +791,7 @@ fb_set_var(struct fb_info *info, struct=20
 		}
=20
 		if (!ret)
=2D		    fb_delete_videomode(&mode1, &info->monspecs.modelist);
+		    fb_delete_videomode(&mode1, &info->modelist);
=20
 		return ret;
 	}
@@ -818,7 +818,7 @@ fb_set_var(struct fb_info *info, struct=20
 			fb_set_cmap(&info->cmap, info);
=20
 			fb_var_to_videomode(&mode, &info->var);
=2D			fb_add_videomode(&mode, &info->monspecs.modelist);
+			fb_add_videomode(&mode, &info->modelist);
=20
 			if (info->flags & FBINFO_MISC_MODECHANGEUSER) {
 				struct fb_event event;
@@ -1164,14 +1164,14 @@ register_framebuffer(struct fb_info *fb_
 	}
 	fb_info->sprite.offset =3D 0;
=20
=2D	if (!fb_info->monspecs.modelist.prev ||
=2D	    !fb_info->monspecs.modelist.next ||
=2D	    list_empty(&fb_info->monspecs.modelist)) {
+	if (!fb_info->modelist.prev ||
+	    !fb_info->modelist.next ||
+	    list_empty(&fb_info->modelist)) {
 	        struct fb_videomode mode;
=20
=2D		INIT_LIST_HEAD(&fb_info->monspecs.modelist);
+		INIT_LIST_HEAD(&fb_info->modelist);
 		fb_var_to_videomode(&mode, &fb_info->var);
=2D		fb_add_videomode(&mode, &fb_info->monspecs.modelist);
+		fb_add_videomode(&mode, &fb_info->modelist);
 	}
=20
 	registered_fb[i] =3D fb_info;
@@ -1209,7 +1209,7 @@ unregister_framebuffer(struct fb_info *f
 		kfree(fb_info->pixmap.addr);
 	if (fb_info->sprite.addr && (fb_info->sprite.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->sprite.addr);
=2D	fb_destroy_modelist(&fb_info->monspecs.modelist);
+	fb_destroy_modelist(&fb_info->modelist);
 	registered_fb[i]=3DNULL;
 	num_registered_fb--;
 	class_simple_device_remove(MKDEV(FB_MAJOR, i));
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/modedb.c linux-2.6.9-rc1-=
mm4/drivers/video/modedb.c
=2D-- linux-2.6.9-rc1-mm4-orig/drivers/video/modedb.c	2004-09-10 04:43:53.0=
45821360 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/modedb.c	2004-09-09 19:11:12.00000000=
0 +0800
@@ -670,7 +670,7 @@ int fb_mode_is_equal(struct fb_videomode
  *
  * IMPORTANT:
  * This function assumes that all modelist entries in
=2D * info->monspecs.modelist are valid.
+ * info->modelist are valid.
  *
  * NOTES:
  * Finds best matching videomode which has an equal or greater dimension t=
han
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/riva/fbdev.c linux-2.6.9-=
rc1-mm4/drivers/video/riva/fbdev.c
=2D-- linux-2.6.9-rc1-mm4-orig/drivers/video/riva/fbdev.c	2004-09-10 04:43:=
53.047821056 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/riva/fbdev.c	2004-09-10 04:44:12.2449=
02656 +0800
@@ -1115,14 +1115,14 @@ static int rivafb_check_var(struct fb_va
 	}
=20
 	if (!mode_valid) {
=2D		mode =3D fb_find_best_mode(var, &info->monspecs.modelist);
+		mode =3D fb_find_best_mode(var, &info->modelist);
 		if (mode) {
 			riva_update_var(var, mode);
 			mode_valid =3D 1;
 		}
 	}
=20
=2D	if (!mode_valid && !list_empty(&info->monspecs.modelist))
+	if (!mode_valid && !list_empty(&info->modelist))
 		return -EINVAL;
=20
 	if (var->xres_virtual < var->xres)
@@ -1797,7 +1797,7 @@ static void __devinit riva_get_edidinfo(
=20
 	fb_edid_to_monspecs(par->EDID, &info->monspecs);
 	fb_videomode_to_modelist(info->monspecs.modedb, info->monspecs.modedb_len,
=2D				 &info->monspecs.modelist);
+				 &info->modelist);
 	riva_update_default_var(var, info);
=20
 	/* if user specified flatpanel, we respect that */
diff -uprN linux-2.6.9-rc1-mm4-orig/include/linux/fb.h linux-2.6.9-rc1-mm4/=
include/linux/fb.h
=2D-- linux-2.6.9-rc1-mm4-orig/include/linux/fb.h	2004-09-10 04:43:53.05082=
0600 +0800
+++ linux-2.6.9-rc1-mm4/include/linux/fb.h	2004-09-10 04:54:59.156557136 +0=
800
@@ -2,7 +2,6 @@
 #define _LINUX_FB_H
=20
 #include <asm/types.h>
=2D#include <linux/list.h>
=20
 /* Definitions of frame buffers						*/
=20
@@ -243,74 +242,6 @@ struct fb_con2fbmap {
 #define VESA_HSYNC_SUSPEND      2
 #define VESA_POWERDOWN          3
=20
=2D/* Definitions below are used in the parsed monitor specs */
=2D#define FB_DPMS_ACTIVE_OFF	1
=2D#define FB_DPMS_SUSPEND		2
=2D#define FB_DPMS_STANDBY		4
=2D
=2D#define FB_DISP_DDI		1
=2D#define FB_DISP_ANA_700_300	2
=2D#define FB_DISP_ANA_714_286	4
=2D#define FB_DISP_ANA_1000_400	8
=2D#define FB_DISP_ANA_700_000	16
=2D
=2D#define FB_DISP_MONO		32
=2D#define FB_DISP_RGB		64
=2D#define FB_DISP_MULTI		128
=2D#define FB_DISP_UNKNOWN		256
=2D
=2D#define FB_SIGNAL_NONE		0
=2D#define FB_SIGNAL_BLANK_BLANK	1
=2D#define FB_SIGNAL_SEPARATE	2
=2D#define FB_SIGNAL_COMPOSITE	4
=2D#define FB_SIGNAL_SYNC_ON_GREEN	8
=2D#define FB_SIGNAL_SERRATION_ON	16
=2D
=2D#define FB_MISC_PRIM_COLOR	1
=2D#define FB_MISC_1ST_DETAIL	2	/* First Detailed Timing is preferred */
=2D
=2Dstruct fb_chroma {
=2D	__u32 redx;	/* in fraction of 1024 */
=2D	__u32 greenx;
=2D	__u32 bluex;
=2D	__u32 whitex;
=2D	__u32 redy;
=2D	__u32 greeny;
=2D	__u32 bluey;
=2D	__u32 whitey;
=2D};
=2D
=2Dstruct fb_monspecs {
=2D	struct fb_chroma chroma;
=2D	struct fb_videomode *modedb;	/* mode database */
=2D	struct list_head modelist;      /* mode list */
=2D	__u8  manufacturer[4];		/* Manufacturer */
=2D	__u8  monitor[14];		/* Monitor String */
=2D	__u8  serial_no[14];		/* Serial Number */
=2D	__u8  ascii[14];		/* ? */
=2D	__u32 modedb_len;		/* mode database length */
=2D	__u32 model;			/* Monitor Model */
=2D	__u32 serial;			/* Serial Number - Integer */
=2D	__u32 year;			/* Year manufactured */
=2D	__u32 week;			/* Week Manufactured */
=2D	__u32 hfmin;			/* hfreq lower limit (Hz) */
=2D	__u32 hfmax;			/* hfreq upper limit (Hz) */
=2D	__u32 dclkmin;			/* pixelclock lower limit (Hz) */
=2D	__u32 dclkmax;			/* pixelclock upper limit (Hz) */
=2D	__u16 input;			/* display type - see FB_DISP_* */
=2D	__u16 dpms;			/* DPMS support - see FB_DPMS_ */
=2D	__u16 signal;			/* Signal Type - see FB_SIGNAL_* */
=2D	__u16 vfmin;			/* vfreq lower limit (Hz) */
=2D	__u16 vfmax;			/* vfreq upper limit (Hz) */
=2D	__u16 gamma;			/* Gamma - in fractions of 100 */
=2D	__u16 gtf	: 1;		/* supports GTF */
=2D	__u16 misc;			/* Misc flags - see FB_MISC_* */
=2D	__u8  version;			/* EDID version... */
=2D	__u8  revision;			/* ...and revision */
=2D	__u8  max_x;			/* Maximum horizontal size (cm) */
=2D	__u8  max_y;			/* Maximum vertical size (cm) */
=2D};
=2D
 #define FB_VBLANK_VBLANKING	0x001	/* currently in a vertical blank */
 #define FB_VBLANK_HBLANKING	0x002	/* currently in a horizontal blank */
 #define FB_VBLANK_HAVE_VBLANK	0x004	/* vertical blanks can be detected */
@@ -399,6 +330,7 @@ struct fb_cursor {
 #include <linux/workqueue.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/notifier.h>
+#include <linux/list.h>
 #include <asm/io.h>
=20
 struct vm_area_struct;
@@ -406,6 +338,72 @@ struct fb_info;
 struct device;
 struct file;
=20
+/* Definitions below are used in the parsed monitor specs */
+#define FB_DPMS_ACTIVE_OFF	1
+#define FB_DPMS_SUSPEND		2
+#define FB_DPMS_STANDBY		4
+
+#define FB_DISP_DDI		1
+#define FB_DISP_ANA_700_300	2
+#define FB_DISP_ANA_714_286	4
+#define FB_DISP_ANA_1000_400	8
+#define FB_DISP_ANA_700_000	16
+
+#define FB_DISP_MONO		32
+#define FB_DISP_RGB		64
+#define FB_DISP_MULTI		128
+#define FB_DISP_UNKNOWN		256
+
+#define FB_SIGNAL_NONE		0
+#define FB_SIGNAL_BLANK_BLANK	1
+#define FB_SIGNAL_SEPARATE	2
+#define FB_SIGNAL_COMPOSITE	4
+#define FB_SIGNAL_SYNC_ON_GREEN	8
+#define FB_SIGNAL_SERRATION_ON	16
+
+#define FB_MISC_PRIM_COLOR	1
+#define FB_MISC_1ST_DETAIL	2	/* First Detailed Timing is preferred */
+struct fb_chroma {
+	__u32 redx;	/* in fraction of 1024 */
+	__u32 greenx;
+	__u32 bluex;
+	__u32 whitex;
+	__u32 redy;
+	__u32 greeny;
+	__u32 bluey;
+	__u32 whitey;
+};
+
+struct fb_monspecs {
+	struct fb_chroma chroma;
+	struct fb_videomode *modedb;	/* mode database */
+	__u8  manufacturer[4];		/* Manufacturer */
+	__u8  monitor[14];		/* Monitor String */
+	__u8  serial_no[14];		/* Serial Number */
+	__u8  ascii[14];		/* ? */
+	__u32 modedb_len;		/* mode database length */
+	__u32 model;			/* Monitor Model */
+	__u32 serial;			/* Serial Number - Integer */
+	__u32 year;			/* Year manufactured */
+	__u32 week;			/* Week Manufactured */
+	__u32 hfmin;			/* hfreq lower limit (Hz) */
+	__u32 hfmax;			/* hfreq upper limit (Hz) */
+	__u32 dclkmin;			/* pixelclock lower limit (Hz) */
+	__u32 dclkmax;			/* pixelclock upper limit (Hz) */
+	__u16 input;			/* display type - see FB_DISP_* */
+	__u16 dpms;			/* DPMS support - see FB_DPMS_ */
+	__u16 signal;			/* Signal Type - see FB_SIGNAL_* */
+	__u16 vfmin;			/* vfreq lower limit (Hz) */
+	__u16 vfmax;			/* vfreq upper limit (Hz) */
+	__u16 gamma;			/* Gamma - in fractions of 100 */
+	__u16 gtf	: 1;		/* supports GTF */
+	__u16 misc;			/* Misc flags - see FB_MISC_* */
+	__u8  version;			/* EDID version... */
+	__u8  revision;			/* ...and revision */
+	__u8  max_x;			/* Maximum horizontal size (cm) */
+	__u8  max_y;			/* Maximum vertical size (cm) */
+};
+
 struct fb_cmap_user {
 	__u32 start;			/* First entry	*/
 	__u32 len;			/* Number of entries */
@@ -601,6 +599,7 @@ struct fb_info {
 	struct fb_pixmap pixmap;	/* Image hardware mapper */
 	struct fb_pixmap sprite;	/* Cursor hardware mapper */
 	struct fb_cmap cmap;		/* Current cmap */
+	struct list_head modelist;      /* mode list */
 	struct fb_ops *fbops;
 	char *screen_base;		/* Virtual address */
 	int currcon;			/* Current VC. */




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php

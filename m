From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 14/20] m68k: atafb: Atari fb revival
Date: Sat, 05 May 2007 23:00:57 +0800
Message-ID: <463C9C29.1040803@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkN5M-0005nC-I9 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 09:26:16 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkMEF-0008EN-BW
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:31:24 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:31:23 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>

Update the atari fb to 2.6 by Michael Schmitz,
Reformatting and rewrite of bit plane functions by Roman Zippel,
A few more fixes by Geert Uytterhoeven.

Signed-off-by: Michael Schmitz <schmitz@debian.org>
Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Kconfig          |    5 =

 drivers/video/Makefile         |    3 =

 drivers/video/atafb.c          | 2801 +++++++++++++++++++++---------------=
----
 drivers/video/atafb.h          |   36 +
 drivers/video/atafb_iplan2p2.c |  309 ++++
 drivers/video/atafb_iplan2p4.c |  308 ++++
 drivers/video/atafb_iplan2p8.c |  345 +++++
 drivers/video/atafb_mfb.c      |  112 ++
 drivers/video/atafb_utils.h    |  400 ++++++
 9 files changed, 3003 insertions(+), 1316 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c3dab68..0b7dc06 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -432,7 +432,10 @@ config FB_ARC
 =

 config FB_ATARI
 	bool "Atari native chipset support"
-	depends on (FB =3D y) && ATARI && BROKEN
+	depends on (FB =3D y) && ATARI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the builtin graphics
 	  chipset found in Ataris.
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 5f3e844..2fa9423 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -71,7 +71,8 @@ obj-$(CONFIG_FB_TCX)              +=3D tcx
 obj-$(CONFIG_FB_LEO)              +=3D leo.o sbuslib.o
 obj-$(CONFIG_FB_SGIVW)            +=3D sgivwfb.o
 obj-$(CONFIG_FB_ACORN)            +=3D acornfb.o
-obj-$(CONFIG_FB_ATARI)            +=3D atafb.o
+obj-$(CONFIG_FB_ATARI)            +=3D atafb.o c2p.o atafb_mfb.o \
+                                     atafb_iplan2p2.o atafb_iplan2p4.o ata=
fb_iplan2p8.o
 obj-$(CONFIG_FB_MAC)              +=3D macfb.o
 obj-$(CONFIG_FB_HECUBA)           +=3D hecubafb.o
 obj-$(CONFIG_FB_HGA)              +=3D hgafb.o
diff --git a/drivers/video/atafb.c b/drivers/video/atafb.c
index bffe2b9..0038a05 100644
--- a/drivers/video/atafb.c
+++ b/drivers/video/atafb.c
@@ -2,7 +2,7 @@
  * linux/drivers/video/atafb.c -- Atari builtin chipset frame buffer device
  *
  *  Copyright (C) 1994 Martin Schaller & Roman Hodek
- *  =

+ *
  * This file is subject to the terms and conditions of the GNU General Pub=
lic
  * License.  See the file COPYING in the main directory of this archive
  * for more details.
@@ -70,14 +70,8 @@ #include <asm/atari_stram.h>
 #include <linux/fb.h>
 #include <asm/atarikb.h>
 =

-#include <video/fbcon.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
-#include <video/fbcon-iplan2p2.h>
-#include <video/fbcon-iplan2p4.h>
-#include <video/fbcon-iplan2p8.h>
-#include <video/fbcon-mfb.h>
-
+#include "c2p.h"
+#include "atafb.h"
 =

 #define SWITCH_ACIA 0x01		/* modes for switch on OverScan */
 #define SWITCH_SND6 0x40
@@ -87,22 +81,48 @@ #define SWITCH_NONE 0x00
 =

 #define up(x, r) (((x) + (r) - 1) & ~((r)-1))
 =

+	/*
+	 * Interface to the world
+	 */
+
+static int atafb_check_var(struct fb_var_screeninfo *var, struct fb_info *=
info);
+static int atafb_set_par(struct fb_info *info);
+static int atafb_setcolreg(unsigned int regno, unsigned int red, unsigned =
int green,
+			   unsigned int blue, unsigned int transp,
+			   struct fb_info *info);
+static int atafb_blank(int blank, struct fb_info *info);
+static int atafb_pan_display(struct fb_var_screeninfo *var,
+			     struct fb_info *info);
+static void atafb_fillrect(struct fb_info *info,
+			   const struct fb_fillrect *rect);
+static void atafb_copyarea(struct fb_info *info,
+			   const struct fb_copyarea *region);
+static void atafb_imageblit(struct fb_info *info, const struct fb_image *i=
mage);
+static int atafb_ioctl(struct fb_info *info, unsigned int cmd,
+		       unsigned long arg);
+
 =

-static int default_par=3D0;	/* default resolution (0=3Dnone) */
+static int default_par;		/* default resolution (0=3Dnone) */
 =

-static unsigned long default_mem_req=3D0;
+static unsigned long default_mem_req;
 =

-static int hwscroll=3D-1;
+static int hwscroll =3D -1;
 =

 static int use_hwscroll =3D 1;
 =

-static int sttt_xres=3D640,st_yres=3D400,tt_yres=3D480;
-static int sttt_xres_virtual=3D640,sttt_yres_virtual=3D400;
-static int ovsc_offset=3D0, ovsc_addlen=3D0;
+static int sttt_xres =3D 640, st_yres =3D 400, tt_yres =3D 480;
+static int sttt_xres_virtual =3D 640, sttt_yres_virtual =3D 400;
+static int ovsc_offset, ovsc_addlen;
+
+	/*
+	 * Hardware parameters for current mode
+	 */
 =

 static struct atafb_par {
 	void *screen_base;
 	int yres_virtual;
+	u_long next_line;
+	u_long next_plane;
 #if defined ATAFB_TT || defined ATAFB_STE
 	union {
 		struct {
@@ -138,7 +158,7 @@ #endif
 /* Don't calculate an own resolution, and thus don't change the one found =
when
  * booting (currently used for the Falcon to keep settings for internal vi=
deo
  * hardware extensions (e.g. ScreenBlaster)  */
-static int DontCalcRes =3D 0; =

+static int DontCalcRes =3D 0;
 =

 #ifdef ATAFB_FALCON
 #define HHT hw.falcon.hht
@@ -163,83 +183,84 @@ #define VMO_INTER		0x02
 #define VMO_PREMASK		0x0c
 #endif
 =

-static struct fb_info fb_info;
+static struct fb_info fb_info =3D {
+	.fix =3D {
+		.id	=3D "Atari ",
+		.visual	=3D FB_VISUAL_PSEUDOCOLOR,
+		.accel	=3D FB_ACCEL_NONE,
+	}
+};
 =

 static void *screen_base;	/* base address of screen */
 static void *real_screen_base;	/* (only for Overscan) */
 =

 static int screen_len;
 =

-static int current_par_valid=3D0; =

+static int current_par_valid;
 =

-static int mono_moni=3D0;
-
-static struct display disp;
+static int mono_moni;
 =

 =

 #ifdef ATAFB_EXT
-/* external video handling */
 =

-static unsigned			external_xres;
-static unsigned			external_xres_virtual;
-static unsigned			external_yres;
-/* not needed - atafb will never support panning/hardwarescroll with exter=
nal
- * static unsigned		external_yres_virtual;	=

-*/
+/* external video handling */
+static unsigned int external_xres;
+static unsigned int external_xres_virtual;
+static unsigned int external_yres;
 =

-static unsigned			external_depth;
-static int				external_pmode;
-static void *external_addr =3D 0;
-static unsigned long	external_len;
-static unsigned long	external_vgaiobase =3D 0;
-static unsigned int		external_bitspercol =3D 6;
-
-/* =

-JOE <joe@amber.dinoco.de>: =

-added card type for external driver, is only needed for
-colormap handling.
-*/
+/*
+ * not needed - atafb will never support panning/hardwarescroll with exter=
nal
+ * static unsigned int external_yres_virtual;
+ */
+static unsigned int external_depth;
+static int external_pmode;
+static void *external_addr;
+static unsigned long external_len;
+static unsigned long external_vgaiobase;
+static unsigned int external_bitspercol =3D 6;
 =

+/*
+ * JOE <joe@amber.dinoco.de>:
+ * added card type for external driver, is only needed for
+ * colormap handling.
+ */
 enum cardtype { IS_VGA, IS_MV300 };
 static enum cardtype external_card_type =3D IS_VGA;
 =

 /*
-The MV300 mixes the color registers. So we need an array of munged
-indices in order to access the correct reg.
-*/
-static int MV300_reg_1bit[2]=3D{0,1};
-static int MV300_reg_4bit[16]=3D{
-0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15 };
-static int MV300_reg_8bit[256]=3D{
-0, 128, 64, 192, 32, 160, 96, 224, 16, 144, 80, 208, 48, 176, 112, 240, =

-8, 136, 72, 200, 40, 168, 104, 232, 24, 152, 88, 216, 56, 184, 120, 248, =

-4, 132, 68, 196, 36, 164, 100, 228, 20, 148, 84, 212, 52, 180, 116, 244, =

-12, 140, 76, 204, 44, 172, 108, 236, 28, 156, 92, 220, 60, 188, 124, 252, =

-2, 130, 66, 194, 34, 162, 98, 226, 18, 146, 82, 210, 50, 178, 114, 242, =

-10, 138, 74, 202, 42, 170, 106, 234, 26, 154, 90, 218, 58, 186, 122, 250, =

-6, 134, 70, 198, 38, 166, 102, 230, 22, 150, 86, 214, 54, 182, 118, 246, =

-14, 142, 78, 206, 46, 174, 110, 238, 30, 158, 94, 222, 62, 190, 126, 254, =

-1, 129, 65, 193, 33, 161, 97, 225, 17, 145, 81, 209, 49, 177, 113, 241, =

-9, 137, 73, 201, 41, 169, 105, 233, 25, 153, 89, 217, 57, 185, 121, 249, =

-5, 133, 69, 197, 37, 165, 101, 229, 21, 149, 85, 213, 53, 181, 117, 245, =

-13, 141, 77, 205, 45, 173, 109, 237, 29, 157, 93, 221, 61, 189, 125, 253, =

-3, 131, 67, 195, 35, 163, 99, 227, 19, 147, 83, 211, 51, 179, 115, 243, =

-11, 139, 75, 203, 43, 171, 107, 235, 27, 155, 91, 219, 59, 187, 123, 251, =

-7, 135, 71, 199, 39, 167, 103, 231, 23, 151, 87, 215, 55, 183, 119, 247, =

-15, 143, 79, 207, 47, 175, 111, 239, 31, 159, 95, 223, 63, 191, 127, 255 }=
; =

+ * The MV300 mixes the color registers. So we need an array of munged
+ * indices in order to access the correct reg.
+ */
+static int MV300_reg_1bit[2] =3D {
+	0, 1
+};
+static int MV300_reg_4bit[16] =3D {
+	0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15
+};
+static int MV300_reg_8bit[256] =3D {
+	0, 128, 64, 192, 32, 160, 96, 224, 16, 144, 80, 208, 48, 176, 112, 240,
+	8, 136, 72, 200, 40, 168, 104, 232, 24, 152, 88, 216, 56, 184, 120, 248,
+	4, 132, 68, 196, 36, 164, 100, 228, 20, 148, 84, 212, 52, 180, 116, 244,
+	12, 140, 76, 204, 44, 172, 108, 236, 28, 156, 92, 220, 60, 188, 124, 252,
+	2, 130, 66, 194, 34, 162, 98, 226, 18, 146, 82, 210, 50, 178, 114, 242,
+	10, 138, 74, 202, 42, 170, 106, 234, 26, 154, 90, 218, 58, 186, 122, 250,
+	6, 134, 70, 198, 38, 166, 102, 230, 22, 150, 86, 214, 54, 182, 118, 246,
+	14, 142, 78, 206, 46, 174, 110, 238, 30, 158, 94, 222, 62, 190, 126, 254,
+	1, 129, 65, 193, 33, 161, 97, 225, 17, 145, 81, 209, 49, 177, 113, 241,
+	9, 137, 73, 201, 41, 169, 105, 233, 25, 153, 89, 217, 57, 185, 121, 249,
+	5, 133, 69, 197, 37, 165, 101, 229, 21, 149, 85, 213, 53, 181, 117, 245,
+	13, 141, 77, 205, 45, 173, 109, 237, 29, 157, 93, 221, 61, 189, 125, 253,
+	3, 131, 67, 195, 35, 163, 99, 227, 19, 147, 83, 211, 51, 179, 115, 243,
+	11, 139, 75, 203, 43, 171, 107, 235, 27, 155, 91, 219, 59, 187, 123, 251,
+	7, 135, 71, 199, 39, 167, 103, 231, 23, 151, 87, 215, 55, 183, 119, 247,
+	15, 143, 79, 207, 47, 175, 111, 239, 31, 159, 95, 223, 63, 191, 127, 255
+};
 =

 static int *MV300_reg =3D MV300_reg_8bit;
-
-/*
-And on the MV300 it's difficult to read out the hardware palette. So we
-just keep track of the set colors in our own array here, and use that!
-*/
-
-static struct { unsigned char red,green,blue,pad; } ext_color[256];
 #endif /* ATAFB_EXT */
 =

 =

-static int inverse=3D0;
+static int inverse;
 =

 extern int fontheight_8x8;
 extern int fontwidth_8x8;
@@ -249,96 +270,154 @@ extern int fontheight_8x16;
 extern int fontwidth_8x16;
 extern unsigned char fontdata_8x16[];
 =

+/*
+ * struct fb_ops {
+ *	* open/release and usage marking
+ *	struct module *owner;
+ *	int (*fb_open)(struct fb_info *info, int user);
+ *	int (*fb_release)(struct fb_info *info, int user);
+ *
+ *	* For framebuffers with strange non linear layouts or that do not
+ *	* work with normal memory mapped access
+ *	ssize_t (*fb_read)(struct file *file, char __user *buf, size_t count, l=
off_t *ppos);
+ *	ssize_t (*fb_write)(struct file *file, const char __user *buf, size_t c=
ount, loff_t *ppos);
+ *
+ *	* checks var and eventually tweaks it to something supported,
+ *	* DOES NOT MODIFY PAR *
+ *	int (*fb_check_var)(struct fb_var_screeninfo *var, struct fb_info *info=
);
+ *
+ *	* set the video mode according to info->var *
+ *	int (*fb_set_par)(struct fb_info *info);
+ *
+ *	* set color register *
+ *	int (*fb_setcolreg)(unsigned int regno, unsigned int red, unsigned int =
green,
+ *			    unsigned int blue, unsigned int transp, struct fb_info *info);
+ *
+ *	* set color registers in batch *
+ *	int (*fb_setcmap)(struct fb_cmap *cmap, struct fb_info *info);
+ *
+ *	* blank display *
+ *	int (*fb_blank)(int blank, struct fb_info *info);
+ *
+ *	* pan display *
+ *	int (*fb_pan_display)(struct fb_var_screeninfo *var, struct fb_info *in=
fo);
+ *
+ *	*** The meat of the drawing engine ***
+ *	* Draws a rectangle *
+ *	void (*fb_fillrect) (struct fb_info *info, const struct fb_fillrect *re=
ct);
+ *	* Copy data from area to another *
+ *	void (*fb_copyarea) (struct fb_info *info, const struct fb_copyarea *re=
gion);
+ *	* Draws a image to the display *
+ *	void (*fb_imageblit) (struct fb_info *info, const struct fb_image *imag=
e);
+ *
+ *	* Draws cursor *
+ *	int (*fb_cursor) (struct fb_info *info, struct fb_cursor *cursor);
+ *
+ *	* Rotates the display *
+ *	void (*fb_rotate)(struct fb_info *info, int angle);
+ *
+ *	* wait for blit idle, optional *
+ *	int (*fb_sync)(struct fb_info *info);
+ *
+ *	* perform fb specific ioctl (optional) *
+ *	int (*fb_ioctl)(struct fb_info *info, unsigned int cmd,
+ *			unsigned long arg);
+ *
+ *	* Handle 32bit compat ioctl (optional) *
+ *	int (*fb_compat_ioctl)(struct fb_info *info, unsigned int cmd,
+ *			unsigned long arg);
+ *
+ *	* perform fb specific mmap *
+ *	int (*fb_mmap)(struct fb_info *info, struct vm_area_struct *vma);
+ *
+ *	* save current hardware state *
+ *	void (*fb_save_state)(struct fb_info *info);
+ *
+ *	* restore saved state *
+ *	void (*fb_restore_state)(struct fb_info *info);
+ * } ;
+ */
+
+
 /* ++roman: This structure abstracts from the underlying hardware (ST(e),
  * TT, or Falcon.
  *
- * int (*detect)( void )
+ * int (*detect)(void)
  *   This function should detect the current video mode settings and
  *   store them in atafb_predefined[0] for later reference by the
  *   user. Return the index+1 of an equivalent predefined mode or 0
  *   if there is no such.
- * =

- * int (*encode_fix)( struct fb_fix_screeninfo *fix,
- *                    struct atafb_par *par )
+ *
+ * int (*encode_fix)(struct fb_fix_screeninfo *fix,
+ *                   struct atafb_par *par)
  *   This function should fill in the 'fix' structure based on the
  *   values in the 'par' structure.
- *   =

- * int (*decode_var)( struct fb_var_screeninfo *var,
- *                    struct atafb_par *par )
+ * !!! Obsolete, perhaps !!!
+ *
+ * int (*decode_var)(struct fb_var_screeninfo *var,
+ *                   struct atafb_par *par)
  *   Get the video params out of 'var'. If a value doesn't fit, round
  *   it up, if it's too big, return EINVAL.
- *   Round up in the following order: bits_per_pixel, xres, yres, =

- *   xres_virtual, yres_virtual, xoffset, yoffset, grayscale, bitfields, =

+ *   Round up in the following order: bits_per_pixel, xres, yres,
+ *   xres_virtual, yres_virtual, xoffset, yoffset, grayscale, bitfields,
  *   horizontal timing, vertical timing.
  *
- * int (*encode_var)( struct fb_var_screeninfo *var,
- *                    struct atafb_par *par );
+ * int (*encode_var)(struct fb_var_screeninfo *var,
+ *                   struct atafb_par *par);
  *   Fill the 'var' structure based on the values in 'par' and maybe
  *   other values read out of the hardware.
- *   =

- * void (*get_par)( struct atafb_par *par )
+ *
+ * void (*get_par)(struct atafb_par *par)
  *   Fill the hardware's 'par' structure.
- *   =

- * void (*set_par)( struct atafb_par *par )
+ *   !!! Used only by detect() !!!
+ *
+ * void (*set_par)(struct atafb_par *par)
  *   Set the hardware according to 'par'.
- *   =

- * int (*getcolreg)( unsigned regno, unsigned *red,
- *                   unsigned *green, unsigned *blue,
- *                   unsigned *transp, struct fb_info *info )
- *   Read a single color register and split it into
- *   colors/transparent. Return !=3D 0 for invalid regno.
  *
  * void (*set_screen_base)(void *s_base)
  *   Set the base address of the displayed frame buffer. Only called
  *   if yres_virtual > yres or xres_virtual > xres.
  *
- * int (*blank)( int blank_mode )
- *   Blank the screen if blank_mode!=3D0, else unblank. If blank=3D=3DNULL=
 then
+ * int (*blank)(int blank_mode)
+ *   Blank the screen if blank_mode !=3D 0, else unblank. If blank =3D=3D =
NULL then
  *   the caller blanks by setting the CLUT to all black. Return 0 if blank=
ing
  *   succeeded, !=3D0 if un-/blanking failed due to e.g. a video mode which
  *   doesn't support it. Implements VESA suspend and powerdown modes on
  *   hardware that supports disabling hsync/vsync:
- *       blank_mode=3D=3D2: suspend vsync, 3:suspend hsync, 4: powerdown.
+ *       blank_mode =3D=3D 2: suspend vsync, 3:suspend hsync, 4: powerdown.
  */
 =

 static struct fb_hwswitch {
-	int  (*detect)( void );
-	int  (*encode_fix)( struct fb_fix_screeninfo *fix,
-						struct atafb_par *par );
-	int  (*decode_var)( struct fb_var_screeninfo *var,
-						struct atafb_par *par );
-	int  (*encode_var)( struct fb_var_screeninfo *var,
-						struct atafb_par *par );
-	void (*get_par)( struct atafb_par *par );
-	void (*set_par)( struct atafb_par *par );
-	int  (*getcolreg)( unsigned regno, unsigned *red,
-					   unsigned *green, unsigned *blue,
-					   unsigned *transp, struct fb_info *info );
+	int (*detect)(void);
+	int (*encode_fix)(struct fb_fix_screeninfo *fix,
+			  struct atafb_par *par);
+	int (*decode_var)(struct fb_var_screeninfo *var,
+			  struct atafb_par *par);
+	int (*encode_var)(struct fb_var_screeninfo *var,
+			  struct atafb_par *par);
+	void (*get_par)(struct atafb_par *par);
+	void (*set_par)(struct atafb_par *par);
 	void (*set_screen_base)(void *s_base);
-	int  (*blank)( int blank_mode );
-	int  (*pan_display)( struct fb_var_screeninfo *var,
-						 struct atafb_par *par);
+	int (*blank)(int blank_mode);
+	int (*pan_display)(struct fb_var_screeninfo *var,
+			   struct fb_info *info);
 } *fbhw;
 =

-static char *autodetect_names[] =3D {"autodetect", NULL};
-static char *stlow_names[] =3D {"stlow", NULL};
-static char *stmid_names[] =3D {"stmid", "default5", NULL};
-static char *sthigh_names[] =3D {"sthigh", "default4", NULL};
-static char *ttlow_names[] =3D {"ttlow", NULL};
-static char *ttmid_names[]=3D {"ttmid", "default1", NULL};
-static char *tthigh_names[]=3D {"tthigh", "default2", NULL};
-static char *vga2_names[] =3D {"vga2", NULL};
-static char *vga4_names[] =3D {"vga4", NULL};
-static char *vga16_names[] =3D {"vga16", "default3", NULL};
-static char *vga256_names[] =3D {"vga256", NULL};
-static char *falh2_names[] =3D {"falh2", NULL};
-static char *falh16_names[] =3D {"falh16", NULL};
+static char *autodetect_names[] =3D { "autodetect", NULL };
+static char *stlow_names[] =3D { "stlow", NULL };
+static char *stmid_names[] =3D { "stmid", "default5", NULL };
+static char *sthigh_names[] =3D { "sthigh", "default4", NULL };
+static char *ttlow_names[] =3D { "ttlow", NULL };
+static char *ttmid_names[] =3D { "ttmid", "default1", NULL };
+static char *tthigh_names[] =3D { "tthigh", "default2", NULL };
+static char *vga2_names[] =3D { "vga2", NULL };
+static char *vga4_names[] =3D { "vga4", NULL };
+static char *vga16_names[] =3D { "vga16", "default3", NULL };
+static char *vga256_names[] =3D { "vga256", NULL };
+static char *falh2_names[] =3D { "falh2", NULL };
+static char *falh16_names[] =3D { "falh16", NULL };
 =

 static char **fb_var_names[] =3D {
-	/* Writing the name arrays directly in this array (via "(char *[]){...}")
-	 * crashes gcc 2.5.8 (sigsegv) if the inner array
-	 * contains more than two items. I've also seen that all elements
-	 * were identical to the last (my cross-gcc) :-(*/
 	autodetect_names,
 	stlow_names,
 	stmid_names,
@@ -353,18 +432,17 @@ static char **fb_var_names[] =3D {
 	falh2_names,
 	falh16_names,
 	NULL
-	/* ,NULL */ /* this causes a sigsegv on my gcc-2.5.8 */
 };
 =

 static struct fb_var_screeninfo atafb_predefined[] =3D {
- 	/*
- 	 * yres_virtual=3D=3D0 means use hw-scrolling if possible, else yres
- 	 */
- 	{ /* autodetect */
-	  0, 0, 0, 0, 0, 0, 0, 0,   		/* xres-grayscale */
-	  {0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}, 	/* red green blue tran*/
+	/*
+	 * yres_virtual =3D=3D 0 means use hw-scrolling if possible, else yres
+	 */
+	{ /* autodetect */
+	  0, 0, 0, 0, 0, 0, 0, 0,		/* xres-grayscale */
+	  {0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0},	/* red green blue tran*/
 	  0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0 },
- 	{ /* st low */
+	{ /* st low */
 	  320, 200, 320, 0, 0, 0, 4, 0,
 	  {0, 4, 0}, {0, 4, 0}, {0, 4, 0}, {0, 0, 0},
 	  0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0 },
@@ -414,27 +492,100 @@ static struct fb_var_screeninfo atafb_pr
 	  0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0 },
 };
 =

-static int num_atafb_predefined=3DARRAY_SIZE(atafb_predefined);
+static int num_atafb_predefined =3D ARRAY_SIZE(atafb_predefined);
 =

+static struct fb_videomode atafb_modedb[] __initdata =3D {
+	/*
+	 *  Atari Video Modes
+	 *
+	 *  If you change these, make sure to update DEFMODE_* as well!
+	 */
 =

-static int
-get_video_mode(char *vname)
+	/*
+	 *  ST/TT Video Modes
+	 */
+
+	{
+		/* 320x200, 15 kHz, 60 Hz (ST low) */
+		"st-low", 60, 320, 200, 32000, 32, 16, 31, 14, 96, 4,
+		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+	}, {
+		/* 640x200, 15 kHz, 60 Hz (ST medium) */
+		"st-mid", 60, 640, 200, 32000, 32, 16, 31, 14, 96, 4,
+		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+	}, {
+		/* 640x400, 30.25 kHz, 63.5 Hz (ST high) */
+		"st-high", 63, 640, 400, 32000, 128, 0, 40, 14, 128, 4,
+		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+	}, {
+		/* 320x480, 15 kHz, 60 Hz (TT low) */
+		"tt-low", 60, 320, 480, 31041, 120, 100, 8, 16, 140, 30,
+		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+	}, {
+		/* 640x480, 29 kHz, 57 Hz (TT medium) */
+		"tt-mid", 60, 640, 480, 31041, 120, 100, 8, 16, 140, 30,
+		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+	}, {
+		/* 1280x960, 29 kHz, 60 Hz (TT high) */
+		"tt-high", 57, 640, 960, 31041, 120, 100, 8, 16, 140, 30,
+		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+	},
+
+	/*
+	 *  VGA Video Modes
+	 */
+
+	{
+		/* 640x480, 31 kHz, 60 Hz (VGA) */
+		"vga", 63.5, 640, 480, 32000, 18, 42, 31, 11, 96, 3,
+		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+	}, {
+		/* 640x400, 31 kHz, 70 Hz (VGA) */
+		"vga70", 70, 640, 400, 32000, 18, 42, 31, 11, 96, 3,
+		FB_SYNC_VERT_HIGH_ACT | FB_SYNC_COMP_HIGH_ACT, FB_VMODE_NONINTERLACED | =
FB_VMODE_YWRAP
+	},
+
+	/*
+	 *  Falcon HiRes Video Modes
+	 */
+
+	{
+		/* 896x608, 31 kHz, 60 Hz (Falcon High) */
+		"falh", 60, 896, 608, 32000, 18, 42, 31, 1, 96,3,
+		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
+	},
+};
+
+#define NUM_TOTAL_MODES  ARRAY_SIZE(atafb_modedb)
+
+static char *mode_option __initdata =3D NULL;
+
+ /* default modes */
+
+#define DEFMODE_TT	5		/* "tt-high" for TT */
+#define DEFMODE_F30	7		/* "vga70" for Falcon */
+#define DEFMODE_STE	2		/* "st-high" for ST/E */
+#define DEFMODE_EXT	6		/* "vga" for external */
+
+
+static int get_video_mode(char *vname)
 {
-    char ***name_list;
-    char **name;
-    int i;
-    name_list=3Dfb_var_names;
-    for (i =3D 0 ; i < num_atafb_predefined ; i++) {
-	name=3D*(name_list++);
-	if (! name || ! *name)
-	    break;
-	while (*name) {
-	    if (! strcmp(vname, *name))
-		return i+1;
-	    name++;
+	char ***name_list;
+	char **name;
+	int i;
+
+	name_list =3D fb_var_names;
+	for (i =3D 0; i < num_atafb_predefined; i++) {
+		name =3D *name_list++;
+		if (!name || !*name)
+			break;
+		while (*name) {
+			if (!strcmp(vname, *name))
+				return i + 1;
+			name++;
+		}
 	}
-    }
-    return 0;
+	return 0;
 }
 =

 =

@@ -443,93 +594,84 @@ get_video_mode(char *vname)
 =

 #ifdef ATAFB_TT
 =

-static int tt_encode_fix( struct fb_fix_screeninfo *fix,
-						  struct atafb_par *par )
-
+static int tt_encode_fix(struct fb_fix_screeninfo *fix, struct atafb_par *=
par)
 {
 	int mode;
 =

-	strcpy(fix->id,"Atari Builtin");
+	strcpy(fix->id, "Atari Builtin");
 	fix->smem_start =3D (unsigned long)real_screen_base;
 	fix->smem_len =3D screen_len;
-	fix->type=3DFB_TYPE_INTERLEAVED_PLANES;
-	fix->type_aux=3D2;
-	fix->visual=3DFB_VISUAL_PSEUDOCOLOR;
+	fix->type =3D FB_TYPE_INTERLEAVED_PLANES;
+	fix->type_aux =3D 2;
+	fix->visual =3D FB_VISUAL_PSEUDOCOLOR;
 	mode =3D par->hw.tt.mode & TT_SHIFTER_MODEMASK;
 	if (mode =3D=3D TT_SHIFTER_TTHIGH || mode =3D=3D TT_SHIFTER_STHIGH) {
-		fix->type=3DFB_TYPE_PACKED_PIXELS;
-		fix->type_aux=3D0;
+		fix->type =3D FB_TYPE_PACKED_PIXELS;
+		fix->type_aux =3D 0;
 		if (mode =3D=3D TT_SHIFTER_TTHIGH)
-			fix->visual=3DFB_VISUAL_MONO01;
+			fix->visual =3D FB_VISUAL_MONO01;
 	}
-	fix->xpanstep=3D0;
-	fix->ypanstep=3D1;
-	fix->ywrapstep=3D0;
+	fix->xpanstep =3D 0;
+	fix->ypanstep =3D 1;
+	fix->ywrapstep =3D 0;
 	fix->line_length =3D 0;
 	fix->accel =3D FB_ACCEL_ATARIBLITT;
 	return 0;
 }
 =

-
-static int tt_decode_var( struct fb_var_screeninfo *var,
-						  struct atafb_par *par )
+static int tt_decode_var(struct fb_var_screeninfo *var, struct atafb_par *=
par)
 {
-	int xres=3Dvar->xres;
-	int yres=3Dvar->yres;
-	int bpp=3Dvar->bits_per_pixel;
+	int xres =3D var->xres;
+	int yres =3D var->yres;
+	int bpp =3D var->bits_per_pixel;
 	int linelen;
 	int yres_virtual =3D var->yres_virtual;
 =

 	if (mono_moni) {
-		if (bpp > 1 || xres > sttt_xres*2 || yres >tt_yres*2)
+		if (bpp > 1 || xres > sttt_xres * 2 || yres > tt_yres * 2)
 			return -EINVAL;
-		par->hw.tt.mode=3DTT_SHIFTER_TTHIGH;
-		xres=3Dsttt_xres*2;
-		yres=3Dtt_yres*2;
-		bpp=3D1;
+		par->hw.tt.mode =3D TT_SHIFTER_TTHIGH;
+		xres =3D sttt_xres * 2;
+		yres =3D tt_yres * 2;
+		bpp =3D 1;
 	} else {
 		if (bpp > 8 || xres > sttt_xres || yres > tt_yres)
 			return -EINVAL;
 		if (bpp > 4) {
-			if (xres > sttt_xres/2 || yres > tt_yres)
+			if (xres > sttt_xres / 2 || yres > tt_yres)
 				return -EINVAL;
-			par->hw.tt.mode=3DTT_SHIFTER_TTLOW;
-			xres=3Dsttt_xres/2;
-			yres=3Dtt_yres;
-			bpp=3D8;
-		}
-		else if (bpp > 2) {
+			par->hw.tt.mode =3D TT_SHIFTER_TTLOW;
+			xres =3D sttt_xres / 2;
+			yres =3D tt_yres;
+			bpp =3D 8;
+		} else if (bpp > 2) {
 			if (xres > sttt_xres || yres > tt_yres)
 				return -EINVAL;
-			if (xres > sttt_xres/2 || yres > st_yres/2) {
-				par->hw.tt.mode=3DTT_SHIFTER_TTMID;
-				xres=3Dsttt_xres;
-				yres=3Dtt_yres;
-				bpp=3D4;
-			}
-			else {
-				par->hw.tt.mode=3DTT_SHIFTER_STLOW;
-				xres=3Dsttt_xres/2;
-				yres=3Dst_yres/2;
-				bpp=3D4;
+			if (xres > sttt_xres / 2 || yres > st_yres / 2) {
+				par->hw.tt.mode =3D TT_SHIFTER_TTMID;
+				xres =3D sttt_xres;
+				yres =3D tt_yres;
+				bpp =3D 4;
+			} else {
+				par->hw.tt.mode =3D TT_SHIFTER_STLOW;
+				xres =3D sttt_xres / 2;
+				yres =3D st_yres / 2;
+				bpp =3D 4;
 			}
-		}
-		else if (bpp > 1) {
-			if (xres > sttt_xres || yres > st_yres/2)
+		} else if (bpp > 1) {
+			if (xres > sttt_xres || yres > st_yres / 2)
 				return -EINVAL;
-			par->hw.tt.mode=3DTT_SHIFTER_STMID;
-			xres=3Dsttt_xres;
-			yres=3Dst_yres/2;
-			bpp=3D2;
-		}
-		else if (var->xres > sttt_xres || var->yres > st_yres) {
+			par->hw.tt.mode =3D TT_SHIFTER_STMID;
+			xres =3D sttt_xres;
+			yres =3D st_yres / 2;
+			bpp =3D 2;
+		} else if (var->xres > sttt_xres || var->yres > st_yres) {
 			return -EINVAL;
-		}
-		else {
-			par->hw.tt.mode=3DTT_SHIFTER_STHIGH;
-			xres=3Dsttt_xres;
-			yres=3Dst_yres;
-			bpp=3D1;
+		} else {
+			par->hw.tt.mode =3D TT_SHIFTER_STHIGH;
+			xres =3D sttt_xres;
+			yres =3D st_yres;
+			bpp =3D 1;
 		}
 	}
 	if (yres_virtual <=3D 0)
@@ -537,10 +679,10 @@ static int tt_decode_var( struct fb_var_
 	else if (yres_virtual < yres)
 		yres_virtual =3D yres;
 	if (var->sync & FB_SYNC_EXT)
-		par->hw.tt.sync=3D0;
+		par->hw.tt.sync =3D 0;
 	else
-		par->hw.tt.sync=3D1;
-	linelen=3Dxres*bpp/8;
+		par->hw.tt.sync =3D 1;
+	linelen =3D xres * bpp / 8;
 	if (yres_virtual * linelen > screen_len && screen_len)
 		return -EINVAL;
 	if (yres * linelen > screen_len && screen_len)
@@ -552,154 +694,123 @@ static int tt_decode_var( struct fb_var_
 	return 0;
 }
 =

-static int tt_encode_var( struct fb_var_screeninfo *var,
-						  struct atafb_par *par )
+static int tt_encode_var(struct fb_var_screeninfo *var, struct atafb_par *=
par)
 {
 	int linelen;
 	memset(var, 0, sizeof(struct fb_var_screeninfo));
-	var->red.offset=3D0;
-	var->red.length=3D4;
-	var->red.msb_right=3D0;
-	var->grayscale=3D0;
-
-	var->pixclock=3D31041;
-	var->left_margin=3D120;		/* these may be incorrect 	*/
-	var->right_margin=3D100;
-	var->upper_margin=3D8;
-	var->lower_margin=3D16;
-	var->hsync_len=3D140;
-	var->vsync_len=3D30;
-
-	var->height=3D-1;
-	var->width=3D-1;
+	var->red.offset =3D 0;
+	var->red.length =3D 4;
+	var->red.msb_right =3D 0;
+	var->grayscale =3D 0;
+
+	var->pixclock =3D 31041;
+	var->left_margin =3D 120;		/* these may be incorrect */
+	var->right_margin =3D 100;
+	var->upper_margin =3D 8;
+	var->lower_margin =3D 16;
+	var->hsync_len =3D 140;
+	var->vsync_len =3D 30;
+
+	var->height =3D -1;
+	var->width =3D -1;
 =

 	if (par->hw.tt.sync & 1)
-		var->sync=3D0;
+		var->sync =3D 0;
 	else
-		var->sync=3DFB_SYNC_EXT;
+		var->sync =3D FB_SYNC_EXT;
 =

 	switch (par->hw.tt.mode & TT_SHIFTER_MODEMASK) {
 	case TT_SHIFTER_STLOW:
-		var->xres=3Dsttt_xres/2;
-		var->xres_virtual=3Dsttt_xres_virtual/2;
-		var->yres=3Dst_yres/2;
-		var->bits_per_pixel=3D4;
+		var->xres =3D sttt_xres / 2;
+		var->xres_virtual =3D sttt_xres_virtual / 2;
+		var->yres =3D st_yres / 2;
+		var->bits_per_pixel =3D 4;
 		break;
 	case TT_SHIFTER_STMID:
-		var->xres=3Dsttt_xres;
-		var->xres_virtual=3Dsttt_xres_virtual;
-		var->yres=3Dst_yres/2;
-		var->bits_per_pixel=3D2;
+		var->xres =3D sttt_xres;
+		var->xres_virtual =3D sttt_xres_virtual;
+		var->yres =3D st_yres / 2;
+		var->bits_per_pixel =3D 2;
 		break;
 	case TT_SHIFTER_STHIGH:
-		var->xres=3Dsttt_xres;
-		var->xres_virtual=3Dsttt_xres_virtual;
-		var->yres=3Dst_yres;
-		var->bits_per_pixel=3D1;
+		var->xres =3D sttt_xres;
+		var->xres_virtual =3D sttt_xres_virtual;
+		var->yres =3D st_yres;
+		var->bits_per_pixel =3D 1;
 		break;
 	case TT_SHIFTER_TTLOW:
-		var->xres=3Dsttt_xres/2;
-		var->xres_virtual=3Dsttt_xres_virtual/2;
-		var->yres=3Dtt_yres;
-		var->bits_per_pixel=3D8;
+		var->xres =3D sttt_xres / 2;
+		var->xres_virtual =3D sttt_xres_virtual / 2;
+		var->yres =3D tt_yres;
+		var->bits_per_pixel =3D 8;
 		break;
 	case TT_SHIFTER_TTMID:
-		var->xres=3Dsttt_xres;
-		var->xres_virtual=3Dsttt_xres_virtual;
-		var->yres=3Dtt_yres;
-		var->bits_per_pixel=3D4;
+		var->xres =3D sttt_xres;
+		var->xres_virtual =3D sttt_xres_virtual;
+		var->yres =3D tt_yres;
+		var->bits_per_pixel =3D 4;
 		break;
 	case TT_SHIFTER_TTHIGH:
-		var->red.length=3D0;
-		var->xres=3Dsttt_xres*2;
-		var->xres_virtual=3Dsttt_xres_virtual*2;
-		var->yres=3Dtt_yres*2;
-		var->bits_per_pixel=3D1;
+		var->red.length =3D 0;
+		var->xres =3D sttt_xres * 2;
+		var->xres_virtual =3D sttt_xres_virtual * 2;
+		var->yres =3D tt_yres * 2;
+		var->bits_per_pixel =3D 1;
 		break;
-	}		=

-	var->blue=3Dvar->green=3Dvar->red;
-	var->transp.offset=3D0;
-	var->transp.length=3D0;
-	var->transp.msb_right=3D0;
-	linelen=3Dvar->xres_virtual * var->bits_per_pixel / 8;
-	if (! use_hwscroll)
-		var->yres_virtual=3Dvar->yres;
+	}
+	var->blue =3D var->green =3D var->red;
+	var->transp.offset =3D 0;
+	var->transp.length =3D 0;
+	var->transp.msb_right =3D 0;
+	linelen =3D var->xres_virtual * var->bits_per_pixel / 8;
+	if (!use_hwscroll)
+		var->yres_virtual =3D var->yres;
 	else if (screen_len) {
 		if (par->yres_virtual)
 			var->yres_virtual =3D par->yres_virtual;
 		else
-			/* yres_virtual=3D=3D0 means use maximum */
+			/* yres_virtual =3D=3D 0 means use maximum */
 			var->yres_virtual =3D screen_len / linelen;
 	} else {
 		if (hwscroll < 0)
 			var->yres_virtual =3D 2 * var->yres;
 		else
-			var->yres_virtual=3Dvar->yres+hwscroll * 16;
+			var->yres_virtual =3D var->yres + hwscroll * 16;
 	}
-	var->xoffset=3D0;
+	var->xoffset =3D 0;
 	if (screen_base)
-		var->yoffset=3D(par->screen_base - screen_base)/linelen;
+		var->yoffset =3D (par->screen_base - screen_base) / linelen;
 	else
-		var->yoffset=3D0;
-	var->nonstd=3D0;
-	var->activate=3D0;
-	var->vmode=3DFB_VMODE_NONINTERLACED;
+		var->yoffset =3D 0;
+	var->nonstd =3D 0;
+	var->activate =3D 0;
+	var->vmode =3D FB_VMODE_NONINTERLACED;
 	return 0;
 }
 =

-
-static void tt_get_par( struct atafb_par *par )
+static void tt_get_par(struct atafb_par *par)
 {
 	unsigned long addr;
-	par->hw.tt.mode=3Dshifter_tt.tt_shiftmode;
-	par->hw.tt.sync=3Dshifter.syncmode;
+	par->hw.tt.mode =3D shifter_tt.tt_shiftmode;
+	par->hw.tt.sync =3D shifter.syncmode;
 	addr =3D ((shifter.bas_hi & 0xff) << 16) |
 	       ((shifter.bas_md & 0xff) << 8)  |
 	       ((shifter.bas_lo & 0xff));
 	par->screen_base =3D phys_to_virt(addr);
 }
 =

-static void tt_set_par( struct atafb_par *par )
+static void tt_set_par(struct atafb_par *par)
 {
-	shifter_tt.tt_shiftmode=3Dpar->hw.tt.mode;
-	shifter.syncmode=3Dpar->hw.tt.sync;
+	shifter_tt.tt_shiftmode =3D par->hw.tt.mode;
+	shifter.syncmode =3D par->hw.tt.sync;
 	/* only set screen_base if really necessary */
 	if (current_par.screen_base !=3D par->screen_base)
 		fbhw->set_screen_base(par->screen_base);
 }
 =

-
-static int tt_getcolreg(unsigned regno, unsigned *red,
-			unsigned *green, unsigned *blue,
-			unsigned *transp, struct fb_info *info)
-{
-	int t, col;
-
-	if ((shifter_tt.tt_shiftmode & TT_SHIFTER_MODEMASK) =3D=3D TT_SHIFTER_STH=
IGH)
-		regno +=3D 254;
-	if (regno > 255)
-		return 1;
-	t =3D tt_palette[regno];
-	col =3D t & 15;
-	col |=3D col << 4;
-	col |=3D col << 8;
-	*blue =3D col;
-	col =3D (t >> 4) & 15;
-	col |=3D col << 4;
-	col |=3D col << 8;
-	*green =3D col;
-	col =3D (t >> 8) & 15;
-	col |=3D col << 4;
-	col |=3D col << 8;
-	*red =3D col;
-	*transp =3D 0;
-	return 0;
-}
-
-
-static int tt_setcolreg(unsigned regno, unsigned red,
-			unsigned green, unsigned blue,
-			unsigned transp, struct fb_info *info)
+static int tt_setcolreg(unsigned int regno, unsigned int red,
+			unsigned int green, unsigned int blue,
+			unsigned int transp, struct fb_info *info)
 {
 	if ((shifter_tt.tt_shiftmode & TT_SHIFTER_MODEMASK) =3D=3D TT_SHIFTER_STH=
IGH)
 		regno +=3D 254;
@@ -708,15 +819,14 @@ static int tt_setcolreg(unsigned regno, =

 	tt_palette[regno] =3D (((red >> 12) << 8) | ((green >> 12) << 4) |
 			     (blue >> 12));
 	if ((shifter_tt.tt_shiftmode & TT_SHIFTER_MODEMASK) =3D=3D
-		TT_SHIFTER_STHIGH && regno =3D=3D 254)
+	    TT_SHIFTER_STHIGH && regno =3D=3D 254)
 		tt_palette[0] =3D 0;
 	return 0;
 }
 =

-						  =

-static int tt_detect( void )
-
-{	struct atafb_par par;
+static int tt_detect(void)
+{
+	struct atafb_par par;
 =

 	/* Determine the connected monitor: The DMA sound must be
 	 * disabled before reading the MFP GPIP, because the Sound
@@ -726,9 +836,9 @@ static int tt_detect( void )
 	 * announced that the Eagle is TT compatible, but only the PCM is
 	 * missing...
 	 */
-	if (ATARIHW_PRESENT(PCM_8BIT)) { =

+	if (ATARIHW_PRESENT(PCM_8BIT)) {
 		tt_dmasnd.ctrl =3D DMASND_CTRL_OFF;
-		udelay(20);	/* wait a while for things to settle down */
+		udelay(20);		/* wait a while for things to settle down */
 	}
 	mono_moni =3D (mfp.par_dt_reg & 0x80) =3D=3D 0;
 =

@@ -755,19 +865,24 @@ static struct pixel_clock {
 	unsigned long f;	/* f/[Hz] */
 	unsigned long t;	/* t/[ps] (=3D1/f) */
 	int right, hsync, left;	/* standard timing in clock cycles, not pixel */
-		/* hsync initialized in falcon_detect() */
+	/* hsync initialized in falcon_detect() */
 	int sync_mask;		/* or-mask for hw.falcon.sync to set this clock */
 	int control_mask;	/* ditto, for hw.falcon.vid_control */
-}
-f25  =3D {25175000, 39721, 18, 0, 42, 0x0, VCO_CLOCK25},
-f32  =3D {32000000, 31250, 18, 0, 42, 0x0, 0},
-fext =3D {       0,     0, 18, 0, 42, 0x1, 0};
+} f25 =3D {
+	25175000, 39721, 18, 0, 42, 0x0, VCO_CLOCK25
+}, f32 =3D {
+	32000000, 31250, 18, 0, 42, 0x0, 0
+}, fext =3D {
+	0, 0, 18, 0, 42, 0x1, 0
+};
 =

 /* VIDEL-prescale values [mon_type][pixel_length from VCO] */
-static int vdl_prescale[4][3] =3D {{4,2,1}, {4,2,1}, {4,2,2}, {4,2,1}};
+static int vdl_prescale[4][3] =3D {
+	{ 4,2,1 }, { 4,2,1 }, { 4,2,2 }, { 4,2,1 }
+};
 =

 /* Default hsync timing [mon_type] in picoseconds */
-static long h_syncs[4] =3D {3000000, 4875000, 4000000, 4875000};
+static long h_syncs[4] =3D { 3000000, 4875000, 4000000, 4875000 };
 =

 #ifdef FBCON_HAS_CFB16
 static u16 fbcon_cfb16_cmap[16];
@@ -775,12 +890,12 @@ #endif
 =

 static inline int hxx_prescale(struct falcon_hw *hw)
 {
-	return hw->ste_mode ? 16 :
-		   vdl_prescale[mon_type][hw->vid_mode >> 2 & 0x3];
+	return hw->ste_mode ? 16
+			    : vdl_prescale[mon_type][hw->vid_mode >> 2 & 0x3];
 }
 =

-static int falcon_encode_fix( struct fb_fix_screeninfo *fix,
-							  struct atafb_par *par )
+static int falcon_encode_fix(struct fb_fix_screeninfo *fix,
+			     struct atafb_par *par)
 {
 	strcpy(fix->id, "Atari Builtin");
 	fix->smem_start =3D (unsigned long)real_screen_base;
@@ -796,8 +911,7 @@ static int falcon_encode_fix( struct fb_
 		fix->type_aux =3D 0;
 		/* no smooth scrolling with longword aligned video mem */
 		fix->xpanstep =3D 32;
-	}
-	else if (par->hw.falcon.f_shift & 0x100) {
+	} else if (par->hw.falcon.f_shift & 0x100) {
 		fix->type =3D FB_TYPE_PACKED_PIXELS;
 		fix->type_aux =3D 0;
 		/* Is this ok or should it be DIRECTCOLOR? */
@@ -809,9 +923,8 @@ static int falcon_encode_fix( struct fb_
 	return 0;
 }
 =

-
-static int falcon_decode_var( struct fb_var_screeninfo *var,
-							  struct atafb_par *par )
+static int falcon_decode_var(struct fb_var_screeninfo *var,
+			     struct atafb_par *par)
 {
 	int bpp =3D var->bits_per_pixel;
 	int xres =3D var->xres;
@@ -823,17 +936,19 @@ static int falcon_decode_var( struct fb_
 	int linelen;
 	int interlace =3D 0, doubleline =3D 0;
 	struct pixel_clock *pclock;
-	int plen; /* width of pixel in clock cycles */
+	int plen;			/* width of pixel in clock cycles */
 	int xstretch;
 	int prescale;
 	int longoffset =3D 0;
 	int hfreq, vfreq;
+	int hdb_off, hde_off, base_off;
+	int gstart, gend1, gend2, align;
 =

 /*
 	Get the video params out of 'var'. If a value doesn't fit, round
 	it up, if it's too big, return EINVAL.
-	Round up in the following order: bits_per_pixel, xres, yres, =

-	xres_virtual, yres_virtual, xoffset, yoffset, grayscale, bitfields, =

+	Round up in the following order: bits_per_pixel, xres, yres,
+	xres_virtual, yres_virtual, xoffset, yoffset, grayscale, bitfields,
 	horizontal timing, vertical timing.
 =

 	There is a maximum of screen resolution determined by pixelclock
@@ -843,11 +958,11 @@ static int falcon_decode_var( struct fb_
 	Frequency range for multisync monitors is given via command line.
 	For TV and SM124 both frequencies are fixed.
 =

-	X % 16 =3D=3D 0 to fit 8x?? font (except 1 bitplane modes must use X%32=
=3D=3D0)
+	X % 16 =3D=3D 0 to fit 8x?? font (except 1 bitplane modes must use X%32 =
=3D=3D 0)
 	Y % 16 =3D=3D 0 to fit 8x16 font
 	Y % 8 =3D=3D 0 if Y<400
 =

-	Currently interlace and doubleline mode in var are ignored. =

+	Currently interlace and doubleline mode in var are ignored.
 	On SM124 and TV only the standard resolutions can be used.
 */
 =

@@ -855,43 +970,38 @@ static int falcon_decode_var( struct fb_
 	if (!xres || !yres || !bpp)
 		return -EINVAL;
 =

-	if (mon_type =3D=3D F_MON_SM && bpp !=3D 1) {
+	if (mon_type =3D=3D F_MON_SM && bpp !=3D 1)
 		return -EINVAL;
-	}
-	else if (bpp <=3D 1) {
+
+	if (bpp <=3D 1) {
 		bpp =3D 1;
 		par->hw.falcon.f_shift =3D 0x400;
 		par->hw.falcon.st_shift =3D 0x200;
-	}
-	else if (bpp <=3D 2) {
+	} else if (bpp <=3D 2) {
 		bpp =3D 2;
 		par->hw.falcon.f_shift =3D 0x000;
 		par->hw.falcon.st_shift =3D 0x100;
-	}
-	else if (bpp <=3D 4) {
+	} else if (bpp <=3D 4) {
 		bpp =3D 4;
 		par->hw.falcon.f_shift =3D 0x000;
 		par->hw.falcon.st_shift =3D 0x000;
-	}
-	else if (bpp <=3D 8) {
+	} else if (bpp <=3D 8) {
 		bpp =3D 8;
 		par->hw.falcon.f_shift =3D 0x010;
-	}
-	else if (bpp <=3D 16) {
-		bpp =3D 16; /* packed pixel mode */
-		par->hw.falcon.f_shift =3D 0x100; /* hicolor, no overlay */
-	}
-	else
+	} else if (bpp <=3D 16) {
+		bpp =3D 16;		/* packed pixel mode */
+		par->hw.falcon.f_shift =3D 0x100;	/* hicolor, no overlay */
+	} else
 		return -EINVAL;
 	par->hw.falcon.bpp =3D bpp;
 =

 	if (mon_type =3D=3D F_MON_SM || DontCalcRes) {
 		/* Skip all calculations. VGA/TV/SC1224 only supported. */
 		struct fb_var_screeninfo *myvar =3D &atafb_predefined[0];
-		=

+
 		if (bpp > myvar->bits_per_pixel ||
-			var->xres > myvar->xres ||
-			var->yres > myvar->yres)
+		    var->xres > myvar->xres ||
+		    var->yres > myvar->yres)
 			return -EINVAL;
 		fbhw->get_par(par);	/* Current par will be new par */
 		goto set_screen_base;	/* Don't forget this */
@@ -910,8 +1020,8 @@ static int falcon_decode_var( struct fb_
 		yres =3D 400;
 =

 	/* 2 planes must use STE compatibility mode */
-	par->hw.falcon.ste_mode =3D bpp=3D=3D2;
-	par->hw.falcon.mono =3D bpp=3D=3D1;
+	par->hw.falcon.ste_mode =3D bpp =3D=3D 2;
+	par->hw.falcon.mono =3D bpp =3D=3D 1;
 =

 	/* Total and visible scanline length must be a multiple of one longword,
 	 * this and the console fontwidth yields the alignment for xres and
@@ -967,8 +1077,7 @@ #if 0 /* SM124 supports only 640x400, th
 		left_margin =3D hsync_len =3D 128 / plen;
 		right_margin =3D 0;
 		/* TODO set all margins */
-	}
-	else
+	} else
 #endif
 	if (mon_type =3D=3D F_MON_SC || mon_type =3D=3D F_MON_TV) {
 		plen =3D 2 * xstretch;
@@ -1002,26 +1111,24 @@ #endif
 				vsync_len *=3D 2;
 			}
 		}
-	}
-	else
-	{	/* F_MON_VGA */
+	} else {			/* F_MON_VGA */
 		if (bpp =3D=3D 16)
-			xstretch =3D 2; /* Double pixel width only for hicolor */
+			xstretch =3D 2;	/* Double pixel width only for hicolor */
 		/* Default values are used for vert./hor. timing if no pixelclock given.=
 */
 		if (var->pixclock =3D=3D 0) {
 			int linesize;
 =

 			/* Choose master pixelclock depending on hor. timing */
 			plen =3D 1 * xstretch;
-			if ((plen * xres + f25.right+f25.hsync+f25.left) *
+			if ((plen * xres + f25.right + f25.hsync + f25.left) *
 			    fb_info.monspecs.hfmin < f25.f)
 				pclock =3D &f25;
-			else if ((plen * xres + f32.right+f32.hsync+f32.left) * =

-			    fb_info.monspecs.hfmin < f32.f)
+			else if ((plen * xres + f32.right + f32.hsync +
+				  f32.left) * fb_info.monspecs.hfmin < f32.f)
 				pclock =3D &f32;
-			else if ((plen * xres + fext.right+fext.hsync+fext.left) * =

-			    fb_info.monspecs.hfmin < fext.f
-			         && fext.f)
+			else if ((plen * xres + fext.right + fext.hsync +
+				  fext.left) * fb_info.monspecs.hfmin < fext.f &&
+			         fext.f)
 				pclock =3D &fext;
 			else
 				return -EINVAL;
@@ -1033,22 +1140,24 @@ #endif
 			upper_margin =3D 31;
 			lower_margin =3D 11;
 			vsync_len =3D 3;
-		}
-		else {
+		} else {
 			/* Choose largest pixelclock <=3D wanted clock */
 			int i;
 			unsigned long pcl =3D ULONG_MAX;
 			pclock =3D 0;
-			for (i=3D1; i <=3D 4; i *=3D 2) {
-				if (f25.t*i >=3D var->pixclock && f25.t*i < pcl) {
+			for (i =3D 1; i <=3D 4; i *=3D 2) {
+				if (f25.t * i >=3D var->pixclock &&
+				    f25.t * i < pcl) {
 					pcl =3D f25.t * i;
 					pclock =3D &f25;
 				}
-				if (f32.t*i >=3D var->pixclock && f32.t*i < pcl) {
+				if (f32.t * i >=3D var->pixclock &&
+				    f32.t * i < pcl) {
 					pcl =3D f32.t * i;
 					pclock =3D &f32;
 				}
-				if (fext.t && fext.t*i >=3D var->pixclock && fext.t*i < pcl) {
+				if (fext.t && fext.t * i >=3D var->pixclock &&
+				    fext.t * i < pcl) {
 					pcl =3D fext.t * i;
 					pclock =3D &fext;
 				}
@@ -1070,8 +1179,7 @@ #endif
 				upper_margin =3D (upper_margin + 1) / 2;
 				lower_margin =3D (lower_margin + 1) / 2;
 				vsync_len =3D (vsync_len + 1) / 2;
-			}
-			else if (var->vmode & FB_VMODE_DOUBLE) {
+			} else if (var->vmode & FB_VMODE_DOUBLE) {
 				/* External unit is [double lines per frame] */
 				upper_margin *=3D 2;
 				lower_margin *=3D 2;
@@ -1079,7 +1187,7 @@ #endif
 			}
 		}
 		if (pclock =3D=3D &fext)
-			longoffset =3D 1; /* VIDEL doesn't synchronize on short offset */
+			longoffset =3D 1;	/* VIDEL doesn't synchronize on short offset */
 	}
 	/* Is video bus bandwidth (32MB/s) too low for this resolution? */
 	/* this is definitely wrong if bus clock !=3D 32MHz */
@@ -1098,7 +1206,7 @@ #endif
 	 * between interlace and non-interlace without messing around
 	 * with these.
 	 */
-  again:
+again:
 	/* Set base_offset 128 and video bus width */
 	par->hw.falcon.vid_control =3D mon_type | f030_bus_width;
 	if (!longoffset)
@@ -1112,37 +1220,34 @@ #endif
 	/* External or internal clock */
 	par->hw.falcon.sync =3D pclock->sync_mask | 0x2;
 	/* Pixellength and prescale */
-	par->hw.falcon.vid_mode =3D (2/plen) << 2;
+	par->hw.falcon.vid_mode =3D (2 / plen) << 2;
 	if (doubleline)
 		par->hw.falcon.vid_mode |=3D VMO_DOUBLE;
 	if (interlace)
 		par->hw.falcon.vid_mode |=3D VMO_INTER;
 =

 	/*********************
-	Horizontal timing: unit =3D [master clock cycles]
-	unit of hxx-registers: [master clock cycles * prescale]
-	Hxx-registers are 9 bit wide
-
-	1 line =3D ((hht + 2) * 2 * prescale) clock cycles
-
-	graphic output =3D hdb & 0x200 ?
-	       ((hht+2)*2 - hdb + hde) * prescale - hdboff + hdeoff:
-	       ( hht + 2  - hdb + hde) * prescale - hdboff + hdeoff
-	(this must be a multiple of plen*128/bpp, on VGA pixels
-	 to the right may be cut off with a bigger right margin)
-
-	start of graphics relative to start of 1st halfline =3D hdb & 0x200 ?
-	       (hdb - hht - 2) * prescale + hdboff :
-	       hdb * prescale + hdboff
-
-	end of graphics relative to start of 1st halfline =3D
-	       (hde + hht + 2) * prescale + hdeoff
-	*********************/
+	 * Horizontal timing: unit =3D [master clock cycles]
+	 * unit of hxx-registers: [master clock cycles * prescale]
+	 * Hxx-registers are 9 bit wide
+	 *
+	 * 1 line =3D ((hht + 2) * 2 * prescale) clock cycles
+	 *
+	 * graphic output =3D hdb & 0x200 ?
+	 *        ((hht + 2) * 2 - hdb + hde) * prescale - hdboff + hdeoff:
+	 *        (hht + 2  - hdb + hde) * prescale - hdboff + hdeoff
+	 * (this must be a multiple of plen*128/bpp, on VGA pixels
+	 *  to the right may be cut off with a bigger right margin)
+	 *
+	 * start of graphics relative to start of 1st halfline =3D hdb & 0x200 ?
+	 *        (hdb - hht - 2) * prescale + hdboff :
+	 *        hdb * prescale + hdboff
+	 *
+	 * end of graphics relative to start of 1st halfline =3D
+	 *        (hde + hht + 2) * prescale + hdeoff
+	 *********************/
 	/* Calculate VIDEL registers */
-	{
-	int hdb_off, hde_off, base_off;
-	int gstart, gend1, gend2, align;
-
+{
 	prescale =3D hxx_prescale(&par->hw.falcon);
 	base_off =3D par->hw.falcon.vid_control & VCO_SHORTOFFS ? 64 : 128;
 =

@@ -1154,8 +1259,7 @@ #endif
 		align =3D 1;
 		hde_off =3D 0;
 		hdb_off =3D (base_off + 16 * plen) + prescale;
-	}
-	else {
+	} else {
 		align =3D 128 / bpp;
 		hde_off =3D ((128 / bpp + 2) * plen);
 		if (par->hw.falcon.ste_mode)
@@ -1164,23 +1268,24 @@ #endif
 			hdb_off =3D (base_off + (128 / bpp + 18) * plen) + prescale;
 	}
 =

-	gstart =3D (prescale/2 + plen * left_margin) / prescale;
+	gstart =3D (prescale / 2 + plen * left_margin) / prescale;
 	/* gend1 is for hde (gend-gstart multiple of align), shifter's xres */
-	gend1 =3D gstart + ((xres + align-1) / align)*align * plen / prescale;
+	gend1 =3D gstart + ((xres + align - 1) / align) * align * plen / prescale;
 	/* gend2 is for hbb, visible xres (rest to gend1 is cut off by hblank) */
 	gend2 =3D gstart + xres * plen / prescale;
 	par->HHT =3D plen * (left_margin + xres + right_margin) /
 			   (2 * prescale) - 2;
 /*	par->HHT =3D (gend2 + plen * right_margin / prescale) / 2 - 2;*/
 =

-	par->HDB =3D gstart - hdb_off/prescale;
+	par->HDB =3D gstart - hdb_off / prescale;
 	par->HBE =3D gstart;
-	if (par->HDB < 0) par->HDB +=3D par->HHT + 2 + 0x200;
-	par->HDE =3D gend1 - par->HHT - 2 - hde_off/prescale;
+	if (par->HDB < 0)
+		par->HDB +=3D par->HHT + 2 + 0x200;
+	par->HDE =3D gend1 - par->HHT - 2 - hde_off / prescale;
 	par->HBB =3D gend2 - par->HHT - 2;
 #if 0
 	/* One more Videl constraint: data fetch of two lines must not overlap */
-	if ((par->HDB & 0x200)  &&  (par->HDB & ~0x200) - par->HDE <=3D 5) {
+	if ((par->HDB & 0x200) && (par->HDB & ~0x200) - par->HDE <=3D 5) {
 		/* if this happens increase margins, decrease hfreq. */
 	}
 #endif
@@ -1189,11 +1294,11 @@ #endif
 	par->HSS =3D par->HHT + 2 - plen * hsync_len / prescale;
 	if (par->HSS < par->HBB)
 		par->HSS =3D par->HBB;
-	}
+}
 =

 	/*  check hor. frequency */
-	hfreq =3D pclock->f / ((par->HHT+2)*prescale*2);
-	if (hfreq > fb_info.monspecs.hfmax && mon_type!=3DF_MON_VGA) {
+	hfreq =3D pclock->f / ((par->HHT + 2) * prescale * 2);
+	if (hfreq > fb_info.monspecs.hfmax && mon_type !=3D F_MON_VGA) {
 		/* ++guenther:   ^^^^^^^^^^^^^^^^^^^ can't remember why I did this */
 		/* Too high -> enlarge margin */
 		left_margin +=3D 1;
@@ -1213,12 +1318,14 @@ #endif
 	par->VBE =3D (upper_margin * 2 + 1); /* must begin on odd halfline */
 	par->VDB =3D par->VBE;
 	par->VDE =3D yres;
-	if (!interlace) par->VDE <<=3D 1;
-	if (doubleline) par->VDE <<=3D 1;  /* VDE now half lines per (half-)frame=
 */
+	if (!interlace)
+		par->VDE <<=3D 1;
+	if (doubleline)
+		par->VDE <<=3D 1;		/* VDE now half lines per (half-)frame */
 	par->VDE +=3D par->VDB;
 	par->VBB =3D par->VDE;
 	par->VFT =3D par->VBB + (lower_margin * 2 - 1) - 1;
-	par->VSS =3D par->VFT+1 - (vsync_len * 2 - 1);
+	par->VSS =3D par->VFT + 1 - (vsync_len * 2 - 1);
 	/* vbb,vss,vft must be even in interlace mode */
 	if (interlace) {
 		par->VBB++;
@@ -1229,55 +1336,53 @@ #endif
 	/* V-frequency check, hope I didn't create any loop here. */
 	/* Interlace and doubleline are mutually exclusive. */
 	vfreq =3D (hfreq * 2) / (par->VFT + 1);
-	if      (vfreq > fb_info.monspecs.vfmax && !doubleline && !interlace) {
+	if (vfreq > fb_info.monspecs.vfmax && !doubleline && !interlace) {
 		/* Too high -> try again with doubleline */
 		doubleline =3D 1;
 		goto again;
-	}
-	else if (vfreq < fb_info.monspecs.vfmin && !interlace && !doubleline) {
+	} else if (vfreq < fb_info.monspecs.vfmin && !interlace && !doubleline) {
 		/* Too low -> try again with interlace */
 		interlace =3D 1;
 		goto again;
-	}
-	else if (vfreq < fb_info.monspecs.vfmin && doubleline) {
+	} else if (vfreq < fb_info.monspecs.vfmin && doubleline) {
 		/* Doubleline too low -> clear doubleline and enlarge margins */
 		int lines;
 		doubleline =3D 0;
-		for (lines=3D0;
-		     (hfreq*2)/(par->VFT+1+4*lines-2*yres)>fb_info.monspecs.vfmax;
+		for (lines =3D 0;
+		     (hfreq * 2) / (par->VFT + 1 + 4 * lines - 2 * yres) >
+		     fb_info.monspecs.vfmax;
 		     lines++)
 			;
 		upper_margin +=3D lines;
 		lower_margin +=3D lines;
 		goto again;
-	}
-	else if (vfreq > fb_info.monspecs.vfmax && doubleline) {
+	} else if (vfreq > fb_info.monspecs.vfmax && doubleline) {
 		/* Doubleline too high -> enlarge margins */
 		int lines;
-		for (lines=3D0;
-		     (hfreq*2)/(par->VFT+1+4*lines)>fb_info.monspecs.vfmax;
-		     lines+=3D2)
+		for (lines =3D 0;
+		     (hfreq * 2) / (par->VFT + 1 + 4 * lines) >
+		     fb_info.monspecs.vfmax;
+		     lines +=3D 2)
 			;
 		upper_margin +=3D lines;
 		lower_margin +=3D lines;
 		goto again;
-	}
-	else if (vfreq > fb_info.monspecs.vfmax && interlace) {
+	} else if (vfreq > fb_info.monspecs.vfmax && interlace) {
 		/* Interlace, too high -> enlarge margins */
 		int lines;
-		for (lines=3D0;
-		     (hfreq*2)/(par->VFT+1+4*lines)>fb_info.monspecs.vfmax;
+		for (lines =3D 0;
+		     (hfreq * 2) / (par->VFT + 1 + 4 * lines) >
+		     fb_info.monspecs.vfmax;
 		     lines++)
 			;
 		upper_margin +=3D lines;
 		lower_margin +=3D lines;
 		goto again;
-	}
-	else if (vfreq < fb_info.monspecs.vfmin ||
-		 vfreq > fb_info.monspecs.vfmax)
+	} else if (vfreq < fb_info.monspecs.vfmin ||
+		   vfreq > fb_info.monspecs.vfmax)
 		return -EINVAL;
 =

-  set_screen_base:
+set_screen_base:
 	linelen =3D xres_virtual * bpp / 8;
 	if (yres_virtual * linelen > screen_len && screen_len)
 		return -EINVAL;
@@ -1289,11 +1394,20 @@ #endif
 	par->screen_base =3D screen_base + var->yoffset * linelen;
 	par->hw.falcon.xoffset =3D 0;
 =

+	// FIXME!!! sort of works, no crash
+	//par->next_line =3D linelen;
+	//par->next_plane =3D yres_virtual * linelen;
+	par->next_line =3D linelen;
+	par->next_plane =3D 2;
+	// crashes
+	//par->next_plane =3D linelen;
+	//par->next_line  =3D yres_virtual * linelen;
+
 	return 0;
 }
 =

-static int falcon_encode_var( struct fb_var_screeninfo *var,
-							  struct atafb_par *par )
+static int falcon_encode_var(struct fb_var_screeninfo *var,
+			     struct atafb_par *par)
 {
 /* !!! only for VGA !!! */
 	int linelen;
@@ -1306,10 +1420,10 @@ static int falcon_encode_var( struct fb_
 	var->pixclock =3D hw->sync & 0x1 ? fext.t :
 	                hw->vid_control & VCO_CLOCK25 ? f25.t : f32.t;
 =

-	var->height=3D-1;
-	var->width=3D-1;
+	var->height =3D -1;
+	var->width =3D -1;
 =

-	var->sync=3D0;
+	var->sync =3D 0;
 	if (hw->vid_control & VCO_HSYPOS)
 		var->sync |=3D FB_SYNC_HOR_HIGH_ACT;
 	if (hw->vid_control & VCO_VSYPOS)
@@ -1320,7 +1434,7 @@ static int falcon_encode_var( struct fb_
 		var->vmode |=3D FB_VMODE_INTERLACED;
 	if (hw->vid_mode & VMO_DOUBLE)
 		var->vmode |=3D FB_VMODE_DOUBLE;
-	=

+
 	/* visible y resolution:
 	 * Graphics display starts at line VDB and ends at line
 	 * VDE. If interlace mode off unit of VC-registers is
@@ -1332,14 +1446,15 @@ static int falcon_encode_var( struct fb_
 	if (var->vmode & FB_VMODE_DOUBLE)
 		var->yres >>=3D 1;
 =

-	/* to get bpp, we must examine f_shift and st_shift.
+	/*
+	 * to get bpp, we must examine f_shift and st_shift.
 	 * f_shift is valid if any of bits no. 10, 8 or 4
 	 * is set. Priority in f_shift is: 10 ">" 8 ">" 4, i.e.
 	 * if bit 10 set then bit 8 and bit 4 don't care...
 	 * If all these bits are 0 get display depth from st_shift
 	 * (as for ST and STE)
 	 */
-	if (hw->f_shift & 0x400)		/* 2 colors */
+	if (hw->f_shift & 0x400)	/* 2 colors */
 		var->bits_per_pixel =3D 1;
 	else if (hw->f_shift & 0x100)	/* hicolor */
 		var->bits_per_pixel =3D 16;
@@ -1349,7 +1464,7 @@ static int falcon_encode_var( struct fb_
 		var->bits_per_pixel =3D 4;
 	else if (hw->st_shift =3D=3D 0x100)
 		var->bits_per_pixel =3D 2;
-	else /* if (hw->st_shift =3D=3D 0x200) */
+	else				/* if (hw->st_shift =3D=3D 0x200) */
 		var->bits_per_pixel =3D 1;
 =

 	var->xres =3D hw->line_width * 16 / var->bits_per_pixel;
@@ -1358,42 +1473,42 @@ static int falcon_encode_var( struct fb_
 		var->xres_virtual +=3D 16;
 =

 	if (var->bits_per_pixel =3D=3D 16) {
-		var->red.offset=3D11;
-		var->red.length=3D5;
-		var->red.msb_right=3D0;
-		var->green.offset=3D5;
-		var->green.length=3D6;
-		var->green.msb_right=3D0;
-		var->blue.offset=3D0;
-		var->blue.length=3D5;
-		var->blue.msb_right=3D0;
-	}
-	else {
-		var->red.offset=3D0;
+		var->red.offset =3D 11;
+		var->red.length =3D 5;
+		var->red.msb_right =3D 0;
+		var->green.offset =3D 5;
+		var->green.length =3D 6;
+		var->green.msb_right =3D 0;
+		var->blue.offset =3D 0;
+		var->blue.length =3D 5;
+		var->blue.msb_right =3D 0;
+	} else {
+		var->red.offset =3D 0;
 		var->red.length =3D hw->ste_mode ? 4 : 6;
-		var->red.msb_right=3D0;
-		var->grayscale=3D0;
-		var->blue=3Dvar->green=3Dvar->red;
+		if (var->red.length > var->bits_per_pixel)
+			var->red.length =3D var->bits_per_pixel;
+		var->red.msb_right =3D 0;
+		var->grayscale =3D 0;
+		var->blue =3D var->green =3D var->red;
 	}
-	var->transp.offset=3D0;
-	var->transp.length=3D0;
-	var->transp.msb_right=3D0;
+	var->transp.offset =3D 0;
+	var->transp.length =3D 0;
+	var->transp.msb_right =3D 0;
 =

 	linelen =3D var->xres_virtual * var->bits_per_pixel / 8;
 	if (screen_len) {
 		if (par->yres_virtual)
 			var->yres_virtual =3D par->yres_virtual;
 		else
-			/* yres_virtual=3D=3D0 means use maximum */
+			/* yres_virtual =3D=3D 0 means use maximum */
 			var->yres_virtual =3D screen_len / linelen;
-	}
-	else {
+	} else {
 		if (hwscroll < 0)
 			var->yres_virtual =3D 2 * var->yres;
 		else
-			var->yres_virtual=3Dvar->yres+hwscroll * 16;
+			var->yres_virtual =3D var->yres + hwscroll * 16;
 	}
-	var->xoffset=3D0; /* TODO change this */
+	var->xoffset =3D 0;		/* TODO change this */
 =

 	/* hdX-offsets */
 	prescale =3D hxx_prescale(hw);
@@ -1402,8 +1517,7 @@ static int falcon_encode_var( struct fb_
 	if (hw->f_shift & 0x100) {
 		hde_off =3D 0;
 		hdb_off =3D (base_off + 16 * plen) + prescale;
-	}
-	else {
+	} else {
 		hde_off =3D ((128 / var->bits_per_pixel + 2) * plen);
 		if (hw->ste_mode)
 			hdb_off =3D (64 + base_off + (128 / var->bits_per_pixel + 2) * plen)
@@ -1415,8 +1529,8 @@ static int falcon_encode_var( struct fb_
 =

 	/* Right margin includes hsync */
 	var->left_margin =3D hdb_off + prescale * ((hw->hdb & 0x1ff) -
-					   (hw->hdb & 0x200 ? 2+hw->hht : 0));
-	if (hw->ste_mode || mon_type!=3DF_MON_VGA)
+					   (hw->hdb & 0x200 ? 2 + hw->hht : 0));
+	if (hw->ste_mode || mon_type !=3D F_MON_VGA)
 		var->right_margin =3D prescale * (hw->hht + 2 - hw->hde) - hde_off;
 	else
 		/* can't use this in ste_mode, because hbb is +1 off */
@@ -1424,15 +1538,14 @@ static int falcon_encode_var( struct fb_
 	var->hsync_len =3D prescale * (hw->hht + 2 - hw->hss);
 =

 	/* Lower margin includes vsync */
-	var->upper_margin =3D hw->vdb / 2 ;  /* round down to full lines */
-	var->lower_margin =3D (hw->vft+1 - hw->vde + 1) / 2; /* round up */
-	var->vsync_len    =3D (hw->vft+1 - hw->vss + 1) / 2; /* round up */
+	var->upper_margin =3D hw->vdb / 2;	/* round down to full lines */
+	var->lower_margin =3D (hw->vft + 1 - hw->vde + 1) / 2;	/* round up */
+	var->vsync_len =3D (hw->vft + 1 - hw->vss + 1) / 2;	/* round up */
 	if (var->vmode & FB_VMODE_INTERLACED) {
 		var->upper_margin *=3D 2;
 		var->lower_margin *=3D 2;
 		var->vsync_len *=3D 2;
-	}
-	else if (var->vmode & FB_VMODE_DOUBLE) {
+	} else if (var->vmode & FB_VMODE_DOUBLE) {
 		var->upper_margin =3D (var->upper_margin + 1) / 2;
 		var->lower_margin =3D (var->lower_margin + 1) / 2;
 		var->vsync_len =3D (var->vsync_len + 1) / 2;
@@ -1447,20 +1560,19 @@ static int falcon_encode_var( struct fb_
 	var->lower_margin -=3D var->vsync_len;
 =

 	if (screen_base)
-		var->yoffset=3D(par->screen_base - screen_base)/linelen;
+		var->yoffset =3D (par->screen_base - screen_base) / linelen;
 	else
-		var->yoffset=3D0;
-	var->nonstd=3D0;	/* what is this for? */
-	var->activate=3D0;
+		var->yoffset =3D 0;
+	var->nonstd =3D 0;		/* what is this for? */
+	var->activate =3D 0;
 	return 0;
 }
 =

-
-static int f_change_mode =3D 0;
+static int f_change_mode;
 static struct falcon_hw f_new_mode;
-static int f_pan_display =3D 0;
+static int f_pan_display;
 =

-static void falcon_get_par( struct atafb_par *par )
+static void falcon_get_par(struct atafb_par *par)
 {
 	unsigned long addr;
 	struct falcon_hw *hw =3D &par->hw.falcon;
@@ -1492,12 +1604,12 @@ static void falcon_get_par( struct atafb
 	par->screen_base =3D phys_to_virt(addr);
 =

 	/* derived parameters */
-	hw->ste_mode =3D (hw->f_shift & 0x510)=3D=3D0 && hw->st_shift=3D=3D0x100;
+	hw->ste_mode =3D (hw->f_shift & 0x510) =3D=3D 0 && hw->st_shift =3D=3D 0x=
100;
 	hw->mono =3D (hw->f_shift & 0x400) ||
-	           ((hw->f_shift & 0x510)=3D=3D0 && hw->st_shift=3D=3D0x200);
+	           ((hw->f_shift & 0x510) =3D=3D 0 && hw->st_shift =3D=3D 0x200);
 }
 =

-static void falcon_set_par( struct atafb_par *par )
+static void falcon_set_par(struct atafb_par *par)
 {
 	f_change_mode =3D 0;
 =

@@ -1519,8 +1631,7 @@ static void falcon_set_par( struct atafb
 	f_change_mode =3D 1;
 }
 =

-
-static irqreturn_t falcon_vbl_switcher( int irq, void *dummy )
+static irqreturn_t falcon_vbl_switcher(int irq, void *dummy)
 {
 	struct falcon_hw *hw =3D &f_new_mode;
 =

@@ -1529,11 +1640,10 @@ static irqreturn_t falcon_vbl_switcher( =

 =

 		if (hw->sync & 0x1) {
 			/* Enable external pixelclock. This code only for ScreenWonder */
-			*(volatile unsigned short*)0xffff9202 =3D 0xffbf;
-		}
-		else {
+			*(volatile unsigned short *)0xffff9202 =3D 0xffbf;
+		} else {
 			/* Turn off external clocks. Read sets all output bits to 1. */
-			*(volatile unsigned short*)0xffff9202;
+			*(volatile unsigned short *)0xffff9202;
 		}
 		shifter.syncmode =3D hw->sync;
 =

@@ -1550,15 +1660,14 @@ static irqreturn_t falcon_vbl_switcher( =

 		videl.vde =3D hw->vde;
 		videl.vss =3D hw->vss;
 =

-		videl.f_shift =3D 0; /* write enables Falcon palette, 0: 4 planes */
+		videl.f_shift =3D 0;	/* write enables Falcon palette, 0: 4 planes */
 		if (hw->ste_mode) {
-			videl.st_shift =3D hw->st_shift; /* write enables STE palette */
-		}
-		else {
+			videl.st_shift =3D hw->st_shift;	/* write enables STE palette */
+		} else {
 			/* IMPORTANT:
-			 * set st_shift 0, so we can tell the screen-depth if f_shift=3D=3D0.
+			 * set st_shift 0, so we can tell the screen-depth if f_shift =3D=3D 0.
 			 * Writing 0 to f_shift enables 4 plane Falcon mode but
-			 * doesn't set st_shift. st_shift!=3D0 (!=3D4planes) is impossible
+			 * doesn't set st_shift. st_shift !=3D 0 (!=3D 4planes) is impossible
 			 * with Falcon palette.
 			 */
 			videl.st_shift =3D 0;
@@ -1580,12 +1689,13 @@ static irqreturn_t falcon_vbl_switcher( =

 	return IRQ_HANDLED;
 }
 =

-
-static int falcon_pan_display( struct fb_var_screeninfo *var,
-							   struct atafb_par *par )
+static int falcon_pan_display(struct fb_var_screeninfo *var,
+			      struct fb_info *info)
 {
+	struct atafb_par *par =3D (struct atafb_par *)info->par;
+
 	int xoffset;
-	int bpp =3D fb_display[fb_info.currcon].var.bits_per_pixel;
+	int bpp =3D info->var.bits_per_pixel;
 =

 	if (bpp =3D=3D 1)
 		var->xoffset =3D up(var->xoffset, 32);
@@ -1596,45 +1706,24 @@ static int falcon_pan_display( struct fb
 		var->xoffset =3D up(var->xoffset, 2);
 	}
 	par->hw.falcon.line_offset =3D bpp *
-	       	(fb_display[fb_info.currcon].var.xres_virtual - fb_display[fb_inf=
o.currcon].var.xres) / 16;
+		(info->var.xres_virtual - info->var.xres) / 16;
 	if (par->hw.falcon.xoffset)
 		par->hw.falcon.line_offset -=3D bpp;
 	xoffset =3D var->xoffset - par->hw.falcon.xoffset;
 =

 	par->screen_base =3D screen_base +
-	        (var->yoffset * fb_display[fb_info.currcon].var.xres_virtual + xo=
ffset) * bpp / 8;
+	        (var->yoffset * info->var.xres_virtual + xoffset) * bpp / 8;
 	if (fbhw->set_screen_base)
-		fbhw->set_screen_base (par->screen_base);
+		fbhw->set_screen_base(par->screen_base);
 	else
-		return -EINVAL; /* shouldn't happen */
+		return -EINVAL;		/* shouldn't happen */
 	f_pan_display =3D 1;
 	return 0;
 }
 =

-
-static int falcon_getcolreg( unsigned regno, unsigned *red,
-				 unsigned *green, unsigned *blue,
-				 unsigned *transp, struct fb_info *info )
-{	unsigned long col;
-	=

-	if (regno > 255)
-		return 1;
-	/* This works in STE-mode (with 4bit/color) since f030_col-registers
-	 * hold up to 6bit/color.
-	 * Even with hicolor r/g/b=3D5/6/5 bit!
-	 */
-	col =3D f030_col[regno];
-	*red =3D (col >> 16) & 0xff00;
-	*green =3D (col >> 8) & 0xff00;
-	*blue =3D (col << 8) & 0xff00;
-	*transp =3D 0;
-	return 0;
-}
-
-
-static int falcon_setcolreg( unsigned regno, unsigned red,
-							 unsigned green, unsigned blue,
-							 unsigned transp, struct fb_info *info )
+static int falcon_setcolreg(unsigned int regno, unsigned int red,
+			    unsigned int green, unsigned int blue,
+			    unsigned int transp, struct fb_info *info)
 {
 	if (regno > 255)
 		return 1;
@@ -1655,13 +1744,12 @@ #endif
 	return 0;
 }
 =

-
-static int falcon_blank( int blank_mode )
+static int falcon_blank(int blank_mode)
 {
-/* ++guenther: we can switch off graphics by changing VDB and VDE,
- * so VIDEL doesn't hog the bus while saving.
- * (this may affect usleep()).
- */
+	/* ++guenther: we can switch off graphics by changing VDB and VDE,
+	 * so VIDEL doesn't hog the bus while saving.
+	 * (this may affect usleep()).
+	 */
 	int vdb, vss, hbe, hss;
 =

 	if (mon_type =3D=3D F_MON_SM)	/* this doesn't work on SM124 */
@@ -1694,14 +1782,13 @@ static int falcon_blank( int blank_mode =

 	return 0;
 }
 =

- =

-static int falcon_detect( void )
+static int falcon_detect(void)
 {
 	struct atafb_par par;
 	unsigned char fhw;
 =

 	/* Determine connected monitor and set monitor parameters */
-	fhw =3D *(unsigned char*)0xffff8006;
+	fhw =3D *(unsigned char *)0xffff8006;
 	mon_type =3D fhw >> 6 & 0x3;
 	/* bit 1 of fhw: 1=3D32 bit ram bus, 0=3D16 bit */
 	f030_bus_width =3D fhw << 6 & 0x80;
@@ -1715,7 +1802,7 @@ static int falcon_detect( void )
 	case F_MON_SC:
 	case F_MON_TV:
 		/* PAL...NTSC */
-		fb_info.monspecs.vfmin =3D 49; /* not 50, since TOS defaults to 49.9x Hz=
 */
+		fb_info.monspecs.vfmin =3D 49;	/* not 50, since TOS defaults to 49.9x Hz=
 */
 		fb_info.monspecs.vfmax =3D 60;
 		fb_info.monspecs.hfmin =3D 15620;
 		fb_info.monspecs.hfmax =3D 15755;
@@ -1740,13 +1827,12 @@ #endif /* ATAFB_FALCON */
 =

 #ifdef ATAFB_STE
 =

-static int stste_encode_fix( struct fb_fix_screeninfo *fix,
-							 struct atafb_par *par )
-
+static int stste_encode_fix(struct fb_fix_screeninfo *fix,
+			    struct atafb_par *par)
 {
 	int mode;
 =

-	strcpy(fix->id,"Atari Builtin");
+	strcpy(fix->id, "Atari Builtin");
 	fix->smem_start =3D (unsigned long)real_screen_base;
 	fix->smem_len =3D screen_len;
 	fix->type =3D FB_TYPE_INTERLEAVED_PLANES;
@@ -1771,43 +1857,40 @@ static int stste_encode_fix( struct fb_f
 	return 0;
 }
 =

-
-static int stste_decode_var( struct fb_var_screeninfo *var,
-						  struct atafb_par *par )
+static int stste_decode_var(struct fb_var_screeninfo *var,
+			    struct atafb_par *par)
 {
-	int xres=3Dvar->xres;
-	int yres=3Dvar->yres;
-	int bpp=3Dvar->bits_per_pixel;
+	int xres =3D var->xres;
+	int yres =3D var->yres;
+	int bpp =3D var->bits_per_pixel;
 	int linelen;
 	int yres_virtual =3D var->yres_virtual;
 =

 	if (mono_moni) {
 		if (bpp > 1 || xres > sttt_xres || yres > st_yres)
 			return -EINVAL;
-		par->hw.st.mode=3DST_HIGH;
-		xres=3Dsttt_xres;
-		yres=3Dst_yres;
-		bpp=3D1;
+		par->hw.st.mode =3D ST_HIGH;
+		xres =3D sttt_xres;
+		yres =3D st_yres;
+		bpp =3D 1;
 	} else {
 		if (bpp > 4 || xres > sttt_xres || yres > st_yres)
 			return -EINVAL;
 		if (bpp > 2) {
-			if (xres > sttt_xres/2 || yres > st_yres/2)
+			if (xres > sttt_xres / 2 || yres > st_yres / 2)
 				return -EINVAL;
-			par->hw.st.mode=3DST_LOW;
-			xres=3Dsttt_xres/2;
-			yres=3Dst_yres/2;
-			bpp=3D4;
-		}
-		else if (bpp > 1) {
-			if (xres > sttt_xres || yres > st_yres/2)
+			par->hw.st.mode =3D ST_LOW;
+			xres =3D sttt_xres / 2;
+			yres =3D st_yres / 2;
+			bpp =3D 4;
+		} else if (bpp > 1) {
+			if (xres > sttt_xres || yres > st_yres / 2)
 				return -EINVAL;
-			par->hw.st.mode=3DST_MID;
-			xres=3Dsttt_xres;
-			yres=3Dst_yres/2;
-			bpp=3D2;
-		}
-		else
+			par->hw.st.mode =3D ST_MID;
+			xres =3D sttt_xres;
+			yres =3D st_yres / 2;
+			bpp =3D 2;
+		} else
 			return -EINVAL;
 	}
 	if (yres_virtual <=3D 0)
@@ -1815,10 +1898,10 @@ static int stste_decode_var( struct fb_v
 	else if (yres_virtual < yres)
 		yres_virtual =3D yres;
 	if (var->sync & FB_SYNC_EXT)
-		par->hw.st.sync=3D(par->hw.st.sync & ~1) | 1;
+		par->hw.st.sync =3D (par->hw.st.sync & ~1) | 1;
 	else
-		par->hw.st.sync=3D(par->hw.st.sync & ~1);
-	linelen=3Dxres*bpp/8;
+		par->hw.st.sync =3D (par->hw.st.sync & ~1);
+	linelen =3D xres * bpp / 8;
 	if (yres_virtual * linelen > screen_len && screen_len)
 		return -EINVAL;
 	if (yres * linelen > screen_len && screen_len)
@@ -1826,93 +1909,91 @@ static int stste_decode_var( struct fb_v
 	if (var->yoffset + yres > yres_virtual && yres_virtual)
 		return -EINVAL;
 	par->yres_virtual =3D yres_virtual;
-	par->screen_base=3Dscreen_base+ var->yoffset*linelen;
+	par->screen_base =3D screen_base + var->yoffset * linelen;
 	return 0;
 }
 =

-static int stste_encode_var( struct fb_var_screeninfo *var,
-						  struct atafb_par *par )
+static int stste_encode_var(struct fb_var_screeninfo *var,
+			    struct atafb_par *par)
 {
 	int linelen;
 	memset(var, 0, sizeof(struct fb_var_screeninfo));
-	var->red.offset=3D0;
+	var->red.offset =3D 0;
 	var->red.length =3D ATARIHW_PRESENT(EXTD_SHIFTER) ? 4 : 3;
-	var->red.msb_right=3D0;
-	var->grayscale=3D0;
+	var->red.msb_right =3D 0;
+	var->grayscale =3D 0;
 =

-	var->pixclock=3D31041;
-	var->left_margin=3D120;		/* these are incorrect */
-	var->right_margin=3D100;
-	var->upper_margin=3D8;
-	var->lower_margin=3D16;
-	var->hsync_len=3D140;
-	var->vsync_len=3D30;
+	var->pixclock =3D 31041;
+	var->left_margin =3D 120;		/* these are incorrect */
+	var->right_margin =3D 100;
+	var->upper_margin =3D 8;
+	var->lower_margin =3D 16;
+	var->hsync_len =3D 140;
+	var->vsync_len =3D 30;
 =

-	var->height=3D-1;
-	var->width=3D-1;
+	var->height =3D -1;
+	var->width =3D -1;
 =

 	if (!(par->hw.st.sync & 1))
-		var->sync=3D0;
+		var->sync =3D 0;
 	else
-		var->sync=3DFB_SYNC_EXT;
+		var->sync =3D FB_SYNC_EXT;
 =

 	switch (par->hw.st.mode & 3) {
 	case ST_LOW:
-		var->xres=3Dsttt_xres/2;
-		var->yres=3Dst_yres/2;
-		var->bits_per_pixel=3D4;
+		var->xres =3D sttt_xres / 2;
+		var->yres =3D st_yres / 2;
+		var->bits_per_pixel =3D 4;
 		break;
 	case ST_MID:
-		var->xres=3Dsttt_xres;
-		var->yres=3Dst_yres/2;
-		var->bits_per_pixel=3D2;
+		var->xres =3D sttt_xres;
+		var->yres =3D st_yres / 2;
+		var->bits_per_pixel =3D 2;
 		break;
 	case ST_HIGH:
-		var->xres=3Dsttt_xres;
-		var->yres=3Dst_yres;
-		var->bits_per_pixel=3D1;
+		var->xres =3D sttt_xres;
+		var->yres =3D st_yres;
+		var->bits_per_pixel =3D 1;
 		break;
-	}		=

-	var->blue=3Dvar->green=3Dvar->red;
-	var->transp.offset=3D0;
-	var->transp.length=3D0;
-	var->transp.msb_right=3D0;
-	var->xres_virtual=3Dsttt_xres_virtual;
-	linelen=3Dvar->xres_virtual * var->bits_per_pixel / 8;
-	ovsc_addlen=3Dlinelen*(sttt_yres_virtual - st_yres);
-	=

-	if (! use_hwscroll)
-		var->yres_virtual=3Dvar->yres;
+	}
+	var->blue =3D var->green =3D var->red;
+	var->transp.offset =3D 0;
+	var->transp.length =3D 0;
+	var->transp.msb_right =3D 0;
+	var->xres_virtual =3D sttt_xres_virtual;
+	linelen =3D var->xres_virtual * var->bits_per_pixel / 8;
+	ovsc_addlen =3D linelen * (sttt_yres_virtual - st_yres);
+
+	if (!use_hwscroll)
+		var->yres_virtual =3D var->yres;
 	else if (screen_len) {
 		if (par->yres_virtual)
 			var->yres_virtual =3D par->yres_virtual;
 		else
-			/* yres_virtual=3D=3D0 means use maximum */
+			/* yres_virtual =3D=3D 0 means use maximum */
 			var->yres_virtual =3D screen_len / linelen;
-	}
-	else {
+	} else {
 		if (hwscroll < 0)
 			var->yres_virtual =3D 2 * var->yres;
 		else
-			var->yres_virtual=3Dvar->yres+hwscroll * 16;
+			var->yres_virtual =3D var->yres + hwscroll * 16;
 	}
-	var->xoffset=3D0;
+	var->xoffset =3D 0;
 	if (screen_base)
-		var->yoffset=3D(par->screen_base - screen_base)/linelen;
+		var->yoffset =3D (par->screen_base - screen_base) / linelen;
 	else
-		var->yoffset=3D0;
-	var->nonstd=3D0;
-	var->activate=3D0;
-	var->vmode=3DFB_VMODE_NONINTERLACED;
+		var->yoffset =3D 0;
+	var->nonstd =3D 0;
+	var->activate =3D 0;
+	var->vmode =3D FB_VMODE_NONINTERLACED;
 	return 0;
 }
 =

-
-static void stste_get_par( struct atafb_par *par )
+static void stste_get_par(struct atafb_par *par)
 {
 	unsigned long addr;
-	par->hw.st.mode=3Dshifter_tt.st_shiftmode;
-	par->hw.st.sync=3Dshifter.syncmode;
+	par->hw.st.mode =3D shifter_tt.st_shiftmode;
+	par->hw.st.sync =3D shifter.syncmode;
 	addr =3D ((shifter.bas_hi & 0xff) << 16) |
 	       ((shifter.bas_md & 0xff) << 8);
 	if (ATARIHW_PRESENT(EXTD_SHIFTER))
@@ -1920,55 +2001,18 @@ static void stste_get_par( struct atafb_
 	par->screen_base =3D phys_to_virt(addr);
 }
 =

-static void stste_set_par( struct atafb_par *par )
+static void stste_set_par(struct atafb_par *par)
 {
-	shifter_tt.st_shiftmode=3Dpar->hw.st.mode;
-	shifter.syncmode=3Dpar->hw.st.sync;
+	shifter_tt.st_shiftmode =3D par->hw.st.mode;
+	shifter.syncmode =3D par->hw.st.sync;
 	/* only set screen_base if really necessary */
 	if (current_par.screen_base !=3D par->screen_base)
 		fbhw->set_screen_base(par->screen_base);
 }
 =

-
-static int stste_getcolreg(unsigned regno, unsigned *red,
-			   unsigned *green, unsigned *blue,
-			   unsigned *transp, struct fb_info *info)
-{
-	unsigned col, t;
-	=

-	if (regno > 15)
-		return 1;
-	col =3D shifter_tt.color_reg[regno];
-	if (ATARIHW_PRESENT(EXTD_SHIFTER)) {
-		t =3D ((col >> 7) & 0xe) | ((col >> 11) & 1);
-		t |=3D t << 4;
-		*red =3D t | (t << 8);
-		t =3D ((col >> 3) & 0xe) | ((col >> 7) & 1);
-		t |=3D t << 4;
-		*green =3D t | (t << 8);
-		t =3D ((col << 1) & 0xe) | ((col >> 3) & 1);
-		t |=3D t << 4;
-		*blue =3D t | (t << 8);
-	}
-	else {
-		t =3D (col >> 7) & 0xe;
-		t |=3D t << 4;
-		*red =3D t | (t << 8);
-		t =3D (col >> 3) & 0xe;
-		t |=3D t << 4;
-		*green =3D t | (t << 8);
-		t =3D (col << 1) & 0xe;
-		t |=3D t << 4;
-		*blue =3D t | (t << 8);
-	}
-	*transp =3D 0;
-	return 0;
-}
-
-
-static int stste_setcolreg(unsigned regno, unsigned red,
-			   unsigned green, unsigned blue,
-			   unsigned transp, struct fb_info *info)
+static int stste_setcolreg(unsigned int regno, unsigned int red,
+			   unsigned int green, unsigned int blue,
+			   unsigned int transp, struct fb_info *info)
 {
 	if (regno > 15)
 		return 1;
@@ -1988,10 +2032,9 @@ static int stste_setcolreg(unsigned regn
 	return 0;
 }
 =

-						  =

-static int stste_detect( void )
-
-{	struct atafb_par par;
+static int stste_detect(void)
+{
+	struct atafb_par par;
 =

 	/* Determine the connected monitor: The DMA sound must be
 	 * disabled before reading the MFP GPIP, because the Sound
@@ -1999,7 +2042,7 @@ static int stste_detect( void )
 	 */
 	if (ATARIHW_PRESENT(PCM_8BIT)) {
 		tt_dmasnd.ctrl =3D DMASND_CTRL_OFF;
-		udelay(20);	/* wait a while for things to settle down */
+		udelay(20);		/* wait a while for things to settle down */
 	}
 	mono_moni =3D (mfp.par_dt_reg & 0x80) =3D=3D 0;
 =

@@ -2014,12 +2057,12 @@ static int stste_detect( void )
 static void stste_set_screen_base(void *s_base)
 {
 	unsigned long addr;
-	addr=3D virt_to_phys(s_base);
+	addr =3D virt_to_phys(s_base);
 	/* Setup Screen Memory */
-	shifter.bas_hi=3D(unsigned char) ((addr & 0xff0000) >> 16);
-  	shifter.bas_md=3D(unsigned char) ((addr & 0x00ff00) >> 8);
+	shifter.bas_hi =3D (unsigned char)((addr & 0xff0000) >> 16);
+	shifter.bas_md =3D (unsigned char)((addr & 0x00ff00) >> 8);
 	if (ATARIHW_PRESENT(EXTD_SHIFTER))
-		shifter.bas_lo=3D(unsigned char)  (addr & 0x0000ff);
+		shifter.bas_lo =3D (unsigned char)(addr & 0x0000ff);
 }
 =

 #endif /* ATAFB_STE */
@@ -2045,51 +2088,49 @@ #define SYNC_DELAY  (mono_moni ? 1500 : =

 /* SWITCH_ACIA may be used for Falcon (ScreenBlaster III internal!) */
 static void st_ovsc_switch(void)
 {
-    unsigned long flags;
-    register unsigned char old, new;
+	unsigned long flags;
+	register unsigned char old, new;
 =

-    if (!(atari_switches & ATARI_SWITCH_OVSC_MASK))
-	return;
-    local_irq_save(flags);
-
-    mfp.tim_ct_b =3D 0x10;
-    mfp.active_edge |=3D 8;
-    mfp.tim_ct_b =3D 0;
-    mfp.tim_dt_b =3D 0xf0;
-    mfp.tim_ct_b =3D 8;
-    while (mfp.tim_dt_b > 1)	/* TOS does it this way, don't ask why */
-	;
-    new =3D mfp.tim_dt_b;
-    do {
-	udelay(LINE_DELAY);
-	old =3D new;
+	if (!(atari_switches & ATARI_SWITCH_OVSC_MASK))
+		return;
+	local_irq_save(flags);
+
+	mfp.tim_ct_b =3D 0x10;
+	mfp.active_edge |=3D 8;
+	mfp.tim_ct_b =3D 0;
+	mfp.tim_dt_b =3D 0xf0;
+	mfp.tim_ct_b =3D 8;
+	while (mfp.tim_dt_b > 1)	/* TOS does it this way, don't ask why */
+		;
 	new =3D mfp.tim_dt_b;
-    } while (old !=3D new);
-    mfp.tim_ct_b =3D 0x10;
-    udelay(SYNC_DELAY);
-
-    if (atari_switches & ATARI_SWITCH_OVSC_IKBD)
-	acia.key_ctrl =3D ACIA_DIV64 | ACIA_D8N1S | ACIA_RHTID | ACIA_RIE;
-    if (atari_switches & ATARI_SWITCH_OVSC_MIDI)
-	acia.mid_ctrl =3D ACIA_DIV16 | ACIA_D8N1S | ACIA_RHTID;
-    if (atari_switches & (ATARI_SWITCH_OVSC_SND6|ATARI_SWITCH_OVSC_SND7)) {
-	sound_ym.rd_data_reg_sel =3D 14;
-	sound_ym.wd_data =3D sound_ym.rd_data_reg_sel |
-			   ((atari_switches&ATARI_SWITCH_OVSC_SND6) ? 0x40:0) |
-			   ((atari_switches&ATARI_SWITCH_OVSC_SND7) ? 0x80:0);
-    }
-    local_irq_restore(flags);
+	do {
+		udelay(LINE_DELAY);
+		old =3D new;
+		new =3D mfp.tim_dt_b;
+	} while (old !=3D new);
+	mfp.tim_ct_b =3D 0x10;
+	udelay(SYNC_DELAY);
+
+	if (atari_switches & ATARI_SWITCH_OVSC_IKBD)
+		acia.key_ctrl =3D ACIA_DIV64 | ACIA_D8N1S | ACIA_RHTID | ACIA_RIE;
+	if (atari_switches & ATARI_SWITCH_OVSC_MIDI)
+		acia.mid_ctrl =3D ACIA_DIV16 | ACIA_D8N1S | ACIA_RHTID;
+	if (atari_switches & (ATARI_SWITCH_OVSC_SND6|ATARI_SWITCH_OVSC_SND7)) {
+		sound_ym.rd_data_reg_sel =3D 14;
+		sound_ym.wd_data =3D sound_ym.rd_data_reg_sel |
+				   ((atari_switches & ATARI_SWITCH_OVSC_SND6) ? 0x40:0) |
+				   ((atari_switches & ATARI_SWITCH_OVSC_SND7) ? 0x80:0);
+	}
+	local_irq_restore(flags);
 }
 =

 /* ------------------- External Video ---------------------- */
 =

 #ifdef ATAFB_EXT
 =

-static int ext_encode_fix( struct fb_fix_screeninfo *fix,
-						   struct atafb_par *par )
-
+static int ext_encode_fix(struct fb_fix_screeninfo *fix, struct atafb_par =
*par)
 {
-	strcpy(fix->id,"Unknown Extern");
+	strcpy(fix->id, "Unknown Extern");
 	fix->smem_start =3D (unsigned long)external_addr;
 	fix->smem_len =3D PAGE_ALIGN(external_len);
 	if (external_depth =3D=3D 1) {
@@ -2099,31 +2140,29 @@ static int ext_encode_fix( struct fb_fix
 		fix->visual =3D
 			(external_pmode =3D=3D FB_TYPE_INTERLEAVED_PLANES ||
 			 external_pmode =3D=3D FB_TYPE_PACKED_PIXELS) ?
-				FB_VISUAL_MONO10 :
-					FB_VISUAL_MONO01;
-	}
-	else {
+				FB_VISUAL_MONO10 : FB_VISUAL_MONO01;
+	} else {
 		/* Use STATIC if we don't know how to access color registers */
 		int visual =3D external_vgaiobase ?
 					 FB_VISUAL_PSEUDOCOLOR :
 					 FB_VISUAL_STATIC_PSEUDOCOLOR;
 		switch (external_pmode) {
-		    case -1:              /* truecolor */
-			fix->type=3DFB_TYPE_PACKED_PIXELS;
-			fix->visual=3DFB_VISUAL_TRUECOLOR;
+		case -1:		/* truecolor */
+			fix->type =3D FB_TYPE_PACKED_PIXELS;
+			fix->visual =3D FB_VISUAL_TRUECOLOR;
 			break;
-		    case FB_TYPE_PACKED_PIXELS:
-			fix->type=3DFB_TYPE_PACKED_PIXELS;
-			fix->visual=3Dvisual;
+		case FB_TYPE_PACKED_PIXELS:
+			fix->type =3D FB_TYPE_PACKED_PIXELS;
+			fix->visual =3D visual;
 			break;
-		    case FB_TYPE_PLANES:
-			fix->type=3DFB_TYPE_PLANES;
-			fix->visual=3Dvisual;
+		case FB_TYPE_PLANES:
+			fix->type =3D FB_TYPE_PLANES;
+			fix->visual =3D visual;
 			break;
-		    case FB_TYPE_INTERLEAVED_PLANES:
-			fix->type=3DFB_TYPE_INTERLEAVED_PLANES;
-			fix->type_aux=3D2;
-			fix->visual=3Dvisual;
+		case FB_TYPE_INTERLEAVED_PLANES:
+			fix->type =3D FB_TYPE_INTERLEAVED_PLANES;
+			fix->type_aux =3D 2;
+			fix->visual =3D visual;
 			break;
 		}
 	}
@@ -2134,137 +2173,112 @@ static int ext_encode_fix( struct fb_fix
 	return 0;
 }
 =

-
-static int ext_decode_var( struct fb_var_screeninfo *var,
-						   struct atafb_par *par )
+static int ext_decode_var(struct fb_var_screeninfo *var, struct atafb_par =
*par)
 {
 	struct fb_var_screeninfo *myvar =3D &atafb_predefined[0];
-	=

+
 	if (var->bits_per_pixel > myvar->bits_per_pixel ||
-		var->xres > myvar->xres ||
-		var->xres_virtual > myvar->xres_virtual ||
-		var->yres > myvar->yres ||
-		var->xoffset > 0 ||
-		var->yoffset > 0)
+	    var->xres > myvar->xres ||
+	    var->xres_virtual > myvar->xres_virtual ||
+	    var->yres > myvar->yres ||
+	    var->xoffset > 0 ||
+	    var->yoffset > 0)
 		return -EINVAL;
 	return 0;
 }
 =

-
-static int ext_encode_var( struct fb_var_screeninfo *var,
-						   struct atafb_par *par )
+static int ext_encode_var(struct fb_var_screeninfo *var, struct atafb_par =
*par)
 {
 	memset(var, 0, sizeof(struct fb_var_screeninfo));
-	var->red.offset=3D0;
-	var->red.length=3D(external_pmode =3D=3D -1) ? external_depth/3 : =

+	var->red.offset =3D 0;
+	var->red.length =3D (external_pmode =3D=3D -1) ? external_depth / 3 :
 			(external_vgaiobase ? external_bitspercol : 0);
-	var->red.msb_right=3D0;
-	var->grayscale=3D0;
+	var->red.msb_right =3D 0;
+	var->grayscale =3D 0;
 =

-	var->pixclock=3D31041;
-	var->left_margin=3D120;		/* these are surely incorrect 	*/
-	var->right_margin=3D100;
-	var->upper_margin=3D8;
-	var->lower_margin=3D16;
-	var->hsync_len=3D140;
-	var->vsync_len=3D30;
+	var->pixclock =3D 31041;
+	var->left_margin =3D 120;		/* these are surely incorrect */
+	var->right_margin =3D 100;
+	var->upper_margin =3D 8;
+	var->lower_margin =3D 16;
+	var->hsync_len =3D 140;
+	var->vsync_len =3D 30;
 =

-	var->height=3D-1;
-	var->width=3D-1;
+	var->height =3D -1;
+	var->width =3D -1;
 =

-	var->sync=3D0;
+	var->sync =3D 0;
 =

 	var->xres =3D external_xres;
 	var->yres =3D external_yres;
 	var->xres_virtual =3D external_xres_virtual;
 	var->bits_per_pixel =3D external_depth;
-	=

-	var->blue=3Dvar->green=3Dvar->red;
-	var->transp.offset=3D0;
-	var->transp.length=3D0;
-	var->transp.msb_right=3D0;
-	var->yres_virtual=3Dvar->yres;
-	var->xoffset=3D0;
-	var->yoffset=3D0;
-	var->nonstd=3D0;
-	var->activate=3D0;
-	var->vmode=3DFB_VMODE_NONINTERLACED;
+
+	var->blue =3D var->green =3D var->red;
+	var->transp.offset =3D 0;
+	var->transp.length =3D 0;
+	var->transp.msb_right =3D 0;
+	var->yres_virtual =3D var->yres;
+	var->xoffset =3D 0;
+	var->yoffset =3D 0;
+	var->nonstd =3D 0;
+	var->activate =3D 0;
+	var->vmode =3D FB_VMODE_NONINTERLACED;
 	return 0;
 }
 =

-
-static void ext_get_par( struct atafb_par *par )
+static void ext_get_par(struct atafb_par *par)
 {
 	par->screen_base =3D external_addr;
 }
 =

-static void ext_set_par( struct atafb_par *par )
+static void ext_set_par(struct atafb_par *par)
 {
 }
 =

 #define OUTB(port,val) \
-	*((unsigned volatile char *) ((port)+external_vgaiobase))=3D(val)
+	*((unsigned volatile char *) ((port)+external_vgaiobase)) =3D (val)
 #define INB(port) \
 	(*((unsigned volatile char *) ((port)+external_vgaiobase)))
-#define DACDelay 				\
+#define DACDelay				\
 	do {					\
-		unsigned char tmp=3DINB(0x3da);	\
-		tmp=3DINB(0x3da);			\
+		unsigned char tmp =3D INB(0x3da);	\
+		tmp =3D INB(0x3da);			\
 	} while (0)
 =

-static int ext_getcolreg( unsigned regno, unsigned *red,
-						  unsigned *green, unsigned *blue,
-						  unsigned *transp, struct fb_info *info )
+static int ext_setcolreg(unsigned int regno, unsigned int red,
+			 unsigned int green, unsigned int blue,
+			 unsigned int transp, struct fb_info *info)
 {
-	if (! external_vgaiobase)
+	unsigned char colmask =3D (1 << external_bitspercol) - 1;
+
+	if (!external_vgaiobase)
 		return 1;
 =

-	    *red   =3D ext_color[regno].red;
-	    *green =3D ext_color[regno].green;
-	    *blue  =3D ext_color[regno].blue;
-	    *transp=3D0;
-	    return 0;
-}
-	=

-static int ext_setcolreg( unsigned regno, unsigned red,
-						  unsigned green, unsigned blue,
-						  unsigned transp, struct fb_info *info )
+	switch (external_card_type) {
+	case IS_VGA:
+		OUTB(0x3c8, regno);
+		DACDelay;
+		OUTB(0x3c9, red & colmask);
+		DACDelay;
+		OUTB(0x3c9, green & colmask);
+		DACDelay;
+		OUTB(0x3c9, blue & colmask);
+		DACDelay;
+		return 0;
 =

-{	unsigned char colmask =3D (1 << external_bitspercol) - 1;
+	case IS_MV300:
+		OUTB((MV300_reg[regno] << 2) + 1, red);
+		OUTB((MV300_reg[regno] << 2) + 1, green);
+		OUTB((MV300_reg[regno] << 2) + 1, blue);
+		return 0;
 =

-	if (! external_vgaiobase)
+	default:
 		return 1;
-
-	ext_color[regno].red =3D red;
-	ext_color[regno].green =3D green;
-	ext_color[regno].blue =3D blue;
-
-	switch (external_card_type) {
-	  case IS_VGA:
-	    OUTB(0x3c8, regno);
-	    DACDelay;
-	    OUTB(0x3c9, red & colmask);
-	    DACDelay;
-	    OUTB(0x3c9, green & colmask);
-	    DACDelay;
-	    OUTB(0x3c9, blue & colmask);
-	    DACDelay;
-	    return 0;
-
-	  case IS_MV300:
-	    OUTB((MV300_reg[regno] << 2)+1, red);
-	    OUTB((MV300_reg[regno] << 2)+1, green);
-	    OUTB((MV300_reg[regno] << 2)+1, blue);
-	    return 0;
-
-	  default:
-	    return 1;
-	  }
+	}
 }
-	=

-
-static int ext_detect( void )
 =

+static int ext_detect(void)
 {
 	struct fb_var_screeninfo *myvar =3D &atafb_predefined[0];
 	struct atafb_par dummy_par;
@@ -2284,213 +2298,182 @@ #endif /* ATAFB_EXT */
 static void set_screen_base(void *s_base)
 {
 	unsigned long addr;
-	addr=3D virt_to_phys(s_base);
+
+	addr =3D virt_to_phys(s_base);
 	/* Setup Screen Memory */
-	shifter.bas_hi=3D(unsigned char) ((addr & 0xff0000) >> 16);
-  	shifter.bas_md=3D(unsigned char) ((addr & 0x00ff00) >> 8);
-  	shifter.bas_lo=3D(unsigned char)  (addr & 0x0000ff);
+	shifter.bas_hi =3D (unsigned char)((addr & 0xff0000) >> 16);
+	shifter.bas_md =3D (unsigned char)((addr & 0x00ff00) >> 8);
+	shifter.bas_lo =3D (unsigned char)(addr & 0x0000ff);
 }
 =

-
-static int pan_display( struct fb_var_screeninfo *var,
-                        struct atafb_par *par )
+static int pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 {
+	struct atafb_par *par =3D (struct atafb_par *)info->par;
+
 	if (!fbhw->set_screen_base ||
-		(!ATARIHW_PRESENT(EXTD_SHIFTER) && var->xoffset))
+	    (!ATARIHW_PRESENT(EXTD_SHIFTER) && var->xoffset))
 		return -EINVAL;
 	var->xoffset =3D up(var->xoffset, 16);
 	par->screen_base =3D screen_base +
-	        (var->yoffset * fb_display[fb_info.currcon].var.xres_virtual + va=
r->xoffset)
-	        * fb_display[fb_info.currcon].var.bits_per_pixel / 8;
-	fbhw->set_screen_base (par->screen_base);
+	        (var->yoffset * info->var.xres_virtual + var->xoffset)
+	        * info->var.bits_per_pixel / 8;
+	fbhw->set_screen_base(par->screen_base);
 	return 0;
 }
 =

-
 /* ------------ Interfaces to hardware functions ------------ */
 =

-
 #ifdef ATAFB_TT
 static struct fb_hwswitch tt_switch =3D {
-	tt_detect, tt_encode_fix, tt_decode_var, tt_encode_var,
-	tt_get_par, tt_set_par, tt_getcolreg, =

-	set_screen_base, NULL, pan_display
+	.detect		=3D tt_detect,
+	.encode_fix	=3D tt_encode_fix,
+	.decode_var	=3D tt_decode_var,
+	.encode_var	=3D tt_encode_var,
+	.get_par	=3D tt_get_par,
+	.set_par	=3D tt_set_par,
+	.set_screen_base =3D set_screen_base,
+	.pan_display	=3D pan_display,
 };
 #endif
 =

 #ifdef ATAFB_FALCON
 static struct fb_hwswitch falcon_switch =3D {
-	falcon_detect, falcon_encode_fix, falcon_decode_var, falcon_encode_var,
-	falcon_get_par, falcon_set_par, falcon_getcolreg,
-	set_screen_base, falcon_blank, falcon_pan_display
+	.detect		=3D falcon_detect,
+	.encode_fix	=3D falcon_encode_fix,
+	.decode_var	=3D falcon_decode_var,
+	.encode_var	=3D falcon_encode_var,
+	.get_par	=3D falcon_get_par,
+	.set_par	=3D falcon_set_par,
+	.set_screen_base =3D set_screen_base,
+	.blank		=3D falcon_blank,
+	.pan_display	=3D falcon_pan_display,
 };
 #endif
 =

 #ifdef ATAFB_STE
 static struct fb_hwswitch st_switch =3D {
-	stste_detect, stste_encode_fix, stste_decode_var, stste_encode_var,
-	stste_get_par, stste_set_par, stste_getcolreg,
-	stste_set_screen_base, NULL, pan_display
+	.detect		=3D stste_detect,
+	.encode_fix	=3D stste_encode_fix,
+	.decode_var	=3D stste_decode_var,
+	.encode_var	=3D stste_encode_var,
+	.get_par	=3D stste_get_par,
+	.set_par	=3D stste_set_par,
+	.set_screen_base =3D stste_set_screen_base,
+	.pan_display	=3D pan_display
 };
 #endif
 =

 #ifdef ATAFB_EXT
 static struct fb_hwswitch ext_switch =3D {
-	ext_detect, ext_encode_fix, ext_decode_var, ext_encode_var,
-	ext_get_par, ext_set_par, ext_getcolreg, NULL, NULL, NULL
+	.detect		=3D ext_detect,
+	.encode_fix	=3D ext_encode_fix,
+	.decode_var	=3D ext_decode_var,
+	.encode_var	=3D ext_encode_var,
+	.get_par	=3D ext_get_par,
+	.set_par	=3D ext_set_par,
 };
 #endif
 =

-
-
-static void atafb_get_par( struct atafb_par *par )
+static void ata_get_par(struct atafb_par *par)
 {
-	if (current_par_valid) {
-		*par=3Dcurrent_par;
-	}
+	if (current_par_valid)
+		*par =3D current_par;
 	else
 		fbhw->get_par(par);
 }
 =

-
-static void atafb_set_par( struct atafb_par *par )
+static void ata_set_par(struct atafb_par *par)
 {
 	fbhw->set_par(par);
-	current_par=3D*par;
-	current_par_valid=3D1;
+	current_par =3D *par;
+	current_par_valid =3D 1;
 }
 =

 =

-
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Hardware Independent Functio=
ns =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
 =

-
 /* used for hardware scrolling */
 =

-static int
-fb_update_var(int con, struct fb_info *info)
-{
-	int off=3Dfb_display[con].var.yoffset*fb_display[con].var.xres_virtual*
-			fb_display[con].var.bits_per_pixel>>3;
-
-	current_par.screen_base=3Dscreen_base + off;
-
-	if (fbhw->set_screen_base)
-		fbhw->set_screen_base(current_par.screen_base);
-	return 0;
-}
-
-static int
-do_fb_set_var(struct fb_var_screeninfo *var, int isactive)
+static int do_fb_set_var(struct fb_var_screeninfo *var, int isactive)
 {
-	int err,activate;
+	int err, activate;
 	struct atafb_par par;
-	if ((err=3Dfbhw->decode_var(var, &par)))
+
+	err =3D fbhw->decode_var(var, &par);
+	if (err)
 		return err;
-	activate=3Dvar->activate;
+	activate =3D var->activate;
 	if (((var->activate & FB_ACTIVATE_MASK) =3D=3D FB_ACTIVATE_NOW) && isacti=
ve)
-		atafb_set_par(&par);
+		ata_set_par(&par);
 	fbhw->encode_var(var, &par);
-	var->activate=3Dactivate;
+	var->activate =3D activate;
 	return 0;
 }
 =

-static int
-atafb_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info)
+static int atafb_get_fix(struct fb_fix_screeninfo *fix, struct fb_info *in=
fo)
 {
 	struct atafb_par par;
-	if (con =3D=3D -1)
-		atafb_get_par(&par);
-	else {
-	  int err;
-		if ((err=3Dfbhw->decode_var(&fb_display[con].var,&par)))
-		  return err;
-	}
+	int err;
+	// Get fix directly (case con =3D=3D -1 before)??
+	err =3D fbhw->decode_var(&info->var, &par);
+	if (err)
+		return err;
 	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
 	return fbhw->encode_fix(fix, &par);
 }
-	=

-static int
-atafb_get_var(struct fb_var_screeninfo *var, int con, struct fb_info *info)
+
+static int atafb_get_var(struct fb_var_screeninfo *var, struct fb_info *in=
fo)
 {
 	struct atafb_par par;
-	if (con =3D=3D -1) {
-		atafb_get_par(&par);
-		fbhw->encode_var(var, &par);
-	}
-	else
-		*var=3Dfb_display[con].var;
+
+	ata_get_par(&par);
+	fbhw->encode_var(var, &par);
+
 	return 0;
 }
 =

-static void
-atafb_set_disp(int con, struct fb_info *info)
+// No longer called by fbcon!
+// Still called by set_var internally
+
+static void atafb_set_disp(struct fb_info *info)
 {
-	struct fb_fix_screeninfo fix;
-	struct fb_var_screeninfo var;
-	struct display *display;
+	atafb_get_var(&info->var, info);
+	atafb_get_fix(&info->fix, info);
 =

-	if (con >=3D 0)
-		display =3D &fb_display[con];
-	else
-		display =3D &disp;	/* used during initialization */
-
-	atafb_get_fix(&fix, con, info);
-	atafb_get_var(&var, con, info);
-	if (con =3D=3D -1)
-		con=3D0;
-	info->screen_base =3D (void *)fix.smem_start;
-	display->visual =3D fix.visual;
-	display->type =3D fix.type;
-	display->type_aux =3D fix.type_aux;
-	display->ypanstep =3D fix.ypanstep;
-	display->ywrapstep =3D fix.ywrapstep;
-	display->line_length =3D fix.line_length;
-	if (fix.visual !=3D FB_VISUAL_PSEUDOCOLOR &&
-		fix.visual !=3D FB_VISUAL_DIRECTCOLOR)
-		display->can_soft_blank =3D 0;
-	else
-		display->can_soft_blank =3D 1;
-	display->inverse =3D
-	    (fix.visual =3D=3D FB_VISUAL_MONO01 ? !inverse : inverse);
-	switch (fix.type) {
-	    case FB_TYPE_INTERLEAVED_PLANES:
-		switch (var.bits_per_pixel) {
-#ifdef FBCON_HAS_IPLAN2P2
-		    case 2:
-			display->dispsw =3D &fbcon_iplan2p2;
+	info->screen_base =3D (void *)info->fix.smem_start;
+
+	switch (info->fix.type) {
+	case FB_TYPE_INTERLEAVED_PLANES:
+		switch (info->var.bits_per_pixel) {
+		case 2:
+			// display->dispsw =3D &fbcon_iplan2p2;
 			break;
-#endif
-#ifdef FBCON_HAS_IPLAN2P4
-		    case 4:
-			display->dispsw =3D &fbcon_iplan2p4;
+		case 4:
+			// display->dispsw =3D &fbcon_iplan2p4;
 			break;
-#endif
-#ifdef FBCON_HAS_IPLAN2P8
-		    case 8:
-			display->dispsw =3D &fbcon_iplan2p8;
+		case 8:
+			// display->dispsw =3D &fbcon_iplan2p8;
 			break;
-#endif
 		}
 		break;
-	    case FB_TYPE_PACKED_PIXELS:
-		switch (var.bits_per_pixel) {
+	case FB_TYPE_PACKED_PIXELS:
+		switch (info->var.bits_per_pixel) {
 #ifdef FBCON_HAS_MFB
-		    case 1:
-			display->dispsw =3D &fbcon_mfb;
+		case 1:
+			// display->dispsw =3D &fbcon_mfb;
 			break;
 #endif
 #ifdef FBCON_HAS_CFB8
-		    case 8:
-			display->dispsw =3D &fbcon_cfb8;
+		case 8:
+			// display->dispsw =3D &fbcon_cfb8;
 			break;
 #endif
 #ifdef FBCON_HAS_CFB16
-		    case 16:
-			display->dispsw =3D &fbcon_cfb16;
-			display->dispsw_data =3D fbcon_cfb16_cmap;
+		case 16:
+			// display->dispsw =3D &fbcon_cfb16;
+			// display->dispsw_data =3D fbcon_cfb16_cmap;
 			break;
 #endif
 		}
@@ -2498,74 +2481,203 @@ #endif
 	}
 }
 =

+static int atafb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
+			   u_int transp, struct fb_info *info)
+{
+	red >>=3D 8;
+	green >>=3D 8;
+	blue >>=3D 8;
+
+	return info->fbops->fb_setcolreg(regno, red, green, blue, transp, info);
+}
+
 static int
-atafb_set_var(struct fb_var_screeninfo *var, int con, struct fb_info *info)
+atafb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	int err,oldxres,oldyres,oldbpp,oldxres_virtual,
-	    oldyres_virtual,oldyoffset;
-	if ((err=3Ddo_fb_set_var(var, con=3D=3Dinfo->currcon)))
-		return err;
-	if ((var->activate & FB_ACTIVATE_MASK) =3D=3D FB_ACTIVATE_NOW) {
-		oldxres=3Dfb_display[con].var.xres;
-		oldyres=3Dfb_display[con].var.yres;
-		oldxres_virtual=3Dfb_display[con].var.xres_virtual;
-		oldyres_virtual=3Dfb_display[con].var.yres_virtual;
-		oldbpp=3Dfb_display[con].var.bits_per_pixel;
-		oldyoffset=3Dfb_display[con].var.yoffset;
-		fb_display[con].var=3D*var;
-		if (oldxres !=3D var->xres || oldyres !=3D var->yres =

-		    || oldxres_virtual !=3D var->xres_virtual
-		    || oldyres_virtual !=3D var->yres_virtual
-		    || oldbpp !=3D var->bits_per_pixel
-		    || oldyoffset !=3D var->yoffset) {
-			atafb_set_disp(con, info);
-			(*fb_info.changevar)(con);
-			fb_alloc_cmap(&fb_display[con].cmap, 0, 0);
-			do_install_cmap(con, info);
-		}
+	int xoffset =3D var->xoffset;
+	int yoffset =3D var->yoffset;
+	int err;
+
+	if (var->vmode & FB_VMODE_YWRAP) {
+		if (yoffset < 0 || yoffset >=3D info->var.yres_virtual || xoffset)
+			return -EINVAL;
+	} else {
+		if (xoffset + info->var.xres > info->var.xres_virtual ||
+		    yoffset + info->var.yres > info->var.yres_virtual)
+			return -EINVAL;
 	}
-	var->activate=3D0;
+
+	if (fbhw->pan_display) {
+		err =3D fbhw->pan_display(var, info);
+		if (err)
+			return err;
+	} else
+		return -EINVAL;
+
+	info->var.xoffset =3D xoffset;
+	info->var.yoffset =3D yoffset;
+
+	if (var->vmode & FB_VMODE_YWRAP)
+		info->var.vmode |=3D FB_VMODE_YWRAP;
+	else
+		info->var.vmode &=3D ~FB_VMODE_YWRAP;
+
 	return 0;
 }
 =

+/*
+ * generic drawing routines; imageblit needs updating for image depth > 1
+ */
 =

+#if BITS_PER_LONG =3D=3D 32
+#define BYTES_PER_LONG	4
+#define SHIFT_PER_LONG	5
+#elif BITS_PER_LONG =3D=3D 64
+#define BYTES_PER_LONG	8
+#define SHIFT_PER_LONG	6
+#else
+#define Please update me
+#endif
 =

-static int
-atafb_get_cmap(struct fb_cmap *cmap, int kspc, int con, struct fb_info *in=
fo)
+
+static void atafb_fillrect(struct fb_info *info, const struct fb_fillrect =
*rect)
 {
-	if (con =3D=3D info->currcon) /* current console ? */
-		return fb_get_cmap(cmap, kspc, fbhw->getcolreg, info);
+	struct atafb_par *par =3D (struct atafb_par *)info->par;
+	int x2, y2;
+	u32 width, height;
+
+	if (!rect->width || !rect->height)
+		return;
+
+	/*
+	 * We could use hardware clipping but on many cards you get around
+	 * hardware clipping by writing to framebuffer directly.
+	 * */
+	x2 =3D rect->dx + rect->width;
+	y2 =3D rect->dy + rect->height;
+	x2 =3D x2 < info->var.xres_virtual ? x2 : info->var.xres_virtual;
+	y2 =3D y2 < info->var.yres_virtual ? y2 : info->var.yres_virtual;
+	width =3D x2 - rect->dx;
+	height =3D y2 - rect->dy;
+
+	if (info->var.bits_per_pixel =3D=3D 1)
+		atafb_mfb_fillrect(info, par->next_line, rect->color,
+				   rect->dy, rect->dx, height, width);
+	else if (info->var.bits_per_pixel =3D=3D 2)
+		atafb_iplan2p2_fillrect(info, par->next_line, rect->color,
+					rect->dy, rect->dx, height, width);
+	else if (info->var.bits_per_pixel =3D=3D 4)
+		atafb_iplan2p4_fillrect(info, par->next_line, rect->color,
+					rect->dy, rect->dx, height, width);
 	else
-		if (fb_display[con].cmap.len) /* non default colormap ? */
-			fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
-		else
-			fb_copy_cmap(fb_default_cmap(1<<fb_display[con].var.bits_per_pixel),
-				     cmap, kspc ? 0 : 2);
-	return 0;
+		atafb_iplan2p8_fillrect(info, par->next_line, rect->color,
+					rect->dy, rect->dx, height, width);
+
+	return;
 }
 =

-static int
-atafb_pan_display(struct fb_var_screeninfo *var, int con, struct fb_info *=
info)
+static void atafb_copyarea(struct fb_info *info, const struct fb_copyarea =
*area)
 {
-	int xoffset =3D var->xoffset;
-	int yoffset =3D var->yoffset;
-	int err;
+	struct atafb_par *par =3D (struct atafb_par *)info->par;
+	int x2, y2;
+	u32 dx, dy, sx, sy, width, height;
+	int rev_copy =3D 0;
+
+	/* clip the destination */
+	x2 =3D area->dx + area->width;
+	y2 =3D area->dy + area->height;
+	dx =3D area->dx > 0 ? area->dx : 0;
+	dy =3D area->dy > 0 ? area->dy : 0;
+	x2 =3D x2 < info->var.xres_virtual ? x2 : info->var.xres_virtual;
+	y2 =3D y2 < info->var.yres_virtual ? y2 : info->var.yres_virtual;
+	width =3D x2 - dx;
+	height =3D y2 - dy;
+
+	/* update sx,sy */
+	sx =3D area->sx + (dx - area->dx);
+	sy =3D area->sy + (dy - area->dy);
+
+	/* the source must be completely inside the virtual screen */
+	if (sx < 0 || sy < 0 || (sx + width) > info->var.xres_virtual ||
+	    (sy + height) > info->var.yres_virtual)
+		return;
 =

-	if (   xoffset < 0 || xoffset + fb_display[con].var.xres > fb_display[con=
].var.xres_virtual
-	    || yoffset < 0 || yoffset + fb_display[con].var.yres > fb_display[con=
].var.yres_virtual)
-		return -EINVAL;
+	if (dy > sy || (dy =3D=3D sy && dx > sx)) {
+		dy +=3D height;
+		sy +=3D height;
+		rev_copy =3D 1;
+	}
+
+	if (info->var.bits_per_pixel =3D=3D 1)
+		atafb_mfb_copyarea(info, par->next_line, sy, sx, dy, dx, height, width);
+	else if (info->var.bits_per_pixel =3D=3D 2)
+		atafb_iplan2p2_copyarea(info, par->next_line, sy, sx, dy, dx, height, wi=
dth);
+	else if (info->var.bits_per_pixel =3D=3D 4)
+		atafb_iplan2p4_copyarea(info, par->next_line, sy, sx, dy, dx, height, wi=
dth);
+	else
+		atafb_iplan2p8_copyarea(info, par->next_line, sy, sx, dy, dx, height, wi=
dth);
 =

-	if (con =3D=3D info->currcon) {
-		if (fbhw->pan_display) {
-			if ((err =3D fbhw->pan_display(var, &current_par)))
-				return err;
+	return;
+}
+
+static void atafb_imageblit(struct fb_info *info, const struct fb_image *i=
mage)
+{
+	struct atafb_par *par =3D (struct atafb_par *)info->par;
+	int x2, y2;
+	unsigned long *dst;
+	int dst_idx;
+	const char *src;
+	u32 dx, dy, width, height, pitch;
+
+	/*
+	 * We could use hardware clipping but on many cards you get around
+	 * hardware clipping by writing to framebuffer directly like we are
+	 * doing here.
+	 */
+	x2 =3D image->dx + image->width;
+	y2 =3D image->dy + image->height;
+	dx =3D image->dx;
+	dy =3D image->dy;
+	x2 =3D x2 < info->var.xres_virtual ? x2 : info->var.xres_virtual;
+	y2 =3D y2 < info->var.yres_virtual ? y2 : info->var.yres_virtual;
+	width =3D x2 - dx;
+	height =3D y2 - dy;
+
+	if (image->depth =3D=3D 1) {
+		// used for font data
+		dst =3D (unsigned long *)
+			((unsigned long)info->screen_base & ~(BYTES_PER_LONG - 1));
+		dst_idx =3D ((unsigned long)info->screen_base & (BYTES_PER_LONG - 1)) * =
8;
+		dst_idx +=3D dy * par->next_line * 8 + dx;
+		src =3D image->data;
+		pitch =3D (image->width + 7) / 8;
+		while (height--) {
+
+			if (info->var.bits_per_pixel =3D=3D 1)
+				atafb_mfb_linefill(info, par->next_line,
+						   dy, dx, width, src,
+						   image->bg_color, image->fg_color);
+			else if (info->var.bits_per_pixel =3D=3D 2)
+				atafb_iplan2p2_linefill(info, par->next_line,
+							dy, dx, width, src,
+							image->bg_color, image->fg_color);
+			else if (info->var.bits_per_pixel =3D=3D 4)
+				atafb_iplan2p4_linefill(info, par->next_line,
+							dy, dx, width, src,
+							image->bg_color, image->fg_color);
+			else
+				atafb_iplan2p8_linefill(info, par->next_line,
+							dy, dx, width, src,
+							image->bg_color, image->fg_color);
+			dy++;
+			src +=3D pitch;
 		}
-		else
-			return -EINVAL;
+	} else {
+		// only used for logo; broken
+		c2p(info->screen_base, image->data, dx, dy, width, height,
+		    par->next_line, par->next_plane, image->width,
+		    info->var.bits_per_pixel);
 	}
-	fb_display[con].var.xoffset =3D var->xoffset;
-	fb_display[con].var.yoffset =3D var->yoffset;
-	return 0;
 }
 =

 static int
@@ -2584,7 +2696,7 @@ #ifdef FBCMD_SET_CURRENTPAR
 		if (copy_from_user((void *)&current_par, (void *)arg,
 				   sizeof(struct atafb_par)))
 			return -EFAULT;
-		atafb_set_par(&current_par);
+		ata_set_par(&current_par);
 		return 0;
 #endif
 	}
@@ -2598,42 +2710,82 @@ #endif
  * 3 =3D suspend hsync
  * 4 =3D off
  */
-static int =

-atafb_blank(int blank, struct fb_info *info)
+static int atafb_blank(int blank, struct fb_info *info)
 {
 	unsigned short black[16];
 	struct fb_cmap cmap;
 	if (fbhw->blank && !fbhw->blank(blank))
 		return 1;
 	if (blank) {
-		memset(black, 0, 16*sizeof(unsigned short));
-		cmap.red=3Dblack;
-		cmap.green=3Dblack;
-		cmap.blue=3Dblack;
-		cmap.transp=3DNULL;
-		cmap.start=3D0;
-		cmap.len=3D16;
-		fb_set_cmap(&cmap, 1, info);
+		memset(black, 0, 16 * sizeof(unsigned short));
+		cmap.red =3D black;
+		cmap.green =3D black;
+		cmap.blue =3D black;
+		cmap.transp =3D NULL;
+		cmap.start =3D 0;
+		cmap.len =3D 16;
+		fb_set_cmap(&cmap, info);
 	}
+#if 0
 	else
-		do_install_cmap(info->currcon, info);
+		do_install_cmap(info);
+#endif
+	return 0;
+}
+
+	/*
+	 * New fbcon interface ...
+	 */
+
+	 /* check var by decoding var into hw par, rounding if necessary,
+	  * then encoding hw par back into new, validated var */
+static int atafb_check_var(struct fb_var_screeninfo *var, struct fb_info *=
info)
+{
+	int err;
+	struct atafb_par par;
+
+	/* Validate wanted screen parameters */
+	// if ((err =3D ata_decode_var(var, &par)))
+	err =3D fbhw->decode_var(var, &par);
+	if (err)
+		return err;
+
+	/* Encode (possibly rounded) screen parameters */
+	fbhw->encode_var(var, &par);
+	return 0;
+}
+
+	/* actually set hw par by decoding var, then setting hardware from
+	 * hw par just decoded */
+static int atafb_set_par(struct fb_info *info)
+{
+	struct atafb_par *par =3D (struct atafb_par *)info->par;
+
+	/* Decode wanted screen parameters */
+	fbhw->decode_var(&info->var, par);
+	fbhw->encode_fix(&info->fix, par);
+
+	/* Set new videomode */
+	ata_set_par(par);
+
 	return 0;
 }
 =

+
 static struct fb_ops atafb_ops =3D {
 	.owner =3D	THIS_MODULE,
-	.fb_get_fix =3D	atafb_get_fix,
-	.fb_get_var =3D	atafb_get_var,
-	.fb_set_var =3D	atafb_set_var,
-	.fb_get_cmap =3D	atafb_get_cmap,
-	.fb_set_cmap =3D	gen_set_cmap,
-	.fb_pan_display =3Datafb_pan_display,
+	.fb_check_var	=3D atafb_check_var,
+	.fb_set_par	=3D atafb_set_par,
+	.fb_setcolreg	=3D atafb_setcolreg,
 	.fb_blank =3D	atafb_blank,
+	.fb_pan_display	=3D atafb_pan_display,
+	.fb_fillrect	=3D atafb_fillrect,
+	.fb_copyarea	=3D atafb_copyarea,
+	.fb_imageblit	=3D atafb_imageblit,
 	.fb_ioctl =3D	atafb_ioctl,
 };
 =

-static void
-check_default_par( int detected_mode )
+static void check_default_par(int detected_mode)
 {
 	char default_name[10];
 	int i;
@@ -2642,199 +2794,41 @@ check_default_par( int detected_mode )
 =

 	/* First try the user supplied mode */
 	if (default_par) {
-		var=3Datafb_predefined[default_par-1];
+		var =3D atafb_predefined[default_par - 1];
 		var.activate =3D FB_ACTIVATE_TEST;
-		if (do_fb_set_var(&var,1))
-			default_par=3D0;		/* failed */
+		if (do_fb_set_var(&var, 1))
+			default_par =3D 0;	/* failed */
 	}
 	/* Next is the autodetected one */
-	if (! default_par) {
-		var=3Datafb_predefined[detected_mode-1]; /* autodetect */
+	if (!default_par) {
+		var =3D atafb_predefined[detected_mode - 1]; /* autodetect */
 		var.activate =3D FB_ACTIVATE_TEST;
-		if (!do_fb_set_var(&var,1))
-			default_par=3Ddetected_mode;
+		if (!do_fb_set_var(&var, 1))
+			default_par =3D detected_mode;
 	}
 	/* If that also failed, try some default modes... */
-	if (! default_par) {
+	if (!default_par) {
 		/* try default1, default2... */
-		for (i=3D1 ; i < 10 ; i++) {
-			sprintf(default_name,"default%d",i);
-			default_par=3Dget_video_mode(default_name);
-			if (! default_par)
+		for (i =3D 1; i < 10; i++) {
+			sprintf(default_name,"default%d", i);
+			default_par =3D get_video_mode(default_name);
+			if (!default_par)
 				panic("can't set default video mode");
-			var=3Datafb_predefined[default_par-1];
+			var =3D atafb_predefined[default_par - 1];
 			var.activate =3D FB_ACTIVATE_TEST;
-			if (! do_fb_set_var(&var,1))
+			if (!do_fb_set_var(&var,1))
 				break;	/* ok */
 		}
 	}
-	min_mem=3Dvar.xres_virtual * var.yres_virtual * var.bits_per_pixel/8;
+	min_mem =3D var.xres_virtual * var.yres_virtual * var.bits_per_pixel / 8;
 	if (default_mem_req < min_mem)
-		default_mem_req=3Dmin_mem;
-}
-
-static int
-atafb_switch(int con, struct fb_info *info)
-{
-	/* Do we have to save the colormap ? */
-	if (fb_display[info->currcon].cmap.len)
-		fb_get_cmap(&fb_display[info->currcon].cmap, 1, fbhw->getcolreg,
-			    info);
-	do_fb_set_var(&fb_display[con].var,1);
-	info->currcon=3Dcon;
-	/* Install new colormap */
-	do_install_cmap(con, info);
-	return 0;
-}
-
-int __init atafb_init(void)
-{
-	int pad;
-	int detected_mode;
-	unsigned long mem_req;
-
-	if (!MACH_IS_ATARI)
-	        return -ENXIO;
-
-	do {
-#ifdef ATAFB_EXT
-		if (external_addr) {
-			fbhw =3D &ext_switch;
-			atafb_ops.fb_setcolreg =3D &ext_setcolreg;
-			break;
-		}
-#endif
-#ifdef ATAFB_TT
-		if (ATARIHW_PRESENT(TT_SHIFTER)) {
-			fbhw =3D &tt_switch;
-			atafb_ops.fb_setcolreg =3D &tt_setcolreg;
-			break;
-		}
-#endif
-#ifdef ATAFB_FALCON
-		if (ATARIHW_PRESENT(VIDEL_SHIFTER)) {
-			fbhw =3D &falcon_switch;
-			atafb_ops.fb_setcolreg =3D &falcon_setcolreg;
-			request_irq(IRQ_AUTO_4, falcon_vbl_switcher, IRQ_TYPE_PRIO,
-			            "framebuffer/modeswitch", falcon_vbl_switcher);
-			break;
-		}
-#endif
-#ifdef ATAFB_STE
-		if (ATARIHW_PRESENT(STND_SHIFTER) ||
-		    ATARIHW_PRESENT(EXTD_SHIFTER)) {
-			fbhw =3D &st_switch;
-			atafb_ops.fb_setcolreg =3D &stste_setcolreg;
-			break;
-		}
-		fbhw =3D &st_switch;
-		atafb_ops.fb_setcolreg =3D &stste_setcolreg;
-		printk("Cannot determine video hardware; defaulting to ST(e)\n");
-#else /* ATAFB_STE */
-		/* no default driver included */
-		/* Nobody will ever see this message :-) */
-		panic("Cannot initialize video hardware");
-#endif
-	} while (0);
-
-	/* Multisync monitor capabilities */
-	/* Atari-TOS defaults if no boot option present */
-	if (fb_info.monspecs.hfmin =3D=3D 0) {
-	    fb_info.monspecs.hfmin =3D 31000;
-	    fb_info.monspecs.hfmax =3D 32000;
-	    fb_info.monspecs.vfmin =3D 58;
-	    fb_info.monspecs.vfmax =3D 62;
-	}
-
-	detected_mode =3D fbhw->detect();
-	check_default_par(detected_mode);
-#ifdef ATAFB_EXT
-	if (!external_addr) {
-#endif /* ATAFB_EXT */
-		mem_req =3D default_mem_req + ovsc_offset + ovsc_addlen;
-		mem_req =3D PAGE_ALIGN(mem_req) + PAGE_SIZE;
-		screen_base =3D atari_stram_alloc(mem_req, "atafb");
-		if (!screen_base)
-			panic("Cannot allocate screen memory");
-		memset(screen_base, 0, mem_req);
-		pad =3D -(unsigned long)screen_base & (PAGE_SIZE-1);
-		screen_base+=3Dpad;
-		real_screen_base=3Dscreen_base+ovsc_offset;
-		screen_len =3D (mem_req - pad - ovsc_offset) & PAGE_MASK;
-		st_ovsc_switch();
-		if (CPU_IS_040_OR_060) {
-			/* On a '040+, the cache mode of video RAM must be set to
-			 * write-through also for internal video hardware! */
-			cache_push(virt_to_phys(screen_base), screen_len);
-			kernel_set_cachemode(screen_base, screen_len,
-					     IOMAP_WRITETHROUGH);
-		}
-#ifdef ATAFB_EXT
-	}
-	else {
-		/* Map the video memory (physical address given) to somewhere
-		 * in the kernel address space.
-		 */
-		external_addr =3D
-		  ioremap_writethrough((unsigned long)external_addr,
-				       external_len);
-		if (external_vgaiobase)
-			external_vgaiobase =3D
-			  (unsigned long)ioremap(external_vgaiobase, 0x10000);
-		screen_base      =3D
-		real_screen_base =3D external_addr;
-		screen_len       =3D external_len & PAGE_MASK;
-		memset (screen_base, 0, external_len);
-	}
-#endif /* ATAFB_EXT */
-
-	strcpy(fb_info.modename, "Atari Builtin ");
-	fb_info.changevar =3D NULL;
-	fb_info.fbops =3D &atafb_ops;
-	fb_info.disp =3D &disp;
-	fb_info.currcon =3D -1;
-	fb_info.switch_con =3D &atafb_switch;
-	fb_info.updatevar =3D &fb_update_var;
-	fb_info.flags =3D FBINFO_FLAG_DEFAULT;
-	do_fb_set_var(&atafb_predefined[default_par-1], 1);
-	strcat(fb_info.modename, fb_var_names[default_par-1][0]);
-
-	atafb_get_var(&disp.var, -1, &fb_info);
-	atafb_set_disp(-1, &fb_info);
-	do_install_cmap(0, &fb_info);
-
-	if (register_framebuffer(&fb_info) < 0) {
-#ifdef ATAFB_EXT
-		if (external_addr) {
-			iounmap(external_addr);
-			external_addr =3D NULL;
-		}
-		if (external_vgaiobase) {
-			iounmap((void*)external_vgaiobase);
-			external_vgaiobase =3D 0;
-		}
-#endif
-		return -EINVAL;
-	}
-
-	printk("Determined %dx%d, depth %d\n",
-	       disp.var.xres, disp.var.yres, disp.var.bits_per_pixel);
-	if ((disp.var.xres !=3D disp.var.xres_virtual) ||
-	    (disp.var.yres !=3D disp.var.yres_virtual))
-	   printk("   virtual %dx%d\n",
-			  disp.var.xres_virtual, disp.var.yres_virtual);
-	printk("fb%d: %s frame buffer device, using %dK of video memory\n",
-	       fb_info.node, fb_info.modename, screen_len>>10);
-
-	/* TODO: This driver cannot be unloaded yet */
-	return 0;
+		default_mem_req =3D min_mem;
 }
 =

-
 #ifdef ATAFB_EXT
 static void __init atafb_setup_ext(char *spec)
 {
-	int		xres, xres_virtual, yres, depth, planes;
+	int xres, xres_virtual, yres, depth, planes;
 	unsigned long addr, len;
 	char *p;
 =

@@ -2848,27 +2842,31 @@ static void __init atafb_setup_ext(char =

 	 *
 	 * Even xres_virtual is available, we neither support panning nor hw-scro=
lling!
 	 */
-	if (!(p =3D strsep(&spec, ";")) || !*p)
-	    return;
+	p =3D strsep(&spec, ";");
+	if (!p || !*p)
+		return;
 	xres_virtual =3D xres =3D simple_strtoul(p, NULL, 10);
 	if (xres <=3D 0)
-	    return;
+		return;
 =

-	if (!(p =3D strsep(&spec, ";")) || !*p)
-	    return;
+	p =3D strsep(&spec, ";");
+	if (!p || !*p)
+		return;
 	yres =3D simple_strtoul(p, NULL, 10);
 	if (yres <=3D 0)
-	    return;
+		return;
 =

-	if (!(p =3D strsep(&spec, ";")) || !*p)
-	    return;
+	p =3D strsep(&spec, ";");
+	if (!p || !*p)
+		return;
 	depth =3D simple_strtoul(p, NULL, 10);
 	if (depth !=3D 1 && depth !=3D 2 && depth !=3D 4 && depth !=3D 8 &&
-		depth !=3D 16 && depth !=3D 24)
-	    return;
+	    depth !=3D 16 && depth !=3D 24)
+		return;
 =

-	if (!(p =3D strsep(&spec, ";")) || !*p)
-	    return;
+	p =3D strsep(&spec, ";");
+	if (!p || !*p)
+		return;
 	if (*p =3D=3D 'i')
 		planes =3D FB_TYPE_INTERLEAVED_PLANES;
 	else if (*p =3D=3D 'p')
@@ -2876,25 +2874,27 @@ static void __init atafb_setup_ext(char =

 	else if (*p =3D=3D 'n')
 		planes =3D FB_TYPE_PLANES;
 	else if (*p =3D=3D 't')
-		planes =3D -1; /* true color */
+		planes =3D -1;		/* true color */
 	else
 		return;
 =

-
-	if (!(p =3D strsep(&spec, ";")) || !*p)
+	p =3D strsep(&spec, ";");
+	if (!p || !*p)
 		return;
 	addr =3D simple_strtoul(p, NULL, 0);
 =

-	if (!(p =3D strsep(&spec, ";")) || !*p)
-		len =3D xres*yres*depth/8;
+	p =3D strsep(&spec, ";");
+	if (!p || !*p)
+		len =3D xres * yres * depth / 8;
 	else
 		len =3D simple_strtoul(p, NULL, 0);
 =

-	if ((p =3D strsep(&spec, ";")) && *p) {
-		external_vgaiobase=3Dsimple_strtoul(p, NULL, 0);
-	}
+	p =3D strsep(&spec, ";");
+	if (p && *p)
+		external_vgaiobase =3D simple_strtoul(p, NULL, 0);
 =

-	if ((p =3D strsep(&spec, ";")) && *p) {
+	p =3D strsep(&spec, ";");
+	if (p && *p) {
 		external_bitspercol =3D simple_strtoul(p, NULL, 0);
 		if (external_bitspercol > 8)
 			external_bitspercol =3D 8;
@@ -2902,59 +2902,61 @@ static void __init atafb_setup_ext(char =

 			external_bitspercol =3D 1;
 	}
 =

-	if ((p =3D strsep(&spec, ";")) && *p) {
+	p =3D strsep(&spec, ";");
+	if (p && *p) {
 		if (!strcmp(p, "vga"))
 			external_card_type =3D IS_VGA;
 		if (!strcmp(p, "mv300"))
 			external_card_type =3D IS_MV300;
 	}
 =

-	if ((p =3D strsep(&spec, ";")) && *p) {
+	p =3D strsep(&spec, ";");
+	if (p && *p) {
 		xres_virtual =3D simple_strtoul(p, NULL, 10);
 		if (xres_virtual < xres)
 			xres_virtual =3D xres;
-		if (xres_virtual*yres*depth/8 > len)
-			len=3Dxres_virtual*yres*depth/8;
+		if (xres_virtual * yres * depth / 8 > len)
+			len =3D xres_virtual * yres * depth / 8;
 	}
 =

-	external_xres  =3D xres;
-	external_xres_virtual  =3D xres_virtual;
-	external_yres  =3D yres;
+	external_xres =3D xres;
+	external_xres_virtual =3D xres_virtual;
+	external_yres =3D yres;
 	external_depth =3D depth;
 	external_pmode =3D planes;
-	external_addr  =3D (void *)addr;
-	external_len   =3D len;
-
-	if (external_card_type =3D=3D IS_MV300)
-	  switch (external_depth) {
-	    case 1:
-	      MV300_reg =3D MV300_reg_1bit;
-	      break;
-	    case 4:
-	      MV300_reg =3D MV300_reg_4bit;
-	      break;
-	    case 8:
-	      MV300_reg =3D MV300_reg_8bit;
-	      break;
-	    }
+	external_addr =3D (void *)addr;
+	external_len =3D len;
+
+	if (external_card_type =3D=3D IS_MV300) {
+		switch (external_depth) {
+		case 1:
+			MV300_reg =3D MV300_reg_1bit;
+			break;
+		case 4:
+			MV300_reg =3D MV300_reg_4bit;
+			break;
+		case 8:
+			MV300_reg =3D MV300_reg_8bit;
+			break;
+		}
+	}
 }
 #endif /* ATAFB_EXT */
 =

-
 static void __init atafb_setup_int(char *spec)
 {
 	/* Format to config extended internal video hardware like OverScan:
-	"internal:<xres>;<yres>;<xres_max>;<yres_max>;<offset>"
-	Explanation:
-	<xres>: x-resolution =

-	<yres>: y-resolution
-	The following are only needed if you have an overscan which
-	needs a black border:
-	<xres_max>: max. length of a line in pixels your OverScan hardware would =
allow
-	<yres_max>: max. number of lines your OverScan hardware would allow
-	<offset>: Offset from physical beginning to visible beginning
-		  of screen in bytes
-	*/
+	 * "internal:<xres>;<yres>;<xres_max>;<yres_max>;<offset>"
+	 * Explanation:
+	 * <xres>: x-resolution
+	 * <yres>: y-resolution
+	 * The following are only needed if you have an overscan which
+	 * needs a black border:
+	 * <xres_max>: max. length of a line in pixels your OverScan hardware wou=
ld allow
+	 * <yres_max>: max. number of lines your OverScan hardware would allow
+	 * <offset>: Offset from physical beginning to visible beginning
+	 *	  of screen in bytes
+	 */
 	int xres;
 	char *p;
 =

@@ -2963,23 +2965,19 @@ static void __init atafb_setup_int(char =

 	xres =3D simple_strtoul(p, NULL, 10);
 	if (!(p =3D strsep(&spec, ";")) || !*p)
 		return;
-	sttt_xres=3Dxres;
-	tt_yres=3Dst_yres=3Dsimple_strtoul(p, NULL, 10);
-	if ((p=3Dstrsep(&spec, ";")) && *p) {
-		sttt_xres_virtual=3Dsimple_strtoul(p, NULL, 10);
-	}
-	if ((p=3Dstrsep(&spec, ";")) && *p) {
-		sttt_yres_virtual=3Dsimple_strtoul(p, NULL, 0);
-	}
-	if ((p=3Dstrsep(&spec, ";")) && *p) {
-		ovsc_offset=3Dsimple_strtoul(p, NULL, 0);
-	}
+	sttt_xres =3D xres;
+	tt_yres =3D st_yres =3D simple_strtoul(p, NULL, 10);
+	if ((p =3D strsep(&spec, ";")) && *p)
+		sttt_xres_virtual =3D simple_strtoul(p, NULL, 10);
+	if ((p =3D strsep(&spec, ";")) && *p)
+		sttt_yres_virtual =3D simple_strtoul(p, NULL, 0);
+	if ((p =3D strsep(&spec, ";")) && *p)
+		ovsc_offset =3D simple_strtoul(p, NULL, 0);
 =

 	if (ovsc_offset || (sttt_yres_virtual !=3D st_yres))
-		use_hwscroll=3D0;
+		use_hwscroll =3D 0;
 }
 =

-
 #ifdef ATAFB_FALCON
 static void __init atafb_setup_mcap(char *spec)
 {
@@ -3018,7 +3016,6 @@ static void __init atafb_setup_mcap(char
 }
 #endif /* ATAFB_FALCON */
 =

-
 static void __init atafb_setup_user(char *spec)
 {
 	/* Format of user defined video mode is: <xres>;<yres>;<depth>
@@ -3026,81 +3023,257 @@ static void __init atafb_setup_user(char
 	char *p;
 	int xres, yres, depth, temp;
 =

-	if (!(p =3D strsep(&spec, ";")) || !*p)
+	p =3D strsep(&spec, ";");
+	if (!p || !*p)
 		return;
 	xres =3D simple_strtoul(p, NULL, 10);
-	if (!(p =3D strsep(&spec, ";")) || !*p)
+	p =3D strsep(&spec, ";");
+	if (!p || !*p)
 		return;
 	yres =3D simple_strtoul(p, NULL, 10);
-	if (!(p =3D strsep(&spec, "")) || !*p)
+	p =3D strsep(&spec, "");
+	if (!p || !*p)
 		return;
 	depth =3D simple_strtoul(p, NULL, 10);
-	if ((temp=3Dget_video_mode("user0"))) {
-		default_par=3Dtemp;
-		atafb_predefined[default_par-1].xres =3D xres;
-		atafb_predefined[default_par-1].yres =3D yres;
-		atafb_predefined[default_par-1].bits_per_pixel =3D depth;
+	temp =3D get_video_mode("user0");
+	if (temp) {
+		default_par =3D temp;
+		atafb_predefined[default_par - 1].xres =3D xres;
+		atafb_predefined[default_par - 1].yres =3D yres;
+		atafb_predefined[default_par - 1].bits_per_pixel =3D depth;
 	}
 }
 =

-int __init atafb_setup( char *options )
+int __init atafb_setup(char *options)
 {
-    char *this_opt;
-    int temp;
-
-    fb_info.fontname[0] =3D '\0';
+	char *this_opt;
+	int temp;
 =

-    if (!options || !*options)
+	if (!options || !*options)
 		return 0;
-    =

-    while ((this_opt =3D strsep(&options, ",")) !=3D NULL) {	 =

-	if (!*this_opt) continue;
-	if ((temp=3Dget_video_mode(this_opt)))
-		default_par=3Dtemp;
-	else if (! strcmp(this_opt, "inverse"))
-		inverse=3D1;
-	else if (!strncmp(this_opt, "font:", 5))
-	   strcpy(fb_info.fontname, this_opt+5);
-	else if (! strncmp(this_opt, "hwscroll_",9)) {
-		hwscroll=3Dsimple_strtoul(this_opt+9, NULL, 10);
-		if (hwscroll < 0)
-			hwscroll =3D 0;
-		if (hwscroll > 200)
-			hwscroll =3D 200;
-	}
+
+	while ((this_opt =3D strsep(&options, ",")) !=3D NULL) {
+		if (!*this_opt)
+			continue;
+		if ((temp =3D get_video_mode(this_opt))) {
+			default_par =3D temp;
+			mode_option =3D this_opt;
+		} else if (!strcmp(this_opt, "inverse"))
+			inverse =3D 1;
+		else if (!strncmp(this_opt, "hwscroll_", 9)) {
+			hwscroll =3D simple_strtoul(this_opt + 9, NULL, 10);
+			if (hwscroll < 0)
+				hwscroll =3D 0;
+			if (hwscroll > 200)
+				hwscroll =3D 200;
+		}
 #ifdef ATAFB_EXT
-	else if (!strcmp(this_opt,"mv300")) {
-		external_bitspercol =3D 8;
-		external_card_type =3D IS_MV300;
+		else if (!strcmp(this_opt, "mv300")) {
+			external_bitspercol =3D 8;
+			external_card_type =3D IS_MV300;
+		} else if (!strncmp(this_opt, "external:", 9))
+			atafb_setup_ext(this_opt + 9);
+#endif
+		else if (!strncmp(this_opt, "internal:", 9))
+			atafb_setup_int(this_opt + 9);
+#ifdef ATAFB_FALCON
+		else if (!strncmp(this_opt, "eclock:", 7)) {
+			fext.f =3D simple_strtoul(this_opt + 7, NULL, 10);
+			/* external pixelclock in kHz --> ps */
+			fext.t =3D 1000000000 / fext.f;
+			fext.f *=3D 1000;
+		} else if (!strncmp(this_opt, "monitorcap:", 11))
+			atafb_setup_mcap(this_opt + 11);
+#endif
+		else if (!strcmp(this_opt, "keep"))
+			DontCalcRes =3D 1;
+		else if (!strncmp(this_opt, "R", 1))
+			atafb_setup_user(this_opt + 1);
 	}
-	else if (!strncmp(this_opt,"external:",9))
-		atafb_setup_ext(this_opt+9);
+	return 0;
+}
+
+int __init atafb_init(void)
+{
+	int pad;
+	int detected_mode;
+	unsigned int defmode =3D 0;
+	unsigned long mem_req;
+
+#ifndef MODULE
+	char *option =3D NULL;
+
+	if (fb_get_options("atafb", &option))
+		return -ENODEV;
+	atafb_setup(option);
+#endif
+	printk("atafb_init: start\n");
+
+	if (!MACH_IS_ATARI)
+		return -ENXIO;
+
+	do {
+#ifdef ATAFB_EXT
+		if (external_addr) {
+			printk("atafb_init: initializing external hw\n");
+			fbhw =3D &ext_switch;
+			atafb_ops.fb_setcolreg =3D &ext_setcolreg;
+			defmode =3D DEFMODE_EXT;
+			break;
+		}
+#endif
+#ifdef ATAFB_TT
+		if (ATARIHW_PRESENT(TT_SHIFTER)) {
+			printk("atafb_init: initializing TT hw\n");
+			fbhw =3D &tt_switch;
+			atafb_ops.fb_setcolreg =3D &tt_setcolreg;
+			defmode =3D DEFMODE_TT;
+			break;
+		}
 #endif
-	else if (!strncmp(this_opt,"internal:",9))
-		atafb_setup_int(this_opt+9);
 #ifdef ATAFB_FALCON
-	else if (!strncmp(this_opt, "eclock:", 7)) {
-		fext.f =3D simple_strtoul(this_opt+7, NULL, 10);
-		/* external pixelclock in kHz --> ps */
-		fext.t =3D 1000000000/fext.f;
-		fext.f *=3D 1000;
+		if (ATARIHW_PRESENT(VIDEL_SHIFTER)) {
+			printk("atafb_init: initializing Falcon hw\n");
+			fbhw =3D &falcon_switch;
+			atafb_ops.fb_setcolreg =3D &falcon_setcolreg;
+			request_irq(IRQ_AUTO_4, falcon_vbl_switcher, IRQ_TYPE_PRIO,
+			            "framebuffer/modeswitch", falcon_vbl_switcher);
+			defmode =3D DEFMODE_F30;
+			break;
+		}
+#endif
+#ifdef ATAFB_STE
+		if (ATARIHW_PRESENT(STND_SHIFTER) ||
+		    ATARIHW_PRESENT(EXTD_SHIFTER)) {
+			printk("atafb_init: initializing ST/E hw\n");
+			fbhw =3D &st_switch;
+			atafb_ops.fb_setcolreg =3D &stste_setcolreg;
+			defmode =3D DEFMODE_STE;
+			break;
+		}
+		fbhw =3D &st_switch;
+		atafb_ops.fb_setcolreg =3D &stste_setcolreg;
+		printk("Cannot determine video hardware; defaulting to ST(e)\n");
+#else /* ATAFB_STE */
+		/* no default driver included */
+		/* Nobody will ever see this message :-) */
+		panic("Cannot initialize video hardware");
+#endif
+	} while (0);
+
+	/* Multisync monitor capabilities */
+	/* Atari-TOS defaults if no boot option present */
+	if (fb_info.monspecs.hfmin =3D=3D 0) {
+		fb_info.monspecs.hfmin =3D 31000;
+		fb_info.monspecs.hfmax =3D 32000;
+		fb_info.monspecs.vfmin =3D 58;
+		fb_info.monspecs.vfmax =3D 62;
 	}
-	else if (!strncmp(this_opt, "monitorcap:", 11))
-		atafb_setup_mcap(this_opt+11);
+
+	detected_mode =3D fbhw->detect();
+	check_default_par(detected_mode);
+#ifdef ATAFB_EXT
+	if (!external_addr) {
+#endif /* ATAFB_EXT */
+		mem_req =3D default_mem_req + ovsc_offset + ovsc_addlen;
+		mem_req =3D PAGE_ALIGN(mem_req) + PAGE_SIZE;
+		screen_base =3D atari_stram_alloc(mem_req, "atafb");
+		if (!screen_base)
+			panic("Cannot allocate screen memory");
+		memset(screen_base, 0, mem_req);
+		pad =3D -(unsigned long)screen_base & (PAGE_SIZE - 1);
+		screen_base +=3D pad;
+		real_screen_base =3D screen_base + ovsc_offset;
+		screen_len =3D (mem_req - pad - ovsc_offset) & PAGE_MASK;
+		st_ovsc_switch();
+		if (CPU_IS_040_OR_060) {
+			/* On a '040+, the cache mode of video RAM must be set to
+			 * write-through also for internal video hardware! */
+			cache_push(virt_to_phys(screen_base), screen_len);
+			kernel_set_cachemode(screen_base, screen_len,
+					     IOMAP_WRITETHROUGH);
+		}
+		printk("atafb: screen_base %p real_screen_base %p screen_len %d\n",
+			screen_base, real_screen_base, screen_len);
+#ifdef ATAFB_EXT
+	} else {
+		/* Map the video memory (physical address given) to somewhere
+		 * in the kernel address space.
+		 */
+		external_addr =3D ioremap_writethrough((unsigned long)external_addr,
+						     external_len);
+		if (external_vgaiobase)
+			external_vgaiobase =3D
+			  (unsigned long)ioremap(external_vgaiobase, 0x10000);
+		screen_base =3D
+		real_screen_base =3D external_addr;
+		screen_len =3D external_len & PAGE_MASK;
+		memset (screen_base, 0, external_len);
+	}
+#endif /* ATAFB_EXT */
+
+//	strcpy(fb_info.mode->name, "Atari Builtin ");
+	fb_info.fbops =3D &atafb_ops;
+	// try to set default (detected; requested) var
+	do_fb_set_var(&atafb_predefined[default_par - 1], 1);
+	// reads hw state into current par, which may not be sane yet
+	ata_get_par(&current_par);
+	fb_info.par =3D &current_par;
+	// tries to read from HW which may not be initialized yet
+	// so set sane var first, then call atafb_set_par
+	atafb_get_var(&fb_info.var, &fb_info);
+	fb_info.flags =3D FBINFO_FLAG_DEFAULT;
+
+	if (!fb_find_mode(&fb_info.var, &fb_info, mode_option, atafb_modedb,
+			  NUM_TOTAL_MODES, &atafb_modedb[defmode],
+			  fb_info.var.bits_per_pixel)) {
+		return -EINVAL;
+	}
+
+	atafb_set_disp(&fb_info);
+
+	fb_alloc_cmap(&(fb_info.cmap), 1 << fb_info.var.bits_per_pixel, 0);
+
+
+	printk("Determined %dx%d, depth %d\n",
+	       fb_info.var.xres, fb_info.var.yres, fb_info.var.bits_per_pixel);
+	if ((fb_info.var.xres !=3D fb_info.var.xres_virtual) ||
+	    (fb_info.var.yres !=3D fb_info.var.yres_virtual))
+		printk("   virtual %dx%d\n", fb_info.var.xres_virtual,
+		       fb_info.var.yres_virtual);
+
+	if (register_framebuffer(&fb_info) < 0) {
+#ifdef ATAFB_EXT
+		if (external_addr) {
+			iounmap(external_addr);
+			external_addr =3D NULL;
+		}
+		if (external_vgaiobase) {
+			iounmap((void*)external_vgaiobase);
+			external_vgaiobase =3D 0;
+		}
 #endif
-	else if (!strcmp(this_opt, "keep"))
-		DontCalcRes =3D 1;
-	else if (!strncmp(this_opt, "R", 1))
-		atafb_setup_user(this_opt+1);
-    }
-    return 0;
+		return -EINVAL;
+	}
+
+	// FIXME: mode needs setting!
+	//printk("fb%d: %s frame buffer device, using %dK of video memory\n",
+	//       fb_info.node, fb_info.mode->name, screen_len>>10);
+	printk("fb%d: frame buffer device, using %dK of video memory\n",
+	       fb_info.node, screen_len >> 10);
+
+	/* TODO: This driver cannot be unloaded yet */
+	return 0;
 }
 =

+module_init(atafb_init);
+
 #ifdef MODULE
 MODULE_LICENSE("GPL");
 =

-int init_module(void)
+int cleanup_module(void)
 {
-	return atafb_init();
+	unregister_framebuffer(&fb_info);
+	return atafb_deinit();
 }
 #endif /* MODULE */
diff --git a/drivers/video/atafb.h b/drivers/video/atafb.h
new file mode 100644
index 0000000..014e059
--- /dev/null
+++ b/drivers/video/atafb.h
@@ -0,0 +1,36 @@
+#ifndef _VIDEO_ATAFB_H
+#define _VIDEO_ATAFB_H
+
+void atafb_mfb_copyarea(struct fb_info *info, u_long next_line, int sy, in=
t sx, int dy,
+			int dx, int height, int width);
+void atafb_mfb_fillrect(struct fb_info *info, u_long next_line, u32 color,
+			int sy, int sx, int height, int width);
+void atafb_mfb_linefill(struct fb_info *info, u_long next_line,
+			int dy, int dx, u32 width,
+			const u8 *data, u32 bgcolor, u32 fgcolor);
+
+void atafb_iplan2p2_copyarea(struct fb_info *info, u_long next_line, int s=
y, int sx, int dy,
+			     int dx, int height, int width);
+void atafb_iplan2p2_fillrect(struct fb_info *info, u_long next_line, u32 c=
olor,
+			     int sy, int sx, int height, int width);
+void atafb_iplan2p2_linefill(struct fb_info *info, u_long next_line,
+			     int dy, int dx, u32 width,
+			     const u8 *data, u32 bgcolor, u32 fgcolor);
+
+void atafb_iplan2p4_copyarea(struct fb_info *info, u_long next_line, int s=
y, int sx, int dy,
+			     int dx, int height, int width);
+void atafb_iplan2p4_fillrect(struct fb_info *info, u_long next_line, u32 c=
olor,
+			     int sy, int sx, int height, int width);
+void atafb_iplan2p4_linefill(struct fb_info *info, u_long next_line,
+			     int dy, int dx, u32 width,
+			     const u8 *data, u32 bgcolor, u32 fgcolor);
+
+void atafb_iplan2p8_copyarea(struct fb_info *info, u_long next_line, int s=
y, int sx, int dy,
+			     int dx, int height, int width);
+void atafb_iplan2p8_fillrect(struct fb_info *info, u_long next_line, u32 c=
olor,
+			     int sy, int sx, int height, int width);
+void atafb_iplan2p8_linefill(struct fb_info *info, u_long next_line,
+			     int dy, int dx, u32 width,
+			     const u8 *data, u32 bgcolor, u32 fgcolor);
+
+#endif /* _VIDEO_ATAFB_H */
diff --git a/drivers/video/atafb_iplan2p2.c b/drivers/video/atafb_iplan2p2.c
new file mode 100644
index 0000000..ef99519
--- /dev/null
+++ b/drivers/video/atafb_iplan2p2.c
@@ -0,0 +1,309 @@
+/*
+ *  linux/drivers/video/iplan2p2.c -- Low level frame buffer operations for
+ *				      interleaved bitplanes =E0 la Atari (2
+ *				      planes, 2 bytes interleave)
+ *
+ *	Created 5 Apr 1997 by Geert Uytterhoeven
+ *
+ *  This file is subject to the terms and conditions of the GNU General Pu=
blic
+ *  License.  See the file COPYING in the main directory of this archive f=
or
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+
+#include <asm/setup.h>
+
+#include "atafb.h"
+
+#define BPL	2
+#include "atafb_utils.h"
+
+void atafb_iplan2p2_copyarea(struct fb_info *info, u_long next_line,
+			     int sy, int sx, int dy, int dx,
+			     int height, int width)
+{
+	/*  bmove() has to distinguish two major cases: If both, source and
+	 *  destination, start at even addresses or both are at odd
+	 *  addresses, just the first odd and last even column (if present)
+	 *  require special treatment (memmove_col()). The rest between
+	 *  then can be copied by normal operations, because all adjacent
+	 *  bytes are affected and are to be stored in the same order.
+	 *    The pathological case is when the move should go from an odd
+	 *  address to an even or vice versa. Since the bytes in the plane
+	 *  words must be assembled in new order, it seems wisest to make
+	 *  all movements by memmove_col().
+	 */
+
+	u8 *src, *dst;
+	u32 *s, *d;
+	int w, l , i, j;
+	u_int colsize;
+	u_int upwards =3D (dy < sy) || (dy =3D=3D sy && dx < sx);
+
+	colsize =3D height;
+	if (!((sx ^ dx) & 15)) {
+		/* odd->odd or even->even */
+
+		if (upwards) {
+			src =3D (u8 *)info->screen_base + sy * next_line +
+				(sx & ~15) / (8 / BPL);
+			dst =3D (u8 *)info->screen_base + dy * next_line +
+				(dx & ~15) / (8 / BPL);
+			if (sx & 15) {
+				memmove32_col(dst, src, 0xff00ff, height,
+					      next_line - BPL * 2);
+				src +=3D BPL * 2;
+				dst +=3D BPL * 2;
+				width -=3D 8;
+			}
+			w =3D width >> 4;
+			if (w) {
+				s =3D (u32 *)src;
+				d =3D (u32 *)dst;
+				w *=3D BPL / 2;
+				l =3D next_line - w * 4;
+				for (j =3D height; j > 0; j--) {
+					for (i =3D w; i > 0; i--)
+						*d++ =3D *s++;
+					s =3D (u32 *)((u8 *)s + l);
+					d =3D (u32 *)((u8 *)d + l);
+				}
+			}
+			if (width & 15)
+				memmove32_col(dst + width / (8 / BPL), src +
+					      width / (8 / BPL),
+					      0xff00ff00, height,
+					      next_line - BPL * 2);
+		} else {
+			src =3D (u8 *)info->screen_base + (sy - 1) * next_line +
+				((sx + width + 8) & ~15) / (8 / BPL);
+			dst =3D (u8 *)info->screen_base + (dy - 1) * next_line +
+				((dx + width + 8) & ~15) / (8 / BPL);
+
+			if ((sx + width) & 15) {
+				src -=3D BPL * 2;
+				dst -=3D BPL * 2;
+				memmove32_col(dst, src, 0xff00ff00, colsize,
+					      -next_line - BPL * 2);
+				width -=3D 8;
+			}
+			w =3D width >> 4;
+			if (w) {
+				s =3D (u32 *)src;
+				d =3D (u32 *)dst;
+				w *=3D BPL / 2;
+				l =3D next_line - w * 4;
+				for (j =3D height; j > 0; j--) {
+					for (i =3D w; i > 0; i--)
+						*--d =3D *--s;
+					s =3D (u32 *)((u8 *)s - l);
+					d =3D (u32 *)((u8 *)d - l);
+				}
+			}
+			if (sx & 15)
+				memmove32_col(dst - (width - 16) / (8 / BPL),
+					      src - (width - 16) / (8 / BPL),
+					      0xff00ff, colsize,
+					      -next_line - BPL * 2);
+		}
+	} else {
+		/* odd->even or even->odd */
+		if (upwards) {
+			u32 *src32, *dst32;
+			u32 pval[4], v, v1, mask;
+			int i, j, w, f;
+
+			src =3D (u8 *)info->screen_base + sy * next_line +
+				(sx & ~15) / (8 / BPL);
+			dst =3D (u8 *)info->screen_base + dy * next_line +
+				(dx & ~15) / (8 / BPL);
+
+			mask =3D 0xff00ff00;
+			f =3D 0;
+			w =3D width;
+			if (sx & 15) {
+				f =3D 1;
+				w +=3D 8;
+			}
+			if ((sx + width) & 15)
+				f |=3D 2;
+			w >>=3D 4;
+			for (i =3D height; i; i--) {
+				src32 =3D (u32 *)src;
+				dst32 =3D (u32 *)dst;
+
+				if (f & 1) {
+					pval[0] =3D (*src32++ << 8) & mask;
+				} else {
+					pval[0] =3D dst32[0] & mask;
+				}
+
+				for (j =3D w; j > 0; j--) {
+					v =3D *src32++;
+					v1 =3D v & mask;
+					*dst32++ =3D pval[0] | (v1 >> 8);
+					pval[0] =3D (v ^ v1) << 8;
+				}
+
+				if (f & 2) {
+					dst32[0] =3D (dst32[0] & mask) | pval[0];
+				}
+
+				src +=3D next_line;
+				dst +=3D next_line;
+			}
+		} else {
+			u32 *src32, *dst32;
+			u32 pval[4], v, v1, mask;
+			int i, j, w, f;
+
+			src =3D (u8 *)info->screen_base + (sy - 1) * next_line +
+				((sx + width + 8) & ~15) / (8 / BPL);
+			dst =3D (u8 *)info->screen_base + (dy - 1) * next_line +
+				((dx + width + 8) & ~15) / (8 / BPL);
+
+			mask =3D 0xff00ff;
+			f =3D 0;
+			w =3D width;
+			if ((dx + width) & 15)
+				f =3D 1;
+			if (sx & 15) {
+				f |=3D 2;
+				w +=3D 8;
+			}
+			w >>=3D 4;
+			for (i =3D height; i; i--) {
+				src32 =3D (u32 *)src;
+				dst32 =3D (u32 *)dst;
+
+				if (f & 1) {
+					pval[0] =3D dst32[-1] & mask;
+				} else {
+					pval[0] =3D (*--src32 >> 8) & mask;
+				}
+
+				for (j =3D w; j > 0; j--) {
+					v =3D *--src32;
+					v1 =3D v & mask;
+					*--dst32 =3D pval[0] | (v1 << 8);
+					pval[0] =3D (v ^ v1) >> 8;
+				}
+
+				if (!(f & 2)) {
+					dst32[-1] =3D (dst32[-1] & mask) |
+						pval[0];
+				}
+
+				src -=3D next_line;
+				dst -=3D next_line;
+			}
+		}
+	}
+}
+
+void atafb_iplan2p2_fillrect(struct fb_info *info, u_long next_line, u32 c=
olor,
+                             int sy, int sx, int height, int width)
+{
+	u32 *dest;
+	int rows, i;
+	u32 cval[4];
+
+	dest =3D (u32 *)(info->screen_base + sy * next_line +
+		       (sx & ~15) / (8 / BPL));
+	if (sx & 15) {
+		u8 *dest8 =3D (u8 *)dest + 1;
+
+		expand8_col2mask(color, cval);
+
+		for (i =3D height; i; i--) {
+			fill8_col(dest8, cval);
+			dest8 +=3D next_line;
+		}
+		dest +=3D BPL / 2;
+		width -=3D 8;
+	}
+
+	expand16_col2mask(color, cval);
+	rows =3D width >> 4;
+	if (rows) {
+		u32 *d =3D dest;
+		u32 off =3D next_line - rows * BPL * 2;
+		for (i =3D height; i; i--) {
+			d =3D fill16_col(d, rows, cval);
+			d =3D (u32 *)((long)d + off);
+		}
+		dest +=3D rows * BPL / 2;
+		width &=3D 15;
+	}
+
+	if (width) {
+		u8 *dest8 =3D (u8 *)dest;
+
+		expand8_col2mask(color, cval);
+
+		for (i =3D height; i; i--) {
+			fill8_col(dest8, cval);
+			dest8 +=3D next_line;
+		}
+	}
+}
+
+void atafb_iplan2p2_linefill(struct fb_info *info, u_long next_line,
+                             int dy, int dx, u32 width,
+                             const u8 *data, u32 bgcolor, u32 fgcolor)
+{
+	u32 *dest;
+	const u16 *data16;
+	int rows;
+	u32 fgm[4], bgm[4], m;
+
+	dest =3D (u32 *)(info->screen_base + dy * next_line +
+		       (dx & ~15) / (8 / BPL));
+	if (dx & 15) {
+		fill8_2col((u8 *)dest + 1, fgcolor, bgcolor, *data++);
+		dest +=3D BPL / 2;
+		width -=3D 8;
+	}
+
+	if (width >=3D 16) {
+		data16 =3D (const u16 *)data;
+		expand16_2col2mask(fgcolor, bgcolor, fgm, bgm);
+
+		for (rows =3D width / 16; rows; rows--) {
+			u16 d =3D *data16++;
+			m =3D d | ((u32)d << 16);
+			*dest++ =3D (m & fgm[0]) ^ bgm[0];
+		}
+
+		data =3D (const u8 *)data16;
+		width &=3D 15;
+	}
+
+	if (width)
+		fill8_2col((u8 *)dest, fgcolor, bgcolor, *data);
+}
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+
+int init_module(void)
+{
+	return 0;
+}
+
+void cleanup_module(void)
+{
+}
+#endif /* MODULE */
+
+
+    /*
+     *  Visible symbols for modules
+     */
+
+EXPORT_SYMBOL(atafb_iplan2p2_copyarea);
+EXPORT_SYMBOL(atafb_iplan2p2_fillrect);
+EXPORT_SYMBOL(atafb_iplan2p2_linefill);
diff --git a/drivers/video/atafb_iplan2p4.c b/drivers/video/atafb_iplan2p4.c
new file mode 100644
index 0000000..bee0d89
--- /dev/null
+++ b/drivers/video/atafb_iplan2p4.c
@@ -0,0 +1,308 @@
+/*
+ *  linux/drivers/video/iplan2p4.c -- Low level frame buffer operations for
+ *				      interleaved bitplanes =E0 la Atari (4
+ *				      planes, 2 bytes interleave)
+ *
+ *	Created 5 Apr 1997 by Geert Uytterhoeven
+ *
+ *  This file is subject to the terms and conditions of the GNU General Pu=
blic
+ *  License.  See the file COPYING in the main directory of this archive f=
or
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+
+#include <asm/setup.h>
+
+#include "atafb.h"
+
+#define BPL	4
+#include "atafb_utils.h"
+
+void atafb_iplan2p4_copyarea(struct fb_info *info, u_long next_line,
+			     int sy, int sx, int dy, int dx,
+			     int height, int width)
+{
+	/*  bmove() has to distinguish two major cases: If both, source and
+	 *  destination, start at even addresses or both are at odd
+	 *  addresses, just the first odd and last even column (if present)
+	 *  require special treatment (memmove_col()). The rest between
+	 *  then can be copied by normal operations, because all adjacent
+	 *  bytes are affected and are to be stored in the same order.
+	 *    The pathological case is when the move should go from an odd
+	 *  address to an even or vice versa. Since the bytes in the plane
+	 *  words must be assembled in new order, it seems wisest to make
+	 *  all movements by memmove_col().
+	 */
+
+	u8 *src, *dst;
+	u32 *s, *d;
+	int w, l , i, j;
+	u_int colsize;
+	u_int upwards =3D (dy < sy) || (dy =3D=3D sy && dx < sx);
+
+	colsize =3D height;
+	if (!((sx ^ dx) & 15)) {
+		/* odd->odd or even->even */
+
+		if (upwards) {
+			src =3D (u8 *)info->screen_base + sy * next_line + (sx & ~15) / (8 / BP=
L);
+			dst =3D (u8 *)info->screen_base + dy * next_line + (dx & ~15) / (8 / BP=
L);
+			if (sx & 15) {
+				memmove32_col(dst, src, 0xff00ff, height, next_line - BPL * 2);
+				src +=3D BPL * 2;
+				dst +=3D BPL * 2;
+				width -=3D 8;
+			}
+			w =3D width >> 4;
+			if (w) {
+				s =3D (u32 *)src;
+				d =3D (u32 *)dst;
+				w *=3D BPL / 2;
+				l =3D next_line - w * 4;
+				for (j =3D height; j > 0; j--) {
+					for (i =3D w; i > 0; i--)
+						*d++ =3D *s++;
+					s =3D (u32 *)((u8 *)s + l);
+					d =3D (u32 *)((u8 *)d + l);
+				}
+			}
+			if (width & 15)
+				memmove32_col(dst + width / (8 / BPL), src + width / (8 / BPL),
+					      0xff00ff00, height, next_line - BPL * 2);
+		} else {
+			src =3D (u8 *)info->screen_base + (sy - 1) * next_line + ((sx + width +=
 8) & ~15) / (8 / BPL);
+			dst =3D (u8 *)info->screen_base + (dy - 1) * next_line + ((dx + width +=
 8) & ~15) / (8 / BPL);
+
+			if ((sx + width) & 15) {
+				src -=3D BPL * 2;
+				dst -=3D BPL * 2;
+				memmove32_col(dst, src, 0xff00ff00, colsize, -next_line - BPL * 2);
+				width -=3D 8;
+			}
+			w =3D width >> 4;
+			if (w) {
+				s =3D (u32 *)src;
+				d =3D (u32 *)dst;
+				w *=3D BPL / 2;
+				l =3D next_line - w * 4;
+				for (j =3D height; j > 0; j--) {
+					for (i =3D w; i > 0; i--)
+						*--d =3D *--s;
+					s =3D (u32 *)((u8 *)s - l);
+					d =3D (u32 *)((u8 *)d - l);
+				}
+			}
+			if (sx & 15)
+				memmove32_col(dst - (width - 16) / (8 / BPL),
+					      src - (width - 16) / (8 / BPL),
+					      0xff00ff, colsize, -next_line - BPL * 2);
+		}
+	} else {
+		/* odd->even or even->odd */
+		if (upwards) {
+			u32 *src32, *dst32;
+			u32 pval[4], v, v1, mask;
+			int i, j, w, f;
+
+			src =3D (u8 *)info->screen_base + sy * next_line + (sx & ~15) / (8 / BP=
L);
+			dst =3D (u8 *)info->screen_base + dy * next_line + (dx & ~15) / (8 / BP=
L);
+
+			mask =3D 0xff00ff00;
+			f =3D 0;
+			w =3D width;
+			if (sx & 15) {
+				f =3D 1;
+				w +=3D 8;
+			}
+			if ((sx + width) & 15)
+				f |=3D 2;
+			w >>=3D 4;
+			for (i =3D height; i; i--) {
+				src32 =3D (u32 *)src;
+				dst32 =3D (u32 *)dst;
+
+				if (f & 1) {
+					pval[0] =3D (*src32++ << 8) & mask;
+					pval[1] =3D (*src32++ << 8) & mask;
+				} else {
+					pval[0] =3D dst32[0] & mask;
+					pval[1] =3D dst32[1] & mask;
+				}
+
+				for (j =3D w; j > 0; j--) {
+					v =3D *src32++;
+					v1 =3D v & mask;
+					*dst32++ =3D pval[0] | (v1 >> 8);
+					pval[0] =3D (v ^ v1) << 8;
+					v =3D *src32++;
+					v1 =3D v & mask;
+					*dst32++ =3D pval[1] | (v1 >> 8);
+					pval[1] =3D (v ^ v1) << 8;
+				}
+
+				if (f & 2) {
+					dst32[0] =3D (dst32[0] & mask) | pval[0];
+					dst32[1] =3D (dst32[1] & mask) | pval[1];
+				}
+
+				src +=3D next_line;
+				dst +=3D next_line;
+			}
+		} else {
+			u32 *src32, *dst32;
+			u32 pval[4], v, v1, mask;
+			int i, j, w, f;
+
+			src =3D (u8 *)info->screen_base + (sy - 1) * next_line + ((sx + width +=
 8) & ~15) / (8 / BPL);
+			dst =3D (u8 *)info->screen_base + (dy - 1) * next_line + ((dx + width +=
 8) & ~15) / (8 / BPL);
+
+			mask =3D 0xff00ff;
+			f =3D 0;
+			w =3D width;
+			if ((dx + width) & 15)
+				f =3D 1;
+			if (sx & 15) {
+				f |=3D 2;
+				w +=3D 8;
+			}
+			w >>=3D 4;
+			for (i =3D height; i; i--) {
+				src32 =3D (u32 *)src;
+				dst32 =3D (u32 *)dst;
+
+				if (f & 1) {
+					pval[0] =3D dst32[-1] & mask;
+					pval[1] =3D dst32[-2] & mask;
+				} else {
+					pval[0] =3D (*--src32 >> 8) & mask;
+					pval[1] =3D (*--src32 >> 8) & mask;
+				}
+
+				for (j =3D w; j > 0; j--) {
+					v =3D *--src32;
+					v1 =3D v & mask;
+					*--dst32 =3D pval[0] | (v1 << 8);
+					pval[0] =3D (v ^ v1) >> 8;
+					v =3D *--src32;
+					v1 =3D v & mask;
+					*--dst32 =3D pval[1] | (v1 << 8);
+					pval[1] =3D (v ^ v1) >> 8;
+				}
+
+				if (!(f & 2)) {
+					dst32[-1] =3D (dst32[-1] & mask) | pval[0];
+					dst32[-2] =3D (dst32[-2] & mask) | pval[1];
+				}
+
+				src -=3D next_line;
+				dst -=3D next_line;
+			}
+		}
+	}
+}
+
+void atafb_iplan2p4_fillrect(struct fb_info *info, u_long next_line, u32 c=
olor,
+                             int sy, int sx, int height, int width)
+{
+	u32 *dest;
+	int rows, i;
+	u32 cval[4];
+
+	dest =3D (u32 *)(info->screen_base + sy * next_line + (sx & ~15) / (8 / B=
PL));
+	if (sx & 15) {
+		u8 *dest8 =3D (u8 *)dest + 1;
+
+		expand8_col2mask(color, cval);
+
+		for (i =3D height; i; i--) {
+			fill8_col(dest8, cval);
+			dest8 +=3D next_line;
+		}
+		dest +=3D BPL / 2;
+		width -=3D 8;
+	}
+
+	expand16_col2mask(color, cval);
+	rows =3D width >> 4;
+	if (rows) {
+		u32 *d =3D dest;
+		u32 off =3D next_line - rows * BPL * 2;
+		for (i =3D height; i; i--) {
+			d =3D fill16_col(d, rows, cval);
+			d =3D (u32 *)((long)d + off);
+		}
+		dest +=3D rows * BPL / 2;
+		width &=3D 15;
+	}
+
+	if (width) {
+		u8 *dest8 =3D (u8 *)dest;
+
+		expand8_col2mask(color, cval);
+
+		for (i =3D height; i; i--) {
+			fill8_col(dest8, cval);
+			dest8 +=3D next_line;
+		}
+	}
+}
+
+void atafb_iplan2p4_linefill(struct fb_info *info, u_long next_line,
+                             int dy, int dx, u32 width,
+                             const u8 *data, u32 bgcolor, u32 fgcolor)
+{
+	u32 *dest;
+	const u16 *data16;
+	int rows;
+	u32 fgm[4], bgm[4], m;
+
+	dest =3D (u32 *)(info->screen_base + dy * next_line + (dx & ~15) / (8 / B=
PL));
+	if (dx & 15) {
+		fill8_2col((u8 *)dest + 1, fgcolor, bgcolor, *data++);
+		dest +=3D BPL / 2;
+		width -=3D 8;
+	}
+
+	if (width >=3D 16) {
+		data16 =3D (const u16 *)data;
+		expand16_2col2mask(fgcolor, bgcolor, fgm, bgm);
+
+		for (rows =3D width / 16; rows; rows--) {
+			u16 d =3D *data16++;
+			m =3D d | ((u32)d << 16);
+			*dest++ =3D (m & fgm[0]) ^ bgm[0];
+			*dest++ =3D (m & fgm[1]) ^ bgm[1];
+		}
+
+		data =3D (const u8 *)data16;
+		width &=3D 15;
+	}
+
+	if (width)
+		fill8_2col((u8 *)dest, fgcolor, bgcolor, *data);
+}
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+
+int init_module(void)
+{
+	return 0;
+}
+
+void cleanup_module(void)
+{
+}
+#endif /* MODULE */
+
+
+    /*
+     *  Visible symbols for modules
+     */
+
+EXPORT_SYMBOL(atafb_iplan2p4_copyarea);
+EXPORT_SYMBOL(atafb_iplan2p4_fillrect);
+EXPORT_SYMBOL(atafb_iplan2p4_linefill);
diff --git a/drivers/video/atafb_iplan2p8.c b/drivers/video/atafb_iplan2p8.c
new file mode 100644
index 0000000..356fb52
--- /dev/null
+++ b/drivers/video/atafb_iplan2p8.c
@@ -0,0 +1,345 @@
+/*
+ *  linux/drivers/video/iplan2p8.c -- Low level frame buffer operations for
+ *				      interleaved bitplanes =E0 la Atari (8
+ *				      planes, 2 bytes interleave)
+ *
+ *	Created 5 Apr 1997 by Geert Uytterhoeven
+ *
+ *  This file is subject to the terms and conditions of the GNU General Pu=
blic
+ *  License.  See the file COPYING in the main directory of this archive f=
or
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+
+#include <asm/setup.h>
+
+#include "atafb.h"
+
+#define BPL	8
+#include "atafb_utils.h"
+
+
+/* Copies a 8 plane column from 's', height 'h', to 'd'. */
+
+/* This expands a 8 bit color into two longs for two movepl (8 plane)
+ * operations.
+ */
+
+void atafb_iplan2p8_copyarea(struct fb_info *info, u_long next_line,
+			     int sy, int sx, int dy, int dx,
+			     int height, int width)
+{
+	/*  bmove() has to distinguish two major cases: If both, source and
+	 *  destination, start at even addresses or both are at odd
+	 *  addresses, just the first odd and last even column (if present)
+	 *  require special treatment (memmove_col()). The rest between
+	 *  then can be copied by normal operations, because all adjacent
+	 *  bytes are affected and are to be stored in the same order.
+	 *    The pathological case is when the move should go from an odd
+	 *  address to an even or vice versa. Since the bytes in the plane
+	 *  words must be assembled in new order, it seems wisest to make
+	 *  all movements by memmove_col().
+	 */
+
+	u8 *src, *dst;
+	u32 *s, *d;
+	int w, l , i, j;
+	u_int colsize;
+	u_int upwards =3D (dy < sy) || (dy =3D=3D sy && dx < sx);
+
+	colsize =3D height;
+	if (!((sx ^ dx) & 15)) {
+		/* odd->odd or even->even */
+
+		if (upwards) {
+			src =3D (u8 *)info->screen_base + sy * next_line + (sx & ~15) / (8 / BP=
L);
+			dst =3D (u8 *)info->screen_base + dy * next_line + (dx & ~15) / (8 / BP=
L);
+			if (sx & 15) {
+				memmove32_col(dst, src, 0xff00ff, height, next_line - BPL * 2);
+				src +=3D BPL * 2;
+				dst +=3D BPL * 2;
+				width -=3D 8;
+			}
+			w =3D width >> 4;
+			if (w) {
+				s =3D (u32 *)src;
+				d =3D (u32 *)dst;
+				w *=3D BPL / 2;
+				l =3D next_line - w * 4;
+				for (j =3D height; j > 0; j--) {
+					for (i =3D w; i > 0; i--)
+						*d++ =3D *s++;
+					s =3D (u32 *)((u8 *)s + l);
+					d =3D (u32 *)((u8 *)d + l);
+				}
+			}
+			if (width & 15)
+				memmove32_col(dst + width / (8 / BPL), src + width / (8 / BPL),
+					      0xff00ff00, height, next_line - BPL * 2);
+		} else {
+			src =3D (u8 *)info->screen_base + (sy - 1) * next_line + ((sx + width +=
 8) & ~15) / (8 / BPL);
+			dst =3D (u8 *)info->screen_base + (dy - 1) * next_line + ((dx + width +=
 8) & ~15) / (8 / BPL);
+
+			if ((sx + width) & 15) {
+				src -=3D BPL * 2;
+				dst -=3D BPL * 2;
+				memmove32_col(dst, src, 0xff00ff00, colsize, -next_line - BPL * 2);
+				width -=3D 8;
+			}
+			w =3D width >> 4;
+			if (w) {
+				s =3D (u32 *)src;
+				d =3D (u32 *)dst;
+				w *=3D BPL / 2;
+				l =3D next_line - w * 4;
+				for (j =3D height; j > 0; j--) {
+					for (i =3D w; i > 0; i--)
+						*--d =3D *--s;
+					s =3D (u32 *)((u8 *)s - l);
+					d =3D (u32 *)((u8 *)d - l);
+				}
+			}
+			if (sx & 15)
+				memmove32_col(dst - (width - 16) / (8 / BPL),
+					      src - (width - 16) / (8 / BPL),
+					      0xff00ff, colsize, -next_line - BPL * 2);
+		}
+	} else {
+		/* odd->even or even->odd */
+		if (upwards) {
+			u32 *src32, *dst32;
+			u32 pval[4], v, v1, mask;
+			int i, j, w, f;
+
+			src =3D (u8 *)info->screen_base + sy * next_line + (sx & ~15) / (8 / BP=
L);
+			dst =3D (u8 *)info->screen_base + dy * next_line + (dx & ~15) / (8 / BP=
L);
+
+			mask =3D 0xff00ff00;
+			f =3D 0;
+			w =3D width;
+			if (sx & 15) {
+				f =3D 1;
+				w +=3D 8;
+			}
+			if ((sx + width) & 15)
+				f |=3D 2;
+			w >>=3D 4;
+			for (i =3D height; i; i--) {
+				src32 =3D (u32 *)src;
+				dst32 =3D (u32 *)dst;
+
+				if (f & 1) {
+					pval[0] =3D (*src32++ << 8) & mask;
+					pval[1] =3D (*src32++ << 8) & mask;
+					pval[2] =3D (*src32++ << 8) & mask;
+					pval[3] =3D (*src32++ << 8) & mask;
+				} else {
+					pval[0] =3D dst32[0] & mask;
+					pval[1] =3D dst32[1] & mask;
+					pval[2] =3D dst32[2] & mask;
+					pval[3] =3D dst32[3] & mask;
+				}
+
+				for (j =3D w; j > 0; j--) {
+					v =3D *src32++;
+					v1 =3D v & mask;
+					*dst32++ =3D pval[0] | (v1 >> 8);
+					pval[0] =3D (v ^ v1) << 8;
+					v =3D *src32++;
+					v1 =3D v & mask;
+					*dst32++ =3D pval[1] | (v1 >> 8);
+					pval[1] =3D (v ^ v1) << 8;
+					v =3D *src32++;
+					v1 =3D v & mask;
+					*dst32++ =3D pval[2] | (v1 >> 8);
+					pval[2] =3D (v ^ v1) << 8;
+					v =3D *src32++;
+					v1 =3D v & mask;
+					*dst32++ =3D pval[3] | (v1 >> 8);
+					pval[3] =3D (v ^ v1) << 8;
+				}
+
+				if (f & 2) {
+					dst32[0] =3D (dst32[0] & mask) | pval[0];
+					dst32[1] =3D (dst32[1] & mask) | pval[1];
+					dst32[2] =3D (dst32[2] & mask) | pval[2];
+					dst32[3] =3D (dst32[3] & mask) | pval[3];
+				}
+
+				src +=3D next_line;
+				dst +=3D next_line;
+			}
+		} else {
+			u32 *src32, *dst32;
+			u32 pval[4], v, v1, mask;
+			int i, j, w, f;
+
+			src =3D (u8 *)info->screen_base + (sy - 1) * next_line + ((sx + width +=
 8) & ~15) / (8 / BPL);
+			dst =3D (u8 *)info->screen_base + (dy - 1) * next_line + ((dx + width +=
 8) & ~15) / (8 / BPL);
+
+			mask =3D 0xff00ff;
+			f =3D 0;
+			w =3D width;
+			if ((dx + width) & 15)
+				f =3D 1;
+			if (sx & 15) {
+				f |=3D 2;
+				w +=3D 8;
+			}
+			w >>=3D 4;
+			for (i =3D height; i; i--) {
+				src32 =3D (u32 *)src;
+				dst32 =3D (u32 *)dst;
+
+				if (f & 1) {
+					pval[0] =3D dst32[-1] & mask;
+					pval[1] =3D dst32[-2] & mask;
+					pval[2] =3D dst32[-3] & mask;
+					pval[3] =3D dst32[-4] & mask;
+				} else {
+					pval[0] =3D (*--src32 >> 8) & mask;
+					pval[1] =3D (*--src32 >> 8) & mask;
+					pval[2] =3D (*--src32 >> 8) & mask;
+					pval[3] =3D (*--src32 >> 8) & mask;
+				}
+
+				for (j =3D w; j > 0; j--) {
+					v =3D *--src32;
+					v1 =3D v & mask;
+					*--dst32 =3D pval[0] | (v1 << 8);
+					pval[0] =3D (v ^ v1) >> 8;
+					v =3D *--src32;
+					v1 =3D v & mask;
+					*--dst32 =3D pval[1] | (v1 << 8);
+					pval[1] =3D (v ^ v1) >> 8;
+					v =3D *--src32;
+					v1 =3D v & mask;
+					*--dst32 =3D pval[2] | (v1 << 8);
+					pval[2] =3D (v ^ v1) >> 8;
+					v =3D *--src32;
+					v1 =3D v & mask;
+					*--dst32 =3D pval[3] | (v1 << 8);
+					pval[3] =3D (v ^ v1) >> 8;
+				}
+
+				if (!(f & 2)) {
+					dst32[-1] =3D (dst32[-1] & mask) | pval[0];
+					dst32[-2] =3D (dst32[-2] & mask) | pval[1];
+					dst32[-3] =3D (dst32[-3] & mask) | pval[2];
+					dst32[-4] =3D (dst32[-4] & mask) | pval[3];
+				}
+
+				src -=3D next_line;
+				dst -=3D next_line;
+			}
+		}
+	}
+}
+
+void atafb_iplan2p8_fillrect(struct fb_info *info, u_long next_line, u32 c=
olor,
+                             int sy, int sx, int height, int width)
+{
+	u32 *dest;
+	int rows, i;
+	u32 cval[4];
+
+	dest =3D (u32 *)(info->screen_base + sy * next_line + (sx & ~15) / (8 / B=
PL));
+	if (sx & 15) {
+		u8 *dest8 =3D (u8 *)dest + 1;
+
+		expand8_col2mask(color, cval);
+
+		for (i =3D height; i; i--) {
+			fill8_col(dest8, cval);
+			dest8 +=3D next_line;
+		}
+		dest +=3D BPL / 2;
+		width -=3D 8;
+	}
+
+	expand16_col2mask(color, cval);
+	rows =3D width >> 4;
+	if (rows) {
+		u32 *d =3D dest;
+		u32 off =3D next_line - rows * BPL * 2;
+		for (i =3D height; i; i--) {
+			d =3D fill16_col(d, rows, cval);
+			d =3D (u32 *)((long)d + off);
+		}
+		dest +=3D rows * BPL / 2;
+		width &=3D 15;
+	}
+
+	if (width) {
+		u8 *dest8 =3D (u8 *)dest;
+
+		expand8_col2mask(color, cval);
+
+		for (i =3D height; i; i--) {
+			fill8_col(dest8, cval);
+			dest8 +=3D next_line;
+		}
+	}
+}
+
+void atafb_iplan2p8_linefill(struct fb_info *info, u_long next_line,
+			     int dy, int dx, u32 width,
+			     const u8 *data, u32 bgcolor, u32 fgcolor)
+{
+	u32 *dest;
+	const u16 *data16;
+	int rows;
+	u32 fgm[4], bgm[4], m;
+
+	dest =3D (u32 *)(info->screen_base + dy * next_line + (dx & ~15) / (8 / B=
PL));
+	if (dx & 15) {
+		fill8_2col((u8 *)dest + 1, fgcolor, bgcolor, *data++);
+		dest +=3D BPL / 2;
+		width -=3D 8;
+	}
+
+	if (width >=3D 16) {
+		data16 =3D (const u16 *)data;
+		expand16_2col2mask(fgcolor, bgcolor, fgm, bgm);
+
+		for (rows =3D width / 16; rows; rows--) {
+			u16 d =3D *data16++;
+			m =3D d | ((u32)d << 16);
+			*dest++ =3D (m & fgm[0]) ^ bgm[0];
+			*dest++ =3D (m & fgm[1]) ^ bgm[1];
+			*dest++ =3D (m & fgm[2]) ^ bgm[2];
+			*dest++ =3D (m & fgm[3]) ^ bgm[3];
+		}
+
+		data =3D (const u8 *)data16;
+		width &=3D 15;
+	}
+
+	if (width)
+		fill8_2col((u8 *)dest, fgcolor, bgcolor, *data);
+}
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+
+int init_module(void)
+{
+	return 0;
+}
+
+void cleanup_module(void)
+{
+}
+#endif /* MODULE */
+
+
+    /*
+     *  Visible symbols for modules
+     */
+
+EXPORT_SYMBOL(atafb_iplan2p8_copyarea);
+EXPORT_SYMBOL(atafb_iplan2p8_fillrect);
+EXPORT_SYMBOL(atafb_iplan2p8_linefill);
diff --git a/drivers/video/atafb_mfb.c b/drivers/video/atafb_mfb.c
new file mode 100644
index 0000000..6a352d6
--- /dev/null
+++ b/drivers/video/atafb_mfb.c
@@ -0,0 +1,112 @@
+/*
+ *  linux/drivers/video/mfb.c -- Low level frame buffer operations for
+ *				 monochrome
+ *
+ *	Created 5 Apr 1997 by Geert Uytterhoeven
+ *
+ *  This file is subject to the terms and conditions of the GNU General Pu=
blic
+ *  License.  See the file COPYING in the main directory of this archive f=
or
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+
+#include "atafb.h"
+#include "atafb_utils.h"
+
+
+    /*
+     *  Monochrome
+     */
+
+void atafb_mfb_copyarea(struct fb_info *info, u_long next_line,
+			int sy, int sx, int dy, int dx,
+			int height, int width)
+{
+	u8 *src, *dest;
+	u_int rows;
+
+	if (sx =3D=3D 0 && dx =3D=3D 0 && width =3D=3D next_line) {
+		src =3D (u8 *)info->screen_base + sy * (width >> 3);
+		dest =3D (u8 *)info->screen_base + dy * (width >> 3);
+		fb_memmove(dest, src, height * (width >> 3));
+	} else if (dy <=3D sy) {
+		src =3D (u8 *)info->screen_base + sy * next_line + (sx >> 3);
+		dest =3D (u8 *)info->screen_base + dy * next_line + (dx >> 3);
+		for (rows =3D height; rows--;) {
+			fb_memmove(dest, src, width >> 3);
+			src +=3D next_line;
+			dest +=3D next_line;
+		}
+	} else {
+		src =3D (u8 *)info->screen_base + (sy + height - 1) * next_line + (sx >>=
 3);
+		dest =3D (u8 *)info->screen_base + (dy + height - 1) * next_line + (dx >=
> 3);
+		for (rows =3D height; rows--;) {
+			fb_memmove(dest, src, width >> 3);
+			src -=3D next_line;
+			dest -=3D next_line;
+		}
+	}
+}
+
+void atafb_mfb_fillrect(struct fb_info *info, u_long next_line, u32 color,
+			int sy, int sx, int height, int width)
+{
+	u8 *dest;
+	u_int rows;
+
+	dest =3D (u8 *)info->screen_base + sy * next_line + (sx >> 3);
+
+	if (sx =3D=3D 0 && width =3D=3D next_line) {
+		if (color)
+			fb_memset255(dest, height * (width >> 3));
+		else
+			fb_memclear(dest, height * (width >> 3));
+	} else {
+		for (rows =3D height; rows--; dest +=3D next_line) {
+			if (color)
+				fb_memset255(dest, width >> 3);
+			else
+				fb_memclear_small(dest, width >> 3);
+		}
+	}
+}
+
+void atafb_mfb_linefill(struct fb_info *info, u_long next_line,
+			int dy, int dx, u32 width,
+			const u8 *data, u32 bgcolor, u32 fgcolor)
+{
+	u8 *dest;
+	u_int rows;
+
+	dest =3D (u8 *)info->screen_base + dy * next_line + (dx >> 3);
+
+	for (rows =3D width / 8; rows--; /* check margins */ ) {
+		// use fast_memmove or fb_memmove
+		*dest++ =3D *data++;
+	}
+}
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+
+int init_module(void)
+{
+	return 0;
+}
+
+void cleanup_module(void)
+{
+}
+#endif /* MODULE */
+
+
+    /*
+     *  Visible symbols for modules
+     */
+
+EXPORT_SYMBOL(atafb_mfb_copyarea);
+EXPORT_SYMBOL(atafb_mfb_fillrect);
+EXPORT_SYMBOL(atafb_mfb_linefill);
diff --git a/drivers/video/atafb_utils.h b/drivers/video/atafb_utils.h
new file mode 100644
index 0000000..ac9e19d
--- /dev/null
+++ b/drivers/video/atafb_utils.h
@@ -0,0 +1,400 @@
+#ifndef _VIDEO_ATAFB_UTILS_H
+#define _VIDEO_ATAFB_UTILS_H
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
+/*                      Utility Assembler Functions                  */
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
+
+/* Those of a delicate disposition might like to skip the next couple of
+ * pages.
+ *
+ * These functions are drop in replacements for memmove and
+ * memset(_, 0, _). However their five instances add at least a kilobyte
+ * to the object file. You have been warned.
+ *
+ * Not a great fan of assembler for the sake of it, but I think
+ * that these routines are at least 10 times faster than their C
+ * equivalents for large blits, and that's important to the lowest level of
+ * a graphics driver. Question is whether some scheme with the blitter
+ * would be faster. I suspect not for simple text system - not much
+ * asynchrony.
+ *
+ * Code is very simple, just gruesome expansion. Basic strategy is to
+ * increase data moved/cleared at each step to 16 bytes to reduce
+ * instruction per data move overhead. movem might be faster still
+ * For more than 15 bytes, we try to align the write direction on a
+ * longword boundary to get maximum speed. This is even more gruesome.
+ * Unaligned read/write used requires 68020+ - think this is a problem?
+ *
+ * Sorry!
+ */
+
+
+/* ++roman: I've optimized Robert's original versions in some minor
+ * aspects, e.g. moveq instead of movel, let gcc choose the registers,
+ * use movem in some places...
+ * For other modes than 1 plane, lots of more such assembler functions
+ * were needed (e.g. the ones using movep or expanding color values).
+ */
+
+/* ++andreas: more optimizations:
+   subl #65536,d0 replaced by clrw d0; subql #1,d0 for dbcc
+   addal is faster than addaw
+   movep is rather expensive compared to ordinary move's
+   some functions rewritten in C for clarity, no speed loss */
+
+static inline void *fb_memclear_small(void *s, size_t count)
+{
+	if (!count)
+		return 0;
+
+	asm volatile ("\n"
+		"	lsr.l	#1,%1 ; jcc 1f ; move.b %2,-(%0)\n"
+		"1:	lsr.l	#1,%1 ; jcc 1f ; move.w %2,-(%0)\n"
+		"1:	lsr.l	#1,%1 ; jcc 1f ; move.l %2,-(%0)\n"
+		"1:	lsr.l	#1,%1 ; jcc 1f ; move.l %2,-(%0) ; move.l %2,-(%0)\n"
+		"1:"
+		: "=3Da" (s), "=3Dd" (count)
+		: "d" (0), "0" ((char *)s + count), "1" (count));
+	asm volatile ("\n"
+		"	subq.l  #1,%1\n"
+		"	jcs	3f\n"
+		"	move.l	%2,%%d4; move.l %2,%%d5; move.l %2,%%d6\n"
+		"2:	movem.l	%2/%%d4/%%d5/%%d6,-(%0)\n"
+		"	dbra	%1,2b\n"
+		"3:"
+		: "=3Da" (s), "=3Dd" (count)
+		: "d" (0), "0" (s), "1" (count)
+		: "d4", "d5", "d6"
+		);
+
+	return 0;
+}
+
+
+static inline void *fb_memclear(void *s, size_t count)
+{
+	if (!count)
+		return 0;
+
+	if (count < 16) {
+		asm volatile ("\n"
+			"	lsr.l	#1,%1 ; jcc 1f ; clr.b (%0)+\n"
+			"1:	lsr.l	#1,%1 ; jcc 1f ; clr.w (%0)+\n"
+			"1:	lsr.l	#1,%1 ; jcc 1f ; clr.l (%0)+\n"
+			"1:	lsr.l	#1,%1 ; jcc 1f ; clr.l (%0)+ ; clr.l (%0)+\n"
+			"1:"
+			: "=3Da" (s), "=3Dd" (count)
+			: "0" (s), "1" (count));
+	} else {
+		long tmp;
+		asm volatile ("\n"
+			"	move.l	%1,%2\n"
+			"	lsr.l	#1,%2 ; jcc 1f ; clr.b (%0)+ ; subq.w #1,%1\n"
+			"	lsr.l	#1,%2 ; jcs 2f\n"  /* %0 increased=3D>bit 2 switched*/
+			"	clr.w	(%0)+  ; subq.w  #2,%1 ; jra 2f\n"
+			"1:	lsr.l	#1,%2 ; jcc 2f\n"
+			"	clr.w	(%0)+  ; subq.w  #2,%1\n"
+			"2:	move.w	%1,%2; lsr.l #2,%1 ; jeq 6f\n"
+			"	lsr.l	#1,%1 ; jcc 3f ; clr.l (%0)+\n"
+			"3:	lsr.l	#1,%1 ; jcc 4f ; clr.l (%0)+ ; clr.l (%0)+\n"
+			"4:	subq.l	#1,%1 ; jcs 6f\n"
+			"5:	clr.l	(%0)+; clr.l (%0)+ ; clr.l (%0)+ ; clr.l (%0)+\n"
+			"	dbra	%1,5b ; clr.w %1; subq.l #1,%1; jcc 5b\n"
+			"6:	move.w	%2,%1; btst #1,%1 ; jeq 7f ; clr.w (%0)+\n"
+			"7:	btst	#0,%1 ; jeq 8f ; clr.b (%0)+\n"
+			"8:"
+			: "=3Da" (s), "=3Dd" (count), "=3Dd" (tmp)
+			: "0" (s), "1" (count));
+	}
+
+	return 0;
+}
+
+
+static inline void *fb_memset255(void *s, size_t count)
+{
+	if (!count)
+		return 0;
+
+	asm volatile ("\n"
+		"	lsr.l	#1,%1 ; jcc 1f ; move.b %2,-(%0)\n"
+		"1:	lsr.l	#1,%1 ; jcc 1f ; move.w %2,-(%0)\n"
+		"1:	lsr.l	#1,%1 ; jcc 1f ; move.l %2,-(%0)\n"
+		"1:	lsr.l	#1,%1 ; jcc 1f ; move.l %2,-(%0) ; move.l %2,-(%0)\n"
+		"1:"
+		: "=3Da" (s), "=3Dd" (count)
+		: "d" (-1), "0" ((char *)s+count), "1" (count));
+	asm volatile ("\n"
+		"	subq.l	#1,%1 ; jcs 3f\n"
+		"	move.l	%2,%%d4; move.l %2,%%d5; move.l %2,%%d6\n"
+		"2:	movem.l	%2/%%d4/%%d5/%%d6,-(%0)\n"
+		"	dbra	%1,2b\n"
+		"3:"
+		: "=3Da" (s), "=3Dd" (count)
+		: "d" (-1), "0" (s), "1" (count)
+		: "d4", "d5", "d6");
+
+	return 0;
+}
+
+
+static inline void *fb_memmove(void *d, const void *s, size_t count)
+{
+	if (d < s) {
+		if (count < 16) {
+			asm volatile ("\n"
+				"	lsr.l	#1,%2 ; jcc 1f ; move.b (%1)+,(%0)+\n"
+				"1:	lsr.l	#1,%2 ; jcc 1f ; move.w (%1)+,(%0)+\n"
+				"1:	lsr.l	#1,%2 ; jcc 1f ; move.l (%1)+,(%0)+\n"
+				"1:	lsr.l	#1,%2 ; jcc 1f ; move.l (%1)+,(%0)+ ; move.l (%1)+,(%0)+\n"
+				"1:"
+				: "=3Da" (d), "=3Da" (s), "=3Dd" (count)
+				: "0" (d), "1" (s), "2" (count));
+		} else {
+			long tmp;
+			asm volatile ("\n"
+				"	move.l	%0,%3\n"
+				"	lsr.l	#1,%3 ; jcc 1f ; move.b (%1)+,(%0)+ ; subqw #1,%2\n"
+				"	lsr.l	#1,%3 ; jcs 2f\n"  /* %0 increased=3D>bit 2 switched*/
+				"	move.w	(%1)+,(%0)+  ; subqw  #2,%2 ; jra 2f\n"
+				"1:	lsr.l   #1,%3 ; jcc 2f\n"
+				"	move.w	(%1)+,(%0)+  ; subqw  #2,%2\n"
+				"2:	move.w	%2,%-; lsr.l #2,%2 ; jeq 6f\n"
+				"	lsr.l	#1,%2 ; jcc 3f ; move.l (%1)+,(%0)+\n"
+				"3:	lsr.l	#1,%2 ; jcc 4f ; move.l (%1)+,(%0)+ ; move.l (%1)+,(%0)+\n"
+				"4:	subq.l	#1,%2 ; jcs 6f\n"
+				"5:	move.l	(%1)+,(%0)+; move.l (%1)+,(%0)+\n"
+				"	move.l	(%1)+,(%0)+; move.l (%1)+,(%0)+\n"
+				"	dbra	%2,5b ; clr.w %2; subq.l #1,%2; jcc 5b\n"
+				"6:	move.w	%+,%2; btst #1,%2 ; jeq 7f ; move.w (%1)+,(%0)+\n"
+				"7:	btst	#0,%2 ; jeq 8f ; move.b (%1)+,(%0)+\n"
+				"8:"
+				: "=3Da" (d), "=3Da" (s), "=3Dd" (count), "=3Dd" (tmp)
+				: "0" (d), "1" (s), "2" (count));
+		}
+	} else {
+		if (count < 16) {
+			asm volatile ("\n"
+				"	lsr.l	#1,%2 ; jcc 1f ; move.b -(%1),-(%0)\n"
+				"1:	lsr.l	#1,%2 ; jcc 1f ; move.w -(%1),-(%0)\n"
+				"1:	lsr.l	#1,%2 ; jcc 1f ; move.l -(%1),-(%0)\n"
+				"1:	lsr.l	#1,%2 ; jcc 1f ; move.l -(%1),-(%0) ; move.l -(%1),-(%0)\n"
+				"1:"
+				: "=3Da" (d), "=3Da" (s), "=3Dd" (count)
+				: "0" ((char *) d + count), "1" ((char *) s + count), "2" (count));
+		} else {
+			long tmp;
+
+			asm volatile ("\n"
+				"	move.l	%0,%3\n"
+				"	lsr.l	#1,%3 ; jcc 1f ; move.b -(%1),-(%0) ; subqw #1,%2\n"
+				"	lsr.l	#1,%3 ; jcs 2f\n"  /* %0 increased=3D>bit 2 switched*/
+				"	move.w	-(%1),-(%0) ; subqw  #2,%2 ; jra 2f\n"
+				"1:	lsr.l	#1,%3 ; jcc 2f\n"
+				"	move.w	-(%1),-(%0) ; subqw  #2,%2\n"
+				"2:	move.w	%2,%-; lsr.l #2,%2 ; jeq 6f\n"
+				"	lsr.l	#1,%2 ; jcc 3f ; move.l -(%1),-(%0)\n"
+				"3:	lsr.l	#1,%2 ; jcc 4f ; move.l -(%1),-(%0) ; move.l -(%1),-(%0)\n"
+				"4:	subq.l	#1,%2 ; jcs 6f\n"
+				"5:	move.l	-(%1),-(%0); move.l -(%1),-(%0)\n"
+				"	move.l	-(%1),-(%0); move.l -(%1),-(%0)\n"
+				"	dbra	%2,5b ; clr.w %2; subq.l #1,%2; jcc 5b\n"
+				"6:	move.w	%+,%2; btst #1,%2 ; jeq 7f ; move.w -(%1),-(%0)\n"
+				"7:	btst	#0,%2 ; jeq 8f ; move.b -(%1),-(%0)\n"
+				"8:"
+				: "=3Da" (d), "=3Da" (s), "=3Dd" (count), "=3Dd" (tmp)
+				: "0" ((char *) d + count), "1" ((char *) s + count), "2" (count));
+		}
+	}
+
+	return 0;
+}
+
+
+/* ++andreas: Simple and fast version of memmove, assumes size is
+   divisible by 16, suitable for moving the whole screen bitplane */
+static inline void fast_memmove(char *dst, const char *src, size_t size)
+{
+	if (!size)
+		return;
+	if (dst < src)
+		asm volatile ("\n"
+			"1:	movem.l	(%0)+,%%d0/%%d1/%%a0/%%a1\n"
+			"	movem.l	%%d0/%%d1/%%a0/%%a1,%1@\n"
+			"	addq.l	#8,%1; addq.l #8,%1\n"
+			"	dbra	%2,1b\n"
+			"	clr.w	%2; subq.l #1,%2\n"
+			"	jcc	1b"
+			: "=3Da" (src), "=3Da" (dst), "=3Dd" (size)
+			: "0" (src), "1" (dst), "2" (size / 16 - 1)
+			: "d0", "d1", "a0", "a1", "memory");
+	else
+		asm volatile ("\n"
+			"1:	subq.l	#8,%0; subq.l #8,%0\n"
+			"	movem.l	%0@,%%d0/%%d1/%%a0/%%a1\n"
+			"	movem.l	%%d0/%%d1/%%a0/%%a1,-(%1)\n"
+			"	dbra	%2,1b\n"
+			"	clr.w	%2; subq.l #1,%2\n"
+			"	jcc 1b"
+			: "=3Da" (src), "=3Da" (dst), "=3Dd" (size)
+			: "0" (src + size), "1" (dst + size), "2" (size / 16 - 1)
+			: "d0", "d1", "a0", "a1", "memory");
+}
+
+#ifdef BPL
+
+/*
+ * This expands a up to 8 bit color into two longs
+ * for movel operations.
+ */
+static const u32 four2long[] =3D {
+	0x00000000, 0x000000ff, 0x0000ff00, 0x0000ffff,
+	0x00ff0000, 0x00ff00ff, 0x00ffff00, 0x00ffffff,
+	0xff000000, 0xff0000ff, 0xff00ff00, 0xff00ffff,
+	0xffff0000, 0xffff00ff, 0xffffff00, 0xffffffff,
+};
+
+static inline void expand8_col2mask(u8 c, u32 m[])
+{
+	m[0] =3D four2long[c & 15];
+#if BPL > 4
+	m[1] =3D four2long[c >> 4];
+#endif
+}
+
+static inline void expand8_2col2mask(u8 fg, u8 bg, u32 fgm[], u32 bgm[])
+{
+	fgm[0] =3D four2long[fg & 15] ^ (bgm[0] =3D four2long[bg & 15]);
+#if BPL > 4
+	fgm[1] =3D four2long[fg >> 4] ^ (bgm[1] =3D four2long[bg >> 4]);
+#endif
+}
+
+/*
+ * set an 8bit value to a color
+ */
+static inline void fill8_col(u8 *dst, u32 m[])
+{
+	u32 tmp =3D m[0];
+	dst[0] =3D tmp;
+	dst[2] =3D (tmp >>=3D 8);
+#if BPL > 2
+	dst[4] =3D (tmp >>=3D 8);
+	dst[6] =3D tmp >> 8;
+#endif
+#if BPL > 4
+	tmp =3D m[1];
+	dst[8] =3D tmp;
+	dst[10] =3D (tmp >>=3D 8);
+	dst[12] =3D (tmp >>=3D 8);
+	dst[14] =3D tmp >> 8;
+#endif
+}
+
+/*
+ * set an 8bit value according to foreground/background color
+ */
+static inline void fill8_2col(u8 *dst, u8 fg, u8 bg, u32 mask)
+{
+	u32 fgm[2], bgm[2], tmp;
+
+	expand8_2col2mask(fg, bg, fgm, bgm);
+
+	mask |=3D mask << 8;
+#if BPL > 2
+	mask |=3D mask << 16;
+#endif
+	tmp =3D (mask & fgm[0]) ^ bgm[0];
+	dst[0] =3D tmp;
+	dst[2] =3D (tmp >>=3D 8);
+#if BPL > 2
+	dst[4] =3D (tmp >>=3D 8);
+	dst[6] =3D tmp >> 8;
+#endif
+#if BPL > 4
+	tmp =3D (mask & fgm[1]) ^ bgm[1];
+	dst[8] =3D tmp;
+	dst[10] =3D (tmp >>=3D 8);
+	dst[12] =3D (tmp >>=3D 8);
+	dst[14] =3D tmp >> 8;
+#endif
+}
+
+static const u32 two2word[] =3D {
+	0x00000000, 0xffff0000, 0x0000ffff, 0xffffffff
+};
+
+static inline void expand16_col2mask(u8 c, u32 m[])
+{
+	m[0] =3D two2word[c & 3];
+#if BPL > 2
+	m[1] =3D two2word[(c >> 2) & 3];
+#endif
+#if BPL > 4
+	m[2] =3D two2word[(c >> 4) & 3];
+	m[3] =3D two2word[c >> 6];
+#endif
+}
+
+static inline void expand16_2col2mask(u8 fg, u8 bg, u32 fgm[], u32 bgm[])
+{
+	bgm[0] =3D two2word[bg & 3];
+	fgm[0] =3D two2word[fg & 3] ^ bgm[0];
+#if BPL > 2
+	bgm[1] =3D two2word[(bg >> 2) & 3];
+	fgm[1] =3D two2word[(fg >> 2) & 3] ^ bgm[1];
+#endif
+#if BPL > 4
+	bgm[2] =3D two2word[(bg >> 4) & 3];
+	fgm[2] =3D two2word[(fg >> 4) & 3] ^ bgm[2];
+	bgm[3] =3D two2word[bg >> 6];
+	fgm[3] =3D two2word[fg >> 6] ^ bgm[3];
+#endif
+}
+
+static inline u32 *fill16_col(u32 *dst, int rows, u32 m[])
+{
+	while (rows) {
+		*dst++ =3D m[0];
+#if BPL > 2
+		*dst++ =3D m[1];
+#endif
+#if BPL > 4
+		*dst++ =3D m[2];
+		*dst++ =3D m[3];
+#endif
+		rows--;
+	}
+	return dst;
+}
+
+static inline void memmove32_col(void *dst, void *src, u32 mask, u32 h, u3=
2 bytes)
+{
+	u32 *s, *d, v;
+
+        s =3D src;
+        d =3D dst;
+        do {
+                v =3D (*s++ & mask) | (*d  & ~mask);
+                *d++ =3D v;
+#if BPL > 2
+                v =3D (*s++ & mask) | (*d  & ~mask);
+                *d++ =3D v;
+#endif
+#if BPL > 4
+                v =3D (*s++ & mask) | (*d  & ~mask);
+                *d++ =3D v;
+                v =3D (*s++ & mask) | (*d  & ~mask);
+                *d++ =3D v;
+#endif
+                d =3D (u32 *)((u8 *)d + bytes);
+                s =3D (u32 *)((u8 *)s + bytes);
+        } while (--h);
+}
+
+#endif
+
+#endif /* _VIDEO_ATAFB_UTILS_H */


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

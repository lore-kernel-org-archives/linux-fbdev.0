From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH 1/5]: logo fix
Date: 16 Feb 2003 14:08:39 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045375680.1823.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TvWOQOdmJkr2bot6g9dw"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kI0J-0005ZU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Feb 2003 22:10:19 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-TvWOQOdmJkr2bot6g9dw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch (linux-2.5.61 + James' fbdev.diff) fixes the following:

1. compile error because of missing scripts/pmntologo.  

2. Break up of fb_show_logo() to fb_prepare_logo()/fb_show_logo() to fix
weird "double drawing" or the "single draw, erase in a flash" of the
logo.

3. Fixed all drivers affected by the (image.depth == 0) is color
expansion.

Tony





--=-TvWOQOdmJkr2bot6g9dw
Content-Disposition: attachment; filename=logo1.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=logo1.diff; charset=ANSI_X3.4-1968

diff -Naur linux-2.5.61-fbdev/drivers/video/cfbimgblt.c linux-2.5.61-ad/dri=
vers/video/cfbimgblt.c
--- linux-2.5.61-fbdev/drivers/video/cfbimgblt.c	2003-02-16 00:55:52.000000=
000 +0000
+++ linux-2.5.61-ad/drivers/video/cfbimgblt.c	2003-02-16 03:53:39.000000000=
 +0000
@@ -113,7 +113,7 @@
 	int i, n, bpp =3D p->var.bits_per_pixel;
 	unsigned long null_bits =3D BITS_PER_LONG - bpp;
 	u32 *palette =3D (u32 *) p->pseudo_palette;
-	u8 *src =3D image->data;
+	u8 *src =3D (u8 *) image->data;
=20
 	dst2 =3D (unsigned long *) dst1;
 	for (i =3D image->height; i--; ) {
@@ -173,7 +173,7 @@
 	unsigned long *dst, *dst2, val, pitch =3D p->fix.line_length;
 	unsigned long null_bits =3D BITS_PER_LONG - bpp;
 	unsigned long spitch =3D (image->width+7)/8;
-	u8 *src =3D image->data, *s;
+	const char *src =3D image->data, *s;
 	unsigned long i, j, l;
 =09
 	dst2 =3D (unsigned long *) dst1;
@@ -246,7 +246,7 @@
 	u32 fgx =3D fgcolor, bgx =3D bgcolor, bpp =3D p->var.bits_per_pixel;
 	u32 ppw =3D BITS_PER_LONG/bpp, spitch =3D (image->width + 7)/8;
 	u32 bit_mask, end_mask, eorx, shift;
-	char *s =3D image->data, *src;
+	const char *s =3D image->data, *src;
 	unsigned long *dst;
 	u32 *tab =3D NULL;
 	int i, j, k;
@@ -328,7 +328,7 @@
 	if (p->fbops->fb_sync)
 		p->fbops->fb_sync(p);
=20
-	if (image->depth =3D=3D 1) {
+	if (image->depth =3D=3D 0) {
 		if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
 		    p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR) {
 			fgcolor =3D ((u32*)(p->pseudo_palette))[image->fg_color];
diff -Naur linux-2.5.61-fbdev/drivers/video/console/fbcon.c linux-2.5.61-ad=
/drivers/video/console/fbcon.c
--- linux-2.5.61-fbdev/drivers/video/console/fbcon.c	2003-02-16 00:55:52.00=
0000000 +0000
+++ linux-2.5.61-ad/drivers/video/console/fbcon.c	2003-02-16 03:53:21.00000=
0000 +0000
@@ -555,7 +555,7 @@
 	cursor.image.height =3D height;
 	cursor.image.dx =3D xx * width;
 	cursor.image.dy =3D yy * height;
-	cursor.image.depth =3D 1;
+	cursor.image.depth =3D 0;
 	cursor.image.data =3D image;
 	cursor.image.bg_color =3D bgcolor;
 	cursor.image.fg_color =3D fgcolor;
@@ -945,6 +945,7 @@
 		int cnt;
 		int step;
=20
+		logo_height =3D fb_prepare_logo(info);
 		logo_lines =3D (logo_height + vc->vc_font.height - 1) /
 			     vc->vc_font.height;
 		q =3D (unsigned short *) (vc->vc_origin +
@@ -1942,7 +1943,7 @@
 	if (logo_shown =3D=3D -2) {
 		logo_shown =3D fg_console;
 		/* This is protected above by initmem_freed */
-		logo_height =3D fb_show_logo(info);
+		fb_show_logo(info);
 		update_region(fg_console,
 			      vc->vc_origin + vc->vc_size_row * vc->vc_top,
 			      vc->vc_size_row * (vc->vc_bottom -
diff -Naur linux-2.5.61-fbdev/drivers/video/fbmem.c linux-2.5.61-ad/drivers=
/video/fbmem.c
--- linux-2.5.61-fbdev/drivers/video/fbmem.c	2003-02-16 00:55:52.000000000 =
+0000
+++ linux-2.5.61-ad/drivers/video/fbmem.c	2003-02-16 03:53:21.000000000 +00=
00
@@ -511,101 +511,121 @@
  * We isolate each bit and expand each into a byte. The "needs_logo" flag =
will
  * be set to 1.
  */
-int fb_show_logo(struct fb_info *info)
-{
-	unsigned char *fb =3D info->screen_base, *logo_new =3D NULL;
-	u32 *palette =3D NULL, *saved_pseudo_palette =3D NULL;
-	int needs_directpalette =3D 0;
-	int needs_truepalette =3D 0;
-	int needs_cmapreset =3D 0;
-	struct fb_image image;
-	const struct linux_logo *logo =3D 0;
+static struct logo_data {
+	int depth;
+	int needs_logo;
+	int needs_directpalette;
+	int needs_truepalette;
+	int needs_cmapreset;
 	int type;
-	int needs_logo =3D 0;
-	int done =3D 0, x;
-
-	/* Return if the frame buffer is not mapped */
-	if (!fb || !info->fbops->fb_imageblit)
-		return 0;
-
-	image.depth =3D info->var.bits_per_pixel;
+	const struct linux_logo *logo;
+} fb_logo;
=20
-	/* reasonable default */
-	if (image.depth >=3D 8)
-		type =3D LINUX_LOGO_CLUT224;
-	else if (image.depth >=3D 4)
-		type =3D LINUX_LOGO_VGA16;
-	else
-		type =3D LINUX_LOGO_MONO;
-
-	/* Return if no suitable logo was found */
-	logo =3D fb_find_logo(type);
-	if (!logo || logo->height > info->var.yres)
-		return 0;
+int fb_prepare_logo(struct fb_info *info)
+{
+	memset(&fb_logo, 0, sizeof(struct logo_data));
=20
-	image.data =3D logo->data;
+	fb_logo.depth =3D info->var.bits_per_pixel;
=20
 	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
-		needs_truepalette =3D 1;
-		if (image.depth >=3D 4 && image.depth <=3D 8)
-			needs_logo =3D 4;
-		else if (image.depth < 4)
-			needs_logo =3D 1;
+		if (fb_logo.depth >=3D 8) {
+			fb_logo.needs_truepalette =3D 1;
+			fb_logo.needs_logo =3D 8;
+		} else if (fb_logo.depth >=3D 4)
+			fb_logo.needs_logo =3D 4;
+		else=20
+			fb_logo.needs_logo =3D 1;
 		break;
 	case FB_VISUAL_DIRECTCOLOR:
-		if (image.depth >=3D 24) {
-			needs_directpalette =3D 1;
-			needs_cmapreset =3D 1;
+		if (fb_logo.depth >=3D 24) {
+			fb_logo.needs_directpalette =3D 1;
+			fb_logo.needs_cmapreset =3D 1;
+			fb_logo.needs_logo =3D 8;
 		}
 		/* 16 colors */
-		else if (image.depth >=3D 16)
-			needs_logo =3D 4;
+		else if (fb_logo.depth >=3D 16)
+			fb_logo.needs_logo =3D 4;
 		/* 2 colors */
 		else
-			needs_logo =3D 1;
+			fb_logo.needs_logo =3D 1;
 		break;
 	case FB_VISUAL_MONO01:
 		/* reversed 0 =3D fg, 1 =3D bg */
-		needs_logo =3D ~1;
+		fb_logo.needs_logo =3D ~1;
 		break;
 	case FB_VISUAL_MONO10:
-		needs_logo =3D 1;
+		fb_logo.needs_logo =3D 1;
 		break;
 	case FB_VISUAL_PSEUDOCOLOR:
 	default:
-		if (image.depth >=3D 8)
-			needs_cmapreset =3D 1;
+		if (fb_logo.depth >=3D 8) {
+			fb_logo.needs_cmapreset =3D 1;
+			fb_logo.needs_logo =3D 8;
+		}
 		/* fall through */
 	case FB_VISUAL_STATIC_PSEUDOCOLOR:
 		/* 16 colors */
-		if (image.depth >=3D 4 && image.depth < 8)
-			needs_logo =3D 4;
+		if (fb_logo.depth >=3D 4 && fb_logo.depth < 8)
+			fb_logo.needs_logo =3D 4;
 		/* 2 colors */
-		else if (image.depth < 4)
-			needs_logo =3D 1;
+		else if (fb_logo.depth < 4)
+			fb_logo.needs_logo =3D 1;
 		break;
 	}
=20
-	if (needs_cmapreset)
-		fb_set_logocmap(info, logo);
+	if (fb_logo.needs_logo >=3D 8)
+		fb_logo.type =3D LINUX_LOGO_CLUT224;
+	else if (fb_logo.needs_logo >=3D 4)
+		fb_logo.type =3D LINUX_LOGO_VGA16;
+	else
+		fb_logo.type =3D LINUX_LOGO_MONO;
+
+	/* Return if no suitable logo was found */
+	fb_logo.logo =3D fb_find_logo(fb_logo.type);
+	if (!fb_logo.logo || fb_logo.logo->height > info->var.yres) {
+		fb_logo.logo =3D NULL;
+		return 0;
+	}
+	return fb_logo.logo->height;
+}
+
+int fb_show_logo(struct fb_info *info)
+{
+	unsigned char *fb =3D info->screen_base, *logo_new =3D NULL;
+	u32 *palette =3D NULL, *saved_pseudo_palette =3D NULL;
+	struct fb_image image;
+	int x;
+
+	/* Return if the frame buffer is not mapped */
+	if (!fb || !info->fbops->fb_imageblit ||
+	    fb_logo.logo =3D=3D NULL)
+		return 0;
=20
-	if (needs_truepalette || needs_directpalette) {
+	image.depth =3D fb_logo.depth;
+	image.data =3D fb_logo.logo->data;
+
+	if (fb_logo.needs_cmapreset)
+		fb_set_logocmap(info, fb_logo.logo);
+
+	if (fb_logo.needs_truepalette ||=20
+	    fb_logo.needs_directpalette) {
 		palette =3D kmalloc(256 * 4, GFP_KERNEL);
 		if (palette =3D=3D NULL)
 			return 0;
=20
-		if (needs_truepalette)
-			fb_set_logo_truepalette(info, logo, palette);
+		if (fb_logo.needs_truepalette)
+			fb_set_logo_truepalette(info, fb_logo.logo, palette);
 		else
-			fb_set_logo_directpalette(info, logo, palette);
+			fb_set_logo_directpalette(info, fb_logo.logo, palette);
=20
 		saved_pseudo_palette =3D info->pseudo_palette;
 		info->pseudo_palette =3D palette;
 	}
=20
-	if (needs_logo) {
-		logo_new =3D kmalloc(logo->width * logo->height, GFP_KERNEL);
+	if (fb_logo.needs_logo !=3D 8) {
+		logo_new =3D kmalloc(fb_logo.logo->width * fb_logo.logo->height,=20
+				   GFP_KERNEL);
 		if (logo_new =3D=3D NULL) {
 			if (palette)
 				kfree(palette);
@@ -615,27 +635,26 @@
 		}
=20
 		image.data =3D logo_new;
-		fb_set_logo(info, logo, logo_new, needs_logo);
+		fb_set_logo(info, fb_logo.logo, logo_new, fb_logo.needs_logo);
 	}
=20
-	image.width =3D logo->width;
-	image.height =3D logo->height;
+	image.width =3D fb_logo.logo->width;
+	image.height =3D fb_logo.logo->height;
 	image.dy =3D 0;
=20
-	for (x =3D 0; x < num_online_cpus() * (logo->width + 8) &&
-	     x <=3D info->var.xres-logo->width; x +=3D (logo->width + 8)) {
+	for (x =3D 0; x < num_online_cpus() * (fb_logo.logo->width + 8) &&
+	     x <=3D info->var.xres-fb_logo.logo->width; x +=3D (fb_logo.logo->wid=
th + 8)) {
 		image.dx =3D x;
 		info->fbops->fb_imageblit(info, &image);
-		done =3D 1;
 	}
-
+=09
 	if (palette !=3D NULL)
 		kfree(palette);
 	if (saved_pseudo_palette !=3D NULL)
 		info->pseudo_palette =3D saved_pseudo_palette;
 	if (logo_new !=3D NULL)
 		kfree(logo_new);
-	return logo->height;
+	return fb_logo.logo->height;
 }
=20
 static int fbmem_read_proc(char *buf, char **start, off_t offset,
@@ -1212,6 +1231,7 @@
 EXPORT_SYMBOL(unregister_framebuffer);
 EXPORT_SYMBOL(num_registered_fb);
 EXPORT_SYMBOL(registered_fb);
+EXPORT_SYMBOL(fb_prepare_logo);
 EXPORT_SYMBOL(fb_show_logo);
 EXPORT_SYMBOL(fb_set_var);
 EXPORT_SYMBOL(fb_blank);
diff -Naur linux-2.5.61-fbdev/drivers/video/tdfxfb.c linux-2.5.61-ad/driver=
s/video/tdfxfb.c
--- linux-2.5.61-fbdev/drivers/video/tdfxfb.c	2003-02-16 00:55:53.000000000=
 +0000
+++ linux-2.5.61-ad/drivers/video/tdfxfb.c	2003-02-16 03:53:50.000000000 +0=
000
@@ -939,7 +939,7 @@
 	u8 *chardata =3D (u8 *) pixmap->data;
 	u32 srcfmt;
=20
-	if (pixmap->depth !=3D 1) {
+	if (pixmap->depth !=3D 0) {
 		//banshee_make_room(par, 6 + ((size + 3) >> 2));
 		//srcfmt =3D stride | ((bpp+((bpp=3D=3D8) ? 0 : 8)) << 13) | 0x400000;
 		cfb_imageblit(info, pixmap);
diff -Naur linux-2.5.61-fbdev/drivers/video/tgafb.c linux-2.5.61-ad/drivers=
/video/tgafb.c
--- linux-2.5.61-fbdev/drivers/video/tgafb.c	2003-02-16 00:48:32.000000000 =
+0000
+++ linux-2.5.61-ad/drivers/video/tgafb.c	2003-02-16 03:53:45.000000000 +00=
00
@@ -585,7 +585,7 @@
 	   can do better than the generic code.  */
 	/* ??? There is a DMA write mode; I wonder if that could be
 	   made to pull the data from the image buffer...  */
-	if (image->depth > 1) {
+	if (image->depth > 0) {
 		cfb_imageblit(info, image);
 		return;
 	}
diff -Naur linux-2.5.61-fbdev/include/linux/fb.h linux-2.5.61-ad/include/li=
nux/fb.h
--- linux-2.5.61-fbdev/include/linux/fb.h	2003-02-16 00:55:53.000000000 +00=
00
+++ linux-2.5.61-ad/include/linux/fb.h	2003-02-16 03:53:21.000000000 +0000
@@ -462,6 +462,7 @@
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
 extern int unregister_framebuffer(struct fb_info *fb_info);
+extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
diff -Naur linux-2.5.61-fbdev/scripts/Makefile linux-2.5.61-ad/scripts/Make=
file
--- linux-2.5.61-fbdev/scripts/Makefile	2003-02-16 02:10:09.000000000 +0000
+++ linux-2.5.61-ad/scripts/Makefile	2003-02-16 03:53:21.000000000 +0000
@@ -8,7 +8,7 @@
 # docproc: 	 Preprocess .tmpl file in order to generate .sgml documentatio=
n
 # conmakehash:	 Create arrays for initializing the kernel console tables
=20
-host-progs    :=3D fixdep split-include conmakehash docproc kallsyms
+host-progs    :=3D fixdep split-include conmakehash docproc kallsyms pnmto=
logo
 build-targets :=3D $(host-progs)
=20
 # Let clean descend into subdirs
diff -Naur linux-2.5.61-fbdev/scripts/pnmtologo.c linux-2.5.61-ad/scripts/p=
nmtologo.c
--- linux-2.5.61-fbdev/scripts/pnmtologo.c	1970-01-01 00:00:00.000000000 +0=
000
+++ linux-2.5.61-ad/scripts/pnmtologo.c	2003-02-16 03:53:21.000000000 +0000
@@ -0,0 +1,498 @@
+
+/*
+ *  Convert a logo in ASCII PNM format to C source suitable for inclusion =
in
+ *  the Linux kernel
+ *
+ *  (C) Copyright 2001-2003 by Geert Uytterhoeven <geert@linux-m68k.org>
+ *
+ *  ----------------------------------------------------------------------=
----
+ *
+ *  This file is subject to the terms and conditions of the GNU General Pu=
blic
+ *  License. See the file COPYING in the main directory of the Linux
+ *  distribution for more details.
+ */
+
+#include <ctype.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+
+static const char *programname;
+static const char *filename;
+static const char *logoname =3D "linux_logo";
+static const char *outputname;
+static FILE *out;
+
+
+#define LINUX_LOGO_MONO		1	/* monochrome black/white */
+#define LINUX_LOGO_VGA16	2	/* 16 colors VGA text palette */
+#define LINUX_LOGO_CLUT224	3	/* 224 colors */
+#define LINUX_LOGO_GRAY256	4	/* 256 levels grayscale */
+
+static const char *logo_types[LINUX_LOGO_GRAY256+1] =3D {
+    [LINUX_LOGO_MONO] =3D "LINUX_LOGO_MONO",
+    [LINUX_LOGO_VGA16] =3D "LINUX_LOGO_VGA16",
+    [LINUX_LOGO_CLUT224] =3D "LINUX_LOGO_CLUT224",
+    [LINUX_LOGO_GRAY256] =3D "LINUX_LOGO_GRAY256"
+};
+
+#define MAX_LINUX_LOGO_COLORS	224
+
+struct color {
+    unsigned char red;
+    unsigned char green;
+    unsigned char blue;
+};
+
+static const struct color clut_vga16[16] =3D {
+    { 0x00, 0x00, 0x00 },
+    { 0x00, 0x00, 0xaa },
+    { 0x00, 0xaa, 0x00 },
+    { 0x00, 0xaa, 0xaa },
+    { 0xaa, 0x00, 0x00 },
+    { 0xaa, 0x00, 0xaa },
+    { 0xaa, 0x55, 0x00 },
+    { 0xaa, 0xaa, 0xaa },
+    { 0x55, 0x55, 0x55 },
+    { 0x55, 0x55, 0xff },
+    { 0x55, 0xff, 0x55 },
+    { 0x55, 0xff, 0xff },
+    { 0xff, 0x55, 0x55 },
+    { 0xff, 0x55, 0xff },
+    { 0xff, 0xff, 0x55 },
+    { 0xff, 0xff, 0xff },
+};
+
+
+static int logo_type =3D LINUX_LOGO_CLUT224;
+static unsigned int logo_width;
+static unsigned int logo_height;
+static struct color **logo_data;
+static struct color logo_clut[MAX_LINUX_LOGO_COLORS];
+static unsigned int logo_clutsize =3D 0;
+
+static void die(const char *fmt, ...)
+    __attribute__ ((noreturn)) __attribute ((format (printf, 1, 2)));
+static void usage(void) __attribute ((noreturn));
+
+
+static unsigned int get_number(FILE *fp)
+{
+    int c, val;
+
+    /* Skip leading whitespace */
+    do {
+	c =3D fgetc(fp);
+	if (c =3D=3D EOF)
+	    die("%s: end of file\n", filename);
+	if (c =3D=3D '#') {
+	    /* Ignore comments 'till end of line */
+	    do {
+		c =3D fgetc(fp);
+		if (c =3D=3D EOF)
+		    die("%s: end of file\n", filename);
+	    } while (c !=3D '\n');
+	}
+    } while (isspace(c));
+
+    /* Parse decimal number */
+    val =3D 0;
+    while (isdigit(c)) {
+	val =3D 10*val+c-'0';
+	c =3D fgetc(fp);
+	if (c =3D=3D EOF)
+	    die("%s: end of file\n", filename);
+    }
+    return val;
+}
+
+static void read_image(void)
+{
+    FILE *fp;
+    int i, j, magic;
+    unsigned int maxval;
+
+    /* open image file */
+    fp =3D fopen(filename, "r");
+    if (!fp)
+	die("Cannot open file %s: %s\n", filename, strerror(errno));
+
+    /* check file type and read file header */
+    magic =3D fgetc(fp);
+    if (magic !=3D 'P')
+	die("%s is not a PNM file\n", filename);
+    magic =3D fgetc(fp);
+    switch (magic) {
+	case '1':
+	case '2':
+	case '3':
+	    /* Plain PBM/PGM/PPM */
+	    break;
+
+	case '4':
+	case '5':
+	case '6':
+	    /* Binary PBM/PGM/PPM */
+	    die("%s: Binary PNM is not supported.\n"
+		"Use pnmnoraw(1) to convert it to ASCII.\n", filename);
+
+	default:
+	    die("%s is not a PNM file\n", filename);
+    }
+    logo_width =3D get_number(fp);
+    logo_height =3D get_number(fp);
+
+    /* allocate image data */
+    logo_data =3D (struct color **)malloc(logo_height*sizeof(struct color =
*));
+    if (!logo_data)
+	die("%s\n", strerror(errno));
+    for (i =3D 0; i < logo_height; i++) {
+	logo_data[i] =3D malloc(logo_width*sizeof(struct color));
+	if (!logo_data[i])
+	    die("%s\n", strerror(errno));
+    }
+
+    /* read image data */
+    switch (magic) {
+	case '1':
+	    /* Plain PBM */
+	    for (i =3D 0; i < logo_height; i++)
+		for (j =3D 0; j < logo_width; j++)
+		    logo_data[i][j].red =3D logo_data[i][j].green =3D
+			logo_data[i][j].blue =3D 255*(1-get_number(fp));
+	    break;
+
+	case '2':
+	    /* Plain PGM */
+	    maxval =3D get_number(fp);
+	    for (i =3D 0; i < logo_height; i++)
+		for (j =3D 0; j < logo_width; j++)
+		    logo_data[i][j].red =3D logo_data[i][j].green =3D
+			logo_data[i][j].blue =3D 255*get_number(fp)/maxval;
+	    break;
+
+	case '3':
+	    /* Plain PPM */
+	    maxval =3D get_number(fp);
+	    for (i =3D 0; i < logo_height; i++)
+		for (j =3D 0; j < logo_width; j++) {
+		    logo_data[i][j].red =3D 255*get_number(fp)/maxval;
+		    logo_data[i][j].green =3D 255*get_number(fp)/maxval;
+		    logo_data[i][j].blue =3D 255*get_number(fp)/maxval;
+		}
+	    break;
+    }
+
+    /* close file */
+    fclose(fp);
+}
+
+static inline int is_black(struct color c)
+{
+    return c.red =3D=3D 0 && c.green =3D=3D 0 && c.blue =3D=3D 0;
+}
+
+static inline int is_white(struct color c)
+{
+    return c.red =3D=3D 255 && c.green =3D=3D 255 && c.blue =3D=3D 255;
+}
+
+static inline int is_gray(struct color c)
+{
+    return c.red =3D=3D c.green && c.red =3D=3D c.blue;
+}
+
+static inline int is_equal(struct color c1, struct color c2)
+{
+    return c1.red =3D=3D c2.red && c1.green =3D=3D c2.green && c1.blue =3D=
=3D c2.blue;
+}
+
+static void write_header(void)
+{
+    /* open logo file */
+    if (outputname) {
+	out =3D fopen(outputname, "w");
+	if (!out)
+	    die("Cannot create file %s: %s\n", outputname, strerror(errno));
+    } else {
+	out =3D stdout;
+    }
+
+    fputs("/*\n", out);
+    fputs(" *  DO NOT EDIT THIS FILE!\n", out);
+    fputs(" *\n", out);
+    fprintf(out, " *  It was automatically generated from %s\n", filename)=
;
+    fputs(" *\n", out);
+    fprintf(out, " *  Linux logo %s\n", logoname);
+    fputs(" */\n\n", out);
+    fputs("#include <linux/linux_logo.h>\n\n", out);
+    fprintf(out, "static const unsigned char %s_data[] __initdata =3D {\n"=
,
+	    logoname);
+}
+
+static void write_footer(void)
+{
+    fputs("\n};\n\n", out);
+    fprintf(out, "const struct linux_logo %s __initdata =3D {\n", logoname=
);
+    fprintf(out, "    .type\t=3D %s,\n", logo_types[logo_type]);
+    fprintf(out, "    .width\t=3D %d,\n", logo_width);
+    fprintf(out, "    .height\t=3D %d,\n", logo_height);
+    if (logo_type =3D=3D LINUX_LOGO_CLUT224) {
+	fprintf(out, "    .clutsize\t=3D %d,\n", logo_clutsize);
+	fprintf(out, "    .clut\t=3D %s_clut,\n", logoname);
+    }
+    fprintf(out, "    .data\t=3D %s_data\n", logoname);
+    fputs("};\n\n", out);
+
+    /* close logo file */
+    if (outputname)
+	fclose(out);
+}
+
+static int write_hex_cnt =3D 0;
+
+static void write_hex(unsigned char byte)
+{
+    if (write_hex_cnt % 12)
+	fprintf(out, ", 0x%02x", byte);
+    else if (write_hex_cnt)
+	fprintf(out, ",\n\t0x%02x", byte);
+    else
+	fprintf(out, "\t0x%02x", byte);
+    write_hex_cnt++;
+}
+
+static void write_logo_mono(void)
+{
+    int i, j;
+    unsigned char val, bit;
+
+    /* validate image */
+    for (i =3D 0; i < logo_height; i++)
+	for (j =3D 0; j < logo_width; j++)
+	    if (!is_black(logo_data[i][j]) && !is_white(logo_data[i][j]))
+		die("Image must be monochrome\n");
+
+    /* write file header */
+    write_header();
+
+    /* write logo data */
+    for (i =3D 0; i < logo_height; i++) {
+	for (j =3D 0; j < logo_width;) {
+	    for (val =3D 0, bit =3D 0x80; bit && j < logo_width; j++, bit >>=3D 1=
)
+		if (logo_data[i][j].red)
+		    val |=3D bit;
+	    write_hex(val);
+	}
+    }
+
+    /* write logo structure and file footer */
+    write_footer();
+}
+
+static void write_logo_vga16(void)
+{
+    int i, j, k;
+    unsigned char val;
+
+    /* validate image */
+    for (i =3D 0; i < logo_height; i++)
+	for (j =3D 0; j < logo_width; j++) {
+	    for (k =3D 0; k < 16; k++)
+		if (is_equal(logo_data[i][j], clut_vga16[k]))
+		    break;
+	    if (k =3D=3D 16)
+		die("Image must use the 16 console colors only\n");
+	}
+
+    /* write file header */
+    write_header();
+
+    /* write logo data */
+    for (i =3D 0; i < logo_height; i++)
+	for (j =3D 0; j < logo_width; j++) {
+	    for (k =3D 0; k < 16; k++)
+		if (is_equal(logo_data[i][j], clut_vga16[k]))
+		    break;
+	    val =3D k<<4;
+	    if (++j < logo_width) {
+		for (k =3D 0; k < 16; k++)
+		    if (is_equal(logo_data[i][j], clut_vga16[k]))
+			break;
+		val |=3D k;
+	    }
+	    write_hex(val);
+	}
+
+    /* write logo structure and file footer */
+    write_footer();
+}
+
+static void write_logo_clut224(void)
+{
+    int i, j, k;
+
+    /* validate image */
+    for (i =3D 0; i < logo_height; i++)
+	for (j =3D 0; j < logo_width; j++) {
+	    for (k =3D 0; k < logo_clutsize; k++)
+		if (is_equal(logo_data[i][j], logo_clut[k]))
+		    break;
+	    if (k =3D=3D logo_clutsize) {
+		if (logo_clutsize =3D=3D MAX_LINUX_LOGO_COLORS)
+		    die("Image has more than %d colors\n",
+			MAX_LINUX_LOGO_COLORS);
+		logo_clut[logo_clutsize++] =3D logo_data[i][j];
+	    }
+	}
+
+    /* write file header */
+    write_header();
+
+    /* write logo data */
+    for (i =3D 0; i < logo_height; i++)
+	for (j =3D 0; j < logo_width; j++) {
+	    for (k =3D 0; k < logo_clutsize; k++)
+		if (is_equal(logo_data[i][j], logo_clut[k]))
+		    break;
+	    write_hex(k+32);
+	}
+    fputs("\n};\n\n", out);
+
+    /* write logo clut */
+    fprintf(out, "static const unsigned char %s_clut[] __initdata =3D {\n"=
,
+	    logoname);
+    write_hex_cnt =3D 0;
+    for (i =3D 0; i < logo_clutsize; i++) {
+	write_hex(logo_clut[i].red);
+	write_hex(logo_clut[i].green);
+	write_hex(logo_clut[i].blue);
+    }
+
+    /* write logo structure and file footer */
+    write_footer();
+}
+
+static void write_logo_gray256(void)
+{
+    int i, j;
+
+    /* validate image */
+    for (i =3D 0; i < logo_height; i++)
+	for (j =3D 0; j < logo_width; j++)
+	    if (!is_gray(logo_data[i][j]))
+		die("Image must be grayscale\n");
+
+    /* write file header */
+    write_header();
+
+    /* write logo data */
+    for (i =3D 0; i < logo_height; i++)
+	for (j =3D 0; j < logo_width; j++)
+	    write_hex(logo_data[i][j].red);
+
+    /* write logo structure and file footer */
+    write_footer();
+}
+
+static void die(const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    vfprintf(stderr, fmt, ap);
+    va_end(ap);
+
+    exit(1);
+}
+
+static void usage(void)
+{
+    die("\n"
+	"Usage: %s [options] <filename>\n"
+	"\n"
+	"Valid options:\n"
+	"    -h          : display this usage information\n"
+	"    -n <name>   : specify logo name (default: linux_logo)\n"
+	"    -o <output> : output to file <output> instead of stdout\n"
+	"    -t <type>   : specify logo type, one of\n"
+	"                      mono    : monochrome black/white\n"
+	"                      vga16   : 16 colors VGA text palette\n"
+	"                      clut224 : 224 colors (default)\n"
+	"                      gray256 : 256 levels grayscale\n"
+	"\n", programname);
+}
+
+int main(int argc, char *argv[])
+{
+    int opt;
+
+    programname =3D argv[0];
+
+    opterr =3D 0;
+    while (1) {
+	opt =3D getopt(argc, argv, "hn:o:t:");
+	if (opt =3D=3D -1)
+	    break;
+
+	switch (opt) {
+	    case 'h':
+		usage();
+		break;
+
+	    case 'n':
+		logoname =3D optarg;
+		break;
+
+	    case 'o':
+		outputname =3D optarg;
+		break;
+
+	    case 't':
+		if (!strcmp(optarg, "mono"))
+		    logo_type =3D LINUX_LOGO_MONO;
+		else if (!strcmp(optarg, "vga16"))
+		    logo_type =3D LINUX_LOGO_VGA16;
+		else if (!strcmp(optarg, "clut224"))
+		    logo_type =3D LINUX_LOGO_CLUT224;
+		else if (!strcmp(optarg, "gray256"))
+		    logo_type =3D LINUX_LOGO_GRAY256;
+		else
+		    usage();
+		break;
+
+	    default:
+		usage();
+		break;
+	}
+    }
+    if (optind !=3D argc-1)
+	usage();
+
+    filename =3D argv[optind];
+
+    read_image();
+    switch (logo_type) {
+	case LINUX_LOGO_MONO:
+	    write_logo_mono();
+	    break;
+
+	case LINUX_LOGO_VGA16:
+	    write_logo_vga16();
+	    break;
+
+	case LINUX_LOGO_CLUT224:
+	    write_logo_clut224();
+	    break;
+
+	case LINUX_LOGO_GRAY256:
+	    write_logo_gray256();
+	    break;
+    }
+    exit(0);
+}
+

--=-TvWOQOdmJkr2bot6g9dw--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

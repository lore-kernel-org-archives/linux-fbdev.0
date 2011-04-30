From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 30 Apr 2011 14:43:23 +0000
Subject: fbdev test application
Message-Id: <201104301643.23482.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi everybody,

I've developed a small fbdev application for internal test purpose that mig=
ht
be useful to other developers, so I'm releasing it under the GPL.

The code can be found in a git repository at
http://git.ideasonboard.org/?p=FBdev-test.git;a=3Dsummary. I'm also adding =
the
initial patch to this e-mail, in case someone would like to review the
code :-)

diff -Nur a/fbdev.c b/fbdev.c
--- a/fbdev.c	1970-01-01 01:00:00.000000000 +0100
+++ b/fbdev.c	2011-04-29 17:04:03.000000000 +0200
@@ -0,0 +1,1062 @@
+/*
+ * fbdev -- Frame buffer device test application
+ *
+ * Copyright (C) 2011 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/time.h>
+
+#include <linux/fb.h>
+
+#define ARRAY_SIZE(a)	(sizeof(a)/sizeof((a)[0]))
+
+struct device {
+	int fd;
+	void *mem;
+
+	struct fb_fix_screeninfo fix_info;
+	struct fb_var_screeninfo var_info;
+};
+
+enum fb_fill_mode {
+	FB_FILL_NONE =3D 0,
+	FB_FILL_DISPLAY =3D 1,
+	FB_FILL_VIRTUAL =3D 2,
+};
+
+/* -----------------------------------------------------------------------=
------
+ * FB information display
+ */
+
+struct fb_value_name {
+	unsigned int value;
+	const char *name;
+};
+
+static const struct fb_value_name fb_type_names[] =3D {
+	{ FB_TYPE_PACKED_PIXELS, "Packed Pixels" },
+	{ FB_TYPE_PLANES, "Non Interleaved Planes" },
+	{ FB_TYPE_INTERLEAVED_PLANES, "Interleaved Planes" },
+	{ FB_TYPE_TEXT, "Text/Attributes" },
+	{ FB_TYPE_VGA_PLANES, "EGA/VGA Planes" },
+};
+
+static const struct fb_value_name fb_visual_names[] =3D {
+	{ FB_VISUAL_MONO01, "Monochrome (white 0, black 1)" },
+	{ FB_VISUAL_MONO10, "Monochrome (white 1, black 0)" },
+	{ FB_VISUAL_TRUECOLOR, "True Color" },
+	{ FB_VISUAL_PSEUDOCOLOR, "Pseudo Color" },
+	{ FB_VISUAL_DIRECTCOLOR, "Direct Color" },
+	{ FB_VISUAL_STATIC_PSEUDOCOLOR, "Pseudo Color (read-only)" },
+};
+
+static const struct fb_value_name fb_accel_names[] =3D {
+	{ FB_ACCEL_NONE, "no hardware accelerator" },
+	{ FB_ACCEL_ATARIBLITT, "Atari Blitter" },
+	{ FB_ACCEL_AMIGABLITT, "Amiga Blitter" },
+	{ FB_ACCEL_S3_TRIO64, "Cybervision64 (S3 Trio64)" },
+	{ FB_ACCEL_NCR_77C32BLT, "RetinaZ3 (NCR 77C32BLT)" },
+	{ FB_ACCEL_S3_VIRGE, "Cybervision64/3D (S3 ViRGE)" },
+	{ FB_ACCEL_ATI_MACH64GX, "ATI Mach 64GX family" },
+	{ FB_ACCEL_DEC_TGA, "DEC 21030 TGA" },
+	{ FB_ACCEL_ATI_MACH64CT, "ATI Mach 64CT family" },
+	{ FB_ACCEL_ATI_MACH64VT, "ATI Mach 64CT family VT class" },
+	{ FB_ACCEL_ATI_MACH64GT, "ATI Mach 64CT family GT class" },
+	{ FB_ACCEL_SUN_CREATOR, "Sun Creator/Creator3D" },
+	{ FB_ACCEL_SUN_CGSIX, "Sun cg6" },
+	{ FB_ACCEL_SUN_LEO, "Sun leo/zx" },
+	{ FB_ACCEL_IMS_TWINTURBO, "IMS Twin Turbo" },
+	{ FB_ACCEL_3DLABS_PERMEDIA2, "3Dlabs Permedia 2" },
+	{ FB_ACCEL_MATROX_MGA2064W, "Matrox MGA2064W (Millenium)" },
+	{ FB_ACCEL_MATROX_MGA1064SG, "Matrox MGA1064SG (Mystique)" },
+	{ FB_ACCEL_MATROX_MGA2164W, "Matrox MGA2164W (Millenium II)" },
+	{ FB_ACCEL_MATROX_MGA2164W_AGP, "Matrox MGA2164W (Millenium II)" },
+	{ FB_ACCEL_MATROX_MGAG100, "Matrox G100 (Productiva G100)" },
+	{ FB_ACCEL_MATROX_MGAG200, "Matrox G200 (Myst, Mill, ...)" },
+	{ FB_ACCEL_SUN_CG14, "Sun cgfourteen" },
+	{ FB_ACCEL_SUN_BWTWO, "Sun bwtwo" },
+	{ FB_ACCEL_SUN_CGTHREE, "Sun cgthree" },
+	{ FB_ACCEL_SUN_TCX, "Sun tcx" },
+	{ FB_ACCEL_MATROX_MGAG400, "Matrox G400" },
+	{ FB_ACCEL_NV3, "nVidia RIVA 128" },
+	{ FB_ACCEL_NV4, "nVidia RIVA TNT" },
+	{ FB_ACCEL_NV5, "nVidia RIVA TNT2" },
+	{ FB_ACCEL_CT_6555x, "C&T 6555x" },
+	{ FB_ACCEL_3DFX_BANSHEE, "3Dfx Banshee" },
+	{ FB_ACCEL_ATI_RAGE128, "ATI Rage128 family" },
+	{ FB_ACCEL_IGS_CYBER2000, "CyberPro 2000" },
+	{ FB_ACCEL_IGS_CYBER2010, "CyberPro 2010" },
+	{ FB_ACCEL_IGS_CYBER5000, "CyberPro 5000" },
+	{ FB_ACCEL_SIS_GLAMOUR, "SiS 300/630/540" },
+	{ FB_ACCEL_3DLABS_PERMEDIA3, "3Dlabs Permedia 3" },
+	{ FB_ACCEL_ATI_RADEON, "ATI Radeon family" },
+	{ FB_ACCEL_I810, "Intel 810/815" },
+	{ FB_ACCEL_SIS_GLAMOUR_2, "SiS 315, 650, 740" },
+	{ FB_ACCEL_SIS_XABRE, "SiS 330 (\"Xabre\")" },
+	{ FB_ACCEL_I830, "Intel 830M/845G/85x/865G" },
+	{ FB_ACCEL_NV_10, "nVidia Arch 10" },
+	{ FB_ACCEL_NV_20, "nVidia Arch 20" },
+	{ FB_ACCEL_NV_30, "nVidia Arch 30" },
+	{ FB_ACCEL_NV_40, "nVidia Arch 40" },
+	{ FB_ACCEL_XGI_VOLARI_V, "XGI Volari V3XT, V5, V8" },
+	{ FB_ACCEL_XGI_VOLARI_Z, "XGI Volari Z7" },
+	{ FB_ACCEL_OMAP1610, "TI OMAP16xx" },
+	{ FB_ACCEL_TRIDENT_TGUI, "Trident TGUI" },
+	{ FB_ACCEL_TRIDENT_3DIMAGE, "Trident 3DImage" },
+	{ FB_ACCEL_TRIDENT_BLADE3D, "Trident Blade3D" },
+	{ FB_ACCEL_TRIDENT_BLADEXP, "Trident BladeXP" },
+	{ FB_ACCEL_CIRRUS_ALPINE, "Cirrus Logic 543x/544x/5480" },
+	{ FB_ACCEL_NEOMAGIC_NM2070, "NeoMagic NM2070" },
+	{ FB_ACCEL_NEOMAGIC_NM2090, "NeoMagic NM2090" },
+	{ FB_ACCEL_NEOMAGIC_NM2093, "NeoMagic NM2093" },
+	{ FB_ACCEL_NEOMAGIC_NM2097, "NeoMagic NM2097" },
+	{ FB_ACCEL_NEOMAGIC_NM2160, "NeoMagic NM2160" },
+	{ FB_ACCEL_NEOMAGIC_NM2200, "NeoMagic NM2200" },
+	{ FB_ACCEL_NEOMAGIC_NM2230, "NeoMagic NM2230" },
+	{ FB_ACCEL_NEOMAGIC_NM2360, "NeoMagic NM2360" },
+	{ FB_ACCEL_NEOMAGIC_NM2380, "NeoMagic NM2380" },
+	{ FB_ACCEL_SAVAGE4, "S3 Savage4" },
+	{ FB_ACCEL_SAVAGE3D, "S3 Savage3D" },
+	{ FB_ACCEL_SAVAGE3D_MV, "S3 Savage3D-MV" },
+	{ FB_ACCEL_SAVAGE2000, "S3 Savage2000" },
+	{ FB_ACCEL_SAVAGE_MX_MV, "S3 Savage/MX-MV" },
+	{ FB_ACCEL_SAVAGE_MX, "S3 Savage/MX" },
+	{ FB_ACCEL_SAVAGE_IX_MV, "S3 Savage/IX-MV" },
+	{ FB_ACCEL_SAVAGE_IX, "S3 Savage/IX" },
+	{ FB_ACCEL_PROSAVAGE_PM, "S3 ProSavage PM133" },
+	{ FB_ACCEL_PROSAVAGE_KM, "S3 ProSavage KM133" },
+	{ FB_ACCEL_S3TWISTER_P, "S3 Twister" },
+	{ FB_ACCEL_S3TWISTER_K, "S3 TwisterK" },
+	{ FB_ACCEL_SUPERSAVAGE, "S3 Supersavage" },
+	{ FB_ACCEL_PROSAVAGE_DDR, "S3 ProSavage DDR" },
+	{ FB_ACCEL_PROSAVAGE_DDRK, "S3 ProSavage DDR-K" },
+};
+
+static const char *fb_value_name(const struct fb_value_name *names,
+				 unsigned int size, unsigned int value)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < size; ++i) {
+		if (names[i].value =3D value)
+			return names[i].name;
+	}
+
+	return "Unknown";
+}
+
+static const char *fb_type_name(unsigned int type)
+{
+	return fb_value_name(fb_type_names, ARRAY_SIZE(fb_type_names), type);
+}
+
+static const char *fb_visual_name(unsigned int visual)
+{
+	return fb_value_name(fb_visual_names, ARRAY_SIZE(fb_visual_names), visual=
);
+}
+
+static const char *fb_accel_name(unsigned int accel)
+{
+	return fb_value_name(fb_accel_names, ARRAY_SIZE(fb_accel_names), accel);
+}
+
+/*
+ * fb_print_fix - Print fixed screen information
+ * @dev: FB device
+ * @var: fixed screen information
+ */
+static void fb_print_fix(struct device *dev __attribute__((__unused__)),
+			 struct fb_fix_screeninfo *fix)
+{
+	printf("--- Fixed screen info ---\n");
+	printf(" Type:\t\t%s\n", fb_type_name(fix->type));
+	printf(" Visual:\t%s\n", fb_visual_name(fix->visual));
+	printf(" Chip/card:\t%s\n", fb_accel_name(fix->accel));
+
+	printf(" Memory:\t%u bytes @0x%08lx\n", fix->smem_len,
+		fix->smem_start);
+
+	if (fix->xpanstep =3D 0)
+		printf(" X Pan:\t\tUnsupported\n");
+	else
+		printf(" X Pan Step:\t%u\n", fix->xpanstep);
+
+	if (fix->ypanstep =3D 0)
+		printf(" Y Pan:\t\tUnsupported\n");
+	else
+		printf(" Y Pan Step:\t%u\n", fix->ypanstep);
+
+	printf(" Line Length:\t%u bytes\n", fix->line_length);
+}
+
+/*
+ * fb_print_var - Print fixed screen information
+ * @dev: FB device
+ * @var: variable screen information
+ */
+static void fb_print_var(struct device *dev, struct fb_var_screeninfo *var)
+{
+	unsigned int i;
+
+	printf("--- Variable screen info ---\n");
+	printf(" Resolution:\t\t%ux%u\n", var->xres, var->yres);
+	printf(" Virtual Resolution:\t%ux%u\n", var->xres_virtual,
+		var->yres_virtual);
+	printf(" X/Y Offset:\t\t(%u,%u)\n", var->xoffset, var->yoffset);
+	printf(" Size:\t\t\t%umm x %umm\n", var->width, var->height);
+
+	if (dev->fix_info.visual =3D FB_VISUAL_TRUECOLOR) {
+		printf(" Pixel organization:\t");
+		for (i =3D var->bits_per_pixel - 1; i < var->bits_per_pixel; --i) {
+			if (var->red.offset <=3D i && var->red.offset + var->red.length > i)
+				printf("R");
+			else if (var->green.offset <=3D i && var->green.offset + var->green.len=
gth > i)
+				printf("G");
+			else if (var->blue.offset <=3D i && var->blue.offset + var->green.lengt=
h > i)
+				printf("B");
+			else if (var->transp.offset <=3D i && var->transp.offset + var->transp.=
length > i)
+				printf("A");
+		}
+		printf("\n  (%u bits per pixel)\t", var->bits_per_pixel);
+		for (i =3D var->bits_per_pixel - 1; i < var->bits_per_pixel; --i) {
+			if (var->red.offset <=3D i &&
+			    var->red.offset + var->red.length > i)
+				printf("%u", var->red.msb_right ?
+					var->red.offset + var->red.length - 1 - i :
+					i - var->red.offset);
+			else if (var->green.offset <=3D i &&
+				 var->green.offset + var->green.length > i)
+				printf("%u", var->green.msb_right ?
+					var->green.offset + var->green.length - 1 - i :
+					i - var->green.offset);
+			else if (var->blue.offset <=3D i &&
+				 var->blue.offset + var->green.length > i)
+				printf("%u", var->blue.msb_right ?
+					var->blue.offset + var->blue.length - 1 - i :
+					i - var->blue.offset);
+			else if (var->transp.offset <=3D i &&
+				 var->transp.offset + var->transp.length > i)
+				printf("%u", var->transp.msb_right ?
+					var->transp.offset + var->transp.length - 1 - i :
+					i - var->transp.offset);
+		}
+		printf("\n");
+	}
+}
+
+/* -----------------------------------------------------------------------=
------
+ * Memory mapping
+ */
+
+/*
+ * fb_map_memory - Map the frame buffer memory to userspace
+ * @dev: FB device
+ */
+static int fb_map_memory(struct device *dev)
+{
+	void *mem;
+
+	mem =3D mmap(NULL, dev->fix_info.smem_len, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, dev->fd, 0);
+	if (mem =3D MAP_FAILED) {
+		printf("Error: FB memory map failed: %s (%d)\n",
+			strerror(errno), errno);
+		return -1;
+	}
+
+	dev->mem =3D mem;
+	return 0;
+}
+
+/*
+ * fb_unmap_memory - Unmap the frame buffer memory from userspace
+ * @dev: FB device
+ */
+static void fb_unmap_memory(struct device *dev)
+{
+	if (dev->mem =3D MAP_FAILED)
+		return;
+
+	munmap(dev->mem, dev->fix_info.smem_len);
+}
+
+/* -----------------------------------------------------------------------=
------
+ * Open/close
+ */
+
+/*
+ * fb_open - Open a frame buffer device
+ * @dev: FB device
+ * @devname: FB device node name and path
+ *
+ * Open the FB devide referenced by devname. Retrieve fixed and variable s=
creen
+ * information, map the frame buffer memory and fill the dev structure.
+ */
+static int fb_open(struct device *dev, const char *devname)
+{
+	int ret;
+
+	memset(dev, 0, sizeof *dev);
+	dev->fd =3D -1;
+	dev->mem =3D MAP_FAILED;
+
+	dev->fd =3D open(devname, O_RDWR);
+	if (dev->fd < 0) {
+		printf("Error opening device %s: %d.\n", devname, errno);
+		return dev->fd;
+	}
+
+	ret =3D ioctl(dev->fd, FBIOGET_FSCREENINFO, &dev->fix_info);
+	if (ret < 0) {
+		printf("Error opening device %s: unable to get fixed screen "
+			"info.\n", devname);
+		close(dev->fd);
+		return ret;
+	}
+
+	ret =3D ioctl(dev->fd, FBIOGET_VSCREENINFO, &dev->var_info);
+	if (ret < 0) {
+		printf("Error opening device %s: unable to get variable screen "
+			"info.\n", devname);
+		close(dev->fd);
+		return ret;
+	}
+
+	printf("Device %s opened: %s\n\n", devname, dev->fix_info.id);
+	fb_print_fix(dev, &dev->fix_info);
+	printf("\n");
+	fb_print_var(dev, &dev->var_info);
+	printf("\n");
+
+	ret =3D fb_map_memory(dev);
+	if (ret < 0) {
+		close(dev->fd);
+		return ret;
+	}
+
+	printf("FB memory mapped at %p\n", dev->mem);
+	return 0;
+}
+
+/*
+ * fb_close - Close a frame buffer device
+ * @dev: FB device
+ *
+ * Close a frame buffer device previously opened by fb_open().
+ */
+static void fb_close(struct device *dev)
+{
+	fb_unmap_memory(dev);
+	close(dev->fd);
+}
+
+/* -----------------------------------------------------------------------=
------
+ * Blanking and sync
+ */
+
+/*
+ * fb_blank - Control screen blanking
+ * @dev: FB device
+ * @blank: Blanking state
+ *
+ * Set the frame buffer screen blanking state. Acceptable values for the b=
lank
+ * parameter are
+ *
+ * FB_BLANK_UNBLANK		Blanking off, screen active
+ * FB_BLANK_NORMAL		Blanked, HSync on,  VSync on
+ * FB_BLANK_VSYNC_SUSPEND	Blanked, HSync on,  VSync off
+ * FB_BLANK_HSYNC_SUSPEND	Blanked, HSync off, VSync on
+ * FB_BLANK_POWERDOWN		Blanked, HSync off, VSync off
+ */
+static int fb_blank(struct device *dev, int blank)
+{
+	int ret;
+
+	ret =3D ioctl(dev->fd, FBIOBLANK, blank);
+	if (ret < 0) {
+		printf("Error: blank failed: %s (%d)\n", strerror(errno), errno);
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * fb_wait_for_vsync - Wait for vsync
+ * @dev: FB device
+ * @screen: Screen number
+ *
+ * Unblank the screen to make sure vsync events are generated and wait for=
 1000
+ * 1000 vsync events on the given screen. Print the average refresh rate w=
hen
+ * done.
+ */
+static int fb_wait_for_vsync(struct device *dev, unsigned int screen)
+{
+	struct timespec start, end;
+	unsigned int i;
+	double fps;
+	int ret;
+
+	/* Can't wait for vsync if the displayed is blanked. */
+	fb_blank(dev, FB_BLANK_UNBLANK);
+
+	printf("waiting for 1000 vsync events... ");
+	fflush(stdout);
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
+	for (i =3D 0; i < 1000; ++i) {
+		ret =3D ioctl(dev->fd, FBIO_WAITFORVSYNC, &screen);
+		if (ret < 0) {
+			printf("\nError: wait for vsync failed: %s (%d)\n",
+				strerror(errno), errno);
+			return ret;
+		}
+	}
+
+	clock_gettime(CLOCK_MONOTONIC, &end);
+
+	end.tv_sec -=3D start.tv_sec;
+	end.tv_nsec -=3D start.tv_nsec;
+	if (end.tv_nsec < 0) {
+		end.tv_sec--;
+		end.tv_nsec +=3D 1000000000;
+	}
+
+	fps =3D i / (end.tv_sec + end.tv_nsec / 1000000000.);
+
+	printf("done\n");
+	printf("%u vsync interrupts in %lu.%06lu s, %f Hz\n",
+		i, end.tv_sec, end.tv_nsec / 1000, fps);
+
+	return 0;
+}
+
+/* -----------------------------------------------------------------------=
------
+ * Resolution and pan
+ */
+
+/*
+ * fb_set_format - Set the frame buffer pixel format
+ * @dev: FB device
+ * @bpp: Bits per pixel
+ */
+static int fb_set_format(struct device *dev, unsigned int bpp)
+{
+	struct fb_var_screeninfo var_info;
+	int ret;
+
+	var_info =3D dev->var_info;
+
+	var_info.bits_per_pixel =3D bpp;
+	var_info.activate =3D FB_ACTIVATE_NOW;
+
+	ret =3D ioctl(dev->fd, FBIOPUT_VSCREENINFO, &var_info);
+	if (ret < 0) {
+		printf("Error: set format failed: %s (%d)\n",
+			strerror(errno), errno);
+		return ret;
+	}
+
+	dev->var_info =3D var_info;
+
+	printf("Format set to %u bits per pixel\n\n",
+		var_info.bits_per_pixel);
+
+	fb_print_var(dev, &var_info);
+
+	return 0;
+}
+
+/*
+ * fb_set_resolution - Set the frame buffer real and virtual resolutions
+ * @dev: FB device
+ * @xres: Horizontal resolution
+ * @yres: Vertical resolution
+ * @xres_virtual: Horizontal virtual resolution
+ * @yres_virtual: Vertical virtual resolution
+ *
+ * Modify the real and virtual resolutions of the frame buffer to (xres, y=
res)
+ * and (xres_virtual, yres_virtual). The real or virtual resolution can be=
 kept
+ * unchanged by setting its value to (-1, -1).
+ */
+static int fb_set_resolution(struct device *dev, int xres, int yres,
+			     int xres_virtual, int yres_virtual)
+{
+	struct fb_var_screeninfo var_info;
+	int ret;
+
+	var_info =3D dev->var_info;
+
+	if (xres !=3D -1 && yres !=3D -1 ) {
+		var_info.xres =3D xres;
+		var_info.yres =3D yres;
+	}
+
+	if (xres_virtual !=3D -1 && yres_virtual !=3D -1 ) {
+		var_info.xres_virtual =3D xres_virtual;
+		var_info.yres_virtual =3D yres_virtual;
+	}
+
+	printf("Setting resolution to %ux%u (virtual %ux%u)\n",
+		var_info.xres, var_info.yres,
+		var_info.xres_virtual, var_info.yres_virtual);
+
+	var_info.bits_per_pixel =3D 16;
+	var_info.activate =3D FB_ACTIVATE_NOW;
+
+	ret =3D ioctl(dev->fd, FBIOPUT_VSCREENINFO, &var_info);
+	if (ret < 0) {
+		printf("Error: set resolution failed: %s (%d)\n",
+			strerror(errno), errno);
+		return ret;
+	}
+
+	dev->var_info =3D var_info;
+
+	printf("Resolution set to %ux%u (virtual %ux%u)\n\n",
+		var_info.xres, var_info.yres,
+		var_info.xres_virtual, var_info.yres_virtual);
+
+	fb_print_var(dev, &var_info);
+
+	return 0;
+}
+
+/*
+ * fb_pan - Pan the display
+ * @dev: FB device
+ * @x: Horizontal offset
+ * @y: Vertical offset
+ *
+ * Pan the display to set the virtual point (x, y) on the top left corner =
of the
+ * screen.
+ */
+static int fb_pan(struct device *dev, unsigned int x, unsigned int y)
+{
+	struct fb_var_screeninfo var_info;
+	int ret;
+
+	memset(&var_info, 0, sizeof var_info);
+	var_info.xoffset =3D x;
+	var_info.yoffset =3D y;
+
+	ret =3D ioctl(dev->fd, FBIOPAN_DISPLAY, &var_info);
+	if (ret < 0) {
+		printf("Error: pan failed: %s (%d)\n", strerror(errno), errno);
+		return ret;
+	}
+
+	dev->var_info.xoffset =3D var_info.xoffset;
+	dev->var_info.yoffset =3D var_info.yoffset;
+
+	return 0;
+}
+
+/* -----------------------------------------------------------------------=
------
+ * Test pattern
+ */
+
+#define FB_MAKE_COLOR(var, r, g, b) \
+	((((r) >> (8 - (var)->red.length)) << (var)->red.offset) | \
+	 (((g) >> (8 - (var)->green.length)) << (var)->green.offset) | \
+	 (((b) >> (8 - (var)->blue.length)) << (var)->blue.offset))
+
+static void
+fb_fill_rgb16(struct device *dev, unsigned int xoffset, unsigned int yoffs=
et,
+	      unsigned int xres, unsigned int yres)
+{
+	const uint16_t colors_top[] =3D {
+		FB_MAKE_COLOR(&dev->var_info, 192, 192, 192),	/* grey */
+		FB_MAKE_COLOR(&dev->var_info, 192, 192, 0),	/* yellow */
+		FB_MAKE_COLOR(&dev->var_info, 0, 192, 192),	/* cyan */
+		FB_MAKE_COLOR(&dev->var_info, 0, 192, 0),	/* green */
+		FB_MAKE_COLOR(&dev->var_info, 192, 0, 192),	/* magenta */
+		FB_MAKE_COLOR(&dev->var_info, 192, 0, 0),	/* red */
+		FB_MAKE_COLOR(&dev->var_info, 0, 0, 192),	/* blue */
+	};
+	const uint16_t colors_middle[] =3D {
+		FB_MAKE_COLOR(&dev->var_info, 0, 0, 192),	/* blue */
+		FB_MAKE_COLOR(&dev->var_info, 19, 19, 19),	/* black */
+		FB_MAKE_COLOR(&dev->var_info, 192, 0, 192),	/* magenta */
+		FB_MAKE_COLOR(&dev->var_info, 19, 19, 19),	/* black */
+		FB_MAKE_COLOR(&dev->var_info, 0, 192, 192),	/* cyan */
+		FB_MAKE_COLOR(&dev->var_info, 19, 19, 19),	/* black */
+		FB_MAKE_COLOR(&dev->var_info, 192, 192, 192),	/* grey */
+	};
+	const uint16_t colors_bottom[] =3D {
+		FB_MAKE_COLOR(&dev->var_info, 0, 33, 76),	/* in-phase */
+		FB_MAKE_COLOR(&dev->var_info, 255, 255, 255),	/* super white */
+		FB_MAKE_COLOR(&dev->var_info, 50, 0, 106),	/* quadrature */
+		FB_MAKE_COLOR(&dev->var_info, 19, 19, 19),	/* black */
+		FB_MAKE_COLOR(&dev->var_info, 9, 9, 9),		/* 3.5% */
+		FB_MAKE_COLOR(&dev->var_info, 19, 19, 19),	/* 7.5% */
+		FB_MAKE_COLOR(&dev->var_info, 29, 29, 29),	/* 11.5% */
+		FB_MAKE_COLOR(&dev->var_info, 19, 19, 19),	/* black */
+	};
+	void *mem =3D dev->mem + dev->fix_info.line_length * yoffset
+		  + xoffset * dev->var_info.bits_per_pixel / 8;
+	unsigned int x;
+	unsigned int y;
+
+	for (y =3D 0; y < yres * 6 / 9; ++y) {
+		for (x =3D 0; x < xres; ++x)
+			((uint16_t *)mem)[x] =3D colors_top[x * 7 / xres];
+		mem +=3D dev->fix_info.line_length;
+	}
+
+	for (; y < yres * 7 / 9; ++y) {
+		for (x =3D 0; x < xres; ++x)
+			((uint16_t *)mem)[x] =3D colors_middle[x * 7 / xres];
+		mem +=3D dev->fix_info.line_length;
+	}
+
+	for (; y < yres; ++y) {
+		for (x =3D 0; x < xres * 5 / 7; ++x)
+			((uint16_t *)mem)[x] +				colors_bottom[x * 4 / (xres * 5 / 7)];
+		for (; x < xres * 6 / 7; ++x)
+			((uint16_t *)mem)[x] +				colors_bottom[(x - xres * 5 / 7) * 3
+					      / (xres / 7) + 4];
+		for (; x < xres; ++x)
+			((uint16_t *)mem)[x] =3D colors_bottom[7];
+		mem +=3D dev->fix_info.line_length;
+	}
+}
+
+struct fb_color24 {
+	unsigned int value:24;
+} __attribute__((__packed__));
+
+#define FB_MAKE_COLOR24(var, r, g, b) \
+	{ .value =3D FB_MAKE_COLOR(var, r, g, b) }
+
+static void
+fb_fill_rgb24(struct device *dev, unsigned int xoffset, unsigned int yoffs=
et,
+	      unsigned int xres, unsigned int yres)
+{
+	const struct fb_color24 colors_top[] =3D {
+		FB_MAKE_COLOR24(&dev->var_info, 192, 192, 192),	/* grey */
+		FB_MAKE_COLOR24(&dev->var_info, 192, 192, 0),	/* yellow */
+		FB_MAKE_COLOR24(&dev->var_info, 0, 192, 192),	/* cyan */
+		FB_MAKE_COLOR24(&dev->var_info, 0, 192, 0),	/* green */
+		FB_MAKE_COLOR24(&dev->var_info, 192, 0, 192),	/* magenta */
+		FB_MAKE_COLOR24(&dev->var_info, 192, 0, 0),	/* red */
+		FB_MAKE_COLOR24(&dev->var_info, 0, 0, 192),	/* blue */
+	};
+	const struct fb_color24 colors_middle[] =3D {
+		FB_MAKE_COLOR24(&dev->var_info, 0, 0, 192),	/* blue */
+		FB_MAKE_COLOR24(&dev->var_info, 19, 19, 19),	/* black */
+		FB_MAKE_COLOR24(&dev->var_info, 192, 0, 192),	/* magenta */
+		FB_MAKE_COLOR24(&dev->var_info, 19, 19, 19),	/* black */
+		FB_MAKE_COLOR24(&dev->var_info, 0, 192, 192),	/* cyan */
+		FB_MAKE_COLOR24(&dev->var_info, 19, 19, 19),	/* black */
+		FB_MAKE_COLOR24(&dev->var_info, 192, 192, 192),	/* grey */
+	};
+	const struct fb_color24 colors_bottom[] =3D {
+		FB_MAKE_COLOR24(&dev->var_info, 0, 33, 76),	/* in-phase */
+		FB_MAKE_COLOR24(&dev->var_info, 255, 255, 255),	/* super white */
+		FB_MAKE_COLOR24(&dev->var_info, 50, 0, 106),	/* quadrature */
+		FB_MAKE_COLOR24(&dev->var_info, 19, 19, 19),	/* black */
+		FB_MAKE_COLOR24(&dev->var_info, 9, 9, 9),	/* 3.5% */
+		FB_MAKE_COLOR24(&dev->var_info, 19, 19, 19),	/* 7.5% */
+		FB_MAKE_COLOR24(&dev->var_info, 29, 29, 29),	/* 11.5% */
+		FB_MAKE_COLOR24(&dev->var_info, 19, 19, 19),	/* black */
+	};
+	void *mem =3D dev->mem + dev->fix_info.line_length * yoffset
+		  + xoffset * dev->var_info.bits_per_pixel / 8;
+	unsigned int x;
+	unsigned int y;
+
+	for (y =3D 0; y < yres * 6 / 9; ++y) {
+		for (x =3D 0; x < xres; ++x)
+			((struct fb_color24 *)mem)[x] +				colors_top[x * 7 / xres];
+		mem +=3D dev->fix_info.line_length;
+	}
+
+	for (; y < yres * 7 / 9; ++y) {
+		for (x =3D 0; x < xres; ++x)
+			((struct fb_color24 *)mem)[x] +				colors_middle[x * 7 / xres];
+		mem +=3D dev->fix_info.line_length;
+	}
+
+	for (; y < yres; ++y) {
+		for (x =3D 0; x < xres * 5 / 7; ++x)
+			((struct fb_color24 *)mem)[x] +				colors_bottom[x * 4 / (xres * 5 / 7)=
];
+		for (; x < xres * 6 / 7; ++x)
+			((struct fb_color24 *)mem)[x] +				colors_bottom[(x - xres * 5 / 7) * 3
+					      / (xres / 7) + 4];
+		for (; x < xres; ++x)
+			((struct fb_color24 *)mem)[x] =3D colors_bottom[7];
+		mem +=3D dev->fix_info.line_length;
+	}
+}
+
+static void
+fb_fill_rgb32(struct device *dev, unsigned int xoffset, unsigned int yoffs=
et,
+	      unsigned int xres, unsigned int yres)
+{
+	const uint32_t colors_top[] =3D {
+		FB_MAKE_COLOR(&dev->var_info, 192, 192, 192),	/* grey */
+		FB_MAKE_COLOR(&dev->var_info, 192, 192, 0),	/* yellow */
+		FB_MAKE_COLOR(&dev->var_info, 0, 192, 192),	/* cyan */
+		FB_MAKE_COLOR(&dev->var_info, 0, 192, 0),	/* green */
+		FB_MAKE_COLOR(&dev->var_info, 192, 0, 192),	/* magenta */
+		FB_MAKE_COLOR(&dev->var_info, 192, 0, 0),	/* red */
+		FB_MAKE_COLOR(&dev->var_info, 0, 0, 192),	/* blue */
+	};
+	const uint32_t colors_middle[] =3D {
+		FB_MAKE_COLOR(&dev->var_info, 0, 0, 192),	/* blue */
+		FB_MAKE_COLOR(&dev->var_info, 19, 19, 19),	/* black */
+		FB_MAKE_COLOR(&dev->var_info, 192, 0, 192),	/* magenta */
+		FB_MAKE_COLOR(&dev->var_info, 19, 19, 19),	/* black */
+		FB_MAKE_COLOR(&dev->var_info, 0, 192, 192),	/* cyan */
+		FB_MAKE_COLOR(&dev->var_info, 19, 19, 19),	/* black */
+		FB_MAKE_COLOR(&dev->var_info, 192, 192, 192),	/* grey */
+	};
+	const uint32_t colors_bottom[] =3D {
+		FB_MAKE_COLOR(&dev->var_info, 0, 33, 76),	/* in-phase */
+		FB_MAKE_COLOR(&dev->var_info, 255, 255, 255),	/* super white */
+		FB_MAKE_COLOR(&dev->var_info, 50, 0, 106),	/* quadrature */
+		FB_MAKE_COLOR(&dev->var_info, 19, 19, 19),	/* black */
+		FB_MAKE_COLOR(&dev->var_info, 9, 9, 9),		/* 3.5% */
+		FB_MAKE_COLOR(&dev->var_info, 19, 19, 19),	/* 7.5% */
+		FB_MAKE_COLOR(&dev->var_info, 29, 29, 29),	/* 11.5% */
+		FB_MAKE_COLOR(&dev->var_info, 19, 19, 19),	/* black */
+	};
+	void *mem =3D dev->mem + dev->fix_info.line_length * yoffset
+		  + xoffset * dev->var_info.bits_per_pixel / 8;
+	unsigned int x;
+	unsigned int y;
+
+	for (y =3D 0; y < yres * 6 / 9; ++y) {
+		for (x =3D 0; x < xres; ++x)
+			((uint32_t *)mem)[x] =3D colors_top[x * 7 / xres];
+		mem +=3D dev->fix_info.line_length;
+	}
+
+	for (; y < yres * 7 / 9; ++y) {
+		for (x =3D 0; x < xres; ++x)
+			((uint32_t *)mem)[x] =3D colors_middle[x * 7 / xres];
+		mem +=3D dev->fix_info.line_length;
+	}
+
+	for (; y < yres; ++y) {
+		for (x =3D 0; x < xres * 5 / 7; ++x)
+			((uint32_t *)mem)[x] +				colors_bottom[x * 4 / (xres * 5 / 7)];
+		for (; x < xres * 6 / 7; ++x)
+			((uint32_t *)mem)[x] +				colors_bottom[(x - xres * 5 / 7) * 3
+					      / (xres / 7) + 4];
+		for (; x < xres; ++x)
+			((uint32_t *)mem)[x] =3D colors_bottom[7];
+		mem +=3D dev->fix_info.line_length;
+	}
+}
+
+/*
+ * fb_fill - Fill the frame buffer with an SMPTE test pattern
+ * @dev: FB device
+ * @mode: Fill mode
+ *
+ * Fill the display (when mode is FB_FILL_DISPLAY) or virtual frame buffer=
 area
+ * (when mode is FB_FILL_VIRTUAL) with an SMPTE color bars pattern. Only R=
GB16,
+ * RGB24 and RGB32 on true color visuals are supported.
+ */
+static void fb_fill(struct device *dev, enum fb_fill_mode mode)
+{
+	unsigned int xoffset, yoffset;
+	unsigned int xres, yres;
+
+	if (dev->fix_info.visual !=3D FB_VISUAL_TRUECOLOR) {
+		printf("Error: test pattern is only supported for true color "
+			"visuals.\n");
+		return;
+	}
+
+	printf("Filling frame buffer with SMPTE test pattern\n");
+
+	if (mode =3D FB_FILL_DISPLAY) {
+		xoffset =3D dev->var_info.xoffset;
+		yoffset =3D dev->var_info.yoffset;
+		xres =3D dev->var_info.xres;
+		yres =3D dev->var_info.yres;
+	} else {
+		xoffset =3D 0;
+		yoffset =3D 0;
+		xres =3D dev->var_info.xres_virtual;
+		yres =3D dev->var_info.yres_virtual;
+	}
+
+	switch (dev->var_info.bits_per_pixel) {
+	case 16:
+		return fb_fill_rgb16(dev, xoffset, yoffset, xres, yres);
+	case 24:
+		return fb_fill_rgb24(dev, xoffset, yoffset, xres, yres);
+	case 32:
+		return fb_fill_rgb32(dev, xoffset, yoffset, xres, yres);
+	default:
+		printf("Error: display depth %u bpp not supported.\n",
+			dev->var_info.bits_per_pixel);
+		break;
+	}
+}
+
+/* -----------------------------------------------------------------------=
------
+ * Main
+ */
+
+static void usage(const char *argv0)
+{
+	printf("Usage: %s [options] device\n", argv0);
+	printf("Supported options:\n");
+	printf("-b, --blank mode		Set blanking mode\n");
+	printf("-f, --fill[=3Dmode]		Fill the frame buffer with a test pattern\n"=
);
+	printf("-F, --format bpp		Set the number of bits per pixel\n");
+	printf("-h, --help			Show this help screen\n");
+	printf("-p, --pan x,y			Pan the display to position (x,y)\n");
+	printf("-r, --resolution wxh		Set the display resolution to width x heigh=
t\n");
+	printf("-v, --virtual wxh		Set the display virtual resolution to width x =
height\n");
+	printf("-w, --wait-vsync[=3Dscreen]	Wait for VSync on the given screen\n"=
);
+	printf("\n");
+	printf("Support fill modes are:\n");
+	printf("display		Fill the displayed frame buffer only\n");
+	printf("virtual		Fill the whole virtual frame buffer\n");
+	printf("Supported blanking modes are:\n");
+	printf(" off		Blanking off, screen active\n");
+	printf(" on		Blanked, HSync on,  VSync on\n");
+	printf(" vsync		Blanked, HSync on,  VSync off\n");
+	printf(" hsync		Blanked, HSync off, VSync on\n");
+	printf(" powerdown	Blanked, HSync off, VSync off\n");
+}
+
+static struct option opts[] =3D {
+	{"blank", 1, 0, 'b'},
+	{"fill", 2, 0, 'f'},
+	{"format", 1, 0, 'F'},
+	{"help", 0, 0, 'h'},
+	{"pan", 1, 0, 'p'},
+	{"resolution", 1, 0, 'r'},
+	{"virtual", 1, 0, 'v'},
+	{"wait-vsync", 2, 0, 'w'},
+	{0, 0, 0, 0}
+};
+
+static int fb_blank_parse(const char *arg, int *value)
+{
+	static const struct fb_value_name names[] =3D {
+		{ FB_BLANK_UNBLANK, "off" },
+		{ FB_BLANK_NORMAL, "on" },
+		{ FB_BLANK_VSYNC_SUSPEND, "vsync" },
+		{ FB_BLANK_HSYNC_SUSPEND, "hsync" },
+		{ FB_BLANK_POWERDOWN, "powerdown" },
+	};
+	unsigned int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(names); ++i) {
+		if (strcmp(names[i].name, arg) =3D 0) {
+			*value =3D names[i].value;
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+static int fb_point_parse(const char *arg, unsigned int *x, unsigned int *=
y)
+{
+	unsigned long value;
+	char *endptr;
+
+	value =3D strtoul(arg, &endptr, 10);
+	if (endptr =3D arg || *endptr !=3D ',')
+		return -1;
+	*x =3D value;
+	arg =3D endptr + 1;
+
+	value =3D strtoul(arg, &endptr, 10);
+	if (endptr =3D arg || *endptr !=3D '\0')
+		return -1;
+	*y =3D value;
+
+	return 0;
+}
+
+static int fb_size_parse(const char *arg, int *x, int *y)
+{
+	unsigned long value;
+	char *endptr;
+
+	value =3D strtoul(arg, &endptr, 10);
+	if (endptr =3D arg || *endptr !=3D 'x')
+		return -1;
+	*x =3D value;
+	arg =3D endptr + 1;
+
+	value =3D strtoul(arg, &endptr, 10);
+	if (endptr =3D arg || *endptr !=3D '\0')
+		return -1;
+	*y =3D value;
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct device dev;
+	int ret;
+
+	/* Options parsing. */
+	bool do_blank =3D false;
+	int blank =3D 0;
+
+	enum fb_fill_mode fill_mode =3D FB_FILL_NONE;
+
+	bool do_format =3D false;
+	unsigned int bpp =3D 0;
+
+	bool do_pan =3D false;
+	unsigned int pan_x =3D 0;
+	unsigned int pan_y =3D 0;
+
+	bool do_resolution =3D false;
+	int xres =3D -1;
+	int yres =3D -1;
+	int xres_virtual =3D -1;
+	int yres_virtual =3D -1;
+
+	bool do_wait_for_vsync =3D false;
+	unsigned int screen =3D 0;
+
+	int c;
+
+	opterr =3D 0;
+	while ((c =3D getopt_long(argc, argv, "b:f::F:hp:r:v:w::", opts, NULL)) !=
=3D -1) {
+
+		switch (c) {
+		case 'b':
+			do_blank =3D true;
+			if (fb_blank_parse(optarg, &blank) < 0) {
+				printf("Invalid blanking mode `%s'\n", optarg);
+				printf("Run %s -h for help.\n", argv[0]);
+				return 1;
+			}
+			break;
+		case 'f':
+			if (optarg =3D NULL)
+				fill_mode =3D FB_FILL_DISPLAY;
+			else if (strcmp(optarg, "display") =3D 0)
+				fill_mode =3D FB_FILL_DISPLAY;
+			else if (strcmp(optarg, "virtual") =3D 0)
+				fill_mode =3D FB_FILL_VIRTUAL;
+			else {
+				printf("Invalid fill mode `%s'\n", optarg);
+				printf("Run %s -h for help.\n", argv[0]);
+				return 1;
+			}
+			break;
+		case 'F':
+			do_format =3D true;
+			bpp =3D atoi(optarg);
+			break;
+		case 'h':
+			usage(argv[0]);
+			return 0;
+		case 'p':
+			do_pan =3D true;
+			if (fb_point_parse(optarg, &pan_x, &pan_y) < 0) {
+				printf("Invalid pan point `%s'\n", optarg);
+				printf("Run %s -h for help.\n", argv[0]);
+				return 1;
+			}
+			break;
+		case 'r':
+			do_resolution =3D true;
+			if (fb_size_parse(optarg, &xres, &yres) < 0) {
+				printf("Invalid resolution `%s'\n", optarg);
+				printf("Run %s -h for help.\n", argv[0]);
+				return 1;
+			}
+			break;
+		case 'v':
+			do_resolution =3D true;
+			if (fb_size_parse(optarg, &xres_virtual, &yres_virtual) < 0) {
+				printf("Invalid virtual resolution `%s'\n", optarg);
+				printf("Run %s -h for help.\n", argv[0]);
+				return 1;
+			}
+			break;
+		case 'w':
+			do_wait_for_vsync =3D true;
+			if (optarg)
+				screen =3D atoi(optarg);
+			break;
+		default:
+			printf("Invalid option -%c\n", c);
+			printf("Run %s -h for help.\n", argv[0]);
+			return 1;
+		}
+	}
+
+	if (optind >=3D argc) {
+		usage(argv[0]);
+		return 1;
+	}
+
+	ret =3D fb_open(&dev, argv[optind]);
+	if (ret < 0)
+		return 1;
+
+	if (do_blank)
+		fb_blank(&dev, blank);
+
+	if (do_format)
+		fb_set_format(&dev, bpp);
+
+	if (do_resolution)
+		fb_set_resolution(&dev, xres, yres, xres_virtual, yres_virtual);
+
+	if (fill_mode !=3D FB_FILL_NONE)
+		fb_fill(&dev, fill_mode);
+
+	if (do_pan)
+		fb_pan(&dev, pan_x, pan_y);
+
+	if (do_wait_for_vsync)
+		fb_wait_for_vsync(&dev, screen);
+
+	fb_close(&dev);
+	return 0;
+}

--=20
Regards,

Laurent Pinchart

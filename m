From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] pm3fb: preliminary support for 2.6
	kernel
Date: Sun, 06 May 2007 22:47:22 +0200
Message-ID: <463e3edaad7a2@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part463e3edaafea3"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hkndg-000110-Qn for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 06 May 2007 13:47:29 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hknde-0005q3-Ot
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 06 May 2007 13:47:28 -0700
Received: from poczta-10.free.wp-sa.pl (HELO localhost) ([10.1.1.28])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 6 May 2007 22:47:22 +0200
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
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--part463e3edaafea3
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This is a basic port from 2.4 kernel to 2.6. Acceleration is lost
and big endian support probably too. The driver works in 8, 16
and 32 bit mode.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This is a first trial of porting this driver. The driver work may
contain many bugs.

diff -urp linux-2.6.21.new/drivers/video/Kconfig
linux-2.6.21/drivers/video/Kconfig
--- linux-2.6.21.new/drivers/video/Kconfig	2007-05-06
22:22:13.507458454 +0200
+++ linux-2.6.21/drivers/video/Kconfig	2007-05-06
22:10:17.094637189 +0200
@@ -1309,8 +1309,11 @@ config FB_TRIDENT_ACCEL
 	acceleration functions.
=20
 config FB_PM3
-	tristate "Permedia3 support"
-	depends on FB && PCI && BROKEN
+	tristate "Permedia3 support (EXPERIMENTAL)"
+	depends on FB && PCI && EXPERIMENTAL
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the 3DLabs Permedia3
 	  chipset, used in Formac ProFormance III, 3DLabs Oxygen VX1 &
diff -urp linux-2.6.21.new/drivers/video/pm3fb.c
linux-2.6.21/drivers/video/pm3fb.c
--- linux-2.6.21.new/drivers/video/pm3fb.c	2007-04-26
05:08:32.000000000 +0200
+++ linux-2.6.21/drivers/video/pm3fb.c	2007-05-06
22:20:01.319925515 +0200
@@ -1,55 +1,25 @@
 /*
  *  linux/drivers/video/pm3fb.c -- 3DLabs Permedia3 frame buffer
device
- * =20
+ *
  *  Copyright (C) 2001 Romain Dolbeau <dolbeau@irisa.fr>
+ *
+ *  Ported to 2.6 kernel on 1 May 2007 by Krzysztof Helt
<krzysztof.h1@wp.pl>
+ *	based on pm2fb.c
+ *
  *  Based on code written by:
- *           Sven Luther, <luther@dpt-info.u-strasbg.fr>
- *           Alan Hourihane, <alanh@fairlite.demon.co.uk>
- *           Russell King, <rmk@arm.linux.org.uk>
+ *	   Sven Luther, <luther@dpt-info.u-strasbg.fr>
+ *	   Alan Hourihane, <alanh@fairlite.demon.co.uk>
+ *	   Russell King, <rmk@arm.linux.org.uk>
  *  Based on linux/drivers/video/skeletonfb.c:
  *	Copyright (C) 1997 Geert Uytterhoeven
  *  Based on linux/driver/video/pm2fb.c:
- *      Copyright (C) 1998-1999 Ilario Nardinocchi
(nardinoc@CS.UniBO.IT)
- *      Copyright (C) 1999 Jakub Jelinek (jakub@redhat.com)
+ *	Copyright (C) 1998-1999 Ilario Nardinocchi (nardinoc@CS.UniBO.IT)
+ *	Copyright (C) 1999 Jakub Jelinek (jakub@redhat.com)
  *
  *  This file is subject to the terms and conditions of the GNU
General Public
  *  License. See the file COPYING in the main directory of this
archive for
  *  more details.
  *
- *  $Header: /cvsroot/linux/drivers/video/pm3fb.c,v 1.1
2002/02/25 19:11:06 marcelo Exp $
- *
- *  CHANGELOG:
- *  Mon Feb 11 10:35:48 MET 2002, v 1.4.11B: Cosmetic update.
- *  Wed Jan 23 14:16:59 MET 2002, v 1.4.11: Preliminary 2.5.x
support, patch for 2.5.2.
- *  Wed Nov 28 11:08:29 MET 2001, v 1.4.10: potential bug fix
for SDRAM-based board, patch for 2.4.16.
- *  Thu Sep 20 10:24:42 MET DST 2001, v 1.4.9: sync bug fix,
preliminary flatpanel support, better timings.
- *  Tue Aug 28 10:13:01 MET DST 2001, v 1.4.8: memory timings
check, minor bug fixes.
- *  Wed Jul 18 19:06:14 CEST 2001, v 1.4.7: Mode fix
(800x600-100, 1024x768-100 changed), using HW panning + accel bug
fix.
- *  Mon Jun 25 10:33:56 MET DST 2001, v 1.4.6: Depth 12 fix,
chip reset ioctl, moved memory erase ioctl to DEBUG.
- *  Wed Jun 20 11:13:08 MET DST 2001, v 1.4.5: Fixed missing
blinking cursor in 8bpp, code cleaning, memory erase IOCTL.
- *  Mon Jun 18 16:00:27 CEST 2001, v 1.4.4: Depth 12 (RGBA 4444)
support, code cleaning.
- *  Fri Jun 15 13:53:01 CEST 2001, v 1.4.3: Removed warnings,
depth 15 support, add 'depth' option.
- *  Thu Jun 14 10:13:52 MET DST 2001, v 1.4.2: Fixed depth
switching bug, preliminary 15bpp (RGB5551) support.
- *  Thu Apr 12 11:16:45 MET DST 2001, v 1.4.1B: Doc updates.
- *  Fri Apr  6 11:12:53 MET DST 2001, v 1.4.1: Configure.help,
minor cleanup
- *  Thu Mar 29 10:56:50 MET DST 2001, v 1.4.0: Module & module
options support (note: linux patch changed, 2.2.19 added).
- *  Thu Mar 15 15:30:31 MET 2001, v 1.3.2: Fixed mirroring bug
on little-endian.
- *  Wed Mar 14 21:25:54 CET 2001, v 1.3.1: Fixed bug in
BlockMove (_bmov).
- *  Tue Mar 13 10:53:19 MET 2001, v 1.3.0: Character drawing
hardware support (in all width between 1 and 16), fixes.
- *  Thu Mar  8 10:20:16 MET 2001, v 1.2.2: Better J2000 support,
"font:" option.
- *  Tue Mar  6 21:25:04 CET 2001, v 1.2.1: Better acceleration
support.
- *  Mon Mar  5 21:54:17 CET 2001, v 1.2.0: Partial acceleration
support (clear & bmove)
- *  Mon Mar  5 12:52:15 CET 2001, v 1.1.3: Big pan_display fix.
- *  Sun Mar  4 22:21:50 CET 2001, v 1.1.2: (numerous) bug fixes.
- *  Fri Mar  2 15:54:07 CET 2001, v 1.1.1: Might have Appian
J2000 support, resource mangement in 2.4
- *  Wed Feb 28 18:21:35 CET 2001, v 1.1.0: Might have multiple
boards support (added, but not yest tested)
- *  Tue Feb 27 17:31:12 CET 2001, v 1.0.6: fixes boot-time mode
select, add more default mode
- *  Tue Feb 27 14:01:36 CET 2001, v 1.0.5: fixes (1.0.4 was
broken for 2.2), cleaning up
- *  Mon Feb 26 23:17:36 CET 2001, v 1.0.4: preliminary 2.4.x
support, dropped (useless on pm3) partial product, more OF fix
- *  Mon Feb 26 20:59:05 CET 2001, v 1.0.3: No more shadow
register (and wasted memory), endianess fix, use OF-preset
resolution by default
- *  Wed Feb 21 22:09:30 CET 2001, v 1.0.2: Code cleaning for
future multiboard support, better OF support, bugs fix
- *  Wed Feb 21 19:58:56 CET 2001, v 1.0.1: OpenFirmware support,
fixed memory detection, better debug support, code cleaning
- *  Wed Feb 21 14:47:06 CET 2001, v 1.0.0: First working version
  */
=20
 #include <linux/module.h>
@@ -58,856 +28,165 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/delay.h>
-#include <linux/interrupt.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/ioport.h>
-#include <linux/ctype.h>
=20
-#include <video/fbcon.h>
-#include <video/fbcon-mfb.h>
-#include <video/fbcon-cfb2.h>
-#include <video/fbcon-cfb4.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
-#include <video/fbcon-cfb24.h>
-#include <video/fbcon-cfb32.h>
 #include <video/pm3fb.h>
=20
-#include <asm/io.h>
-#include <asm/uaccess.h>
+#if !defined(CONFIG_PCI)
+#error "Only generic PCI cards supported."
+#endif
=20
-#ifdef CONFIG_FB_OF
-#include <asm/prom.h>
+#undef PM3FB_MASTER_DEBUG
+#ifdef PM3FB_MASTER_DEBUG
+#define DPRINTK(a,b...)	printk(KERN_DEBUG "pm3fb: %s: " a,
__FUNCTION__ , ## b)
+#else
+#define DPRINTK(a,b...)
 #endif
=20
-/* ************************************* */
-/* ***** The various "global" data ***** */
-/* ************************************* */
-
-/* those will need a rework for multiple board support */
-/* Driver name */
-static const char permedia3_name[16] =3D "Permedia3";
-
-/* the fb_par struct, mandatory */
-struct pm3fb_par {
-	u32 pixclock;		/* pixclock in KHz */
-
-	u32 width;		/* width of virtual screen */
-	u32 height;		/* height of virtual screen */
-
-	u32 hsstart;		/* horiz. sync start */
-	u32 hsend;		/* horiz. sync end */
-	u32 hbend;		/* horiz. blank end (also gate end) */
-	u32 htotal;		/* total width (w/ sync & blank) */
-
-	u32 vsstart;		/* vert. sync start */
-	u32 vsend;		/* vert. sync end */
-	u32 vbend;		/* vert. blank end */
-	u32 vtotal;		/* total height (w/ sync & blank) */
-
-	u32 stride;		/* screen stride */
-	u32 base;		/* screen base (xoffset+yoffset) in 128 bits unit */
-	/* NOTE : unlike other pm3 stuff above, stored *after*
shiftbpp. don't ask */
-	u32 depth;		/* screen depth (8, 12, 15, 16 or 32) */
-	u32 video;		/* video control (hsync,vsync) */
-};
+/*
+ * Driver data
+ */
+static char *mode_option __devinitdata;
=20
-/* memory timings */
-struct pm3fb_timings
-{
-	unsigned long caps;
-	unsigned long timings;
-	unsigned long control;
-	unsigned long refresh;
-	unsigned long powerdown;
-};
-typedef enum pm3fb_timing_result { pm3fb_timing_ok,
pm3fb_timing_problem, pm3fb_timing_retry } pm3fb_timing_result;
-#define PM3FB_UNKNOWN_TIMING_VALUE ((unsigned long)-1)
-#define PM3FB_UNKNOWN_TIMINGS { PM3FB_UNKNOWN_TIMING_VALUE,
PM3FB_UNKNOWN_TIMING_VALUE, PM3FB_UNKNOWN_TIMING_VALUE,
PM3FB_UNKNOWN_TIMING_VALUE, PM3FB_UNKNOWN_TIMING_VALUE }
-
-/* the fb_info struct, mandatory */
-struct pm3fb_info {
-	struct fb_info_gen gen;
-	unsigned long board_num; /* internal board number */
-	unsigned long use_current;
-	struct pm3fb_par *current_par;
-	struct pci_dev *dev;    /* PCI device */
-	unsigned long board_type; /* index in the cardbase */
-	unsigned char *fb_base;	/* framebuffer memory base */
-	u32 fb_size;		/* framebuffer memory size */
-	unsigned char *p_fb;	/* physical address of frame buffer */
-	unsigned char *v_fb;	/* virtual address of frame buffer */
-	unsigned char *pIOBase;	/* physical address of registers
region, must be rg_base or rg_base+PM2_REGS_SIZE depending on the
host endianness */
-	unsigned char *vIOBase;	/* address of registers after ioremap() */
-	struct {
-		u8 transp;
-		u8 red;
-		u8 green;
-		u8 blue;
-	} palette[256];
-	union {
-#ifdef FBCON_HAS_CFB16
-		u16 cmap12[16]; /* RGBA 4444 */
-		u16 cmap15[16]; /* RGBA 5551 */
-		u16 cmap16[16]; /* RGBA 5650 */
-#endif
-#ifdef FBCON_HAS_CFB32
-		u32 cmap32[16];
-#endif
-	} cmap;
-	struct pm3fb_timings memt;
-};
+/*
+ *  If your driver supports multiple boards, you should make the
+ *  below data types arrays, or allocate them dynamically (using
kmalloc()).
+ */
=20
-/* regular resolution database*/
-static struct {
-	char name[16];
-	struct pm3fb_par user_mode;
-} mode_base[] __initdata =3D {
-	{
-		"default-800x600", {
-	49500, 800, 600, 16, 96, 256, 1056, 1, 4, 25, 625,
-			    800, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}}, {
-		"1024x768-74", {
-	78752, 1024, 768, 32, 128, 304, 1328, 1, 4, 38,
-			    806, 1024, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}}, {
-		"1024x768-74-32", {
-			78752, 1024, 768, 32, 128, 304, 1328, 1, 4, 38,
-			806, 1024, 0, 32,
-			PM3VideoControl_ENABLE |
-			PM3VideoControl_HSYNC_ACTIVE_HIGH
-			|
-			PM3VideoControl_VSYNC_ACTIVE_HIGH
-			| PM3VideoControl_PIXELSIZE_32BIT}},
-/* Generated mode : "1600x1024", for the SGI 1600SW flat panel*/
-	{
-		"SGI1600SW", {
-			108000, 1600, 1024, 16, 56, 104, 1704, 3, 6, 32,
-			1056, 1600, 0, 8,
-			PM3VideoControl_ENABLE|
-	=09
PM3VideoControl_HSYNC_ACTIVE_LOW|PM3VideoControl_VSYNC_ACTIVE_LOW|
-			PM3VideoControl_PIXELSIZE_32BIT}},=20
-/* ##### auto-generated mode, by fbtimings2pm3 */
-/* Generated mode : "640x480-60" */
-	{
-		"640x480-60", {
-	25174, 640, 480, 16, 112, 160, 800, 10, 12, 45,
-			    525, 640, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_LOW
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_LOW
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "640x480-72" */
-	{
-		"640x480-72", {
-	31199, 640, 480, 24, 64, 192, 832, 9, 12, 40, 520,
-			    640, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_LOW
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_LOW
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "640x480-75" */
-	{
-		"640x480-75", {
-	31499, 640, 480, 16, 80, 200, 840, 1, 4, 20, 500,
-			    640, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_LOW
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_LOW
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "640x480-90" */
-	{
-		"640x480-90", {
-	39909, 640, 480, 32, 72, 192, 832, 25, 39, 53, 533,
-			    640, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_LOW
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_LOW
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "640x480-100" */
-	{
-		"640x480-100", {
-	44899, 640, 480, 32, 160, 208, 848, 22, 34, 51,
-			    531, 640, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_LOW
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_LOW
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "800x600-48-lace" */
-/* INTERLACED NOT SUPPORTED
-  {"800x600-48-lace", {35999, 800, 600, 80, 208, 264, 1064, 11,
23, 102, 702, 800, 0, 8,
PM3VideoControl_ENABLE|PM3VideoControl_HSYNC_ACTIVE_HIGH|PM3VideoControl_=
VSYNC_ACTIVE_HIGH|PM3VideoControl_PIXELSIZE_8BIT}},

-   INTERLACED NOT SUPPORTED */
-/* Generated mode : "800x600-56" */
-	{
-		"800x600-56", {
-	35999, 800, 600, 24, 96, 224, 1024, 1, 3, 25, 625,
-			    800, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "800x600-60" */
-	{
-		"800x600-60", {
-	40000, 800, 600, 40, 168, 256, 1056, 1, 5, 28, 628,
-			    800, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "800x600-70" */
-	{
-		"800x600-70", {
-	44899, 800, 600, 24, 168, 208, 1008, 9, 21, 36,
-			    636, 800, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_LOW
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "800x600-72" */
-	{
-		"800x600-72", {
-	50000, 800, 600, 56, 176, 240, 1040, 37, 43, 66,
-			    666, 800, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "800x600-75" */
-	{
-		"800x600-75", {
-	49497, 800, 600, 16, 96, 256, 1056, 1, 4, 25, 625,
-			    800, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "800x600-90" */
-	{
-		"800x600-90", {
-	56637, 800, 600, 8, 72, 192, 992, 8, 19, 35, 635,
-			    800, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "800x600-100", from /etc/fb.modes */
-/* DISABLED, hsstart =3D=3D 0
-	{
-		"800x600-100", {
-	67499, 800, 600, 0, 64, 280, 1080, 7, 11, 25, 625,
-			    800, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-*/
-/* Generated mode : "800x600-100", from ??? */
-	{
-		"800x600-100", {
-			69650, 800, 600, 64, 128, 288, 1088, 4, 10, 40, 640, 800, 0, 8,
-			PM3VideoControl_ENABLE|PM3VideoControl_HSYNC_ACTIVE_LOW|
-	=09
PM3VideoControl_VSYNC_ACTIVE_LOW|PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1024x768-43-lace" */
-/* INTERLACED NOT SUPPORTED
-  {"1024x768-43-lace", {44899, 1024, 768, 8, 184, 240, 1264, 1,
9, 49, 817, 1024, 0, 8,
PM3VideoControl_ENABLE|PM3VideoControl_HSYNC_ACTIVE_HIGH|PM3VideoControl_=
VSYNC_ACTIVE_HIGH|PM3VideoControl_PIXELSIZE_8BIT}},

-   INTERLACED NOT SUPPORTED */
-/* Generated mode : "1024x768-60" */
-	{
-		"1024x768-60", {
-	64998, 1024, 768, 24, 160, 320, 1344, 3, 9, 38,
-			    806, 1024, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_LOW
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_LOW
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1024x768-70" */
-	{
-		"1024x768-70", {
-	74996, 1024, 768, 24, 160, 304, 1328, 3, 9, 38,
-			    806, 1024, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_LOW
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_LOW
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1024x768-72" */
-	{
-		"1024x768-72", {
-	74996, 10224, 768, 24, 160, 264, 10488, 3, 9, 38,
-			    806, 10224, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_LOW
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_LOW
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1024x768-75" */
-	{
-		"1024x768-75", {
-	78746, 1024, 768, 16, 112, 288, 1312, 1, 4, 32,
-			    800, 1024, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1024x768-90" */
-	{
-		"1024x768-90", {
-	100000, 1024, 768, 0, 96, 288, 1312, 21, 36, 77,
-			    845, 1024, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_LOW
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_LOW
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1024x768-100", from /etc/fb.modes */
-/* DISABLED, vsstart =3D=3D 0
-	{
-		"1024x768-100", {
-	109998, 1024, 768, 0, 88, 368, 1392, 0, 8, 24, 792,
-			    1024, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_LOW
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_LOW
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-*/
-/* Generated mode : "1024x768-100", from ??? */
-	{
-		"1024x768-100", {
-			115500, 1024, 768, 32, 224, 416, 1440, 3, 13, 34, 802, 1024,
0, 8,
-			PM3VideoControl_ENABLE|PM3VideoControl_HSYNC_ACTIVE_LOW|
-	=09
PM3VideoControl_VSYNC_ACTIVE_LOW|PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1152x864-43-lace" */
-/* INTERLACED NOT SUPPORTED
-  {"1152x864-43-lace", {64998, 1152, 864, 72, 200, 264, 1416,
78, 87, 191, 1055, 1152, 0, 8,
PM3VideoControl_ENABLE|PM3VideoControl_HSYNC_ACTIVE_HIGH|PM3VideoControl_=
VSYNC_ACTIVE_HIGH|PM3VideoControl_PIXELSIZE_8BIT}},

-   INTERLACED NOT SUPPORTED */
-/* Generated mode : "1152x864-47-lace" */
-/* INTERLACED NOT SUPPORTED
-  {"1152x864-47-lace", {64998, 1152, 864, 88, 216, 296, 1448,
30, 39, 83, 947, 1152, 0, 8,
PM3VideoControl_ENABLE|PM3VideoControl_HSYNC_ACTIVE_HIGH|PM3VideoControl_=
VSYNC_ACTIVE_HIGH|PM3VideoControl_PIXELSIZE_8BIT}},

-   INTERLACED NOT SUPPORTED */
-/* Generated mode : "1152x864-60" */
-	{
-		"1152x864-60", {
-	80000, 1152, 864, 64, 176, 304, 1456, 6, 11, 52,
-			    916, 1152, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1152x864-70" */
-	{
-		"1152x864-70", {
-	100000, 1152, 864, 40, 192, 360, 1512, 13, 24, 81,
-			    945, 1152, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1152x864-75" */
-	{
-		"1152x864-75", {
-	109998, 1152, 864, 24, 168, 312, 1464, 45, 53, 138,
-			    1002, 1152, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1152x864-80" */
-	{
-		"1152x864-80", {
-	109998, 1152, 864, 16, 128, 288, 1440, 30, 37, 94,
-			    958, 1152, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1280x1024-43-lace" */
-/* INTERLACED NOT SUPPORTED
-  {"1280x1024-43-lace", {80000, 1024, 1024, 80, 160, 320, 1344,
50, 60, 125, 1149, 1024, 0, 8,
PM3VideoControl_ENABLE|PM3VideoControl_HSYNC_ACTIVE_HIGH|PM3VideoControl_=
VSYNC_ACTIVE_HIGH|PM3VideoControl_PIXELSIZE_8BIT}},

-   INTERLACED NOT SUPPORTED */
-/* Generated mode : "1280x1024-47-lace" */
-/* INTERLACED NOT SUPPORTED
-  {"1280x1024-47-lace", {80000, 1280, 1024, 80, 160, 320, 1600,
1, 11, 29, 1053, 1280, 0, 8,
PM3VideoControl_ENABLE|PM3VideoControl_HSYNC_ACTIVE_HIGH|PM3VideoControl_=
VSYNC_ACTIVE_HIGH|PM3VideoControl_PIXELSIZE_8BIT}},

-   INTERLACED NOT SUPPORTED */
-/* Generated mode : "1280x1024-60" */
-	{
-		"1280x1024-60", {
-	107991, 1280, 1024, 48, 160, 408, 1688, 1, 4, 42,
-			    1066, 1280, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1280x1024-70" */
-	{
-		"1280x1024-70", {
-	125992, 1280, 1024, 80, 192, 408, 1688, 1, 6, 42,
-			    1066, 1280, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1280x1024-74" */
-	{
-		"1280x1024-74", {
-	134989, 1280, 1024, 32, 176, 432, 1712, 0, 30, 40,
-			    1064, 1280, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1280x1024-75" */
-	{
-		"1280x1024-75", {
-	134989, 1280, 1024, 16, 160, 408, 1688, 1, 4, 42,
-			    1066, 1280, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_HIGH
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_HIGH
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1600x1200-60" */
-	{
-		"1600x1200-60", {
-	155981, 1600, 1200, 32, 192, 448, 2048, 10, 18, 70,
-			    1270, 1600, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_LOW
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_LOW
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1600x1200-66" */
-	{
-		"1600x1200-66", {
-	171998, 1600, 1200, 40, 176, 480, 2080, 3, 6, 53,
-			    1253, 1600, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_LOW
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_LOW
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* Generated mode : "1600x1200-76" */
-	{
-		"1600x1200-76", {
-	197980, 1600, 1200, 40, 176, 480, 2080, 3, 8, 50,
-			    1250, 1600, 0, 8,
-			    PM3VideoControl_ENABLE |
-			    PM3VideoControl_HSYNC_ACTIVE_LOW
-			    |
-			    PM3VideoControl_VSYNC_ACTIVE_LOW
-			    | PM3VideoControl_PIXELSIZE_8BIT}},
-/* ##### end of auto-generated mode */
-	{
-	"\0",}
+/*
+ * This structure defines the hardware state of the graphics
card. Normally
+ * you place this in a header file in linux/include/video. This
file usually
+ * also includes register information. That allows other driver
subsystems
+ * and userland applications the ability to use the same header
file to
+ * avoid duplicate work and easy porting of software.
+ */
+struct pm3_par {
+	unsigned char	__iomem *v_regs;/* virtual address of p_regs */
+	u32		video;		/* video flags before blanking */
+	u32		base;		/* screen base (xoffset+yoffset) in 128 bits unit */
+	u32 		palette[16];
 };
=20
-/* more mandatory stuff (see skeletonfb.c + framebuffer driver
HOWTO */
-static struct pm3fb_info fb_info[PM3_MAX_BOARD];
-static struct pm3fb_par current_par[PM3_MAX_BOARD];
-static int current_par_valid[PM3_MAX_BOARD];
-/* to allow explicit filtering of board */
-short bus[PM3_MAX_BOARD];
-short slot[PM3_MAX_BOARD];
-short func[PM3_MAX_BOARD];
-short disable[PM3_MAX_BOARD];
-short noaccel[PM3_MAX_BOARD];
-char fontn[PM3_MAX_BOARD][PM3_FONTNAME_SIZE];
-short depth[PM3_MAX_BOARD];
-short flatpanel[PM3_MAX_BOARD];
-static struct display disp[PM3_MAX_BOARD];
-static char g_options[PM3_OPTIONS_SIZE] __initdata =3D "pm3fb,dummy";
-short printtimings =3D 0;
-short forcesize[PM3_MAX_BOARD];
-
-/* ********************* */
-/* ***** prototype ***** */
-/* ********************* */
-/* card-specific */
-static void pm3fb_j2000_setup(struct pm3fb_info *l_fb_info);
-/* permedia3-specific */
-static pm3fb_timing_result pm3fb_preserve_memory_timings(struct
pm3fb_info *l_fb_info);
-static pm3fb_timing_result pm3fb_try_memory_timings(struct
pm3fb_info *l_fb_info);
-static void pm3fb_write_memory_timings(struct pm3fb_info
*l_fb_info);
-static unsigned long pm3fb_read_dac_reg(struct pm3fb_info
*l_fb_info,
-					unsigned long r);
-static unsigned long pm3fb_CalculateClock(struct pm3fb_info
*l_fb_info, unsigned long reqclock,	/* In kHz units */
-					  unsigned long refclock,	/* In kHz units */
-					  unsigned char *prescale,	/* ClkPreScale */
-					  unsigned char *feedback,	/* ClkFeedBackScale */
-					  unsigned char *postscale
-					  /* ClkPostScale */ );
-static void pm3fb_clear_memory(struct pm3fb_info *l_fb_info, u32
cc);
-static void pm3fb_clear_colormap(struct pm3fb_info *l_fb_info,
unsigned char r, unsigned char g, unsigned char b);
-static void pm3fb_common_init(struct pm3fb_info *l_fb_info);
-static int pm3fb_Shiftbpp(struct pm3fb_info *l_fb_info,
-			  unsigned long depth, int v);
-static int pm3fb_Unshiftbpp(struct pm3fb_info *l_fb_info,
-			    unsigned long depth, int v);
-static void pm3fb_mapIO(struct pm3fb_info *l_fb_info);
-static void pm3fb_unmapIO(struct pm3fb_info *l_fb_info);
-#if defined(PM3FB_MASTER_DEBUG) && (PM3FB_MASTER_DEBUG >=3D 2)
-static void pm3fb_show_cur_mode(struct pm3fb_info *l_fb_info);
-#endif
-static void pm3fb_show_cur_timing(struct pm3fb_info *l_fb_info);
-static void pm3fb_write_mode(struct pm3fb_info *l_fb_info);
-static void pm3fb_read_mode(struct pm3fb_info *l_fb_info,
-			    struct pm3fb_par *curpar);
-static unsigned long pm3fb_size_memory(struct pm3fb_info
*l_fb_info);
-/* accelerated permedia3-specific */
-#ifdef PM3FB_USE_ACCEL
-static void pm3fb_wait_pm3(struct pm3fb_info *l_fb_info);
-static void pm3fb_init_engine(struct pm3fb_info *l_fb_info);
-#ifdef FBCON_HAS_CFB32
-static void pm3fb_cfb32_clear(struct vc_data *conp,
-			      struct display *p,
-			      int sy, int sx, int height, int width);
-static void pm3fb_cfb32_clear_margins(struct vc_data *conp,
-				      struct display *p, int bottom_only);
-#endif /* FBCON_HAS_CFB32 */
-#ifdef FBCON_HAS_CFB16
-static void pm3fb_cfb16_clear(struct vc_data *conp,
-			      struct display *p,
-			      int sy, int sx, int height, int width);
-static void pm3fb_cfb16_clear_margins(struct vc_data *conp,
-				      struct display *p, int bottom_only);
-#endif /* FBCON_HAS_CFB16 */
-#ifdef FBCON_HAS_CFB8
-static void pm3fb_cfb8_clear(struct vc_data *conp,
-			     struct display *p,
-			     int sy, int sx, int height, int width);
-static void pm3fb_cfb8_clear_margins(struct vc_data *conp,
-				     struct display *p, int bottom_only);
-#endif /* FBCON_HAS_CFB8 */
-#if defined(FBCON_HAS_CFB8) || defined(FBCON_HAS_CFB16) ||
defined(FBCON_HAS_CFB32)
-static void pm3fb_cfbX_bmove(struct display *p,
-			     int sy, int sx,
-			     int dy, int dx, int height, int width);
-static void pm3fb_cfbX_putc(struct vc_data *conp, struct display *p,
-			    int c, int yy, int xx);
-static void pm3fb_cfbX_putcs(struct vc_data *conp, struct
display *p,
-			     const unsigned short *s, int count, int yy,
-			     int xx);
-static void pm3fb_cfbX_revc(struct display *p, int xx, int yy);
-#endif /* FBCON_HAS_CFB8 || FBCON_HAS_CFB16 || FBCON_HAS_CFB32 */
-#endif /* PM3FB_USE_ACCEL */
-/* pre-init */
-static void pm3fb_mode_setup(char *mode, unsigned long board_num);
-static void pm3fb_pciid_setup(char *pciid, unsigned long board_num);
-static char *pm3fb_boardnum_setup(char *options, unsigned long *bn);
-static void pm3fb_real_setup(char *options);
-/* fbdev */
-static int pm3fb_encode_fix(struct fb_fix_screeninfo *fix,
-			    const void *par, struct fb_info_gen *info);
-static int pm3fb_decode_var(const struct fb_var_screeninfo *var,
-			    void *par, struct fb_info_gen *info);
-static void pm3fb_encode_depth(struct fb_var_screeninfo *var,
long d);
-static int pm3fb_encode_var(struct fb_var_screeninfo *var,
-			    const void *par, struct fb_info_gen *info);
-static void pm3fb_get_par(void *par, struct fb_info_gen *info);
-static void pm3fb_set_par(const void *par, struct fb_info_gen
*info);
-static void pm3fb_set_color(struct pm3fb_info *l_fb_info,
-			    unsigned char regno, unsigned char r,
-			    unsigned char g, unsigned char b);
-static int pm3fb_getcolreg(unsigned regno, unsigned *red,
unsigned *green,
-			   unsigned *blue, unsigned *transp,
-			   struct fb_info *info);
-static int pm3fb_setcolreg(unsigned regno, unsigned red,
unsigned green,
-			   unsigned blue, unsigned transp,
-			   struct fb_info *info);
-static int pm3fb_blank(int blank_mode, struct fb_info_gen *info);
-static void pm3fb_set_disp(const void *par, struct display *disp,
-			   struct fb_info_gen *info);
-static void pm3fb_detect(void);
-static int pm3fb_pan_display(const struct fb_var_screeninfo *var,
-			     struct fb_info_gen *info);
-static int pm3fb_ioctl(struct fb_info *info, u_int cmd, u_long arg);
+/*
+ * Here we define the default structs fb_fix_screeninfo and
fb_var_screeninfo
+ * if we don't use modedb. If we do use modedb see pm3fb_init
how to use it
+ * to get a fb_var_screeninfo. Otherwise define a default var as
well.
+ */
+static struct fb_fix_screeninfo pm3fb_fix __devinitdata =3D {
+	.id =3D		"Permedia3",
+	.type =3D		FB_TYPE_PACKED_PIXELS,
+	.visual =3D	FB_VISUAL_PSEUDOCOLOR,
+	.xpanstep =3D	1,
+	.ypanstep =3D	1,
+	.ywrapstep =3D	0,
+	.accel =3D	FB_ACCEL_NONE,
+};
=20
+/*
+ * Utility functions
+ */
=20
-/* the struct that hold them together */
-struct fbgen_hwswitch pm3fb_switch =3D {
-	pm3fb_detect, pm3fb_encode_fix, pm3fb_decode_var, pm3fb_encode_var,
-	pm3fb_get_par, pm3fb_set_par, pm3fb_getcolreg,=20
-	pm3fb_pan_display, pm3fb_blank, pm3fb_set_disp
-};
+static inline u32 PM3_READ_REG(struct pm3_par *par, s32 off)
+{
+	return fb_readl(par->v_regs + off);
+}
=20
-static struct fb_ops pm3fb_ops =3D {
-	.owner =3D	THIS_MODULE,
-	.fb_get_fix =3D	fbgen_get_fix,
-	.fb_get_var =3D	fbgen_get_var,
-	.fb_set_var =3D	fbgen_set_var,
-	.fb_get_cmap =3D	fbgen_get_cmap,
-	.fb_set_cmap =3D	fbgen_set_cmap,
-	.fb_setcolreg =3D	pm3fb_setcolreg,
-	.fb_pan_display =3Dfbgen_pan_display,
-	.fb_blank =3D	fbgen_blank,
-	.fb_ioctl =3D	pm3fb_ioctl,
-};
+static inline void PM3_WRITE_REG(struct pm3_par *par, s32 off,
u32 v)
+{
+	fb_writel(v, par->v_regs + off);
+}
=20
-#ifdef PM3FB_USE_ACCEL
-#ifdef FBCON_HAS_CFB32
-static struct display_switch pm3fb_cfb32 =3D {
-	fbcon_cfb32_setup, pm3fb_cfbX_bmove, pm3fb_cfb32_clear,
-	pm3fb_cfbX_putc, pm3fb_cfbX_putcs, pm3fb_cfbX_revc,
-	NULL /* cursor() */ , NULL /* set_font() */ ,
-	pm3fb_cfb32_clear_margins,
-	FONTWIDTHRANGE(1, 16)	/* true only if accelerated... */
-};
-#endif /* FBCON_HAS_CFB32 */
-#ifdef FBCON_HAS_CFB16
-static struct display_switch pm3fb_cfb16 =3D {
-	fbcon_cfb16_setup, pm3fb_cfbX_bmove, pm3fb_cfb16_clear,
-	pm3fb_cfbX_putc, pm3fb_cfbX_putcs, pm3fb_cfbX_revc,
-	NULL /* cursor() */ , NULL /* set_font() */ ,
-	pm3fb_cfb16_clear_margins,
-	FONTWIDTHRANGE(1, 16)	/* true only if accelerated... */
-};
-#endif /* FBCON_HAS_CFB16 */
-#ifdef FBCON_HAS_CFB8
-static struct display_switch pm3fb_cfb8 =3D {
-	fbcon_cfb8_setup, pm3fb_cfbX_bmove, pm3fb_cfb8_clear,
-	pm3fb_cfbX_putc, pm3fb_cfbX_putcs, pm3fb_cfbX_revc,
-	NULL /* cursor() */ , NULL /* set_font() */ ,
-	pm3fb_cfb8_clear_margins,
-	FONTWIDTHRANGE(1, 16)	/* true only if accelerated... */
-};
-#endif /* FBCON_HAS_CFB8 */
-#endif /* PM3FB_USE_ACCEL */
+static inline void PM3_WAIT(struct pm3_par *par, u32 n)
+{
+	while (PM3_READ_REG(par, PM3InFIFOSpace) < n);
+}
=20
-/* ****************************** */
-/* ***** card-specific data ***** */
-/* ****************************** */
-struct pm3fb_card_timings {
-	unsigned long memsize; /* 0 for last value (i.e. default) */
-	struct pm3fb_timings memt;
-};
+static inline void PM3_SLOW_WRITE_REG(struct pm3_par *par, s32
off, u32 v)
+{
+	if ( par->v_regs ) {
+		mb();
+		PM3_WAIT(par, 1);
+		wmb();
+		PM3_WRITE_REG(par, off, v);
+	}
+}
=20
-static struct pm3fb_card_timings t_FormacProFormance3[] =3D {
-	{ 16, { 0x02e311b8, 0x06100205, 0x08000002, 0x00000079,
0x00000000} },
-	{ 0, { 0x02e311b8, 0x06100205, 0x08000002, 0x00000079,
0x00000000} } /* from 16 MB PF3 */
-};
+static inline void PM3_SET_INDEX(struct pm3_par *par, unsigned
index)
+{
+	PM3_SLOW_WRITE_REG(par, PM3RD_IndexHigh, (index >> 8 ) & 0xff);
+	PM3_SLOW_WRITE_REG(par, PM3RD_IndexLow, index & 0xff);
+}
=20
-static struct pm3fb_card_timings t_AppianJeronimo2000[] =3D {
-	{ 32, { 0x02e311B8, 0x07424905, 0x0c000003, 0x00000061,
0x00000000} },
-	{ 0, { 0x02e311B8, 0x07424905, 0x0c000003, 0x00000061,
0x00000000} } /* from 32MB J2000 */
-};
+static inline void PM3_WRITE_DAC_REG(struct pm3_par *par,
unsigned r, u8 v)
+{
+	PM3_SET_INDEX(par, r);
+	wmb();
+	PM3_WRITE_REG(par, PM3RD_IndexedData, v);
+}
=20
-static struct pm3fb_card_timings t_3DLabsOxygenVX1[] =3D {
-	{ 32, { 0x30e311b8, 0x08501204, 0x08000002, 0x0000006b,
0x00000000} },
-	{ 0, { 0x30e311b8, 0x08501204, 0x08000002, 0x0000006b,
0x00000000} } /* from 32MB VX1 */
-};
+static inline void pm3fb_set_color(struct pm3_par *par, unsigned
char regno,
+			unsigned char r, unsigned char g, unsigned char b)
+{
+	PM3_SLOW_WRITE_REG(par, PM3RD_PaletteWriteAddress, regno);
+	PM3_SLOW_WRITE_REG(par, PM3RD_PaletteData, r);
+	PM3_SLOW_WRITE_REG(par, PM3RD_PaletteData, g);
+	PM3_SLOW_WRITE_REG(par, PM3RD_PaletteData, b);
+}
=20
-static struct {
-		char cardname[32]; /* recognized card name */
-		u16 subvendor; /* subvendor of the card */
-		u16 subdevice; /* subdevice of the card */
-		u8  func; /* function of the card to which the extra init apply */
-		void (*specific_setup)(struct pm3fb_info *l_fb_info); /*
card/func specific setup, done before _any_ FB access */
-	struct pm3fb_card_timings *c_memt; /* defauls timings for the
boards */
-} cardbase[] =3D {
-	{ "Unknown Permedia3 board", 0xFFFF, 0xFFFF, 0xFF, NULL, NULL },
-	{ "Appian Jeronimo 2000 head 1", 0x1097, 0x3d32, 1, NULL,
-	  t_AppianJeronimo2000
-	},
-	{ "Appian Jeronimo 2000 head 2", 0x1097, 0x3d32, 2,
pm3fb_j2000_setup,
-	  t_AppianJeronimo2000
-	},
-	{ "Formac ProFormance 3", PCI_VENDOR_ID_3DLABS, 0x000a, 0,
NULL, /* Formac use 3DLabs ID ?!? */
-	  t_FormacProFormance3
-	},
-	{ "3DLabs Permedia3 Create!", PCI_VENDOR_ID_3DLABS, 0x0127, 0,
NULL, NULL },
-	{ "3DLabs Oxygen VX1 PCI", PCI_VENDOR_ID_3DLABS, 0x0121, 0, NULL,
-	  t_3DLabsOxygenVX1
-	},
-	{ "3DLabs Oxygen VX1 AGP", PCI_VENDOR_ID_3DLABS, 0x0125, 0,
NULL, NULL },
-	{ "3DLabs Oxygen VX1-16 AGP", PCI_VENDOR_ID_3DLABS, 0x0140, 0,
NULL, NULL },
-	{ "3DLabs Oxygen VX1-1600SW PCI", PCI_VENDOR_ID_3DLABS, 0x0800,
0, NULL, NULL },
-	{ "\0", 0x0, 0x0, 0, NULL, NULL }
-};
+static void pm3fb_clear_memory(struct fb_info *info, u32 cc)
+{
+	int i;
=20
-/* ********************************** */
-/* ***** card-specific function ***** */
-/* ********************************** */
-static void pm3fb_j2000_setup(struct pm3fb_info *l_fb_info)
-{       /* the appian j2000 require more initialization of the
second head */
-	/* l_fb_info must point to the _second_ head of the J2000 */
-=09
-	DTRACE;
-
-	l_fb_info->memt =3D t_AppianJeronimo2000[0].memt; /* 32 MB, first
and only j2000 ? */
-=09
-	pm3fb_write_memory_timings(l_fb_info);
-}
-
-/* *************************************** */
-/* ***** permedia3-specific function ***** */
-/* *************************************** */
-static pm3fb_timing_result pm3fb_preserve_memory_timings(struct
pm3fb_info *l_fb_info)
-{
-	l_fb_info->memt.caps =3D PM3_READ_REG(PM3LocalMemCaps);
-	l_fb_info->memt.timings =3D PM3_READ_REG(PM3LocalMemTimings);
-	l_fb_info->memt.control =3D PM3_READ_REG(PM3LocalMemControl);
-	l_fb_info->memt.refresh =3D PM3_READ_REG(PM3LocalMemRefresh);
-	l_fb_info->memt.powerdown =3D PM3_READ_REG(PM3LocalMemPowerDown);
-
-	if ((l_fb_info->memt.caps =3D=3D PM3FB_UNKNOWN_TIMING_VALUE) ||
-	    (l_fb_info->memt.timings =3D=3D PM3FB_UNKNOWN_TIMING_VALUE) ||
-	    (l_fb_info->memt.control =3D=3D PM3FB_UNKNOWN_TIMING_VALUE) ||
-	    (l_fb_info->memt.refresh =3D=3D PM3FB_UNKNOWN_TIMING_VALUE) ||
-	    (l_fb_info->memt.powerdown =3D=3D PM3FB_UNKNOWN_TIMING_VALUE))
+	for (i =3D 0; i < (info->screen_size / sizeof(u32)) ; i++) /*
clear entire FB memory to black */
 	{
-		printk(KERN_ERR "pm3fb: invalid memory timings in permedia3
board #%ld\n", l_fb_info->board_num);
-		return(pm3fb_try_memory_timings(l_fb_info));
+		fb_writel(cc, (info->screen_base + (i * sizeof(u32))));
 	}
-	return(pm3fb_timing_ok);
 }
=20
-static pm3fb_timing_result pm3fb_try_memory_timings(struct
pm3fb_info *l_fb_info)
+static void pm3fb_clear_colormap(struct pm3_par *par,
+			unsigned char r, unsigned char g, unsigned char b)
 {
-	if (cardbase[l_fb_info->board_type].c_memt)
-	{
-		int i =3D 0, done =3D 0;
-		while (!done)
-		{
-			if ((cardbase[l_fb_info->board_type].c_memt[i].memsize =3D=3D
l_fb_info->fb_size)
-			    || !(cardbase[l_fb_info->board_type].c_memt[i].memsize))
-			{ /* will use the 0-sized timings by default */
-				done =3D 1;
-				l_fb_info->memt =3D
cardbase[l_fb_info->board_type].c_memt[i].memt;
-				printk(KERN_WARNING  "pm3fb: trying to use predefined memory
timings for permedia3 board #%ld (%s, %ld MB)\n",
-				       l_fb_info->board_num,
-				       cardbase[l_fb_info->board_type].cardname,
-				       cardbase[l_fb_info->board_type].c_memt[i].memsize);
-				pm3fb_write_memory_timings(l_fb_info);
-				return(pm3fb_timing_retry);
-			}
-			i++;
-		}
-	} else
-		return(pm3fb_timing_problem);
-	return(pm3fb_timing_ok);
-}
-
-static void pm3fb_write_memory_timings(struct pm3fb_info *l_fb_info)
-{
-	unsigned char m, n, p;
-	unsigned long clockused;
-=09
-	PM3_SLOW_WRITE_REG(PM3LocalMemCaps, l_fb_info->memt.caps);
-	PM3_SLOW_WRITE_REG(PM3LocalMemTimings, l_fb_info->memt.timings);
-	PM3_SLOW_WRITE_REG(PM3LocalMemControl, l_fb_info->memt.control);
-	PM3_SLOW_WRITE_REG(PM3LocalMemRefresh, l_fb_info->memt.refresh);
-	PM3_SLOW_WRITE_REG(PM3LocalMemPowerDown,
l_fb_info->memt.powerdown);
-
-	clockused =3D
-	    pm3fb_CalculateClock(l_fb_info, 2 * 105000, PM3_REF_CLOCK, &m,
-				 &n, &p);
-
-	PM3_WRITE_DAC_REG(PM3RD_KClkPreScale, m);
-	PM3_WRITE_DAC_REG(PM3RD_KClkFeedbackScale, n);
-	PM3_WRITE_DAC_REG(PM3RD_KClkPostScale, p);
-	PM3_WRITE_DAC_REG(PM3RD_KClkControl,
-			  PM3RD_KClkControl_STATE_RUN |
-			  PM3RD_KClkControl_SOURCE_PLL |
-			  PM3RD_KClkControl_ENABLE);
-	PM3_WRITE_DAC_REG(PM3RD_MClkControl,
-			  PM3RD_MClkControl_STATE_RUN |
-			  PM3RD_MClkControl_SOURCE_KCLK |
-			  PM3RD_MClkControl_ENABLE);
-	PM3_WRITE_DAC_REG(PM3RD_SClkControl,
-			  PM3RD_SClkControl_STATE_RUN |
-			  PM3RD_SClkControl_SOURCE_PCLK |
-			  PM3RD_SClkControl_ENABLE);
-}
-
-static unsigned long pm3fb_read_dac_reg(struct pm3fb_info
*l_fb_info,
-					unsigned long r)
-{
-	DASSERT((l_fb_info->vIOBase !=3D (unsigned char *) (-1)),
-		"l_fb_info->vIOBase mapped in read dac reg\n");
-	PM3_SET_INDEX(r);
-	mb();
-	return (PM3_READ_REG(PM3RD_IndexedData));
+	int i;
+
+	for (i =3D 0; i < 256 ; i++) /* fill color map with white */
+		pm3fb_set_color(par, i, r, g, b);
+
 }
=20
 /* Calculating various clock parameter */
-static unsigned long pm3fb_CalculateClock(struct pm3fb_info
*l_fb_info, unsigned long reqclock,	/* In kHz units */
-					  unsigned long refclock,	/* In kHz units */
-					  unsigned char *prescale,	/* ClkPreScale */
-					  unsigned char *feedback,	/* ClkFeedBackScale */
-					  unsigned char *postscale
-					  /* ClkPostScale */ )
+static void pm3fb_calculate_clock(unsigned long reqclock,
+				unsigned char *prescale,
+				unsigned char *feedback,
+				unsigned char *postscale)
 {
 	int f, pre, post;
 	unsigned long freq;
 	long freqerr =3D 1000;
-	unsigned long actualclock =3D 0;
-
-	DTRACE;
+	long currerr;
=20
 	for (f =3D 1; f < 256; f++) {
 		for (pre =3D 1; pre < 256; pre++) {
 			for (post =3D 0; post < 5; post++) {
-				freq =3D
-				    ((2 * refclock * f) /
-				     (pre * (1 << post)));
-				if ((reqclock > freq - freqerr)
-				    && (reqclock < freq + freqerr)) {
-					freqerr =3D
-					    (reqclock >
-					     freq) ? reqclock -
-					    freq : freq - reqclock;
+				freq =3D ((2*PM3_REF_CLOCK * f) >> post) / pre;
+				currerr =3D (reqclock > freq)
+					? reqclock - freq
+					: freq - reqclock;
+				if (currerr < freqerr) {
+					freqerr =3D currerr;
 					*feedback =3D f;
 					*prescale =3D pre;
 					*postscale =3D post;
-					actualclock =3D freq;
 				}
 			}
 		}
 	}
-
-	return (actualclock);
 }
=20
-static int pm3fb_Shiftbpp(struct pm3fb_info *l_fb_info,
-			  unsigned long depth, int v)
+static inline int pm3fb_shift_bpp(unsigned long depth, int v)
 {
-	DTRACE;
-=09
 	switch (depth) {
 	case 8:
 		return (v >> 4);
@@ -918,181 +197,59 @@ static int pm3fb_Shiftbpp(struct pm3fb_i
 	case 32:
 		return (v >> 2);
 	}
-	DPRINTK(1, "Unsupported depth %ld\n", depth);
-	return (0);
-}
-
-static int pm3fb_Unshiftbpp(struct pm3fb_info *l_fb_info,
-			    unsigned long depth, int v)
-{
-	DTRACE;
-
-	switch (depth) {
-	case 8:
-		return (v << 4);
-	case 12:=09
-	case 15:
-	case 16:
-		return (v << 3);
-	case 32:
-		return (v << 2);
-	}
-	DPRINTK(1, "Unsupported depth %ld\n", depth);
-	return (0);
-}
-
-static void pm3fb_mapIO(struct pm3fb_info *l_fb_info)
-{
-	DTRACE;
-
-	l_fb_info->vIOBase =3D
-	    ioremap((unsigned long) l_fb_info->pIOBase, PM3_REGS_SIZE);
-	l_fb_info->v_fb =3D
-	    ioremap((unsigned long) l_fb_info->p_fb, l_fb_info->fb_size);
-	DPRINTK(2, "IO mapping : IOBase %lx / %lx, fb %lx / %lx\n",
-		(unsigned long) l_fb_info->pIOBase,
-		(unsigned long) l_fb_info->vIOBase,
-		(unsigned long) l_fb_info->p_fb,
-		(unsigned long) l_fb_info->v_fb);
-}
-
-static void pm3fb_unmapIO(struct pm3fb_info *l_fb_info)
-{
-	DTRACE;
-
-	iounmap(l_fb_info->vIOBase);
-	iounmap(l_fb_info->v_fb);
-	l_fb_info->vIOBase =3D (unsigned char *) -1;
-	l_fb_info->v_fb =3D (unsigned char *) -1;
-}
-
-#if defined(PM3FB_MASTER_DEBUG) && (PM3FB_MASTER_DEBUG >=3D 2)
-static void pm3fb_show_cur_mode(struct pm3fb_info *l_fb_info)
-{
-	DPRINTK(2, "PM3Aperture0: 0x%08x\n", PM3_READ_REG(PM3Aperture0));
-	DPRINTK(2, "PM3Aperture1: 0x%08x\n", PM3_READ_REG(PM3Aperture1));
-	DPRINTK(2, "PM3ByAperture1Mode: 0x%08x\n",
-		PM3_READ_REG(PM3ByAperture1Mode));
-	DPRINTK(2, "PM3ByAperture2Mode: 0x%08x\n",
-		PM3_READ_REG(PM3ByAperture2Mode));
-	DPRINTK(2, "PM3ChipConfig: 0x%08x\n", PM3_READ_REG(PM3ChipConfig));
-	DPRINTK(2, "PM3FIFODis: 0x%08x\n", PM3_READ_REG(PM3FIFODis));
-	DPRINTK(2, "PM3HTotal: 0x%08x\n", PM3_READ_REG(PM3HTotal));
-	DPRINTK(2, "PM3HbEnd: 0x%08x\n", PM3_READ_REG(PM3HbEnd));
-	DPRINTK(2, "PM3HgEnd: 0x%08x\n", PM3_READ_REG(PM3HgEnd));
-	DPRINTK(2, "PM3HsEnd: 0x%08x\n", PM3_READ_REG(PM3HsEnd));
-	DPRINTK(2, "PM3HsStart: 0x%08x\n", PM3_READ_REG(PM3HsStart));
-	DPRINTK(2, "PM3MemBypassWriteMask: 0x%08x\n",
-		PM3_READ_REG(PM3MemBypassWriteMask));
-	DPRINTK(2, "PM3RD_IndexControl: 0x%08x\n",
-		PM3_READ_REG(PM3RD_IndexControl));
-	DPRINTK(2, "PM3ScreenBase: 0x%08x\n", PM3_READ_REG(PM3ScreenBase));
-	DPRINTK(2, "PM3ScreenStride: 0x%08x\n",
-		PM3_READ_REG(PM3ScreenStride));
-	DPRINTK(2, "PM3VClkCtl: 0x%08x\n", PM3_READ_REG(PM3VClkCtl));
-	DPRINTK(2, "PM3VTotal: 0x%08x\n", PM3_READ_REG(PM3VTotal));
-	DPRINTK(2, "PM3VbEnd: 0x%08x\n", PM3_READ_REG(PM3VbEnd));
-	DPRINTK(2, "PM3VideoControl: 0x%08x\n",
-		PM3_READ_REG(PM3VideoControl));
-	DPRINTK(2, "PM3VsEnd: 0x%08x\n", PM3_READ_REG(PM3VsEnd));
-	DPRINTK(2, "PM3VsStart: 0x%08x\n", PM3_READ_REG(PM3VsStart));
-
-	DPRINTK(2, "PM3RD_ColorFormat: %ld\n",
-		PM3_READ_DAC_REG(PM3RD_ColorFormat));
-	DPRINTK(2, "PM3RD_DACControl: %ld\n",
-		PM3_READ_DAC_REG(PM3RD_DACControl));
-	DPRINTK(2, "PM3RD_DClk0FeedbackScale: %ld\n",
-		PM3_READ_DAC_REG(PM3RD_DClk0FeedbackScale));
-	DPRINTK(2, "PM3RD_DClk0PostScale: %ld\n",
-		PM3_READ_DAC_REG(PM3RD_DClk0PostScale));
-	DPRINTK(2, "PM3RD_DClk0PreScale: %ld\n",
-		PM3_READ_DAC_REG(PM3RD_DClk0PreScale));
-	DPRINTK(2, "[not set] PM3RD_IndexControl: %ld\n",
-		PM3_READ_DAC_REG(PM3RD_IndexControl));
-	DPRINTK(2, "PM3RD_MiscControl: %ld\n",
-		PM3_READ_DAC_REG(PM3RD_MiscControl));
-	DPRINTK(2, "PM3RD_PixelSize: %ld\n",
-		PM3_READ_DAC_REG(PM3RD_PixelSize));
-	DPRINTK(2, "PM3RD_SyncControl: %ld\n",
-		PM3_READ_DAC_REG(PM3RD_SyncControl));
-}
-
-#endif /* defined(PM3FB_MASTER_DEBUG) && (PM3FB_MASTER_DEBUG >=3D
2) */
-static void pm3fb_show_cur_timing(struct pm3fb_info *l_fb_info)
-{
-	u16 subvendor, subdevice;
-
-	if ((!pci_read_config_word
-	     (l_fb_info->dev, PCI_SUBSYSTEM_VENDOR_ID, &subvendor))
-	    &&
-	    (!pci_read_config_word
-	     (l_fb_info->dev, PCI_SUBSYSTEM_ID, &subdevice))) {
-		/* well, nothing... */
-	} else {
-		subvendor =3D subdevice =3D (u16)-1;
-	}
-
-	printk(KERN_INFO "pm3fb: memory timings for board #%ld
(subvendor: 0x%hx, subdevice: 0x%hx)\n", l_fb_info->board_num,
subvendor, subdevice);
-	printk(KERN_INFO " PM3LocalMemCaps: 0x%08x\n",
-	       PM3_READ_REG(PM3LocalMemCaps));
-	printk(KERN_INFO " PM3LocalMemTimings: 0x%08x\n",
-	       PM3_READ_REG(PM3LocalMemTimings));
-	printk(KERN_INFO " PM3LocalMemControl: 0x%08x\n",
-	       PM3_READ_REG(PM3LocalMemControl));
-	printk(KERN_INFO " PM3LocalMemRefresh: 0x%08x\n",
-	       PM3_READ_REG(PM3LocalMemRefresh));
-	printk(KERN_INFO " PM3LocalMemPowerDown: 0x%08x\n",
-	       PM3_READ_REG(PM3LocalMemPowerDown));
+	DPRINTK("Unsupported depth %ld\n", depth);
+	return 0;
 }
=20
 /* write the mode to registers */
-static void pm3fb_write_mode(struct pm3fb_info *l_fb_info)
+static void pm3fb_write_mode(struct fb_info *info)
 {
+	struct pm3_par *par =3D info->par;
 	char tempsync =3D 0x00, tempmisc =3D 0x00;
-	DTRACE;
-
-	PM3_SLOW_WRITE_REG(PM3MemBypassWriteMask, 0xffffffff);
-	PM3_SLOW_WRITE_REG(PM3Aperture0, 0x00000000);
-	PM3_SLOW_WRITE_REG(PM3Aperture1, 0x00000000);
-	PM3_SLOW_WRITE_REG(PM3FIFODis, 0x00000007);
-
-	PM3_SLOW_WRITE_REG(PM3HTotal,
-			   pm3fb_Shiftbpp(l_fb_info,
-					  l_fb_info->current_par->depth,
-					  l_fb_info->current_par->htotal -
-					  1));
-	PM3_SLOW_WRITE_REG(PM3HsEnd,
-			   pm3fb_Shiftbpp(l_fb_info,
-					  l_fb_info->current_par->depth,
-					  l_fb_info->current_par->hsend));
-	PM3_SLOW_WRITE_REG(PM3HsStart,
-			   pm3fb_Shiftbpp(l_fb_info,
-					  l_fb_info->current_par->depth,
-					  l_fb_info->current_par->
+	const u32 hsstart =3D info->var.right_margin;
+	const u32 hsend =3D hsstart + info->var.hsync_len;
+	const u32 hbend =3D hsend + info->var.left_margin;
+	const u32 xres =3D (info->var.xres + 31) & ~31;
+	const u32 htotal =3D xres + hbend;
+	const u32 vsstart =3D info->var.lower_margin;
+	const u32 vsend =3D vsstart + info->var.vsync_len;
+	const u32 vbend =3D vsend + info->var.upper_margin;
+	const u32 vtotal =3D info->var.yres + vbend;
+	const u32 width =3D (info->var.xres_virtual + 7) & ~7;
+
+	PM3_SLOW_WRITE_REG(par, PM3MemBypassWriteMask, 0xffffffff);
+	PM3_SLOW_WRITE_REG(par, PM3Aperture0, 0x00000000);
+	PM3_SLOW_WRITE_REG(par, PM3Aperture1, 0x00000000);
+	PM3_SLOW_WRITE_REG(par, PM3FIFODis, 0x00000007);
+
+	PM3_SLOW_WRITE_REG(par, PM3HTotal,
+			   pm3fb_shift_bpp(info->var.bits_per_pixel,
+					  htotal - 1));
+	PM3_SLOW_WRITE_REG(par, PM3HsEnd,
+			   pm3fb_shift_bpp(info->var.bits_per_pixel,
+					  hsend));
+	PM3_SLOW_WRITE_REG(par, PM3HsStart,
+			   pm3fb_shift_bpp(info->var.bits_per_pixel,
 					  hsstart));
-	PM3_SLOW_WRITE_REG(PM3HbEnd,
-			   pm3fb_Shiftbpp(l_fb_info,
-					  l_fb_info->current_par->depth,
-					  l_fb_info->current_par->hbend));
-	PM3_SLOW_WRITE_REG(PM3HgEnd,
-			   pm3fb_Shiftbpp(l_fb_info,
-					  l_fb_info->current_par->depth,
-					  l_fb_info->current_par->hbend));
-	PM3_SLOW_WRITE_REG(PM3ScreenStride,
-			   pm3fb_Shiftbpp(l_fb_info,
-					  l_fb_info->current_par->depth,
-					  l_fb_info->current_par->stride));
-	PM3_SLOW_WRITE_REG(PM3VTotal, l_fb_info->current_par->vtotal - 1);
-	PM3_SLOW_WRITE_REG(PM3VsEnd, l_fb_info->current_par->vsend - 1);
-	PM3_SLOW_WRITE_REG(PM3VsStart,
-			   l_fb_info->current_par->vsstart - 1);
-	PM3_SLOW_WRITE_REG(PM3VbEnd, l_fb_info->current_par->vbend);
+	PM3_SLOW_WRITE_REG(par, PM3HbEnd,
+			   pm3fb_shift_bpp(info->var.bits_per_pixel,
+					  hbend));
+	PM3_SLOW_WRITE_REG(par, PM3HgEnd,
+			   pm3fb_shift_bpp(info->var.bits_per_pixel,
+					  hbend));
+	PM3_SLOW_WRITE_REG(par, PM3ScreenStride,
+			   pm3fb_shift_bpp(info->var.bits_per_pixel,
+					  width));
+	PM3_SLOW_WRITE_REG(par, PM3VTotal, vtotal - 1);
+	PM3_SLOW_WRITE_REG(par, PM3VsEnd, vsend - 1);
+	PM3_SLOW_WRITE_REG(par, PM3VsStart, vsstart - 1);
+	PM3_SLOW_WRITE_REG(par, PM3VbEnd, vbend);
=20
-	switch (l_fb_info->current_par->depth) {
+	switch (info->var.bits_per_pixel) {
 	case 8:
-		PM3_SLOW_WRITE_REG(PM3ByAperture1Mode,
+		PM3_SLOW_WRITE_REG(par, PM3ByAperture1Mode,
 				   PM3ByApertureMode_PIXELSIZE_8BIT);
-		PM3_SLOW_WRITE_REG(PM3ByAperture2Mode,
+		PM3_SLOW_WRITE_REG(par, PM3ByAperture2Mode,
 				   PM3ByApertureMode_PIXELSIZE_8BIT);
 		break;
=20
@@ -1100,15 +257,15 @@ static void pm3fb_write_mode(struct pm3f
 	case 15:
 	case 16:
 #ifndef __BIG_ENDIAN
-		PM3_SLOW_WRITE_REG(PM3ByAperture1Mode,
+		PM3_SLOW_WRITE_REG(par, PM3ByAperture1Mode,
 				   PM3ByApertureMode_PIXELSIZE_16BIT);
-		PM3_SLOW_WRITE_REG(PM3ByAperture2Mode,
+		PM3_SLOW_WRITE_REG(par, PM3ByAperture2Mode,
 				   PM3ByApertureMode_PIXELSIZE_16BIT);
 #else
-		PM3_SLOW_WRITE_REG(PM3ByAperture1Mode,
+		PM3_SLOW_WRITE_REG(par, PM3ByAperture1Mode,
 				   PM3ByApertureMode_PIXELSIZE_16BIT |
 				   PM3ByApertureMode_BYTESWAP_BADC);
-		PM3_SLOW_WRITE_REG(PM3ByAperture2Mode,
+		PM3_SLOW_WRITE_REG(par, PM3ByAperture2Mode,
 				   PM3ByApertureMode_PIXELSIZE_16BIT |
 				   PM3ByApertureMode_BYTESWAP_BADC);
 #endif /* ! __BIG_ENDIAN */
@@ -1116,23 +273,23 @@ static void pm3fb_write_mode(struct pm3f
=20
 	case 32:
 #ifndef __BIG_ENDIAN
-		PM3_SLOW_WRITE_REG(PM3ByAperture1Mode,
+		PM3_SLOW_WRITE_REG(par, PM3ByAperture1Mode,
 				   PM3ByApertureMode_PIXELSIZE_32BIT);
-		PM3_SLOW_WRITE_REG(PM3ByAperture2Mode,
+		PM3_SLOW_WRITE_REG(par, PM3ByAperture2Mode,
 				   PM3ByApertureMode_PIXELSIZE_32BIT);
 #else
-		PM3_SLOW_WRITE_REG(PM3ByAperture1Mode,
+		PM3_SLOW_WRITE_REG(par, PM3ByAperture1Mode,
 				   PM3ByApertureMode_PIXELSIZE_32BIT |
 				   PM3ByApertureMode_BYTESWAP_DCBA);
-		PM3_SLOW_WRITE_REG(PM3ByAperture2Mode,
+		PM3_SLOW_WRITE_REG(par, PM3ByAperture2Mode,
 				   PM3ByApertureMode_PIXELSIZE_32BIT |
 				   PM3ByApertureMode_BYTESWAP_DCBA);
 #endif /* ! __BIG_ENDIAN */
 		break;
=20
 	default:
-		DPRINTK(1, "Unsupported depth %d\n",
-			l_fb_info->current_par->depth);
+		DPRINTK("Unsupported depth %d\n",
+			info->var.bits_per_pixel);
 		break;
 	}
=20
@@ -1143,95 +300,86 @@ static void pm3fb_write_mode(struct pm3f
 	 * sync options in PM3RD_SyncControl.  --rmk
 	 */
 	{
-		unsigned int video =3D l_fb_info->current_par->video;
+		unsigned int video =3D par->video;
=20
 		video &=3D ~(PM3VideoControl_HSYNC_MASK |
 			   PM3VideoControl_VSYNC_MASK);
 		video |=3D PM3VideoControl_HSYNC_ACTIVE_HIGH |
 			 PM3VideoControl_VSYNC_ACTIVE_HIGH;
-		PM3_SLOW_WRITE_REG(PM3VideoControl, video);
+		PM3_SLOW_WRITE_REG(par, PM3VideoControl, video);
 	}
-	PM3_SLOW_WRITE_REG(PM3VClkCtl,
-			   (PM3_READ_REG(PM3VClkCtl) & 0xFFFFFFFC));
-	PM3_SLOW_WRITE_REG(PM3ScreenBase, l_fb_info->current_par->base);
-	PM3_SLOW_WRITE_REG(PM3ChipConfig,
-			   (PM3_READ_REG(PM3ChipConfig) & 0xFFFFFFFD));
+	PM3_SLOW_WRITE_REG(par, PM3VClkCtl,
+			   (PM3_READ_REG(par, PM3VClkCtl) & 0xFFFFFFFC));
+	PM3_SLOW_WRITE_REG(par, PM3ScreenBase, par->base);
+	PM3_SLOW_WRITE_REG(par, PM3ChipConfig,
+			   (PM3_READ_REG(par, PM3ChipConfig) & 0xFFFFFFFD));
=20
 	{
 		unsigned char m;	/* ClkPreScale */
 		unsigned char n;	/* ClkFeedBackScale */
 		unsigned char p;	/* ClkPostScale */
-		(void)pm3fb_CalculateClock(l_fb_info,
l_fb_info->current_par->pixclock, PM3_REF_CLOCK, &m, &n, &p);
+		unsigned long pixclock =3D PICOS2KHZ(info->var.pixclock);
+
+		(void)pm3fb_calculate_clock(pixclock, &m, &n, &p);
+
+		DPRINTK("Pixclock: %ld, Pre: %d, Feedback: %d, Post: %d\n",
+			pixclock, (int) m, (int) n, (int) p);
=20
-		DPRINTK(2,
-			"Pixclock: %d, Pre: %d, Feedback: %d, Post: %d\n",
-			l_fb_info->current_par->pixclock, (int) m, (int) n,
-			(int) p);
-
-		PM3_WRITE_DAC_REG(PM3RD_DClk0PreScale, m);
-		PM3_WRITE_DAC_REG(PM3RD_DClk0FeedbackScale, n);
-		PM3_WRITE_DAC_REG(PM3RD_DClk0PostScale, p);
+		PM3_WRITE_DAC_REG(par, PM3RD_DClk0PreScale, m);
+		PM3_WRITE_DAC_REG(par, PM3RD_DClk0FeedbackScale, n);
+		PM3_WRITE_DAC_REG(par, PM3RD_DClk0PostScale, p);
 	}
 	/*
-	   PM3_WRITE_DAC_REG(PM3RD_IndexControl, 0x00);
+	   PM3_WRITE_DAC_REG(par, PM3RD_IndexControl, 0x00);
 	 */
 	/*
-	   PM3_SLOW_WRITE_REG(PM3RD_IndexControl, 0x00);
+	   PM3_SLOW_WRITE_REG(par, PM3RD_IndexControl, 0x00);
 	 */
-	if ((l_fb_info->current_par->video & PM3VideoControl_HSYNC_MASK) =3D=3D
+	if ((par->video & PM3VideoControl_HSYNC_MASK) =3D=3D
 	    PM3VideoControl_HSYNC_ACTIVE_HIGH)
 		tempsync |=3D PM3RD_SyncControl_HSYNC_ACTIVE_HIGH;
-	if ((l_fb_info->current_par->video & PM3VideoControl_VSYNC_MASK) =3D=3D
+	if ((par->video & PM3VideoControl_VSYNC_MASK) =3D=3D
 	    PM3VideoControl_VSYNC_ACTIVE_HIGH)
 		tempsync |=3D PM3RD_SyncControl_VSYNC_ACTIVE_HIGH;
-=09
-	PM3_WRITE_DAC_REG(PM3RD_SyncControl, tempsync);
-	DPRINTK(2, "PM3RD_SyncControl: %d\n", tempsync);
-=09
-	if (flatpanel[l_fb_info->board_num])
-	{
-		PM3_WRITE_DAC_REG(PM3RD_DACControl,
PM3RD_DACControl_BLANK_PEDESTAL_ENABLE);
-		PM3_WAIT(2);
-		PM3_WRITE_REG(PM3VSConfiguration, 0x06);
-		PM3_WRITE_REG(0x5a00, 1 << 14); /* black magic... */
-		tempmisc =3D PM3RD_MiscControl_VSB_OUTPUT_ENABLE;
-	}
-	else
-		PM3_WRITE_DAC_REG(PM3RD_DACControl, 0x00);
=20
-	switch (l_fb_info->current_par->depth) {
+	PM3_WRITE_DAC_REG(par, PM3RD_SyncControl, tempsync);
+	DPRINTK("PM3RD_SyncControl: %d\n", tempsync);
+
+	PM3_WRITE_DAC_REG(par, PM3RD_DACControl, 0x00);
+
+	switch (info->var.bits_per_pixel) {
 	case 8:
-		PM3_WRITE_DAC_REG(PM3RD_PixelSize,
+		PM3_WRITE_DAC_REG(par, PM3RD_PixelSize,
 				  PM3RD_PixelSize_8_BIT_PIXELS);
-		PM3_WRITE_DAC_REG(PM3RD_ColorFormat,
+		PM3_WRITE_DAC_REG(par, PM3RD_ColorFormat,
 				  PM3RD_ColorFormat_CI8_COLOR |
 				  PM3RD_ColorFormat_COLOR_ORDER_BLUE_LOW);
 		tempmisc |=3D PM3RD_MiscControl_HIGHCOLOR_RES_ENABLE;
 		break;
 	case 12:
-		PM3_WRITE_DAC_REG(PM3RD_PixelSize,
+		PM3_WRITE_DAC_REG(par, PM3RD_PixelSize,
 				  PM3RD_PixelSize_16_BIT_PIXELS);
-		PM3_WRITE_DAC_REG(PM3RD_ColorFormat,
+		PM3_WRITE_DAC_REG(par, PM3RD_ColorFormat,
 				  PM3RD_ColorFormat_4444_COLOR |
 				  PM3RD_ColorFormat_COLOR_ORDER_BLUE_LOW |
 				  PM3RD_ColorFormat_LINEAR_COLOR_EXT_ENABLE);
 		tempmisc |=3D PM3RD_MiscControl_DIRECTCOLOR_ENABLE |
 			PM3RD_MiscControl_HIGHCOLOR_RES_ENABLE;
-		break;	=09
+		break;
 	case 15:
-		PM3_WRITE_DAC_REG(PM3RD_PixelSize,
+		PM3_WRITE_DAC_REG(par, PM3RD_PixelSize,
 				  PM3RD_PixelSize_16_BIT_PIXELS);
-		PM3_WRITE_DAC_REG(PM3RD_ColorFormat,
+		PM3_WRITE_DAC_REG(par, PM3RD_ColorFormat,
 				  PM3RD_ColorFormat_5551_FRONT_COLOR |
 				  PM3RD_ColorFormat_COLOR_ORDER_BLUE_LOW |
 				  PM3RD_ColorFormat_LINEAR_COLOR_EXT_ENABLE);
 		tempmisc |=3D PM3RD_MiscControl_DIRECTCOLOR_ENABLE |
 			PM3RD_MiscControl_HIGHCOLOR_RES_ENABLE;
-		break;	=09
+		break;
 	case 16:
-		PM3_WRITE_DAC_REG(PM3RD_PixelSize,
+		PM3_WRITE_DAC_REG(par, PM3RD_PixelSize,
 				  PM3RD_PixelSize_16_BIT_PIXELS);
-		PM3_WRITE_DAC_REG(PM3RD_ColorFormat,
+		PM3_WRITE_DAC_REG(par, PM3RD_ColorFormat,
 				  PM3RD_ColorFormat_565_FRONT_COLOR |
 				  PM3RD_ColorFormat_COLOR_ORDER_BLUE_LOW |
 				  PM3RD_ColorFormat_LINEAR_COLOR_EXT_ENABLE);
@@ -1239,1936 +387,280 @@ static void pm3fb_write_mode(struct pm3f
 			PM3RD_MiscControl_HIGHCOLOR_RES_ENABLE;
 		break;
 	case 32:
-		PM3_WRITE_DAC_REG(PM3RD_PixelSize,
+		PM3_WRITE_DAC_REG(par, PM3RD_PixelSize,
 				  PM3RD_PixelSize_32_BIT_PIXELS);
-		PM3_WRITE_DAC_REG(PM3RD_ColorFormat,
+		PM3_WRITE_DAC_REG(par, PM3RD_ColorFormat,
 				  PM3RD_ColorFormat_8888_COLOR |
 				  PM3RD_ColorFormat_COLOR_ORDER_BLUE_LOW);
 		tempmisc |=3D PM3RD_MiscControl_DIRECTCOLOR_ENABLE |
 			PM3RD_MiscControl_HIGHCOLOR_RES_ENABLE;
 		break;
 	}
-	PM3_WRITE_DAC_REG(PM3RD_MiscControl, tempmisc);
-=09
-	PM3_SHOW_CUR_MODE;
+	PM3_WRITE_DAC_REG(par, PM3RD_MiscControl, tempmisc);
 }
=20
-static void pm3fb_read_mode(struct pm3fb_info *l_fb_info,
-			    struct pm3fb_par *curpar)
-{
-	unsigned long pixsize1, pixsize2, clockused;
-	unsigned long pre, feedback, post;
-
-	DTRACE;
-
-	clockused =3D PM3_READ_REG(PM3VClkCtl);
+/*
+ * hardware independent functions
+ */
+int pm3fb_init(void);
+int pm3fb_setup(char*);
=20
-	switch (clockused) {
-	case 3:
-		pre =3D PM3_READ_DAC_REG(PM3RD_DClk3PreScale);
-		feedback =3D PM3_READ_DAC_REG(PM3RD_DClk3FeedbackScale);
-		post =3D PM3_READ_DAC_REG(PM3RD_DClk3PostScale);
+static int pm3fb_check_var(struct fb_var_screeninfo *var, struct
fb_info *info)
+{
+	u32 lpitch;
=20
-		DPRINTK(2,
-			"DClk3 parameter: Pre: %ld, Feedback: %ld, Post: %ld ; giving
pixclock: %ld\n",
-			pre, feedback, post, PM3_SCALE_TO_CLOCK(pre,
-								feedback,
-								post));
+	var->transp.offset =3D 0;
+	var->transp.length =3D 0;
+	switch(var->bits_per_pixel) {
+	case 8:
+		var->red.length =3D var->green.length =3D var->blue.length =3D 8;
+		var->red.offset =3D var->green.offset =3D var->blue.offset =3D 0;
 		break;
-	case 2:
-		pre =3D PM3_READ_DAC_REG(PM3RD_DClk2PreScale);
-		feedback =3D PM3_READ_DAC_REG(PM3RD_DClk2FeedbackScale);
-		post =3D PM3_READ_DAC_REG(PM3RD_DClk2PostScale);
-
-		DPRINTK(2,
-			"DClk2 parameter: Pre: %ld, Feedback: %ld, Post: %ld ; giving
pixclock: %ld\n",
-			pre, feedback, post, PM3_SCALE_TO_CLOCK(pre,
-								feedback,
-								post));
+	case 12:
+		var->red.offset   =3D 8;
+		var->red.length   =3D 4;
+		var->green.offset =3D 4;
+		var->green.length =3D 4;
+		var->blue.offset  =3D 0;
+		var->blue.length  =3D 4;
+		var->transp.offset =3D 12;
+		var->transp.length =3D 4;
+	case 15:
+		var->red.offset   =3D 10;
+		var->red.length   =3D 5;
+		var->green.offset =3D 5;
+		var->green.length =3D 5;
+		var->blue.offset  =3D 0;
+		var->blue.length  =3D 5;
+		var->transp.offset =3D 15;
+		var->transp.length =3D 1;
 		break;
-	case 1:
-		pre =3D PM3_READ_DAC_REG(PM3RD_DClk1PreScale);
-		feedback =3D PM3_READ_DAC_REG(PM3RD_DClk1FeedbackScale);
-		post =3D PM3_READ_DAC_REG(PM3RD_DClk1PostScale);
-
-		DPRINTK(2,
-			"DClk1 parameter: Pre: %ld, Feedback: %ld, Post: %ld ; giving
pixclock: %ld\n",
-			pre, feedback, post, PM3_SCALE_TO_CLOCK(pre,
-								feedback,
-								post));
+	case 16:
+		var->red.offset   =3D 11;
+		var->red.length   =3D 5;
+		var->green.offset =3D 5;
+		var->green.length =3D 6;
+		var->blue.offset  =3D 0;
+		var->blue.length  =3D 5;
 		break;
-	case 0:
-		pre =3D PM3_READ_DAC_REG(PM3RD_DClk0PreScale);
-		feedback =3D PM3_READ_DAC_REG(PM3RD_DClk0FeedbackScale);
-		post =3D PM3_READ_DAC_REG(PM3RD_DClk0PostScale);
-
-		DPRINTK(2,
-			"DClk0 parameter: Pre: %ld, Feedback: %ld, Post: %ld ; giving
pixclock: %ld\n",
-			pre, feedback, post, PM3_SCALE_TO_CLOCK(pre,
-								feedback,
-								post));
+	case 32:
+		var->transp.offset =3D 24;
+		var->transp.length =3D 8;
+		var->red.offset	  =3D 16;
+		var->green.offset =3D 8;
+		var->blue.offset  =3D 0;
+		var->red.length =3D var->green.length =3D var->blue.length =3D 8;
 		break;
 	default:
-		pre =3D feedback =3D post =3D 0;
-		DPRINTK(1, "Unknowk D clock used : %ld\n", clockused);
-		break;
+		DPRINTK("depth not supported: %u\n", var->bits_per_pixel);
+		return -EINVAL;
 	}
+	var->height =3D var->width =3D -1;
=20
-	curpar->pixclock =3D PM3_SCALE_TO_CLOCK(pre, feedback, post);
-
-	pixsize1 =3D
-	    PM3ByApertureMode_PIXELSIZE_MASK &
-	    (PM3_READ_REG(PM3ByAperture1Mode));
-	pixsize2 =3D
-	    PM3ByApertureMode_PIXELSIZE_MASK &
-	    (PM3_READ_REG(PM3ByAperture2Mode));
-
-	DASSERT((pixsize1 =3D=3D pixsize2),
-		"pixsize the same in both aperture\n");
-
-	if (pixsize1 & PM3ByApertureMode_PIXELSIZE_32BIT)
-		curpar->depth =3D 32;
-	else if (pixsize1 & PM3ByApertureMode_PIXELSIZE_16BIT)
-	{
-		curpar->depth =3D 16;
+	if (var->xres !=3D var->xres_virtual) {
+		DPRINTK("virtual x resolution !=3D physical x resolution not
supported\n");
+		return -EINVAL;
 	}
-	else
-		curpar->depth =3D 8;
=20
-	/* not sure if I need to add one on the next ; it give better
result with */
-	curpar->htotal =3D
-	    pm3fb_Unshiftbpp(l_fb_info, curpar->depth,
-			     1 + PM3_READ_REG(PM3HTotal));
-	curpar->hsend =3D
-	    pm3fb_Unshiftbpp(l_fb_info, curpar->depth,
-			     PM3_READ_REG(PM3HsEnd));
-	curpar->hsstart =3D
-	    pm3fb_Unshiftbpp(l_fb_info, curpar->depth,
-			     PM3_READ_REG(PM3HsStart));
-	curpar->hbend =3D
-	    pm3fb_Unshiftbpp(l_fb_info, curpar->depth,
-			     PM3_READ_REG(PM3HbEnd));
-
-	curpar->stride =3D
-	    pm3fb_Unshiftbpp(l_fb_info, curpar->depth,
-			     PM3_READ_REG(PM3ScreenStride));
-
-	curpar->vtotal =3D 1 + PM3_READ_REG(PM3VTotal);
-	curpar->vsend =3D 1 + PM3_READ_REG(PM3VsEnd);
-	curpar->vsstart =3D 1 + PM3_READ_REG(PM3VsStart);
-	curpar->vbend =3D PM3_READ_REG(PM3VbEnd);
-
-	curpar->video =3D PM3_READ_REG(PM3VideoControl);
-
-	curpar->base =3D PM3_READ_REG(PM3ScreenBase);
-	curpar->width =3D curpar->htotal - curpar->hbend; /* make virtual
=3D=3D displayed resolution */
-	curpar->height =3D curpar->vtotal - curpar->vbend;
-
-	DPRINTK(2, "Found : %d * %d, %d Khz, stride is %08x\n",
-		curpar->width, curpar->height, curpar->pixclock,
-		curpar->stride);
-}
-
-static unsigned long pm3fb_size_memory(struct pm3fb_info *l_fb_info)
-{
-	unsigned long memsize =3D 0, tempBypass, i, temp1, temp2;
-	u16 subvendor, subdevice;
-	pm3fb_timing_result ptr;
-
-	DTRACE;
-
-	l_fb_info->fb_size =3D 64 * 1024 * 1024;	/* pm3 aperture always
64 MB */
-	pm3fb_mapIO(l_fb_info);	/* temporary map IO */
-
-	DASSERT((l_fb_info->vIOBase !=3D NULL),
-		"IO successfully mapped before mem detect\n");
-	DASSERT((l_fb_info->v_fb !=3D NULL),
-		"FB successfully mapped before mem detect\n");
-
-	/* card-specific stuff, *before* accessing *any* FB memory */
-	if ((!pci_read_config_word
-	     (l_fb_info->dev, PCI_SUBSYSTEM_VENDOR_ID, &subvendor))
-	    &&
-	    (!pci_read_config_word
-	     (l_fb_info->dev, PCI_SUBSYSTEM_ID, &subdevice))) {
-		i =3D 0; l_fb_info->board_type =3D 0;
-		while ((cardbase[i].cardname[0]) && !(l_fb_info->board_type)) {
-			if ((cardbase[i].subvendor =3D=3D subvendor) &&
-			    (cardbase[i].subdevice =3D=3D subdevice) &&
-			    (cardbase[i].func =3D=3D PCI_FUNC(l_fb_info->dev->devfn))) {
-				DPRINTK(2, "Card #%ld is an %s\n",
-					l_fb_info->board_num,
-					cardbase[i].cardname);
-				if (cardbase[i].specific_setup)
-					cardbase[i].specific_setup(l_fb_info);
-				l_fb_info->board_type =3D i;
-			}
-			i++;
-		}
-		if (!l_fb_info->board_type) {
-			DPRINTK(1, "Card #%ld is an unknown 0x%04x / 0x%04x\n",
-				l_fb_info->board_num, subvendor, subdevice);
-		}
-	} else {
-		printk(KERN_ERR "pm3fb: Error: pci_read_config_word failed,
board #%ld\n",
-		       l_fb_info->board_num);
+	if (var->yres > var->yres_virtual) {
+		DPRINTK("virtual y resolution < physical y resolution not
possible\n");
+		return -EINVAL;
 	}
=20
-	if (printtimings)
-		pm3fb_show_cur_timing(l_fb_info);
-=09
-	/* card-specific setup is done, we preserve the final
-           memory timing for future reference */
-	if ((ptr =3D pm3fb_preserve_memory_timings(l_fb_info)) =3D=3D
pm3fb_timing_problem) { /* memory timings were wrong ! oops.... */
-		return(0);
+	if (var->xoffset) {
+		DPRINTK("xoffset not supported\n");
+		return -EINVAL;
 	}
-=09
-	tempBypass =3D PM3_READ_REG(PM3MemBypassWriteMask);
-
-	DPRINTK(2, "PM3MemBypassWriteMask was: 0x%08lx\n", tempBypass);
-
-	PM3_SLOW_WRITE_REG(PM3MemBypassWriteMask, 0xFFFFFFFF);
-
-	/* pm3 split up memory, replicates, and do a lot of nasty stuff
IMHO ;-) */
-	for (i =3D 0; i < 32; i++) {
-		fb_writel(i * 0x00345678,
-			  (l_fb_info->v_fb + (i * 1048576)));
-		mb();
-		temp1 =3D fb_readl((l_fb_info->v_fb + (i * 1048576)));
=20
-		/* Let's check for wrapover, write will fail at 16MB boundary */
-		if (temp1 =3D=3D (i * 0x00345678))
-			memsize =3D i;
-		else
-			break;
+	if ((var->vmode & FB_VMODE_MASK) =3D=3D FB_VMODE_INTERLACED) {
+		DPRINTK("interlace not supported\n");
+		return -EINVAL;
 	}
=20
-	DPRINTK(2, "First detect pass already got %ld MB\n", memsize + 1);
-
-	if (memsize =3D=3D i) {
-		for (i =3D 0; i < 32; i++) {
-			/* Clear first 32MB ; 0 is 0, no need to byteswap */
-			writel(0x0000000,
-			       (l_fb_info->v_fb + (i * 1048576)));
-			mb();
-		}
+	var->xres =3D (var->xres + 31) & ~31; /* could sometimes be 8 */
+	lpitch =3D var->xres * ((var->bits_per_pixel + 7)>>3);
=20
-		for (i =3D 32; i < 64; i++) {
-			fb_writel(i * 0x00345678,
-				  (l_fb_info->v_fb + (i * 1048576)));
-			mb();
-			temp1 =3D
-			    fb_readl((l_fb_info->v_fb + (i * 1048576)));
-			temp2 =3D
-			    fb_readl((l_fb_info->v_fb +
-				      ((i - 32) * 1048576)));
-			if ((temp1 =3D=3D (i * 0x00345678)) && (temp2 =3D=3D 0))	/* different
value, different RAM... */
-				memsize =3D i;
-			else
-				break;
-		}
+	if (var->xres < 200 || var->xres > 2048) {
+		DPRINTK("width not supported: %u\n", var->xres);
+		return -EINVAL;
 	}
=20
-	DPRINTK(2, "Second detect pass got %ld MB\n", memsize + 1);
-
-	PM3_SLOW_WRITE_REG(PM3MemBypassWriteMask, tempBypass);
-
-	pm3fb_unmapIO(l_fb_info);
-	memsize =3D 1048576 * (memsize + 1);
-
-	DPRINTK(2, "Returning 0x%08lx bytes\n", memsize);
-
-	if (forcesize[l_fb_info->board_num] &&
((forcesize[l_fb_info->board_num] * 1048576) !=3D memsize))
-	{
-		printk(KERN_WARNING "pm3fb: mismatch between probed (%ld MB)
and specified (%hd MB) memory size, using SPECIFIED !\n",
memsize, forcesize[l_fb_info->board_num]);
-		memsize =3D 1048576 * forcesize[l_fb_info->board_num];
-	}
-=09
-	l_fb_info->fb_size =3D memsize;
-=09
-	if (ptr =3D=3D pm3fb_timing_retry)
-	{
-		printk(KERN_WARNING "pm3fb: retrying memory timings check");
-		if (pm3fb_try_memory_timings(l_fb_info) =3D=3D pm3fb_timing_problem)
-			return(0);
+	if (var->yres < 200 || var->yres > 4095) {
+		DPRINTK("height not supported: %u\n", var->yres);
+		return -EINVAL;
 	}
-=09
-	return (memsize);
-}
=20
-static void pm3fb_clear_memory(struct pm3fb_info *l_fb_info, u32 cc)
-{
-	int i;
-
-	DTRACE;
-
-	for (i =3D 0; i < (l_fb_info->fb_size / sizeof(u32)) ; i++) /*
clear entire FB memory to black */
-	{
-		fb_writel(cc, (l_fb_info->v_fb + (i * sizeof(u32))));
+	if (lpitch * var->yres_virtual > info->fix.smem_len) {
+		DPRINTK("no memory for screen (%ux%ux%u)\n",
+			var->xres, var->yres_virtual, var->bits_per_pixel);
+		return -EINVAL;
 	}
-}
-
-static void pm3fb_clear_colormap(struct pm3fb_info *l_fb_info,
unsigned char r, unsigned char g, unsigned char b)
-{
-	int i;
=20
-	DTRACE;
+	if (PICOS2KHZ(var->pixclock) > PM3_MAX_PIXCLOCK) {
+		DPRINTK("pixclock too high (%ldKHz)\n", PICOS2KHZ(var->pixclock));
+		return -EINVAL;
+	}
=20
-	for (i =3D 0; i < 256 ; i++) /* fill color map with white */
-		pm3fb_set_color(l_fb_info, i, r, g, b);
+	var->accel_flags =3D 0;	/* Can't mmap if this is on */
=20
+	DPRINTK("Checking graphics mode at %dx%d depth %d\n",
+		var->xres, var->yres, var->bits_per_pixel);
+	return 0;
 }
=20
-/* common initialisation */
-static void pm3fb_common_init(struct pm3fb_info *l_fb_info)
+static int pm3fb_set_par(struct fb_info *info)
 {
-	DTRACE;
+	struct pm3_par *par =3D info->par;
+	const u32 xres =3D (info->var.xres + 31) & ~31;
+	const int depth =3D (info->var.bits_per_pixel + 7) & ~7;
=20
-	DPRINTK(2, "Initializing board #%ld @ %lx\n", l_fb_info->board_num,
-		(unsigned long) l_fb_info);
+	par->base =3D pm3fb_shift_bpp(info->var.bits_per_pixel,
+					(info->var.yoffset * xres)
+					+ info->var.xoffset);
+	par->video =3D 0;
=20
-	strcpy(l_fb_info->gen.info.modename, permedia3_name);
-	disp[l_fb_info->board_num].scrollmode =3D 0;	/* SCROLL_YNOMOVE;
*//* 0 means "let fbcon choose" */
-	l_fb_info->gen.parsize =3D sizeof(struct pm3fb_par);
-	l_fb_info->gen.info.changevar =3D NULL;
-	l_fb_info->gen.info.fbops =3D &pm3fb_ops;
-	l_fb_info->gen.info.disp =3D &(disp[l_fb_info->board_num]);
-	if (fontn[l_fb_info->board_num][0])
-		strcpy(l_fb_info->gen.info.fontname,
-		       fontn[l_fb_info->board_num]);
-	l_fb_info->gen.info.switch_con =3D &fbgen_switch;
-	l_fb_info->gen.info.updatevar =3D &fbgen_update_var;	/* */
-	l_fb_info->gen.info.flags =3D FBINFO_FLAG_DEFAULT;
-
-	pm3fb_mapIO(l_fb_info);
+	if (info->var.sync & FB_SYNC_HOR_HIGH_ACT)
+		par->video |=3D PM3VideoControl_HSYNC_ACTIVE_HIGH;
+	else
+		par->video |=3D PM3VideoControl_HSYNC_ACTIVE_LOW;
=20
-	pm3fb_clear_memory(l_fb_info, 0);
-	pm3fb_clear_colormap(l_fb_info, 0, 0, 0);
+	if (info->var.sync & FB_SYNC_VERT_HIGH_ACT)
+		par->video |=3D PM3VideoControl_VSYNC_ACTIVE_HIGH;
+	else
+		par->video |=3D PM3VideoControl_VSYNC_ACTIVE_LOW;
=20
-	(void) fbgen_get_var(&(disp[l_fb_info->board_num]).var, -1,
-			     &l_fb_info->gen.info);
+	if ((info->var.vmode & FB_VMODE_MASK) =3D=3D FB_VMODE_DOUBLE)
+		par->video |=3D PM3VideoControl_LINE_DOUBLE_ON;
+	else
+		par->video |=3D PM3VideoControl_LINE_DOUBLE_OFF;
=20
-	if (depth[l_fb_info->board_num]) /* override mode-defined depth */
-	{
-		pm3fb_encode_depth(&(disp[l_fb_info->board_num]).var,
depth[l_fb_info->board_num]);
-		(disp[l_fb_info->board_num]).var.bits_per_pixel =3D
depth2bpp(depth[l_fb_info->board_num]);
+	if (info->var.activate =3D=3D FB_ACTIVATE_NOW)
+		par->video |=3D PM3VideoControl_ENABLE;
+	else {
+		par->video |=3D PM3VideoControl_DISABLE;
+		DPRINTK("PM3Video disabled\n");
+	}
+	switch (depth) {
+	case 8:
+		par->video |=3D PM3VideoControl_PIXELSIZE_8BIT;
+		break;
+	case 12:
+	case 15:
+	case 16:
+		par->video |=3D PM3VideoControl_PIXELSIZE_16BIT;
+		break;
+	case 32:
+		par->video |=3D PM3VideoControl_PIXELSIZE_32BIT;
+		break;
+	default:
+		DPRINTK("Unsupported depth\n");
+		break;
 	}
=20
-	(void) fbgen_do_set_var(&(disp[l_fb_info->board_num]).var, 1,
-				&l_fb_info->gen);
+	info->fix.visual =3D
+		(depth =3D=3D 8) ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
+	info->fix.line_length =3D ((info->var.xres_virtual + 7)  & ~7 )
+					* depth / 8;
=20
-	fbgen_set_disp(-1, &l_fb_info->gen);
+/*	pm3fb_clear_memory(info, 0);*/
+	pm3fb_clear_colormap(par, 0, 0, 0);
+	PM3_WRITE_DAC_REG(par, PM3RD_CursorMode,
+			  PM3RD_CursorMode_CURSOR_DISABLE);
+	pm3fb_write_mode(info);
+	return 0;
+}
=20
-	do_install_cmap(0, &l_fb_info->gen.info);
+static int pm3fb_setcolreg(unsigned regno, unsigned red,
unsigned green,
+			   unsigned blue, unsigned transp,
+			   struct fb_info *info)
+{
+	struct pm3_par *par =3D info->par;
=20
-	if (register_framebuffer(&l_fb_info->gen.info) < 0) {
-		DPRINTK(1, "Couldn't register framebuffer\n");
-		return;
-	}
+	if (regno >=3D 256)  /* no. of hw registers */
+	   return -EINVAL;
=20
-	PM3_WRITE_DAC_REG(PM3RD_CursorMode,
-			  PM3RD_CursorMode_CURSOR_DISABLE);
-=09
-	PM3_SHOW_CUR_MODE;
-=09
-	pm3fb_write_mode(l_fb_info);
-=09
-	printk("fb%d: %s, using %uK of video memory (%s)\n",
-	       l_fb_info->gen.info.node,
-	       permedia3_name, (u32) (l_fb_info->fb_size >> 10),
-	       cardbase[l_fb_info->board_type].cardname);
-}
-
-/* **************************************************** */
-/* ***** accelerated permedia3-specific functions ***** */
-/* **************************************************** */
-#ifdef PM3FB_USE_ACCEL
-static void pm3fb_wait_pm3(struct pm3fb_info *l_fb_info)
-{
-	DTRACE;
-
-	PM3_SLOW_WRITE_REG(PM3FilterMode, PM3FilterModeSync);
-	PM3_SLOW_WRITE_REG(PM3Sync, 0);
-	mb();
-	do {
-		while ((PM3_READ_REG(PM3OutFIFOWords)) =3D=3D 0);
-		rmb();
-	} while ((PM3_READ_REG(PM3OutputFifo)) !=3D PM3Sync_Tag);
-}
-
-static void pm3fb_init_engine(struct pm3fb_info *l_fb_info)
-{
-	PM3_SLOW_WRITE_REG(PM3FilterMode, PM3FilterModeSync);
-	PM3_SLOW_WRITE_REG(PM3StatisticMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3DeltaMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3RasterizerMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3ScissorMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3LineStippleMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3AreaStippleMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3GIDMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3DepthMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3StencilMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3StencilData, 0x0);
-	PM3_SLOW_WRITE_REG(PM3ColorDDAMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3TextureCoordMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3TextureIndexMode0, 0x0);
-	PM3_SLOW_WRITE_REG(PM3TextureIndexMode1, 0x0);
-	PM3_SLOW_WRITE_REG(PM3TextureReadMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3LUTMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3TextureFilterMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3TextureCompositeMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3TextureApplicationMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3TextureCompositeColorMode1, 0x0);
-	PM3_SLOW_WRITE_REG(PM3TextureCompositeAlphaMode1, 0x0);
-	PM3_SLOW_WRITE_REG(PM3TextureCompositeColorMode0, 0x0);
-	PM3_SLOW_WRITE_REG(PM3TextureCompositeAlphaMode0, 0x0);
-	PM3_SLOW_WRITE_REG(PM3FogMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3ChromaTestMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3AlphaTestMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3AntialiasMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3YUVMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3AlphaBlendColorMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3AlphaBlendAlphaMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3DitherMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3LogicalOpMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3RouterMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3Window, 0x0);
-
-	PM3_SLOW_WRITE_REG(PM3Config2D, 0x0);
-
-	PM3_SLOW_WRITE_REG(PM3SpanColorMask, 0xffffffff);
-
-	PM3_SLOW_WRITE_REG(PM3XBias, 0x0);
-	PM3_SLOW_WRITE_REG(PM3YBias, 0x0);
-	PM3_SLOW_WRITE_REG(PM3DeltaControl, 0x0);
-
-	PM3_SLOW_WRITE_REG(PM3BitMaskPattern, 0xffffffff);
-
-	PM3_SLOW_WRITE_REG(PM3FBDestReadEnables,
-			   PM3FBDestReadEnables_E(0xff) |
-			   PM3FBDestReadEnables_R(0xff) |
-			   PM3FBDestReadEnables_ReferenceAlpha(0xff));
-	PM3_SLOW_WRITE_REG(PM3FBDestReadBufferAddr0, 0x0);
-	PM3_SLOW_WRITE_REG(PM3FBDestReadBufferOffset0, 0x0);
-	PM3_SLOW_WRITE_REG(PM3FBDestReadBufferWidth0,
-			   PM3FBDestReadBufferWidth_Width(l_fb_info->
-							  current_par->
-							  width));
-
-	PM3_SLOW_WRITE_REG(PM3FBDestReadMode,
-			   PM3FBDestReadMode_ReadEnable |
-			   PM3FBDestReadMode_Enable0);
-	PM3_SLOW_WRITE_REG(PM3FBSourceReadBufferAddr, 0x0);
-	PM3_SLOW_WRITE_REG(PM3FBSourceReadBufferOffset, 0x0);
-	PM3_SLOW_WRITE_REG(PM3FBSourceReadBufferWidth,
-			   PM3FBSourceReadBufferWidth_Width(l_fb_info->
-							    current_par->
-							    width));
-	PM3_SLOW_WRITE_REG(PM3FBSourceReadMode,
-			   PM3FBSourceReadMode_Blocking |
-			   PM3FBSourceReadMode_ReadEnable);
+	/* grayscale works only partially under directcolor */
+	if (info->var.grayscale) {
+	   /* grayscale =3D 0.30*R + 0.59*G + 0.11*B */
+	   red =3D green =3D blue =3D (red * 77 + green * 151 + blue * 28) >> 8=
;
+	}
+
+	/* Directcolor:
+	 *   var->{color}.offset contains start of bitfield
+	 *   var->{color}.length contains length of bitfield
+	 *   {hardwarespecific} contains width of DAC
+	 *   pseudo_palette[X] is programmed to (X << red.offset) |
+	 *				      (X << green.offset) |
+	 *				      (X << blue.offset)
+	 *   RAMDAC[X] is programmed to (red, green, blue)
+	 *   color depth =3D SUM(var->{color}.length)
+	 *
+	 * Pseudocolor:
+	 *	var->{color}.offset is 0
+	 *	var->{color}.length contains width of DAC or the number of
unique
+	 *			colors available (color depth)
+	 *	pseudo_palette is not used
+	 *	RAMDAC[X] is programmed to (red, green, blue)
+	 *	color depth =3D var->{color}.length
+	 */
=20
-	{
-		unsigned long rm =3D 1;
-		switch (l_fb_info->current_par->depth) {
+	/*
+	 * This is the point where the color is converted to something that
+	 * is acceptable by the hardware.
+	 */
+#define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
+	red =3D CNVT_TOHW(red, info->var.red.length);
+	green =3D CNVT_TOHW(green, info->var.green.length);
+	blue =3D CNVT_TOHW(blue, info->var.blue.length);
+	transp =3D CNVT_TOHW(transp, info->var.transp.length);
+#undef CNVT_TOHW
+
+	if (info->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
+	info->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR) {
+		u32 v;
+
+		if (regno >=3D 16)
+			return -EINVAL;
+
+		v =3D (red << info->var.red.offset) |
+			(green << info->var.green.offset) |
+			(blue << info->var.blue.offset) |
+			(transp << info->var.transp.offset);
+
+		switch (info->var.bits_per_pixel) {
 		case 8:
-			PM3_SLOW_WRITE_REG(PM3PixelSize,
-					   PM3PixelSize_GLOBAL_8BIT);
 			break;
-		case 12:
-		case 15:
 		case 16:
-			PM3_SLOW_WRITE_REG(PM3PixelSize,
-					   PM3PixelSize_GLOBAL_16BIT);
-			break;
+		case 24:
 		case 32:
-			PM3_SLOW_WRITE_REG(PM3PixelSize,
-					   PM3PixelSize_GLOBAL_32BIT);
-			break;
-		default:
-			DPRINTK(1, "Unsupported depth %d\n",
-				l_fb_info->current_par->depth);
+			((u32*)(info->pseudo_palette))[regno] =3D v;
 			break;
 		}
-		PM3_SLOW_WRITE_REG(PM3RasterizerMode, rm);
+		return 0;
 	}
+	else if (info->fix.visual =3D=3D FB_VISUAL_PSEUDOCOLOR)
+		pm3fb_set_color(par, regno, red, green, blue);
=20
-	PM3_SLOW_WRITE_REG(PM3FBSoftwareWriteMask, 0xffffffff);
-	PM3_SLOW_WRITE_REG(PM3FBHardwareWriteMask, 0xffffffff);
-	PM3_SLOW_WRITE_REG(PM3FBWriteMode,
-			   PM3FBWriteMode_WriteEnable |
-			   PM3FBWriteMode_OpaqueSpan |
-			   PM3FBWriteMode_Enable0);
-	PM3_SLOW_WRITE_REG(PM3FBWriteBufferAddr0, 0x0);
-	PM3_SLOW_WRITE_REG(PM3FBWriteBufferOffset0, 0x0);
-	PM3_SLOW_WRITE_REG(PM3FBWriteBufferWidth0,
-			   PM3FBWriteBufferWidth_Width(l_fb_info->
-						       current_par->
-						       width));
+	return 0;
+}
=20
-	PM3_SLOW_WRITE_REG(PM3SizeOfFramebuffer, 0x0);
-	{
-		unsigned long sofb =3D (8UL * l_fb_info->fb_size) /
-			((depth2bpp(l_fb_info->current_par->depth))
-			 * l_fb_info->current_par->width);	/* size in lines of FB */
-		if (sofb > 4095)
-			PM3_SLOW_WRITE_REG(PM3SizeOfFramebuffer, 4095);
-		else
-			PM3_SLOW_WRITE_REG(PM3SizeOfFramebuffer, sofb);
-	=09
-		switch (l_fb_info->current_par->depth) {
-		case 8:
-			PM3_SLOW_WRITE_REG(PM3DitherMode,
-					   (1 << 10) | (2 << 3));
-			break;
-		case 12:
-		case 15:
-		case 16:
-			PM3_SLOW_WRITE_REG(PM3DitherMode,
-					   (1 << 10) | (1 << 3));
-			break;
-		case 32:
-			PM3_SLOW_WRITE_REG(PM3DitherMode,
-					   (1 << 10) | (0 << 3));
-			break;
-		default:
-			DPRINTK(1, "Unsupported depth %d\n",
-				l_fb_info->current_par->depth);
-			break;
-		}
-	}
-
-	PM3_SLOW_WRITE_REG(PM3dXDom, 0x0);
-	PM3_SLOW_WRITE_REG(PM3dXSub, 0x0);
-	PM3_SLOW_WRITE_REG(PM3dY, (1 << 16));
-	PM3_SLOW_WRITE_REG(PM3StartXDom, 0x0);
-	PM3_SLOW_WRITE_REG(PM3StartXSub, 0x0);
-	PM3_SLOW_WRITE_REG(PM3StartY, 0x0);
-	PM3_SLOW_WRITE_REG(PM3Count, 0x0);
-=09
-/* Disable LocalBuffer. better safe than sorry */
-	PM3_SLOW_WRITE_REG(PM3LBDestReadMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3LBDestReadEnables, 0x0);
-	PM3_SLOW_WRITE_REG(PM3LBSourceReadMode, 0x0);
-	PM3_SLOW_WRITE_REG(PM3LBWriteMode, 0x0);
-=09
-	pm3fb_wait_pm3(l_fb_info);
-}
-
-#ifdef FBCON_HAS_CFB32
-static void pm3fb_cfb32_clear(struct vc_data *conp,
-			      struct display *p,
-			      int sy, int sx, int height, int width)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) p->fb_info;
-	u32 c;
-
-	DTRACE;
-
-	sx =3D sx * fontwidth(p);
-	width =3D width * fontwidth(p);
-	sy =3D sy * fontheight(p);
-	height =3D height * fontheight(p);
-	c =3D ((u32 *) p->dispsw_data)[attr_bgcol_ec(p, conp)];
-
-	/* block fills in 32bpp are hard, but in low res (width <=3D 1600 :-)
-	   we can use 16bpp operations, but not if NoWriteMask is on
(SDRAM)  */
-	if ((l_fb_info->current_par->width > 1600) ||
-	    (l_fb_info->memt.caps & PM3LocalMemCaps_NoWriteMask)) {
-		PM3_WAIT(4);
-
-		PM3_WRITE_REG(PM3Config2D,
-					  PM3Config2D_UseConstantSource |
-					  PM3Config2D_ForegroundROPEnable |
-					  (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-					  PM3Config2D_FBWriteEnable);
-
-		PM3_WRITE_REG(PM3ForegroundColor, c);
-
-		PM3_WRITE_REG(PM3RectanglePosition,
-			      (PM3RectanglePosition_XOffset(sx)) |
-			      (PM3RectanglePosition_YOffset(sy)));
-
-		PM3_WRITE_REG(PM3Render2D,
-			      PM3Render2D_XPositive |
-			      PM3Render2D_YPositive |
-			      PM3Render2D_Operation_Normal |
-			      PM3Render2D_SpanOperation |
-			      (PM3Render2D_Width(width)) |
-			      (PM3Render2D_Height(height)));
-	} else {
-		PM3_WAIT(8);
-
-		PM3_WRITE_REG(PM3FBBlockColor, c);
-
-		PM3_WRITE_REG(PM3PixelSize, PM3PixelSize_GLOBAL_16BIT);
-
-		PM3_WRITE_REG(PM3FBWriteBufferWidth0,
-			      PM3FBWriteBufferWidth_Width(l_fb_info->
-							  current_par->
-							  width << 1));
-
-		PM3_WRITE_REG(PM3Config2D,
-					  PM3Config2D_UseConstantSource |
-					  PM3Config2D_ForegroundROPEnable |
-					  (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-					  PM3Config2D_FBWriteEnable);
-
-		PM3_WRITE_REG(PM3RectanglePosition,
-			      (PM3RectanglePosition_XOffset(sx << 1)) |
-			      (PM3RectanglePosition_YOffset(sy)));
-
-		PM3_WRITE_REG(PM3Render2D,
-			      PM3Render2D_XPositive |
-			      PM3Render2D_YPositive |
-			      PM3Render2D_Operation_Normal |
-			      (PM3Render2D_Width(width << 1)) |
-			      (PM3Render2D_Height(height)));
-
-		PM3_WRITE_REG(PM3FBWriteBufferWidth0,
-			      PM3FBWriteBufferWidth_Width(l_fb_info->
-							  current_par->
-							  width));
-
-		PM3_WRITE_REG(PM3PixelSize, PM3PixelSize_GLOBAL_32BIT);
-	}
-
-	pm3fb_wait_pm3(l_fb_info);
-}
-
-static void pm3fb_cfb32_clear_margins(struct vc_data *conp,
-				      struct display *p, int bottom_only)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) p->fb_info;
-	int sx, sy;
-	u32 c;
-
-	DTRACE;
-
-	sx =3D conp->vc_cols * fontwidth(p);	/* right margin */
-	sy =3D conp->vc_rows * fontheight(p);	/* bottom margin */
-	c =3D ((u32 *) p->dispsw_data)[attr_bgcol_ec(p, conp)];
-
-	if (!bottom_only) {	/* right margin top->bottom */
-		PM3_WAIT(4);
-
-		PM3_WRITE_REG(PM3Config2D,
-					  PM3Config2D_UseConstantSource |
-					  PM3Config2D_ForegroundROPEnable |
-					  (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-					  PM3Config2D_FBWriteEnable);
-
-		PM3_WRITE_REG(PM3ForegroundColor, c);
-
-		PM3_WRITE_REG(PM3RectanglePosition,
-			      (PM3RectanglePosition_XOffset
-			       (p->var.xoffset +
-				sx)) | (PM3RectanglePosition_YOffset(p->
-								     var.
-								     yoffset)));
-
-		PM3_WRITE_REG(PM3Render2D,
-			      PM3Render2D_XPositive |
-			      PM3Render2D_YPositive |
-			      PM3Render2D_Operation_Normal |
-			      PM3Render2D_SpanOperation |
-			      (PM3Render2D_Width(p->var.xres - sx)) |
-			      (PM3Render2D_Height(p->var.yres)));
-	}
-
-	/* bottom margin left -> right */
-	PM3_WAIT(4);
-
-	PM3_WRITE_REG(PM3Config2D,
-				  PM3Config2D_UseConstantSource |
-				  PM3Config2D_ForegroundROPEnable |
-				  (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-				  PM3Config2D_FBWriteEnable);
-
-	PM3_WRITE_REG(PM3ForegroundColor, c);
-
-	PM3_WRITE_REG(PM3RectanglePosition,
-		      (PM3RectanglePosition_XOffset(p->var.xoffset)) |
-		      (PM3RectanglePosition_YOffset(p->var.yoffset + sy)));
-
-	PM3_WRITE_REG(PM3Render2D,
-		      PM3Render2D_XPositive |
-		      PM3Render2D_YPositive |
-		      PM3Render2D_Operation_Normal |
-		      PM3Render2D_SpanOperation |
-		      (PM3Render2D_Width(p->var.xres)) |
-		      (PM3Render2D_Height(p->var.yres - sy)));
-
-	pm3fb_wait_pm3(l_fb_info);
-}
-#endif /* FBCON_HAS_CFB32 */
-#ifdef FBCON_HAS_CFB16
-static void pm3fb_cfb16_clear(struct vc_data *conp,
-			      struct display *p,
-			      int sy, int sx, int height, int width)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) p->fb_info;
-	u32 c;
-
-	DTRACE;
-
-	sx =3D sx * fontwidth(p);
-	width =3D width * fontwidth(p);
-	sy =3D sy * fontheight(p);
-	height =3D height * fontheight(p);
-	c =3D ((u16 *) p->dispsw_data)[attr_bgcol_ec(p, conp)];
-	c =3D c | (c << 16);
-
-	PM3_WAIT(4);
-
-	if (l_fb_info->memt.caps & PM3LocalMemCaps_NoWriteMask)
-		PM3_WRITE_REG(PM3ForegroundColor, c);
-	else
-		PM3_WRITE_REG(PM3FBBlockColor, c);
-
-	PM3_WRITE_REG(PM3Config2D,
-				  PM3Config2D_UseConstantSource |
-				  PM3Config2D_ForegroundROPEnable |
-				  (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-				  PM3Config2D_FBWriteEnable);
-
-	PM3_WRITE_REG(PM3RectanglePosition,
-		      (PM3RectanglePosition_XOffset(sx)) |
-		      (PM3RectanglePosition_YOffset(sy)));
-=09
-	if (l_fb_info->memt.caps & PM3LocalMemCaps_NoWriteMask)
-		PM3_WRITE_REG(PM3Render2D,
-			      PM3Render2D_XPositive |
-			      PM3Render2D_YPositive |
-			      PM3Render2D_Operation_Normal |
-			      PM3Render2D_SpanOperation |
-			      (PM3Render2D_Width(width)) |
-			      (PM3Render2D_Height(height)));
-	else
-		PM3_WRITE_REG(PM3Render2D,
-			      PM3Render2D_XPositive |
-			      PM3Render2D_YPositive |
-			      PM3Render2D_Operation_Normal |
-			      (PM3Render2D_Width(width)) |
-			      (PM3Render2D_Height(height)));
-=09
-	pm3fb_wait_pm3(l_fb_info);
-}
-
-static void pm3fb_cfb16_clear_margins(struct vc_data *conp,
-				      struct display *p, int bottom_only)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) p->fb_info;
-	int sx, sy;
-	u32 c;
-
-	DTRACE;
-
-	sx =3D conp->vc_cols * fontwidth(p);	/* right margin */
-	sy =3D conp->vc_rows * fontheight(p);	/* bottom margin */
-	c =3D ((u16 *) p->dispsw_data)[attr_bgcol_ec(p, conp)];
-	c =3D c | (c << 16);
-
-	if (!bottom_only) {	/* right margin top->bottom */
-		PM3_WAIT(4);
-
-		PM3_WRITE_REG(PM3Config2D,
-					  PM3Config2D_UseConstantSource |
-					  PM3Config2D_ForegroundROPEnable |
-					  (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-					  PM3Config2D_FBWriteEnable);
-	=09
-		if (l_fb_info->memt.caps & PM3LocalMemCaps_NoWriteMask)
-			PM3_WRITE_REG(PM3ForegroundColor, c);
-		else
-			PM3_WRITE_REG(PM3FBBlockColor, c);
-	=09
-		PM3_WRITE_REG(PM3RectanglePosition,
-			      (PM3RectanglePosition_XOffset
-			       (p->var.xoffset +
-				sx)) | (PM3RectanglePosition_YOffset(p->
-								     var.
-								     yoffset)));
-		if (l_fb_info->memt.caps & PM3LocalMemCaps_NoWriteMask)
-			PM3_WRITE_REG(PM3Render2D,
-				      PM3Render2D_XPositive |
-				      PM3Render2D_YPositive |
-				      PM3Render2D_Operation_Normal |
-				      PM3Render2D_SpanOperation |
-				      (PM3Render2D_Width(p->var.xres - sx)) |
-				      (PM3Render2D_Height(p->var.yres)));
-		else
-			PM3_WRITE_REG(PM3Render2D,
-				      PM3Render2D_XPositive |
-				      PM3Render2D_YPositive |
-				      PM3Render2D_Operation_Normal |
-				      (PM3Render2D_Width(p->var.xres - sx)) |
-				      (PM3Render2D_Height(p->var.yres)));
-	}
-=09
-	/* bottom margin left -> right */
-	PM3_WAIT(4);
-=09
-	PM3_WRITE_REG(PM3Config2D,
-		      PM3Config2D_UseConstantSource |
-		      PM3Config2D_ForegroundROPEnable |
-		      (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-		      PM3Config2D_FBWriteEnable);
-=09
-	if (l_fb_info->memt.caps & PM3LocalMemCaps_NoWriteMask)
-		PM3_WRITE_REG(PM3ForegroundColor, c);
-	else
-		PM3_WRITE_REG(PM3FBBlockColor, c);
-=09
-=09
-	PM3_WRITE_REG(PM3RectanglePosition,
-		      (PM3RectanglePosition_XOffset(p->var.xoffset)) |
-		      (PM3RectanglePosition_YOffset(p->var.yoffset + sy)));
-=09
-	if (l_fb_info->memt.caps & PM3LocalMemCaps_NoWriteMask)
-		PM3_WRITE_REG(PM3Render2D,
-			      PM3Render2D_XPositive |
-			      PM3Render2D_YPositive |
-			      PM3Render2D_Operation_Normal |
-			      PM3Render2D_SpanOperation |
-			      (PM3Render2D_Width(p->var.xres)) |
-			      (PM3Render2D_Height(p->var.yres - sy)));
-	else
-		PM3_WRITE_REG(PM3Render2D,
-			      PM3Render2D_XPositive |
-			      PM3Render2D_YPositive |
-			      PM3Render2D_Operation_Normal |
-			      (PM3Render2D_Width(p->var.xres)) |
-			      (PM3Render2D_Height(p->var.yres - sy)));
-
-	pm3fb_wait_pm3(l_fb_info);
-}
-#endif /* FBCON_HAS_CFB16 */
-#ifdef FBCON_HAS_CFB8
-static void pm3fb_cfb8_clear(struct vc_data *conp,
-			     struct display *p,
-			     int sy, int sx, int height, int width)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) p->fb_info;
-	u32 c;
-
-	DTRACE;
-
-	sx =3D sx * fontwidth(p);
-	width =3D width * fontwidth(p);
-	sy =3D sy * fontheight(p);
-	height =3D height * fontheight(p);
-
-	c =3D attr_bgcol_ec(p, conp);
-	c |=3D c << 8;
-	c |=3D c << 16;
-
-	PM3_WAIT(4);
-
-	PM3_WRITE_REG(PM3Config2D,
-				  PM3Config2D_UseConstantSource |
-				  PM3Config2D_ForegroundROPEnable |
-				  (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-				  PM3Config2D_FBWriteEnable);
-
-	PM3_WRITE_REG(PM3ForegroundColor, c);
-
-	PM3_WRITE_REG(PM3RectanglePosition,
-		      (PM3RectanglePosition_XOffset(sx)) |
-		      (PM3RectanglePosition_YOffset(sy)));
-
-	PM3_WRITE_REG(PM3Render2D,
-		      PM3Render2D_XPositive |
-		      PM3Render2D_YPositive |
-		      PM3Render2D_Operation_Normal |
-		      PM3Render2D_SpanOperation |
-		      (PM3Render2D_Width(width)) |
-		      (PM3Render2D_Height(height)));
-
-	pm3fb_wait_pm3(l_fb_info);
-}
-
-static void pm3fb_cfb8_clear_margins(struct vc_data *conp,
-				     struct display *p, int bottom_only)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) p->fb_info;
-	int sx, sy;
-	u32 c;
-
-	DTRACE;
-
-	sx =3D conp->vc_cols * fontwidth(p);	/* right margin */
-	sy =3D conp->vc_rows * fontheight(p);	/* bottom margin */
-	c =3D attr_bgcol_ec(p, conp);
-	c |=3D c << 8;
-	c |=3D c << 16;
-
-	if (!bottom_only) {	/* right margin top->bottom */
-		PM3_WAIT(4);
-
-		PM3_WRITE_REG(PM3Config2D,
-					  PM3Config2D_UseConstantSource |
-					  PM3Config2D_ForegroundROPEnable |
-					  (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-					  PM3Config2D_FBWriteEnable);
-
-		PM3_WRITE_REG(PM3ForegroundColor, c);
-
-		PM3_WRITE_REG(PM3RectanglePosition,
-			      (PM3RectanglePosition_XOffset
-			       (p->var.xoffset +
-				sx)) | (PM3RectanglePosition_YOffset(p->
-								     var.
-								     yoffset)));
-
-		PM3_WRITE_REG(PM3Render2D,
-			      PM3Render2D_XPositive |
-			      PM3Render2D_YPositive |
-			      PM3Render2D_Operation_Normal |
-			      PM3Render2D_SpanOperation |
-			      (PM3Render2D_Width(p->var.xres - sx)) |
-			      (PM3Render2D_Height(p->var.yres)));
-	}
-
-	/* bottom margin left -> right */
-	PM3_WAIT(4);
-
-	PM3_WRITE_REG(PM3Config2D,
-				  PM3Config2D_UseConstantSource |
-				  PM3Config2D_ForegroundROPEnable |
-				  (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-				  PM3Config2D_FBWriteEnable);
-
-	PM3_WRITE_REG(PM3ForegroundColor, c);
-
-	PM3_WRITE_REG(PM3RectanglePosition,
-		      (PM3RectanglePosition_XOffset(p->var.xoffset)) |
-		      (PM3RectanglePosition_YOffset(p->var.yoffset + sy)));
-
-	PM3_WRITE_REG(PM3Render2D,
-		      PM3Render2D_XPositive |
-		      PM3Render2D_YPositive |
-		      PM3Render2D_Operation_Normal |
-		      PM3Render2D_SpanOperation |
-		      (PM3Render2D_Width(p->var.xres)) |
-		      (PM3Render2D_Height(p->var.yres - sy)));
-
-	pm3fb_wait_pm3(l_fb_info);
-}
-#endif /* FBCON_HAS_CFB8 */
-#if defined(FBCON_HAS_CFB8) || defined(FBCON_HAS_CFB16) ||
defined(FBCON_HAS_CFB32)
-static void pm3fb_cfbX_bmove(struct display *p,
-			     int sy, int sx,
-			     int dy, int dx, int height, int width)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) p->fb_info;
-	int x_align, o_x, o_y;
-
-	DTRACE;
-
-	sx =3D sx * fontwidth(p);
-	dx =3D dx * fontwidth(p);
-	width =3D width * fontwidth(p);
-	sy =3D sy * fontheight(p);
-	dy =3D dy * fontheight(p);
-	height =3D height * fontheight(p);
-
-	o_x =3D sx - dx;		/*(sx > dx ) ? (sx - dx) : (dx - sx); */
-	o_y =3D sy - dy;		/*(sy > dy ) ? (sy - dy) : (dy - sy); */
-
-	x_align =3D (sx & 0x1f);
-
-	PM3_WAIT(6);
-
-	PM3_WRITE_REG(PM3Config2D,
-				  PM3Config2D_UserScissorEnable |
-				  PM3Config2D_ForegroundROPEnable |
-				  PM3Config2D_Blocking |
-				  (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-				  PM3Config2D_FBWriteEnable);
-
-	PM3_WRITE_REG(PM3ScissorMinXY,
-		      ((dy & 0x0fff) << 16) | (dx & 0x0fff));
-	PM3_WRITE_REG(PM3ScissorMaxXY,
-				  (((dy + height) & 0x0fff) << 16) |
-				  ((dx + width) & 0x0fff));
-
-	PM3_WRITE_REG(PM3FBSourceReadBufferOffset,
-		      PM3FBSourceReadBufferOffset_XOffset(o_x) |
-		      PM3FBSourceReadBufferOffset_YOffset(o_y));
-
-	PM3_WRITE_REG(PM3RectanglePosition,
-		      (PM3RectanglePosition_XOffset(dx - x_align)) |
-		      (PM3RectanglePosition_YOffset(dy)));
-
-	PM3_WRITE_REG(PM3Render2D,
-		      ((sx > dx) ? PM3Render2D_XPositive : 0) |
-		      ((sy > dy) ? PM3Render2D_YPositive : 0) |
-		      PM3Render2D_Operation_Normal |
-		      PM3Render2D_SpanOperation |
-		      PM3Render2D_FBSourceReadEnable |
-		      (PM3Render2D_Width(width + x_align)) |
-		      (PM3Render2D_Height(height)));
-
-	pm3fb_wait_pm3(l_fb_info);
-}
-
-static void pm3fb_cfbX_putc(struct vc_data *conp, struct display *p,
-			    int c, int yy, int xx)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) p->fb_info;
-	u8 *cdat, asx =3D 0, asy =3D 0, o_x =3D 0, o_y =3D 0;
-	u32 fgx, bgx, ldat;
-	int sx, sy, i;
-
-	DTRACE;
-
-	if (l_fb_info->current_par->depth =3D=3D 8)
-		fgx =3D attr_fgcol(p, c);
-	else if (depth2bpp(l_fb_info->current_par->depth) =3D=3D 16)
-		fgx =3D ((u16 *) p->dispsw_data)[attr_fgcol(p, c)];
-	else
-		fgx =3D ((u32 *) p->dispsw_data)[attr_fgcol(p, c)];
-
-	PM3_COLOR(fgx);
-
-	if (l_fb_info->current_par->depth =3D=3D 8)
-		bgx =3D attr_bgcol(p, c);
-	else if (depth2bpp(l_fb_info->current_par->depth) =3D=3D 16)
-		bgx =3D ((u16 *) p->dispsw_data)[attr_bgcol(p, c)];
-	else
-		bgx =3D ((u32 *) p->dispsw_data)[attr_bgcol(p, c)];
-
-	PM3_COLOR(bgx);
-
-	PM3_WAIT(4);
-
-	PM3_WRITE_REG(PM3Config2D,
-				  PM3Config2D_UseConstantSource |
-				  PM3Config2D_ForegroundROPEnable |
-				  (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-				  PM3Config2D_FBWriteEnable | PM3Config2D_OpaqueSpan);
-
-	PM3_WRITE_REG(PM3ForegroundColor, fgx);
-	PM3_WRITE_REG(PM3FillBackgroundColor, bgx);
-
-	/* WARNING : address select X need to specify 8 bits for
fontwidth <=3D 8 */
-	/* and 16 bits for fontwidth <=3D 16 */
-	/* same in _putcs, same for Y and fontheight */
-	if (fontwidth(p) <=3D 8)
-		asx =3D 2;
-	else if (fontwidth(p) <=3D 16)
-		asx =3D 3;	/* look OK */
-	if (fontheight(p) <=3D 8)
-		asy =3D 2;
-	else if (fontheight(p) <=3D 16)
-		asy =3D 3;	/* look OK */
-	else if (fontheight(p) <=3D 32)
-		asy =3D 4;	/* look OK */
-
-	sx =3D xx * fontwidth(p);
-	sy =3D yy * fontheight(p);
-
-	if (fontwidth(p) <=3D 8)
-		o_x =3D (8 - (sx & 0x7)) & 0x7;
-	else if (fontwidth(p) <=3D 16)
-		o_x =3D (16 - (sx & 0xF)) & 0xF;
-	if (fontheight(p) <=3D 8)
-		o_y =3D (8 - (sy & 0x7)) & 0x7;
-	else if (fontheight(p) <=3D 16)
-		o_y =3D (16 - (sy & 0xF)) & 0xF;
-	else if (fontheight(p) <=3D 32)
-		o_y =3D (32 - (sy & 0x1F)) & 0x1F;
-
-	PM3_WRITE_REG(PM3AreaStippleMode, (o_x << 7) | (o_y << 12) |	/*
x_offset, y_offset in pattern */
-		      (1 << 18) |	/* BE */
-		      1 | (asx << 1) | (asy << 4) |	/* address select x/y */
-		      (1 << 20));	/* OpaqueSpan */
-
-	if (fontwidth(p) <=3D 8) {
-		cdat =3D p->fontdata + (c & p->charmask) * fontheight(p);
-	} else {
-		cdat =3D
-		    p->fontdata +
-		    ((c & p->charmask) * (fontheight(p) << 1));
-	}
-
-	PM3_WAIT(2 + fontheight(p));
-
-	for (i =3D 0; i < fontheight(p); i++) {	/* assume fontheight <=3D 32 */
-		if (fontwidth(p) <=3D 8) {
-			ldat =3D *cdat++;
-		} else {	/* assume fontwidth <=3D 16 ATM */
-
-			ldat =3D ((*cdat++) << 8);
-			ldat |=3D *cdat++;
-		}
-		PM3_WRITE_REG(AreaStipplePattern_indexed(i), ldat);
-	}
-
-	PM3_WRITE_REG(PM3RectanglePosition,
-		      (PM3RectanglePosition_XOffset(sx)) |
-		      (PM3RectanglePosition_YOffset(sy)));
-
-	PM3_WRITE_REG(PM3Render2D,
-		      PM3Render2D_AreaStippleEnable |
-		      PM3Render2D_XPositive |
-		      PM3Render2D_YPositive |
-		      PM3Render2D_Operation_Normal |
-		      PM3Render2D_SpanOperation |
-		      (PM3Render2D_Width(fontwidth(p))) |
-		      (PM3Render2D_Height(fontheight(p))));
-
-	pm3fb_wait_pm3(l_fb_info);
-}
-
-static void pm3fb_cfbX_putcs(struct vc_data *conp, struct
display *p,
-			     const unsigned short *s, int count, int yy,
-			     int xx)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) p->fb_info;
-	u8 *cdat, asx =3D 0, asy =3D 0, o_x =3D 0, o_y =3D 0;
-	u32 fgx, bgx, ldat;
-	int sx, sy, i, j;
-	u16 sc;
-
-	DTRACE;
-
-	sc =3D scr_readw(s);
-	if (l_fb_info->current_par->depth =3D=3D 8)
-		fgx =3D attr_fgcol(p, sc);
-	else if (depth2bpp(l_fb_info->current_par->depth) =3D=3D 16)
-		fgx =3D ((u16 *) p->dispsw_data)[attr_fgcol(p, sc)];
-	else
-		fgx =3D ((u32 *) p->dispsw_data)[attr_fgcol(p, sc)];
-=09
-	PM3_COLOR(fgx);
-=09
-	if (l_fb_info->current_par->depth =3D=3D 8)
-		bgx =3D attr_bgcol(p, sc);
-	else if (depth2bpp(l_fb_info->current_par->depth) =3D=3D 16)
-		bgx =3D ((u16 *) p->dispsw_data)[attr_bgcol(p, sc)];
-	else
-		bgx =3D ((u32 *) p->dispsw_data)[attr_bgcol(p, sc)];
-=09
-	PM3_COLOR(bgx);
-
-	PM3_WAIT(4);
-
-	PM3_WRITE_REG(PM3Config2D,
-				  PM3Config2D_UseConstantSource |
-				  PM3Config2D_ForegroundROPEnable |
-				  (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-				  PM3Config2D_FBWriteEnable |
-				  PM3Config2D_OpaqueSpan);
-
-	PM3_WRITE_REG(PM3ForegroundColor, fgx);
-	PM3_WRITE_REG(PM3FillBackgroundColor, bgx);
-
-	/* WARNING : address select X need to specify 8 bits for
fontwidth <=3D 8 */
-	/* and 16 bits for fontwidth <=3D 16 */
-	/* same in _putc, same for Y and fontheight */
-	if (fontwidth(p) <=3D 8)
-		asx =3D 2;
-	else if (fontwidth(p) <=3D 16)
-		asx =3D 3;	/* look OK */
-	if (fontheight(p) <=3D 8)
-		asy =3D 2;
-	else if (fontheight(p) <=3D 16)
-		asy =3D 3;	/* look OK */
-	else if (fontheight(p) <=3D 32)
-		asy =3D 4;	/* look OK */
-
-	sy =3D yy * fontheight(p);
-
-	if (fontheight(p) <=3D 8)
-		o_y =3D (8 - (sy & 0x7)) & 0x7;
-	else if (fontheight(p) <=3D 16)
-		o_y =3D (16 - (sy & 0xF)) & 0xF;
-	else if (fontheight(p) <=3D 32)
-		o_y =3D (32 - (sy & 0x1F)) & 0x1F;
-
-	for (j =3D 0; j < count; j++) {
-		sc =3D scr_readw(s + j);
-		if (fontwidth(p) <=3D 8)
-			cdat =3D p->fontdata +
-				(sc & p->charmask) * fontheight(p);
-		else
-			cdat =3D p->fontdata +
-				((sc & p->charmask) * fontheight(p) << 1);
-	=09
-		sx =3D (xx + j) * fontwidth(p);
-
-		if (fontwidth(p) <=3D 8)
-			o_x =3D (8 - (sx & 0x7)) & 0x7;
-		else if (fontwidth(p) <=3D 16)
-			o_x =3D (16 - (sx & 0xF)) & 0xF;
-
-		PM3_WAIT(3 + fontheight(p));
-
-		PM3_WRITE_REG(PM3AreaStippleMode, (o_x << 7) | (o_y << 12) |
/* x_offset, y_offset in pattern */
-			      (1 << 18) | /* BE */
-			      1 | (asx << 1) | (asy << 4) | /* address select x/y */
-			      (1 << 20)); /* OpaqueSpan */
-
-		for (i =3D 0; i < fontheight(p); i++) { /* assume fontheight <=3D
32 */
-			if (fontwidth(p) <=3D 8) {
-				ldat =3D *cdat++;
-			} else { /* assume fontwidth <=3D 16 ATM */
-				ldat =3D ((*cdat++) << 8);
-				ldat |=3D *cdat++;
-			}
-			PM3_WRITE_REG(AreaStipplePattern_indexed(i), ldat);
-		}
-
-		PM3_WRITE_REG(PM3RectanglePosition,
-			      (PM3RectanglePosition_XOffset(sx)) |
-			      (PM3RectanglePosition_YOffset(sy)));
-
-		PM3_WRITE_REG(PM3Render2D,
-			      PM3Render2D_AreaStippleEnable |
-			      PM3Render2D_XPositive |
-			      PM3Render2D_YPositive |
-			      PM3Render2D_Operation_Normal |
-			      PM3Render2D_SpanOperation |
-			      (PM3Render2D_Width(fontwidth(p))) |
-			      (PM3Render2D_Height(fontheight(p))));
-	}
-	pm3fb_wait_pm3(l_fb_info);
-}
-
-static void pm3fb_cfbX_revc(struct display *p, int xx, int yy)
+static int pm3fb_pan_display(struct fb_var_screeninfo *var,
+				 struct fb_info *info)
 {
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) p->fb_info;
-
-	xx =3D xx * fontwidth(p);
-	yy =3D yy * fontheight(p);
-
-	if (l_fb_info->current_par->depth =3D=3D 8)
-	{
-		if (l_fb_info->memt.caps & PM3LocalMemCaps_NoWriteMask)
-			PM3_SLOW_WRITE_REG(PM3FBSoftwareWriteMask, 0x0F0F0F0F);
-		else
-			PM3_SLOW_WRITE_REG(PM3FBHardwareWriteMask, 0x0F0F0F0F);
-	}
-
-	PM3_WAIT(3);
-
-	PM3_WRITE_REG(PM3Config2D,
-				  PM3Config2D_UseConstantSource |
-				  PM3Config2D_ForegroundROPEnable |
-				  (PM3Config2D_ForegroundROP(0xa)) |	/* Oxa is GXinvert */
-				  PM3Config2D_FBDestReadEnable |
-				  PM3Config2D_FBWriteEnable);
-
-	PM3_WRITE_REG(PM3RectanglePosition,
-		      (PM3RectanglePosition_XOffset(xx)) |
-		      (PM3RectanglePosition_YOffset(yy)));
-
-	PM3_WRITE_REG(PM3Render2D,
-		      PM3Render2D_XPositive |
-		      PM3Render2D_YPositive |
-		      PM3Render2D_Operation_Normal |
-		      PM3Render2D_SpanOperation |
-		      (PM3Render2D_Width(fontwidth(p))) |
-		      (PM3Render2D_Height(fontheight(p))));
-
-	pm3fb_wait_pm3(l_fb_info);
-
-	if (l_fb_info->current_par->depth =3D=3D 8)
-	{
-		if (l_fb_info->memt.caps & PM3LocalMemCaps_NoWriteMask)
-			PM3_SLOW_WRITE_REG(PM3FBSoftwareWriteMask, 0xFFFFFFFF);
-		else
-			PM3_SLOW_WRITE_REG(PM3FBHardwareWriteMask, 0xFFFFFFFF);
-	}
-}
-
-#endif /* FBCON_HAS_CFB8 || FBCON_HAS_CFB16 || FBCON_HAS_CFB32 */
-#endif /* PM3FB_USE_ACCEL */
-/* *********************************** */
-/* ***** pre-init board(s) setup ***** */
-/* *********************************** */
-
-static void pm3fb_mode_setup(char *mode, unsigned long board_num)
-{
-	struct pm3fb_info *l_fb_info =3D &(fb_info[board_num]);
-	struct pm3fb_par *l_fb_par =3D &(current_par[board_num]);
-	unsigned long i =3D 0;
-
-	current_par_valid[board_num] =3D 0;
-
-	if (!strncmp(mode, "current", 7)) {
-		l_fb_info->use_current =3D 1;	/* default w/ OpenFirmware */
-	} else {
-		while ((mode_base[i].name[0])
-		       && (!current_par_valid[board_num])) {
-			if (!
-			    (strncmp
-			     (mode, mode_base[i].name,
-			      strlen(mode_base[i].name)))) {
-				memcpy(l_fb_par, &(mode_base[i].user_mode),
-				       sizeof(struct pm3fb_par));
-				current_par_valid[board_num] =3D 1;
-				DPRINTK(2, "Mode set to %s\n",
-					mode_base[i].name);
-			}
-			i++;
-		}
-		DASSERT(current_par_valid[board_num],
-			"Valid mode on command line\n");
-	}
-}
-
-static void pm3fb_pciid_setup(char *pciid, unsigned long board_num)
-{
-	short l_bus =3D -1, l_slot =3D -1, l_func =3D -1;
-	char *next;
-
-	if (pciid) {
-		l_bus =3D simple_strtoul(pciid, &next, 10);
-		if (next && (next[0] =3D=3D ':')) {
-			pciid =3D next + 1;
-			l_slot =3D simple_strtoul(pciid, &next, 10);
-			if (next && (next[0] =3D=3D ':')) {
-				pciid =3D next + 1;
-				l_func =3D
-				    simple_strtoul(pciid, (char **) NULL,
-						   10);
-			}
-		}
-	} else
-		return;
-
-	if ((l_bus >=3D 0) && (l_slot >=3D 0) && (l_func >=3D 0)) {
-		bus[board_num] =3D l_bus;
-		slot[board_num] =3D l_slot;
-		func[board_num] =3D l_func;
-		DPRINTK(2, "Board #%ld will be PciId: %hd:%hd:%hd\n",
-			board_num, l_bus, l_slot, l_func);
-	} else {
-		DPRINTK(1, "Invalid PciId: %hd:%hd:%hd for board #%ld\n",
-			l_bus, l_slot, l_func, board_num);
-	}
-}
-
-static void pm3fb_font_setup(char *lf, unsigned long board_num)
-{
-	unsigned long lfs =3D strlen(lf);
-
-	if (lfs > (PM3_FONTNAME_SIZE - 1)) {
-		DPRINTK(1, "Fontname %s too long\n", lf);
-		return;
-	}
-	strlcpy(fontn[board_num], lf, lfs + 1);
-}
-
-static void pm3fb_bootdepth_setup(char *bds, unsigned long
board_num)
-{
-	unsigned long bd =3D simple_strtoul(bds, (char **) NULL, 10);
-
-	if (!(depth_supported(bd))) {
-		printk(KERN_WARNING "pm3fb: ignoring invalid depth %s for
board #%ld\n",
-		       bds, board_num);
-		return;
-	}
-	depth[board_num] =3D bd;
-}
-
-static void pm3fb_forcesize_setup(char *bds, unsigned long
board_num)
-{
-	unsigned long bd =3D simple_strtoul(bds, (char **) NULL, 10);
-
-	if (bd > 64) {
-		printk(KERN_WARNING "pm3fb: ignoring invalid memory size %s
for board #%ld\n",
-		       bds, board_num);
-		return;
-	}
-	forcesize[board_num] =3D bd;
-}
-
-static char *pm3fb_boardnum_setup(char *options, unsigned long *bn)
-{
-	char *next;
-
-	if (!(isdigit(options[0]))) {
-		(*bn) =3D 0;
-		return (options);
-	}
-
-	(*bn) =3D simple_strtoul(options, &next, 10);
-
-	if (next && (next[0] =3D=3D ':') && ((*bn) >=3D 0)
-	    && ((*bn) <=3D PM3_MAX_BOARD)) {
-		DPRINTK(2, "Board_num seen as %ld\n", (*bn));
-		return (next + 1);
-	} else {
-		(*bn) =3D 0;
-		DPRINTK(2, "Board_num default to %ld\n", (*bn));
-		return (options);
-	}
-}
-
-static void pm3fb_real_setup(char *options)
-{
-	char *next;
-	unsigned long i, bn;
-	struct pm3fb_info *l_fb_info;
-
-	DTRACE;
-
-	DPRINTK(2, "Options : %s\n", options);
-
-	for (i =3D 0; i < PM3_MAX_BOARD; i++) {
-		l_fb_info =3D &(fb_info[i]);
-		memset(l_fb_info, 0, sizeof(struct pm3fb_info));
-		l_fb_info->gen.fbhw =3D &pm3fb_switch;
-		l_fb_info->board_num =3D i;
-		current_par_valid[i] =3D 0;
-		slot[i] =3D -1;
-		func[i] =3D -1;
-		bus[i] =3D -1;
-		disable[i] =3D 0;
-		noaccel[i] =3D 0;
-		fontn[i][0] =3D '\0';
-		depth[i] =3D 0;
-		l_fb_info->current_par =3D &(current_par[i]);
-	}
-
-	/* eat up prefix pm3fb and whatever is used as separator i.e.
:,=3D */
-	if (!strncmp(options, "pm3fb", 5)) {
-		options +=3D 5;
-		while (((*options) =3D=3D ',') || ((*options) =3D=3D ':')
-		       || ((*options) =3D=3D '=3D'))
-			options++;
-	}
-
-	while (options) {
-		bn =3D 0;
-		if ((next =3D strchr(options, ','))) {
-			(*next) =3D '\0';
-			next++;
-		}
-
-		if (!strncmp(options, "mode:", 5)) {
-			options =3D pm3fb_boardnum_setup(options + 5, &bn);
-			DPRINTK(2, "Setting mode for board #%ld\n", bn);
-			pm3fb_mode_setup(options, bn);
-		} else if (!strncmp(options, "off:", 4)) {
-			options =3D pm3fb_boardnum_setup(options + 4, &bn);
-			DPRINTK(2, "Disabling board #%ld\n", bn);
-			disable[bn] =3D 1;
-		} else if (!strncmp(options, "off", 3)) {	/* disable everything */
-			for (i =3D 0; i < PM3_MAX_BOARD; i++)
-				disable[i] =3D 1;
-		} else if (!strncmp(options, "disable:", 8)) {
-			options =3D pm3fb_boardnum_setup(options + 8, &bn);
-			DPRINTK(2, "Disabling board #%ld\n", bn);
-			disable[bn] =3D 1;
-		} else if (!strncmp(options, "pciid:", 6)) {
-			options =3D pm3fb_boardnum_setup(options + 6, &bn);
-			DPRINTK(2, "Setting PciID for board #%ld\n", bn);
-			pm3fb_pciid_setup(options, bn);
-		} else if (!strncmp(options, "noaccel:", 8)) {
-			options =3D pm3fb_boardnum_setup(options + 8, &bn);
-			noaccel[bn] =3D 1;
-		} else if (!strncmp(options, "font:", 5)) {
-			options =3D pm3fb_boardnum_setup(options + 5, &bn);
-			pm3fb_font_setup(options, bn);
-		} else if (!strncmp(options, "depth:", 6)) {
-			options =3D pm3fb_boardnum_setup(options + 6, &bn);
-			pm3fb_bootdepth_setup(options, bn);
-		} else if (!strncmp(options, "printtimings", 12)) {
-			printtimings =3D 1;
-		} else if (!strncmp(options, "flatpanel:", 10)) {
-			options =3D pm3fb_boardnum_setup(options + 10, &bn);
-			flatpanel[bn] =3D 1;
-		} else if (!strncmp(options, "forcesize:", 10)) {
-			options =3D pm3fb_boardnum_setup(options + 10, &bn);
-			pm3fb_forcesize_setup(options, bn);
-		}
-		options =3D next;
-	}
-}
+	struct pm3_par *par =3D info->par;
+	const u32 xres =3D (var->xres + 31) & ~31;
=20
-/* ********************************************** */
-/* ***** framebuffer API standard functions ***** */
-/* ********************************************** */
-
-static int pm3fb_encode_fix(struct fb_fix_screeninfo *fix,
-			    const void *par, struct fb_info_gen *info)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) info;
-	struct pm3fb_par *p =3D (struct pm3fb_par *) par;
-
-	DTRACE;
-
-	strcpy(fix->id, permedia3_name);
-	fix->smem_start =3D (unsigned long)l_fb_info->p_fb;
-	fix->smem_len =3D l_fb_info->fb_size;
-	fix->mmio_start =3D (unsigned long)l_fb_info->pIOBase;
-	fix->mmio_len =3D PM3_REGS_SIZE;
-#ifdef PM3FB_USE_ACCEL
-	if (!(noaccel[l_fb_info->board_num]))
-		fix->accel =3D FB_ACCEL_3DLABS_PERMEDIA3;
-	else
-#endif /* PM3FB_USE_ACCEL */
-		fix->accel =3D FB_ACCEL_NONE;
-	fix->type =3D FB_TYPE_PACKED_PIXELS;
-	fix->visual =3D
-	    (p->depth =3D=3D 8) ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
-	if (current_par_valid[l_fb_info->board_num])
-		fix->line_length =3D
-			l_fb_info->current_par->width *
-			depth2ByPP(l_fb_info->current_par->depth);
-	else
-		fix->line_length =3D 0;
-	fix->xpanstep =3D 64 / depth2bpp(p->depth);
-	fix->ypanstep =3D 1;
-	fix->ywrapstep =3D 0;
-	return (0);
-}
-
-static int pm3fb_decode_var(const struct fb_var_screeninfo *var,
-			    void *par, struct fb_info_gen *info)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) info;
-	struct pm3fb_par *p =3D (struct pm3fb_par *) par;
-	struct pm3fb_par temp_p;
-	u32 xres;
-
-	DTRACE;
-
-	DASSERT((var !=3D NULL), "fb_var_screeninfo* not NULL");
-	DASSERT((p !=3D NULL), "pm3fb_par* not NULL");
-	DASSERT((l_fb_info !=3D NULL), "pm3fb_info* not NULL");
-
-	memset(&temp_p, 0, sizeof(struct pm3fb_par));
-	temp_p.width =3D (var->xres_virtual + 7) & ~7;
-	temp_p.height =3D var->yres_virtual;
-
-	if (!(depth_supported(var->bits_per_pixel))) /* round
unsupported up to a multiple of 8 */
-		temp_p.depth =3D depth2bpp(var->bits_per_pixel);
-	else
-		temp_p.depth =3D var->bits_per_pixel;
-
-	temp_p.depth =3D (temp_p.depth > 32) ? 32 : temp_p.depth; /* max
32 */
-	temp_p.depth =3D (temp_p.depth =3D=3D 24) ? 32 : temp_p.depth; /* 24
unsupported, round-up to 32 */
-
-	if ((temp_p.depth =3D=3D 16) && (var->red.length =3D=3D 5) &&
(var->green.length =3D=3D 5) && (var->blue.length =3D=3D 5))
-		temp_p.depth =3D 15; /* RGBA 5551 is stored as depth 15 */
-
-	if ((temp_p.depth =3D=3D 16) && (var->red.length =3D=3D 4) &&
(var->green.length =3D=3D 4) && (var->blue.length =3D=3D 4))
-		temp_p.depth =3D 12; /* RGBA 4444  is stored as depth 12 */
-
-
-	DPRINTK(2,
-		"xres: %d, yres: %d, vxres: %d, vyres: %d ; xoffset:%d,
yoffset: %d\n",
-		var->xres, var->yres, var->xres_virtual, var->yres_virtual,
-		var->xoffset, var->yoffset);
-
-	xres =3D (var->xres + 31) & ~31;
-	if (temp_p.width < xres + var->xoffset)
-		temp_p.width =3D xres + var->xoffset;
-	if (temp_p.height < var->yres + var->yoffset)
-		temp_p.height =3D var->yres + var->yoffset;
-
-	if (temp_p.width > 2048) {
-		DPRINTK(1, "virtual width not supported: %u\n",
-			temp_p.width);
-		return (-EINVAL);
-	}
-	if (var->yres < 200) {
-		DPRINTK(1, "height not supported: %u\n", (u32) var->yres);
-		return (-EINVAL);
-	}
-	if (temp_p.height < 200 || temp_p.height > 4095) {
-		DPRINTK(1, "virtual height not supported: %u\n",
-			temp_p.height);
-		return (-EINVAL);
-	}
-	if (!(depth_supported(temp_p.depth))) {
-		DPRINTK(1, "depth not supported: %u\n", temp_p.depth);
-		return (-EINVAL);
-	}
-	if ((temp_p.width * temp_p.height * depth2ByPP(temp_p.depth)) >
-	    l_fb_info->fb_size) {
-		DPRINTK(1, "no memory for screen (%ux%ux%u)\n",
-			temp_p.width, temp_p.height, temp_p.depth);
-		return (-EINVAL);
-	}
-
-	if ((!var->pixclock) ||
-	    (!var->right_margin) ||
-	    (!var->hsync_len) ||
-	    (!var->left_margin) ||
-	    (!var->lower_margin) ||
-	    (!var->vsync_len) || (!var->upper_margin)
-	    ) {
-		unsigned long i =3D 0, done =3D 0;
-		printk(KERN_WARNING "pm3fb: refusing to use a likely wrong
timing\n");
-
-		while ((mode_base[i].user_mode.width) && !done) {
-			if ((mode_base[i].user_mode.width =3D=3D temp_p.width)
-			    && (mode_base[i].user_mode.height =3D=3D
-				temp_p.height)) {
-				printk(KERN_NOTICE "pm3fb: using close match %s\n",
-				       mode_base[i].name);
-				temp_p =3D mode_base[i].user_mode;
-				done =3D 1;
-			}
-			i++;
-		}
-		if (!done)
-			return (-EINVAL);
-	} else {
-		temp_p.pixclock =3D PICOS2KHZ(var->pixclock);
-		if (temp_p.pixclock > PM3_MAX_PIXCLOCK) {
-			DPRINTK(1, "pixclock too high (%uKHz)\n",
-				temp_p.pixclock);
-			return (-EINVAL);
-		}
-
-		temp_p.hsstart =3D var->right_margin;
-		temp_p.hsend =3D var->right_margin + var->hsync_len;
-		temp_p.hbend =3D
-		    var->right_margin + var->hsync_len + var->left_margin;
-		temp_p.htotal =3D xres + temp_p.hbend;
-
-		temp_p.vsstart =3D var->lower_margin;
-		temp_p.vsend =3D var->lower_margin + var->vsync_len;
-		temp_p.vbend =3D
-		    var->lower_margin + var->vsync_len + var->upper_margin;
-		temp_p.vtotal =3D var->yres + temp_p.vbend;
-
-		temp_p.stride =3D temp_p.width;
-
-		DPRINTK(2, "Using %d * %d, %d Khz, stride is %08x\n",
-			temp_p.width, temp_p.height, temp_p.pixclock,
-			temp_p.stride);
-
-		temp_p.base =3D
-		    pm3fb_Shiftbpp(l_fb_info, temp_p.depth,
-				   (var->yoffset * xres) + var->xoffset);
-
-		temp_p.video =3D 0;
-
-		if (var->sync & FB_SYNC_HOR_HIGH_ACT)
-			temp_p.video |=3D PM3VideoControl_HSYNC_ACTIVE_HIGH;
-		else
-			temp_p.video |=3D PM3VideoControl_HSYNC_ACTIVE_LOW;
-
-		if (var->sync & FB_SYNC_VERT_HIGH_ACT)
-			temp_p.video |=3D PM3VideoControl_VSYNC_ACTIVE_HIGH;
-		else
-			temp_p.video |=3D PM3VideoControl_VSYNC_ACTIVE_LOW;
-
-		if ((var->vmode & FB_VMODE_MASK) =3D=3D FB_VMODE_INTERLACED) {
-			DPRINTK(1, "Interlaced mode not supported\n\n");
-			return (-EINVAL);
-		}
-
-		if ((var->vmode & FB_VMODE_MASK) =3D=3D FB_VMODE_DOUBLE)
-			temp_p.video |=3D PM3VideoControl_LINE_DOUBLE_ON;
-		else
-			temp_p.video |=3D PM3VideoControl_LINE_DOUBLE_OFF;
-
-		if (var->activate =3D=3D FB_ACTIVATE_NOW)
-			temp_p.video |=3D PM3VideoControl_ENABLE;
-		else {
-			temp_p.video |=3D PM3VideoControl_DISABLE;
-			DPRINTK(2, "PM3Video disabled\n");
-		}
-
-		switch (temp_p.depth) {
-		case 8:
-			temp_p.video |=3D PM3VideoControl_PIXELSIZE_8BIT;
-			break;
-		case 12:
-		case 15:
-		case 16:
-			temp_p.video |=3D PM3VideoControl_PIXELSIZE_16BIT;
-			break;
-		case 32:
-			temp_p.video |=3D PM3VideoControl_PIXELSIZE_32BIT;
-			break;
-		default:
-			DPRINTK(1, "Unsupported depth\n");
-			break;
-		}
-	}
-	(*p) =3D temp_p;
-
-#ifdef PM3FB_USE_ACCEL
-	if (var->accel_flags & FB_ACCELF_TEXT)
-		noaccel[l_fb_info->board_num] =3D 0;
-	else
-		noaccel[l_fb_info->board_num] =3D 1;
-#endif /* PM3FB_USE_ACCEL */
-
-	return (0);
-}
-
-static void pm3fb_encode_depth(struct fb_var_screeninfo *var,
long d)
-{
-	switch (d) {
-	case 8:
-		var->red.length =3D var->green.length =3D var->blue.length =3D 8;
-		var->red.offset =3D var->green.offset =3D var->blue.offset =3D 0;
-		var->transp.offset =3D var->transp.length =3D 0;
-		break;
-
-	case 12:
-		var->red.offset =3D 8;
-		var->red.length =3D 4;
-		var->green.offset =3D 4;
-		var->green.length =3D 4;
-		var->blue.offset =3D 0;
-		var->blue.length =3D 4;
-		var->transp.offset =3D 12;
-		var->transp.length =3D 4;
-		break;
-
-	case 15:
-		var->red.offset =3D 10;
-		var->red.length =3D 5;
-		var->green.offset =3D 5;
-		var->green.length =3D 5;
-		var->blue.offset =3D 0;
-		var->blue.length =3D 5;
-		var->transp.offset =3D 15;
-		var->transp.length =3D 1;
-		break;
-
-	case 16:
-		var->red.offset =3D 11;
-		var->red.length =3D 5;
-		var->green.offset =3D 5;
-		var->green.length =3D 6;
-		var->blue.offset =3D 0;
-		var->blue.length =3D 5;
-		var->transp.offset =3D var->transp.length =3D 0;
-		break;
-
-	case 32:
-		var->transp.offset =3D 24;
-		var->red.offset =3D 16;
-		var->green.offset =3D 8;
-		var->blue.offset =3D 0;
-		var->red.length =3D var->green.length =3D
-			var->blue.length =3D var->transp.length =3D 8;
-		break;
-
-	default:
-		DPRINTK(1, "Unsupported depth %ld\n", d);
-		break;
-	}
-}
-
-static int pm3fb_encode_var(struct fb_var_screeninfo *var,
-			    const void *par, struct fb_info_gen *info)
-{
-	struct pm3fb_par *p =3D (struct pm3fb_par *) par;
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) info;
-
-	u32 base;
-
-	DTRACE;
-
-	DASSERT((var !=3D NULL), "fb_var_screeninfo* not NULL");
-	DASSERT((p !=3D NULL), "pm3fb_par* not NULL");
-	DASSERT((info !=3D NULL), "fb_info_gen* not NULL");
-
-	memset(var, 0, sizeof(struct fb_var_screeninfo));
-
-#ifdef PM3FB_USE_ACCEL
-	if (!(noaccel[l_fb_info->board_num]))
-		var->accel_flags |=3D FB_ACCELF_TEXT;
-#endif /* PM3FB_USE_ACCEL */
-
-	var->xres_virtual =3D p->width;
-	var->yres_virtual =3D p->height;
-	var->xres =3D p->htotal - p->hbend;
-	var->yres =3D p->vtotal - p->vbend;
-
-	DPRINTK(2, "xres =3D %d, yres : %d\n", var->xres, var->yres);
-
-	var->right_margin =3D p->hsstart;
-	var->hsync_len =3D p->hsend - p->hsstart;
-	var->left_margin =3D p->hbend - p->hsend;
-	var->lower_margin =3D p->vsstart;
-	var->vsync_len =3D p->vsend - p->vsstart;
-	var->upper_margin =3D p->vbend - p->vsend;
-	var->bits_per_pixel =3D depth2bpp(p->depth);
-=09
-	pm3fb_encode_depth(var, p->depth);
-
-	base =3D pm3fb_Unshiftbpp(l_fb_info, p->depth, p->base);
-
-	var->xoffset =3D base % var->xres;
-	var->yoffset =3D base / var->xres;
-
-	var->height =3D var->width =3D -1;
-
-	var->pixclock =3D KHZ2PICOS(p->pixclock);
-
-	if ((p->video & PM3VideoControl_HSYNC_MASK) =3D=3D
-	    PM3VideoControl_HSYNC_ACTIVE_HIGH)
-		var->sync |=3D FB_SYNC_HOR_HIGH_ACT;
-	if ((p->video & PM3VideoControl_VSYNC_MASK) =3D=3D
-	    PM3VideoControl_VSYNC_ACTIVE_HIGH)
-		var->sync |=3D FB_SYNC_VERT_HIGH_ACT;
-	if (p->video & PM3VideoControl_LINE_DOUBLE_ON)
-		var->vmode =3D FB_VMODE_DOUBLE;
-
-	return (0);
-}
-
-static void pm3fb_get_par(void *par, struct fb_info_gen *info)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) info;
-
-	DTRACE;
-
-	if (!current_par_valid[l_fb_info->board_num]) {
-		if (l_fb_info->use_current)
-			pm3fb_read_mode(l_fb_info, l_fb_info->current_par);
-		else
-			memcpy(l_fb_info->current_par,
-			       &(mode_base[0].user_mode),
-			       sizeof(struct pm3fb_par));
-		current_par_valid[l_fb_info->board_num] =3D 1;
-	}
-	*((struct pm3fb_par *) par) =3D *(l_fb_info->current_par);
-}
-
-static void pm3fb_set_par(const void *par, struct fb_info_gen *info)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) info;
-
-	DTRACE;
-
-	*(l_fb_info->current_par) =3D *((struct pm3fb_par *) par);
-	current_par_valid[l_fb_info->board_num] =3D 1;
-
-	pm3fb_write_mode(l_fb_info);
-
-#ifdef PM3FB_USE_ACCEL
-	pm3fb_init_engine(l_fb_info);
-#endif /* PM3FB_USE_ACCEL */
-}
-
-static void pm3fb_set_color(struct pm3fb_info *l_fb_info,
-			    unsigned char regno, unsigned char r,
-			    unsigned char g, unsigned char b)
-{
-	DTRACE;
-
-	PM3_SLOW_WRITE_REG(PM3RD_PaletteWriteAddress, regno);
-	PM3_SLOW_WRITE_REG(PM3RD_PaletteData, r);
-	PM3_SLOW_WRITE_REG(PM3RD_PaletteData, g);
-	PM3_SLOW_WRITE_REG(PM3RD_PaletteData, b);
-}
-
-static int pm3fb_getcolreg(unsigned regno, unsigned *red,
unsigned *green,
-			   unsigned *blue, unsigned *transp,
-			   struct fb_info *info)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) info;
-
-	DTRACE;
-
-	if (regno < 256) {
-		*red =3D
-		    l_fb_info->palette[regno].red << 8 | l_fb_info->
-		    palette[regno].red;
-		*green =3D
-		    l_fb_info->palette[regno].green << 8 | l_fb_info->
-		    palette[regno].green;
-		*blue =3D
-		    l_fb_info->palette[regno].blue << 8 | l_fb_info->
-		    palette[regno].blue;
-		*transp =3D
-		    l_fb_info->palette[regno].transp << 8 | l_fb_info->
-		    palette[regno].transp;
-	}
-	return (regno > 255);
-}
-
-static int pm3fb_setcolreg(unsigned regno, unsigned red,
unsigned green,
-			   unsigned blue, unsigned transp,
-			   struct fb_info *info)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) info;
-
-	DTRACE;
-
-	if (regno < 16) {
-		switch (l_fb_info->current_par->depth) {
-#ifdef FBCON_HAS_CFB8
-		case 8:
-			break;
-#endif
-#ifdef FBCON_HAS_CFB16
-		case 12:
-			l_fb_info->cmap.cmap12[regno] =3D
-				(((u32) red & 0xf000) >> 4) |
-				(((u32) green & 0xf000) >> 8) |
-				(((u32) blue & 0xf000) >> 12);
-			break;
-
-		case 15:
-			l_fb_info->cmap.cmap15[regno] =3D
-				(((u32) red & 0xf800) >> 1) |
-				(((u32) green & 0xf800) >> 6) |
-				(((u32) blue & 0xf800) >> 11);
-			break;
-
-		case 16:
-			l_fb_info->cmap.cmap16[regno] =3D
-			    ((u32) red & 0xf800) |
-			    (((u32) green & 0xfc00) >> 5) |
-			    (((u32) blue & 0xf800) >> 11);
-			break;
-#endif
-#ifdef FBCON_HAS_CFB32
-		case 32:
-			l_fb_info->cmap.cmap32[regno] =3D
-			    (((u32) transp & 0xff00) << 16) |
-			    (((u32) red & 0xff00) << 8) |
-			    (((u32) green & 0xff00)) |
-			    (((u32) blue & 0xff00) >> 8);
-			break;
-#endif
-		default:
-			DPRINTK(1, "bad depth %u\n",
-				l_fb_info->current_par->depth);
-			break;
-		}
-	}
-	if (regno < 256) {
-		l_fb_info->palette[regno].red =3D red >> 8;
-		l_fb_info->palette[regno].green =3D green >> 8;
-		l_fb_info->palette[regno].blue =3D blue >> 8;
-		l_fb_info->palette[regno].transp =3D transp >> 8;
-		if (l_fb_info->current_par->depth =3D=3D 8)
-			pm3fb_set_color(l_fb_info, regno, red >> 8,
-					green >> 8, blue >> 8);
-	}
-	return (regno > 255);
+	par->base =3D pm3fb_shift_bpp(var->bits_per_pixel,
+					(var->yoffset * xres)
+					+ var->xoffset);
+	PM3_SLOW_WRITE_REG(par, PM3ScreenBase, par->base);
+	return 0;
 }
=20
-static int pm3fb_blank(int blank_mode, struct fb_info_gen *info)
+static int pm3fb_blank(int blank_mode, struct fb_info *info)
 {
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) info;
-	u32 video;
-
-	DTRACE;
-
-	if (!current_par_valid[l_fb_info->board_num])
-		return (1);
-
-	video =3D l_fb_info->current_par->video;
+	struct pm3_par *par =3D info->par;
+	u32 video =3D par->video;
=20
 	/*
 	 * Oxygen VX1 - it appears that setting PM3VideoControl and
@@ -3202,433 +694,325 @@ static int pm3fb_blank(int blank_mode, s
 					  PM3VideoControl_BLANK_ACTIVE_LOW);
 			break;
 		default:
-			DPRINTK(1, "Unsupported blanking %d\n",
-				blank_mode);
-			return (1);
-			break;
+			DPRINTK("Unsupported blanking %d\n", blank_mode);
+			return 1;
 		}
 	}
=20
-	PM3_SLOW_WRITE_REG(PM3VideoControl, video);
+	PM3_SLOW_WRITE_REG(par,PM3VideoControl, video);
=20
-	return (0);
+	return 0;
 }
=20
-static void pm3fb_set_disp(const void *par, struct display *disp,
-			   struct fb_info_gen *info)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) info;
-	struct pm3fb_par *p =3D (struct pm3fb_par *) par;
-	u32 flags;
+	/*
+	 *  Frame buffer operations
+	 */
=20
-	DTRACE;
+static struct fb_ops pm3fb_ops =3D {
+	.owner		=3D THIS_MODULE,
+	.fb_check_var	=3D pm3fb_check_var,
+	.fb_set_par	=3D pm3fb_set_par,
+	.fb_setcolreg	=3D pm3fb_setcolreg,
+	.fb_pan_display	=3D pm3fb_pan_display,
+	.fb_fillrect	=3D cfb_fillrect,		/* Needed !!! */
+	.fb_copyarea	=3D cfb_copyarea,		/* Needed !!! */
+	.fb_imageblit	=3D cfb_imageblit,	/* Needed !!! */
+	.fb_blank	=3D pm3fb_blank,
+};
=20
-	local_irq_save(flags);
-	info->info.screen_base =3D l_fb_info->v_fb;
-	switch (p->depth) {
-#ifdef FBCON_HAS_CFB8
-	case 8:
-#ifdef PM3FB_USE_ACCEL
-		if (!(noaccel[l_fb_info->board_num]))
-			disp->dispsw =3D &pm3fb_cfb8;
-		else
-#endif /* PM3FB_USE_ACCEL */
-			disp->dispsw =3D &fbcon_cfb8;
-		break;
-#endif
-#ifdef FBCON_HAS_CFB16
-	case 12:
-#ifdef PM3FB_USE_ACCEL
-		if (!(noaccel[l_fb_info->board_num]))
-			disp->dispsw =3D &pm3fb_cfb16;
-		else
-#endif /* PM3FB_USE_ACCEL */
-			disp->dispsw =3D &fbcon_cfb16;
-		disp->dispsw_data =3D l_fb_info->cmap.cmap12;
-		break;
-	case 15:
-#ifdef PM3FB_USE_ACCEL
-		if (!(noaccel[l_fb_info->board_num]))
-			disp->dispsw =3D &pm3fb_cfb16;
-		else
-#endif /* PM3FB_USE_ACCEL */
-			disp->dispsw =3D &fbcon_cfb16;
-		disp->dispsw_data =3D l_fb_info->cmap.cmap15;
-		break;
-	case 16:
-#ifdef PM3FB_USE_ACCEL
-		if (!(noaccel[l_fb_info->board_num]))
-			disp->dispsw =3D &pm3fb_cfb16;
-		else
-#endif /* PM3FB_USE_ACCEL */
-			disp->dispsw =3D &fbcon_cfb16;
-		disp->dispsw_data =3D l_fb_info->cmap.cmap16;
-		break;
-#endif
-#ifdef FBCON_HAS_CFB32
-	case 32:
-#ifdef PM3FB_USE_ACCEL
-		if (!(noaccel[l_fb_info->board_num]))
-			disp->dispsw =3D &pm3fb_cfb32;
-		else
-#endif /* PM3FB_USE_ACCEL */
-			disp->dispsw =3D &fbcon_cfb32;
-		disp->dispsw_data =3D l_fb_info->cmap.cmap32;
-		break;
-#endif /* FBCON_HAS_CFB32 */
-	default:
-		disp->dispsw =3D &fbcon_dummy;
-		DPRINTK(1, "Invalid depth, using fbcon_dummy\n");
-		break;
-	}
-	local_irq_restore(flags);
-}
+/*
-------------------------------------------------------------------------
*/
=20
-/* */
-static void pm3fb_detect(void)
-{
-	struct pci_dev *dev_array[PM3_MAX_BOARD];
-	struct pci_dev *dev =3D NULL;
-	struct pm3fb_info *l_fb_info =3D &(fb_info[0]);
-	unsigned long i, j, done;
+	/*
+	 *  Initialization
+	 */
=20
-	DTRACE;
+/* mmio register are already mapped when this function is called */
+/* the pm3fb_fix.smem_start is also set */
+static unsigned long pm3fb_size_memory(struct pm3_par *par)
+{
+	unsigned long	memsize =3D 0, tempBypass, i, temp1, temp2;
+	unsigned char	__iomem *screen_mem;
=20
-	for (i =3D 0; i < PM3_MAX_BOARD; i++) {
-		dev_array[i] =3D NULL;
-		fb_info[i].dev =3D NULL;
+	pm3fb_fix.smem_len =3D 64 * 1024 * 1024; /* request full aperture
size */
+	/* Linear frame buffer - request region and map it. */
+	if ( !request_mem_region(pm3fb_fix.smem_start, pm3fb_fix.smem_len,
+				 "pm3fb smem") ) {
+		printk(KERN_WARNING "pm3fb: Can't reserve smem.\n");
+		return 0;
+	}
+	screen_mem =3D
+		ioremap_nocache(pm3fb_fix.smem_start, pm3fb_fix.smem_len);
+	if ( !screen_mem ) {
+		printk(KERN_WARNING "pm3fb: Can't ioremap smem area.\n");
+		release_mem_region(pm3fb_fix.smem_start, pm3fb_fix.smem_len);
+		return 0;
 	}
=20
-	dev =3D pci_get_device(PCI_VENDOR_ID_3DLABS,
-			    PCI_DEVICE_ID_3DLABS_PERMEDIA3, dev);
+	/* TODO: card-specific stuff, *before* accessing *any* FB memory */
+	/* For Appian Jeronimo 2000 board second head */
=20
-	for (i =3D 0; ((i < PM3_MAX_BOARD) && dev); i++) {
-		dev_array[i] =3D dev;
-		dev =3D pci_get_device(PCI_VENDOR_ID_3DLABS,
-				    PCI_DEVICE_ID_3DLABS_PERMEDIA3, dev);
-	}
+	tempBypass =3D PM3_READ_REG(par, PM3MemBypassWriteMask);
=20
-	if (dev) {		/* more than PM3_MAX_BOARD */
-		printk(KERN_WARNING "pm3fb: Warning: more than %d boards found\n",
-		       PM3_MAX_BOARD);
-	}
+	DPRINTK("PM3MemBypassWriteMask was: 0x%08lx\n", tempBypass);
=20
-	if (!dev_array[0]) {	/* not a single board, abort */
-		return;
-	}
+	PM3_SLOW_WRITE_REG(par, PM3MemBypassWriteMask, 0xFFFFFFFF);
=20
-	/* allocate user-defined boards */
-	for (i =3D 0; i < PM3_MAX_BOARD; i++) {
-		if ((bus[i] >=3D 0) && (slot[i] >=3D 0) && (func[i] >=3D 0)) {
-			for (j =3D 0; j < PM3_MAX_BOARD; j++) {
-				if ((dev_array[j] !=3D NULL) &&
-				    (dev_array[j]->bus->number =3D=3D bus[i])
-				    && (PCI_SLOT(dev_array[j]->devfn) =3D=3D
-					slot[i])
-				    && (PCI_FUNC(dev_array[j]->devfn) =3D=3D
-					func[i])) {
-					fb_info[i].dev =3D dev_array[j];
-					dev_array[j] =3D NULL;
-				}
-			}
-		}
-	}
-	/* allocate remaining boards */
-	for (i =3D 0; i < PM3_MAX_BOARD; i++) {
-		if (fb_info[i].dev =3D=3D NULL) {
-			done =3D 0;
-			for (j =3D 0; ((j < PM3_MAX_BOARD) && (!done)); j++) {
-				if (dev_array[j] !=3D NULL) {
-					fb_info[i].dev =3D dev_array[j];
-					dev_array[j] =3D NULL;
-					done =3D 1;
-				}
-			}
-		}
+	/* pm3 split up memory, replicates, and do a lot of nasty stuff
IMHO ;-) */
+	for (i =3D 0; i < 32; i++) {
+		fb_writel(i * 0x00345678,
+			  (screen_mem + (i * 1048576)));
+		mb();
+		temp1 =3D fb_readl((screen_mem + (i * 1048576)));
+
+		/* Let's check for wrapover, write will fail at 16MB boundary */
+		if (temp1 =3D=3D (i * 0x00345678))
+			memsize =3D i;
+		else
+			break;
 	}
=20
-	/* at that point, all PCI Permedia3 are detected and allocated */
-	/* now, initialize... or not */
-	for (i =3D 0; i < PM3_MAX_BOARD; i++) {
-		l_fb_info =3D &(fb_info[i]);
-		if (l_fb_info->dev && !disable[i]) {	/* PCI device was found
and not disabled by user */
-			DPRINTK(2,
-				"found @%lx Vendor %lx Device %lx ; base @ : %lx - %lx - %lx
- %lx - %lx - %lx, irq %ld\n",
-				(unsigned long) l_fb_info->dev,
-				(unsigned long) l_fb_info->dev->vendor,
-				(unsigned long) l_fb_info->dev->device,
-				(unsigned long)
-				pci_resource_start(l_fb_info->dev, 0),
-				(unsigned long)
-				pci_resource_start(l_fb_info->dev, 1),
-				(unsigned long)
-				pci_resource_start(l_fb_info->dev, 2),
-				(unsigned long)
-				pci_resource_start(l_fb_info->dev, 3),
-				(unsigned long)
-				pci_resource_start(l_fb_info->dev, 4),
-				(unsigned long)
-				pci_resource_start(l_fb_info->dev, 5),
-				(unsigned long) l_fb_info->dev->irq);
-
-			l_fb_info->pIOBase =3D
-			    (unsigned char *)
-			    pci_resource_start(l_fb_info->dev, 0);
-#ifdef __BIG_ENDIAN
-			l_fb_info->pIOBase +=3D PM3_REGS_SIZE;
-#endif
-			l_fb_info->vIOBase =3D (unsigned char *) -1;
-			l_fb_info->p_fb =3D
-			    (unsigned char *)
-			    pci_resource_start(l_fb_info->dev, 1);
-			l_fb_info->v_fb =3D (unsigned char *) -1;
-
-				if (!request_mem_region
-			    ((unsigned long)l_fb_info->p_fb, 64 * 1024 * 1024, /*
request full aperture size */
-			     "pm3fb")) {
-				printk
-				    (KERN_ERR "pm3fb: Error: couldn't request framebuffer
memory, board #%ld\n",
-				     l_fb_info->board_num);
-				continue;
-			}
-			if (!request_mem_region
-			    ((unsigned long)l_fb_info->pIOBase, PM3_REGS_SIZE,
-			     "pm3fb I/O regs")) {
-				printk
-				    (KERN_ERR "pm3fb: Error: couldn't request IObase memory,
board #%ld\n",
-				     l_fb_info->board_num);
-				continue;
-			}
-			if (forcesize[l_fb_info->board_num])
-				l_fb_info->fb_size =3D forcesize[l_fb_info->board_num];
+	DPRINTK("First detect pass already got %ld MB\n", memsize + 1);
=20
-			l_fb_info->fb_size =3D
-			    pm3fb_size_memory(l_fb_info);
-				if (l_fb_info->fb_size) {
-				(void) pci_enable_device(l_fb_info->dev);
-				pm3fb_common_init(l_fb_info);
-			} else
-				printk(KERN_ERR "pm3fb: memory problem, not enabling board
#%ld\n", l_fb_info->board_num);
+	if (memsize + 1 =3D=3D i) {
+		for (i =3D 0; i < 32; i++) {
+			/* Clear first 32MB ; 0 is 0, no need to byteswap */
+			writel(0x0000000,
+			       (screen_mem + (i * 1048576)));
+			mb();
+		}
+
+		for (i =3D 32; i < 64; i++) {
+			fb_writel(i * 0x00345678,
+				  (screen_mem + (i * 1048576)));
+			mb();
+			temp1 =3D
+			    fb_readl((screen_mem + (i * 1048576)));
+			temp2 =3D
+			    fb_readl((screen_mem + ((i - 32) * 1048576)));
+			/* different value, different RAM... */
+			if ((temp1 =3D=3D (i * 0x00345678)) && (temp2 =3D=3D 0))
+				memsize =3D i;
+			else
+				break;
 		}
 	}
-}
+	DPRINTK("Second detect pass got %ld MB\n", memsize + 1);
=20
-static int pm3fb_pan_display(const struct fb_var_screeninfo *var,
-			     struct fb_info_gen *info)
-{
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) info;
+	PM3_SLOW_WRITE_REG(par, PM3MemBypassWriteMask, tempBypass);
=20
-	DTRACE;
+	iounmap(screen_mem);
+	release_mem_region(pm3fb_fix.smem_start, pm3fb_fix.smem_len);
+	memsize =3D 1048576 * (memsize + 1);
=20
-	if (!current_par_valid[l_fb_info->board_num])
-		return -EINVAL;
+	DPRINTK("Returning 0x%08lx bytes\n", memsize);
=20
-	l_fb_info->current_par->base =3D	/* in 128 bits chunk - i.e.
AFTER Shiftbpp */
-	    pm3fb_Shiftbpp(l_fb_info,
-			   l_fb_info->current_par->depth,
-			   (var->yoffset * l_fb_info->current_par->width) +
-			   var->xoffset);
-	PM3_SLOW_WRITE_REG(PM3ScreenBase, l_fb_info->current_par->base);
-	return 0;
+	return memsize;
 }
=20
-static int pm3fb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
+static int __devinit pm3fb_probe(struct pci_dev *dev,
+				  const struct pci_device_id *ent)
 {
-	struct pm3fb_info *l_fb_info =3D (struct pm3fb_info *) info;
-	u32 cm, i;
-#ifdef PM3FB_MASTER_DEBUG
-	char cc[3];
-#endif /* PM3FB_MASTER_DEBUG */
+	struct fb_info *info;
+	struct pm3_par *par;
+	struct device* device =3D &dev->dev; /* for pci drivers */
+	int err, retval =3D -ENXIO;
=20
-	switch(cmd)
-	{
-#ifdef PM3FB_MASTER_DEBUG
-	case PM3FBIO_CLEARMEMORY:
-		if (copy_from_user(&cm, (void *)arg, sizeof(u32)))
-			return(-EFAULT);
-		pm3fb_clear_memory(l_fb_info, cm);
-		return(0);
-		break;
+	err =3D pci_enable_device(dev);
+	if (err) {
+		printk(KERN_WARNING "pm3fb: Can't enable PCI dev: %d\n", err);
+		return err;
+	}
+	/*
+	 * Dynamically allocate info and par
+	 */
+	info =3D framebuffer_alloc(sizeof(struct pm3_par), device);
=20
-	case PM3FBIO_CLEARCMAP:
-		if (copy_from_user(cc, (void*)arg, 3 * sizeof(char)))
-			return(-EFAULT);
-		pm3fb_clear_colormap(l_fb_info, cc[0], cc[1], cc[2]);
-		return(0);
-		break;
-#endif /* PM3FB_MASTER_DEBUG */
+	if (!info)
+		return -ENOMEM;
+	par =3D info->par;
=20
-	case PM3FBIO_RESETCHIP:
-		cm =3D 1;
-		PM3_SLOW_WRITE_REG(PM3ResetStatus, 1);
-		for (i =3D 0 ; (i < 10000) && cm ; i++)
-		{
-			PM3_DELAY(10);
-			cm =3D PM3_READ_REG(PM3ResetStatus);
-		}
-		if (cm)
-		{
-			printk(KERN_ERR "pm3fb: chip reset failed with status
0x%x\n", cm);
-			return(-EIO);
-		}
-		/* first thing first, reload memory timings */
-		pm3fb_write_memory_timings(l_fb_info);
-#ifdef PM3FB_USE_ACCEL
-		pm3fb_init_engine(l_fb_info);
-#endif /* PM3FB_USE_ACCEL */
-		pm3fb_write_mode(l_fb_info);
-		return(0);
-		break;
+	/*
+	 * Here we set the screen_base to the virtual memory address
+	 * for the framebuffer.
+	 */
+	pm3fb_fix.mmio_start =3D pci_resource_start(dev, 0);
+	pm3fb_fix.mmio_len =3D PM3_REGS_SIZE;
=20
-	default:
-		DPRINTK(2, "unknown ioctl: %d (%x)\n", cmd, cmd);
-		return(-EINVAL);
-	}
-}
+	/* Registers - request region and map it. */
+	if ( !request_mem_region(pm3fb_fix.mmio_start, pm3fb_fix.mmio_len,
+				 "pm3fb regbase") ) {
+		printk(KERN_WARNING "pm3fb: Can't reserve regbase.\n");
+		goto err_exit_neither;
+	}
+	par->v_regs =3D
+		ioremap_nocache(pm3fb_fix.mmio_start, pm3fb_fix.mmio_len);
+	if ( !par->v_regs ) {
+		printk(KERN_WARNING "pm3fb: Can't remap %s register area.\n",
+			pm3fb_fix.id);
+		release_mem_region(pm3fb_fix.mmio_start, pm3fb_fix.mmio_len);
+		goto err_exit_neither;
+	}
+
+#if defined(__BIG_ENDIAN)
+	pm3fb_fix.mmio_start +=3D PM3_REGS_SIZE;
+	DPRINTK("Adjusting register base for big-endian.\n");
+#endif
+	/* Linear frame buffer - request region and map it. */
+	pm3fb_fix.smem_start =3D pci_resource_start(dev, 1);
+	pm3fb_fix.smem_len =3D pm3fb_size_memory(par);
+	if (!pm3fb_fix.smem_len)
+	{
+		printk(KERN_WARNING "pm3fb: Can't find memory on board.\n");
+		goto err_exit_mmio;
+	}
+	if ( !request_mem_region(pm3fb_fix.smem_start, pm3fb_fix.smem_len,
+				 "pm3fb smem") ) {
+		printk(KERN_WARNING "pm3fb: Can't reserve smem.\n");
+		goto err_exit_mmio;
+	}
+	info->screen_base =3D
+		ioremap_nocache(pm3fb_fix.smem_start, pm3fb_fix.smem_len);
+	if ( !info->screen_base ) {
+		printk(KERN_WARNING "pm3fb: Can't ioremap smem area.\n");
+		release_mem_region(pm3fb_fix.smem_start, pm3fb_fix.smem_len);
+		goto err_exit_mmio;
+	}
+	info->screen_size =3D pm3fb_fix.smem_len;
+
+	info->fbops =3D &pm3fb_ops;
+
+	par->video =3D PM3_READ_REG(par, PM3VideoControl);
+
+	info->fix =3D pm3fb_fix;
+	info->pseudo_palette =3D par->palette;
+	info->flags =3D FBINFO_DEFAULT;/* | FBINFO_HWACCEL_YPAN;*/
+
+	/*
+	 * This should give a reasonable default video mode. The
following is
+	 * done when we can set a video mode.
+	 */
+	if (!mode_option)
+		mode_option =3D "640x480@60";
=20
-/* ****************************************** */
-/* ***** standard FB API init functions ***** */
-/* ****************************************** */
+	retval =3D fb_find_mode(&info->var, info, mode_option, NULL, 0,
NULL, 8);
=20
-int __init pm3fb_setup(char *options)
-{
-	long opsi =3D strlen(options);
+	if (!retval || retval =3D=3D 4) {
+		retval =3D -EINVAL;
+		goto err_exit_both;
+	}
=20
-	DTRACE;
+	/* This has to been done !!! */
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
+		retval =3D -ENOMEM;
+		goto err_exit_both;
+	}
=20
-	memcpy(g_options, options,
-	       ((opsi + 1) >
-		PM3_OPTIONS_SIZE) ? PM3_OPTIONS_SIZE : (opsi + 1));
-	g_options[PM3_OPTIONS_SIZE - 1] =3D 0;
+	/*
+	 * For drivers that can...
+	 */
+	pm3fb_check_var(&info->var, info);
=20
-	return (0);
+	if (register_framebuffer(info) < 0) {
+		retval =3D -EINVAL;
+		goto err_exit_all;
+	}
+	printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node,
+	   info->fix.id);
+	pci_set_drvdata(dev, info); /* or dev_set_drvdata(device, info) */
+	return 0;
+
+ err_exit_all:
+	fb_dealloc_cmap(&info->cmap);
+ err_exit_both:
+	iounmap(info->screen_base);
+	release_mem_region(pm3fb_fix.smem_start, pm3fb_fix.smem_len);
+ err_exit_mmio:
+	iounmap(par->v_regs);
+	release_mem_region(pm3fb_fix.mmio_start, pm3fb_fix.mmio_len);
+ err_exit_neither:
+	framebuffer_release(info);
+	return retval;
 }
=20
-int __init pm3fb_init(void)
+	/*
+	 *  Cleanup
+	 */
+static void __devexit pm3fb_remove(struct pci_dev *dev)
 {
-	DTRACE;
+	struct fb_info *info =3D pci_get_drvdata(dev);
=20
-	DPRINTK(2, "This is pm3fb.c, CVS version: $Header:
/cvsroot/linux/drivers/video/pm3fb.c,v 1.1 2002/02/25 19:11:06
marcelo Exp $");
+	if (info) {
+		struct fb_fix_screeninfo *fix =3D &info->fix;
+		struct pm3_par *par =3D info->par;
=20
-	pm3fb_real_setup(g_options);
+		unregister_framebuffer(info);
+		fb_dealloc_cmap(&info->cmap);
=20
-	pm3fb_detect();
+		iounmap(info->screen_base);
+		release_mem_region(fix->smem_start, fix->smem_len);
+		iounmap(par->v_regs);
+		release_mem_region(fix->mmio_start, fix->mmio_len);
=20
-	if (!fb_info[0].dev) {	/* not even one board ??? */
-		DPRINTK(1, "No PCI Permedia3 board detected\n");
+		pci_set_drvdata(dev, NULL);
+		framebuffer_release(info);
 	}
-	return (0);
 }
=20
-/* ************************* */
-/* **** Module support ***** */
-/* ************************* */
-
-#ifdef MODULE
-MODULE_AUTHOR("Romain Dolbeau");
-MODULE_DESCRIPTION("Permedia3 framebuffer device driver");
-static char *mode[PM3_MAX_BOARD];
-module_param_array(mode, charp, NULL, 0);
-MODULE_PARM_DESC(mode,"video mode");
-module_param_array(disable, short, NULL, 0);
-MODULE_PARM_DESC(disable,"disable board");
-static short off[PM3_MAX_BOARD];
-module_param_array(off, short, NULL, 0);
-MODULE_PARM_DESC(off,"disable board");
-static char *pciid[PM3_MAX_BOARD];
-module_param_array(pciid, charp, NULL, 0);
-MODULE_PARM_DESC(pciid,"board PCI Id");
-module_param_array(noaccel, short, NULL, 0);
-MODULE_PARM_DESC(noaccel,"disable accel");
-static char *font[PM3_MAX_BOARD];
-module_param_array(font, charp, NULL, 0);
-MODULE_PARM_DESC(font,"choose font");
-module_param(depth, short, NULL, 0);
-MODULE_PARM_DESC(depth,"boot-time depth");
-module_param(printtimings, short, NULL, 0);
-MODULE_PARM_DESC(printtimings, "print the memory timings of the
card(s)");
-module_param(forcesize, short, NULL, 0);
-MODULE_PARM_DESC(forcesize, "force specified memory size");
-/*
-MODULE_SUPPORTED_DEVICE("Permedia3 PCI boards")
-MODULE_GENERIC_TABLE(gtype,name)
-MODULE_DEVICE_TABLE(type,name)
-*/
+static struct pci_device_id pm3fb_id_table[] =3D {
+	{ PCI_VENDOR_ID_3DLABS, 0x0a,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
+	  0xff0000, 0 },
+	{ 0, }
+};
=20
-void pm3fb_build_options(void)
-{
-	int i;
-	char ts[128];
+/* For PCI drivers */
+static struct pci_driver pm3fb_driver =3D {
+	.name =3D		"pm3fb",
+	.id_table =3D	pm3fb_id_table,
+	.probe =3D	pm3fb_probe,
+	.remove =3D	__devexit_p(pm3fb_remove),
+};
=20
-	strcpy(g_options, "pm3fb");
-	for (i =3D 0; i < PM3_MAX_BOARD ; i++)
-	{
-		if (mode[i])
-		{
-			sprintf(ts, ",mode:%d:%s", i, mode[i]);
-			strncat(g_options, ts, PM3_OPTIONS_SIZE - strlen(g_options));
-		}
-		if (disable[i] || off[i])
-		{
-			sprintf(ts, ",disable:%d:", i);
-			strncat(g_options, ts, PM3_OPTIONS_SIZE - strlen(g_options));
-		}
-		if (pciid[i])
-		{
-			sprintf(ts, ",pciid:%d:%s", i, pciid[i]);
-			strncat(g_options, ts, PM3_OPTIONS_SIZE - strlen(g_options));
-		}
-		if (noaccel[i])
-		{
-			sprintf(ts, ",noaccel:%d:", i);
-			strncat(g_options, ts, PM3_OPTIONS_SIZE - strlen(g_options));
-		}
-		if (font[i])
-		{
-			sprintf(ts, ",font:%d:%s", i, font[i]);
-			strncat(g_options, ts, PM3_OPTIONS_SIZE - strlen(g_options));
-		}
-		if (depth[i])
-		{
-			sprintf(ts, ",depth:%d:%d", i, depth[i]);
-			strncat(g_options, ts, PM3_OPTIONS_SIZE - strlen(g_options));
-		}
-	}
-	g_options[PM3_OPTIONS_SIZE - 1] =3D '\0';
-	DPRINTK(1, "pm3fb use options: %s\n", g_options);
-}
+MODULE_DEVICE_TABLE(pci, pm3fb_id_table);
=20
-int init_module(void)
+int __init pm3fb_init(void)
 {
-	DTRACE;
+	/*
+	 *  For kernel boot options (in 'video=3Dpm3fb:<options>' format)
+	 */
+#ifndef MODULE
+	char *option =3D NULL;
=20
-	pm3fb_build_options();
+	if (fb_get_options("pm3fb", &option))
+		return -ENODEV;
+	pm3fb_setup(option);
+#endif
=20
-	pm3fb_init();
+	return pci_register_driver(&pm3fb_driver);
+}
=20
-	return 0;
+static void __exit pm3fb_exit(void)
+{
+	pci_unregister_driver(&pm3fb_driver);
 }
=20
-void cleanup_module(void)
+#ifdef MODULE
+	/*
+	 *  Setup
+	 */
+
+/*
+ * Only necessary if your driver takes special options,
+ * otherwise we fall back on the generic fb_setup().
+ */
+int __init pm3fb_setup(char *options)
 {
-	DTRACE;
-	{
-		unsigned long i;
-		struct pm3fb_info *l_fb_info;
-		for (i =3D 0; i < PM3_MAX_BOARD; i++) {
-			l_fb_info =3D &(fb_info[i]);
-			pci_dev_put(l_fb_info->dev);
-			if (l_fb_info->dev !=3D NULL  &&
!(disable[l_fb_info->board_num])) {
-				if (l_fb_info->vIOBase !=3D (unsigned char *) -1) {
-					pm3fb_unmapIO(l_fb_info);
-					release_mem_region(l_fb_info->p_fb,
-						   l_fb_info->fb_size);
-					release_mem_region(l_fb_info->pIOBase,
-						   PM3_REGS_SIZE);
-				}
-				unregister_framebuffer(&l_fb_info->gen.info);
-			}
-		}
-	}
+	/* Parse user speficied options (`video=3Dpm3fb:') */
+	return 0;
 }
 #endif /* MODULE */
+
+module_init(pm3fb_init);
+module_exit(pm3fb_exit);
+
+MODULE_LICENSE("GPL");
diff -urp linux-2.6.21.new/include/video/pm3fb.h
linux-2.6.21/include/video/pm3fb.h
--- linux-2.6.21.new/include/video/pm3fb.h	2007-04-26
05:08:32.000000000 +0200
+++ linux-2.6.21/include/video/pm3fb.h	2007-05-06
22:08:07.343243079 +0200
@@ -1119,117 +1119,10 @@
 /* ***** pm3fb useful define and macro ***** */
 /* ***************************************** */
=20
-/* permedia3 -specific definitions */
-#define PM3_SCALE_TO_CLOCK(pr, fe, po) ((2 * PM3_REF_CLOCK * fe)
/ (pr * (1 << (po))))
-
-/* in case it's not in linux/pci.h */
-#ifndef PCI_DEVICE_ID_3DLABS_PERMEDIA3
-#define PCI_DEVICE_ID_3DLABS_PERMEDIA3 0x000a
-#endif
-
-/* max number of simultaneous board */
-#define PM3_MAX_BOARD 4
-
 /* max size of options */
 #define PM3_OPTIONS_SIZE 256
=20
 /* max size of font name */
 #define PM3_FONTNAME_SIZE 40
=20
-/* do we want accelerated console  */
-#define PM3FB_USE_ACCEL 1
-
-/* for driver debugging ONLY */
-/* 0 =3D assert only, 1 =3D error, 2 =3D info, 3+ =3D verbose */
-/* define PM3FB_MASTER_DEBUG 1 */
-#if defined(PM3FB_MASTER_DEBUG) && (PM3FB_MASTER_DEBUG >=3D 3)
-#define PM3FB_TRACE
-#endif /* defined(PM3FB_MASTER_DEBUG) && (PM3FB_MASTER_DEBUG >=3D
3) */
-
-#ifdef PM3FB_MASTER_DEBUG
-#define DPRINTK(l,a,b...) do { if ((l) <=3D PM3FB_MASTER_DEBUG)
printk("pm3fb: %s: " a, __FUNCTION__ , ## b); } while (0)
-#define DASSERT(t,a,b...) do { if (!(t)) printk("pm3fb: _assert
failed: %s: " a, __FUNCTION__ , ## b); } while (0)
-#ifdef PM3FB_TRACE
-#define DTRACE printk("pm3fb: _enter %s\n", __FUNCTION__)
-#else /* PM3FB_TRACE */
-#define DTRACE
-#endif /* PM3FB_TRACE */
-#else /* PM3FB_MASTER_DEBUG */
-#define DPRINTK(l,a,b...)
-#define DASSERT(t,a,b...)
-#define DTRACE
-#endif /* PM3FB_MASTER_DEBUG */
-
-#if defined(PM3FB_MASTER_DEBUG) && (PM3FB_MASTER_DEBUG >=3D 2)
-#define PM3_SHOW_CUR_MODE pm3fb_show_cur_mode(l_fb_info)
-#else
-#define PM3_SHOW_CUR_MODE /* pm3fb_show_cur_mode() */
-#endif
-
-/* ******************************************** */
-/* ***** A bunch of register-access macro ***** */
-/* ******************************************** */
-
-#define PM3_WRITE_REG(r, v) fb_writel(v, (l_fb_info->vIOBase + r))
-#define PM3_READ_REG(r) fb_readl((l_fb_info->vIOBase + r))
-
-
-#define depth2bpp(d) ((d + 7L) & ~7L)
-#define depth2ByPP(d) (depth2bpp(d) / 8)
-
-#define depth_supported(d) ((d =3D=3D 8) || (d =3D=3D 12) || (d =3D=3D 1=
5)
|| (d =3D=3D 16) || (d=3D=3D32))
-
-
-#define PM3_WAIT(n) \
-do{ \
-	while(PM3_READ_REG(PM3InFIFOSpace)<(n)); \
-} while(0)
-
-#define PM3_DELAY(x) do { \
-        int delay =3D x; \
-        unsigned char tmp; \
-        while(delay--){tmp =3D PM3_READ_REG(PM3InFIFOSpace);}; \
-} while(0)
-
-#define PM3_SLOW_WRITE_REG(r,v)	\
-do{                             \
-    DASSERT((l_fb_info->vIOBase !=3D (unsigned char*)(-1)),
"l_fb_info->vIOBase mapped in slow write\n"); \
-	mb();                   \
-	PM3_WAIT(1);            \
-	mb();                   \
-    PM3_WRITE_REG(r,v);     \
-} while(0)
-
-#define PM3_SET_INDEX(index) \
-do{ \
-	PM3_SLOW_WRITE_REG(PM3RD_IndexHigh,(((index)>>8)&0xff)); \
-	PM3_SLOW_WRITE_REG(PM3RD_IndexLow,((index)&0xff)); \
-} while(0)
-
-#define PM3_WRITE_DAC_REG(r, v) \
-do { \
-     DASSERT((l_fb_info->vIOBase !=3D (unsigned char*)(-1)),
"l_fb_info->vIOBase mapped in write dac reg\n"); \
-     PM3_SET_INDEX(r); \
-     mb(); \
-     PM3_WRITE_REG(PM3RD_IndexedData, v); \
-} while (0)
-
-/* next one is really a function, added as a macro to be
consistent */
-#define PM3_READ_DAC_REG(r) pm3fb_read_dac_reg(l_fb_info, r)
-
-
-#define PM3_COLOR(c) \
-do { \
-  if (l_fb_info->current_par->depth =3D=3D 8) \
-    { \
-      c =3D (c & 0xFF); \
-      c =3D c | (c << 8); \
-    } \
-  if ((l_fb_info->current_par->depth =3D=3D 8) ||
(depth2bpp(l_fb_info->current_par->depth) =3D=3D 16)) \
-    { \
-      c =3D (c & 0xFFFF); \
-      c =3D c | (c << 16); \
-    } \
-} while (0)
-
 #endif /* PM3FB_H */


----------------------------------------------------
Sprawd=BC czym jest Mobi!
Wirtualna Polska w telefonie.
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Finfo.mobi.wp.pl&sid=3D1126

--part463e3edaafea3
Content-Type: application/octet-stream; name="pm3fb.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pm3fb.diff"

ZGlmZiAtdXJwIGxpbnV4LTIuNi4yMS5uZXcvZHJpdmVycy92aWRlby9LY29uZmlnIGxpbnV4LTIu
Ni4yMS9kcml2ZXJzL3ZpZGVvL0tjb25maWcKLS0tIGxpbnV4LTIuNi4yMS5uZXcvZHJpdmVycy92
aWRlby9LY29uZmlnCTIwMDctMDUtMDYgMjI6MjI6MTMuNTA3NDU4NDU0ICswMjAwCisrKyBsaW51
eC0yLjYuMjEvZHJpdmVycy92aWRlby9LY29uZmlnCTIwMDctMDUtMDYgMjI6MTA6MTcuMDk0NjM3
MTg5ICswMjAwCkBAIC0xMzA5LDggKzEzMDksMTEgQEAgY29uZmlnIEZCX1RSSURFTlRfQUNDRUwK
IAlhY2NlbGVyYXRpb24gZnVuY3Rpb25zLgogCiBjb25maWcgRkJfUE0zCi0JdHJpc3RhdGUgIlBl
cm1lZGlhMyBzdXBwb3J0IgotCWRlcGVuZHMgb24gRkIgJiYgUENJICYmIEJST0tFTgorCXRyaXN0
YXRlICJQZXJtZWRpYTMgc3VwcG9ydCAoRVhQRVJJTUVOVEFMKSIKKwlkZXBlbmRzIG9uIEZCICYm
IFBDSSAmJiBFWFBFUklNRU5UQUwKKwlzZWxlY3QgRkJfQ0ZCX0ZJTExSRUNUCisJc2VsZWN0IEZC
X0NGQl9DT1BZQVJFQQorCXNlbGVjdCBGQl9DRkJfSU1BR0VCTElUCiAJaGVscAogCSAgVGhpcyBp
cyB0aGUgZnJhbWUgYnVmZmVyIGRldmljZSBkcml2ZXIgZm9yIHRoZSAzRExhYnMgUGVybWVkaWEz
CiAJICBjaGlwc2V0LCB1c2VkIGluIEZvcm1hYyBQcm9Gb3JtYW5jZSBJSUksIDNETGFicyBPeHln
ZW4gVlgxICYKZGlmZiAtdXJwIGxpbnV4LTIuNi4yMS5uZXcvZHJpdmVycy92aWRlby9wbTNmYi5j
IGxpbnV4LTIuNi4yMS9kcml2ZXJzL3ZpZGVvL3BtM2ZiLmMKLS0tIGxpbnV4LTIuNi4yMS5uZXcv
ZHJpdmVycy92aWRlby9wbTNmYi5jCTIwMDctMDQtMjYgMDU6MDg6MzIuMDAwMDAwMDAwICswMjAw
CisrKyBsaW51eC0yLjYuMjEvZHJpdmVycy92aWRlby9wbTNmYi5jCTIwMDctMDUtMDYgMjI6MjA6
MDEuMzE5OTI1NTE1ICswMjAwCkBAIC0xLDU1ICsxLDI1IEBACiAvKgogICogIGxpbnV4L2RyaXZl
cnMvdmlkZW8vcG0zZmIuYyAtLSAzRExhYnMgUGVybWVkaWEzIGZyYW1lIGJ1ZmZlciBkZXZpY2UK
LSAqICAKKyAqCiAgKiAgQ29weXJpZ2h0IChDKSAyMDAxIFJvbWFpbiBEb2xiZWF1IDxkb2xiZWF1
QGlyaXNhLmZyPgorICoKKyAqICBQb3J0ZWQgdG8gMi42IGtlcm5lbCBvbiAxIE1heSAyMDA3IGJ5
IEtyenlzenRvZiBIZWx0IDxrcnp5c3p0b2YuaDFAd3AucGw+CisgKgliYXNlZCBvbiBwbTJmYi5j
CisgKgogICogIEJhc2VkIG9uIGNvZGUgd3JpdHRlbiBieToKLSAqICAgICAgICAgICBTdmVuIEx1
dGhlciwgPGx1dGhlckBkcHQtaW5mby51LXN0cmFzYmcuZnI+Ci0gKiAgICAgICAgICAgQWxhbiBI
b3VyaWhhbmUsIDxhbGFuaEBmYWlybGl0ZS5kZW1vbi5jby51az4KLSAqICAgICAgICAgICBSdXNz
ZWxsIEtpbmcsIDxybWtAYXJtLmxpbnV4Lm9yZy51az4KKyAqCSAgIFN2ZW4gTHV0aGVyLCA8bHV0
aGVyQGRwdC1pbmZvLnUtc3RyYXNiZy5mcj4KKyAqCSAgIEFsYW4gSG91cmloYW5lLCA8YWxhbmhA
ZmFpcmxpdGUuZGVtb24uY28udWs+CisgKgkgICBSdXNzZWxsIEtpbmcsIDxybWtAYXJtLmxpbnV4
Lm9yZy51az4KICAqICBCYXNlZCBvbiBsaW51eC9kcml2ZXJzL3ZpZGVvL3NrZWxldG9uZmIuYzoK
ICAqCUNvcHlyaWdodCAoQykgMTk5NyBHZWVydCBVeXR0ZXJob2V2ZW4KICAqICBCYXNlZCBvbiBs
aW51eC9kcml2ZXIvdmlkZW8vcG0yZmIuYzoKLSAqICAgICAgQ29weXJpZ2h0IChDKSAxOTk4LTE5
OTkgSWxhcmlvIE5hcmRpbm9jY2hpIChuYXJkaW5vY0BDUy5VbmlCTy5JVCkKLSAqICAgICAgQ29w
eXJpZ2h0IChDKSAxOTk5IEpha3ViIEplbGluZWsgKGpha3ViQHJlZGhhdC5jb20pCisgKglDb3B5
cmlnaHQgKEMpIDE5OTgtMTk5OSBJbGFyaW8gTmFyZGlub2NjaGkgKG5hcmRpbm9jQENTLlVuaUJP
LklUKQorICoJQ29weXJpZ2h0IChDKSAxOTk5IEpha3ViIEplbGluZWsgKGpha3ViQHJlZGhhdC5j
b20pCiAgKgogICogIFRoaXMgZmlsZSBpcyBzdWJqZWN0IHRvIHRoZSB0ZXJtcyBhbmQgY29uZGl0
aW9ucyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljCiAgKiAgTGljZW5zZS4gU2VlIHRoZSBmaWxl
IENPUFlJTkcgaW4gdGhlIG1haW4gZGlyZWN0b3J5IG9mIHRoaXMgYXJjaGl2ZSBmb3IKICAqICBt
b3JlIGRldGFpbHMuCiAgKgotICogICRIZWFkZXI6IC9jdnNyb290L2xpbnV4L2RyaXZlcnMvdmlk
ZW8vcG0zZmIuYyx2IDEuMSAyMDAyLzAyLzI1IDE5OjExOjA2IG1hcmNlbG8gRXhwICQKLSAqCi0g
KiAgQ0hBTkdFTE9HOgotICogIE1vbiBGZWIgMTEgMTA6MzU6NDggTUVUIDIwMDIsIHYgMS40LjEx
QjogQ29zbWV0aWMgdXBkYXRlLgotICogIFdlZCBKYW4gMjMgMTQ6MTY6NTkgTUVUIDIwMDIsIHYg
MS40LjExOiBQcmVsaW1pbmFyeSAyLjUueCBzdXBwb3J0LCBwYXRjaCBmb3IgMi41LjIuCi0gKiAg
V2VkIE5vdiAyOCAxMTowODoyOSBNRVQgMjAwMSwgdiAxLjQuMTA6IHBvdGVudGlhbCBidWcgZml4
IGZvciBTRFJBTS1iYXNlZCBib2FyZCwgcGF0Y2ggZm9yIDIuNC4xNi4KLSAqICBUaHUgU2VwIDIw
IDEwOjI0OjQyIE1FVCBEU1QgMjAwMSwgdiAxLjQuOTogc3luYyBidWcgZml4LCBwcmVsaW1pbmFy
eSBmbGF0cGFuZWwgc3VwcG9ydCwgYmV0dGVyIHRpbWluZ3MuCi0gKiAgVHVlIEF1ZyAyOCAxMDox
MzowMSBNRVQgRFNUIDIwMDEsIHYgMS40Ljg6IG1lbW9yeSB0aW1pbmdzIGNoZWNrLCBtaW5vciBi
dWcgZml4ZXMuCi0gKiAgV2VkIEp1bCAxOCAxOTowNjoxNCBDRVNUIDIwMDEsIHYgMS40Ljc6IE1v
ZGUgZml4ICg4MDB4NjAwLTEwMCwgMTAyNHg3NjgtMTAwIGNoYW5nZWQpLCB1c2luZyBIVyBwYW5u
aW5nICsgYWNjZWwgYnVnIGZpeC4KLSAqICBNb24gSnVuIDI1IDEwOjMzOjU2IE1FVCBEU1QgMjAw
MSwgdiAxLjQuNjogRGVwdGggMTIgZml4LCBjaGlwIHJlc2V0IGlvY3RsLCBtb3ZlZCBtZW1vcnkg
ZXJhc2UgaW9jdGwgdG8gREVCVUcuCi0gKiAgV2VkIEp1biAyMCAxMToxMzowOCBNRVQgRFNUIDIw
MDEsIHYgMS40LjU6IEZpeGVkIG1pc3NpbmcgYmxpbmtpbmcgY3Vyc29yIGluIDhicHAsIGNvZGUg
Y2xlYW5pbmcsIG1lbW9yeSBlcmFzZSBJT0NUTC4KLSAqICBNb24gSnVuIDE4IDE2OjAwOjI3IENF
U1QgMjAwMSwgdiAxLjQuNDogRGVwdGggMTIgKFJHQkEgNDQ0NCkgc3VwcG9ydCwgY29kZSBjbGVh
bmluZy4KLSAqICBGcmkgSnVuIDE1IDEzOjUzOjAxIENFU1QgMjAwMSwgdiAxLjQuMzogUmVtb3Zl
ZCB3YXJuaW5ncywgZGVwdGggMTUgc3VwcG9ydCwgYWRkICdkZXB0aCcgb3B0aW9uLgotICogIFRo
dSBKdW4gMTQgMTA6MTM6NTIgTUVUIERTVCAyMDAxLCB2IDEuNC4yOiBGaXhlZCBkZXB0aCBzd2l0
Y2hpbmcgYnVnLCBwcmVsaW1pbmFyeSAxNWJwcCAoUkdCNTU1MSkgc3VwcG9ydC4KLSAqICBUaHUg
QXByIDEyIDExOjE2OjQ1IE1FVCBEU1QgMjAwMSwgdiAxLjQuMUI6IERvYyB1cGRhdGVzLgotICog
IEZyaSBBcHIgIDYgMTE6MTI6NTMgTUVUIERTVCAyMDAxLCB2IDEuNC4xOiBDb25maWd1cmUuaGVs
cCwgbWlub3IgY2xlYW51cAotICogIFRodSBNYXIgMjkgMTA6NTY6NTAgTUVUIERTVCAyMDAxLCB2
IDEuNC4wOiBNb2R1bGUgJiBtb2R1bGUgb3B0aW9ucyBzdXBwb3J0IChub3RlOiBsaW51eCBwYXRj
aCBjaGFuZ2VkLCAyLjIuMTkgYWRkZWQpLgotICogIFRodSBNYXIgMTUgMTU6MzA6MzEgTUVUIDIw
MDEsIHYgMS4zLjI6IEZpeGVkIG1pcnJvcmluZyBidWcgb24gbGl0dGxlLWVuZGlhbi4KLSAqICBX
ZWQgTWFyIDE0IDIxOjI1OjU0IENFVCAyMDAxLCB2IDEuMy4xOiBGaXhlZCBidWcgaW4gQmxvY2tN
b3ZlIChfYm1vdikuCi0gKiAgVHVlIE1hciAxMyAxMDo1MzoxOSBNRVQgMjAwMSwgdiAxLjMuMDog
Q2hhcmFjdGVyIGRyYXdpbmcgaGFyZHdhcmUgc3VwcG9ydCAoaW4gYWxsIHdpZHRoIGJldHdlZW4g
MSBhbmQgMTYpLCBmaXhlcy4KLSAqICBUaHUgTWFyICA4IDEwOjIwOjE2IE1FVCAyMDAxLCB2IDEu
Mi4yOiBCZXR0ZXIgSjIwMDAgc3VwcG9ydCwgImZvbnQ6IiBvcHRpb24uCi0gKiAgVHVlIE1hciAg
NiAyMToyNTowNCBDRVQgMjAwMSwgdiAxLjIuMTogQmV0dGVyIGFjY2VsZXJhdGlvbiBzdXBwb3J0
LgotICogIE1vbiBNYXIgIDUgMjE6NTQ6MTcgQ0VUIDIwMDEsIHYgMS4yLjA6IFBhcnRpYWwgYWNj
ZWxlcmF0aW9uIHN1cHBvcnQgKGNsZWFyICYgYm1vdmUpCi0gKiAgTW9uIE1hciAgNSAxMjo1Mjox
NSBDRVQgMjAwMSwgdiAxLjEuMzogQmlnIHBhbl9kaXNwbGF5IGZpeC4KLSAqICBTdW4gTWFyICA0
IDIyOjIxOjUwIENFVCAyMDAxLCB2IDEuMS4yOiAobnVtZXJvdXMpIGJ1ZyBmaXhlcy4KLSAqICBG
cmkgTWFyICAyIDE1OjU0OjA3IENFVCAyMDAxLCB2IDEuMS4xOiBNaWdodCBoYXZlIEFwcGlhbiBK
MjAwMCBzdXBwb3J0LCByZXNvdXJjZSBtYW5nZW1lbnQgaW4gMi40Ci0gKiAgV2VkIEZlYiAyOCAx
ODoyMTozNSBDRVQgMjAwMSwgdiAxLjEuMDogTWlnaHQgaGF2ZSBtdWx0aXBsZSBib2FyZHMgc3Vw
cG9ydCAoYWRkZWQsIGJ1dCBub3QgeWVzdCB0ZXN0ZWQpCi0gKiAgVHVlIEZlYiAyNyAxNzozMTox
MiBDRVQgMjAwMSwgdiAxLjAuNjogZml4ZXMgYm9vdC10aW1lIG1vZGUgc2VsZWN0LCBhZGQgbW9y
ZSBkZWZhdWx0IG1vZGUKLSAqICBUdWUgRmViIDI3IDE0OjAxOjM2IENFVCAyMDAxLCB2IDEuMC41
OiBmaXhlcyAoMS4wLjQgd2FzIGJyb2tlbiBmb3IgMi4yKSwgY2xlYW5pbmcgdXAKLSAqICBNb24g
RmViIDI2IDIzOjE3OjM2IENFVCAyMDAxLCB2IDEuMC40OiBwcmVsaW1pbmFyeSAyLjQueCBzdXBw
b3J0LCBkcm9wcGVkICh1c2VsZXNzIG9uIHBtMykgcGFydGlhbCBwcm9kdWN0LCBtb3JlIE9GIGZp
eAotICogIE1vbiBGZWIgMjYgMjA6NTk6MDUgQ0VUIDIwMDEsIHYgMS4wLjM6IE5vIG1vcmUgc2hh
ZG93IHJlZ2lzdGVyIChhbmQgd2FzdGVkIG1lbW9yeSksIGVuZGlhbmVzcyBmaXgsIHVzZSBPRi1w
cmVzZXQgcmVzb2x1dGlvbiBieSBkZWZhdWx0Ci0gKiAgV2VkIEZlYiAyMSAyMjowOTozMCBDRVQg
MjAwMSwgdiAxLjAuMjogQ29kZSBjbGVhbmluZyBmb3IgZnV0dXJlIG11bHRpYm9hcmQgc3VwcG9y
dCwgYmV0dGVyIE9GIHN1cHBvcnQsIGJ1Z3MgZml4Ci0gKiAgV2VkIEZlYiAyMSAxOTo1ODo1NiBD
RVQgMjAwMSwgdiAxLjAuMTogT3BlbkZpcm13YXJlIHN1cHBvcnQsIGZpeGVkIG1lbW9yeSBkZXRl
Y3Rpb24sIGJldHRlciBkZWJ1ZyBzdXBwb3J0LCBjb2RlIGNsZWFuaW5nCi0gKiAgV2VkIEZlYiAy
MSAxNDo0NzowNiBDRVQgMjAwMSwgdiAxLjAuMDogRmlyc3Qgd29ya2luZyB2ZXJzaW9uCiAgKi8K
IAogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgpAQCAtNTgsODU2ICsyOCwxNjUgQEAKICNpbmNs
dWRlIDxsaW51eC9zdHJpbmcuaD4KICNpbmNsdWRlIDxsaW51eC9tbS5oPgogI2luY2x1ZGUgPGxp
bnV4L3NsYWIuaD4KLSNpbmNsdWRlIDxsaW51eC92bWFsbG9jLmg+CiAjaW5jbHVkZSA8bGludXgv
ZGVsYXkuaD4KLSNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KICNpbmNsdWRlIDxsaW51eC9m
Yi5oPgogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KICNpbmNsdWRlIDxsaW51eC9wY2kuaD4KLSNp
bmNsdWRlIDxsaW51eC9pb3BvcnQuaD4KLSNpbmNsdWRlIDxsaW51eC9jdHlwZS5oPgogCi0jaW5j
bHVkZSA8dmlkZW8vZmJjb24uaD4KLSNpbmNsdWRlIDx2aWRlby9mYmNvbi1tZmIuaD4KLSNpbmNs
dWRlIDx2aWRlby9mYmNvbi1jZmIyLmg+Ci0jaW5jbHVkZSA8dmlkZW8vZmJjb24tY2ZiNC5oPgot
I2luY2x1ZGUgPHZpZGVvL2ZiY29uLWNmYjguaD4KLSNpbmNsdWRlIDx2aWRlby9mYmNvbi1jZmIx
Ni5oPgotI2luY2x1ZGUgPHZpZGVvL2ZiY29uLWNmYjI0Lmg+Ci0jaW5jbHVkZSA8dmlkZW8vZmJj
b24tY2ZiMzIuaD4KICNpbmNsdWRlIDx2aWRlby9wbTNmYi5oPgogCi0jaW5jbHVkZSA8YXNtL2lv
Lmg+Ci0jaW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4KKyNpZiAhZGVmaW5lZChDT05GSUdfUENJKQor
I2Vycm9yICJPbmx5IGdlbmVyaWMgUENJIGNhcmRzIHN1cHBvcnRlZC4iCisjZW5kaWYKIAotI2lm
ZGVmIENPTkZJR19GQl9PRgotI2luY2x1ZGUgPGFzbS9wcm9tLmg+CisjdW5kZWYgUE0zRkJfTUFT
VEVSX0RFQlVHCisjaWZkZWYgUE0zRkJfTUFTVEVSX0RFQlVHCisjZGVmaW5lIERQUklOVEsoYSxi
Li4uKQlwcmludGsoS0VSTl9ERUJVRyAicG0zZmI6ICVzOiAiIGEsIF9fRlVOQ1RJT05fXyAsICMj
IGIpCisjZWxzZQorI2RlZmluZSBEUFJJTlRLKGEsYi4uLikKICNlbmRpZgogCi0vKiAqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqICovCi0vKiAqKioqKiBUaGUgdmFyaW91cyAi
Z2xvYmFsIiBkYXRhICoqKioqICovCi0vKiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqICovCi0KLS8qIHRob3NlIHdpbGwgbmVlZCBhIHJld29yayBmb3IgbXVsdGlwbGUgYm9h
cmQgc3VwcG9ydCAqLwotLyogRHJpdmVyIG5hbWUgKi8KLXN0YXRpYyBjb25zdCBjaGFyIHBlcm1l
ZGlhM19uYW1lWzE2XSA9ICJQZXJtZWRpYTMiOwotCi0vKiB0aGUgZmJfcGFyIHN0cnVjdCwgbWFu
ZGF0b3J5ICovCi1zdHJ1Y3QgcG0zZmJfcGFyIHsKLQl1MzIgcGl4Y2xvY2s7CQkvKiBwaXhjbG9j
ayBpbiBLSHogKi8KLQotCXUzMiB3aWR0aDsJCS8qIHdpZHRoIG9mIHZpcnR1YWwgc2NyZWVuICov
Ci0JdTMyIGhlaWdodDsJCS8qIGhlaWdodCBvZiB2aXJ0dWFsIHNjcmVlbiAqLwotCi0JdTMyIGhz
c3RhcnQ7CQkvKiBob3Jpei4gc3luYyBzdGFydCAqLwotCXUzMiBoc2VuZDsJCS8qIGhvcml6LiBz
eW5jIGVuZCAqLwotCXUzMiBoYmVuZDsJCS8qIGhvcml6LiBibGFuayBlbmQgKGFsc28gZ2F0ZSBl
bmQpICovCi0JdTMyIGh0b3RhbDsJCS8qIHRvdGFsIHdpZHRoICh3LyBzeW5jICYgYmxhbmspICov
Ci0KLQl1MzIgdnNzdGFydDsJCS8qIHZlcnQuIHN5bmMgc3RhcnQgKi8KLQl1MzIgdnNlbmQ7CQkv
KiB2ZXJ0LiBzeW5jIGVuZCAqLwotCXUzMiB2YmVuZDsJCS8qIHZlcnQuIGJsYW5rIGVuZCAqLwot
CXUzMiB2dG90YWw7CQkvKiB0b3RhbCBoZWlnaHQgKHcvIHN5bmMgJiBibGFuaykgKi8KLQotCXUz
MiBzdHJpZGU7CQkvKiBzY3JlZW4gc3RyaWRlICovCi0JdTMyIGJhc2U7CQkvKiBzY3JlZW4gYmFz
ZSAoeG9mZnNldCt5b2Zmc2V0KSBpbiAxMjggYml0cyB1bml0ICovCi0JLyogTk9URSA6IHVubGlr
ZSBvdGhlciBwbTMgc3R1ZmYgYWJvdmUsIHN0b3JlZCAqYWZ0ZXIqIHNoaWZ0YnBwLiBkb24ndCBh
c2sgKi8KLQl1MzIgZGVwdGg7CQkvKiBzY3JlZW4gZGVwdGggKDgsIDEyLCAxNSwgMTYgb3IgMzIp
ICovCi0JdTMyIHZpZGVvOwkJLyogdmlkZW8gY29udHJvbCAoaHN5bmMsdnN5bmMpICovCi19Owor
LyoKKyAqIERyaXZlciBkYXRhCisgKi8KK3N0YXRpYyBjaGFyICptb2RlX29wdGlvbiBfX2Rldmlu
aXRkYXRhOwogCi0vKiBtZW1vcnkgdGltaW5ncyAqLwotc3RydWN0IHBtM2ZiX3RpbWluZ3MKLXsK
LQl1bnNpZ25lZCBsb25nIGNhcHM7Ci0JdW5zaWduZWQgbG9uZyB0aW1pbmdzOwotCXVuc2lnbmVk
IGxvbmcgY29udHJvbDsKLQl1bnNpZ25lZCBsb25nIHJlZnJlc2g7Ci0JdW5zaWduZWQgbG9uZyBw
b3dlcmRvd247Ci19OwotdHlwZWRlZiBlbnVtIHBtM2ZiX3RpbWluZ19yZXN1bHQgeyBwbTNmYl90
aW1pbmdfb2ssIHBtM2ZiX3RpbWluZ19wcm9ibGVtLCBwbTNmYl90aW1pbmdfcmV0cnkgfSBwbTNm
Yl90aW1pbmdfcmVzdWx0OwotI2RlZmluZSBQTTNGQl9VTktOT1dOX1RJTUlOR19WQUxVRSAoKHVu
c2lnbmVkIGxvbmcpLTEpCi0jZGVmaW5lIFBNM0ZCX1VOS05PV05fVElNSU5HUyB7IFBNM0ZCX1VO
S05PV05fVElNSU5HX1ZBTFVFLCBQTTNGQl9VTktOT1dOX1RJTUlOR19WQUxVRSwgUE0zRkJfVU5L
Tk9XTl9USU1JTkdfVkFMVUUsIFBNM0ZCX1VOS05PV05fVElNSU5HX1ZBTFVFLCBQTTNGQl9VTktO
T1dOX1RJTUlOR19WQUxVRSB9Ci0KLS8qIHRoZSBmYl9pbmZvIHN0cnVjdCwgbWFuZGF0b3J5ICov
Ci1zdHJ1Y3QgcG0zZmJfaW5mbyB7Ci0Jc3RydWN0IGZiX2luZm9fZ2VuIGdlbjsKLQl1bnNpZ25l
ZCBsb25nIGJvYXJkX251bTsgLyogaW50ZXJuYWwgYm9hcmQgbnVtYmVyICovCi0JdW5zaWduZWQg
bG9uZyB1c2VfY3VycmVudDsKLQlzdHJ1Y3QgcG0zZmJfcGFyICpjdXJyZW50X3BhcjsKLQlzdHJ1
Y3QgcGNpX2RldiAqZGV2OyAgICAvKiBQQ0kgZGV2aWNlICovCi0JdW5zaWduZWQgbG9uZyBib2Fy
ZF90eXBlOyAvKiBpbmRleCBpbiB0aGUgY2FyZGJhc2UgKi8KLQl1bnNpZ25lZCBjaGFyICpmYl9i
YXNlOwkvKiBmcmFtZWJ1ZmZlciBtZW1vcnkgYmFzZSAqLwotCXUzMiBmYl9zaXplOwkJLyogZnJh
bWVidWZmZXIgbWVtb3J5IHNpemUgKi8KLQl1bnNpZ25lZCBjaGFyICpwX2ZiOwkvKiBwaHlzaWNh
bCBhZGRyZXNzIG9mIGZyYW1lIGJ1ZmZlciAqLwotCXVuc2lnbmVkIGNoYXIgKnZfZmI7CS8qIHZp
cnR1YWwgYWRkcmVzcyBvZiBmcmFtZSBidWZmZXIgKi8KLQl1bnNpZ25lZCBjaGFyICpwSU9CYXNl
OwkvKiBwaHlzaWNhbCBhZGRyZXNzIG9mIHJlZ2lzdGVycyByZWdpb24sIG11c3QgYmUgcmdfYmFz
ZSBvciByZ19iYXNlK1BNMl9SRUdTX1NJWkUgZGVwZW5kaW5nIG9uIHRoZSBob3N0IGVuZGlhbm5l
c3MgKi8KLQl1bnNpZ25lZCBjaGFyICp2SU9CYXNlOwkvKiBhZGRyZXNzIG9mIHJlZ2lzdGVycyBh
ZnRlciBpb3JlbWFwKCkgKi8KLQlzdHJ1Y3QgewotCQl1OCB0cmFuc3A7Ci0JCXU4IHJlZDsKLQkJ
dTggZ3JlZW47Ci0JCXU4IGJsdWU7Ci0JfSBwYWxldHRlWzI1Nl07Ci0JdW5pb24gewotI2lmZGVm
IEZCQ09OX0hBU19DRkIxNgotCQl1MTYgY21hcDEyWzE2XTsgLyogUkdCQSA0NDQ0ICovCi0JCXUx
NiBjbWFwMTVbMTZdOyAvKiBSR0JBIDU1NTEgKi8KLQkJdTE2IGNtYXAxNlsxNl07IC8qIFJHQkEg
NTY1MCAqLwotI2VuZGlmCi0jaWZkZWYgRkJDT05fSEFTX0NGQjMyCi0JCXUzMiBjbWFwMzJbMTZd
OwotI2VuZGlmCi0JfSBjbWFwOwotCXN0cnVjdCBwbTNmYl90aW1pbmdzIG1lbXQ7Ci19OworLyoK
KyAqICBJZiB5b3VyIGRyaXZlciBzdXBwb3J0cyBtdWx0aXBsZSBib2FyZHMsIHlvdSBzaG91bGQg
bWFrZSB0aGUKKyAqICBiZWxvdyBkYXRhIHR5cGVzIGFycmF5cywgb3IgYWxsb2NhdGUgdGhlbSBk
eW5hbWljYWxseSAodXNpbmcga21hbGxvYygpKS4KKyAqLwogCi0vKiByZWd1bGFyIHJlc29sdXRp
b24gZGF0YWJhc2UqLwotc3RhdGljIHN0cnVjdCB7Ci0JY2hhciBuYW1lWzE2XTsKLQlzdHJ1Y3Qg
cG0zZmJfcGFyIHVzZXJfbW9kZTsKLX0gbW9kZV9iYXNlW10gX19pbml0ZGF0YSA9IHsKLQl7Ci0J
CSJkZWZhdWx0LTgwMHg2MDAiLCB7Ci0JNDk1MDAsIDgwMCwgNjAwLCAxNiwgOTYsIDI1NiwgMTA1
NiwgMSwgNCwgMjUsIDYyNSwKLQkJCSAgICA4MDAsIDAsIDgsCi0JCQkgICAgUE0zVmlkZW9Db250
cm9sX0VOQUJMRSB8Ci0JCQkgICAgUE0zVmlkZW9Db250cm9sX0hTWU5DX0FDVElWRV9ISUdICi0J
CQkgICAgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfSElHSAotCQkJICAg
IHwgUE0zVmlkZW9Db250cm9sX1BJWEVMU0laRV84QklUfX0sIHsKLQkJIjEwMjR4NzY4LTc0Iiwg
ewotCTc4NzUyLCAxMDI0LCA3NjgsIDMyLCAxMjgsIDMwNCwgMTMyOCwgMSwgNCwgMzgsCi0JCQkg
ICAgODA2LCAxMDI0LCAwLCA4LAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9FTkFCTEUgfAotCQkJ
ICAgIFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19BQ1RJVkVfSElHSAotCQkJICAgIHwKLQkJCSAgICBQ
TTNWaWRlb0NvbnRyb2xfVlNZTkNfQUNUSVZFX0hJR0gKLQkJCSAgICB8IFBNM1ZpZGVvQ29udHJv
bF9QSVhFTFNJWkVfOEJJVH19LCB7Ci0JCSIxMDI0eDc2OC03NC0zMiIsIHsKLQkJCTc4NzUyLCAx
MDI0LCA3NjgsIDMyLCAxMjgsIDMwNCwgMTMyOCwgMSwgNCwgMzgsCi0JCQk4MDYsIDEwMjQsIDAs
IDMyLAotCQkJUE0zVmlkZW9Db250cm9sX0VOQUJMRSB8Ci0JCQlQTTNWaWRlb0NvbnRyb2xfSFNZ
TkNfQUNUSVZFX0hJR0gKLQkJCXwKLQkJCVBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfSElH
SAotCQkJfCBQTTNWaWRlb0NvbnRyb2xfUElYRUxTSVpFXzMyQklUfX0sCi0vKiBHZW5lcmF0ZWQg
bW9kZSA6ICIxNjAweDEwMjQiLCBmb3IgdGhlIFNHSSAxNjAwU1cgZmxhdCBwYW5lbCovCi0Jewot
CQkiU0dJMTYwMFNXIiwgewotCQkJMTA4MDAwLCAxNjAwLCAxMDI0LCAxNiwgNTYsIDEwNCwgMTcw
NCwgMywgNiwgMzIsCi0JCQkxMDU2LCAxNjAwLCAwLCA4LAotCQkJUE0zVmlkZW9Db250cm9sX0VO
QUJMRXwKLQkJCVBNM1ZpZGVvQ29udHJvbF9IU1lOQ19BQ1RJVkVfTE9XfFBNM1ZpZGVvQ29udHJv
bF9WU1lOQ19BQ1RJVkVfTE9XfAotCQkJUE0zVmlkZW9Db250cm9sX1BJWEVMU0laRV8zMkJJVH19
LCAKLS8qICMjIyMjIGF1dG8tZ2VuZXJhdGVkIG1vZGUsIGJ5IGZidGltaW5nczJwbTMgKi8KLS8q
IEdlbmVyYXRlZCBtb2RlIDogIjY0MHg0ODAtNjAiICovCi0JewotCQkiNjQweDQ4MC02MCIsIHsK
LQkyNTE3NCwgNjQwLCA0ODAsIDE2LCAxMTIsIDE2MCwgODAwLCAxMCwgMTIsIDQ1LAotCQkJICAg
IDUyNSwgNjQwLCAwLCA4LAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9FTkFCTEUgfAotCQkJICAg
IFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19BQ1RJVkVfTE9XCi0JCQkgICAgfAotCQkJICAgIFBNM1Zp
ZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfTE9XCi0JCQkgICAgfCBQTTNWaWRlb0NvbnRyb2xfUElY
RUxTSVpFXzhCSVR9fSwKLS8qIEdlbmVyYXRlZCBtb2RlIDogIjY0MHg0ODAtNzIiICovCi0Jewot
CQkiNjQweDQ4MC03MiIsIHsKLQkzMTE5OSwgNjQwLCA0ODAsIDI0LCA2NCwgMTkyLCA4MzIsIDks
IDEyLCA0MCwgNTIwLAotCQkJICAgIDY0MCwgMCwgOCwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xf
RU5BQkxFIHwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfSFNZTkNfQUNUSVZFX0xPVwotCQkJICAg
IHwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfVlNZTkNfQUNUSVZFX0xPVwotCQkJICAgIHwgUE0z
VmlkZW9Db250cm9sX1BJWEVMU0laRV84QklUfX0sCi0vKiBHZW5lcmF0ZWQgbW9kZSA6ICI2NDB4
NDgwLTc1IiAqLwotCXsKLQkJIjY0MHg0ODAtNzUiLCB7Ci0JMzE0OTksIDY0MCwgNDgwLCAxNiwg
ODAsIDIwMCwgODQwLCAxLCA0LCAyMCwgNTAwLAotCQkJICAgIDY0MCwgMCwgOCwKLQkJCSAgICBQ
TTNWaWRlb0NvbnRyb2xfRU5BQkxFIHwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfSFNZTkNfQUNU
SVZFX0xPVwotCQkJICAgIHwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfVlNZTkNfQUNUSVZFX0xP
VwotCQkJICAgIHwgUE0zVmlkZW9Db250cm9sX1BJWEVMU0laRV84QklUfX0sCi0vKiBHZW5lcmF0
ZWQgbW9kZSA6ICI2NDB4NDgwLTkwIiAqLwotCXsKLQkJIjY0MHg0ODAtOTAiLCB7Ci0JMzk5MDks
IDY0MCwgNDgwLCAzMiwgNzIsIDE5MiwgODMyLCAyNSwgMzksIDUzLCA1MzMsCi0JCQkgICAgNjQw
LCAwLCA4LAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9FTkFCTEUgfAotCQkJICAgIFBNM1ZpZGVv
Q29udHJvbF9IU1lOQ19BQ1RJVkVfTE9XCi0JCQkgICAgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJv
bF9WU1lOQ19BQ1RJVkVfTE9XCi0JCQkgICAgfCBQTTNWaWRlb0NvbnRyb2xfUElYRUxTSVpFXzhC
SVR9fSwKLS8qIEdlbmVyYXRlZCBtb2RlIDogIjY0MHg0ODAtMTAwIiAqLwotCXsKLQkJIjY0MHg0
ODAtMTAwIiwgewotCTQ0ODk5LCA2NDAsIDQ4MCwgMzIsIDE2MCwgMjA4LCA4NDgsIDIyLCAzNCwg
NTEsCi0JCQkgICAgNTMxLCA2NDAsIDAsIDgsCi0JCQkgICAgUE0zVmlkZW9Db250cm9sX0VOQUJM
RSB8Ci0JCQkgICAgUE0zVmlkZW9Db250cm9sX0hTWU5DX0FDVElWRV9MT1cKLQkJCSAgICB8Ci0J
CQkgICAgUE0zVmlkZW9Db250cm9sX1ZTWU5DX0FDVElWRV9MT1cKLQkJCSAgICB8IFBNM1ZpZGVv
Q29udHJvbF9QSVhFTFNJWkVfOEJJVH19LAotLyogR2VuZXJhdGVkIG1vZGUgOiAiODAweDYwMC00
OC1sYWNlIiAqLwotLyogSU5URVJMQUNFRCBOT1QgU1VQUE9SVEVECi0gIHsiODAweDYwMC00OC1s
YWNlIiwgezM1OTk5LCA4MDAsIDYwMCwgODAsIDIwOCwgMjY0LCAxMDY0LCAxMSwgMjMsIDEwMiwg
NzAyLCA4MDAsIDAsIDgsIFBNM1ZpZGVvQ29udHJvbF9FTkFCTEV8UE0zVmlkZW9Db250cm9sX0hT
WU5DX0FDVElWRV9ISUdIfFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfSElHSHxQTTNWaWRl
b0NvbnRyb2xfUElYRUxTSVpFXzhCSVR9fSwgCi0gICBJTlRFUkxBQ0VEIE5PVCBTVVBQT1JURUQg
Ki8KLS8qIEdlbmVyYXRlZCBtb2RlIDogIjgwMHg2MDAtNTYiICovCi0JewotCQkiODAweDYwMC01
NiIsIHsKLQkzNTk5OSwgODAwLCA2MDAsIDI0LCA5NiwgMjI0LCAxMDI0LCAxLCAzLCAyNSwgNjI1
LAotCQkJICAgIDgwMCwgMCwgOCwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfRU5BQkxFIHwKLQkJ
CSAgICBQTTNWaWRlb0NvbnRyb2xfSFNZTkNfQUNUSVZFX0hJR0gKLQkJCSAgICB8Ci0JCQkgICAg
UE0zVmlkZW9Db250cm9sX1ZTWU5DX0FDVElWRV9ISUdICi0JCQkgICAgfCBQTTNWaWRlb0NvbnRy
b2xfUElYRUxTSVpFXzhCSVR9fSwKLS8qIEdlbmVyYXRlZCBtb2RlIDogIjgwMHg2MDAtNjAiICov
Ci0JewotCQkiODAweDYwMC02MCIsIHsKLQk0MDAwMCwgODAwLCA2MDAsIDQwLCAxNjgsIDI1Niwg
MTA1NiwgMSwgNSwgMjgsIDYyOCwKLQkJCSAgICA4MDAsIDAsIDgsCi0JCQkgICAgUE0zVmlkZW9D
b250cm9sX0VOQUJMRSB8Ci0JCQkgICAgUE0zVmlkZW9Db250cm9sX0hTWU5DX0FDVElWRV9ISUdI
Ci0JCQkgICAgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfSElHSAotCQkJ
ICAgIHwgUE0zVmlkZW9Db250cm9sX1BJWEVMU0laRV84QklUfX0sCi0vKiBHZW5lcmF0ZWQgbW9k
ZSA6ICI4MDB4NjAwLTcwIiAqLwotCXsKLQkJIjgwMHg2MDAtNzAiLCB7Ci0JNDQ4OTksIDgwMCwg
NjAwLCAyNCwgMTY4LCAyMDgsIDEwMDgsIDksIDIxLCAzNiwKLQkJCSAgICA2MzYsIDgwMCwgMCwg
OCwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfRU5BQkxFIHwKLQkJCSAgICBQTTNWaWRlb0NvbnRy
b2xfSFNZTkNfQUNUSVZFX0hJR0gKLQkJCSAgICB8Ci0JCQkgICAgUE0zVmlkZW9Db250cm9sX1ZT
WU5DX0FDVElWRV9MT1cKLQkJCSAgICB8IFBNM1ZpZGVvQ29udHJvbF9QSVhFTFNJWkVfOEJJVH19
LAotLyogR2VuZXJhdGVkIG1vZGUgOiAiODAweDYwMC03MiIgKi8KLQl7Ci0JCSI4MDB4NjAwLTcy
IiwgewotCTUwMDAwLCA4MDAsIDYwMCwgNTYsIDE3NiwgMjQwLCAxMDQwLCAzNywgNDMsIDY2LAot
CQkJICAgIDY2NiwgODAwLCAwLCA4LAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9FTkFCTEUgfAot
CQkJICAgIFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19BQ1RJVkVfSElHSAotCQkJICAgIHwKLQkJCSAg
ICBQTTNWaWRlb0NvbnRyb2xfVlNZTkNfQUNUSVZFX0hJR0gKLQkJCSAgICB8IFBNM1ZpZGVvQ29u
dHJvbF9QSVhFTFNJWkVfOEJJVH19LAotLyogR2VuZXJhdGVkIG1vZGUgOiAiODAweDYwMC03NSIg
Ki8KLQl7Ci0JCSI4MDB4NjAwLTc1IiwgewotCTQ5NDk3LCA4MDAsIDYwMCwgMTYsIDk2LCAyNTYs
IDEwNTYsIDEsIDQsIDI1LCA2MjUsCi0JCQkgICAgODAwLCAwLCA4LAotCQkJICAgIFBNM1ZpZGVv
Q29udHJvbF9FTkFCTEUgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19BQ1RJVkVfSElH
SAotCQkJICAgIHwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfVlNZTkNfQUNUSVZFX0hJR0gKLQkJ
CSAgICB8IFBNM1ZpZGVvQ29udHJvbF9QSVhFTFNJWkVfOEJJVH19LAotLyogR2VuZXJhdGVkIG1v
ZGUgOiAiODAweDYwMC05MCIgKi8KLQl7Ci0JCSI4MDB4NjAwLTkwIiwgewotCTU2NjM3LCA4MDAs
IDYwMCwgOCwgNzIsIDE5MiwgOTkyLCA4LCAxOSwgMzUsIDYzNSwKLQkJCSAgICA4MDAsIDAsIDgs
Ci0JCQkgICAgUE0zVmlkZW9Db250cm9sX0VOQUJMRSB8Ci0JCQkgICAgUE0zVmlkZW9Db250cm9s
X0hTWU5DX0FDVElWRV9ISUdICi0JCQkgICAgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9WU1lO
Q19BQ1RJVkVfSElHSAotCQkJICAgIHwgUE0zVmlkZW9Db250cm9sX1BJWEVMU0laRV84QklUfX0s
Ci0vKiBHZW5lcmF0ZWQgbW9kZSA6ICI4MDB4NjAwLTEwMCIsIGZyb20gL2V0Yy9mYi5tb2RlcyAq
LwotLyogRElTQUJMRUQsIGhzc3RhcnQgPT0gMAotCXsKLQkJIjgwMHg2MDAtMTAwIiwgewotCTY3
NDk5LCA4MDAsIDYwMCwgMCwgNjQsIDI4MCwgMTA4MCwgNywgMTEsIDI1LCA2MjUsCi0JCQkgICAg
ODAwLCAwLCA4LAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9FTkFCTEUgfAotCQkJICAgIFBNM1Zp
ZGVvQ29udHJvbF9IU1lOQ19BQ1RJVkVfSElHSAotCQkJICAgIHwKLQkJCSAgICBQTTNWaWRlb0Nv
bnRyb2xfVlNZTkNfQUNUSVZFX0hJR0gKLQkJCSAgICB8IFBNM1ZpZGVvQ29udHJvbF9QSVhFTFNJ
WkVfOEJJVH19LAotKi8KLS8qIEdlbmVyYXRlZCBtb2RlIDogIjgwMHg2MDAtMTAwIiwgZnJvbSA/
Pz8gKi8KLQl7Ci0JCSI4MDB4NjAwLTEwMCIsIHsKLQkJCTY5NjUwLCA4MDAsIDYwMCwgNjQsIDEy
OCwgMjg4LCAxMDg4LCA0LCAxMCwgNDAsIDY0MCwgODAwLCAwLCA4LAotCQkJUE0zVmlkZW9Db250
cm9sX0VOQUJMRXxQTTNWaWRlb0NvbnRyb2xfSFNZTkNfQUNUSVZFX0xPV3wKLQkJCVBNM1ZpZGVv
Q29udHJvbF9WU1lOQ19BQ1RJVkVfTE9XfFBNM1ZpZGVvQ29udHJvbF9QSVhFTFNJWkVfOEJJVH19
LAotLyogR2VuZXJhdGVkIG1vZGUgOiAiMTAyNHg3NjgtNDMtbGFjZSIgKi8KLS8qIElOVEVSTEFD
RUQgTk9UIFNVUFBPUlRFRAotICB7IjEwMjR4NzY4LTQzLWxhY2UiLCB7NDQ4OTksIDEwMjQsIDc2
OCwgOCwgMTg0LCAyNDAsIDEyNjQsIDEsIDksIDQ5LCA4MTcsIDEwMjQsIDAsIDgsIFBNM1ZpZGVv
Q29udHJvbF9FTkFCTEV8UE0zVmlkZW9Db250cm9sX0hTWU5DX0FDVElWRV9ISUdIfFBNM1ZpZGVv
Q29udHJvbF9WU1lOQ19BQ1RJVkVfSElHSHxQTTNWaWRlb0NvbnRyb2xfUElYRUxTSVpFXzhCSVR9
fSwgCi0gICBJTlRFUkxBQ0VEIE5PVCBTVVBQT1JURUQgKi8KLS8qIEdlbmVyYXRlZCBtb2RlIDog
IjEwMjR4NzY4LTYwIiAqLwotCXsKLQkJIjEwMjR4NzY4LTYwIiwgewotCTY0OTk4LCAxMDI0LCA3
NjgsIDI0LCAxNjAsIDMyMCwgMTM0NCwgMywgOSwgMzgsCi0JCQkgICAgODA2LCAxMDI0LCAwLCA4
LAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9FTkFCTEUgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJv
bF9IU1lOQ19BQ1RJVkVfTE9XCi0JCQkgICAgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9WU1lO
Q19BQ1RJVkVfTE9XCi0JCQkgICAgfCBQTTNWaWRlb0NvbnRyb2xfUElYRUxTSVpFXzhCSVR9fSwK
LS8qIEdlbmVyYXRlZCBtb2RlIDogIjEwMjR4NzY4LTcwIiAqLwotCXsKLQkJIjEwMjR4NzY4LTcw
IiwgewotCTc0OTk2LCAxMDI0LCA3NjgsIDI0LCAxNjAsIDMwNCwgMTMyOCwgMywgOSwgMzgsCi0J
CQkgICAgODA2LCAxMDI0LCAwLCA4LAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9FTkFCTEUgfAot
CQkJICAgIFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19BQ1RJVkVfTE9XCi0JCQkgICAgfAotCQkJICAg
IFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfTE9XCi0JCQkgICAgfCBQTTNWaWRlb0NvbnRy
b2xfUElYRUxTSVpFXzhCSVR9fSwKLS8qIEdlbmVyYXRlZCBtb2RlIDogIjEwMjR4NzY4LTcyIiAq
LwotCXsKLQkJIjEwMjR4NzY4LTcyIiwgewotCTc0OTk2LCAxMDIyNCwgNzY4LCAyNCwgMTYwLCAy
NjQsIDEwNDg4LCAzLCA5LCAzOCwKLQkJCSAgICA4MDYsIDEwMjI0LCAwLCA4LAotCQkJICAgIFBN
M1ZpZGVvQ29udHJvbF9FTkFCTEUgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19BQ1RJ
VkVfTE9XCi0JCQkgICAgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfTE9X
Ci0JCQkgICAgfCBQTTNWaWRlb0NvbnRyb2xfUElYRUxTSVpFXzhCSVR9fSwKLS8qIEdlbmVyYXRl
ZCBtb2RlIDogIjEwMjR4NzY4LTc1IiAqLwotCXsKLQkJIjEwMjR4NzY4LTc1IiwgewotCTc4NzQ2
LCAxMDI0LCA3NjgsIDE2LCAxMTIsIDI4OCwgMTMxMiwgMSwgNCwgMzIsCi0JCQkgICAgODAwLCAx
MDI0LCAwLCA4LAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9FTkFCTEUgfAotCQkJICAgIFBNM1Zp
ZGVvQ29udHJvbF9IU1lOQ19BQ1RJVkVfSElHSAotCQkJICAgIHwKLQkJCSAgICBQTTNWaWRlb0Nv
bnRyb2xfVlNZTkNfQUNUSVZFX0hJR0gKLQkJCSAgICB8IFBNM1ZpZGVvQ29udHJvbF9QSVhFTFNJ
WkVfOEJJVH19LAotLyogR2VuZXJhdGVkIG1vZGUgOiAiMTAyNHg3NjgtOTAiICovCi0JewotCQki
MTAyNHg3NjgtOTAiLCB7Ci0JMTAwMDAwLCAxMDI0LCA3NjgsIDAsIDk2LCAyODgsIDEzMTIsIDIx
LCAzNiwgNzcsCi0JCQkgICAgODQ1LCAxMDI0LCAwLCA4LAotCQkJICAgIFBNM1ZpZGVvQ29udHJv
bF9FTkFCTEUgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19BQ1RJVkVfTE9XCi0JCQkg
ICAgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfTE9XCi0JCQkgICAgfCBQ
TTNWaWRlb0NvbnRyb2xfUElYRUxTSVpFXzhCSVR9fSwKLS8qIEdlbmVyYXRlZCBtb2RlIDogIjEw
MjR4NzY4LTEwMCIsIGZyb20gL2V0Yy9mYi5tb2RlcyAqLwotLyogRElTQUJMRUQsIHZzc3RhcnQg
PT0gMAotCXsKLQkJIjEwMjR4NzY4LTEwMCIsIHsKLQkxMDk5OTgsIDEwMjQsIDc2OCwgMCwgODgs
IDM2OCwgMTM5MiwgMCwgOCwgMjQsIDc5MiwKLQkJCSAgICAxMDI0LCAwLCA4LAotCQkJICAgIFBN
M1ZpZGVvQ29udHJvbF9FTkFCTEUgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19BQ1RJ
VkVfTE9XCi0JCQkgICAgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfTE9X
Ci0JCQkgICAgfCBQTTNWaWRlb0NvbnRyb2xfUElYRUxTSVpFXzhCSVR9fSwKLSovCi0vKiBHZW5l
cmF0ZWQgbW9kZSA6ICIxMDI0eDc2OC0xMDAiLCBmcm9tID8/PyAqLwotCXsKLQkJIjEwMjR4NzY4
LTEwMCIsIHsKLQkJCTExNTUwMCwgMTAyNCwgNzY4LCAzMiwgMjI0LCA0MTYsIDE0NDAsIDMsIDEz
LCAzNCwgODAyLCAxMDI0LCAwLCA4LAotCQkJUE0zVmlkZW9Db250cm9sX0VOQUJMRXxQTTNWaWRl
b0NvbnRyb2xfSFNZTkNfQUNUSVZFX0xPV3wKLQkJCVBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJ
VkVfTE9XfFBNM1ZpZGVvQ29udHJvbF9QSVhFTFNJWkVfOEJJVH19LAotLyogR2VuZXJhdGVkIG1v
ZGUgOiAiMTE1Mng4NjQtNDMtbGFjZSIgKi8KLS8qIElOVEVSTEFDRUQgTk9UIFNVUFBPUlRFRAot
ICB7IjExNTJ4ODY0LTQzLWxhY2UiLCB7NjQ5OTgsIDExNTIsIDg2NCwgNzIsIDIwMCwgMjY0LCAx
NDE2LCA3OCwgODcsIDE5MSwgMTA1NSwgMTE1MiwgMCwgOCwgUE0zVmlkZW9Db250cm9sX0VOQUJM
RXxQTTNWaWRlb0NvbnRyb2xfSFNZTkNfQUNUSVZFX0hJR0h8UE0zVmlkZW9Db250cm9sX1ZTWU5D
X0FDVElWRV9ISUdIfFBNM1ZpZGVvQ29udHJvbF9QSVhFTFNJWkVfOEJJVH19LCAKLSAgIElOVEVS
TEFDRUQgTk9UIFNVUFBPUlRFRCAqLwotLyogR2VuZXJhdGVkIG1vZGUgOiAiMTE1Mng4NjQtNDct
bGFjZSIgKi8KLS8qIElOVEVSTEFDRUQgTk9UIFNVUFBPUlRFRAotICB7IjExNTJ4ODY0LTQ3LWxh
Y2UiLCB7NjQ5OTgsIDExNTIsIDg2NCwgODgsIDIxNiwgMjk2LCAxNDQ4LCAzMCwgMzksIDgzLCA5
NDcsIDExNTIsIDAsIDgsIFBNM1ZpZGVvQ29udHJvbF9FTkFCTEV8UE0zVmlkZW9Db250cm9sX0hT
WU5DX0FDVElWRV9ISUdIfFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfSElHSHxQTTNWaWRl
b0NvbnRyb2xfUElYRUxTSVpFXzhCSVR9fSwgCi0gICBJTlRFUkxBQ0VEIE5PVCBTVVBQT1JURUQg
Ki8KLS8qIEdlbmVyYXRlZCBtb2RlIDogIjExNTJ4ODY0LTYwIiAqLwotCXsKLQkJIjExNTJ4ODY0
LTYwIiwgewotCTgwMDAwLCAxMTUyLCA4NjQsIDY0LCAxNzYsIDMwNCwgMTQ1NiwgNiwgMTEsIDUy
LAotCQkJICAgIDkxNiwgMTE1MiwgMCwgOCwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfRU5BQkxF
IHwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfSFNZTkNfQUNUSVZFX0hJR0gKLQkJCSAgICB8Ci0J
CQkgICAgUE0zVmlkZW9Db250cm9sX1ZTWU5DX0FDVElWRV9ISUdICi0JCQkgICAgfCBQTTNWaWRl
b0NvbnRyb2xfUElYRUxTSVpFXzhCSVR9fSwKLS8qIEdlbmVyYXRlZCBtb2RlIDogIjExNTJ4ODY0
LTcwIiAqLwotCXsKLQkJIjExNTJ4ODY0LTcwIiwgewotCTEwMDAwMCwgMTE1MiwgODY0LCA0MCwg
MTkyLCAzNjAsIDE1MTIsIDEzLCAyNCwgODEsCi0JCQkgICAgOTQ1LCAxMTUyLCAwLCA4LAotCQkJ
ICAgIFBNM1ZpZGVvQ29udHJvbF9FTkFCTEUgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9IU1lO
Q19BQ1RJVkVfSElHSAotCQkJICAgIHwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfVlNZTkNfQUNU
SVZFX0hJR0gKLQkJCSAgICB8IFBNM1ZpZGVvQ29udHJvbF9QSVhFTFNJWkVfOEJJVH19LAotLyog
R2VuZXJhdGVkIG1vZGUgOiAiMTE1Mng4NjQtNzUiICovCi0JewotCQkiMTE1Mng4NjQtNzUiLCB7
Ci0JMTA5OTk4LCAxMTUyLCA4NjQsIDI0LCAxNjgsIDMxMiwgMTQ2NCwgNDUsIDUzLCAxMzgsCi0J
CQkgICAgMTAwMiwgMTE1MiwgMCwgOCwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfRU5BQkxFIHwK
LQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfSFNZTkNfQUNUSVZFX0hJR0gKLQkJCSAgICB8Ci0JCQkg
ICAgUE0zVmlkZW9Db250cm9sX1ZTWU5DX0FDVElWRV9ISUdICi0JCQkgICAgfCBQTTNWaWRlb0Nv
bnRyb2xfUElYRUxTSVpFXzhCSVR9fSwKLS8qIEdlbmVyYXRlZCBtb2RlIDogIjExNTJ4ODY0LTgw
IiAqLwotCXsKLQkJIjExNTJ4ODY0LTgwIiwgewotCTEwOTk5OCwgMTE1MiwgODY0LCAxNiwgMTI4
LCAyODgsIDE0NDAsIDMwLCAzNywgOTQsCi0JCQkgICAgOTU4LCAxMTUyLCAwLCA4LAotCQkJICAg
IFBNM1ZpZGVvQ29udHJvbF9FTkFCTEUgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19B
Q1RJVkVfSElHSAotCQkJICAgIHwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfVlNZTkNfQUNUSVZF
X0hJR0gKLQkJCSAgICB8IFBNM1ZpZGVvQ29udHJvbF9QSVhFTFNJWkVfOEJJVH19LAotLyogR2Vu
ZXJhdGVkIG1vZGUgOiAiMTI4MHgxMDI0LTQzLWxhY2UiICovCi0vKiBJTlRFUkxBQ0VEIE5PVCBT
VVBQT1JURUQKLSAgeyIxMjgweDEwMjQtNDMtbGFjZSIsIHs4MDAwMCwgMTAyNCwgMTAyNCwgODAs
IDE2MCwgMzIwLCAxMzQ0LCA1MCwgNjAsIDEyNSwgMTE0OSwgMTAyNCwgMCwgOCwgUE0zVmlkZW9D
b250cm9sX0VOQUJMRXxQTTNWaWRlb0NvbnRyb2xfSFNZTkNfQUNUSVZFX0hJR0h8UE0zVmlkZW9D
b250cm9sX1ZTWU5DX0FDVElWRV9ISUdIfFBNM1ZpZGVvQ29udHJvbF9QSVhFTFNJWkVfOEJJVH19
LCAKLSAgIElOVEVSTEFDRUQgTk9UIFNVUFBPUlRFRCAqLwotLyogR2VuZXJhdGVkIG1vZGUgOiAi
MTI4MHgxMDI0LTQ3LWxhY2UiICovCi0vKiBJTlRFUkxBQ0VEIE5PVCBTVVBQT1JURUQKLSAgeyIx
MjgweDEwMjQtNDctbGFjZSIsIHs4MDAwMCwgMTI4MCwgMTAyNCwgODAsIDE2MCwgMzIwLCAxNjAw
LCAxLCAxMSwgMjksIDEwNTMsIDEyODAsIDAsIDgsIFBNM1ZpZGVvQ29udHJvbF9FTkFCTEV8UE0z
VmlkZW9Db250cm9sX0hTWU5DX0FDVElWRV9ISUdIfFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJ
VkVfSElHSHxQTTNWaWRlb0NvbnRyb2xfUElYRUxTSVpFXzhCSVR9fSwgCi0gICBJTlRFUkxBQ0VE
IE5PVCBTVVBQT1JURUQgKi8KLS8qIEdlbmVyYXRlZCBtb2RlIDogIjEyODB4MTAyNC02MCIgKi8K
LQl7Ci0JCSIxMjgweDEwMjQtNjAiLCB7Ci0JMTA3OTkxLCAxMjgwLCAxMDI0LCA0OCwgMTYwLCA0
MDgsIDE2ODgsIDEsIDQsIDQyLAotCQkJICAgIDEwNjYsIDEyODAsIDAsIDgsCi0JCQkgICAgUE0z
VmlkZW9Db250cm9sX0VOQUJMRSB8Ci0JCQkgICAgUE0zVmlkZW9Db250cm9sX0hTWU5DX0FDVElW
RV9ISUdICi0JCQkgICAgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfSElH
SAotCQkJICAgIHwgUE0zVmlkZW9Db250cm9sX1BJWEVMU0laRV84QklUfX0sCi0vKiBHZW5lcmF0
ZWQgbW9kZSA6ICIxMjgweDEwMjQtNzAiICovCi0JewotCQkiMTI4MHgxMDI0LTcwIiwgewotCTEy
NTk5MiwgMTI4MCwgMTAyNCwgODAsIDE5MiwgNDA4LCAxNjg4LCAxLCA2LCA0MiwKLQkJCSAgICAx
MDY2LCAxMjgwLCAwLCA4LAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9FTkFCTEUgfAotCQkJICAg
IFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19BQ1RJVkVfSElHSAotCQkJICAgIHwKLQkJCSAgICBQTTNW
aWRlb0NvbnRyb2xfVlNZTkNfQUNUSVZFX0hJR0gKLQkJCSAgICB8IFBNM1ZpZGVvQ29udHJvbF9Q
SVhFTFNJWkVfOEJJVH19LAotLyogR2VuZXJhdGVkIG1vZGUgOiAiMTI4MHgxMDI0LTc0IiAqLwot
CXsKLQkJIjEyODB4MTAyNC03NCIsIHsKLQkxMzQ5ODksIDEyODAsIDEwMjQsIDMyLCAxNzYsIDQz
MiwgMTcxMiwgMCwgMzAsIDQwLAotCQkJICAgIDEwNjQsIDEyODAsIDAsIDgsCi0JCQkgICAgUE0z
VmlkZW9Db250cm9sX0VOQUJMRSB8Ci0JCQkgICAgUE0zVmlkZW9Db250cm9sX0hTWU5DX0FDVElW
RV9ISUdICi0JCQkgICAgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfSElH
SAotCQkJICAgIHwgUE0zVmlkZW9Db250cm9sX1BJWEVMU0laRV84QklUfX0sCi0vKiBHZW5lcmF0
ZWQgbW9kZSA6ICIxMjgweDEwMjQtNzUiICovCi0JewotCQkiMTI4MHgxMDI0LTc1IiwgewotCTEz
NDk4OSwgMTI4MCwgMTAyNCwgMTYsIDE2MCwgNDA4LCAxNjg4LCAxLCA0LCA0MiwKLQkJCSAgICAx
MDY2LCAxMjgwLCAwLCA4LAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9FTkFCTEUgfAotCQkJICAg
IFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19BQ1RJVkVfSElHSAotCQkJICAgIHwKLQkJCSAgICBQTTNW
aWRlb0NvbnRyb2xfVlNZTkNfQUNUSVZFX0hJR0gKLQkJCSAgICB8IFBNM1ZpZGVvQ29udHJvbF9Q
SVhFTFNJWkVfOEJJVH19LAotLyogR2VuZXJhdGVkIG1vZGUgOiAiMTYwMHgxMjAwLTYwIiAqLwot
CXsKLQkJIjE2MDB4MTIwMC02MCIsIHsKLQkxNTU5ODEsIDE2MDAsIDEyMDAsIDMyLCAxOTIsIDQ0
OCwgMjA0OCwgMTAsIDE4LCA3MCwKLQkJCSAgICAxMjcwLCAxNjAwLCAwLCA4LAotCQkJICAgIFBN
M1ZpZGVvQ29udHJvbF9FTkFCTEUgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19BQ1RJ
VkVfTE9XCi0JCQkgICAgfAotCQkJICAgIFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfTE9X
Ci0JCQkgICAgfCBQTTNWaWRlb0NvbnRyb2xfUElYRUxTSVpFXzhCSVR9fSwKLS8qIEdlbmVyYXRl
ZCBtb2RlIDogIjE2MDB4MTIwMC02NiIgKi8KLQl7Ci0JCSIxNjAweDEyMDAtNjYiLCB7Ci0JMTcx
OTk4LCAxNjAwLCAxMjAwLCA0MCwgMTc2LCA0ODAsIDIwODAsIDMsIDYsIDUzLAotCQkJICAgIDEy
NTMsIDE2MDAsIDAsIDgsCi0JCQkgICAgUE0zVmlkZW9Db250cm9sX0VOQUJMRSB8Ci0JCQkgICAg
UE0zVmlkZW9Db250cm9sX0hTWU5DX0FDVElWRV9MT1cKLQkJCSAgICB8Ci0JCQkgICAgUE0zVmlk
ZW9Db250cm9sX1ZTWU5DX0FDVElWRV9MT1cKLQkJCSAgICB8IFBNM1ZpZGVvQ29udHJvbF9QSVhF
TFNJWkVfOEJJVH19LAotLyogR2VuZXJhdGVkIG1vZGUgOiAiMTYwMHgxMjAwLTc2IiAqLwotCXsK
LQkJIjE2MDB4MTIwMC03NiIsIHsKLQkxOTc5ODAsIDE2MDAsIDEyMDAsIDQwLCAxNzYsIDQ4MCwg
MjA4MCwgMywgOCwgNTAsCi0JCQkgICAgMTI1MCwgMTYwMCwgMCwgOCwKLQkJCSAgICBQTTNWaWRl
b0NvbnRyb2xfRU5BQkxFIHwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfSFNZTkNfQUNUSVZFX0xP
VwotCQkJICAgIHwKLQkJCSAgICBQTTNWaWRlb0NvbnRyb2xfVlNZTkNfQUNUSVZFX0xPVwotCQkJ
ICAgIHwgUE0zVmlkZW9Db250cm9sX1BJWEVMU0laRV84QklUfX0sCi0vKiAjIyMjIyBlbmQgb2Yg
YXV0by1nZW5lcmF0ZWQgbW9kZSAqLwotCXsKLQkiXDAiLH0KKy8qCisgKiBUaGlzIHN0cnVjdHVy
ZSBkZWZpbmVzIHRoZSBoYXJkd2FyZSBzdGF0ZSBvZiB0aGUgZ3JhcGhpY3MgY2FyZC4gTm9ybWFs
bHkKKyAqIHlvdSBwbGFjZSB0aGlzIGluIGEgaGVhZGVyIGZpbGUgaW4gbGludXgvaW5jbHVkZS92
aWRlby4gVGhpcyBmaWxlIHVzdWFsbHkKKyAqIGFsc28gaW5jbHVkZXMgcmVnaXN0ZXIgaW5mb3Jt
YXRpb24uIFRoYXQgYWxsb3dzIG90aGVyIGRyaXZlciBzdWJzeXN0ZW1zCisgKiBhbmQgdXNlcmxh
bmQgYXBwbGljYXRpb25zIHRoZSBhYmlsaXR5IHRvIHVzZSB0aGUgc2FtZSBoZWFkZXIgZmlsZSB0
bworICogYXZvaWQgZHVwbGljYXRlIHdvcmsgYW5kIGVhc3kgcG9ydGluZyBvZiBzb2Z0d2FyZS4K
KyAqLworc3RydWN0IHBtM19wYXIgeworCXVuc2lnbmVkIGNoYXIJX19pb21lbSAqdl9yZWdzOy8q
IHZpcnR1YWwgYWRkcmVzcyBvZiBwX3JlZ3MgKi8KKwl1MzIJCXZpZGVvOwkJLyogdmlkZW8gZmxh
Z3MgYmVmb3JlIGJsYW5raW5nICovCisJdTMyCQliYXNlOwkJLyogc2NyZWVuIGJhc2UgKHhvZmZz
ZXQreW9mZnNldCkgaW4gMTI4IGJpdHMgdW5pdCAqLworCXUzMiAJCXBhbGV0dGVbMTZdOwogfTsK
IAotLyogbW9yZSBtYW5kYXRvcnkgc3R1ZmYgKHNlZSBza2VsZXRvbmZiLmMgKyBmcmFtZWJ1ZmZl
ciBkcml2ZXIgSE9XVE8gKi8KLXN0YXRpYyBzdHJ1Y3QgcG0zZmJfaW5mbyBmYl9pbmZvW1BNM19N
QVhfQk9BUkRdOwotc3RhdGljIHN0cnVjdCBwbTNmYl9wYXIgY3VycmVudF9wYXJbUE0zX01BWF9C
T0FSRF07Ci1zdGF0aWMgaW50IGN1cnJlbnRfcGFyX3ZhbGlkW1BNM19NQVhfQk9BUkRdOwotLyog
dG8gYWxsb3cgZXhwbGljaXQgZmlsdGVyaW5nIG9mIGJvYXJkICovCi1zaG9ydCBidXNbUE0zX01B
WF9CT0FSRF07Ci1zaG9ydCBzbG90W1BNM19NQVhfQk9BUkRdOwotc2hvcnQgZnVuY1tQTTNfTUFY
X0JPQVJEXTsKLXNob3J0IGRpc2FibGVbUE0zX01BWF9CT0FSRF07Ci1zaG9ydCBub2FjY2VsW1BN
M19NQVhfQk9BUkRdOwotY2hhciBmb250bltQTTNfTUFYX0JPQVJEXVtQTTNfRk9OVE5BTUVfU0la
RV07Ci1zaG9ydCBkZXB0aFtQTTNfTUFYX0JPQVJEXTsKLXNob3J0IGZsYXRwYW5lbFtQTTNfTUFY
X0JPQVJEXTsKLXN0YXRpYyBzdHJ1Y3QgZGlzcGxheSBkaXNwW1BNM19NQVhfQk9BUkRdOwotc3Rh
dGljIGNoYXIgZ19vcHRpb25zW1BNM19PUFRJT05TX1NJWkVdIF9faW5pdGRhdGEgPSAicG0zZmIs
ZHVtbXkiOwotc2hvcnQgcHJpbnR0aW1pbmdzID0gMDsKLXNob3J0IGZvcmNlc2l6ZVtQTTNfTUFY
X0JPQVJEXTsKLQotLyogKioqKioqKioqKioqKioqKioqKioqICovCi0vKiAqKioqKiBwcm90b3R5
cGUgKioqKiogKi8KLS8qICoqKioqKioqKioqKioqKioqKioqKiAqLwotLyogY2FyZC1zcGVjaWZp
YyAqLwotc3RhdGljIHZvaWQgcG0zZmJfajIwMDBfc2V0dXAoc3RydWN0IHBtM2ZiX2luZm8gKmxf
ZmJfaW5mbyk7Ci0vKiBwZXJtZWRpYTMtc3BlY2lmaWMgKi8KLXN0YXRpYyBwbTNmYl90aW1pbmdf
cmVzdWx0IHBtM2ZiX3ByZXNlcnZlX21lbW9yeV90aW1pbmdzKHN0cnVjdCBwbTNmYl9pbmZvICps
X2ZiX2luZm8pOwotc3RhdGljIHBtM2ZiX3RpbWluZ19yZXN1bHQgcG0zZmJfdHJ5X21lbW9yeV90
aW1pbmdzKHN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8pOwotc3RhdGljIHZvaWQgcG0zZmJf
d3JpdGVfbWVtb3J5X3RpbWluZ3Moc3RydWN0IHBtM2ZiX2luZm8gKmxfZmJfaW5mbyk7Ci1zdGF0
aWMgdW5zaWduZWQgbG9uZyBwbTNmYl9yZWFkX2RhY19yZWcoc3RydWN0IHBtM2ZiX2luZm8gKmxf
ZmJfaW5mbywKLQkJCQkJdW5zaWduZWQgbG9uZyByKTsKLXN0YXRpYyB1bnNpZ25lZCBsb25nIHBt
M2ZiX0NhbGN1bGF0ZUNsb2NrKHN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8sIHVuc2lnbmVk
IGxvbmcgcmVxY2xvY2ssCS8qIEluIGtIeiB1bml0cyAqLwotCQkJCQkgIHVuc2lnbmVkIGxvbmcg
cmVmY2xvY2ssCS8qIEluIGtIeiB1bml0cyAqLwotCQkJCQkgIHVuc2lnbmVkIGNoYXIgKnByZXNj
YWxlLAkvKiBDbGtQcmVTY2FsZSAqLwotCQkJCQkgIHVuc2lnbmVkIGNoYXIgKmZlZWRiYWNrLAkv
KiBDbGtGZWVkQmFja1NjYWxlICovCi0JCQkJCSAgdW5zaWduZWQgY2hhciAqcG9zdHNjYWxlCi0J
CQkJCSAgLyogQ2xrUG9zdFNjYWxlICovICk7Ci1zdGF0aWMgdm9pZCBwbTNmYl9jbGVhcl9tZW1v
cnkoc3RydWN0IHBtM2ZiX2luZm8gKmxfZmJfaW5mbywgdTMyIGNjKTsKLXN0YXRpYyB2b2lkIHBt
M2ZiX2NsZWFyX2NvbG9ybWFwKHN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8sIHVuc2lnbmVk
IGNoYXIgciwgdW5zaWduZWQgY2hhciBnLCB1bnNpZ25lZCBjaGFyIGIpOwotc3RhdGljIHZvaWQg
cG0zZmJfY29tbW9uX2luaXQoc3RydWN0IHBtM2ZiX2luZm8gKmxfZmJfaW5mbyk7Ci1zdGF0aWMg
aW50IHBtM2ZiX1NoaWZ0YnBwKHN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8sCi0JCQkgIHVu
c2lnbmVkIGxvbmcgZGVwdGgsIGludCB2KTsKLXN0YXRpYyBpbnQgcG0zZmJfVW5zaGlmdGJwcChz
dHJ1Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvLAotCQkJICAgIHVuc2lnbmVkIGxvbmcgZGVwdGgs
IGludCB2KTsKLXN0YXRpYyB2b2lkIHBtM2ZiX21hcElPKHN0cnVjdCBwbTNmYl9pbmZvICpsX2Zi
X2luZm8pOwotc3RhdGljIHZvaWQgcG0zZmJfdW5tYXBJTyhzdHJ1Y3QgcG0zZmJfaW5mbyAqbF9m
Yl9pbmZvKTsKLSNpZiBkZWZpbmVkKFBNM0ZCX01BU1RFUl9ERUJVRykgJiYgKFBNM0ZCX01BU1RF
Ul9ERUJVRyA+PSAyKQotc3RhdGljIHZvaWQgcG0zZmJfc2hvd19jdXJfbW9kZShzdHJ1Y3QgcG0z
ZmJfaW5mbyAqbF9mYl9pbmZvKTsKLSNlbmRpZgotc3RhdGljIHZvaWQgcG0zZmJfc2hvd19jdXJf
dGltaW5nKHN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8pOwotc3RhdGljIHZvaWQgcG0zZmJf
d3JpdGVfbW9kZShzdHJ1Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvKTsKLXN0YXRpYyB2b2lkIHBt
M2ZiX3JlYWRfbW9kZShzdHJ1Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvLAotCQkJICAgIHN0cnVj
dCBwbTNmYl9wYXIgKmN1cnBhcik7Ci1zdGF0aWMgdW5zaWduZWQgbG9uZyBwbTNmYl9zaXplX21l
bW9yeShzdHJ1Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvKTsKLS8qIGFjY2VsZXJhdGVkIHBlcm1l
ZGlhMy1zcGVjaWZpYyAqLwotI2lmZGVmIFBNM0ZCX1VTRV9BQ0NFTAotc3RhdGljIHZvaWQgcG0z
ZmJfd2FpdF9wbTMoc3RydWN0IHBtM2ZiX2luZm8gKmxfZmJfaW5mbyk7Ci1zdGF0aWMgdm9pZCBw
bTNmYl9pbml0X2VuZ2luZShzdHJ1Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvKTsKLSNpZmRlZiBG
QkNPTl9IQVNfQ0ZCMzIKLXN0YXRpYyB2b2lkIHBtM2ZiX2NmYjMyX2NsZWFyKHN0cnVjdCB2Y19k
YXRhICpjb25wLAotCQkJICAgICAgc3RydWN0IGRpc3BsYXkgKnAsCi0JCQkgICAgICBpbnQgc3ks
IGludCBzeCwgaW50IGhlaWdodCwgaW50IHdpZHRoKTsKLXN0YXRpYyB2b2lkIHBtM2ZiX2NmYjMy
X2NsZWFyX21hcmdpbnMoc3RydWN0IHZjX2RhdGEgKmNvbnAsCi0JCQkJICAgICAgc3RydWN0IGRp
c3BsYXkgKnAsIGludCBib3R0b21fb25seSk7Ci0jZW5kaWYgLyogRkJDT05fSEFTX0NGQjMyICov
Ci0jaWZkZWYgRkJDT05fSEFTX0NGQjE2Ci1zdGF0aWMgdm9pZCBwbTNmYl9jZmIxNl9jbGVhcihz
dHJ1Y3QgdmNfZGF0YSAqY29ucCwKLQkJCSAgICAgIHN0cnVjdCBkaXNwbGF5ICpwLAotCQkJICAg
ICAgaW50IHN5LCBpbnQgc3gsIGludCBoZWlnaHQsIGludCB3aWR0aCk7Ci1zdGF0aWMgdm9pZCBw
bTNmYl9jZmIxNl9jbGVhcl9tYXJnaW5zKHN0cnVjdCB2Y19kYXRhICpjb25wLAotCQkJCSAgICAg
IHN0cnVjdCBkaXNwbGF5ICpwLCBpbnQgYm90dG9tX29ubHkpOwotI2VuZGlmIC8qIEZCQ09OX0hB
U19DRkIxNiAqLwotI2lmZGVmIEZCQ09OX0hBU19DRkI4Ci1zdGF0aWMgdm9pZCBwbTNmYl9jZmI4
X2NsZWFyKHN0cnVjdCB2Y19kYXRhICpjb25wLAotCQkJICAgICBzdHJ1Y3QgZGlzcGxheSAqcCwK
LQkJCSAgICAgaW50IHN5LCBpbnQgc3gsIGludCBoZWlnaHQsIGludCB3aWR0aCk7Ci1zdGF0aWMg
dm9pZCBwbTNmYl9jZmI4X2NsZWFyX21hcmdpbnMoc3RydWN0IHZjX2RhdGEgKmNvbnAsCi0JCQkJ
ICAgICBzdHJ1Y3QgZGlzcGxheSAqcCwgaW50IGJvdHRvbV9vbmx5KTsKLSNlbmRpZiAvKiBGQkNP
Tl9IQVNfQ0ZCOCAqLwotI2lmIGRlZmluZWQoRkJDT05fSEFTX0NGQjgpIHx8IGRlZmluZWQoRkJD
T05fSEFTX0NGQjE2KSB8fCBkZWZpbmVkKEZCQ09OX0hBU19DRkIzMikKLXN0YXRpYyB2b2lkIHBt
M2ZiX2NmYlhfYm1vdmUoc3RydWN0IGRpc3BsYXkgKnAsCi0JCQkgICAgIGludCBzeSwgaW50IHN4
LAotCQkJICAgICBpbnQgZHksIGludCBkeCwgaW50IGhlaWdodCwgaW50IHdpZHRoKTsKLXN0YXRp
YyB2b2lkIHBtM2ZiX2NmYlhfcHV0YyhzdHJ1Y3QgdmNfZGF0YSAqY29ucCwgc3RydWN0IGRpc3Bs
YXkgKnAsCi0JCQkgICAgaW50IGMsIGludCB5eSwgaW50IHh4KTsKLXN0YXRpYyB2b2lkIHBtM2Zi
X2NmYlhfcHV0Y3Moc3RydWN0IHZjX2RhdGEgKmNvbnAsIHN0cnVjdCBkaXNwbGF5ICpwLAotCQkJ
ICAgICBjb25zdCB1bnNpZ25lZCBzaG9ydCAqcywgaW50IGNvdW50LCBpbnQgeXksCi0JCQkgICAg
IGludCB4eCk7Ci1zdGF0aWMgdm9pZCBwbTNmYl9jZmJYX3JldmMoc3RydWN0IGRpc3BsYXkgKnAs
IGludCB4eCwgaW50IHl5KTsKLSNlbmRpZiAvKiBGQkNPTl9IQVNfQ0ZCOCB8fCBGQkNPTl9IQVNf
Q0ZCMTYgfHwgRkJDT05fSEFTX0NGQjMyICovCi0jZW5kaWYgLyogUE0zRkJfVVNFX0FDQ0VMICov
Ci0vKiBwcmUtaW5pdCAqLwotc3RhdGljIHZvaWQgcG0zZmJfbW9kZV9zZXR1cChjaGFyICptb2Rl
LCB1bnNpZ25lZCBsb25nIGJvYXJkX251bSk7Ci1zdGF0aWMgdm9pZCBwbTNmYl9wY2lpZF9zZXR1
cChjaGFyICpwY2lpZCwgdW5zaWduZWQgbG9uZyBib2FyZF9udW0pOwotc3RhdGljIGNoYXIgKnBt
M2ZiX2JvYXJkbnVtX3NldHVwKGNoYXIgKm9wdGlvbnMsIHVuc2lnbmVkIGxvbmcgKmJuKTsKLXN0
YXRpYyB2b2lkIHBtM2ZiX3JlYWxfc2V0dXAoY2hhciAqb3B0aW9ucyk7Ci0vKiBmYmRldiAqLwot
c3RhdGljIGludCBwbTNmYl9lbmNvZGVfZml4KHN0cnVjdCBmYl9maXhfc2NyZWVuaW5mbyAqZml4
LAotCQkJICAgIGNvbnN0IHZvaWQgKnBhciwgc3RydWN0IGZiX2luZm9fZ2VuICppbmZvKTsKLXN0
YXRpYyBpbnQgcG0zZmJfZGVjb2RlX3Zhcihjb25zdCBzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8g
KnZhciwKLQkJCSAgICB2b2lkICpwYXIsIHN0cnVjdCBmYl9pbmZvX2dlbiAqaW5mbyk7Ci1zdGF0
aWMgdm9pZCBwbTNmYl9lbmNvZGVfZGVwdGgoc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIs
IGxvbmcgZCk7Ci1zdGF0aWMgaW50IHBtM2ZiX2VuY29kZV92YXIoc3RydWN0IGZiX3Zhcl9zY3Jl
ZW5pbmZvICp2YXIsCi0JCQkgICAgY29uc3Qgdm9pZCAqcGFyLCBzdHJ1Y3QgZmJfaW5mb19nZW4g
KmluZm8pOwotc3RhdGljIHZvaWQgcG0zZmJfZ2V0X3Bhcih2b2lkICpwYXIsIHN0cnVjdCBmYl9p
bmZvX2dlbiAqaW5mbyk7Ci1zdGF0aWMgdm9pZCBwbTNmYl9zZXRfcGFyKGNvbnN0IHZvaWQgKnBh
ciwgc3RydWN0IGZiX2luZm9fZ2VuICppbmZvKTsKLXN0YXRpYyB2b2lkIHBtM2ZiX3NldF9jb2xv
cihzdHJ1Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvLAotCQkJICAgIHVuc2lnbmVkIGNoYXIgcmVn
bm8sIHVuc2lnbmVkIGNoYXIgciwKLQkJCSAgICB1bnNpZ25lZCBjaGFyIGcsIHVuc2lnbmVkIGNo
YXIgYik7Ci1zdGF0aWMgaW50IHBtM2ZiX2dldGNvbHJlZyh1bnNpZ25lZCByZWdubywgdW5zaWdu
ZWQgKnJlZCwgdW5zaWduZWQgKmdyZWVuLAotCQkJICAgdW5zaWduZWQgKmJsdWUsIHVuc2lnbmVk
ICp0cmFuc3AsCi0JCQkgICBzdHJ1Y3QgZmJfaW5mbyAqaW5mbyk7Ci1zdGF0aWMgaW50IHBtM2Zi
X3NldGNvbHJlZyh1bnNpZ25lZCByZWdubywgdW5zaWduZWQgcmVkLCB1bnNpZ25lZCBncmVlbiwK
LQkJCSAgIHVuc2lnbmVkIGJsdWUsIHVuc2lnbmVkIHRyYW5zcCwKLQkJCSAgIHN0cnVjdCBmYl9p
bmZvICppbmZvKTsKLXN0YXRpYyBpbnQgcG0zZmJfYmxhbmsoaW50IGJsYW5rX21vZGUsIHN0cnVj
dCBmYl9pbmZvX2dlbiAqaW5mbyk7Ci1zdGF0aWMgdm9pZCBwbTNmYl9zZXRfZGlzcChjb25zdCB2
b2lkICpwYXIsIHN0cnVjdCBkaXNwbGF5ICpkaXNwLAotCQkJICAgc3RydWN0IGZiX2luZm9fZ2Vu
ICppbmZvKTsKLXN0YXRpYyB2b2lkIHBtM2ZiX2RldGVjdCh2b2lkKTsKLXN0YXRpYyBpbnQgcG0z
ZmJfcGFuX2Rpc3BsYXkoY29uc3Qgc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIsCi0JCQkg
ICAgIHN0cnVjdCBmYl9pbmZvX2dlbiAqaW5mbyk7Ci1zdGF0aWMgaW50IHBtM2ZiX2lvY3RsKHN0
cnVjdCBmYl9pbmZvICppbmZvLCB1X2ludCBjbWQsIHVfbG9uZyBhcmcpOworLyoKKyAqIEhlcmUg
d2UgZGVmaW5lIHRoZSBkZWZhdWx0IHN0cnVjdHMgZmJfZml4X3NjcmVlbmluZm8gYW5kIGZiX3Zh
cl9zY3JlZW5pbmZvCisgKiBpZiB3ZSBkb24ndCB1c2UgbW9kZWRiLiBJZiB3ZSBkbyB1c2UgbW9k
ZWRiIHNlZSBwbTNmYl9pbml0IGhvdyB0byB1c2UgaXQKKyAqIHRvIGdldCBhIGZiX3Zhcl9zY3Jl
ZW5pbmZvLiBPdGhlcndpc2UgZGVmaW5lIGEgZGVmYXVsdCB2YXIgYXMgd2VsbC4KKyAqLworc3Rh
dGljIHN0cnVjdCBmYl9maXhfc2NyZWVuaW5mbyBwbTNmYl9maXggX19kZXZpbml0ZGF0YSA9IHsK
KwkuaWQgPQkJIlBlcm1lZGlhMyIsCisJLnR5cGUgPQkJRkJfVFlQRV9QQUNLRURfUElYRUxTLAor
CS52aXN1YWwgPQlGQl9WSVNVQUxfUFNFVURPQ09MT1IsCisJLnhwYW5zdGVwID0JMSwKKwkueXBh
bnN0ZXAgPQkxLAorCS55d3JhcHN0ZXAgPQkwLAorCS5hY2NlbCA9CUZCX0FDQ0VMX05PTkUsCit9
OwogCisvKgorICogVXRpbGl0eSBmdW5jdGlvbnMKKyAqLwogCi0vKiB0aGUgc3RydWN0IHRoYXQg
aG9sZCB0aGVtIHRvZ2V0aGVyICovCi1zdHJ1Y3QgZmJnZW5faHdzd2l0Y2ggcG0zZmJfc3dpdGNo
ID0gewotCXBtM2ZiX2RldGVjdCwgcG0zZmJfZW5jb2RlX2ZpeCwgcG0zZmJfZGVjb2RlX3Zhciwg
cG0zZmJfZW5jb2RlX3ZhciwKLQlwbTNmYl9nZXRfcGFyLCBwbTNmYl9zZXRfcGFyLCBwbTNmYl9n
ZXRjb2xyZWcsIAotCXBtM2ZiX3Bhbl9kaXNwbGF5LCBwbTNmYl9ibGFuaywgcG0zZmJfc2V0X2Rp
c3AKLX07CitzdGF0aWMgaW5saW5lIHUzMiBQTTNfUkVBRF9SRUcoc3RydWN0IHBtM19wYXIgKnBh
ciwgczMyIG9mZikKK3sKKwlyZXR1cm4gZmJfcmVhZGwocGFyLT52X3JlZ3MgKyBvZmYpOworfQog
Ci1zdGF0aWMgc3RydWN0IGZiX29wcyBwbTNmYl9vcHMgPSB7Ci0JLm93bmVyID0JVEhJU19NT0RV
TEUsCi0JLmZiX2dldF9maXggPQlmYmdlbl9nZXRfZml4LAotCS5mYl9nZXRfdmFyID0JZmJnZW5f
Z2V0X3ZhciwKLQkuZmJfc2V0X3ZhciA9CWZiZ2VuX3NldF92YXIsCi0JLmZiX2dldF9jbWFwID0J
ZmJnZW5fZ2V0X2NtYXAsCi0JLmZiX3NldF9jbWFwID0JZmJnZW5fc2V0X2NtYXAsCi0JLmZiX3Nl
dGNvbHJlZyA9CXBtM2ZiX3NldGNvbHJlZywKLQkuZmJfcGFuX2Rpc3BsYXkgPWZiZ2VuX3Bhbl9k
aXNwbGF5LAotCS5mYl9ibGFuayA9CWZiZ2VuX2JsYW5rLAotCS5mYl9pb2N0bCA9CXBtM2ZiX2lv
Y3RsLAotfTsKK3N0YXRpYyBpbmxpbmUgdm9pZCBQTTNfV1JJVEVfUkVHKHN0cnVjdCBwbTNfcGFy
ICpwYXIsIHMzMiBvZmYsIHUzMiB2KQoreworCWZiX3dyaXRlbCh2LCBwYXItPnZfcmVncyArIG9m
Zik7Cit9CiAKLSNpZmRlZiBQTTNGQl9VU0VfQUNDRUwKLSNpZmRlZiBGQkNPTl9IQVNfQ0ZCMzIK
LXN0YXRpYyBzdHJ1Y3QgZGlzcGxheV9zd2l0Y2ggcG0zZmJfY2ZiMzIgPSB7Ci0JZmJjb25fY2Zi
MzJfc2V0dXAsIHBtM2ZiX2NmYlhfYm1vdmUsIHBtM2ZiX2NmYjMyX2NsZWFyLAotCXBtM2ZiX2Nm
YlhfcHV0YywgcG0zZmJfY2ZiWF9wdXRjcywgcG0zZmJfY2ZiWF9yZXZjLAotCU5VTEwgLyogY3Vy
c29yKCkgKi8gLCBOVUxMIC8qIHNldF9mb250KCkgKi8gLAotCXBtM2ZiX2NmYjMyX2NsZWFyX21h
cmdpbnMsCi0JRk9OVFdJRFRIUkFOR0UoMSwgMTYpCS8qIHRydWUgb25seSBpZiBhY2NlbGVyYXRl
ZC4uLiAqLwotfTsKLSNlbmRpZiAvKiBGQkNPTl9IQVNfQ0ZCMzIgKi8KLSNpZmRlZiBGQkNPTl9I
QVNfQ0ZCMTYKLXN0YXRpYyBzdHJ1Y3QgZGlzcGxheV9zd2l0Y2ggcG0zZmJfY2ZiMTYgPSB7Ci0J
ZmJjb25fY2ZiMTZfc2V0dXAsIHBtM2ZiX2NmYlhfYm1vdmUsIHBtM2ZiX2NmYjE2X2NsZWFyLAot
CXBtM2ZiX2NmYlhfcHV0YywgcG0zZmJfY2ZiWF9wdXRjcywgcG0zZmJfY2ZiWF9yZXZjLAotCU5V
TEwgLyogY3Vyc29yKCkgKi8gLCBOVUxMIC8qIHNldF9mb250KCkgKi8gLAotCXBtM2ZiX2NmYjE2
X2NsZWFyX21hcmdpbnMsCi0JRk9OVFdJRFRIUkFOR0UoMSwgMTYpCS8qIHRydWUgb25seSBpZiBh
Y2NlbGVyYXRlZC4uLiAqLwotfTsKLSNlbmRpZiAvKiBGQkNPTl9IQVNfQ0ZCMTYgKi8KLSNpZmRl
ZiBGQkNPTl9IQVNfQ0ZCOAotc3RhdGljIHN0cnVjdCBkaXNwbGF5X3N3aXRjaCBwbTNmYl9jZmI4
ID0gewotCWZiY29uX2NmYjhfc2V0dXAsIHBtM2ZiX2NmYlhfYm1vdmUsIHBtM2ZiX2NmYjhfY2xl
YXIsCi0JcG0zZmJfY2ZiWF9wdXRjLCBwbTNmYl9jZmJYX3B1dGNzLCBwbTNmYl9jZmJYX3JldmMs
Ci0JTlVMTCAvKiBjdXJzb3IoKSAqLyAsIE5VTEwgLyogc2V0X2ZvbnQoKSAqLyAsCi0JcG0zZmJf
Y2ZiOF9jbGVhcl9tYXJnaW5zLAotCUZPTlRXSURUSFJBTkdFKDEsIDE2KQkvKiB0cnVlIG9ubHkg
aWYgYWNjZWxlcmF0ZWQuLi4gKi8KLX07Ci0jZW5kaWYgLyogRkJDT05fSEFTX0NGQjggKi8KLSNl
bmRpZiAvKiBQTTNGQl9VU0VfQUNDRUwgKi8KK3N0YXRpYyBpbmxpbmUgdm9pZCBQTTNfV0FJVChz
dHJ1Y3QgcG0zX3BhciAqcGFyLCB1MzIgbikKK3sKKwl3aGlsZSAoUE0zX1JFQURfUkVHKHBhciwg
UE0zSW5GSUZPU3BhY2UpIDwgbik7Cit9CiAKLS8qICoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKiAqLwotLyogKioqKiogY2FyZC1zcGVjaWZpYyBkYXRhICoqKioqICovCi0vKiAqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKiogKi8KLXN0cnVjdCBwbTNmYl9jYXJkX3RpbWluZ3Mgewot
CXVuc2lnbmVkIGxvbmcgbWVtc2l6ZTsgLyogMCBmb3IgbGFzdCB2YWx1ZSAoaS5lLiBkZWZhdWx0
KSAqLwotCXN0cnVjdCBwbTNmYl90aW1pbmdzIG1lbXQ7Ci19Oworc3RhdGljIGlubGluZSB2b2lk
IFBNM19TTE9XX1dSSVRFX1JFRyhzdHJ1Y3QgcG0zX3BhciAqcGFyLCBzMzIgb2ZmLCB1MzIgdikK
K3sKKwlpZiAoIHBhci0+dl9yZWdzICkgeworCQltYigpOworCQlQTTNfV0FJVChwYXIsIDEpOwor
CQl3bWIoKTsKKwkJUE0zX1dSSVRFX1JFRyhwYXIsIG9mZiwgdik7CisJfQorfQogCi1zdGF0aWMg
c3RydWN0IHBtM2ZiX2NhcmRfdGltaW5ncyB0X0Zvcm1hY1Byb0Zvcm1hbmNlM1tdID0gewotCXsg
MTYsIHsgMHgwMmUzMTFiOCwgMHgwNjEwMDIwNSwgMHgwODAwMDAwMiwgMHgwMDAwMDA3OSwgMHgw
MDAwMDAwMH0gfSwKLQl7IDAsIHsgMHgwMmUzMTFiOCwgMHgwNjEwMDIwNSwgMHgwODAwMDAwMiwg
MHgwMDAwMDA3OSwgMHgwMDAwMDAwMH0gfSAvKiBmcm9tIDE2IE1CIFBGMyAqLwotfTsKK3N0YXRp
YyBpbmxpbmUgdm9pZCBQTTNfU0VUX0lOREVYKHN0cnVjdCBwbTNfcGFyICpwYXIsIHVuc2lnbmVk
IGluZGV4KQoreworCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBNM1JEX0luZGV4SGlnaCwgKGlu
ZGV4ID4+IDggKSAmIDB4ZmYpOworCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBNM1JEX0luZGV4
TG93LCBpbmRleCAmIDB4ZmYpOworfQogCi1zdGF0aWMgc3RydWN0IHBtM2ZiX2NhcmRfdGltaW5n
cyB0X0FwcGlhbkplcm9uaW1vMjAwMFtdID0gewotCXsgMzIsIHsgMHgwMmUzMTFCOCwgMHgwNzQy
NDkwNSwgMHgwYzAwMDAwMywgMHgwMDAwMDA2MSwgMHgwMDAwMDAwMH0gfSwKLQl7IDAsIHsgMHgw
MmUzMTFCOCwgMHgwNzQyNDkwNSwgMHgwYzAwMDAwMywgMHgwMDAwMDA2MSwgMHgwMDAwMDAwMH0g
fSAvKiBmcm9tIDMyTUIgSjIwMDAgKi8KLX07CitzdGF0aWMgaW5saW5lIHZvaWQgUE0zX1dSSVRF
X0RBQ19SRUcoc3RydWN0IHBtM19wYXIgKnBhciwgdW5zaWduZWQgciwgdTggdikKK3sKKwlQTTNf
U0VUX0lOREVYKHBhciwgcik7CisJd21iKCk7CisJUE0zX1dSSVRFX1JFRyhwYXIsIFBNM1JEX0lu
ZGV4ZWREYXRhLCB2KTsKK30KIAotc3RhdGljIHN0cnVjdCBwbTNmYl9jYXJkX3RpbWluZ3MgdF8z
RExhYnNPeHlnZW5WWDFbXSA9IHsKLQl7IDMyLCB7IDB4MzBlMzExYjgsIDB4MDg1MDEyMDQsIDB4
MDgwMDAwMDIsIDB4MDAwMDAwNmIsIDB4MDAwMDAwMDB9IH0sCi0JeyAwLCB7IDB4MzBlMzExYjgs
IDB4MDg1MDEyMDQsIDB4MDgwMDAwMDIsIDB4MDAwMDAwNmIsIDB4MDAwMDAwMDB9IH0gLyogZnJv
bSAzMk1CIFZYMSAqLwotfTsKK3N0YXRpYyBpbmxpbmUgdm9pZCBwbTNmYl9zZXRfY29sb3Ioc3Ry
dWN0IHBtM19wYXIgKnBhciwgdW5zaWduZWQgY2hhciByZWdubywKKwkJCXVuc2lnbmVkIGNoYXIg
ciwgdW5zaWduZWQgY2hhciBnLCB1bnNpZ25lZCBjaGFyIGIpCit7CisJUE0zX1NMT1dfV1JJVEVf
UkVHKHBhciwgUE0zUkRfUGFsZXR0ZVdyaXRlQWRkcmVzcywgcmVnbm8pOworCVBNM19TTE9XX1dS
SVRFX1JFRyhwYXIsIFBNM1JEX1BhbGV0dGVEYXRhLCByKTsKKwlQTTNfU0xPV19XUklURV9SRUco
cGFyLCBQTTNSRF9QYWxldHRlRGF0YSwgZyk7CisJUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0z
UkRfUGFsZXR0ZURhdGEsIGIpOworfQogCi1zdGF0aWMgc3RydWN0IHsKLQkJY2hhciBjYXJkbmFt
ZVszMl07IC8qIHJlY29nbml6ZWQgY2FyZCBuYW1lICovCi0JCXUxNiBzdWJ2ZW5kb3I7IC8qIHN1
YnZlbmRvciBvZiB0aGUgY2FyZCAqLwotCQl1MTYgc3ViZGV2aWNlOyAvKiBzdWJkZXZpY2Ugb2Yg
dGhlIGNhcmQgKi8KLQkJdTggIGZ1bmM7IC8qIGZ1bmN0aW9uIG9mIHRoZSBjYXJkIHRvIHdoaWNo
IHRoZSBleHRyYSBpbml0IGFwcGx5ICovCi0JCXZvaWQgKCpzcGVjaWZpY19zZXR1cCkoc3RydWN0
IHBtM2ZiX2luZm8gKmxfZmJfaW5mbyk7IC8qIGNhcmQvZnVuYyBzcGVjaWZpYyBzZXR1cCwgZG9u
ZSBiZWZvcmUgX2FueV8gRkIgYWNjZXNzICovCi0Jc3RydWN0IHBtM2ZiX2NhcmRfdGltaW5ncyAq
Y19tZW10OyAvKiBkZWZhdWxzIHRpbWluZ3MgZm9yIHRoZSBib2FyZHMgKi8KLX0gY2FyZGJhc2Vb
XSA9IHsKLQl7ICJVbmtub3duIFBlcm1lZGlhMyBib2FyZCIsIDB4RkZGRiwgMHhGRkZGLCAweEZG
LCBOVUxMLCBOVUxMIH0sCi0JeyAiQXBwaWFuIEplcm9uaW1vIDIwMDAgaGVhZCAxIiwgMHgxMDk3
LCAweDNkMzIsIDEsIE5VTEwsCi0JICB0X0FwcGlhbkplcm9uaW1vMjAwMAotCX0sCi0JeyAiQXBw
aWFuIEplcm9uaW1vIDIwMDAgaGVhZCAyIiwgMHgxMDk3LCAweDNkMzIsIDIsIHBtM2ZiX2oyMDAw
X3NldHVwLAotCSAgdF9BcHBpYW5KZXJvbmltbzIwMDAKLQl9LAotCXsgIkZvcm1hYyBQcm9Gb3Jt
YW5jZSAzIiwgUENJX1ZFTkRPUl9JRF8zRExBQlMsIDB4MDAwYSwgMCwgTlVMTCwgLyogRm9ybWFj
IHVzZSAzRExhYnMgSUQgPyE/ICovCi0JICB0X0Zvcm1hY1Byb0Zvcm1hbmNlMwotCX0sCi0JeyAi
M0RMYWJzIFBlcm1lZGlhMyBDcmVhdGUhIiwgUENJX1ZFTkRPUl9JRF8zRExBQlMsIDB4MDEyNywg
MCwgTlVMTCwgTlVMTCB9LAotCXsgIjNETGFicyBPeHlnZW4gVlgxIFBDSSIsIFBDSV9WRU5ET1Jf
SURfM0RMQUJTLCAweDAxMjEsIDAsIE5VTEwsCi0JICB0XzNETGFic094eWdlblZYMQotCX0sCi0J
eyAiM0RMYWJzIE94eWdlbiBWWDEgQUdQIiwgUENJX1ZFTkRPUl9JRF8zRExBQlMsIDB4MDEyNSwg
MCwgTlVMTCwgTlVMTCB9LAotCXsgIjNETGFicyBPeHlnZW4gVlgxLTE2IEFHUCIsIFBDSV9WRU5E
T1JfSURfM0RMQUJTLCAweDAxNDAsIDAsIE5VTEwsIE5VTEwgfSwKLQl7ICIzRExhYnMgT3h5Z2Vu
IFZYMS0xNjAwU1cgUENJIiwgUENJX1ZFTkRPUl9JRF8zRExBQlMsIDB4MDgwMCwgMCwgTlVMTCwg
TlVMTCB9LAotCXsgIlwwIiwgMHgwLCAweDAsIDAsIE5VTEwsIE5VTEwgfQotfTsKK3N0YXRpYyB2
b2lkIHBtM2ZiX2NsZWFyX21lbW9yeShzdHJ1Y3QgZmJfaW5mbyAqaW5mbywgdTMyIGNjKQorewor
CWludCBpOwogCi0vKiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqICovCi0vKiAq
KioqKiBjYXJkLXNwZWNpZmljIGZ1bmN0aW9uICoqKioqICovCi0vKiAqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqICovCi1zdGF0aWMgdm9pZCBwbTNmYl9qMjAwMF9zZXR1cChzdHJ1
Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvKQoteyAgICAgICAvKiB0aGUgYXBwaWFuIGoyMDAwIHJl
cXVpcmUgbW9yZSBpbml0aWFsaXphdGlvbiBvZiB0aGUgc2Vjb25kIGhlYWQgKi8KLQkvKiBsX2Zi
X2luZm8gbXVzdCBwb2ludCB0byB0aGUgX3NlY29uZF8gaGVhZCBvZiB0aGUgSjIwMDAgKi8KLQkK
LQlEVFJBQ0U7Ci0KLQlsX2ZiX2luZm8tPm1lbXQgPSB0X0FwcGlhbkplcm9uaW1vMjAwMFswXS5t
ZW10OyAvKiAzMiBNQiwgZmlyc3QgYW5kIG9ubHkgajIwMDAgPyAqLwotCQotCXBtM2ZiX3dyaXRl
X21lbW9yeV90aW1pbmdzKGxfZmJfaW5mbyk7Ci19Ci0KLS8qICoqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKiAqLwotLyogKioqKiogcGVybWVkaWEzLXNwZWNpZmljIGZ1bmN0
aW9uICoqKioqICovCi0vKiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiog
Ki8KLXN0YXRpYyBwbTNmYl90aW1pbmdfcmVzdWx0IHBtM2ZiX3ByZXNlcnZlX21lbW9yeV90aW1p
bmdzKHN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8pCi17Ci0JbF9mYl9pbmZvLT5tZW10LmNh
cHMgPSBQTTNfUkVBRF9SRUcoUE0zTG9jYWxNZW1DYXBzKTsKLQlsX2ZiX2luZm8tPm1lbXQudGlt
aW5ncyA9IFBNM19SRUFEX1JFRyhQTTNMb2NhbE1lbVRpbWluZ3MpOwotCWxfZmJfaW5mby0+bWVt
dC5jb250cm9sID0gUE0zX1JFQURfUkVHKFBNM0xvY2FsTWVtQ29udHJvbCk7Ci0JbF9mYl9pbmZv
LT5tZW10LnJlZnJlc2ggPSBQTTNfUkVBRF9SRUcoUE0zTG9jYWxNZW1SZWZyZXNoKTsKLQlsX2Zi
X2luZm8tPm1lbXQucG93ZXJkb3duID0gUE0zX1JFQURfUkVHKFBNM0xvY2FsTWVtUG93ZXJEb3du
KTsKLQotCWlmICgobF9mYl9pbmZvLT5tZW10LmNhcHMgPT0gUE0zRkJfVU5LTk9XTl9USU1JTkdf
VkFMVUUpIHx8Ci0JICAgIChsX2ZiX2luZm8tPm1lbXQudGltaW5ncyA9PSBQTTNGQl9VTktOT1dO
X1RJTUlOR19WQUxVRSkgfHwKLQkgICAgKGxfZmJfaW5mby0+bWVtdC5jb250cm9sID09IFBNM0ZC
X1VOS05PV05fVElNSU5HX1ZBTFVFKSB8fAotCSAgICAobF9mYl9pbmZvLT5tZW10LnJlZnJlc2gg
PT0gUE0zRkJfVU5LTk9XTl9USU1JTkdfVkFMVUUpIHx8Ci0JICAgIChsX2ZiX2luZm8tPm1lbXQu
cG93ZXJkb3duID09IFBNM0ZCX1VOS05PV05fVElNSU5HX1ZBTFVFKSkKKwlmb3IgKGkgPSAwOyBp
IDwgKGluZm8tPnNjcmVlbl9zaXplIC8gc2l6ZW9mKHUzMikpIDsgaSsrKSAvKiBjbGVhciBlbnRp
cmUgRkIgbWVtb3J5IHRvIGJsYWNrICovCiAJewotCQlwcmludGsoS0VSTl9FUlIgInBtM2ZiOiBp
bnZhbGlkIG1lbW9yeSB0aW1pbmdzIGluIHBlcm1lZGlhMyBib2FyZCAjJWxkXG4iLCBsX2ZiX2lu
Zm8tPmJvYXJkX251bSk7Ci0JCXJldHVybihwbTNmYl90cnlfbWVtb3J5X3RpbWluZ3MobF9mYl9p
bmZvKSk7CisJCWZiX3dyaXRlbChjYywgKGluZm8tPnNjcmVlbl9iYXNlICsgKGkgKiBzaXplb2Yo
dTMyKSkpKTsKIAl9Ci0JcmV0dXJuKHBtM2ZiX3RpbWluZ19vayk7CiB9CiAKLXN0YXRpYyBwbTNm
Yl90aW1pbmdfcmVzdWx0IHBtM2ZiX3RyeV9tZW1vcnlfdGltaW5ncyhzdHJ1Y3QgcG0zZmJfaW5m
byAqbF9mYl9pbmZvKQorc3RhdGljIHZvaWQgcG0zZmJfY2xlYXJfY29sb3JtYXAoc3RydWN0IHBt
M19wYXIgKnBhciwKKwkJCXVuc2lnbmVkIGNoYXIgciwgdW5zaWduZWQgY2hhciBnLCB1bnNpZ25l
ZCBjaGFyIGIpCiB7Ci0JaWYgKGNhcmRiYXNlW2xfZmJfaW5mby0+Ym9hcmRfdHlwZV0uY19tZW10
KQotCXsKLQkJaW50IGkgPSAwLCBkb25lID0gMDsKLQkJd2hpbGUgKCFkb25lKQotCQl7Ci0JCQlp
ZiAoKGNhcmRiYXNlW2xfZmJfaW5mby0+Ym9hcmRfdHlwZV0uY19tZW10W2ldLm1lbXNpemUgPT0g
bF9mYl9pbmZvLT5mYl9zaXplKQotCQkJICAgIHx8ICEoY2FyZGJhc2VbbF9mYl9pbmZvLT5ib2Fy
ZF90eXBlXS5jX21lbXRbaV0ubWVtc2l6ZSkpCi0JCQl7IC8qIHdpbGwgdXNlIHRoZSAwLXNpemVk
IHRpbWluZ3MgYnkgZGVmYXVsdCAqLwotCQkJCWRvbmUgPSAxOwotCQkJCWxfZmJfaW5mby0+bWVt
dCA9IGNhcmRiYXNlW2xfZmJfaW5mby0+Ym9hcmRfdHlwZV0uY19tZW10W2ldLm1lbXQ7Ci0JCQkJ
cHJpbnRrKEtFUk5fV0FSTklORyAgInBtM2ZiOiB0cnlpbmcgdG8gdXNlIHByZWRlZmluZWQgbWVt
b3J5IHRpbWluZ3MgZm9yIHBlcm1lZGlhMyBib2FyZCAjJWxkICglcywgJWxkIE1CKVxuIiwKLQkJ
CQkgICAgICAgbF9mYl9pbmZvLT5ib2FyZF9udW0sCi0JCQkJICAgICAgIGNhcmRiYXNlW2xfZmJf
aW5mby0+Ym9hcmRfdHlwZV0uY2FyZG5hbWUsCi0JCQkJICAgICAgIGNhcmRiYXNlW2xfZmJfaW5m
by0+Ym9hcmRfdHlwZV0uY19tZW10W2ldLm1lbXNpemUpOwotCQkJCXBtM2ZiX3dyaXRlX21lbW9y
eV90aW1pbmdzKGxfZmJfaW5mbyk7Ci0JCQkJcmV0dXJuKHBtM2ZiX3RpbWluZ19yZXRyeSk7Ci0J
CQl9Ci0JCQlpKys7Ci0JCX0KLQl9IGVsc2UKLQkJcmV0dXJuKHBtM2ZiX3RpbWluZ19wcm9ibGVt
KTsKLQlyZXR1cm4ocG0zZmJfdGltaW5nX29rKTsKLX0KLQotc3RhdGljIHZvaWQgcG0zZmJfd3Jp
dGVfbWVtb3J5X3RpbWluZ3Moc3RydWN0IHBtM2ZiX2luZm8gKmxfZmJfaW5mbykKLXsKLQl1bnNp
Z25lZCBjaGFyIG0sIG4sIHA7Ci0JdW5zaWduZWQgbG9uZyBjbG9ja3VzZWQ7Ci0JCi0JUE0zX1NM
T1dfV1JJVEVfUkVHKFBNM0xvY2FsTWVtQ2FwcywgbF9mYl9pbmZvLT5tZW10LmNhcHMpOwotCVBN
M19TTE9XX1dSSVRFX1JFRyhQTTNMb2NhbE1lbVRpbWluZ3MsIGxfZmJfaW5mby0+bWVtdC50aW1p
bmdzKTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zTG9jYWxNZW1Db250cm9sLCBsX2ZiX2luZm8t
Pm1lbXQuY29udHJvbCk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0xvY2FsTWVtUmVmcmVzaCwg
bF9mYl9pbmZvLT5tZW10LnJlZnJlc2gpOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNMb2NhbE1l
bVBvd2VyRG93biwgbF9mYl9pbmZvLT5tZW10LnBvd2VyZG93bik7Ci0KLQljbG9ja3VzZWQgPQot
CSAgICBwbTNmYl9DYWxjdWxhdGVDbG9jayhsX2ZiX2luZm8sIDIgKiAxMDUwMDAsIFBNM19SRUZf
Q0xPQ0ssICZtLAotCQkJCSAmbiwgJnApOwotCi0JUE0zX1dSSVRFX0RBQ19SRUcoUE0zUkRfS0Ns
a1ByZVNjYWxlLCBtKTsKLQlQTTNfV1JJVEVfREFDX1JFRyhQTTNSRF9LQ2xrRmVlZGJhY2tTY2Fs
ZSwgbik7Ci0JUE0zX1dSSVRFX0RBQ19SRUcoUE0zUkRfS0Nsa1Bvc3RTY2FsZSwgcCk7Ci0JUE0z
X1dSSVRFX0RBQ19SRUcoUE0zUkRfS0Nsa0NvbnRyb2wsCi0JCQkgIFBNM1JEX0tDbGtDb250cm9s
X1NUQVRFX1JVTiB8Ci0JCQkgIFBNM1JEX0tDbGtDb250cm9sX1NPVVJDRV9QTEwgfAotCQkJICBQ
TTNSRF9LQ2xrQ29udHJvbF9FTkFCTEUpOwotCVBNM19XUklURV9EQUNfUkVHKFBNM1JEX01DbGtD
b250cm9sLAotCQkJICBQTTNSRF9NQ2xrQ29udHJvbF9TVEFURV9SVU4gfAotCQkJICBQTTNSRF9N
Q2xrQ29udHJvbF9TT1VSQ0VfS0NMSyB8Ci0JCQkgIFBNM1JEX01DbGtDb250cm9sX0VOQUJMRSk7
Ci0JUE0zX1dSSVRFX0RBQ19SRUcoUE0zUkRfU0Nsa0NvbnRyb2wsCi0JCQkgIFBNM1JEX1NDbGtD
b250cm9sX1NUQVRFX1JVTiB8Ci0JCQkgIFBNM1JEX1NDbGtDb250cm9sX1NPVVJDRV9QQ0xLIHwK
LQkJCSAgUE0zUkRfU0Nsa0NvbnRyb2xfRU5BQkxFKTsKLX0KLQotc3RhdGljIHVuc2lnbmVkIGxv
bmcgcG0zZmJfcmVhZF9kYWNfcmVnKHN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8sCi0JCQkJ
CXVuc2lnbmVkIGxvbmcgcikKLXsKLQlEQVNTRVJUKChsX2ZiX2luZm8tPnZJT0Jhc2UgIT0gKHVu
c2lnbmVkIGNoYXIgKikgKC0xKSksCi0JCSJsX2ZiX2luZm8tPnZJT0Jhc2UgbWFwcGVkIGluIHJl
YWQgZGFjIHJlZ1xuIik7Ci0JUE0zX1NFVF9JTkRFWChyKTsKLQltYigpOwotCXJldHVybiAoUE0z
X1JFQURfUkVHKFBNM1JEX0luZGV4ZWREYXRhKSk7CisJaW50IGk7CisKKwlmb3IgKGkgPSAwOyBp
IDwgMjU2IDsgaSsrKSAvKiBmaWxsIGNvbG9yIG1hcCB3aXRoIHdoaXRlICovCisJCXBtM2ZiX3Nl
dF9jb2xvcihwYXIsIGksIHIsIGcsIGIpOworCiB9CiAKIC8qIENhbGN1bGF0aW5nIHZhcmlvdXMg
Y2xvY2sgcGFyYW1ldGVyICovCi1zdGF0aWMgdW5zaWduZWQgbG9uZyBwbTNmYl9DYWxjdWxhdGVD
bG9jayhzdHJ1Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvLCB1bnNpZ25lZCBsb25nIHJlcWNsb2Nr
LAkvKiBJbiBrSHogdW5pdHMgKi8KLQkJCQkJICB1bnNpZ25lZCBsb25nIHJlZmNsb2NrLAkvKiBJ
biBrSHogdW5pdHMgKi8KLQkJCQkJICB1bnNpZ25lZCBjaGFyICpwcmVzY2FsZSwJLyogQ2xrUHJl
U2NhbGUgKi8KLQkJCQkJICB1bnNpZ25lZCBjaGFyICpmZWVkYmFjaywJLyogQ2xrRmVlZEJhY2tT
Y2FsZSAqLwotCQkJCQkgIHVuc2lnbmVkIGNoYXIgKnBvc3RzY2FsZQotCQkJCQkgIC8qIENsa1Bv
c3RTY2FsZSAqLyApCitzdGF0aWMgdm9pZCBwbTNmYl9jYWxjdWxhdGVfY2xvY2sodW5zaWduZWQg
bG9uZyByZXFjbG9jaywKKwkJCQl1bnNpZ25lZCBjaGFyICpwcmVzY2FsZSwKKwkJCQl1bnNpZ25l
ZCBjaGFyICpmZWVkYmFjaywKKwkJCQl1bnNpZ25lZCBjaGFyICpwb3N0c2NhbGUpCiB7CiAJaW50
IGYsIHByZSwgcG9zdDsKIAl1bnNpZ25lZCBsb25nIGZyZXE7CiAJbG9uZyBmcmVxZXJyID0gMTAw
MDsKLQl1bnNpZ25lZCBsb25nIGFjdHVhbGNsb2NrID0gMDsKLQotCURUUkFDRTsKKwlsb25nIGN1
cnJlcnI7CiAKIAlmb3IgKGYgPSAxOyBmIDwgMjU2OyBmKyspIHsKIAkJZm9yIChwcmUgPSAxOyBw
cmUgPCAyNTY7IHByZSsrKSB7CiAJCQlmb3IgKHBvc3QgPSAwOyBwb3N0IDwgNTsgcG9zdCsrKSB7
Ci0JCQkJZnJlcSA9Ci0JCQkJICAgICgoMiAqIHJlZmNsb2NrICogZikgLwotCQkJCSAgICAgKHBy
ZSAqICgxIDw8IHBvc3QpKSk7Ci0JCQkJaWYgKChyZXFjbG9jayA+IGZyZXEgLSBmcmVxZXJyKQot
CQkJCSAgICAmJiAocmVxY2xvY2sgPCBmcmVxICsgZnJlcWVycikpIHsKLQkJCQkJZnJlcWVyciA9
Ci0JCQkJCSAgICAocmVxY2xvY2sgPgotCQkJCQkgICAgIGZyZXEpID8gcmVxY2xvY2sgLQotCQkJ
CQkgICAgZnJlcSA6IGZyZXEgLSByZXFjbG9jazsKKwkJCQlmcmVxID0gKCgyKlBNM19SRUZfQ0xP
Q0sgKiBmKSA+PiBwb3N0KSAvIHByZTsKKwkJCQljdXJyZXJyID0gKHJlcWNsb2NrID4gZnJlcSkK
KwkJCQkJPyByZXFjbG9jayAtIGZyZXEKKwkJCQkJOiBmcmVxIC0gcmVxY2xvY2s7CisJCQkJaWYg
KGN1cnJlcnIgPCBmcmVxZXJyKSB7CisJCQkJCWZyZXFlcnIgPSBjdXJyZXJyOwogCQkJCQkqZmVl
ZGJhY2sgPSBmOwogCQkJCQkqcHJlc2NhbGUgPSBwcmU7CiAJCQkJCSpwb3N0c2NhbGUgPSBwb3N0
OwotCQkJCQlhY3R1YWxjbG9jayA9IGZyZXE7CiAJCQkJfQogCQkJfQogCQl9CiAJfQotCi0JcmV0
dXJuIChhY3R1YWxjbG9jayk7CiB9CiAKLXN0YXRpYyBpbnQgcG0zZmJfU2hpZnRicHAoc3RydWN0
IHBtM2ZiX2luZm8gKmxfZmJfaW5mbywKLQkJCSAgdW5zaWduZWQgbG9uZyBkZXB0aCwgaW50IHYp
CitzdGF0aWMgaW5saW5lIGludCBwbTNmYl9zaGlmdF9icHAodW5zaWduZWQgbG9uZyBkZXB0aCwg
aW50IHYpCiB7Ci0JRFRSQUNFOwotCQogCXN3aXRjaCAoZGVwdGgpIHsKIAljYXNlIDg6CiAJCXJl
dHVybiAodiA+PiA0KTsKQEAgLTkxOCwxODEgKzE5Nyw1OSBAQCBzdGF0aWMgaW50IHBtM2ZiX1No
aWZ0YnBwKHN0cnVjdCBwbTNmYl9pCiAJY2FzZSAzMjoKIAkJcmV0dXJuICh2ID4+IDIpOwogCX0K
LQlEUFJJTlRLKDEsICJVbnN1cHBvcnRlZCBkZXB0aCAlbGRcbiIsIGRlcHRoKTsKLQlyZXR1cm4g
KDApOwotfQotCi1zdGF0aWMgaW50IHBtM2ZiX1Vuc2hpZnRicHAoc3RydWN0IHBtM2ZiX2luZm8g
KmxfZmJfaW5mbywKLQkJCSAgICB1bnNpZ25lZCBsb25nIGRlcHRoLCBpbnQgdikKLXsKLQlEVFJB
Q0U7Ci0KLQlzd2l0Y2ggKGRlcHRoKSB7Ci0JY2FzZSA4OgotCQlyZXR1cm4gKHYgPDwgNCk7Ci0J
Y2FzZSAxMjoJCi0JY2FzZSAxNToKLQljYXNlIDE2OgotCQlyZXR1cm4gKHYgPDwgMyk7Ci0JY2Fz
ZSAzMjoKLQkJcmV0dXJuICh2IDw8IDIpOwotCX0KLQlEUFJJTlRLKDEsICJVbnN1cHBvcnRlZCBk
ZXB0aCAlbGRcbiIsIGRlcHRoKTsKLQlyZXR1cm4gKDApOwotfQotCi1zdGF0aWMgdm9pZCBwbTNm
Yl9tYXBJTyhzdHJ1Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvKQotewotCURUUkFDRTsKLQotCWxf
ZmJfaW5mby0+dklPQmFzZSA9Ci0JICAgIGlvcmVtYXAoKHVuc2lnbmVkIGxvbmcpIGxfZmJfaW5m
by0+cElPQmFzZSwgUE0zX1JFR1NfU0laRSk7Ci0JbF9mYl9pbmZvLT52X2ZiID0KLQkgICAgaW9y
ZW1hcCgodW5zaWduZWQgbG9uZykgbF9mYl9pbmZvLT5wX2ZiLCBsX2ZiX2luZm8tPmZiX3NpemUp
OwotCURQUklOVEsoMiwgIklPIG1hcHBpbmcgOiBJT0Jhc2UgJWx4IC8gJWx4LCBmYiAlbHggLyAl
bHhcbiIsCi0JCSh1bnNpZ25lZCBsb25nKSBsX2ZiX2luZm8tPnBJT0Jhc2UsCi0JCSh1bnNpZ25l
ZCBsb25nKSBsX2ZiX2luZm8tPnZJT0Jhc2UsCi0JCSh1bnNpZ25lZCBsb25nKSBsX2ZiX2luZm8t
PnBfZmIsCi0JCSh1bnNpZ25lZCBsb25nKSBsX2ZiX2luZm8tPnZfZmIpOwotfQotCi1zdGF0aWMg
dm9pZCBwbTNmYl91bm1hcElPKHN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8pCi17Ci0JRFRS
QUNFOwotCi0JaW91bm1hcChsX2ZiX2luZm8tPnZJT0Jhc2UpOwotCWlvdW5tYXAobF9mYl9pbmZv
LT52X2ZiKTsKLQlsX2ZiX2luZm8tPnZJT0Jhc2UgPSAodW5zaWduZWQgY2hhciAqKSAtMTsKLQls
X2ZiX2luZm8tPnZfZmIgPSAodW5zaWduZWQgY2hhciAqKSAtMTsKLX0KLQotI2lmIGRlZmluZWQo
UE0zRkJfTUFTVEVSX0RFQlVHKSAmJiAoUE0zRkJfTUFTVEVSX0RFQlVHID49IDIpCi1zdGF0aWMg
dm9pZCBwbTNmYl9zaG93X2N1cl9tb2RlKHN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8pCi17
Ci0JRFBSSU5USygyLCAiUE0zQXBlcnR1cmUwOiAweCUwOHhcbiIsIFBNM19SRUFEX1JFRyhQTTNB
cGVydHVyZTApKTsKLQlEUFJJTlRLKDIsICJQTTNBcGVydHVyZTE6IDB4JTA4eFxuIiwgUE0zX1JF
QURfUkVHKFBNM0FwZXJ0dXJlMSkpOwotCURQUklOVEsoMiwgIlBNM0J5QXBlcnR1cmUxTW9kZTog
MHglMDh4XG4iLAotCQlQTTNfUkVBRF9SRUcoUE0zQnlBcGVydHVyZTFNb2RlKSk7Ci0JRFBSSU5U
SygyLCAiUE0zQnlBcGVydHVyZTJNb2RlOiAweCUwOHhcbiIsCi0JCVBNM19SRUFEX1JFRyhQTTNC
eUFwZXJ0dXJlMk1vZGUpKTsKLQlEUFJJTlRLKDIsICJQTTNDaGlwQ29uZmlnOiAweCUwOHhcbiIs
IFBNM19SRUFEX1JFRyhQTTNDaGlwQ29uZmlnKSk7Ci0JRFBSSU5USygyLCAiUE0zRklGT0Rpczog
MHglMDh4XG4iLCBQTTNfUkVBRF9SRUcoUE0zRklGT0RpcykpOwotCURQUklOVEsoMiwgIlBNM0hU
b3RhbDogMHglMDh4XG4iLCBQTTNfUkVBRF9SRUcoUE0zSFRvdGFsKSk7Ci0JRFBSSU5USygyLCAi
UE0zSGJFbmQ6IDB4JTA4eFxuIiwgUE0zX1JFQURfUkVHKFBNM0hiRW5kKSk7Ci0JRFBSSU5USygy
LCAiUE0zSGdFbmQ6IDB4JTA4eFxuIiwgUE0zX1JFQURfUkVHKFBNM0hnRW5kKSk7Ci0JRFBSSU5U
SygyLCAiUE0zSHNFbmQ6IDB4JTA4eFxuIiwgUE0zX1JFQURfUkVHKFBNM0hzRW5kKSk7Ci0JRFBS
SU5USygyLCAiUE0zSHNTdGFydDogMHglMDh4XG4iLCBQTTNfUkVBRF9SRUcoUE0zSHNTdGFydCkp
OwotCURQUklOVEsoMiwgIlBNM01lbUJ5cGFzc1dyaXRlTWFzazogMHglMDh4XG4iLAotCQlQTTNf
UkVBRF9SRUcoUE0zTWVtQnlwYXNzV3JpdGVNYXNrKSk7Ci0JRFBSSU5USygyLCAiUE0zUkRfSW5k
ZXhDb250cm9sOiAweCUwOHhcbiIsCi0JCVBNM19SRUFEX1JFRyhQTTNSRF9JbmRleENvbnRyb2wp
KTsKLQlEUFJJTlRLKDIsICJQTTNTY3JlZW5CYXNlOiAweCUwOHhcbiIsIFBNM19SRUFEX1JFRyhQ
TTNTY3JlZW5CYXNlKSk7Ci0JRFBSSU5USygyLCAiUE0zU2NyZWVuU3RyaWRlOiAweCUwOHhcbiIs
Ci0JCVBNM19SRUFEX1JFRyhQTTNTY3JlZW5TdHJpZGUpKTsKLQlEUFJJTlRLKDIsICJQTTNWQ2xr
Q3RsOiAweCUwOHhcbiIsIFBNM19SRUFEX1JFRyhQTTNWQ2xrQ3RsKSk7Ci0JRFBSSU5USygyLCAi
UE0zVlRvdGFsOiAweCUwOHhcbiIsIFBNM19SRUFEX1JFRyhQTTNWVG90YWwpKTsKLQlEUFJJTlRL
KDIsICJQTTNWYkVuZDogMHglMDh4XG4iLCBQTTNfUkVBRF9SRUcoUE0zVmJFbmQpKTsKLQlEUFJJ
TlRLKDIsICJQTTNWaWRlb0NvbnRyb2w6IDB4JTA4eFxuIiwKLQkJUE0zX1JFQURfUkVHKFBNM1Zp
ZGVvQ29udHJvbCkpOwotCURQUklOVEsoMiwgIlBNM1ZzRW5kOiAweCUwOHhcbiIsIFBNM19SRUFE
X1JFRyhQTTNWc0VuZCkpOwotCURQUklOVEsoMiwgIlBNM1ZzU3RhcnQ6IDB4JTA4eFxuIiwgUE0z
X1JFQURfUkVHKFBNM1ZzU3RhcnQpKTsKLQotCURQUklOVEsoMiwgIlBNM1JEX0NvbG9yRm9ybWF0
OiAlbGRcbiIsCi0JCVBNM19SRUFEX0RBQ19SRUcoUE0zUkRfQ29sb3JGb3JtYXQpKTsKLQlEUFJJ
TlRLKDIsICJQTTNSRF9EQUNDb250cm9sOiAlbGRcbiIsCi0JCVBNM19SRUFEX0RBQ19SRUcoUE0z
UkRfREFDQ29udHJvbCkpOwotCURQUklOVEsoMiwgIlBNM1JEX0RDbGswRmVlZGJhY2tTY2FsZTog
JWxkXG4iLAotCQlQTTNfUkVBRF9EQUNfUkVHKFBNM1JEX0RDbGswRmVlZGJhY2tTY2FsZSkpOwot
CURQUklOVEsoMiwgIlBNM1JEX0RDbGswUG9zdFNjYWxlOiAlbGRcbiIsCi0JCVBNM19SRUFEX0RB
Q19SRUcoUE0zUkRfRENsazBQb3N0U2NhbGUpKTsKLQlEUFJJTlRLKDIsICJQTTNSRF9EQ2xrMFBy
ZVNjYWxlOiAlbGRcbiIsCi0JCVBNM19SRUFEX0RBQ19SRUcoUE0zUkRfRENsazBQcmVTY2FsZSkp
OwotCURQUklOVEsoMiwgIltub3Qgc2V0XSBQTTNSRF9JbmRleENvbnRyb2w6ICVsZFxuIiwKLQkJ
UE0zX1JFQURfREFDX1JFRyhQTTNSRF9JbmRleENvbnRyb2wpKTsKLQlEUFJJTlRLKDIsICJQTTNS
RF9NaXNjQ29udHJvbDogJWxkXG4iLAotCQlQTTNfUkVBRF9EQUNfUkVHKFBNM1JEX01pc2NDb250
cm9sKSk7Ci0JRFBSSU5USygyLCAiUE0zUkRfUGl4ZWxTaXplOiAlbGRcbiIsCi0JCVBNM19SRUFE
X0RBQ19SRUcoUE0zUkRfUGl4ZWxTaXplKSk7Ci0JRFBSSU5USygyLCAiUE0zUkRfU3luY0NvbnRy
b2w6ICVsZFxuIiwKLQkJUE0zX1JFQURfREFDX1JFRyhQTTNSRF9TeW5jQ29udHJvbCkpOwotfQot
Ci0jZW5kaWYgLyogZGVmaW5lZChQTTNGQl9NQVNURVJfREVCVUcpICYmIChQTTNGQl9NQVNURVJf
REVCVUcgPj0gMikgKi8KLXN0YXRpYyB2b2lkIHBtM2ZiX3Nob3dfY3VyX3RpbWluZyhzdHJ1Y3Qg
cG0zZmJfaW5mbyAqbF9mYl9pbmZvKQotewotCXUxNiBzdWJ2ZW5kb3IsIHN1YmRldmljZTsKLQot
CWlmICgoIXBjaV9yZWFkX2NvbmZpZ193b3JkCi0JICAgICAobF9mYl9pbmZvLT5kZXYsIFBDSV9T
VUJTWVNURU1fVkVORE9SX0lELCAmc3VidmVuZG9yKSkKLQkgICAgJiYKLQkgICAgKCFwY2lfcmVh
ZF9jb25maWdfd29yZAotCSAgICAgKGxfZmJfaW5mby0+ZGV2LCBQQ0lfU1VCU1lTVEVNX0lELCAm
c3ViZGV2aWNlKSkpIHsKLQkJLyogd2VsbCwgbm90aGluZy4uLiAqLwotCX0gZWxzZSB7Ci0JCXN1
YnZlbmRvciA9IHN1YmRldmljZSA9ICh1MTYpLTE7Ci0JfQotCi0JcHJpbnRrKEtFUk5fSU5GTyAi
cG0zZmI6IG1lbW9yeSB0aW1pbmdzIGZvciBib2FyZCAjJWxkIChzdWJ2ZW5kb3I6IDB4JWh4LCBz
dWJkZXZpY2U6IDB4JWh4KVxuIiwgbF9mYl9pbmZvLT5ib2FyZF9udW0sIHN1YnZlbmRvciwgc3Vi
ZGV2aWNlKTsKLQlwcmludGsoS0VSTl9JTkZPICIgUE0zTG9jYWxNZW1DYXBzOiAweCUwOHhcbiIs
Ci0JICAgICAgIFBNM19SRUFEX1JFRyhQTTNMb2NhbE1lbUNhcHMpKTsKLQlwcmludGsoS0VSTl9J
TkZPICIgUE0zTG9jYWxNZW1UaW1pbmdzOiAweCUwOHhcbiIsCi0JICAgICAgIFBNM19SRUFEX1JF
RyhQTTNMb2NhbE1lbVRpbWluZ3MpKTsKLQlwcmludGsoS0VSTl9JTkZPICIgUE0zTG9jYWxNZW1D
b250cm9sOiAweCUwOHhcbiIsCi0JICAgICAgIFBNM19SRUFEX1JFRyhQTTNMb2NhbE1lbUNvbnRy
b2wpKTsKLQlwcmludGsoS0VSTl9JTkZPICIgUE0zTG9jYWxNZW1SZWZyZXNoOiAweCUwOHhcbiIs
Ci0JICAgICAgIFBNM19SRUFEX1JFRyhQTTNMb2NhbE1lbVJlZnJlc2gpKTsKLQlwcmludGsoS0VS
Tl9JTkZPICIgUE0zTG9jYWxNZW1Qb3dlckRvd246IDB4JTA4eFxuIiwKLQkgICAgICAgUE0zX1JF
QURfUkVHKFBNM0xvY2FsTWVtUG93ZXJEb3duKSk7CisJRFBSSU5USygiVW5zdXBwb3J0ZWQgZGVw
dGggJWxkXG4iLCBkZXB0aCk7CisJcmV0dXJuIDA7CiB9CiAKIC8qIHdyaXRlIHRoZSBtb2RlIHRv
IHJlZ2lzdGVycyAqLwotc3RhdGljIHZvaWQgcG0zZmJfd3JpdGVfbW9kZShzdHJ1Y3QgcG0zZmJf
aW5mbyAqbF9mYl9pbmZvKQorc3RhdGljIHZvaWQgcG0zZmJfd3JpdGVfbW9kZShzdHJ1Y3QgZmJf
aW5mbyAqaW5mbykKIHsKKwlzdHJ1Y3QgcG0zX3BhciAqcGFyID0gaW5mby0+cGFyOwogCWNoYXIg
dGVtcHN5bmMgPSAweDAwLCB0ZW1wbWlzYyA9IDB4MDA7Ci0JRFRSQUNFOwotCi0JUE0zX1NMT1df
V1JJVEVfUkVHKFBNM01lbUJ5cGFzc1dyaXRlTWFzaywgMHhmZmZmZmZmZik7Ci0JUE0zX1NMT1df
V1JJVEVfUkVHKFBNM0FwZXJ0dXJlMCwgMHgwMDAwMDAwMCk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVH
KFBNM0FwZXJ0dXJlMSwgMHgwMDAwMDAwMCk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0ZJRk9E
aXMsIDB4MDAwMDAwMDcpOwotCi0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0hUb3RhbCwKLQkJCSAg
IHBtM2ZiX1NoaWZ0YnBwKGxfZmJfaW5mbywKLQkJCQkJICBsX2ZiX2luZm8tPmN1cnJlbnRfcGFy
LT5kZXB0aCwKLQkJCQkJICBsX2ZiX2luZm8tPmN1cnJlbnRfcGFyLT5odG90YWwgLQotCQkJCQkg
IDEpKTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zSHNFbmQsCi0JCQkgICBwbTNmYl9TaGlmdGJw
cChsX2ZiX2luZm8sCi0JCQkJCSAgbF9mYl9pbmZvLT5jdXJyZW50X3Bhci0+ZGVwdGgsCi0JCQkJ
CSAgbF9mYl9pbmZvLT5jdXJyZW50X3Bhci0+aHNlbmQpKTsKLQlQTTNfU0xPV19XUklURV9SRUco
UE0zSHNTdGFydCwKLQkJCSAgIHBtM2ZiX1NoaWZ0YnBwKGxfZmJfaW5mbywKLQkJCQkJICBsX2Zi
X2luZm8tPmN1cnJlbnRfcGFyLT5kZXB0aCwKLQkJCQkJICBsX2ZiX2luZm8tPmN1cnJlbnRfcGFy
LT4KKwljb25zdCB1MzIgaHNzdGFydCA9IGluZm8tPnZhci5yaWdodF9tYXJnaW47CisJY29uc3Qg
dTMyIGhzZW5kID0gaHNzdGFydCArIGluZm8tPnZhci5oc3luY19sZW47CisJY29uc3QgdTMyIGhi
ZW5kID0gaHNlbmQgKyBpbmZvLT52YXIubGVmdF9tYXJnaW47CisJY29uc3QgdTMyIHhyZXMgPSAo
aW5mby0+dmFyLnhyZXMgKyAzMSkgJiB+MzE7CisJY29uc3QgdTMyIGh0b3RhbCA9IHhyZXMgKyBo
YmVuZDsKKwljb25zdCB1MzIgdnNzdGFydCA9IGluZm8tPnZhci5sb3dlcl9tYXJnaW47CisJY29u
c3QgdTMyIHZzZW5kID0gdnNzdGFydCArIGluZm8tPnZhci52c3luY19sZW47CisJY29uc3QgdTMy
IHZiZW5kID0gdnNlbmQgKyBpbmZvLT52YXIudXBwZXJfbWFyZ2luOworCWNvbnN0IHUzMiB2dG90
YWwgPSBpbmZvLT52YXIueXJlcyArIHZiZW5kOworCWNvbnN0IHUzMiB3aWR0aCA9IChpbmZvLT52
YXIueHJlc192aXJ0dWFsICsgNykgJiB+NzsKKworCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBN
M01lbUJ5cGFzc1dyaXRlTWFzaywgMHhmZmZmZmZmZik7CisJUE0zX1NMT1dfV1JJVEVfUkVHKHBh
ciwgUE0zQXBlcnR1cmUwLCAweDAwMDAwMDAwKTsKKwlQTTNfU0xPV19XUklURV9SRUcocGFyLCBQ
TTNBcGVydHVyZTEsIDB4MDAwMDAwMDApOworCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBNM0ZJ
Rk9EaXMsIDB4MDAwMDAwMDcpOworCisJUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zSFRvdGFs
LAorCQkJICAgcG0zZmJfc2hpZnRfYnBwKGluZm8tPnZhci5iaXRzX3Blcl9waXhlbCwKKwkJCQkJ
ICBodG90YWwgLSAxKSk7CisJUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zSHNFbmQsCisJCQkg
ICBwbTNmYl9zaGlmdF9icHAoaW5mby0+dmFyLmJpdHNfcGVyX3BpeGVsLAorCQkJCQkgIGhzZW5k
KSk7CisJUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zSHNTdGFydCwKKwkJCSAgIHBtM2ZiX3No
aWZ0X2JwcChpbmZvLT52YXIuYml0c19wZXJfcGl4ZWwsCiAJCQkJCSAgaHNzdGFydCkpOwotCVBN
M19TTE9XX1dSSVRFX1JFRyhQTTNIYkVuZCwKLQkJCSAgIHBtM2ZiX1NoaWZ0YnBwKGxfZmJfaW5m
bywKLQkJCQkJICBsX2ZiX2luZm8tPmN1cnJlbnRfcGFyLT5kZXB0aCwKLQkJCQkJICBsX2ZiX2lu
Zm8tPmN1cnJlbnRfcGFyLT5oYmVuZCkpOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNIZ0VuZCwK
LQkJCSAgIHBtM2ZiX1NoaWZ0YnBwKGxfZmJfaW5mbywKLQkJCQkJICBsX2ZiX2luZm8tPmN1cnJl
bnRfcGFyLT5kZXB0aCwKLQkJCQkJICBsX2ZiX2luZm8tPmN1cnJlbnRfcGFyLT5oYmVuZCkpOwot
CVBNM19TTE9XX1dSSVRFX1JFRyhQTTNTY3JlZW5TdHJpZGUsCi0JCQkgICBwbTNmYl9TaGlmdGJw
cChsX2ZiX2luZm8sCi0JCQkJCSAgbF9mYl9pbmZvLT5jdXJyZW50X3Bhci0+ZGVwdGgsCi0JCQkJ
CSAgbF9mYl9pbmZvLT5jdXJyZW50X3Bhci0+c3RyaWRlKSk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVH
KFBNM1ZUb3RhbCwgbF9mYl9pbmZvLT5jdXJyZW50X3Bhci0+dnRvdGFsIC0gMSk7Ci0JUE0zX1NM
T1dfV1JJVEVfUkVHKFBNM1ZzRW5kLCBsX2ZiX2luZm8tPmN1cnJlbnRfcGFyLT52c2VuZCAtIDEp
OwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNWc1N0YXJ0LAotCQkJICAgbF9mYl9pbmZvLT5jdXJy
ZW50X3Bhci0+dnNzdGFydCAtIDEpOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNWYkVuZCwgbF9m
Yl9pbmZvLT5jdXJyZW50X3Bhci0+dmJlbmQpOworCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBN
M0hiRW5kLAorCQkJICAgcG0zZmJfc2hpZnRfYnBwKGluZm8tPnZhci5iaXRzX3Blcl9waXhlbCwK
KwkJCQkJICBoYmVuZCkpOworCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBNM0hnRW5kLAorCQkJ
ICAgcG0zZmJfc2hpZnRfYnBwKGluZm8tPnZhci5iaXRzX3Blcl9waXhlbCwKKwkJCQkJICBoYmVu
ZCkpOworCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBNM1NjcmVlblN0cmlkZSwKKwkJCSAgIHBt
M2ZiX3NoaWZ0X2JwcChpbmZvLT52YXIuYml0c19wZXJfcGl4ZWwsCisJCQkJCSAgd2lkdGgpKTsK
KwlQTTNfU0xPV19XUklURV9SRUcocGFyLCBQTTNWVG90YWwsIHZ0b3RhbCAtIDEpOworCVBNM19T
TE9XX1dSSVRFX1JFRyhwYXIsIFBNM1ZzRW5kLCB2c2VuZCAtIDEpOworCVBNM19TTE9XX1dSSVRF
X1JFRyhwYXIsIFBNM1ZzU3RhcnQsIHZzc3RhcnQgLSAxKTsKKwlQTTNfU0xPV19XUklURV9SRUco
cGFyLCBQTTNWYkVuZCwgdmJlbmQpOwogCi0Jc3dpdGNoIChsX2ZiX2luZm8tPmN1cnJlbnRfcGFy
LT5kZXB0aCkgeworCXN3aXRjaCAoaW5mby0+dmFyLmJpdHNfcGVyX3BpeGVsKSB7CiAJY2FzZSA4
OgotCQlQTTNfU0xPV19XUklURV9SRUcoUE0zQnlBcGVydHVyZTFNb2RlLAorCQlQTTNfU0xPV19X
UklURV9SRUcocGFyLCBQTTNCeUFwZXJ0dXJlMU1vZGUsCiAJCQkJICAgUE0zQnlBcGVydHVyZU1v
ZGVfUElYRUxTSVpFXzhCSVQpOwotCQlQTTNfU0xPV19XUklURV9SRUcoUE0zQnlBcGVydHVyZTJN
b2RlLAorCQlQTTNfU0xPV19XUklURV9SRUcocGFyLCBQTTNCeUFwZXJ0dXJlMk1vZGUsCiAJCQkJ
ICAgUE0zQnlBcGVydHVyZU1vZGVfUElYRUxTSVpFXzhCSVQpOwogCQlicmVhazsKIApAQCAtMTEw
MCwxNSArMjU3LDE1IEBAIHN0YXRpYyB2b2lkIHBtM2ZiX3dyaXRlX21vZGUoc3RydWN0IHBtM2YK
IAljYXNlIDE1OgogCWNhc2UgMTY6CiAjaWZuZGVmIF9fQklHX0VORElBTgotCQlQTTNfU0xPV19X
UklURV9SRUcoUE0zQnlBcGVydHVyZTFNb2RlLAorCQlQTTNfU0xPV19XUklURV9SRUcocGFyLCBQ
TTNCeUFwZXJ0dXJlMU1vZGUsCiAJCQkJICAgUE0zQnlBcGVydHVyZU1vZGVfUElYRUxTSVpFXzE2
QklUKTsKLQkJUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0J5QXBlcnR1cmUyTW9kZSwKKwkJUE0zX1NM
T1dfV1JJVEVfUkVHKHBhciwgUE0zQnlBcGVydHVyZTJNb2RlLAogCQkJCSAgIFBNM0J5QXBlcnR1
cmVNb2RlX1BJWEVMU0laRV8xNkJJVCk7CiAjZWxzZQotCQlQTTNfU0xPV19XUklURV9SRUcoUE0z
QnlBcGVydHVyZTFNb2RlLAorCQlQTTNfU0xPV19XUklURV9SRUcocGFyLCBQTTNCeUFwZXJ0dXJl
MU1vZGUsCiAJCQkJICAgUE0zQnlBcGVydHVyZU1vZGVfUElYRUxTSVpFXzE2QklUIHwKIAkJCQkg
ICBQTTNCeUFwZXJ0dXJlTW9kZV9CWVRFU1dBUF9CQURDKTsKLQkJUE0zX1NMT1dfV1JJVEVfUkVH
KFBNM0J5QXBlcnR1cmUyTW9kZSwKKwkJUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zQnlBcGVy
dHVyZTJNb2RlLAogCQkJCSAgIFBNM0J5QXBlcnR1cmVNb2RlX1BJWEVMU0laRV8xNkJJVCB8CiAJ
CQkJICAgUE0zQnlBcGVydHVyZU1vZGVfQllURVNXQVBfQkFEQyk7CiAjZW5kaWYgLyogISBfX0JJ
R19FTkRJQU4gKi8KQEAgLTExMTYsMjMgKzI3MywyMyBAQCBzdGF0aWMgdm9pZCBwbTNmYl93cml0
ZV9tb2RlKHN0cnVjdCBwbTNmCiAKIAljYXNlIDMyOgogI2lmbmRlZiBfX0JJR19FTkRJQU4KLQkJ
UE0zX1NMT1dfV1JJVEVfUkVHKFBNM0J5QXBlcnR1cmUxTW9kZSwKKwkJUE0zX1NMT1dfV1JJVEVf
UkVHKHBhciwgUE0zQnlBcGVydHVyZTFNb2RlLAogCQkJCSAgIFBNM0J5QXBlcnR1cmVNb2RlX1BJ
WEVMU0laRV8zMkJJVCk7Ci0JCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNCeUFwZXJ0dXJlMk1vZGUs
CisJCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBNM0J5QXBlcnR1cmUyTW9kZSwKIAkJCQkgICBQ
TTNCeUFwZXJ0dXJlTW9kZV9QSVhFTFNJWkVfMzJCSVQpOwogI2Vsc2UKLQkJUE0zX1NMT1dfV1JJ
VEVfUkVHKFBNM0J5QXBlcnR1cmUxTW9kZSwKKwkJUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0z
QnlBcGVydHVyZTFNb2RlLAogCQkJCSAgIFBNM0J5QXBlcnR1cmVNb2RlX1BJWEVMU0laRV8zMkJJ
VCB8CiAJCQkJICAgUE0zQnlBcGVydHVyZU1vZGVfQllURVNXQVBfRENCQSk7Ci0JCVBNM19TTE9X
X1dSSVRFX1JFRyhQTTNCeUFwZXJ0dXJlMk1vZGUsCisJCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIs
IFBNM0J5QXBlcnR1cmUyTW9kZSwKIAkJCQkgICBQTTNCeUFwZXJ0dXJlTW9kZV9QSVhFTFNJWkVf
MzJCSVQgfAogCQkJCSAgIFBNM0J5QXBlcnR1cmVNb2RlX0JZVEVTV0FQX0RDQkEpOwogI2VuZGlm
IC8qICEgX19CSUdfRU5ESUFOICovCiAJCWJyZWFrOwogCiAJZGVmYXVsdDoKLQkJRFBSSU5USygx
LCAiVW5zdXBwb3J0ZWQgZGVwdGggJWRcbiIsCi0JCQlsX2ZiX2luZm8tPmN1cnJlbnRfcGFyLT5k
ZXB0aCk7CisJCURQUklOVEsoIlVuc3VwcG9ydGVkIGRlcHRoICVkXG4iLAorCQkJaW5mby0+dmFy
LmJpdHNfcGVyX3BpeGVsKTsKIAkJYnJlYWs7CiAJfQogCkBAIC0xMTQzLDk1ICszMDAsODYgQEAg
c3RhdGljIHZvaWQgcG0zZmJfd3JpdGVfbW9kZShzdHJ1Y3QgcG0zZgogCSAqIHN5bmMgb3B0aW9u
cyBpbiBQTTNSRF9TeW5jQ29udHJvbC4gIC0tcm1rCiAJICovCiAJewotCQl1bnNpZ25lZCBpbnQg
dmlkZW8gPSBsX2ZiX2luZm8tPmN1cnJlbnRfcGFyLT52aWRlbzsKKwkJdW5zaWduZWQgaW50IHZp
ZGVvID0gcGFyLT52aWRlbzsKIAogCQl2aWRlbyAmPSB+KFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19N
QVNLIHwKIAkJCSAgIFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19NQVNLKTsKIAkJdmlkZW8gfD0gUE0z
VmlkZW9Db250cm9sX0hTWU5DX0FDVElWRV9ISUdIIHwKIAkJCSBQTTNWaWRlb0NvbnRyb2xfVlNZ
TkNfQUNUSVZFX0hJR0g7Ci0JCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNWaWRlb0NvbnRyb2wsIHZp
ZGVvKTsKKwkJUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zVmlkZW9Db250cm9sLCB2aWRlbyk7
CiAJfQotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNWQ2xrQ3RsLAotCQkJICAgKFBNM19SRUFEX1JF
RyhQTTNWQ2xrQ3RsKSAmIDB4RkZGRkZGRkMpKTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zU2Ny
ZWVuQmFzZSwgbF9mYl9pbmZvLT5jdXJyZW50X3Bhci0+YmFzZSk7Ci0JUE0zX1NMT1dfV1JJVEVf
UkVHKFBNM0NoaXBDb25maWcsCi0JCQkgICAoUE0zX1JFQURfUkVHKFBNM0NoaXBDb25maWcpICYg
MHhGRkZGRkZGRCkpOworCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBNM1ZDbGtDdGwsCisJCQkg
ICAoUE0zX1JFQURfUkVHKHBhciwgUE0zVkNsa0N0bCkgJiAweEZGRkZGRkZDKSk7CisJUE0zX1NM
T1dfV1JJVEVfUkVHKHBhciwgUE0zU2NyZWVuQmFzZSwgcGFyLT5iYXNlKTsKKwlQTTNfU0xPV19X
UklURV9SRUcocGFyLCBQTTNDaGlwQ29uZmlnLAorCQkJICAgKFBNM19SRUFEX1JFRyhwYXIsIFBN
M0NoaXBDb25maWcpICYgMHhGRkZGRkZGRCkpOwogCiAJewogCQl1bnNpZ25lZCBjaGFyIG07CS8q
IENsa1ByZVNjYWxlICovCiAJCXVuc2lnbmVkIGNoYXIgbjsJLyogQ2xrRmVlZEJhY2tTY2FsZSAq
LwogCQl1bnNpZ25lZCBjaGFyIHA7CS8qIENsa1Bvc3RTY2FsZSAqLwotCQkodm9pZClwbTNmYl9D
YWxjdWxhdGVDbG9jayhsX2ZiX2luZm8sIGxfZmJfaW5mby0+Y3VycmVudF9wYXItPnBpeGNsb2Nr
LCBQTTNfUkVGX0NMT0NLLCAmbSwgJm4sICZwKTsKKwkJdW5zaWduZWQgbG9uZyBwaXhjbG9jayA9
IFBJQ09TMktIWihpbmZvLT52YXIucGl4Y2xvY2spOworCisJCSh2b2lkKXBtM2ZiX2NhbGN1bGF0
ZV9jbG9jayhwaXhjbG9jaywgJm0sICZuLCAmcCk7CisKKwkJRFBSSU5USygiUGl4Y2xvY2s6ICVs
ZCwgUHJlOiAlZCwgRmVlZGJhY2s6ICVkLCBQb3N0OiAlZFxuIiwKKwkJCXBpeGNsb2NrLCAoaW50
KSBtLCAoaW50KSBuLCAoaW50KSBwKTsKIAotCQlEUFJJTlRLKDIsCi0JCQkiUGl4Y2xvY2s6ICVk
LCBQcmU6ICVkLCBGZWVkYmFjazogJWQsIFBvc3Q6ICVkXG4iLAotCQkJbF9mYl9pbmZvLT5jdXJy
ZW50X3Bhci0+cGl4Y2xvY2ssIChpbnQpIG0sIChpbnQpIG4sCi0JCQkoaW50KSBwKTsKLQotCQlQ
TTNfV1JJVEVfREFDX1JFRyhQTTNSRF9EQ2xrMFByZVNjYWxlLCBtKTsKLQkJUE0zX1dSSVRFX0RB
Q19SRUcoUE0zUkRfRENsazBGZWVkYmFja1NjYWxlLCBuKTsKLQkJUE0zX1dSSVRFX0RBQ19SRUco
UE0zUkRfRENsazBQb3N0U2NhbGUsIHApOworCQlQTTNfV1JJVEVfREFDX1JFRyhwYXIsIFBNM1JE
X0RDbGswUHJlU2NhbGUsIG0pOworCQlQTTNfV1JJVEVfREFDX1JFRyhwYXIsIFBNM1JEX0RDbGsw
RmVlZGJhY2tTY2FsZSwgbik7CisJCVBNM19XUklURV9EQUNfUkVHKHBhciwgUE0zUkRfRENsazBQ
b3N0U2NhbGUsIHApOwogCX0KIAkvKgotCSAgIFBNM19XUklURV9EQUNfUkVHKFBNM1JEX0luZGV4
Q29udHJvbCwgMHgwMCk7CisJICAgUE0zX1dSSVRFX0RBQ19SRUcocGFyLCBQTTNSRF9JbmRleENv
bnRyb2wsIDB4MDApOwogCSAqLwogCS8qCi0JICAgUE0zX1NMT1dfV1JJVEVfUkVHKFBNM1JEX0lu
ZGV4Q29udHJvbCwgMHgwMCk7CisJICAgUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zUkRfSW5k
ZXhDb250cm9sLCAweDAwKTsKIAkgKi8KLQlpZiAoKGxfZmJfaW5mby0+Y3VycmVudF9wYXItPnZp
ZGVvICYgUE0zVmlkZW9Db250cm9sX0hTWU5DX01BU0spID09CisJaWYgKChwYXItPnZpZGVvICYg
UE0zVmlkZW9Db250cm9sX0hTWU5DX01BU0spID09CiAJICAgIFBNM1ZpZGVvQ29udHJvbF9IU1lO
Q19BQ1RJVkVfSElHSCkKIAkJdGVtcHN5bmMgfD0gUE0zUkRfU3luY0NvbnRyb2xfSFNZTkNfQUNU
SVZFX0hJR0g7Ci0JaWYgKChsX2ZiX2luZm8tPmN1cnJlbnRfcGFyLT52aWRlbyAmIFBNM1ZpZGVv
Q29udHJvbF9WU1lOQ19NQVNLKSA9PQorCWlmICgocGFyLT52aWRlbyAmIFBNM1ZpZGVvQ29udHJv
bF9WU1lOQ19NQVNLKSA9PQogCSAgICBQTTNWaWRlb0NvbnRyb2xfVlNZTkNfQUNUSVZFX0hJR0gp
CiAJCXRlbXBzeW5jIHw9IFBNM1JEX1N5bmNDb250cm9sX1ZTWU5DX0FDVElWRV9ISUdIOwotCQot
CVBNM19XUklURV9EQUNfUkVHKFBNM1JEX1N5bmNDb250cm9sLCB0ZW1wc3luYyk7Ci0JRFBSSU5U
SygyLCAiUE0zUkRfU3luY0NvbnRyb2w6ICVkXG4iLCB0ZW1wc3luYyk7Ci0JCi0JaWYgKGZsYXRw
YW5lbFtsX2ZiX2luZm8tPmJvYXJkX251bV0pCi0JewotCQlQTTNfV1JJVEVfREFDX1JFRyhQTTNS
RF9EQUNDb250cm9sLCBQTTNSRF9EQUNDb250cm9sX0JMQU5LX1BFREVTVEFMX0VOQUJMRSk7Ci0J
CVBNM19XQUlUKDIpOwotCQlQTTNfV1JJVEVfUkVHKFBNM1ZTQ29uZmlndXJhdGlvbiwgMHgwNik7
Ci0JCVBNM19XUklURV9SRUcoMHg1YTAwLCAxIDw8IDE0KTsgLyogYmxhY2sgbWFnaWMuLi4gKi8K
LQkJdGVtcG1pc2MgPSBQTTNSRF9NaXNjQ29udHJvbF9WU0JfT1VUUFVUX0VOQUJMRTsKLQl9Ci0J
ZWxzZQotCQlQTTNfV1JJVEVfREFDX1JFRyhQTTNSRF9EQUNDb250cm9sLCAweDAwKTsKIAotCXN3
aXRjaCAobF9mYl9pbmZvLT5jdXJyZW50X3Bhci0+ZGVwdGgpIHsKKwlQTTNfV1JJVEVfREFDX1JF
RyhwYXIsIFBNM1JEX1N5bmNDb250cm9sLCB0ZW1wc3luYyk7CisJRFBSSU5USygiUE0zUkRfU3lu
Y0NvbnRyb2w6ICVkXG4iLCB0ZW1wc3luYyk7CisKKwlQTTNfV1JJVEVfREFDX1JFRyhwYXIsIFBN
M1JEX0RBQ0NvbnRyb2wsIDB4MDApOworCisJc3dpdGNoIChpbmZvLT52YXIuYml0c19wZXJfcGl4
ZWwpIHsKIAljYXNlIDg6Ci0JCVBNM19XUklURV9EQUNfUkVHKFBNM1JEX1BpeGVsU2l6ZSwKKwkJ
UE0zX1dSSVRFX0RBQ19SRUcocGFyLCBQTTNSRF9QaXhlbFNpemUsCiAJCQkJICBQTTNSRF9QaXhl
bFNpemVfOF9CSVRfUElYRUxTKTsKLQkJUE0zX1dSSVRFX0RBQ19SRUcoUE0zUkRfQ29sb3JGb3Jt
YXQsCisJCVBNM19XUklURV9EQUNfUkVHKHBhciwgUE0zUkRfQ29sb3JGb3JtYXQsCiAJCQkJICBQ
TTNSRF9Db2xvckZvcm1hdF9DSThfQ09MT1IgfAogCQkJCSAgUE0zUkRfQ29sb3JGb3JtYXRfQ09M
T1JfT1JERVJfQkxVRV9MT1cpOwogCQl0ZW1wbWlzYyB8PSBQTTNSRF9NaXNjQ29udHJvbF9ISUdI
Q09MT1JfUkVTX0VOQUJMRTsKIAkJYnJlYWs7CiAJY2FzZSAxMjoKLQkJUE0zX1dSSVRFX0RBQ19S
RUcoUE0zUkRfUGl4ZWxTaXplLAorCQlQTTNfV1JJVEVfREFDX1JFRyhwYXIsIFBNM1JEX1BpeGVs
U2l6ZSwKIAkJCQkgIFBNM1JEX1BpeGVsU2l6ZV8xNl9CSVRfUElYRUxTKTsKLQkJUE0zX1dSSVRF
X0RBQ19SRUcoUE0zUkRfQ29sb3JGb3JtYXQsCisJCVBNM19XUklURV9EQUNfUkVHKHBhciwgUE0z
UkRfQ29sb3JGb3JtYXQsCiAJCQkJICBQTTNSRF9Db2xvckZvcm1hdF80NDQ0X0NPTE9SIHwKIAkJ
CQkgIFBNM1JEX0NvbG9yRm9ybWF0X0NPTE9SX09SREVSX0JMVUVfTE9XIHwKIAkJCQkgIFBNM1JE
X0NvbG9yRm9ybWF0X0xJTkVBUl9DT0xPUl9FWFRfRU5BQkxFKTsKIAkJdGVtcG1pc2MgfD0gUE0z
UkRfTWlzY0NvbnRyb2xfRElSRUNUQ09MT1JfRU5BQkxFIHwKIAkJCVBNM1JEX01pc2NDb250cm9s
X0hJR0hDT0xPUl9SRVNfRU5BQkxFOwotCQlicmVhazsJCQorCQlicmVhazsKIAljYXNlIDE1Ogot
CQlQTTNfV1JJVEVfREFDX1JFRyhQTTNSRF9QaXhlbFNpemUsCisJCVBNM19XUklURV9EQUNfUkVH
KHBhciwgUE0zUkRfUGl4ZWxTaXplLAogCQkJCSAgUE0zUkRfUGl4ZWxTaXplXzE2X0JJVF9QSVhF
TFMpOwotCQlQTTNfV1JJVEVfREFDX1JFRyhQTTNSRF9Db2xvckZvcm1hdCwKKwkJUE0zX1dSSVRF
X0RBQ19SRUcocGFyLCBQTTNSRF9Db2xvckZvcm1hdCwKIAkJCQkgIFBNM1JEX0NvbG9yRm9ybWF0
XzU1NTFfRlJPTlRfQ09MT1IgfAogCQkJCSAgUE0zUkRfQ29sb3JGb3JtYXRfQ09MT1JfT1JERVJf
QkxVRV9MT1cgfAogCQkJCSAgUE0zUkRfQ29sb3JGb3JtYXRfTElORUFSX0NPTE9SX0VYVF9FTkFC
TEUpOwogCQl0ZW1wbWlzYyB8PSBQTTNSRF9NaXNjQ29udHJvbF9ESVJFQ1RDT0xPUl9FTkFCTEUg
fAogCQkJUE0zUkRfTWlzY0NvbnRyb2xfSElHSENPTE9SX1JFU19FTkFCTEU7Ci0JCWJyZWFrOwkJ
CisJCWJyZWFrOwogCWNhc2UgMTY6Ci0JCVBNM19XUklURV9EQUNfUkVHKFBNM1JEX1BpeGVsU2l6
ZSwKKwkJUE0zX1dSSVRFX0RBQ19SRUcocGFyLCBQTTNSRF9QaXhlbFNpemUsCiAJCQkJICBQTTNS
RF9QaXhlbFNpemVfMTZfQklUX1BJWEVMUyk7Ci0JCVBNM19XUklURV9EQUNfUkVHKFBNM1JEX0Nv
bG9yRm9ybWF0LAorCQlQTTNfV1JJVEVfREFDX1JFRyhwYXIsIFBNM1JEX0NvbG9yRm9ybWF0LAog
CQkJCSAgUE0zUkRfQ29sb3JGb3JtYXRfNTY1X0ZST05UX0NPTE9SIHwKIAkJCQkgIFBNM1JEX0Nv
bG9yRm9ybWF0X0NPTE9SX09SREVSX0JMVUVfTE9XIHwKIAkJCQkgIFBNM1JEX0NvbG9yRm9ybWF0
X0xJTkVBUl9DT0xPUl9FWFRfRU5BQkxFKTsKQEAgLTEyMzksMTkzNiArMzg3LDI4MCBAQCBzdGF0
aWMgdm9pZCBwbTNmYl93cml0ZV9tb2RlKHN0cnVjdCBwbTNmCiAJCQlQTTNSRF9NaXNjQ29udHJv
bF9ISUdIQ09MT1JfUkVTX0VOQUJMRTsKIAkJYnJlYWs7CiAJY2FzZSAzMjoKLQkJUE0zX1dSSVRF
X0RBQ19SRUcoUE0zUkRfUGl4ZWxTaXplLAorCQlQTTNfV1JJVEVfREFDX1JFRyhwYXIsIFBNM1JE
X1BpeGVsU2l6ZSwKIAkJCQkgIFBNM1JEX1BpeGVsU2l6ZV8zMl9CSVRfUElYRUxTKTsKLQkJUE0z
X1dSSVRFX0RBQ19SRUcoUE0zUkRfQ29sb3JGb3JtYXQsCisJCVBNM19XUklURV9EQUNfUkVHKHBh
ciwgUE0zUkRfQ29sb3JGb3JtYXQsCiAJCQkJICBQTTNSRF9Db2xvckZvcm1hdF84ODg4X0NPTE9S
IHwKIAkJCQkgIFBNM1JEX0NvbG9yRm9ybWF0X0NPTE9SX09SREVSX0JMVUVfTE9XKTsKIAkJdGVt
cG1pc2MgfD0gUE0zUkRfTWlzY0NvbnRyb2xfRElSRUNUQ09MT1JfRU5BQkxFIHwKIAkJCVBNM1JE
X01pc2NDb250cm9sX0hJR0hDT0xPUl9SRVNfRU5BQkxFOwogCQlicmVhazsKIAl9Ci0JUE0zX1dS
SVRFX0RBQ19SRUcoUE0zUkRfTWlzY0NvbnRyb2wsIHRlbXBtaXNjKTsKLQkKLQlQTTNfU0hPV19D
VVJfTU9ERTsKKwlQTTNfV1JJVEVfREFDX1JFRyhwYXIsIFBNM1JEX01pc2NDb250cm9sLCB0ZW1w
bWlzYyk7CiB9CiAKLXN0YXRpYyB2b2lkIHBtM2ZiX3JlYWRfbW9kZShzdHJ1Y3QgcG0zZmJfaW5m
byAqbF9mYl9pbmZvLAotCQkJICAgIHN0cnVjdCBwbTNmYl9wYXIgKmN1cnBhcikKLXsKLQl1bnNp
Z25lZCBsb25nIHBpeHNpemUxLCBwaXhzaXplMiwgY2xvY2t1c2VkOwotCXVuc2lnbmVkIGxvbmcg
cHJlLCBmZWVkYmFjaywgcG9zdDsKLQotCURUUkFDRTsKLQotCWNsb2NrdXNlZCA9IFBNM19SRUFE
X1JFRyhQTTNWQ2xrQ3RsKTsKKy8qCisgKiBoYXJkd2FyZSBpbmRlcGVuZGVudCBmdW5jdGlvbnMK
KyAqLworaW50IHBtM2ZiX2luaXQodm9pZCk7CitpbnQgcG0zZmJfc2V0dXAoY2hhciopOwogCi0J
c3dpdGNoIChjbG9ja3VzZWQpIHsKLQljYXNlIDM6Ci0JCXByZSA9IFBNM19SRUFEX0RBQ19SRUco
UE0zUkRfRENsazNQcmVTY2FsZSk7Ci0JCWZlZWRiYWNrID0gUE0zX1JFQURfREFDX1JFRyhQTTNS
RF9EQ2xrM0ZlZWRiYWNrU2NhbGUpOwotCQlwb3N0ID0gUE0zX1JFQURfREFDX1JFRyhQTTNSRF9E
Q2xrM1Bvc3RTY2FsZSk7CitzdGF0aWMgaW50IHBtM2ZiX2NoZWNrX3ZhcihzdHJ1Y3QgZmJfdmFy
X3NjcmVlbmluZm8gKnZhciwgc3RydWN0IGZiX2luZm8gKmluZm8pCit7CisJdTMyIGxwaXRjaDsK
IAotCQlEUFJJTlRLKDIsCi0JCQkiRENsazMgcGFyYW1ldGVyOiBQcmU6ICVsZCwgRmVlZGJhY2s6
ICVsZCwgUG9zdDogJWxkIDsgZ2l2aW5nIHBpeGNsb2NrOiAlbGRcbiIsCi0JCQlwcmUsIGZlZWRi
YWNrLCBwb3N0LCBQTTNfU0NBTEVfVE9fQ0xPQ0socHJlLAotCQkJCQkJCQlmZWVkYmFjaywKLQkJ
CQkJCQkJcG9zdCkpOworCXZhci0+dHJhbnNwLm9mZnNldCA9IDA7CisJdmFyLT50cmFuc3AubGVu
Z3RoID0gMDsKKwlzd2l0Y2godmFyLT5iaXRzX3Blcl9waXhlbCkgeworCWNhc2UgODoKKwkJdmFy
LT5yZWQubGVuZ3RoID0gdmFyLT5ncmVlbi5sZW5ndGggPSB2YXItPmJsdWUubGVuZ3RoID0gODsK
KwkJdmFyLT5yZWQub2Zmc2V0ID0gdmFyLT5ncmVlbi5vZmZzZXQgPSB2YXItPmJsdWUub2Zmc2V0
ID0gMDsKIAkJYnJlYWs7Ci0JY2FzZSAyOgotCQlwcmUgPSBQTTNfUkVBRF9EQUNfUkVHKFBNM1JE
X0RDbGsyUHJlU2NhbGUpOwotCQlmZWVkYmFjayA9IFBNM19SRUFEX0RBQ19SRUcoUE0zUkRfRENs
azJGZWVkYmFja1NjYWxlKTsKLQkJcG9zdCA9IFBNM19SRUFEX0RBQ19SRUcoUE0zUkRfRENsazJQ
b3N0U2NhbGUpOwotCi0JCURQUklOVEsoMiwKLQkJCSJEQ2xrMiBwYXJhbWV0ZXI6IFByZTogJWxk
LCBGZWVkYmFjazogJWxkLCBQb3N0OiAlbGQgOyBnaXZpbmcgcGl4Y2xvY2s6ICVsZFxuIiwKLQkJ
CXByZSwgZmVlZGJhY2ssIHBvc3QsIFBNM19TQ0FMRV9UT19DTE9DSyhwcmUsCi0JCQkJCQkJCWZl
ZWRiYWNrLAotCQkJCQkJCQlwb3N0KSk7CisJY2FzZSAxMjoKKwkJdmFyLT5yZWQub2Zmc2V0ICAg
PSA4OworCQl2YXItPnJlZC5sZW5ndGggICA9IDQ7CisJCXZhci0+Z3JlZW4ub2Zmc2V0ID0gNDsK
KwkJdmFyLT5ncmVlbi5sZW5ndGggPSA0OworCQl2YXItPmJsdWUub2Zmc2V0ICA9IDA7CisJCXZh
ci0+Ymx1ZS5sZW5ndGggID0gNDsKKwkJdmFyLT50cmFuc3Aub2Zmc2V0ID0gMTI7CisJCXZhci0+
dHJhbnNwLmxlbmd0aCA9IDQ7CisJY2FzZSAxNToKKwkJdmFyLT5yZWQub2Zmc2V0ICAgPSAxMDsK
KwkJdmFyLT5yZWQubGVuZ3RoICAgPSA1OworCQl2YXItPmdyZWVuLm9mZnNldCA9IDU7CisJCXZh
ci0+Z3JlZW4ubGVuZ3RoID0gNTsKKwkJdmFyLT5ibHVlLm9mZnNldCAgPSAwOworCQl2YXItPmJs
dWUubGVuZ3RoICA9IDU7CisJCXZhci0+dHJhbnNwLm9mZnNldCA9IDE1OworCQl2YXItPnRyYW5z
cC5sZW5ndGggPSAxOwogCQlicmVhazsKLQljYXNlIDE6Ci0JCXByZSA9IFBNM19SRUFEX0RBQ19S
RUcoUE0zUkRfRENsazFQcmVTY2FsZSk7Ci0JCWZlZWRiYWNrID0gUE0zX1JFQURfREFDX1JFRyhQ
TTNSRF9EQ2xrMUZlZWRiYWNrU2NhbGUpOwotCQlwb3N0ID0gUE0zX1JFQURfREFDX1JFRyhQTTNS
RF9EQ2xrMVBvc3RTY2FsZSk7Ci0KLQkJRFBSSU5USygyLAotCQkJIkRDbGsxIHBhcmFtZXRlcjog
UHJlOiAlbGQsIEZlZWRiYWNrOiAlbGQsIFBvc3Q6ICVsZCA7IGdpdmluZyBwaXhjbG9jazogJWxk
XG4iLAotCQkJcHJlLCBmZWVkYmFjaywgcG9zdCwgUE0zX1NDQUxFX1RPX0NMT0NLKHByZSwKLQkJ
CQkJCQkJZmVlZGJhY2ssCi0JCQkJCQkJCXBvc3QpKTsKKwljYXNlIDE2OgorCQl2YXItPnJlZC5v
ZmZzZXQgICA9IDExOworCQl2YXItPnJlZC5sZW5ndGggICA9IDU7CisJCXZhci0+Z3JlZW4ub2Zm
c2V0ID0gNTsKKwkJdmFyLT5ncmVlbi5sZW5ndGggPSA2OworCQl2YXItPmJsdWUub2Zmc2V0ICA9
IDA7CisJCXZhci0+Ymx1ZS5sZW5ndGggID0gNTsKIAkJYnJlYWs7Ci0JY2FzZSAwOgotCQlwcmUg
PSBQTTNfUkVBRF9EQUNfUkVHKFBNM1JEX0RDbGswUHJlU2NhbGUpOwotCQlmZWVkYmFjayA9IFBN
M19SRUFEX0RBQ19SRUcoUE0zUkRfRENsazBGZWVkYmFja1NjYWxlKTsKLQkJcG9zdCA9IFBNM19S
RUFEX0RBQ19SRUcoUE0zUkRfRENsazBQb3N0U2NhbGUpOwotCi0JCURQUklOVEsoMiwKLQkJCSJE
Q2xrMCBwYXJhbWV0ZXI6IFByZTogJWxkLCBGZWVkYmFjazogJWxkLCBQb3N0OiAlbGQgOyBnaXZp
bmcgcGl4Y2xvY2s6ICVsZFxuIiwKLQkJCXByZSwgZmVlZGJhY2ssIHBvc3QsIFBNM19TQ0FMRV9U
T19DTE9DSyhwcmUsCi0JCQkJCQkJCWZlZWRiYWNrLAotCQkJCQkJCQlwb3N0KSk7CisJY2FzZSAz
MjoKKwkJdmFyLT50cmFuc3Aub2Zmc2V0ID0gMjQ7CisJCXZhci0+dHJhbnNwLmxlbmd0aCA9IDg7
CisJCXZhci0+cmVkLm9mZnNldAkgID0gMTY7CisJCXZhci0+Z3JlZW4ub2Zmc2V0ID0gODsKKwkJ
dmFyLT5ibHVlLm9mZnNldCAgPSAwOworCQl2YXItPnJlZC5sZW5ndGggPSB2YXItPmdyZWVuLmxl
bmd0aCA9IHZhci0+Ymx1ZS5sZW5ndGggPSA4OwogCQlicmVhazsKIAlkZWZhdWx0OgotCQlwcmUg
PSBmZWVkYmFjayA9IHBvc3QgPSAwOwotCQlEUFJJTlRLKDEsICJVbmtub3drIEQgY2xvY2sgdXNl
ZCA6ICVsZFxuIiwgY2xvY2t1c2VkKTsKLQkJYnJlYWs7CisJCURQUklOVEsoImRlcHRoIG5vdCBz
dXBwb3J0ZWQ6ICV1XG4iLCB2YXItPmJpdHNfcGVyX3BpeGVsKTsKKwkJcmV0dXJuIC1FSU5WQUw7
CiAJfQorCXZhci0+aGVpZ2h0ID0gdmFyLT53aWR0aCA9IC0xOwogCi0JY3VycGFyLT5waXhjbG9j
ayA9IFBNM19TQ0FMRV9UT19DTE9DSyhwcmUsIGZlZWRiYWNrLCBwb3N0KTsKLQotCXBpeHNpemUx
ID0KLQkgICAgUE0zQnlBcGVydHVyZU1vZGVfUElYRUxTSVpFX01BU0sgJgotCSAgICAoUE0zX1JF
QURfUkVHKFBNM0J5QXBlcnR1cmUxTW9kZSkpOwotCXBpeHNpemUyID0KLQkgICAgUE0zQnlBcGVy
dHVyZU1vZGVfUElYRUxTSVpFX01BU0sgJgotCSAgICAoUE0zX1JFQURfUkVHKFBNM0J5QXBlcnR1
cmUyTW9kZSkpOwotCi0JREFTU0VSVCgocGl4c2l6ZTEgPT0gcGl4c2l6ZTIpLAotCQkicGl4c2l6
ZSB0aGUgc2FtZSBpbiBib3RoIGFwZXJ0dXJlXG4iKTsKLQotCWlmIChwaXhzaXplMSAmIFBNM0J5
QXBlcnR1cmVNb2RlX1BJWEVMU0laRV8zMkJJVCkKLQkJY3VycGFyLT5kZXB0aCA9IDMyOwotCWVs
c2UgaWYgKHBpeHNpemUxICYgUE0zQnlBcGVydHVyZU1vZGVfUElYRUxTSVpFXzE2QklUKQotCXsK
LQkJY3VycGFyLT5kZXB0aCA9IDE2OworCWlmICh2YXItPnhyZXMgIT0gdmFyLT54cmVzX3ZpcnR1
YWwpIHsKKwkJRFBSSU5USygidmlydHVhbCB4IHJlc29sdXRpb24gIT0gcGh5c2ljYWwgeCByZXNv
bHV0aW9uIG5vdCBzdXBwb3J0ZWRcbiIpOworCQlyZXR1cm4gLUVJTlZBTDsKIAl9Ci0JZWxzZQot
CQljdXJwYXItPmRlcHRoID0gODsKIAotCS8qIG5vdCBzdXJlIGlmIEkgbmVlZCB0byBhZGQgb25l
IG9uIHRoZSBuZXh0IDsgaXQgZ2l2ZSBiZXR0ZXIgcmVzdWx0IHdpdGggKi8KLQljdXJwYXItPmh0
b3RhbCA9Ci0JICAgIHBtM2ZiX1Vuc2hpZnRicHAobF9mYl9pbmZvLCBjdXJwYXItPmRlcHRoLAot
CQkJICAgICAxICsgUE0zX1JFQURfUkVHKFBNM0hUb3RhbCkpOwotCWN1cnBhci0+aHNlbmQgPQot
CSAgICBwbTNmYl9VbnNoaWZ0YnBwKGxfZmJfaW5mbywgY3VycGFyLT5kZXB0aCwKLQkJCSAgICAg
UE0zX1JFQURfUkVHKFBNM0hzRW5kKSk7Ci0JY3VycGFyLT5oc3N0YXJ0ID0KLQkgICAgcG0zZmJf
VW5zaGlmdGJwcChsX2ZiX2luZm8sIGN1cnBhci0+ZGVwdGgsCi0JCQkgICAgIFBNM19SRUFEX1JF
RyhQTTNIc1N0YXJ0KSk7Ci0JY3VycGFyLT5oYmVuZCA9Ci0JICAgIHBtM2ZiX1Vuc2hpZnRicHAo
bF9mYl9pbmZvLCBjdXJwYXItPmRlcHRoLAotCQkJICAgICBQTTNfUkVBRF9SRUcoUE0zSGJFbmQp
KTsKLQotCWN1cnBhci0+c3RyaWRlID0KLQkgICAgcG0zZmJfVW5zaGlmdGJwcChsX2ZiX2luZm8s
IGN1cnBhci0+ZGVwdGgsCi0JCQkgICAgIFBNM19SRUFEX1JFRyhQTTNTY3JlZW5TdHJpZGUpKTsK
LQotCWN1cnBhci0+dnRvdGFsID0gMSArIFBNM19SRUFEX1JFRyhQTTNWVG90YWwpOwotCWN1cnBh
ci0+dnNlbmQgPSAxICsgUE0zX1JFQURfUkVHKFBNM1ZzRW5kKTsKLQljdXJwYXItPnZzc3RhcnQg
PSAxICsgUE0zX1JFQURfUkVHKFBNM1ZzU3RhcnQpOwotCWN1cnBhci0+dmJlbmQgPSBQTTNfUkVB
RF9SRUcoUE0zVmJFbmQpOwotCi0JY3VycGFyLT52aWRlbyA9IFBNM19SRUFEX1JFRyhQTTNWaWRl
b0NvbnRyb2wpOwotCi0JY3VycGFyLT5iYXNlID0gUE0zX1JFQURfUkVHKFBNM1NjcmVlbkJhc2Up
OwotCWN1cnBhci0+d2lkdGggPSBjdXJwYXItPmh0b3RhbCAtIGN1cnBhci0+aGJlbmQ7IC8qIG1h
a2UgdmlydHVhbCA9PSBkaXNwbGF5ZWQgcmVzb2x1dGlvbiAqLwotCWN1cnBhci0+aGVpZ2h0ID0g
Y3VycGFyLT52dG90YWwgLSBjdXJwYXItPnZiZW5kOwotCi0JRFBSSU5USygyLCAiRm91bmQgOiAl
ZCAqICVkLCAlZCBLaHosIHN0cmlkZSBpcyAlMDh4XG4iLAotCQljdXJwYXItPndpZHRoLCBjdXJw
YXItPmhlaWdodCwgY3VycGFyLT5waXhjbG9jaywKLQkJY3VycGFyLT5zdHJpZGUpOwotfQotCi1z
dGF0aWMgdW5zaWduZWQgbG9uZyBwbTNmYl9zaXplX21lbW9yeShzdHJ1Y3QgcG0zZmJfaW5mbyAq
bF9mYl9pbmZvKQotewotCXVuc2lnbmVkIGxvbmcgbWVtc2l6ZSA9IDAsIHRlbXBCeXBhc3MsIGks
IHRlbXAxLCB0ZW1wMjsKLQl1MTYgc3VidmVuZG9yLCBzdWJkZXZpY2U7Ci0JcG0zZmJfdGltaW5n
X3Jlc3VsdCBwdHI7Ci0KLQlEVFJBQ0U7Ci0KLQlsX2ZiX2luZm8tPmZiX3NpemUgPSA2NCAqIDEw
MjQgKiAxMDI0OwkvKiBwbTMgYXBlcnR1cmUgYWx3YXlzIDY0IE1CICovCi0JcG0zZmJfbWFwSU8o
bF9mYl9pbmZvKTsJLyogdGVtcG9yYXJ5IG1hcCBJTyAqLwotCi0JREFTU0VSVCgobF9mYl9pbmZv
LT52SU9CYXNlICE9IE5VTEwpLAotCQkiSU8gc3VjY2Vzc2Z1bGx5IG1hcHBlZCBiZWZvcmUgbWVt
IGRldGVjdFxuIik7Ci0JREFTU0VSVCgobF9mYl9pbmZvLT52X2ZiICE9IE5VTEwpLAotCQkiRkIg
c3VjY2Vzc2Z1bGx5IG1hcHBlZCBiZWZvcmUgbWVtIGRldGVjdFxuIik7Ci0KLQkvKiBjYXJkLXNw
ZWNpZmljIHN0dWZmLCAqYmVmb3JlKiBhY2Nlc3NpbmcgKmFueSogRkIgbWVtb3J5ICovCi0JaWYg
KCghcGNpX3JlYWRfY29uZmlnX3dvcmQKLQkgICAgIChsX2ZiX2luZm8tPmRldiwgUENJX1NVQlNZ
U1RFTV9WRU5ET1JfSUQsICZzdWJ2ZW5kb3IpKQotCSAgICAmJgotCSAgICAoIXBjaV9yZWFkX2Nv
bmZpZ193b3JkCi0JICAgICAobF9mYl9pbmZvLT5kZXYsIFBDSV9TVUJTWVNURU1fSUQsICZzdWJk
ZXZpY2UpKSkgewotCQlpID0gMDsgbF9mYl9pbmZvLT5ib2FyZF90eXBlID0gMDsKLQkJd2hpbGUg
KChjYXJkYmFzZVtpXS5jYXJkbmFtZVswXSkgJiYgIShsX2ZiX2luZm8tPmJvYXJkX3R5cGUpKSB7
Ci0JCQlpZiAoKGNhcmRiYXNlW2ldLnN1YnZlbmRvciA9PSBzdWJ2ZW5kb3IpICYmCi0JCQkgICAg
KGNhcmRiYXNlW2ldLnN1YmRldmljZSA9PSBzdWJkZXZpY2UpICYmCi0JCQkgICAgKGNhcmRiYXNl
W2ldLmZ1bmMgPT0gUENJX0ZVTkMobF9mYl9pbmZvLT5kZXYtPmRldmZuKSkpIHsKLQkJCQlEUFJJ
TlRLKDIsICJDYXJkICMlbGQgaXMgYW4gJXNcbiIsCi0JCQkJCWxfZmJfaW5mby0+Ym9hcmRfbnVt
LAotCQkJCQljYXJkYmFzZVtpXS5jYXJkbmFtZSk7Ci0JCQkJaWYgKGNhcmRiYXNlW2ldLnNwZWNp
ZmljX3NldHVwKQotCQkJCQljYXJkYmFzZVtpXS5zcGVjaWZpY19zZXR1cChsX2ZiX2luZm8pOwot
CQkJCWxfZmJfaW5mby0+Ym9hcmRfdHlwZSA9IGk7Ci0JCQl9Ci0JCQlpKys7Ci0JCX0KLQkJaWYg
KCFsX2ZiX2luZm8tPmJvYXJkX3R5cGUpIHsKLQkJCURQUklOVEsoMSwgIkNhcmQgIyVsZCBpcyBh
biB1bmtub3duIDB4JTA0eCAvIDB4JTA0eFxuIiwKLQkJCQlsX2ZiX2luZm8tPmJvYXJkX251bSwg
c3VidmVuZG9yLCBzdWJkZXZpY2UpOwotCQl9Ci0JfSBlbHNlIHsKLQkJcHJpbnRrKEtFUk5fRVJS
ICJwbTNmYjogRXJyb3I6IHBjaV9yZWFkX2NvbmZpZ193b3JkIGZhaWxlZCwgYm9hcmQgIyVsZFxu
IiwKLQkJICAgICAgIGxfZmJfaW5mby0+Ym9hcmRfbnVtKTsKKwlpZiAodmFyLT55cmVzID4gdmFy
LT55cmVzX3ZpcnR1YWwpIHsKKwkJRFBSSU5USygidmlydHVhbCB5IHJlc29sdXRpb24gPCBwaHlz
aWNhbCB5IHJlc29sdXRpb24gbm90IHBvc3NpYmxlXG4iKTsKKwkJcmV0dXJuIC1FSU5WQUw7CiAJ
fQogCi0JaWYgKHByaW50dGltaW5ncykKLQkJcG0zZmJfc2hvd19jdXJfdGltaW5nKGxfZmJfaW5m
byk7Ci0JCi0JLyogY2FyZC1zcGVjaWZpYyBzZXR1cCBpcyBkb25lLCB3ZSBwcmVzZXJ2ZSB0aGUg
ZmluYWwKLSAgICAgICAgICAgbWVtb3J5IHRpbWluZyBmb3IgZnV0dXJlIHJlZmVyZW5jZSAqLwot
CWlmICgocHRyID0gcG0zZmJfcHJlc2VydmVfbWVtb3J5X3RpbWluZ3MobF9mYl9pbmZvKSkgPT0g
cG0zZmJfdGltaW5nX3Byb2JsZW0pIHsgLyogbWVtb3J5IHRpbWluZ3Mgd2VyZSB3cm9uZyAhIG9v
cHMuLi4uICovCi0JCXJldHVybigwKTsKKwlpZiAodmFyLT54b2Zmc2V0KSB7CisJCURQUklOVEso
InhvZmZzZXQgbm90IHN1cHBvcnRlZFxuIik7CisJCXJldHVybiAtRUlOVkFMOwogCX0KLQkKLQl0
ZW1wQnlwYXNzID0gUE0zX1JFQURfUkVHKFBNM01lbUJ5cGFzc1dyaXRlTWFzayk7Ci0KLQlEUFJJ
TlRLKDIsICJQTTNNZW1CeXBhc3NXcml0ZU1hc2sgd2FzOiAweCUwOGx4XG4iLCB0ZW1wQnlwYXNz
KTsKLQotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNNZW1CeXBhc3NXcml0ZU1hc2ssIDB4RkZGRkZG
RkYpOwotCi0JLyogcG0zIHNwbGl0IHVwIG1lbW9yeSwgcmVwbGljYXRlcywgYW5kIGRvIGEgbG90
IG9mIG5hc3R5IHN0dWZmIElNSE8gOy0pICovCi0JZm9yIChpID0gMDsgaSA8IDMyOyBpKyspIHsK
LQkJZmJfd3JpdGVsKGkgKiAweDAwMzQ1Njc4LAotCQkJICAobF9mYl9pbmZvLT52X2ZiICsgKGkg
KiAxMDQ4NTc2KSkpOwotCQltYigpOwotCQl0ZW1wMSA9IGZiX3JlYWRsKChsX2ZiX2luZm8tPnZf
ZmIgKyAoaSAqIDEwNDg1NzYpKSk7CiAKLQkJLyogTGV0J3MgY2hlY2sgZm9yIHdyYXBvdmVyLCB3
cml0ZSB3aWxsIGZhaWwgYXQgMTZNQiBib3VuZGFyeSAqLwotCQlpZiAodGVtcDEgPT0gKGkgKiAw
eDAwMzQ1Njc4KSkKLQkJCW1lbXNpemUgPSBpOwotCQllbHNlCi0JCQlicmVhazsKKwlpZiAoKHZh
ci0+dm1vZGUgJiBGQl9WTU9ERV9NQVNLKSA9PSBGQl9WTU9ERV9JTlRFUkxBQ0VEKSB7CisJCURQ
UklOVEsoImludGVybGFjZSBub3Qgc3VwcG9ydGVkXG4iKTsKKwkJcmV0dXJuIC1FSU5WQUw7CiAJ
fQogCi0JRFBSSU5USygyLCAiRmlyc3QgZGV0ZWN0IHBhc3MgYWxyZWFkeSBnb3QgJWxkIE1CXG4i
LCBtZW1zaXplICsgMSk7Ci0KLQlpZiAobWVtc2l6ZSA9PSBpKSB7Ci0JCWZvciAoaSA9IDA7IGkg
PCAzMjsgaSsrKSB7Ci0JCQkvKiBDbGVhciBmaXJzdCAzMk1CIDsgMCBpcyAwLCBubyBuZWVkIHRv
IGJ5dGVzd2FwICovCi0JCQl3cml0ZWwoMHgwMDAwMDAwLAotCQkJICAgICAgIChsX2ZiX2luZm8t
PnZfZmIgKyAoaSAqIDEwNDg1NzYpKSk7Ci0JCQltYigpOwotCQl9CisJdmFyLT54cmVzID0gKHZh
ci0+eHJlcyArIDMxKSAmIH4zMTsgLyogY291bGQgc29tZXRpbWVzIGJlIDggKi8KKwlscGl0Y2gg
PSB2YXItPnhyZXMgKiAoKHZhci0+Yml0c19wZXJfcGl4ZWwgKyA3KT4+Myk7CiAKLQkJZm9yIChp
ID0gMzI7IGkgPCA2NDsgaSsrKSB7Ci0JCQlmYl93cml0ZWwoaSAqIDB4MDAzNDU2NzgsCi0JCQkJ
ICAobF9mYl9pbmZvLT52X2ZiICsgKGkgKiAxMDQ4NTc2KSkpOwotCQkJbWIoKTsKLQkJCXRlbXAx
ID0KLQkJCSAgICBmYl9yZWFkbCgobF9mYl9pbmZvLT52X2ZiICsgKGkgKiAxMDQ4NTc2KSkpOwot
CQkJdGVtcDIgPQotCQkJICAgIGZiX3JlYWRsKChsX2ZiX2luZm8tPnZfZmIgKwotCQkJCSAgICAg
ICgoaSAtIDMyKSAqIDEwNDg1NzYpKSk7Ci0JCQlpZiAoKHRlbXAxID09IChpICogMHgwMDM0NTY3
OCkpICYmICh0ZW1wMiA9PSAwKSkJLyogZGlmZmVyZW50IHZhbHVlLCBkaWZmZXJlbnQgUkFNLi4u
ICovCi0JCQkJbWVtc2l6ZSA9IGk7Ci0JCQllbHNlCi0JCQkJYnJlYWs7Ci0JCX0KKwlpZiAodmFy
LT54cmVzIDwgMjAwIHx8IHZhci0+eHJlcyA+IDIwNDgpIHsKKwkJRFBSSU5USygid2lkdGggbm90
IHN1cHBvcnRlZDogJXVcbiIsIHZhci0+eHJlcyk7CisJCXJldHVybiAtRUlOVkFMOwogCX0KIAot
CURQUklOVEsoMiwgIlNlY29uZCBkZXRlY3QgcGFzcyBnb3QgJWxkIE1CXG4iLCBtZW1zaXplICsg
MSk7Ci0KLQlQTTNfU0xPV19XUklURV9SRUcoUE0zTWVtQnlwYXNzV3JpdGVNYXNrLCB0ZW1wQnlw
YXNzKTsKLQotCXBtM2ZiX3VubWFwSU8obF9mYl9pbmZvKTsKLQltZW1zaXplID0gMTA0ODU3NiAq
IChtZW1zaXplICsgMSk7Ci0KLQlEUFJJTlRLKDIsICJSZXR1cm5pbmcgMHglMDhseCBieXRlc1xu
IiwgbWVtc2l6ZSk7Ci0KLQlpZiAoZm9yY2VzaXplW2xfZmJfaW5mby0+Ym9hcmRfbnVtXSAmJiAo
KGZvcmNlc2l6ZVtsX2ZiX2luZm8tPmJvYXJkX251bV0gKiAxMDQ4NTc2KSAhPSBtZW1zaXplKSkK
LQl7Ci0JCXByaW50ayhLRVJOX1dBUk5JTkcgInBtM2ZiOiBtaXNtYXRjaCBiZXR3ZWVuIHByb2Jl
ZCAoJWxkIE1CKSBhbmQgc3BlY2lmaWVkICglaGQgTUIpIG1lbW9yeSBzaXplLCB1c2luZyBTUEVD
SUZJRUQgIVxuIiwgbWVtc2l6ZSwgZm9yY2VzaXplW2xfZmJfaW5mby0+Ym9hcmRfbnVtXSk7Ci0J
CW1lbXNpemUgPSAxMDQ4NTc2ICogZm9yY2VzaXplW2xfZmJfaW5mby0+Ym9hcmRfbnVtXTsKLQl9
Ci0JCi0JbF9mYl9pbmZvLT5mYl9zaXplID0gbWVtc2l6ZTsKLQkKLQlpZiAocHRyID09IHBtM2Zi
X3RpbWluZ19yZXRyeSkKLQl7Ci0JCXByaW50ayhLRVJOX1dBUk5JTkcgInBtM2ZiOiByZXRyeWlu
ZyBtZW1vcnkgdGltaW5ncyBjaGVjayIpOwotCQlpZiAocG0zZmJfdHJ5X21lbW9yeV90aW1pbmdz
KGxfZmJfaW5mbykgPT0gcG0zZmJfdGltaW5nX3Byb2JsZW0pCi0JCQlyZXR1cm4oMCk7CisJaWYg
KHZhci0+eXJlcyA8IDIwMCB8fCB2YXItPnlyZXMgPiA0MDk1KSB7CisJCURQUklOVEsoImhlaWdo
dCBub3Qgc3VwcG9ydGVkOiAldVxuIiwgdmFyLT55cmVzKTsKKwkJcmV0dXJuIC1FSU5WQUw7CiAJ
fQotCQotCXJldHVybiAobWVtc2l6ZSk7Ci19CiAKLXN0YXRpYyB2b2lkIHBtM2ZiX2NsZWFyX21l
bW9yeShzdHJ1Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvLCB1MzIgY2MpCi17Ci0JaW50IGk7Ci0K
LQlEVFJBQ0U7Ci0KLQlmb3IgKGkgPSAwOyBpIDwgKGxfZmJfaW5mby0+ZmJfc2l6ZSAvIHNpemVv
Zih1MzIpKSA7IGkrKykgLyogY2xlYXIgZW50aXJlIEZCIG1lbW9yeSB0byBibGFjayAqLwotCXsK
LQkJZmJfd3JpdGVsKGNjLCAobF9mYl9pbmZvLT52X2ZiICsgKGkgKiBzaXplb2YodTMyKSkpKTsK
KwlpZiAobHBpdGNoICogdmFyLT55cmVzX3ZpcnR1YWwgPiBpbmZvLT5maXguc21lbV9sZW4pIHsK
KwkJRFBSSU5USygibm8gbWVtb3J5IGZvciBzY3JlZW4gKCV1eCV1eCV1KVxuIiwKKwkJCXZhci0+
eHJlcywgdmFyLT55cmVzX3ZpcnR1YWwsIHZhci0+Yml0c19wZXJfcGl4ZWwpOworCQlyZXR1cm4g
LUVJTlZBTDsKIAl9Ci19Ci0KLXN0YXRpYyB2b2lkIHBtM2ZiX2NsZWFyX2NvbG9ybWFwKHN0cnVj
dCBwbTNmYl9pbmZvICpsX2ZiX2luZm8sIHVuc2lnbmVkIGNoYXIgciwgdW5zaWduZWQgY2hhciBn
LCB1bnNpZ25lZCBjaGFyIGIpCi17Ci0JaW50IGk7CiAKLQlEVFJBQ0U7CisJaWYgKFBJQ09TMktI
Wih2YXItPnBpeGNsb2NrKSA+IFBNM19NQVhfUElYQ0xPQ0spIHsKKwkJRFBSSU5USygicGl4Y2xv
Y2sgdG9vIGhpZ2ggKCVsZEtIeilcbiIsIFBJQ09TMktIWih2YXItPnBpeGNsb2NrKSk7CisJCXJl
dHVybiAtRUlOVkFMOworCX0KIAotCWZvciAoaSA9IDA7IGkgPCAyNTYgOyBpKyspIC8qIGZpbGwg
Y29sb3IgbWFwIHdpdGggd2hpdGUgKi8KLQkJcG0zZmJfc2V0X2NvbG9yKGxfZmJfaW5mbywgaSwg
ciwgZywgYik7CisJdmFyLT5hY2NlbF9mbGFncyA9IDA7CS8qIENhbid0IG1tYXAgaWYgdGhpcyBp
cyBvbiAqLwogCisJRFBSSU5USygiQ2hlY2tpbmcgZ3JhcGhpY3MgbW9kZSBhdCAlZHglZCBkZXB0
aCAlZFxuIiwKKwkJdmFyLT54cmVzLCB2YXItPnlyZXMsIHZhci0+Yml0c19wZXJfcGl4ZWwpOwor
CXJldHVybiAwOwogfQogCi0vKiBjb21tb24gaW5pdGlhbGlzYXRpb24gKi8KLXN0YXRpYyB2b2lk
IHBtM2ZiX2NvbW1vbl9pbml0KHN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8pCitzdGF0aWMg
aW50IHBtM2ZiX3NldF9wYXIoc3RydWN0IGZiX2luZm8gKmluZm8pCiB7Ci0JRFRSQUNFOworCXN0
cnVjdCBwbTNfcGFyICpwYXIgPSBpbmZvLT5wYXI7CisJY29uc3QgdTMyIHhyZXMgPSAoaW5mby0+
dmFyLnhyZXMgKyAzMSkgJiB+MzE7CisJY29uc3QgaW50IGRlcHRoID0gKGluZm8tPnZhci5iaXRz
X3Blcl9waXhlbCArIDcpICYgfjc7CiAKLQlEUFJJTlRLKDIsICJJbml0aWFsaXppbmcgYm9hcmQg
IyVsZCBAICVseFxuIiwgbF9mYl9pbmZvLT5ib2FyZF9udW0sCi0JCSh1bnNpZ25lZCBsb25nKSBs
X2ZiX2luZm8pOworCXBhci0+YmFzZSA9IHBtM2ZiX3NoaWZ0X2JwcChpbmZvLT52YXIuYml0c19w
ZXJfcGl4ZWwsCisJCQkJCShpbmZvLT52YXIueW9mZnNldCAqIHhyZXMpCisJCQkJCSsgaW5mby0+
dmFyLnhvZmZzZXQpOworCXBhci0+dmlkZW8gPSAwOwogCi0Jc3RyY3B5KGxfZmJfaW5mby0+Z2Vu
LmluZm8ubW9kZW5hbWUsIHBlcm1lZGlhM19uYW1lKTsKLQlkaXNwW2xfZmJfaW5mby0+Ym9hcmRf
bnVtXS5zY3JvbGxtb2RlID0gMDsJLyogU0NST0xMX1lOT01PVkU7ICovLyogMCBtZWFucyAibGV0
IGZiY29uIGNob29zZSIgKi8KLQlsX2ZiX2luZm8tPmdlbi5wYXJzaXplID0gc2l6ZW9mKHN0cnVj
dCBwbTNmYl9wYXIpOwotCWxfZmJfaW5mby0+Z2VuLmluZm8uY2hhbmdldmFyID0gTlVMTDsKLQls
X2ZiX2luZm8tPmdlbi5pbmZvLmZib3BzID0gJnBtM2ZiX29wczsKLQlsX2ZiX2luZm8tPmdlbi5p
bmZvLmRpc3AgPSAmKGRpc3BbbF9mYl9pbmZvLT5ib2FyZF9udW1dKTsKLQlpZiAoZm9udG5bbF9m
Yl9pbmZvLT5ib2FyZF9udW1dWzBdKQotCQlzdHJjcHkobF9mYl9pbmZvLT5nZW4uaW5mby5mb250
bmFtZSwKLQkJICAgICAgIGZvbnRuW2xfZmJfaW5mby0+Ym9hcmRfbnVtXSk7Ci0JbF9mYl9pbmZv
LT5nZW4uaW5mby5zd2l0Y2hfY29uID0gJmZiZ2VuX3N3aXRjaDsKLQlsX2ZiX2luZm8tPmdlbi5p
bmZvLnVwZGF0ZXZhciA9ICZmYmdlbl91cGRhdGVfdmFyOwkvKiAqLwotCWxfZmJfaW5mby0+Z2Vu
LmluZm8uZmxhZ3MgPSBGQklORk9fRkxBR19ERUZBVUxUOwotCi0JcG0zZmJfbWFwSU8obF9mYl9p
bmZvKTsKKwlpZiAoaW5mby0+dmFyLnN5bmMgJiBGQl9TWU5DX0hPUl9ISUdIX0FDVCkKKwkJcGFy
LT52aWRlbyB8PSBQTTNWaWRlb0NvbnRyb2xfSFNZTkNfQUNUSVZFX0hJR0g7CisJZWxzZQorCQlw
YXItPnZpZGVvIHw9IFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19BQ1RJVkVfTE9XOwogCi0JcG0zZmJf
Y2xlYXJfbWVtb3J5KGxfZmJfaW5mbywgMCk7Ci0JcG0zZmJfY2xlYXJfY29sb3JtYXAobF9mYl9p
bmZvLCAwLCAwLCAwKTsKKwlpZiAoaW5mby0+dmFyLnN5bmMgJiBGQl9TWU5DX1ZFUlRfSElHSF9B
Q1QpCisJCXBhci0+dmlkZW8gfD0gUE0zVmlkZW9Db250cm9sX1ZTWU5DX0FDVElWRV9ISUdIOwor
CWVsc2UKKwkJcGFyLT52aWRlbyB8PSBQTTNWaWRlb0NvbnRyb2xfVlNZTkNfQUNUSVZFX0xPVzsK
IAotCSh2b2lkKSBmYmdlbl9nZXRfdmFyKCYoZGlzcFtsX2ZiX2luZm8tPmJvYXJkX251bV0pLnZh
ciwgLTEsCi0JCQkgICAgICZsX2ZiX2luZm8tPmdlbi5pbmZvKTsKKwlpZiAoKGluZm8tPnZhci52
bW9kZSAmIEZCX1ZNT0RFX01BU0spID09IEZCX1ZNT0RFX0RPVUJMRSkKKwkJcGFyLT52aWRlbyB8
PSBQTTNWaWRlb0NvbnRyb2xfTElORV9ET1VCTEVfT047CisJZWxzZQorCQlwYXItPnZpZGVvIHw9
IFBNM1ZpZGVvQ29udHJvbF9MSU5FX0RPVUJMRV9PRkY7CiAKLQlpZiAoZGVwdGhbbF9mYl9pbmZv
LT5ib2FyZF9udW1dKSAvKiBvdmVycmlkZSBtb2RlLWRlZmluZWQgZGVwdGggKi8KLQl7Ci0JCXBt
M2ZiX2VuY29kZV9kZXB0aCgmKGRpc3BbbF9mYl9pbmZvLT5ib2FyZF9udW1dKS52YXIsIGRlcHRo
W2xfZmJfaW5mby0+Ym9hcmRfbnVtXSk7Ci0JCShkaXNwW2xfZmJfaW5mby0+Ym9hcmRfbnVtXSku
dmFyLmJpdHNfcGVyX3BpeGVsID0gZGVwdGgyYnBwKGRlcHRoW2xfZmJfaW5mby0+Ym9hcmRfbnVt
XSk7CisJaWYgKGluZm8tPnZhci5hY3RpdmF0ZSA9PSBGQl9BQ1RJVkFURV9OT1cpCisJCXBhci0+
dmlkZW8gfD0gUE0zVmlkZW9Db250cm9sX0VOQUJMRTsKKwllbHNlIHsKKwkJcGFyLT52aWRlbyB8
PSBQTTNWaWRlb0NvbnRyb2xfRElTQUJMRTsKKwkJRFBSSU5USygiUE0zVmlkZW8gZGlzYWJsZWRc
biIpOworCX0KKwlzd2l0Y2ggKGRlcHRoKSB7CisJY2FzZSA4OgorCQlwYXItPnZpZGVvIHw9IFBN
M1ZpZGVvQ29udHJvbF9QSVhFTFNJWkVfOEJJVDsKKwkJYnJlYWs7CisJY2FzZSAxMjoKKwljYXNl
IDE1OgorCWNhc2UgMTY6CisJCXBhci0+dmlkZW8gfD0gUE0zVmlkZW9Db250cm9sX1BJWEVMU0la
RV8xNkJJVDsKKwkJYnJlYWs7CisJY2FzZSAzMjoKKwkJcGFyLT52aWRlbyB8PSBQTTNWaWRlb0Nv
bnRyb2xfUElYRUxTSVpFXzMyQklUOworCQlicmVhazsKKwlkZWZhdWx0OgorCQlEUFJJTlRLKCJV
bnN1cHBvcnRlZCBkZXB0aFxuIik7CisJCWJyZWFrOwogCX0KIAotCSh2b2lkKSBmYmdlbl9kb19z
ZXRfdmFyKCYoZGlzcFtsX2ZiX2luZm8tPmJvYXJkX251bV0pLnZhciwgMSwKLQkJCQkmbF9mYl9p
bmZvLT5nZW4pOworCWluZm8tPmZpeC52aXN1YWwgPQorCQkoZGVwdGggPT0gOCkgPyBGQl9WSVNV
QUxfUFNFVURPQ09MT1IgOiBGQl9WSVNVQUxfVFJVRUNPTE9SOworCWluZm8tPmZpeC5saW5lX2xl
bmd0aCA9ICgoaW5mby0+dmFyLnhyZXNfdmlydHVhbCArIDcpICAmIH43ICkKKwkJCQkJKiBkZXB0
aCAvIDg7CiAKLQlmYmdlbl9zZXRfZGlzcCgtMSwgJmxfZmJfaW5mby0+Z2VuKTsKKy8qCXBtM2Zi
X2NsZWFyX21lbW9yeShpbmZvLCAwKTsqLworCXBtM2ZiX2NsZWFyX2NvbG9ybWFwKHBhciwgMCwg
MCwgMCk7CisJUE0zX1dSSVRFX0RBQ19SRUcocGFyLCBQTTNSRF9DdXJzb3JNb2RlLAorCQkJICBQ
TTNSRF9DdXJzb3JNb2RlX0NVUlNPUl9ESVNBQkxFKTsKKwlwbTNmYl93cml0ZV9tb2RlKGluZm8p
OworCXJldHVybiAwOworfQogCi0JZG9faW5zdGFsbF9jbWFwKDAsICZsX2ZiX2luZm8tPmdlbi5p
bmZvKTsKK3N0YXRpYyBpbnQgcG0zZmJfc2V0Y29scmVnKHVuc2lnbmVkIHJlZ25vLCB1bnNpZ25l
ZCByZWQsIHVuc2lnbmVkIGdyZWVuLAorCQkJICAgdW5zaWduZWQgYmx1ZSwgdW5zaWduZWQgdHJh
bnNwLAorCQkJICAgc3RydWN0IGZiX2luZm8gKmluZm8pCit7CisJc3RydWN0IHBtM19wYXIgKnBh
ciA9IGluZm8tPnBhcjsKIAotCWlmIChyZWdpc3Rlcl9mcmFtZWJ1ZmZlcigmbF9mYl9pbmZvLT5n
ZW4uaW5mbykgPCAwKSB7Ci0JCURQUklOVEsoMSwgIkNvdWxkbid0IHJlZ2lzdGVyIGZyYW1lYnVm
ZmVyXG4iKTsKLQkJcmV0dXJuOwotCX0KKwlpZiAocmVnbm8gPj0gMjU2KSAgLyogbm8uIG9mIGh3
IHJlZ2lzdGVycyAqLworCSAgIHJldHVybiAtRUlOVkFMOwogCi0JUE0zX1dSSVRFX0RBQ19SRUco
UE0zUkRfQ3Vyc29yTW9kZSwKLQkJCSAgUE0zUkRfQ3Vyc29yTW9kZV9DVVJTT1JfRElTQUJMRSk7
Ci0JCi0JUE0zX1NIT1dfQ1VSX01PREU7Ci0JCi0JcG0zZmJfd3JpdGVfbW9kZShsX2ZiX2luZm8p
OwotCQotCXByaW50aygiZmIlZDogJXMsIHVzaW5nICV1SyBvZiB2aWRlbyBtZW1vcnkgKCVzKVxu
IiwKLQkgICAgICAgbF9mYl9pbmZvLT5nZW4uaW5mby5ub2RlLAotCSAgICAgICBwZXJtZWRpYTNf
bmFtZSwgKHUzMikgKGxfZmJfaW5mby0+ZmJfc2l6ZSA+PiAxMCksCi0JICAgICAgIGNhcmRiYXNl
W2xfZmJfaW5mby0+Ym9hcmRfdHlwZV0uY2FyZG5hbWUpOwotfQotCi0vKiAqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqICovCi0vKiAqKioqKiBhY2Nl
bGVyYXRlZCBwZXJtZWRpYTMtc3BlY2lmaWMgZnVuY3Rpb25zICoqKioqICovCi0vKiAqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqICovCi0jaWZkZWYg
UE0zRkJfVVNFX0FDQ0VMCi1zdGF0aWMgdm9pZCBwbTNmYl93YWl0X3BtMyhzdHJ1Y3QgcG0zZmJf
aW5mbyAqbF9mYl9pbmZvKQotewotCURUUkFDRTsKLQotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNG
aWx0ZXJNb2RlLCBQTTNGaWx0ZXJNb2RlU3luYyk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM1N5
bmMsIDApOwotCW1iKCk7Ci0JZG8gewotCQl3aGlsZSAoKFBNM19SRUFEX1JFRyhQTTNPdXRGSUZP
V29yZHMpKSA9PSAwKTsKLQkJcm1iKCk7Ci0JfSB3aGlsZSAoKFBNM19SRUFEX1JFRyhQTTNPdXRw
dXRGaWZvKSkgIT0gUE0zU3luY19UYWcpOwotfQotCi1zdGF0aWMgdm9pZCBwbTNmYl9pbml0X2Vu
Z2luZShzdHJ1Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvKQotewotCVBNM19TTE9XX1dSSVRFX1JF
RyhQTTNGaWx0ZXJNb2RlLCBQTTNGaWx0ZXJNb2RlU3luYyk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVH
KFBNM1N0YXRpc3RpY01vZGUsIDB4MCk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0RlbHRhTW9k
ZSwgMHgwKTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zUmFzdGVyaXplck1vZGUsIDB4MCk7Ci0J
UE0zX1NMT1dfV1JJVEVfUkVHKFBNM1NjaXNzb3JNb2RlLCAweDApOwotCVBNM19TTE9XX1dSSVRF
X1JFRyhQTTNMaW5lU3RpcHBsZU1vZGUsIDB4MCk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0Fy
ZWFTdGlwcGxlTW9kZSwgMHgwKTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zR0lETW9kZSwgMHgw
KTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zRGVwdGhNb2RlLCAweDApOwotCVBNM19TTE9XX1dS
SVRFX1JFRyhQTTNTdGVuY2lsTW9kZSwgMHgwKTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zU3Rl
bmNpbERhdGEsIDB4MCk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0NvbG9yRERBTW9kZSwgMHgw
KTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zVGV4dHVyZUNvb3JkTW9kZSwgMHgwKTsKLQlQTTNf
U0xPV19XUklURV9SRUcoUE0zVGV4dHVyZUluZGV4TW9kZTAsIDB4MCk7Ci0JUE0zX1NMT1dfV1JJ
VEVfUkVHKFBNM1RleHR1cmVJbmRleE1vZGUxLCAweDApOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQ
TTNUZXh0dXJlUmVhZE1vZGUsIDB4MCk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0xVVE1vZGUs
IDB4MCk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM1RleHR1cmVGaWx0ZXJNb2RlLCAweDApOwot
CVBNM19TTE9XX1dSSVRFX1JFRyhQTTNUZXh0dXJlQ29tcG9zaXRlTW9kZSwgMHgwKTsKLQlQTTNf
U0xPV19XUklURV9SRUcoUE0zVGV4dHVyZUFwcGxpY2F0aW9uTW9kZSwgMHgwKTsKLQlQTTNfU0xP
V19XUklURV9SRUcoUE0zVGV4dHVyZUNvbXBvc2l0ZUNvbG9yTW9kZTEsIDB4MCk7Ci0JUE0zX1NM
T1dfV1JJVEVfUkVHKFBNM1RleHR1cmVDb21wb3NpdGVBbHBoYU1vZGUxLCAweDApOwotCVBNM19T
TE9XX1dSSVRFX1JFRyhQTTNUZXh0dXJlQ29tcG9zaXRlQ29sb3JNb2RlMCwgMHgwKTsKLQlQTTNf
U0xPV19XUklURV9SRUcoUE0zVGV4dHVyZUNvbXBvc2l0ZUFscGhhTW9kZTAsIDB4MCk7Ci0JUE0z
X1NMT1dfV1JJVEVfUkVHKFBNM0ZvZ01vZGUsIDB4MCk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKFBN
M0Nocm9tYVRlc3RNb2RlLCAweDApOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNBbHBoYVRlc3RN
b2RlLCAweDApOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNBbnRpYWxpYXNNb2RlLCAweDApOwot
CVBNM19TTE9XX1dSSVRFX1JFRyhQTTNZVVZNb2RlLCAweDApOwotCVBNM19TTE9XX1dSSVRFX1JF
RyhQTTNBbHBoYUJsZW5kQ29sb3JNb2RlLCAweDApOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNB
bHBoYUJsZW5kQWxwaGFNb2RlLCAweDApOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNEaXRoZXJN
b2RlLCAweDApOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNMb2dpY2FsT3BNb2RlLCAweDApOwot
CVBNM19TTE9XX1dSSVRFX1JFRyhQTTNSb3V0ZXJNb2RlLCAweDApOwotCVBNM19TTE9XX1dSSVRF
X1JFRyhQTTNXaW5kb3csIDB4MCk7Ci0KLQlQTTNfU0xPV19XUklURV9SRUcoUE0zQ29uZmlnMkQs
IDB4MCk7Ci0KLQlQTTNfU0xPV19XUklURV9SRUcoUE0zU3BhbkNvbG9yTWFzaywgMHhmZmZmZmZm
Zik7Ci0KLQlQTTNfU0xPV19XUklURV9SRUcoUE0zWEJpYXMsIDB4MCk7Ci0JUE0zX1NMT1dfV1JJ
VEVfUkVHKFBNM1lCaWFzLCAweDApOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNEZWx0YUNvbnRy
b2wsIDB4MCk7Ci0KLQlQTTNfU0xPV19XUklURV9SRUcoUE0zQml0TWFza1BhdHRlcm4sIDB4ZmZm
ZmZmZmYpOwotCi0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0ZCRGVzdFJlYWRFbmFibGVzLAotCQkJ
ICAgUE0zRkJEZXN0UmVhZEVuYWJsZXNfRSgweGZmKSB8Ci0JCQkgICBQTTNGQkRlc3RSZWFkRW5h
Ymxlc19SKDB4ZmYpIHwKLQkJCSAgIFBNM0ZCRGVzdFJlYWRFbmFibGVzX1JlZmVyZW5jZUFscGhh
KDB4ZmYpKTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zRkJEZXN0UmVhZEJ1ZmZlckFkZHIwLCAw
eDApOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNGQkRlc3RSZWFkQnVmZmVyT2Zmc2V0MCwgMHgw
KTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zRkJEZXN0UmVhZEJ1ZmZlcldpZHRoMCwKLQkJCSAg
IFBNM0ZCRGVzdFJlYWRCdWZmZXJXaWR0aF9XaWR0aChsX2ZiX2luZm8tPgotCQkJCQkJCSAgY3Vy
cmVudF9wYXItPgotCQkJCQkJCSAgd2lkdGgpKTsKLQotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNG
QkRlc3RSZWFkTW9kZSwKLQkJCSAgIFBNM0ZCRGVzdFJlYWRNb2RlX1JlYWRFbmFibGUgfAotCQkJ
ICAgUE0zRkJEZXN0UmVhZE1vZGVfRW5hYmxlMCk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0ZC
U291cmNlUmVhZEJ1ZmZlckFkZHIsIDB4MCk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0ZCU291
cmNlUmVhZEJ1ZmZlck9mZnNldCwgMHgwKTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zRkJTb3Vy
Y2VSZWFkQnVmZmVyV2lkdGgsCi0JCQkgICBQTTNGQlNvdXJjZVJlYWRCdWZmZXJXaWR0aF9XaWR0
aChsX2ZiX2luZm8tPgotCQkJCQkJCSAgICBjdXJyZW50X3Bhci0+Ci0JCQkJCQkJICAgIHdpZHRo
KSk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0ZCU291cmNlUmVhZE1vZGUsCi0JCQkgICBQTTNG
QlNvdXJjZVJlYWRNb2RlX0Jsb2NraW5nIHwKLQkJCSAgIFBNM0ZCU291cmNlUmVhZE1vZGVfUmVh
ZEVuYWJsZSk7CisJLyogZ3JheXNjYWxlIHdvcmtzIG9ubHkgcGFydGlhbGx5IHVuZGVyIGRpcmVj
dGNvbG9yICovCisJaWYgKGluZm8tPnZhci5ncmF5c2NhbGUpIHsKKwkgICAvKiBncmF5c2NhbGUg
PSAwLjMwKlIgKyAwLjU5KkcgKyAwLjExKkIgKi8KKwkgICByZWQgPSBncmVlbiA9IGJsdWUgPSAo
cmVkICogNzcgKyBncmVlbiAqIDE1MSArIGJsdWUgKiAyOCkgPj4gODsKKwl9CisKKwkvKiBEaXJl
Y3Rjb2xvcjoKKwkgKiAgIHZhci0+e2NvbG9yfS5vZmZzZXQgY29udGFpbnMgc3RhcnQgb2YgYml0
ZmllbGQKKwkgKiAgIHZhci0+e2NvbG9yfS5sZW5ndGggY29udGFpbnMgbGVuZ3RoIG9mIGJpdGZp
ZWxkCisJICogICB7aGFyZHdhcmVzcGVjaWZpY30gY29udGFpbnMgd2lkdGggb2YgREFDCisJICog
ICBwc2V1ZG9fcGFsZXR0ZVtYXSBpcyBwcm9ncmFtbWVkIHRvIChYIDw8IHJlZC5vZmZzZXQpIHwK
KwkgKgkJCQkgICAgICAoWCA8PCBncmVlbi5vZmZzZXQpIHwKKwkgKgkJCQkgICAgICAoWCA8PCBi
bHVlLm9mZnNldCkKKwkgKiAgIFJBTURBQ1tYXSBpcyBwcm9ncmFtbWVkIHRvIChyZWQsIGdyZWVu
LCBibHVlKQorCSAqICAgY29sb3IgZGVwdGggPSBTVU0odmFyLT57Y29sb3J9Lmxlbmd0aCkKKwkg
KgorCSAqIFBzZXVkb2NvbG9yOgorCSAqCXZhci0+e2NvbG9yfS5vZmZzZXQgaXMgMAorCSAqCXZh
ci0+e2NvbG9yfS5sZW5ndGggY29udGFpbnMgd2lkdGggb2YgREFDIG9yIHRoZSBudW1iZXIgb2Yg
dW5pcXVlCisJICoJCQljb2xvcnMgYXZhaWxhYmxlIChjb2xvciBkZXB0aCkKKwkgKglwc2V1ZG9f
cGFsZXR0ZSBpcyBub3QgdXNlZAorCSAqCVJBTURBQ1tYXSBpcyBwcm9ncmFtbWVkIHRvIChyZWQs
IGdyZWVuLCBibHVlKQorCSAqCWNvbG9yIGRlcHRoID0gdmFyLT57Y29sb3J9Lmxlbmd0aAorCSAq
LwogCi0JewotCQl1bnNpZ25lZCBsb25nIHJtID0gMTsKLQkJc3dpdGNoIChsX2ZiX2luZm8tPmN1
cnJlbnRfcGFyLT5kZXB0aCkgeworCS8qCisJICogVGhpcyBpcyB0aGUgcG9pbnQgd2hlcmUgdGhl
IGNvbG9yIGlzIGNvbnZlcnRlZCB0byBzb21ldGhpbmcgdGhhdAorCSAqIGlzIGFjY2VwdGFibGUg
YnkgdGhlIGhhcmR3YXJlLgorCSAqLworI2RlZmluZSBDTlZUX1RPSFcodmFsLHdpZHRoKSAoKCgo
dmFsKTw8KHdpZHRoKSkrMHg3RkZGLSh2YWwpKT4+MTYpCisJcmVkID0gQ05WVF9UT0hXKHJlZCwg
aW5mby0+dmFyLnJlZC5sZW5ndGgpOworCWdyZWVuID0gQ05WVF9UT0hXKGdyZWVuLCBpbmZvLT52
YXIuZ3JlZW4ubGVuZ3RoKTsKKwlibHVlID0gQ05WVF9UT0hXKGJsdWUsIGluZm8tPnZhci5ibHVl
Lmxlbmd0aCk7CisJdHJhbnNwID0gQ05WVF9UT0hXKHRyYW5zcCwgaW5mby0+dmFyLnRyYW5zcC5s
ZW5ndGgpOworI3VuZGVmIENOVlRfVE9IVworCisJaWYgKGluZm8tPmZpeC52aXN1YWwgPT0gRkJf
VklTVUFMX1RSVUVDT0xPUiB8fAorCWluZm8tPmZpeC52aXN1YWwgPT0gRkJfVklTVUFMX0RJUkVD
VENPTE9SKSB7CisJCXUzMiB2OworCisJCWlmIChyZWdubyA+PSAxNikKKwkJCXJldHVybiAtRUlO
VkFMOworCisJCXYgPSAocmVkIDw8IGluZm8tPnZhci5yZWQub2Zmc2V0KSB8CisJCQkoZ3JlZW4g
PDwgaW5mby0+dmFyLmdyZWVuLm9mZnNldCkgfAorCQkJKGJsdWUgPDwgaW5mby0+dmFyLmJsdWUu
b2Zmc2V0KSB8CisJCQkodHJhbnNwIDw8IGluZm8tPnZhci50cmFuc3Aub2Zmc2V0KTsKKworCQlz
d2l0Y2ggKGluZm8tPnZhci5iaXRzX3Blcl9waXhlbCkgewogCQljYXNlIDg6Ci0JCQlQTTNfU0xP
V19XUklURV9SRUcoUE0zUGl4ZWxTaXplLAotCQkJCQkgICBQTTNQaXhlbFNpemVfR0xPQkFMXzhC
SVQpOwogCQkJYnJlYWs7Ci0JCWNhc2UgMTI6Ci0JCWNhc2UgMTU6CiAJCWNhc2UgMTY6Ci0JCQlQ
TTNfU0xPV19XUklURV9SRUcoUE0zUGl4ZWxTaXplLAotCQkJCQkgICBQTTNQaXhlbFNpemVfR0xP
QkFMXzE2QklUKTsKLQkJCWJyZWFrOworCQljYXNlIDI0OgogCQljYXNlIDMyOgotCQkJUE0zX1NM
T1dfV1JJVEVfUkVHKFBNM1BpeGVsU2l6ZSwKLQkJCQkJICAgUE0zUGl4ZWxTaXplX0dMT0JBTF8z
MkJJVCk7Ci0JCQlicmVhazsKLQkJZGVmYXVsdDoKLQkJCURQUklOVEsoMSwgIlVuc3VwcG9ydGVk
IGRlcHRoICVkXG4iLAotCQkJCWxfZmJfaW5mby0+Y3VycmVudF9wYXItPmRlcHRoKTsKKwkJCSgo
dTMyKikoaW5mby0+cHNldWRvX3BhbGV0dGUpKVtyZWdub10gPSB2OwogCQkJYnJlYWs7CiAJCX0K
LQkJUE0zX1NMT1dfV1JJVEVfUkVHKFBNM1Jhc3Rlcml6ZXJNb2RlLCBybSk7CisJCXJldHVybiAw
OwogCX0KKwllbHNlIGlmIChpbmZvLT5maXgudmlzdWFsID09IEZCX1ZJU1VBTF9QU0VVRE9DT0xP
UikKKwkJcG0zZmJfc2V0X2NvbG9yKHBhciwgcmVnbm8sIHJlZCwgZ3JlZW4sIGJsdWUpOwogCi0J
UE0zX1NMT1dfV1JJVEVfUkVHKFBNM0ZCU29mdHdhcmVXcml0ZU1hc2ssIDB4ZmZmZmZmZmYpOwot
CVBNM19TTE9XX1dSSVRFX1JFRyhQTTNGQkhhcmR3YXJlV3JpdGVNYXNrLCAweGZmZmZmZmZmKTsK
LQlQTTNfU0xPV19XUklURV9SRUcoUE0zRkJXcml0ZU1vZGUsCi0JCQkgICBQTTNGQldyaXRlTW9k
ZV9Xcml0ZUVuYWJsZSB8Ci0JCQkgICBQTTNGQldyaXRlTW9kZV9PcGFxdWVTcGFuIHwKLQkJCSAg
IFBNM0ZCV3JpdGVNb2RlX0VuYWJsZTApOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNGQldyaXRl
QnVmZmVyQWRkcjAsIDB4MCk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0ZCV3JpdGVCdWZmZXJP
ZmZzZXQwLCAweDApOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNGQldyaXRlQnVmZmVyV2lkdGgw
LAotCQkJICAgUE0zRkJXcml0ZUJ1ZmZlcldpZHRoX1dpZHRoKGxfZmJfaW5mby0+Ci0JCQkJCQkg
ICAgICAgY3VycmVudF9wYXItPgotCQkJCQkJICAgICAgIHdpZHRoKSk7CisJcmV0dXJuIDA7Cit9
CiAKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zU2l6ZU9mRnJhbWVidWZmZXIsIDB4MCk7Ci0Jewot
CQl1bnNpZ25lZCBsb25nIHNvZmIgPSAoOFVMICogbF9mYl9pbmZvLT5mYl9zaXplKSAvCi0JCQko
KGRlcHRoMmJwcChsX2ZiX2luZm8tPmN1cnJlbnRfcGFyLT5kZXB0aCkpCi0JCQkgKiBsX2ZiX2lu
Zm8tPmN1cnJlbnRfcGFyLT53aWR0aCk7CS8qIHNpemUgaW4gbGluZXMgb2YgRkIgKi8KLQkJaWYg
KHNvZmIgPiA0MDk1KQotCQkJUE0zX1NMT1dfV1JJVEVfUkVHKFBNM1NpemVPZkZyYW1lYnVmZmVy
LCA0MDk1KTsKLQkJZWxzZQotCQkJUE0zX1NMT1dfV1JJVEVfUkVHKFBNM1NpemVPZkZyYW1lYnVm
ZmVyLCBzb2ZiKTsKLQkJCi0JCXN3aXRjaCAobF9mYl9pbmZvLT5jdXJyZW50X3Bhci0+ZGVwdGgp
IHsKLQkJY2FzZSA4OgotCQkJUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0RpdGhlck1vZGUsCi0JCQkJ
CSAgICgxIDw8IDEwKSB8ICgyIDw8IDMpKTsKLQkJCWJyZWFrOwotCQljYXNlIDEyOgotCQljYXNl
IDE1OgotCQljYXNlIDE2OgotCQkJUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0RpdGhlck1vZGUsCi0J
CQkJCSAgICgxIDw8IDEwKSB8ICgxIDw8IDMpKTsKLQkJCWJyZWFrOwotCQljYXNlIDMyOgotCQkJ
UE0zX1NMT1dfV1JJVEVfUkVHKFBNM0RpdGhlck1vZGUsCi0JCQkJCSAgICgxIDw8IDEwKSB8ICgw
IDw8IDMpKTsKLQkJCWJyZWFrOwotCQlkZWZhdWx0OgotCQkJRFBSSU5USygxLCAiVW5zdXBwb3J0
ZWQgZGVwdGggJWRcbiIsCi0JCQkJbF9mYl9pbmZvLT5jdXJyZW50X3Bhci0+ZGVwdGgpOwotCQkJ
YnJlYWs7Ci0JCX0KLQl9Ci0KLQlQTTNfU0xPV19XUklURV9SRUcoUE0zZFhEb20sIDB4MCk7Ci0J
UE0zX1NMT1dfV1JJVEVfUkVHKFBNM2RYU3ViLCAweDApOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQ
TTNkWSwgKDEgPDwgMTYpKTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zU3RhcnRYRG9tLCAweDAp
OwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNTdGFydFhTdWIsIDB4MCk7Ci0JUE0zX1NMT1dfV1JJ
VEVfUkVHKFBNM1N0YXJ0WSwgMHgwKTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zQ291bnQsIDB4
MCk7Ci0JCi0vKiBEaXNhYmxlIExvY2FsQnVmZmVyLiBiZXR0ZXIgc2FmZSB0aGFuIHNvcnJ5ICov
Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKFBNM0xCRGVzdFJlYWRNb2RlLCAweDApOwotCVBNM19TTE9X
X1dSSVRFX1JFRyhQTTNMQkRlc3RSZWFkRW5hYmxlcywgMHgwKTsKLQlQTTNfU0xPV19XUklURV9S
RUcoUE0zTEJTb3VyY2VSZWFkTW9kZSwgMHgwKTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zTEJX
cml0ZU1vZGUsIDB4MCk7Ci0JCi0JcG0zZmJfd2FpdF9wbTMobF9mYl9pbmZvKTsKLX0KLQotI2lm
ZGVmIEZCQ09OX0hBU19DRkIzMgotc3RhdGljIHZvaWQgcG0zZmJfY2ZiMzJfY2xlYXIoc3RydWN0
IHZjX2RhdGEgKmNvbnAsCi0JCQkgICAgICBzdHJ1Y3QgZGlzcGxheSAqcCwKLQkJCSAgICAgIGlu
dCBzeSwgaW50IHN4LCBpbnQgaGVpZ2h0LCBpbnQgd2lkdGgpCi17Ci0Jc3RydWN0IHBtM2ZiX2lu
Zm8gKmxfZmJfaW5mbyA9IChzdHJ1Y3QgcG0zZmJfaW5mbyAqKSBwLT5mYl9pbmZvOwotCXUzMiBj
OwotCi0JRFRSQUNFOwotCi0Jc3ggPSBzeCAqIGZvbnR3aWR0aChwKTsKLQl3aWR0aCA9IHdpZHRo
ICogZm9udHdpZHRoKHApOwotCXN5ID0gc3kgKiBmb250aGVpZ2h0KHApOwotCWhlaWdodCA9IGhl
aWdodCAqIGZvbnRoZWlnaHQocCk7Ci0JYyA9ICgodTMyICopIHAtPmRpc3Bzd19kYXRhKVthdHRy
X2JnY29sX2VjKHAsIGNvbnApXTsKLQotCS8qIGJsb2NrIGZpbGxzIGluIDMyYnBwIGFyZSBoYXJk
LCBidXQgaW4gbG93IHJlcyAod2lkdGggPD0gMTYwMCA6LSkKLQkgICB3ZSBjYW4gdXNlIDE2YnBw
IG9wZXJhdGlvbnMsIGJ1dCBub3QgaWYgTm9Xcml0ZU1hc2sgaXMgb24gKFNEUkFNKSAgKi8KLQlp
ZiAoKGxfZmJfaW5mby0+Y3VycmVudF9wYXItPndpZHRoID4gMTYwMCkgfHwKLQkgICAgKGxfZmJf
aW5mby0+bWVtdC5jYXBzICYgUE0zTG9jYWxNZW1DYXBzX05vV3JpdGVNYXNrKSkgewotCQlQTTNf
V0FJVCg0KTsKLQotCQlQTTNfV1JJVEVfUkVHKFBNM0NvbmZpZzJELAotCQkJCQkgIFBNM0NvbmZp
ZzJEX1VzZUNvbnN0YW50U291cmNlIHwKLQkJCQkJICBQTTNDb25maWcyRF9Gb3JlZ3JvdW5kUk9Q
RW5hYmxlIHwKLQkJCQkJICAoUE0zQ29uZmlnMkRfRm9yZWdyb3VuZFJPUCgweDMpKSB8CS8qIE94
MyBpcyBHWGNvcHkgKi8KLQkJCQkJICBQTTNDb25maWcyRF9GQldyaXRlRW5hYmxlKTsKLQotCQlQ
TTNfV1JJVEVfUkVHKFBNM0ZvcmVncm91bmRDb2xvciwgYyk7Ci0KLQkJUE0zX1dSSVRFX1JFRyhQ
TTNSZWN0YW5nbGVQb3NpdGlvbiwKLQkJCSAgICAgIChQTTNSZWN0YW5nbGVQb3NpdGlvbl9YT2Zm
c2V0KHN4KSkgfAotCQkJICAgICAgKFBNM1JlY3RhbmdsZVBvc2l0aW9uX1lPZmZzZXQoc3kpKSk7
Ci0KLQkJUE0zX1dSSVRFX1JFRyhQTTNSZW5kZXIyRCwKLQkJCSAgICAgIFBNM1JlbmRlcjJEX1hQ
b3NpdGl2ZSB8Ci0JCQkgICAgICBQTTNSZW5kZXIyRF9ZUG9zaXRpdmUgfAotCQkJICAgICAgUE0z
UmVuZGVyMkRfT3BlcmF0aW9uX05vcm1hbCB8Ci0JCQkgICAgICBQTTNSZW5kZXIyRF9TcGFuT3Bl
cmF0aW9uIHwKLQkJCSAgICAgIChQTTNSZW5kZXIyRF9XaWR0aCh3aWR0aCkpIHwKLQkJCSAgICAg
IChQTTNSZW5kZXIyRF9IZWlnaHQoaGVpZ2h0KSkpOwotCX0gZWxzZSB7Ci0JCVBNM19XQUlUKDgp
OwotCi0JCVBNM19XUklURV9SRUcoUE0zRkJCbG9ja0NvbG9yLCBjKTsKLQotCQlQTTNfV1JJVEVf
UkVHKFBNM1BpeGVsU2l6ZSwgUE0zUGl4ZWxTaXplX0dMT0JBTF8xNkJJVCk7Ci0KLQkJUE0zX1dS
SVRFX1JFRyhQTTNGQldyaXRlQnVmZmVyV2lkdGgwLAotCQkJICAgICAgUE0zRkJXcml0ZUJ1ZmZl
cldpZHRoX1dpZHRoKGxfZmJfaW5mby0+Ci0JCQkJCQkJICBjdXJyZW50X3Bhci0+Ci0JCQkJCQkJ
ICB3aWR0aCA8PCAxKSk7Ci0KLQkJUE0zX1dSSVRFX1JFRyhQTTNDb25maWcyRCwKLQkJCQkJICBQ
TTNDb25maWcyRF9Vc2VDb25zdGFudFNvdXJjZSB8Ci0JCQkJCSAgUE0zQ29uZmlnMkRfRm9yZWdy
b3VuZFJPUEVuYWJsZSB8Ci0JCQkJCSAgKFBNM0NvbmZpZzJEX0ZvcmVncm91bmRST1AoMHgzKSkg
fAkvKiBPeDMgaXMgR1hjb3B5ICovCi0JCQkJCSAgUE0zQ29uZmlnMkRfRkJXcml0ZUVuYWJsZSk7
Ci0KLQkJUE0zX1dSSVRFX1JFRyhQTTNSZWN0YW5nbGVQb3NpdGlvbiwKLQkJCSAgICAgIChQTTNS
ZWN0YW5nbGVQb3NpdGlvbl9YT2Zmc2V0KHN4IDw8IDEpKSB8Ci0JCQkgICAgICAoUE0zUmVjdGFu
Z2xlUG9zaXRpb25fWU9mZnNldChzeSkpKTsKLQotCQlQTTNfV1JJVEVfUkVHKFBNM1JlbmRlcjJE
LAotCQkJICAgICAgUE0zUmVuZGVyMkRfWFBvc2l0aXZlIHwKLQkJCSAgICAgIFBNM1JlbmRlcjJE
X1lQb3NpdGl2ZSB8Ci0JCQkgICAgICBQTTNSZW5kZXIyRF9PcGVyYXRpb25fTm9ybWFsIHwKLQkJ
CSAgICAgIChQTTNSZW5kZXIyRF9XaWR0aCh3aWR0aCA8PCAxKSkgfAotCQkJICAgICAgKFBNM1Jl
bmRlcjJEX0hlaWdodChoZWlnaHQpKSk7Ci0KLQkJUE0zX1dSSVRFX1JFRyhQTTNGQldyaXRlQnVm
ZmVyV2lkdGgwLAotCQkJICAgICAgUE0zRkJXcml0ZUJ1ZmZlcldpZHRoX1dpZHRoKGxfZmJfaW5m
by0+Ci0JCQkJCQkJICBjdXJyZW50X3Bhci0+Ci0JCQkJCQkJICB3aWR0aCkpOwotCi0JCVBNM19X
UklURV9SRUcoUE0zUGl4ZWxTaXplLCBQTTNQaXhlbFNpemVfR0xPQkFMXzMyQklUKTsKLQl9Ci0K
LQlwbTNmYl93YWl0X3BtMyhsX2ZiX2luZm8pOwotfQotCi1zdGF0aWMgdm9pZCBwbTNmYl9jZmIz
Ml9jbGVhcl9tYXJnaW5zKHN0cnVjdCB2Y19kYXRhICpjb25wLAotCQkJCSAgICAgIHN0cnVjdCBk
aXNwbGF5ICpwLCBpbnQgYm90dG9tX29ubHkpCi17Ci0Jc3RydWN0IHBtM2ZiX2luZm8gKmxfZmJf
aW5mbyA9IChzdHJ1Y3QgcG0zZmJfaW5mbyAqKSBwLT5mYl9pbmZvOwotCWludCBzeCwgc3k7Ci0J
dTMyIGM7Ci0KLQlEVFJBQ0U7Ci0KLQlzeCA9IGNvbnAtPnZjX2NvbHMgKiBmb250d2lkdGgocCk7
CS8qIHJpZ2h0IG1hcmdpbiAqLwotCXN5ID0gY29ucC0+dmNfcm93cyAqIGZvbnRoZWlnaHQocCk7
CS8qIGJvdHRvbSBtYXJnaW4gKi8KLQljID0gKCh1MzIgKikgcC0+ZGlzcHN3X2RhdGEpW2F0dHJf
Ymdjb2xfZWMocCwgY29ucCldOwotCi0JaWYgKCFib3R0b21fb25seSkgewkvKiByaWdodCBtYXJn
aW4gdG9wLT5ib3R0b20gKi8KLQkJUE0zX1dBSVQoNCk7Ci0KLQkJUE0zX1dSSVRFX1JFRyhQTTND
b25maWcyRCwKLQkJCQkJICBQTTNDb25maWcyRF9Vc2VDb25zdGFudFNvdXJjZSB8Ci0JCQkJCSAg
UE0zQ29uZmlnMkRfRm9yZWdyb3VuZFJPUEVuYWJsZSB8Ci0JCQkJCSAgKFBNM0NvbmZpZzJEX0Zv
cmVncm91bmRST1AoMHgzKSkgfAkvKiBPeDMgaXMgR1hjb3B5ICovCi0JCQkJCSAgUE0zQ29uZmln
MkRfRkJXcml0ZUVuYWJsZSk7Ci0KLQkJUE0zX1dSSVRFX1JFRyhQTTNGb3JlZ3JvdW5kQ29sb3Is
IGMpOwotCi0JCVBNM19XUklURV9SRUcoUE0zUmVjdGFuZ2xlUG9zaXRpb24sCi0JCQkgICAgICAo
UE0zUmVjdGFuZ2xlUG9zaXRpb25fWE9mZnNldAotCQkJICAgICAgIChwLT52YXIueG9mZnNldCAr
Ci0JCQkJc3gpKSB8IChQTTNSZWN0YW5nbGVQb3NpdGlvbl9ZT2Zmc2V0KHAtPgotCQkJCQkJCQkg
ICAgIHZhci4KLQkJCQkJCQkJICAgICB5b2Zmc2V0KSkpOwotCi0JCVBNM19XUklURV9SRUcoUE0z
UmVuZGVyMkQsCi0JCQkgICAgICBQTTNSZW5kZXIyRF9YUG9zaXRpdmUgfAotCQkJICAgICAgUE0z
UmVuZGVyMkRfWVBvc2l0aXZlIHwKLQkJCSAgICAgIFBNM1JlbmRlcjJEX09wZXJhdGlvbl9Ob3Jt
YWwgfAotCQkJICAgICAgUE0zUmVuZGVyMkRfU3Bhbk9wZXJhdGlvbiB8Ci0JCQkgICAgICAoUE0z
UmVuZGVyMkRfV2lkdGgocC0+dmFyLnhyZXMgLSBzeCkpIHwKLQkJCSAgICAgIChQTTNSZW5kZXIy
RF9IZWlnaHQocC0+dmFyLnlyZXMpKSk7Ci0JfQotCi0JLyogYm90dG9tIG1hcmdpbiBsZWZ0IC0+
IHJpZ2h0ICovCi0JUE0zX1dBSVQoNCk7Ci0KLQlQTTNfV1JJVEVfUkVHKFBNM0NvbmZpZzJELAot
CQkJCSAgUE0zQ29uZmlnMkRfVXNlQ29uc3RhbnRTb3VyY2UgfAotCQkJCSAgUE0zQ29uZmlnMkRf
Rm9yZWdyb3VuZFJPUEVuYWJsZSB8Ci0JCQkJICAoUE0zQ29uZmlnMkRfRm9yZWdyb3VuZFJPUCgw
eDMpKSB8CS8qIE94MyBpcyBHWGNvcHkgKi8KLQkJCQkgIFBNM0NvbmZpZzJEX0ZCV3JpdGVFbmFi
bGUpOwotCi0JUE0zX1dSSVRFX1JFRyhQTTNGb3JlZ3JvdW5kQ29sb3IsIGMpOwotCi0JUE0zX1dS
SVRFX1JFRyhQTTNSZWN0YW5nbGVQb3NpdGlvbiwKLQkJICAgICAgKFBNM1JlY3RhbmdsZVBvc2l0
aW9uX1hPZmZzZXQocC0+dmFyLnhvZmZzZXQpKSB8Ci0JCSAgICAgIChQTTNSZWN0YW5nbGVQb3Np
dGlvbl9ZT2Zmc2V0KHAtPnZhci55b2Zmc2V0ICsgc3kpKSk7Ci0KLQlQTTNfV1JJVEVfUkVHKFBN
M1JlbmRlcjJELAotCQkgICAgICBQTTNSZW5kZXIyRF9YUG9zaXRpdmUgfAotCQkgICAgICBQTTNS
ZW5kZXIyRF9ZUG9zaXRpdmUgfAotCQkgICAgICBQTTNSZW5kZXIyRF9PcGVyYXRpb25fTm9ybWFs
IHwKLQkJICAgICAgUE0zUmVuZGVyMkRfU3Bhbk9wZXJhdGlvbiB8Ci0JCSAgICAgIChQTTNSZW5k
ZXIyRF9XaWR0aChwLT52YXIueHJlcykpIHwKLQkJICAgICAgKFBNM1JlbmRlcjJEX0hlaWdodChw
LT52YXIueXJlcyAtIHN5KSkpOwotCi0JcG0zZmJfd2FpdF9wbTMobF9mYl9pbmZvKTsKLX0KLSNl
bmRpZiAvKiBGQkNPTl9IQVNfQ0ZCMzIgKi8KLSNpZmRlZiBGQkNPTl9IQVNfQ0ZCMTYKLXN0YXRp
YyB2b2lkIHBtM2ZiX2NmYjE2X2NsZWFyKHN0cnVjdCB2Y19kYXRhICpjb25wLAotCQkJICAgICAg
c3RydWN0IGRpc3BsYXkgKnAsCi0JCQkgICAgICBpbnQgc3ksIGludCBzeCwgaW50IGhlaWdodCwg
aW50IHdpZHRoKQotewotCXN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8gPSAoc3RydWN0IHBt
M2ZiX2luZm8gKikgcC0+ZmJfaW5mbzsKLQl1MzIgYzsKLQotCURUUkFDRTsKLQotCXN4ID0gc3gg
KiBmb250d2lkdGgocCk7Ci0Jd2lkdGggPSB3aWR0aCAqIGZvbnR3aWR0aChwKTsKLQlzeSA9IHN5
ICogZm9udGhlaWdodChwKTsKLQloZWlnaHQgPSBoZWlnaHQgKiBmb250aGVpZ2h0KHApOwotCWMg
PSAoKHUxNiAqKSBwLT5kaXNwc3dfZGF0YSlbYXR0cl9iZ2NvbF9lYyhwLCBjb25wKV07Ci0JYyA9
IGMgfCAoYyA8PCAxNik7Ci0KLQlQTTNfV0FJVCg0KTsKLQotCWlmIChsX2ZiX2luZm8tPm1lbXQu
Y2FwcyAmIFBNM0xvY2FsTWVtQ2Fwc19Ob1dyaXRlTWFzaykKLQkJUE0zX1dSSVRFX1JFRyhQTTNG
b3JlZ3JvdW5kQ29sb3IsIGMpOwotCWVsc2UKLQkJUE0zX1dSSVRFX1JFRyhQTTNGQkJsb2NrQ29s
b3IsIGMpOwotCi0JUE0zX1dSSVRFX1JFRyhQTTNDb25maWcyRCwKLQkJCQkgIFBNM0NvbmZpZzJE
X1VzZUNvbnN0YW50U291cmNlIHwKLQkJCQkgIFBNM0NvbmZpZzJEX0ZvcmVncm91bmRST1BFbmFi
bGUgfAotCQkJCSAgKFBNM0NvbmZpZzJEX0ZvcmVncm91bmRST1AoMHgzKSkgfAkvKiBPeDMgaXMg
R1hjb3B5ICovCi0JCQkJICBQTTNDb25maWcyRF9GQldyaXRlRW5hYmxlKTsKLQotCVBNM19XUklU
RV9SRUcoUE0zUmVjdGFuZ2xlUG9zaXRpb24sCi0JCSAgICAgIChQTTNSZWN0YW5nbGVQb3NpdGlv
bl9YT2Zmc2V0KHN4KSkgfAotCQkgICAgICAoUE0zUmVjdGFuZ2xlUG9zaXRpb25fWU9mZnNldChz
eSkpKTsKLQkKLQlpZiAobF9mYl9pbmZvLT5tZW10LmNhcHMgJiBQTTNMb2NhbE1lbUNhcHNfTm9X
cml0ZU1hc2spCi0JCVBNM19XUklURV9SRUcoUE0zUmVuZGVyMkQsCi0JCQkgICAgICBQTTNSZW5k
ZXIyRF9YUG9zaXRpdmUgfAotCQkJICAgICAgUE0zUmVuZGVyMkRfWVBvc2l0aXZlIHwKLQkJCSAg
ICAgIFBNM1JlbmRlcjJEX09wZXJhdGlvbl9Ob3JtYWwgfAotCQkJICAgICAgUE0zUmVuZGVyMkRf
U3Bhbk9wZXJhdGlvbiB8Ci0JCQkgICAgICAoUE0zUmVuZGVyMkRfV2lkdGgod2lkdGgpKSB8Ci0J
CQkgICAgICAoUE0zUmVuZGVyMkRfSGVpZ2h0KGhlaWdodCkpKTsKLQllbHNlCi0JCVBNM19XUklU
RV9SRUcoUE0zUmVuZGVyMkQsCi0JCQkgICAgICBQTTNSZW5kZXIyRF9YUG9zaXRpdmUgfAotCQkJ
ICAgICAgUE0zUmVuZGVyMkRfWVBvc2l0aXZlIHwKLQkJCSAgICAgIFBNM1JlbmRlcjJEX09wZXJh
dGlvbl9Ob3JtYWwgfAotCQkJICAgICAgKFBNM1JlbmRlcjJEX1dpZHRoKHdpZHRoKSkgfAotCQkJ
ICAgICAgKFBNM1JlbmRlcjJEX0hlaWdodChoZWlnaHQpKSk7Ci0JCi0JcG0zZmJfd2FpdF9wbTMo
bF9mYl9pbmZvKTsKLX0KLQotc3RhdGljIHZvaWQgcG0zZmJfY2ZiMTZfY2xlYXJfbWFyZ2lucyhz
dHJ1Y3QgdmNfZGF0YSAqY29ucCwKLQkJCQkgICAgICBzdHJ1Y3QgZGlzcGxheSAqcCwgaW50IGJv
dHRvbV9vbmx5KQotewotCXN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8gPSAoc3RydWN0IHBt
M2ZiX2luZm8gKikgcC0+ZmJfaW5mbzsKLQlpbnQgc3gsIHN5OwotCXUzMiBjOwotCi0JRFRSQUNF
OwotCi0Jc3ggPSBjb25wLT52Y19jb2xzICogZm9udHdpZHRoKHApOwkvKiByaWdodCBtYXJnaW4g
Ki8KLQlzeSA9IGNvbnAtPnZjX3Jvd3MgKiBmb250aGVpZ2h0KHApOwkvKiBib3R0b20gbWFyZ2lu
ICovCi0JYyA9ICgodTE2ICopIHAtPmRpc3Bzd19kYXRhKVthdHRyX2JnY29sX2VjKHAsIGNvbnAp
XTsKLQljID0gYyB8IChjIDw8IDE2KTsKLQotCWlmICghYm90dG9tX29ubHkpIHsJLyogcmlnaHQg
bWFyZ2luIHRvcC0+Ym90dG9tICovCi0JCVBNM19XQUlUKDQpOwotCi0JCVBNM19XUklURV9SRUco
UE0zQ29uZmlnMkQsCi0JCQkJCSAgUE0zQ29uZmlnMkRfVXNlQ29uc3RhbnRTb3VyY2UgfAotCQkJ
CQkgIFBNM0NvbmZpZzJEX0ZvcmVncm91bmRST1BFbmFibGUgfAotCQkJCQkgIChQTTNDb25maWcy
RF9Gb3JlZ3JvdW5kUk9QKDB4MykpIHwJLyogT3gzIGlzIEdYY29weSAqLwotCQkJCQkgIFBNM0Nv
bmZpZzJEX0ZCV3JpdGVFbmFibGUpOwotCQkKLQkJaWYgKGxfZmJfaW5mby0+bWVtdC5jYXBzICYg
UE0zTG9jYWxNZW1DYXBzX05vV3JpdGVNYXNrKQotCQkJUE0zX1dSSVRFX1JFRyhQTTNGb3JlZ3Jv
dW5kQ29sb3IsIGMpOwotCQllbHNlCi0JCQlQTTNfV1JJVEVfUkVHKFBNM0ZCQmxvY2tDb2xvciwg
Yyk7Ci0JCQotCQlQTTNfV1JJVEVfUkVHKFBNM1JlY3RhbmdsZVBvc2l0aW9uLAotCQkJICAgICAg
KFBNM1JlY3RhbmdsZVBvc2l0aW9uX1hPZmZzZXQKLQkJCSAgICAgICAocC0+dmFyLnhvZmZzZXQg
KwotCQkJCXN4KSkgfCAoUE0zUmVjdGFuZ2xlUG9zaXRpb25fWU9mZnNldChwLT4KLQkJCQkJCQkJ
ICAgICB2YXIuCi0JCQkJCQkJCSAgICAgeW9mZnNldCkpKTsKLQkJaWYgKGxfZmJfaW5mby0+bWVt
dC5jYXBzICYgUE0zTG9jYWxNZW1DYXBzX05vV3JpdGVNYXNrKQotCQkJUE0zX1dSSVRFX1JFRyhQ
TTNSZW5kZXIyRCwKLQkJCQkgICAgICBQTTNSZW5kZXIyRF9YUG9zaXRpdmUgfAotCQkJCSAgICAg
IFBNM1JlbmRlcjJEX1lQb3NpdGl2ZSB8Ci0JCQkJICAgICAgUE0zUmVuZGVyMkRfT3BlcmF0aW9u
X05vcm1hbCB8Ci0JCQkJICAgICAgUE0zUmVuZGVyMkRfU3Bhbk9wZXJhdGlvbiB8Ci0JCQkJICAg
ICAgKFBNM1JlbmRlcjJEX1dpZHRoKHAtPnZhci54cmVzIC0gc3gpKSB8Ci0JCQkJICAgICAgKFBN
M1JlbmRlcjJEX0hlaWdodChwLT52YXIueXJlcykpKTsKLQkJZWxzZQotCQkJUE0zX1dSSVRFX1JF
RyhQTTNSZW5kZXIyRCwKLQkJCQkgICAgICBQTTNSZW5kZXIyRF9YUG9zaXRpdmUgfAotCQkJCSAg
ICAgIFBNM1JlbmRlcjJEX1lQb3NpdGl2ZSB8Ci0JCQkJICAgICAgUE0zUmVuZGVyMkRfT3BlcmF0
aW9uX05vcm1hbCB8Ci0JCQkJICAgICAgKFBNM1JlbmRlcjJEX1dpZHRoKHAtPnZhci54cmVzIC0g
c3gpKSB8Ci0JCQkJICAgICAgKFBNM1JlbmRlcjJEX0hlaWdodChwLT52YXIueXJlcykpKTsKLQl9
Ci0JCi0JLyogYm90dG9tIG1hcmdpbiBsZWZ0IC0+IHJpZ2h0ICovCi0JUE0zX1dBSVQoNCk7Ci0J
Ci0JUE0zX1dSSVRFX1JFRyhQTTNDb25maWcyRCwKLQkJICAgICAgUE0zQ29uZmlnMkRfVXNlQ29u
c3RhbnRTb3VyY2UgfAotCQkgICAgICBQTTNDb25maWcyRF9Gb3JlZ3JvdW5kUk9QRW5hYmxlIHwK
LQkJICAgICAgKFBNM0NvbmZpZzJEX0ZvcmVncm91bmRST1AoMHgzKSkgfAkvKiBPeDMgaXMgR1hj
b3B5ICovCi0JCSAgICAgIFBNM0NvbmZpZzJEX0ZCV3JpdGVFbmFibGUpOwotCQotCWlmIChsX2Zi
X2luZm8tPm1lbXQuY2FwcyAmIFBNM0xvY2FsTWVtQ2Fwc19Ob1dyaXRlTWFzaykKLQkJUE0zX1dS
SVRFX1JFRyhQTTNGb3JlZ3JvdW5kQ29sb3IsIGMpOwotCWVsc2UKLQkJUE0zX1dSSVRFX1JFRyhQ
TTNGQkJsb2NrQ29sb3IsIGMpOwotCQotCQotCVBNM19XUklURV9SRUcoUE0zUmVjdGFuZ2xlUG9z
aXRpb24sCi0JCSAgICAgIChQTTNSZWN0YW5nbGVQb3NpdGlvbl9YT2Zmc2V0KHAtPnZhci54b2Zm
c2V0KSkgfAotCQkgICAgICAoUE0zUmVjdGFuZ2xlUG9zaXRpb25fWU9mZnNldChwLT52YXIueW9m
ZnNldCArIHN5KSkpOwotCQotCWlmIChsX2ZiX2luZm8tPm1lbXQuY2FwcyAmIFBNM0xvY2FsTWVt
Q2Fwc19Ob1dyaXRlTWFzaykKLQkJUE0zX1dSSVRFX1JFRyhQTTNSZW5kZXIyRCwKLQkJCSAgICAg
IFBNM1JlbmRlcjJEX1hQb3NpdGl2ZSB8Ci0JCQkgICAgICBQTTNSZW5kZXIyRF9ZUG9zaXRpdmUg
fAotCQkJICAgICAgUE0zUmVuZGVyMkRfT3BlcmF0aW9uX05vcm1hbCB8Ci0JCQkgICAgICBQTTNS
ZW5kZXIyRF9TcGFuT3BlcmF0aW9uIHwKLQkJCSAgICAgIChQTTNSZW5kZXIyRF9XaWR0aChwLT52
YXIueHJlcykpIHwKLQkJCSAgICAgIChQTTNSZW5kZXIyRF9IZWlnaHQocC0+dmFyLnlyZXMgLSBz
eSkpKTsKLQllbHNlCi0JCVBNM19XUklURV9SRUcoUE0zUmVuZGVyMkQsCi0JCQkgICAgICBQTTNS
ZW5kZXIyRF9YUG9zaXRpdmUgfAotCQkJICAgICAgUE0zUmVuZGVyMkRfWVBvc2l0aXZlIHwKLQkJ
CSAgICAgIFBNM1JlbmRlcjJEX09wZXJhdGlvbl9Ob3JtYWwgfAotCQkJICAgICAgKFBNM1JlbmRl
cjJEX1dpZHRoKHAtPnZhci54cmVzKSkgfAotCQkJICAgICAgKFBNM1JlbmRlcjJEX0hlaWdodChw
LT52YXIueXJlcyAtIHN5KSkpOwotCi0JcG0zZmJfd2FpdF9wbTMobF9mYl9pbmZvKTsKLX0KLSNl
bmRpZiAvKiBGQkNPTl9IQVNfQ0ZCMTYgKi8KLSNpZmRlZiBGQkNPTl9IQVNfQ0ZCOAotc3RhdGlj
IHZvaWQgcG0zZmJfY2ZiOF9jbGVhcihzdHJ1Y3QgdmNfZGF0YSAqY29ucCwKLQkJCSAgICAgc3Ry
dWN0IGRpc3BsYXkgKnAsCi0JCQkgICAgIGludCBzeSwgaW50IHN4LCBpbnQgaGVpZ2h0LCBpbnQg
d2lkdGgpCi17Ci0Jc3RydWN0IHBtM2ZiX2luZm8gKmxfZmJfaW5mbyA9IChzdHJ1Y3QgcG0zZmJf
aW5mbyAqKSBwLT5mYl9pbmZvOwotCXUzMiBjOwotCi0JRFRSQUNFOwotCi0Jc3ggPSBzeCAqIGZv
bnR3aWR0aChwKTsKLQl3aWR0aCA9IHdpZHRoICogZm9udHdpZHRoKHApOwotCXN5ID0gc3kgKiBm
b250aGVpZ2h0KHApOwotCWhlaWdodCA9IGhlaWdodCAqIGZvbnRoZWlnaHQocCk7Ci0KLQljID0g
YXR0cl9iZ2NvbF9lYyhwLCBjb25wKTsKLQljIHw9IGMgPDwgODsKLQljIHw9IGMgPDwgMTY7Ci0K
LQlQTTNfV0FJVCg0KTsKLQotCVBNM19XUklURV9SRUcoUE0zQ29uZmlnMkQsCi0JCQkJICBQTTND
b25maWcyRF9Vc2VDb25zdGFudFNvdXJjZSB8Ci0JCQkJICBQTTNDb25maWcyRF9Gb3JlZ3JvdW5k
Uk9QRW5hYmxlIHwKLQkJCQkgIChQTTNDb25maWcyRF9Gb3JlZ3JvdW5kUk9QKDB4MykpIHwJLyog
T3gzIGlzIEdYY29weSAqLwotCQkJCSAgUE0zQ29uZmlnMkRfRkJXcml0ZUVuYWJsZSk7Ci0KLQlQ
TTNfV1JJVEVfUkVHKFBNM0ZvcmVncm91bmRDb2xvciwgYyk7Ci0KLQlQTTNfV1JJVEVfUkVHKFBN
M1JlY3RhbmdsZVBvc2l0aW9uLAotCQkgICAgICAoUE0zUmVjdGFuZ2xlUG9zaXRpb25fWE9mZnNl
dChzeCkpIHwKLQkJICAgICAgKFBNM1JlY3RhbmdsZVBvc2l0aW9uX1lPZmZzZXQoc3kpKSk7Ci0K
LQlQTTNfV1JJVEVfUkVHKFBNM1JlbmRlcjJELAotCQkgICAgICBQTTNSZW5kZXIyRF9YUG9zaXRp
dmUgfAotCQkgICAgICBQTTNSZW5kZXIyRF9ZUG9zaXRpdmUgfAotCQkgICAgICBQTTNSZW5kZXIy
RF9PcGVyYXRpb25fTm9ybWFsIHwKLQkJICAgICAgUE0zUmVuZGVyMkRfU3Bhbk9wZXJhdGlvbiB8
Ci0JCSAgICAgIChQTTNSZW5kZXIyRF9XaWR0aCh3aWR0aCkpIHwKLQkJICAgICAgKFBNM1JlbmRl
cjJEX0hlaWdodChoZWlnaHQpKSk7Ci0KLQlwbTNmYl93YWl0X3BtMyhsX2ZiX2luZm8pOwotfQot
Ci1zdGF0aWMgdm9pZCBwbTNmYl9jZmI4X2NsZWFyX21hcmdpbnMoc3RydWN0IHZjX2RhdGEgKmNv
bnAsCi0JCQkJICAgICBzdHJ1Y3QgZGlzcGxheSAqcCwgaW50IGJvdHRvbV9vbmx5KQotewotCXN0
cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8gPSAoc3RydWN0IHBtM2ZiX2luZm8gKikgcC0+ZmJf
aW5mbzsKLQlpbnQgc3gsIHN5OwotCXUzMiBjOwotCi0JRFRSQUNFOwotCi0Jc3ggPSBjb25wLT52
Y19jb2xzICogZm9udHdpZHRoKHApOwkvKiByaWdodCBtYXJnaW4gKi8KLQlzeSA9IGNvbnAtPnZj
X3Jvd3MgKiBmb250aGVpZ2h0KHApOwkvKiBib3R0b20gbWFyZ2luICovCi0JYyA9IGF0dHJfYmdj
b2xfZWMocCwgY29ucCk7Ci0JYyB8PSBjIDw8IDg7Ci0JYyB8PSBjIDw8IDE2OwotCi0JaWYgKCFi
b3R0b21fb25seSkgewkvKiByaWdodCBtYXJnaW4gdG9wLT5ib3R0b20gKi8KLQkJUE0zX1dBSVQo
NCk7Ci0KLQkJUE0zX1dSSVRFX1JFRyhQTTNDb25maWcyRCwKLQkJCQkJICBQTTNDb25maWcyRF9V
c2VDb25zdGFudFNvdXJjZSB8Ci0JCQkJCSAgUE0zQ29uZmlnMkRfRm9yZWdyb3VuZFJPUEVuYWJs
ZSB8Ci0JCQkJCSAgKFBNM0NvbmZpZzJEX0ZvcmVncm91bmRST1AoMHgzKSkgfAkvKiBPeDMgaXMg
R1hjb3B5ICovCi0JCQkJCSAgUE0zQ29uZmlnMkRfRkJXcml0ZUVuYWJsZSk7Ci0KLQkJUE0zX1dS
SVRFX1JFRyhQTTNGb3JlZ3JvdW5kQ29sb3IsIGMpOwotCi0JCVBNM19XUklURV9SRUcoUE0zUmVj
dGFuZ2xlUG9zaXRpb24sCi0JCQkgICAgICAoUE0zUmVjdGFuZ2xlUG9zaXRpb25fWE9mZnNldAot
CQkJICAgICAgIChwLT52YXIueG9mZnNldCArCi0JCQkJc3gpKSB8IChQTTNSZWN0YW5nbGVQb3Np
dGlvbl9ZT2Zmc2V0KHAtPgotCQkJCQkJCQkgICAgIHZhci4KLQkJCQkJCQkJICAgICB5b2Zmc2V0
KSkpOwotCi0JCVBNM19XUklURV9SRUcoUE0zUmVuZGVyMkQsCi0JCQkgICAgICBQTTNSZW5kZXIy
RF9YUG9zaXRpdmUgfAotCQkJICAgICAgUE0zUmVuZGVyMkRfWVBvc2l0aXZlIHwKLQkJCSAgICAg
IFBNM1JlbmRlcjJEX09wZXJhdGlvbl9Ob3JtYWwgfAotCQkJICAgICAgUE0zUmVuZGVyMkRfU3Bh
bk9wZXJhdGlvbiB8Ci0JCQkgICAgICAoUE0zUmVuZGVyMkRfV2lkdGgocC0+dmFyLnhyZXMgLSBz
eCkpIHwKLQkJCSAgICAgIChQTTNSZW5kZXIyRF9IZWlnaHQocC0+dmFyLnlyZXMpKSk7Ci0JfQot
Ci0JLyogYm90dG9tIG1hcmdpbiBsZWZ0IC0+IHJpZ2h0ICovCi0JUE0zX1dBSVQoNCk7Ci0KLQlQ
TTNfV1JJVEVfUkVHKFBNM0NvbmZpZzJELAotCQkJCSAgUE0zQ29uZmlnMkRfVXNlQ29uc3RhbnRT
b3VyY2UgfAotCQkJCSAgUE0zQ29uZmlnMkRfRm9yZWdyb3VuZFJPUEVuYWJsZSB8Ci0JCQkJICAo
UE0zQ29uZmlnMkRfRm9yZWdyb3VuZFJPUCgweDMpKSB8CS8qIE94MyBpcyBHWGNvcHkgKi8KLQkJ
CQkgIFBNM0NvbmZpZzJEX0ZCV3JpdGVFbmFibGUpOwotCi0JUE0zX1dSSVRFX1JFRyhQTTNGb3Jl
Z3JvdW5kQ29sb3IsIGMpOwotCi0JUE0zX1dSSVRFX1JFRyhQTTNSZWN0YW5nbGVQb3NpdGlvbiwK
LQkJICAgICAgKFBNM1JlY3RhbmdsZVBvc2l0aW9uX1hPZmZzZXQocC0+dmFyLnhvZmZzZXQpKSB8
Ci0JCSAgICAgIChQTTNSZWN0YW5nbGVQb3NpdGlvbl9ZT2Zmc2V0KHAtPnZhci55b2Zmc2V0ICsg
c3kpKSk7Ci0KLQlQTTNfV1JJVEVfUkVHKFBNM1JlbmRlcjJELAotCQkgICAgICBQTTNSZW5kZXIy
RF9YUG9zaXRpdmUgfAotCQkgICAgICBQTTNSZW5kZXIyRF9ZUG9zaXRpdmUgfAotCQkgICAgICBQ
TTNSZW5kZXIyRF9PcGVyYXRpb25fTm9ybWFsIHwKLQkJICAgICAgUE0zUmVuZGVyMkRfU3Bhbk9w
ZXJhdGlvbiB8Ci0JCSAgICAgIChQTTNSZW5kZXIyRF9XaWR0aChwLT52YXIueHJlcykpIHwKLQkJ
ICAgICAgKFBNM1JlbmRlcjJEX0hlaWdodChwLT52YXIueXJlcyAtIHN5KSkpOwotCi0JcG0zZmJf
d2FpdF9wbTMobF9mYl9pbmZvKTsKLX0KLSNlbmRpZiAvKiBGQkNPTl9IQVNfQ0ZCOCAqLwotI2lm
IGRlZmluZWQoRkJDT05fSEFTX0NGQjgpIHx8IGRlZmluZWQoRkJDT05fSEFTX0NGQjE2KSB8fCBk
ZWZpbmVkKEZCQ09OX0hBU19DRkIzMikKLXN0YXRpYyB2b2lkIHBtM2ZiX2NmYlhfYm1vdmUoc3Ry
dWN0IGRpc3BsYXkgKnAsCi0JCQkgICAgIGludCBzeSwgaW50IHN4LAotCQkJICAgICBpbnQgZHks
IGludCBkeCwgaW50IGhlaWdodCwgaW50IHdpZHRoKQotewotCXN0cnVjdCBwbTNmYl9pbmZvICps
X2ZiX2luZm8gPSAoc3RydWN0IHBtM2ZiX2luZm8gKikgcC0+ZmJfaW5mbzsKLQlpbnQgeF9hbGln
biwgb194LCBvX3k7Ci0KLQlEVFJBQ0U7Ci0KLQlzeCA9IHN4ICogZm9udHdpZHRoKHApOwotCWR4
ID0gZHggKiBmb250d2lkdGgocCk7Ci0Jd2lkdGggPSB3aWR0aCAqIGZvbnR3aWR0aChwKTsKLQlz
eSA9IHN5ICogZm9udGhlaWdodChwKTsKLQlkeSA9IGR5ICogZm9udGhlaWdodChwKTsKLQloZWln
aHQgPSBoZWlnaHQgKiBmb250aGVpZ2h0KHApOwotCi0Jb194ID0gc3ggLSBkeDsJCS8qKHN4ID4g
ZHggKSA/IChzeCAtIGR4KSA6IChkeCAtIHN4KTsgKi8KLQlvX3kgPSBzeSAtIGR5OwkJLyooc3kg
PiBkeSApID8gKHN5IC0gZHkpIDogKGR5IC0gc3kpOyAqLwotCi0JeF9hbGlnbiA9IChzeCAmIDB4
MWYpOwotCi0JUE0zX1dBSVQoNik7Ci0KLQlQTTNfV1JJVEVfUkVHKFBNM0NvbmZpZzJELAotCQkJ
CSAgUE0zQ29uZmlnMkRfVXNlclNjaXNzb3JFbmFibGUgfAotCQkJCSAgUE0zQ29uZmlnMkRfRm9y
ZWdyb3VuZFJPUEVuYWJsZSB8Ci0JCQkJICBQTTNDb25maWcyRF9CbG9ja2luZyB8Ci0JCQkJICAo
UE0zQ29uZmlnMkRfRm9yZWdyb3VuZFJPUCgweDMpKSB8CS8qIE94MyBpcyBHWGNvcHkgKi8KLQkJ
CQkgIFBNM0NvbmZpZzJEX0ZCV3JpdGVFbmFibGUpOwotCi0JUE0zX1dSSVRFX1JFRyhQTTNTY2lz
c29yTWluWFksCi0JCSAgICAgICgoZHkgJiAweDBmZmYpIDw8IDE2KSB8IChkeCAmIDB4MGZmZikp
OwotCVBNM19XUklURV9SRUcoUE0zU2Npc3Nvck1heFhZLAotCQkJCSAgKCgoZHkgKyBoZWlnaHQp
ICYgMHgwZmZmKSA8PCAxNikgfAotCQkJCSAgKChkeCArIHdpZHRoKSAmIDB4MGZmZikpOwotCi0J
UE0zX1dSSVRFX1JFRyhQTTNGQlNvdXJjZVJlYWRCdWZmZXJPZmZzZXQsCi0JCSAgICAgIFBNM0ZC
U291cmNlUmVhZEJ1ZmZlck9mZnNldF9YT2Zmc2V0KG9feCkgfAotCQkgICAgICBQTTNGQlNvdXJj
ZVJlYWRCdWZmZXJPZmZzZXRfWU9mZnNldChvX3kpKTsKLQotCVBNM19XUklURV9SRUcoUE0zUmVj
dGFuZ2xlUG9zaXRpb24sCi0JCSAgICAgIChQTTNSZWN0YW5nbGVQb3NpdGlvbl9YT2Zmc2V0KGR4
IC0geF9hbGlnbikpIHwKLQkJICAgICAgKFBNM1JlY3RhbmdsZVBvc2l0aW9uX1lPZmZzZXQoZHkp
KSk7Ci0KLQlQTTNfV1JJVEVfUkVHKFBNM1JlbmRlcjJELAotCQkgICAgICAoKHN4ID4gZHgpID8g
UE0zUmVuZGVyMkRfWFBvc2l0aXZlIDogMCkgfAotCQkgICAgICAoKHN5ID4gZHkpID8gUE0zUmVu
ZGVyMkRfWVBvc2l0aXZlIDogMCkgfAotCQkgICAgICBQTTNSZW5kZXIyRF9PcGVyYXRpb25fTm9y
bWFsIHwKLQkJICAgICAgUE0zUmVuZGVyMkRfU3Bhbk9wZXJhdGlvbiB8Ci0JCSAgICAgIFBNM1Jl
bmRlcjJEX0ZCU291cmNlUmVhZEVuYWJsZSB8Ci0JCSAgICAgIChQTTNSZW5kZXIyRF9XaWR0aCh3
aWR0aCArIHhfYWxpZ24pKSB8Ci0JCSAgICAgIChQTTNSZW5kZXIyRF9IZWlnaHQoaGVpZ2h0KSkp
OwotCi0JcG0zZmJfd2FpdF9wbTMobF9mYl9pbmZvKTsKLX0KLQotc3RhdGljIHZvaWQgcG0zZmJf
Y2ZiWF9wdXRjKHN0cnVjdCB2Y19kYXRhICpjb25wLCBzdHJ1Y3QgZGlzcGxheSAqcCwKLQkJCSAg
ICBpbnQgYywgaW50IHl5LCBpbnQgeHgpCi17Ci0Jc3RydWN0IHBtM2ZiX2luZm8gKmxfZmJfaW5m
byA9IChzdHJ1Y3QgcG0zZmJfaW5mbyAqKSBwLT5mYl9pbmZvOwotCXU4ICpjZGF0LCBhc3ggPSAw
LCBhc3kgPSAwLCBvX3ggPSAwLCBvX3kgPSAwOwotCXUzMiBmZ3gsIGJneCwgbGRhdDsKLQlpbnQg
c3gsIHN5LCBpOwotCi0JRFRSQUNFOwotCi0JaWYgKGxfZmJfaW5mby0+Y3VycmVudF9wYXItPmRl
cHRoID09IDgpCi0JCWZneCA9IGF0dHJfZmdjb2wocCwgYyk7Ci0JZWxzZSBpZiAoZGVwdGgyYnBw
KGxfZmJfaW5mby0+Y3VycmVudF9wYXItPmRlcHRoKSA9PSAxNikKLQkJZmd4ID0gKCh1MTYgKikg
cC0+ZGlzcHN3X2RhdGEpW2F0dHJfZmdjb2wocCwgYyldOwotCWVsc2UKLQkJZmd4ID0gKCh1MzIg
KikgcC0+ZGlzcHN3X2RhdGEpW2F0dHJfZmdjb2wocCwgYyldOwotCi0JUE0zX0NPTE9SKGZneCk7
Ci0KLQlpZiAobF9mYl9pbmZvLT5jdXJyZW50X3Bhci0+ZGVwdGggPT0gOCkKLQkJYmd4ID0gYXR0
cl9iZ2NvbChwLCBjKTsKLQllbHNlIGlmIChkZXB0aDJicHAobF9mYl9pbmZvLT5jdXJyZW50X3Bh
ci0+ZGVwdGgpID09IDE2KQotCQliZ3ggPSAoKHUxNiAqKSBwLT5kaXNwc3dfZGF0YSlbYXR0cl9i
Z2NvbChwLCBjKV07Ci0JZWxzZQotCQliZ3ggPSAoKHUzMiAqKSBwLT5kaXNwc3dfZGF0YSlbYXR0
cl9iZ2NvbChwLCBjKV07Ci0KLQlQTTNfQ09MT1IoYmd4KTsKLQotCVBNM19XQUlUKDQpOwotCi0J
UE0zX1dSSVRFX1JFRyhQTTNDb25maWcyRCwKLQkJCQkgIFBNM0NvbmZpZzJEX1VzZUNvbnN0YW50
U291cmNlIHwKLQkJCQkgIFBNM0NvbmZpZzJEX0ZvcmVncm91bmRST1BFbmFibGUgfAotCQkJCSAg
KFBNM0NvbmZpZzJEX0ZvcmVncm91bmRST1AoMHgzKSkgfAkvKiBPeDMgaXMgR1hjb3B5ICovCi0J
CQkJICBQTTNDb25maWcyRF9GQldyaXRlRW5hYmxlIHwgUE0zQ29uZmlnMkRfT3BhcXVlU3Bhbik7
Ci0KLQlQTTNfV1JJVEVfUkVHKFBNM0ZvcmVncm91bmRDb2xvciwgZmd4KTsKLQlQTTNfV1JJVEVf
UkVHKFBNM0ZpbGxCYWNrZ3JvdW5kQ29sb3IsIGJneCk7Ci0KLQkvKiBXQVJOSU5HIDogYWRkcmVz
cyBzZWxlY3QgWCBuZWVkIHRvIHNwZWNpZnkgOCBiaXRzIGZvciBmb250d2lkdGggPD0gOCAqLwot
CS8qIGFuZCAxNiBiaXRzIGZvciBmb250d2lkdGggPD0gMTYgKi8KLQkvKiBzYW1lIGluIF9wdXRj
cywgc2FtZSBmb3IgWSBhbmQgZm9udGhlaWdodCAqLwotCWlmIChmb250d2lkdGgocCkgPD0gOCkK
LQkJYXN4ID0gMjsKLQllbHNlIGlmIChmb250d2lkdGgocCkgPD0gMTYpCi0JCWFzeCA9IDM7CS8q
IGxvb2sgT0sgKi8KLQlpZiAoZm9udGhlaWdodChwKSA8PSA4KQotCQlhc3kgPSAyOwotCWVsc2Ug
aWYgKGZvbnRoZWlnaHQocCkgPD0gMTYpCi0JCWFzeSA9IDM7CS8qIGxvb2sgT0sgKi8KLQllbHNl
IGlmIChmb250aGVpZ2h0KHApIDw9IDMyKQotCQlhc3kgPSA0OwkvKiBsb29rIE9LICovCi0KLQlz
eCA9IHh4ICogZm9udHdpZHRoKHApOwotCXN5ID0geXkgKiBmb250aGVpZ2h0KHApOwotCi0JaWYg
KGZvbnR3aWR0aChwKSA8PSA4KQotCQlvX3ggPSAoOCAtIChzeCAmIDB4NykpICYgMHg3OwotCWVs
c2UgaWYgKGZvbnR3aWR0aChwKSA8PSAxNikKLQkJb194ID0gKDE2IC0gKHN4ICYgMHhGKSkgJiAw
eEY7Ci0JaWYgKGZvbnRoZWlnaHQocCkgPD0gOCkKLQkJb195ID0gKDggLSAoc3kgJiAweDcpKSAm
IDB4NzsKLQllbHNlIGlmIChmb250aGVpZ2h0KHApIDw9IDE2KQotCQlvX3kgPSAoMTYgLSAoc3kg
JiAweEYpKSAmIDB4RjsKLQllbHNlIGlmIChmb250aGVpZ2h0KHApIDw9IDMyKQotCQlvX3kgPSAo
MzIgLSAoc3kgJiAweDFGKSkgJiAweDFGOwotCi0JUE0zX1dSSVRFX1JFRyhQTTNBcmVhU3RpcHBs
ZU1vZGUsIChvX3ggPDwgNykgfCAob195IDw8IDEyKSB8CS8qIHhfb2Zmc2V0LCB5X29mZnNldCBp
biBwYXR0ZXJuICovCi0JCSAgICAgICgxIDw8IDE4KSB8CS8qIEJFICovCi0JCSAgICAgIDEgfCAo
YXN4IDw8IDEpIHwgKGFzeSA8PCA0KSB8CS8qIGFkZHJlc3Mgc2VsZWN0IHgveSAqLwotCQkgICAg
ICAoMSA8PCAyMCkpOwkvKiBPcGFxdWVTcGFuICovCi0KLQlpZiAoZm9udHdpZHRoKHApIDw9IDgp
IHsKLQkJY2RhdCA9IHAtPmZvbnRkYXRhICsgKGMgJiBwLT5jaGFybWFzaykgKiBmb250aGVpZ2h0
KHApOwotCX0gZWxzZSB7Ci0JCWNkYXQgPQotCQkgICAgcC0+Zm9udGRhdGEgKwotCQkgICAgKChj
ICYgcC0+Y2hhcm1hc2spICogKGZvbnRoZWlnaHQocCkgPDwgMSkpOwotCX0KLQotCVBNM19XQUlU
KDIgKyBmb250aGVpZ2h0KHApKTsKLQotCWZvciAoaSA9IDA7IGkgPCBmb250aGVpZ2h0KHApOyBp
KyspIHsJLyogYXNzdW1lIGZvbnRoZWlnaHQgPD0gMzIgKi8KLQkJaWYgKGZvbnR3aWR0aChwKSA8
PSA4KSB7Ci0JCQlsZGF0ID0gKmNkYXQrKzsKLQkJfSBlbHNlIHsJLyogYXNzdW1lIGZvbnR3aWR0
aCA8PSAxNiBBVE0gKi8KLQotCQkJbGRhdCA9ICgoKmNkYXQrKykgPDwgOCk7Ci0JCQlsZGF0IHw9
ICpjZGF0Kys7Ci0JCX0KLQkJUE0zX1dSSVRFX1JFRyhBcmVhU3RpcHBsZVBhdHRlcm5faW5kZXhl
ZChpKSwgbGRhdCk7Ci0JfQotCi0JUE0zX1dSSVRFX1JFRyhQTTNSZWN0YW5nbGVQb3NpdGlvbiwK
LQkJICAgICAgKFBNM1JlY3RhbmdsZVBvc2l0aW9uX1hPZmZzZXQoc3gpKSB8Ci0JCSAgICAgIChQ
TTNSZWN0YW5nbGVQb3NpdGlvbl9ZT2Zmc2V0KHN5KSkpOwotCi0JUE0zX1dSSVRFX1JFRyhQTTNS
ZW5kZXIyRCwKLQkJICAgICAgUE0zUmVuZGVyMkRfQXJlYVN0aXBwbGVFbmFibGUgfAotCQkgICAg
ICBQTTNSZW5kZXIyRF9YUG9zaXRpdmUgfAotCQkgICAgICBQTTNSZW5kZXIyRF9ZUG9zaXRpdmUg
fAotCQkgICAgICBQTTNSZW5kZXIyRF9PcGVyYXRpb25fTm9ybWFsIHwKLQkJICAgICAgUE0zUmVu
ZGVyMkRfU3Bhbk9wZXJhdGlvbiB8Ci0JCSAgICAgIChQTTNSZW5kZXIyRF9XaWR0aChmb250d2lk
dGgocCkpKSB8Ci0JCSAgICAgIChQTTNSZW5kZXIyRF9IZWlnaHQoZm9udGhlaWdodChwKSkpKTsK
LQotCXBtM2ZiX3dhaXRfcG0zKGxfZmJfaW5mbyk7Ci19Ci0KLXN0YXRpYyB2b2lkIHBtM2ZiX2Nm
YlhfcHV0Y3Moc3RydWN0IHZjX2RhdGEgKmNvbnAsIHN0cnVjdCBkaXNwbGF5ICpwLAotCQkJICAg
ICBjb25zdCB1bnNpZ25lZCBzaG9ydCAqcywgaW50IGNvdW50LCBpbnQgeXksCi0JCQkgICAgIGlu
dCB4eCkKLXsKLQlzdHJ1Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvID0gKHN0cnVjdCBwbTNmYl9p
bmZvICopIHAtPmZiX2luZm87Ci0JdTggKmNkYXQsIGFzeCA9IDAsIGFzeSA9IDAsIG9feCA9IDAs
IG9feSA9IDA7Ci0JdTMyIGZneCwgYmd4LCBsZGF0OwotCWludCBzeCwgc3ksIGksIGo7Ci0JdTE2
IHNjOwotCi0JRFRSQUNFOwotCi0Jc2MgPSBzY3JfcmVhZHcocyk7Ci0JaWYgKGxfZmJfaW5mby0+
Y3VycmVudF9wYXItPmRlcHRoID09IDgpCi0JCWZneCA9IGF0dHJfZmdjb2wocCwgc2MpOwotCWVs
c2UgaWYgKGRlcHRoMmJwcChsX2ZiX2luZm8tPmN1cnJlbnRfcGFyLT5kZXB0aCkgPT0gMTYpCi0J
CWZneCA9ICgodTE2ICopIHAtPmRpc3Bzd19kYXRhKVthdHRyX2ZnY29sKHAsIHNjKV07Ci0JZWxz
ZQotCQlmZ3ggPSAoKHUzMiAqKSBwLT5kaXNwc3dfZGF0YSlbYXR0cl9mZ2NvbChwLCBzYyldOwot
CQotCVBNM19DT0xPUihmZ3gpOwotCQotCWlmIChsX2ZiX2luZm8tPmN1cnJlbnRfcGFyLT5kZXB0
aCA9PSA4KQotCQliZ3ggPSBhdHRyX2JnY29sKHAsIHNjKTsKLQllbHNlIGlmIChkZXB0aDJicHAo
bF9mYl9pbmZvLT5jdXJyZW50X3Bhci0+ZGVwdGgpID09IDE2KQotCQliZ3ggPSAoKHUxNiAqKSBw
LT5kaXNwc3dfZGF0YSlbYXR0cl9iZ2NvbChwLCBzYyldOwotCWVsc2UKLQkJYmd4ID0gKCh1MzIg
KikgcC0+ZGlzcHN3X2RhdGEpW2F0dHJfYmdjb2wocCwgc2MpXTsKLQkKLQlQTTNfQ09MT1IoYmd4
KTsKLQotCVBNM19XQUlUKDQpOwotCi0JUE0zX1dSSVRFX1JFRyhQTTNDb25maWcyRCwKLQkJCQkg
IFBNM0NvbmZpZzJEX1VzZUNvbnN0YW50U291cmNlIHwKLQkJCQkgIFBNM0NvbmZpZzJEX0ZvcmVn
cm91bmRST1BFbmFibGUgfAotCQkJCSAgKFBNM0NvbmZpZzJEX0ZvcmVncm91bmRST1AoMHgzKSkg
fAkvKiBPeDMgaXMgR1hjb3B5ICovCi0JCQkJICBQTTNDb25maWcyRF9GQldyaXRlRW5hYmxlIHwK
LQkJCQkgIFBNM0NvbmZpZzJEX09wYXF1ZVNwYW4pOwotCi0JUE0zX1dSSVRFX1JFRyhQTTNGb3Jl
Z3JvdW5kQ29sb3IsIGZneCk7Ci0JUE0zX1dSSVRFX1JFRyhQTTNGaWxsQmFja2dyb3VuZENvbG9y
LCBiZ3gpOwotCi0JLyogV0FSTklORyA6IGFkZHJlc3Mgc2VsZWN0IFggbmVlZCB0byBzcGVjaWZ5
IDggYml0cyBmb3IgZm9udHdpZHRoIDw9IDggKi8KLQkvKiBhbmQgMTYgYml0cyBmb3IgZm9udHdp
ZHRoIDw9IDE2ICovCi0JLyogc2FtZSBpbiBfcHV0Yywgc2FtZSBmb3IgWSBhbmQgZm9udGhlaWdo
dCAqLwotCWlmIChmb250d2lkdGgocCkgPD0gOCkKLQkJYXN4ID0gMjsKLQllbHNlIGlmIChmb250
d2lkdGgocCkgPD0gMTYpCi0JCWFzeCA9IDM7CS8qIGxvb2sgT0sgKi8KLQlpZiAoZm9udGhlaWdo
dChwKSA8PSA4KQotCQlhc3kgPSAyOwotCWVsc2UgaWYgKGZvbnRoZWlnaHQocCkgPD0gMTYpCi0J
CWFzeSA9IDM7CS8qIGxvb2sgT0sgKi8KLQllbHNlIGlmIChmb250aGVpZ2h0KHApIDw9IDMyKQot
CQlhc3kgPSA0OwkvKiBsb29rIE9LICovCi0KLQlzeSA9IHl5ICogZm9udGhlaWdodChwKTsKLQot
CWlmIChmb250aGVpZ2h0KHApIDw9IDgpCi0JCW9feSA9ICg4IC0gKHN5ICYgMHg3KSkgJiAweDc7
Ci0JZWxzZSBpZiAoZm9udGhlaWdodChwKSA8PSAxNikKLQkJb195ID0gKDE2IC0gKHN5ICYgMHhG
KSkgJiAweEY7Ci0JZWxzZSBpZiAoZm9udGhlaWdodChwKSA8PSAzMikKLQkJb195ID0gKDMyIC0g
KHN5ICYgMHgxRikpICYgMHgxRjsKLQotCWZvciAoaiA9IDA7IGogPCBjb3VudDsgaisrKSB7Ci0J
CXNjID0gc2NyX3JlYWR3KHMgKyBqKTsKLQkJaWYgKGZvbnR3aWR0aChwKSA8PSA4KQotCQkJY2Rh
dCA9IHAtPmZvbnRkYXRhICsKLQkJCQkoc2MgJiBwLT5jaGFybWFzaykgKiBmb250aGVpZ2h0KHAp
OwotCQllbHNlCi0JCQljZGF0ID0gcC0+Zm9udGRhdGEgKwotCQkJCSgoc2MgJiBwLT5jaGFybWFz
aykgKiBmb250aGVpZ2h0KHApIDw8IDEpOwotCQkKLQkJc3ggPSAoeHggKyBqKSAqIGZvbnR3aWR0
aChwKTsKLQotCQlpZiAoZm9udHdpZHRoKHApIDw9IDgpCi0JCQlvX3ggPSAoOCAtIChzeCAmIDB4
NykpICYgMHg3OwotCQllbHNlIGlmIChmb250d2lkdGgocCkgPD0gMTYpCi0JCQlvX3ggPSAoMTYg
LSAoc3ggJiAweEYpKSAmIDB4RjsKLQotCQlQTTNfV0FJVCgzICsgZm9udGhlaWdodChwKSk7Ci0K
LQkJUE0zX1dSSVRFX1JFRyhQTTNBcmVhU3RpcHBsZU1vZGUsIChvX3ggPDwgNykgfCAob195IDw8
IDEyKSB8IC8qIHhfb2Zmc2V0LCB5X29mZnNldCBpbiBwYXR0ZXJuICovCi0JCQkgICAgICAoMSA8
PCAxOCkgfCAvKiBCRSAqLwotCQkJICAgICAgMSB8IChhc3ggPDwgMSkgfCAoYXN5IDw8IDQpIHwg
LyogYWRkcmVzcyBzZWxlY3QgeC95ICovCi0JCQkgICAgICAoMSA8PCAyMCkpOyAvKiBPcGFxdWVT
cGFuICovCi0KLQkJZm9yIChpID0gMDsgaSA8IGZvbnRoZWlnaHQocCk7IGkrKykgeyAvKiBhc3N1
bWUgZm9udGhlaWdodCA8PSAzMiAqLwotCQkJaWYgKGZvbnR3aWR0aChwKSA8PSA4KSB7Ci0JCQkJ
bGRhdCA9ICpjZGF0Kys7Ci0JCQl9IGVsc2UgeyAvKiBhc3N1bWUgZm9udHdpZHRoIDw9IDE2IEFU
TSAqLwotCQkJCWxkYXQgPSAoKCpjZGF0KyspIDw8IDgpOwotCQkJCWxkYXQgfD0gKmNkYXQrKzsK
LQkJCX0KLQkJCVBNM19XUklURV9SRUcoQXJlYVN0aXBwbGVQYXR0ZXJuX2luZGV4ZWQoaSksIGxk
YXQpOwotCQl9Ci0KLQkJUE0zX1dSSVRFX1JFRyhQTTNSZWN0YW5nbGVQb3NpdGlvbiwKLQkJCSAg
ICAgIChQTTNSZWN0YW5nbGVQb3NpdGlvbl9YT2Zmc2V0KHN4KSkgfAotCQkJICAgICAgKFBNM1Jl
Y3RhbmdsZVBvc2l0aW9uX1lPZmZzZXQoc3kpKSk7Ci0KLQkJUE0zX1dSSVRFX1JFRyhQTTNSZW5k
ZXIyRCwKLQkJCSAgICAgIFBNM1JlbmRlcjJEX0FyZWFTdGlwcGxlRW5hYmxlIHwKLQkJCSAgICAg
IFBNM1JlbmRlcjJEX1hQb3NpdGl2ZSB8Ci0JCQkgICAgICBQTTNSZW5kZXIyRF9ZUG9zaXRpdmUg
fAotCQkJICAgICAgUE0zUmVuZGVyMkRfT3BlcmF0aW9uX05vcm1hbCB8Ci0JCQkgICAgICBQTTNS
ZW5kZXIyRF9TcGFuT3BlcmF0aW9uIHwKLQkJCSAgICAgIChQTTNSZW5kZXIyRF9XaWR0aChmb250
d2lkdGgocCkpKSB8Ci0JCQkgICAgICAoUE0zUmVuZGVyMkRfSGVpZ2h0KGZvbnRoZWlnaHQocCkp
KSk7Ci0JfQotCXBtM2ZiX3dhaXRfcG0zKGxfZmJfaW5mbyk7Ci19Ci0KLXN0YXRpYyB2b2lkIHBt
M2ZiX2NmYlhfcmV2YyhzdHJ1Y3QgZGlzcGxheSAqcCwgaW50IHh4LCBpbnQgeXkpCitzdGF0aWMg
aW50IHBtM2ZiX3Bhbl9kaXNwbGF5KHN0cnVjdCBmYl92YXJfc2NyZWVuaW5mbyAqdmFyLAorCQkJ
CSBzdHJ1Y3QgZmJfaW5mbyAqaW5mbykKIHsKLQlzdHJ1Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZv
ID0gKHN0cnVjdCBwbTNmYl9pbmZvICopIHAtPmZiX2luZm87Ci0KLQl4eCA9IHh4ICogZm9udHdp
ZHRoKHApOwotCXl5ID0geXkgKiBmb250aGVpZ2h0KHApOwotCi0JaWYgKGxfZmJfaW5mby0+Y3Vy
cmVudF9wYXItPmRlcHRoID09IDgpCi0JewotCQlpZiAobF9mYl9pbmZvLT5tZW10LmNhcHMgJiBQ
TTNMb2NhbE1lbUNhcHNfTm9Xcml0ZU1hc2spCi0JCQlQTTNfU0xPV19XUklURV9SRUcoUE0zRkJT
b2Z0d2FyZVdyaXRlTWFzaywgMHgwRjBGMEYwRik7Ci0JCWVsc2UKLQkJCVBNM19TTE9XX1dSSVRF
X1JFRyhQTTNGQkhhcmR3YXJlV3JpdGVNYXNrLCAweDBGMEYwRjBGKTsKLQl9Ci0KLQlQTTNfV0FJ
VCgzKTsKLQotCVBNM19XUklURV9SRUcoUE0zQ29uZmlnMkQsCi0JCQkJICBQTTNDb25maWcyRF9V
c2VDb25zdGFudFNvdXJjZSB8Ci0JCQkJICBQTTNDb25maWcyRF9Gb3JlZ3JvdW5kUk9QRW5hYmxl
IHwKLQkJCQkgIChQTTNDb25maWcyRF9Gb3JlZ3JvdW5kUk9QKDB4YSkpIHwJLyogT3hhIGlzIEdY
aW52ZXJ0ICovCi0JCQkJICBQTTNDb25maWcyRF9GQkRlc3RSZWFkRW5hYmxlIHwKLQkJCQkgIFBN
M0NvbmZpZzJEX0ZCV3JpdGVFbmFibGUpOwotCi0JUE0zX1dSSVRFX1JFRyhQTTNSZWN0YW5nbGVQ
b3NpdGlvbiwKLQkJICAgICAgKFBNM1JlY3RhbmdsZVBvc2l0aW9uX1hPZmZzZXQoeHgpKSB8Ci0J
CSAgICAgIChQTTNSZWN0YW5nbGVQb3NpdGlvbl9ZT2Zmc2V0KHl5KSkpOwotCi0JUE0zX1dSSVRF
X1JFRyhQTTNSZW5kZXIyRCwKLQkJICAgICAgUE0zUmVuZGVyMkRfWFBvc2l0aXZlIHwKLQkJICAg
ICAgUE0zUmVuZGVyMkRfWVBvc2l0aXZlIHwKLQkJICAgICAgUE0zUmVuZGVyMkRfT3BlcmF0aW9u
X05vcm1hbCB8Ci0JCSAgICAgIFBNM1JlbmRlcjJEX1NwYW5PcGVyYXRpb24gfAotCQkgICAgICAo
UE0zUmVuZGVyMkRfV2lkdGgoZm9udHdpZHRoKHApKSkgfAotCQkgICAgICAoUE0zUmVuZGVyMkRf
SGVpZ2h0KGZvbnRoZWlnaHQocCkpKSk7Ci0KLQlwbTNmYl93YWl0X3BtMyhsX2ZiX2luZm8pOwot
Ci0JaWYgKGxfZmJfaW5mby0+Y3VycmVudF9wYXItPmRlcHRoID09IDgpCi0JewotCQlpZiAobF9m
Yl9pbmZvLT5tZW10LmNhcHMgJiBQTTNMb2NhbE1lbUNhcHNfTm9Xcml0ZU1hc2spCi0JCQlQTTNf
U0xPV19XUklURV9SRUcoUE0zRkJTb2Z0d2FyZVdyaXRlTWFzaywgMHhGRkZGRkZGRik7Ci0JCWVs
c2UKLQkJCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNGQkhhcmR3YXJlV3JpdGVNYXNrLCAweEZGRkZG
RkZGKTsKLQl9Ci19Ci0KLSNlbmRpZiAvKiBGQkNPTl9IQVNfQ0ZCOCB8fCBGQkNPTl9IQVNfQ0ZC
MTYgfHwgRkJDT05fSEFTX0NGQjMyICovCi0jZW5kaWYgLyogUE0zRkJfVVNFX0FDQ0VMICovCi0v
KiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiAqLwotLyogKioqKiogcHJlLWlu
aXQgYm9hcmQocykgc2V0dXAgKioqKiogKi8KLS8qICoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqICovCi0KLXN0YXRpYyB2b2lkIHBtM2ZiX21vZGVfc2V0dXAoY2hhciAqbW9kZSwg
dW5zaWduZWQgbG9uZyBib2FyZF9udW0pCi17Ci0Jc3RydWN0IHBtM2ZiX2luZm8gKmxfZmJfaW5m
byA9ICYoZmJfaW5mb1tib2FyZF9udW1dKTsKLQlzdHJ1Y3QgcG0zZmJfcGFyICpsX2ZiX3BhciA9
ICYoY3VycmVudF9wYXJbYm9hcmRfbnVtXSk7Ci0JdW5zaWduZWQgbG9uZyBpID0gMDsKLQotCWN1
cnJlbnRfcGFyX3ZhbGlkW2JvYXJkX251bV0gPSAwOwotCi0JaWYgKCFzdHJuY21wKG1vZGUsICJj
dXJyZW50IiwgNykpIHsKLQkJbF9mYl9pbmZvLT51c2VfY3VycmVudCA9IDE7CS8qIGRlZmF1bHQg
dy8gT3BlbkZpcm13YXJlICovCi0JfSBlbHNlIHsKLQkJd2hpbGUgKChtb2RlX2Jhc2VbaV0ubmFt
ZVswXSkKLQkJICAgICAgICYmICghY3VycmVudF9wYXJfdmFsaWRbYm9hcmRfbnVtXSkpIHsKLQkJ
CWlmICghCi0JCQkgICAgKHN0cm5jbXAKLQkJCSAgICAgKG1vZGUsIG1vZGVfYmFzZVtpXS5uYW1l
LAotCQkJICAgICAgc3RybGVuKG1vZGVfYmFzZVtpXS5uYW1lKSkpKSB7Ci0JCQkJbWVtY3B5KGxf
ZmJfcGFyLCAmKG1vZGVfYmFzZVtpXS51c2VyX21vZGUpLAotCQkJCSAgICAgICBzaXplb2Yoc3Ry
dWN0IHBtM2ZiX3BhcikpOwotCQkJCWN1cnJlbnRfcGFyX3ZhbGlkW2JvYXJkX251bV0gPSAxOwot
CQkJCURQUklOVEsoMiwgIk1vZGUgc2V0IHRvICVzXG4iLAotCQkJCQltb2RlX2Jhc2VbaV0ubmFt
ZSk7Ci0JCQl9Ci0JCQlpKys7Ci0JCX0KLQkJREFTU0VSVChjdXJyZW50X3Bhcl92YWxpZFtib2Fy
ZF9udW1dLAotCQkJIlZhbGlkIG1vZGUgb24gY29tbWFuZCBsaW5lXG4iKTsKLQl9Ci19Ci0KLXN0
YXRpYyB2b2lkIHBtM2ZiX3BjaWlkX3NldHVwKGNoYXIgKnBjaWlkLCB1bnNpZ25lZCBsb25nIGJv
YXJkX251bSkKLXsKLQlzaG9ydCBsX2J1cyA9IC0xLCBsX3Nsb3QgPSAtMSwgbF9mdW5jID0gLTE7
Ci0JY2hhciAqbmV4dDsKLQotCWlmIChwY2lpZCkgewotCQlsX2J1cyA9IHNpbXBsZV9zdHJ0b3Vs
KHBjaWlkLCAmbmV4dCwgMTApOwotCQlpZiAobmV4dCAmJiAobmV4dFswXSA9PSAnOicpKSB7Ci0J
CQlwY2lpZCA9IG5leHQgKyAxOwotCQkJbF9zbG90ID0gc2ltcGxlX3N0cnRvdWwocGNpaWQsICZu
ZXh0LCAxMCk7Ci0JCQlpZiAobmV4dCAmJiAobmV4dFswXSA9PSAnOicpKSB7Ci0JCQkJcGNpaWQg
PSBuZXh0ICsgMTsKLQkJCQlsX2Z1bmMgPQotCQkJCSAgICBzaW1wbGVfc3RydG91bChwY2lpZCwg
KGNoYXIgKiopIE5VTEwsCi0JCQkJCQkgICAxMCk7Ci0JCQl9Ci0JCX0KLQl9IGVsc2UKLQkJcmV0
dXJuOwotCi0JaWYgKChsX2J1cyA+PSAwKSAmJiAobF9zbG90ID49IDApICYmIChsX2Z1bmMgPj0g
MCkpIHsKLQkJYnVzW2JvYXJkX251bV0gPSBsX2J1czsKLQkJc2xvdFtib2FyZF9udW1dID0gbF9z
bG90OwotCQlmdW5jW2JvYXJkX251bV0gPSBsX2Z1bmM7Ci0JCURQUklOVEsoMiwgIkJvYXJkICMl
bGQgd2lsbCBiZSBQY2lJZDogJWhkOiVoZDolaGRcbiIsCi0JCQlib2FyZF9udW0sIGxfYnVzLCBs
X3Nsb3QsIGxfZnVuYyk7Ci0JfSBlbHNlIHsKLQkJRFBSSU5USygxLCAiSW52YWxpZCBQY2lJZDog
JWhkOiVoZDolaGQgZm9yIGJvYXJkICMlbGRcbiIsCi0JCQlsX2J1cywgbF9zbG90LCBsX2Z1bmMs
IGJvYXJkX251bSk7Ci0JfQotfQotCi1zdGF0aWMgdm9pZCBwbTNmYl9mb250X3NldHVwKGNoYXIg
KmxmLCB1bnNpZ25lZCBsb25nIGJvYXJkX251bSkKLXsKLQl1bnNpZ25lZCBsb25nIGxmcyA9IHN0
cmxlbihsZik7Ci0KLQlpZiAobGZzID4gKFBNM19GT05UTkFNRV9TSVpFIC0gMSkpIHsKLQkJRFBS
SU5USygxLCAiRm9udG5hbWUgJXMgdG9vIGxvbmdcbiIsIGxmKTsKLQkJcmV0dXJuOwotCX0KLQlz
dHJsY3B5KGZvbnRuW2JvYXJkX251bV0sIGxmLCBsZnMgKyAxKTsKLX0KLQotc3RhdGljIHZvaWQg
cG0zZmJfYm9vdGRlcHRoX3NldHVwKGNoYXIgKmJkcywgdW5zaWduZWQgbG9uZyBib2FyZF9udW0p
Ci17Ci0JdW5zaWduZWQgbG9uZyBiZCA9IHNpbXBsZV9zdHJ0b3VsKGJkcywgKGNoYXIgKiopIE5V
TEwsIDEwKTsKLQotCWlmICghKGRlcHRoX3N1cHBvcnRlZChiZCkpKSB7Ci0JCXByaW50ayhLRVJO
X1dBUk5JTkcgInBtM2ZiOiBpZ25vcmluZyBpbnZhbGlkIGRlcHRoICVzIGZvciBib2FyZCAjJWxk
XG4iLAotCQkgICAgICAgYmRzLCBib2FyZF9udW0pOwotCQlyZXR1cm47Ci0JfQotCWRlcHRoW2Jv
YXJkX251bV0gPSBiZDsKLX0KLQotc3RhdGljIHZvaWQgcG0zZmJfZm9yY2VzaXplX3NldHVwKGNo
YXIgKmJkcywgdW5zaWduZWQgbG9uZyBib2FyZF9udW0pCi17Ci0JdW5zaWduZWQgbG9uZyBiZCA9
IHNpbXBsZV9zdHJ0b3VsKGJkcywgKGNoYXIgKiopIE5VTEwsIDEwKTsKLQotCWlmIChiZCA+IDY0
KSB7Ci0JCXByaW50ayhLRVJOX1dBUk5JTkcgInBtM2ZiOiBpZ25vcmluZyBpbnZhbGlkIG1lbW9y
eSBzaXplICVzIGZvciBib2FyZCAjJWxkXG4iLAotCQkgICAgICAgYmRzLCBib2FyZF9udW0pOwot
CQlyZXR1cm47Ci0JfQotCWZvcmNlc2l6ZVtib2FyZF9udW1dID0gYmQ7Ci19Ci0KLXN0YXRpYyBj
aGFyICpwbTNmYl9ib2FyZG51bV9zZXR1cChjaGFyICpvcHRpb25zLCB1bnNpZ25lZCBsb25nICpi
bikKLXsKLQljaGFyICpuZXh0OwotCi0JaWYgKCEoaXNkaWdpdChvcHRpb25zWzBdKSkpIHsKLQkJ
KCpibikgPSAwOwotCQlyZXR1cm4gKG9wdGlvbnMpOwotCX0KLQotCSgqYm4pID0gc2ltcGxlX3N0
cnRvdWwob3B0aW9ucywgJm5leHQsIDEwKTsKLQotCWlmIChuZXh0ICYmIChuZXh0WzBdID09ICc6
JykgJiYgKCgqYm4pID49IDApCi0JICAgICYmICgoKmJuKSA8PSBQTTNfTUFYX0JPQVJEKSkgewot
CQlEUFJJTlRLKDIsICJCb2FyZF9udW0gc2VlbiBhcyAlbGRcbiIsICgqYm4pKTsKLQkJcmV0dXJu
IChuZXh0ICsgMSk7Ci0JfSBlbHNlIHsKLQkJKCpibikgPSAwOwotCQlEUFJJTlRLKDIsICJCb2Fy
ZF9udW0gZGVmYXVsdCB0byAlbGRcbiIsICgqYm4pKTsKLQkJcmV0dXJuIChvcHRpb25zKTsKLQl9
Ci19Ci0KLXN0YXRpYyB2b2lkIHBtM2ZiX3JlYWxfc2V0dXAoY2hhciAqb3B0aW9ucykKLXsKLQlj
aGFyICpuZXh0OwotCXVuc2lnbmVkIGxvbmcgaSwgYm47Ci0Jc3RydWN0IHBtM2ZiX2luZm8gKmxf
ZmJfaW5mbzsKLQotCURUUkFDRTsKLQotCURQUklOVEsoMiwgIk9wdGlvbnMgOiAlc1xuIiwgb3B0
aW9ucyk7Ci0KLQlmb3IgKGkgPSAwOyBpIDwgUE0zX01BWF9CT0FSRDsgaSsrKSB7Ci0JCWxfZmJf
aW5mbyA9ICYoZmJfaW5mb1tpXSk7Ci0JCW1lbXNldChsX2ZiX2luZm8sIDAsIHNpemVvZihzdHJ1
Y3QgcG0zZmJfaW5mbykpOwotCQlsX2ZiX2luZm8tPmdlbi5mYmh3ID0gJnBtM2ZiX3N3aXRjaDsK
LQkJbF9mYl9pbmZvLT5ib2FyZF9udW0gPSBpOwotCQljdXJyZW50X3Bhcl92YWxpZFtpXSA9IDA7
Ci0JCXNsb3RbaV0gPSAtMTsKLQkJZnVuY1tpXSA9IC0xOwotCQlidXNbaV0gPSAtMTsKLQkJZGlz
YWJsZVtpXSA9IDA7Ci0JCW5vYWNjZWxbaV0gPSAwOwotCQlmb250bltpXVswXSA9ICdcMCc7Ci0J
CWRlcHRoW2ldID0gMDsKLQkJbF9mYl9pbmZvLT5jdXJyZW50X3BhciA9ICYoY3VycmVudF9wYXJb
aV0pOwotCX0KLQotCS8qIGVhdCB1cCBwcmVmaXggcG0zZmIgYW5kIHdoYXRldmVyIGlzIHVzZWQg
YXMgc2VwYXJhdG9yIGkuZS4gOiw9ICovCi0JaWYgKCFzdHJuY21wKG9wdGlvbnMsICJwbTNmYiIs
IDUpKSB7Ci0JCW9wdGlvbnMgKz0gNTsKLQkJd2hpbGUgKCgoKm9wdGlvbnMpID09ICcsJykgfHwg
KCgqb3B0aW9ucykgPT0gJzonKQotCQkgICAgICAgfHwgKCgqb3B0aW9ucykgPT0gJz0nKSkKLQkJ
CW9wdGlvbnMrKzsKLQl9Ci0KLQl3aGlsZSAob3B0aW9ucykgewotCQlibiA9IDA7Ci0JCWlmICgo
bmV4dCA9IHN0cmNocihvcHRpb25zLCAnLCcpKSkgewotCQkJKCpuZXh0KSA9ICdcMCc7Ci0JCQlu
ZXh0Kys7Ci0JCX0KLQotCQlpZiAoIXN0cm5jbXAob3B0aW9ucywgIm1vZGU6IiwgNSkpIHsKLQkJ
CW9wdGlvbnMgPSBwbTNmYl9ib2FyZG51bV9zZXR1cChvcHRpb25zICsgNSwgJmJuKTsKLQkJCURQ
UklOVEsoMiwgIlNldHRpbmcgbW9kZSBmb3IgYm9hcmQgIyVsZFxuIiwgYm4pOwotCQkJcG0zZmJf
bW9kZV9zZXR1cChvcHRpb25zLCBibik7Ci0JCX0gZWxzZSBpZiAoIXN0cm5jbXAob3B0aW9ucywg
Im9mZjoiLCA0KSkgewotCQkJb3B0aW9ucyA9IHBtM2ZiX2JvYXJkbnVtX3NldHVwKG9wdGlvbnMg
KyA0LCAmYm4pOwotCQkJRFBSSU5USygyLCAiRGlzYWJsaW5nIGJvYXJkICMlbGRcbiIsIGJuKTsK
LQkJCWRpc2FibGVbYm5dID0gMTsKLQkJfSBlbHNlIGlmICghc3RybmNtcChvcHRpb25zLCAib2Zm
IiwgMykpIHsJLyogZGlzYWJsZSBldmVyeXRoaW5nICovCi0JCQlmb3IgKGkgPSAwOyBpIDwgUE0z
X01BWF9CT0FSRDsgaSsrKQotCQkJCWRpc2FibGVbaV0gPSAxOwotCQl9IGVsc2UgaWYgKCFzdHJu
Y21wKG9wdGlvbnMsICJkaXNhYmxlOiIsIDgpKSB7Ci0JCQlvcHRpb25zID0gcG0zZmJfYm9hcmRu
dW1fc2V0dXAob3B0aW9ucyArIDgsICZibik7Ci0JCQlEUFJJTlRLKDIsICJEaXNhYmxpbmcgYm9h
cmQgIyVsZFxuIiwgYm4pOwotCQkJZGlzYWJsZVtibl0gPSAxOwotCQl9IGVsc2UgaWYgKCFzdHJu
Y21wKG9wdGlvbnMsICJwY2lpZDoiLCA2KSkgewotCQkJb3B0aW9ucyA9IHBtM2ZiX2JvYXJkbnVt
X3NldHVwKG9wdGlvbnMgKyA2LCAmYm4pOwotCQkJRFBSSU5USygyLCAiU2V0dGluZyBQY2lJRCBm
b3IgYm9hcmQgIyVsZFxuIiwgYm4pOwotCQkJcG0zZmJfcGNpaWRfc2V0dXAob3B0aW9ucywgYm4p
OwotCQl9IGVsc2UgaWYgKCFzdHJuY21wKG9wdGlvbnMsICJub2FjY2VsOiIsIDgpKSB7Ci0JCQlv
cHRpb25zID0gcG0zZmJfYm9hcmRudW1fc2V0dXAob3B0aW9ucyArIDgsICZibik7Ci0JCQlub2Fj
Y2VsW2JuXSA9IDE7Ci0JCX0gZWxzZSBpZiAoIXN0cm5jbXAob3B0aW9ucywgImZvbnQ6IiwgNSkp
IHsKLQkJCW9wdGlvbnMgPSBwbTNmYl9ib2FyZG51bV9zZXR1cChvcHRpb25zICsgNSwgJmJuKTsK
LQkJCXBtM2ZiX2ZvbnRfc2V0dXAob3B0aW9ucywgYm4pOwotCQl9IGVsc2UgaWYgKCFzdHJuY21w
KG9wdGlvbnMsICJkZXB0aDoiLCA2KSkgewotCQkJb3B0aW9ucyA9IHBtM2ZiX2JvYXJkbnVtX3Nl
dHVwKG9wdGlvbnMgKyA2LCAmYm4pOwotCQkJcG0zZmJfYm9vdGRlcHRoX3NldHVwKG9wdGlvbnMs
IGJuKTsKLQkJfSBlbHNlIGlmICghc3RybmNtcChvcHRpb25zLCAicHJpbnR0aW1pbmdzIiwgMTIp
KSB7Ci0JCQlwcmludHRpbWluZ3MgPSAxOwotCQl9IGVsc2UgaWYgKCFzdHJuY21wKG9wdGlvbnMs
ICJmbGF0cGFuZWw6IiwgMTApKSB7Ci0JCQlvcHRpb25zID0gcG0zZmJfYm9hcmRudW1fc2V0dXAo
b3B0aW9ucyArIDEwLCAmYm4pOwotCQkJZmxhdHBhbmVsW2JuXSA9IDE7Ci0JCX0gZWxzZSBpZiAo
IXN0cm5jbXAob3B0aW9ucywgImZvcmNlc2l6ZToiLCAxMCkpIHsKLQkJCW9wdGlvbnMgPSBwbTNm
Yl9ib2FyZG51bV9zZXR1cChvcHRpb25zICsgMTAsICZibik7Ci0JCQlwbTNmYl9mb3JjZXNpemVf
c2V0dXAob3B0aW9ucywgYm4pOwotCQl9Ci0JCW9wdGlvbnMgPSBuZXh0OwotCX0KLX0KKwlzdHJ1
Y3QgcG0zX3BhciAqcGFyID0gaW5mby0+cGFyOworCWNvbnN0IHUzMiB4cmVzID0gKHZhci0+eHJl
cyArIDMxKSAmIH4zMTsKIAotLyogKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKiAqLwotLyogKioqKiogZnJhbWVidWZmZXIgQVBJIHN0YW5kYXJkIGZ1bmN0aW9u
cyAqKioqKiAqLwotLyogKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKiAqLwotCi1zdGF0aWMgaW50IHBtM2ZiX2VuY29kZV9maXgoc3RydWN0IGZiX2ZpeF9zY3Jl
ZW5pbmZvICpmaXgsCi0JCQkgICAgY29uc3Qgdm9pZCAqcGFyLCBzdHJ1Y3QgZmJfaW5mb19nZW4g
KmluZm8pCi17Ci0Jc3RydWN0IHBtM2ZiX2luZm8gKmxfZmJfaW5mbyA9IChzdHJ1Y3QgcG0zZmJf
aW5mbyAqKSBpbmZvOwotCXN0cnVjdCBwbTNmYl9wYXIgKnAgPSAoc3RydWN0IHBtM2ZiX3BhciAq
KSBwYXI7Ci0KLQlEVFJBQ0U7Ci0KLQlzdHJjcHkoZml4LT5pZCwgcGVybWVkaWEzX25hbWUpOwot
CWZpeC0+c21lbV9zdGFydCA9ICh1bnNpZ25lZCBsb25nKWxfZmJfaW5mby0+cF9mYjsKLQlmaXgt
PnNtZW1fbGVuID0gbF9mYl9pbmZvLT5mYl9zaXplOwotCWZpeC0+bW1pb19zdGFydCA9ICh1bnNp
Z25lZCBsb25nKWxfZmJfaW5mby0+cElPQmFzZTsKLQlmaXgtPm1taW9fbGVuID0gUE0zX1JFR1Nf
U0laRTsKLSNpZmRlZiBQTTNGQl9VU0VfQUNDRUwKLQlpZiAoIShub2FjY2VsW2xfZmJfaW5mby0+
Ym9hcmRfbnVtXSkpCi0JCWZpeC0+YWNjZWwgPSBGQl9BQ0NFTF8zRExBQlNfUEVSTUVESUEzOwot
CWVsc2UKLSNlbmRpZiAvKiBQTTNGQl9VU0VfQUNDRUwgKi8KLQkJZml4LT5hY2NlbCA9IEZCX0FD
Q0VMX05PTkU7Ci0JZml4LT50eXBlID0gRkJfVFlQRV9QQUNLRURfUElYRUxTOwotCWZpeC0+dmlz
dWFsID0KLQkgICAgKHAtPmRlcHRoID09IDgpID8gRkJfVklTVUFMX1BTRVVET0NPTE9SIDogRkJf
VklTVUFMX1RSVUVDT0xPUjsKLQlpZiAoY3VycmVudF9wYXJfdmFsaWRbbF9mYl9pbmZvLT5ib2Fy
ZF9udW1dKQotCQlmaXgtPmxpbmVfbGVuZ3RoID0KLQkJCWxfZmJfaW5mby0+Y3VycmVudF9wYXIt
PndpZHRoICoKLQkJCWRlcHRoMkJ5UFAobF9mYl9pbmZvLT5jdXJyZW50X3Bhci0+ZGVwdGgpOwot
CWVsc2UKLQkJZml4LT5saW5lX2xlbmd0aCA9IDA7Ci0JZml4LT54cGFuc3RlcCA9IDY0IC8gZGVw
dGgyYnBwKHAtPmRlcHRoKTsKLQlmaXgtPnlwYW5zdGVwID0gMTsKLQlmaXgtPnl3cmFwc3RlcCA9
IDA7Ci0JcmV0dXJuICgwKTsKLX0KLQotc3RhdGljIGludCBwbTNmYl9kZWNvZGVfdmFyKGNvbnN0
IHN0cnVjdCBmYl92YXJfc2NyZWVuaW5mbyAqdmFyLAotCQkJICAgIHZvaWQgKnBhciwgc3RydWN0
IGZiX2luZm9fZ2VuICppbmZvKQotewotCXN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8gPSAo
c3RydWN0IHBtM2ZiX2luZm8gKikgaW5mbzsKLQlzdHJ1Y3QgcG0zZmJfcGFyICpwID0gKHN0cnVj
dCBwbTNmYl9wYXIgKikgcGFyOwotCXN0cnVjdCBwbTNmYl9wYXIgdGVtcF9wOwotCXUzMiB4cmVz
OwotCi0JRFRSQUNFOwotCi0JREFTU0VSVCgodmFyICE9IE5VTEwpLCAiZmJfdmFyX3NjcmVlbmlu
Zm8qIG5vdCBOVUxMIik7Ci0JREFTU0VSVCgocCAhPSBOVUxMKSwgInBtM2ZiX3Bhciogbm90IE5V
TEwiKTsKLQlEQVNTRVJUKChsX2ZiX2luZm8gIT0gTlVMTCksICJwbTNmYl9pbmZvKiBub3QgTlVM
TCIpOwotCi0JbWVtc2V0KCZ0ZW1wX3AsIDAsIHNpemVvZihzdHJ1Y3QgcG0zZmJfcGFyKSk7Ci0J
dGVtcF9wLndpZHRoID0gKHZhci0+eHJlc192aXJ0dWFsICsgNykgJiB+NzsKLQl0ZW1wX3AuaGVp
Z2h0ID0gdmFyLT55cmVzX3ZpcnR1YWw7Ci0KLQlpZiAoIShkZXB0aF9zdXBwb3J0ZWQodmFyLT5i
aXRzX3Blcl9waXhlbCkpKSAvKiByb3VuZCB1bnN1cHBvcnRlZCB1cCB0byBhIG11bHRpcGxlIG9m
IDggKi8KLQkJdGVtcF9wLmRlcHRoID0gZGVwdGgyYnBwKHZhci0+Yml0c19wZXJfcGl4ZWwpOwot
CWVsc2UKLQkJdGVtcF9wLmRlcHRoID0gdmFyLT5iaXRzX3Blcl9waXhlbDsKLQotCXRlbXBfcC5k
ZXB0aCA9ICh0ZW1wX3AuZGVwdGggPiAzMikgPyAzMiA6IHRlbXBfcC5kZXB0aDsgLyogbWF4IDMy
ICovCi0JdGVtcF9wLmRlcHRoID0gKHRlbXBfcC5kZXB0aCA9PSAyNCkgPyAzMiA6IHRlbXBfcC5k
ZXB0aDsgLyogMjQgdW5zdXBwb3J0ZWQsIHJvdW5kLXVwIHRvIDMyICovCi0KLQlpZiAoKHRlbXBf
cC5kZXB0aCA9PSAxNikgJiYgKHZhci0+cmVkLmxlbmd0aCA9PSA1KSAmJiAodmFyLT5ncmVlbi5s
ZW5ndGggPT0gNSkgJiYgKHZhci0+Ymx1ZS5sZW5ndGggPT0gNSkpCi0JCXRlbXBfcC5kZXB0aCA9
IDE1OyAvKiBSR0JBIDU1NTEgaXMgc3RvcmVkIGFzIGRlcHRoIDE1ICovCi0KLQlpZiAoKHRlbXBf
cC5kZXB0aCA9PSAxNikgJiYgKHZhci0+cmVkLmxlbmd0aCA9PSA0KSAmJiAodmFyLT5ncmVlbi5s
ZW5ndGggPT0gNCkgJiYgKHZhci0+Ymx1ZS5sZW5ndGggPT0gNCkpCi0JCXRlbXBfcC5kZXB0aCA9
IDEyOyAvKiBSR0JBIDQ0NDQgIGlzIHN0b3JlZCBhcyBkZXB0aCAxMiAqLwotCi0KLQlEUFJJTlRL
KDIsCi0JCSJ4cmVzOiAlZCwgeXJlczogJWQsIHZ4cmVzOiAlZCwgdnlyZXM6ICVkIDsgeG9mZnNl
dDolZCwgeW9mZnNldDogJWRcbiIsCi0JCXZhci0+eHJlcywgdmFyLT55cmVzLCB2YXItPnhyZXNf
dmlydHVhbCwgdmFyLT55cmVzX3ZpcnR1YWwsCi0JCXZhci0+eG9mZnNldCwgdmFyLT55b2Zmc2V0
KTsKLQotCXhyZXMgPSAodmFyLT54cmVzICsgMzEpICYgfjMxOwotCWlmICh0ZW1wX3Aud2lkdGgg
PCB4cmVzICsgdmFyLT54b2Zmc2V0KQotCQl0ZW1wX3Aud2lkdGggPSB4cmVzICsgdmFyLT54b2Zm
c2V0OwotCWlmICh0ZW1wX3AuaGVpZ2h0IDwgdmFyLT55cmVzICsgdmFyLT55b2Zmc2V0KQotCQl0
ZW1wX3AuaGVpZ2h0ID0gdmFyLT55cmVzICsgdmFyLT55b2Zmc2V0OwotCi0JaWYgKHRlbXBfcC53
aWR0aCA+IDIwNDgpIHsKLQkJRFBSSU5USygxLCAidmlydHVhbCB3aWR0aCBub3Qgc3VwcG9ydGVk
OiAldVxuIiwKLQkJCXRlbXBfcC53aWR0aCk7Ci0JCXJldHVybiAoLUVJTlZBTCk7Ci0JfQotCWlm
ICh2YXItPnlyZXMgPCAyMDApIHsKLQkJRFBSSU5USygxLCAiaGVpZ2h0IG5vdCBzdXBwb3J0ZWQ6
ICV1XG4iLCAodTMyKSB2YXItPnlyZXMpOwotCQlyZXR1cm4gKC1FSU5WQUwpOwotCX0KLQlpZiAo
dGVtcF9wLmhlaWdodCA8IDIwMCB8fCB0ZW1wX3AuaGVpZ2h0ID4gNDA5NSkgewotCQlEUFJJTlRL
KDEsICJ2aXJ0dWFsIGhlaWdodCBub3Qgc3VwcG9ydGVkOiAldVxuIiwKLQkJCXRlbXBfcC5oZWln
aHQpOwotCQlyZXR1cm4gKC1FSU5WQUwpOwotCX0KLQlpZiAoIShkZXB0aF9zdXBwb3J0ZWQodGVt
cF9wLmRlcHRoKSkpIHsKLQkJRFBSSU5USygxLCAiZGVwdGggbm90IHN1cHBvcnRlZDogJXVcbiIs
IHRlbXBfcC5kZXB0aCk7Ci0JCXJldHVybiAoLUVJTlZBTCk7Ci0JfQotCWlmICgodGVtcF9wLndp
ZHRoICogdGVtcF9wLmhlaWdodCAqIGRlcHRoMkJ5UFAodGVtcF9wLmRlcHRoKSkgPgotCSAgICBs
X2ZiX2luZm8tPmZiX3NpemUpIHsKLQkJRFBSSU5USygxLCAibm8gbWVtb3J5IGZvciBzY3JlZW4g
KCV1eCV1eCV1KVxuIiwKLQkJCXRlbXBfcC53aWR0aCwgdGVtcF9wLmhlaWdodCwgdGVtcF9wLmRl
cHRoKTsKLQkJcmV0dXJuICgtRUlOVkFMKTsKLQl9Ci0KLQlpZiAoKCF2YXItPnBpeGNsb2NrKSB8
fAotCSAgICAoIXZhci0+cmlnaHRfbWFyZ2luKSB8fAotCSAgICAoIXZhci0+aHN5bmNfbGVuKSB8
fAotCSAgICAoIXZhci0+bGVmdF9tYXJnaW4pIHx8Ci0JICAgICghdmFyLT5sb3dlcl9tYXJnaW4p
IHx8Ci0JICAgICghdmFyLT52c3luY19sZW4pIHx8ICghdmFyLT51cHBlcl9tYXJnaW4pCi0JICAg
ICkgewotCQl1bnNpZ25lZCBsb25nIGkgPSAwLCBkb25lID0gMDsKLQkJcHJpbnRrKEtFUk5fV0FS
TklORyAicG0zZmI6IHJlZnVzaW5nIHRvIHVzZSBhIGxpa2VseSB3cm9uZyB0aW1pbmdcbiIpOwot
Ci0JCXdoaWxlICgobW9kZV9iYXNlW2ldLnVzZXJfbW9kZS53aWR0aCkgJiYgIWRvbmUpIHsKLQkJ
CWlmICgobW9kZV9iYXNlW2ldLnVzZXJfbW9kZS53aWR0aCA9PSB0ZW1wX3Aud2lkdGgpCi0JCQkg
ICAgJiYgKG1vZGVfYmFzZVtpXS51c2VyX21vZGUuaGVpZ2h0ID09Ci0JCQkJdGVtcF9wLmhlaWdo
dCkpIHsKLQkJCQlwcmludGsoS0VSTl9OT1RJQ0UgInBtM2ZiOiB1c2luZyBjbG9zZSBtYXRjaCAl
c1xuIiwKLQkJCQkgICAgICAgbW9kZV9iYXNlW2ldLm5hbWUpOwotCQkJCXRlbXBfcCA9IG1vZGVf
YmFzZVtpXS51c2VyX21vZGU7Ci0JCQkJZG9uZSA9IDE7Ci0JCQl9Ci0JCQlpKys7Ci0JCX0KLQkJ
aWYgKCFkb25lKQotCQkJcmV0dXJuICgtRUlOVkFMKTsKLQl9IGVsc2UgewotCQl0ZW1wX3AucGl4
Y2xvY2sgPSBQSUNPUzJLSFoodmFyLT5waXhjbG9jayk7Ci0JCWlmICh0ZW1wX3AucGl4Y2xvY2sg
PiBQTTNfTUFYX1BJWENMT0NLKSB7Ci0JCQlEUFJJTlRLKDEsICJwaXhjbG9jayB0b28gaGlnaCAo
JXVLSHopXG4iLAotCQkJCXRlbXBfcC5waXhjbG9jayk7Ci0JCQlyZXR1cm4gKC1FSU5WQUwpOwot
CQl9Ci0KLQkJdGVtcF9wLmhzc3RhcnQgPSB2YXItPnJpZ2h0X21hcmdpbjsKLQkJdGVtcF9wLmhz
ZW5kID0gdmFyLT5yaWdodF9tYXJnaW4gKyB2YXItPmhzeW5jX2xlbjsKLQkJdGVtcF9wLmhiZW5k
ID0KLQkJICAgIHZhci0+cmlnaHRfbWFyZ2luICsgdmFyLT5oc3luY19sZW4gKyB2YXItPmxlZnRf
bWFyZ2luOwotCQl0ZW1wX3AuaHRvdGFsID0geHJlcyArIHRlbXBfcC5oYmVuZDsKLQotCQl0ZW1w
X3AudnNzdGFydCA9IHZhci0+bG93ZXJfbWFyZ2luOwotCQl0ZW1wX3AudnNlbmQgPSB2YXItPmxv
d2VyX21hcmdpbiArIHZhci0+dnN5bmNfbGVuOwotCQl0ZW1wX3AudmJlbmQgPQotCQkgICAgdmFy
LT5sb3dlcl9tYXJnaW4gKyB2YXItPnZzeW5jX2xlbiArIHZhci0+dXBwZXJfbWFyZ2luOwotCQl0
ZW1wX3AudnRvdGFsID0gdmFyLT55cmVzICsgdGVtcF9wLnZiZW5kOwotCi0JCXRlbXBfcC5zdHJp
ZGUgPSB0ZW1wX3Aud2lkdGg7Ci0KLQkJRFBSSU5USygyLCAiVXNpbmcgJWQgKiAlZCwgJWQgS2h6
LCBzdHJpZGUgaXMgJTA4eFxuIiwKLQkJCXRlbXBfcC53aWR0aCwgdGVtcF9wLmhlaWdodCwgdGVt
cF9wLnBpeGNsb2NrLAotCQkJdGVtcF9wLnN0cmlkZSk7Ci0KLQkJdGVtcF9wLmJhc2UgPQotCQkg
ICAgcG0zZmJfU2hpZnRicHAobF9mYl9pbmZvLCB0ZW1wX3AuZGVwdGgsCi0JCQkJICAgKHZhci0+
eW9mZnNldCAqIHhyZXMpICsgdmFyLT54b2Zmc2V0KTsKLQotCQl0ZW1wX3AudmlkZW8gPSAwOwot
Ci0JCWlmICh2YXItPnN5bmMgJiBGQl9TWU5DX0hPUl9ISUdIX0FDVCkKLQkJCXRlbXBfcC52aWRl
byB8PSBQTTNWaWRlb0NvbnRyb2xfSFNZTkNfQUNUSVZFX0hJR0g7Ci0JCWVsc2UKLQkJCXRlbXBf
cC52aWRlbyB8PSBQTTNWaWRlb0NvbnRyb2xfSFNZTkNfQUNUSVZFX0xPVzsKLQotCQlpZiAodmFy
LT5zeW5jICYgRkJfU1lOQ19WRVJUX0hJR0hfQUNUKQotCQkJdGVtcF9wLnZpZGVvIHw9IFBNM1Zp
ZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfSElHSDsKLQkJZWxzZQotCQkJdGVtcF9wLnZpZGVvIHw9
IFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19BQ1RJVkVfTE9XOwotCi0JCWlmICgodmFyLT52bW9kZSAm
IEZCX1ZNT0RFX01BU0spID09IEZCX1ZNT0RFX0lOVEVSTEFDRUQpIHsKLQkJCURQUklOVEsoMSwg
IkludGVybGFjZWQgbW9kZSBub3Qgc3VwcG9ydGVkXG5cbiIpOwotCQkJcmV0dXJuICgtRUlOVkFM
KTsKLQkJfQotCi0JCWlmICgodmFyLT52bW9kZSAmIEZCX1ZNT0RFX01BU0spID09IEZCX1ZNT0RF
X0RPVUJMRSkKLQkJCXRlbXBfcC52aWRlbyB8PSBQTTNWaWRlb0NvbnRyb2xfTElORV9ET1VCTEVf
T047Ci0JCWVsc2UKLQkJCXRlbXBfcC52aWRlbyB8PSBQTTNWaWRlb0NvbnRyb2xfTElORV9ET1VC
TEVfT0ZGOwotCi0JCWlmICh2YXItPmFjdGl2YXRlID09IEZCX0FDVElWQVRFX05PVykKLQkJCXRl
bXBfcC52aWRlbyB8PSBQTTNWaWRlb0NvbnRyb2xfRU5BQkxFOwotCQllbHNlIHsKLQkJCXRlbXBf
cC52aWRlbyB8PSBQTTNWaWRlb0NvbnRyb2xfRElTQUJMRTsKLQkJCURQUklOVEsoMiwgIlBNM1Zp
ZGVvIGRpc2FibGVkXG4iKTsKLQkJfQotCi0JCXN3aXRjaCAodGVtcF9wLmRlcHRoKSB7Ci0JCWNh
c2UgODoKLQkJCXRlbXBfcC52aWRlbyB8PSBQTTNWaWRlb0NvbnRyb2xfUElYRUxTSVpFXzhCSVQ7
Ci0JCQlicmVhazsKLQkJY2FzZSAxMjoKLQkJY2FzZSAxNToKLQkJY2FzZSAxNjoKLQkJCXRlbXBf
cC52aWRlbyB8PSBQTTNWaWRlb0NvbnRyb2xfUElYRUxTSVpFXzE2QklUOwotCQkJYnJlYWs7Ci0J
CWNhc2UgMzI6Ci0JCQl0ZW1wX3AudmlkZW8gfD0gUE0zVmlkZW9Db250cm9sX1BJWEVMU0laRV8z
MkJJVDsKLQkJCWJyZWFrOwotCQlkZWZhdWx0OgotCQkJRFBSSU5USygxLCAiVW5zdXBwb3J0ZWQg
ZGVwdGhcbiIpOwotCQkJYnJlYWs7Ci0JCX0KLQl9Ci0JKCpwKSA9IHRlbXBfcDsKLQotI2lmZGVm
IFBNM0ZCX1VTRV9BQ0NFTAotCWlmICh2YXItPmFjY2VsX2ZsYWdzICYgRkJfQUNDRUxGX1RFWFQp
Ci0JCW5vYWNjZWxbbF9mYl9pbmZvLT5ib2FyZF9udW1dID0gMDsKLQllbHNlCi0JCW5vYWNjZWxb
bF9mYl9pbmZvLT5ib2FyZF9udW1dID0gMTsKLSNlbmRpZiAvKiBQTTNGQl9VU0VfQUNDRUwgKi8K
LQotCXJldHVybiAoMCk7Ci19Ci0KLXN0YXRpYyB2b2lkIHBtM2ZiX2VuY29kZV9kZXB0aChzdHJ1
Y3QgZmJfdmFyX3NjcmVlbmluZm8gKnZhciwgbG9uZyBkKQotewotCXN3aXRjaCAoZCkgewotCWNh
c2UgODoKLQkJdmFyLT5yZWQubGVuZ3RoID0gdmFyLT5ncmVlbi5sZW5ndGggPSB2YXItPmJsdWUu
bGVuZ3RoID0gODsKLQkJdmFyLT5yZWQub2Zmc2V0ID0gdmFyLT5ncmVlbi5vZmZzZXQgPSB2YXIt
PmJsdWUub2Zmc2V0ID0gMDsKLQkJdmFyLT50cmFuc3Aub2Zmc2V0ID0gdmFyLT50cmFuc3AubGVu
Z3RoID0gMDsKLQkJYnJlYWs7Ci0KLQljYXNlIDEyOgotCQl2YXItPnJlZC5vZmZzZXQgPSA4Owot
CQl2YXItPnJlZC5sZW5ndGggPSA0OwotCQl2YXItPmdyZWVuLm9mZnNldCA9IDQ7Ci0JCXZhci0+
Z3JlZW4ubGVuZ3RoID0gNDsKLQkJdmFyLT5ibHVlLm9mZnNldCA9IDA7Ci0JCXZhci0+Ymx1ZS5s
ZW5ndGggPSA0OwotCQl2YXItPnRyYW5zcC5vZmZzZXQgPSAxMjsKLQkJdmFyLT50cmFuc3AubGVu
Z3RoID0gNDsKLQkJYnJlYWs7Ci0KLQljYXNlIDE1OgotCQl2YXItPnJlZC5vZmZzZXQgPSAxMDsK
LQkJdmFyLT5yZWQubGVuZ3RoID0gNTsKLQkJdmFyLT5ncmVlbi5vZmZzZXQgPSA1OwotCQl2YXIt
PmdyZWVuLmxlbmd0aCA9IDU7Ci0JCXZhci0+Ymx1ZS5vZmZzZXQgPSAwOwotCQl2YXItPmJsdWUu
bGVuZ3RoID0gNTsKLQkJdmFyLT50cmFuc3Aub2Zmc2V0ID0gMTU7Ci0JCXZhci0+dHJhbnNwLmxl
bmd0aCA9IDE7Ci0JCWJyZWFrOwotCi0JY2FzZSAxNjoKLQkJdmFyLT5yZWQub2Zmc2V0ID0gMTE7
Ci0JCXZhci0+cmVkLmxlbmd0aCA9IDU7Ci0JCXZhci0+Z3JlZW4ub2Zmc2V0ID0gNTsKLQkJdmFy
LT5ncmVlbi5sZW5ndGggPSA2OwotCQl2YXItPmJsdWUub2Zmc2V0ID0gMDsKLQkJdmFyLT5ibHVl
Lmxlbmd0aCA9IDU7Ci0JCXZhci0+dHJhbnNwLm9mZnNldCA9IHZhci0+dHJhbnNwLmxlbmd0aCA9
IDA7Ci0JCWJyZWFrOwotCi0JY2FzZSAzMjoKLQkJdmFyLT50cmFuc3Aub2Zmc2V0ID0gMjQ7Ci0J
CXZhci0+cmVkLm9mZnNldCA9IDE2OwotCQl2YXItPmdyZWVuLm9mZnNldCA9IDg7Ci0JCXZhci0+
Ymx1ZS5vZmZzZXQgPSAwOwotCQl2YXItPnJlZC5sZW5ndGggPSB2YXItPmdyZWVuLmxlbmd0aCA9
Ci0JCQl2YXItPmJsdWUubGVuZ3RoID0gdmFyLT50cmFuc3AubGVuZ3RoID0gODsKLQkJYnJlYWs7
Ci0KLQlkZWZhdWx0OgotCQlEUFJJTlRLKDEsICJVbnN1cHBvcnRlZCBkZXB0aCAlbGRcbiIsIGQp
OwotCQlicmVhazsKLQl9Ci19Ci0KLXN0YXRpYyBpbnQgcG0zZmJfZW5jb2RlX3ZhcihzdHJ1Y3Qg
ZmJfdmFyX3NjcmVlbmluZm8gKnZhciwKLQkJCSAgICBjb25zdCB2b2lkICpwYXIsIHN0cnVjdCBm
Yl9pbmZvX2dlbiAqaW5mbykKLXsKLQlzdHJ1Y3QgcG0zZmJfcGFyICpwID0gKHN0cnVjdCBwbTNm
Yl9wYXIgKikgcGFyOwotCXN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8gPSAoc3RydWN0IHBt
M2ZiX2luZm8gKikgaW5mbzsKLQotCXUzMiBiYXNlOwotCi0JRFRSQUNFOwotCi0JREFTU0VSVCgo
dmFyICE9IE5VTEwpLCAiZmJfdmFyX3NjcmVlbmluZm8qIG5vdCBOVUxMIik7Ci0JREFTU0VSVCgo
cCAhPSBOVUxMKSwgInBtM2ZiX3Bhciogbm90IE5VTEwiKTsKLQlEQVNTRVJUKChpbmZvICE9IE5V
TEwpLCAiZmJfaW5mb19nZW4qIG5vdCBOVUxMIik7Ci0KLQltZW1zZXQodmFyLCAwLCBzaXplb2Yo
c3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvKSk7Ci0KLSNpZmRlZiBQTTNGQl9VU0VfQUNDRUwKLQlp
ZiAoIShub2FjY2VsW2xfZmJfaW5mby0+Ym9hcmRfbnVtXSkpCi0JCXZhci0+YWNjZWxfZmxhZ3Mg
fD0gRkJfQUNDRUxGX1RFWFQ7Ci0jZW5kaWYgLyogUE0zRkJfVVNFX0FDQ0VMICovCi0KLQl2YXIt
PnhyZXNfdmlydHVhbCA9IHAtPndpZHRoOwotCXZhci0+eXJlc192aXJ0dWFsID0gcC0+aGVpZ2h0
OwotCXZhci0+eHJlcyA9IHAtPmh0b3RhbCAtIHAtPmhiZW5kOwotCXZhci0+eXJlcyA9IHAtPnZ0
b3RhbCAtIHAtPnZiZW5kOwotCi0JRFBSSU5USygyLCAieHJlcyA9ICVkLCB5cmVzIDogJWRcbiIs
IHZhci0+eHJlcywgdmFyLT55cmVzKTsKLQotCXZhci0+cmlnaHRfbWFyZ2luID0gcC0+aHNzdGFy
dDsKLQl2YXItPmhzeW5jX2xlbiA9IHAtPmhzZW5kIC0gcC0+aHNzdGFydDsKLQl2YXItPmxlZnRf
bWFyZ2luID0gcC0+aGJlbmQgLSBwLT5oc2VuZDsKLQl2YXItPmxvd2VyX21hcmdpbiA9IHAtPnZz
c3RhcnQ7Ci0JdmFyLT52c3luY19sZW4gPSBwLT52c2VuZCAtIHAtPnZzc3RhcnQ7Ci0JdmFyLT51
cHBlcl9tYXJnaW4gPSBwLT52YmVuZCAtIHAtPnZzZW5kOwotCXZhci0+Yml0c19wZXJfcGl4ZWwg
PSBkZXB0aDJicHAocC0+ZGVwdGgpOwotCQotCXBtM2ZiX2VuY29kZV9kZXB0aCh2YXIsIHAtPmRl
cHRoKTsKLQotCWJhc2UgPSBwbTNmYl9VbnNoaWZ0YnBwKGxfZmJfaW5mbywgcC0+ZGVwdGgsIHAt
PmJhc2UpOwotCi0JdmFyLT54b2Zmc2V0ID0gYmFzZSAlIHZhci0+eHJlczsKLQl2YXItPnlvZmZz
ZXQgPSBiYXNlIC8gdmFyLT54cmVzOwotCi0JdmFyLT5oZWlnaHQgPSB2YXItPndpZHRoID0gLTE7
Ci0KLQl2YXItPnBpeGNsb2NrID0gS0haMlBJQ09TKHAtPnBpeGNsb2NrKTsKLQotCWlmICgocC0+
dmlkZW8gJiBQTTNWaWRlb0NvbnRyb2xfSFNZTkNfTUFTSykgPT0KLQkgICAgUE0zVmlkZW9Db250
cm9sX0hTWU5DX0FDVElWRV9ISUdIKQotCQl2YXItPnN5bmMgfD0gRkJfU1lOQ19IT1JfSElHSF9B
Q1Q7Ci0JaWYgKChwLT52aWRlbyAmIFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19NQVNLKSA9PQotCSAg
ICBQTTNWaWRlb0NvbnRyb2xfVlNZTkNfQUNUSVZFX0hJR0gpCi0JCXZhci0+c3luYyB8PSBGQl9T
WU5DX1ZFUlRfSElHSF9BQ1Q7Ci0JaWYgKHAtPnZpZGVvICYgUE0zVmlkZW9Db250cm9sX0xJTkVf
RE9VQkxFX09OKQotCQl2YXItPnZtb2RlID0gRkJfVk1PREVfRE9VQkxFOwotCi0JcmV0dXJuICgw
KTsKLX0KLQotc3RhdGljIHZvaWQgcG0zZmJfZ2V0X3Bhcih2b2lkICpwYXIsIHN0cnVjdCBmYl9p
bmZvX2dlbiAqaW5mbykKLXsKLQlzdHJ1Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvID0gKHN0cnVj
dCBwbTNmYl9pbmZvICopIGluZm87Ci0KLQlEVFJBQ0U7Ci0KLQlpZiAoIWN1cnJlbnRfcGFyX3Zh
bGlkW2xfZmJfaW5mby0+Ym9hcmRfbnVtXSkgewotCQlpZiAobF9mYl9pbmZvLT51c2VfY3VycmVu
dCkKLQkJCXBtM2ZiX3JlYWRfbW9kZShsX2ZiX2luZm8sIGxfZmJfaW5mby0+Y3VycmVudF9wYXIp
OwotCQllbHNlCi0JCQltZW1jcHkobF9mYl9pbmZvLT5jdXJyZW50X3BhciwKLQkJCSAgICAgICAm
KG1vZGVfYmFzZVswXS51c2VyX21vZGUpLAotCQkJICAgICAgIHNpemVvZihzdHJ1Y3QgcG0zZmJf
cGFyKSk7Ci0JCWN1cnJlbnRfcGFyX3ZhbGlkW2xfZmJfaW5mby0+Ym9hcmRfbnVtXSA9IDE7Ci0J
fQotCSooKHN0cnVjdCBwbTNmYl9wYXIgKikgcGFyKSA9ICoobF9mYl9pbmZvLT5jdXJyZW50X3Bh
cik7Ci19Ci0KLXN0YXRpYyB2b2lkIHBtM2ZiX3NldF9wYXIoY29uc3Qgdm9pZCAqcGFyLCBzdHJ1
Y3QgZmJfaW5mb19nZW4gKmluZm8pCi17Ci0Jc3RydWN0IHBtM2ZiX2luZm8gKmxfZmJfaW5mbyA9
IChzdHJ1Y3QgcG0zZmJfaW5mbyAqKSBpbmZvOwotCi0JRFRSQUNFOwotCi0JKihsX2ZiX2luZm8t
PmN1cnJlbnRfcGFyKSA9ICooKHN0cnVjdCBwbTNmYl9wYXIgKikgcGFyKTsKLQljdXJyZW50X3Bh
cl92YWxpZFtsX2ZiX2luZm8tPmJvYXJkX251bV0gPSAxOwotCi0JcG0zZmJfd3JpdGVfbW9kZShs
X2ZiX2luZm8pOwotCi0jaWZkZWYgUE0zRkJfVVNFX0FDQ0VMCi0JcG0zZmJfaW5pdF9lbmdpbmUo
bF9mYl9pbmZvKTsKLSNlbmRpZiAvKiBQTTNGQl9VU0VfQUNDRUwgKi8KLX0KLQotc3RhdGljIHZv
aWQgcG0zZmJfc2V0X2NvbG9yKHN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8sCi0JCQkgICAg
dW5zaWduZWQgY2hhciByZWdubywgdW5zaWduZWQgY2hhciByLAotCQkJICAgIHVuc2lnbmVkIGNo
YXIgZywgdW5zaWduZWQgY2hhciBiKQotewotCURUUkFDRTsKLQotCVBNM19TTE9XX1dSSVRFX1JF
RyhQTTNSRF9QYWxldHRlV3JpdGVBZGRyZXNzLCByZWdubyk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVH
KFBNM1JEX1BhbGV0dGVEYXRhLCByKTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zUkRfUGFsZXR0
ZURhdGEsIGcpOwotCVBNM19TTE9XX1dSSVRFX1JFRyhQTTNSRF9QYWxldHRlRGF0YSwgYik7Ci19
Ci0KLXN0YXRpYyBpbnQgcG0zZmJfZ2V0Y29scmVnKHVuc2lnbmVkIHJlZ25vLCB1bnNpZ25lZCAq
cmVkLCB1bnNpZ25lZCAqZ3JlZW4sCi0JCQkgICB1bnNpZ25lZCAqYmx1ZSwgdW5zaWduZWQgKnRy
YW5zcCwKLQkJCSAgIHN0cnVjdCBmYl9pbmZvICppbmZvKQotewotCXN0cnVjdCBwbTNmYl9pbmZv
ICpsX2ZiX2luZm8gPSAoc3RydWN0IHBtM2ZiX2luZm8gKikgaW5mbzsKLQotCURUUkFDRTsKLQot
CWlmIChyZWdubyA8IDI1NikgewotCQkqcmVkID0KLQkJICAgIGxfZmJfaW5mby0+cGFsZXR0ZVty
ZWdub10ucmVkIDw8IDggfCBsX2ZiX2luZm8tPgotCQkgICAgcGFsZXR0ZVtyZWdub10ucmVkOwot
CQkqZ3JlZW4gPQotCQkgICAgbF9mYl9pbmZvLT5wYWxldHRlW3JlZ25vXS5ncmVlbiA8PCA4IHwg
bF9mYl9pbmZvLT4KLQkJICAgIHBhbGV0dGVbcmVnbm9dLmdyZWVuOwotCQkqYmx1ZSA9Ci0JCSAg
ICBsX2ZiX2luZm8tPnBhbGV0dGVbcmVnbm9dLmJsdWUgPDwgOCB8IGxfZmJfaW5mby0+Ci0JCSAg
ICBwYWxldHRlW3JlZ25vXS5ibHVlOwotCQkqdHJhbnNwID0KLQkJICAgIGxfZmJfaW5mby0+cGFs
ZXR0ZVtyZWdub10udHJhbnNwIDw8IDggfCBsX2ZiX2luZm8tPgotCQkgICAgcGFsZXR0ZVtyZWdu
b10udHJhbnNwOwotCX0KLQlyZXR1cm4gKHJlZ25vID4gMjU1KTsKLX0KLQotc3RhdGljIGludCBw
bTNmYl9zZXRjb2xyZWcodW5zaWduZWQgcmVnbm8sIHVuc2lnbmVkIHJlZCwgdW5zaWduZWQgZ3Jl
ZW4sCi0JCQkgICB1bnNpZ25lZCBibHVlLCB1bnNpZ25lZCB0cmFuc3AsCi0JCQkgICBzdHJ1Y3Qg
ZmJfaW5mbyAqaW5mbykKLXsKLQlzdHJ1Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvID0gKHN0cnVj
dCBwbTNmYl9pbmZvICopIGluZm87Ci0KLQlEVFJBQ0U7Ci0KLQlpZiAocmVnbm8gPCAxNikgewot
CQlzd2l0Y2ggKGxfZmJfaW5mby0+Y3VycmVudF9wYXItPmRlcHRoKSB7Ci0jaWZkZWYgRkJDT05f
SEFTX0NGQjgKLQkJY2FzZSA4OgotCQkJYnJlYWs7Ci0jZW5kaWYKLSNpZmRlZiBGQkNPTl9IQVNf
Q0ZCMTYKLQkJY2FzZSAxMjoKLQkJCWxfZmJfaW5mby0+Y21hcC5jbWFwMTJbcmVnbm9dID0KLQkJ
CQkoKCh1MzIpIHJlZCAmIDB4ZjAwMCkgPj4gNCkgfAotCQkJCSgoKHUzMikgZ3JlZW4gJiAweGYw
MDApID4+IDgpIHwKLQkJCQkoKCh1MzIpIGJsdWUgJiAweGYwMDApID4+IDEyKTsKLQkJCWJyZWFr
OwotCi0JCWNhc2UgMTU6Ci0JCQlsX2ZiX2luZm8tPmNtYXAuY21hcDE1W3JlZ25vXSA9Ci0JCQkJ
KCgodTMyKSByZWQgJiAweGY4MDApID4+IDEpIHwKLQkJCQkoKCh1MzIpIGdyZWVuICYgMHhmODAw
KSA+PiA2KSB8Ci0JCQkJKCgodTMyKSBibHVlICYgMHhmODAwKSA+PiAxMSk7Ci0JCQlicmVhazsK
LQotCQljYXNlIDE2OgotCQkJbF9mYl9pbmZvLT5jbWFwLmNtYXAxNltyZWdub10gPQotCQkJICAg
ICgodTMyKSByZWQgJiAweGY4MDApIHwKLQkJCSAgICAoKCh1MzIpIGdyZWVuICYgMHhmYzAwKSA+
PiA1KSB8Ci0JCQkgICAgKCgodTMyKSBibHVlICYgMHhmODAwKSA+PiAxMSk7Ci0JCQlicmVhazsK
LSNlbmRpZgotI2lmZGVmIEZCQ09OX0hBU19DRkIzMgotCQljYXNlIDMyOgotCQkJbF9mYl9pbmZv
LT5jbWFwLmNtYXAzMltyZWdub10gPQotCQkJICAgICgoKHUzMikgdHJhbnNwICYgMHhmZjAwKSA8
PCAxNikgfAotCQkJICAgICgoKHUzMikgcmVkICYgMHhmZjAwKSA8PCA4KSB8Ci0JCQkgICAgKCgo
dTMyKSBncmVlbiAmIDB4ZmYwMCkpIHwKLQkJCSAgICAoKCh1MzIpIGJsdWUgJiAweGZmMDApID4+
IDgpOwotCQkJYnJlYWs7Ci0jZW5kaWYKLQkJZGVmYXVsdDoKLQkJCURQUklOVEsoMSwgImJhZCBk
ZXB0aCAldVxuIiwKLQkJCQlsX2ZiX2luZm8tPmN1cnJlbnRfcGFyLT5kZXB0aCk7Ci0JCQlicmVh
azsKLQkJfQotCX0KLQlpZiAocmVnbm8gPCAyNTYpIHsKLQkJbF9mYl9pbmZvLT5wYWxldHRlW3Jl
Z25vXS5yZWQgPSByZWQgPj4gODsKLQkJbF9mYl9pbmZvLT5wYWxldHRlW3JlZ25vXS5ncmVlbiA9
IGdyZWVuID4+IDg7Ci0JCWxfZmJfaW5mby0+cGFsZXR0ZVtyZWdub10uYmx1ZSA9IGJsdWUgPj4g
ODsKLQkJbF9mYl9pbmZvLT5wYWxldHRlW3JlZ25vXS50cmFuc3AgPSB0cmFuc3AgPj4gODsKLQkJ
aWYgKGxfZmJfaW5mby0+Y3VycmVudF9wYXItPmRlcHRoID09IDgpCi0JCQlwbTNmYl9zZXRfY29s
b3IobF9mYl9pbmZvLCByZWdubywgcmVkID4+IDgsCi0JCQkJCWdyZWVuID4+IDgsIGJsdWUgPj4g
OCk7Ci0JfQotCXJldHVybiAocmVnbm8gPiAyNTUpOworCXBhci0+YmFzZSA9IHBtM2ZiX3NoaWZ0
X2JwcCh2YXItPmJpdHNfcGVyX3BpeGVsLAorCQkJCQkodmFyLT55b2Zmc2V0ICogeHJlcykKKwkJ
CQkJKyB2YXItPnhvZmZzZXQpOworCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBNM1NjcmVlbkJh
c2UsIHBhci0+YmFzZSk7CisJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBpbnQgcG0zZmJfYmxhbmso
aW50IGJsYW5rX21vZGUsIHN0cnVjdCBmYl9pbmZvX2dlbiAqaW5mbykKK3N0YXRpYyBpbnQgcG0z
ZmJfYmxhbmsoaW50IGJsYW5rX21vZGUsIHN0cnVjdCBmYl9pbmZvICppbmZvKQogewotCXN0cnVj
dCBwbTNmYl9pbmZvICpsX2ZiX2luZm8gPSAoc3RydWN0IHBtM2ZiX2luZm8gKikgaW5mbzsKLQl1
MzIgdmlkZW87Ci0KLQlEVFJBQ0U7Ci0KLQlpZiAoIWN1cnJlbnRfcGFyX3ZhbGlkW2xfZmJfaW5m
by0+Ym9hcmRfbnVtXSkKLQkJcmV0dXJuICgxKTsKLQotCXZpZGVvID0gbF9mYl9pbmZvLT5jdXJy
ZW50X3Bhci0+dmlkZW87CisJc3RydWN0IHBtM19wYXIgKnBhciA9IGluZm8tPnBhcjsKKwl1MzIg
dmlkZW8gPSBwYXItPnZpZGVvOwogCiAJLyoKIAkgKiBPeHlnZW4gVlgxIC0gaXQgYXBwZWFycyB0
aGF0IHNldHRpbmcgUE0zVmlkZW9Db250cm9sIGFuZApAQCAtMzIwMiw0MzMgKzY5NCwzMjUgQEAg
c3RhdGljIGludCBwbTNmYl9ibGFuayhpbnQgYmxhbmtfbW9kZSwgcwogCQkJCQkgIFBNM1ZpZGVv
Q29udHJvbF9CTEFOS19BQ1RJVkVfTE9XKTsKIAkJCWJyZWFrOwogCQlkZWZhdWx0OgotCQkJRFBS
SU5USygxLCAiVW5zdXBwb3J0ZWQgYmxhbmtpbmcgJWRcbiIsCi0JCQkJYmxhbmtfbW9kZSk7Ci0J
CQlyZXR1cm4gKDEpOwotCQkJYnJlYWs7CisJCQlEUFJJTlRLKCJVbnN1cHBvcnRlZCBibGFua2lu
ZyAlZFxuIiwgYmxhbmtfbW9kZSk7CisJCQlyZXR1cm4gMTsKIAkJfQogCX0KIAotCVBNM19TTE9X
X1dSSVRFX1JFRyhQTTNWaWRlb0NvbnRyb2wsIHZpZGVvKTsKKwlQTTNfU0xPV19XUklURV9SRUco
cGFyLFBNM1ZpZGVvQ29udHJvbCwgdmlkZW8pOwogCi0JcmV0dXJuICgwKTsKKwlyZXR1cm4gMDsK
IH0KIAotc3RhdGljIHZvaWQgcG0zZmJfc2V0X2Rpc3AoY29uc3Qgdm9pZCAqcGFyLCBzdHJ1Y3Qg
ZGlzcGxheSAqZGlzcCwKLQkJCSAgIHN0cnVjdCBmYl9pbmZvX2dlbiAqaW5mbykKLXsKLQlzdHJ1
Y3QgcG0zZmJfaW5mbyAqbF9mYl9pbmZvID0gKHN0cnVjdCBwbTNmYl9pbmZvICopIGluZm87Ci0J
c3RydWN0IHBtM2ZiX3BhciAqcCA9IChzdHJ1Y3QgcG0zZmJfcGFyICopIHBhcjsKLQl1MzIgZmxh
Z3M7CisJLyoKKwkgKiAgRnJhbWUgYnVmZmVyIG9wZXJhdGlvbnMKKwkgKi8KIAotCURUUkFDRTsK
K3N0YXRpYyBzdHJ1Y3QgZmJfb3BzIHBtM2ZiX29wcyA9IHsKKwkub3duZXIJCT0gVEhJU19NT0RV
TEUsCisJLmZiX2NoZWNrX3Zhcgk9IHBtM2ZiX2NoZWNrX3ZhciwKKwkuZmJfc2V0X3Bhcgk9IHBt
M2ZiX3NldF9wYXIsCisJLmZiX3NldGNvbHJlZwk9IHBtM2ZiX3NldGNvbHJlZywKKwkuZmJfcGFu
X2Rpc3BsYXkJPSBwbTNmYl9wYW5fZGlzcGxheSwKKwkuZmJfZmlsbHJlY3QJPSBjZmJfZmlsbHJl
Y3QsCQkvKiBOZWVkZWQgISEhICovCisJLmZiX2NvcHlhcmVhCT0gY2ZiX2NvcHlhcmVhLAkJLyog
TmVlZGVkICEhISAqLworCS5mYl9pbWFnZWJsaXQJPSBjZmJfaW1hZ2VibGl0LAkvKiBOZWVkZWQg
ISEhICovCisJLmZiX2JsYW5rCT0gcG0zZmJfYmxhbmssCit9OwogCi0JbG9jYWxfaXJxX3NhdmUo
ZmxhZ3MpOwotCWluZm8tPmluZm8uc2NyZWVuX2Jhc2UgPSBsX2ZiX2luZm8tPnZfZmI7Ci0Jc3dp
dGNoIChwLT5kZXB0aCkgewotI2lmZGVmIEZCQ09OX0hBU19DRkI4Ci0JY2FzZSA4OgotI2lmZGVm
IFBNM0ZCX1VTRV9BQ0NFTAotCQlpZiAoIShub2FjY2VsW2xfZmJfaW5mby0+Ym9hcmRfbnVtXSkp
Ci0JCQlkaXNwLT5kaXNwc3cgPSAmcG0zZmJfY2ZiODsKLQkJZWxzZQotI2VuZGlmIC8qIFBNM0ZC
X1VTRV9BQ0NFTCAqLwotCQkJZGlzcC0+ZGlzcHN3ID0gJmZiY29uX2NmYjg7Ci0JCWJyZWFrOwot
I2VuZGlmCi0jaWZkZWYgRkJDT05fSEFTX0NGQjE2Ci0JY2FzZSAxMjoKLSNpZmRlZiBQTTNGQl9V
U0VfQUNDRUwKLQkJaWYgKCEobm9hY2NlbFtsX2ZiX2luZm8tPmJvYXJkX251bV0pKQotCQkJZGlz
cC0+ZGlzcHN3ID0gJnBtM2ZiX2NmYjE2OwotCQllbHNlCi0jZW5kaWYgLyogUE0zRkJfVVNFX0FD
Q0VMICovCi0JCQlkaXNwLT5kaXNwc3cgPSAmZmJjb25fY2ZiMTY7Ci0JCWRpc3AtPmRpc3Bzd19k
YXRhID0gbF9mYl9pbmZvLT5jbWFwLmNtYXAxMjsKLQkJYnJlYWs7Ci0JY2FzZSAxNToKLSNpZmRl
ZiBQTTNGQl9VU0VfQUNDRUwKLQkJaWYgKCEobm9hY2NlbFtsX2ZiX2luZm8tPmJvYXJkX251bV0p
KQotCQkJZGlzcC0+ZGlzcHN3ID0gJnBtM2ZiX2NmYjE2OwotCQllbHNlCi0jZW5kaWYgLyogUE0z
RkJfVVNFX0FDQ0VMICovCi0JCQlkaXNwLT5kaXNwc3cgPSAmZmJjb25fY2ZiMTY7Ci0JCWRpc3At
PmRpc3Bzd19kYXRhID0gbF9mYl9pbmZvLT5jbWFwLmNtYXAxNTsKLQkJYnJlYWs7Ci0JY2FzZSAx
NjoKLSNpZmRlZiBQTTNGQl9VU0VfQUNDRUwKLQkJaWYgKCEobm9hY2NlbFtsX2ZiX2luZm8tPmJv
YXJkX251bV0pKQotCQkJZGlzcC0+ZGlzcHN3ID0gJnBtM2ZiX2NmYjE2OwotCQllbHNlCi0jZW5k
aWYgLyogUE0zRkJfVVNFX0FDQ0VMICovCi0JCQlkaXNwLT5kaXNwc3cgPSAmZmJjb25fY2ZiMTY7
Ci0JCWRpc3AtPmRpc3Bzd19kYXRhID0gbF9mYl9pbmZvLT5jbWFwLmNtYXAxNjsKLQkJYnJlYWs7
Ci0jZW5kaWYKLSNpZmRlZiBGQkNPTl9IQVNfQ0ZCMzIKLQljYXNlIDMyOgotI2lmZGVmIFBNM0ZC
X1VTRV9BQ0NFTAotCQlpZiAoIShub2FjY2VsW2xfZmJfaW5mby0+Ym9hcmRfbnVtXSkpCi0JCQlk
aXNwLT5kaXNwc3cgPSAmcG0zZmJfY2ZiMzI7Ci0JCWVsc2UKLSNlbmRpZiAvKiBQTTNGQl9VU0Vf
QUNDRUwgKi8KLQkJCWRpc3AtPmRpc3BzdyA9ICZmYmNvbl9jZmIzMjsKLQkJZGlzcC0+ZGlzcHN3
X2RhdGEgPSBsX2ZiX2luZm8tPmNtYXAuY21hcDMyOwotCQlicmVhazsKLSNlbmRpZiAvKiBGQkNP
Tl9IQVNfQ0ZCMzIgKi8KLQlkZWZhdWx0OgotCQlkaXNwLT5kaXNwc3cgPSAmZmJjb25fZHVtbXk7
Ci0JCURQUklOVEsoMSwgIkludmFsaWQgZGVwdGgsIHVzaW5nIGZiY29uX2R1bW15XG4iKTsKLQkJ
YnJlYWs7Ci0JfQotCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKLX0KKy8qIC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0gKi8KIAotLyogKi8KLXN0YXRpYyB2b2lkIHBtM2ZiX2RldGVjdCh2b2lkKQotewotCXN0
cnVjdCBwY2lfZGV2ICpkZXZfYXJyYXlbUE0zX01BWF9CT0FSRF07Ci0Jc3RydWN0IHBjaV9kZXYg
KmRldiA9IE5VTEw7Ci0Jc3RydWN0IHBtM2ZiX2luZm8gKmxfZmJfaW5mbyA9ICYoZmJfaW5mb1sw
XSk7Ci0JdW5zaWduZWQgbG9uZyBpLCBqLCBkb25lOworCS8qCisJICogIEluaXRpYWxpemF0aW9u
CisJICovCiAKLQlEVFJBQ0U7CisvKiBtbWlvIHJlZ2lzdGVyIGFyZSBhbHJlYWR5IG1hcHBlZCB3
aGVuIHRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkICovCisvKiB0aGUgcG0zZmJfZml4LnNtZW1fc3Rh
cnQgaXMgYWxzbyBzZXQgKi8KK3N0YXRpYyB1bnNpZ25lZCBsb25nIHBtM2ZiX3NpemVfbWVtb3J5
KHN0cnVjdCBwbTNfcGFyICpwYXIpCit7CisJdW5zaWduZWQgbG9uZwltZW1zaXplID0gMCwgdGVt
cEJ5cGFzcywgaSwgdGVtcDEsIHRlbXAyOworCXVuc2lnbmVkIGNoYXIJX19pb21lbSAqc2NyZWVu
X21lbTsKIAotCWZvciAoaSA9IDA7IGkgPCBQTTNfTUFYX0JPQVJEOyBpKyspIHsKLQkJZGV2X2Fy
cmF5W2ldID0gTlVMTDsKLQkJZmJfaW5mb1tpXS5kZXYgPSBOVUxMOworCXBtM2ZiX2ZpeC5zbWVt
X2xlbiA9IDY0ICogMTAyNCAqIDEwMjQ7IC8qIHJlcXVlc3QgZnVsbCBhcGVydHVyZSBzaXplICov
CisJLyogTGluZWFyIGZyYW1lIGJ1ZmZlciAtIHJlcXVlc3QgcmVnaW9uIGFuZCBtYXAgaXQuICov
CisJaWYgKCAhcmVxdWVzdF9tZW1fcmVnaW9uKHBtM2ZiX2ZpeC5zbWVtX3N0YXJ0LCBwbTNmYl9m
aXguc21lbV9sZW4sCisJCQkJICJwbTNmYiBzbWVtIikgKSB7CisJCXByaW50ayhLRVJOX1dBUk5J
TkcgInBtM2ZiOiBDYW4ndCByZXNlcnZlIHNtZW0uXG4iKTsKKwkJcmV0dXJuIDA7CisJfQorCXNj
cmVlbl9tZW0gPQorCQlpb3JlbWFwX25vY2FjaGUocG0zZmJfZml4LnNtZW1fc3RhcnQsIHBtM2Zi
X2ZpeC5zbWVtX2xlbik7CisJaWYgKCAhc2NyZWVuX21lbSApIHsKKwkJcHJpbnRrKEtFUk5fV0FS
TklORyAicG0zZmI6IENhbid0IGlvcmVtYXAgc21lbSBhcmVhLlxuIik7CisJCXJlbGVhc2VfbWVt
X3JlZ2lvbihwbTNmYl9maXguc21lbV9zdGFydCwgcG0zZmJfZml4LnNtZW1fbGVuKTsKKwkJcmV0
dXJuIDA7CiAJfQogCi0JZGV2ID0gcGNpX2dldF9kZXZpY2UoUENJX1ZFTkRPUl9JRF8zRExBQlMs
Ci0JCQkgICAgUENJX0RFVklDRV9JRF8zRExBQlNfUEVSTUVESUEzLCBkZXYpOworCS8qIFRPRE86
IGNhcmQtc3BlY2lmaWMgc3R1ZmYsICpiZWZvcmUqIGFjY2Vzc2luZyAqYW55KiBGQiBtZW1vcnkg
Ki8KKwkvKiBGb3IgQXBwaWFuIEplcm9uaW1vIDIwMDAgYm9hcmQgc2Vjb25kIGhlYWQgKi8KIAot
CWZvciAoaSA9IDA7ICgoaSA8IFBNM19NQVhfQk9BUkQpICYmIGRldik7IGkrKykgewotCQlkZXZf
YXJyYXlbaV0gPSBkZXY7Ci0JCWRldiA9IHBjaV9nZXRfZGV2aWNlKFBDSV9WRU5ET1JfSURfM0RM
QUJTLAotCQkJCSAgICBQQ0lfREVWSUNFX0lEXzNETEFCU19QRVJNRURJQTMsIGRldik7Ci0JfQor
CXRlbXBCeXBhc3MgPSBQTTNfUkVBRF9SRUcocGFyLCBQTTNNZW1CeXBhc3NXcml0ZU1hc2spOwog
Ci0JaWYgKGRldikgewkJLyogbW9yZSB0aGFuIFBNM19NQVhfQk9BUkQgKi8KLQkJcHJpbnRrKEtF
Uk5fV0FSTklORyAicG0zZmI6IFdhcm5pbmc6IG1vcmUgdGhhbiAlZCBib2FyZHMgZm91bmRcbiIs
Ci0JCSAgICAgICBQTTNfTUFYX0JPQVJEKTsKLQl9CisJRFBSSU5USygiUE0zTWVtQnlwYXNzV3Jp
dGVNYXNrIHdhczogMHglMDhseFxuIiwgdGVtcEJ5cGFzcyk7CiAKLQlpZiAoIWRldl9hcnJheVsw
XSkgewkvKiBub3QgYSBzaW5nbGUgYm9hcmQsIGFib3J0ICovCi0JCXJldHVybjsKLQl9CisJUE0z
X1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zTWVtQnlwYXNzV3JpdGVNYXNrLCAweEZGRkZGRkZGKTsK
IAotCS8qIGFsbG9jYXRlIHVzZXItZGVmaW5lZCBib2FyZHMgKi8KLQlmb3IgKGkgPSAwOyBpIDwg
UE0zX01BWF9CT0FSRDsgaSsrKSB7Ci0JCWlmICgoYnVzW2ldID49IDApICYmIChzbG90W2ldID49
IDApICYmIChmdW5jW2ldID49IDApKSB7Ci0JCQlmb3IgKGogPSAwOyBqIDwgUE0zX01BWF9CT0FS
RDsgaisrKSB7Ci0JCQkJaWYgKChkZXZfYXJyYXlbal0gIT0gTlVMTCkgJiYKLQkJCQkgICAgKGRl
dl9hcnJheVtqXS0+YnVzLT5udW1iZXIgPT0gYnVzW2ldKQotCQkJCSAgICAmJiAoUENJX1NMT1Qo
ZGV2X2FycmF5W2pdLT5kZXZmbikgPT0KLQkJCQkJc2xvdFtpXSkKLQkJCQkgICAgJiYgKFBDSV9G
VU5DKGRldl9hcnJheVtqXS0+ZGV2Zm4pID09Ci0JCQkJCWZ1bmNbaV0pKSB7Ci0JCQkJCWZiX2lu
Zm9baV0uZGV2ID0gZGV2X2FycmF5W2pdOwotCQkJCQlkZXZfYXJyYXlbal0gPSBOVUxMOwotCQkJ
CX0KLQkJCX0KLQkJfQotCX0KLQkvKiBhbGxvY2F0ZSByZW1haW5pbmcgYm9hcmRzICovCi0JZm9y
IChpID0gMDsgaSA8IFBNM19NQVhfQk9BUkQ7IGkrKykgewotCQlpZiAoZmJfaW5mb1tpXS5kZXYg
PT0gTlVMTCkgewotCQkJZG9uZSA9IDA7Ci0JCQlmb3IgKGogPSAwOyAoKGogPCBQTTNfTUFYX0JP
QVJEKSAmJiAoIWRvbmUpKTsgaisrKSB7Ci0JCQkJaWYgKGRldl9hcnJheVtqXSAhPSBOVUxMKSB7
Ci0JCQkJCWZiX2luZm9baV0uZGV2ID0gZGV2X2FycmF5W2pdOwotCQkJCQlkZXZfYXJyYXlbal0g
PSBOVUxMOwotCQkJCQlkb25lID0gMTsKLQkJCQl9Ci0JCQl9Ci0JCX0KKwkvKiBwbTMgc3BsaXQg
dXAgbWVtb3J5LCByZXBsaWNhdGVzLCBhbmQgZG8gYSBsb3Qgb2YgbmFzdHkgc3R1ZmYgSU1ITyA7
LSkgKi8KKwlmb3IgKGkgPSAwOyBpIDwgMzI7IGkrKykgeworCQlmYl93cml0ZWwoaSAqIDB4MDAz
NDU2NzgsCisJCQkgIChzY3JlZW5fbWVtICsgKGkgKiAxMDQ4NTc2KSkpOworCQltYigpOworCQl0
ZW1wMSA9IGZiX3JlYWRsKChzY3JlZW5fbWVtICsgKGkgKiAxMDQ4NTc2KSkpOworCisJCS8qIExl
dCdzIGNoZWNrIGZvciB3cmFwb3Zlciwgd3JpdGUgd2lsbCBmYWlsIGF0IDE2TUIgYm91bmRhcnkg
Ki8KKwkJaWYgKHRlbXAxID09IChpICogMHgwMDM0NTY3OCkpCisJCQltZW1zaXplID0gaTsKKwkJ
ZWxzZQorCQkJYnJlYWs7CiAJfQogCi0JLyogYXQgdGhhdCBwb2ludCwgYWxsIFBDSSBQZXJtZWRp
YTMgYXJlIGRldGVjdGVkIGFuZCBhbGxvY2F0ZWQgKi8KLQkvKiBub3csIGluaXRpYWxpemUuLi4g
b3Igbm90ICovCi0JZm9yIChpID0gMDsgaSA8IFBNM19NQVhfQk9BUkQ7IGkrKykgewotCQlsX2Zi
X2luZm8gPSAmKGZiX2luZm9baV0pOwotCQlpZiAobF9mYl9pbmZvLT5kZXYgJiYgIWRpc2FibGVb
aV0pIHsJLyogUENJIGRldmljZSB3YXMgZm91bmQgYW5kIG5vdCBkaXNhYmxlZCBieSB1c2VyICov
Ci0JCQlEUFJJTlRLKDIsCi0JCQkJImZvdW5kIEAlbHggVmVuZG9yICVseCBEZXZpY2UgJWx4IDsg
YmFzZSBAIDogJWx4IC0gJWx4IC0gJWx4IC0gJWx4IC0gJWx4IC0gJWx4LCBpcnEgJWxkXG4iLAot
CQkJCSh1bnNpZ25lZCBsb25nKSBsX2ZiX2luZm8tPmRldiwKLQkJCQkodW5zaWduZWQgbG9uZykg
bF9mYl9pbmZvLT5kZXYtPnZlbmRvciwKLQkJCQkodW5zaWduZWQgbG9uZykgbF9mYl9pbmZvLT5k
ZXYtPmRldmljZSwKLQkJCQkodW5zaWduZWQgbG9uZykKLQkJCQlwY2lfcmVzb3VyY2Vfc3RhcnQo
bF9mYl9pbmZvLT5kZXYsIDApLAotCQkJCSh1bnNpZ25lZCBsb25nKQotCQkJCXBjaV9yZXNvdXJj
ZV9zdGFydChsX2ZiX2luZm8tPmRldiwgMSksCi0JCQkJKHVuc2lnbmVkIGxvbmcpCi0JCQkJcGNp
X3Jlc291cmNlX3N0YXJ0KGxfZmJfaW5mby0+ZGV2LCAyKSwKLQkJCQkodW5zaWduZWQgbG9uZykK
LQkJCQlwY2lfcmVzb3VyY2Vfc3RhcnQobF9mYl9pbmZvLT5kZXYsIDMpLAotCQkJCSh1bnNpZ25l
ZCBsb25nKQotCQkJCXBjaV9yZXNvdXJjZV9zdGFydChsX2ZiX2luZm8tPmRldiwgNCksCi0JCQkJ
KHVuc2lnbmVkIGxvbmcpCi0JCQkJcGNpX3Jlc291cmNlX3N0YXJ0KGxfZmJfaW5mby0+ZGV2LCA1
KSwKLQkJCQkodW5zaWduZWQgbG9uZykgbF9mYl9pbmZvLT5kZXYtPmlycSk7Ci0KLQkJCWxfZmJf
aW5mby0+cElPQmFzZSA9Ci0JCQkgICAgKHVuc2lnbmVkIGNoYXIgKikKLQkJCSAgICBwY2lfcmVz
b3VyY2Vfc3RhcnQobF9mYl9pbmZvLT5kZXYsIDApOwotI2lmZGVmIF9fQklHX0VORElBTgotCQkJ
bF9mYl9pbmZvLT5wSU9CYXNlICs9IFBNM19SRUdTX1NJWkU7Ci0jZW5kaWYKLQkJCWxfZmJfaW5m
by0+dklPQmFzZSA9ICh1bnNpZ25lZCBjaGFyICopIC0xOwotCQkJbF9mYl9pbmZvLT5wX2ZiID0K
LQkJCSAgICAodW5zaWduZWQgY2hhciAqKQotCQkJICAgIHBjaV9yZXNvdXJjZV9zdGFydChsX2Zi
X2luZm8tPmRldiwgMSk7Ci0JCQlsX2ZiX2luZm8tPnZfZmIgPSAodW5zaWduZWQgY2hhciAqKSAt
MTsKLQotCQkJCWlmICghcmVxdWVzdF9tZW1fcmVnaW9uCi0JCQkgICAgKCh1bnNpZ25lZCBsb25n
KWxfZmJfaW5mby0+cF9mYiwgNjQgKiAxMDI0ICogMTAyNCwgLyogcmVxdWVzdCBmdWxsIGFwZXJ0
dXJlIHNpemUgKi8KLQkJCSAgICAgInBtM2ZiIikpIHsKLQkJCQlwcmludGsKLQkJCQkgICAgKEtF
Uk5fRVJSICJwbTNmYjogRXJyb3I6IGNvdWxkbid0IHJlcXVlc3QgZnJhbWVidWZmZXIgbWVtb3J5
LCBib2FyZCAjJWxkXG4iLAotCQkJCSAgICAgbF9mYl9pbmZvLT5ib2FyZF9udW0pOwotCQkJCWNv
bnRpbnVlOwotCQkJfQotCQkJaWYgKCFyZXF1ZXN0X21lbV9yZWdpb24KLQkJCSAgICAoKHVuc2ln
bmVkIGxvbmcpbF9mYl9pbmZvLT5wSU9CYXNlLCBQTTNfUkVHU19TSVpFLAotCQkJICAgICAicG0z
ZmIgSS9PIHJlZ3MiKSkgewotCQkJCXByaW50awotCQkJCSAgICAoS0VSTl9FUlIgInBtM2ZiOiBF
cnJvcjogY291bGRuJ3QgcmVxdWVzdCBJT2Jhc2UgbWVtb3J5LCBib2FyZCAjJWxkXG4iLAotCQkJ
CSAgICAgbF9mYl9pbmZvLT5ib2FyZF9udW0pOwotCQkJCWNvbnRpbnVlOwotCQkJfQotCQkJaWYg
KGZvcmNlc2l6ZVtsX2ZiX2luZm8tPmJvYXJkX251bV0pCi0JCQkJbF9mYl9pbmZvLT5mYl9zaXpl
ID0gZm9yY2VzaXplW2xfZmJfaW5mby0+Ym9hcmRfbnVtXTsKKwlEUFJJTlRLKCJGaXJzdCBkZXRl
Y3QgcGFzcyBhbHJlYWR5IGdvdCAlbGQgTUJcbiIsIG1lbXNpemUgKyAxKTsKIAotCQkJbF9mYl9p
bmZvLT5mYl9zaXplID0KLQkJCSAgICBwbTNmYl9zaXplX21lbW9yeShsX2ZiX2luZm8pOwotCQkJ
CWlmIChsX2ZiX2luZm8tPmZiX3NpemUpIHsKLQkJCQkodm9pZCkgcGNpX2VuYWJsZV9kZXZpY2Uo
bF9mYl9pbmZvLT5kZXYpOwotCQkJCXBtM2ZiX2NvbW1vbl9pbml0KGxfZmJfaW5mbyk7Ci0JCQl9
IGVsc2UKLQkJCQlwcmludGsoS0VSTl9FUlIgInBtM2ZiOiBtZW1vcnkgcHJvYmxlbSwgbm90IGVu
YWJsaW5nIGJvYXJkICMlbGRcbiIsIGxfZmJfaW5mby0+Ym9hcmRfbnVtKTsKKwlpZiAobWVtc2l6
ZSArIDEgPT0gaSkgeworCQlmb3IgKGkgPSAwOyBpIDwgMzI7IGkrKykgeworCQkJLyogQ2xlYXIg
Zmlyc3QgMzJNQiA7IDAgaXMgMCwgbm8gbmVlZCB0byBieXRlc3dhcCAqLworCQkJd3JpdGVsKDB4
MDAwMDAwMCwKKwkJCSAgICAgICAoc2NyZWVuX21lbSArIChpICogMTA0ODU3NikpKTsKKwkJCW1i
KCk7CisJCX0KKworCQlmb3IgKGkgPSAzMjsgaSA8IDY0OyBpKyspIHsKKwkJCWZiX3dyaXRlbChp
ICogMHgwMDM0NTY3OCwKKwkJCQkgIChzY3JlZW5fbWVtICsgKGkgKiAxMDQ4NTc2KSkpOworCQkJ
bWIoKTsKKwkJCXRlbXAxID0KKwkJCSAgICBmYl9yZWFkbCgoc2NyZWVuX21lbSArIChpICogMTA0
ODU3NikpKTsKKwkJCXRlbXAyID0KKwkJCSAgICBmYl9yZWFkbCgoc2NyZWVuX21lbSArICgoaSAt
IDMyKSAqIDEwNDg1NzYpKSk7CisJCQkvKiBkaWZmZXJlbnQgdmFsdWUsIGRpZmZlcmVudCBSQU0u
Li4gKi8KKwkJCWlmICgodGVtcDEgPT0gKGkgKiAweDAwMzQ1Njc4KSkgJiYgKHRlbXAyID09IDAp
KQorCQkJCW1lbXNpemUgPSBpOworCQkJZWxzZQorCQkJCWJyZWFrOwogCQl9CiAJfQotfQorCURQ
UklOVEsoIlNlY29uZCBkZXRlY3QgcGFzcyBnb3QgJWxkIE1CXG4iLCBtZW1zaXplICsgMSk7CiAK
LXN0YXRpYyBpbnQgcG0zZmJfcGFuX2Rpc3BsYXkoY29uc3Qgc3RydWN0IGZiX3Zhcl9zY3JlZW5p
bmZvICp2YXIsCi0JCQkgICAgIHN0cnVjdCBmYl9pbmZvX2dlbiAqaW5mbykKLXsKLQlzdHJ1Y3Qg
cG0zZmJfaW5mbyAqbF9mYl9pbmZvID0gKHN0cnVjdCBwbTNmYl9pbmZvICopIGluZm87CisJUE0z
X1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zTWVtQnlwYXNzV3JpdGVNYXNrLCB0ZW1wQnlwYXNzKTsK
IAotCURUUkFDRTsKKwlpb3VubWFwKHNjcmVlbl9tZW0pOworCXJlbGVhc2VfbWVtX3JlZ2lvbihw
bTNmYl9maXguc21lbV9zdGFydCwgcG0zZmJfZml4LnNtZW1fbGVuKTsKKwltZW1zaXplID0gMTA0
ODU3NiAqIChtZW1zaXplICsgMSk7CiAKLQlpZiAoIWN1cnJlbnRfcGFyX3ZhbGlkW2xfZmJfaW5m
by0+Ym9hcmRfbnVtXSkKLQkJcmV0dXJuIC1FSU5WQUw7CisJRFBSSU5USygiUmV0dXJuaW5nIDB4
JTA4bHggYnl0ZXNcbiIsIG1lbXNpemUpOwogCi0JbF9mYl9pbmZvLT5jdXJyZW50X3Bhci0+YmFz
ZSA9CS8qIGluIDEyOCBiaXRzIGNodW5rIC0gaS5lLiBBRlRFUiBTaGlmdGJwcCAqLwotCSAgICBw
bTNmYl9TaGlmdGJwcChsX2ZiX2luZm8sCi0JCQkgICBsX2ZiX2luZm8tPmN1cnJlbnRfcGFyLT5k
ZXB0aCwKLQkJCSAgICh2YXItPnlvZmZzZXQgKiBsX2ZiX2luZm8tPmN1cnJlbnRfcGFyLT53aWR0
aCkgKwotCQkJICAgdmFyLT54b2Zmc2V0KTsKLQlQTTNfU0xPV19XUklURV9SRUcoUE0zU2NyZWVu
QmFzZSwgbF9mYl9pbmZvLT5jdXJyZW50X3Bhci0+YmFzZSk7Ci0JcmV0dXJuIDA7CisJcmV0dXJu
IG1lbXNpemU7CiB9CiAKLXN0YXRpYyBpbnQgcG0zZmJfaW9jdGwoc3RydWN0IGZiX2luZm8gKmlu
Zm8sIHVfaW50IGNtZCwgdV9sb25nIGFyZykKK3N0YXRpYyBpbnQgX19kZXZpbml0IHBtM2ZiX3By
b2JlKHN0cnVjdCBwY2lfZGV2ICpkZXYsCisJCQkJICBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9p
ZCAqZW50KQogewotCXN0cnVjdCBwbTNmYl9pbmZvICpsX2ZiX2luZm8gPSAoc3RydWN0IHBtM2Zi
X2luZm8gKikgaW5mbzsKLQl1MzIgY20sIGk7Ci0jaWZkZWYgUE0zRkJfTUFTVEVSX0RFQlVHCi0J
Y2hhciBjY1szXTsKLSNlbmRpZiAvKiBQTTNGQl9NQVNURVJfREVCVUcgKi8KKwlzdHJ1Y3QgZmJf
aW5mbyAqaW5mbzsKKwlzdHJ1Y3QgcG0zX3BhciAqcGFyOworCXN0cnVjdCBkZXZpY2UqIGRldmlj
ZSA9ICZkZXYtPmRldjsgLyogZm9yIHBjaSBkcml2ZXJzICovCisJaW50IGVyciwgcmV0dmFsID0g
LUVOWElPOwogCi0Jc3dpdGNoKGNtZCkKLQl7Ci0jaWZkZWYgUE0zRkJfTUFTVEVSX0RFQlVHCi0J
Y2FzZSBQTTNGQklPX0NMRUFSTUVNT1JZOgotCQlpZiAoY29weV9mcm9tX3VzZXIoJmNtLCAodm9p
ZCAqKWFyZywgc2l6ZW9mKHUzMikpKQotCQkJcmV0dXJuKC1FRkFVTFQpOwotCQlwbTNmYl9jbGVh
cl9tZW1vcnkobF9mYl9pbmZvLCBjbSk7Ci0JCXJldHVybigwKTsKLQkJYnJlYWs7CisJZXJyID0g
cGNpX2VuYWJsZV9kZXZpY2UoZGV2KTsKKwlpZiAoZXJyKSB7CisJCXByaW50ayhLRVJOX1dBUk5J
TkcgInBtM2ZiOiBDYW4ndCBlbmFibGUgUENJIGRldjogJWRcbiIsIGVycik7CisJCXJldHVybiBl
cnI7CisJfQorCS8qCisJICogRHluYW1pY2FsbHkgYWxsb2NhdGUgaW5mbyBhbmQgcGFyCisJICov
CisJaW5mbyA9IGZyYW1lYnVmZmVyX2FsbG9jKHNpemVvZihzdHJ1Y3QgcG0zX3BhciksIGRldmlj
ZSk7CiAKLQljYXNlIFBNM0ZCSU9fQ0xFQVJDTUFQOgotCQlpZiAoY29weV9mcm9tX3VzZXIoY2Ms
ICh2b2lkKilhcmcsIDMgKiBzaXplb2YoY2hhcikpKQotCQkJcmV0dXJuKC1FRkFVTFQpOwotCQlw
bTNmYl9jbGVhcl9jb2xvcm1hcChsX2ZiX2luZm8sIGNjWzBdLCBjY1sxXSwgY2NbMl0pOwotCQly
ZXR1cm4oMCk7Ci0JCWJyZWFrOwotI2VuZGlmIC8qIFBNM0ZCX01BU1RFUl9ERUJVRyAqLworCWlm
ICghaW5mbykKKwkJcmV0dXJuIC1FTk9NRU07CisJcGFyID0gaW5mby0+cGFyOwogCi0JY2FzZSBQ
TTNGQklPX1JFU0VUQ0hJUDoKLQkJY20gPSAxOwotCQlQTTNfU0xPV19XUklURV9SRUcoUE0zUmVz
ZXRTdGF0dXMsIDEpOwotCQlmb3IgKGkgPSAwIDsgKGkgPCAxMDAwMCkgJiYgY20gOyBpKyspCi0J
CXsKLQkJCVBNM19ERUxBWSgxMCk7Ci0JCQljbSA9IFBNM19SRUFEX1JFRyhQTTNSZXNldFN0YXR1
cyk7Ci0JCX0KLQkJaWYgKGNtKQotCQl7Ci0JCQlwcmludGsoS0VSTl9FUlIgInBtM2ZiOiBjaGlw
IHJlc2V0IGZhaWxlZCB3aXRoIHN0YXR1cyAweCV4XG4iLCBjbSk7Ci0JCQlyZXR1cm4oLUVJTyk7
Ci0JCX0KLQkJLyogZmlyc3QgdGhpbmcgZmlyc3QsIHJlbG9hZCBtZW1vcnkgdGltaW5ncyAqLwot
CQlwbTNmYl93cml0ZV9tZW1vcnlfdGltaW5ncyhsX2ZiX2luZm8pOwotI2lmZGVmIFBNM0ZCX1VT
RV9BQ0NFTAotCQlwbTNmYl9pbml0X2VuZ2luZShsX2ZiX2luZm8pOwotI2VuZGlmIC8qIFBNM0ZC
X1VTRV9BQ0NFTCAqLwotCQlwbTNmYl93cml0ZV9tb2RlKGxfZmJfaW5mbyk7Ci0JCXJldHVybigw
KTsKLQkJYnJlYWs7CisJLyoKKwkgKiBIZXJlIHdlIHNldCB0aGUgc2NyZWVuX2Jhc2UgdG8gdGhl
IHZpcnR1YWwgbWVtb3J5IGFkZHJlc3MKKwkgKiBmb3IgdGhlIGZyYW1lYnVmZmVyLgorCSAqLwor
CXBtM2ZiX2ZpeC5tbWlvX3N0YXJ0ID0gcGNpX3Jlc291cmNlX3N0YXJ0KGRldiwgMCk7CisJcG0z
ZmJfZml4Lm1taW9fbGVuID0gUE0zX1JFR1NfU0laRTsKIAotCWRlZmF1bHQ6Ci0JCURQUklOVEso
MiwgInVua25vd24gaW9jdGw6ICVkICgleClcbiIsIGNtZCwgY21kKTsKLQkJcmV0dXJuKC1FSU5W
QUwpOwotCX0KLX0KKwkvKiBSZWdpc3RlcnMgLSByZXF1ZXN0IHJlZ2lvbiBhbmQgbWFwIGl0LiAq
LworCWlmICggIXJlcXVlc3RfbWVtX3JlZ2lvbihwbTNmYl9maXgubW1pb19zdGFydCwgcG0zZmJf
Zml4Lm1taW9fbGVuLAorCQkJCSAicG0zZmIgcmVnYmFzZSIpICkgeworCQlwcmludGsoS0VSTl9X
QVJOSU5HICJwbTNmYjogQ2FuJ3QgcmVzZXJ2ZSByZWdiYXNlLlxuIik7CisJCWdvdG8gZXJyX2V4
aXRfbmVpdGhlcjsKKwl9CisJcGFyLT52X3JlZ3MgPQorCQlpb3JlbWFwX25vY2FjaGUocG0zZmJf
Zml4Lm1taW9fc3RhcnQsIHBtM2ZiX2ZpeC5tbWlvX2xlbik7CisJaWYgKCAhcGFyLT52X3JlZ3Mg
KSB7CisJCXByaW50ayhLRVJOX1dBUk5JTkcgInBtM2ZiOiBDYW4ndCByZW1hcCAlcyByZWdpc3Rl
ciBhcmVhLlxuIiwKKwkJCXBtM2ZiX2ZpeC5pZCk7CisJCXJlbGVhc2VfbWVtX3JlZ2lvbihwbTNm
Yl9maXgubW1pb19zdGFydCwgcG0zZmJfZml4Lm1taW9fbGVuKTsKKwkJZ290byBlcnJfZXhpdF9u
ZWl0aGVyOworCX0KKworI2lmIGRlZmluZWQoX19CSUdfRU5ESUFOKQorCXBtM2ZiX2ZpeC5tbWlv
X3N0YXJ0ICs9IFBNM19SRUdTX1NJWkU7CisJRFBSSU5USygiQWRqdXN0aW5nIHJlZ2lzdGVyIGJh
c2UgZm9yIGJpZy1lbmRpYW4uXG4iKTsKKyNlbmRpZgorCS8qIExpbmVhciBmcmFtZSBidWZmZXIg
LSByZXF1ZXN0IHJlZ2lvbiBhbmQgbWFwIGl0LiAqLworCXBtM2ZiX2ZpeC5zbWVtX3N0YXJ0ID0g
cGNpX3Jlc291cmNlX3N0YXJ0KGRldiwgMSk7CisJcG0zZmJfZml4LnNtZW1fbGVuID0gcG0zZmJf
c2l6ZV9tZW1vcnkocGFyKTsKKwlpZiAoIXBtM2ZiX2ZpeC5zbWVtX2xlbikKKwl7CisJCXByaW50
ayhLRVJOX1dBUk5JTkcgInBtM2ZiOiBDYW4ndCBmaW5kIG1lbW9yeSBvbiBib2FyZC5cbiIpOwor
CQlnb3RvIGVycl9leGl0X21taW87CisJfQorCWlmICggIXJlcXVlc3RfbWVtX3JlZ2lvbihwbTNm
Yl9maXguc21lbV9zdGFydCwgcG0zZmJfZml4LnNtZW1fbGVuLAorCQkJCSAicG0zZmIgc21lbSIp
ICkgeworCQlwcmludGsoS0VSTl9XQVJOSU5HICJwbTNmYjogQ2FuJ3QgcmVzZXJ2ZSBzbWVtLlxu
Iik7CisJCWdvdG8gZXJyX2V4aXRfbW1pbzsKKwl9CisJaW5mby0+c2NyZWVuX2Jhc2UgPQorCQlp
b3JlbWFwX25vY2FjaGUocG0zZmJfZml4LnNtZW1fc3RhcnQsIHBtM2ZiX2ZpeC5zbWVtX2xlbik7
CisJaWYgKCAhaW5mby0+c2NyZWVuX2Jhc2UgKSB7CisJCXByaW50ayhLRVJOX1dBUk5JTkcgInBt
M2ZiOiBDYW4ndCBpb3JlbWFwIHNtZW0gYXJlYS5cbiIpOworCQlyZWxlYXNlX21lbV9yZWdpb24o
cG0zZmJfZml4LnNtZW1fc3RhcnQsIHBtM2ZiX2ZpeC5zbWVtX2xlbik7CisJCWdvdG8gZXJyX2V4
aXRfbW1pbzsKKwl9CisJaW5mby0+c2NyZWVuX3NpemUgPSBwbTNmYl9maXguc21lbV9sZW47CisK
KwlpbmZvLT5mYm9wcyA9ICZwbTNmYl9vcHM7CisKKwlwYXItPnZpZGVvID0gUE0zX1JFQURfUkVH
KHBhciwgUE0zVmlkZW9Db250cm9sKTsKKworCWluZm8tPmZpeCA9IHBtM2ZiX2ZpeDsKKwlpbmZv
LT5wc2V1ZG9fcGFsZXR0ZSA9IHBhci0+cGFsZXR0ZTsKKwlpbmZvLT5mbGFncyA9IEZCSU5GT19E
RUZBVUxUOy8qIHwgRkJJTkZPX0hXQUNDRUxfWVBBTjsqLworCisJLyoKKwkgKiBUaGlzIHNob3Vs
ZCBnaXZlIGEgcmVhc29uYWJsZSBkZWZhdWx0IHZpZGVvIG1vZGUuIFRoZSBmb2xsb3dpbmcgaXMK
KwkgKiBkb25lIHdoZW4gd2UgY2FuIHNldCBhIHZpZGVvIG1vZGUuCisJICovCisJaWYgKCFtb2Rl
X29wdGlvbikKKwkJbW9kZV9vcHRpb24gPSAiNjQweDQ4MEA2MCI7CiAKLS8qICoqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiAqLwotLyogKioqKiogc3RhbmRhcmQgRkIg
QVBJIGluaXQgZnVuY3Rpb25zICoqKioqICovCi0vKiAqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKiogKi8KKwlyZXR2YWwgPSBmYl9maW5kX21vZGUoJmluZm8tPnZhciwg
aW5mbywgbW9kZV9vcHRpb24sIE5VTEwsIDAsIE5VTEwsIDgpOwogCi1pbnQgX19pbml0IHBtM2Zi
X3NldHVwKGNoYXIgKm9wdGlvbnMpCi17Ci0JbG9uZyBvcHNpID0gc3RybGVuKG9wdGlvbnMpOwor
CWlmICghcmV0dmFsIHx8IHJldHZhbCA9PSA0KSB7CisJCXJldHZhbCA9IC1FSU5WQUw7CisJCWdv
dG8gZXJyX2V4aXRfYm90aDsKKwl9CiAKLQlEVFJBQ0U7CisJLyogVGhpcyBoYXMgdG8gYmVlbiBk
b25lICEhISAqLworCWlmIChmYl9hbGxvY19jbWFwKCZpbmZvLT5jbWFwLCAyNTYsIDApIDwgMCkg
eworCQlyZXR2YWwgPSAtRU5PTUVNOworCQlnb3RvIGVycl9leGl0X2JvdGg7CisJfQogCi0JbWVt
Y3B5KGdfb3B0aW9ucywgb3B0aW9ucywKLQkgICAgICAgKChvcHNpICsgMSkgPgotCQlQTTNfT1BU
SU9OU19TSVpFKSA/IFBNM19PUFRJT05TX1NJWkUgOiAob3BzaSArIDEpKTsKLQlnX29wdGlvbnNb
UE0zX09QVElPTlNfU0laRSAtIDFdID0gMDsKKwkvKgorCSAqIEZvciBkcml2ZXJzIHRoYXQgY2Fu
Li4uCisJICovCisJcG0zZmJfY2hlY2tfdmFyKCZpbmZvLT52YXIsIGluZm8pOwogCi0JcmV0dXJu
ICgwKTsKKwlpZiAocmVnaXN0ZXJfZnJhbWVidWZmZXIoaW5mbykgPCAwKSB7CisJCXJldHZhbCA9
IC1FSU5WQUw7CisJCWdvdG8gZXJyX2V4aXRfYWxsOworCX0KKwlwcmludGsoS0VSTl9JTkZPICJm
YiVkOiAlcyBmcmFtZSBidWZmZXIgZGV2aWNlXG4iLCBpbmZvLT5ub2RlLAorCSAgIGluZm8tPmZp
eC5pZCk7CisJcGNpX3NldF9kcnZkYXRhKGRldiwgaW5mbyk7IC8qIG9yIGRldl9zZXRfZHJ2ZGF0
YShkZXZpY2UsIGluZm8pICovCisJcmV0dXJuIDA7CisKKyBlcnJfZXhpdF9hbGw6CisJZmJfZGVh
bGxvY19jbWFwKCZpbmZvLT5jbWFwKTsKKyBlcnJfZXhpdF9ib3RoOgorCWlvdW5tYXAoaW5mby0+
c2NyZWVuX2Jhc2UpOworCXJlbGVhc2VfbWVtX3JlZ2lvbihwbTNmYl9maXguc21lbV9zdGFydCwg
cG0zZmJfZml4LnNtZW1fbGVuKTsKKyBlcnJfZXhpdF9tbWlvOgorCWlvdW5tYXAocGFyLT52X3Jl
Z3MpOworCXJlbGVhc2VfbWVtX3JlZ2lvbihwbTNmYl9maXgubW1pb19zdGFydCwgcG0zZmJfZml4
Lm1taW9fbGVuKTsKKyBlcnJfZXhpdF9uZWl0aGVyOgorCWZyYW1lYnVmZmVyX3JlbGVhc2UoaW5m
byk7CisJcmV0dXJuIHJldHZhbDsKIH0KIAotaW50IF9faW5pdCBwbTNmYl9pbml0KHZvaWQpCisJ
LyoKKwkgKiAgQ2xlYW51cAorCSAqLworc3RhdGljIHZvaWQgX19kZXZleGl0IHBtM2ZiX3JlbW92
ZShzdHJ1Y3QgcGNpX2RldiAqZGV2KQogewotCURUUkFDRTsKKwlzdHJ1Y3QgZmJfaW5mbyAqaW5m
byA9IHBjaV9nZXRfZHJ2ZGF0YShkZXYpOwogCi0JRFBSSU5USygyLCAiVGhpcyBpcyBwbTNmYi5j
LCBDVlMgdmVyc2lvbjogJEhlYWRlcjogL2N2c3Jvb3QvbGludXgvZHJpdmVycy92aWRlby9wbTNm
Yi5jLHYgMS4xIDIwMDIvMDIvMjUgMTk6MTE6MDYgbWFyY2VsbyBFeHAgJCIpOworCWlmIChpbmZv
KSB7CisJCXN0cnVjdCBmYl9maXhfc2NyZWVuaW5mbyAqZml4ID0gJmluZm8tPmZpeDsKKwkJc3Ry
dWN0IHBtM19wYXIgKnBhciA9IGluZm8tPnBhcjsKIAotCXBtM2ZiX3JlYWxfc2V0dXAoZ19vcHRp
b25zKTsKKwkJdW5yZWdpc3Rlcl9mcmFtZWJ1ZmZlcihpbmZvKTsKKwkJZmJfZGVhbGxvY19jbWFw
KCZpbmZvLT5jbWFwKTsKIAotCXBtM2ZiX2RldGVjdCgpOworCQlpb3VubWFwKGluZm8tPnNjcmVl
bl9iYXNlKTsKKwkJcmVsZWFzZV9tZW1fcmVnaW9uKGZpeC0+c21lbV9zdGFydCwgZml4LT5zbWVt
X2xlbik7CisJCWlvdW5tYXAocGFyLT52X3JlZ3MpOworCQlyZWxlYXNlX21lbV9yZWdpb24oZml4
LT5tbWlvX3N0YXJ0LCBmaXgtPm1taW9fbGVuKTsKIAotCWlmICghZmJfaW5mb1swXS5kZXYpIHsJ
Lyogbm90IGV2ZW4gb25lIGJvYXJkID8/PyAqLwotCQlEUFJJTlRLKDEsICJObyBQQ0kgUGVybWVk
aWEzIGJvYXJkIGRldGVjdGVkXG4iKTsKKwkJcGNpX3NldF9kcnZkYXRhKGRldiwgTlVMTCk7CisJ
CWZyYW1lYnVmZmVyX3JlbGVhc2UoaW5mbyk7CiAJfQotCXJldHVybiAoMCk7CiB9CiAKLS8qICoq
KioqKioqKioqKioqKioqKioqKioqKiogKi8KLS8qICoqKiogTW9kdWxlIHN1cHBvcnQgKioqKiog
Ki8KLS8qICoqKioqKioqKioqKioqKioqKioqKioqKiogKi8KLQotI2lmZGVmIE1PRFVMRQotTU9E
VUxFX0FVVEhPUigiUm9tYWluIERvbGJlYXUiKTsKLU1PRFVMRV9ERVNDUklQVElPTigiUGVybWVk
aWEzIGZyYW1lYnVmZmVyIGRldmljZSBkcml2ZXIiKTsKLXN0YXRpYyBjaGFyICptb2RlW1BNM19N
QVhfQk9BUkRdOwotbW9kdWxlX3BhcmFtX2FycmF5KG1vZGUsIGNoYXJwLCBOVUxMLCAwKTsKLU1P
RFVMRV9QQVJNX0RFU0MobW9kZSwidmlkZW8gbW9kZSIpOwotbW9kdWxlX3BhcmFtX2FycmF5KGRp
c2FibGUsIHNob3J0LCBOVUxMLCAwKTsKLU1PRFVMRV9QQVJNX0RFU0MoZGlzYWJsZSwiZGlzYWJs
ZSBib2FyZCIpOwotc3RhdGljIHNob3J0IG9mZltQTTNfTUFYX0JPQVJEXTsKLW1vZHVsZV9wYXJh
bV9hcnJheShvZmYsIHNob3J0LCBOVUxMLCAwKTsKLU1PRFVMRV9QQVJNX0RFU0Mob2ZmLCJkaXNh
YmxlIGJvYXJkIik7Ci1zdGF0aWMgY2hhciAqcGNpaWRbUE0zX01BWF9CT0FSRF07Ci1tb2R1bGVf
cGFyYW1fYXJyYXkocGNpaWQsIGNoYXJwLCBOVUxMLCAwKTsKLU1PRFVMRV9QQVJNX0RFU0MocGNp
aWQsImJvYXJkIFBDSSBJZCIpOwotbW9kdWxlX3BhcmFtX2FycmF5KG5vYWNjZWwsIHNob3J0LCBO
VUxMLCAwKTsKLU1PRFVMRV9QQVJNX0RFU0Mobm9hY2NlbCwiZGlzYWJsZSBhY2NlbCIpOwotc3Rh
dGljIGNoYXIgKmZvbnRbUE0zX01BWF9CT0FSRF07Ci1tb2R1bGVfcGFyYW1fYXJyYXkoZm9udCwg
Y2hhcnAsIE5VTEwsIDApOwotTU9EVUxFX1BBUk1fREVTQyhmb250LCJjaG9vc2UgZm9udCIpOwot
bW9kdWxlX3BhcmFtKGRlcHRoLCBzaG9ydCwgTlVMTCwgMCk7Ci1NT0RVTEVfUEFSTV9ERVNDKGRl
cHRoLCJib290LXRpbWUgZGVwdGgiKTsKLW1vZHVsZV9wYXJhbShwcmludHRpbWluZ3MsIHNob3J0
LCBOVUxMLCAwKTsKLU1PRFVMRV9QQVJNX0RFU0MocHJpbnR0aW1pbmdzLCAicHJpbnQgdGhlIG1l
bW9yeSB0aW1pbmdzIG9mIHRoZSBjYXJkKHMpIik7Ci1tb2R1bGVfcGFyYW0oZm9yY2VzaXplLCBz
aG9ydCwgTlVMTCwgMCk7Ci1NT0RVTEVfUEFSTV9ERVNDKGZvcmNlc2l6ZSwgImZvcmNlIHNwZWNp
ZmllZCBtZW1vcnkgc2l6ZSIpOwotLyoKLU1PRFVMRV9TVVBQT1JURURfREVWSUNFKCJQZXJtZWRp
YTMgUENJIGJvYXJkcyIpCi1NT0RVTEVfR0VORVJJQ19UQUJMRShndHlwZSxuYW1lKQotTU9EVUxF
X0RFVklDRV9UQUJMRSh0eXBlLG5hbWUpCi0qLworc3RhdGljIHN0cnVjdCBwY2lfZGV2aWNlX2lk
IHBtM2ZiX2lkX3RhYmxlW10gPSB7CisJeyBQQ0lfVkVORE9SX0lEXzNETEFCUywgMHgwYSwKKwkg
IFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIFBDSV9CQVNFX0NMQVNTX0RJU1BMQVkgPDwgMTYsCisJ
ICAweGZmMDAwMCwgMCB9LAorCXsgMCwgfQorfTsKIAotdm9pZCBwbTNmYl9idWlsZF9vcHRpb25z
KHZvaWQpCi17Ci0JaW50IGk7Ci0JY2hhciB0c1sxMjhdOworLyogRm9yIFBDSSBkcml2ZXJzICov
CitzdGF0aWMgc3RydWN0IHBjaV9kcml2ZXIgcG0zZmJfZHJpdmVyID0geworCS5uYW1lID0JCSJw
bTNmYiIsCisJLmlkX3RhYmxlID0JcG0zZmJfaWRfdGFibGUsCisJLnByb2JlID0JcG0zZmJfcHJv
YmUsCisJLnJlbW92ZSA9CV9fZGV2ZXhpdF9wKHBtM2ZiX3JlbW92ZSksCit9OwogCi0Jc3RyY3B5
KGdfb3B0aW9ucywgInBtM2ZiIik7Ci0JZm9yIChpID0gMDsgaSA8IFBNM19NQVhfQk9BUkQgOyBp
KyspCi0JewotCQlpZiAobW9kZVtpXSkKLQkJewotCQkJc3ByaW50Zih0cywgIixtb2RlOiVkOiVz
IiwgaSwgbW9kZVtpXSk7Ci0JCQlzdHJuY2F0KGdfb3B0aW9ucywgdHMsIFBNM19PUFRJT05TX1NJ
WkUgLSBzdHJsZW4oZ19vcHRpb25zKSk7Ci0JCX0KLQkJaWYgKGRpc2FibGVbaV0gfHwgb2ZmW2ld
KQotCQl7Ci0JCQlzcHJpbnRmKHRzLCAiLGRpc2FibGU6JWQ6IiwgaSk7Ci0JCQlzdHJuY2F0KGdf
b3B0aW9ucywgdHMsIFBNM19PUFRJT05TX1NJWkUgLSBzdHJsZW4oZ19vcHRpb25zKSk7Ci0JCX0K
LQkJaWYgKHBjaWlkW2ldKQotCQl7Ci0JCQlzcHJpbnRmKHRzLCAiLHBjaWlkOiVkOiVzIiwgaSwg
cGNpaWRbaV0pOwotCQkJc3RybmNhdChnX29wdGlvbnMsIHRzLCBQTTNfT1BUSU9OU19TSVpFIC0g
c3RybGVuKGdfb3B0aW9ucykpOwotCQl9Ci0JCWlmIChub2FjY2VsW2ldKQotCQl7Ci0JCQlzcHJp
bnRmKHRzLCAiLG5vYWNjZWw6JWQ6IiwgaSk7Ci0JCQlzdHJuY2F0KGdfb3B0aW9ucywgdHMsIFBN
M19PUFRJT05TX1NJWkUgLSBzdHJsZW4oZ19vcHRpb25zKSk7Ci0JCX0KLQkJaWYgKGZvbnRbaV0p
Ci0JCXsKLQkJCXNwcmludGYodHMsICIsZm9udDolZDolcyIsIGksIGZvbnRbaV0pOwotCQkJc3Ry
bmNhdChnX29wdGlvbnMsIHRzLCBQTTNfT1BUSU9OU19TSVpFIC0gc3RybGVuKGdfb3B0aW9ucykp
OwotCQl9Ci0JCWlmIChkZXB0aFtpXSkKLQkJewotCQkJc3ByaW50Zih0cywgIixkZXB0aDolZDol
ZCIsIGksIGRlcHRoW2ldKTsKLQkJCXN0cm5jYXQoZ19vcHRpb25zLCB0cywgUE0zX09QVElPTlNf
U0laRSAtIHN0cmxlbihnX29wdGlvbnMpKTsKLQkJfQotCX0KLQlnX29wdGlvbnNbUE0zX09QVElP
TlNfU0laRSAtIDFdID0gJ1wwJzsKLQlEUFJJTlRLKDEsICJwbTNmYiB1c2Ugb3B0aW9uczogJXNc
biIsIGdfb3B0aW9ucyk7Ci19CitNT0RVTEVfREVWSUNFX1RBQkxFKHBjaSwgcG0zZmJfaWRfdGFi
bGUpOwogCi1pbnQgaW5pdF9tb2R1bGUodm9pZCkKK2ludCBfX2luaXQgcG0zZmJfaW5pdCh2b2lk
KQogewotCURUUkFDRTsKKwkvKgorCSAqICBGb3Iga2VybmVsIGJvb3Qgb3B0aW9ucyAoaW4gJ3Zp
ZGVvPXBtM2ZiOjxvcHRpb25zPicgZm9ybWF0KQorCSAqLworI2lmbmRlZiBNT0RVTEUKKwljaGFy
ICpvcHRpb24gPSBOVUxMOwogCi0JcG0zZmJfYnVpbGRfb3B0aW9ucygpOworCWlmIChmYl9nZXRf
b3B0aW9ucygicG0zZmIiLCAmb3B0aW9uKSkKKwkJcmV0dXJuIC1FTk9ERVY7CisJcG0zZmJfc2V0
dXAob3B0aW9uKTsKKyNlbmRpZgogCi0JcG0zZmJfaW5pdCgpOworCXJldHVybiBwY2lfcmVnaXN0
ZXJfZHJpdmVyKCZwbTNmYl9kcml2ZXIpOworfQogCi0JcmV0dXJuIDA7CitzdGF0aWMgdm9pZCBf
X2V4aXQgcG0zZmJfZXhpdCh2b2lkKQoreworCXBjaV91bnJlZ2lzdGVyX2RyaXZlcigmcG0zZmJf
ZHJpdmVyKTsKIH0KIAotdm9pZCBjbGVhbnVwX21vZHVsZSh2b2lkKQorI2lmZGVmIE1PRFVMRQor
CS8qCisJICogIFNldHVwCisJICovCisKKy8qCisgKiBPbmx5IG5lY2Vzc2FyeSBpZiB5b3VyIGRy
aXZlciB0YWtlcyBzcGVjaWFsIG9wdGlvbnMsCisgKiBvdGhlcndpc2Ugd2UgZmFsbCBiYWNrIG9u
IHRoZSBnZW5lcmljIGZiX3NldHVwKCkuCisgKi8KK2ludCBfX2luaXQgcG0zZmJfc2V0dXAoY2hh
ciAqb3B0aW9ucykKIHsKLQlEVFJBQ0U7Ci0JewotCQl1bnNpZ25lZCBsb25nIGk7Ci0JCXN0cnVj
dCBwbTNmYl9pbmZvICpsX2ZiX2luZm87Ci0JCWZvciAoaSA9IDA7IGkgPCBQTTNfTUFYX0JPQVJE
OyBpKyspIHsKLQkJCWxfZmJfaW5mbyA9ICYoZmJfaW5mb1tpXSk7Ci0JCQlwY2lfZGV2X3B1dChs
X2ZiX2luZm8tPmRldik7Ci0JCQlpZiAobF9mYl9pbmZvLT5kZXYgIT0gTlVMTCAgJiYgIShkaXNh
YmxlW2xfZmJfaW5mby0+Ym9hcmRfbnVtXSkpIHsKLQkJCQlpZiAobF9mYl9pbmZvLT52SU9CYXNl
ICE9ICh1bnNpZ25lZCBjaGFyICopIC0xKSB7Ci0JCQkJCXBtM2ZiX3VubWFwSU8obF9mYl9pbmZv
KTsKLQkJCQkJcmVsZWFzZV9tZW1fcmVnaW9uKGxfZmJfaW5mby0+cF9mYiwKLQkJCQkJCSAgIGxf
ZmJfaW5mby0+ZmJfc2l6ZSk7Ci0JCQkJCXJlbGVhc2VfbWVtX3JlZ2lvbihsX2ZiX2luZm8tPnBJ
T0Jhc2UsCi0JCQkJCQkgICBQTTNfUkVHU19TSVpFKTsKLQkJCQl9Ci0JCQkJdW5yZWdpc3Rlcl9m
cmFtZWJ1ZmZlcigmbF9mYl9pbmZvLT5nZW4uaW5mbyk7Ci0JCQl9Ci0JCX0KLQl9CisJLyogUGFy
c2UgdXNlciBzcGVmaWNpZWQgb3B0aW9ucyAoYHZpZGVvPXBtM2ZiOicpICovCisJcmV0dXJuIDA7
CiB9CiAjZW5kaWYgLyogTU9EVUxFICovCisKK21vZHVsZV9pbml0KHBtM2ZiX2luaXQpOworbW9k
dWxlX2V4aXQocG0zZmJfZXhpdCk7CisKK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsKZGlmZiAtdXJw
IGxpbnV4LTIuNi4yMS5uZXcvaW5jbHVkZS92aWRlby9wbTNmYi5oIGxpbnV4LTIuNi4yMS9pbmNs
dWRlL3ZpZGVvL3BtM2ZiLmgKLS0tIGxpbnV4LTIuNi4yMS5uZXcvaW5jbHVkZS92aWRlby9wbTNm
Yi5oCTIwMDctMDQtMjYgMDU6MDg6MzIuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjEv
aW5jbHVkZS92aWRlby9wbTNmYi5oCTIwMDctMDUtMDYgMjI6MDg6MDcuMzQzMjQzMDc5ICswMjAw
CkBAIC0xMTE5LDExNyArMTExOSwxMCBAQAogLyogKioqKiogcG0zZmIgdXNlZnVsIGRlZmluZSBh
bmQgbWFjcm8gKioqKiogKi8KIC8qICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqICovCiAKLS8qIHBlcm1lZGlhMyAtc3BlY2lmaWMgZGVmaW5pdGlvbnMgKi8KLSNkZWZp
bmUgUE0zX1NDQUxFX1RPX0NMT0NLKHByLCBmZSwgcG8pICgoMiAqIFBNM19SRUZfQ0xPQ0sgKiBm
ZSkgLyAocHIgKiAoMSA8PCAocG8pKSkpCi0KLS8qIGluIGNhc2UgaXQncyBub3QgaW4gbGludXgv
cGNpLmggKi8KLSNpZm5kZWYgUENJX0RFVklDRV9JRF8zRExBQlNfUEVSTUVESUEzCi0jZGVmaW5l
IFBDSV9ERVZJQ0VfSURfM0RMQUJTX1BFUk1FRElBMyAweDAwMGEKLSNlbmRpZgotCi0vKiBtYXgg
bnVtYmVyIG9mIHNpbXVsdGFuZW91cyBib2FyZCAqLwotI2RlZmluZSBQTTNfTUFYX0JPQVJEIDQK
LQogLyogbWF4IHNpemUgb2Ygb3B0aW9ucyAqLwogI2RlZmluZSBQTTNfT1BUSU9OU19TSVpFIDI1
NgogCiAvKiBtYXggc2l6ZSBvZiBmb250IG5hbWUgKi8KICNkZWZpbmUgUE0zX0ZPTlROQU1FX1NJ
WkUgNDAKIAotLyogZG8gd2Ugd2FudCBhY2NlbGVyYXRlZCBjb25zb2xlICAqLwotI2RlZmluZSBQ
TTNGQl9VU0VfQUNDRUwgMQotCi0vKiBmb3IgZHJpdmVyIGRlYnVnZ2luZyBPTkxZICovCi0vKiAw
ID0gYXNzZXJ0IG9ubHksIDEgPSBlcnJvciwgMiA9IGluZm8sIDMrID0gdmVyYm9zZSAqLwotLyog
ZGVmaW5lIFBNM0ZCX01BU1RFUl9ERUJVRyAxICovCi0jaWYgZGVmaW5lZChQTTNGQl9NQVNURVJf
REVCVUcpICYmIChQTTNGQl9NQVNURVJfREVCVUcgPj0gMykKLSNkZWZpbmUgUE0zRkJfVFJBQ0UK
LSNlbmRpZiAvKiBkZWZpbmVkKFBNM0ZCX01BU1RFUl9ERUJVRykgJiYgKFBNM0ZCX01BU1RFUl9E
RUJVRyA+PSAzKSAqLwotCi0jaWZkZWYgUE0zRkJfTUFTVEVSX0RFQlVHCi0jZGVmaW5lIERQUklO
VEsobCxhLGIuLi4pIGRvIHsgaWYgKChsKSA8PSBQTTNGQl9NQVNURVJfREVCVUcpIHByaW50aygi
cG0zZmI6ICVzOiAiIGEsIF9fRlVOQ1RJT05fXyAsICMjIGIpOyB9IHdoaWxlICgwKQotI2RlZmlu
ZSBEQVNTRVJUKHQsYSxiLi4uKSBkbyB7IGlmICghKHQpKSBwcmludGsoInBtM2ZiOiBfYXNzZXJ0
IGZhaWxlZDogJXM6ICIgYSwgX19GVU5DVElPTl9fICwgIyMgYik7IH0gd2hpbGUgKDApCi0jaWZk
ZWYgUE0zRkJfVFJBQ0UKLSNkZWZpbmUgRFRSQUNFIHByaW50aygicG0zZmI6IF9lbnRlciAlc1xu
IiwgX19GVU5DVElPTl9fKQotI2Vsc2UgLyogUE0zRkJfVFJBQ0UgKi8KLSNkZWZpbmUgRFRSQUNF
Ci0jZW5kaWYgLyogUE0zRkJfVFJBQ0UgKi8KLSNlbHNlIC8qIFBNM0ZCX01BU1RFUl9ERUJVRyAq
LwotI2RlZmluZSBEUFJJTlRLKGwsYSxiLi4uKQotI2RlZmluZSBEQVNTRVJUKHQsYSxiLi4uKQot
I2RlZmluZSBEVFJBQ0UKLSNlbmRpZiAvKiBQTTNGQl9NQVNURVJfREVCVUcgKi8KLQotI2lmIGRl
ZmluZWQoUE0zRkJfTUFTVEVSX0RFQlVHKSAmJiAoUE0zRkJfTUFTVEVSX0RFQlVHID49IDIpCi0j
ZGVmaW5lIFBNM19TSE9XX0NVUl9NT0RFIHBtM2ZiX3Nob3dfY3VyX21vZGUobF9mYl9pbmZvKQot
I2Vsc2UKLSNkZWZpbmUgUE0zX1NIT1dfQ1VSX01PREUgLyogcG0zZmJfc2hvd19jdXJfbW9kZSgp
ICovCi0jZW5kaWYKLQotLyogKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKiogKi8KLS8qICoqKioqIEEgYnVuY2ggb2YgcmVnaXN0ZXItYWNjZXNzIG1hY3JvICoqKioq
ICovCi0vKiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiAqLwot
Ci0jZGVmaW5lIFBNM19XUklURV9SRUcociwgdikgZmJfd3JpdGVsKHYsIChsX2ZiX2luZm8tPnZJ
T0Jhc2UgKyByKSkKLSNkZWZpbmUgUE0zX1JFQURfUkVHKHIpIGZiX3JlYWRsKChsX2ZiX2luZm8t
PnZJT0Jhc2UgKyByKSkKLQotCi0jZGVmaW5lIGRlcHRoMmJwcChkKSAoKGQgKyA3TCkgJiB+N0wp
Ci0jZGVmaW5lIGRlcHRoMkJ5UFAoZCkgKGRlcHRoMmJwcChkKSAvIDgpCi0KLSNkZWZpbmUgZGVw
dGhfc3VwcG9ydGVkKGQpICgoZCA9PSA4KSB8fCAoZCA9PSAxMikgfHwgKGQgPT0gMTUpIHx8IChk
ID09IDE2KSB8fCAoZD09MzIpKQotCi0KLSNkZWZpbmUgUE0zX1dBSVQobikgXAotZG97IFwKLQl3
aGlsZShQTTNfUkVBRF9SRUcoUE0zSW5GSUZPU3BhY2UpPChuKSk7IFwKLX0gd2hpbGUoMCkKLQot
I2RlZmluZSBQTTNfREVMQVkoeCkgZG8geyBcCi0gICAgICAgIGludCBkZWxheSA9IHg7IFwKLSAg
ICAgICAgdW5zaWduZWQgY2hhciB0bXA7IFwKLSAgICAgICAgd2hpbGUoZGVsYXktLSl7dG1wID0g
UE0zX1JFQURfUkVHKFBNM0luRklGT1NwYWNlKTt9OyBcCi19IHdoaWxlKDApCi0KLSNkZWZpbmUg
UE0zX1NMT1dfV1JJVEVfUkVHKHIsdikJXAotZG97ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcCi0gICAgREFTU0VSVCgobF9mYl9pbmZvLT52SU9CYXNlICE9ICh1bnNpZ25lZCBjaGFyKiko
LTEpKSwgImxfZmJfaW5mby0+dklPQmFzZSBtYXBwZWQgaW4gc2xvdyB3cml0ZVxuIik7IFwKLQlt
YigpOyAgICAgICAgICAgICAgICAgICBcCi0JUE0zX1dBSVQoMSk7ICAgICAgICAgICAgXAotCW1i
KCk7ICAgICAgICAgICAgICAgICAgIFwKLSAgICBQTTNfV1JJVEVfUkVHKHIsdik7ICAgICBcCi19
IHdoaWxlKDApCi0KLSNkZWZpbmUgUE0zX1NFVF9JTkRFWChpbmRleCkgXAotZG97IFwKLQlQTTNf
U0xPV19XUklURV9SRUcoUE0zUkRfSW5kZXhIaWdoLCgoKGluZGV4KT4+OCkmMHhmZikpOyBcCi0J
UE0zX1NMT1dfV1JJVEVfUkVHKFBNM1JEX0luZGV4TG93LCgoaW5kZXgpJjB4ZmYpKTsgXAotfSB3
aGlsZSgwKQotCi0jZGVmaW5lIFBNM19XUklURV9EQUNfUkVHKHIsIHYpIFwKLWRvIHsgXAotICAg
ICBEQVNTRVJUKChsX2ZiX2luZm8tPnZJT0Jhc2UgIT0gKHVuc2lnbmVkIGNoYXIqKSgtMSkpLCAi
bF9mYl9pbmZvLT52SU9CYXNlIG1hcHBlZCBpbiB3cml0ZSBkYWMgcmVnXG4iKTsgXAotICAgICBQ
TTNfU0VUX0lOREVYKHIpOyBcCi0gICAgIG1iKCk7IFwKLSAgICAgUE0zX1dSSVRFX1JFRyhQTTNS
RF9JbmRleGVkRGF0YSwgdik7IFwKLX0gd2hpbGUgKDApCi0KLS8qIG5leHQgb25lIGlzIHJlYWxs
eSBhIGZ1bmN0aW9uLCBhZGRlZCBhcyBhIG1hY3JvIHRvIGJlIGNvbnNpc3RlbnQgKi8KLSNkZWZp
bmUgUE0zX1JFQURfREFDX1JFRyhyKSBwbTNmYl9yZWFkX2RhY19yZWcobF9mYl9pbmZvLCByKQot
Ci0KLSNkZWZpbmUgUE0zX0NPTE9SKGMpIFwKLWRvIHsgXAotICBpZiAobF9mYl9pbmZvLT5jdXJy
ZW50X3Bhci0+ZGVwdGggPT0gOCkgXAotICAgIHsgXAotICAgICAgYyA9IChjICYgMHhGRik7IFwK
LSAgICAgIGMgPSBjIHwgKGMgPDwgOCk7IFwKLSAgICB9IFwKLSAgaWYgKChsX2ZiX2luZm8tPmN1
cnJlbnRfcGFyLT5kZXB0aCA9PSA4KSB8fCAoZGVwdGgyYnBwKGxfZmJfaW5mby0+Y3VycmVudF9w
YXItPmRlcHRoKSA9PSAxNikpIFwKLSAgICB7IFwKLSAgICAgIGMgPSAoYyAmIDB4RkZGRik7IFwK
LSAgICAgIGMgPSBjIHwgKGMgPDwgMTYpOyBcCi0gICAgfSBcCi19IHdoaWxlICgwKQotCiAjZW5k
aWYgLyogUE0zRkJfSCAqLwo=

--part463e3edaafea3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part463e3edaafea3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part463e3edaafea3--

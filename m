From: David Eger <eger@havoc.gtf.org>
Subject: [PATCH] cirrusfb: it lives!
Date: Tue, 22 Jun 2004 16:27:58 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040622202758.GA10135@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcrsL-0003HS-2s
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Jun 2004 13:28:13 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcrsJ-00024v-AV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Jun 2004 13:28:11 -0700
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
Content-Transfer-Encoding: 7bit
To: akpm@osdl.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Jeff Garzik <garzik@havoc.gtf.org>, jsimmons@infradead.org

Dear Andrew,

This patch brings the cirrusfb driver up to date with 2.6.  cirrusfb
has suffered bit rot like you wouldn't believe (last updated... 2.3.x era?).
The driver will now compile again, and you can change to a high resolution 
text mode with stty.  Known defects: doesn't play nice with X, nor fbset.
Nonetheless, please apply to -mm and forward to mainline.

-dte


cirrusfb: port from Linux 2.4 to Linux 2.6 fb API
	aka The Big Overhaul(tm)

Signed-off-by: David Eger <eger@havoc.gtf.org>

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2004-06-22 16:12:19 -04:00
+++ b/drivers/video/Kconfig	2004-06-22 16:12:19 -04:00
@@ -40,7 +40,7 @@
 
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
-	depends on FB && (AMIGA || PCI) && BROKEN
+	depends on FB && (AMIGA || PCI)
 	---help---
 	  This enables support for Cirrus Logic GD542x/543x based boards on
 	  Amiga: SD64, Piccolo, Picasso II/II+, Picasso IV, or EGS Spectrum.
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	2004-06-22 16:12:19 -04:00
+++ b/drivers/video/Makefile	2004-06-22 16:12:19 -04:00
@@ -39,7 +39,7 @@
 obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
 obj-$(CONFIG_FB_IMSTT)            += imsttfb.o cfbimgblt.o
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
-obj-$(CONFIG_FB_CIRRUS)		  += cirrusfb.o
+obj-$(CONFIG_FB_CIRRUS)		  += cirrusfb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
 obj-$(CONFIG_FB_TRIDENT)	  += tridentfb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
 obj-$(CONFIG_FB_S3TRIO)           += S3triofb.o
 obj-$(CONFIG_FB_TGA)              += tgafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
diff -Nru a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
--- a/drivers/video/cirrusfb.c	2004-06-22 16:12:19 -04:00
+++ b/drivers/video/cirrusfb.c	2004-06-22 16:12:20 -04:00
@@ -1,10 +1,13 @@
 /*
- * drivers/video/clgenfb.c - driver for Cirrus Logic chipsets
+ * drivers/video/cirrusfb.c - driver for Cirrus Logic chipsets
  *
  * Copyright 1999-2001 Jeff Garzik <jgarzik@pobox.com>
  *
  * Contributors (thanks, all!)
  *
+ * 	David Eger:
+ * 	Overhaul for Linux 2.6
+ *
  *      Jeff Rugen:
  *      Major contributions;  Motorola PowerStack (PPC and PCI) support,
  *      GD54xx, 1280x1024 mode support, change MCLK based on VCLK.
@@ -15,9 +18,9 @@
  *	Lars Hecking:
  *	Amiga updates and testing.
  *
- * Original clgenfb author:  Frank Neumann
+ * Original cirrusfb author:  Frank Neumann
  *
- * Based on retz3fb.c and clgen.c:
+ * Based on retz3fb.c and cirrusfb.c:
  *      Copyright (C) 1997 Jes Sorensen
  *      Copyright (C) 1996 Frank Neumann
  *
@@ -31,7 +34,7 @@
  *
  */
 
-#define CLGEN_VERSION "1.9.9.1"
+#define CIRRUSFB_VERSION "2.0-pre2"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -63,15 +66,8 @@
 #define isPReP 0
 #endif
 
-#include <video/fbcon.h>
-#include <video/fbcon-mfb.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
-#include <video/fbcon-cfb24.h>
-#include <video/fbcon-cfb32.h>
-
-#include "clgenfb.h"
-#include "vga.h"
+#include "video/vga.h"
+#include "video/cirrus.h"
 
 
 /*****************************************************************
@@ -81,20 +77,20 @@
  */
 
 /* enable debug output? */
-/* #define CLGEN_DEBUG 1 */
+/* #define CIRRUSFB_DEBUG 1 */
 
 /* disable runtime assertions? */
-/* #define CLGEN_NDEBUG */
+/* #define CIRRUSFB_NDEBUG */
 
 /* debug output */
-#ifdef CLGEN_DEBUG
+#ifdef CIRRUSFB_DEBUG
 #define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
 #else
 #define DPRINTK(fmt, args...)
 #endif
 
 /* debugging assertions */
-#ifndef CLGEN_NDEBUG
+#ifndef CIRRUSFB_NDEBUG
 #define assert(expr) \
         if(!(expr)) { \
         printk( "Assertion failed! %s,%s,%s,line=%d\n",\
@@ -136,24 +132,25 @@
 	BT_ALPINE,	/* GD543x/4x */
 	BT_GD5480,
 	BT_LAGUNA,	/* GD546x */
-} clgen_board_t;
+} cirrusfb_board_t;
 
 
 /*
  * per-board-type information, used for enumerating and abstracting
  * chip-specific information
- * NOTE: MUST be in the same order as clgen_board_t in order to
+ * NOTE: MUST be in the same order as cirrusfb_board_t in order to
  * use direct indexing on this array
  * NOTE: '__initdata' cannot be used as some of this info
  * is required at runtime.  Maybe separate into an init-only and
  * a run-time table?
  */
-static const struct clgen_board_info_rec {
-	clgen_board_t btype;	/* chipset enum, not strictly necessary, as
-				 * clgen_board_info[] is directly indexed
+static const struct cirrusfb_board_info_rec {
+	cirrusfb_board_t btype;	/* chipset enum, not strictly necessary, as
+				 * cirrusfb_board_info[] is directly indexed
 				 * by this value */
 	char *name;		/* ASCII name of chipset */
-	long maxclock;		/* maximum video clock */
+	long maxclock[5];		/* maximum video clock */
+	/* for  1/4bpp, 8bpp 15/16bpp, 24bpp, 32bpp - numbers from xorg code */
 	unsigned init_sr07 : 1;	/* init SR07 during init_vgachip() */
 	unsigned init_sr1f : 1; /* write SR1F during init_vgachip() */
 	unsigned scrn_start_bit19 : 1; /* construct bit 19 of screen start address */
@@ -166,11 +163,12 @@
 	unsigned char sr07_8bpp_mux;
 
 	unsigned char sr1f;	/* SR1F VGA initial register value */
-} clgen_board_info[] = {
+} cirrusfb_board_info[] = {
 	{ BT_NONE, }, /* dummy record */
 	{ BT_SD64,
 		"CL SD64",
-		140000,		/* the SD64/P4 have a higher max. videoclock */
+		{ 140000, 140000, 140000, 140000, 140000, },	/* guess */
+		/* the SD64/P4 have a higher max. videoclock */
 		TRUE,
 		TRUE,
 		TRUE,
@@ -182,7 +180,7 @@
 		0x20 },
 	{ BT_PICCOLO,
 		"CL Piccolo",
-		90000,
+		{ 90000, 90000, 90000, 90000, 90000 },	/* guess */
 		TRUE,
 		TRUE,
 		FALSE,
@@ -194,7 +192,7 @@
 		0x22 },
 	{ BT_PICASSO,
 		"CL Picasso",
-		90000,
+		{ 90000, 90000, 90000, 90000, 90000, },	/* guess */
 		TRUE,
 		TRUE,
 		FALSE,
@@ -206,7 +204,7 @@
 		0x22 },
 	{ BT_SPECTRUM,
 		"CL Spectrum",
-		90000,
+		{ 90000, 90000, 90000, 90000, 90000, },	/* guess */
 		TRUE,
 		TRUE,
 		FALSE,
@@ -218,7 +216,7 @@
 		0x22 },
 	{ BT_PICASSO4,
 		"CL Picasso4",
-		140000,		/* the SD64/P4 have a higher max. videoclock */
+		{ 135100, 135100, 85500, 85500, 0 },
 		TRUE,
 		FALSE,
 		TRUE,
@@ -230,7 +228,7 @@
 		0 },
 	{ BT_ALPINE,
 		"CL Alpine",
-		110000,		/* 135100 for some, 85500 for others */
+		{ 85500, 85500, 50000, 28500, 0}, /* for the GD5430.  GD5446 can do more... */
 		TRUE,
 		TRUE,
 		TRUE,
@@ -242,7 +240,7 @@
 		0x1C },
 	{ BT_GD5480,
 		"CL GD5480",
-		90000,
+		{ 135100, 200000, 200000, 135100, 135100 },
 		TRUE,
 		TRUE,
 		TRUE,
@@ -254,7 +252,7 @@
 		0x1C },
 	{ BT_LAGUNA,
 		"CL Laguna",
-		135100,
+		{ 135100, 135100, 135100, 135100, 135100, }, /* guess */
 		FALSE,
 		FALSE,
 		TRUE,
@@ -268,34 +266,34 @@
 
 
 #ifdef CONFIG_PCI
-/* the list of PCI devices for which we probe, and the
- * order in which we do it */
-static const struct {
-	clgen_board_t btype;
-	const char *nameOverride; /* XXX unused... for now */
-	unsigned short device;
-} clgen_pci_probe_list[] __initdata = {
-	{ BT_ALPINE, NULL, PCI_DEVICE_ID_CIRRUS_5436 },
-	{ BT_ALPINE, NULL, PCI_DEVICE_ID_CIRRUS_5434_8 },
-	{ BT_ALPINE, NULL, PCI_DEVICE_ID_CIRRUS_5434_4 },
-	{ BT_ALPINE, NULL, PCI_DEVICE_ID_CIRRUS_5430 }, /* GD-5440 has identical id */
-	{ BT_ALPINE, NULL, PCI_DEVICE_ID_CIRRUS_7543 },
-	{ BT_ALPINE, NULL, PCI_DEVICE_ID_CIRRUS_7548 },
-	{ BT_GD5480, NULL, PCI_DEVICE_ID_CIRRUS_5480 }, /* MacPicasso probably */
-	{ BT_PICASSO4, NULL, PCI_DEVICE_ID_CIRRUS_5446 }, /* Picasso 4 is a GD5446 */
-	{ BT_LAGUNA, "CL Laguna", PCI_DEVICE_ID_CIRRUS_5462 },
-	{ BT_LAGUNA, "CL Laguna 3D", PCI_DEVICE_ID_CIRRUS_5464 },
-	{ BT_LAGUNA, "CL Laguna 3DA", PCI_DEVICE_ID_CIRRUS_5465 },
+#define CHIP(id, btype) \
+	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_##id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (btype) }
+
+static struct pci_device_id cirrusfb_pci_table[] = {
+	CHIP( CIRRUS_5436, 	BT_ALPINE ),
+	CHIP( CIRRUS_5434_8, 	BT_ALPINE ),
+	CHIP( CIRRUS_5434_4, 	BT_ALPINE ),
+	CHIP( CIRRUS_5430, 	BT_ALPINE ), /* GD-5440 has identical id */
+	CHIP( CIRRUS_7543, 	BT_ALPINE ),
+	CHIP( CIRRUS_7548, 	BT_ALPINE ),
+	CHIP( CIRRUS_5480,	BT_GD5480 ), /* MacPicasso probably */
+	CHIP( CIRRUS_5446,	BT_PICASSO4 ), /* Picasso 4 is a GD5446 */
+	CHIP( CIRRUS_5462,	BT_LAGUNA ), /* CL Laguna */
+	CHIP( CIRRUS_5464,	BT_LAGUNA ), /* CL Laguna 3D */
+	CHIP( CIRRUS_5465,	BT_LAGUNA ), /* CL Laguna 3DA*/
+	{ 0, }
 };
+MODULE_DEVICE_TABLE(pci, cirrusfb_pci_table);
+#undef CHIP
 #endif /* CONFIG_PCI */
 
 
 #ifdef CONFIG_ZORRO
 static const struct {
-	clgen_board_t btype;
+	cirrusfb_board_t btype;
 	zorro_id id, id2;
 	unsigned long size;
-} clgen_zorro_probe_list[] __initdata = {
+} cirrusfb_zorro_probe_list[] __initdata = {
 	{ BT_SD64,
 		ZORRO_PROD_HELFRICH_SD64_RAM,
 		ZORRO_PROD_HELFRICH_SD64_REG,
@@ -320,10 +318,7 @@
 #endif /* CONFIG_ZORRO */
 
 
-
-struct clgenfb_par {
-	struct fb_var_screeninfo var;
-
+struct cirrusfb_regs {
 	__u32 line_length;	/* in BYTES! */
 	__u32 visual;
 	__u32 type;
@@ -355,47 +350,36 @@
 
 
 
-#ifdef CLGEN_DEBUG
+#ifdef CIRRUSFB_DEBUG
 typedef enum {
         CRT,
         SEQ
-} clgen_dbg_reg_class_t;
-#endif                          /* CLGEN_DEBUG */
+} cirrusfb_dbg_reg_class_t;
+#endif                          /* CIRRUSFB_DEBUG */
 
 
 
 
 /* info about board */
-struct clgenfb_info {
-	struct fb_info_gen gen;
+struct cirrusfb_info {
+	struct fb_info *info;
 
 	caddr_t fbmem;
-	caddr_t regs;
+	caddr_t regbase;
 	caddr_t mem;
 	unsigned long size;
-	clgen_board_t btype;
-	int smallboard;
+	cirrusfb_board_t btype;
 	unsigned char SFR;	/* Shadow of special function register */
 
 	unsigned long fbmem_phys;
 	unsigned long fbregs_phys;
 
-	struct clgenfb_par currentmode;
+	struct cirrusfb_regs currentmode;
+	int blank_mode;
 
+	u32	pseudo_palette[17];
 	struct { u8 red, green, blue, pad; } palette[256];
 
-	union {
-#ifdef FBCON_HAS_CFB16
-		u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB24
-		u32 cfb24[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-		u32 cfb32[16];
-#endif
-	} fbcon_cmap;
-
 #ifdef CONFIG_ZORRO
 	unsigned long board_addr,
 		      board_size;
@@ -407,17 +391,9 @@
 };
 
 
-
-
-static struct display disp;
-
-static struct clgenfb_info boards[MAX_NUM_BOARDS];	/* the boards */
-
-static unsigned clgen_def_mode = 1;
+static unsigned cirrusfb_def_mode = 1;
 static int noaccel = 0;
 
-
-
 /*
  *    Predefined Video Modes
  */
@@ -425,7 +401,7 @@
 static const struct {
 	const char *name;
 	struct fb_var_screeninfo var;
-} clgenfb_predefined[] __initdata =
+} cirrusfb_predefined[] =
 
 {
 	{"Autodetect",		/* autodetect mode */
@@ -473,171 +449,90 @@
 	}
 };
 
-#define NUM_TOTAL_MODES    ARRAY_SIZE(clgenfb_predefined)
-static struct fb_var_screeninfo clgenfb_default;
-
-/*
- *    Frame Buffer Name
- */
-
-static const char *clgenfb_name = "CLgen";
+#define NUM_TOTAL_MODES    ARRAY_SIZE(cirrusfb_predefined)
 
 /****************************************************************************/
 /**** BEGIN PROTOTYPES ******************************************************/
 
 
 /*--- Interface used by the world ------------------------------------------*/
-int clgenfb_init (void);
-int clgenfb_setup (char *options);
+int cirrusfb_init (void);
+int cirrusfb_setup (char *options);
 
-static int clgenfb_open (struct fb_info *info, int user);
-static int clgenfb_release (struct fb_info *info, int user);
-
-static int clgenfb_setcolreg (unsigned regno, unsigned red, unsigned green,
-			      unsigned blue, unsigned transp,
-			      struct fb_info *info);
+int cirrusfb_open (struct fb_info *info, int user);
+int cirrusfb_release (struct fb_info *info, int user);
+int cirrusfb_setcolreg (unsigned regno, unsigned red, unsigned green,
+			unsigned blue, unsigned transp,
+			struct fb_info *info);
+int cirrusfb_check_var (struct fb_var_screeninfo *var, 
+			struct fb_info *info);
+int cirrusfb_set_par (struct fb_info *info);
+int cirrusfb_pan_display (struct fb_var_screeninfo *var,
+			  struct fb_info *info);
+int cirrusfb_blank (int blank_mode, struct fb_info *info);
+void cirrusfb_fillrect (struct fb_info *info, const struct fb_fillrect *region);
+void cirrusfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
+void cirrusfb_imageblit(struct fb_info *info, const struct fb_image *image);
 
 /* function table of the above functions */
-static struct fb_ops clgenfb_ops = {
-	.owner =	THIS_MODULE,
-	.fb_open =	clgenfb_open,
-	.fb_release =	clgenfb_release,
-	.fb_get_fix =	fbgen_get_fix,
-	.fb_get_var =	fbgen_get_var,
-	.fb_set_var =	fbgen_set_var,
-	.fb_get_cmap =	fbgen_get_cmap,
-	.fb_set_cmap =	gen_set_cmap,
-	.fb_setcolreg =	clgenfb_setcolreg,
-	.fb_pan_display =fbgen_pan_display,
-	.fb_blank =	fbgen_blank,
+static struct fb_ops cirrusfb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_open	= cirrusfb_open,
+	.fb_release 	= cirrusfb_release,
+	.fb_setcolreg	= cirrusfb_setcolreg,
+	.fb_check_var	= cirrusfb_check_var,
+	.fb_set_par	= cirrusfb_set_par,
+	.fb_pan_display = cirrusfb_pan_display,
+	.fb_blank	= cirrusfb_blank,
+	.fb_fillrect	= cirrusfb_fillrect,
+	.fb_copyarea	= cirrusfb_copyarea,
+	.fb_imageblit	= cirrusfb_imageblit,
+	.fb_cursor	= soft_cursor,
 };
 
 /*--- Hardware Specific Routines -------------------------------------------*/
-static void clgen_detect (void);
-static int clgen_encode_fix (struct fb_fix_screeninfo *fix, const void *par,
-			     struct fb_info_gen *info);
-static int clgen_decode_var (const struct fb_var_screeninfo *var, void *par,
-			     struct fb_info_gen *info);
-static int clgen_encode_var (struct fb_var_screeninfo *var, const void *par,
-			     struct fb_info_gen *info);
-static void clgen_get_par (void *par, struct fb_info_gen *info);
-static void clgen_set_par (const void *par, struct fb_info_gen *info);
-static int clgen_getcolreg (unsigned regno, unsigned *red, unsigned *green,
-			    unsigned *blue, unsigned *transp,
-			    struct fb_info *info);
-static int clgen_pan_display (const struct fb_var_screeninfo *var,
-			      struct fb_info_gen *info);
-static int clgen_blank (int blank_mode, struct fb_info_gen *info);
-
-static void clgen_set_disp (const void *par, struct display *disp,
-			    struct fb_info_gen *info);
-
-/* function table of the above functions */
-static struct fbgen_hwswitch clgen_hwswitch =
-{
-	clgen_detect,
-	clgen_encode_fix,
-	clgen_decode_var,
-	clgen_encode_var,
-	clgen_get_par,
-	clgen_set_par,
-	clgen_getcolreg,
-	clgen_pan_display,
-	clgen_blank,
-	clgen_set_disp
-};
-
-/* Text console acceleration */
-
-#ifdef FBCON_HAS_CFB8
-static void fbcon_clgen8_bmove (struct display *p, int sy, int sx,
-				int dy, int dx, int height, int width);
-static void fbcon_clgen8_clear (struct vc_data *conp, struct display *p,
-				int sy, int sx, int height, int width);
-
-static struct display_switch fbcon_clgen_8 = {
-	.setup =	fbcon_cfb8_setup,
-	.bmove =	fbcon_clgen8_bmove,
-	.clear =	fbcon_clgen8_clear,
-	.putc =		fbcon_cfb8_putc,
-	.putcs =	fbcon_cfb8_putcs,
-	.revc =		fbcon_cfb8_revc,
-	.clear_margins =fbcon_cfb8_clear_margins,
-	.fontwidthmask =FONTWIDTH (4) | FONTWIDTH (8) | FONTWIDTH (12) | FONTWIDTH (16)
-};
-#endif
-#ifdef FBCON_HAS_CFB16
-static void fbcon_clgen16_bmove (struct display *p, int sy, int sx,
-				 int dy, int dx, int height, int width);
-static void fbcon_clgen16_clear (struct vc_data *conp, struct display *p,
-				 int sy, int sx, int height, int width);
-static struct display_switch fbcon_clgen_16 = {
-	.setup =	fbcon_cfb16_setup,
-	.bmove =	fbcon_clgen16_bmove,
-	.clear =	fbcon_clgen16_clear,
-	.putc =		fbcon_cfb16_putc,
-	.putcs =	fbcon_cfb16_putcs,
-	.revc =		fbcon_cfb16_revc,
-	.clear_margins =fbcon_cfb16_clear_margins,
-	.fontwidthmask =FONTWIDTH (4) | FONTWIDTH (8) | FONTWIDTH (12) | FONTWIDTH (16)
-};
-#endif
-#ifdef FBCON_HAS_CFB32
-static void fbcon_clgen32_bmove (struct display *p, int sy, int sx,
-				 int dy, int dx, int height, int width);
-static void fbcon_clgen32_clear (struct vc_data *conp, struct display *p,
-				 int sy, int sx, int height, int width);
-static struct display_switch fbcon_clgen_32 = {
-	.setup =	fbcon_cfb32_setup,
-	.bmove =	fbcon_clgen32_bmove,
-	.clear =	fbcon_clgen32_clear,
-	.putc =		fbcon_cfb32_putc,
-	.putcs =	fbcon_cfb32_putcs,
-	.revc =		fbcon_cfb32_revc,
-	.clear_margins =fbcon_cfb32_clear_margins,
-	.fontwidthmask =FONTWIDTH (4) | FONTWIDTH (8) | FONTWIDTH (12) | FONTWIDTH (16)
-};
-#endif
-
-
-
+static int cirrusfb_decode_var (const struct fb_var_screeninfo *var, 
+				struct cirrusfb_regs *regs,
+				const struct fb_info *info);
 /*--- Internal routines ----------------------------------------------------*/
-static void init_vgachip (struct clgenfb_info *fb_info);
-static void switch_monitor (struct clgenfb_info *fb_info, int on);
-static void WGen (const struct clgenfb_info *fb_info,
+static void init_vgachip (struct cirrusfb_info *cinfo);
+static void switch_monitor (struct cirrusfb_info *cinfo, int on);
+static void WGen (const struct cirrusfb_info *cinfo,
 		  int regnum, unsigned char val);
-static unsigned char RGen (const struct clgenfb_info *fb_info, int regnum);
-static void AttrOn (const struct clgenfb_info *fb_info);
-static void WHDR (const struct clgenfb_info *fb_info, unsigned char val);
-static void WSFR (struct clgenfb_info *fb_info, unsigned char val);
-static void WSFR2 (struct clgenfb_info *fb_info, unsigned char val);
-static void WClut (struct clgenfb_info *fb_info, unsigned char regnum, unsigned char red,
+static unsigned char RGen (const struct cirrusfb_info *cinfo, int regnum);
+static void AttrOn (const struct cirrusfb_info *cinfo);
+static void WHDR (const struct cirrusfb_info *cinfo, unsigned char val);
+static void WSFR (struct cirrusfb_info *cinfo, unsigned char val);
+static void WSFR2 (struct cirrusfb_info *cinfo, unsigned char val);
+static void WClut (struct cirrusfb_info *cinfo, unsigned char regnum, unsigned char red,
 		   unsigned char green,
 		   unsigned char blue);
 #if 0
-static void RClut (struct clgenfb_info *fb_info, unsigned char regnum, unsigned char *red,
+static void RClut (struct cirrusfb_info *cinfo, unsigned char regnum, unsigned char *red,
 		   unsigned char *green,
 		   unsigned char *blue);
 #endif
-static void clgen_WaitBLT (caddr_t regbase);
-static void clgen_BitBLT (caddr_t regbase, u_short curx, u_short cury,
-			  u_short destx, u_short desty,
-			  u_short width, u_short height,
-			  u_short line_length);
-static void clgen_RectFill (struct clgenfb_info *fb_info, u_short x, u_short y,
-			    u_short width, u_short height,
-			    u_char color, u_short line_length);
+static void cirrusfb_WaitBLT (caddr_t regbase);
+static void cirrusfb_BitBLT (caddr_t regbase, int bits_per_pixel,
+			     u_short curx, u_short cury,
+			     u_short destx, u_short desty,
+			     u_short width, u_short height,
+			     u_short line_length);
+static void cirrusfb_RectFill (caddr_t regbase, int bits_per_pixel,
+			       u_short x, u_short y,
+			       u_short width, u_short height,
+			       u_char color, u_short line_length);
 
 static void bestclock (long freq, long *best,
 		       long *nom, long *den,
 		       long *div, long maxfreq);
 
-#ifdef CLGEN_DEBUG
-static void clgen_dump (void);
-static void clgen_dbg_reg_dump (caddr_t regbase);
-static void clgen_dbg_print_regs (caddr_t regbase, clgen_dbg_reg_class_t reg_class,...);
-static void clgen_dbg_print_byte (const char *name, unsigned char val);
-#endif /* CLGEN_DEBUG */
+#ifdef CIRRUSFB_DEBUG
+static void cirrusfb_dump (void);
+static void cirrusfb_dbg_reg_dump (caddr_t regbase);
+static void cirrusfb_dbg_print_regs (caddr_t regbase, cirrusfb_dbg_reg_class_t reg_class,...);
+static void cirrusfb_dbg_print_byte (const char *name, unsigned char val);
+#endif /* CIRRUSFB_DEBUG */
 
 /*** END   PROTOTYPES ********************************************************/
 /*****************************************************************************/
@@ -646,18 +541,18 @@
 static int opencount = 0;
 
 /*--- Open /dev/fbx ---------------------------------------------------------*/
-static int clgenfb_open (struct fb_info *info, int user)
+int cirrusfb_open (struct fb_info *info, int user)
 {
 	if (opencount++ == 0)
-		switch_monitor ((struct clgenfb_info *) info, 1);
+		switch_monitor (info->par, 1);
 	return 0;
 }
 
 /*--- Close /dev/fbx --------------------------------------------------------*/
-static int clgenfb_release (struct fb_info *info, int user)
+int cirrusfb_release (struct fb_info *info, int user)
 {
 	if (--opencount == 0)
-		switch_monitor ((struct clgenfb_info *) info, 0);
+		switch_monitor (info->par, 0);
 	return 0;
 }
 
@@ -665,67 +560,8 @@
 /****************************************************************************/
 /**** BEGIN Hardware specific Routines **************************************/
 
-static void clgen_detect (void)
-{
-	DPRINTK ("ENTER\n");
-	DPRINTK ("EXIT\n");
-}
-
-static int clgen_encode_fix (struct fb_fix_screeninfo *fix, const void *par,
-			     struct fb_info_gen *info)
-{
-	struct clgenfb_par *_par = (struct clgenfb_par *) par;
-	struct clgenfb_info *_info = (struct clgenfb_info *) info;
-
-	DPRINTK ("ENTER\n");
-
-	memset (fix, 0, sizeof (struct fb_fix_screeninfo));
-	strcpy (fix->id, clgenfb_name);
-
-	if (_info->btype == BT_GD5480) {
-		/* Select proper byte-swapping aperture */
-		switch (_par->var.bits_per_pixel) {
-		case 1:
-		case 8:
-			fix->smem_start = _info->fbmem_phys;
-			break;
-		case 16:
-			fix->smem_start = _info->fbmem_phys + 1 * MB_;
-			break;
-		case 24:
-		case 32:
-			fix->smem_start = _info->fbmem_phys + 2 * MB_;
-			break;
-		}
-	} else {
-		fix->smem_start = _info->fbmem_phys;
-	}
-
-	/* monochrome: only 1 memory plane */
-	/* 8 bit and above: Use whole memory area */
-	fix->smem_len = _par->var.bits_per_pixel == 1 ? _info->size / 4
-	    : _info->size;
-	fix->type = _par->type;
-	fix->type_aux = 0;
-	fix->visual = _par->visual;
-	fix->xpanstep = 1;
-	fix->ypanstep = 1;
-	fix->ywrapstep = 0;
-	fix->line_length = _par->line_length;
-
-	/* FIXME: map region at 0xB8000 if available, fill in here */
-	fix->mmio_start = 0;
-	fix->mmio_len = 0;
-	fix->accel = FB_ACCEL_NONE;
-
-	DPRINTK ("EXIT\n");
-	return 0;
-}
-
-
-
 /* Get a good MCLK value */
-static long clgen_get_mclk (long freq, int bpp, long *div)
+static long cirrusfb_get_mclk (long freq, int bpp, long *div)
 {
 	long mclk;
 
@@ -765,227 +601,253 @@
 	return mclk;
 }
 
-static int clgen_decode_var (const struct fb_var_screeninfo *var, void *par,
-			     struct fb_info_gen *info)
+int cirrusfb_check_var(struct fb_var_screeninfo *var,
+		       struct fb_info *info)
 {
-	long freq;
-	long maxclock;
-	int xres, hfront, hsync, hback;
-	int yres, vfront, vsync, vback;
+	struct cirrusfb_info *cinfo = info->par;
 	int nom, den;		/* translyting from pixels->bytes */
-	int i;
-	static struct {
-		int xres, yres;
-	} modes[] = { {
-			1600, 1280
-	}, {
-		1280, 1024
-	}, {
-		1024, 768
-	},
-	{
-		800, 600
-	}, {
-		640, 480
-	}, {
-		-1, -1
-	}
-	};
-
-	struct clgenfb_par *_par = (struct clgenfb_par *) par;
-	struct clgenfb_info *fb_info = (struct clgenfb_info *) info;
-
-	assert (var != NULL);
-	assert (par != NULL);
-	assert (info != NULL);
-
-	DPRINTK ("ENTER\n");
-
-	DPRINTK ("Requested: %dx%dx%d\n", var->xres, var->yres, var->bits_per_pixel);
-	DPRINTK ("  virtual: %dx%d\n", var->xres_virtual, var->yres_virtual);
-	DPRINTK ("   offset: (%d,%d)\n", var->xoffset, var->yoffset);
-	DPRINTK ("grayscale: %d\n", var->grayscale);
-
-	memset (par, 0, sizeof (struct clgenfb_par));
-
-	_par->var = *var;
+	int yres, i;
+	static struct { int xres, yres; } modes[] = 
+	{ { 1600, 1280 }, 
+	  { 1280, 1024 }, 
+	  { 1024, 768 }, 
+	  { 800, 600 }, 
+	  { 640, 480 }, 
+	  { -1, -1 } };
 
 	switch (var->bits_per_pixel) {
-	case 1:
+	case 0 ... 1:
+		var->bits_per_pixel = 1;
 		nom = 4;
 		den = 8;
 		break;		/* 8 pixel per byte, only 1/4th of mem usable */
 	case 2 ... 8:
-		_par->var.bits_per_pixel = 8;
+		var->bits_per_pixel = 8;
 		nom = 1;
 		den = 1;
 		break;		/* 1 pixel == 1 byte */
 	case 9 ... 16:
-		_par->var.bits_per_pixel = 16;
+		var->bits_per_pixel = 16;
 		nom = 2;
 		den = 1;
 		break;		/* 2 bytes per pixel */
 	case 17 ... 24:
-		_par->var.bits_per_pixel = 24;
+		var->bits_per_pixel = 24;
 		nom = 3;
 		den = 1;
 		break;		/* 3 bytes per pixel */
 	case 25 ... 32:
-		_par->var.bits_per_pixel = 32;
+		var->bits_per_pixel = 32;
 		nom = 4;
 		den = 1;
 		break;		/* 4 bytes per pixel */
 	default:
-		printk ("clgen: mode %dx%dx%d rejected...color depth not supported.\n",
+		printk ("cirrusfb: mode %dx%dx%d rejected...color depth not supported.\n",
 			var->xres, var->yres, var->bits_per_pixel);
 		DPRINTK ("EXIT - EINVAL error\n");
 		return -EINVAL;
 	}
 
-	if (_par->var.xres * nom / den * _par->var.yres > fb_info->size) {
-		printk ("clgen: mode %dx%dx%d rejected...resolution too high to fit into video memory!\n",
+	if (var->xres * nom / den * var->yres > cinfo->size) {
+		printk ("cirrusfb: mode %dx%dx%d rejected...resolution too high to fit into video memory!\n",
 			var->xres, var->yres, var->bits_per_pixel);
 		DPRINTK ("EXIT - EINVAL error\n");
 		return -EINVAL;
 	}
+	
 	/* use highest possible virtual resolution */
-	if (_par->var.xres_virtual == -1 &&
-	    _par->var.yres_virtual == -1) {
-		printk ("clgen: using maximum available virtual resolution\n");
+	if (var->xres_virtual == -1 &&
+	    var->yres_virtual == -1) {
+		printk ("cirrusfb: using maximum available virtual resolution\n");
 		for (i = 0; modes[i].xres != -1; i++) {
-			if (modes[i].xres * nom / den * modes[i].yres < fb_info->size / 2)
+			if (modes[i].xres * nom / den * modes[i].yres < cinfo->size / 2)
 				break;
 		}
 		if (modes[i].xres == -1) {
-			printk ("clgen: could not find a virtual resolution that fits into video memory!!\n");
+			printk ("cirrusfb: could not find a virtual resolution that fits into video memory!!\n");
 			DPRINTK ("EXIT - EINVAL error\n");
 			return -EINVAL;
 		}
-		_par->var.xres_virtual = modes[i].xres;
-		_par->var.yres_virtual = modes[i].yres;
+		var->xres_virtual = modes[i].xres;
+		var->yres_virtual = modes[i].yres;
 
-		printk ("clgen: virtual resolution set to maximum of %dx%d\n",
-			_par->var.xres_virtual, _par->var.yres_virtual);
-	} else if (_par->var.xres_virtual == -1) {
-		/* FIXME: maximize X virtual resolution only */
-	} else if (_par->var.yres_virtual == -1) {
-		/* FIXME: maximize Y virtual resolution only */
-	}
-	if (_par->var.xoffset < 0)
-		_par->var.xoffset = 0;
-	if (_par->var.yoffset < 0)
-		_par->var.yoffset = 0;
+		printk ("cirrusfb: virtual resolution set to maximum of %dx%d\n",
+			var->xres_virtual, var->yres_virtual);
+	} 
+
+	if (var->xres_virtual < var->xres)
+		var->xres_virtual = var->xres;
+	if (var->yres_virtual < var->yres)
+		var->yres_virtual = var->yres;
+
+	if (var->xoffset < 0)
+		var->xoffset = 0;
+	if (var->yoffset < 0)
+		var->yoffset = 0;
 
 	/* truncate xoffset and yoffset to maximum if too high */
-	if (_par->var.xoffset > _par->var.xres_virtual - _par->var.xres)
-		_par->var.xoffset = _par->var.xres_virtual - _par->var.xres - 1;
-
-	if (_par->var.yoffset > _par->var.yres_virtual - _par->var.yres)
-		_par->var.yoffset = _par->var.yres_virtual - _par->var.yres - 1;
+	if (var->xoffset > var->xres_virtual - var->xres)
+		var->xoffset = var->xres_virtual - var->xres - 1;
+	if (var->yoffset > var->yres_virtual - var->yres)
+		var->yoffset = var->yres_virtual - var->yres - 1;
 
-	switch (_par->var.bits_per_pixel) {
+	switch (var->bits_per_pixel) {
 	case 1:
-		_par->line_length = _par->var.xres_virtual / 8;
-		_par->visual = FB_VISUAL_MONO10;
 		break;
 
 	case 8:
-		_par->line_length = _par->var.xres_virtual;
-		_par->visual = FB_VISUAL_PSEUDOCOLOR;
-		_par->var.red.offset = 0;
-		_par->var.red.length = 6;
-		_par->var.green.offset = 0;
-		_par->var.green.length = 6;
-		_par->var.blue.offset = 0;
-		_par->var.blue.length = 6;
+		var->red.offset = 0;
+		var->red.length = 6;
+		var->green.offset = 0;
+		var->green.length = 6;
+		var->blue.offset = 0;
+		var->blue.length = 6;
 		break;
 
 	case 16:
-		_par->line_length = _par->var.xres_virtual * 2;
-		_par->visual = FB_VISUAL_DIRECTCOLOR;
 		if(isPReP) {
-			_par->var.red.offset = 2;
-			_par->var.green.offset = -3;
-			_par->var.blue.offset = 8;
+			var->red.offset = 2;
+			var->green.offset = -3;
+			var->blue.offset = 8;
 		} else {
-			_par->var.red.offset = 10;
-			_par->var.green.offset = 5;
-			_par->var.blue.offset = 0;
-		}
-		_par->var.red.length = 5;
-		_par->var.green.length = 5;
-		_par->var.blue.length = 5;
+			var->red.offset = 10;
+			var->green.offset = 5;
+			var->blue.offset = 0;
+		}
+		var->red.length = 5;
+		var->green.length = 5;
+		var->blue.length = 5;
 		break;
 
 	case 24:
-		_par->line_length = _par->var.xres_virtual * 3;
-		_par->visual = FB_VISUAL_DIRECTCOLOR;
 		if(isPReP) {
-			_par->var.red.offset = 8;
-			_par->var.green.offset = 16;
-			_par->var.blue.offset = 24;
+			var->red.offset = 8;
+			var->green.offset = 16;
+			var->blue.offset = 24;
 		} else {
-			_par->var.red.offset = 16;
-			_par->var.green.offset = 8;
-			_par->var.blue.offset = 0;
-		}
-		_par->var.red.length = 8;
-		_par->var.green.length = 8;
-		_par->var.blue.length = 8;
+			var->red.offset = 16;
+			var->green.offset = 8;
+			var->blue.offset = 0;
+		}
+		var->red.length = 8;
+		var->green.length = 8;
+		var->blue.length = 8;
 		break;
 
 	case 32:
-		_par->line_length = _par->var.xres_virtual * 4;
-		_par->visual = FB_VISUAL_DIRECTCOLOR;
 		if(isPReP) {
-			_par->var.red.offset = 8;
-			_par->var.green.offset = 16;
-			_par->var.blue.offset = 24;
+			var->red.offset = 8;
+			var->green.offset = 16;
+			var->blue.offset = 24;
 		} else {
-			_par->var.red.offset = 16;
-			_par->var.green.offset = 8;
-			_par->var.blue.offset = 0;
-		}
-		_par->var.red.length = 8;
-		_par->var.green.length = 8;
-		_par->var.blue.length = 8;
+			var->red.offset = 16;
+			var->green.offset = 8;
+			var->blue.offset = 0;
+		}
+		var->red.length = 8;
+		var->green.length = 8;
+		var->blue.length = 8;
 		break;
 
 	default:
-		DPRINTK("Unsupported bpp size: %d\n", _par->var.bits_per_pixel);
+		DPRINTK("Unsupported bpp size: %d\n", var->bits_per_pixel);
 		assert (FALSE);
 		/* should never occur */
 		break;
 	}
 
-	_par->var.red.msb_right =
-	    _par->var.green.msb_right =
-	    _par->var.blue.msb_right =
-	    _par->var.transp.offset =
-	    _par->var.transp.length =
-	    _par->var.transp.msb_right = 0;
+	var->red.msb_right =
+	    var->green.msb_right =
+	    var->blue.msb_right =
+	    var->transp.offset =
+	    var->transp.length =
+	    var->transp.msb_right = 0;
+
+	yres = var->yres;
+	if (var->vmode & FB_VMODE_DOUBLE) 
+		yres *= 2;
+	else if (var->vmode & FB_VMODE_INTERLACED)
+		yres = (yres + 1) / 2;
+
+	if (yres >= 1280) {
+		printk (KERN_WARNING "cirrusfb: ERROR: VerticalTotal >= 1280; special treatment required! (TODO)\n");
+		DPRINTK ("EXIT - EINVAL error\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cirrusfb_decode_var (const struct fb_var_screeninfo *var, 
+				struct cirrusfb_regs *regs,
+				const struct fb_info *info)
+{
+	long freq;
+	long maxclock;
+	int maxclockidx = 0;
+	struct cirrusfb_info *cinfo = info->par;
+	int xres, hfront, hsync, hback;
+	int yres, vfront, vsync, vback;
+
+	switch(var->bits_per_pixel) {
+	case 1:
+		regs->line_length = var->xres_virtual / 8;
+		regs->visual = FB_VISUAL_MONO10;
+		maxclockidx = 0;
+		break;
+
+	case 8:
+		regs->line_length = var->xres_virtual;
+		regs->visual = FB_VISUAL_PSEUDOCOLOR;
+		maxclockidx = 1;
+		break;
+
+	case 16:
+		regs->line_length = var->xres_virtual * 2;
+		regs->visual = FB_VISUAL_DIRECTCOLOR;
+		maxclockidx = 2;
+		break;
+
+	case 24:
+		regs->line_length = var->xres_virtual * 3;
+		regs->visual = FB_VISUAL_DIRECTCOLOR;
+		maxclockidx = 3;
+		break;
+
+	case 32:
+		regs->line_length = var->xres_virtual * 4;
+		regs->visual = FB_VISUAL_DIRECTCOLOR;
+		maxclockidx = 4;
+		break;
+
+	default:
+		DPRINTK("Unsupported bpp size: %d\n", var->bits_per_pixel);
+		assert (FALSE);
+		/* should never occur */
+		break;
+	}
 
-	_par->type = FB_TYPE_PACKED_PIXELS;
+	regs->type = FB_TYPE_PACKED_PIXELS;
 
 	/* convert from ps to kHz */
 	freq = 1000000000 / var->pixclock;
 
 	DPRINTK ("desired pixclock: %ld kHz\n", freq);
 
-	maxclock = clgen_board_info[fb_info->btype].maxclock;
-	_par->multiplexing = 0;
+	maxclock = cirrusfb_board_info[cinfo->btype].maxclock[maxclockidx];
+	regs->multiplexing = 0;
 
 	/* If the frequency is greater than we can support, we might be able
 	 * to use multiplexing for the video mode */
 	if (freq > maxclock) {
-		switch (fb_info->btype) {
+		switch (cinfo->btype) {
 		case BT_ALPINE:
 		case BT_GD5480:
-			_par->multiplexing = 1;
+			regs->multiplexing = 1;
 			break;
 
 		default:
-			printk (KERN_WARNING "clgen: ERROR: Frequency greater than maxclock (%ld kHz)\n", maxclock);
+			printk (KERN_WARNING "cirrusfb: ERROR: Frequency greater than maxclock (%ld kHz)\n", maxclock);
 			DPRINTK ("EXIT - return -EINVAL\n");
 			return -EINVAL;
 		}
@@ -996,274 +858,256 @@
 	switch (var->bits_per_pixel) {
 	case 16:
 	case 32:
-		if (_par->HorizRes <= 800)
+		if (regs->HorizRes <= 800)
 			freq /= 2;	/* Xbh has this type of clock for 32-bit */
 		break;
 	}
 #endif
 
-	bestclock (freq, &_par->freq, &_par->nom, &_par->den, &_par->div,
+	bestclock (freq, &regs->freq, &regs->nom, &regs->den, &regs->div,
 		   maxclock);
-	_par->mclk = clgen_get_mclk (freq, _par->var.bits_per_pixel, &_par->divMCLK);
+	regs->mclk = cirrusfb_get_mclk (freq, var->bits_per_pixel, &regs->divMCLK);
 
-	xres = _par->var.xres;
-	hfront = _par->var.right_margin;
-	hsync = _par->var.hsync_len;
-	hback = _par->var.left_margin;
-
-	yres = _par->var.yres;
-	vfront = _par->var.lower_margin;
-	vsync = _par->var.vsync_len;
-	vback = _par->var.upper_margin;
+	xres = var->xres;
+	hfront = var->right_margin;
+	hsync = var->hsync_len;
+	hback = var->left_margin;
+
+	yres = var->yres;
+	vfront = var->lower_margin;
+	vsync = var->vsync_len;
+	vback = var->upper_margin;
 
-	if (_par->var.vmode & FB_VMODE_DOUBLE) {
+	if (var->vmode & FB_VMODE_DOUBLE) {
 		yres *= 2;
 		vfront *= 2;
 		vsync *= 2;
 		vback *= 2;
-	} else if (_par->var.vmode & FB_VMODE_INTERLACED) {
+	} else if (var->vmode & FB_VMODE_INTERLACED) {
 		yres = (yres + 1) / 2;
 		vfront = (vfront + 1) / 2;
 		vsync = (vsync + 1) / 2;
 		vback = (vback + 1) / 2;
 	}
-	_par->HorizRes = xres;
-	_par->HorizTotal = (xres + hfront + hsync + hback) / 8 - 5;
-	_par->HorizDispEnd = xres / 8 - 1;
-	_par->HorizBlankStart = xres / 8;
-	_par->HorizBlankEnd = _par->HorizTotal + 5;	/* does not count with "-5" */
-	_par->HorizSyncStart = (xres + hfront) / 8 + 1;
-	_par->HorizSyncEnd = (xres + hfront + hsync) / 8 + 1;
-
-	_par->VertRes = yres;
-	_par->VertTotal = yres + vfront + vsync + vback - 2;
-	_par->VertDispEnd = yres - 1;
-	_par->VertBlankStart = yres;
-	_par->VertBlankEnd = _par->VertTotal;
-	_par->VertSyncStart = yres + vfront - 1;
-	_par->VertSyncEnd = yres + vfront + vsync - 1;
-
-	if (_par->VertRes >= 1024) {
-		_par->VertTotal /= 2;
-		_par->VertSyncStart /= 2;
-		_par->VertSyncEnd /= 2;
-		_par->VertDispEnd /= 2;
-	}
-	if (_par->multiplexing) {
-		_par->HorizTotal /= 2;
-		_par->HorizSyncStart /= 2;
-		_par->HorizSyncEnd /= 2;
-		_par->HorizDispEnd /= 2;
-	}
-	if (_par->VertRes >= 1280) {
-		printk (KERN_WARNING "clgen: ERROR: VerticalTotal >= 1280; special treatment required! (TODO)\n");
-		DPRINTK ("EXIT - EINVAL error\n");
-		return -EINVAL;
+	regs->HorizRes = xres;
+	regs->HorizTotal = (xres + hfront + hsync + hback) / 8 - 5;
+	regs->HorizDispEnd = xres / 8 - 1;
+	regs->HorizBlankStart = xres / 8;
+	regs->HorizBlankEnd = regs->HorizTotal + 5;	/* does not count with "-5" */
+	regs->HorizSyncStart = (xres + hfront) / 8 + 1;
+	regs->HorizSyncEnd = (xres + hfront + hsync) / 8 + 1;
+
+	regs->VertRes = yres;
+	regs->VertTotal = yres + vfront + vsync + vback - 2;
+	regs->VertDispEnd = yres - 1;
+	regs->VertBlankStart = yres;
+	regs->VertBlankEnd = regs->VertTotal;
+	regs->VertSyncStart = yres + vfront - 1;
+	regs->VertSyncEnd = yres + vfront + vsync - 1;
+
+	if (regs->VertRes >= 1024) {
+		regs->VertTotal /= 2;
+		regs->VertSyncStart /= 2;
+		regs->VertSyncEnd /= 2;
+		regs->VertDispEnd /= 2;
+	}
+	if (regs->multiplexing) {
+		regs->HorizTotal /= 2;
+		regs->HorizSyncStart /= 2;
+		regs->HorizSyncEnd /= 2;
+		regs->HorizDispEnd /= 2;
 	}
-	DPRINTK ("EXIT\n");
-	return 0;
-}
-
-
-static int clgen_encode_var (struct fb_var_screeninfo *var, const void *par,
-			     struct fb_info_gen *info)
-{
-	DPRINTK ("ENTER\n");
 
-	*var = ((struct clgenfb_par *) par)->var;
-
-	DPRINTK ("EXIT\n");
 	return 0;
 }
 
-/* get current video mode */
-static void clgen_get_par (void *par, struct fb_info_gen *info)
-{
-	struct clgenfb_par *_par = (struct clgenfb_par *) par;
-	struct clgenfb_info *_info = (struct clgenfb_info *) info;
-
-	DPRINTK ("ENTER\n");
-
-	*_par = _info->currentmode;
 
-	DPRINTK ("EXIT\n");
-}
-
-static void clgen_set_mclk (const struct clgenfb_info *fb_info, int val, int div)
+static void cirrusfb_set_mclk (const struct cirrusfb_info *cinfo, int val, int div)
 {
-	assert (fb_info != NULL);
+	assert (cinfo != NULL);
 
 	if (div == 2) {
 		/* VCLK = MCLK/2 */
-		unsigned char old = vga_rseq (fb_info->regs, CL_SEQR1E);
-		vga_wseq (fb_info->regs, CL_SEQR1E, old | 0x1);
-		vga_wseq (fb_info->regs, CL_SEQR1F, 0x40 | (val & 0x3f));
+		unsigned char old = vga_rseq (cinfo->regbase, CL_SEQR1E);
+		vga_wseq (cinfo->regbase, CL_SEQR1E, old | 0x1);
+		vga_wseq (cinfo->regbase, CL_SEQR1F, 0x40 | (val & 0x3f));
 	} else if (div == 1) {
 		/* VCLK = MCLK */
-		unsigned char old = vga_rseq (fb_info->regs, CL_SEQR1E);
-		vga_wseq (fb_info->regs, CL_SEQR1E, old & ~0x1);
-		vga_wseq (fb_info->regs, CL_SEQR1F, 0x40 | (val & 0x3f));
+		unsigned char old = vga_rseq (cinfo->regbase, CL_SEQR1E);
+		vga_wseq (cinfo->regbase, CL_SEQR1E, old & ~0x1);
+		vga_wseq (cinfo->regbase, CL_SEQR1F, 0x40 | (val & 0x3f));
 	} else {
-		vga_wseq (fb_info->regs, CL_SEQR1F, val & 0x3f);
+		vga_wseq (cinfo->regbase, CL_SEQR1F, val & 0x3f);
 	}
 }
 
 /*************************************************************************
-	clgen_set_par()
+	cirrusfb_set_par_foo()
 
 	actually writes the values for a new video mode into the hardware,
 **************************************************************************/
-static void clgen_set_par (const void *par, struct fb_info_gen *info)
+static int cirrusfb_set_par_foo (struct fb_info *info)
 {
+	struct cirrusfb_info *cinfo = info->par;
+	struct fb_var_screeninfo *var = &info->var;
+	struct cirrusfb_regs regs;
+	caddr_t regbase = cinfo->regbase;
 	unsigned char tmp;
-	int offset = 0;
-	struct clgenfb_par *_par = (struct clgenfb_par *) par;
-	struct clgenfb_info *fb_info = (struct clgenfb_info *) info;
-	const struct clgen_board_info_rec *bi;
-
+	int offset = 0, err;
+	const struct cirrusfb_board_info_rec *bi;
+	
 	DPRINTK ("ENTER\n");
 	DPRINTK ("Requested mode: %dx%dx%d\n",
-	       _par->var.xres, _par->var.yres, _par->var.bits_per_pixel);
-	DPRINTK ("pixclock: %d\n", _par->var.pixclock);
+	       var->xres, var->yres, var->bits_per_pixel);
+	DPRINTK ("pixclock: %d\n", var->pixclock);
+
+	init_vgachip (cinfo);
 
-	bi = &clgen_board_info[fb_info->btype];
+	err = cirrusfb_decode_var(var, &regs, info);
+	if(err) {
+		/* should never happen */ 
+		DPRINTK("mode change aborted.  invalid var.\n");
+		return -EINVAL;
+	}
+	
+	bi = &cirrusfb_board_info[cinfo->btype];
 
 
 	/* unlock register VGA_CRTC_H_TOTAL..CRT7 */
-	vga_wcrt (fb_info->regs, VGA_CRTC_V_SYNC_END, 0x20);	/* previously: 0x00) */
+	vga_wcrt (regbase, VGA_CRTC_V_SYNC_END, 0x20);	/* previously: 0x00) */
 
 	/* if debugging is enabled, all parameters get output before writing */
-	DPRINTK ("CRT0: %ld\n", _par->HorizTotal);
-	vga_wcrt (fb_info->regs, VGA_CRTC_H_TOTAL, _par->HorizTotal);
+	DPRINTK ("CRT0: %ld\n", regs.HorizTotal);
+	vga_wcrt (regbase, VGA_CRTC_H_TOTAL, regs.HorizTotal);
 
-	DPRINTK ("CRT1: %ld\n", _par->HorizDispEnd);
-	vga_wcrt (fb_info->regs, VGA_CRTC_H_DISP, _par->HorizDispEnd);
+	DPRINTK ("CRT1: %ld\n", regs.HorizDispEnd);
+	vga_wcrt (regbase, VGA_CRTC_H_DISP, regs.HorizDispEnd);
 
-	DPRINTK ("CRT2: %ld\n", _par->HorizBlankStart);
-	vga_wcrt (fb_info->regs, VGA_CRTC_H_BLANK_START, _par->HorizBlankStart);
+	DPRINTK ("CRT2: %ld\n", regs.HorizBlankStart);
+	vga_wcrt (regbase, VGA_CRTC_H_BLANK_START, regs.HorizBlankStart);
 
-	DPRINTK ("CRT3: 128+%ld\n", _par->HorizBlankEnd % 32);	/*  + 128: Compatible read */
-	vga_wcrt (fb_info->regs, VGA_CRTC_H_BLANK_END, 128 + (_par->HorizBlankEnd % 32));
+	DPRINTK ("CRT3: 128+%ld\n", regs.HorizBlankEnd % 32);	/*  + 128: Compatible read */
+	vga_wcrt (regbase, VGA_CRTC_H_BLANK_END, 128 + (regs.HorizBlankEnd % 32));
 
-	DPRINTK ("CRT4: %ld\n", _par->HorizSyncStart);
-	vga_wcrt (fb_info->regs, VGA_CRTC_H_SYNC_START, _par->HorizSyncStart);
+	DPRINTK ("CRT4: %ld\n", regs.HorizSyncStart);
+	vga_wcrt (regbase, VGA_CRTC_H_SYNC_START, regs.HorizSyncStart);
 
-	tmp = _par->HorizSyncEnd % 32;
-	if (_par->HorizBlankEnd & 32)
+	tmp = regs.HorizSyncEnd % 32;
+	if (regs.HorizBlankEnd & 32)
 		tmp += 128;
 	DPRINTK ("CRT5: %d\n", tmp);
-	vga_wcrt (fb_info->regs, VGA_CRTC_H_SYNC_END, tmp);
+	vga_wcrt (regbase, VGA_CRTC_H_SYNC_END, tmp);
 
-	DPRINTK ("CRT6: %ld\n", _par->VertTotal & 0xff);
-	vga_wcrt (fb_info->regs, VGA_CRTC_V_TOTAL, (_par->VertTotal & 0xff));
+	DPRINTK ("CRT6: %ld\n", regs.VertTotal & 0xff);
+	vga_wcrt (regbase, VGA_CRTC_V_TOTAL, (regs.VertTotal & 0xff));
 
 	tmp = 16;		/* LineCompare bit #9 */
-	if (_par->VertTotal & 256)
+	if (regs.VertTotal & 256)
 		tmp |= 1;
-	if (_par->VertDispEnd & 256)
+	if (regs.VertDispEnd & 256)
 		tmp |= 2;
-	if (_par->VertSyncStart & 256)
+	if (regs.VertSyncStart & 256)
 		tmp |= 4;
-	if (_par->VertBlankStart & 256)
+	if (regs.VertBlankStart & 256)
 		tmp |= 8;
-	if (_par->VertTotal & 512)
+	if (regs.VertTotal & 512)
 		tmp |= 32;
-	if (_par->VertDispEnd & 512)
+	if (regs.VertDispEnd & 512)
 		tmp |= 64;
-	if (_par->VertSyncStart & 512)
+	if (regs.VertSyncStart & 512)
 		tmp |= 128;
 	DPRINTK ("CRT7: %d\n", tmp);
-	vga_wcrt (fb_info->regs, VGA_CRTC_OVERFLOW, tmp);
+	vga_wcrt (regbase, VGA_CRTC_OVERFLOW, tmp);
 
 	tmp = 0x40;		/* LineCompare bit #8 */
-	if (_par->VertBlankStart & 512)
+	if (regs.VertBlankStart & 512)
 		tmp |= 0x20;
-	if (_par->var.vmode & FB_VMODE_DOUBLE)
+	if (var->vmode & FB_VMODE_DOUBLE)
 		tmp |= 0x80;
 	DPRINTK ("CRT9: %d\n", tmp);
-	vga_wcrt (fb_info->regs, VGA_CRTC_MAX_SCAN, tmp);
+	vga_wcrt (regbase, VGA_CRTC_MAX_SCAN, tmp);
 
-	DPRINTK ("CRT10: %ld\n", _par->VertSyncStart & 0xff);
-	vga_wcrt (fb_info->regs, VGA_CRTC_V_SYNC_START, (_par->VertSyncStart & 0xff));
+	DPRINTK ("CRT10: %ld\n", regs.VertSyncStart & 0xff);
+	vga_wcrt (regbase, VGA_CRTC_V_SYNC_START, (regs.VertSyncStart & 0xff));
 
-	DPRINTK ("CRT11: 64+32+%ld\n", _par->VertSyncEnd % 16);
-	vga_wcrt (fb_info->regs, VGA_CRTC_V_SYNC_END, (_par->VertSyncEnd % 16 + 64 + 32));
+	DPRINTK ("CRT11: 64+32+%ld\n", regs.VertSyncEnd % 16);
+	vga_wcrt (regbase, VGA_CRTC_V_SYNC_END, (regs.VertSyncEnd % 16 + 64 + 32));
 
-	DPRINTK ("CRT12: %ld\n", _par->VertDispEnd & 0xff);
-	vga_wcrt (fb_info->regs, VGA_CRTC_V_DISP_END, (_par->VertDispEnd & 0xff));
+	DPRINTK ("CRT12: %ld\n", regs.VertDispEnd & 0xff);
+	vga_wcrt (regbase, VGA_CRTC_V_DISP_END, (regs.VertDispEnd & 0xff));
 
-	DPRINTK ("CRT15: %ld\n", _par->VertBlankStart & 0xff);
-	vga_wcrt (fb_info->regs, VGA_CRTC_V_BLANK_START, (_par->VertBlankStart & 0xff));
+	DPRINTK ("CRT15: %ld\n", regs.VertBlankStart & 0xff);
+	vga_wcrt (regbase, VGA_CRTC_V_BLANK_START, (regs.VertBlankStart & 0xff));
 
-	DPRINTK ("CRT16: %ld\n", _par->VertBlankEnd & 0xff);
-	vga_wcrt (fb_info->regs, VGA_CRTC_V_BLANK_END, (_par->VertBlankEnd & 0xff));
+	DPRINTK ("CRT16: %ld\n", regs.VertBlankEnd & 0xff);
+	vga_wcrt (regbase, VGA_CRTC_V_BLANK_END, (regs.VertBlankEnd & 0xff));
 
 	DPRINTK ("CRT18: 0xff\n");
-	vga_wcrt (fb_info->regs, VGA_CRTC_LINE_COMPARE, 0xff);
+	vga_wcrt (regbase, VGA_CRTC_LINE_COMPARE, 0xff);
 
 	tmp = 0;
-	if (_par->var.vmode & FB_VMODE_INTERLACED)
+	if (var->vmode & FB_VMODE_INTERLACED)
 		tmp |= 1;
-	if (_par->HorizBlankEnd & 64)
+	if (regs.HorizBlankEnd & 64)
 		tmp |= 16;
-	if (_par->HorizBlankEnd & 128)
+	if (regs.HorizBlankEnd & 128)
 		tmp |= 32;
-	if (_par->VertBlankEnd & 256)
+	if (regs.VertBlankEnd & 256)
 		tmp |= 64;
-	if (_par->VertBlankEnd & 512)
+	if (regs.VertBlankEnd & 512)
 		tmp |= 128;
 
 	DPRINTK ("CRT1a: %d\n", tmp);
-	vga_wcrt (fb_info->regs, CL_CRT1A, tmp);
+	vga_wcrt (regbase, CL_CRT1A, tmp);
 
 	/* set VCLK0 */
 	/* hardware RefClock: 14.31818 MHz */
 	/* formula: VClk = (OSC * N) / (D * (1+P)) */
 	/* Example: VClk = (14.31818 * 91) / (23 * (1+1)) = 28.325 MHz */
 
-	vga_wseq (fb_info->regs, CL_SEQRB, _par->nom);
-	tmp = _par->den << 1;
-	if (_par->div != 0)
+	vga_wseq (regbase, CL_SEQRB, regs.nom);
+	tmp = regs.den << 1;
+	if (regs.div != 0)
 		tmp |= 1;
 
-	if ((fb_info->btype == BT_SD64) ||
-	    (fb_info->btype == BT_ALPINE) ||
-	    (fb_info->btype == BT_GD5480))
+	if ((cinfo->btype == BT_SD64) ||
+	    (cinfo->btype == BT_ALPINE) ||
+	    (cinfo->btype == BT_GD5480))
 		tmp |= 0x80;	/* 6 bit denom; ONLY 5434!!! (bugged me 10 days) */
 
 	DPRINTK ("CL_SEQR1B: %ld\n", (long) tmp);
-	vga_wseq (fb_info->regs, CL_SEQR1B, tmp);
+	vga_wseq (regbase, CL_SEQR1B, tmp);
 
-	if (_par->VertRes >= 1024)
+	if (regs.VertRes >= 1024)
 		/* 1280x1024 */
-		vga_wcrt (fb_info->regs, VGA_CRTC_MODE, 0xc7);
+		vga_wcrt (regbase, VGA_CRTC_MODE, 0xc7);
 	else
 		/* mode control: VGA_CRTC_START_HI enable, ROTATE(?), 16bit
 		 * address wrap, no compat. */
-		vga_wcrt (fb_info->regs, VGA_CRTC_MODE, 0xc3);
+		vga_wcrt (regbase, VGA_CRTC_MODE, 0xc3);
 
-/* HAEH?        vga_wcrt (fb_info->regs, VGA_CRTC_V_SYNC_END, 0x20);  * previously: 0x00  unlock VGA_CRTC_H_TOTAL..CRT7 */
+/* HAEH?        vga_wcrt (regbase, VGA_CRTC_V_SYNC_END, 0x20);  * previously: 0x00  unlock VGA_CRTC_H_TOTAL..CRT7 */
 
 	/* don't know if it would hurt to also program this if no interlaced */
 	/* mode is used, but I feel better this way.. :-) */
-	if (_par->var.vmode & FB_VMODE_INTERLACED)
-		vga_wcrt (fb_info->regs, VGA_CRTC_REGS, _par->HorizTotal / 2);
+	if (var->vmode & FB_VMODE_INTERLACED)
+		vga_wcrt (regbase, VGA_CRTC_REGS, regs.HorizTotal / 2);
 	else
-		vga_wcrt (fb_info->regs, VGA_CRTC_REGS, 0x00);	/* interlace control */
+		vga_wcrt (regbase, VGA_CRTC_REGS, 0x00);	/* interlace control */
 
-	vga_wseq (fb_info->regs, VGA_SEQ_CHARACTER_MAP, 0);
+	vga_wseq (regbase, VGA_SEQ_CHARACTER_MAP, 0);
 
 	/* adjust horizontal/vertical sync type (low/high) */
 	tmp = 0x03;		/* enable display memory & CRTC I/O address for color mode */
-	if (_par->var.sync & FB_SYNC_HOR_HIGH_ACT)
+	if (var->sync & FB_SYNC_HOR_HIGH_ACT)
 		tmp |= 0x40;
-	if (_par->var.sync & FB_SYNC_VERT_HIGH_ACT)
+	if (var->sync & FB_SYNC_VERT_HIGH_ACT)
 		tmp |= 0x80;
-	WGen (fb_info, VGA_MIS_W, tmp);
+	WGen (cinfo, VGA_MIS_W, tmp);
 
-	vga_wcrt (fb_info->regs, VGA_CRTC_PRESET_ROW, 0);	/* Screen A Preset Row-Scan register */
-	vga_wcrt (fb_info->regs, VGA_CRTC_CURSOR_START, 0);	/* text cursor on and start line */
-	vga_wcrt (fb_info->regs, VGA_CRTC_CURSOR_END, 31);	/* text cursor end line */
+	vga_wcrt (regbase, VGA_CRTC_PRESET_ROW, 0);	/* Screen A Preset Row-Scan register */
+	vga_wcrt (regbase, VGA_CRTC_CURSOR_START, 0);	/* text cursor on and start line */
+	vga_wcrt (regbase, VGA_CRTC_CURSOR_END, 31);	/* text cursor end line */
 
 	/******************************************************
 	 *
@@ -1272,12 +1116,12 @@
 	 */
 
 	/* programming for different color depths */
-	if (_par->var.bits_per_pixel == 1) {
-		DPRINTK ("clgen: preparing for 1 bit deep display\n");
-		vga_wgfx (fb_info->regs, VGA_GFX_MODE, 0);	/* mode register */
+	if (var->bits_per_pixel == 1) {
+		DPRINTK ("cirrusfb: preparing for 1 bit deep display\n");
+		vga_wgfx (regbase, VGA_GFX_MODE, 0);	/* mode register */
 
 		/* SR07 */
-		switch (fb_info->btype) {
+		switch (cinfo->btype) {
 		case BT_SD64:
 		case BT_PICCOLO:
 		case BT_PICASSO:
@@ -1286,48 +1130,48 @@
 		case BT_ALPINE:
 		case BT_GD5480:
 			DPRINTK (" (for GD54xx)\n");
-			vga_wseq (fb_info->regs, CL_SEQR7,
-				  _par->multiplexing ?
+			vga_wseq (regbase, CL_SEQR7,
+				  regs.multiplexing ?
 				  	bi->sr07_1bpp_mux : bi->sr07_1bpp);
 			break;
 
 		case BT_LAGUNA:
 			DPRINTK (" (for GD546x)\n");
-			vga_wseq (fb_info->regs, CL_SEQR7,
-				vga_rseq (fb_info->regs, CL_SEQR7) & ~0x01);
+			vga_wseq (regbase, CL_SEQR7,
+				vga_rseq (regbase, CL_SEQR7) & ~0x01);
 			break;
 
 		default:
-			printk (KERN_WARNING "clgen: unknown Board\n");
+			printk (KERN_WARNING "cirrusfb: unknown Board\n");
 			break;
 		}
 
 		/* Extended Sequencer Mode */
-		switch (fb_info->btype) {
+		switch (cinfo->btype) {
 		case BT_SD64:
 			/* setting the SEQRF on SD64 is not necessary (only during init) */
 			DPRINTK ("(for SD64)\n");
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x1a);		/*  MCLK select */
+			vga_wseq (regbase, CL_SEQR1F, 0x1a);		/*  MCLK select */
 			break;
 
 		case BT_PICCOLO:
 			DPRINTK ("(for Piccolo)\n");
 /* ### ueberall 0x22? */
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x22);		/* ##vorher 1c MCLK select */
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xb0);	/* evtl d0 bei 1 bit? avoid FIFO underruns..? */
+			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* ##vorher 1c MCLK select */
+			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* evtl d0 bei 1 bit? avoid FIFO underruns..? */
 			break;
 
 		case BT_PICASSO:
 			DPRINTK ("(for Picasso)\n");
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x22);		/* ##vorher 22 MCLK select */
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xd0);	/* ## vorher d0 avoid FIFO underruns..? */
+			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* ##vorher 22 MCLK select */
+			vga_wseq (regbase, CL_SEQRF, 0xd0);	/* ## vorher d0 avoid FIFO underruns..? */
 			break;
 
 		case BT_SPECTRUM:
 			DPRINTK ("(for Spectrum)\n");
 /* ### ueberall 0x22? */
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x22);		/* ##vorher 1c MCLK select */
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xb0);	/* evtl d0? avoid FIFO underruns..? */
+			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* ##vorher 1c MCLK select */
+			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* evtl d0? avoid FIFO underruns..? */
 			break;
 
 		case BT_PICASSO4:
@@ -1339,18 +1183,18 @@
 			break;
 
 		default:
-			printk (KERN_WARNING "clgen: unknown Board\n");
+			printk (KERN_WARNING "cirrusfb: unknown Board\n");
 			break;
 		}
 
-		WGen (fb_info, VGA_PEL_MSK, 0x01);	/* pixel mask: pass-through for first plane */
-		if (_par->multiplexing)
-			WHDR (fb_info, 0x4a);	/* hidden dac reg: 1280x1024 */
+		WGen (cinfo, VGA_PEL_MSK, 0x01);	/* pixel mask: pass-through for first plane */
+		if (regs.multiplexing)
+			WHDR (cinfo, 0x4a);	/* hidden dac reg: 1280x1024 */
 		else
-			WHDR (fb_info, 0);	/* hidden dac: nothing */
-		vga_wseq (fb_info->regs, VGA_SEQ_MEMORY_MODE, 0x06);	/* memory mode: odd/even, ext. memory */
-		vga_wseq (fb_info->regs, VGA_SEQ_PLANE_WRITE, 0x01);	/* plane mask: only write to first plane */
-		offset = _par->var.xres_virtual / 16;
+			WHDR (cinfo, 0);	/* hidden dac: nothing */
+		vga_wseq (regbase, VGA_SEQ_MEMORY_MODE, 0x06);	/* memory mode: odd/even, ext. memory */
+		vga_wseq (regbase, VGA_SEQ_PLANE_WRITE, 0x01);	/* plane mask: only write to first plane */
+		offset = var->xres_virtual / 16;
 	}
 
 	/******************************************************
@@ -1359,9 +1203,9 @@
 	 *
 	 */
 
-	else if (_par->var.bits_per_pixel == 8) {
-		DPRINTK ("clgen: preparing for 8 bit deep display\n");
-		switch (fb_info->btype) {
+	else if (var->bits_per_pixel == 8) {
+		DPRINTK ("cirrusfb: preparing for 8 bit deep display\n");
+		switch (cinfo->btype) {
 		case BT_SD64:
 		case BT_PICCOLO:
 		case BT_PICASSO:
@@ -1370,52 +1214,52 @@
 		case BT_ALPINE:
 		case BT_GD5480:
 			DPRINTK (" (for GD54xx)\n");
-			vga_wseq (fb_info->regs, CL_SEQR7,
-				  _par->multiplexing ?
+			vga_wseq (regbase, CL_SEQR7,
+				  regs.multiplexing ?
 				  	bi->sr07_8bpp_mux : bi->sr07_8bpp);
 			break;
 
 		case BT_LAGUNA:
 			DPRINTK (" (for GD546x)\n");
-			vga_wseq (fb_info->regs, CL_SEQR7,
-				vga_rseq (fb_info->regs, CL_SEQR7) | 0x01);
+			vga_wseq (regbase, CL_SEQR7,
+				vga_rseq (regbase, CL_SEQR7) | 0x01);
 			break;
 
 		default:
-			printk (KERN_WARNING "clgen: unknown Board\n");
+			printk (KERN_WARNING "cirrusfb: unknown Board\n");
 			break;
 		}
 
-		switch (fb_info->btype) {
+		switch (cinfo->btype) {
 		case BT_SD64:
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x1d);		/* MCLK select */
+			vga_wseq (regbase, CL_SEQR1F, 0x1d);		/* MCLK select */
 			break;
 
 		case BT_PICCOLO:
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x22);		/* ### vorher 1c MCLK select */
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
+			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* ### vorher 1c MCLK select */
+			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
 			break;
 
 		case BT_PICASSO:
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x22);		/* ### vorher 1c MCLK select */
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
+			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* ### vorher 1c MCLK select */
+			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
 			break;
 
 		case BT_SPECTRUM:
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x22);		/* ### vorher 1c MCLK select */
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
+			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* ### vorher 1c MCLK select */
+			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
 			break;
 
 		case BT_PICASSO4:
 #ifdef CONFIG_ZORRO
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xb8);	/* ### INCOMPLETE!! */
+			vga_wseq (regbase, CL_SEQRF, 0xb8);	/* ### INCOMPLETE!! */
 #endif
-/*          vga_wseq (fb_info->regs, CL_SEQR1F, 0x1c); */
+/*          vga_wseq (regbase, CL_SEQR1F, 0x1c); */
 			break;
 
 		case BT_ALPINE:
 			DPRINTK (" (for GD543x)\n");
-			clgen_set_mclk (fb_info, _par->mclk, _par->divMCLK);
+			cirrusfb_set_mclk (cinfo, regs.mclk, regs.divMCLK);
 			/* We already set SRF and SR1F */
 			break;
 
@@ -1426,19 +1270,19 @@
 			break;
 
 		default:
-			printk (KERN_WARNING "clgen: unknown Board\n");
+			printk (KERN_WARNING "cirrusfb: unknown Board\n");
 			break;
 		}
 
-		vga_wgfx (fb_info->regs, VGA_GFX_MODE, 64);	/* mode register: 256 color mode */
-		WGen (fb_info, VGA_PEL_MSK, 0xff);	/* pixel mask: pass-through all planes */
-		if (_par->multiplexing)
-			WHDR (fb_info, 0x4a);	/* hidden dac reg: 1280x1024 */
+		vga_wgfx (regbase, VGA_GFX_MODE, 64);	/* mode register: 256 color mode */
+		WGen (cinfo, VGA_PEL_MSK, 0xff);	/* pixel mask: pass-through all planes */
+		if (regs.multiplexing)
+			WHDR (cinfo, 0x4a);	/* hidden dac reg: 1280x1024 */
 		else
-			WHDR (fb_info, 0);	/* hidden dac: nothing */
-		vga_wseq (fb_info->regs, VGA_SEQ_MEMORY_MODE, 0x0a);	/* memory mode: chain4, ext. memory */
-		vga_wseq (fb_info->regs, VGA_SEQ_PLANE_WRITE, 0xff);	/* plane mask: enable writing to all 4 planes */
-		offset = _par->var.xres_virtual / 8;
+			WHDR (cinfo, 0);	/* hidden dac: nothing */
+		vga_wseq (regbase, VGA_SEQ_MEMORY_MODE, 0x0a);	/* memory mode: chain4, ext. memory */
+		vga_wseq (regbase, VGA_SEQ_PLANE_WRITE, 0xff);	/* plane mask: enable writing to all 4 planes */
+		offset = var->xres_virtual / 8;
 	}
 
 	/******************************************************
@@ -1447,74 +1291,74 @@
 	 *
 	 */
 
-	else if (_par->var.bits_per_pixel == 16) {
-		DPRINTK ("clgen: preparing for 16 bit deep display\n");
-		switch (fb_info->btype) {
+	else if (var->bits_per_pixel == 16) {
+		DPRINTK ("cirrusfb: preparing for 16 bit deep display\n");
+		switch (cinfo->btype) {
 		case BT_SD64:
-			vga_wseq (fb_info->regs, CL_SEQR7, 0xf7);	/* Extended Sequencer Mode: 256c col. mode */
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x1e);		/* MCLK select */
+			vga_wseq (regbase, CL_SEQR7, 0xf7);	/* Extended Sequencer Mode: 256c col. mode */
+			vga_wseq (regbase, CL_SEQR1F, 0x1e);		/* MCLK select */
 			break;
 
 		case BT_PICCOLO:
-			vga_wseq (fb_info->regs, CL_SEQR7, 0x87);
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x22);		/* MCLK select */
+			vga_wseq (regbase, CL_SEQR7, 0x87);
+			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
+			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* MCLK select */
 			break;
 
 		case BT_PICASSO:
-			vga_wseq (fb_info->regs, CL_SEQR7, 0x27);
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x22);		/* MCLK select */
+			vga_wseq (regbase, CL_SEQR7, 0x27);
+			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
+			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* MCLK select */
 			break;
 
 		case BT_SPECTRUM:
-			vga_wseq (fb_info->regs, CL_SEQR7, 0x87);
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x22);		/* MCLK select */
+			vga_wseq (regbase, CL_SEQR7, 0x87);
+			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
+			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* MCLK select */
 			break;
 
 		case BT_PICASSO4:
-			vga_wseq (fb_info->regs, CL_SEQR7, 0x27);
-/*          vga_wseq (fb_info->regs, CL_SEQR1F, 0x1c);  */
+			vga_wseq (regbase, CL_SEQR7, 0x27);
+/*          vga_wseq (regbase, CL_SEQR1F, 0x1c);  */
 			break;
 
 		case BT_ALPINE:
 			DPRINTK (" (for GD543x)\n");
-			if (_par->HorizRes >= 1024)
-				vga_wseq (fb_info->regs, CL_SEQR7, 0xa7);
+			if (regs.HorizRes >= 1024)
+				vga_wseq (regbase, CL_SEQR7, 0xa7);
 			else
-				vga_wseq (fb_info->regs, CL_SEQR7, 0xa3);
-			clgen_set_mclk (fb_info, _par->mclk, _par->divMCLK);
+				vga_wseq (regbase, CL_SEQR7, 0xa3);
+			cirrusfb_set_mclk (cinfo, regs.mclk, regs.divMCLK);
 			break;
 
 		case BT_GD5480:
 			DPRINTK (" (for GD5480)\n");
-			vga_wseq (fb_info->regs, CL_SEQR7, 0x17);
+			vga_wseq (regbase, CL_SEQR7, 0x17);
 			/* We already set SRF and SR1F */
 			break;
 
 		case BT_LAGUNA:
 			DPRINTK (" (for GD546x)\n");
-			vga_wseq (fb_info->regs, CL_SEQR7,
-				vga_rseq (fb_info->regs, CL_SEQR7) & ~0x01);
+			vga_wseq (regbase, CL_SEQR7,
+				vga_rseq (regbase, CL_SEQR7) & ~0x01);
 			break;
 
 		default:
-			printk (KERN_WARNING "CLGEN: unknown Board\n");
+			printk (KERN_WARNING "CIRRUSFB: unknown Board\n");
 			break;
 		}
 
-		vga_wgfx (fb_info->regs, VGA_GFX_MODE, 64);	/* mode register: 256 color mode */
-		WGen (fb_info, VGA_PEL_MSK, 0xff);	/* pixel mask: pass-through all planes */
+		vga_wgfx (regbase, VGA_GFX_MODE, 64);	/* mode register: 256 color mode */
+		WGen (cinfo, VGA_PEL_MSK, 0xff);	/* pixel mask: pass-through all planes */
 #ifdef CONFIG_PCI
-		WHDR (fb_info, 0xc0);	/* Copy Xbh */
+		WHDR (cinfo, 0xc0);	/* Copy Xbh */
 #elif defined(CONFIG_ZORRO)
 		/* FIXME: CONFIG_PCI and CONFIG_ZORRO may be defined both */
-		WHDR (fb_info, 0xa0);	/* hidden dac reg: nothing special */
+		WHDR (cinfo, 0xa0);	/* hidden dac reg: nothing special */
 #endif
-		vga_wseq (fb_info->regs, VGA_SEQ_MEMORY_MODE, 0x0a);	/* memory mode: chain4, ext. memory */
-		vga_wseq (fb_info->regs, VGA_SEQ_PLANE_WRITE, 0xff);	/* plane mask: enable writing to all 4 planes */
-		offset = _par->var.xres_virtual / 4;
+		vga_wseq (regbase, VGA_SEQ_MEMORY_MODE, 0x0a);	/* memory mode: chain4, ext. memory */
+		vga_wseq (regbase, VGA_SEQ_PLANE_WRITE, 0xff);	/* plane mask: enable writing to all 4 planes */
+		offset = var->xres_virtual / 4;
 	}
 
 	/******************************************************
@@ -1523,66 +1367,66 @@
 	 *
 	 */
 
-	else if (_par->var.bits_per_pixel == 32) {
-		DPRINTK ("clgen: preparing for 24/32 bit deep display\n");
-		switch (fb_info->btype) {
+	else if (var->bits_per_pixel == 32) {
+		DPRINTK ("cirrusfb: preparing for 24/32 bit deep display\n");
+		switch (cinfo->btype) {
 		case BT_SD64:
-			vga_wseq (fb_info->regs, CL_SEQR7, 0xf9);	/* Extended Sequencer Mode: 256c col. mode */
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x1e);		/* MCLK select */
+			vga_wseq (regbase, CL_SEQR7, 0xf9);	/* Extended Sequencer Mode: 256c col. mode */
+			vga_wseq (regbase, CL_SEQR1F, 0x1e);		/* MCLK select */
 			break;
 
 		case BT_PICCOLO:
-			vga_wseq (fb_info->regs, CL_SEQR7, 0x85);
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x22);		/* MCLK select */
+			vga_wseq (regbase, CL_SEQR7, 0x85);
+			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
+			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* MCLK select */
 			break;
 
 		case BT_PICASSO:
-			vga_wseq (fb_info->regs, CL_SEQR7, 0x25);
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x22);		/* MCLK select */
+			vga_wseq (regbase, CL_SEQR7, 0x25);
+			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
+			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* MCLK select */
 			break;
 
 		case BT_SPECTRUM:
-			vga_wseq (fb_info->regs, CL_SEQR7, 0x85);
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
-			vga_wseq (fb_info->regs, CL_SEQR1F, 0x22);		/* MCLK select */
+			vga_wseq (regbase, CL_SEQR7, 0x85);
+			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast Page-Mode writes */
+			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* MCLK select */
 			break;
 
 		case BT_PICASSO4:
-			vga_wseq (fb_info->regs, CL_SEQR7, 0x25);
-/*          vga_wseq (fb_info->regs, CL_SEQR1F, 0x1c);  */
+			vga_wseq (regbase, CL_SEQR7, 0x25);
+/*          vga_wseq (regbase, CL_SEQR1F, 0x1c);  */
 			break;
 
 		case BT_ALPINE:
 			DPRINTK (" (for GD543x)\n");
-			vga_wseq (fb_info->regs, CL_SEQR7, 0xa9);
-			clgen_set_mclk (fb_info, _par->mclk, _par->divMCLK);
+			vga_wseq (regbase, CL_SEQR7, 0xa9);
+			cirrusfb_set_mclk (cinfo, regs.mclk, regs.divMCLK);
 			break;
 
 		case BT_GD5480:
 			DPRINTK (" (for GD5480)\n");
-			vga_wseq (fb_info->regs, CL_SEQR7, 0x19);
+			vga_wseq (regbase, CL_SEQR7, 0x19);
 			/* We already set SRF and SR1F */
 			break;
 
 		case BT_LAGUNA:
 			DPRINTK (" (for GD546x)\n");
-			vga_wseq (fb_info->regs, CL_SEQR7,
-				vga_rseq (fb_info->regs, CL_SEQR7) & ~0x01);
+			vga_wseq (regbase, CL_SEQR7,
+				vga_rseq (regbase, CL_SEQR7) & ~0x01);
 			break;
 
 		default:
-			printk (KERN_WARNING "clgen: unknown Board\n");
+			printk (KERN_WARNING "cirrusfb: unknown Board\n");
 			break;
 		}
 
-		vga_wgfx (fb_info->regs, VGA_GFX_MODE, 64);	/* mode register: 256 color mode */
-		WGen (fb_info, VGA_PEL_MSK, 0xff);	/* pixel mask: pass-through all planes */
-		WHDR (fb_info, 0xc5);	/* hidden dac reg: 8-8-8 mode (24 or 32) */
-		vga_wseq (fb_info->regs, VGA_SEQ_MEMORY_MODE, 0x0a);	/* memory mode: chain4, ext. memory */
-		vga_wseq (fb_info->regs, VGA_SEQ_PLANE_WRITE, 0xff);	/* plane mask: enable writing to all 4 planes */
-		offset = _par->var.xres_virtual / 4;
+		vga_wgfx (regbase, VGA_GFX_MODE, 64);	/* mode register: 256 color mode */
+		WGen (cinfo, VGA_PEL_MSK, 0xff);	/* pixel mask: pass-through all planes */
+		WHDR (cinfo, 0xc5);	/* hidden dac reg: 8-8-8 mode (24 or 32) */
+		vga_wseq (regbase, VGA_SEQ_MEMORY_MODE, 0x0a);	/* memory mode: chain4, ext. memory */
+		vga_wseq (regbase, VGA_SEQ_PLANE_WRITE, 0xff);	/* plane mask: enable writing to all 4 planes */
+		offset = var->xres_virtual / 4;
 	}
 
 	/******************************************************
@@ -1592,47 +1436,47 @@
 	 */
 
 	else {
-		printk (KERN_ERR "clgen: What's this?? requested color depth == %d.\n",
-			_par->var.bits_per_pixel);
+		printk (KERN_ERR "cirrusfb: What's this?? requested color depth == %d.\n",
+			var->bits_per_pixel);
 	}
 
-	vga_wcrt (fb_info->regs, VGA_CRTC_OFFSET, offset & 0xff);
+	vga_wcrt (regbase, VGA_CRTC_OFFSET, offset & 0xff);
 	tmp = 0x22;
 	if (offset & 0x100)
 		tmp |= 0x10;	/* offset overflow bit */
 
-	vga_wcrt (fb_info->regs, CL_CRT1B, tmp);	/* screen start addr #16-18, fastpagemode cycles */
+	vga_wcrt (regbase, CL_CRT1B, tmp);	/* screen start addr #16-18, fastpagemode cycles */
 
-	if (fb_info->btype == BT_SD64 ||
-	    fb_info->btype == BT_PICASSO4 ||
-	    fb_info->btype == BT_ALPINE ||
-	    fb_info->btype == BT_GD5480)
-		vga_wcrt (fb_info->regs, CL_CRT1D, 0x00);	/* screen start address bit 19 */
-
-	vga_wcrt (fb_info->regs, VGA_CRTC_CURSOR_HI, 0);	/* text cursor location high */
-	vga_wcrt (fb_info->regs, VGA_CRTC_CURSOR_LO, 0);	/* text cursor location low */
-	vga_wcrt (fb_info->regs, VGA_CRTC_UNDERLINE, 0);	/* underline row scanline = at very bottom */
-
-	vga_wattr (fb_info->regs, VGA_ATC_MODE, 1);	/* controller mode */
-	vga_wattr (fb_info->regs, VGA_ATC_OVERSCAN, 0);		/* overscan (border) color */
-	vga_wattr (fb_info->regs, VGA_ATC_PLANE_ENABLE, 15);	/* color plane enable */
-	vga_wattr (fb_info->regs, CL_AR33, 0);	/* pixel panning */
-	vga_wattr (fb_info->regs, VGA_ATC_COLOR_PAGE, 0);	/* color select */
+	if (cinfo->btype == BT_SD64 ||
+	    cinfo->btype == BT_PICASSO4 ||
+	    cinfo->btype == BT_ALPINE ||
+	    cinfo->btype == BT_GD5480)
+		vga_wcrt (regbase, CL_CRT1D, 0x00);	/* screen start address bit 19 */
+
+	vga_wcrt (regbase, VGA_CRTC_CURSOR_HI, 0);	/* text cursor location high */
+	vga_wcrt (regbase, VGA_CRTC_CURSOR_LO, 0);	/* text cursor location low */
+	vga_wcrt (regbase, VGA_CRTC_UNDERLINE, 0);	/* underline row scanline = at very bottom */
+
+	vga_wattr (regbase, VGA_ATC_MODE, 1);	/* controller mode */
+	vga_wattr (regbase, VGA_ATC_OVERSCAN, 0);		/* overscan (border) color */
+	vga_wattr (regbase, VGA_ATC_PLANE_ENABLE, 15);	/* color plane enable */
+	vga_wattr (regbase, CL_AR33, 0);	/* pixel panning */
+	vga_wattr (regbase, VGA_ATC_COLOR_PAGE, 0);	/* color select */
 
 	/* [ EGS: SetOffset(); ] */
 	/* From SetOffset(): Turn on VideoEnable bit in Attribute controller */
-	AttrOn (fb_info);
+	AttrOn (cinfo);
 
-	vga_wgfx (fb_info->regs, VGA_GFX_SR_VALUE, 0);	/* set/reset register */
-	vga_wgfx (fb_info->regs, VGA_GFX_SR_ENABLE, 0);		/* set/reset enable */
-	vga_wgfx (fb_info->regs, VGA_GFX_COMPARE_VALUE, 0);	/* color compare */
-	vga_wgfx (fb_info->regs, VGA_GFX_DATA_ROTATE, 0);	/* data rotate */
-	vga_wgfx (fb_info->regs, VGA_GFX_PLANE_READ, 0);	/* read map select */
-	vga_wgfx (fb_info->regs, VGA_GFX_MISC, 1);	/* miscellaneous register */
-	vga_wgfx (fb_info->regs, VGA_GFX_COMPARE_MASK, 15);	/* color don't care */
-	vga_wgfx (fb_info->regs, VGA_GFX_BIT_MASK, 255);	/* bit mask */
+	vga_wgfx (regbase, VGA_GFX_SR_VALUE, 0);	/* set/reset register */
+	vga_wgfx (regbase, VGA_GFX_SR_ENABLE, 0);		/* set/reset enable */
+	vga_wgfx (regbase, VGA_GFX_COMPARE_VALUE, 0);	/* color compare */
+	vga_wgfx (regbase, VGA_GFX_DATA_ROTATE, 0);	/* data rotate */
+	vga_wgfx (regbase, VGA_GFX_PLANE_READ, 0);	/* read map select */
+	vga_wgfx (regbase, VGA_GFX_MISC, 1);	/* miscellaneous register */
+	vga_wgfx (regbase, VGA_GFX_COMPARE_MASK, 15);	/* color don't care */
+	vga_wgfx (regbase, VGA_GFX_BIT_MASK, 255);	/* bit mask */
 
-	vga_wseq (fb_info->regs, CL_SEQR12, 0x0);	/* graphics cursor attributes: nothing special */
+	vga_wseq (regbase, CL_SEQR12, 0x0);	/* graphics cursor attributes: nothing special */
 
 	/* finally, turn on everything - turn off "FullBandwidth" bit */
 	/* also, set "DotClock%2" bit where requested */
@@ -1643,149 +1487,112 @@
 	tmp |= 0x08;
 */
 
-	vga_wseq (fb_info->regs, VGA_SEQ_CLOCK_MODE, tmp);
+	vga_wseq (regbase, VGA_SEQ_CLOCK_MODE, tmp);
 	DPRINTK ("CL_SEQR1: %d\n", tmp);
 
-	fb_info->currentmode = *_par;
+	cinfo->currentmode = regs;
+	info->fix.type = regs.type;
+	info->fix.visual = regs.visual;
+	info->fix.line_length = regs.line_length;
 
-	DPRINTK ("virtual offset: (%d,%d)\n", _par->var.xoffset, _par->var.yoffset);
 	/* pan to requested offset */
-	clgen_pan_display (&fb_info->currentmode.var, (struct fb_info_gen *) fb_info);
+	cirrusfb_pan_display (var, info);
 
-#ifdef CLGEN_DEBUG
-	clgen_dump ();
+#ifdef CIRRUSFB_DEBUG
+	cirrusfb_dump ();
 #endif
 
 	DPRINTK ("EXIT\n");
-	return;
+	return 0;
 }
 
-
-static int clgen_getcolreg (unsigned regno, unsigned *red, unsigned *green,
-			    unsigned *blue, unsigned *transp,
-			    struct fb_info *info)
+/* for some reason incomprehensible to me, cirrusfb requires that you write
+ * the registers twice for the settings to take..grr. -dte */
+int cirrusfb_set_par (struct fb_info *info)
 {
-    struct clgenfb_info *fb_info = (struct clgenfb_info *)info;
-
-    if (regno > 255)
-	return 1;
-    *red = fb_info->palette[regno].red;
-    *green = fb_info->palette[regno].green;
-    *blue = fb_info->palette[regno].blue;
-    *transp = 0;
-    return 0;
+	cirrusfb_set_par_foo (info);
+	return cirrusfb_set_par_foo (info);
 }
 
-
-static int clgenfb_setcolreg (unsigned regno, unsigned red, unsigned green,
-			      unsigned blue, unsigned transp,
-			      struct fb_info *info)
+int cirrusfb_setcolreg (unsigned regno, unsigned red, unsigned green,
+			unsigned blue, unsigned transp,
+			struct fb_info *info)
 {
-	struct clgenfb_info *fb_info = (struct clgenfb_info *) info;
+	struct cirrusfb_info *cinfo = info->par;
 
 	if (regno > 255)
 		return -EINVAL;
 
-#ifdef FBCON_HAS_CFB8
-	switch (fb_info->currentmode.var.bits_per_pixel) {
-	case 8:
-		/* "transparent" stuff is completely ignored. */
-		WClut (fb_info, regno, red >> 10, green >> 10, blue >> 10);
-		break;
-	default:
-		/* do nothing */
-		break;
-	}
-#endif	/* FBCON_HAS_CFB8 */
-
-	fb_info->palette[regno].red = red;
-	fb_info->palette[regno].green = green;
-	fb_info->palette[regno].blue = blue;
-
-	if (regno >= 16)
-		return 0;
-
-	switch (fb_info->currentmode.var.bits_per_pixel) {
-
-#ifdef FBCON_HAS_CFB16
-	case 16:
-		assert (regno < 16);
-		if(isPReP) {
-			fb_info->fbcon_cmap.cfb16[regno] =
-			    ((red & 0xf800) >> 9) |
-			    ((green & 0xf800) >> 14) |
-			    ((green & 0xf800) << 2) |
-			    ((blue & 0xf800) >> 3);
-		} else {
-			fb_info->fbcon_cmap.cfb16[regno] =
-			    ((red & 0xf800) >> 1) |
-			    ((green & 0xf800) >> 6) |
-			    ((blue & 0xf800) >> 11);
+	if (info->fix.visual == FB_VISUAL_TRUECOLOR) {
+		u32 v;
+		red >>= (16 - info->var.red.length);
+		green >>= (16 - info->var.green.length);
+		blue >>= (16 - info->var.blue.length);
+	
+		if (regno>=16)
+			return 1;
+		v = (red << info->var.red.offset) |
+		    (green << info->var.green.offset) |
+		    (blue << info->var.blue.offset);
+		
+		switch (info->var.bits_per_pixel) {
+			case 8:
+				((u8*)(info->pseudo_palette))[regno] = v;
+				break;
+			case 16:
+				((u16*)(info->pseudo_palette))[regno] = v;
+				break;
+			case 24:
+			case 32:
+				((u32*)(info->pseudo_palette))[regno] = v;
+				break;
 		}
-#endif /* FBCON_HAS_CFB16 */
-
-#ifdef FBCON_HAS_CFB24
-	case 24:
-		assert (regno < 16);
-		fb_info->fbcon_cmap.cfb24[regno] =
-			(red   << fb_info->currentmode.var.red.offset)   |
-			(green << fb_info->currentmode.var.green.offset) |
-			(blue  << fb_info->currentmode.var.blue.offset);
-		break;
-#endif /* FBCON_HAS_CFB24 */
+		return 0;
+	}	
+	
+	cinfo->palette[regno].red = red;
+	cinfo->palette[regno].green = green;
+	cinfo->palette[regno].blue = blue;
 
-#ifdef FBCON_HAS_CFB32
-	case 32:
-		assert (regno < 16);
-		if(isPReP) {
-			fb_info->fbcon_cmap.cfb32[regno] =
-			    ((red & 0xff00)) |
-			    ((green & 0xff00) << 8) |
-			    ((blue & 0xff00) << 16);
-		} else {
-			fb_info->fbcon_cmap.cfb32[regno] =
-			    ((red & 0xff00) << 8) |
-			    ((green & 0xff00)) |
-			    ((blue & 0xff00) >> 8);
-		}
-		break;
-#endif /* FBCON_HAS_CFB32 */
-	default:
-		/* do nothing */
-		break;
+	if (info->var.bits_per_pixel == 8) {
+			WClut (cinfo, regno, red >> 10, green >> 10, blue >> 10);
 	}
 
 	return 0;
+
 }
 
 /*************************************************************************
-	clgen_pan_display()
+	cirrusfb_pan_display()
 
 	performs display panning - provided hardware permits this
 **************************************************************************/
-static int clgen_pan_display (const struct fb_var_screeninfo *var,
-			      struct fb_info_gen *info)
+int cirrusfb_pan_display (struct fb_var_screeninfo *var,
+			  struct fb_info *info)
 {
 	int xoffset = 0;
 	int yoffset = 0;
 	unsigned long base;
 	unsigned char tmp = 0, tmp2 = 0, xpix;
-	struct clgenfb_info *fb_info = (struct clgenfb_info *) info;
+	struct cirrusfb_info *cinfo = info->par;
 
 	DPRINTK ("ENTER\n");
+	DPRINTK ("virtual offset: (%d,%d)\n", var->xoffset, var->yoffset);
 
 	/* no range checks for xoffset and yoffset,   */
-	/* as fbgen_pan_display has already done this */
+	/* as fb_pan_display has already done this */
+	if (var->vmode & FB_VMODE_YWRAP)
+		return -EINVAL;
 
-	fb_info->currentmode.var.xoffset = var->xoffset;
-	fb_info->currentmode.var.yoffset = var->yoffset;
+	info->var.xoffset = var->xoffset;
+	info->var.yoffset = var->yoffset;
 
-	xoffset = var->xoffset * fb_info->currentmode.var.bits_per_pixel / 8;
+	xoffset = var->xoffset * info->var.bits_per_pixel / 8;
 	yoffset = var->yoffset;
 
-	base = yoffset * fb_info->currentmode.line_length + xoffset;
+	base = yoffset * cinfo->currentmode.line_length + xoffset;
 
-	if (fb_info->currentmode.var.bits_per_pixel == 1) {
+	if (info->var.bits_per_pixel == 1) {
 		/* base is already correct */
 		xpix = (unsigned char) (var->xoffset % 8);
 	} else {
@@ -1793,9 +1600,11 @@
 		xpix = (unsigned char) ((xoffset % 4) * 2);
 	}
 
+        cirrusfb_WaitBLT(cinfo->regbase); /* make sure all the BLT's are done */
+
 	/* lower 8 + 8 bits of screen start address */
-	vga_wcrt (fb_info->regs, VGA_CRTC_START_LO, (unsigned char) (base & 0xff));
-	vga_wcrt (fb_info->regs, VGA_CRTC_START_HI, (unsigned char) (base >> 8));
+	vga_wcrt (cinfo->regbase, VGA_CRTC_START_LO, (unsigned char) (base & 0xff));
+	vga_wcrt (cinfo->regbase, VGA_CRTC_START_HI, (unsigned char) (base >> 8));
 
 	/* construct bits 16, 17 and 18 of screen start address */
 	if (base & 0x10000)
@@ -1805,29 +1614,30 @@
 	if (base & 0x40000)
 		tmp |= 0x08;
 
-	tmp2 = (vga_rcrt (fb_info->regs, CL_CRT1B) & 0xf2) | tmp;	/* 0xf2 is %11110010, exclude tmp bits */
-	vga_wcrt (fb_info->regs, CL_CRT1B, tmp2);
+	tmp2 = (vga_rcrt (cinfo->regbase, CL_CRT1B) & 0xf2) | tmp;	/* 0xf2 is %11110010, exclude tmp bits */
+	vga_wcrt (cinfo->regbase, CL_CRT1B, tmp2);
 
 	/* construct bit 19 of screen start address */
-	if (clgen_board_info[fb_info->btype].scrn_start_bit19) {
+	if (cirrusfb_board_info[cinfo->btype].scrn_start_bit19) {
 		tmp2 = 0;
 		if (base & 0x80000)
 			tmp2 = 0x80;
-		vga_wcrt (fb_info->regs, CL_CRT1D, tmp2);
+		vga_wcrt (cinfo->regbase, CL_CRT1D, tmp2);
 	}
 
 	/* write pixel panning value to AR33; this does not quite work in 8bpp */
 	/* ### Piccolo..? Will this work? */
-	if (fb_info->currentmode.var.bits_per_pixel == 1)
-		vga_wattr (fb_info->regs, CL_AR33, xpix);
-
+	if (info->var.bits_per_pixel == 1)
+		vga_wattr (cinfo->regbase, CL_AR33, xpix);
 
+	cirrusfb_WaitBLT (cinfo->regbase);
+	
 	DPRINTK ("EXIT\n");
 	return (0);
 }
 
 
-static int clgen_blank (int blank_mode, struct fb_info_gen *info)
+int cirrusfb_blank (int blank_mode, struct fb_info *info)
 {
 	/*
 	 *  Blank the screen if blank_mode != 0, else unblank. If blank == NULL
@@ -1840,57 +1650,51 @@
 	 *    blank_mode == 4: powerdown
 	 */
 	unsigned char val;
-	static int current_mode = 0;
-	struct clgenfb_info *fb_info = (struct clgenfb_info *) info;
+	struct cirrusfb_info *cinfo = info->par;
+	int current_mode = cinfo->blank_mode;
 
 	DPRINTK ("ENTER, blank mode = %d\n", blank_mode);
 
-	if (current_mode == blank_mode) {
+	if (info->state != FBINFO_STATE_RUNNING || 
+	    current_mode == blank_mode) {
 		DPRINTK ("EXIT, returning 0\n");
 		return 0;
 	}
 
 	/* Undo current */
-	switch (current_mode) {
-	case 0:		/* Screen is normal */
-		break;
-	case 1:		/* Screen is blanked */
-		val = vga_rseq (fb_info->regs, VGA_SEQ_CLOCK_MODE);
-		vga_wseq (fb_info->regs, VGA_SEQ_CLOCK_MODE, val & 0xdf);	/* clear "FullBandwidth" bit */
-		break;
-	case 2:		/* vsync suspended */
-	case 3:		/* hsync suspended */
-	case 4:		/* sceen is powered down */
-		vga_wgfx (fb_info->regs, CL_GRE, 0x00);
-		break;
-	default:
-		DPRINTK ("EXIT, returning 1\n");
-		return 1;
+	if (current_mode != VESA_NO_BLANKING) {
+		/* unblank the screen */
+		val = vga_rseq (cinfo->regbase, VGA_SEQ_CLOCK_MODE);
+		vga_wseq (cinfo->regbase, VGA_SEQ_CLOCK_MODE, val & 0xdf);	/* clear "FullBandwidth" bit */
+		/* and undo VESA suspend trickery */
+		vga_wgfx (cinfo->regbase, CL_GRE, 0x00);
 	}
-
+	
 	/* set new */
+	if(blank_mode != VESA_NO_BLANKING) {
+		/* blank the screen */
+		val = vga_rseq (cinfo->regbase, VGA_SEQ_CLOCK_MODE);
+		vga_wseq (cinfo->regbase, VGA_SEQ_CLOCK_MODE, val | 0x20);	/* set "FullBandwidth" bit */
+	}
+
 	switch (blank_mode) {
-	case 0:		/* Unblank screen */
+	case VESA_NO_BLANKING:
 		break;
-	case 1:		/* Blank screen */
-		val = vga_rseq (fb_info->regs, VGA_SEQ_CLOCK_MODE);
-		vga_wseq (fb_info->regs, VGA_SEQ_CLOCK_MODE, val | 0x20);	/* set "FullBandwidth" bit */
+	case VESA_VSYNC_SUSPEND:
+		vga_wgfx (cinfo->regbase, CL_GRE, 0x04);
 		break;
-	case 2:		/* suspend vsync */
-		vga_wgfx (fb_info->regs, CL_GRE, 0x04);
+	case VESA_HSYNC_SUSPEND:
+		vga_wgfx (cinfo->regbase, CL_GRE, 0x02);
 		break;
-	case 3:		/* suspend hsync */
-		vga_wgfx (fb_info->regs, CL_GRE, 0x02);
-		break;
-	case 4:		/* powerdown */
-		vga_wgfx (fb_info->regs, CL_GRE, 0x06);
+	case VESA_POWERDOWN:
+		vga_wgfx (cinfo->regbase, CL_GRE, 0x06);
 		break;
 	default:
 		DPRINTK ("EXIT, returning 1\n");
 		return 1;
 	}
 
-	current_mode = blank_mode;
+	cinfo->blank_mode = blank_mode;
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
 }
@@ -1898,45 +1702,45 @@
 /****************************************************************************/
 /**** BEGIN Internal Routines ***********************************************/
 
-static void __init init_vgachip (struct clgenfb_info *fb_info)
+static void init_vgachip (struct cirrusfb_info *cinfo)
 {
-	const struct clgen_board_info_rec *bi;
+	const struct cirrusfb_board_info_rec *bi;
 
 	DPRINTK ("ENTER\n");
 
-	assert (fb_info != NULL);
+	assert (cinfo != NULL);
 
-	bi = &clgen_board_info[fb_info->btype];
+	bi = &cirrusfb_board_info[cinfo->btype];
 
 	/* reset board globally */
-	switch (fb_info->btype) {
+	switch (cinfo->btype) {
 	case BT_PICCOLO:
-		WSFR (fb_info, 0x01);
+		WSFR (cinfo, 0x01);
 		udelay (500);
-		WSFR (fb_info, 0x51);
+		WSFR (cinfo, 0x51);
 		udelay (500);
 		break;
 	case BT_PICASSO:
-		WSFR2 (fb_info, 0xff);
+		WSFR2 (cinfo, 0xff);
 		udelay (500);
 		break;
 	case BT_SD64:
 	case BT_SPECTRUM:
-		WSFR (fb_info, 0x1f);
+		WSFR (cinfo, 0x1f);
 		udelay (500);
-		WSFR (fb_info, 0x4f);
+		WSFR (cinfo, 0x4f);
 		udelay (500);
 		break;
 	case BT_PICASSO4:
-		vga_wcrt (fb_info->regs, CL_CRT51, 0x00);	/* disable flickerfixer */
+		vga_wcrt (cinfo->regbase, CL_CRT51, 0x00);	/* disable flickerfixer */
 		mdelay (100);
-		vga_wgfx (fb_info->regs, CL_GR2F, 0x00);	/* from Klaus' NetBSD driver: */
-		vga_wgfx (fb_info->regs, CL_GR33, 0x00);	/* put blitter into 542x compat */
-		vga_wgfx (fb_info->regs, CL_GR31, 0x00);	/* mode */
+		vga_wgfx (cinfo->regbase, CL_GR2F, 0x00);	/* from Klaus' NetBSD driver: */
+		vga_wgfx (cinfo->regbase, CL_GR33, 0x00);	/* put blitter into 542x compat */
+		vga_wgfx (cinfo->regbase, CL_GR31, 0x00);	/* mode */
 		break;
 
 	case BT_GD5480:
-		vga_wgfx (fb_info->regs, CL_GR2F, 0x00);	/* from Klaus' NetBSD driver: */
+		vga_wgfx (cinfo->regbase, CL_GR2F, 0x00);	/* from Klaus' NetBSD driver: */
 		break;
 
 	case BT_ALPINE:
@@ -1944,220 +1748,190 @@
 		break;
 
 	default:
-		printk (KERN_ERR "clgen: Warning: Unknown board type\n");
+		printk (KERN_ERR "cirrusfb: Warning: Unknown board type\n");
 		break;
 	}
 
-	assert (fb_info->size > 0); /* make sure RAM size set by this point */
-
-	/* assume it's a "large memory" board (2/4 MB) */
-	fb_info->smallboard = FALSE;
+	assert (cinfo->size > 0); /* make sure RAM size set by this point */
 
 	/* the P4 is not fully initialized here; I rely on it having been */
 	/* inited under AmigaOS already, which seems to work just fine    */
 	/* (Klaus advised to do it this way)                              */
 
-	if (fb_info->btype != BT_PICASSO4) {
-		WGen (fb_info, CL_VSSM, 0x10);	/* EGS: 0x16 */
-		WGen (fb_info, CL_POS102, 0x01);
-		WGen (fb_info, CL_VSSM, 0x08);	/* EGS: 0x0e */
+	if (cinfo->btype != BT_PICASSO4) {
+		WGen (cinfo, CL_VSSM, 0x10);	/* EGS: 0x16 */
+		WGen (cinfo, CL_POS102, 0x01);
+		WGen (cinfo, CL_VSSM, 0x08);	/* EGS: 0x0e */
 
-		if (fb_info->btype != BT_SD64)
-			WGen (fb_info, CL_VSSM2, 0x01);
+		if (cinfo->btype != BT_SD64)
+			WGen (cinfo, CL_VSSM2, 0x01);
 
-		vga_wseq (fb_info->regs, CL_SEQR0, 0x03);	/* reset sequencer logic */
+		vga_wseq (cinfo->regbase, CL_SEQR0, 0x03);	/* reset sequencer logic */
 
-		vga_wseq (fb_info->regs, VGA_SEQ_CLOCK_MODE, 0x21);	/* FullBandwidth (video off) and 8/9 dot clock */
-		WGen (fb_info, VGA_MIS_W, 0xc1);	/* polarity (-/-), disable access to display memory, VGA_CRTC_START_HI base address: color */
+		vga_wseq (cinfo->regbase, VGA_SEQ_CLOCK_MODE, 0x21);	/* FullBandwidth (video off) and 8/9 dot clock */
+		WGen (cinfo, VGA_MIS_W, 0xc1);	/* polarity (-/-), disable access to display memory, VGA_CRTC_START_HI base address: color */
 
-/*      vga_wgfx (fb_info->regs, CL_GRA, 0xce);    "magic cookie" - doesn't make any sense to me.. */
-		vga_wseq (fb_info->regs, CL_SEQR6, 0x12);	/* unlock all extension registers */
+/*      vga_wgfx (cinfo->regbase, CL_GRA, 0xce);    "magic cookie" - doesn't make any sense to me.. */
+		vga_wseq (cinfo->regbase, CL_SEQR6, 0x12);	/* unlock all extension registers */
 
-		vga_wgfx (fb_info->regs, CL_GR31, 0x04);	/* reset blitter */
+		vga_wgfx (cinfo->regbase, CL_GR31, 0x04);	/* reset blitter */
 
-		switch (fb_info->btype) {
+		switch (cinfo->btype) {
 		case BT_GD5480:
-			vga_wseq (fb_info->regs, CL_SEQRF, 0x98);
+			vga_wseq (cinfo->regbase, CL_SEQRF, 0x98);
 			break;
 		case BT_ALPINE:
 			break;
 		case BT_SD64:
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xb8);
+			vga_wseq (cinfo->regbase, CL_SEQRF, 0xb8);
 			break;
 		default:
-			vga_wseq (fb_info->regs, CL_SEQR16, 0x0f);
-			vga_wseq (fb_info->regs, CL_SEQRF, 0xb0);
+			vga_wseq (cinfo->regbase, CL_SEQR16, 0x0f);
+			vga_wseq (cinfo->regbase, CL_SEQRF, 0xb0);
 			break;
 		}
 	}
-	vga_wseq (fb_info->regs, VGA_SEQ_PLANE_WRITE, 0xff);	/* plane mask: nothing */
-	vga_wseq (fb_info->regs, VGA_SEQ_CHARACTER_MAP, 0x00);	/* character map select: doesn't even matter in gx mode */
-	vga_wseq (fb_info->regs, VGA_SEQ_MEMORY_MODE, 0x0e);	/* memory mode: chain-4, no odd/even, ext. memory */
+	vga_wseq (cinfo->regbase, VGA_SEQ_PLANE_WRITE, 0xff);	/* plane mask: nothing */
+	vga_wseq (cinfo->regbase, VGA_SEQ_CHARACTER_MAP, 0x00);	/* character map select: doesn't even matter in gx mode */
+	vga_wseq (cinfo->regbase, VGA_SEQ_MEMORY_MODE, 0x0e);	/* memory mode: chain-4, no odd/even, ext. memory */
 
 	/* controller-internal base address of video memory */
 	if (bi->init_sr07)
-		vga_wseq (fb_info->regs, CL_SEQR7, bi->sr07);
+		vga_wseq (cinfo->regbase, CL_SEQR7, bi->sr07);
 
-	/*  vga_wseq (fb_info->regs, CL_SEQR8, 0x00); *//* EEPROM control: shouldn't be necessary to write to this at all.. */
+	/*  vga_wseq (cinfo->regbase, CL_SEQR8, 0x00); *//* EEPROM control: shouldn't be necessary to write to this at all.. */
 
-	vga_wseq (fb_info->regs, CL_SEQR10, 0x00);		/* graphics cursor X position (incomplete; position gives rem. 3 bits */
-	vga_wseq (fb_info->regs, CL_SEQR11, 0x00);		/* graphics cursor Y position (..."... ) */
-	vga_wseq (fb_info->regs, CL_SEQR12, 0x00);		/* graphics cursor attributes */
-	vga_wseq (fb_info->regs, CL_SEQR13, 0x00);		/* graphics cursor pattern address */
+	vga_wseq (cinfo->regbase, CL_SEQR10, 0x00);		/* graphics cursor X position (incomplete; position gives rem. 3 bits */
+	vga_wseq (cinfo->regbase, CL_SEQR11, 0x00);		/* graphics cursor Y position (..."... ) */
+	vga_wseq (cinfo->regbase, CL_SEQR12, 0x00);		/* graphics cursor attributes */
+	vga_wseq (cinfo->regbase, CL_SEQR13, 0x00);		/* graphics cursor pattern address */
 
 	/* writing these on a P4 might give problems..  */
-	if (fb_info->btype != BT_PICASSO4) {
-		vga_wseq (fb_info->regs, CL_SEQR17, 0x00);		/* configuration readback and ext. color */
-		vga_wseq (fb_info->regs, CL_SEQR18, 0x02);		/* signature generator */
+	if (cinfo->btype != BT_PICASSO4) {
+		vga_wseq (cinfo->regbase, CL_SEQR17, 0x00);		/* configuration readback and ext. color */
+		vga_wseq (cinfo->regbase, CL_SEQR18, 0x02);		/* signature generator */
 	}
 
 	/* MCLK select etc. */
 	if (bi->init_sr1f)
-		vga_wseq (fb_info->regs, CL_SEQR1F, bi->sr1f);
+		vga_wseq (cinfo->regbase, CL_SEQR1F, bi->sr1f);
 
-	vga_wcrt (fb_info->regs, VGA_CRTC_PRESET_ROW, 0x00);	/* Screen A preset row scan: none */
-	vga_wcrt (fb_info->regs, VGA_CRTC_CURSOR_START, 0x20);	/* Text cursor start: disable text cursor */
-	vga_wcrt (fb_info->regs, VGA_CRTC_CURSOR_END, 0x00);	/* Text cursor end: - */
-	vga_wcrt (fb_info->regs, VGA_CRTC_START_HI, 0x00);	/* Screen start address high: 0 */
-	vga_wcrt (fb_info->regs, VGA_CRTC_START_LO, 0x00);	/* Screen start address low: 0 */
-	vga_wcrt (fb_info->regs, VGA_CRTC_CURSOR_HI, 0x00);	/* text cursor location high: 0 */
-	vga_wcrt (fb_info->regs, VGA_CRTC_CURSOR_LO, 0x00);	/* text cursor location low: 0 */
-
-	vga_wcrt (fb_info->regs, VGA_CRTC_UNDERLINE, 0x00);	/* Underline Row scanline: - */
-	vga_wcrt (fb_info->regs, VGA_CRTC_MODE, 0xc3);	/* mode control: timing enable, byte mode, no compat modes */
-	vga_wcrt (fb_info->regs, VGA_CRTC_LINE_COMPARE, 0x00);	/* Line Compare: not needed */
+	vga_wcrt (cinfo->regbase, VGA_CRTC_PRESET_ROW, 0x00);	/* Screen A preset row scan: none */
+	vga_wcrt (cinfo->regbase, VGA_CRTC_CURSOR_START, 0x20);	/* Text cursor start: disable text cursor */
+	vga_wcrt (cinfo->regbase, VGA_CRTC_CURSOR_END, 0x00);	/* Text cursor end: - */
+	vga_wcrt (cinfo->regbase, VGA_CRTC_START_HI, 0x00);	/* Screen start address high: 0 */
+	vga_wcrt (cinfo->regbase, VGA_CRTC_START_LO, 0x00);	/* Screen start address low: 0 */
+	vga_wcrt (cinfo->regbase, VGA_CRTC_CURSOR_HI, 0x00);	/* text cursor location high: 0 */
+	vga_wcrt (cinfo->regbase, VGA_CRTC_CURSOR_LO, 0x00);	/* text cursor location low: 0 */
+
+	vga_wcrt (cinfo->regbase, VGA_CRTC_UNDERLINE, 0x00);	/* Underline Row scanline: - */
+	vga_wcrt (cinfo->regbase, VGA_CRTC_MODE, 0xc3);	/* mode control: timing enable, byte mode, no compat modes */
+	vga_wcrt (cinfo->regbase, VGA_CRTC_LINE_COMPARE, 0x00);	/* Line Compare: not needed */
 	/* ### add 0x40 for text modes with > 30 MHz pixclock */
-	vga_wcrt (fb_info->regs, CL_CRT1B, 0x02);	/* ext. display controls: ext.adr. wrap */
+	vga_wcrt (cinfo->regbase, CL_CRT1B, 0x02);	/* ext. display controls: ext.adr. wrap */
 
-	vga_wgfx (fb_info->regs, VGA_GFX_SR_VALUE, 0x00);	/* Set/Reset registes: - */
-	vga_wgfx (fb_info->regs, VGA_GFX_SR_ENABLE, 0x00);	/* Set/Reset enable: - */
-	vga_wgfx (fb_info->regs, VGA_GFX_COMPARE_VALUE, 0x00);	/* Color Compare: - */
-	vga_wgfx (fb_info->regs, VGA_GFX_DATA_ROTATE, 0x00);	/* Data Rotate: - */
-	vga_wgfx (fb_info->regs, VGA_GFX_PLANE_READ, 0x00);	/* Read Map Select: - */
-	vga_wgfx (fb_info->regs, VGA_GFX_MODE, 0x00);	/* Mode: conf. for 16/4/2 color mode, no odd/even, read/write mode 0 */
-	vga_wgfx (fb_info->regs, VGA_GFX_MISC, 0x01);	/* Miscellaneous: memory map base address, graphics mode */
-	vga_wgfx (fb_info->regs, VGA_GFX_COMPARE_MASK, 0x0f);	/* Color Don't care: involve all planes */
-	vga_wgfx (fb_info->regs, VGA_GFX_BIT_MASK, 0xff);	/* Bit Mask: no mask at all */
-	if (fb_info->btype == BT_ALPINE)
-		vga_wgfx (fb_info->regs, CL_GRB, 0x20);	/* (5434 can't have bit 3 set for bitblt) */
+	vga_wgfx (cinfo->regbase, VGA_GFX_SR_VALUE, 0x00);	/* Set/Reset registes: - */
+	vga_wgfx (cinfo->regbase, VGA_GFX_SR_ENABLE, 0x00);	/* Set/Reset enable: - */
+	vga_wgfx (cinfo->regbase, VGA_GFX_COMPARE_VALUE, 0x00);	/* Color Compare: - */
+	vga_wgfx (cinfo->regbase, VGA_GFX_DATA_ROTATE, 0x00);	/* Data Rotate: - */
+	vga_wgfx (cinfo->regbase, VGA_GFX_PLANE_READ, 0x00);	/* Read Map Select: - */
+	vga_wgfx (cinfo->regbase, VGA_GFX_MODE, 0x00);	/* Mode: conf. for 16/4/2 color mode, no odd/even, read/write mode 0 */
+	vga_wgfx (cinfo->regbase, VGA_GFX_MISC, 0x01);	/* Miscellaneous: memory map base address, graphics mode */
+	vga_wgfx (cinfo->regbase, VGA_GFX_COMPARE_MASK, 0x0f);	/* Color Don't care: involve all planes */
+	vga_wgfx (cinfo->regbase, VGA_GFX_BIT_MASK, 0xff);	/* Bit Mask: no mask at all */
+	if (cinfo->btype == BT_ALPINE)
+		vga_wgfx (cinfo->regbase, CL_GRB, 0x20);	/* (5434 can't have bit 3 set for bitblt) */
 	else
-		vga_wgfx (fb_info->regs, CL_GRB, 0x28);	/* Graphics controller mode extensions: finer granularity, 8byte data latches */
+		vga_wgfx (cinfo->regbase, CL_GRB, 0x28);	/* Graphics controller mode extensions: finer granularity, 8byte data latches */
 
-	vga_wgfx (fb_info->regs, CL_GRC, 0xff);	/* Color Key compare: - */
-	vga_wgfx (fb_info->regs, CL_GRD, 0x00);	/* Color Key compare mask: - */
-	vga_wgfx (fb_info->regs, CL_GRE, 0x00);	/* Miscellaneous control: - */
-	/*  vga_wgfx (fb_info->regs, CL_GR10, 0x00); *//* Background color byte 1: - */
-/*  vga_wgfx (fb_info->regs, CL_GR11, 0x00); */
-
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTE0, 0x00);	/* Attribute Controller palette registers: "identity mapping" */
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTE1, 0x01);
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTE2, 0x02);
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTE3, 0x03);
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTE4, 0x04);
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTE5, 0x05);
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTE6, 0x06);
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTE7, 0x07);
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTE8, 0x08);
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTE9, 0x09);
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTEA, 0x0a);
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTEB, 0x0b);
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTEC, 0x0c);
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTED, 0x0d);
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTEE, 0x0e);
-	vga_wattr (fb_info->regs, VGA_ATC_PALETTEF, 0x0f);
-
-	vga_wattr (fb_info->regs, VGA_ATC_MODE, 0x01);	/* Attribute Controller mode: graphics mode */
-	vga_wattr (fb_info->regs, VGA_ATC_OVERSCAN, 0x00);	/* Overscan color reg.: reg. 0 */
-	vga_wattr (fb_info->regs, VGA_ATC_PLANE_ENABLE, 0x0f);	/* Color Plane enable: Enable all 4 planes */
-/* ###  vga_wattr (fb_info->regs, CL_AR33, 0x00); * Pixel Panning: - */
-	vga_wattr (fb_info->regs, VGA_ATC_COLOR_PAGE, 0x00);	/* Color Select: - */
-
-	WGen (fb_info, VGA_PEL_MSK, 0xff);	/* Pixel mask: no mask */
-
-	if (fb_info->btype != BT_ALPINE && fb_info->btype != BT_GD5480)
-		WGen (fb_info, VGA_MIS_W, 0xc3);	/* polarity (-/-), enable display mem, VGA_CRTC_START_HI i/o base = color */
-
-	vga_wgfx (fb_info->regs, CL_GR31, 0x04);	/* BLT Start/status: Blitter reset */
-	vga_wgfx (fb_info->regs, CL_GR31, 0x00);	/* - " -           : "end-of-reset" */
-
-	/* CLUT setup */
-	WClut (fb_info, 0, 0x00, 0x00, 0x00);	/* background: black */
-	WClut (fb_info, 1, 0x3f, 0x3f, 0x3f);	/* foreground: white */
-	WClut (fb_info, 2, 0x00, 0x20, 0x00);
-	WClut (fb_info, 3, 0x00, 0x20, 0x20);
-	WClut (fb_info, 4, 0x20, 0x00, 0x00);
-	WClut (fb_info, 5, 0x20, 0x00, 0x20);
-	WClut (fb_info, 6, 0x20, 0x10, 0x00);
-	WClut (fb_info, 7, 0x20, 0x20, 0x20);
-	WClut (fb_info, 8, 0x10, 0x10, 0x10);
-	WClut (fb_info, 9, 0x10, 0x10, 0x30);
-	WClut (fb_info, 10, 0x10, 0x30, 0x10);
-	WClut (fb_info, 11, 0x10, 0x30, 0x30);
-	WClut (fb_info, 12, 0x30, 0x10, 0x10);
-	WClut (fb_info, 13, 0x30, 0x10, 0x30);
-	WClut (fb_info, 14, 0x30, 0x30, 0x10);
-	WClut (fb_info, 15, 0x30, 0x30, 0x30);
-
-	/* the rest a grey ramp */
-	{
-		int i;
+	vga_wgfx (cinfo->regbase, CL_GRC, 0xff);	/* Color Key compare: - */
+	vga_wgfx (cinfo->regbase, CL_GRD, 0x00);	/* Color Key compare mask: - */
+	vga_wgfx (cinfo->regbase, CL_GRE, 0x00);	/* Miscellaneous control: - */
+	/*  vga_wgfx (cinfo->regbase, CL_GR10, 0x00); *//* Background color byte 1: - */
+/*  vga_wgfx (cinfo->regbase, CL_GR11, 0x00); */
+
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE0, 0x00);	/* Attribute Controller palette registers: "identity mapping" */
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE1, 0x01);
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE2, 0x02);
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE3, 0x03);
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE4, 0x04);
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE5, 0x05);
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE6, 0x06);
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE7, 0x07);
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE8, 0x08);
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE9, 0x09);
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTEA, 0x0a);
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTEB, 0x0b);
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTEC, 0x0c);
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTED, 0x0d);
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTEE, 0x0e);
+	vga_wattr (cinfo->regbase, VGA_ATC_PALETTEF, 0x0f);
+
+	vga_wattr (cinfo->regbase, VGA_ATC_MODE, 0x01);	/* Attribute Controller mode: graphics mode */
+	vga_wattr (cinfo->regbase, VGA_ATC_OVERSCAN, 0x00);	/* Overscan color reg.: reg. 0 */
+	vga_wattr (cinfo->regbase, VGA_ATC_PLANE_ENABLE, 0x0f);	/* Color Plane enable: Enable all 4 planes */
+/* ###  vga_wattr (cinfo->regbase, CL_AR33, 0x00); * Pixel Panning: - */
+	vga_wattr (cinfo->regbase, VGA_ATC_COLOR_PAGE, 0x00);	/* Color Select: - */
 
-		for (i = 16; i < 256; i++)
-			WClut (fb_info, i, i >> 2, i >> 2, i >> 2);
-	}
+	WGen (cinfo, VGA_PEL_MSK, 0xff);	/* Pixel mask: no mask */
 
+	if (cinfo->btype != BT_ALPINE && cinfo->btype != BT_GD5480)
+		WGen (cinfo, VGA_MIS_W, 0xc3);	/* polarity (-/-), enable display mem, VGA_CRTC_START_HI i/o base = color */
+
+	vga_wgfx (cinfo->regbase, CL_GR31, 0x04);	/* BLT Start/status: Blitter reset */
+	vga_wgfx (cinfo->regbase, CL_GR31, 0x00);	/* - " -           : "end-of-reset" */
 
 	/* misc... */
-	WHDR (fb_info, 0);	/* Hidden DAC register: - */
+	WHDR (cinfo, 0);	/* Hidden DAC register: - */
 
-	printk (KERN_INFO "clgen: This board has %ld bytes of DRAM memory\n", fb_info->size);
+	printk (KERN_DEBUG "cirrusfb: This board has %ld bytes of DRAM memory\n", cinfo->size);
 	DPRINTK ("EXIT\n");
 	return;
 }
 
-static void switch_monitor (struct clgenfb_info *fb_info, int on)
+static void switch_monitor (struct cirrusfb_info *cinfo, int on)
 {
 #ifdef CONFIG_ZORRO /* only works on Zorro boards */
 	static int IsOn = 0;	/* XXX not ok for multiple boards */
 
 	DPRINTK ("ENTER\n");
 
-	if (fb_info->btype == BT_PICASSO4)
+	if (cinfo->btype == BT_PICASSO4)
 		return;		/* nothing to switch */
-	if (fb_info->btype == BT_ALPINE)
+	if (cinfo->btype == BT_ALPINE)
 		return;		/* nothing to switch */
-	if (fb_info->btype == BT_GD5480)
+	if (cinfo->btype == BT_GD5480)
 		return;		/* nothing to switch */
-	if (fb_info->btype == BT_PICASSO) {
+	if (cinfo->btype == BT_PICASSO) {
 		if ((on && !IsOn) || (!on && IsOn))
-			WSFR (fb_info, 0xff);
+			WSFR (cinfo, 0xff);
 
 		DPRINTK ("EXIT\n");
 		return;
 	}
 	if (on) {
-		switch (fb_info->btype) {
+		switch (cinfo->btype) {
 		case BT_SD64:
-			WSFR (fb_info, fb_info->SFR | 0x21);
+			WSFR (cinfo, cinfo->SFR | 0x21);
 			break;
 		case BT_PICCOLO:
-			WSFR (fb_info, fb_info->SFR | 0x28);
+			WSFR (cinfo, cinfo->SFR | 0x28);
 			break;
 		case BT_SPECTRUM:
-			WSFR (fb_info, 0x6f);
+			WSFR (cinfo, 0x6f);
 			break;
 		default: /* do nothing */ break;
 		}
 	} else {
-		switch (fb_info->btype) {
+		switch (cinfo->btype) {
 		case BT_SD64:
-			WSFR (fb_info, fb_info->SFR & 0xde);
+			WSFR (cinfo, cinfo->SFR & 0xde);
 			break;
 		case BT_PICCOLO:
-			WSFR (fb_info, fb_info->SFR & 0xd7);
+			WSFR (cinfo, cinfo->SFR & 0xd7);
 			break;
 		case BT_SPECTRUM:
-			WSFR (fb_info, 0x4f);
+			WSFR (cinfo, 0x4f);
 			break;
 		default: /* do nothing */ break;
 		}
@@ -2167,238 +1941,130 @@
 #endif /* CONFIG_ZORRO */
 }
 
-static void clgen_set_disp (const void *par, struct display *disp,
-			    struct fb_info_gen *info)
-{
-	struct clgenfb_par *_par = (struct clgenfb_par *) par;
-	struct clgenfb_info *fb_info = (struct clgenfb_info *) info;
-	int accel_text;
-
-	DPRINTK ("ENTER\n");
-
-	assert (_par != NULL);
-	assert (fb_info != NULL);
 
-	accel_text = _par->var.accel_flags & FB_ACCELF_TEXT;
-
-	printk ("Cirrus Logic video mode: ");
-	info->info.screen_base = (char *) fb_info->fbmem;
-	switch (_par->var.bits_per_pixel) {
-#ifdef FBCON_HAS_MFB
-	case 1:
-		printk ("monochrome\n");
-		if (fb_info->btype == BT_GD5480)
-			info->info.screen_base = (char *) fb_info->fbmem;
-		disp->dispsw = &fbcon_mfb;
-		break;
-#endif
-#ifdef FBCON_HAS_CFB8
-	case 8:
-		printk ("8 bit color depth\n");
-		if (fb_info->btype == BT_GD5480)
-			info->info.screen_base = (char *) fb_info->fbmem;
-		if (accel_text)
-			disp->dispsw = &fbcon_clgen_8;
-		else
-			disp->dispsw = &fbcon_cfb8;
-		break;
-#endif
-#ifdef FBCON_HAS_CFB16
-	case 16:
-		printk ("16 bit color depth\n");
-		if (accel_text)
-			disp->dispsw = &fbcon_clgen_16;
-		else
-			disp->dispsw = &fbcon_cfb16;
-		if (fb_info->btype == BT_GD5480)
-			info->info.screen_base = (char *) fb_info->fbmem + 1 * MB_;
-		disp->dispsw_data = fb_info->fbcon_cmap.cfb16;
-		break;
-#endif
-#ifdef FBCON_HAS_CFB24
-	case 24:
-		printk ("24 bit color depth\n");
-		disp->dispsw = &fbcon_cfb24;
-		if (fb_info->btype == BT_GD5480)
-			info->info.screen_base = (char *) fb_info->fbmem + 2 * MB_;
-		disp->dispsw_data = fb_info->fbcon_cmap.cfb24;
-		break;
-#endif
-#ifdef FBCON_HAS_CFB32
-	case 32:
-		printk ("32 bit color depth\n");
-		if (accel_text)
-			disp->dispsw = &fbcon_clgen_32;
-		else
-			disp->dispsw = &fbcon_cfb32;
-		if (fb_info->btype == BT_GD5480)
-			info->info.screen_base = (char *) fb_info->fbmem + 2 * MB_;
-		disp->dispsw_data = fb_info->fbcon_cmap.cfb32;
-		break;
-#endif
-
-	default:
-		printk ("unsupported color depth\n");
-		disp->dispsw = &fbcon_dummy;
-		disp->dispsw_data = NULL;
-		break;
+/******************************************/
+/* Linux 2.6-style  accelerated functions */
+/******************************************/
+
+static void cirrusfb_prim_fillrect(struct cirrusfb_info *cinfo, 
+				   const struct fb_fillrect *region)
+{
+	int m; /* bytes per pixel */
+	if(cinfo->info->var.bits_per_pixel == 1) {
+		cirrusfb_RectFill(cinfo->regbase, cinfo->info->var.bits_per_pixel, 
+				  region->dx / 8, region->dy, 
+				  region->width / 8, region->height, 
+				  region->color, 
+				  cinfo->currentmode.line_length);
+	} else {
+		m = ( cinfo->info->var.bits_per_pixel + 7 ) / 8;
+		cirrusfb_RectFill(cinfo->regbase, cinfo->info->var.bits_per_pixel, 
+				  region->dx * m, region->dy, 
+				  region->width * m, region->height, 
+				  region->color, 
+				  cinfo->currentmode.line_length);
 	}
-
-	DPRINTK ("EXIT\n");
-}
-
-#ifdef FBCON_HAS_CFB8
-static void fbcon_clgen8_bmove (struct display *p, int sy, int sx,
-				int dy, int dx, int height, int width)
-{
-	struct clgenfb_info *fb_info = (struct clgenfb_info *) p->fb_info;
-
-	DPRINTK ("ENTER\n");
-
-	sx *= fontwidth (p);
-	sy *= fontheight (p);
-	dx *= fontwidth (p);
-	dy *= fontheight (p);
-	width *= fontwidth (p);
-	height *= fontheight (p);
-
-	clgen_BitBLT (fb_info->regs, (unsigned short) sx, (unsigned short) sy,
-		      (unsigned short) dx, (unsigned short) dy,
-		      (unsigned short) width, (unsigned short) height,
-		      fb_info->currentmode.line_length);
-
-	DPRINTK ("EXIT\n");
-}
-
-static void fbcon_clgen8_clear (struct vc_data *conp, struct display *p,
-				int sy, int sx, int height, int width)
-{
-	struct clgenfb_info *fb_info = (struct clgenfb_info *) p->fb_info;
-	unsigned short col;
-
-	DPRINTK ("ENTER\n");
-
-	sx *= fontwidth (p);
-	sy *= fontheight (p);
-	width *= fontwidth (p);
-	height *= fontheight (p);
-
-	col = attr_bgcol_ec (p, conp);
-	col &= 0xff;
-
-	clgen_RectFill (fb_info, (unsigned short) sx, (unsigned short) sy,
-			(unsigned short) width, (unsigned short) height,
-			col, fb_info->currentmode.line_length);
-
-	DPRINTK ("EXIT\n");
-}
-
-#endif
-
-#ifdef FBCON_HAS_CFB16
-static void fbcon_clgen16_bmove (struct display *p, int sy, int sx,
-				 int dy, int dx, int height, int width)
-{
-	struct clgenfb_info *fb_info = (struct clgenfb_info *) p->fb_info;
-
-	DPRINTK ("ENTER\n");
-
-	sx *= fontwidth (p) * 2;	/* 2 bytes/pixel */
-	sy *= fontheight (p);
-	dx *= fontwidth (p) * 2;	/* 2 bytes/pixel */
-	dy *= fontheight (p);
-	width *= fontwidth (p) * 2;	/* 2 bytes/pixel */
-	height *= fontheight (p);
-
-	clgen_BitBLT (fb_info->regs, (unsigned short) sx, (unsigned short) sy,
-		      (unsigned short) dx, (unsigned short) dy,
-		      (unsigned short) width, (unsigned short) height,
-		      fb_info->currentmode.line_length);
-
-	DPRINTK ("EXIT\n");
+	return;
 }
 
-static void fbcon_clgen16_clear (struct vc_data *conp, struct display *p,
-				 int sy, int sx, int height, int width)
+void cirrusfb_fillrect (struct fb_info *info, const struct fb_fillrect *region)
 {
-	struct clgenfb_info *fb_info = (struct clgenfb_info *) p->fb_info;
-	unsigned short col;
+	struct cirrusfb_info *cinfo = info->par;
+	struct fb_fillrect modded;
+	int vxres, vyres;
+  
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
+		cfb_fillrect(info, region);
+		return;
+	}
 
-	DPRINTK ("ENTER\n");
+	vxres = info->var.xres_virtual;
+	vyres = info->var.yres_virtual;
 
-	sx *= fontwidth (p) * 2;	/* 2 bytes/pixel */
-	sy *= fontheight (p);
-	width *= fontwidth (p) * 2;	/* 2 bytes/pixel? */
-	height *= fontheight (p);
-
-	col = attr_bgcol_ec (p, conp);
-	col &= 0xff;
-
-	clgen_RectFill (fb_info, (unsigned short) sx, (unsigned short) sy,
-			(unsigned short) width, (unsigned short) height,
-			col, fb_info->currentmode.line_length);
+	memcpy(&modded, region, sizeof(struct fb_fillrect));
 
-	DPRINTK ("EXIT\n");
+	if(!modded.width || !modded.height ||
+	   modded.dx >= vxres || modded.dy >= vyres)
+		return;
+  
+	if(modded.dx + modded.width  > vxres) modded.width  = vxres - modded.dx;
+	if(modded.dy + modded.height > vyres) modded.height = vyres - modded.dy;
+
+	cirrusfb_prim_fillrect(cinfo, &modded);
+}
+
+static void cirrusfb_prim_copyarea(struct cirrusfb_info *cinfo, 
+				   const struct fb_copyarea *area)
+{
+	int m; /* bytes per pixel */
+	if(cinfo->info->var.bits_per_pixel == 1) {
+		cirrusfb_BitBLT(cinfo->regbase, cinfo->info->var.bits_per_pixel,
+				area->sx / 8, area->sy,
+				area->dx / 8, area->dy,
+				area->width / 8, area->height,
+				cinfo->currentmode.line_length);
+	} else {
+		m = ( cinfo->info->var.bits_per_pixel + 7 ) / 8;
+		cirrusfb_BitBLT(cinfo->regbase, cinfo->info->var.bits_per_pixel,
+				area->sx * m, area->sy,
+				area->dx * m, area->dy,
+				area->width * m, area->height,
+				cinfo->currentmode.line_length);
+	}
+	return;
 }
 
-#endif
 
-#ifdef FBCON_HAS_CFB32
-static void fbcon_clgen32_bmove (struct display *p, int sy, int sx,
-				 int dy, int dx, int height, int width)
+void cirrusfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
-	struct clgenfb_info *fb_info = (struct clgenfb_info *) p->fb_info;
-
-	DPRINTK ("ENTER\n");
+	struct cirrusfb_info *cinfo = info->par;
+	struct fb_copyarea modded;
+	u32 vxres, vyres;
+	modded.sx = area->sx;
+	modded.sy = area->sy;
+	modded.dx = area->dx;
+	modded.dy = area->dy;
+	modded.width  = area->width;
+	modded.height = area->height;
+  
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
+		cfb_copyarea(info, area);
+		return;
+	}
 
-	sx *= fontwidth (p) * 4;	/* 4 bytes/pixel */
-	sy *= fontheight (p);
-	dx *= fontwidth (p) * 4;	/* 4 bytes/pixel */
-	dy *= fontheight (p);
-	width *= fontwidth (p) * 4;	/* 4 bytes/pixel */
-	height *= fontheight (p);
-
-	clgen_BitBLT (fb_info->regs, (unsigned short) sx, (unsigned short) sy,
-		      (unsigned short) dx, (unsigned short) dy,
-		      (unsigned short) width, (unsigned short) height,
-		      fb_info->currentmode.line_length);
+	vxres = info->var.xres_virtual;
+	vyres = info->var.yres_virtual;
 
-	DPRINTK ("EXIT\n");
+	if(!modded.width || !modded.height ||
+	   modded.sx >= vxres || modded.sy >= vyres ||
+	   modded.dx >= vxres || modded.dy >= vyres)
+		return;
+  
+	if(modded.sx + modded.width > vxres)  modded.width = vxres - modded.sx;
+	if(modded.dx + modded.width > vxres)  modded.width = vxres - modded.dx;
+	if(modded.sy + modded.height > vyres) modded.height = vyres - modded.sy;
+	if(modded.dy + modded.height > vyres) modded.height = vyres - modded.dy;
+  
+	cirrusfb_prim_copyarea(cinfo, &modded);
 }
 
-static void fbcon_clgen32_clear (struct vc_data *conp, struct display *p,
-				 int sy, int sx, int height, int width)
+void cirrusfb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
-	struct clgenfb_info *fb_info = (struct clgenfb_info *) p->fb_info;
-
-	unsigned short col;
-
-	DPRINTK ("ENTER\n");
+	struct cirrusfb_info *cinfo = info->par;
 
-	sx *= fontwidth (p) * 4;	/* 4 bytes/pixel */
-	sy *= fontheight (p);
-	width *= fontwidth (p) * 4;	/* 4 bytes/pixel? */
-	height *= fontheight (p);
-
-	col = attr_bgcol_ec (p, conp);
-	col &= 0xff;
-
-	clgen_RectFill (fb_info, (unsigned short) sx, (unsigned short) sy,
-			(unsigned short) width, (unsigned short) height,
-			col, fb_info->currentmode.line_length);
-
-	DPRINTK ("EXIT\n");
+        cirrusfb_WaitBLT(cinfo->regbase);
+	cfb_imageblit(info, image);
 }
 
-#endif				/* FBCON_HAS_CFB32 */
-
-
-
 
 #ifdef CONFIG_PPC_PREP
 #define PREP_VIDEO_BASE ((volatile unsigned long) 0xC0000000)
 #define PREP_IO_BASE    ((volatile unsigned char *) 0x80000000)
-static void __init get_prep_addrs (unsigned long *display, unsigned long *registers)
+static void get_prep_addrs (unsigned long *display, unsigned long *registers)
 {
 	DPRINTK ("ENTER\n");
 
@@ -2411,8 +2077,6 @@
 #endif				/* CONFIG_PPC_PREP */
 
 
-
-
 #ifdef CONFIG_PCI
 static int release_io_ports = 0;
 
@@ -2420,7 +2084,7 @@
  * based on the DRAM bandwidth bit and DRAM bank switching bit.  This
  * works with 1MB, 2MB and 4MB configurations (which the Motorola boards
  * seem to have. */
-static unsigned int __init clgen_get_memsize (caddr_t regbase)
+static unsigned int cirrusfb_get_memsize (caddr_t regbase)
 {
 	unsigned long mem;
 	unsigned char SRF;
@@ -2443,40 +2107,14 @@
 		mem *= 2;
 	}
 	/* TODO: Handling of GD5446/5480 (see XF86 sources ...) */
-	return mem;
 
 	DPRINTK ("EXIT\n");
+	return mem;
 }
 
 
 
-static struct pci_dev * __init clgen_pci_dev_get (clgen_board_t *btype)
-{
-	struct pci_dev *pdev;
-	int i;
-
-	DPRINTK ("ENTER\n");
-
-	for (i = 0; i < ARRAY_SIZE(clgen_pci_probe_list); i++) {
-		pdev = NULL;
-		while ((pdev = pci_find_device (PCI_VENDOR_ID_CIRRUS,
-				clgen_pci_probe_list[i].device, pdev)) != NULL) {
-			if (pci_enable_device(pdev) == 0) {
-				*btype = clgen_pci_probe_list[i].btype;
-				DPRINTK ("EXIT, returning pdev=%p\n", pdev);
-				return pdev;
-			}
-		}
-	}
-
-	DPRINTK ("EXIT, returning NULL\n");
-	return NULL;
-}
-
-
-
-
-static void __init get_pci_addrs (const struct pci_dev *pdev,
+static void get_pci_addrs (const struct pci_dev *pdev,
 			   unsigned long *display, unsigned long *registers)
 {
 	assert (pdev != NULL);
@@ -2504,10 +2142,10 @@
 }
 
 
-static void __exit clgen_pci_unmap (struct clgenfb_info *info)
+static void __devexit cirrusfb_pci_unmap (struct cirrusfb_info *cinfo)
 {
-	iounmap (info->fbmem);
-	release_mem_region(info->fbmem_phys, info->size);
+	iounmap (cinfo->fbmem);
+	release_mem_region(cinfo->fbmem_phys, cinfo->size);
 
 #if 0 /* if system didn't claim this region, we would... */
 	release_mem_region(0xA0000, 65535);
@@ -2518,79 +2156,78 @@
 }
 
 
-static int __init clgen_pci_setup (struct clgenfb_info *info,
-				   clgen_board_t *btype)
+static struct cirrusfb_info *cirrusfb_pci_setup (struct pci_dev *pdev,
+				   		 const struct pci_device_id *ent)
 {
-	struct pci_dev *pdev;
+	struct cirrusfb_info *cinfo;
+	struct fb_info *info;
+	cirrusfb_board_t btype;
 	unsigned long board_addr, board_size;
 
-	DPRINTK ("ENTER\n");
+	if (pci_enable_device(pdev) != 0) {
+		printk(KERN_ERR "cirrusfb: Cannot enable PCI device\n");
+		return NULL;
+	}
+	
+	info = framebuffer_alloc(sizeof(struct cirrusfb_info), &pdev->dev);
+	if (!info) {
+		printk (KERN_ERR "cirrusfb: could not allocate memory\n");
+		return NULL;
+	}
+	
+	cinfo = info->par;
+	cinfo->info = info;
+	cinfo->pdev = pdev;
+	cinfo->btype = btype = (cirrusfb_board_t) ent->driver_data;
 
-	pdev = clgen_pci_dev_get (btype);
-	if (!pdev) {
-		printk (KERN_INFO "cirrusfb: couldn't find Cirrus Logic PCI device\n");
-		DPRINTK ("EXIT, returning 1\n");
-		return 1;
-	}
 	DPRINTK (" Found PCI device, base address 0 is 0x%lx, btype set to %d\n",
-		 pdev->resource[0].start, *btype);
+		pdev->resource[0].start, btype);
 	DPRINTK (" base address 1 is 0x%lx\n", pdev->resource[1].start);
 
-	info->pdev = pdev;
-
 	if(isPReP) {
-		/* Xbh does this, though 0 seems to be the init value */
-		pcibios_write_config_dword (0, pdev->devfn, PCI_BASE_ADDRESS_0,
-			0x00000000);
-
+		pci_write_config_dword (pdev, PCI_BASE_ADDRESS_0, 0x00000000);
 #ifdef CONFIG_PPC_PREP
-		get_prep_addrs (&board_addr, &info->fbregs_phys);
+		get_prep_addrs (&board_addr, &cinfo->fbregs_phys);
 #endif
+		/* PReP dies if we ioremap the IO registers, but it works w/out... */
+		cinfo->regbase = (char *) cinfo->fbregs_phys;
 	} else {
 		DPRINTK ("Attempt to get PCI info for Cirrus Graphics Card\n");
-		get_pci_addrs (pdev, &board_addr, &info->fbregs_phys);
+		get_pci_addrs (pdev, &board_addr, &cinfo->fbregs_phys);
+		cinfo->regbase = 0;		/* FIXME: this forces VGA.  alternatives? */
 	}
 
-	DPRINTK ("Board address: 0x%lx, register address: 0x%lx\n", board_addr, info->fbregs_phys);
-
-	if(isPReP) {
-		/* PReP dies if we ioremap the IO registers, but it works w/out... */
-		info->regs = (char *) info->fbregs_phys;
-	} else
-		info->regs = 0;		/* FIXME: this forces VGA.  alternatives? */
+	DPRINTK ("Board address: 0x%lx, register address: 0x%lx\n", board_addr, cinfo->fbregs_phys);
 
-	if (*btype == BT_GD5480) {
-		board_size = 32 * MB_;
-	} else {
-		board_size = clgen_get_memsize (info->regs);
-	}
+	board_size = (btype == BT_GD5480) ? 
+		32 * MB_ : cirrusfb_get_memsize (cinfo->regbase);
 
-	if (!request_mem_region(board_addr, board_size, "clgenfb")) {
-		printk(KERN_ERR "clgen: cannot reserve region 0x%lx, abort\n",
+	if (!request_mem_region(board_addr, board_size, "cirrusfb")) {
+		printk(KERN_ERR "cirrusfb: cannot reserve region 0x%lx, abort\n",
 		       board_addr);
-		return -1;
+		framebuffer_release (info);
+		return NULL;
 	}
 #if 0 /* if the system didn't claim this region, we would... */
-	if (!request_mem_region(0xA0000, 65535, "clgenfb")) {
-		printk(KERN_ERR "clgen: cannot reserve region 0x%lx, abort\n",
+	if (!request_mem_region(0xA0000, 65535, "cirrusfb")) {
+		printk(KERN_ERR "cirrusfb: cannot reserve region 0x%lx, abort\n",
 		       0xA0000L);
 		release_mem_region(board_addr, board_size);
-		return -1;
+		framebuffer_release (info);
+		return NULL;
 	}
 #endif
-	if (request_region(0x3C0, 32, "clgenfb"))
+	if (request_region(0x3C0, 32, "cirrusfb"))
 		release_io_ports = 1;
 
-	info->fbmem = ioremap (board_addr, board_size);
-	info->fbmem_phys = board_addr;
-	info->size = board_size;
-
-	printk (" RAM (%lu kB) at 0x%lx, ", info->size / KB_, board_addr);
+	cinfo->fbmem = ioremap (board_addr, board_size);
+	cinfo->fbmem_phys = board_addr;
+	cinfo->size = board_size;
 
+	printk (" RAM (%lu kB) at 0xx%lx, ", cinfo->size / KB_, board_addr);
 	printk ("Cirrus Logic chipset on PCI bus\n");
-
-	DPRINTK ("EXIT, returning 0\n");
-	return 0;
+	
+	return cinfo;
 }
 #endif				/* CONFIG_PCI */
 
@@ -2598,9 +2235,9 @@
 
 
 #ifdef CONFIG_ZORRO
-static int __init clgen_zorro_find (struct zorro_dev **z_o,
+static int cirrusfb_zorro_find (struct zorro_dev **z_o,
 				    struct zorro_dev **z2_o,
-				    clgen_board_t *btype, unsigned long *size)
+				    cirrusfb_board_t *btype, unsigned long *size)
 {
 	struct zorro_dev *z = NULL;
 	int i;
@@ -2608,101 +2245,110 @@
 	assert (z_o != NULL);
 	assert (btype != NULL);
 
-	for (i = 0; i < ARRAY_SIZE(clgen_zorro_probe_list); i++)
-		if ((z = zorro_find_device(clgen_zorro_probe_list[i].id, NULL)))
+	for (i = 0; i < ARRAY_SIZE(cirrusfb_zorro_probe_list); i++)
+		if ((z = zorro_find_device(cirrusfb_zorro_probe_list[i].id, NULL)))
 			break;
 
 	if (z) {
 		*z_o = z;
-		if (clgen_zorro_probe_list[i].id2)
-			*z2_o = zorro_find_device(clgen_zorro_probe_list[i].id2, NULL);
+		if (cirrusfb_zorro_probe_list[i].id2)
+			*z2_o = zorro_find_device(cirrusfb_zorro_probe_list[i].id2, NULL);
 		else
 			*z2_o = NULL;
 
-		*btype = clgen_zorro_probe_list[i].btype;
-		*size = clgen_zorro_probe_list[i].size;
+		*btype = cirrusfb_zorro_probe_list[i].btype;
+		*size = cirrusfb_zorro_probe_list[i].size;
 
-		printk (KERN_INFO "clgen: %s board detected; ",
-			clgen_board_info[*btype].name);
+		printk (KERN_INFO "cirrusfb: %s board detected; ",
+			cirrusfb_board_info[*btype].name);
 
 		return 0;
 	}
 
-	printk (KERN_NOTICE "clgen: no supported board found.\n");
+	printk (KERN_NOTICE "cirrusfb: no supported board found.\n");
 	return -1;
 }
 
 
-static void __exit clgen_zorro_unmap (struct clgenfb_info *info)
+static void __devexit cirrusfb_zorro_unmap (struct cirrusfb_info *cinfo)
 {
-	release_mem_region(info->board_addr, info->board_size);
+	release_mem_region(cinfo->board_addr, cinfo->board_size);
 
-	if (info->btype == BT_PICASSO4) {
-		iounmap ((void *)info->board_addr);
-		iounmap ((void *)info->fbmem_phys);
+	if (cinfo->btype == BT_PICASSO4) {
+		iounmap ((void *)cinfo->board_addr);
+		iounmap ((void *)cinfo->fbmem_phys);
 	} else {
-		if (info->board_addr > 0x01000000)
-			iounmap ((void *)info->board_addr);
+		if (cinfo->board_addr > 0x01000000)
+			iounmap ((void *)cinfo->board_addr);
 	}
 }
 
 
-static int __init clgen_zorro_setup (struct clgenfb_info *info,
-				     clgen_board_t *btype)
+static struct cirrusfb_info *cirrusfb_zorro_setup ()
 {
+	struct cirrusfb_info *cinfo;
+	struct fb_info *info;
+	cirrusfb_board_t btype;
 	struct zorro_dev *z = NULL, *z2 = NULL;
 	unsigned long board_addr, board_size, size;
 
-	assert (info != NULL);
-	assert (btype != NULL);
-
-	if (clgen_zorro_find (&z, &z2, btype, &size))
-		return -1;
-
+	if (cirrusfb_zorro_find (&z, &z2, &btype, &size))
+		return NULL;
+	
+	info = framebuffer_alloc(sizeof(struct cirrusfb_info), &z->dev);
+	if (!info) {
+		printk (KERN_ERR "cirrusfb: could not allocate memory\n");
+		return NULL;
+	}
+	
+	cinfo = info->par;
+	cinfo->info = info;
+	cinfo->btype = btype;
+	
 	assert (z > 0);
 	assert (z2 >= 0);
-	assert (*btype != BT_NONE);
+	assert (btype != BT_NONE);
 
-	info->board_addr = board_addr = z->resource.start;
-	info->board_size = board_size = z->resource.end-z->resource.start+1;
-	info->size = size;
+	cinfo->board_addr = board_addr = z->resource.start;
+	cinfo->board_size = board_size = z->resource.end-z->resource.start+1;
+	cinfo->size = size;
 
-	if (!request_mem_region(board_addr, board_size, "clgenfb")) {
-		printk(KERN_ERR "clgen: cannot reserve region 0x%lx, abort\n",
+	if (!request_mem_region(board_addr, board_size, "cirrusfb")) {
+		printk(KERN_ERR "cirrusfb: cannot reserve region 0x%lx, abort\n",
 		       board_addr);
 		return -1;
 	}
 
 	printk (" RAM (%lu MB) at $%lx, ", board_size / MB_, board_addr);
 
-	if (*btype == BT_PICASSO4) {
+	if (btype == BT_PICASSO4) {
 		printk (" REG at $%lx\n", board_addr + 0x600000);
 
 		/* To be precise, for the P4 this is not the */
 		/* begin of the board, but the begin of RAM. */
 		/* for P4, map in its address space in 2 chunks (### TEST! ) */
 		/* (note the ugly hardcoded 16M number) */
-		info->regs = ioremap (board_addr, 16777216);
-		DPRINTK ("clgen: Virtual address for board set to: $%p\n", info->regs);
-		info->regs += 0x600000;
-		info->fbregs_phys = board_addr + 0x600000;
+		cinfo->regbase = ioremap (board_addr, 16777216);
+		DPRINTK ("cirrusfb: Virtual address for board set to: $%p\n", cinfo->regbase);
+		cinfo->regbase += 0x600000;
+		cinfo->fbregs_phys = board_addr + 0x600000;
 
-		info->fbmem_phys = board_addr + 16777216;
-		info->fbmem = ioremap (info->fbmem_phys, 16777216);
+		cinfo->fbmem_phys = board_addr + 16777216;
+		cinfo->fbmem = ioremap (info->fbmem_phys, 16777216);
 	} else {
 		printk (" REG at $%lx\n", (unsigned long) z2->resource.start);
 
-		info->fbmem_phys = board_addr;
+		cinfo->fbmem_phys = board_addr;
 		if (board_addr > 0x01000000)
-			info->fbmem = ioremap (board_addr, board_size);
+			cinfo->fbmem = ioremap (board_addr, board_size);
 		else
-			info->fbmem = (caddr_t) ZTWO_VADDR (board_addr);
+			cinfo->fbmem = (caddr_t) ZTWO_VADDR (board_addr);
 
 		/* set address for REG area of board */
-		info->regs = (caddr_t) ZTWO_VADDR (z2->resource.start);
-		info->fbregs_phys = z2->resource.start;
+		cinfo->regbase = (caddr_t) ZTWO_VADDR (z2->resource.start);
+		cinfo->fbregs_phys = z2->resource.start;
 
-		DPRINTK ("clgen: Virtual address for board set to: $%p\n", info->regs);
+		DPRINTK ("cirrusfb: Virtual address for board set to: $%p\n", cinfo->regbase);
 	}
 
 	printk (KERN_INFO "Cirrus Logic chipset on Zorro bus\n");
@@ -2711,148 +2357,177 @@
 }
 #endif /* CONFIG_ZORRO */
 
-
-
-/********************************************************************/
-/* clgenfb_init() - master initialization function                  */
-/********************************************************************/
-int __init clgenfb_init(void)
+static int cirrusfb_set_fbinfo(struct cirrusfb_info *cinfo)
 {
-	int err, j, k;
+	struct fb_info *info = cinfo->info;
+	struct fb_var_screeninfo *var = &info->var;
 
-	clgen_board_t btype = BT_NONE;
-	struct clgenfb_info *fb_info = NULL;
+	info->currcon = -1;
+	info->par = cinfo;
+	info->pseudo_palette = cinfo->pseudo_palette;
+	info->flags = FBINFO_DEFAULT
+		    | FBINFO_HWACCEL_XPAN
+		    | FBINFO_HWACCEL_YPAN
+		    | FBINFO_HWACCEL_FILLRECT
+		    | FBINFO_HWACCEL_COPYAREA;
+	if (noaccel)
+		info->flags |= FBINFO_HWACCEL_DISABLED;
+	info->fbops = &cirrusfb_ops;
+	info->screen_base = cinfo->fbmem;
+	if (cinfo->btype == BT_GD5480) {
+		if (var->bits_per_pixel == 16) 
+			info->screen_base += 1 * MB_;
+		if (var->bits_per_pixel == 24 || var->bits_per_pixel == 32)
+			info->screen_base += 2 * MB_;
+	}	
+	
+	/* Fill fix common fields */
+	strlcpy(info->fix.id, cirrusfb_board_info[cinfo->btype].name,
+		sizeof(info->fix.id));
 
-	DPRINTK ("ENTER\n");
+	/* monochrome: only 1 memory plane */
+	/* 8 bit and above: Use whole memory area */
+	info->fix.smem_start = cinfo->fbmem_phys;
+	info->fix.smem_len   = (var->bits_per_pixel == 1) ? cinfo->size / 4 : cinfo->size;
+	info->fix.type       = cinfo->currentmode.type;
+	info->fix.type_aux   = 0;
+	info->fix.visual     = cinfo->currentmode.visual;
+	info->fix.xpanstep   = 1;
+	info->fix.ypanstep   = 1;
+	info->fix.ywrapstep  = 0;
+	info->fix.line_length = cinfo->currentmode.line_length;
 
-	printk (KERN_INFO "clgen: Driver for Cirrus Logic based graphic boards, v" CLGEN_VERSION "\n");
+	/* FIXME: map region at 0xB8000 if available, fill in here */
+	info->fix.mmio_start = cinfo->fbregs_phys;
+	info->fix.mmio_len   = 0;
+	info->fix.accel = FB_ACCEL_NONE;
 
-	fb_info = &boards[0];	/* FIXME support multiple boards ... */
+	fb_alloc_cmap(&info->cmap, 256, 0);
 
-#ifdef CONFIG_PCI
-	if (clgen_pci_setup (fb_info, &btype)) { /* Also does OF setup */
-		DPRINTK ("EXIT, returning -ENXIO\n");
-		return -ENXIO;
-	}
+	return 0;
+}
 
+#if defined(CONFIG_PCI)
+#define cirrusfb_unmap cirrusfb_pci_unmap
+#define cirrusfb_bus_setup cirrusfb_pci_setup
 #elif defined(CONFIG_ZORRO)
-	/* FIXME: CONFIG_PCI and CONFIG_ZORRO may both be defined */
-	if (clgen_zorro_setup (fb_info, &btype)) {
-		DPRINTK ("EXIT, returning -ENXIO\n");
-		return -ENXIO;
-	}
+#define cirrusfb_unmap cirrusfb_zorro_unmap
+#define cirrusfb_bus_setup cirrusfb_zorro_setup
+#endif
 
-#else
-#error This driver requires Zorro or PCI bus.
-#endif				/* !CONFIG_PCI, !CONFIG_ZORRO */
 
-	/* sanity checks */
-	assert (btype != BT_NONE);
-	assert (btype == clgen_board_info[btype].btype);
+static int cirrusfb_pci_register (struct pci_dev *pdev,
+				  const struct pci_device_id *ent)
+{
+	struct fb_info *info;
+	struct cirrusfb_info *cinfo = NULL;
+	int err;
+	cirrusfb_board_t btype;
 
-	fb_info->btype = btype;
+	DPRINTK ("ENTER\n");
 
-	DPRINTK ("clgen: (RAM start set to: 0x%p)\n", fb_info->fbmem);
+	printk (KERN_INFO "cirrusfb: Driver for Cirrus Logic based graphic boards, v" CIRRUSFB_VERSION "\n");
 
-	if (noaccel)
-	{
-		printk("clgen: disabling text acceleration support\n");
-#ifdef FBCON_HAS_CFB8
-		fbcon_clgen_8.bmove = fbcon_cfb8_bmove;
-		fbcon_clgen_8.clear = fbcon_cfb8_clear;
-#endif
-#ifdef FBCON_HAS_CFB16
-		fbcon_clgen_16.bmove = fbcon_cfb16_bmove;
-		fbcon_clgen_16.clear = fbcon_cfb16_clear;
-#endif
-#ifdef FBCON_HAS_CFB32
-		fbcon_clgen_32.bmove = fbcon_cfb32_bmove;
-		fbcon_clgen_32.clear = fbcon_cfb32_clear;
-#endif
-	}
+	cinfo = cirrusfb_bus_setup(pdev, ent);
+	
+	if (!cinfo) 
+		return -ENODEV;
 
-	init_vgachip (fb_info);
-
-	/* set up a few more things, register framebuffer driver etc */
-	fb_info->gen.parsize = sizeof (struct clgenfb_par);
-	fb_info->gen.fbhw = &clgen_hwswitch;
-
-	strlcpy (fb_info->gen.info.modename, clgen_board_info[btype].name,
-		 sizeof (fb_info->gen.info.modename));
-
-	fb_info->gen.info.fbops = &clgenfb_ops;
-	fb_info->gen.info.disp = &disp;
-	fb_info->gen.info.currcon = -1;
-	fb_info->gen.info.changevar = NULL;
-	fb_info->gen.info.switch_con = &fbgen_switch;
-	fb_info->gen.info.updatevar = &fbgen_update_var;
-	fb_info->gen.info.flags = FBINFO_FLAG_DEFAULT;
-
-	for (j = 0; j < 256; j++) {
-		if (j < 16) {
-			k = color_table[j];
-			fb_info->palette[j].red = default_red[k];
-			fb_info->palette[j].green = default_grn[k];
-			fb_info->palette[j].blue = default_blu[k];
-		} else {
-			fb_info->palette[j].red =
-			fb_info->palette[j].green =
-			fb_info->palette[j].blue = j;
-		}
-	}
+	info = cinfo->info;
+	btype = cinfo->btype;
+
+	/* sanity checks */
+	assert (btype != BT_NONE);
+	assert (btype == cirrusfb_board_info[btype].btype);
 
-	/* now that we know the board has been registered n' stuff, we */
-	/* can finally initialize it to a default mode */
-	clgenfb_default = clgenfb_predefined[clgen_def_mode].var;
-	clgenfb_default.activate = FB_ACTIVATE_NOW;
-	clgenfb_default.yres_virtual = 480 * 3;		/* for fast scrolling (YPAN-Mode) */
-	err = fbgen_do_set_var (&clgenfb_default, 1, &fb_info->gen);
+	DPRINTK ("cirrusfb: (RAM start set to: 0x%p)\n", cinfo->fbmem);
 
-	if (err) {
-		DPRINTK ("EXIT, returning -EINVAL\n");
+	/* Make pretend we've set the var so our structures are in a "good" */
+	/* state, even though we haven't written the mode to the hw yet...  */
+	info->var = cirrusfb_predefined[cirrusfb_def_mode].var;
+	info->var.activate = FB_ACTIVATE_NOW;
+	err = cirrusfb_decode_var(&info->var, &cinfo->currentmode, info);
+	if(err) {
+		/* should never happen */ 
+		DPRINTK("choking on default var... umm, no good.\n");
+		cirrusfb_unmap (cinfo);
+		framebuffer_release (info);
 		return -EINVAL;
 	}
 
-	disp.var = clgenfb_default;
-	fbgen_set_disp (-1, &fb_info->gen);
-	do_install_cmap (0, &fb_info->gen.info);
-
-	err = register_framebuffer (&fb_info->gen.info);
-	if (err) {
-		printk (KERN_ERR "clgen: ERROR - could not register fb device; err = %d!\n", err);
-		DPRINTK ("EXIT, returning -EINVAL\n");
+	/* set all the vital stuff */
+	cirrusfb_set_fbinfo(cinfo);
+
+	pci_set_drvdata(pdev, info);
+
+	if ((err = register_framebuffer (info)) < 0) {
+		printk (KERN_ERR "cirrusfb: could not register fb device; err = %d!\n", err);
+		fb_dealloc_cmap(&info->cmap);
+		cirrusfb_unmap (cinfo);
+		framebuffer_release (info);
 		return -EINVAL;
 	}
+
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
 }
 
 
-
-    /*
-     *  Cleanup (only needed for module)
-     */
-static void __exit clgenfb_cleanup (struct clgenfb_info *info)
+static void __devexit cirrusfb_cleanup (struct fb_info *info)
 {
+	struct cirrusfb_info *cinfo = info->par;
 	DPRINTK ("ENTER\n");
 
 #ifdef CONFIG_ZORRO
-	switch_monitor (info, 0);
-
-	clgen_zorro_unmap (info);
-#else
-	clgen_pci_unmap (info);
-#endif				/* CONFIG_ZORRO */
+	switch_monitor (cinfo, 0);
+#endif
 
-	unregister_framebuffer ((struct fb_info *) info);
+	cirrusfb_unmap (cinfo);
+	fb_dealloc_cmap (&info->cmap);
+	unregister_framebuffer (info);
 	printk ("Framebuffer unregistered\n");
+	framebuffer_release (info);
 
 	DPRINTK ("EXIT\n");
 }
 
 
+void __devexit cirrusfb_pci_unregister (struct pci_dev *pdev)
+{
+	struct fb_info *info = pci_get_drvdata(pdev);
+	DPRINTK ("ENTER\n");
+
+	cirrusfb_cleanup (info);
+
+	DPRINTK ("EXIT\n");
+}
+
+static struct pci_driver cirrusfb_driver = {
+	.name	= "cirrusfb",
+	.id_table	= cirrusfb_pci_table,
+	.probe		= cirrusfb_pci_register,
+	.remove		= __devexit_p(cirrusfb_pci_unregister),
+#ifdef CONFIG_PM
+#if 0
+	.suspend	= cirrusfb_pci_suspend,
+	.resume		= cirrusfb_pci_resume,
+#endif
+#endif
+};
+
+int __init cirrusfb_init(void)
+{
+#ifdef CONFIG_ZORRO
+	return cirrusfb_pci_register(NULL, NULL);
+#else
+	return pci_module_init(&cirrusfb_driver);
+#endif
+}
+
+
+
 #ifndef MODULE
-int __init clgenfb_setup(char *options) {
+int __init cirrusfb_setup(char *options) {
 	char *this_opt, s[32];
 	int i;
 
@@ -2864,12 +2539,12 @@
 	while ((this_opt = strsep (&options, ",")) != NULL) {	
 		if (!*this_opt) continue;
 
-		DPRINTK("clgenfb_setup: option '%s'\n", this_opt);
+		DPRINTK("cirrusfb_setup: option '%s'\n", this_opt);
 
 		for (i = 0; i < NUM_TOTAL_MODES; i++) {
-			sprintf (s, "mode:%s", clgenfb_predefined[i].name);
+			sprintf (s, "mode:%s", cirrusfb_predefined[i].name);
 			if (strcmp (this_opt, s) == 0)
-				clgen_def_mode = i;
+				cirrusfb_def_mode = i;
 		}
 		if (!strcmp(this_opt, "noaccel"))
 			noaccel = 1;
@@ -2887,19 +2562,15 @@
 MODULE_DESCRIPTION("Accelerated FBDev driver for Cirrus Logic chips");
 MODULE_LICENSE("GPL");
 
-static void __exit clgenfb_exit (void)
+void __exit cirrusfb_exit (void)
 {
-	DPRINTK ("ENTER\n");
-
-	clgenfb_cleanup (&boards[0]);	/* FIXME: support multiple boards */
-
-	DPRINTK ("EXIT\n");
+	pci_unregister_driver (&cirrusfb_driver);
 }
 
 #ifdef MODULE
-module_init(clgenfb_init);
+module_init(cirrusfb_init);
+module_exit(cirrusfb_exit);
 #endif
-module_exit(clgenfb_exit);
 
 
 /**********************************************************************/
@@ -2910,55 +2581,55 @@
 /**********************************************************************/
 
 /*** WGen() - write into one of the external/general registers ***/
-static void WGen (const struct clgenfb_info *fb_info,
+static void WGen (const struct cirrusfb_info *cinfo,
 		  int regnum, unsigned char val)
 {
 	unsigned long regofs = 0;
 
-	if (fb_info->btype == BT_PICASSO) {
+	if (cinfo->btype == BT_PICASSO) {
 		/* Picasso II specific hack */
 /*              if (regnum == VGA_PEL_IR || regnum == VGA_PEL_D || regnum == CL_VSSM2) */
 		if (regnum == VGA_PEL_IR || regnum == VGA_PEL_D)
 			regofs = 0xfff;
 	}
 
-	vga_w (fb_info->regs, regofs + regnum, val);
+	vga_w (cinfo->regbase, regofs + regnum, val);
 }
 
 /*** RGen() - read out one of the external/general registers ***/
-static unsigned char RGen (const struct clgenfb_info *fb_info, int regnum)
+static unsigned char RGen (const struct cirrusfb_info *cinfo, int regnum)
 {
 	unsigned long regofs = 0;
 
-	if (fb_info->btype == BT_PICASSO) {
+	if (cinfo->btype == BT_PICASSO) {
 		/* Picasso II specific hack */
 /*              if (regnum == VGA_PEL_IR || regnum == VGA_PEL_D || regnum == CL_VSSM2) */
 		if (regnum == VGA_PEL_IR || regnum == VGA_PEL_D)
 			regofs = 0xfff;
 	}
 
-	return vga_r (fb_info->regs, regofs + regnum);
+	return vga_r (cinfo->regbase, regofs + regnum);
 }
 
 /*** AttrOn() - turn on VideoEnable for Attribute controller ***/
-static void AttrOn (const struct clgenfb_info *fb_info)
+static void AttrOn (const struct cirrusfb_info *cinfo)
 {
-	assert (fb_info != NULL);
+	assert (cinfo != NULL);
 
 	DPRINTK ("ENTER\n");
 
-	if (vga_rcrt (fb_info->regs, CL_CRT24) & 0x80) {
+	if (vga_rcrt (cinfo->regbase, CL_CRT24) & 0x80) {
 		/* if we're just in "write value" mode, write back the */
 		/* same value as before to not modify anything */
-		vga_w (fb_info->regs, VGA_ATT_IW,
-		       vga_r (fb_info->regs, VGA_ATT_R));
+		vga_w (cinfo->regbase, VGA_ATT_IW,
+		       vga_r (cinfo->regbase, VGA_ATT_R));
 	}
 	/* turn on video bit */
-/*      vga_w (fb_info->regs, VGA_ATT_IW, 0x20); */
-	vga_w (fb_info->regs, VGA_ATT_IW, 0x33);
+/*      vga_w (cinfo->regbase, VGA_ATT_IW, 0x20); */
+	vga_w (cinfo->regbase, VGA_ATT_IW, 0x33);
 
 	/* dummy write on Reg0 to be on "write index" mode next time */
-	vga_w (fb_info->regs, VGA_ATT_IW, 0x00);
+	vga_w (cinfo->regbase, VGA_ATT_IW, 0x00);
 
 	DPRINTK ("EXIT\n");
 }
@@ -2969,127 +2640,127 @@
  * registers of their functional group) here is a specialized routine for
  * accessing the HDR
  */
-static void WHDR (const struct clgenfb_info *fb_info, unsigned char val)
+static void WHDR (const struct cirrusfb_info *cinfo, unsigned char val)
 {
 	unsigned char dummy;
 
-	if (fb_info->btype == BT_PICASSO) {
+	if (cinfo->btype == BT_PICASSO) {
 		/* Klaus' hint for correct access to HDR on some boards */
 		/* first write 0 to pixel mask (3c6) */
-		WGen (fb_info, VGA_PEL_MSK, 0x00);
+		WGen (cinfo, VGA_PEL_MSK, 0x00);
 		udelay (200);
 		/* next read dummy from pixel address (3c8) */
-		dummy = RGen (fb_info, VGA_PEL_IW);
+		dummy = RGen (cinfo, VGA_PEL_IW);
 		udelay (200);
 	}
 	/* now do the usual stuff to access the HDR */
 
-	dummy = RGen (fb_info, VGA_PEL_MSK);
+	dummy = RGen (cinfo, VGA_PEL_MSK);
 	udelay (200);
-	dummy = RGen (fb_info, VGA_PEL_MSK);
+	dummy = RGen (cinfo, VGA_PEL_MSK);
 	udelay (200);
-	dummy = RGen (fb_info, VGA_PEL_MSK);
+	dummy = RGen (cinfo, VGA_PEL_MSK);
 	udelay (200);
-	dummy = RGen (fb_info, VGA_PEL_MSK);
+	dummy = RGen (cinfo, VGA_PEL_MSK);
 	udelay (200);
 
-	WGen (fb_info, VGA_PEL_MSK, val);
+	WGen (cinfo, VGA_PEL_MSK, val);
 	udelay (200);
 
-	if (fb_info->btype == BT_PICASSO) {
+	if (cinfo->btype == BT_PICASSO) {
 		/* now first reset HDR access counter */
-		dummy = RGen (fb_info, VGA_PEL_IW);
+		dummy = RGen (cinfo, VGA_PEL_IW);
 		udelay (200);
 
 		/* and at the end, restore the mask value */
 		/* ## is this mask always 0xff? */
-		WGen (fb_info, VGA_PEL_MSK, 0xff);
+		WGen (cinfo, VGA_PEL_MSK, 0xff);
 		udelay (200);
 	}
 }
 
 
 /*** WSFR() - write to the "special function register" (SFR) ***/
-static void WSFR (struct clgenfb_info *fb_info, unsigned char val)
+static void WSFR (struct cirrusfb_info *cinfo, unsigned char val)
 {
 #ifdef CONFIG_ZORRO
-	assert (fb_info->regs != NULL);
-	fb_info->SFR = val;
-	z_writeb (val, fb_info->regs + 0x8000);
+	assert (cinfo->regbase != NULL);
+	cinfo->SFR = val;
+	z_writeb (val, cinfo->regbase + 0x8000);
 #endif
 }
 
 /* The Picasso has a second register for switching the monitor bit */
-static void WSFR2 (struct clgenfb_info *fb_info, unsigned char val)
+static void WSFR2 (struct cirrusfb_info *cinfo, unsigned char val)
 {
 #ifdef CONFIG_ZORRO
 	/* writing an arbitrary value to this one causes the monitor switcher */
 	/* to flip to Amiga display */
-	assert (fb_info->regs != NULL);
-	fb_info->SFR = val;
-	z_writeb (val, fb_info->regs + 0x9000);
+	assert (cinfo->regbase != NULL);
+	cinfo->SFR = val;
+	z_writeb (val, cinfo->regbase + 0x9000);
 #endif
 }
 
 
 /*** WClut - set CLUT entry (range: 0..63) ***/
-static void WClut (struct clgenfb_info *fb_info, unsigned char regnum, unsigned char red,
+static void WClut (struct cirrusfb_info *cinfo, unsigned char regnum, unsigned char red,
 	    unsigned char green, unsigned char blue)
 {
 	unsigned int data = VGA_PEL_D;
 
 	/* address write mode register is not translated.. */
-	vga_w (fb_info->regs, VGA_PEL_IW, regnum);
+	vga_w (cinfo->regbase, VGA_PEL_IW, regnum);
 
-	if (fb_info->btype == BT_PICASSO || fb_info->btype == BT_PICASSO4 ||
-	    fb_info->btype == BT_ALPINE || fb_info->btype == BT_GD5480) {
+	if (cinfo->btype == BT_PICASSO || cinfo->btype == BT_PICASSO4 ||
+	    cinfo->btype == BT_ALPINE || cinfo->btype == BT_GD5480) {
 		/* but DAC data register IS, at least for Picasso II */
-		if (fb_info->btype == BT_PICASSO)
+		if (cinfo->btype == BT_PICASSO)
 			data += 0xfff;
-		vga_w (fb_info->regs, data, red);
-		vga_w (fb_info->regs, data, green);
-		vga_w (fb_info->regs, data, blue);
+		vga_w (cinfo->regbase, data, red);
+		vga_w (cinfo->regbase, data, green);
+		vga_w (cinfo->regbase, data, blue);
 	} else {
-		vga_w (fb_info->regs, data, blue);
-		vga_w (fb_info->regs, data, green);
-		vga_w (fb_info->regs, data, red);
+		vga_w (cinfo->regbase, data, blue);
+		vga_w (cinfo->regbase, data, green);
+		vga_w (cinfo->regbase, data, red);
 	}
 }
 
 
 #if 0
 /*** RClut - read CLUT entry (range 0..63) ***/
-static void RClut (struct clgenfb_info *fb_info, unsigned char regnum, unsigned char *red,
+static void RClut (struct cirrusfb_info *cinfo, unsigned char regnum, unsigned char *red,
 	    unsigned char *green, unsigned char *blue)
 {
 	unsigned int data = VGA_PEL_D;
 
-	vga_w (fb_info->regs, VGA_PEL_IR, regnum);
+	vga_w (cinfo->regbase, VGA_PEL_IR, regnum);
 
-	if (fb_info->btype == BT_PICASSO || fb_info->btype == BT_PICASSO4 ||
-	    fb_info->btype == BT_ALPINE || fb_info->btype == BT_GD5480) {
-		if (fb_info->btype == BT_PICASSO)
+	if (cinfo->btype == BT_PICASSO || cinfo->btype == BT_PICASSO4 ||
+	    cinfo->btype == BT_ALPINE || cinfo->btype == BT_GD5480) {
+		if (cinfo->btype == BT_PICASSO)
 			data += 0xfff;
-		*red = vga_r (fb_info->regs, data);
-		*green = vga_r (fb_info->regs, data);
-		*blue = vga_r (fb_info->regs, data);
+		*red = vga_r (cinfo->regbase, data);
+		*green = vga_r (cinfo->regbase, data);
+		*blue = vga_r (cinfo->regbase, data);
 	} else {
-		*blue = vga_r (fb_info->regs, data);
-		*green = vga_r (fb_info->regs, data);
-		*red = vga_r (fb_info->regs, data);
+		*blue = vga_r (cinfo->regbase, data);
+		*green = vga_r (cinfo->regbase, data);
+		*red = vga_r (cinfo->regbase, data);
 	}
 }
 #endif
 
 
 /*******************************************************************
-	clgen_WaitBLT()
+	cirrusfb_WaitBLT()
 
 	Wait for the BitBLT engine to complete a possible earlier job
 *********************************************************************/
 
 /* FIXME: use interrupts instead */
-static inline void clgen_WaitBLT (caddr_t regbase)
+static void cirrusfb_WaitBLT (caddr_t regbase)
 {
 	/* now busy-wait until we're done */
 	while (vga_rgfx (regbase, CL_GR31) & 0x08)
@@ -3097,13 +2768,14 @@
 }
 
 /*******************************************************************
-	clgen_BitBLT()
+	cirrusfb_BitBLT()
 
 	perform accelerated "scrolling"
 ********************************************************************/
 
-static void clgen_BitBLT (caddr_t regbase, u_short curx, u_short cury, u_short destx, u_short desty,
-		   u_short width, u_short height, u_short line_length)
+static void cirrusfb_BitBLT (caddr_t regbase, int bits_per_pixel,
+			     u_short curx, u_short cury, u_short destx, u_short desty,
+		  	     u_short width, u_short height, u_short line_length)
 {
 	u_short nwidth, nheight;
 	u_long nsrc, ndest;
@@ -3134,8 +2806,6 @@
 		ndest = desty * line_length + destx + nheight * line_length + nwidth;
 	}
 
-        clgen_WaitBLT(regbase);
-
 	/*
 	   run-down of registers to be programmed:
 	   destination pitch
@@ -3149,6 +2819,8 @@
 	   start/stop
 	 */
 
+        cirrusfb_WaitBLT(regbase);
+
 	/* pitch: set to line_length */
 	vga_wgfx (regbase, CL_GR24, line_length & 0xff);	/* dest pitch low */
 	vga_wgfx (regbase, CL_GR25, (line_length >> 8));	/* dest pitch hi */
@@ -3187,12 +2859,12 @@
 
 
 /*******************************************************************
-	clgen_RectFill()
+	cirrusfb_RectFill()
 
 	perform accelerated rectangle fill
 ********************************************************************/
 
-static void clgen_RectFill (struct clgenfb_info *fb_info,
+static void cirrusfb_RectFill (caddr_t regbase, int bits_per_pixel,
 		     u_short x, u_short y, u_short width, u_short height,
 		     u_char color, u_short line_length)
 {
@@ -3207,61 +2879,61 @@
 
 	ndest = (y * line_length) + x;
 
-        clgen_WaitBLT(fb_info->regs);
+        cirrusfb_WaitBLT(regbase);
 
 	/* pitch: set to line_length */
-	vga_wgfx (fb_info->regs, CL_GR24, line_length & 0xff);	/* dest pitch low */
-	vga_wgfx (fb_info->regs, CL_GR25, (line_length >> 8));	/* dest pitch hi */
-	vga_wgfx (fb_info->regs, CL_GR26, line_length & 0xff);	/* source pitch low */
-	vga_wgfx (fb_info->regs, CL_GR27, (line_length >> 8));	/* source pitch hi */
+	vga_wgfx (regbase, CL_GR24, line_length & 0xff);	/* dest pitch low */
+	vga_wgfx (regbase, CL_GR25, (line_length >> 8));	/* dest pitch hi */
+	vga_wgfx (regbase, CL_GR26, line_length & 0xff);	/* source pitch low */
+	vga_wgfx (regbase, CL_GR27, (line_length >> 8));	/* source pitch hi */
 
 	/* BLT width: actual number of pixels - 1 */
-	vga_wgfx (fb_info->regs, CL_GR20, nwidth & 0xff);	/* BLT width low */
-	vga_wgfx (fb_info->regs, CL_GR21, (nwidth >> 8));	/* BLT width hi */
+	vga_wgfx (regbase, CL_GR20, nwidth & 0xff);	/* BLT width low */
+	vga_wgfx (regbase, CL_GR21, (nwidth >> 8));	/* BLT width hi */
 
 	/* BLT height: actual number of lines -1 */
-	vga_wgfx (fb_info->regs, CL_GR22, nheight & 0xff);		/* BLT height low */
-	vga_wgfx (fb_info->regs, CL_GR23, (nheight >> 8));		/* BLT width hi */
+	vga_wgfx (regbase, CL_GR22, nheight & 0xff);		/* BLT height low */
+	vga_wgfx (regbase, CL_GR23, (nheight >> 8));		/* BLT width hi */
 
 	/* BLT destination */
-	vga_wgfx (fb_info->regs, CL_GR28, (u_char) (ndest & 0xff));	/* BLT dest low */
-	vga_wgfx (fb_info->regs, CL_GR29, (u_char) (ndest >> 8));	/* BLT dest mid */
-	vga_wgfx (fb_info->regs, CL_GR2A, (u_char) (ndest >> 16));		/* BLT dest hi */
+	vga_wgfx (regbase, CL_GR28, (u_char) (ndest & 0xff));	/* BLT dest low */
+	vga_wgfx (regbase, CL_GR29, (u_char) (ndest >> 8));	/* BLT dest mid */
+	vga_wgfx (regbase, CL_GR2A, (u_char) (ndest >> 16));		/* BLT dest hi */
 
 	/* BLT source: set to 0 (is a dummy here anyway) */
-	vga_wgfx (fb_info->regs, CL_GR2C, 0x00);	/* BLT src low */
-	vga_wgfx (fb_info->regs, CL_GR2D, 0x00);	/* BLT src mid */
-	vga_wgfx (fb_info->regs, CL_GR2E, 0x00);	/* BLT src hi */
+	vga_wgfx (regbase, CL_GR2C, 0x00);	/* BLT src low */
+	vga_wgfx (regbase, CL_GR2D, 0x00);	/* BLT src mid */
+	vga_wgfx (regbase, CL_GR2E, 0x00);	/* BLT src hi */
 
 	/* This is a ColorExpand Blt, using the */
 	/* same color for foreground and background */
-	vga_wgfx (fb_info->regs, VGA_GFX_SR_VALUE, color);	/* foreground color */
-	vga_wgfx (fb_info->regs, VGA_GFX_SR_ENABLE, color);	/* background color */
+	vga_wgfx (regbase, VGA_GFX_SR_VALUE, color);	/* foreground color */
+	vga_wgfx (regbase, VGA_GFX_SR_ENABLE, color);	/* background color */
 
 	op = 0xc0;
-	if (fb_info->currentmode.var.bits_per_pixel == 16) {
-		vga_wgfx (fb_info->regs, CL_GR10, color);	/* foreground color */
-		vga_wgfx (fb_info->regs, CL_GR11, color);	/* background color */
+	if (bits_per_pixel == 16) {
+		vga_wgfx (regbase, CL_GR10, color);	/* foreground color */
+		vga_wgfx (regbase, CL_GR11, color);	/* background color */
 		op = 0x50;
 		op = 0xd0;
-	} else if (fb_info->currentmode.var.bits_per_pixel == 32) {
-		vga_wgfx (fb_info->regs, CL_GR10, color);	/* foreground color */
-		vga_wgfx (fb_info->regs, CL_GR11, color);	/* background color */
-		vga_wgfx (fb_info->regs, CL_GR12, color);	/* foreground color */
-		vga_wgfx (fb_info->regs, CL_GR13, color);	/* background color */
-		vga_wgfx (fb_info->regs, CL_GR14, 0);	/* foreground color */
-		vga_wgfx (fb_info->regs, CL_GR15, 0);	/* background color */
+	} else if (bits_per_pixel == 32) {
+		vga_wgfx (regbase, CL_GR10, color);	/* foreground color */
+		vga_wgfx (regbase, CL_GR11, color);	/* background color */
+		vga_wgfx (regbase, CL_GR12, color);	/* foreground color */
+		vga_wgfx (regbase, CL_GR13, color);	/* background color */
+		vga_wgfx (regbase, CL_GR14, 0);	/* foreground color */
+		vga_wgfx (regbase, CL_GR15, 0);	/* background color */
 		op = 0x50;
 		op = 0xf0;
 	}
 	/* BLT mode: color expand, Enable 8x8 copy (faster?) */
-	vga_wgfx (fb_info->regs, CL_GR30, op);	/* BLT mode */
+	vga_wgfx (regbase, CL_GR30, op);	/* BLT mode */
 
 	/* BLT ROP: SrcCopy */
-	vga_wgfx (fb_info->regs, CL_GR32, 0x0d);	/* BLT ROP */
+	vga_wgfx (regbase, CL_GR32, 0x0d);	/* BLT ROP */
 
 	/* and finally: GO! */
-	vga_wgfx (fb_info->regs, CL_GR31, 0x02);	/* BLT Start/status */
+	vga_wgfx (regbase, CL_GR31, 0x02);	/* BLT Start/status */
 
 	DPRINTK ("EXIT\n");
 }
@@ -3349,10 +3021,10 @@
  * -------------------------------------------------------------------------
  */
 
-#ifdef CLGEN_DEBUG
+#ifdef CIRRUSFB_DEBUG
 
 /**
- * clgen_dbg_print_byte
+ * cirrusfb_dbg_print_byte
  * @name: name associated with byte value to be displayed
  * @val: byte value to be displayed
  *
@@ -3363,7 +3035,7 @@
  */
 
 static
-void clgen_dbg_print_byte (const char *name, unsigned char val)
+void cirrusfb_dbg_print_byte (const char *name, unsigned char val)
 {
 	DPRINTK ("%8s = 0x%02X (bits 7-0: %c%c%c%c%c%c%c%c)\n",
 		 name, val,
@@ -3379,7 +3051,7 @@
 
 
 /**
- * clgen_dbg_print_regs
+ * cirrusfb_dbg_print_regs
  * @base: If using newmmio, the newmmio base address, otherwise %NULL
  * @reg_class: type of registers to read: %CRT, or %SEQ
  *
@@ -3390,7 +3062,7 @@
  */
 
 static
-void clgen_dbg_print_regs (caddr_t regbase, clgen_dbg_reg_class_t reg_class,...)
+void cirrusfb_dbg_print_regs (caddr_t regbase, cirrusfb_dbg_reg_class_t reg_class,...)
 {
 	va_list list;
 	unsigned char val = 0;
@@ -3416,7 +3088,7 @@
 			break;
 		}
 
-		clgen_dbg_print_byte (name, val);
+		cirrusfb_dbg_print_byte (name, val);
 
 		name = va_arg (list, char *);
 	}
@@ -3426,35 +3098,35 @@
 
 
 /**
- * clgen_dump
- * @clgeninfo:
+ * cirrusfb_dump
+ * @cirrusfbinfo:
  *
  * DESCRIPTION:
  */
 
 static
-void clgen_dump (void)
+void cirrusfb_dump (void)
 {
-	clgen_dbg_reg_dump (NULL);
+	cirrusfb_dbg_reg_dump (NULL);
 }
 
 
 /**
- * clgen_dbg_reg_dump
+ * cirrusfb_dbg_reg_dump
  * @base: If using newmmio, the newmmio base address, otherwise %NULL
  *
  * DESCRIPTION:
- * Dumps a list of interesting VGA and CLGEN registers.  If @base is %NULL,
+ * Dumps a list of interesting VGA and CIRRUSFB registers.  If @base is %NULL,
  * old-style I/O ports are queried for information, otherwise MMIO is
  * used at the given @base address to query the information.
  */
 
 static
-void clgen_dbg_reg_dump (caddr_t regbase)
+void cirrusfb_dbg_reg_dump (caddr_t regbase)
 {
-	DPRINTK ("CLGEN VGA CRTC register dump:\n");
+	DPRINTK ("CIRRUSFB VGA CRTC register dump:\n");
 
-	clgen_dbg_print_regs (regbase, CRT,
+	cirrusfb_dbg_print_regs (regbase, CRT,
 			   "CR00", 0x00,
 			   "CR01", 0x01,
 			   "CR02", 0x02,
@@ -3506,9 +3178,9 @@
 
 	DPRINTK ("\n");
 
-	DPRINTK ("CLGEN VGA SEQ register dump:\n");
+	DPRINTK ("CIRRUSFB VGA SEQ register dump:\n");
 
-	clgen_dbg_print_regs (regbase, SEQ,
+	cirrusfb_dbg_print_regs (regbase, SEQ,
 			   "SR00", 0x00,
 			   "SR01", 0x01,
 			   "SR02", 0x02,
@@ -3540,5 +3212,5 @@
 	DPRINTK ("\n");
 }
 
-#endif				/* CLGEN_DEBUG */
+#endif				/* CIRRUSFB_DEBUG */
 
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2004-06-22 16:12:19 -04:00
+++ b/drivers/video/fbmem.c	2004-06-22 16:12:19 -04:00
@@ -73,8 +73,8 @@
 extern int cyber2000fb_setup(char*);
 extern int retz3fb_init(void);
 extern int retz3fb_setup(char*);
-extern int clgenfb_init(void);
-extern int clgenfb_setup(char*);
+extern int cirrusfb_init(void);
+extern int cirrusfb_setup(char*);
 extern int hitfb_init(void);
 extern int vfb_init(void);
 extern int vfb_setup(char*);
@@ -204,8 +204,8 @@
 #ifdef CONFIG_FB_PM3
 	{ "pm3fb", pm3fb_init, pm3fb_setup },
 #endif           
-#ifdef CONFIG_FB_CLGEN
-	{ "clgenfb", clgenfb_init, clgenfb_setup },
+#ifdef CONFIG_FB_CIRRUS
+	{ "cirrusfb", cirrusfb_init, cirrusfb_setup },
 #endif
 #ifdef CONFIG_FB_ATY
 	{ "atyfb", atyfb_init, atyfb_setup },


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: (no subject)
Date: Fri, 17 Aug 2007 18:47:13 +0200
Message-ID: <46c5d1110df9a@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46c5d111106b2"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IM4yj-0004Po-Tl for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 09:47:21 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IM4yh-0005L0-Ex
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 09:47:17 -0700
Received: from poczta-5.free.wp-sa.pl (HELO localhost) ([10.1.1.10])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	17 Aug 2007 18:47:13 +0200
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--part46c5d111106b2
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes over 850 errors and warnings pointed
out by the checkpatch.pl script.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

I run the checkpatch.pl script on the whole drivers/video
directory. The most errors are in drivers which share code
with X11 (sis, nvidia). The cirrus driver had the most errors
as a non-X11 driver.

--- linux-2.6.23.old/drivers/video/cirrusfb.c	2007-07-09 01:
32:16.000000000 +0200
+++ linux-2.6.23/drivers/video/cirrusfb.c	2007-08-16 19:43:
03.000000000 +0200
@@ -59,7 +59,7 @@
 #endif
 #ifdef CONFIG_PPC_PREP
 #include <asm/machdep.h>
-#define isPReP (machine_is(prep))
+#define isPReP(machine_is(prep))
 #else
 #define isPReP 0
 #endif
@@ -67,7 +67,6 @@
 #include "video/vga.h"
 #include "video/cirrus.h"
=20
-
=20
/****************************************************************
*
  *
  * debugging and utility macros
@@ -82,7 +81,8 @@
=20
 /* debug output */
 #ifdef CIRRUSFB_DEBUG
-#define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt,=20
__FUNCTION__ , ## args)
+#define DPRINTK(fmt, args...) \
+	printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
 #else
 #define DPRINTK(fmt, args...)
 #endif
@@ -90,20 +90,19 @@
 /* debugging assertions */
 #ifndef CIRRUSFB_NDEBUG
 #define assert(expr) \
-        if(!(expr)) { \
-        printk( "Assertion failed! %s,%s,%s,line=3D%d\n",\
-        #expr,__FILE__,__FUNCTION__,__LINE__); \
-        }
+	if (!(expr)) { \
+		printk("Assertion failed! %s,%s,%s,line=3D%d\n", \
+		#expr, __FILE__, __FUNCTION__, __LINE__); \
+	}
 #else
 #define assert(expr)
 #endif
=20
-#define MB_ (1024*1024)
+#define MB_ (1024 * 1024)
 #define KB_ (1024)
=20
 #define MAX_NUM_BOARDS 7
=20
-
=20
/****************************************************************
*
  *
  * chipset information
@@ -123,7 +122,6 @@ typedef enum {
 	BT_LAGUNA,	/* GD546x */
 } cirrusfb_board_t;
=20
-
 /*
  * per-board-type information, used for enumerating and=20
abstracting
  * chip-specific information
@@ -139,7 +137,8 @@ static const struct cirrusfb_board_info_
 	/* for  1/4bpp, 8bpp 15/16bpp, 24bpp, 32bpp - numbers from=20
xorg code */
 	bool init_sr07 : 1; /* init SR07 during init_vgachip() */
 	bool init_sr1f : 1; /* write SR1F during init_vgachip() */
-	bool scrn_start_bit19 : 1; /* construct bit 19 of screen=20
start address */
+	/* construct bit 19 of screen start address */
+	bool scrn_start_bit19 : 1;
=20
 	/* initial SR07 value, then for each mode */
 	unsigned char sr07;
@@ -261,30 +260,28 @@ static const struct cirrusfb_board_info_
 	}
 };
=20
-
 #ifdef CONFIG_PCI
 #define CHIP(id, btype) \
 	{ PCI_VENDOR_ID_CIRRUS, id, PCI_ANY_ID, PCI_ANY_ID, 0, 0,=20
(btype) }
=20
 static struct pci_device_id cirrusfb_pci_table[] =3D {
-	CHIP( PCI_DEVICE_ID_CIRRUS_5436, BT_ALPINE ),
-	CHIP( PCI_DEVICE_ID_CIRRUS_5434_8, BT_ALPINE ),
-	CHIP( PCI_DEVICE_ID_CIRRUS_5434_4, BT_ALPINE ),
-	CHIP( PCI_DEVICE_ID_CIRRUS_5430, BT_ALPINE ), /* GD-5440 is=20
same id */
-	CHIP( PCI_DEVICE_ID_CIRRUS_7543, BT_ALPINE ),
-	CHIP( PCI_DEVICE_ID_CIRRUS_7548, BT_ALPINE ),
-	CHIP( PCI_DEVICE_ID_CIRRUS_5480, BT_GD5480 ), /* MacPicasso=20
likely */
-	CHIP( PCI_DEVICE_ID_CIRRUS_5446, BT_PICASSO4 ), /* Picasso=20
4 is 5446 */
-	CHIP( PCI_DEVICE_ID_CIRRUS_5462, BT_LAGUNA ), /* CL Laguna=20
*/
-	CHIP( PCI_DEVICE_ID_CIRRUS_5464, BT_LAGUNA ), /* CL Laguna=20
3D */
-	CHIP( PCI_DEVICE_ID_CIRRUS_5465, BT_LAGUNA ), /* CL Laguna=20
3DA*/
+	CHIP(PCI_DEVICE_ID_CIRRUS_5436, BT_ALPINE),
+	CHIP(PCI_DEVICE_ID_CIRRUS_5434_8, BT_ALPINE),
+	CHIP(PCI_DEVICE_ID_CIRRUS_5434_4, BT_ALPINE),
+	CHIP(PCI_DEVICE_ID_CIRRUS_5430, BT_ALPINE), /* GD-5440 is=20
same id */
+	CHIP(PCI_DEVICE_ID_CIRRUS_7543, BT_ALPINE),
+	CHIP(PCI_DEVICE_ID_CIRRUS_7548, BT_ALPINE),
+	CHIP(PCI_DEVICE_ID_CIRRUS_5480, BT_GD5480), /* MacPicasso=20
likely */
+	CHIP(PCI_DEVICE_ID_CIRRUS_5446, BT_PICASSO4), /* Picasso 4=20
is 5446 */
+	CHIP(PCI_DEVICE_ID_CIRRUS_5462, BT_LAGUNA), /* CL Laguna */
+	CHIP(PCI_DEVICE_ID_CIRRUS_5464, BT_LAGUNA), /* CL Laguna 3D=20
*/
+	CHIP(PCI_DEVICE_ID_CIRRUS_5465, BT_LAGUNA), /* CL Laguna=20
3DA*/
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, cirrusfb_pci_table);
 #undef CHIP
 #endif /* CONFIG_PCI */
=20
-
 #ifdef CONFIG_ZORRO
 static const struct zorro_device_id cirrusfb_zorro_table[] =3D {
 	{
@@ -294,7 +291,7 @@ static const struct zorro_device_id cirr
 		.id		=3D ZORRO_PROD_HELFRICH_PICCOLO_RAM,
 		.driver_data	=3D BT_PICCOLO,
 	}, {
-		.id		=3D=20
ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_RAM,
+		.id	=3D=20
ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_RAM,
 		.driver_data	=3D BT_PICASSO,
 	}, {
 		.id		=3D ZORRO_PROD_GVP_EGS_28_24_SPECTRUM_RAM,
@@ -333,7 +330,6 @@ static const struct {
 };
 #endif /* CONFIG_ZORRO */
=20
-
 struct cirrusfb_regs {
 	__u32 line_length;	/* in BYTES! */
 	__u32 visual;
@@ -364,17 +360,12 @@ struct cirrusfb_regs {
 	long VertBlankEnd;
 };
=20
-
-
 #ifdef CIRRUSFB_DEBUG
 typedef enum {
-        CRT,
-        SEQ
+	CRT,
+	SEQ
 } cirrusfb_dbg_reg_class_t;
-#endif                          /* CIRRUSFB_DEBUG */
-
-
-
+#endif		/* CIRRUSFB_DEBUG */
=20
 /* info about board */
 struct cirrusfb_info {
@@ -405,9 +396,8 @@ struct cirrusfb_info {
 	void (*unmap)(struct cirrusfb_info *cinfo);
 };
=20
-
 static unsigned cirrusfb_def_mode =3D 1;
-static int noaccel =3D 0;
+static int noaccel;
=20
 /*
  *    Predefined Video Modes
@@ -441,7 +431,7 @@ static const struct {
 			.lower_margin	=3D 8,
 			.hsync_len	=3D 96,
 			.vsync_len	=3D 4,
-			.sync		=3D FB_SYNC_HOR_HIGH_ACT |=20
FB_SYNC_VERT_HIGH_ACT,
+			.sync	=3D FB_SYNC_HOR_HIGH_ACT |=20
FB_SYNC_VERT_HIGH_ACT,
 			.vmode		=3D FB_VMODE_NONINTERLACED
 		 }
 	}, {
@@ -502,27 +492,29 @@ static const struct {
=20
/****************************************************************
************/
 /**** BEGIN PROTOTYPES=20
******************************************************/
=20
-
 /*--- Interface used by the world=20
------------------------------------------*/
-static int cirrusfb_init (void);
+static int cirrusfb_init(void);
 #ifndef MODULE
-static int cirrusfb_setup (char *options);
+static int cirrusfb_setup(char *options);
 #endif
=20
-static int cirrusfb_open (struct fb_info *info, int user);
-static int cirrusfb_release (struct fb_info *info, int user);
-static int cirrusfb_setcolreg (unsigned regno, unsigned red,=20
unsigned green,
-			       unsigned blue, unsigned transp,
-			       struct fb_info *info);
-static int cirrusfb_check_var (struct fb_var_screeninfo *var,
-			       struct fb_info *info);
-static int cirrusfb_set_par (struct fb_info *info);
-static int cirrusfb_pan_display (struct fb_var_screeninfo *var,
-				 struct fb_info *info);
-static int cirrusfb_blank (int blank_mode, struct fb_info *info)
;
-static void cirrusfb_fillrect (struct fb_info *info, const=20
struct fb_fillrect *region);
-static void cirrusfb_copyarea(struct fb_info *info, const struct=20
fb_copyarea *area);
-static void cirrusfb_imageblit(struct fb_info *info, const=20
struct fb_image *image);
+static int cirrusfb_open(struct fb_info *info, int user);
+static int cirrusfb_release(struct fb_info *info, int user);
+static int cirrusfb_setcolreg(unsigned regno, unsigned red,=20
unsigned green,
+			      unsigned blue, unsigned transp,
+			      struct fb_info *info);
+static int cirrusfb_check_var(struct fb_var_screeninfo *var,
+			      struct fb_info *info);
+static int cirrusfb_set_par(struct fb_info *info);
+static int cirrusfb_pan_display(struct fb_var_screeninfo *var,
+				struct fb_info *info);
+static int cirrusfb_blank(int blank_mode, struct fb_info *info);
+static void cirrusfb_fillrect(struct fb_info *info,
+			      const struct fb_fillrect *region);
+static void cirrusfb_copyarea(struct fb_info *info,
+			      const struct fb_copyarea *area);
+static void cirrusfb_imageblit(struct fb_info *info,
+			       const struct fb_image *image);
=20
 /* function table of the above functions */
 static struct fb_ops cirrusfb_ops =3D {
@@ -540,68 +532,68 @@ static struct fb_ops cirrusfb_ops =3D {
 };
=20
 /*--- Hardware Specific Routines=20
-------------------------------------------*/
-static int cirrusfb_decode_var (const struct fb_var_screeninfo=20
*var,
+static int cirrusfb_decode_var(const struct fb_var_screeninfo=20
*var,
 				struct cirrusfb_regs *regs,
 				const struct fb_info *info);
 /*--- Internal routines=20
----------------------------------------------------*/
-static void init_vgachip (struct cirrusfb_info *cinfo);
-static void switch_monitor (struct cirrusfb_info *cinfo, int on)
;
-static void WGen (const struct cirrusfb_info *cinfo,
-		  int regnum, unsigned char val);
-static unsigned char RGen (const struct cirrusfb_info *cinfo,=20
int regnum);
-static void AttrOn (const struct cirrusfb_info *cinfo);
-static void WHDR (const struct cirrusfb_info *cinfo, unsigned=20
char val);
-static void WSFR (struct cirrusfb_info *cinfo, unsigned char=20
val);
-static void WSFR2 (struct cirrusfb_info *cinfo, unsigned char=20
val);
-static void WClut (struct cirrusfb_info *cinfo, unsigned char=20
regnum, unsigned char red,
-		   unsigned char green,
-		   unsigned char blue);
+static void init_vgachip(struct cirrusfb_info *cinfo);
+static void switch_monitor(struct cirrusfb_info *cinfo, int on);
+static void WGen(const struct cirrusfb_info *cinfo,
+		 int regnum, unsigned char val);
+static unsigned char RGen(const struct cirrusfb_info *cinfo, int=20
regnum);
+static void AttrOn(const struct cirrusfb_info *cinfo);
+static void WHDR(const struct cirrusfb_info *cinfo, unsigned=20
char val);
+static void WSFR(struct cirrusfb_info *cinfo, unsigned char val)
;
+static void WSFR2(struct cirrusfb_info *cinfo, unsigned char=20
val);
+static void WClut(struct cirrusfb_info *cinfo, unsigned char=20
regnum,
+		  unsigned char red, unsigned char green, unsigned char=20
blue);
 #if 0
-static void RClut (struct cirrusfb_info *cinfo, unsigned char=20
regnum, unsigned char *red,
-		   unsigned char *green,
-		   unsigned char *blue);
-#endif
-static void cirrusfb_WaitBLT (u8 __iomem *regbase);
-static void cirrusfb_BitBLT (u8 __iomem *regbase, int=20
bits_per_pixel,
-			     u_short curx, u_short cury,
-			     u_short destx, u_short desty,
-			     u_short width, u_short height,
-			     u_short line_length);
-static void cirrusfb_RectFill (u8 __iomem *regbase, int=20
bits_per_pixel,
-			       u_short x, u_short y,
-			       u_short width, u_short height,
-			       u_char color, u_short line_length);
-
-static void bestclock (long freq, long *best,
-		       long *nom, long *den,
-		       long *div, long maxfreq);
+static void RClut(struct cirrusfb_info *cinfo, unsigned char=20
regnum,
+		  unsigned char *red, unsigned char *green,
+		  unsigned char *blue);
+#endif
+static void cirrusfb_WaitBLT(u8 __iomem *regbase);
+static void cirrusfb_BitBLT(u8 __iomem *regbase, int=20
bits_per_pixel,
+			    u_short curx, u_short cury,
+			    u_short destx, u_short desty,
+			    u_short width, u_short height,
+			    u_short line_length);
+static void cirrusfb_RectFill(u8 __iomem *regbase, int=20
bits_per_pixel,
+			      u_short x, u_short y,
+			      u_short width, u_short height,
+			      u_char color, u_short line_length);
+
+static void bestclock(long freq, long *best,
+		      long *nom, long *den,
+		      long *div, long maxfreq);
=20
 #ifdef CIRRUSFB_DEBUG
-static void cirrusfb_dump (void);
-static void cirrusfb_dbg_reg_dump (caddr_t regbase);
-static void cirrusfb_dbg_print_regs (caddr_t regbase,=20
cirrusfb_dbg_reg_class_t reg_class,...);
-static void cirrusfb_dbg_print_byte (const char *name, unsigned=20
char val);
+static void cirrusfb_dump(void);
+static void cirrusfb_dbg_reg_dump(caddr_t regbase);
+static void cirrusfb_dbg_print_regs(caddr_t regbase,
+				    cirrusfb_dbg_reg_class_t reg_class, ...);
+static void cirrusfb_dbg_print_byte(const char *name, unsigned=20
char val);
 #endif /* CIRRUSFB_DEBUG */
=20
 /*** END   PROTOTYPES=20
********************************************************/
=20
/****************************************************************
*************/
 /*** BEGIN Interface Used by the World=20
***************************************/
=20
-static int opencount =3D 0;
+static int opencount;
=20
 /*--- Open /dev/fbx=20
---------------------------------------------------------*/
-static int cirrusfb_open (struct fb_info *info, int user)
+static int cirrusfb_open(struct fb_info *info, int user)
 {
 	if (opencount++ =3D=3D 0)
-		switch_monitor (info->par, 1);
+		switch_monitor(info->par, 1);
 	return 0;
 }
=20
 /*--- Close /dev/fbx=20
--------------------------------------------------------*/
-static int cirrusfb_release (struct fb_info *info, int user)
+static int cirrusfb_release(struct fb_info *info, int user)
 {
 	if (--opencount =3D=3D 0)
-		switch_monitor (info->par, 0);
+		switch_monitor(info->par, 0);
 	return 0;
 }
=20
@@ -610,11 +602,11 @@ static int cirrusfb_release (struct fb_i
 /**** BEGIN Hardware specific Routines=20
**************************************/
=20
 /* Get a good MCLK value */
-static long cirrusfb_get_mclk (long freq, int bpp, long *div)
+static long cirrusfb_get_mclk(long freq, int bpp, long *div)
 {
 	long mclk;
=20
-	assert (div !=3D NULL);
+	assert(div !=3D NULL);
=20
 	/* Calculate MCLK, in case VCLK is high enough to require >=20
50MHz.
 	 * Assume a 64-bit data path for now.  The formula is:
@@ -624,23 +616,23 @@ static long cirrusfb_get_mclk (long freq
 	mclk =3D (mclk * 12) / 10;
 	if (mclk < 50000)
 		mclk =3D 50000;
-	DPRINTK ("Use MCLK of %ld kHz\n", mclk);
+	DPRINTK("Use MCLK of %ld kHz\n", mclk);
=20
 	/* Calculate value for SR1F.  Multiply by 2 so we can round=20
up. */
 	mclk =3D ((mclk * 16) / 14318);
 	mclk =3D (mclk + 1) / 2;
-	DPRINTK ("Set SR1F[5:0] to 0x%lx\n", mclk);
+	DPRINTK("Set SR1F[5:0] to 0x%lx\n", mclk);
=20
 	/* Determine if we should use MCLK instead of VCLK, and if=20
so, what we
 	   * should divide it by to get VCLK */
 	switch (freq) {
 	case 24751 ... 25249:
 		*div =3D 2;
-		DPRINTK ("Using VCLK =3D MCLK/2\n");
+		DPRINTK("Using VCLK =3D MCLK/2\n");
 		break;
 	case 49501 ... 50499:
 		*div =3D 1;
-		DPRINTK ("Using VCLK =3D MCLK\n");
+		DPRINTK("Using VCLK =3D MCLK\n");
 		break;
 	default:
 		*div =3D 0;
@@ -691,37 +683,42 @@ static int cirrusfb_check_var(struct fb_
 		den =3D 1;
 		break;		/* 4 bytes per pixel */
 	default:
-		printk ("cirrusfb: mode %dx%dx%d rejected...color depth=20
not supported.\n",
+		printk(KERN_ERR "cirrusfb: mode %dx%dx%d rejected..."
+			"color depth not supported.\n",
 			var->xres, var->yres, var->bits_per_pixel);
-		DPRINTK ("EXIT - EINVAL error\n");
+		DPRINTK("EXIT - EINVAL error\n");
 		return -EINVAL;
 	}
=20
 	if (var->xres * nom / den * var->yres > cinfo->size) {
-		printk ("cirrusfb: mode %dx%dx%d rejected...resolution=20
too high to fit into video memory!\n",
+		printk(KERN_ERR "cirrusfb: mode %dx%dx%d rejected..."
+			"resolution too high to fit into video memory!\n",
 			var->xres, var->yres, var->bits_per_pixel);
-		DPRINTK ("EXIT - EINVAL error\n");
+		DPRINTK("EXIT - EINVAL error\n");
 		return -EINVAL;
 	}
=20
 	/* use highest possible virtual resolution */
 	if (var->xres_virtual =3D=3D -1 &&
 	    var->yres_virtual =3D=3D -1) {
-		printk ("cirrusfb: using maximum available virtual=20
resolution\n");
+		printk(KERN_INFO
+		     "cirrusfb: using maximum available virtual=20
resolution\n");
 		for (i =3D 0; modes[i].xres !=3D -1; i++) {
 			if (modes[i].xres * nom / den * modes[i].yres <=20
cinfo->size / 2)
 				break;
 		}
 		if (modes[i].xres =3D=3D -1) {
-			printk ("cirrusfb: could not find a virtual=20
resolution that fits into video memory!!\n");
-			DPRINTK ("EXIT - EINVAL error\n");
+			printk(KERN_ERR "cirrusfb: could not find a virtual "
+				"resolution that fits into video memory!!\n");
+			DPRINTK("EXIT - EINVAL error\n");
 			return -EINVAL;
 		}
 		var->xres_virtual =3D modes[i].xres;
 		var->yres_virtual =3D modes[i].yres;
=20
-		printk ("cirrusfb: virtual resolution set to maximum of=20
%dx%d\n",
-			var->xres_virtual, var->yres_virtual);
+		printk(KERN_INFO "cirrusfb: virtual resolution set to "
+			"maximum of %dx%d\n", var->xres_virtual,
+			var->yres_virtual);
 	}
=20
 	if (var->xres_virtual < var->xres)
@@ -760,7 +757,7 @@ static int cirrusfb_check_var(struct fb_
 		break;
=20
 	case 16:
-		if(isPReP) {
+		if (isPReP) {
 			var->red.offset =3D 2;
 			var->green.offset =3D -3;
 			var->blue.offset =3D 8;
@@ -775,7 +772,7 @@ static int cirrusfb_check_var(struct fb_
 		break;
=20
 	case 24:
-		if(isPReP) {
+		if (isPReP) {
 			var->red.offset =3D 8;
 			var->green.offset =3D 16;
 			var->blue.offset =3D 24;
@@ -790,7 +787,7 @@ static int cirrusfb_check_var(struct fb_
 		break;
=20
 	case 32:
-		if(isPReP) {
+		if (isPReP) {
 			var->red.offset =3D 8;
 			var->green.offset =3D 16;
 			var->blue.offset =3D 24;
@@ -825,15 +822,16 @@ static int cirrusfb_check_var(struct fb_
 		yres =3D (yres + 1) / 2;
=20
 	if (yres >=3D 1280) {
-		printk (KERN_WARNING "cirrusfb: ERROR: VerticalTotal >=3D=20
1280; special treatment required! (TODO)\n");
-		DPRINTK ("EXIT - EINVAL error\n");
+		printk(KERN_ERR "cirrusfb: ERROR: VerticalTotal >=3D 1280;=20
"
+			"special treatment required! (TODO)\n");
+		DPRINTK("EXIT - EINVAL error\n");
 		return -EINVAL;
 	}
=20
 	return 0;
 }
=20
-static int cirrusfb_decode_var (const struct fb_var_screeninfo=20
*var,
+static int cirrusfb_decode_var(const struct fb_var_screeninfo=20
*var,
 				struct cirrusfb_regs *regs,
 				const struct fb_info *info)
 {
@@ -844,7 +842,7 @@ static int cirrusfb_decode_var (const st
 	int xres, hfront, hsync, hback;
 	int yres, vfront, vsync, vback;
=20
-	switch(var->bits_per_pixel) {
+	switch (var->bits_per_pixel) {
 	case 1:
 		regs->line_length =3D var->xres_virtual / 8;
 		regs->visual =3D FB_VISUAL_MONO10;
@@ -887,7 +885,7 @@ static int cirrusfb_decode_var (const st
 	/* convert from ps to kHz */
 	freq =3D 1000000000 / var->pixclock;
=20
-	DPRINTK ("desired pixclock: %ld kHz\n", freq);
+	DPRINTK("desired pixclock: %ld kHz\n", freq);
=20
 	maxclock =3D cirrusfb_board_info[cinfo->btype].
maxclock[maxclockidx];
 	regs->multiplexing =3D 0;
@@ -902,8 +900,9 @@ static int cirrusfb_decode_var (const st
 			break;
=20
 		default:
-			printk (KERN_WARNING "cirrusfb: ERROR: Frequency=20
greater than maxclock (%ld kHz)\n", maxclock);
-			DPRINTK ("EXIT - return -EINVAL\n");
+			printk(KERN_ERR "cirrusfb: Frequency greater "
+				"than maxclock (%ld kHz)\n", maxclock);
+			DPRINTK("EXIT - return -EINVAL\n");
 			return -EINVAL;
 		}
 	}
@@ -914,14 +913,16 @@ static int cirrusfb_decode_var (const st
 	case 16:
 	case 32:
 		if (regs->HorizRes <=3D 800)
-			freq /=3D 2;	/* Xbh has this type of clock for=20
32-bit */
+			/* Xbh has this type of clock for 32-bit */
+			freq /=3D 2;
 		break;
 	}
 #endif
=20
-	bestclock (freq, &regs->freq, &regs->nom, &regs->den,=20
&regs->div,
-		   maxclock);
-	regs->mclk =3D cirrusfb_get_mclk (freq, var->bits_per_pixel,=20
&regs->divMCLK);
+	bestclock(freq, &regs->freq, &regs->nom, &regs->den,=20
&regs->div,
+		  maxclock);
+	regs->mclk =3D cirrusfb_get_mclk(freq, var->bits_per_pixel,
+					&regs->divMCLK);
=20
 	xres =3D var->xres;
 	hfront =3D var->right_margin;
@@ -948,7 +949,8 @@ static int cirrusfb_decode_var (const st
 	regs->HorizTotal =3D (xres + hfront + hsync + hback) / 8 - 5;
 	regs->HorizDispEnd =3D xres / 8 - 1;
 	regs->HorizBlankStart =3D xres / 8;
-	regs->HorizBlankEnd =3D regs->HorizTotal + 5;	/* does not=20
count with "-5" */
+	/* does not count with "-5" */
+	regs->HorizBlankEnd =3D regs->HorizTotal + 5;
 	regs->HorizSyncStart =3D (xres + hfront) / 8 + 1;
 	regs->HorizSyncEnd =3D (xres + hfront + hsync) / 8 + 1;
=20
@@ -976,23 +978,23 @@ static int cirrusfb_decode_var (const st
 	return 0;
 }
=20
-
-static void cirrusfb_set_mclk (const struct cirrusfb_info=20
*cinfo, int val, int div)
+static void cirrusfb_set_mclk(const struct cirrusfb_info *cinfo,=20
int val,
+				int div)
 {
-	assert (cinfo !=3D NULL);
+	assert(cinfo !=3D NULL);
=20
 	if (div =3D=3D 2) {
 		/* VCLK =3D MCLK/2 */
-		unsigned char old =3D vga_rseq (cinfo->regbase, CL_SEQR1E)
;
-		vga_wseq (cinfo->regbase, CL_SEQR1E, old | 0x1);
-		vga_wseq (cinfo->regbase, CL_SEQR1F, 0x40 | (val & 0x3f)
);
+		unsigned char old =3D vga_rseq(cinfo->regbase, CL_SEQR1E);
+		vga_wseq(cinfo->regbase, CL_SEQR1E, old | 0x1);
+		vga_wseq(cinfo->regbase, CL_SEQR1F, 0x40 | (val & 0x3f))
;
 	} else if (div =3D=3D 1) {
 		/* VCLK =3D MCLK */
-		unsigned char old =3D vga_rseq (cinfo->regbase, CL_SEQR1E)
;
-		vga_wseq (cinfo->regbase, CL_SEQR1E, old & ~0x1);
-		vga_wseq (cinfo->regbase, CL_SEQR1F, 0x40 | (val & 0x3f)
);
+		unsigned char old =3D vga_rseq(cinfo->regbase, CL_SEQR1E);
+		vga_wseq(cinfo->regbase, CL_SEQR1E, old & ~0x1);
+		vga_wseq(cinfo->regbase, CL_SEQR1F, 0x40 | (val & 0x3f))
;
 	} else {
-		vga_wseq (cinfo->regbase, CL_SEQR1F, val & 0x3f);
+		vga_wseq(cinfo->regbase, CL_SEQR1F, val & 0x3f);
 	}
 }
=20
@@ -1001,7 +1003,7 @@ static void cirrusfb_set_mclk (const str
=20
 	actually writes the values for a new video mode into the=20
hardware,
=20
*****************************************************************
*********/
-static int cirrusfb_set_par_foo (struct fb_info *info)
+static int cirrusfb_set_par_foo(struct fb_info *info)
 {
 	struct cirrusfb_info *cinfo =3D info->par;
 	struct fb_var_screeninfo *var =3D &info->var;
@@ -1011,15 +1013,15 @@ static int cirrusfb_set_par_foo (struct=20
 	int offset =3D 0, err;
 	const struct cirrusfb_board_info_rec *bi;
=20
-	DPRINTK ("ENTER\n");
-	DPRINTK ("Requested mode: %dx%dx%d\n",
+	DPRINTK("ENTER\n");
+	DPRINTK("Requested mode: %dx%dx%d\n",
 	       var->xres, var->yres, var->bits_per_pixel);
-	DPRINTK ("pixclock: %d\n", var->pixclock);
+	DPRINTK("pixclock: %d\n", var->pixclock);
=20
-	init_vgachip (cinfo);
+	init_vgachip(cinfo);
=20
 	err =3D cirrusfb_decode_var(var, &regs, info);
-	if(err) {
+	if (err) {
 		/* should never happen */
 		DPRINTK("mode change aborted.  invalid var.\n");
 		return -EINVAL;
@@ -1027,34 +1029,35 @@ static int cirrusfb_set_par_foo (struct=20
=20
 	bi =3D &cirrusfb_board_info[cinfo->btype];
=20
-
 	/* unlock register VGA_CRTC_H_TOTAL..CRT7 */
-	vga_wcrt (regbase, VGA_CRTC_V_SYNC_END, 0x20);	/*=20
previously: 0x00) */
+	vga_wcrt(regbase, VGA_CRTC_V_SYNC_END, 0x20);	/*=20
previously: 0x00) */
=20
 	/* if debugging is enabled, all parameters get output=20
before writing */
-	DPRINTK ("CRT0: %ld\n", regs.HorizTotal);
-	vga_wcrt (regbase, VGA_CRTC_H_TOTAL, regs.HorizTotal);
+	DPRINTK("CRT0: %ld\n", regs.HorizTotal);
+	vga_wcrt(regbase, VGA_CRTC_H_TOTAL, regs.HorizTotal);
=20
-	DPRINTK ("CRT1: %ld\n", regs.HorizDispEnd);
-	vga_wcrt (regbase, VGA_CRTC_H_DISP, regs.HorizDispEnd);
+	DPRINTK("CRT1: %ld\n", regs.HorizDispEnd);
+	vga_wcrt(regbase, VGA_CRTC_H_DISP, regs.HorizDispEnd);
=20
-	DPRINTK ("CRT2: %ld\n", regs.HorizBlankStart);
-	vga_wcrt (regbase, VGA_CRTC_H_BLANK_START, regs.
HorizBlankStart);
+	DPRINTK("CRT2: %ld\n", regs.HorizBlankStart);
+	vga_wcrt(regbase, VGA_CRTC_H_BLANK_START, regs.
HorizBlankStart);
=20
-	DPRINTK ("CRT3: 128+%ld\n", regs.HorizBlankEnd % 32);
	/*  + 128: Compatible read */
-	vga_wcrt (regbase, VGA_CRTC_H_BLANK_END, 128 + (regs.
HorizBlankEnd % 32));
+	/*  + 128: Compatible read */
+	DPRINTK("CRT3: 128+%ld\n", regs.HorizBlankEnd % 32);
+	vga_wcrt(regbase, VGA_CRTC_H_BLANK_END,
+		 128 + (regs.HorizBlankEnd % 32));
=20
-	DPRINTK ("CRT4: %ld\n", regs.HorizSyncStart);
-	vga_wcrt (regbase, VGA_CRTC_H_SYNC_START, regs.
HorizSyncStart);
+	DPRINTK("CRT4: %ld\n", regs.HorizSyncStart);
+	vga_wcrt(regbase, VGA_CRTC_H_SYNC_START, regs.
HorizSyncStart);
=20
 	tmp =3D regs.HorizSyncEnd % 32;
 	if (regs.HorizBlankEnd & 32)
 		tmp +=3D 128;
-	DPRINTK ("CRT5: %d\n", tmp);
-	vga_wcrt (regbase, VGA_CRTC_H_SYNC_END, tmp);
+	DPRINTK("CRT5: %d\n", tmp);
+	vga_wcrt(regbase, VGA_CRTC_H_SYNC_END, tmp);
=20
-	DPRINTK ("CRT6: %ld\n", regs.VertTotal & 0xff);
-	vga_wcrt (regbase, VGA_CRTC_V_TOTAL, (regs.VertTotal &=20
0xff));
+	DPRINTK("CRT6: %ld\n", regs.VertTotal & 0xff);
+	vga_wcrt(regbase, VGA_CRTC_V_TOTAL, (regs.VertTotal & 0xff)
);
=20
 	tmp =3D 16;		/* LineCompare bit #9 */
 	if (regs.VertTotal & 256)
@@ -1071,34 +1074,34 @@ static int cirrusfb_set_par_foo (struct=20
 		tmp |=3D 64;
 	if (regs.VertSyncStart & 512)
 		tmp |=3D 128;
-	DPRINTK ("CRT7: %d\n", tmp);
-	vga_wcrt (regbase, VGA_CRTC_OVERFLOW, tmp);
+	DPRINTK("CRT7: %d\n", tmp);
+	vga_wcrt(regbase, VGA_CRTC_OVERFLOW, tmp);
=20
 	tmp =3D 0x40;		/* LineCompare bit #8 */
 	if (regs.VertBlankStart & 512)
 		tmp |=3D 0x20;
 	if (var->vmode & FB_VMODE_DOUBLE)
 		tmp |=3D 0x80;
-	DPRINTK ("CRT9: %d\n", tmp);
-	vga_wcrt (regbase, VGA_CRTC_MAX_SCAN, tmp);
+	DPRINTK("CRT9: %d\n", tmp);
+	vga_wcrt(regbase, VGA_CRTC_MAX_SCAN, tmp);
=20
-	DPRINTK ("CRT10: %ld\n", regs.VertSyncStart & 0xff);
-	vga_wcrt (regbase, VGA_CRTC_V_SYNC_START, (regs.
VertSyncStart & 0xff));
+	DPRINTK("CRT10: %ld\n", regs.VertSyncStart & 0xff);
+	vga_wcrt(regbase, VGA_CRTC_V_SYNC_START, regs.VertSyncStart=20
& 0xff);
=20
-	DPRINTK ("CRT11: 64+32+%ld\n", regs.VertSyncEnd % 16);
-	vga_wcrt (regbase, VGA_CRTC_V_SYNC_END, (regs.VertSyncEnd %=20
16 + 64 + 32));
+	DPRINTK("CRT11: 64+32+%ld\n", regs.VertSyncEnd % 16);
+	vga_wcrt(regbase, VGA_CRTC_V_SYNC_END, regs.VertSyncEnd %=20
16 + 64 + 32);
=20
-	DPRINTK ("CRT12: %ld\n", regs.VertDispEnd & 0xff);
-	vga_wcrt (regbase, VGA_CRTC_V_DISP_END, (regs.VertDispEnd &=20
0xff));
+	DPRINTK("CRT12: %ld\n", regs.VertDispEnd & 0xff);
+	vga_wcrt(regbase, VGA_CRTC_V_DISP_END, regs.VertDispEnd &=20
0xff);
=20
-	DPRINTK ("CRT15: %ld\n", regs.VertBlankStart & 0xff);
-	vga_wcrt (regbase, VGA_CRTC_V_BLANK_START, (regs.
VertBlankStart & 0xff));
+	DPRINTK("CRT15: %ld\n", regs.VertBlankStart & 0xff);
+	vga_wcrt(regbase, VGA_CRTC_V_BLANK_START, regs.
VertBlankStart & 0xff);
=20
-	DPRINTK ("CRT16: %ld\n", regs.VertBlankEnd & 0xff);
-	vga_wcrt (regbase, VGA_CRTC_V_BLANK_END, (regs.VertBlankEnd=20
& 0xff));
+	DPRINTK("CRT16: %ld\n", regs.VertBlankEnd & 0xff);
+	vga_wcrt(regbase, VGA_CRTC_V_BLANK_END, regs.VertBlankEnd &=20
0xff);
=20
-	DPRINTK ("CRT18: 0xff\n");
-	vga_wcrt (regbase, VGA_CRTC_LINE_COMPARE, 0xff);
+	DPRINTK("CRT18: 0xff\n");
+	vga_wcrt(regbase, VGA_CRTC_LINE_COMPARE, 0xff);
=20
 	tmp =3D 0;
 	if (var->vmode & FB_VMODE_INTERLACED)
@@ -1112,57 +1115,63 @@ static int cirrusfb_set_par_foo (struct=20
 	if (regs.VertBlankEnd & 512)
 		tmp |=3D 128;
=20
-	DPRINTK ("CRT1a: %d\n", tmp);
-	vga_wcrt (regbase, CL_CRT1A, tmp);
+	DPRINTK("CRT1a: %d\n", tmp);
+	vga_wcrt(regbase, CL_CRT1A, tmp);
=20
 	/* set VCLK0 */
 	/* hardware RefClock: 14.31818 MHz */
 	/* formula: VClk =3D (OSC * N) / (D * (1+P)) */
 	/* Example: VClk =3D (14.31818 * 91) / (23 * (1+1)) =3D 28.325=20
MHz */
=20
-	vga_wseq (regbase, CL_SEQRB, regs.nom);
+	vga_wseq(regbase, CL_SEQRB, regs.nom);
 	tmp =3D regs.den << 1;
 	if (regs.div !=3D 0)
 		tmp |=3D 1;
=20
+	/* 6 bit denom; ONLY 5434!!! (bugged me 10 days) */
 	if ((cinfo->btype =3D=3D BT_SD64) ||
 	    (cinfo->btype =3D=3D BT_ALPINE) ||
 	    (cinfo->btype =3D=3D BT_GD5480))
-		tmp |=3D 0x80;	/* 6 bit denom; ONLY 5434!!! (bugged me=20
10 days) */
+		tmp |=3D 0x80;
=20
-	DPRINTK ("CL_SEQR1B: %ld\n", (long) tmp);
-	vga_wseq (regbase, CL_SEQR1B, tmp);
+	DPRINTK("CL_SEQR1B: %ld\n", (long) tmp);
+	vga_wseq(regbase, CL_SEQR1B, tmp);
=20
 	if (regs.VertRes >=3D 1024)
 		/* 1280x1024 */
-		vga_wcrt (regbase, VGA_CRTC_MODE, 0xc7);
+		vga_wcrt(regbase, VGA_CRTC_MODE, 0xc7);
 	else
 		/* mode control: VGA_CRTC_START_HI enable, ROTATE(?),=20
16bit
 		 * address wrap, no compat. */
-		vga_wcrt (regbase, VGA_CRTC_MODE, 0xc3);
+		vga_wcrt(regbase, VGA_CRTC_MODE, 0xc3);
=20
-/* HAEH?        vga_wcrt (regbase, VGA_CRTC_V_SYNC_END, 0x20); =20
* previously: 0x00  unlock VGA_CRTC_H_TOTAL..CRT7 */
+/* HAEH?	vga_wcrt(regbase, VGA_CRTC_V_SYNC_END, 0x20);
+ * previously: 0x00  unlock VGA_CRTC_H_TOTAL..CRT7 */
=20
 	/* don't know if it would hurt to also program this if no=20
interlaced */
 	/* mode is used, but I feel better this way.. :-) */
 	if (var->vmode & FB_VMODE_INTERLACED)
-		vga_wcrt (regbase, VGA_CRTC_REGS, regs.HorizTotal / 2);
+		vga_wcrt(regbase, VGA_CRTC_REGS, regs.HorizTotal / 2);
 	else
-		vga_wcrt (regbase, VGA_CRTC_REGS, 0x00);	/*=20
interlace control */
+		vga_wcrt(regbase, VGA_CRTC_REGS, 0x00);	/* interlace=20
control */
=20
-	vga_wseq (regbase, VGA_SEQ_CHARACTER_MAP, 0);
+	vga_wseq(regbase, VGA_SEQ_CHARACTER_MAP, 0);
=20
 	/* adjust horizontal/vertical sync type (low/high) */
-	tmp =3D 0x03;		/* enable display memory & CRTC I/O=20
address for color mode */
+	/* enable display memory & CRTC I/O address for color mode=20
*/
+	tmp =3D 0x03;
 	if (var->sync & FB_SYNC_HOR_HIGH_ACT)
 		tmp |=3D 0x40;
 	if (var->sync & FB_SYNC_VERT_HIGH_ACT)
 		tmp |=3D 0x80;
-	WGen (cinfo, VGA_MIS_W, tmp);
+	WGen(cinfo, VGA_MIS_W, tmp);
=20
-	vga_wcrt (regbase, VGA_CRTC_PRESET_ROW, 0);	/* Screen A=20
Preset Row-Scan register */
-	vga_wcrt (regbase, VGA_CRTC_CURSOR_START, 0);	/* text=20
cursor on and start line */
-	vga_wcrt (regbase, VGA_CRTC_CURSOR_END, 31);	/* text=20
cursor end line */
+	/* Screen A Preset Row-Scan register */
+	vga_wcrt(regbase, VGA_CRTC_PRESET_ROW, 0);
+	/* text cursor on and start line */
+	vga_wcrt(regbase, VGA_CRTC_CURSOR_START, 0);
+	/* text cursor end line */
+	vga_wcrt(regbase, VGA_CRTC_CURSOR_END, 31);
=20
 	/******************************************************
 	 *
@@ -1172,8 +1181,8 @@ static int cirrusfb_set_par_foo (struct=20
=20
 	/* programming for different color depths */
 	if (var->bits_per_pixel =3D=3D 1) {
-		DPRINTK ("cirrusfb: preparing for 1 bit deep display\n")
;
-		vga_wgfx (regbase, VGA_GFX_MODE, 0);	/* mode=20
register */
+		DPRINTK("cirrusfb: preparing for 1 bit deep display\n");
+		vga_wgfx(regbase, VGA_GFX_MODE, 0);	/* mode register=20
*/
=20
 		/* SR07 */
 		switch (cinfo->btype) {
@@ -1184,71 +1193,85 @@ static int cirrusfb_set_par_foo (struct=20
 		case BT_PICASSO4:
 		case BT_ALPINE:
 		case BT_GD5480:
-			DPRINTK (" (for GD54xx)\n");
-			vga_wseq (regbase, CL_SEQR7,
+			DPRINTK(" (for GD54xx)\n");
+			vga_wseq(regbase, CL_SEQR7,
 				  regs.multiplexing ?
 					bi->sr07_1bpp_mux : bi->sr07_1bpp);
 			break;
=20
 		case BT_LAGUNA:
-			DPRINTK (" (for GD546x)\n");
-			vga_wseq (regbase, CL_SEQR7,
-				vga_rseq (regbase, CL_SEQR7) & ~0x01);
+			DPRINTK(" (for GD546x)\n");
+			vga_wseq(regbase, CL_SEQR7,
+				vga_rseq(regbase, CL_SEQR7) & ~0x01);
 			break;
=20
 		default:
-			printk (KERN_WARNING "cirrusfb: unknown Board\n");
+			printk(KERN_WARNING "cirrusfb: unknown Board\n");
 			break;
 		}
=20
 		/* Extended Sequencer Mode */
 		switch (cinfo->btype) {
 		case BT_SD64:
-			/* setting the SEQRF on SD64 is not necessary (only=20
during init) */
-			DPRINTK ("(for SD64)\n");
-			vga_wseq (regbase, CL_SEQR1F, 0x1a);		/*  MCLK=20
select */
+			/* setting the SEQRF on SD64 is not necessary
+			 * (only during init)
+			 */
+			DPRINTK("(for SD64)\n");
+			/*  MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x1a);
 			break;
=20
 		case BT_PICCOLO:
-			DPRINTK ("(for Piccolo)\n");
-/* ### ueberall 0x22? */
-			vga_wseq (regbase, CL_SEQR1F, 0x22);		/*=20
##vorher 1c MCLK select */
-			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* evtl d0=20
bei 1 bit? avoid FIFO underruns..? */
+			DPRINTK("(for Piccolo)\n");
+			/* ### ueberall 0x22? */
+			/* ##vorher 1c MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x22);
+			/* evtl d0 bei 1 bit? avoid FIFO underruns..? */
+			vga_wseq(regbase, CL_SEQRF, 0xb0);
 			break;
=20
 		case BT_PICASSO:
-			DPRINTK ("(for Picasso)\n");
-			vga_wseq (regbase, CL_SEQR1F, 0x22);		/*=20
##vorher 22 MCLK select */
-			vga_wseq (regbase, CL_SEQRF, 0xd0);	/* ## vorher=20
d0 avoid FIFO underruns..? */
+			DPRINTK("(for Picasso)\n");
+			/* ##vorher 22 MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x22);
+			/* ## vorher d0 avoid FIFO underruns..? */
+			vga_wseq(regbase, CL_SEQRF, 0xd0);
 			break;
=20
 		case BT_SPECTRUM:
-			DPRINTK ("(for Spectrum)\n");
-/* ### ueberall 0x22? */
-			vga_wseq (regbase, CL_SEQR1F, 0x22);		/*=20
##vorher 1c MCLK select */
-			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* evtl d0?=20
avoid FIFO underruns..? */
+			DPRINTK("(for Spectrum)\n");
+			/* ### ueberall 0x22? */
+			/* ##vorher 1c MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x22);
+			/* evtl d0? avoid FIFO underruns..? */
+			vga_wseq(regbase, CL_SEQRF, 0xb0);
 			break;
=20
 		case BT_PICASSO4:
 		case BT_ALPINE:
 		case BT_GD5480:
 		case BT_LAGUNA:
-			DPRINTK (" (for GD54xx)\n");
+			DPRINTK(" (for GD54xx)\n");
 			/* do nothing */
 			break;
=20
 		default:
-			printk (KERN_WARNING "cirrusfb: unknown Board\n");
+			printk(KERN_WARNING "cirrusfb: unknown Board\n");
 			break;
 		}
=20
-		WGen (cinfo, VGA_PEL_MSK, 0x01);	/* pixel mask:=20
pass-through for first plane */
+		/* pixel mask: pass-through for first plane */
+		WGen(cinfo, VGA_PEL_MSK, 0x01);
 		if (regs.multiplexing)
-			WHDR (cinfo, 0x4a);	/* hidden dac reg: 1280x1024=20
*/
+			/* hidden dac reg: 1280x1024 */
+			WHDR(cinfo, 0x4a);
 		else
-			WHDR (cinfo, 0);	/* hidden dac: nothing */
-		vga_wseq (regbase, VGA_SEQ_MEMORY_MODE, 0x06);	/*=20
memory mode: odd/even, ext. memory */
-		vga_wseq (regbase, VGA_SEQ_PLANE_WRITE, 0x01);	/*=20
plane mask: only write to first plane */
+			/* hidden dac: nothing */
+			WHDR(cinfo, 0);
+		/* memory mode: odd/even, ext. memory */
+		vga_wseq(regbase, VGA_SEQ_MEMORY_MODE, 0x06);
+		/* plane mask: only write to first plane */
+		vga_wseq(regbase, VGA_SEQ_PLANE_WRITE, 0x01);
 		offset =3D var->xres_virtual / 16;
 	}
=20
@@ -1259,7 +1282,7 @@ static int cirrusfb_set_par_foo (struct=20
 	 */
=20
 	else if (var->bits_per_pixel =3D=3D 8) {
-		DPRINTK ("cirrusfb: preparing for 8 bit deep display\n")
;
+		DPRINTK("cirrusfb: preparing for 8 bit deep display\n");
 		switch (cinfo->btype) {
 		case BT_SD64:
 		case BT_PICCOLO:
@@ -1268,75 +1291,89 @@ static int cirrusfb_set_par_foo (struct=20
 		case BT_PICASSO4:
 		case BT_ALPINE:
 		case BT_GD5480:
-			DPRINTK (" (for GD54xx)\n");
-			vga_wseq (regbase, CL_SEQR7,
+			DPRINTK(" (for GD54xx)\n");
+			vga_wseq(regbase, CL_SEQR7,
 				  regs.multiplexing ?
 					bi->sr07_8bpp_mux : bi->sr07_8bpp);
 			break;
=20
 		case BT_LAGUNA:
-			DPRINTK (" (for GD546x)\n");
-			vga_wseq (regbase, CL_SEQR7,
-				vga_rseq (regbase, CL_SEQR7) | 0x01);
+			DPRINTK(" (for GD546x)\n");
+			vga_wseq(regbase, CL_SEQR7,
+				vga_rseq(regbase, CL_SEQR7) | 0x01);
 			break;
=20
 		default:
-			printk (KERN_WARNING "cirrusfb: unknown Board\n");
+			printk(KERN_WARNING "cirrusfb: unknown Board\n");
 			break;
 		}
=20
 		switch (cinfo->btype) {
 		case BT_SD64:
-			vga_wseq (regbase, CL_SEQR1F, 0x1d);		/* MCLK=20
select */
+			/* MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x1d);
 			break;
=20
 		case BT_PICCOLO:
-			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* ###=20
vorher 1c MCLK select */
-			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast=20
Page-Mode writes */
+			/* ### vorher 1c MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x22);
+			/* Fast Page-Mode writes */
+			vga_wseq(regbase, CL_SEQRF, 0xb0);
 			break;
=20
 		case BT_PICASSO:
-			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* ###=20
vorher 1c MCLK select */
-			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast=20
Page-Mode writes */
+			/* ### vorher 1c MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x22);
+			/* Fast Page-Mode writes */
+			vga_wseq(regbase, CL_SEQRF, 0xb0);
 			break;
=20
 		case BT_SPECTRUM:
-			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* ###=20
vorher 1c MCLK select */
-			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast=20
Page-Mode writes */
+			/* ### vorher 1c MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x22);
+			/* Fast Page-Mode writes */
+			vga_wseq(regbase, CL_SEQRF, 0xb0);
 			break;
=20
 		case BT_PICASSO4:
 #ifdef CONFIG_ZORRO
-			vga_wseq (regbase, CL_SEQRF, 0xb8);	/* ###=20
INCOMPLETE!! */
+			/* ### INCOMPLETE!! */
+			vga_wseq(regbase, CL_SEQRF, 0xb8);
 #endif
-/*          vga_wseq (regbase, CL_SEQR1F, 0x1c); */
+/*	  		vga_wseq(regbase, CL_SEQR1F, 0x1c); */
 			break;
=20
 		case BT_ALPINE:
-			DPRINTK (" (for GD543x)\n");
-			cirrusfb_set_mclk (cinfo, regs.mclk, regs.divMCLK);
+			DPRINTK(" (for GD543x)\n");
+			cirrusfb_set_mclk(cinfo, regs.mclk, regs.divMCLK);
 			/* We already set SRF and SR1F */
 			break;
=20
 		case BT_GD5480:
 		case BT_LAGUNA:
-			DPRINTK (" (for GD54xx)\n");
+			DPRINTK(" (for GD54xx)\n");
 			/* do nothing */
 			break;
=20
 		default:
-			printk (KERN_WARNING "cirrusfb: unknown Board\n");
+			printk(KERN_WARNING "cirrusfb: unknown Board\n");
 			break;
 		}
=20
-		vga_wgfx (regbase, VGA_GFX_MODE, 64);	/* mode=20
register: 256 color mode */
-		WGen (cinfo, VGA_PEL_MSK, 0xff);	/* pixel mask:=20
pass-through all planes */
+		/* mode register: 256 color mode */
+		vga_wgfx(regbase, VGA_GFX_MODE, 64);
+		/* pixel mask: pass-through all planes */
+		WGen(cinfo, VGA_PEL_MSK, 0xff);
 		if (regs.multiplexing)
-			WHDR (cinfo, 0x4a);	/* hidden dac reg: 1280x1024=20
*/
+			/* hidden dac reg: 1280x1024 */
+			WHDR(cinfo, 0x4a);
 		else
-			WHDR (cinfo, 0);	/* hidden dac: nothing */
-		vga_wseq (regbase, VGA_SEQ_MEMORY_MODE, 0x0a);	/*=20
memory mode: chain4, ext. memory */
-		vga_wseq (regbase, VGA_SEQ_PLANE_WRITE, 0xff);	/*=20
plane mask: enable writing to all 4 planes */
+			/* hidden dac: nothing */
+			WHDR(cinfo, 0);
+		/* memory mode: chain4, ext. memory */
+		vga_wseq(regbase, VGA_SEQ_MEMORY_MODE, 0x0a);
+		/* plane mask: enable writing to all 4 planes */
+		vga_wseq(regbase, VGA_SEQ_PLANE_WRITE, 0xff);
 		offset =3D var->xres_virtual / 8;
 	}
=20
@@ -1347,72 +1384,84 @@ static int cirrusfb_set_par_foo (struct=20
 	 */
=20
 	else if (var->bits_per_pixel =3D=3D 16) {
-		DPRINTK ("cirrusfb: preparing for 16 bit deep=20
display\n");
+		DPRINTK("cirrusfb: preparing for 16 bit deep display\n")
;
 		switch (cinfo->btype) {
 		case BT_SD64:
-			vga_wseq (regbase, CL_SEQR7, 0xf7);	/* Extended=20
Sequencer Mode: 256c col. mode */
-			vga_wseq (regbase, CL_SEQR1F, 0x1e);		/* MCLK=20
select */
+			/* Extended Sequencer Mode: 256c col. mode */
+			vga_wseq(regbase, CL_SEQR7, 0xf7);
+			/* MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x1e);
 			break;
=20
 		case BT_PICCOLO:
-			vga_wseq (regbase, CL_SEQR7, 0x87);
-			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast=20
Page-Mode writes */
-			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* MCLK=20
select */
+			vga_wseq(regbase, CL_SEQR7, 0x87);
+			/* Fast Page-Mode writes */
+			vga_wseq(regbase, CL_SEQRF, 0xb0);
+			/* MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x22);
 			break;
=20
 		case BT_PICASSO:
-			vga_wseq (regbase, CL_SEQR7, 0x27);
-			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast=20
Page-Mode writes */
-			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* MCLK=20
select */
+			vga_wseq(regbase, CL_SEQR7, 0x27);
+			/* Fast Page-Mode writes */
+			vga_wseq(regbase, CL_SEQRF, 0xb0);
+			/* MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x22);
 			break;
=20
 		case BT_SPECTRUM:
-			vga_wseq (regbase, CL_SEQR7, 0x87);
-			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast=20
Page-Mode writes */
-			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* MCLK=20
select */
+			vga_wseq(regbase, CL_SEQR7, 0x87);
+			/* Fast Page-Mode writes */
+			vga_wseq(regbase, CL_SEQRF, 0xb0);
+			/* MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x22);
 			break;
=20
 		case BT_PICASSO4:
-			vga_wseq (regbase, CL_SEQR7, 0x27);
-/*          vga_wseq (regbase, CL_SEQR1F, 0x1c);  */
+			vga_wseq(regbase, CL_SEQR7, 0x27);
+/*			vga_wseq(regbase, CL_SEQR1F, 0x1c);  */
 			break;
=20
 		case BT_ALPINE:
-			DPRINTK (" (for GD543x)\n");
+			DPRINTK(" (for GD543x)\n");
 			if (regs.HorizRes >=3D 1024)
-				vga_wseq (regbase, CL_SEQR7, 0xa7);
+				vga_wseq(regbase, CL_SEQR7, 0xa7);
 			else
-				vga_wseq (regbase, CL_SEQR7, 0xa3);
-			cirrusfb_set_mclk (cinfo, regs.mclk, regs.divMCLK);
+				vga_wseq(regbase, CL_SEQR7, 0xa3);
+			cirrusfb_set_mclk(cinfo, regs.mclk, regs.divMCLK);
 			break;
=20
 		case BT_GD5480:
-			DPRINTK (" (for GD5480)\n");
-			vga_wseq (regbase, CL_SEQR7, 0x17);
+			DPRINTK(" (for GD5480)\n");
+			vga_wseq(regbase, CL_SEQR7, 0x17);
 			/* We already set SRF and SR1F */
 			break;
=20
 		case BT_LAGUNA:
-			DPRINTK (" (for GD546x)\n");
-			vga_wseq (regbase, CL_SEQR7,
-				vga_rseq (regbase, CL_SEQR7) & ~0x01);
+			DPRINTK(" (for GD546x)\n");
+			vga_wseq(regbase, CL_SEQR7,
+				vga_rseq(regbase, CL_SEQR7) & ~0x01);
 			break;
=20
 		default:
-			printk (KERN_WARNING "CIRRUSFB: unknown Board\n");
+			printk(KERN_WARNING "CIRRUSFB: unknown Board\n");
 			break;
 		}
=20
-		vga_wgfx (regbase, VGA_GFX_MODE, 64);	/* mode=20
register: 256 color mode */
-		WGen (cinfo, VGA_PEL_MSK, 0xff);	/* pixel mask:=20
pass-through all planes */
+		/* mode register: 256 color mode */
+		vga_wgfx(regbase, VGA_GFX_MODE, 64);
+		/* pixel mask: pass-through all planes */
+		WGen(cinfo, VGA_PEL_MSK, 0xff);
 #ifdef CONFIG_PCI
-		WHDR (cinfo, 0xc0);	/* Copy Xbh */
+		WHDR(cinfo, 0xc0);	/* Copy Xbh */
 #elif defined(CONFIG_ZORRO)
 		/* FIXME: CONFIG_PCI and CONFIG_ZORRO may be defined=20
both */
-		WHDR (cinfo, 0xa0);	/* hidden dac reg: nothing=20
special */
+		WHDR(cinfo, 0xa0);	/* hidden dac reg: nothing=20
special */
 #endif
-		vga_wseq (regbase, VGA_SEQ_MEMORY_MODE, 0x0a);	/*=20
memory mode: chain4, ext. memory */
-		vga_wseq (regbase, VGA_SEQ_PLANE_WRITE, 0xff);	/*=20
plane mask: enable writing to all 4 planes */
+		/* memory mode: chain4, ext. memory */
+		vga_wseq(regbase, VGA_SEQ_MEMORY_MODE, 0x0a);
+		/* plane mask: enable writing to all 4 planes */
+		vga_wseq(regbase, VGA_SEQ_PLANE_WRITE, 0xff);
 		offset =3D var->xres_virtual / 4;
 	}
=20
@@ -1423,64 +1472,77 @@ static int cirrusfb_set_par_foo (struct=20
 	 */
=20
 	else if (var->bits_per_pixel =3D=3D 32) {
-		DPRINTK ("cirrusfb: preparing for 24/32 bit deep=20
display\n");
+		DPRINTK("cirrusfb: preparing for 24/32 bit deep=20
display\n");
 		switch (cinfo->btype) {
 		case BT_SD64:
-			vga_wseq (regbase, CL_SEQR7, 0xf9);	/* Extended=20
Sequencer Mode: 256c col. mode */
-			vga_wseq (regbase, CL_SEQR1F, 0x1e);		/* MCLK=20
select */
+			/* Extended Sequencer Mode: 256c col. mode */
+			vga_wseq(regbase, CL_SEQR7, 0xf9);
+			/* MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x1e);
 			break;
=20
 		case BT_PICCOLO:
-			vga_wseq (regbase, CL_SEQR7, 0x85);
-			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast=20
Page-Mode writes */
-			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* MCLK=20
select */
+			vga_wseq(regbase, CL_SEQR7, 0x85);
+			/* Fast Page-Mode writes */
+			vga_wseq(regbase, CL_SEQRF, 0xb0);
+			/* MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x22);
 			break;
=20
 		case BT_PICASSO:
-			vga_wseq (regbase, CL_SEQR7, 0x25);
-			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast=20
Page-Mode writes */
-			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* MCLK=20
select */
+			vga_wseq(regbase, CL_SEQR7, 0x25);
+			/* Fast Page-Mode writes */
+			vga_wseq(regbase, CL_SEQRF, 0xb0);
+			/* MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x22);
 			break;
=20
 		case BT_SPECTRUM:
-			vga_wseq (regbase, CL_SEQR7, 0x85);
-			vga_wseq (regbase, CL_SEQRF, 0xb0);	/* Fast=20
Page-Mode writes */
-			vga_wseq (regbase, CL_SEQR1F, 0x22);		/* MCLK=20
select */
+			vga_wseq(regbase, CL_SEQR7, 0x85);
+			/* Fast Page-Mode writes */
+			vga_wseq(regbase, CL_SEQRF, 0xb0);
+			/* MCLK select */
+			vga_wseq(regbase, CL_SEQR1F, 0x22);
 			break;
=20
 		case BT_PICASSO4:
-			vga_wseq (regbase, CL_SEQR7, 0x25);
-/*          vga_wseq (regbase, CL_SEQR1F, 0x1c);  */
+			vga_wseq(regbase, CL_SEQR7, 0x25);
+/*			vga_wseq(regbase, CL_SEQR1F, 0x1c);  */
 			break;
=20
 		case BT_ALPINE:
-			DPRINTK (" (for GD543x)\n");
-			vga_wseq (regbase, CL_SEQR7, 0xa9);
-			cirrusfb_set_mclk (cinfo, regs.mclk, regs.divMCLK);
+			DPRINTK(" (for GD543x)\n");
+			vga_wseq(regbase, CL_SEQR7, 0xa9);
+			cirrusfb_set_mclk(cinfo, regs.mclk, regs.divMCLK);
 			break;
=20
 		case BT_GD5480:
-			DPRINTK (" (for GD5480)\n");
-			vga_wseq (regbase, CL_SEQR7, 0x19);
+			DPRINTK(" (for GD5480)\n");
+			vga_wseq(regbase, CL_SEQR7, 0x19);
 			/* We already set SRF and SR1F */
 			break;
=20
 		case BT_LAGUNA:
-			DPRINTK (" (for GD546x)\n");
-			vga_wseq (regbase, CL_SEQR7,
-				vga_rseq (regbase, CL_SEQR7) & ~0x01);
+			DPRINTK(" (for GD546x)\n");
+			vga_wseq(regbase, CL_SEQR7,
+				vga_rseq(regbase, CL_SEQR7) & ~0x01);
 			break;
=20
 		default:
-			printk (KERN_WARNING "cirrusfb: unknown Board\n");
+			printk(KERN_WARNING "cirrusfb: unknown Board\n");
 			break;
 		}
=20
-		vga_wgfx (regbase, VGA_GFX_MODE, 64);	/* mode=20
register: 256 color mode */
-		WGen (cinfo, VGA_PEL_MSK, 0xff);	/* pixel mask:=20
pass-through all planes */
-		WHDR (cinfo, 0xc5);	/* hidden dac reg: 8-8-8 mode=20
(24 or 32) */
-		vga_wseq (regbase, VGA_SEQ_MEMORY_MODE, 0x0a);	/*=20
memory mode: chain4, ext. memory */
-		vga_wseq (regbase, VGA_SEQ_PLANE_WRITE, 0xff);	/*=20
plane mask: enable writing to all 4 planes */
+		/* mode register: 256 color mode */
+		vga_wgfx(regbase, VGA_GFX_MODE, 64);
+		/* pixel mask: pass-through all planes */
+		WGen(cinfo, VGA_PEL_MSK, 0xff);
+		/* hidden dac reg: 8-8-8 mode (24 or 32) */
+		WHDR(cinfo, 0xc5);
+		/* memory mode: chain4, ext. memory */
+		vga_wseq(regbase, VGA_SEQ_MEMORY_MODE, 0x0a);
+		/* plane mask: enable writing to all 4 planes */
+		vga_wseq(regbase, VGA_SEQ_PLANE_WRITE, 0xff);
 		offset =3D var->xres_virtual / 4;
 	}
=20
@@ -1490,48 +1552,67 @@ static int cirrusfb_set_par_foo (struct=20
 	 *
 	 */
=20
-	else {
-		printk (KERN_ERR "cirrusfb: What's this?? requested=20
color depth =3D=3D %d.\n",
+	else
+		printk(KERN_ERR "cirrusfb: What's this?? "
+			" requested color depth =3D=3D %d.\n",
 			var->bits_per_pixel);
-	}
=20
-	vga_wcrt (regbase, VGA_CRTC_OFFSET, offset & 0xff);
+	vga_wcrt(regbase, VGA_CRTC_OFFSET, offset & 0xff);
 	tmp =3D 0x22;
 	if (offset & 0x100)
 		tmp |=3D 0x10;	/* offset overflow bit */
=20
-	vga_wcrt (regbase, CL_CRT1B, tmp);	/* screen start addr=20
#16-18, fastpagemode cycles */
+	/* screen start addr #16-18, fastpagemode cycles */
+	vga_wcrt(regbase, CL_CRT1B, tmp);
=20
 	if (cinfo->btype =3D=3D BT_SD64 ||
 	    cinfo->btype =3D=3D BT_PICASSO4 ||
 	    cinfo->btype =3D=3D BT_ALPINE ||
 	    cinfo->btype =3D=3D BT_GD5480)
-		vga_wcrt (regbase, CL_CRT1D, 0x00);	/* screen start=20
address bit 19 */
+		/* screen start address bit 19 */
+		vga_wcrt(regbase, CL_CRT1D, 0x00);
=20
-	vga_wcrt (regbase, VGA_CRTC_CURSOR_HI, 0);	/* text=20
cursor location high */
-	vga_wcrt (regbase, VGA_CRTC_CURSOR_LO, 0);	/* text=20
cursor location low */
-	vga_wcrt (regbase, VGA_CRTC_UNDERLINE, 0);	/* underline=20
row scanline =3D at very bottom */
-
-	vga_wattr (regbase, VGA_ATC_MODE, 1);	/* controller=20
mode */
-	vga_wattr (regbase, VGA_ATC_OVERSCAN, 0);		/*=20
overscan (border) color */
-	vga_wattr (regbase, VGA_ATC_PLANE_ENABLE, 15);	/* color=20
plane enable */
-	vga_wattr (regbase, CL_AR33, 0);	/* pixel panning */
-	vga_wattr (regbase, VGA_ATC_COLOR_PAGE, 0);	/* color=20
select */
+	/* text cursor location high */
+	vga_wcrt(regbase, VGA_CRTC_CURSOR_HI, 0);
+	/* text cursor location low */
+	vga_wcrt(regbase, VGA_CRTC_CURSOR_LO, 0);
+	/* underline row scanline =3D at very bottom */
+	vga_wcrt(regbase, VGA_CRTC_UNDERLINE, 0);
+
+	/* controller mode */
+	vga_wattr(regbase, VGA_ATC_MODE, 1);
+	/* overscan (border) color */
+	vga_wattr(regbase, VGA_ATC_OVERSCAN, 0);
+	/* color plane enable */
+	vga_wattr(regbase, VGA_ATC_PLANE_ENABLE, 15);
+	/* pixel panning */
+	vga_wattr(regbase, CL_AR33, 0);
+	/* color select */
+	vga_wattr(regbase, VGA_ATC_COLOR_PAGE, 0);
=20
 	/* [ EGS: SetOffset(); ] */
 	/* From SetOffset(): Turn on VideoEnable bit in Attribute=20
controller */
-	AttrOn (cinfo);
+	AttrOn(cinfo);
=20
-	vga_wgfx (regbase, VGA_GFX_SR_VALUE, 0);	/* set/reset=20
register */
-	vga_wgfx (regbase, VGA_GFX_SR_ENABLE, 0);		/*=20
set/reset enable */
-	vga_wgfx (regbase, VGA_GFX_COMPARE_VALUE, 0);	/* color=20
compare */
-	vga_wgfx (regbase, VGA_GFX_DATA_ROTATE, 0);	/* data=20
rotate */
-	vga_wgfx (regbase, VGA_GFX_PLANE_READ, 0);	/* read map=20
select */
-	vga_wgfx (regbase, VGA_GFX_MISC, 1);	/* miscellaneous=20
register */
-	vga_wgfx (regbase, VGA_GFX_COMPARE_MASK, 15);	/* color=20
don't care */
-	vga_wgfx (regbase, VGA_GFX_BIT_MASK, 255);	/* bit mask=20
*/
+	/* set/reset register */
+	vga_wgfx(regbase, VGA_GFX_SR_VALUE, 0);
+	/* set/reset enable */
+	vga_wgfx(regbase, VGA_GFX_SR_ENABLE, 0);
+	/* color compare */
+	vga_wgfx(regbase, VGA_GFX_COMPARE_VALUE, 0);
+	/* data rotate */
+	vga_wgfx(regbase, VGA_GFX_DATA_ROTATE, 0);
+	/* read map select */
+	vga_wgfx(regbase, VGA_GFX_PLANE_READ, 0);
+	/* miscellaneous register */
+	vga_wgfx(regbase, VGA_GFX_MISC, 1);
+	/* color don't care */
+	vga_wgfx(regbase, VGA_GFX_COMPARE_MASK, 15);
+	/* bit mask */
+	vga_wgfx(regbase, VGA_GFX_BIT_MASK, 255);
=20
-	vga_wseq (regbase, CL_SEQR12, 0x0);	/* graphics cursor=20
attributes: nothing special */
+	/* graphics cursor attributes: nothing special */
+	vga_wseq(regbase, CL_SEQR12, 0x0);
=20
 	/* finally, turn on everything - turn off "FullBandwidth"=20
bit */
 	/* also, set "DotClock%2" bit where requested */
@@ -1542,8 +1623,8 @@ static int cirrusfb_set_par_foo (struct=20
 	tmp |=3D 0x08;
 */
=20
-	vga_wseq (regbase, VGA_SEQ_CLOCK_MODE, tmp);
-	DPRINTK ("CL_SEQR1: %d\n", tmp);
+	vga_wseq(regbase, VGA_SEQ_CLOCK_MODE, tmp);
+	DPRINTK("CL_SEQR1: %d\n", tmp);
=20
 	cinfo->currentmode =3D regs;
 	info->fix.type =3D regs.type;
@@ -1551,27 +1632,27 @@ static int cirrusfb_set_par_foo (struct=20
 	info->fix.line_length =3D regs.line_length;
=20
 	/* pan to requested offset */
-	cirrusfb_pan_display (var, info);
+	cirrusfb_pan_display(var, info);
=20
 #ifdef CIRRUSFB_DEBUG
-	cirrusfb_dump ();
+	cirrusfb_dump();
 #endif
=20
-	DPRINTK ("EXIT\n");
+	DPRINTK("EXIT\n");
 	return 0;
 }
=20
 /* for some reason incomprehensible to me, cirrusfb requires=20
that you write
  * the registers twice for the settings to take..grr. -dte */
-static int cirrusfb_set_par (struct fb_info *info)
+static int cirrusfb_set_par(struct fb_info *info)
 {
-	cirrusfb_set_par_foo (info);
-	return cirrusfb_set_par_foo (info);
+	cirrusfb_set_par_foo(info);
+	return cirrusfb_set_par_foo(info);
 }
=20
-static int cirrusfb_setcolreg (unsigned regno, unsigned red,=20
unsigned green,
-			       unsigned blue, unsigned transp,
-			       struct fb_info *info)
+static int cirrusfb_setcolreg(unsigned regno, unsigned red,=20
unsigned green,
+			      unsigned blue, unsigned transp,
+			      struct fb_info *info)
 {
 	struct cirrusfb_info *cinfo =3D info->par;
=20
@@ -1584,23 +1665,23 @@ static int cirrusfb_setcolreg (unsigned=20
 		green >>=3D (16 - info->var.green.length);
 		blue >>=3D (16 - info->var.blue.length);
=20
-		if (regno>=3D16)
+		if (regno >=3D 16)
 			return 1;
 		v =3D (red << info->var.red.offset) |
 		    (green << info->var.green.offset) |
 		    (blue << info->var.blue.offset);
=20
 		switch (info->var.bits_per_pixel) {
-			case 8:
-				cinfo->pseudo_palette[regno] =3D v;
-				break;
-			case 16:
-				cinfo->pseudo_palette[regno] =3D v;
-				break;
-			case 24:
-			case 32:
-				cinfo->pseudo_palette[regno] =3D v;
-				break;
+		case 8:
+			cinfo->pseudo_palette[regno] =3D v;
+			break;
+		case 16:
+			cinfo->pseudo_palette[regno] =3D v;
+			break;
+		case 24:
+		case 32:
+			cinfo->pseudo_palette[regno] =3D v;
+			break;
 		}
 		return 0;
 	}
@@ -1609,9 +1690,8 @@ static int cirrusfb_setcolreg (unsigned=20
 	cinfo->palette[regno].green =3D green;
 	cinfo->palette[regno].blue =3D blue;
=20
-	if (info->var.bits_per_pixel =3D=3D 8) {
-			WClut (cinfo, regno, red >> 10, green >> 10, blue >>=20
10);
-	}
+	if (info->var.bits_per_pixel =3D=3D 8)
+		WClut(cinfo, regno, red >> 10, green >> 10, blue >> 10);
=20
 	return 0;
=20
@@ -1622,8 +1702,8 @@ static int cirrusfb_setcolreg (unsigned=20
=20
 	performs display panning - provided hardware permits this
=20
*****************************************************************
*********/
-static int cirrusfb_pan_display (struct fb_var_screeninfo *var,
-				 struct fb_info *info)
+static int cirrusfb_pan_display(struct fb_var_screeninfo *var,
+				struct fb_info *info)
 {
 	int xoffset =3D 0;
 	int yoffset =3D 0;
@@ -1631,8 +1711,8 @@ static int cirrusfb_pan_display (struct=20
 	unsigned char tmp =3D 0, tmp2 =3D 0, xpix;
 	struct cirrusfb_info *cinfo =3D info->par;
=20
-	DPRINTK ("ENTER\n");
-	DPRINTK ("virtual offset: (%d,%d)\n", var->xoffset,=20
var->yoffset);
+	DPRINTK("ENTER\n");
+	DPRINTK("virtual offset: (%d,%d)\n", var->xoffset,=20
var->yoffset);
=20
 	/* no range checks for xoffset and yoffset,   */
 	/* as fb_pan_display has already done this */
@@ -1655,11 +1735,13 @@ static int cirrusfb_pan_display (struct=20
 		xpix =3D (unsigned char) ((xoffset % 4) * 2);
 	}
=20
-        cirrusfb_WaitBLT(cinfo->regbase); /* make sure all the=20
BLT's are done */
+	cirrusfb_WaitBLT(cinfo->regbase); /* make sure all the=20
BLT's are done */
=20
 	/* lower 8 + 8 bits of screen start address */
-	vga_wcrt (cinfo->regbase, VGA_CRTC_START_LO, (unsigned=20
char) (base & 0xff));
-	vga_wcrt (cinfo->regbase, VGA_CRTC_START_HI, (unsigned=20
char) (base >> 8));
+	vga_wcrt(cinfo->regbase, VGA_CRTC_START_LO,
+		 (unsigned char) (base & 0xff));
+	vga_wcrt(cinfo->regbase, VGA_CRTC_START_HI,
+		 (unsigned char) (base >> 8));
=20
 	/* construct bits 16, 17 and 18 of screen start address */
 	if (base & 0x10000)
@@ -1669,50 +1751,53 @@ static int cirrusfb_pan_display (struct=20
 	if (base & 0x40000)
 		tmp |=3D 0x08;
=20
-	tmp2 =3D (vga_rcrt (cinfo->regbase, CL_CRT1B) & 0xf2) | tmp;
	/* 0xf2 is %11110010, exclude tmp bits */
-	vga_wcrt (cinfo->regbase, CL_CRT1B, tmp2);
+	/* 0xf2 is %11110010, exclude tmp bits */
+	tmp2 =3D (vga_rcrt(cinfo->regbase, CL_CRT1B) & 0xf2) | tmp;
+	vga_wcrt(cinfo->regbase, CL_CRT1B, tmp2);
=20
 	/* construct bit 19 of screen start address */
 	if (cirrusfb_board_info[cinfo->btype].scrn_start_bit19) {
 		tmp2 =3D 0;
 		if (base & 0x80000)
 			tmp2 =3D 0x80;
-		vga_wcrt (cinfo->regbase, CL_CRT1D, tmp2);
+		vga_wcrt(cinfo->regbase, CL_CRT1D, tmp2);
 	}
=20
-	/* write pixel panning value to AR33; this does not quite=20
work in 8bpp */
-	/* ### Piccolo..? Will this work? */
+	/* write pixel panning value to AR33; this does not quite=20
work in 8bpp
+	 *
+	 * ### Piccolo..? Will this work?
+	 */
 	if (info->var.bits_per_pixel =3D=3D 1)
-		vga_wattr (cinfo->regbase, CL_AR33, xpix);
+		vga_wattr(cinfo->regbase, CL_AR33, xpix);
=20
-	cirrusfb_WaitBLT (cinfo->regbase);
+	cirrusfb_WaitBLT(cinfo->regbase);
=20
-	DPRINTK ("EXIT\n");
-	return (0);
+	DPRINTK("EXIT\n");
+	return 0;
 }
=20
-
-static int cirrusfb_blank (int blank_mode, struct fb_info *info)
+static int cirrusfb_blank(int blank_mode, struct fb_info *info)
 {
 	/*
-	 *  Blank the screen if blank_mode !=3D 0, else unblank. If=20
blank =3D=3D NULL
-	 *  then the caller blanks by setting the CLUT (Color Look Up=20
Table) to all
-	 *  black. Return 0 if blanking succeeded, !=3D 0 if=20
un-/blanking failed due
-	 *  to e.g. a video mode which doesn't support it. Implements=20
VESA suspend
-	 *  and powerdown modes on hardware that supports disabling=20
hsync/vsync:
-	 *    blank_mode =3D=3D 2: suspend vsync
-	 *    blank_mode =3D=3D 3: suspend hsync
-	 *    blank_mode =3D=3D 4: powerdown
+	 * Blank the screen if blank_mode !=3D 0, else unblank. If=20
blank =3D=3D NULL
+	 * then the caller blanks by setting the CLUT (Color Look Up=20
Table)
+	 * to all black. Return 0 if blanking succeeded, !=3D 0 if=20
un-/blanking
+	 * failed due to e.g. a video mode which doesn't support it.
+	 * Implements VESA suspend and powerdown modes on hardware=20
that
+	 * supports disabling hsync/vsync:
+	 *   blank_mode =3D=3D 2: suspend vsync
+	 *   blank_mode =3D=3D 3: suspend hsync
+	 *   blank_mode =3D=3D 4: powerdown
 	 */
 	unsigned char val;
 	struct cirrusfb_info *cinfo =3D info->par;
 	int current_mode =3D cinfo->blank_mode;
=20
-	DPRINTK ("ENTER, blank mode =3D %d\n", blank_mode);
+	DPRINTK("ENTER, blank mode =3D %d\n", blank_mode);
=20
 	if (info->state !=3D FBINFO_STATE_RUNNING ||
 	    current_mode =3D=3D blank_mode) {
-		DPRINTK ("EXIT, returning 0\n");
+		DPRINTK("EXIT, returning 0\n");
 		return 0;
 	}
=20
@@ -1720,17 +1805,19 @@ static int cirrusfb_blank (int blank_mod
 	if (current_mode =3D=3D FB_BLANK_NORMAL ||
 	    current_mode =3D=3D FB_BLANK_UNBLANK) {
 		/* unblank the screen */
-		val =3D vga_rseq (cinfo->regbase, VGA_SEQ_CLOCK_MODE);
-		vga_wseq (cinfo->regbase, VGA_SEQ_CLOCK_MODE, val &=20
0xdf);	/* clear "FullBandwidth" bit */
+		val =3D vga_rseq(cinfo->regbase, VGA_SEQ_CLOCK_MODE);
+		/* clear "FullBandwidth" bit */
+		vga_wseq(cinfo->regbase, VGA_SEQ_CLOCK_MODE, val & 0xdf)
;
 		/* and undo VESA suspend trickery */
-		vga_wgfx (cinfo->regbase, CL_GRE, 0x00);
+		vga_wgfx(cinfo->regbase, CL_GRE, 0x00);
 	}
=20
 	/* set new */
-	if(blank_mode > FB_BLANK_NORMAL) {
+	if (blank_mode > FB_BLANK_NORMAL) {
 		/* blank the screen */
-		val =3D vga_rseq (cinfo->regbase, VGA_SEQ_CLOCK_MODE);
-		vga_wseq (cinfo->regbase, VGA_SEQ_CLOCK_MODE, val |=20
0x20);	/* set "FullBandwidth" bit */
+		val =3D vga_rseq(cinfo->regbase, VGA_SEQ_CLOCK_MODE);
+		/* set "FullBandwidth" bit */
+		vga_wseq(cinfo->regbase, VGA_SEQ_CLOCK_MODE, val | 0x20)
;
 	}
=20
 	switch (blank_mode) {
@@ -1738,21 +1825,21 @@ static int cirrusfb_blank (int blank_mod
 	case FB_BLANK_NORMAL:
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:
-		vga_wgfx (cinfo->regbase, CL_GRE, 0x04);
+		vga_wgfx(cinfo->regbase, CL_GRE, 0x04);
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
-		vga_wgfx (cinfo->regbase, CL_GRE, 0x02);
+		vga_wgfx(cinfo->regbase, CL_GRE, 0x02);
 		break;
 	case FB_BLANK_POWERDOWN:
-		vga_wgfx (cinfo->regbase, CL_GRE, 0x06);
+		vga_wgfx(cinfo->regbase, CL_GRE, 0x06);
 		break;
 	default:
-		DPRINTK ("EXIT, returning 1\n");
+		DPRINTK("EXIT, returning 1\n");
 		return 1;
 	}
=20
 	cinfo->blank_mode =3D blank_mode;
-	DPRINTK ("EXIT, returning 0\n");
+	DPRINTK("EXIT, returning 0\n");
=20
 	/* Let fbcon do a soft blank for us */
 	return (blank_mode =3D=3D FB_BLANK_NORMAL) ? 1 : 0;
@@ -1761,45 +1848,50 @@ static int cirrusfb_blank (int blank_mod
=20
/****************************************************************
************/
 /**** BEGIN Internal Routines=20
***********************************************/
=20
-static void init_vgachip (struct cirrusfb_info *cinfo)
+static void init_vgachip(struct cirrusfb_info *cinfo)
 {
 	const struct cirrusfb_board_info_rec *bi;
=20
-	DPRINTK ("ENTER\n");
+	DPRINTK("ENTER\n");
=20
-	assert (cinfo !=3D NULL);
+	assert(cinfo !=3D NULL);
=20
 	bi =3D &cirrusfb_board_info[cinfo->btype];
=20
 	/* reset board globally */
 	switch (cinfo->btype) {
 	case BT_PICCOLO:
-		WSFR (cinfo, 0x01);
-		udelay (500);
-		WSFR (cinfo, 0x51);
-		udelay (500);
+		WSFR(cinfo, 0x01);
+		udelay(500);
+		WSFR(cinfo, 0x51);
+		udelay(500);
 		break;
 	case BT_PICASSO:
-		WSFR2 (cinfo, 0xff);
-		udelay (500);
+		WSFR2(cinfo, 0xff);
+		udelay(500);
 		break;
 	case BT_SD64:
 	case BT_SPECTRUM:
-		WSFR (cinfo, 0x1f);
-		udelay (500);
-		WSFR (cinfo, 0x4f);
-		udelay (500);
+		WSFR(cinfo, 0x1f);
+		udelay(500);
+		WSFR(cinfo, 0x4f);
+		udelay(500);
 		break;
 	case BT_PICASSO4:
-		vga_wcrt (cinfo->regbase, CL_CRT51, 0x00);	/*=20
disable flickerfixer */
-		mdelay (100);
-		vga_wgfx (cinfo->regbase, CL_GR2F, 0x00);	/* from=20
Klaus' NetBSD driver: */
-		vga_wgfx (cinfo->regbase, CL_GR33, 0x00);	/* put=20
blitter into 542x compat */
-		vga_wgfx (cinfo->regbase, CL_GR31, 0x00);	/* mode */
+		/* disable flickerfixer */
+		vga_wcrt(cinfo->regbase, CL_CRT51, 0x00);
+		mdelay(100);
+		/* from Klaus' NetBSD driver: */
+		vga_wgfx(cinfo->regbase, CL_GR2F, 0x00);
+		/* put blitter into 542x compat */
+		vga_wgfx(cinfo->regbase, CL_GR33, 0x00);
+		/* mode */
+		vga_wgfx(cinfo->regbase, CL_GR31, 0x00);
 		break;
=20
 	case BT_GD5480:
-		vga_wgfx (cinfo->regbase, CL_GR2F, 0x00);	/* from=20
Klaus' NetBSD driver: */
+		/* from Klaus' NetBSD driver: */
+		vga_wgfx(cinfo->regbase, CL_GR2F, 0x00);
 		break;
=20
 	case BT_ALPINE:
@@ -1807,153 +1899,207 @@ static void init_vgachip (struct=20
cirrusf
 		break;
=20
 	default:
-		printk (KERN_ERR "cirrusfb: Warning: Unknown board=20
type\n");
+		printk(KERN_ERR "cirrusfb: Warning: Unknown board=20
type\n");
 		break;
 	}
=20
-	assert (cinfo->size > 0); /* make sure RAM size set by this=20
point */
+	assert(cinfo->size > 0); /* make sure RAM size set by this=20
point */
=20
 	/* the P4 is not fully initialized here; I rely on it=20
having been */
 	/* inited under AmigaOS already, which seems to work just=20
fine    */
-	/* (Klaus advised to do it this way)                       =20
      */
+	/* (Klaus advised to do it this way)			      */
=20
 	if (cinfo->btype !=3D BT_PICASSO4) {
-		WGen (cinfo, CL_VSSM, 0x10);	/* EGS: 0x16 */
-		WGen (cinfo, CL_POS102, 0x01);
-		WGen (cinfo, CL_VSSM, 0x08);	/* EGS: 0x0e */
+		WGen(cinfo, CL_VSSM, 0x10);	/* EGS: 0x16 */
+		WGen(cinfo, CL_POS102, 0x01);
+		WGen(cinfo, CL_VSSM, 0x08);	/* EGS: 0x0e */
=20
 		if (cinfo->btype !=3D BT_SD64)
-			WGen (cinfo, CL_VSSM2, 0x01);
+			WGen(cinfo, CL_VSSM2, 0x01);
=20
-		vga_wseq (cinfo->regbase, CL_SEQR0, 0x03);	/* reset=20
sequencer logic */
+		/* reset sequencer logic */
+		vga_wseq(cinfo->regbase, CL_SEQR0, 0x03);
=20
-		vga_wseq (cinfo->regbase, VGA_SEQ_CLOCK_MODE, 0x21);
	/* FullBandwidth (video off) and 8/9 dot clock */
-		WGen (cinfo, VGA_MIS_W, 0xc1);	/* polarity (-/-),=20
disable access to display memory, VGA_CRTC_START_HI base address:=20
color */
+		/* FullBandwidth (video off) and 8/9 dot clock */
+		vga_wseq(cinfo->regbase, VGA_SEQ_CLOCK_MODE, 0x21);
+		/* polarity (-/-), disable access to display memory,
+		 * VGA_CRTC_START_HI base address: color
+		 */
+		WGen(cinfo, VGA_MIS_W, 0xc1);
=20
-/*      vga_wgfx (cinfo->regbase, CL_GRA, 0xce);    "magic=20
cookie" - doesn't make any sense to me.. */
-		vga_wseq (cinfo->regbase, CL_SEQR6, 0x12);	/* unlock=20
all extension registers */
+		/* "magic cookie" - doesn't make any sense to me.. */
+/*      vga_wgfx(cinfo->regbase, CL_GRA, 0xce);   */
+		/* unlock all extension registers */
+		vga_wseq(cinfo->regbase, CL_SEQR6, 0x12);
=20
-		vga_wgfx (cinfo->regbase, CL_GR31, 0x04);	/* reset=20
blitter */
+		/* reset blitter */
+		vga_wgfx(cinfo->regbase, CL_GR31, 0x04);
=20
 		switch (cinfo->btype) {
 		case BT_GD5480:
-			vga_wseq (cinfo->regbase, CL_SEQRF, 0x98);
+			vga_wseq(cinfo->regbase, CL_SEQRF, 0x98);
 			break;
 		case BT_ALPINE:
 			break;
 		case BT_SD64:
-			vga_wseq (cinfo->regbase, CL_SEQRF, 0xb8);
+			vga_wseq(cinfo->regbase, CL_SEQRF, 0xb8);
 			break;
 		default:
-			vga_wseq (cinfo->regbase, CL_SEQR16, 0x0f);
-			vga_wseq (cinfo->regbase, CL_SEQRF, 0xb0);
+			vga_wseq(cinfo->regbase, CL_SEQR16, 0x0f);
+			vga_wseq(cinfo->regbase, CL_SEQRF, 0xb0);
 			break;
 		}
 	}
-	vga_wseq (cinfo->regbase, VGA_SEQ_PLANE_WRITE, 0xff);
	/* plane mask: nothing */
-	vga_wseq (cinfo->regbase, VGA_SEQ_CHARACTER_MAP, 0x00);
	/* character map select: doesn't even matter in gx mode */
-	vga_wseq (cinfo->regbase, VGA_SEQ_MEMORY_MODE, 0x0e);
	/* memory mode: chain-4, no odd/even, ext. memory */
+	/* plane mask: nothing */
+	vga_wseq(cinfo->regbase, VGA_SEQ_PLANE_WRITE, 0xff);
+	/* character map select: doesn't even matter in gx mode */
+	vga_wseq(cinfo->regbase, VGA_SEQ_CHARACTER_MAP, 0x00);
+	/* memory mode: chain-4, no odd/even, ext. memory */
+	vga_wseq(cinfo->regbase, VGA_SEQ_MEMORY_MODE, 0x0e);
=20
 	/* controller-internal base address of video memory */
 	if (bi->init_sr07)
-		vga_wseq (cinfo->regbase, CL_SEQR7, bi->sr07);
+		vga_wseq(cinfo->regbase, CL_SEQR7, bi->sr07);
=20
-	/*  vga_wseq (cinfo->regbase, CL_SEQR8, 0x00); *//* EEPROM=20
control: shouldn't be necessary to write to this at all.. */
+	/*  vga_wseq(cinfo->regbase, CL_SEQR8, 0x00); */
+	/* EEPROM control: shouldn't be necessary to write to this=20
at all.. */
=20
-	vga_wseq (cinfo->regbase, CL_SEQR10, 0x00);		/*=20
graphics cursor X position (incomplete; position gives rem. 3=20
bits */
-	vga_wseq (cinfo->regbase, CL_SEQR11, 0x00);		/*=20
graphics cursor Y position (..."... ) */
-	vga_wseq (cinfo->regbase, CL_SEQR12, 0x00);		/*=20
graphics cursor attributes */
-	vga_wseq (cinfo->regbase, CL_SEQR13, 0x00);		/*=20
graphics cursor pattern address */
+	/* graphics cursor X position (incomplete; position gives=20
rem. 3 bits */
+	vga_wseq(cinfo->regbase, CL_SEQR10, 0x00);
+	/* graphics cursor Y position (..."... ) */
+	vga_wseq(cinfo->regbase, CL_SEQR11, 0x00);
+	/* graphics cursor attributes */
+	vga_wseq(cinfo->regbase, CL_SEQR12, 0x00);
+	/* graphics cursor pattern address */
+	vga_wseq(cinfo->regbase, CL_SEQR13, 0x00);
=20
 	/* writing these on a P4 might give problems..  */
 	if (cinfo->btype !=3D BT_PICASSO4) {
-		vga_wseq (cinfo->regbase, CL_SEQR17, 0x00);		/*=20
configuration readback and ext. color */
-		vga_wseq (cinfo->regbase, CL_SEQR18, 0x02);		/*=20
signature generator */
+		/* configuration readback and ext. color */
+		vga_wseq(cinfo->regbase, CL_SEQR17, 0x00);
+		/* signature generator */
+		vga_wseq(cinfo->regbase, CL_SEQR18, 0x02);
 	}
=20
 	/* MCLK select etc. */
 	if (bi->init_sr1f)
-		vga_wseq (cinfo->regbase, CL_SEQR1F, bi->sr1f);
+		vga_wseq(cinfo->regbase, CL_SEQR1F, bi->sr1f);
=20
-	vga_wcrt (cinfo->regbase, VGA_CRTC_PRESET_ROW, 0x00);
	/* Screen A preset row scan: none */
-	vga_wcrt (cinfo->regbase, VGA_CRTC_CURSOR_START, 0x20);
	/* Text cursor start: disable text cursor */
-	vga_wcrt (cinfo->regbase, VGA_CRTC_CURSOR_END, 0x00);
	/* Text cursor end: - */
-	vga_wcrt (cinfo->regbase, VGA_CRTC_START_HI, 0x00);	/*=20
Screen start address high: 0 */
-	vga_wcrt (cinfo->regbase, VGA_CRTC_START_LO, 0x00);	/*=20
Screen start address low: 0 */
-	vga_wcrt (cinfo->regbase, VGA_CRTC_CURSOR_HI, 0x00);	/*=20
text cursor location high: 0 */
-	vga_wcrt (cinfo->regbase, VGA_CRTC_CURSOR_LO, 0x00);	/*=20
text cursor location low: 0 */
-
-	vga_wcrt (cinfo->regbase, VGA_CRTC_UNDERLINE, 0x00);	/*=20
Underline Row scanline: - */
-	vga_wcrt (cinfo->regbase, VGA_CRTC_MODE, 0xc3);	/* mode=20
control: timing enable, byte mode, no compat modes */
-	vga_wcrt (cinfo->regbase, VGA_CRTC_LINE_COMPARE, 0x00);
	/* Line Compare: not needed */
+	/* Screen A preset row scan: none */
+	vga_wcrt(cinfo->regbase, VGA_CRTC_PRESET_ROW, 0x00);
+	/* Text cursor start: disable text cursor */
+	vga_wcrt(cinfo->regbase, VGA_CRTC_CURSOR_START, 0x20);
+	/* Text cursor end: - */
+	vga_wcrt(cinfo->regbase, VGA_CRTC_CURSOR_END, 0x00);
+	/* Screen start address high: 0 */
+	vga_wcrt(cinfo->regbase, VGA_CRTC_START_HI, 0x00);
+	/* Screen start address low: 0 */
+	vga_wcrt(cinfo->regbase, VGA_CRTC_START_LO, 0x00);
+	/* text cursor location high: 0 */
+	vga_wcrt(cinfo->regbase, VGA_CRTC_CURSOR_HI, 0x00);
+	/* text cursor location low: 0 */
+	vga_wcrt(cinfo->regbase, VGA_CRTC_CURSOR_LO, 0x00);
+
+	/* Underline Row scanline: - */
+	vga_wcrt(cinfo->regbase, VGA_CRTC_UNDERLINE, 0x00);
+	/* mode control: timing enable, byte mode, no compat modes=20
*/
+	vga_wcrt(cinfo->regbase, VGA_CRTC_MODE, 0xc3);
+	/* Line Compare: not needed */
+	vga_wcrt(cinfo->regbase, VGA_CRTC_LINE_COMPARE, 0x00);
 	/* ### add 0x40 for text modes with > 30 MHz pixclock */
-	vga_wcrt (cinfo->regbase, CL_CRT1B, 0x02);	/* ext.=20
display controls: ext.adr. wrap */
+	/* ext. display controls: ext.adr. wrap */
+	vga_wcrt(cinfo->regbase, CL_CRT1B, 0x02);
=20
-	vga_wgfx (cinfo->regbase, VGA_GFX_SR_VALUE, 0x00);	/*=20
Set/Reset registes: - */
-	vga_wgfx (cinfo->regbase, VGA_GFX_SR_ENABLE, 0x00);	/*=20
Set/Reset enable: - */
-	vga_wgfx (cinfo->regbase, VGA_GFX_COMPARE_VALUE, 0x00);
	/* Color Compare: - */
-	vga_wgfx (cinfo->regbase, VGA_GFX_DATA_ROTATE, 0x00);
	/* Data Rotate: - */
-	vga_wgfx (cinfo->regbase, VGA_GFX_PLANE_READ, 0x00);	/*=20
Read Map Select: - */
-	vga_wgfx (cinfo->regbase, VGA_GFX_MODE, 0x00);	/* Mode:=20
conf. for 16/4/2 color mode, no odd/even, read/write mode 0 */
-	vga_wgfx (cinfo->regbase, VGA_GFX_MISC, 0x01);	/*=20
Miscellaneous: memory map base address, graphics mode */
-	vga_wgfx (cinfo->regbase, VGA_GFX_COMPARE_MASK, 0x0f);
	/* Color Don't care: involve all planes */
-	vga_wgfx (cinfo->regbase, VGA_GFX_BIT_MASK, 0xff);	/*=20
Bit Mask: no mask at all */
+	/* Set/Reset registes: - */
+	vga_wgfx(cinfo->regbase, VGA_GFX_SR_VALUE, 0x00);
+	/* Set/Reset enable: - */
+	vga_wgfx(cinfo->regbase, VGA_GFX_SR_ENABLE, 0x00);
+	/* Color Compare: - */
+	vga_wgfx(cinfo->regbase, VGA_GFX_COMPARE_VALUE, 0x00);
+	/* Data Rotate: - */
+	vga_wgfx(cinfo->regbase, VGA_GFX_DATA_ROTATE, 0x00);
+	/* Read Map Select: - */
+	vga_wgfx(cinfo->regbase, VGA_GFX_PLANE_READ, 0x00);
+	/* Mode: conf. for 16/4/2 color mode, no odd/even,=20
read/write mode 0 */
+	vga_wgfx(cinfo->regbase, VGA_GFX_MODE, 0x00);
+	/* Miscellaneous: memory map base address, graphics mode */
+	vga_wgfx(cinfo->regbase, VGA_GFX_MISC, 0x01);
+	/* Color Don't care: involve all planes */
+	vga_wgfx(cinfo->regbase, VGA_GFX_COMPARE_MASK, 0x0f);
+	/* Bit Mask: no mask at all */
+	vga_wgfx(cinfo->regbase, VGA_GFX_BIT_MASK, 0xff);
 	if (cinfo->btype =3D=3D BT_ALPINE)
-		vga_wgfx (cinfo->regbase, CL_GRB, 0x20);	/* (5434=20
can't have bit 3 set for bitblt) */
+		/* (5434 can't have bit 3 set for bitblt) */
+		vga_wgfx(cinfo->regbase, CL_GRB, 0x20);
 	else
-		vga_wgfx (cinfo->regbase, CL_GRB, 0x28);	/* Graphics=20
controller mode extensions: finer granularity, 8byte data latches=20
*/
+	/* Graphics controller mode extensions: finer granularity,
+	 * 8byte data latches
+	 */
+		vga_wgfx(cinfo->regbase, CL_GRB, 0x28);
=20
-	vga_wgfx (cinfo->regbase, CL_GRC, 0xff);	/* Color Key=20
compare: - */
-	vga_wgfx (cinfo->regbase, CL_GRD, 0x00);	/* Color Key=20
compare mask: - */
-	vga_wgfx (cinfo->regbase, CL_GRE, 0x00);	/*=20
Miscellaneous control: - */
-	/*  vga_wgfx (cinfo->regbase, CL_GR10, 0x00); *//*=20
Background color byte 1: - */
-/*  vga_wgfx (cinfo->regbase, CL_GR11, 0x00); */
-
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE0, 0x00);	/*=20
Attribute Controller palette registers: "identity mapping" */
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE1, 0x01);
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE2, 0x02);
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE3, 0x03);
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE4, 0x04);
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE5, 0x05);
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE6, 0x06);
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE7, 0x07);
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE8, 0x08);
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTE9, 0x09);
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTEA, 0x0a);
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTEB, 0x0b);
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTEC, 0x0c);
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTED, 0x0d);
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTEE, 0x0e);
-	vga_wattr (cinfo->regbase, VGA_ATC_PALETTEF, 0x0f);
-
-	vga_wattr (cinfo->regbase, VGA_ATC_MODE, 0x01);	/*=20
Attribute Controller mode: graphics mode */
-	vga_wattr (cinfo->regbase, VGA_ATC_OVERSCAN, 0x00);	/*=20
Overscan color reg.: reg. 0 */
-	vga_wattr (cinfo->regbase, VGA_ATC_PLANE_ENABLE, 0x0f);
	/* Color Plane enable: Enable all 4 planes */
-/* ###  vga_wattr (cinfo->regbase, CL_AR33, 0x00); * Pixel=20
Panning: - */
-	vga_wattr (cinfo->regbase, VGA_ATC_COLOR_PAGE, 0x00);
	/* Color Select: - */
+	vga_wgfx(cinfo->regbase, CL_GRC, 0xff);	/* Color Key=20
compare: - */
+	vga_wgfx(cinfo->regbase, CL_GRD, 0x00);	/* Color Key=20
compare mask: - */
+	vga_wgfx(cinfo->regbase, CL_GRE, 0x00);	/*=20
Miscellaneous control: - */
+	/* Background color byte 1: - */
+	/*  vga_wgfx (cinfo->regbase, CL_GR10, 0x00); */
+	/*  vga_wgfx (cinfo->regbase, CL_GR11, 0x00); */
+
+	/* Attribute Controller palette registers: "identity=20
mapping" */
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTE0, 0x00);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTE1, 0x01);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTE2, 0x02);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTE3, 0x03);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTE4, 0x04);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTE5, 0x05);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTE6, 0x06);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTE7, 0x07);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTE8, 0x08);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTE9, 0x09);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTEA, 0x0a);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTEB, 0x0b);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTEC, 0x0c);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTED, 0x0d);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTEE, 0x0e);
+	vga_wattr(cinfo->regbase, VGA_ATC_PALETTEF, 0x0f);
+
+	/* Attribute Controller mode: graphics mode */
+	vga_wattr(cinfo->regbase, VGA_ATC_MODE, 0x01);
+	/* Overscan color reg.: reg. 0 */
+	vga_wattr(cinfo->regbase, VGA_ATC_OVERSCAN, 0x00);
+	/* Color Plane enable: Enable all 4 planes */
+	vga_wattr(cinfo->regbase, VGA_ATC_PLANE_ENABLE, 0x0f);
+/* ###  vga_wattr(cinfo->regbase, CL_AR33, 0x00); * Pixel=20
Panning: - */
+	/* Color Select: - */
+	vga_wattr(cinfo->regbase, VGA_ATC_COLOR_PAGE, 0x00);
=20
-	WGen (cinfo, VGA_PEL_MSK, 0xff);	/* Pixel mask: no mask=20
*/
+	WGen(cinfo, VGA_PEL_MSK, 0xff);	/* Pixel mask: no mask=20
*/
=20
 	if (cinfo->btype !=3D BT_ALPINE && cinfo->btype !=3D BT_GD5480)
-		WGen (cinfo, VGA_MIS_W, 0xc3);	/* polarity (-/-),=20
enable display mem, VGA_CRTC_START_HI i/o base =3D color */
+	/* polarity (-/-), enable display mem,
+	 * VGA_CRTC_START_HI i/o base =3D color
+	 */
+		WGen(cinfo, VGA_MIS_W, 0xc3);
=20
-	vga_wgfx (cinfo->regbase, CL_GR31, 0x04);	/* BLT=20
Start/status: Blitter reset */
-	vga_wgfx (cinfo->regbase, CL_GR31, 0x00);	/* - " -     =20
     : "end-of-reset" */
+	/* BLT Start/status: Blitter reset */
+	vga_wgfx(cinfo->regbase, CL_GR31, 0x04);
+	/* - " -	   : "end-of-reset" */
+	vga_wgfx(cinfo->regbase, CL_GR31, 0x00);
=20
 	/* misc... */
-	WHDR (cinfo, 0);	/* Hidden DAC register: - */
+	WHDR(cinfo, 0);	/* Hidden DAC register: - */
=20
-	printk (KERN_DEBUG "cirrusfb: This board has %ld bytes of=20
DRAM memory\n", cinfo->size);
-	DPRINTK ("EXIT\n");
+	printk(KERN_DEBUG "cirrusfb: This board has %ld bytes of=20
DRAM memory\n",
+		cinfo->size);
+	DPRINTK("EXIT\n");
 	return;
 }
=20
-static void switch_monitor (struct cirrusfb_info *cinfo, int on)
+static void switch_monitor(struct cirrusfb_info *cinfo, int on)
 {
 #ifdef CONFIG_ZORRO /* only works on Zorro boards */
 	static int IsOn =3D 0;	/* XXX not ok for multiple boards=20
*/
=20
-	DPRINTK ("ENTER\n");
+	DPRINTK("ENTER\n");
=20
 	if (cinfo->btype =3D=3D BT_PICASSO4)
 		return;		/* nothing to switch */
@@ -1963,44 +2109,43 @@ static void switch_monitor (struct cirru
 		return;		/* nothing to switch */
 	if (cinfo->btype =3D=3D BT_PICASSO) {
 		if ((on && !IsOn) || (!on && IsOn))
-			WSFR (cinfo, 0xff);
+			WSFR(cinfo, 0xff);
=20
-		DPRINTK ("EXIT\n");
+		DPRINTK("EXIT\n");
 		return;
 	}
 	if (on) {
 		switch (cinfo->btype) {
 		case BT_SD64:
-			WSFR (cinfo, cinfo->SFR | 0x21);
+			WSFR(cinfo, cinfo->SFR | 0x21);
 			break;
 		case BT_PICCOLO:
-			WSFR (cinfo, cinfo->SFR | 0x28);
+			WSFR(cinfo, cinfo->SFR | 0x28);
 			break;
 		case BT_SPECTRUM:
-			WSFR (cinfo, 0x6f);
+			WSFR(cinfo, 0x6f);
 			break;
 		default: /* do nothing */ break;
 		}
 	} else {
 		switch (cinfo->btype) {
 		case BT_SD64:
-			WSFR (cinfo, cinfo->SFR & 0xde);
+			WSFR(cinfo, cinfo->SFR & 0xde);
 			break;
 		case BT_PICCOLO:
-			WSFR (cinfo, cinfo->SFR & 0xd7);
+			WSFR(cinfo, cinfo->SFR & 0xd7);
 			break;
 		case BT_SPECTRUM:
-			WSFR (cinfo, 0x4f);
+			WSFR(cinfo, 0x4f);
 			break;
 		default: /* do nothing */ break;
 		}
 	}
=20
-	DPRINTK ("EXIT\n");
+	DPRINTK("EXIT\n");
 #endif /* CONFIG_ZORRO */
 }
=20
-
 /******************************************/
 /* Linux 2.6-style  accelerated functions */
 /******************************************/
@@ -2012,15 +2157,17 @@ static void cirrusfb_prim_fillrect(struc
 	u32 color =3D (cinfo->info->fix.visual =3D=3D=20
FB_VISUAL_TRUECOLOR) ?
 		cinfo->pseudo_palette[region->color] : region->color;
=20
-	if(cinfo->info->var.bits_per_pixel =3D=3D 1) {
-		cirrusfb_RectFill(cinfo->regbase, cinfo->info->var.
bits_per_pixel,
+	if (cinfo->info->var.bits_per_pixel =3D=3D 1) {
+		cirrusfb_RectFill(cinfo->regbase,
+				  cinfo->info->var.bits_per_pixel,
 				  region->dx / 8, region->dy,
 				  region->width / 8, region->height,
 				  color,
 				  cinfo->currentmode.line_length);
 	} else {
-		m =3D ( cinfo->info->var.bits_per_pixel + 7 ) / 8;
-		cirrusfb_RectFill(cinfo->regbase, cinfo->info->var.
bits_per_pixel,
+		m =3D (cinfo->info->var.bits_per_pixel + 7) / 8;
+		cirrusfb_RectFill(cinfo->regbase,
+				  cinfo->info->var.bits_per_pixel,
 				  region->dx * m, region->dy,
 				  region->width * m, region->height,
 				  color,
@@ -2029,7 +2176,8 @@ static void cirrusfb_prim_fillrect(struc
 	return;
 }
=20
-static void cirrusfb_fillrect (struct fb_info *info, const=20
struct fb_fillrect *region)
+static void cirrusfb_fillrect(struct fb_info *info,
+			      const struct fb_fillrect *region)
 {
 	struct cirrusfb_info *cinfo =3D info->par;
 	struct fb_fillrect modded;
@@ -2047,12 +2195,14 @@ static void cirrusfb_fillrect (struct fb
=20
 	memcpy(&modded, region, sizeof(struct fb_fillrect));
=20
-	if(!modded.width || !modded.height ||
+	if (!modded.width || !modded.height ||
 	   modded.dx >=3D vxres || modded.dy >=3D vyres)
 		return;
=20
-	if(modded.dx + modded.width  > vxres) modded.width  =3D vxres=20
- modded.dx;
-	if(modded.dy + modded.height > vyres) modded.height =3D vyres=20
- modded.dy;
+	if (modded.dx + modded.width  > vxres)
+		modded.width  =3D vxres - modded.dx;
+	if (modded.dy + modded.height > vyres)
+		modded.height =3D vyres - modded.dy;
=20
 	cirrusfb_prim_fillrect(cinfo, &modded);
 }
@@ -2061,14 +2211,14 @@ static void cirrusfb_prim_copyarea(struc
 				   const struct fb_copyarea *area)
 {
 	int m; /* bytes per pixel */
-	if(cinfo->info->var.bits_per_pixel =3D=3D 1) {
+	if (cinfo->info->var.bits_per_pixel =3D=3D 1) {
 		cirrusfb_BitBLT(cinfo->regbase, cinfo->info->var.
bits_per_pixel,
 				area->sx / 8, area->sy,
 				area->dx / 8, area->dy,
 				area->width / 8, area->height,
 				cinfo->currentmode.line_length);
 	} else {
-		m =3D ( cinfo->info->var.bits_per_pixel + 7 ) / 8;
+		m =3D (cinfo->info->var.bits_per_pixel + 7) / 8;
 		cirrusfb_BitBLT(cinfo->regbase, cinfo->info->var.
bits_per_pixel,
 				area->sx * m, area->sy,
 				area->dx * m, area->dy,
@@ -2078,8 +2228,8 @@ static void cirrusfb_prim_copyarea(struc
 	return;
 }
=20
-
-static void cirrusfb_copyarea(struct fb_info *info, const struct=20
fb_copyarea *area)
+static void cirrusfb_copyarea(struct fb_info *info,
+			      const struct fb_copyarea *area)
 {
 	struct cirrusfb_info *cinfo =3D info->par;
 	struct fb_copyarea modded;
@@ -2101,89 +2251,99 @@ static void cirrusfb_copyarea(struct fb_
 	vxres =3D info->var.xres_virtual;
 	vyres =3D info->var.yres_virtual;
=20
-	if(!modded.width || !modded.height ||
+	if (!modded.width || !modded.height ||
 	   modded.sx >=3D vxres || modded.sy >=3D vyres ||
 	   modded.dx >=3D vxres || modded.dy >=3D vyres)
 		return;
=20
-	if(modded.sx + modded.width > vxres)  modded.width =3D vxres=20
- modded.sx;
-	if(modded.dx + modded.width > vxres)  modded.width =3D vxres=20
- modded.dx;
-	if(modded.sy + modded.height > vyres) modded.height =3D vyres=20
- modded.sy;
-	if(modded.dy + modded.height > vyres) modded.height =3D vyres=20
- modded.dy;
+	if (modded.sx + modded.width > vxres)
+		modded.width =3D vxres - modded.sx;
+	if (modded.dx + modded.width > vxres)
+		modded.width =3D vxres - modded.dx;
+	if (modded.sy + modded.height > vyres)
+		modded.height =3D vyres - modded.sy;
+	if (modded.dy + modded.height > vyres)
+		modded.height =3D vyres - modded.dy;
=20
 	cirrusfb_prim_copyarea(cinfo, &modded);
 }
=20
-static void cirrusfb_imageblit(struct fb_info *info, const=20
struct fb_image *image)
+static void cirrusfb_imageblit(struct fb_info *info,
+			       const struct fb_image *image)
 {
 	struct cirrusfb_info *cinfo =3D info->par;
=20
-        cirrusfb_WaitBLT(cinfo->regbase);
+	cirrusfb_WaitBLT(cinfo->regbase);
 	cfb_imageblit(info, image);
 }
=20
-
 #ifdef CONFIG_PPC_PREP
 #define PREP_VIDEO_BASE ((volatile unsigned long) 0xC0000000)
 #define PREP_IO_BASE    ((volatile unsigned char *) 0x80000000)
-static void get_prep_addrs (unsigned long *display, unsigned=20
long *registers)
+static void get_prep_addrs(unsigned long *display, unsigned long=20
*registers)
 {
-	DPRINTK ("ENTER\n");
+	DPRINTK("ENTER\n");
=20
 	*display =3D PREP_VIDEO_BASE;
 	*registers =3D (unsigned long) PREP_IO_BASE;
=20
-	DPRINTK ("EXIT\n");
+	DPRINTK("EXIT\n");
 }
=20
 #endif				/* CONFIG_PPC_PREP */
=20
-
 #ifdef CONFIG_PCI
-static int release_io_ports =3D 0;
+static int release_io_ports;
=20
 /* Pulled the logic from XFree86 Cirrus driver to get the memory=20
size,
  * based on the DRAM bandwidth bit and DRAM bank switching bit. =20
This
  * works with 1MB, 2MB and 4MB configurations (which the=20
Motorola boards
  * seem to have. */
-static unsigned int cirrusfb_get_memsize (u8 __iomem *regbase)
+static unsigned int cirrusfb_get_memsize(u8 __iomem *regbase)
 {
 	unsigned long mem;
 	unsigned char SRF;
=20
-	DPRINTK ("ENTER\n");
+	DPRINTK("ENTER\n");
=20
-	SRF =3D vga_rseq (regbase, CL_SEQRF);
+	SRF =3D vga_rseq(regbase, CL_SEQRF);
 	switch ((SRF & 0x18)) {
-	    case 0x08: mem =3D 512 * 1024; break;
-	    case 0x10: mem =3D 1024 * 1024; break;
-		/* 64-bit DRAM data bus width; assume 2MB. Also=20
indicates 2MB memory
-		   * on the 5430. */
-	    case 0x18: mem =3D 2048 * 1024; break;
-	    default: printk ("CLgenfb: Unknown memory size!\n");
+	case 0x08:
+		mem =3D 512 * 1024;
+		break;
+	case 0x10:
+		mem =3D 1024 * 1024;
+		break;
+	/* 64-bit DRAM data bus width; assume 2MB. Also indicates=20
2MB memory
+	 * on the 5430.
+	 */
+	case 0x18:
+		mem =3D 2048 * 1024;
+		break;
+	default:
+		printk(KERN_WARNING "CLgenfb: Unknown memory size!\n");
 		mem =3D 1024 * 1024;
 	}
-	if (SRF & 0x80) {
-		/* If DRAM bank switching is enabled, there must be=20
twice as much
-		   * memory installed. (4MB on the 5434) */
+	if (SRF & 0x80)
+	/* If DRAM bank switching is enabled, there must be twice=20
as much
+	 * memory installed. (4MB on the 5434)
+	 */
 		mem *=3D 2;
-	}
+
 	/* TODO: Handling of GD5446/5480 (see XF86 sources ...) */
=20
-	DPRINTK ("EXIT\n");
+	DPRINTK("EXIT\n");
 	return mem;
 }
=20
-
-
-static void get_pci_addrs (const struct pci_dev *pdev,
-			   unsigned long *display, unsigned long *registers)
+static void get_pci_addrs(const struct pci_dev *pdev,
+			  unsigned long *display, unsigned long *registers)
 {
-	assert (pdev !=3D NULL);
-	assert (display !=3D NULL);
-	assert (registers !=3D NULL);
+	assert(pdev !=3D NULL);
+	assert(display !=3D NULL);
+	assert(registers !=3D NULL);
=20
-	DPRINTK ("ENTER\n");
+	DPRINTK("ENTER\n");
=20
 	*display =3D 0;
 	*registers =3D 0;
@@ -2198,13 +2358,12 @@ static void get_pci_addrs (const struct=20
 		*registers =3D pci_resource_start(pdev, 1);
 	}
=20
-	assert (*display !=3D 0);
+	assert(*display !=3D 0);
=20
-	DPRINTK ("EXIT\n");
+	DPRINTK("EXIT\n");
 }
=20
-
-static void cirrusfb_pci_unmap (struct cirrusfb_info *cinfo)
+static void cirrusfb_pci_unmap(struct cirrusfb_info *cinfo)
 {
 	struct pci_dev *pdev =3D cinfo->pdev;
=20
@@ -2219,19 +2378,18 @@ static void cirrusfb_pci_unmap (struct c
 }
 #endif /* CONFIG_PCI */
=20
-
 #ifdef CONFIG_ZORRO
-static void __devexit cirrusfb_zorro_unmap (struct cirrusfb_info=20
*cinfo)
+static void __devexit cirrusfb_zorro_unmap(struct cirrusfb_info=20
*cinfo)
 {
 	zorro_release_device(cinfo->zdev);
=20
 	if (cinfo->btype =3D=3D BT_PICASSO4) {
 		cinfo->regbase -=3D 0x600000;
-		iounmap ((void *)cinfo->regbase);
-		iounmap ((void *)cinfo->fbmem);
+		iounmap((void *)cinfo->regbase);
+		iounmap((void *)cinfo->fbmem);
 	} else {
 		if (zorro_resource_start(cinfo->zdev) > 0x01000000)
-			iounmap ((void *)cinfo->fbmem);
+			iounmap((void *)cinfo->fbmem);
 	}
 	framebuffer_release(cinfo->info);
 }
@@ -2267,7 +2425,8 @@ static int cirrusfb_set_fbinfo(struct ci
 	/* monochrome: only 1 memory plane */
 	/* 8 bit and above: Use whole memory area */
 	info->fix.smem_start =3D cinfo->fbmem_phys;
-	info->fix.smem_len   =3D (var->bits_per_pixel =3D=3D 1) ?=20
cinfo->size / 4 : cinfo->size;
+	info->fix.smem_len   =3D
+		(var->bits_per_pixel =3D=3D 1) ? cinfo->size / 4 :=20
cinfo->size;
 	info->fix.type       =3D cinfo->currentmode.type;
 	info->fix.type_aux   =3D 0;
 	info->fix.visual     =3D cinfo->currentmode.visual;
@@ -2292,17 +2451,18 @@ static int cirrusfb_register(struct cirr
 	int err;
 	cirrusfb_board_t btype;
=20
-	DPRINTK ("ENTER\n");
+	DPRINTK("ENTER\n");
=20
-	printk (KERN_INFO "cirrusfb: Driver for Cirrus Logic based=20
graphic boards, v" CIRRUSFB_VERSION "\n");
+	printk(KERN_INFO "cirrusfb: Driver for Cirrus Logic based "
+		"graphic boards, v" CIRRUSFB_VERSION "\n");
=20
 	info =3D cinfo->info;
 	btype =3D cinfo->btype;
=20
 	/* sanity checks */
-	assert (btype !=3D BT_NONE);
+	assert(btype !=3D BT_NONE);
=20
-	DPRINTK ("cirrusfb: (RAM start set to: 0x%p)\n",=20
cinfo->fbmem);
+	DPRINTK("cirrusfb: (RAM start set to: 0x%p)\n",=20
cinfo->fbmem);
=20
 	/* Make pretend we've set the var so our structures are in=20
a "good" */
 	/* state, even though we haven't written the mode to the hw=20
yet...  */
@@ -2321,11 +2481,12 @@ static int cirrusfb_register(struct cirr
=20
 	err =3D register_framebuffer(info);
 	if (err < 0) {
-		printk (KERN_ERR "cirrusfb: could not register fb=20
device; err =3D %d!\n", err);
+		printk(KERN_ERR "cirrusfb: could not register "
+			"fb device; err =3D %d!\n", err);
 		goto err_dealloc_cmap;
 	}
=20
-	DPRINTK ("EXIT, returning 0\n");
+	DPRINTK("EXIT, returning 0\n");
 	return 0;
=20
 err_dealloc_cmap:
@@ -2335,24 +2496,23 @@ err_unmap_cirrusfb:
 	return err;
 }
=20
-static void __devexit cirrusfb_cleanup (struct fb_info *info)
+static void __devexit cirrusfb_cleanup(struct fb_info *info)
 {
 	struct cirrusfb_info *cinfo =3D info->par;
-	DPRINTK ("ENTER\n");
+	DPRINTK("ENTER\n");
=20
-	switch_monitor (cinfo, 0);
+	switch_monitor(cinfo, 0);
=20
-	unregister_framebuffer (info);
-	fb_dealloc_cmap (&info->cmap);
-	printk ("Framebuffer unregistered\n");
+	unregister_framebuffer(info);
+	fb_dealloc_cmap(&info->cmap);
+	printk("Framebuffer unregistered\n");
 	cinfo->unmap(cinfo);
=20
-	DPRINTK ("EXIT\n");
+	DPRINTK("EXIT\n");
 }
=20
-
 #ifdef CONFIG_PCI
-static int cirrusfb_pci_register (struct pci_dev *pdev,
+static int cirrusfb_pci_register(struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
 {
 	struct cirrusfb_info *cinfo;
@@ -2379,31 +2539,34 @@ static int cirrusfb_pci_register (struct
 	cinfo->pdev =3D pdev;
 	cinfo->btype =3D btype =3D (cirrusfb_board_t) ent->driver_data;
=20
-	DPRINTK (" Found PCI device, base address 0 is 0x%lx, btype=20
set to %d\n",
+	DPRINTK(" Found PCI device, base address 0 is 0x%lx, btype=20
set to %d\n",
 		pdev->resource[0].start, btype);
-	DPRINTK (" base address 1 is 0x%lx\n", pdev->resource[1].
start);
+	DPRINTK(" base address 1 is 0x%lx\n", pdev->resource[1].
start);
=20
-	if(isPReP) {
-		pci_write_config_dword (pdev, PCI_BASE_ADDRESS_0,=20
0x00000000);
+	if (isPReP) {
+		pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0,=20
0x00000000);
 #ifdef CONFIG_PPC_PREP
-		get_prep_addrs (&board_addr, &cinfo->fbregs_phys);
+		get_prep_addrs(&board_addr, &cinfo->fbregs_phys);
 #endif
-		/* PReP dies if we ioremap the IO registers, but it=20
works w/out... */
+	/* PReP dies if we ioremap the IO registers, but it works=20
w/out... */
 		cinfo->regbase =3D (char __iomem *) cinfo->fbregs_phys;
 	} else {
-		DPRINTK ("Attempt to get PCI info for Cirrus Graphics=20
Card\n");
-		get_pci_addrs (pdev, &board_addr, &cinfo->fbregs_phys);
-		cinfo->regbase =3D NULL;		/* FIXME: this forces VGA.=20
 alternatives? */
+		DPRINTK("Attempt to get PCI info for Cirrus Graphics=20
Card\n");
+		get_pci_addrs(pdev, &board_addr, &cinfo->fbregs_phys);
+		/* FIXME: this forces VGA.  alternatives? */
+		cinfo->regbase =3D NULL;
 	}
=20
-	DPRINTK ("Board address: 0x%lx, register address: 0x%lx\n",=20
board_addr, cinfo->fbregs_phys);
+	DPRINTK("Board address: 0x%lx, register address: 0x%lx\n",
+		board_addr, cinfo->fbregs_phys);
=20
 	board_size =3D (btype =3D=3D BT_GD5480) ?
-		32 * MB_ : cirrusfb_get_memsize (cinfo->regbase);
+		32 * MB_ : cirrusfb_get_memsize(cinfo->regbase);
=20
 	ret =3D pci_request_regions(pdev, "cirrusfb");
-	if (ret <0) {
-		printk(KERN_ERR "cirrusfb: cannot reserve region 0x%lx,=20
abort\n",
+	if (ret < 0) {
+		printk(KERN_ERR "cirrusfb: cannot reserve region 0x%lx,=20
"
+		       "abort\n",
 		       board_addr);
 		goto err_release_fb;
 	}
@@ -2429,8 +2592,9 @@ static int cirrusfb_pci_register (struct
 	cinfo->size =3D board_size;
 	cinfo->unmap =3D cirrusfb_pci_unmap;
=20
-	printk (" RAM (%lu kB) at 0xx%lx, ", cinfo->size / KB_,=20
board_addr);
-	printk ("Cirrus Logic chipset on PCI bus\n");
+	printk(KERN_INFO " RAM (%lu kB) at 0xx%lx, ",
+		cinfo->size / KB_, board_addr);
+	printk(KERN_INFO "Cirrus Logic chipset on PCI bus\n");
 	pci_set_drvdata(pdev, info);
=20
 	ret =3D cirrusfb_register(cinfo);
@@ -2453,14 +2617,14 @@ err_out:
 	return ret;
 }
=20
-static void __devexit cirrusfb_pci_unregister (struct pci_dev=20
*pdev)
+static void __devexit cirrusfb_pci_unregister(struct pci_dev=20
*pdev)
 {
 	struct fb_info *info =3D pci_get_drvdata(pdev);
-	DPRINTK ("ENTER\n");
+	DPRINTK("ENTER\n");
=20
-	cirrusfb_cleanup (info);
+	cirrusfb_cleanup(info);
=20
-	DPRINTK ("EXIT\n");
+	DPRINTK("EXIT\n");
 }
=20
 static struct pci_driver cirrusfb_pci_driver =3D {
@@ -2477,7 +2641,6 @@ static struct pci_driver cirrusfb_pci_dr
 };
 #endif /* CONFIG_PCI */
=20
-
 #ifdef CONFIG_ZORRO
 static int cirrusfb_zorro_register(struct zorro_dev *z,
 				   const struct zorro_device_id *ent)
@@ -2498,7 +2661,7 @@ static int cirrusfb_zorro_register(struc
=20
 	info =3D framebuffer_alloc(sizeof(struct cirrusfb_info),=20
&z->dev);
 	if (!info) {
-		printk (KERN_ERR "cirrusfb: could not allocate=20
memory\n");
+		printk(KERN_ERR "cirrusfb: could not allocate memory\n")
;
 		ret =3D -ENOMEM;
 		goto err_out;
 	}
@@ -2507,9 +2670,9 @@ static int cirrusfb_zorro_register(struc
 	cinfo->info =3D info;
 	cinfo->btype =3D btype;
=20
-	assert (z > 0);
-	assert (z2 >=3D 0);
-	assert (btype !=3D BT_NONE);
+	assert(z > 0);
+	assert(z2 >=3D 0);
+	assert(btype !=3D BT_NONE);
=20
 	cinfo->zdev =3D z;
 	board_addr =3D zorro_resource_start(z);
@@ -2517,55 +2680,59 @@ static int cirrusfb_zorro_register(struc
 	cinfo->size =3D size;
=20
 	if (!zorro_request_device(z, "cirrusfb")) {
-		printk(KERN_ERR "cirrusfb: cannot reserve region 0x%lx,=20
abort\n",
+		printk(KERN_ERR "cirrusfb: cannot reserve region 0x%lx,=20
"
+		       "abort\n",
 		       board_addr);
 		ret =3D -EBUSY;
 		goto err_release_fb;
 	}
=20
-	printk (" RAM (%lu MB) at $%lx, ", board_size / MB_,=20
board_addr);
+	printk(" RAM (%lu MB) at $%lx, ", board_size / MB_,=20
board_addr);
=20
 	ret =3D -EIO;
=20
 	if (btype =3D=3D BT_PICASSO4) {
-		printk (" REG at $%lx\n", board_addr + 0x600000);
+		printk(KERN_INFO " REG at $%lx\n", board_addr +=20
0x600000);
=20
 		/* To be precise, for the P4 this is not the */
 		/* begin of the board, but the begin of RAM. */
 		/* for P4, map in its address space in 2 chunks (###=20
TEST! ) */
 		/* (note the ugly hardcoded 16M number) */
-		cinfo->regbase =3D ioremap (board_addr, 16777216);
+		cinfo->regbase =3D ioremap(board_addr, 16777216);
 		if (!cinfo->regbase)
 			goto err_release_region;
=20
-		DPRINTK ("cirrusfb: Virtual address for board set to: $%
p\n", cinfo->regbase);
+		DPRINTK("cirrusfb: Virtual address for board set to: $%
p\n",
+			cinfo->regbase);
 		cinfo->regbase +=3D 0x600000;
 		cinfo->fbregs_phys =3D board_addr + 0x600000;
=20
 		cinfo->fbmem_phys =3D board_addr + 16777216;
-		cinfo->fbmem =3D ioremap (cinfo->fbmem_phys, 16777216);
+		cinfo->fbmem =3D ioremap(cinfo->fbmem_phys, 16777216);
 		if (!cinfo->fbmem)
 			goto err_unmap_regbase;
 	} else {
-		printk (" REG at $%lx\n", (unsigned long) z2->resource.
start);
+		printk(KERN_INFO " REG at $%lx\n",
+			(unsigned long) z2->resource.start);
=20
 		cinfo->fbmem_phys =3D board_addr;
 		if (board_addr > 0x01000000)
-			cinfo->fbmem =3D ioremap (board_addr, board_size);
+			cinfo->fbmem =3D ioremap(board_addr, board_size);
 		else
-			cinfo->fbmem =3D (caddr_t) ZTWO_VADDR (board_addr);
+			cinfo->fbmem =3D (caddr_t) ZTWO_VADDR(board_addr);
 		if (!cinfo->fbmem)
 			goto err_release_region;
=20
 		/* set address for REG area of board */
-		cinfo->regbase =3D (caddr_t) ZTWO_VADDR (z2->resource.
start);
+		cinfo->regbase =3D (caddr_t) ZTWO_VADDR(z2->resource.
start);
 		cinfo->fbregs_phys =3D z2->resource.start;
=20
-		DPRINTK ("cirrusfb: Virtual address for board set to: $%
p\n", cinfo->regbase);
+		DPRINTK("cirrusfb: Virtual address for board set to: $%
p\n",
+			cinfo->regbase);
 	}
 	cinfo->unmap =3D cirrusfb_zorro_unmap;
=20
-	printk (KERN_INFO "Cirrus Logic chipset on Zorro bus\n");
+	printk(KERN_INFO "Cirrus Logic chipset on Zorro bus\n");
 	zorro_set_drvdata(z, info);
=20
 	ret =3D cirrusfb_register(cinfo);
@@ -2592,11 +2759,11 @@ err_out:
 void __devexit cirrusfb_zorro_unregister(struct zorro_dev *z)
 {
 	struct fb_info *info =3D zorro_get_drvdata(z);
-	DPRINTK ("ENTER\n");
+	DPRINTK("ENTER\n");
=20
-	cirrusfb_cleanup (info);
+	cirrusfb_cleanup(info);
=20
-	DPRINTK ("EXIT\n");
+	DPRINTK("EXIT\n");
 }
=20
 static struct zorro_driver cirrusfb_zorro_driver =3D {
@@ -2628,26 +2795,24 @@ static int __init cirrusfb_init(void)
 	return error;
 }
=20
-
-
 #ifndef MODULE
 static int __init cirrusfb_setup(char *options) {
 	char *this_opt, s[32];
 	int i;
=20
-	DPRINTK ("ENTER\n");
+	DPRINTK("ENTER\n");
=20
 	if (!options || !*options)
 		return 0;
=20
-	while ((this_opt =3D strsep (&options, ",")) !=3D NULL) {=09
+	while ((this_opt =3D strsep(&options, ",")) !=3D NULL) {
 		if (!*this_opt) continue;
=20
 		DPRINTK("cirrusfb_setup: option '%s'\n", this_opt);
=20
 		for (i =3D 0; i < NUM_TOTAL_MODES; i++) {
-			sprintf (s, "mode:%s", cirrusfb_predefined[i].name);
-			if (strcmp (this_opt, s) =3D=3D 0)
+			sprintf(s, "mode:%s", cirrusfb_predefined[i].name);
+			if (strcmp(this_opt, s) =3D=3D 0)
 				cirrusfb_def_mode =3D i;
 		}
 		if (!strcmp(this_opt, "noaccel"))
@@ -2657,7 +2822,6 @@ static int __init cirrusfb_setup(char *o
 }
 #endif
=20
-
     /*
      *  Modularization
      */
@@ -2666,7 +2830,7 @@ MODULE_AUTHOR("Copyright 1999,2000 Jeff=20
 MODULE_DESCRIPTION("Accelerated FBDev driver for Cirrus Logic=20
chips");
 MODULE_LICENSE("GPL");
=20
-static void __exit cirrusfb_exit (void)
+static void __exit cirrusfb_exit(void)
 {
 #ifdef CONFIG_PCI
 	pci_unregister_driver(&cirrusfb_pci_driver);
@@ -2682,66 +2846,67 @@ module_init(cirrusfb_init);
 module_exit(cirrusfb_exit);
 #endif
=20
-
=20
/****************************************************************
******/
 /* about the following functions - I have used the same names=20
for the */
 /* functions as Markus Wild did in his Retina driver for NetBSD=20
as    */
 /* they just made sense for this purpose. Apart from that, I=20
wrote    */
-/* these functions myself.                                      =20
     */
+/* these functions myself.					    */
=20
/****************************************************************
******/
=20
 /*** WGen() - write into one of the external/general registers=20
***/
-static void WGen (const struct cirrusfb_info *cinfo,
+static void WGen(const struct cirrusfb_info *cinfo,
 		  int regnum, unsigned char val)
 {
 	unsigned long regofs =3D 0;
=20
 	if (cinfo->btype =3D=3D BT_PICASSO) {
 		/* Picasso II specific hack */
-/*              if (regnum =3D=3D VGA_PEL_IR || regnum =3D=3D VGA_PEL_D=20
|| regnum =3D=3D CL_VSSM2) */
+/*	      if (regnum =3D=3D VGA_PEL_IR || regnum =3D=3D VGA_PEL_D ||
+		  regnum =3D=3D CL_VSSM2) */
 		if (regnum =3D=3D VGA_PEL_IR || regnum =3D=3D VGA_PEL_D)
 			regofs =3D 0xfff;
 	}
=20
-	vga_w (cinfo->regbase, regofs + regnum, val);
+	vga_w(cinfo->regbase, regofs + regnum, val);
 }
=20
 /*** RGen() - read out one of the external/general registers=20
***/
-static unsigned char RGen (const struct cirrusfb_info *cinfo,=20
int regnum)
+static unsigned char RGen(const struct cirrusfb_info *cinfo, int=20
regnum)
 {
 	unsigned long regofs =3D 0;
=20
 	if (cinfo->btype =3D=3D BT_PICASSO) {
 		/* Picasso II specific hack */
-/*              if (regnum =3D=3D VGA_PEL_IR || regnum =3D=3D VGA_PEL_D=20
|| regnum =3D=3D CL_VSSM2) */
+/*	      if (regnum =3D=3D VGA_PEL_IR || regnum =3D=3D VGA_PEL_D ||
+		  regnum =3D=3D CL_VSSM2) */
 		if (regnum =3D=3D VGA_PEL_IR || regnum =3D=3D VGA_PEL_D)
 			regofs =3D 0xfff;
 	}
=20
-	return vga_r (cinfo->regbase, regofs + regnum);
+	return vga_r(cinfo->regbase, regofs + regnum);
 }
=20
 /*** AttrOn() - turn on VideoEnable for Attribute controller=20
***/
-static void AttrOn (const struct cirrusfb_info *cinfo)
+static void AttrOn(const struct cirrusfb_info *cinfo)
 {
-	assert (cinfo !=3D NULL);
+	assert(cinfo !=3D NULL);
=20
-	DPRINTK ("ENTER\n");
+	DPRINTK("ENTER\n");
=20
-	if (vga_rcrt (cinfo->regbase, CL_CRT24) & 0x80) {
+	if (vga_rcrt(cinfo->regbase, CL_CRT24) & 0x80) {
 		/* if we're just in "write value" mode, write back the=20
*/
 		/* same value as before to not modify anything */
-		vga_w (cinfo->regbase, VGA_ATT_IW,
-		       vga_r (cinfo->regbase, VGA_ATT_R));
+		vga_w(cinfo->regbase, VGA_ATT_IW,
+		      vga_r(cinfo->regbase, VGA_ATT_R));
 	}
 	/* turn on video bit */
-/*      vga_w (cinfo->regbase, VGA_ATT_IW, 0x20); */
-	vga_w (cinfo->regbase, VGA_ATT_IW, 0x33);
+/*      vga_w(cinfo->regbase, VGA_ATT_IW, 0x20); */
+	vga_w(cinfo->regbase, VGA_ATT_IW, 0x33);
=20
 	/* dummy write on Reg0 to be on "write index" mode next=20
time */
-	vga_w (cinfo->regbase, VGA_ATT_IW, 0x00);
+	vga_w(cinfo->regbase, VGA_ATT_IW, 0x00);
=20
-	DPRINTK ("EXIT\n");
+	DPRINTK("EXIT\n");
 }
=20
 /*** WHDR() - write into the Hidden DAC register ***/
@@ -2750,119 +2915,115 @@ static void AttrOn (const struct=20
cirrusf
  * registers of their functional group) here is a specialized=20
routine for
  * accessing the HDR
  */
-static void WHDR (const struct cirrusfb_info *cinfo, unsigned=20
char val)
+static void WHDR(const struct cirrusfb_info *cinfo, unsigned=20
char val)
 {
 	unsigned char dummy;
=20
 	if (cinfo->btype =3D=3D BT_PICASSO) {
 		/* Klaus' hint for correct access to HDR on some boards=20
*/
 		/* first write 0 to pixel mask (3c6) */
-		WGen (cinfo, VGA_PEL_MSK, 0x00);
-		udelay (200);
+		WGen(cinfo, VGA_PEL_MSK, 0x00);
+		udelay(200);
 		/* next read dummy from pixel address (3c8) */
-		dummy =3D RGen (cinfo, VGA_PEL_IW);
-		udelay (200);
+		dummy =3D RGen(cinfo, VGA_PEL_IW);
+		udelay(200);
 	}
 	/* now do the usual stuff to access the HDR */
=20
-	dummy =3D RGen (cinfo, VGA_PEL_MSK);
-	udelay (200);
-	dummy =3D RGen (cinfo, VGA_PEL_MSK);
-	udelay (200);
-	dummy =3D RGen (cinfo, VGA_PEL_MSK);
-	udelay (200);
-	dummy =3D RGen (cinfo, VGA_PEL_MSK);
-	udelay (200);
+	dummy =3D RGen(cinfo, VGA_PEL_MSK);
+	udelay(200);
+	dummy =3D RGen(cinfo, VGA_PEL_MSK);
+	udelay(200);
+	dummy =3D RGen(cinfo, VGA_PEL_MSK);
+	udelay(200);
+	dummy =3D RGen(cinfo, VGA_PEL_MSK);
+	udelay(200);
=20
-	WGen (cinfo, VGA_PEL_MSK, val);
-	udelay (200);
+	WGen(cinfo, VGA_PEL_MSK, val);
+	udelay(200);
=20
 	if (cinfo->btype =3D=3D BT_PICASSO) {
 		/* now first reset HDR access counter */
-		dummy =3D RGen (cinfo, VGA_PEL_IW);
-		udelay (200);
+		dummy =3D RGen(cinfo, VGA_PEL_IW);
+		udelay(200);
=20
 		/* and at the end, restore the mask value */
 		/* ## is this mask always 0xff? */
-		WGen (cinfo, VGA_PEL_MSK, 0xff);
-		udelay (200);
+		WGen(cinfo, VGA_PEL_MSK, 0xff);
+		udelay(200);
 	}
 }
=20
-
 /*** WSFR() - write to the "special function register" (SFR)=20
***/
-static void WSFR (struct cirrusfb_info *cinfo, unsigned char=20
val)
+static void WSFR(struct cirrusfb_info *cinfo, unsigned char val)
 {
 #ifdef CONFIG_ZORRO
-	assert (cinfo->regbase !=3D NULL);
+	assert(cinfo->regbase !=3D NULL);
 	cinfo->SFR =3D val;
-	z_writeb (val, cinfo->regbase + 0x8000);
+	z_writeb(val, cinfo->regbase + 0x8000);
 #endif
 }
=20
 /* The Picasso has a second register for switching the monitor=20
bit */
-static void WSFR2 (struct cirrusfb_info *cinfo, unsigned char=20
val)
+static void WSFR2(struct cirrusfb_info *cinfo, unsigned char=20
val)
 {
 #ifdef CONFIG_ZORRO
 	/* writing an arbitrary value to this one causes the=20
monitor switcher */
 	/* to flip to Amiga display */
-	assert (cinfo->regbase !=3D NULL);
+	assert(cinfo->regbase !=3D NULL);
 	cinfo->SFR =3D val;
-	z_writeb (val, cinfo->regbase + 0x9000);
+	z_writeb(val, cinfo->regbase + 0x9000);
 #endif
 }
=20
-
 /*** WClut - set CLUT entry (range: 0..63) ***/
-static void WClut (struct cirrusfb_info *cinfo, unsigned char=20
regnum, unsigned char red,
+static void WClut(struct cirrusfb_info *cinfo, unsigned char=20
regnum, unsigned char red,
 	    unsigned char green, unsigned char blue)
 {
 	unsigned int data =3D VGA_PEL_D;
=20
 	/* address write mode register is not translated.. */
-	vga_w (cinfo->regbase, VGA_PEL_IW, regnum);
+	vga_w(cinfo->regbase, VGA_PEL_IW, regnum);
=20
 	if (cinfo->btype =3D=3D BT_PICASSO || cinfo->btype =3D=3D=20
BT_PICASSO4 ||
 	    cinfo->btype =3D=3D BT_ALPINE || cinfo->btype =3D=3D BT_GD5480) {
 		/* but DAC data register IS, at least for Picasso II */
 		if (cinfo->btype =3D=3D BT_PICASSO)
 			data +=3D 0xfff;
-		vga_w (cinfo->regbase, data, red);
-		vga_w (cinfo->regbase, data, green);
-		vga_w (cinfo->regbase, data, blue);
+		vga_w(cinfo->regbase, data, red);
+		vga_w(cinfo->regbase, data, green);
+		vga_w(cinfo->regbase, data, blue);
 	} else {
-		vga_w (cinfo->regbase, data, blue);
-		vga_w (cinfo->regbase, data, green);
-		vga_w (cinfo->regbase, data, red);
+		vga_w(cinfo->regbase, data, blue);
+		vga_w(cinfo->regbase, data, green);
+		vga_w(cinfo->regbase, data, red);
 	}
 }
=20
-
 #if 0
 /*** RClut - read CLUT entry (range 0..63) ***/
-static void RClut (struct cirrusfb_info *cinfo, unsigned char=20
regnum, unsigned char *red,
+static void RClut(struct cirrusfb_info *cinfo, unsigned char=20
regnum, unsigned char *red,
 	    unsigned char *green, unsigned char *blue)
 {
 	unsigned int data =3D VGA_PEL_D;
=20
-	vga_w (cinfo->regbase, VGA_PEL_IR, regnum);
+	vga_w(cinfo->regbase, VGA_PEL_IR, regnum);
=20
 	if (cinfo->btype =3D=3D BT_PICASSO || cinfo->btype =3D=3D=20
BT_PICASSO4 ||
 	    cinfo->btype =3D=3D BT_ALPINE || cinfo->btype =3D=3D BT_GD5480) {
 		if (cinfo->btype =3D=3D BT_PICASSO)
 			data +=3D 0xfff;
-		*red =3D vga_r (cinfo->regbase, data);
-		*green =3D vga_r (cinfo->regbase, data);
-		*blue =3D vga_r (cinfo->regbase, data);
+		*red =3D vga_r(cinfo->regbase, data);
+		*green =3D vga_r(cinfo->regbase, data);
+		*blue =3D vga_r(cinfo->regbase, data);
 	} else {
-		*blue =3D vga_r (cinfo->regbase, data);
-		*green =3D vga_r (cinfo->regbase, data);
-		*red =3D vga_r (cinfo->regbase, data);
+		*blue =3D vga_r(cinfo->regbase, data);
+		*green =3D vga_r(cinfo->regbase, data);
+		*red =3D vga_r(cinfo->regbase, data);
 	}
 }
 #endif
=20
-
=20
/****************************************************************
***
 	cirrusfb_WaitBLT()
=20
@@ -2870,10 +3031,10 @@ static void RClut (struct cirrusfb_info=20
=20
*****************************************************************
****/
=20
 /* FIXME: use interrupts instead */
-static void cirrusfb_WaitBLT (u8 __iomem *regbase)
+static void cirrusfb_WaitBLT(u8 __iomem *regbase)
 {
 	/* now busy-wait until we're done */
-	while (vga_rgfx (regbase, CL_GR31) & 0x08)
+	while (vga_rgfx(regbase, CL_GR31) & 0x08)
 		/* do nothing */ ;
 }
=20
@@ -2883,15 +3044,17 @@ static void cirrusfb_WaitBLT (u8 __iomem
 	perform accelerated "scrolling"
=20
*****************************************************************
***/
=20
-static void cirrusfb_BitBLT (u8 __iomem *regbase, int=20
bits_per_pixel,
-			     u_short curx, u_short cury, u_short destx, u_short=20
desty,
-			     u_short width, u_short height, u_short=20
line_length)
+static void cirrusfb_BitBLT(u8 __iomem *regbase, int=20
bits_per_pixel,
+			    u_short curx, u_short cury,
+			    u_short destx, u_short desty,
+			    u_short width, u_short height,
+			    u_short line_length)
 {
 	u_short nwidth, nheight;
 	u_long nsrc, ndest;
 	u_char bltmode;
=20
-	DPRINTK ("ENTER\n");
+	DPRINTK("ENTER\n");
=20
 	nwidth =3D width - 1;
 	nheight =3D height - 1;
@@ -2911,9 +3074,13 @@ static void cirrusfb_BitBLT (u8 __iomem=20
 		nsrc =3D (cury * line_length) + curx;
 		ndest =3D (desty * line_length) + destx;
 	} else {
-		/* this means start addresses are at the end, counting=20
backwards */
-		nsrc =3D cury * line_length + curx + nheight * line_length=20
+ nwidth;
-		ndest =3D desty * line_length + destx + nheight *=20
line_length + nwidth;
+		/* this means start addresses are at the end,
+		 * counting backwards
+		 */
+		nsrc =3D cury * line_length + curx +
+			nheight * line_length + nwidth;
+		ndest =3D desty * line_length + destx +
+			nheight * line_length + nwidth;
 	}
=20
 	/*
@@ -2929,52 +3096,65 @@ static void cirrusfb_BitBLT (u8 __iomem=20
 	   start/stop
 	 */
=20
-        cirrusfb_WaitBLT(regbase);
+	cirrusfb_WaitBLT(regbase);
=20
 	/* pitch: set to line_length */
-	vga_wgfx (regbase, CL_GR24, line_length & 0xff);	/*=20
dest pitch low */
-	vga_wgfx (regbase, CL_GR25, (line_length >> 8));	/*=20
dest pitch hi */
-	vga_wgfx (regbase, CL_GR26, line_length & 0xff);	/*=20
source pitch low */
-	vga_wgfx (regbase, CL_GR27, (line_length >> 8));	/*=20
source pitch hi */
+	/* dest pitch low */
+	vga_wgfx(regbase, CL_GR24, line_length & 0xff);
+	/* dest pitch hi */
+	vga_wgfx(regbase, CL_GR25, line_length >> 8);
+	/* source pitch low */
+	vga_wgfx(regbase, CL_GR26, line_length & 0xff);
+	/* source pitch hi */
+	vga_wgfx(regbase, CL_GR27, line_length >> 8);
=20
 	/* BLT width: actual number of pixels - 1 */
-	vga_wgfx (regbase, CL_GR20, nwidth & 0xff);	/* BLT=20
width low */
-	vga_wgfx (regbase, CL_GR21, (nwidth >> 8));	/* BLT=20
width hi */
+	/* BLT width low */
+	vga_wgfx(regbase, CL_GR20, nwidth & 0xff);
+	/* BLT width hi */
+	vga_wgfx(regbase, CL_GR21, nwidth >> 8);
=20
 	/* BLT height: actual number of lines -1 */
-	vga_wgfx (regbase, CL_GR22, nheight & 0xff);	/* BLT=20
height low */
-	vga_wgfx (regbase, CL_GR23, (nheight >> 8));	/* BLT=20
width hi */
+	/* BLT height low */
+	vga_wgfx(regbase, CL_GR22, nheight & 0xff);
+	/* BLT width hi */
+	vga_wgfx(regbase, CL_GR23, nheight >> 8);
=20
 	/* BLT destination */
-	vga_wgfx (regbase, CL_GR28, (u_char) (ndest & 0xff));
	/* BLT dest low */
-	vga_wgfx (regbase, CL_GR29, (u_char) (ndest >> 8));	/*=20
BLT dest mid */
-	vga_wgfx (regbase, CL_GR2A, (u_char) (ndest >> 16));	/*=20
BLT dest hi */
+	/* BLT dest low */
+	vga_wgfx(regbase, CL_GR28, (u_char) (ndest & 0xff));
+	/* BLT dest mid */
+	vga_wgfx(regbase, CL_GR29, (u_char) (ndest >> 8));
+	/* BLT dest hi */
+	vga_wgfx(regbase, CL_GR2A, (u_char) (ndest >> 16));
=20
 	/* BLT source */
-	vga_wgfx (regbase, CL_GR2C, (u_char) (nsrc & 0xff));	/*=20
BLT src low */
-	vga_wgfx (regbase, CL_GR2D, (u_char) (nsrc >> 8));
		/* BLT src mid */
-	vga_wgfx (regbase, CL_GR2E, (u_char) (nsrc >> 16));	/*=20
BLT src hi */
+	/* BLT src low */
+	vga_wgfx(regbase, CL_GR2C, (u_char) (nsrc & 0xff));
+	/* BLT src mid */
+	vga_wgfx(regbase, CL_GR2D, (u_char) (nsrc >> 8));
+	/* BLT src hi */
+	vga_wgfx(regbase, CL_GR2E, (u_char) (nsrc >> 16));
=20
 	/* BLT mode */
-	vga_wgfx (regbase, CL_GR30, bltmode);	/* BLT mode */
+	vga_wgfx(regbase, CL_GR30, bltmode);	/* BLT mode */
=20
 	/* BLT ROP: SrcCopy */
-	vga_wgfx (regbase, CL_GR32, 0x0d);		/* BLT ROP */
+	vga_wgfx(regbase, CL_GR32, 0x0d);	/* BLT ROP */
=20
 	/* and finally: GO! */
-	vga_wgfx (regbase, CL_GR31, 0x02);		/* BLT=20
Start/status */
+	vga_wgfx(regbase, CL_GR31, 0x02);	/* BLT Start/status=20
*/
=20
-	DPRINTK ("EXIT\n");
+	DPRINTK("EXIT\n");
 }
=20
-
=20
/****************************************************************
***
 	cirrusfb_RectFill()
=20
 	perform accelerated rectangle fill
=20
*****************************************************************
***/
=20
-static void cirrusfb_RectFill (u8 __iomem *regbase, int=20
bits_per_pixel,
+static void cirrusfb_RectFill(u8 __iomem *regbase, int=20
bits_per_pixel,
 		     u_short x, u_short y, u_short width, u_short height,
 		     u_char color, u_short line_length)
 {
@@ -2982,93 +3162,95 @@ static void cirrusfb_RectFill (u8 __iome
 	u_long ndest;
 	u_char op;
=20
-	DPRINTK ("ENTER\n");
+	DPRINTK("ENTER\n");
=20
 	nwidth =3D width - 1;
 	nheight =3D height - 1;
=20
 	ndest =3D (y * line_length) + x;
=20
-        cirrusfb_WaitBLT(regbase);
+	cirrusfb_WaitBLT(regbase);
=20
 	/* pitch: set to line_length */
-	vga_wgfx (regbase, CL_GR24, line_length & 0xff);	/*=20
dest pitch low */
-	vga_wgfx (regbase, CL_GR25, (line_length >> 8));	/*=20
dest pitch hi */
-	vga_wgfx (regbase, CL_GR26, line_length & 0xff);	/*=20
source pitch low */
-	vga_wgfx (regbase, CL_GR27, (line_length >> 8));	/*=20
source pitch hi */
+	vga_wgfx(regbase, CL_GR24, line_length & 0xff);	/* dest=20
pitch low */
+	vga_wgfx(regbase, CL_GR25, line_length >> 8);	/* dest=20
pitch hi */
+	vga_wgfx(regbase, CL_GR26, line_length & 0xff);	/*=20
source pitch low */
+	vga_wgfx(regbase, CL_GR27, line_length >> 8);	/* source=20
pitch hi */
=20
 	/* BLT width: actual number of pixels - 1 */
-	vga_wgfx (regbase, CL_GR20, nwidth & 0xff);	/* BLT=20
width low */
-	vga_wgfx (regbase, CL_GR21, (nwidth >> 8));	/* BLT=20
width hi */
+	vga_wgfx(regbase, CL_GR20, nwidth & 0xff);	/* BLT width=20
low */
+	vga_wgfx(regbase, CL_GR21, nwidth >> 8);	/* BLT width=20
hi */
=20
 	/* BLT height: actual number of lines -1 */
-	vga_wgfx (regbase, CL_GR22, nheight & 0xff);		/* BLT=20
height low */
-	vga_wgfx (regbase, CL_GR23, (nheight >> 8));		/* BLT=20
width hi */
+	vga_wgfx(regbase, CL_GR22, nheight & 0xff);	/* BLT=20
height low */
+	vga_wgfx(regbase, CL_GR23, nheight >> 8);	/* BLT width=20
hi */
=20
 	/* BLT destination */
-	vga_wgfx (regbase, CL_GR28, (u_char) (ndest & 0xff));
	/* BLT dest low */
-	vga_wgfx (regbase, CL_GR29, (u_char) (ndest >> 8));	/*=20
BLT dest mid */
-	vga_wgfx (regbase, CL_GR2A, (u_char) (ndest >> 16));
		/* BLT dest hi */
+	/* BLT dest low */
+	vga_wgfx(regbase, CL_GR28, (u_char) (ndest & 0xff));
+	/* BLT dest mid */
+	vga_wgfx(regbase, CL_GR29, (u_char) (ndest >> 8));
+	/* BLT dest hi */
+	vga_wgfx(regbase, CL_GR2A, (u_char) (ndest >> 16));
=20
 	/* BLT source: set to 0 (is a dummy here anyway) */
-	vga_wgfx (regbase, CL_GR2C, 0x00);	/* BLT src low */
-	vga_wgfx (regbase, CL_GR2D, 0x00);	/* BLT src mid */
-	vga_wgfx (regbase, CL_GR2E, 0x00);	/* BLT src hi */
+	vga_wgfx(regbase, CL_GR2C, 0x00);	/* BLT src low */
+	vga_wgfx(regbase, CL_GR2D, 0x00);	/* BLT src mid */
+	vga_wgfx(regbase, CL_GR2E, 0x00);	/* BLT src hi */
=20
 	/* This is a ColorExpand Blt, using the */
 	/* same color for foreground and background */
-	vga_wgfx (regbase, VGA_GFX_SR_VALUE, color);	/*=20
foreground color */
-	vga_wgfx (regbase, VGA_GFX_SR_ENABLE, color);	/*=20
background color */
+	vga_wgfx(regbase, VGA_GFX_SR_VALUE, color);	/*=20
foreground color */
+	vga_wgfx(regbase, VGA_GFX_SR_ENABLE, color);	/*=20
background color */
=20
 	op =3D 0xc0;
 	if (bits_per_pixel =3D=3D 16) {
-		vga_wgfx (regbase, CL_GR10, color);	/* foreground=20
color */
-		vga_wgfx (regbase, CL_GR11, color);	/* background=20
color */
+		vga_wgfx(regbase, CL_GR10, color);	/* foreground=20
color */
+		vga_wgfx(regbase, CL_GR11, color);	/* background=20
color */
 		op =3D 0x50;
 		op =3D 0xd0;
 	} else if (bits_per_pixel =3D=3D 32) {
-		vga_wgfx (regbase, CL_GR10, color);	/* foreground=20
color */
-		vga_wgfx (regbase, CL_GR11, color);	/* background=20
color */
-		vga_wgfx (regbase, CL_GR12, color);	/* foreground=20
color */
-		vga_wgfx (regbase, CL_GR13, color);	/* background=20
color */
-		vga_wgfx (regbase, CL_GR14, 0);	/* foreground color=20
*/
-		vga_wgfx (regbase, CL_GR15, 0);	/* background color=20
*/
+		vga_wgfx(regbase, CL_GR10, color);	/* foreground=20
color */
+		vga_wgfx(regbase, CL_GR11, color);	/* background=20
color */
+		vga_wgfx(regbase, CL_GR12, color);	/* foreground=20
color */
+		vga_wgfx(regbase, CL_GR13, color);	/* background=20
color */
+		vga_wgfx(regbase, CL_GR14, 0);	/* foreground color=20
*/
+		vga_wgfx(regbase, CL_GR15, 0);	/* background color=20
*/
 		op =3D 0x50;
 		op =3D 0xf0;
 	}
 	/* BLT mode: color expand, Enable 8x8 copy (faster?) */
-	vga_wgfx (regbase, CL_GR30, op);	/* BLT mode */
+	vga_wgfx(regbase, CL_GR30, op);	/* BLT mode */
=20
 	/* BLT ROP: SrcCopy */
-	vga_wgfx (regbase, CL_GR32, 0x0d);	/* BLT ROP */
+	vga_wgfx(regbase, CL_GR32, 0x0d);	/* BLT ROP */
=20
 	/* and finally: GO! */
-	vga_wgfx (regbase, CL_GR31, 0x02);	/* BLT Start/status=20
*/
+	vga_wgfx(regbase, CL_GR31, 0x02);	/* BLT Start/status=20
*/
=20
-	DPRINTK ("EXIT\n");
+	DPRINTK("EXIT\n");
 }
=20
-
=20
/****************************************************************
**********
  * bestclock() - determine closest possible clock lower(?) than=20
the
  * desired pixel clock
 =20
*****************************************************************
*********/
-static void bestclock (long freq, long *best, long *nom,
+static void bestclock(long freq, long *best, long *nom,
 		       long *den, long *div, long maxfreq)
 {
 	long n, h, d, f;
=20
-	assert (best !=3D NULL);
-	assert (nom !=3D NULL);
-	assert (den !=3D NULL);
-	assert (div !=3D NULL);
-	assert (maxfreq > 0);
+	assert(best !=3D NULL);
+	assert(nom !=3D NULL);
+	assert(den !=3D NULL);
+	assert(div !=3D NULL);
+	assert(maxfreq > 0);
=20
 	*nom =3D 0;
 	*den =3D 0;
 	*div =3D 0;
=20
-	DPRINTK ("ENTER\n");
+	DPRINTK("ENTER\n");
=20
 	if (freq < 8000)
 		freq =3D 8000;
@@ -3085,7 +3267,7 @@ static void bestclock (long freq, long *
 			if (d > 31)
 				d =3D (d / 2) * 2;
 			h =3D (14318 * n) / d;
-			if (abs (h - freq) < abs (*best - freq)) {
+			if (abs(h - freq) < abs(*best - freq)) {
 				*best =3D h;
 				*nom =3D n;
 				if (d < 32) {
@@ -3102,7 +3284,7 @@ static void bestclock (long freq, long *
 			if (d > 31)
 				d =3D (d / 2) * 2;
 			h =3D (14318 * n) / d;
-			if (abs (h - freq) < abs (*best - freq)) {
+			if (abs(h - freq) < abs(*best - freq)) {
 				*best =3D h;
 				*nom =3D n;
 				if (d < 32) {
@@ -3116,14 +3298,13 @@ static void bestclock (long freq, long *
 		}
 	}
=20
-	DPRINTK ("Best possible values for given frequency:\n");
-	DPRINTK ("        best: %ld kHz  nom: %ld  den: %ld  div: %
ld\n",
-		 freq, *nom, *den, *div);
+	DPRINTK("Best possible values for given frequency:\n");
+	DPRINTK("	best: %ld kHz  nom: %ld  den: %ld  div: %
ld\n",
+		freq, *nom, *den, *div);
=20
-	DPRINTK ("EXIT\n");
+	DPRINTK("EXIT\n");
 }
=20
-
 /*=20
-----------------------------------------------------------------
--------
  *
  * debugging functions
@@ -3145,21 +3326,20 @@ static void bestclock (long freq, long *
  */
=20
 static
-void cirrusfb_dbg_print_byte (const char *name, unsigned char=20
val)
+void cirrusfb_dbg_print_byte(const char *name, unsigned char=20
val)
 {
-	DPRINTK ("%8s =3D 0x%02X (bits 7-0: %c%c%c%c%c%c%c%c)\n",
-		 name, val,
-		 val & 0x80 ? '1' : '0',
-		 val & 0x40 ? '1' : '0',
-		 val & 0x20 ? '1' : '0',
-		 val & 0x10 ? '1' : '0',
-		 val & 0x08 ? '1' : '0',
-		 val & 0x04 ? '1' : '0',
-		 val & 0x02 ? '1' : '0',
-		 val & 0x01 ? '1' : '0');
+	DPRINTK("%8s =3D 0x%02X (bits 7-0: %c%c%c%c%c%c%c%c)\n",
+		name, val,
+		val & 0x80 ? '1' : '0',
+		val & 0x40 ? '1' : '0',
+		val & 0x20 ? '1' : '0',
+		val & 0x10 ? '1' : '0',
+		val & 0x08 ? '1' : '0',
+		val & 0x04 ? '1' : '0',
+		val & 0x02 ? '1' : '0',
+		val & 0x01 ? '1' : '0');
 }
=20
-
 /**
  * cirrusfb_dbg_print_regs
  * @base: If using newmmio, the newmmio base address, otherwise=20
%NULL
@@ -3172,25 +3352,26 @@ void cirrusfb_dbg_print_byte (const char
  */
=20
 static
-void cirrusfb_dbg_print_regs (caddr_t regbase,=20
cirrusfb_dbg_reg_class_t reg_class,...)
+void cirrusfb_dbg_print_regs(caddr_t regbase,
+			     cirrusfb_dbg_reg_class_t reg_class, ...)
 {
 	va_list list;
 	unsigned char val =3D 0;
 	unsigned reg;
 	char *name;
=20
-	va_start (list, reg_class);
+	va_start(list, reg_class);
=20
-	name =3D va_arg (list, char *);
+	name =3D va_arg(list, char *);
 	while (name !=3D NULL) {
-		reg =3D va_arg (list, int);
+		reg =3D va_arg(list, int);
=20
 		switch (reg_class) {
 		case CRT:
-			val =3D vga_rcrt (regbase, (unsigned char) reg);
+			val =3D vga_rcrt(regbase, (unsigned char) reg);
 			break;
 		case SEQ:
-			val =3D vga_rseq (regbase, (unsigned char) reg);
+			val =3D vga_rseq(regbase, (unsigned char) reg);
 			break;
 		default:
 			/* should never occur */
@@ -3198,15 +3379,14 @@ void cirrusfb_dbg_print_regs (caddr_t re
 			break;
 		}
=20
-		cirrusfb_dbg_print_byte (name, val);
+		cirrusfb_dbg_print_byte(name, val);
=20
-		name =3D va_arg (list, char *);
+		name =3D va_arg(list, char *);
 	}
=20
-	va_end (list);
+	va_end(list);
 }
=20
-
 /**
  * cirrusfb_dump
  * @cirrusfbinfo:
@@ -3214,13 +3394,11 @@ void cirrusfb_dbg_print_regs (caddr_t re
  * DESCRIPTION:
  */
=20
-static
-void cirrusfb_dump (void)
+static void cirrusfb_dump(void)
 {
-	cirrusfb_dbg_reg_dump (NULL);
+	cirrusfb_dbg_reg_dump(NULL);
 }
=20
-
 /**
  * cirrusfb_dbg_reg_dump
  * @base: If using newmmio, the newmmio base address, otherwise=20
%NULL
@@ -3232,11 +3410,11 @@ void cirrusfb_dump (void)
  */
=20
 static
-void cirrusfb_dbg_reg_dump (caddr_t regbase)
+void cirrusfb_dbg_reg_dump(caddr_t regbase)
 {
-	DPRINTK ("CIRRUSFB VGA CRTC register dump:\n");
+	DPRINTK("CIRRUSFB VGA CRTC register dump:\n");
=20
-	cirrusfb_dbg_print_regs (regbase, CRT,
+	cirrusfb_dbg_print_regs(regbase, CRT,
 			   "CR00", 0x00,
 			   "CR01", 0x01,
 			   "CR02", 0x02,
@@ -3286,11 +3464,11 @@ void cirrusfb_dbg_reg_dump (caddr_t regb
 			   "CR3F", 0x3F,
 			   NULL);
=20
-	DPRINTK ("\n");
+	DPRINTK("\n");
=20
-	DPRINTK ("CIRRUSFB VGA SEQ register dump:\n");
+	DPRINTK("CIRRUSFB VGA SEQ register dump:\n");
=20
-	cirrusfb_dbg_print_regs (regbase, SEQ,
+	cirrusfb_dbg_print_regs(regbase, SEQ,
 			   "SR00", 0x00,
 			   "SR01", 0x01,
 			   "SR02", 0x02,
@@ -3319,7 +3497,7 @@ void cirrusfb_dbg_reg_dump (caddr_t regb
 			   "SR1F", 0x1F,
 			   NULL);
=20
-	DPRINTK ("\n");
+	DPRINTK("\n");
 }
=20
 #endif				/* CIRRUSFB_DEBUG */


----------------------------------------------------
Poznaj nowego wybra=F1ca Boga... i jego trz=F3dk=EA! Rewelacyjna
komedia EVAN WSZECHMOG=A1CY - w kinach od 24 sierpnia!
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fevanwszech=
mogacy_zwiastun.html&sid=3D1263

--part46c5d111106b2
Content-Type: application/octet-stream; name="cirrus-cleanup.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cirrus-cleanup.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggZml4
ZXMgb3ZlciA4NTAgZXJyb3JzIGFuZCB3YXJuaW5ncyBwb2ludGVkCm91dCBieSB0aGUgY2hlY2tw
YXRjaC5wbCBzY3JpcHQuCgpTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgSGVsdCA8a3J6eXN6dG9m
LmgxQHdwLnBsPgoKLS0tCgpJIHJ1biB0aGUgY2hlY2twYXRjaC5wbCBzY3JpcHQgb24gdGhlIHdo
b2xlIGRyaXZlcnMvdmlkZW8KZGlyZWN0b3J5LiBUaGUgbW9zdCBlcnJvcnMgYXJlIGluIGRyaXZl
cnMgd2hpY2ggc2hhcmUgY29kZQp3aXRoIFgxMSAoc2lzLCBudmlkaWEpLiBUaGUgY2lycnVzIGRy
aXZlciBoYWQgdGhlIG1vc3QgZXJyb3JzCmFzIGEgbm9uLVgxMSBkcml2ZXIuCgotLS0gbGludXgt
Mi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2NpcnJ1c2ZiLmMJMjAwNy0wNy0wOSAwMTozMjoxNi4w
MDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMy9kcml2ZXJzL3ZpZGVvL2NpcnJ1c2ZiLmMJ
MjAwNy0wOC0xNiAxOTo0MzowMy4wMDAwMDAwMDAgKzAyMDAKQEAgLTU5LDcgKzU5LDcgQEAKICNl
bmRpZgogI2lmZGVmIENPTkZJR19QUENfUFJFUAogI2luY2x1ZGUgPGFzbS9tYWNoZGVwLmg+Ci0j
ZGVmaW5lIGlzUFJlUCAobWFjaGluZV9pcyhwcmVwKSkKKyNkZWZpbmUgaXNQUmVQKG1hY2hpbmVf
aXMocHJlcCkpCiAjZWxzZQogI2RlZmluZSBpc1BSZVAgMAogI2VuZGlmCkBAIC02Nyw3ICs2Nyw2
IEBACiAjaW5jbHVkZSAidmlkZW8vdmdhLmgiCiAjaW5jbHVkZSAidmlkZW8vY2lycnVzLmgiCiAK
LQogLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqCiAgKgogICogZGVidWdnaW5nIGFuZCB1dGlsaXR5IG1hY3JvcwpAQCAtODIs
NyArODEsOCBAQAogCiAvKiBkZWJ1ZyBvdXRwdXQgKi8KICNpZmRlZiBDSVJSVVNGQl9ERUJVRwot
I2RlZmluZSBEUFJJTlRLKGZtdCwgYXJncy4uLikgcHJpbnRrKEtFUk5fREVCVUcgIiVzOiAiIGZt
dCwgX19GVU5DVElPTl9fICwgIyMgYXJncykKKyNkZWZpbmUgRFBSSU5USyhmbXQsIGFyZ3MuLi4p
IFwKKwlwcmludGsoS0VSTl9ERUJVRyAiJXM6ICIgZm10LCBfX0ZVTkNUSU9OX18gLCAjIyBhcmdz
KQogI2Vsc2UKICNkZWZpbmUgRFBSSU5USyhmbXQsIGFyZ3MuLi4pCiAjZW5kaWYKQEAgLTkwLDIw
ICs5MCwxOSBAQAogLyogZGVidWdnaW5nIGFzc2VydGlvbnMgKi8KICNpZm5kZWYgQ0lSUlVTRkJf
TkRFQlVHCiAjZGVmaW5lIGFzc2VydChleHByKSBcCi0gICAgICAgIGlmKCEoZXhwcikpIHsgXAot
ICAgICAgICBwcmludGsoICJBc3NlcnRpb24gZmFpbGVkISAlcywlcywlcyxsaW5lPSVkXG4iLFwK
LSAgICAgICAgI2V4cHIsX19GSUxFX18sX19GVU5DVElPTl9fLF9fTElORV9fKTsgXAotICAgICAg
ICB9CisJaWYgKCEoZXhwcikpIHsgXAorCQlwcmludGsoIkFzc2VydGlvbiBmYWlsZWQhICVzLCVz
LCVzLGxpbmU9JWRcbiIsIFwKKwkJI2V4cHIsIF9fRklMRV9fLCBfX0ZVTkNUSU9OX18sIF9fTElO
RV9fKTsgXAorCX0KICNlbHNlCiAjZGVmaW5lIGFzc2VydChleHByKQogI2VuZGlmCiAKLSNkZWZp
bmUgTUJfICgxMDI0KjEwMjQpCisjZGVmaW5lIE1CXyAoMTAyNCAqIDEwMjQpCiAjZGVmaW5lIEtC
XyAoMTAyNCkKIAogI2RlZmluZSBNQVhfTlVNX0JPQVJEUyA3CiAKLQogLyoqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAgKgog
ICogY2hpcHNldCBpbmZvcm1hdGlvbgpAQCAtMTIzLDcgKzEyMiw2IEBAIHR5cGVkZWYgZW51bSB7
CiAJQlRfTEFHVU5BLAkvKiBHRDU0NnggKi8KIH0gY2lycnVzZmJfYm9hcmRfdDsKIAotCiAvKgog
ICogcGVyLWJvYXJkLXR5cGUgaW5mb3JtYXRpb24sIHVzZWQgZm9yIGVudW1lcmF0aW5nIGFuZCBh
YnN0cmFjdGluZwogICogY2hpcC1zcGVjaWZpYyBpbmZvcm1hdGlvbgpAQCAtMTM5LDcgKzEzNyw4
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2lycnVzZmJfYm9hcmRfaW5mb18KIAkvKiBmb3IgIDEv
NGJwcCwgOGJwcCAxNS8xNmJwcCwgMjRicHAsIDMyYnBwIC0gbnVtYmVycyBmcm9tIHhvcmcgY29k
ZSAqLwogCWJvb2wgaW5pdF9zcjA3IDogMTsgLyogaW5pdCBTUjA3IGR1cmluZyBpbml0X3ZnYWNo
aXAoKSAqLwogCWJvb2wgaW5pdF9zcjFmIDogMTsgLyogd3JpdGUgU1IxRiBkdXJpbmcgaW5pdF92
Z2FjaGlwKCkgKi8KLQlib29sIHNjcm5fc3RhcnRfYml0MTkgOiAxOyAvKiBjb25zdHJ1Y3QgYml0
IDE5IG9mIHNjcmVlbiBzdGFydCBhZGRyZXNzICovCisJLyogY29uc3RydWN0IGJpdCAxOSBvZiBz
Y3JlZW4gc3RhcnQgYWRkcmVzcyAqLworCWJvb2wgc2Nybl9zdGFydF9iaXQxOSA6IDE7CiAKIAkv
KiBpbml0aWFsIFNSMDcgdmFsdWUsIHRoZW4gZm9yIGVhY2ggbW9kZSAqLwogCXVuc2lnbmVkIGNo
YXIgc3IwNzsKQEAgLTI2MSwzMCArMjYwLDI4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2lycnVz
ZmJfYm9hcmRfaW5mb18KIAl9CiB9OwogCi0KICNpZmRlZiBDT05GSUdfUENJCiAjZGVmaW5lIENI
SVAoaWQsIGJ0eXBlKSBcCiAJeyBQQ0lfVkVORE9SX0lEX0NJUlJVUywgaWQsIFBDSV9BTllfSUQs
IFBDSV9BTllfSUQsIDAsIDAsIChidHlwZSkgfQogCiBzdGF0aWMgc3RydWN0IHBjaV9kZXZpY2Vf
aWQgY2lycnVzZmJfcGNpX3RhYmxlW10gPSB7Ci0JQ0hJUCggUENJX0RFVklDRV9JRF9DSVJSVVNf
NTQzNiwgQlRfQUxQSU5FICksCi0JQ0hJUCggUENJX0RFVklDRV9JRF9DSVJSVVNfNTQzNF84LCBC
VF9BTFBJTkUgKSwKLQlDSElQKCBQQ0lfREVWSUNFX0lEX0NJUlJVU181NDM0XzQsIEJUX0FMUElO
RSApLAotCUNISVAoIFBDSV9ERVZJQ0VfSURfQ0lSUlVTXzU0MzAsIEJUX0FMUElORSApLCAvKiBH
RC01NDQwIGlzIHNhbWUgaWQgKi8KLQlDSElQKCBQQ0lfREVWSUNFX0lEX0NJUlJVU183NTQzLCBC
VF9BTFBJTkUgKSwKLQlDSElQKCBQQ0lfREVWSUNFX0lEX0NJUlJVU183NTQ4LCBCVF9BTFBJTkUg
KSwKLQlDSElQKCBQQ0lfREVWSUNFX0lEX0NJUlJVU181NDgwLCBCVF9HRDU0ODAgKSwgLyogTWFj
UGljYXNzbyBsaWtlbHkgKi8KLQlDSElQKCBQQ0lfREVWSUNFX0lEX0NJUlJVU181NDQ2LCBCVF9Q
SUNBU1NPNCApLCAvKiBQaWNhc3NvIDQgaXMgNTQ0NiAqLwotCUNISVAoIFBDSV9ERVZJQ0VfSURf
Q0lSUlVTXzU0NjIsIEJUX0xBR1VOQSApLCAvKiBDTCBMYWd1bmEgKi8KLQlDSElQKCBQQ0lfREVW
SUNFX0lEX0NJUlJVU181NDY0LCBCVF9MQUdVTkEgKSwgLyogQ0wgTGFndW5hIDNEICovCi0JQ0hJ
UCggUENJX0RFVklDRV9JRF9DSVJSVVNfNTQ2NSwgQlRfTEFHVU5BICksIC8qIENMIExhZ3VuYSAz
REEqLworCUNISVAoUENJX0RFVklDRV9JRF9DSVJSVVNfNTQzNiwgQlRfQUxQSU5FKSwKKwlDSElQ
KFBDSV9ERVZJQ0VfSURfQ0lSUlVTXzU0MzRfOCwgQlRfQUxQSU5FKSwKKwlDSElQKFBDSV9ERVZJ
Q0VfSURfQ0lSUlVTXzU0MzRfNCwgQlRfQUxQSU5FKSwKKwlDSElQKFBDSV9ERVZJQ0VfSURfQ0lS
UlVTXzU0MzAsIEJUX0FMUElORSksIC8qIEdELTU0NDAgaXMgc2FtZSBpZCAqLworCUNISVAoUENJ
X0RFVklDRV9JRF9DSVJSVVNfNzU0MywgQlRfQUxQSU5FKSwKKwlDSElQKFBDSV9ERVZJQ0VfSURf
Q0lSUlVTXzc1NDgsIEJUX0FMUElORSksCisJQ0hJUChQQ0lfREVWSUNFX0lEX0NJUlJVU181NDgw
LCBCVF9HRDU0ODApLCAvKiBNYWNQaWNhc3NvIGxpa2VseSAqLworCUNISVAoUENJX0RFVklDRV9J
RF9DSVJSVVNfNTQ0NiwgQlRfUElDQVNTTzQpLCAvKiBQaWNhc3NvIDQgaXMgNTQ0NiAqLworCUNI
SVAoUENJX0RFVklDRV9JRF9DSVJSVVNfNTQ2MiwgQlRfTEFHVU5BKSwgLyogQ0wgTGFndW5hICov
CisJQ0hJUChQQ0lfREVWSUNFX0lEX0NJUlJVU181NDY0LCBCVF9MQUdVTkEpLCAvKiBDTCBMYWd1
bmEgM0QgKi8KKwlDSElQKFBDSV9ERVZJQ0VfSURfQ0lSUlVTXzU0NjUsIEJUX0xBR1VOQSksIC8q
IENMIExhZ3VuYSAzREEqLwogCXsgMCwgfQogfTsKIE1PRFVMRV9ERVZJQ0VfVEFCTEUocGNpLCBj
aXJydXNmYl9wY2lfdGFibGUpOwogI3VuZGVmIENISVAKICNlbmRpZiAvKiBDT05GSUdfUENJICov
CiAKLQogI2lmZGVmIENPTkZJR19aT1JSTwogc3RhdGljIGNvbnN0IHN0cnVjdCB6b3Jyb19kZXZp
Y2VfaWQgY2lycnVzZmJfem9ycm9fdGFibGVbXSA9IHsKIAl7CkBAIC0yOTQsNyArMjkxLDcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCB6b3Jyb19kZXZpY2VfaWQgY2lycgogCQkuaWQJCT0gWk9SUk9f
UFJPRF9IRUxGUklDSF9QSUNDT0xPX1JBTSwKIAkJLmRyaXZlcl9kYXRhCT0gQlRfUElDQ09MTywK
IAl9LCB7Ci0JCS5pZAkJPSBaT1JST19QUk9EX1ZJTExBR0VfVFJPTklDX1BJQ0FTU09fSUlfSUlf
UExVU19SQU0sCisJCS5pZAk9IFpPUlJPX1BST0RfVklMTEFHRV9UUk9OSUNfUElDQVNTT19JSV9J
SV9QTFVTX1JBTSwKIAkJLmRyaXZlcl9kYXRhCT0gQlRfUElDQVNTTywKIAl9LCB7CiAJCS5pZAkJ
PSBaT1JST19QUk9EX0dWUF9FR1NfMjhfMjRfU1BFQ1RSVU1fUkFNLApAQCAtMzMzLDcgKzMzMCw2
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgewogfTsKICNlbmRpZiAvKiBDT05GSUdfWk9SUk8gKi8K
IAotCiBzdHJ1Y3QgY2lycnVzZmJfcmVncyB7CiAJX191MzIgbGluZV9sZW5ndGg7CS8qIGluIEJZ
VEVTISAqLwogCV9fdTMyIHZpc3VhbDsKQEAgLTM2NCwxNyArMzYwLDEyIEBAIHN0cnVjdCBjaXJy
dXNmYl9yZWdzIHsKIAlsb25nIFZlcnRCbGFua0VuZDsKIH07CiAKLQotCiAjaWZkZWYgQ0lSUlVT
RkJfREVCVUcKIHR5cGVkZWYgZW51bSB7Ci0gICAgICAgIENSVCwKLSAgICAgICAgU0VRCisJQ1JU
LAorCVNFUQogfSBjaXJydXNmYl9kYmdfcmVnX2NsYXNzX3Q7Ci0jZW5kaWYgICAgICAgICAgICAg
ICAgICAgICAgICAgIC8qIENJUlJVU0ZCX0RFQlVHICovCi0KLQotCisjZW5kaWYJCS8qIENJUlJV
U0ZCX0RFQlVHICovCiAKIC8qIGluZm8gYWJvdXQgYm9hcmQgKi8KIHN0cnVjdCBjaXJydXNmYl9p
bmZvIHsKQEAgLTQwNSw5ICszOTYsOCBAQCBzdHJ1Y3QgY2lycnVzZmJfaW5mbyB7CiAJdm9pZCAo
KnVubWFwKShzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8pOwogfTsKIAotCiBzdGF0aWMgdW5z
aWduZWQgY2lycnVzZmJfZGVmX21vZGUgPSAxOwotc3RhdGljIGludCBub2FjY2VsID0gMDsKK3N0
YXRpYyBpbnQgbm9hY2NlbDsKIAogLyoKICAqICAgIFByZWRlZmluZWQgVmlkZW8gTW9kZXMKQEAg
LTQ0MSw3ICs0MzEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHsKIAkJCS5sb3dlcl9tYXJnaW4J
PSA4LAogCQkJLmhzeW5jX2xlbgk9IDk2LAogCQkJLnZzeW5jX2xlbgk9IDQsCi0JCQkuc3luYwkJ
PSBGQl9TWU5DX0hPUl9ISUdIX0FDVCB8IEZCX1NZTkNfVkVSVF9ISUdIX0FDVCwKKwkJCS5zeW5j
CT0gRkJfU1lOQ19IT1JfSElHSF9BQ1QgfCBGQl9TWU5DX1ZFUlRfSElHSF9BQ1QsCiAJCQkudm1v
ZGUJCT0gRkJfVk1PREVfTk9OSU5URVJMQUNFRAogCQkgfQogCX0sIHsKQEAgLTUwMiwyNyArNDky
LDI5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgewogLyoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCiAvKioq
KiBCRUdJTiBQUk9UT1RZUEVTICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKi8KIAotCiAvKi0tLSBJbnRlcmZhY2UgdXNlZCBieSB0aGUgd29ybGQg
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKi8KLXN0YXRpYyBpbnQg
Y2lycnVzZmJfaW5pdCAodm9pZCk7CitzdGF0aWMgaW50IGNpcnJ1c2ZiX2luaXQodm9pZCk7CiAj
aWZuZGVmIE1PRFVMRQotc3RhdGljIGludCBjaXJydXNmYl9zZXR1cCAoY2hhciAqb3B0aW9ucyk7
CitzdGF0aWMgaW50IGNpcnJ1c2ZiX3NldHVwKGNoYXIgKm9wdGlvbnMpOwogI2VuZGlmCiAKLXN0
YXRpYyBpbnQgY2lycnVzZmJfb3BlbiAoc3RydWN0IGZiX2luZm8gKmluZm8sIGludCB1c2VyKTsK
LXN0YXRpYyBpbnQgY2lycnVzZmJfcmVsZWFzZSAoc3RydWN0IGZiX2luZm8gKmluZm8sIGludCB1
c2VyKTsKLXN0YXRpYyBpbnQgY2lycnVzZmJfc2V0Y29scmVnICh1bnNpZ25lZCByZWdubywgdW5z
aWduZWQgcmVkLCB1bnNpZ25lZCBncmVlbiwKLQkJCSAgICAgICB1bnNpZ25lZCBibHVlLCB1bnNp
Z25lZCB0cmFuc3AsCi0JCQkgICAgICAgc3RydWN0IGZiX2luZm8gKmluZm8pOwotc3RhdGljIGlu
dCBjaXJydXNmYl9jaGVja192YXIgKHN0cnVjdCBmYl92YXJfc2NyZWVuaW5mbyAqdmFyLAotCQkJ
ICAgICAgIHN0cnVjdCBmYl9pbmZvICppbmZvKTsKLXN0YXRpYyBpbnQgY2lycnVzZmJfc2V0X3Bh
ciAoc3RydWN0IGZiX2luZm8gKmluZm8pOwotc3RhdGljIGludCBjaXJydXNmYl9wYW5fZGlzcGxh
eSAoc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIsCi0JCQkJIHN0cnVjdCBmYl9pbmZvICpp
bmZvKTsKLXN0YXRpYyBpbnQgY2lycnVzZmJfYmxhbmsgKGludCBibGFua19tb2RlLCBzdHJ1Y3Qg
ZmJfaW5mbyAqaW5mbyk7Ci1zdGF0aWMgdm9pZCBjaXJydXNmYl9maWxscmVjdCAoc3RydWN0IGZi
X2luZm8gKmluZm8sIGNvbnN0IHN0cnVjdCBmYl9maWxscmVjdCAqcmVnaW9uKTsKLXN0YXRpYyB2
b2lkIGNpcnJ1c2ZiX2NvcHlhcmVhKHN0cnVjdCBmYl9pbmZvICppbmZvLCBjb25zdCBzdHJ1Y3Qg
ZmJfY29weWFyZWEgKmFyZWEpOwotc3RhdGljIHZvaWQgY2lycnVzZmJfaW1hZ2VibGl0KHN0cnVj
dCBmYl9pbmZvICppbmZvLCBjb25zdCBzdHJ1Y3QgZmJfaW1hZ2UgKmltYWdlKTsKK3N0YXRpYyBp
bnQgY2lycnVzZmJfb3BlbihzdHJ1Y3QgZmJfaW5mbyAqaW5mbywgaW50IHVzZXIpOworc3RhdGlj
IGludCBjaXJydXNmYl9yZWxlYXNlKHN0cnVjdCBmYl9pbmZvICppbmZvLCBpbnQgdXNlcik7Citz
dGF0aWMgaW50IGNpcnJ1c2ZiX3NldGNvbHJlZyh1bnNpZ25lZCByZWdubywgdW5zaWduZWQgcmVk
LCB1bnNpZ25lZCBncmVlbiwKKwkJCSAgICAgIHVuc2lnbmVkIGJsdWUsIHVuc2lnbmVkIHRyYW5z
cCwKKwkJCSAgICAgIHN0cnVjdCBmYl9pbmZvICppbmZvKTsKK3N0YXRpYyBpbnQgY2lycnVzZmJf
Y2hlY2tfdmFyKHN0cnVjdCBmYl92YXJfc2NyZWVuaW5mbyAqdmFyLAorCQkJICAgICAgc3RydWN0
IGZiX2luZm8gKmluZm8pOworc3RhdGljIGludCBjaXJydXNmYl9zZXRfcGFyKHN0cnVjdCBmYl9p
bmZvICppbmZvKTsKK3N0YXRpYyBpbnQgY2lycnVzZmJfcGFuX2Rpc3BsYXkoc3RydWN0IGZiX3Zh
cl9zY3JlZW5pbmZvICp2YXIsCisJCQkJc3RydWN0IGZiX2luZm8gKmluZm8pOworc3RhdGljIGlu
dCBjaXJydXNmYl9ibGFuayhpbnQgYmxhbmtfbW9kZSwgc3RydWN0IGZiX2luZm8gKmluZm8pOwor
c3RhdGljIHZvaWQgY2lycnVzZmJfZmlsbHJlY3Qoc3RydWN0IGZiX2luZm8gKmluZm8sCisJCQkg
ICAgICBjb25zdCBzdHJ1Y3QgZmJfZmlsbHJlY3QgKnJlZ2lvbik7CitzdGF0aWMgdm9pZCBjaXJy
dXNmYl9jb3B5YXJlYShzdHJ1Y3QgZmJfaW5mbyAqaW5mbywKKwkJCSAgICAgIGNvbnN0IHN0cnVj
dCBmYl9jb3B5YXJlYSAqYXJlYSk7CitzdGF0aWMgdm9pZCBjaXJydXNmYl9pbWFnZWJsaXQoc3Ry
dWN0IGZiX2luZm8gKmluZm8sCisJCQkgICAgICAgY29uc3Qgc3RydWN0IGZiX2ltYWdlICppbWFn
ZSk7CiAKIC8qIGZ1bmN0aW9uIHRhYmxlIG9mIHRoZSBhYm92ZSBmdW5jdGlvbnMgKi8KIHN0YXRp
YyBzdHJ1Y3QgZmJfb3BzIGNpcnJ1c2ZiX29wcyA9IHsKQEAgLTU0MCw2OCArNTMyLDY4IEBAIHN0
YXRpYyBzdHJ1Y3QgZmJfb3BzIGNpcnJ1c2ZiX29wcyA9IHsKIH07CiAKIC8qLS0tIEhhcmR3YXJl
IFNwZWNpZmljIFJvdXRpbmVzIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0qLwotc3RhdGljIGludCBjaXJydXNmYl9kZWNvZGVfdmFyIChjb25zdCBzdHJ1Y3QgZmJf
dmFyX3NjcmVlbmluZm8gKnZhciwKK3N0YXRpYyBpbnQgY2lycnVzZmJfZGVjb2RlX3Zhcihjb25z
dCBzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8gKnZhciwKIAkJCQlzdHJ1Y3QgY2lycnVzZmJfcmVn
cyAqcmVncywKIAkJCQljb25zdCBzdHJ1Y3QgZmJfaW5mbyAqaW5mbyk7CiAvKi0tLSBJbnRlcm5h
bCByb3V0aW5lcyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tKi8KLXN0YXRpYyB2b2lkIGluaXRfdmdhY2hpcCAoc3RydWN0IGNpcnJ1c2ZiX2luZm8g
KmNpbmZvKTsKLXN0YXRpYyB2b2lkIHN3aXRjaF9tb25pdG9yIChzdHJ1Y3QgY2lycnVzZmJfaW5m
byAqY2luZm8sIGludCBvbik7Ci1zdGF0aWMgdm9pZCBXR2VuIChjb25zdCBzdHJ1Y3QgY2lycnVz
ZmJfaW5mbyAqY2luZm8sCi0JCSAgaW50IHJlZ251bSwgdW5zaWduZWQgY2hhciB2YWwpOwotc3Rh
dGljIHVuc2lnbmVkIGNoYXIgUkdlbiAoY29uc3Qgc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZv
LCBpbnQgcmVnbnVtKTsKLXN0YXRpYyB2b2lkIEF0dHJPbiAoY29uc3Qgc3RydWN0IGNpcnJ1c2Zi
X2luZm8gKmNpbmZvKTsKLXN0YXRpYyB2b2lkIFdIRFIgKGNvbnN0IHN0cnVjdCBjaXJydXNmYl9p
bmZvICpjaW5mbywgdW5zaWduZWQgY2hhciB2YWwpOwotc3RhdGljIHZvaWQgV1NGUiAoc3RydWN0
IGNpcnJ1c2ZiX2luZm8gKmNpbmZvLCB1bnNpZ25lZCBjaGFyIHZhbCk7Ci1zdGF0aWMgdm9pZCBX
U0ZSMiAoc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvLCB1bnNpZ25lZCBjaGFyIHZhbCk7Ci1z
dGF0aWMgdm9pZCBXQ2x1dCAoc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvLCB1bnNpZ25lZCBj
aGFyIHJlZ251bSwgdW5zaWduZWQgY2hhciByZWQsCi0JCSAgIHVuc2lnbmVkIGNoYXIgZ3JlZW4s
Ci0JCSAgIHVuc2lnbmVkIGNoYXIgYmx1ZSk7CitzdGF0aWMgdm9pZCBpbml0X3ZnYWNoaXAoc3Ry
dWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvKTsKK3N0YXRpYyB2b2lkIHN3aXRjaF9tb25pdG9yKHN0
cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbywgaW50IG9uKTsKK3N0YXRpYyB2b2lkIFdHZW4oY29u
c3Qgc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvLAorCQkgaW50IHJlZ251bSwgdW5zaWduZWQg
Y2hhciB2YWwpOworc3RhdGljIHVuc2lnbmVkIGNoYXIgUkdlbihjb25zdCBzdHJ1Y3QgY2lycnVz
ZmJfaW5mbyAqY2luZm8sIGludCByZWdudW0pOworc3RhdGljIHZvaWQgQXR0ck9uKGNvbnN0IHN0
cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbyk7CitzdGF0aWMgdm9pZCBXSERSKGNvbnN0IHN0cnVj
dCBjaXJydXNmYl9pbmZvICpjaW5mbywgdW5zaWduZWQgY2hhciB2YWwpOworc3RhdGljIHZvaWQg
V1NGUihzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8sIHVuc2lnbmVkIGNoYXIgdmFsKTsKK3N0
YXRpYyB2b2lkIFdTRlIyKHN0cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbywgdW5zaWduZWQgY2hh
ciB2YWwpOworc3RhdGljIHZvaWQgV0NsdXQoc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvLCB1
bnNpZ25lZCBjaGFyIHJlZ251bSwKKwkJICB1bnNpZ25lZCBjaGFyIHJlZCwgdW5zaWduZWQgY2hh
ciBncmVlbiwgdW5zaWduZWQgY2hhciBibHVlKTsKICNpZiAwCi1zdGF0aWMgdm9pZCBSQ2x1dCAo
c3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvLCB1bnNpZ25lZCBjaGFyIHJlZ251bSwgdW5zaWdu
ZWQgY2hhciAqcmVkLAotCQkgICB1bnNpZ25lZCBjaGFyICpncmVlbiwKLQkJICAgdW5zaWduZWQg
Y2hhciAqYmx1ZSk7Ci0jZW5kaWYKLXN0YXRpYyB2b2lkIGNpcnJ1c2ZiX1dhaXRCTFQgKHU4IF9f
aW9tZW0gKnJlZ2Jhc2UpOwotc3RhdGljIHZvaWQgY2lycnVzZmJfQml0QkxUICh1OCBfX2lvbWVt
ICpyZWdiYXNlLCBpbnQgYml0c19wZXJfcGl4ZWwsCi0JCQkgICAgIHVfc2hvcnQgY3VyeCwgdV9z
aG9ydCBjdXJ5LAotCQkJICAgICB1X3Nob3J0IGRlc3R4LCB1X3Nob3J0IGRlc3R5LAotCQkJICAg
ICB1X3Nob3J0IHdpZHRoLCB1X3Nob3J0IGhlaWdodCwKLQkJCSAgICAgdV9zaG9ydCBsaW5lX2xl
bmd0aCk7Ci1zdGF0aWMgdm9pZCBjaXJydXNmYl9SZWN0RmlsbCAodTggX19pb21lbSAqcmVnYmFz
ZSwgaW50IGJpdHNfcGVyX3BpeGVsLAotCQkJICAgICAgIHVfc2hvcnQgeCwgdV9zaG9ydCB5LAot
CQkJICAgICAgIHVfc2hvcnQgd2lkdGgsIHVfc2hvcnQgaGVpZ2h0LAotCQkJICAgICAgIHVfY2hh
ciBjb2xvciwgdV9zaG9ydCBsaW5lX2xlbmd0aCk7Ci0KLXN0YXRpYyB2b2lkIGJlc3RjbG9jayAo
bG9uZyBmcmVxLCBsb25nICpiZXN0LAotCQkgICAgICAgbG9uZyAqbm9tLCBsb25nICpkZW4sCi0J
CSAgICAgICBsb25nICpkaXYsIGxvbmcgbWF4ZnJlcSk7CitzdGF0aWMgdm9pZCBSQ2x1dChzdHJ1
Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8sIHVuc2lnbmVkIGNoYXIgcmVnbnVtLAorCQkgIHVuc2ln
bmVkIGNoYXIgKnJlZCwgdW5zaWduZWQgY2hhciAqZ3JlZW4sCisJCSAgdW5zaWduZWQgY2hhciAq
Ymx1ZSk7CisjZW5kaWYKK3N0YXRpYyB2b2lkIGNpcnJ1c2ZiX1dhaXRCTFQodTggX19pb21lbSAq
cmVnYmFzZSk7CitzdGF0aWMgdm9pZCBjaXJydXNmYl9CaXRCTFQodTggX19pb21lbSAqcmVnYmFz
ZSwgaW50IGJpdHNfcGVyX3BpeGVsLAorCQkJICAgIHVfc2hvcnQgY3VyeCwgdV9zaG9ydCBjdXJ5
LAorCQkJICAgIHVfc2hvcnQgZGVzdHgsIHVfc2hvcnQgZGVzdHksCisJCQkgICAgdV9zaG9ydCB3
aWR0aCwgdV9zaG9ydCBoZWlnaHQsCisJCQkgICAgdV9zaG9ydCBsaW5lX2xlbmd0aCk7CitzdGF0
aWMgdm9pZCBjaXJydXNmYl9SZWN0RmlsbCh1OCBfX2lvbWVtICpyZWdiYXNlLCBpbnQgYml0c19w
ZXJfcGl4ZWwsCisJCQkgICAgICB1X3Nob3J0IHgsIHVfc2hvcnQgeSwKKwkJCSAgICAgIHVfc2hv
cnQgd2lkdGgsIHVfc2hvcnQgaGVpZ2h0LAorCQkJICAgICAgdV9jaGFyIGNvbG9yLCB1X3Nob3J0
IGxpbmVfbGVuZ3RoKTsKKworc3RhdGljIHZvaWQgYmVzdGNsb2NrKGxvbmcgZnJlcSwgbG9uZyAq
YmVzdCwKKwkJICAgICAgbG9uZyAqbm9tLCBsb25nICpkZW4sCisJCSAgICAgIGxvbmcgKmRpdiwg
bG9uZyBtYXhmcmVxKTsKIAogI2lmZGVmIENJUlJVU0ZCX0RFQlVHCi1zdGF0aWMgdm9pZCBjaXJy
dXNmYl9kdW1wICh2b2lkKTsKLXN0YXRpYyB2b2lkIGNpcnJ1c2ZiX2RiZ19yZWdfZHVtcCAoY2Fk
ZHJfdCByZWdiYXNlKTsKLXN0YXRpYyB2b2lkIGNpcnJ1c2ZiX2RiZ19wcmludF9yZWdzIChjYWRk
cl90IHJlZ2Jhc2UsIGNpcnJ1c2ZiX2RiZ19yZWdfY2xhc3NfdCByZWdfY2xhc3MsLi4uKTsKLXN0
YXRpYyB2b2lkIGNpcnJ1c2ZiX2RiZ19wcmludF9ieXRlIChjb25zdCBjaGFyICpuYW1lLCB1bnNp
Z25lZCBjaGFyIHZhbCk7CitzdGF0aWMgdm9pZCBjaXJydXNmYl9kdW1wKHZvaWQpOworc3RhdGlj
IHZvaWQgY2lycnVzZmJfZGJnX3JlZ19kdW1wKGNhZGRyX3QgcmVnYmFzZSk7CitzdGF0aWMgdm9p
ZCBjaXJydXNmYl9kYmdfcHJpbnRfcmVncyhjYWRkcl90IHJlZ2Jhc2UsCisJCQkJICAgIGNpcnJ1
c2ZiX2RiZ19yZWdfY2xhc3NfdCByZWdfY2xhc3MsIC4uLik7CitzdGF0aWMgdm9pZCBjaXJydXNm
Yl9kYmdfcHJpbnRfYnl0ZShjb25zdCBjaGFyICpuYW1lLCB1bnNpZ25lZCBjaGFyIHZhbCk7CiAj
ZW5kaWYgLyogQ0lSUlVTRkJfREVCVUcgKi8KIAogLyoqKiBFTkQgICBQUk9UT1RZUEVTICoqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwogLyoq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqLwogLyoqKiBCRUdJTiBJbnRlcmZhY2UgVXNlZCBieSB0aGUgV29y
bGQgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwogCi1zdGF0aWMgaW50
IG9wZW5jb3VudCA9IDA7CitzdGF0aWMgaW50IG9wZW5jb3VudDsKIAogLyotLS0gT3BlbiAvZGV2
L2ZieCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0qLwotc3RhdGljIGludCBjaXJydXNmYl9vcGVuIChzdHJ1Y3QgZmJfaW5mbyAqaW5mbywg
aW50IHVzZXIpCitzdGF0aWMgaW50IGNpcnJ1c2ZiX29wZW4oc3RydWN0IGZiX2luZm8gKmluZm8s
IGludCB1c2VyKQogewogCWlmIChvcGVuY291bnQrKyA9PSAwKQotCQlzd2l0Y2hfbW9uaXRvciAo
aW5mby0+cGFyLCAxKTsKKwkJc3dpdGNoX21vbml0b3IoaW5mby0+cGFyLCAxKTsKIAlyZXR1cm4g
MDsKIH0KIAogLyotLS0gQ2xvc2UgL2Rldi9mYnggLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0qLwotc3RhdGljIGludCBjaXJydXNmYl9yZWxl
YXNlIChzdHJ1Y3QgZmJfaW5mbyAqaW5mbywgaW50IHVzZXIpCitzdGF0aWMgaW50IGNpcnJ1c2Zi
X3JlbGVhc2Uoc3RydWN0IGZiX2luZm8gKmluZm8sIGludCB1c2VyKQogewogCWlmICgtLW9wZW5j
b3VudCA9PSAwKQotCQlzd2l0Y2hfbW9uaXRvciAoaW5mby0+cGFyLCAwKTsKKwkJc3dpdGNoX21v
bml0b3IoaW5mby0+cGFyLCAwKTsKIAlyZXR1cm4gMDsKIH0KIApAQCAtNjEwLDExICs2MDIsMTEg
QEAgc3RhdGljIGludCBjaXJydXNmYl9yZWxlYXNlIChzdHJ1Y3QgZmJfaQogLyoqKiogQkVHSU4g
SGFyZHdhcmUgc3BlY2lmaWMgUm91dGluZXMgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKiovCiAKIC8qIEdldCBhIGdvb2QgTUNMSyB2YWx1ZSAqLwotc3RhdGljIGxvbmcgY2ly
cnVzZmJfZ2V0X21jbGsgKGxvbmcgZnJlcSwgaW50IGJwcCwgbG9uZyAqZGl2KQorc3RhdGljIGxv
bmcgY2lycnVzZmJfZ2V0X21jbGsobG9uZyBmcmVxLCBpbnQgYnBwLCBsb25nICpkaXYpCiB7CiAJ
bG9uZyBtY2xrOwogCi0JYXNzZXJ0IChkaXYgIT0gTlVMTCk7CisJYXNzZXJ0KGRpdiAhPSBOVUxM
KTsKIAogCS8qIENhbGN1bGF0ZSBNQ0xLLCBpbiBjYXNlIFZDTEsgaXMgaGlnaCBlbm91Z2ggdG8g
cmVxdWlyZSA+IDUwTUh6LgogCSAqIEFzc3VtZSBhIDY0LWJpdCBkYXRhIHBhdGggZm9yIG5vdy4g
IFRoZSBmb3JtdWxhIGlzOgpAQCAtNjI0LDIzICs2MTYsMjMgQEAgc3RhdGljIGxvbmcgY2lycnVz
ZmJfZ2V0X21jbGsgKGxvbmcgZnJlcQogCW1jbGsgPSAobWNsayAqIDEyKSAvIDEwOwogCWlmICht
Y2xrIDwgNTAwMDApCiAJCW1jbGsgPSA1MDAwMDsKLQlEUFJJTlRLICgiVXNlIE1DTEsgb2YgJWxk
IGtIelxuIiwgbWNsayk7CisJRFBSSU5USygiVXNlIE1DTEsgb2YgJWxkIGtIelxuIiwgbWNsayk7
CiAKIAkvKiBDYWxjdWxhdGUgdmFsdWUgZm9yIFNSMUYuICBNdWx0aXBseSBieSAyIHNvIHdlIGNh
biByb3VuZCB1cC4gKi8KIAltY2xrID0gKChtY2xrICogMTYpIC8gMTQzMTgpOwogCW1jbGsgPSAo
bWNsayArIDEpIC8gMjsKLQlEUFJJTlRLICgiU2V0IFNSMUZbNTowXSB0byAweCVseFxuIiwgbWNs
ayk7CisJRFBSSU5USygiU2V0IFNSMUZbNTowXSB0byAweCVseFxuIiwgbWNsayk7CiAKIAkvKiBE
ZXRlcm1pbmUgaWYgd2Ugc2hvdWxkIHVzZSBNQ0xLIGluc3RlYWQgb2YgVkNMSywgYW5kIGlmIHNv
LCB3aGF0IHdlCiAJICAgKiBzaG91bGQgZGl2aWRlIGl0IGJ5IHRvIGdldCBWQ0xLICovCiAJc3dp
dGNoIChmcmVxKSB7CiAJY2FzZSAyNDc1MSAuLi4gMjUyNDk6CiAJCSpkaXYgPSAyOwotCQlEUFJJ
TlRLICgiVXNpbmcgVkNMSyA9IE1DTEsvMlxuIik7CisJCURQUklOVEsoIlVzaW5nIFZDTEsgPSBN
Q0xLLzJcbiIpOwogCQlicmVhazsKIAljYXNlIDQ5NTAxIC4uLiA1MDQ5OToKIAkJKmRpdiA9IDE7
Ci0JCURQUklOVEsgKCJVc2luZyBWQ0xLID0gTUNMS1xuIik7CisJCURQUklOVEsoIlVzaW5nIFZD
TEsgPSBNQ0xLXG4iKTsKIAkJYnJlYWs7CiAJZGVmYXVsdDoKIAkJKmRpdiA9IDA7CkBAIC02OTEs
MzcgKzY4Myw0MiBAQCBzdGF0aWMgaW50IGNpcnJ1c2ZiX2NoZWNrX3ZhcihzdHJ1Y3QgZmJfCiAJ
CWRlbiA9IDE7CiAJCWJyZWFrOwkJLyogNCBieXRlcyBwZXIgcGl4ZWwgKi8KIAlkZWZhdWx0Ogot
CQlwcmludGsgKCJjaXJydXNmYjogbW9kZSAlZHglZHglZCByZWplY3RlZC4uLmNvbG9yIGRlcHRo
IG5vdCBzdXBwb3J0ZWQuXG4iLAorCQlwcmludGsoS0VSTl9FUlIgImNpcnJ1c2ZiOiBtb2RlICVk
eCVkeCVkIHJlamVjdGVkLi4uIgorCQkJImNvbG9yIGRlcHRoIG5vdCBzdXBwb3J0ZWQuXG4iLAog
CQkJdmFyLT54cmVzLCB2YXItPnlyZXMsIHZhci0+Yml0c19wZXJfcGl4ZWwpOwotCQlEUFJJTlRL
ICgiRVhJVCAtIEVJTlZBTCBlcnJvclxuIik7CisJCURQUklOVEsoIkVYSVQgLSBFSU5WQUwgZXJy
b3JcbiIpOwogCQlyZXR1cm4gLUVJTlZBTDsKIAl9CiAKIAlpZiAodmFyLT54cmVzICogbm9tIC8g
ZGVuICogdmFyLT55cmVzID4gY2luZm8tPnNpemUpIHsKLQkJcHJpbnRrICgiY2lycnVzZmI6IG1v
ZGUgJWR4JWR4JWQgcmVqZWN0ZWQuLi5yZXNvbHV0aW9uIHRvbyBoaWdoIHRvIGZpdCBpbnRvIHZp
ZGVvIG1lbW9yeSFcbiIsCisJCXByaW50ayhLRVJOX0VSUiAiY2lycnVzZmI6IG1vZGUgJWR4JWR4
JWQgcmVqZWN0ZWQuLi4iCisJCQkicmVzb2x1dGlvbiB0b28gaGlnaCB0byBmaXQgaW50byB2aWRl
byBtZW1vcnkhXG4iLAogCQkJdmFyLT54cmVzLCB2YXItPnlyZXMsIHZhci0+Yml0c19wZXJfcGl4
ZWwpOwotCQlEUFJJTlRLICgiRVhJVCAtIEVJTlZBTCBlcnJvclxuIik7CisJCURQUklOVEsoIkVY
SVQgLSBFSU5WQUwgZXJyb3JcbiIpOwogCQlyZXR1cm4gLUVJTlZBTDsKIAl9CiAKIAkvKiB1c2Ug
aGlnaGVzdCBwb3NzaWJsZSB2aXJ0dWFsIHJlc29sdXRpb24gKi8KIAlpZiAodmFyLT54cmVzX3Zp
cnR1YWwgPT0gLTEgJiYKIAkgICAgdmFyLT55cmVzX3ZpcnR1YWwgPT0gLTEpIHsKLQkJcHJpbnRr
ICgiY2lycnVzZmI6IHVzaW5nIG1heGltdW0gYXZhaWxhYmxlIHZpcnR1YWwgcmVzb2x1dGlvblxu
Iik7CisJCXByaW50ayhLRVJOX0lORk8KKwkJICAgICAiY2lycnVzZmI6IHVzaW5nIG1heGltdW0g
YXZhaWxhYmxlIHZpcnR1YWwgcmVzb2x1dGlvblxuIik7CiAJCWZvciAoaSA9IDA7IG1vZGVzW2ld
LnhyZXMgIT0gLTE7IGkrKykgewogCQkJaWYgKG1vZGVzW2ldLnhyZXMgKiBub20gLyBkZW4gKiBt
b2Rlc1tpXS55cmVzIDwgY2luZm8tPnNpemUgLyAyKQogCQkJCWJyZWFrOwogCQl9CiAJCWlmICht
b2Rlc1tpXS54cmVzID09IC0xKSB7Ci0JCQlwcmludGsgKCJjaXJydXNmYjogY291bGQgbm90IGZp
bmQgYSB2aXJ0dWFsIHJlc29sdXRpb24gdGhhdCBmaXRzIGludG8gdmlkZW8gbWVtb3J5ISFcbiIp
OwotCQkJRFBSSU5USyAoIkVYSVQgLSBFSU5WQUwgZXJyb3JcbiIpOworCQkJcHJpbnRrKEtFUk5f
RVJSICJjaXJydXNmYjogY291bGQgbm90IGZpbmQgYSB2aXJ0dWFsICIKKwkJCQkicmVzb2x1dGlv
biB0aGF0IGZpdHMgaW50byB2aWRlbyBtZW1vcnkhIVxuIik7CisJCQlEUFJJTlRLKCJFWElUIC0g
RUlOVkFMIGVycm9yXG4iKTsKIAkJCXJldHVybiAtRUlOVkFMOwogCQl9CiAJCXZhci0+eHJlc192
aXJ0dWFsID0gbW9kZXNbaV0ueHJlczsKIAkJdmFyLT55cmVzX3ZpcnR1YWwgPSBtb2Rlc1tpXS55
cmVzOwogCi0JCXByaW50ayAoImNpcnJ1c2ZiOiB2aXJ0dWFsIHJlc29sdXRpb24gc2V0IHRvIG1h
eGltdW0gb2YgJWR4JWRcbiIsCi0JCQl2YXItPnhyZXNfdmlydHVhbCwgdmFyLT55cmVzX3ZpcnR1
YWwpOworCQlwcmludGsoS0VSTl9JTkZPICJjaXJydXNmYjogdmlydHVhbCByZXNvbHV0aW9uIHNl
dCB0byAiCisJCQkibWF4aW11bSBvZiAlZHglZFxuIiwgdmFyLT54cmVzX3ZpcnR1YWwsCisJCQl2
YXItPnlyZXNfdmlydHVhbCk7CiAJfQogCiAJaWYgKHZhci0+eHJlc192aXJ0dWFsIDwgdmFyLT54
cmVzKQpAQCAtNzYwLDcgKzc1Nyw3IEBAIHN0YXRpYyBpbnQgY2lycnVzZmJfY2hlY2tfdmFyKHN0
cnVjdCBmYl8KIAkJYnJlYWs7CiAKIAljYXNlIDE2OgotCQlpZihpc1BSZVApIHsKKwkJaWYgKGlz
UFJlUCkgewogCQkJdmFyLT5yZWQub2Zmc2V0ID0gMjsKIAkJCXZhci0+Z3JlZW4ub2Zmc2V0ID0g
LTM7CiAJCQl2YXItPmJsdWUub2Zmc2V0ID0gODsKQEAgLTc3NSw3ICs3NzIsNyBAQCBzdGF0aWMg
aW50IGNpcnJ1c2ZiX2NoZWNrX3ZhcihzdHJ1Y3QgZmJfCiAJCWJyZWFrOwogCiAJY2FzZSAyNDoK
LQkJaWYoaXNQUmVQKSB7CisJCWlmIChpc1BSZVApIHsKIAkJCXZhci0+cmVkLm9mZnNldCA9IDg7
CiAJCQl2YXItPmdyZWVuLm9mZnNldCA9IDE2OwogCQkJdmFyLT5ibHVlLm9mZnNldCA9IDI0OwpA
QCAtNzkwLDcgKzc4Nyw3IEBAIHN0YXRpYyBpbnQgY2lycnVzZmJfY2hlY2tfdmFyKHN0cnVjdCBm
Yl8KIAkJYnJlYWs7CiAKIAljYXNlIDMyOgotCQlpZihpc1BSZVApIHsKKwkJaWYgKGlzUFJlUCkg
ewogCQkJdmFyLT5yZWQub2Zmc2V0ID0gODsKIAkJCXZhci0+Z3JlZW4ub2Zmc2V0ID0gMTY7CiAJ
CQl2YXItPmJsdWUub2Zmc2V0ID0gMjQ7CkBAIC04MjUsMTUgKzgyMiwxNiBAQCBzdGF0aWMgaW50
IGNpcnJ1c2ZiX2NoZWNrX3ZhcihzdHJ1Y3QgZmJfCiAJCXlyZXMgPSAoeXJlcyArIDEpIC8gMjsK
IAogCWlmICh5cmVzID49IDEyODApIHsKLQkJcHJpbnRrIChLRVJOX1dBUk5JTkcgImNpcnJ1c2Zi
OiBFUlJPUjogVmVydGljYWxUb3RhbCA+PSAxMjgwOyBzcGVjaWFsIHRyZWF0bWVudCByZXF1aXJl
ZCEgKFRPRE8pXG4iKTsKLQkJRFBSSU5USyAoIkVYSVQgLSBFSU5WQUwgZXJyb3JcbiIpOworCQlw
cmludGsoS0VSTl9FUlIgImNpcnJ1c2ZiOiBFUlJPUjogVmVydGljYWxUb3RhbCA+PSAxMjgwOyAi
CisJCQkic3BlY2lhbCB0cmVhdG1lbnQgcmVxdWlyZWQhIChUT0RPKVxuIik7CisJCURQUklOVEso
IkVYSVQgLSBFSU5WQUwgZXJyb3JcbiIpOwogCQlyZXR1cm4gLUVJTlZBTDsKIAl9CiAKIAlyZXR1
cm4gMDsKIH0KIAotc3RhdGljIGludCBjaXJydXNmYl9kZWNvZGVfdmFyIChjb25zdCBzdHJ1Y3Qg
ZmJfdmFyX3NjcmVlbmluZm8gKnZhciwKK3N0YXRpYyBpbnQgY2lycnVzZmJfZGVjb2RlX3Zhcihj
b25zdCBzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8gKnZhciwKIAkJCQlzdHJ1Y3QgY2lycnVzZmJf
cmVncyAqcmVncywKIAkJCQljb25zdCBzdHJ1Y3QgZmJfaW5mbyAqaW5mbykKIHsKQEAgLTg0NCw3
ICs4NDIsNyBAQCBzdGF0aWMgaW50IGNpcnJ1c2ZiX2RlY29kZV92YXIgKGNvbnN0IHN0CiAJaW50
IHhyZXMsIGhmcm9udCwgaHN5bmMsIGhiYWNrOwogCWludCB5cmVzLCB2ZnJvbnQsIHZzeW5jLCB2
YmFjazsKIAotCXN3aXRjaCh2YXItPmJpdHNfcGVyX3BpeGVsKSB7CisJc3dpdGNoICh2YXItPmJp
dHNfcGVyX3BpeGVsKSB7CiAJY2FzZSAxOgogCQlyZWdzLT5saW5lX2xlbmd0aCA9IHZhci0+eHJl
c192aXJ0dWFsIC8gODsKIAkJcmVncy0+dmlzdWFsID0gRkJfVklTVUFMX01PTk8xMDsKQEAgLTg4
Nyw3ICs4ODUsNyBAQCBzdGF0aWMgaW50IGNpcnJ1c2ZiX2RlY29kZV92YXIgKGNvbnN0IHN0CiAJ
LyogY29udmVydCBmcm9tIHBzIHRvIGtIeiAqLwogCWZyZXEgPSAxMDAwMDAwMDAwIC8gdmFyLT5w
aXhjbG9jazsKIAotCURQUklOVEsgKCJkZXNpcmVkIHBpeGNsb2NrOiAlbGQga0h6XG4iLCBmcmVx
KTsKKwlEUFJJTlRLKCJkZXNpcmVkIHBpeGNsb2NrOiAlbGQga0h6XG4iLCBmcmVxKTsKIAogCW1h
eGNsb2NrID0gY2lycnVzZmJfYm9hcmRfaW5mb1tjaW5mby0+YnR5cGVdLm1heGNsb2NrW21heGNs
b2NraWR4XTsKIAlyZWdzLT5tdWx0aXBsZXhpbmcgPSAwOwpAQCAtOTAyLDggKzkwMCw5IEBAIHN0
YXRpYyBpbnQgY2lycnVzZmJfZGVjb2RlX3ZhciAoY29uc3Qgc3QKIAkJCWJyZWFrOwogCiAJCWRl
ZmF1bHQ6Ci0JCQlwcmludGsgKEtFUk5fV0FSTklORyAiY2lycnVzZmI6IEVSUk9SOiBGcmVxdWVu
Y3kgZ3JlYXRlciB0aGFuIG1heGNsb2NrICglbGQga0h6KVxuIiwgbWF4Y2xvY2spOwotCQkJRFBS
SU5USyAoIkVYSVQgLSByZXR1cm4gLUVJTlZBTFxuIik7CisJCQlwcmludGsoS0VSTl9FUlIgImNp
cnJ1c2ZiOiBGcmVxdWVuY3kgZ3JlYXRlciAiCisJCQkJInRoYW4gbWF4Y2xvY2sgKCVsZCBrSHop
XG4iLCBtYXhjbG9jayk7CisJCQlEUFJJTlRLKCJFWElUIC0gcmV0dXJuIC1FSU5WQUxcbiIpOwog
CQkJcmV0dXJuIC1FSU5WQUw7CiAJCX0KIAl9CkBAIC05MTQsMTQgKzkxMywxNiBAQCBzdGF0aWMg
aW50IGNpcnJ1c2ZiX2RlY29kZV92YXIgKGNvbnN0IHN0CiAJY2FzZSAxNjoKIAljYXNlIDMyOgog
CQlpZiAocmVncy0+SG9yaXpSZXMgPD0gODAwKQotCQkJZnJlcSAvPSAyOwkvKiBYYmggaGFzIHRo
aXMgdHlwZSBvZiBjbG9jayBmb3IgMzItYml0ICovCisJCQkvKiBYYmggaGFzIHRoaXMgdHlwZSBv
ZiBjbG9jayBmb3IgMzItYml0ICovCisJCQlmcmVxIC89IDI7CiAJCWJyZWFrOwogCX0KICNlbmRp
ZgogCi0JYmVzdGNsb2NrIChmcmVxLCAmcmVncy0+ZnJlcSwgJnJlZ3MtPm5vbSwgJnJlZ3MtPmRl
biwgJnJlZ3MtPmRpdiwKLQkJICAgbWF4Y2xvY2spOwotCXJlZ3MtPm1jbGsgPSBjaXJydXNmYl9n
ZXRfbWNsayAoZnJlcSwgdmFyLT5iaXRzX3Blcl9waXhlbCwgJnJlZ3MtPmRpdk1DTEspOworCWJl
c3RjbG9jayhmcmVxLCAmcmVncy0+ZnJlcSwgJnJlZ3MtPm5vbSwgJnJlZ3MtPmRlbiwgJnJlZ3Mt
PmRpdiwKKwkJICBtYXhjbG9jayk7CisJcmVncy0+bWNsayA9IGNpcnJ1c2ZiX2dldF9tY2xrKGZy
ZXEsIHZhci0+Yml0c19wZXJfcGl4ZWwsCisJCQkJCSZyZWdzLT5kaXZNQ0xLKTsKIAogCXhyZXMg
PSB2YXItPnhyZXM7CiAJaGZyb250ID0gdmFyLT5yaWdodF9tYXJnaW47CkBAIC05NDgsNyArOTQ5
LDggQEAgc3RhdGljIGludCBjaXJydXNmYl9kZWNvZGVfdmFyIChjb25zdCBzdAogCXJlZ3MtPkhv
cml6VG90YWwgPSAoeHJlcyArIGhmcm9udCArIGhzeW5jICsgaGJhY2spIC8gOCAtIDU7CiAJcmVn
cy0+SG9yaXpEaXNwRW5kID0geHJlcyAvIDggLSAxOwogCXJlZ3MtPkhvcml6QmxhbmtTdGFydCA9
IHhyZXMgLyA4OwotCXJlZ3MtPkhvcml6QmxhbmtFbmQgPSByZWdzLT5Ib3JpelRvdGFsICsgNTsJ
LyogZG9lcyBub3QgY291bnQgd2l0aCAiLTUiICovCisJLyogZG9lcyBub3QgY291bnQgd2l0aCAi
LTUiICovCisJcmVncy0+SG9yaXpCbGFua0VuZCA9IHJlZ3MtPkhvcml6VG90YWwgKyA1OwogCXJl
Z3MtPkhvcml6U3luY1N0YXJ0ID0gKHhyZXMgKyBoZnJvbnQpIC8gOCArIDE7CiAJcmVncy0+SG9y
aXpTeW5jRW5kID0gKHhyZXMgKyBoZnJvbnQgKyBoc3luYykgLyA4ICsgMTsKIApAQCAtOTc2LDIz
ICs5NzgsMjMgQEAgc3RhdGljIGludCBjaXJydXNmYl9kZWNvZGVfdmFyIChjb25zdCBzdAogCXJl
dHVybiAwOwogfQogCi0KLXN0YXRpYyB2b2lkIGNpcnJ1c2ZiX3NldF9tY2xrIChjb25zdCBzdHJ1
Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8sIGludCB2YWwsIGludCBkaXYpCitzdGF0aWMgdm9pZCBj
aXJydXNmYl9zZXRfbWNsayhjb25zdCBzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8sIGludCB2
YWwsCisJCQkJaW50IGRpdikKIHsKLQlhc3NlcnQgKGNpbmZvICE9IE5VTEwpOworCWFzc2VydChj
aW5mbyAhPSBOVUxMKTsKIAogCWlmIChkaXYgPT0gMikgewogCQkvKiBWQ0xLID0gTUNMSy8yICov
Ci0JCXVuc2lnbmVkIGNoYXIgb2xkID0gdmdhX3JzZXEgKGNpbmZvLT5yZWdiYXNlLCBDTF9TRVFS
MUUpOwotCQl2Z2Ffd3NlcSAoY2luZm8tPnJlZ2Jhc2UsIENMX1NFUVIxRSwgb2xkIHwgMHgxKTsK
LQkJdmdhX3dzZXEgKGNpbmZvLT5yZWdiYXNlLCBDTF9TRVFSMUYsIDB4NDAgfCAodmFsICYgMHgz
ZikpOworCQl1bnNpZ25lZCBjaGFyIG9sZCA9IHZnYV9yc2VxKGNpbmZvLT5yZWdiYXNlLCBDTF9T
RVFSMUUpOworCQl2Z2Ffd3NlcShjaW5mby0+cmVnYmFzZSwgQ0xfU0VRUjFFLCBvbGQgfCAweDEp
OworCQl2Z2Ffd3NlcShjaW5mby0+cmVnYmFzZSwgQ0xfU0VRUjFGLCAweDQwIHwgKHZhbCAmIDB4
M2YpKTsKIAl9IGVsc2UgaWYgKGRpdiA9PSAxKSB7CiAJCS8qIFZDTEsgPSBNQ0xLICovCi0JCXVu
c2lnbmVkIGNoYXIgb2xkID0gdmdhX3JzZXEgKGNpbmZvLT5yZWdiYXNlLCBDTF9TRVFSMUUpOwot
CQl2Z2Ffd3NlcSAoY2luZm8tPnJlZ2Jhc2UsIENMX1NFUVIxRSwgb2xkICYgfjB4MSk7Ci0JCXZn
YV93c2VxIChjaW5mby0+cmVnYmFzZSwgQ0xfU0VRUjFGLCAweDQwIHwgKHZhbCAmIDB4M2YpKTsK
KwkJdW5zaWduZWQgY2hhciBvbGQgPSB2Z2FfcnNlcShjaW5mby0+cmVnYmFzZSwgQ0xfU0VRUjFF
KTsKKwkJdmdhX3dzZXEoY2luZm8tPnJlZ2Jhc2UsIENMX1NFUVIxRSwgb2xkICYgfjB4MSk7CisJ
CXZnYV93c2VxKGNpbmZvLT5yZWdiYXNlLCBDTF9TRVFSMUYsIDB4NDAgfCAodmFsICYgMHgzZikp
OwogCX0gZWxzZSB7Ci0JCXZnYV93c2VxIChjaW5mby0+cmVnYmFzZSwgQ0xfU0VRUjFGLCB2YWwg
JiAweDNmKTsKKwkJdmdhX3dzZXEoY2luZm8tPnJlZ2Jhc2UsIENMX1NFUVIxRiwgdmFsICYgMHgz
Zik7CiAJfQogfQogCkBAIC0xMDAxLDcgKzEwMDMsNyBAQCBzdGF0aWMgdm9pZCBjaXJydXNmYl9z
ZXRfbWNsayAoY29uc3Qgc3RyCiAKIAlhY3R1YWxseSB3cml0ZXMgdGhlIHZhbHVlcyBmb3IgYSBu
ZXcgdmlkZW8gbW9kZSBpbnRvIHRoZSBoYXJkd2FyZSwKICoqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwotc3Rh
dGljIGludCBjaXJydXNmYl9zZXRfcGFyX2ZvbyAoc3RydWN0IGZiX2luZm8gKmluZm8pCitzdGF0
aWMgaW50IGNpcnJ1c2ZiX3NldF9wYXJfZm9vKHN0cnVjdCBmYl9pbmZvICppbmZvKQogewogCXN0
cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbyA9IGluZm8tPnBhcjsKIAlzdHJ1Y3QgZmJfdmFyX3Nj
cmVlbmluZm8gKnZhciA9ICZpbmZvLT52YXI7CkBAIC0xMDExLDE1ICsxMDEzLDE1IEBAIHN0YXRp
YyBpbnQgY2lycnVzZmJfc2V0X3Bhcl9mb28gKHN0cnVjdCAKIAlpbnQgb2Zmc2V0ID0gMCwgZXJy
OwogCWNvbnN0IHN0cnVjdCBjaXJydXNmYl9ib2FyZF9pbmZvX3JlYyAqYmk7CiAKLQlEUFJJTlRL
ICgiRU5URVJcbiIpOwotCURQUklOVEsgKCJSZXF1ZXN0ZWQgbW9kZTogJWR4JWR4JWRcbiIsCisJ
RFBSSU5USygiRU5URVJcbiIpOworCURQUklOVEsoIlJlcXVlc3RlZCBtb2RlOiAlZHglZHglZFxu
IiwKIAkgICAgICAgdmFyLT54cmVzLCB2YXItPnlyZXMsIHZhci0+Yml0c19wZXJfcGl4ZWwpOwot
CURQUklOVEsgKCJwaXhjbG9jazogJWRcbiIsIHZhci0+cGl4Y2xvY2spOworCURQUklOVEsoInBp
eGNsb2NrOiAlZFxuIiwgdmFyLT5waXhjbG9jayk7CiAKLQlpbml0X3ZnYWNoaXAgKGNpbmZvKTsK
Kwlpbml0X3ZnYWNoaXAoY2luZm8pOwogCiAJZXJyID0gY2lycnVzZmJfZGVjb2RlX3Zhcih2YXIs
ICZyZWdzLCBpbmZvKTsKLQlpZihlcnIpIHsKKwlpZiAoZXJyKSB7CiAJCS8qIHNob3VsZCBuZXZl
ciBoYXBwZW4gKi8KIAkJRFBSSU5USygibW9kZSBjaGFuZ2UgYWJvcnRlZC4gIGludmFsaWQgdmFy
LlxuIik7CiAJCXJldHVybiAtRUlOVkFMOwpAQCAtMTAyNywzNCArMTAyOSwzNSBAQCBzdGF0aWMg
aW50IGNpcnJ1c2ZiX3NldF9wYXJfZm9vIChzdHJ1Y3QgCiAKIAliaSA9ICZjaXJydXNmYl9ib2Fy
ZF9pbmZvW2NpbmZvLT5idHlwZV07CiAKLQogCS8qIHVubG9jayByZWdpc3RlciBWR0FfQ1JUQ19I
X1RPVEFMLi5DUlQ3ICovCi0JdmdhX3djcnQgKHJlZ2Jhc2UsIFZHQV9DUlRDX1ZfU1lOQ19FTkQs
IDB4MjApOwkvKiBwcmV2aW91c2x5OiAweDAwKSAqLworCXZnYV93Y3J0KHJlZ2Jhc2UsIFZHQV9D
UlRDX1ZfU1lOQ19FTkQsIDB4MjApOwkvKiBwcmV2aW91c2x5OiAweDAwKSAqLwogCiAJLyogaWYg
ZGVidWdnaW5nIGlzIGVuYWJsZWQsIGFsbCBwYXJhbWV0ZXJzIGdldCBvdXRwdXQgYmVmb3JlIHdy
aXRpbmcgKi8KLQlEUFJJTlRLICgiQ1JUMDogJWxkXG4iLCByZWdzLkhvcml6VG90YWwpOwotCXZn
YV93Y3J0IChyZWdiYXNlLCBWR0FfQ1JUQ19IX1RPVEFMLCByZWdzLkhvcml6VG90YWwpOworCURQ
UklOVEsoIkNSVDA6ICVsZFxuIiwgcmVncy5Ib3JpelRvdGFsKTsKKwl2Z2Ffd2NydChyZWdiYXNl
LCBWR0FfQ1JUQ19IX1RPVEFMLCByZWdzLkhvcml6VG90YWwpOwogCi0JRFBSSU5USyAoIkNSVDE6
ICVsZFxuIiwgcmVncy5Ib3JpekRpc3BFbmQpOwotCXZnYV93Y3J0IChyZWdiYXNlLCBWR0FfQ1JU
Q19IX0RJU1AsIHJlZ3MuSG9yaXpEaXNwRW5kKTsKKwlEUFJJTlRLKCJDUlQxOiAlbGRcbiIsIHJl
Z3MuSG9yaXpEaXNwRW5kKTsKKwl2Z2Ffd2NydChyZWdiYXNlLCBWR0FfQ1JUQ19IX0RJU1AsIHJl
Z3MuSG9yaXpEaXNwRW5kKTsKIAotCURQUklOVEsgKCJDUlQyOiAlbGRcbiIsIHJlZ3MuSG9yaXpC
bGFua1N0YXJ0KTsKLQl2Z2Ffd2NydCAocmVnYmFzZSwgVkdBX0NSVENfSF9CTEFOS19TVEFSVCwg
cmVncy5Ib3JpekJsYW5rU3RhcnQpOworCURQUklOVEsoIkNSVDI6ICVsZFxuIiwgcmVncy5Ib3Jp
ekJsYW5rU3RhcnQpOworCXZnYV93Y3J0KHJlZ2Jhc2UsIFZHQV9DUlRDX0hfQkxBTktfU1RBUlQs
IHJlZ3MuSG9yaXpCbGFua1N0YXJ0KTsKIAotCURQUklOVEsgKCJDUlQzOiAxMjgrJWxkXG4iLCBy
ZWdzLkhvcml6QmxhbmtFbmQgJSAzMik7CS8qICArIDEyODogQ29tcGF0aWJsZSByZWFkICovCi0J
dmdhX3djcnQgKHJlZ2Jhc2UsIFZHQV9DUlRDX0hfQkxBTktfRU5ELCAxMjggKyAocmVncy5Ib3Jp
ekJsYW5rRW5kICUgMzIpKTsKKwkvKiAgKyAxMjg6IENvbXBhdGlibGUgcmVhZCAqLworCURQUklO
VEsoIkNSVDM6IDEyOCslbGRcbiIsIHJlZ3MuSG9yaXpCbGFua0VuZCAlIDMyKTsKKwl2Z2Ffd2Ny
dChyZWdiYXNlLCBWR0FfQ1JUQ19IX0JMQU5LX0VORCwKKwkJIDEyOCArIChyZWdzLkhvcml6Qmxh
bmtFbmQgJSAzMikpOwogCi0JRFBSSU5USyAoIkNSVDQ6ICVsZFxuIiwgcmVncy5Ib3JpelN5bmNT
dGFydCk7Ci0JdmdhX3djcnQgKHJlZ2Jhc2UsIFZHQV9DUlRDX0hfU1lOQ19TVEFSVCwgcmVncy5I
b3JpelN5bmNTdGFydCk7CisJRFBSSU5USygiQ1JUNDogJWxkXG4iLCByZWdzLkhvcml6U3luY1N0
YXJ0KTsKKwl2Z2Ffd2NydChyZWdiYXNlLCBWR0FfQ1JUQ19IX1NZTkNfU1RBUlQsIHJlZ3MuSG9y
aXpTeW5jU3RhcnQpOwogCiAJdG1wID0gcmVncy5Ib3JpelN5bmNFbmQgJSAzMjsKIAlpZiAocmVn
cy5Ib3JpekJsYW5rRW5kICYgMzIpCiAJCXRtcCArPSAxMjg7Ci0JRFBSSU5USyAoIkNSVDU6ICVk
XG4iLCB0bXApOwotCXZnYV93Y3J0IChyZWdiYXNlLCBWR0FfQ1JUQ19IX1NZTkNfRU5ELCB0bXAp
OworCURQUklOVEsoIkNSVDU6ICVkXG4iLCB0bXApOworCXZnYV93Y3J0KHJlZ2Jhc2UsIFZHQV9D
UlRDX0hfU1lOQ19FTkQsIHRtcCk7CiAKLQlEUFJJTlRLICgiQ1JUNjogJWxkXG4iLCByZWdzLlZl
cnRUb3RhbCAmIDB4ZmYpOwotCXZnYV93Y3J0IChyZWdiYXNlLCBWR0FfQ1JUQ19WX1RPVEFMLCAo
cmVncy5WZXJ0VG90YWwgJiAweGZmKSk7CisJRFBSSU5USygiQ1JUNjogJWxkXG4iLCByZWdzLlZl
cnRUb3RhbCAmIDB4ZmYpOworCXZnYV93Y3J0KHJlZ2Jhc2UsIFZHQV9DUlRDX1ZfVE9UQUwsIChy
ZWdzLlZlcnRUb3RhbCAmIDB4ZmYpKTsKIAogCXRtcCA9IDE2OwkJLyogTGluZUNvbXBhcmUgYml0
ICM5ICovCiAJaWYgKHJlZ3MuVmVydFRvdGFsICYgMjU2KQpAQCAtMTA3MSwzNCArMTA3NCwzNCBA
QCBzdGF0aWMgaW50IGNpcnJ1c2ZiX3NldF9wYXJfZm9vIChzdHJ1Y3QgCiAJCXRtcCB8PSA2NDsK
IAlpZiAocmVncy5WZXJ0U3luY1N0YXJ0ICYgNTEyKQogCQl0bXAgfD0gMTI4OwotCURQUklOVEsg
KCJDUlQ3OiAlZFxuIiwgdG1wKTsKLQl2Z2Ffd2NydCAocmVnYmFzZSwgVkdBX0NSVENfT1ZFUkZM
T1csIHRtcCk7CisJRFBSSU5USygiQ1JUNzogJWRcbiIsIHRtcCk7CisJdmdhX3djcnQocmVnYmFz
ZSwgVkdBX0NSVENfT1ZFUkZMT1csIHRtcCk7CiAKIAl0bXAgPSAweDQwOwkJLyogTGluZUNvbXBh
cmUgYml0ICM4ICovCiAJaWYgKHJlZ3MuVmVydEJsYW5rU3RhcnQgJiA1MTIpCiAJCXRtcCB8PSAw
eDIwOwogCWlmICh2YXItPnZtb2RlICYgRkJfVk1PREVfRE9VQkxFKQogCQl0bXAgfD0gMHg4MDsK
LQlEUFJJTlRLICgiQ1JUOTogJWRcbiIsIHRtcCk7Ci0JdmdhX3djcnQgKHJlZ2Jhc2UsIFZHQV9D
UlRDX01BWF9TQ0FOLCB0bXApOworCURQUklOVEsoIkNSVDk6ICVkXG4iLCB0bXApOworCXZnYV93
Y3J0KHJlZ2Jhc2UsIFZHQV9DUlRDX01BWF9TQ0FOLCB0bXApOwogCi0JRFBSSU5USyAoIkNSVDEw
OiAlbGRcbiIsIHJlZ3MuVmVydFN5bmNTdGFydCAmIDB4ZmYpOwotCXZnYV93Y3J0IChyZWdiYXNl
LCBWR0FfQ1JUQ19WX1NZTkNfU1RBUlQsIChyZWdzLlZlcnRTeW5jU3RhcnQgJiAweGZmKSk7CisJ
RFBSSU5USygiQ1JUMTA6ICVsZFxuIiwgcmVncy5WZXJ0U3luY1N0YXJ0ICYgMHhmZik7CisJdmdh
X3djcnQocmVnYmFzZSwgVkdBX0NSVENfVl9TWU5DX1NUQVJULCByZWdzLlZlcnRTeW5jU3RhcnQg
JiAweGZmKTsKIAotCURQUklOVEsgKCJDUlQxMTogNjQrMzIrJWxkXG4iLCByZWdzLlZlcnRTeW5j
RW5kICUgMTYpOwotCXZnYV93Y3J0IChyZWdiYXNlLCBWR0FfQ1JUQ19WX1NZTkNfRU5ELCAocmVn
cy5WZXJ0U3luY0VuZCAlIDE2ICsgNjQgKyAzMikpOworCURQUklOVEsoIkNSVDExOiA2NCszMisl
bGRcbiIsIHJlZ3MuVmVydFN5bmNFbmQgJSAxNik7CisJdmdhX3djcnQocmVnYmFzZSwgVkdBX0NS
VENfVl9TWU5DX0VORCwgcmVncy5WZXJ0U3luY0VuZCAlIDE2ICsgNjQgKyAzMik7CiAKLQlEUFJJ
TlRLICgiQ1JUMTI6ICVsZFxuIiwgcmVncy5WZXJ0RGlzcEVuZCAmIDB4ZmYpOwotCXZnYV93Y3J0
IChyZWdiYXNlLCBWR0FfQ1JUQ19WX0RJU1BfRU5ELCAocmVncy5WZXJ0RGlzcEVuZCAmIDB4ZmYp
KTsKKwlEUFJJTlRLKCJDUlQxMjogJWxkXG4iLCByZWdzLlZlcnREaXNwRW5kICYgMHhmZik7CisJ
dmdhX3djcnQocmVnYmFzZSwgVkdBX0NSVENfVl9ESVNQX0VORCwgcmVncy5WZXJ0RGlzcEVuZCAm
IDB4ZmYpOwogCi0JRFBSSU5USyAoIkNSVDE1OiAlbGRcbiIsIHJlZ3MuVmVydEJsYW5rU3RhcnQg
JiAweGZmKTsKLQl2Z2Ffd2NydCAocmVnYmFzZSwgVkdBX0NSVENfVl9CTEFOS19TVEFSVCwgKHJl
Z3MuVmVydEJsYW5rU3RhcnQgJiAweGZmKSk7CisJRFBSSU5USygiQ1JUMTU6ICVsZFxuIiwgcmVn
cy5WZXJ0QmxhbmtTdGFydCAmIDB4ZmYpOworCXZnYV93Y3J0KHJlZ2Jhc2UsIFZHQV9DUlRDX1Zf
QkxBTktfU1RBUlQsIHJlZ3MuVmVydEJsYW5rU3RhcnQgJiAweGZmKTsKIAotCURQUklOVEsgKCJD
UlQxNjogJWxkXG4iLCByZWdzLlZlcnRCbGFua0VuZCAmIDB4ZmYpOwotCXZnYV93Y3J0IChyZWdi
YXNlLCBWR0FfQ1JUQ19WX0JMQU5LX0VORCwgKHJlZ3MuVmVydEJsYW5rRW5kICYgMHhmZikpOwor
CURQUklOVEsoIkNSVDE2OiAlbGRcbiIsIHJlZ3MuVmVydEJsYW5rRW5kICYgMHhmZik7CisJdmdh
X3djcnQocmVnYmFzZSwgVkdBX0NSVENfVl9CTEFOS19FTkQsIHJlZ3MuVmVydEJsYW5rRW5kICYg
MHhmZik7CiAKLQlEUFJJTlRLICgiQ1JUMTg6IDB4ZmZcbiIpOwotCXZnYV93Y3J0IChyZWdiYXNl
LCBWR0FfQ1JUQ19MSU5FX0NPTVBBUkUsIDB4ZmYpOworCURQUklOVEsoIkNSVDE4OiAweGZmXG4i
KTsKKwl2Z2Ffd2NydChyZWdiYXNlLCBWR0FfQ1JUQ19MSU5FX0NPTVBBUkUsIDB4ZmYpOwogCiAJ
dG1wID0gMDsKIAlpZiAodmFyLT52bW9kZSAmIEZCX1ZNT0RFX0lOVEVSTEFDRUQpCkBAIC0xMTEy
LDU3ICsxMTE1LDYzIEBAIHN0YXRpYyBpbnQgY2lycnVzZmJfc2V0X3Bhcl9mb28gKHN0cnVjdCAK
IAlpZiAocmVncy5WZXJ0QmxhbmtFbmQgJiA1MTIpCiAJCXRtcCB8PSAxMjg7CiAKLQlEUFJJTlRL
ICgiQ1JUMWE6ICVkXG4iLCB0bXApOwotCXZnYV93Y3J0IChyZWdiYXNlLCBDTF9DUlQxQSwgdG1w
KTsKKwlEUFJJTlRLKCJDUlQxYTogJWRcbiIsIHRtcCk7CisJdmdhX3djcnQocmVnYmFzZSwgQ0xf
Q1JUMUEsIHRtcCk7CiAKIAkvKiBzZXQgVkNMSzAgKi8KIAkvKiBoYXJkd2FyZSBSZWZDbG9jazog
MTQuMzE4MTggTUh6ICovCiAJLyogZm9ybXVsYTogVkNsayA9IChPU0MgKiBOKSAvIChEICogKDEr
UCkpICovCiAJLyogRXhhbXBsZTogVkNsayA9ICgxNC4zMTgxOCAqIDkxKSAvICgyMyAqICgxKzEp
KSA9IDI4LjMyNSBNSHogKi8KIAotCXZnYV93c2VxIChyZWdiYXNlLCBDTF9TRVFSQiwgcmVncy5u
b20pOworCXZnYV93c2VxKHJlZ2Jhc2UsIENMX1NFUVJCLCByZWdzLm5vbSk7CiAJdG1wID0gcmVn
cy5kZW4gPDwgMTsKIAlpZiAocmVncy5kaXYgIT0gMCkKIAkJdG1wIHw9IDE7CiAKKwkvKiA2IGJp
dCBkZW5vbTsgT05MWSA1NDM0ISEhIChidWdnZWQgbWUgMTAgZGF5cykgKi8KIAlpZiAoKGNpbmZv
LT5idHlwZSA9PSBCVF9TRDY0KSB8fAogCSAgICAoY2luZm8tPmJ0eXBlID09IEJUX0FMUElORSkg
fHwKIAkgICAgKGNpbmZvLT5idHlwZSA9PSBCVF9HRDU0ODApKQotCQl0bXAgfD0gMHg4MDsJLyog
NiBiaXQgZGVub207IE9OTFkgNTQzNCEhISAoYnVnZ2VkIG1lIDEwIGRheXMpICovCisJCXRtcCB8
PSAweDgwOwogCi0JRFBSSU5USyAoIkNMX1NFUVIxQjogJWxkXG4iLCAobG9uZykgdG1wKTsKLQl2
Z2Ffd3NlcSAocmVnYmFzZSwgQ0xfU0VRUjFCLCB0bXApOworCURQUklOVEsoIkNMX1NFUVIxQjog
JWxkXG4iLCAobG9uZykgdG1wKTsKKwl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9TRVFSMUIsIHRtcCk7
CiAKIAlpZiAocmVncy5WZXJ0UmVzID49IDEwMjQpCiAJCS8qIDEyODB4MTAyNCAqLwotCQl2Z2Ff
d2NydCAocmVnYmFzZSwgVkdBX0NSVENfTU9ERSwgMHhjNyk7CisJCXZnYV93Y3J0KHJlZ2Jhc2Us
IFZHQV9DUlRDX01PREUsIDB4YzcpOwogCWVsc2UKIAkJLyogbW9kZSBjb250cm9sOiBWR0FfQ1JU
Q19TVEFSVF9ISSBlbmFibGUsIFJPVEFURSg/KSwgMTZiaXQKIAkJICogYWRkcmVzcyB3cmFwLCBu
byBjb21wYXQuICovCi0JCXZnYV93Y3J0IChyZWdiYXNlLCBWR0FfQ1JUQ19NT0RFLCAweGMzKTsK
KwkJdmdhX3djcnQocmVnYmFzZSwgVkdBX0NSVENfTU9ERSwgMHhjMyk7CiAKLS8qIEhBRUg/ICAg
ICAgICB2Z2Ffd2NydCAocmVnYmFzZSwgVkdBX0NSVENfVl9TWU5DX0VORCwgMHgyMCk7ICAqIHBy
ZXZpb3VzbHk6IDB4MDAgIHVubG9jayBWR0FfQ1JUQ19IX1RPVEFMLi5DUlQ3ICovCisvKiBIQUVI
Pwl2Z2Ffd2NydChyZWdiYXNlLCBWR0FfQ1JUQ19WX1NZTkNfRU5ELCAweDIwKTsKKyAqIHByZXZp
b3VzbHk6IDB4MDAgIHVubG9jayBWR0FfQ1JUQ19IX1RPVEFMLi5DUlQ3ICovCiAKIAkvKiBkb24n
dCBrbm93IGlmIGl0IHdvdWxkIGh1cnQgdG8gYWxzbyBwcm9ncmFtIHRoaXMgaWYgbm8gaW50ZXJs
YWNlZCAqLwogCS8qIG1vZGUgaXMgdXNlZCwgYnV0IEkgZmVlbCBiZXR0ZXIgdGhpcyB3YXkuLiA6
LSkgKi8KIAlpZiAodmFyLT52bW9kZSAmIEZCX1ZNT0RFX0lOVEVSTEFDRUQpCi0JCXZnYV93Y3J0
IChyZWdiYXNlLCBWR0FfQ1JUQ19SRUdTLCByZWdzLkhvcml6VG90YWwgLyAyKTsKKwkJdmdhX3dj
cnQocmVnYmFzZSwgVkdBX0NSVENfUkVHUywgcmVncy5Ib3JpelRvdGFsIC8gMik7CiAJZWxzZQot
CQl2Z2Ffd2NydCAocmVnYmFzZSwgVkdBX0NSVENfUkVHUywgMHgwMCk7CS8qIGludGVybGFjZSBj
b250cm9sICovCisJCXZnYV93Y3J0KHJlZ2Jhc2UsIFZHQV9DUlRDX1JFR1MsIDB4MDApOwkvKiBp
bnRlcmxhY2UgY29udHJvbCAqLwogCi0JdmdhX3dzZXEgKHJlZ2Jhc2UsIFZHQV9TRVFfQ0hBUkFD
VEVSX01BUCwgMCk7CisJdmdhX3dzZXEocmVnYmFzZSwgVkdBX1NFUV9DSEFSQUNURVJfTUFQLCAw
KTsKIAogCS8qIGFkanVzdCBob3Jpem9udGFsL3ZlcnRpY2FsIHN5bmMgdHlwZSAobG93L2hpZ2gp
ICovCi0JdG1wID0gMHgwMzsJCS8qIGVuYWJsZSBkaXNwbGF5IG1lbW9yeSAmIENSVEMgSS9PIGFk
ZHJlc3MgZm9yIGNvbG9yIG1vZGUgKi8KKwkvKiBlbmFibGUgZGlzcGxheSBtZW1vcnkgJiBDUlRD
IEkvTyBhZGRyZXNzIGZvciBjb2xvciBtb2RlICovCisJdG1wID0gMHgwMzsKIAlpZiAodmFyLT5z
eW5jICYgRkJfU1lOQ19IT1JfSElHSF9BQ1QpCiAJCXRtcCB8PSAweDQwOwogCWlmICh2YXItPnN5
bmMgJiBGQl9TWU5DX1ZFUlRfSElHSF9BQ1QpCiAJCXRtcCB8PSAweDgwOwotCVdHZW4gKGNpbmZv
LCBWR0FfTUlTX1csIHRtcCk7CisJV0dlbihjaW5mbywgVkdBX01JU19XLCB0bXApOwogCi0Jdmdh
X3djcnQgKHJlZ2Jhc2UsIFZHQV9DUlRDX1BSRVNFVF9ST1csIDApOwkvKiBTY3JlZW4gQSBQcmVz
ZXQgUm93LVNjYW4gcmVnaXN0ZXIgKi8KLQl2Z2Ffd2NydCAocmVnYmFzZSwgVkdBX0NSVENfQ1VS
U09SX1NUQVJULCAwKTsJLyogdGV4dCBjdXJzb3Igb24gYW5kIHN0YXJ0IGxpbmUgKi8KLQl2Z2Ff
d2NydCAocmVnYmFzZSwgVkdBX0NSVENfQ1VSU09SX0VORCwgMzEpOwkvKiB0ZXh0IGN1cnNvciBl
bmQgbGluZSAqLworCS8qIFNjcmVlbiBBIFByZXNldCBSb3ctU2NhbiByZWdpc3RlciAqLworCXZn
YV93Y3J0KHJlZ2Jhc2UsIFZHQV9DUlRDX1BSRVNFVF9ST1csIDApOworCS8qIHRleHQgY3Vyc29y
IG9uIGFuZCBzdGFydCBsaW5lICovCisJdmdhX3djcnQocmVnYmFzZSwgVkdBX0NSVENfQ1VSU09S
X1NUQVJULCAwKTsKKwkvKiB0ZXh0IGN1cnNvciBlbmQgbGluZSAqLworCXZnYV93Y3J0KHJlZ2Jh
c2UsIFZHQV9DUlRDX0NVUlNPUl9FTkQsIDMxKTsKIAogCS8qKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKIAkgKgpAQCAtMTE3Miw4ICsxMTgxLDgg
QEAgc3RhdGljIGludCBjaXJydXNmYl9zZXRfcGFyX2ZvbyAoc3RydWN0IAogCiAJLyogcHJvZ3Jh
bW1pbmcgZm9yIGRpZmZlcmVudCBjb2xvciBkZXB0aHMgKi8KIAlpZiAodmFyLT5iaXRzX3Blcl9w
aXhlbCA9PSAxKSB7Ci0JCURQUklOVEsgKCJjaXJydXNmYjogcHJlcGFyaW5nIGZvciAxIGJpdCBk
ZWVwIGRpc3BsYXlcbiIpOwotCQl2Z2Ffd2dmeCAocmVnYmFzZSwgVkdBX0dGWF9NT0RFLCAwKTsJ
LyogbW9kZSByZWdpc3RlciAqLworCQlEUFJJTlRLKCJjaXJydXNmYjogcHJlcGFyaW5nIGZvciAx
IGJpdCBkZWVwIGRpc3BsYXlcbiIpOworCQl2Z2Ffd2dmeChyZWdiYXNlLCBWR0FfR0ZYX01PREUs
IDApOwkvKiBtb2RlIHJlZ2lzdGVyICovCiAKIAkJLyogU1IwNyAqLwogCQlzd2l0Y2ggKGNpbmZv
LT5idHlwZSkgewpAQCAtMTE4NCw3MSArMTE5Myw4NSBAQCBzdGF0aWMgaW50IGNpcnJ1c2ZiX3Nl
dF9wYXJfZm9vIChzdHJ1Y3QgCiAJCWNhc2UgQlRfUElDQVNTTzQ6CiAJCWNhc2UgQlRfQUxQSU5F
OgogCQljYXNlIEJUX0dENTQ4MDoKLQkJCURQUklOVEsgKCIgKGZvciBHRDU0eHgpXG4iKTsKLQkJ
CXZnYV93c2VxIChyZWdiYXNlLCBDTF9TRVFSNywKKwkJCURQUklOVEsoIiAoZm9yIEdENTR4eClc
biIpOworCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjcsCiAJCQkJICByZWdzLm11bHRpcGxl
eGluZyA/CiAJCQkJCWJpLT5zcjA3XzFicHBfbXV4IDogYmktPnNyMDdfMWJwcCk7CiAJCQlicmVh
azsKIAogCQljYXNlIEJUX0xBR1VOQToKLQkJCURQUklOVEsgKCIgKGZvciBHRDU0NngpXG4iKTsK
LQkJCXZnYV93c2VxIChyZWdiYXNlLCBDTF9TRVFSNywKLQkJCQl2Z2FfcnNlcSAocmVnYmFzZSwg
Q0xfU0VRUjcpICYgfjB4MDEpOworCQkJRFBSSU5USygiIChmb3IgR0Q1NDZ4KVxuIik7CisJCQl2
Z2Ffd3NlcShyZWdiYXNlLCBDTF9TRVFSNywKKwkJCQl2Z2FfcnNlcShyZWdiYXNlLCBDTF9TRVFS
NykgJiB+MHgwMSk7CiAJCQlicmVhazsKIAogCQlkZWZhdWx0OgotCQkJcHJpbnRrIChLRVJOX1dB
Uk5JTkcgImNpcnJ1c2ZiOiB1bmtub3duIEJvYXJkXG4iKTsKKwkJCXByaW50ayhLRVJOX1dBUk5J
TkcgImNpcnJ1c2ZiOiB1bmtub3duIEJvYXJkXG4iKTsKIAkJCWJyZWFrOwogCQl9CiAKIAkJLyog
RXh0ZW5kZWQgU2VxdWVuY2VyIE1vZGUgKi8KIAkJc3dpdGNoIChjaW5mby0+YnR5cGUpIHsKIAkJ
Y2FzZSBCVF9TRDY0OgotCQkJLyogc2V0dGluZyB0aGUgU0VRUkYgb24gU0Q2NCBpcyBub3QgbmVj
ZXNzYXJ5IChvbmx5IGR1cmluZyBpbml0KSAqLwotCQkJRFBSSU5USyAoIihmb3IgU0Q2NClcbiIp
OwotCQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVIxRiwgMHgxYSk7CQkvKiAgTUNMSyBzZWxl
Y3QgKi8KKwkJCS8qIHNldHRpbmcgdGhlIFNFUVJGIG9uIFNENjQgaXMgbm90IG5lY2Vzc2FyeQor
CQkJICogKG9ubHkgZHVyaW5nIGluaXQpCisJCQkgKi8KKwkJCURQUklOVEsoIihmb3IgU0Q2NClc
biIpOworCQkJLyogIE1DTEsgc2VsZWN0ICovCisJCQl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9TRVFS
MUYsIDB4MWEpOwogCQkJYnJlYWs7CiAKIAkJY2FzZSBCVF9QSUNDT0xPOgotCQkJRFBSSU5USyAo
Iihmb3IgUGljY29sbylcbiIpOwotLyogIyMjIHVlYmVyYWxsIDB4MjI/ICovCi0JCQl2Z2Ffd3Nl
cSAocmVnYmFzZSwgQ0xfU0VRUjFGLCAweDIyKTsJCS8qICMjdm9yaGVyIDFjIE1DTEsgc2VsZWN0
ICovCi0JCQl2Z2Ffd3NlcSAocmVnYmFzZSwgQ0xfU0VRUkYsIDB4YjApOwkvKiBldnRsIGQwIGJl
aSAxIGJpdD8gYXZvaWQgRklGTyB1bmRlcnJ1bnMuLj8gKi8KKwkJCURQUklOVEsoIihmb3IgUGlj
Y29sbylcbiIpOworCQkJLyogIyMjIHVlYmVyYWxsIDB4MjI/ICovCisJCQkvKiAjI3ZvcmhlciAx
YyBNQ0xLIHNlbGVjdCAqLworCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjFGLCAweDIyKTsK
KwkJCS8qIGV2dGwgZDAgYmVpIDEgYml0PyBhdm9pZCBGSUZPIHVuZGVycnVucy4uPyAqLworCQkJ
dmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUkYsIDB4YjApOwogCQkJYnJlYWs7CiAKIAkJY2FzZSBC
VF9QSUNBU1NPOgotCQkJRFBSSU5USyAoIihmb3IgUGljYXNzbylcbiIpOwotCQkJdmdhX3dzZXEg
KHJlZ2Jhc2UsIENMX1NFUVIxRiwgMHgyMik7CQkvKiAjI3ZvcmhlciAyMiBNQ0xLIHNlbGVjdCAq
LwotCQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVJGLCAweGQwKTsJLyogIyMgdm9yaGVyIGQw
IGF2b2lkIEZJRk8gdW5kZXJydW5zLi4/ICovCisJCQlEUFJJTlRLKCIoZm9yIFBpY2Fzc28pXG4i
KTsKKwkJCS8qICMjdm9yaGVyIDIyIE1DTEsgc2VsZWN0ICovCisJCQl2Z2Ffd3NlcShyZWdiYXNl
LCBDTF9TRVFSMUYsIDB4MjIpOworCQkJLyogIyMgdm9yaGVyIGQwIGF2b2lkIEZJRk8gdW5kZXJy
dW5zLi4/ICovCisJCQl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9TRVFSRiwgMHhkMCk7CiAJCQlicmVh
azsKIAogCQljYXNlIEJUX1NQRUNUUlVNOgotCQkJRFBSSU5USyAoIihmb3IgU3BlY3RydW0pXG4i
KTsKLS8qICMjIyB1ZWJlcmFsbCAweDIyPyAqLwotCQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NF
UVIxRiwgMHgyMik7CQkvKiAjI3ZvcmhlciAxYyBNQ0xLIHNlbGVjdCAqLwotCQkJdmdhX3dzZXEg
KHJlZ2Jhc2UsIENMX1NFUVJGLCAweGIwKTsJLyogZXZ0bCBkMD8gYXZvaWQgRklGTyB1bmRlcnJ1
bnMuLj8gKi8KKwkJCURQUklOVEsoIihmb3IgU3BlY3RydW0pXG4iKTsKKwkJCS8qICMjIyB1ZWJl
cmFsbCAweDIyPyAqLworCQkJLyogIyN2b3JoZXIgMWMgTUNMSyBzZWxlY3QgKi8KKwkJCXZnYV93
c2VxKHJlZ2Jhc2UsIENMX1NFUVIxRiwgMHgyMik7CisJCQkvKiBldnRsIGQwPyBhdm9pZCBGSUZP
IHVuZGVycnVucy4uPyAqLworCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUkYsIDB4YjApOwog
CQkJYnJlYWs7CiAKIAkJY2FzZSBCVF9QSUNBU1NPNDoKIAkJY2FzZSBCVF9BTFBJTkU6CiAJCWNh
c2UgQlRfR0Q1NDgwOgogCQljYXNlIEJUX0xBR1VOQToKLQkJCURQUklOVEsgKCIgKGZvciBHRDU0
eHgpXG4iKTsKKwkJCURQUklOVEsoIiAoZm9yIEdENTR4eClcbiIpOwogCQkJLyogZG8gbm90aGlu
ZyAqLwogCQkJYnJlYWs7CiAKIAkJZGVmYXVsdDoKLQkJCXByaW50ayAoS0VSTl9XQVJOSU5HICJj
aXJydXNmYjogdW5rbm93biBCb2FyZFxuIik7CisJCQlwcmludGsoS0VSTl9XQVJOSU5HICJjaXJy
dXNmYjogdW5rbm93biBCb2FyZFxuIik7CiAJCQlicmVhazsKIAkJfQogCi0JCVdHZW4gKGNpbmZv
LCBWR0FfUEVMX01TSywgMHgwMSk7CS8qIHBpeGVsIG1hc2s6IHBhc3MtdGhyb3VnaCBmb3IgZmly
c3QgcGxhbmUgKi8KKwkJLyogcGl4ZWwgbWFzazogcGFzcy10aHJvdWdoIGZvciBmaXJzdCBwbGFu
ZSAqLworCQlXR2VuKGNpbmZvLCBWR0FfUEVMX01TSywgMHgwMSk7CiAJCWlmIChyZWdzLm11bHRp
cGxleGluZykKLQkJCVdIRFIgKGNpbmZvLCAweDRhKTsJLyogaGlkZGVuIGRhYyByZWc6IDEyODB4
MTAyNCAqLworCQkJLyogaGlkZGVuIGRhYyByZWc6IDEyODB4MTAyNCAqLworCQkJV0hEUihjaW5m
bywgMHg0YSk7CiAJCWVsc2UKLQkJCVdIRFIgKGNpbmZvLCAwKTsJLyogaGlkZGVuIGRhYzogbm90
aGluZyAqLwotCQl2Z2Ffd3NlcSAocmVnYmFzZSwgVkdBX1NFUV9NRU1PUllfTU9ERSwgMHgwNik7
CS8qIG1lbW9yeSBtb2RlOiBvZGQvZXZlbiwgZXh0LiBtZW1vcnkgKi8KLQkJdmdhX3dzZXEgKHJl
Z2Jhc2UsIFZHQV9TRVFfUExBTkVfV1JJVEUsIDB4MDEpOwkvKiBwbGFuZSBtYXNrOiBvbmx5IHdy
aXRlIHRvIGZpcnN0IHBsYW5lICovCisJCQkvKiBoaWRkZW4gZGFjOiBub3RoaW5nICovCisJCQlX
SERSKGNpbmZvLCAwKTsKKwkJLyogbWVtb3J5IG1vZGU6IG9kZC9ldmVuLCBleHQuIG1lbW9yeSAq
LworCQl2Z2Ffd3NlcShyZWdiYXNlLCBWR0FfU0VRX01FTU9SWV9NT0RFLCAweDA2KTsKKwkJLyog
cGxhbmUgbWFzazogb25seSB3cml0ZSB0byBmaXJzdCBwbGFuZSAqLworCQl2Z2Ffd3NlcShyZWdi
YXNlLCBWR0FfU0VRX1BMQU5FX1dSSVRFLCAweDAxKTsKIAkJb2Zmc2V0ID0gdmFyLT54cmVzX3Zp
cnR1YWwgLyAxNjsKIAl9CiAKQEAgLTEyNTksNyArMTI4Miw3IEBAIHN0YXRpYyBpbnQgY2lycnVz
ZmJfc2V0X3Bhcl9mb28gKHN0cnVjdCAKIAkgKi8KIAogCWVsc2UgaWYgKHZhci0+Yml0c19wZXJf
cGl4ZWwgPT0gOCkgewotCQlEUFJJTlRLICgiY2lycnVzZmI6IHByZXBhcmluZyBmb3IgOCBiaXQg
ZGVlcCBkaXNwbGF5XG4iKTsKKwkJRFBSSU5USygiY2lycnVzZmI6IHByZXBhcmluZyBmb3IgOCBi
aXQgZGVlcCBkaXNwbGF5XG4iKTsKIAkJc3dpdGNoIChjaW5mby0+YnR5cGUpIHsKIAkJY2FzZSBC
VF9TRDY0OgogCQljYXNlIEJUX1BJQ0NPTE86CkBAIC0xMjY4LDc1ICsxMjkxLDg5IEBAIHN0YXRp
YyBpbnQgY2lycnVzZmJfc2V0X3Bhcl9mb28gKHN0cnVjdCAKIAkJY2FzZSBCVF9QSUNBU1NPNDoK
IAkJY2FzZSBCVF9BTFBJTkU6CiAJCWNhc2UgQlRfR0Q1NDgwOgotCQkJRFBSSU5USyAoIiAoZm9y
IEdENTR4eClcbiIpOwotCQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVI3LAorCQkJRFBSSU5U
SygiIChmb3IgR0Q1NHh4KVxuIik7CisJCQl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9TRVFSNywKIAkJ
CQkgIHJlZ3MubXVsdGlwbGV4aW5nID8KIAkJCQkJYmktPnNyMDdfOGJwcF9tdXggOiBiaS0+c3Iw
N184YnBwKTsKIAkJCWJyZWFrOwogCiAJCWNhc2UgQlRfTEFHVU5BOgotCQkJRFBSSU5USyAoIiAo
Zm9yIEdENTQ2eClcbiIpOwotCQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVI3LAotCQkJCXZn
YV9yc2VxIChyZWdiYXNlLCBDTF9TRVFSNykgfCAweDAxKTsKKwkJCURQUklOVEsoIiAoZm9yIEdE
NTQ2eClcbiIpOworCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjcsCisJCQkJdmdhX3JzZXEo
cmVnYmFzZSwgQ0xfU0VRUjcpIHwgMHgwMSk7CiAJCQlicmVhazsKIAogCQlkZWZhdWx0OgotCQkJ
cHJpbnRrIChLRVJOX1dBUk5JTkcgImNpcnJ1c2ZiOiB1bmtub3duIEJvYXJkXG4iKTsKKwkJCXBy
aW50ayhLRVJOX1dBUk5JTkcgImNpcnJ1c2ZiOiB1bmtub3duIEJvYXJkXG4iKTsKIAkJCWJyZWFr
OwogCQl9CiAKIAkJc3dpdGNoIChjaW5mby0+YnR5cGUpIHsKIAkJY2FzZSBCVF9TRDY0OgotCQkJ
dmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVIxRiwgMHgxZCk7CQkvKiBNQ0xLIHNlbGVjdCAqLwor
CQkJLyogTUNMSyBzZWxlY3QgKi8KKwkJCXZnYV93c2VxKHJlZ2Jhc2UsIENMX1NFUVIxRiwgMHgx
ZCk7CiAJCQlicmVhazsKIAogCQljYXNlIEJUX1BJQ0NPTE86Ci0JCQl2Z2Ffd3NlcSAocmVnYmFz
ZSwgQ0xfU0VRUjFGLCAweDIyKTsJCS8qICMjIyB2b3JoZXIgMWMgTUNMSyBzZWxlY3QgKi8KLQkJ
CXZnYV93c2VxIChyZWdiYXNlLCBDTF9TRVFSRiwgMHhiMCk7CS8qIEZhc3QgUGFnZS1Nb2RlIHdy
aXRlcyAqLworCQkJLyogIyMjIHZvcmhlciAxYyBNQ0xLIHNlbGVjdCAqLworCQkJdmdhX3dzZXEo
cmVnYmFzZSwgQ0xfU0VRUjFGLCAweDIyKTsKKwkJCS8qIEZhc3QgUGFnZS1Nb2RlIHdyaXRlcyAq
LworCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUkYsIDB4YjApOwogCQkJYnJlYWs7CiAKIAkJ
Y2FzZSBCVF9QSUNBU1NPOgotCQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVIxRiwgMHgyMik7
CQkvKiAjIyMgdm9yaGVyIDFjIE1DTEsgc2VsZWN0ICovCi0JCQl2Z2Ffd3NlcSAocmVnYmFzZSwg
Q0xfU0VRUkYsIDB4YjApOwkvKiBGYXN0IFBhZ2UtTW9kZSB3cml0ZXMgKi8KKwkJCS8qICMjIyB2
b3JoZXIgMWMgTUNMSyBzZWxlY3QgKi8KKwkJCXZnYV93c2VxKHJlZ2Jhc2UsIENMX1NFUVIxRiwg
MHgyMik7CisJCQkvKiBGYXN0IFBhZ2UtTW9kZSB3cml0ZXMgKi8KKwkJCXZnYV93c2VxKHJlZ2Jh
c2UsIENMX1NFUVJGLCAweGIwKTsKIAkJCWJyZWFrOwogCiAJCWNhc2UgQlRfU1BFQ1RSVU06Ci0J
CQl2Z2Ffd3NlcSAocmVnYmFzZSwgQ0xfU0VRUjFGLCAweDIyKTsJCS8qICMjIyB2b3JoZXIgMWMg
TUNMSyBzZWxlY3QgKi8KLQkJCXZnYV93c2VxIChyZWdiYXNlLCBDTF9TRVFSRiwgMHhiMCk7CS8q
IEZhc3QgUGFnZS1Nb2RlIHdyaXRlcyAqLworCQkJLyogIyMjIHZvcmhlciAxYyBNQ0xLIHNlbGVj
dCAqLworCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjFGLCAweDIyKTsKKwkJCS8qIEZhc3Qg
UGFnZS1Nb2RlIHdyaXRlcyAqLworCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUkYsIDB4YjAp
OwogCQkJYnJlYWs7CiAKIAkJY2FzZSBCVF9QSUNBU1NPNDoKICNpZmRlZiBDT05GSUdfWk9SUk8K
LQkJCXZnYV93c2VxIChyZWdiYXNlLCBDTF9TRVFSRiwgMHhiOCk7CS8qICMjIyBJTkNPTVBMRVRF
ISEgKi8KKwkJCS8qICMjIyBJTkNPTVBMRVRFISEgKi8KKwkJCXZnYV93c2VxKHJlZ2Jhc2UsIENM
X1NFUVJGLCAweGI4KTsKICNlbmRpZgotLyogICAgICAgICAgdmdhX3dzZXEgKHJlZ2Jhc2UsIENM
X1NFUVIxRiwgMHgxYyk7ICovCisvKgkgIAkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjFGLCAw
eDFjKTsgKi8KIAkJCWJyZWFrOwogCiAJCWNhc2UgQlRfQUxQSU5FOgotCQkJRFBSSU5USyAoIiAo
Zm9yIEdENTQzeClcbiIpOwotCQkJY2lycnVzZmJfc2V0X21jbGsgKGNpbmZvLCByZWdzLm1jbGss
IHJlZ3MuZGl2TUNMSyk7CisJCQlEUFJJTlRLKCIgKGZvciBHRDU0M3gpXG4iKTsKKwkJCWNpcnJ1
c2ZiX3NldF9tY2xrKGNpbmZvLCByZWdzLm1jbGssIHJlZ3MuZGl2TUNMSyk7CiAJCQkvKiBXZSBh
bHJlYWR5IHNldCBTUkYgYW5kIFNSMUYgKi8KIAkJCWJyZWFrOwogCiAJCWNhc2UgQlRfR0Q1NDgw
OgogCQljYXNlIEJUX0xBR1VOQToKLQkJCURQUklOVEsgKCIgKGZvciBHRDU0eHgpXG4iKTsKKwkJ
CURQUklOVEsoIiAoZm9yIEdENTR4eClcbiIpOwogCQkJLyogZG8gbm90aGluZyAqLwogCQkJYnJl
YWs7CiAKIAkJZGVmYXVsdDoKLQkJCXByaW50ayAoS0VSTl9XQVJOSU5HICJjaXJydXNmYjogdW5r
bm93biBCb2FyZFxuIik7CisJCQlwcmludGsoS0VSTl9XQVJOSU5HICJjaXJydXNmYjogdW5rbm93
biBCb2FyZFxuIik7CiAJCQlicmVhazsKIAkJfQogCi0JCXZnYV93Z2Z4IChyZWdiYXNlLCBWR0Ff
R0ZYX01PREUsIDY0KTsJLyogbW9kZSByZWdpc3RlcjogMjU2IGNvbG9yIG1vZGUgKi8KLQkJV0dl
biAoY2luZm8sIFZHQV9QRUxfTVNLLCAweGZmKTsJLyogcGl4ZWwgbWFzazogcGFzcy10aHJvdWdo
IGFsbCBwbGFuZXMgKi8KKwkJLyogbW9kZSByZWdpc3RlcjogMjU2IGNvbG9yIG1vZGUgKi8KKwkJ
dmdhX3dnZngocmVnYmFzZSwgVkdBX0dGWF9NT0RFLCA2NCk7CisJCS8qIHBpeGVsIG1hc2s6IHBh
c3MtdGhyb3VnaCBhbGwgcGxhbmVzICovCisJCVdHZW4oY2luZm8sIFZHQV9QRUxfTVNLLCAweGZm
KTsKIAkJaWYgKHJlZ3MubXVsdGlwbGV4aW5nKQotCQkJV0hEUiAoY2luZm8sIDB4NGEpOwkvKiBo
aWRkZW4gZGFjIHJlZzogMTI4MHgxMDI0ICovCisJCQkvKiBoaWRkZW4gZGFjIHJlZzogMTI4MHgx
MDI0ICovCisJCQlXSERSKGNpbmZvLCAweDRhKTsKIAkJZWxzZQotCQkJV0hEUiAoY2luZm8sIDAp
OwkvKiBoaWRkZW4gZGFjOiBub3RoaW5nICovCi0JCXZnYV93c2VxIChyZWdiYXNlLCBWR0FfU0VR
X01FTU9SWV9NT0RFLCAweDBhKTsJLyogbWVtb3J5IG1vZGU6IGNoYWluNCwgZXh0LiBtZW1vcnkg
Ki8KLQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIFZHQV9TRVFfUExBTkVfV1JJVEUsIDB4ZmYpOwkvKiBw
bGFuZSBtYXNrOiBlbmFibGUgd3JpdGluZyB0byBhbGwgNCBwbGFuZXMgKi8KKwkJCS8qIGhpZGRl
biBkYWM6IG5vdGhpbmcgKi8KKwkJCVdIRFIoY2luZm8sIDApOworCQkvKiBtZW1vcnkgbW9kZTog
Y2hhaW40LCBleHQuIG1lbW9yeSAqLworCQl2Z2Ffd3NlcShyZWdiYXNlLCBWR0FfU0VRX01FTU9S
WV9NT0RFLCAweDBhKTsKKwkJLyogcGxhbmUgbWFzazogZW5hYmxlIHdyaXRpbmcgdG8gYWxsIDQg
cGxhbmVzICovCisJCXZnYV93c2VxKHJlZ2Jhc2UsIFZHQV9TRVFfUExBTkVfV1JJVEUsIDB4ZmYp
OwogCQlvZmZzZXQgPSB2YXItPnhyZXNfdmlydHVhbCAvIDg7CiAJfQogCkBAIC0xMzQ3LDcyICsx
Mzg0LDg0IEBAIHN0YXRpYyBpbnQgY2lycnVzZmJfc2V0X3Bhcl9mb28gKHN0cnVjdCAKIAkgKi8K
IAogCWVsc2UgaWYgKHZhci0+Yml0c19wZXJfcGl4ZWwgPT0gMTYpIHsKLQkJRFBSSU5USyAoImNp
cnJ1c2ZiOiBwcmVwYXJpbmcgZm9yIDE2IGJpdCBkZWVwIGRpc3BsYXlcbiIpOworCQlEUFJJTlRL
KCJjaXJydXNmYjogcHJlcGFyaW5nIGZvciAxNiBiaXQgZGVlcCBkaXNwbGF5XG4iKTsKIAkJc3dp
dGNoIChjaW5mby0+YnR5cGUpIHsKIAkJY2FzZSBCVF9TRDY0OgotCQkJdmdhX3dzZXEgKHJlZ2Jh
c2UsIENMX1NFUVI3LCAweGY3KTsJLyogRXh0ZW5kZWQgU2VxdWVuY2VyIE1vZGU6IDI1NmMgY29s
LiBtb2RlICovCi0JCQl2Z2Ffd3NlcSAocmVnYmFzZSwgQ0xfU0VRUjFGLCAweDFlKTsJCS8qIE1D
TEsgc2VsZWN0ICovCisJCQkvKiBFeHRlbmRlZCBTZXF1ZW5jZXIgTW9kZTogMjU2YyBjb2wuIG1v
ZGUgKi8KKwkJCXZnYV93c2VxKHJlZ2Jhc2UsIENMX1NFUVI3LCAweGY3KTsKKwkJCS8qIE1DTEsg
c2VsZWN0ICovCisJCQl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9TRVFSMUYsIDB4MWUpOwogCQkJYnJl
YWs7CiAKIAkJY2FzZSBCVF9QSUNDT0xPOgotCQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVI3
LCAweDg3KTsKLQkJCXZnYV93c2VxIChyZWdiYXNlLCBDTF9TRVFSRiwgMHhiMCk7CS8qIEZhc3Qg
UGFnZS1Nb2RlIHdyaXRlcyAqLwotCQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVIxRiwgMHgy
Mik7CQkvKiBNQ0xLIHNlbGVjdCAqLworCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjcsIDB4
ODcpOworCQkJLyogRmFzdCBQYWdlLU1vZGUgd3JpdGVzICovCisJCQl2Z2Ffd3NlcShyZWdiYXNl
LCBDTF9TRVFSRiwgMHhiMCk7CisJCQkvKiBNQ0xLIHNlbGVjdCAqLworCQkJdmdhX3dzZXEocmVn
YmFzZSwgQ0xfU0VRUjFGLCAweDIyKTsKIAkJCWJyZWFrOwogCiAJCWNhc2UgQlRfUElDQVNTTzoK
LQkJCXZnYV93c2VxIChyZWdiYXNlLCBDTF9TRVFSNywgMHgyNyk7Ci0JCQl2Z2Ffd3NlcSAocmVn
YmFzZSwgQ0xfU0VRUkYsIDB4YjApOwkvKiBGYXN0IFBhZ2UtTW9kZSB3cml0ZXMgKi8KLQkJCXZn
YV93c2VxIChyZWdiYXNlLCBDTF9TRVFSMUYsIDB4MjIpOwkJLyogTUNMSyBzZWxlY3QgKi8KKwkJ
CXZnYV93c2VxKHJlZ2Jhc2UsIENMX1NFUVI3LCAweDI3KTsKKwkJCS8qIEZhc3QgUGFnZS1Nb2Rl
IHdyaXRlcyAqLworCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUkYsIDB4YjApOworCQkJLyog
TUNMSyBzZWxlY3QgKi8KKwkJCXZnYV93c2VxKHJlZ2Jhc2UsIENMX1NFUVIxRiwgMHgyMik7CiAJ
CQlicmVhazsKIAogCQljYXNlIEJUX1NQRUNUUlVNOgotCQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIENM
X1NFUVI3LCAweDg3KTsKLQkJCXZnYV93c2VxIChyZWdiYXNlLCBDTF9TRVFSRiwgMHhiMCk7CS8q
IEZhc3QgUGFnZS1Nb2RlIHdyaXRlcyAqLwotCQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVIx
RiwgMHgyMik7CQkvKiBNQ0xLIHNlbGVjdCAqLworCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VR
UjcsIDB4ODcpOworCQkJLyogRmFzdCBQYWdlLU1vZGUgd3JpdGVzICovCisJCQl2Z2Ffd3NlcShy
ZWdiYXNlLCBDTF9TRVFSRiwgMHhiMCk7CisJCQkvKiBNQ0xLIHNlbGVjdCAqLworCQkJdmdhX3dz
ZXEocmVnYmFzZSwgQ0xfU0VRUjFGLCAweDIyKTsKIAkJCWJyZWFrOwogCiAJCWNhc2UgQlRfUElD
QVNTTzQ6Ci0JCQl2Z2Ffd3NlcSAocmVnYmFzZSwgQ0xfU0VRUjcsIDB4MjcpOwotLyogICAgICAg
ICAgdmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVIxRiwgMHgxYyk7ICAqLworCQkJdmdhX3dzZXEo
cmVnYmFzZSwgQ0xfU0VRUjcsIDB4MjcpOworLyoJCQl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9TRVFS
MUYsIDB4MWMpOyAgKi8KIAkJCWJyZWFrOwogCiAJCWNhc2UgQlRfQUxQSU5FOgotCQkJRFBSSU5U
SyAoIiAoZm9yIEdENTQzeClcbiIpOworCQkJRFBSSU5USygiIChmb3IgR0Q1NDN4KVxuIik7CiAJ
CQlpZiAocmVncy5Ib3JpelJlcyA+PSAxMDI0KQotCQkJCXZnYV93c2VxIChyZWdiYXNlLCBDTF9T
RVFSNywgMHhhNyk7CisJCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjcsIDB4YTcpOwogCQkJ
ZWxzZQotCQkJCXZnYV93c2VxIChyZWdiYXNlLCBDTF9TRVFSNywgMHhhMyk7Ci0JCQljaXJydXNm
Yl9zZXRfbWNsayAoY2luZm8sIHJlZ3MubWNsaywgcmVncy5kaXZNQ0xLKTsKKwkJCQl2Z2Ffd3Nl
cShyZWdiYXNlLCBDTF9TRVFSNywgMHhhMyk7CisJCQljaXJydXNmYl9zZXRfbWNsayhjaW5mbywg
cmVncy5tY2xrLCByZWdzLmRpdk1DTEspOwogCQkJYnJlYWs7CiAKIAkJY2FzZSBCVF9HRDU0ODA6
Ci0JCQlEUFJJTlRLICgiIChmb3IgR0Q1NDgwKVxuIik7Ci0JCQl2Z2Ffd3NlcSAocmVnYmFzZSwg
Q0xfU0VRUjcsIDB4MTcpOworCQkJRFBSSU5USygiIChmb3IgR0Q1NDgwKVxuIik7CisJCQl2Z2Ff
d3NlcShyZWdiYXNlLCBDTF9TRVFSNywgMHgxNyk7CiAJCQkvKiBXZSBhbHJlYWR5IHNldCBTUkYg
YW5kIFNSMUYgKi8KIAkJCWJyZWFrOwogCiAJCWNhc2UgQlRfTEFHVU5BOgotCQkJRFBSSU5USyAo
IiAoZm9yIEdENTQ2eClcbiIpOwotCQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVI3LAotCQkJ
CXZnYV9yc2VxIChyZWdiYXNlLCBDTF9TRVFSNykgJiB+MHgwMSk7CisJCQlEUFJJTlRLKCIgKGZv
ciBHRDU0NngpXG4iKTsKKwkJCXZnYV93c2VxKHJlZ2Jhc2UsIENMX1NFUVI3LAorCQkJCXZnYV9y
c2VxKHJlZ2Jhc2UsIENMX1NFUVI3KSAmIH4weDAxKTsKIAkJCWJyZWFrOwogCiAJCWRlZmF1bHQ6
Ci0JCQlwcmludGsgKEtFUk5fV0FSTklORyAiQ0lSUlVTRkI6IHVua25vd24gQm9hcmRcbiIpOwor
CQkJcHJpbnRrKEtFUk5fV0FSTklORyAiQ0lSUlVTRkI6IHVua25vd24gQm9hcmRcbiIpOwogCQkJ
YnJlYWs7CiAJCX0KIAotCQl2Z2Ffd2dmeCAocmVnYmFzZSwgVkdBX0dGWF9NT0RFLCA2NCk7CS8q
IG1vZGUgcmVnaXN0ZXI6IDI1NiBjb2xvciBtb2RlICovCi0JCVdHZW4gKGNpbmZvLCBWR0FfUEVM
X01TSywgMHhmZik7CS8qIHBpeGVsIG1hc2s6IHBhc3MtdGhyb3VnaCBhbGwgcGxhbmVzICovCisJ
CS8qIG1vZGUgcmVnaXN0ZXI6IDI1NiBjb2xvciBtb2RlICovCisJCXZnYV93Z2Z4KHJlZ2Jhc2Us
IFZHQV9HRlhfTU9ERSwgNjQpOworCQkvKiBwaXhlbCBtYXNrOiBwYXNzLXRocm91Z2ggYWxsIHBs
YW5lcyAqLworCQlXR2VuKGNpbmZvLCBWR0FfUEVMX01TSywgMHhmZik7CiAjaWZkZWYgQ09ORklH
X1BDSQotCQlXSERSIChjaW5mbywgMHhjMCk7CS8qIENvcHkgWGJoICovCisJCVdIRFIoY2luZm8s
IDB4YzApOwkvKiBDb3B5IFhiaCAqLwogI2VsaWYgZGVmaW5lZChDT05GSUdfWk9SUk8pCiAJCS8q
IEZJWE1FOiBDT05GSUdfUENJIGFuZCBDT05GSUdfWk9SUk8gbWF5IGJlIGRlZmluZWQgYm90aCAq
LwotCQlXSERSIChjaW5mbywgMHhhMCk7CS8qIGhpZGRlbiBkYWMgcmVnOiBub3RoaW5nIHNwZWNp
YWwgKi8KKwkJV0hEUihjaW5mbywgMHhhMCk7CS8qIGhpZGRlbiBkYWMgcmVnOiBub3RoaW5nIHNw
ZWNpYWwgKi8KICNlbmRpZgotCQl2Z2Ffd3NlcSAocmVnYmFzZSwgVkdBX1NFUV9NRU1PUllfTU9E
RSwgMHgwYSk7CS8qIG1lbW9yeSBtb2RlOiBjaGFpbjQsIGV4dC4gbWVtb3J5ICovCi0JCXZnYV93
c2VxIChyZWdiYXNlLCBWR0FfU0VRX1BMQU5FX1dSSVRFLCAweGZmKTsJLyogcGxhbmUgbWFzazog
ZW5hYmxlIHdyaXRpbmcgdG8gYWxsIDQgcGxhbmVzICovCisJCS8qIG1lbW9yeSBtb2RlOiBjaGFp
bjQsIGV4dC4gbWVtb3J5ICovCisJCXZnYV93c2VxKHJlZ2Jhc2UsIFZHQV9TRVFfTUVNT1JZX01P
REUsIDB4MGEpOworCQkvKiBwbGFuZSBtYXNrOiBlbmFibGUgd3JpdGluZyB0byBhbGwgNCBwbGFu
ZXMgKi8KKwkJdmdhX3dzZXEocmVnYmFzZSwgVkdBX1NFUV9QTEFORV9XUklURSwgMHhmZik7CiAJ
CW9mZnNldCA9IHZhci0+eHJlc192aXJ0dWFsIC8gNDsKIAl9CiAKQEAgLTE0MjMsNjQgKzE0NzIs
NzcgQEAgc3RhdGljIGludCBjaXJydXNmYl9zZXRfcGFyX2ZvbyAoc3RydWN0IAogCSAqLwogCiAJ
ZWxzZSBpZiAodmFyLT5iaXRzX3Blcl9waXhlbCA9PSAzMikgewotCQlEUFJJTlRLICgiY2lycnVz
ZmI6IHByZXBhcmluZyBmb3IgMjQvMzIgYml0IGRlZXAgZGlzcGxheVxuIik7CisJCURQUklOVEso
ImNpcnJ1c2ZiOiBwcmVwYXJpbmcgZm9yIDI0LzMyIGJpdCBkZWVwIGRpc3BsYXlcbiIpOwogCQlz
d2l0Y2ggKGNpbmZvLT5idHlwZSkgewogCQljYXNlIEJUX1NENjQ6Ci0JCQl2Z2Ffd3NlcSAocmVn
YmFzZSwgQ0xfU0VRUjcsIDB4ZjkpOwkvKiBFeHRlbmRlZCBTZXF1ZW5jZXIgTW9kZTogMjU2YyBj
b2wuIG1vZGUgKi8KLQkJCXZnYV93c2VxIChyZWdiYXNlLCBDTF9TRVFSMUYsIDB4MWUpOwkJLyog
TUNMSyBzZWxlY3QgKi8KKwkJCS8qIEV4dGVuZGVkIFNlcXVlbmNlciBNb2RlOiAyNTZjIGNvbC4g
bW9kZSAqLworCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjcsIDB4ZjkpOworCQkJLyogTUNM
SyBzZWxlY3QgKi8KKwkJCXZnYV93c2VxKHJlZ2Jhc2UsIENMX1NFUVIxRiwgMHgxZSk7CiAJCQli
cmVhazsKIAogCQljYXNlIEJUX1BJQ0NPTE86Ci0JCQl2Z2Ffd3NlcSAocmVnYmFzZSwgQ0xfU0VR
UjcsIDB4ODUpOwotCQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVJGLCAweGIwKTsJLyogRmFz
dCBQYWdlLU1vZGUgd3JpdGVzICovCi0JCQl2Z2Ffd3NlcSAocmVnYmFzZSwgQ0xfU0VRUjFGLCAw
eDIyKTsJCS8qIE1DTEsgc2VsZWN0ICovCisJCQl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9TRVFSNywg
MHg4NSk7CisJCQkvKiBGYXN0IFBhZ2UtTW9kZSB3cml0ZXMgKi8KKwkJCXZnYV93c2VxKHJlZ2Jh
c2UsIENMX1NFUVJGLCAweGIwKTsKKwkJCS8qIE1DTEsgc2VsZWN0ICovCisJCQl2Z2Ffd3NlcShy
ZWdiYXNlLCBDTF9TRVFSMUYsIDB4MjIpOwogCQkJYnJlYWs7CiAKIAkJY2FzZSBCVF9QSUNBU1NP
OgotCQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVI3LCAweDI1KTsKLQkJCXZnYV93c2VxIChy
ZWdiYXNlLCBDTF9TRVFSRiwgMHhiMCk7CS8qIEZhc3QgUGFnZS1Nb2RlIHdyaXRlcyAqLwotCQkJ
dmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVIxRiwgMHgyMik7CQkvKiBNQ0xLIHNlbGVjdCAqLwor
CQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjcsIDB4MjUpOworCQkJLyogRmFzdCBQYWdlLU1v
ZGUgd3JpdGVzICovCisJCQl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9TRVFSRiwgMHhiMCk7CisJCQkv
KiBNQ0xLIHNlbGVjdCAqLworCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjFGLCAweDIyKTsK
IAkJCWJyZWFrOwogCiAJCWNhc2UgQlRfU1BFQ1RSVU06Ci0JCQl2Z2Ffd3NlcSAocmVnYmFzZSwg
Q0xfU0VRUjcsIDB4ODUpOwotCQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIENMX1NFUVJGLCAweGIwKTsJ
LyogRmFzdCBQYWdlLU1vZGUgd3JpdGVzICovCi0JCQl2Z2Ffd3NlcSAocmVnYmFzZSwgQ0xfU0VR
UjFGLCAweDIyKTsJCS8qIE1DTEsgc2VsZWN0ICovCisJCQl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9T
RVFSNywgMHg4NSk7CisJCQkvKiBGYXN0IFBhZ2UtTW9kZSB3cml0ZXMgKi8KKwkJCXZnYV93c2Vx
KHJlZ2Jhc2UsIENMX1NFUVJGLCAweGIwKTsKKwkJCS8qIE1DTEsgc2VsZWN0ICovCisJCQl2Z2Ff
d3NlcShyZWdiYXNlLCBDTF9TRVFSMUYsIDB4MjIpOwogCQkJYnJlYWs7CiAKIAkJY2FzZSBCVF9Q
SUNBU1NPNDoKLQkJCXZnYV93c2VxIChyZWdiYXNlLCBDTF9TRVFSNywgMHgyNSk7Ci0vKiAgICAg
ICAgICB2Z2Ffd3NlcSAocmVnYmFzZSwgQ0xfU0VRUjFGLCAweDFjKTsgICovCisJCQl2Z2Ffd3Nl
cShyZWdiYXNlLCBDTF9TRVFSNywgMHgyNSk7CisvKgkJCXZnYV93c2VxKHJlZ2Jhc2UsIENMX1NF
UVIxRiwgMHgxYyk7ICAqLwogCQkJYnJlYWs7CiAKIAkJY2FzZSBCVF9BTFBJTkU6Ci0JCQlEUFJJ
TlRLICgiIChmb3IgR0Q1NDN4KVxuIik7Ci0JCQl2Z2Ffd3NlcSAocmVnYmFzZSwgQ0xfU0VRUjcs
IDB4YTkpOwotCQkJY2lycnVzZmJfc2V0X21jbGsgKGNpbmZvLCByZWdzLm1jbGssIHJlZ3MuZGl2
TUNMSyk7CisJCQlEUFJJTlRLKCIgKGZvciBHRDU0M3gpXG4iKTsKKwkJCXZnYV93c2VxKHJlZ2Jh
c2UsIENMX1NFUVI3LCAweGE5KTsKKwkJCWNpcnJ1c2ZiX3NldF9tY2xrKGNpbmZvLCByZWdzLm1j
bGssIHJlZ3MuZGl2TUNMSyk7CiAJCQlicmVhazsKIAogCQljYXNlIEJUX0dENTQ4MDoKLQkJCURQ
UklOVEsgKCIgKGZvciBHRDU0ODApXG4iKTsKLQkJCXZnYV93c2VxIChyZWdiYXNlLCBDTF9TRVFS
NywgMHgxOSk7CisJCQlEUFJJTlRLKCIgKGZvciBHRDU0ODApXG4iKTsKKwkJCXZnYV93c2VxKHJl
Z2Jhc2UsIENMX1NFUVI3LCAweDE5KTsKIAkJCS8qIFdlIGFscmVhZHkgc2V0IFNSRiBhbmQgU1Ix
RiAqLwogCQkJYnJlYWs7CiAKIAkJY2FzZSBCVF9MQUdVTkE6Ci0JCQlEUFJJTlRLICgiIChmb3Ig
R0Q1NDZ4KVxuIik7Ci0JCQl2Z2Ffd3NlcSAocmVnYmFzZSwgQ0xfU0VRUjcsCi0JCQkJdmdhX3Jz
ZXEgKHJlZ2Jhc2UsIENMX1NFUVI3KSAmIH4weDAxKTsKKwkJCURQUklOVEsoIiAoZm9yIEdENTQ2
eClcbiIpOworCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjcsCisJCQkJdmdhX3JzZXEocmVn
YmFzZSwgQ0xfU0VRUjcpICYgfjB4MDEpOwogCQkJYnJlYWs7CiAKIAkJZGVmYXVsdDoKLQkJCXBy
aW50ayAoS0VSTl9XQVJOSU5HICJjaXJydXNmYjogdW5rbm93biBCb2FyZFxuIik7CisJCQlwcmlu
dGsoS0VSTl9XQVJOSU5HICJjaXJydXNmYjogdW5rbm93biBCb2FyZFxuIik7CiAJCQlicmVhazsK
IAkJfQogCi0JCXZnYV93Z2Z4IChyZWdiYXNlLCBWR0FfR0ZYX01PREUsIDY0KTsJLyogbW9kZSBy
ZWdpc3RlcjogMjU2IGNvbG9yIG1vZGUgKi8KLQkJV0dlbiAoY2luZm8sIFZHQV9QRUxfTVNLLCAw
eGZmKTsJLyogcGl4ZWwgbWFzazogcGFzcy10aHJvdWdoIGFsbCBwbGFuZXMgKi8KLQkJV0hEUiAo
Y2luZm8sIDB4YzUpOwkvKiBoaWRkZW4gZGFjIHJlZzogOC04LTggbW9kZSAoMjQgb3IgMzIpICov
Ci0JCXZnYV93c2VxIChyZWdiYXNlLCBWR0FfU0VRX01FTU9SWV9NT0RFLCAweDBhKTsJLyogbWVt
b3J5IG1vZGU6IGNoYWluNCwgZXh0LiBtZW1vcnkgKi8KLQkJdmdhX3dzZXEgKHJlZ2Jhc2UsIFZH
QV9TRVFfUExBTkVfV1JJVEUsIDB4ZmYpOwkvKiBwbGFuZSBtYXNrOiBlbmFibGUgd3JpdGluZyB0
byBhbGwgNCBwbGFuZXMgKi8KKwkJLyogbW9kZSByZWdpc3RlcjogMjU2IGNvbG9yIG1vZGUgKi8K
KwkJdmdhX3dnZngocmVnYmFzZSwgVkdBX0dGWF9NT0RFLCA2NCk7CisJCS8qIHBpeGVsIG1hc2s6
IHBhc3MtdGhyb3VnaCBhbGwgcGxhbmVzICovCisJCVdHZW4oY2luZm8sIFZHQV9QRUxfTVNLLCAw
eGZmKTsKKwkJLyogaGlkZGVuIGRhYyByZWc6IDgtOC04IG1vZGUgKDI0IG9yIDMyKSAqLworCQlX
SERSKGNpbmZvLCAweGM1KTsKKwkJLyogbWVtb3J5IG1vZGU6IGNoYWluNCwgZXh0LiBtZW1vcnkg
Ki8KKwkJdmdhX3dzZXEocmVnYmFzZSwgVkdBX1NFUV9NRU1PUllfTU9ERSwgMHgwYSk7CisJCS8q
IHBsYW5lIG1hc2s6IGVuYWJsZSB3cml0aW5nIHRvIGFsbCA0IHBsYW5lcyAqLworCQl2Z2Ffd3Nl
cShyZWdiYXNlLCBWR0FfU0VRX1BMQU5FX1dSSVRFLCAweGZmKTsKIAkJb2Zmc2V0ID0gdmFyLT54
cmVzX3ZpcnR1YWwgLyA0OwogCX0KIApAQCAtMTQ5MCw0OCArMTU1Miw2NyBAQCBzdGF0aWMgaW50
IGNpcnJ1c2ZiX3NldF9wYXJfZm9vIChzdHJ1Y3QgCiAJICoKIAkgKi8KIAotCWVsc2UgewotCQlw
cmludGsgKEtFUk5fRVJSICJjaXJydXNmYjogV2hhdCdzIHRoaXM/PyByZXF1ZXN0ZWQgY29sb3Ig
ZGVwdGggPT0gJWQuXG4iLAorCWVsc2UKKwkJcHJpbnRrKEtFUk5fRVJSICJjaXJydXNmYjogV2hh
dCdzIHRoaXM/PyAiCisJCQkiIHJlcXVlc3RlZCBjb2xvciBkZXB0aCA9PSAlZC5cbiIsCiAJCQl2
YXItPmJpdHNfcGVyX3BpeGVsKTsKLQl9CiAKLQl2Z2Ffd2NydCAocmVnYmFzZSwgVkdBX0NSVENf
T0ZGU0VULCBvZmZzZXQgJiAweGZmKTsKKwl2Z2Ffd2NydChyZWdiYXNlLCBWR0FfQ1JUQ19PRkZT
RVQsIG9mZnNldCAmIDB4ZmYpOwogCXRtcCA9IDB4MjI7CiAJaWYgKG9mZnNldCAmIDB4MTAwKQog
CQl0bXAgfD0gMHgxMDsJLyogb2Zmc2V0IG92ZXJmbG93IGJpdCAqLwogCi0JdmdhX3djcnQgKHJl
Z2Jhc2UsIENMX0NSVDFCLCB0bXApOwkvKiBzY3JlZW4gc3RhcnQgYWRkciAjMTYtMTgsIGZhc3Rw
YWdlbW9kZSBjeWNsZXMgKi8KKwkvKiBzY3JlZW4gc3RhcnQgYWRkciAjMTYtMTgsIGZhc3RwYWdl
bW9kZSBjeWNsZXMgKi8KKwl2Z2Ffd2NydChyZWdiYXNlLCBDTF9DUlQxQiwgdG1wKTsKIAogCWlm
IChjaW5mby0+YnR5cGUgPT0gQlRfU0Q2NCB8fAogCSAgICBjaW5mby0+YnR5cGUgPT0gQlRfUElD
QVNTTzQgfHwKIAkgICAgY2luZm8tPmJ0eXBlID09IEJUX0FMUElORSB8fAogCSAgICBjaW5mby0+
YnR5cGUgPT0gQlRfR0Q1NDgwKQotCQl2Z2Ffd2NydCAocmVnYmFzZSwgQ0xfQ1JUMUQsIDB4MDAp
OwkvKiBzY3JlZW4gc3RhcnQgYWRkcmVzcyBiaXQgMTkgKi8KKwkJLyogc2NyZWVuIHN0YXJ0IGFk
ZHJlc3MgYml0IDE5ICovCisJCXZnYV93Y3J0KHJlZ2Jhc2UsIENMX0NSVDFELCAweDAwKTsKIAot
CXZnYV93Y3J0IChyZWdiYXNlLCBWR0FfQ1JUQ19DVVJTT1JfSEksIDApOwkvKiB0ZXh0IGN1cnNv
ciBsb2NhdGlvbiBoaWdoICovCi0JdmdhX3djcnQgKHJlZ2Jhc2UsIFZHQV9DUlRDX0NVUlNPUl9M
TywgMCk7CS8qIHRleHQgY3Vyc29yIGxvY2F0aW9uIGxvdyAqLwotCXZnYV93Y3J0IChyZWdiYXNl
LCBWR0FfQ1JUQ19VTkRFUkxJTkUsIDApOwkvKiB1bmRlcmxpbmUgcm93IHNjYW5saW5lID0gYXQg
dmVyeSBib3R0b20gKi8KLQotCXZnYV93YXR0ciAocmVnYmFzZSwgVkdBX0FUQ19NT0RFLCAxKTsJ
LyogY29udHJvbGxlciBtb2RlICovCi0JdmdhX3dhdHRyIChyZWdiYXNlLCBWR0FfQVRDX09WRVJT
Q0FOLCAwKTsJCS8qIG92ZXJzY2FuIChib3JkZXIpIGNvbG9yICovCi0JdmdhX3dhdHRyIChyZWdi
YXNlLCBWR0FfQVRDX1BMQU5FX0VOQUJMRSwgMTUpOwkvKiBjb2xvciBwbGFuZSBlbmFibGUgKi8K
LQl2Z2Ffd2F0dHIgKHJlZ2Jhc2UsIENMX0FSMzMsIDApOwkvKiBwaXhlbCBwYW5uaW5nICovCi0J
dmdhX3dhdHRyIChyZWdiYXNlLCBWR0FfQVRDX0NPTE9SX1BBR0UsIDApOwkvKiBjb2xvciBzZWxl
Y3QgKi8KKwkvKiB0ZXh0IGN1cnNvciBsb2NhdGlvbiBoaWdoICovCisJdmdhX3djcnQocmVnYmFz
ZSwgVkdBX0NSVENfQ1VSU09SX0hJLCAwKTsKKwkvKiB0ZXh0IGN1cnNvciBsb2NhdGlvbiBsb3cg
Ki8KKwl2Z2Ffd2NydChyZWdiYXNlLCBWR0FfQ1JUQ19DVVJTT1JfTE8sIDApOworCS8qIHVuZGVy
bGluZSByb3cgc2NhbmxpbmUgPSBhdCB2ZXJ5IGJvdHRvbSAqLworCXZnYV93Y3J0KHJlZ2Jhc2Us
IFZHQV9DUlRDX1VOREVSTElORSwgMCk7CisKKwkvKiBjb250cm9sbGVyIG1vZGUgKi8KKwl2Z2Ff
d2F0dHIocmVnYmFzZSwgVkdBX0FUQ19NT0RFLCAxKTsKKwkvKiBvdmVyc2NhbiAoYm9yZGVyKSBj
b2xvciAqLworCXZnYV93YXR0cihyZWdiYXNlLCBWR0FfQVRDX09WRVJTQ0FOLCAwKTsKKwkvKiBj
b2xvciBwbGFuZSBlbmFibGUgKi8KKwl2Z2Ffd2F0dHIocmVnYmFzZSwgVkdBX0FUQ19QTEFORV9F
TkFCTEUsIDE1KTsKKwkvKiBwaXhlbCBwYW5uaW5nICovCisJdmdhX3dhdHRyKHJlZ2Jhc2UsIENM
X0FSMzMsIDApOworCS8qIGNvbG9yIHNlbGVjdCAqLworCXZnYV93YXR0cihyZWdiYXNlLCBWR0Ff
QVRDX0NPTE9SX1BBR0UsIDApOwogCiAJLyogWyBFR1M6IFNldE9mZnNldCgpOyBdICovCiAJLyog
RnJvbSBTZXRPZmZzZXQoKTogVHVybiBvbiBWaWRlb0VuYWJsZSBiaXQgaW4gQXR0cmlidXRlIGNv
bnRyb2xsZXIgKi8KLQlBdHRyT24gKGNpbmZvKTsKKwlBdHRyT24oY2luZm8pOwogCi0JdmdhX3dn
ZnggKHJlZ2Jhc2UsIFZHQV9HRlhfU1JfVkFMVUUsIDApOwkvKiBzZXQvcmVzZXQgcmVnaXN0ZXIg
Ki8KLQl2Z2Ffd2dmeCAocmVnYmFzZSwgVkdBX0dGWF9TUl9FTkFCTEUsIDApOwkJLyogc2V0L3Jl
c2V0IGVuYWJsZSAqLwotCXZnYV93Z2Z4IChyZWdiYXNlLCBWR0FfR0ZYX0NPTVBBUkVfVkFMVUUs
IDApOwkvKiBjb2xvciBjb21wYXJlICovCi0JdmdhX3dnZnggKHJlZ2Jhc2UsIFZHQV9HRlhfREFU
QV9ST1RBVEUsIDApOwkvKiBkYXRhIHJvdGF0ZSAqLwotCXZnYV93Z2Z4IChyZWdiYXNlLCBWR0Ff
R0ZYX1BMQU5FX1JFQUQsIDApOwkvKiByZWFkIG1hcCBzZWxlY3QgKi8KLQl2Z2Ffd2dmeCAocmVn
YmFzZSwgVkdBX0dGWF9NSVNDLCAxKTsJLyogbWlzY2VsbGFuZW91cyByZWdpc3RlciAqLwotCXZn
YV93Z2Z4IChyZWdiYXNlLCBWR0FfR0ZYX0NPTVBBUkVfTUFTSywgMTUpOwkvKiBjb2xvciBkb24n
dCBjYXJlICovCi0JdmdhX3dnZnggKHJlZ2Jhc2UsIFZHQV9HRlhfQklUX01BU0ssIDI1NSk7CS8q
IGJpdCBtYXNrICovCisJLyogc2V0L3Jlc2V0IHJlZ2lzdGVyICovCisJdmdhX3dnZngocmVnYmFz
ZSwgVkdBX0dGWF9TUl9WQUxVRSwgMCk7CisJLyogc2V0L3Jlc2V0IGVuYWJsZSAqLworCXZnYV93
Z2Z4KHJlZ2Jhc2UsIFZHQV9HRlhfU1JfRU5BQkxFLCAwKTsKKwkvKiBjb2xvciBjb21wYXJlICov
CisJdmdhX3dnZngocmVnYmFzZSwgVkdBX0dGWF9DT01QQVJFX1ZBTFVFLCAwKTsKKwkvKiBkYXRh
IHJvdGF0ZSAqLworCXZnYV93Z2Z4KHJlZ2Jhc2UsIFZHQV9HRlhfREFUQV9ST1RBVEUsIDApOwor
CS8qIHJlYWQgbWFwIHNlbGVjdCAqLworCXZnYV93Z2Z4KHJlZ2Jhc2UsIFZHQV9HRlhfUExBTkVf
UkVBRCwgMCk7CisJLyogbWlzY2VsbGFuZW91cyByZWdpc3RlciAqLworCXZnYV93Z2Z4KHJlZ2Jh
c2UsIFZHQV9HRlhfTUlTQywgMSk7CisJLyogY29sb3IgZG9uJ3QgY2FyZSAqLworCXZnYV93Z2Z4
KHJlZ2Jhc2UsIFZHQV9HRlhfQ09NUEFSRV9NQVNLLCAxNSk7CisJLyogYml0IG1hc2sgKi8KKwl2
Z2Ffd2dmeChyZWdiYXNlLCBWR0FfR0ZYX0JJVF9NQVNLLCAyNTUpOwogCi0JdmdhX3dzZXEgKHJl
Z2Jhc2UsIENMX1NFUVIxMiwgMHgwKTsJLyogZ3JhcGhpY3MgY3Vyc29yIGF0dHJpYnV0ZXM6IG5v
dGhpbmcgc3BlY2lhbCAqLworCS8qIGdyYXBoaWNzIGN1cnNvciBhdHRyaWJ1dGVzOiBub3RoaW5n
IHNwZWNpYWwgKi8KKwl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9TRVFSMTIsIDB4MCk7CiAKIAkvKiBm
aW5hbGx5LCB0dXJuIG9uIGV2ZXJ5dGhpbmcgLSB0dXJuIG9mZiAiRnVsbEJhbmR3aWR0aCIgYml0
ICovCiAJLyogYWxzbywgc2V0ICJEb3RDbG9jayUyIiBiaXQgd2hlcmUgcmVxdWVzdGVkICovCkBA
IC0xNTQyLDggKzE2MjMsOCBAQCBzdGF0aWMgaW50IGNpcnJ1c2ZiX3NldF9wYXJfZm9vIChzdHJ1
Y3QgCiAJdG1wIHw9IDB4MDg7CiAqLwogCi0JdmdhX3dzZXEgKHJlZ2Jhc2UsIFZHQV9TRVFfQ0xP
Q0tfTU9ERSwgdG1wKTsKLQlEUFJJTlRLICgiQ0xfU0VRUjE6ICVkXG4iLCB0bXApOworCXZnYV93
c2VxKHJlZ2Jhc2UsIFZHQV9TRVFfQ0xPQ0tfTU9ERSwgdG1wKTsKKwlEUFJJTlRLKCJDTF9TRVFS
MTogJWRcbiIsIHRtcCk7CiAKIAljaW5mby0+Y3VycmVudG1vZGUgPSByZWdzOwogCWluZm8tPmZp
eC50eXBlID0gcmVncy50eXBlOwpAQCAtMTU1MSwyNyArMTYzMiwyNyBAQCBzdGF0aWMgaW50IGNp
cnJ1c2ZiX3NldF9wYXJfZm9vIChzdHJ1Y3QgCiAJaW5mby0+Zml4LmxpbmVfbGVuZ3RoID0gcmVn
cy5saW5lX2xlbmd0aDsKIAogCS8qIHBhbiB0byByZXF1ZXN0ZWQgb2Zmc2V0ICovCi0JY2lycnVz
ZmJfcGFuX2Rpc3BsYXkgKHZhciwgaW5mbyk7CisJY2lycnVzZmJfcGFuX2Rpc3BsYXkodmFyLCBp
bmZvKTsKIAogI2lmZGVmIENJUlJVU0ZCX0RFQlVHCi0JY2lycnVzZmJfZHVtcCAoKTsKKwljaXJy
dXNmYl9kdW1wKCk7CiAjZW5kaWYKIAotCURQUklOVEsgKCJFWElUXG4iKTsKKwlEUFJJTlRLKCJF
WElUXG4iKTsKIAlyZXR1cm4gMDsKIH0KIAogLyogZm9yIHNvbWUgcmVhc29uIGluY29tcHJlaGVu
c2libGUgdG8gbWUsIGNpcnJ1c2ZiIHJlcXVpcmVzIHRoYXQgeW91IHdyaXRlCiAgKiB0aGUgcmVn
aXN0ZXJzIHR3aWNlIGZvciB0aGUgc2V0dGluZ3MgdG8gdGFrZS4uZ3JyLiAtZHRlICovCi1zdGF0
aWMgaW50IGNpcnJ1c2ZiX3NldF9wYXIgKHN0cnVjdCBmYl9pbmZvICppbmZvKQorc3RhdGljIGlu
dCBjaXJydXNmYl9zZXRfcGFyKHN0cnVjdCBmYl9pbmZvICppbmZvKQogewotCWNpcnJ1c2ZiX3Nl
dF9wYXJfZm9vIChpbmZvKTsKLQlyZXR1cm4gY2lycnVzZmJfc2V0X3Bhcl9mb28gKGluZm8pOwor
CWNpcnJ1c2ZiX3NldF9wYXJfZm9vKGluZm8pOworCXJldHVybiBjaXJydXNmYl9zZXRfcGFyX2Zv
byhpbmZvKTsKIH0KIAotc3RhdGljIGludCBjaXJydXNmYl9zZXRjb2xyZWcgKHVuc2lnbmVkIHJl
Z25vLCB1bnNpZ25lZCByZWQsIHVuc2lnbmVkIGdyZWVuLAotCQkJICAgICAgIHVuc2lnbmVkIGJs
dWUsIHVuc2lnbmVkIHRyYW5zcCwKLQkJCSAgICAgICBzdHJ1Y3QgZmJfaW5mbyAqaW5mbykKK3N0
YXRpYyBpbnQgY2lycnVzZmJfc2V0Y29scmVnKHVuc2lnbmVkIHJlZ25vLCB1bnNpZ25lZCByZWQs
IHVuc2lnbmVkIGdyZWVuLAorCQkJICAgICAgdW5zaWduZWQgYmx1ZSwgdW5zaWduZWQgdHJhbnNw
LAorCQkJICAgICAgc3RydWN0IGZiX2luZm8gKmluZm8pCiB7CiAJc3RydWN0IGNpcnJ1c2ZiX2lu
Zm8gKmNpbmZvID0gaW5mby0+cGFyOwogCkBAIC0xNTg0LDIzICsxNjY1LDIzIEBAIHN0YXRpYyBp
bnQgY2lycnVzZmJfc2V0Y29scmVnICh1bnNpZ25lZCAKIAkJZ3JlZW4gPj49ICgxNiAtIGluZm8t
PnZhci5ncmVlbi5sZW5ndGgpOwogCQlibHVlID4+PSAoMTYgLSBpbmZvLT52YXIuYmx1ZS5sZW5n
dGgpOwogCi0JCWlmIChyZWdubz49MTYpCisJCWlmIChyZWdubyA+PSAxNikKIAkJCXJldHVybiAx
OwogCQl2ID0gKHJlZCA8PCBpbmZvLT52YXIucmVkLm9mZnNldCkgfAogCQkgICAgKGdyZWVuIDw8
IGluZm8tPnZhci5ncmVlbi5vZmZzZXQpIHwKIAkJICAgIChibHVlIDw8IGluZm8tPnZhci5ibHVl
Lm9mZnNldCk7CiAKIAkJc3dpdGNoIChpbmZvLT52YXIuYml0c19wZXJfcGl4ZWwpIHsKLQkJCWNh
c2UgODoKLQkJCQljaW5mby0+cHNldWRvX3BhbGV0dGVbcmVnbm9dID0gdjsKLQkJCQlicmVhazsK
LQkJCWNhc2UgMTY6Ci0JCQkJY2luZm8tPnBzZXVkb19wYWxldHRlW3JlZ25vXSA9IHY7Ci0JCQkJ
YnJlYWs7Ci0JCQljYXNlIDI0OgotCQkJY2FzZSAzMjoKLQkJCQljaW5mby0+cHNldWRvX3BhbGV0
dGVbcmVnbm9dID0gdjsKLQkJCQlicmVhazsKKwkJY2FzZSA4OgorCQkJY2luZm8tPnBzZXVkb19w
YWxldHRlW3JlZ25vXSA9IHY7CisJCQlicmVhazsKKwkJY2FzZSAxNjoKKwkJCWNpbmZvLT5wc2V1
ZG9fcGFsZXR0ZVtyZWdub10gPSB2OworCQkJYnJlYWs7CisJCWNhc2UgMjQ6CisJCWNhc2UgMzI6
CisJCQljaW5mby0+cHNldWRvX3BhbGV0dGVbcmVnbm9dID0gdjsKKwkJCWJyZWFrOwogCQl9CiAJ
CXJldHVybiAwOwogCX0KQEAgLTE2MDksOSArMTY5MCw4IEBAIHN0YXRpYyBpbnQgY2lycnVzZmJf
c2V0Y29scmVnICh1bnNpZ25lZCAKIAljaW5mby0+cGFsZXR0ZVtyZWdub10uZ3JlZW4gPSBncmVl
bjsKIAljaW5mby0+cGFsZXR0ZVtyZWdub10uYmx1ZSA9IGJsdWU7CiAKLQlpZiAoaW5mby0+dmFy
LmJpdHNfcGVyX3BpeGVsID09IDgpIHsKLQkJCVdDbHV0IChjaW5mbywgcmVnbm8sIHJlZCA+PiAx
MCwgZ3JlZW4gPj4gMTAsIGJsdWUgPj4gMTApOwotCX0KKwlpZiAoaW5mby0+dmFyLmJpdHNfcGVy
X3BpeGVsID09IDgpCisJCVdDbHV0KGNpbmZvLCByZWdubywgcmVkID4+IDEwLCBncmVlbiA+PiAx
MCwgYmx1ZSA+PiAxMCk7CiAKIAlyZXR1cm4gMDsKIApAQCAtMTYyMiw4ICsxNzAyLDggQEAgc3Rh
dGljIGludCBjaXJydXNmYl9zZXRjb2xyZWcgKHVuc2lnbmVkIAogCiAJcGVyZm9ybXMgZGlzcGxh
eSBwYW5uaW5nIC0gcHJvdmlkZWQgaGFyZHdhcmUgcGVybWl0cyB0aGlzCiAqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKi8KLXN0YXRpYyBpbnQgY2lycnVzZmJfcGFuX2Rpc3BsYXkgKHN0cnVjdCBmYl92YXJfc2Ny
ZWVuaW5mbyAqdmFyLAotCQkJCSBzdHJ1Y3QgZmJfaW5mbyAqaW5mbykKK3N0YXRpYyBpbnQgY2ly
cnVzZmJfcGFuX2Rpc3BsYXkoc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIsCisJCQkJc3Ry
dWN0IGZiX2luZm8gKmluZm8pCiB7CiAJaW50IHhvZmZzZXQgPSAwOwogCWludCB5b2Zmc2V0ID0g
MDsKQEAgLTE2MzEsOCArMTcxMSw4IEBAIHN0YXRpYyBpbnQgY2lycnVzZmJfcGFuX2Rpc3BsYXkg
KHN0cnVjdCAKIAl1bnNpZ25lZCBjaGFyIHRtcCA9IDAsIHRtcDIgPSAwLCB4cGl4OwogCXN0cnVj
dCBjaXJydXNmYl9pbmZvICpjaW5mbyA9IGluZm8tPnBhcjsKIAotCURQUklOVEsgKCJFTlRFUlxu
Iik7Ci0JRFBSSU5USyAoInZpcnR1YWwgb2Zmc2V0OiAoJWQsJWQpXG4iLCB2YXItPnhvZmZzZXQs
IHZhci0+eW9mZnNldCk7CisJRFBSSU5USygiRU5URVJcbiIpOworCURQUklOVEsoInZpcnR1YWwg
b2Zmc2V0OiAoJWQsJWQpXG4iLCB2YXItPnhvZmZzZXQsIHZhci0+eW9mZnNldCk7CiAKIAkvKiBu
byByYW5nZSBjaGVja3MgZm9yIHhvZmZzZXQgYW5kIHlvZmZzZXQsICAgKi8KIAkvKiBhcyBmYl9w
YW5fZGlzcGxheSBoYXMgYWxyZWFkeSBkb25lIHRoaXMgKi8KQEAgLTE2NTUsMTEgKzE3MzUsMTMg
QEAgc3RhdGljIGludCBjaXJydXNmYl9wYW5fZGlzcGxheSAoc3RydWN0IAogCQl4cGl4ID0gKHVu
c2lnbmVkIGNoYXIpICgoeG9mZnNldCAlIDQpICogMik7CiAJfQogCi0gICAgICAgIGNpcnJ1c2Zi
X1dhaXRCTFQoY2luZm8tPnJlZ2Jhc2UpOyAvKiBtYWtlIHN1cmUgYWxsIHRoZSBCTFQncyBhcmUg
ZG9uZSAqLworCWNpcnJ1c2ZiX1dhaXRCTFQoY2luZm8tPnJlZ2Jhc2UpOyAvKiBtYWtlIHN1cmUg
YWxsIHRoZSBCTFQncyBhcmUgZG9uZSAqLwogCiAJLyogbG93ZXIgOCArIDggYml0cyBvZiBzY3Jl
ZW4gc3RhcnQgYWRkcmVzcyAqLwotCXZnYV93Y3J0IChjaW5mby0+cmVnYmFzZSwgVkdBX0NSVENf
U1RBUlRfTE8sICh1bnNpZ25lZCBjaGFyKSAoYmFzZSAmIDB4ZmYpKTsKLQl2Z2Ffd2NydCAoY2lu
Zm8tPnJlZ2Jhc2UsIFZHQV9DUlRDX1NUQVJUX0hJLCAodW5zaWduZWQgY2hhcikgKGJhc2UgPj4g
OCkpOworCXZnYV93Y3J0KGNpbmZvLT5yZWdiYXNlLCBWR0FfQ1JUQ19TVEFSVF9MTywKKwkJICh1
bnNpZ25lZCBjaGFyKSAoYmFzZSAmIDB4ZmYpKTsKKwl2Z2Ffd2NydChjaW5mby0+cmVnYmFzZSwg
VkdBX0NSVENfU1RBUlRfSEksCisJCSAodW5zaWduZWQgY2hhcikgKGJhc2UgPj4gOCkpOwogCiAJ
LyogY29uc3RydWN0IGJpdHMgMTYsIDE3IGFuZCAxOCBvZiBzY3JlZW4gc3RhcnQgYWRkcmVzcyAq
LwogCWlmIChiYXNlICYgMHgxMDAwMCkKQEAgLTE2NjksNTAgKzE3NTEsNTMgQEAgc3RhdGljIGlu
dCBjaXJydXNmYl9wYW5fZGlzcGxheSAoc3RydWN0IAogCWlmIChiYXNlICYgMHg0MDAwMCkKIAkJ
dG1wIHw9IDB4MDg7CiAKLQl0bXAyID0gKHZnYV9yY3J0IChjaW5mby0+cmVnYmFzZSwgQ0xfQ1JU
MUIpICYgMHhmMikgfCB0bXA7CS8qIDB4ZjIgaXMgJTExMTEwMDEwLCBleGNsdWRlIHRtcCBiaXRz
ICovCi0JdmdhX3djcnQgKGNpbmZvLT5yZWdiYXNlLCBDTF9DUlQxQiwgdG1wMik7CisJLyogMHhm
MiBpcyAlMTExMTAwMTAsIGV4Y2x1ZGUgdG1wIGJpdHMgKi8KKwl0bXAyID0gKHZnYV9yY3J0KGNp
bmZvLT5yZWdiYXNlLCBDTF9DUlQxQikgJiAweGYyKSB8IHRtcDsKKwl2Z2Ffd2NydChjaW5mby0+
cmVnYmFzZSwgQ0xfQ1JUMUIsIHRtcDIpOwogCiAJLyogY29uc3RydWN0IGJpdCAxOSBvZiBzY3Jl
ZW4gc3RhcnQgYWRkcmVzcyAqLwogCWlmIChjaXJydXNmYl9ib2FyZF9pbmZvW2NpbmZvLT5idHlw
ZV0uc2Nybl9zdGFydF9iaXQxOSkgewogCQl0bXAyID0gMDsKIAkJaWYgKGJhc2UgJiAweDgwMDAw
KQogCQkJdG1wMiA9IDB4ODA7Ci0JCXZnYV93Y3J0IChjaW5mby0+cmVnYmFzZSwgQ0xfQ1JUMUQs
IHRtcDIpOworCQl2Z2Ffd2NydChjaW5mby0+cmVnYmFzZSwgQ0xfQ1JUMUQsIHRtcDIpOwogCX0K
IAotCS8qIHdyaXRlIHBpeGVsIHBhbm5pbmcgdmFsdWUgdG8gQVIzMzsgdGhpcyBkb2VzIG5vdCBx
dWl0ZSB3b3JrIGluIDhicHAgKi8KLQkvKiAjIyMgUGljY29sby4uPyBXaWxsIHRoaXMgd29yaz8g
Ki8KKwkvKiB3cml0ZSBwaXhlbCBwYW5uaW5nIHZhbHVlIHRvIEFSMzM7IHRoaXMgZG9lcyBub3Qg
cXVpdGUgd29yayBpbiA4YnBwCisJICoKKwkgKiAjIyMgUGljY29sby4uPyBXaWxsIHRoaXMgd29y
az8KKwkgKi8KIAlpZiAoaW5mby0+dmFyLmJpdHNfcGVyX3BpeGVsID09IDEpCi0JCXZnYV93YXR0
ciAoY2luZm8tPnJlZ2Jhc2UsIENMX0FSMzMsIHhwaXgpOworCQl2Z2Ffd2F0dHIoY2luZm8tPnJl
Z2Jhc2UsIENMX0FSMzMsIHhwaXgpOwogCi0JY2lycnVzZmJfV2FpdEJMVCAoY2luZm8tPnJlZ2Jh
c2UpOworCWNpcnJ1c2ZiX1dhaXRCTFQoY2luZm8tPnJlZ2Jhc2UpOwogCi0JRFBSSU5USyAoIkVY
SVRcbiIpOwotCXJldHVybiAoMCk7CisJRFBSSU5USygiRVhJVFxuIik7CisJcmV0dXJuIDA7CiB9
CiAKLQotc3RhdGljIGludCBjaXJydXNmYl9ibGFuayAoaW50IGJsYW5rX21vZGUsIHN0cnVjdCBm
Yl9pbmZvICppbmZvKQorc3RhdGljIGludCBjaXJydXNmYl9ibGFuayhpbnQgYmxhbmtfbW9kZSwg
c3RydWN0IGZiX2luZm8gKmluZm8pCiB7CiAJLyoKLQkgKiAgQmxhbmsgdGhlIHNjcmVlbiBpZiBi
bGFua19tb2RlICE9IDAsIGVsc2UgdW5ibGFuay4gSWYgYmxhbmsgPT0gTlVMTAotCSAqICB0aGVu
IHRoZSBjYWxsZXIgYmxhbmtzIGJ5IHNldHRpbmcgdGhlIENMVVQgKENvbG9yIExvb2sgVXAgVGFi
bGUpIHRvIGFsbAotCSAqICBibGFjay4gUmV0dXJuIDAgaWYgYmxhbmtpbmcgc3VjY2VlZGVkLCAh
PSAwIGlmIHVuLS9ibGFua2luZyBmYWlsZWQgZHVlCi0JICogIHRvIGUuZy4gYSB2aWRlbyBtb2Rl
IHdoaWNoIGRvZXNuJ3Qgc3VwcG9ydCBpdC4gSW1wbGVtZW50cyBWRVNBIHN1c3BlbmQKLQkgKiAg
YW5kIHBvd2VyZG93biBtb2RlcyBvbiBoYXJkd2FyZSB0aGF0IHN1cHBvcnRzIGRpc2FibGluZyBo
c3luYy92c3luYzoKLQkgKiAgICBibGFua19tb2RlID09IDI6IHN1c3BlbmQgdnN5bmMKLQkgKiAg
ICBibGFua19tb2RlID09IDM6IHN1c3BlbmQgaHN5bmMKLQkgKiAgICBibGFua19tb2RlID09IDQ6
IHBvd2VyZG93bgorCSAqIEJsYW5rIHRoZSBzY3JlZW4gaWYgYmxhbmtfbW9kZSAhPSAwLCBlbHNl
IHVuYmxhbmsuIElmIGJsYW5rID09IE5VTEwKKwkgKiB0aGVuIHRoZSBjYWxsZXIgYmxhbmtzIGJ5
IHNldHRpbmcgdGhlIENMVVQgKENvbG9yIExvb2sgVXAgVGFibGUpCisJICogdG8gYWxsIGJsYWNr
LiBSZXR1cm4gMCBpZiBibGFua2luZyBzdWNjZWVkZWQsICE9IDAgaWYgdW4tL2JsYW5raW5nCisJ
ICogZmFpbGVkIGR1ZSB0byBlLmcuIGEgdmlkZW8gbW9kZSB3aGljaCBkb2Vzbid0IHN1cHBvcnQg
aXQuCisJICogSW1wbGVtZW50cyBWRVNBIHN1c3BlbmQgYW5kIHBvd2VyZG93biBtb2RlcyBvbiBo
YXJkd2FyZSB0aGF0CisJICogc3VwcG9ydHMgZGlzYWJsaW5nIGhzeW5jL3ZzeW5jOgorCSAqICAg
YmxhbmtfbW9kZSA9PSAyOiBzdXNwZW5kIHZzeW5jCisJICogICBibGFua19tb2RlID09IDM6IHN1
c3BlbmQgaHN5bmMKKwkgKiAgIGJsYW5rX21vZGUgPT0gNDogcG93ZXJkb3duCiAJICovCiAJdW5z
aWduZWQgY2hhciB2YWw7CiAJc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvID0gaW5mby0+cGFy
OwogCWludCBjdXJyZW50X21vZGUgPSBjaW5mby0+YmxhbmtfbW9kZTsKIAotCURQUklOVEsgKCJF
TlRFUiwgYmxhbmsgbW9kZSA9ICVkXG4iLCBibGFua19tb2RlKTsKKwlEUFJJTlRLKCJFTlRFUiwg
YmxhbmsgbW9kZSA9ICVkXG4iLCBibGFua19tb2RlKTsKIAogCWlmIChpbmZvLT5zdGF0ZSAhPSBG
QklORk9fU1RBVEVfUlVOTklORyB8fAogCSAgICBjdXJyZW50X21vZGUgPT0gYmxhbmtfbW9kZSkg
ewotCQlEUFJJTlRLICgiRVhJVCwgcmV0dXJuaW5nIDBcbiIpOworCQlEUFJJTlRLKCJFWElULCBy
ZXR1cm5pbmcgMFxuIik7CiAJCXJldHVybiAwOwogCX0KIApAQCAtMTcyMCwxNyArMTgwNSwxOSBA
QCBzdGF0aWMgaW50IGNpcnJ1c2ZiX2JsYW5rIChpbnQgYmxhbmtfbW9kCiAJaWYgKGN1cnJlbnRf
bW9kZSA9PSBGQl9CTEFOS19OT1JNQUwgfHwKIAkgICAgY3VycmVudF9tb2RlID09IEZCX0JMQU5L
X1VOQkxBTkspIHsKIAkJLyogdW5ibGFuayB0aGUgc2NyZWVuICovCi0JCXZhbCA9IHZnYV9yc2Vx
IChjaW5mby0+cmVnYmFzZSwgVkdBX1NFUV9DTE9DS19NT0RFKTsKLQkJdmdhX3dzZXEgKGNpbmZv
LT5yZWdiYXNlLCBWR0FfU0VRX0NMT0NLX01PREUsIHZhbCAmIDB4ZGYpOwkvKiBjbGVhciAiRnVs
bEJhbmR3aWR0aCIgYml0ICovCisJCXZhbCA9IHZnYV9yc2VxKGNpbmZvLT5yZWdiYXNlLCBWR0Ff
U0VRX0NMT0NLX01PREUpOworCQkvKiBjbGVhciAiRnVsbEJhbmR3aWR0aCIgYml0ICovCisJCXZn
YV93c2VxKGNpbmZvLT5yZWdiYXNlLCBWR0FfU0VRX0NMT0NLX01PREUsIHZhbCAmIDB4ZGYpOwog
CQkvKiBhbmQgdW5kbyBWRVNBIHN1c3BlbmQgdHJpY2tlcnkgKi8KLQkJdmdhX3dnZnggKGNpbmZv
LT5yZWdiYXNlLCBDTF9HUkUsIDB4MDApOworCQl2Z2Ffd2dmeChjaW5mby0+cmVnYmFzZSwgQ0xf
R1JFLCAweDAwKTsKIAl9CiAKIAkvKiBzZXQgbmV3ICovCi0JaWYoYmxhbmtfbW9kZSA+IEZCX0JM
QU5LX05PUk1BTCkgeworCWlmIChibGFua19tb2RlID4gRkJfQkxBTktfTk9STUFMKSB7CiAJCS8q
IGJsYW5rIHRoZSBzY3JlZW4gKi8KLQkJdmFsID0gdmdhX3JzZXEgKGNpbmZvLT5yZWdiYXNlLCBW
R0FfU0VRX0NMT0NLX01PREUpOwotCQl2Z2Ffd3NlcSAoY2luZm8tPnJlZ2Jhc2UsIFZHQV9TRVFf
Q0xPQ0tfTU9ERSwgdmFsIHwgMHgyMCk7CS8qIHNldCAiRnVsbEJhbmR3aWR0aCIgYml0ICovCisJ
CXZhbCA9IHZnYV9yc2VxKGNpbmZvLT5yZWdiYXNlLCBWR0FfU0VRX0NMT0NLX01PREUpOworCQkv
KiBzZXQgIkZ1bGxCYW5kd2lkdGgiIGJpdCAqLworCQl2Z2Ffd3NlcShjaW5mby0+cmVnYmFzZSwg
VkdBX1NFUV9DTE9DS19NT0RFLCB2YWwgfCAweDIwKTsKIAl9CiAKIAlzd2l0Y2ggKGJsYW5rX21v
ZGUpIHsKQEAgLTE3MzgsMjEgKzE4MjUsMjEgQEAgc3RhdGljIGludCBjaXJydXNmYl9ibGFuayAo
aW50IGJsYW5rX21vZAogCWNhc2UgRkJfQkxBTktfTk9STUFMOgogCQlicmVhazsKIAljYXNlIEZC
X0JMQU5LX1ZTWU5DX1NVU1BFTkQ6Ci0JCXZnYV93Z2Z4IChjaW5mby0+cmVnYmFzZSwgQ0xfR1JF
LCAweDA0KTsKKwkJdmdhX3dnZngoY2luZm8tPnJlZ2Jhc2UsIENMX0dSRSwgMHgwNCk7CiAJCWJy
ZWFrOwogCWNhc2UgRkJfQkxBTktfSFNZTkNfU1VTUEVORDoKLQkJdmdhX3dnZnggKGNpbmZvLT5y
ZWdiYXNlLCBDTF9HUkUsIDB4MDIpOworCQl2Z2Ffd2dmeChjaW5mby0+cmVnYmFzZSwgQ0xfR1JF
LCAweDAyKTsKIAkJYnJlYWs7CiAJY2FzZSBGQl9CTEFOS19QT1dFUkRPV046Ci0JCXZnYV93Z2Z4
IChjaW5mby0+cmVnYmFzZSwgQ0xfR1JFLCAweDA2KTsKKwkJdmdhX3dnZngoY2luZm8tPnJlZ2Jh
c2UsIENMX0dSRSwgMHgwNik7CiAJCWJyZWFrOwogCWRlZmF1bHQ6Ci0JCURQUklOVEsgKCJFWElU
LCByZXR1cm5pbmcgMVxuIik7CisJCURQUklOVEsoIkVYSVQsIHJldHVybmluZyAxXG4iKTsKIAkJ
cmV0dXJuIDE7CiAJfQogCiAJY2luZm8tPmJsYW5rX21vZGUgPSBibGFua19tb2RlOwotCURQUklO
VEsgKCJFWElULCByZXR1cm5pbmcgMFxuIik7CisJRFBSSU5USygiRVhJVCwgcmV0dXJuaW5nIDBc
biIpOwogCiAJLyogTGV0IGZiY29uIGRvIGEgc29mdCBibGFuayBmb3IgdXMgKi8KIAlyZXR1cm4g
KGJsYW5rX21vZGUgPT0gRkJfQkxBTktfTk9STUFMKSA/IDEgOiAwOwpAQCAtMTc2MSw0NSArMTg0
OCw1MCBAQCBzdGF0aWMgaW50IGNpcnJ1c2ZiX2JsYW5rIChpbnQgYmxhbmtfbW9kCiAvKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKi8KIC8qKioqIEJFR0lOIEludGVybmFsIFJvdXRpbmVzICoqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwogCi1zdGF0aWMgdm9pZCBpbml0
X3ZnYWNoaXAgKHN0cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbykKK3N0YXRpYyB2b2lkIGluaXRf
dmdhY2hpcChzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8pCiB7CiAJY29uc3Qgc3RydWN0IGNp
cnJ1c2ZiX2JvYXJkX2luZm9fcmVjICpiaTsKIAotCURQUklOVEsgKCJFTlRFUlxuIik7CisJRFBS
SU5USygiRU5URVJcbiIpOwogCi0JYXNzZXJ0IChjaW5mbyAhPSBOVUxMKTsKKwlhc3NlcnQoY2lu
Zm8gIT0gTlVMTCk7CiAKIAliaSA9ICZjaXJydXNmYl9ib2FyZF9pbmZvW2NpbmZvLT5idHlwZV07
CiAKIAkvKiByZXNldCBib2FyZCBnbG9iYWxseSAqLwogCXN3aXRjaCAoY2luZm8tPmJ0eXBlKSB7
CiAJY2FzZSBCVF9QSUNDT0xPOgotCQlXU0ZSIChjaW5mbywgMHgwMSk7Ci0JCXVkZWxheSAoNTAw
KTsKLQkJV1NGUiAoY2luZm8sIDB4NTEpOwotCQl1ZGVsYXkgKDUwMCk7CisJCVdTRlIoY2luZm8s
IDB4MDEpOworCQl1ZGVsYXkoNTAwKTsKKwkJV1NGUihjaW5mbywgMHg1MSk7CisJCXVkZWxheSg1
MDApOwogCQlicmVhazsKIAljYXNlIEJUX1BJQ0FTU086Ci0JCVdTRlIyIChjaW5mbywgMHhmZik7
Ci0JCXVkZWxheSAoNTAwKTsKKwkJV1NGUjIoY2luZm8sIDB4ZmYpOworCQl1ZGVsYXkoNTAwKTsK
IAkJYnJlYWs7CiAJY2FzZSBCVF9TRDY0OgogCWNhc2UgQlRfU1BFQ1RSVU06Ci0JCVdTRlIgKGNp
bmZvLCAweDFmKTsKLQkJdWRlbGF5ICg1MDApOwotCQlXU0ZSIChjaW5mbywgMHg0Zik7Ci0JCXVk
ZWxheSAoNTAwKTsKKwkJV1NGUihjaW5mbywgMHgxZik7CisJCXVkZWxheSg1MDApOworCQlXU0ZS
KGNpbmZvLCAweDRmKTsKKwkJdWRlbGF5KDUwMCk7CiAJCWJyZWFrOwogCWNhc2UgQlRfUElDQVNT
TzQ6Ci0JCXZnYV93Y3J0IChjaW5mby0+cmVnYmFzZSwgQ0xfQ1JUNTEsIDB4MDApOwkvKiBkaXNh
YmxlIGZsaWNrZXJmaXhlciAqLwotCQltZGVsYXkgKDEwMCk7Ci0JCXZnYV93Z2Z4IChjaW5mby0+
cmVnYmFzZSwgQ0xfR1IyRiwgMHgwMCk7CS8qIGZyb20gS2xhdXMnIE5ldEJTRCBkcml2ZXI6ICov
Ci0JCXZnYV93Z2Z4IChjaW5mby0+cmVnYmFzZSwgQ0xfR1IzMywgMHgwMCk7CS8qIHB1dCBibGl0
dGVyIGludG8gNTQyeCBjb21wYXQgKi8KLQkJdmdhX3dnZnggKGNpbmZvLT5yZWdiYXNlLCBDTF9H
UjMxLCAweDAwKTsJLyogbW9kZSAqLworCQkvKiBkaXNhYmxlIGZsaWNrZXJmaXhlciAqLworCQl2
Z2Ffd2NydChjaW5mby0+cmVnYmFzZSwgQ0xfQ1JUNTEsIDB4MDApOworCQltZGVsYXkoMTAwKTsK
KwkJLyogZnJvbSBLbGF1cycgTmV0QlNEIGRyaXZlcjogKi8KKwkJdmdhX3dnZngoY2luZm8tPnJl
Z2Jhc2UsIENMX0dSMkYsIDB4MDApOworCQkvKiBwdXQgYmxpdHRlciBpbnRvIDU0MnggY29tcGF0
ICovCisJCXZnYV93Z2Z4KGNpbmZvLT5yZWdiYXNlLCBDTF9HUjMzLCAweDAwKTsKKwkJLyogbW9k
ZSAqLworCQl2Z2Ffd2dmeChjaW5mby0+cmVnYmFzZSwgQ0xfR1IzMSwgMHgwMCk7CiAJCWJyZWFr
OwogCiAJY2FzZSBCVF9HRDU0ODA6Ci0JCXZnYV93Z2Z4IChjaW5mby0+cmVnYmFzZSwgQ0xfR1Iy
RiwgMHgwMCk7CS8qIGZyb20gS2xhdXMnIE5ldEJTRCBkcml2ZXI6ICovCisJCS8qIGZyb20gS2xh
dXMnIE5ldEJTRCBkcml2ZXI6ICovCisJCXZnYV93Z2Z4KGNpbmZvLT5yZWdiYXNlLCBDTF9HUjJG
LCAweDAwKTsKIAkJYnJlYWs7CiAKIAljYXNlIEJUX0FMUElORToKQEAgLTE4MDcsMTUzICsxODk5
LDIwNyBAQCBzdGF0aWMgdm9pZCBpbml0X3ZnYWNoaXAgKHN0cnVjdCBjaXJydXNmCiAJCWJyZWFr
OwogCiAJZGVmYXVsdDoKLQkJcHJpbnRrIChLRVJOX0VSUiAiY2lycnVzZmI6IFdhcm5pbmc6IFVu
a25vd24gYm9hcmQgdHlwZVxuIik7CisJCXByaW50ayhLRVJOX0VSUiAiY2lycnVzZmI6IFdhcm5p
bmc6IFVua25vd24gYm9hcmQgdHlwZVxuIik7CiAJCWJyZWFrOwogCX0KIAotCWFzc2VydCAoY2lu
Zm8tPnNpemUgPiAwKTsgLyogbWFrZSBzdXJlIFJBTSBzaXplIHNldCBieSB0aGlzIHBvaW50ICov
CisJYXNzZXJ0KGNpbmZvLT5zaXplID4gMCk7IC8qIG1ha2Ugc3VyZSBSQU0gc2l6ZSBzZXQgYnkg
dGhpcyBwb2ludCAqLwogCiAJLyogdGhlIFA0IGlzIG5vdCBmdWxseSBpbml0aWFsaXplZCBoZXJl
OyBJIHJlbHkgb24gaXQgaGF2aW5nIGJlZW4gKi8KIAkvKiBpbml0ZWQgdW5kZXIgQW1pZ2FPUyBh
bHJlYWR5LCB3aGljaCBzZWVtcyB0byB3b3JrIGp1c3QgZmluZSAgICAqLwotCS8qIChLbGF1cyBh
ZHZpc2VkIHRvIGRvIGl0IHRoaXMgd2F5KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICov
CisJLyogKEtsYXVzIGFkdmlzZWQgdG8gZG8gaXQgdGhpcyB3YXkpCQkJICAgICAgKi8KIAogCWlm
IChjaW5mby0+YnR5cGUgIT0gQlRfUElDQVNTTzQpIHsKLQkJV0dlbiAoY2luZm8sIENMX1ZTU00s
IDB4MTApOwkvKiBFR1M6IDB4MTYgKi8KLQkJV0dlbiAoY2luZm8sIENMX1BPUzEwMiwgMHgwMSk7
Ci0JCVdHZW4gKGNpbmZvLCBDTF9WU1NNLCAweDA4KTsJLyogRUdTOiAweDBlICovCisJCVdHZW4o
Y2luZm8sIENMX1ZTU00sIDB4MTApOwkvKiBFR1M6IDB4MTYgKi8KKwkJV0dlbihjaW5mbywgQ0xf
UE9TMTAyLCAweDAxKTsKKwkJV0dlbihjaW5mbywgQ0xfVlNTTSwgMHgwOCk7CS8qIEVHUzogMHgw
ZSAqLwogCiAJCWlmIChjaW5mby0+YnR5cGUgIT0gQlRfU0Q2NCkKLQkJCVdHZW4gKGNpbmZvLCBD
TF9WU1NNMiwgMHgwMSk7CisJCQlXR2VuKGNpbmZvLCBDTF9WU1NNMiwgMHgwMSk7CiAKLQkJdmdh
X3dzZXEgKGNpbmZvLT5yZWdiYXNlLCBDTF9TRVFSMCwgMHgwMyk7CS8qIHJlc2V0IHNlcXVlbmNl
ciBsb2dpYyAqLworCQkvKiByZXNldCBzZXF1ZW5jZXIgbG9naWMgKi8KKwkJdmdhX3dzZXEoY2lu
Zm8tPnJlZ2Jhc2UsIENMX1NFUVIwLCAweDAzKTsKIAotCQl2Z2Ffd3NlcSAoY2luZm8tPnJlZ2Jh
c2UsIFZHQV9TRVFfQ0xPQ0tfTU9ERSwgMHgyMSk7CS8qIEZ1bGxCYW5kd2lkdGggKHZpZGVvIG9m
ZikgYW5kIDgvOSBkb3QgY2xvY2sgKi8KLQkJV0dlbiAoY2luZm8sIFZHQV9NSVNfVywgMHhjMSk7
CS8qIHBvbGFyaXR5ICgtLy0pLCBkaXNhYmxlIGFjY2VzcyB0byBkaXNwbGF5IG1lbW9yeSwgVkdB
X0NSVENfU1RBUlRfSEkgYmFzZSBhZGRyZXNzOiBjb2xvciAqLworCQkvKiBGdWxsQmFuZHdpZHRo
ICh2aWRlbyBvZmYpIGFuZCA4LzkgZG90IGNsb2NrICovCisJCXZnYV93c2VxKGNpbmZvLT5yZWdi
YXNlLCBWR0FfU0VRX0NMT0NLX01PREUsIDB4MjEpOworCQkvKiBwb2xhcml0eSAoLS8tKSwgZGlz
YWJsZSBhY2Nlc3MgdG8gZGlzcGxheSBtZW1vcnksCisJCSAqIFZHQV9DUlRDX1NUQVJUX0hJIGJh
c2UgYWRkcmVzczogY29sb3IKKwkJICovCisJCVdHZW4oY2luZm8sIFZHQV9NSVNfVywgMHhjMSk7
CiAKLS8qICAgICAgdmdhX3dnZnggKGNpbmZvLT5yZWdiYXNlLCBDTF9HUkEsIDB4Y2UpOyAgICAi
bWFnaWMgY29va2llIiAtIGRvZXNuJ3QgbWFrZSBhbnkgc2Vuc2UgdG8gbWUuLiAqLwotCQl2Z2Ff
d3NlcSAoY2luZm8tPnJlZ2Jhc2UsIENMX1NFUVI2LCAweDEyKTsJLyogdW5sb2NrIGFsbCBleHRl
bnNpb24gcmVnaXN0ZXJzICovCisJCS8qICJtYWdpYyBjb29raWUiIC0gZG9lc24ndCBtYWtlIGFu
eSBzZW5zZSB0byBtZS4uICovCisvKiAgICAgIHZnYV93Z2Z4KGNpbmZvLT5yZWdiYXNlLCBDTF9H
UkEsIDB4Y2UpOyAgICovCisJCS8qIHVubG9jayBhbGwgZXh0ZW5zaW9uIHJlZ2lzdGVycyAqLwor
CQl2Z2Ffd3NlcShjaW5mby0+cmVnYmFzZSwgQ0xfU0VRUjYsIDB4MTIpOwogCi0JCXZnYV93Z2Z4
IChjaW5mby0+cmVnYmFzZSwgQ0xfR1IzMSwgMHgwNCk7CS8qIHJlc2V0IGJsaXR0ZXIgKi8KKwkJ
LyogcmVzZXQgYmxpdHRlciAqLworCQl2Z2Ffd2dmeChjaW5mby0+cmVnYmFzZSwgQ0xfR1IzMSwg
MHgwNCk7CiAKIAkJc3dpdGNoIChjaW5mby0+YnR5cGUpIHsKIAkJY2FzZSBCVF9HRDU0ODA6Ci0J
CQl2Z2Ffd3NlcSAoY2luZm8tPnJlZ2Jhc2UsIENMX1NFUVJGLCAweDk4KTsKKwkJCXZnYV93c2Vx
KGNpbmZvLT5yZWdiYXNlLCBDTF9TRVFSRiwgMHg5OCk7CiAJCQlicmVhazsKIAkJY2FzZSBCVF9B
TFBJTkU6CiAJCQlicmVhazsKIAkJY2FzZSBCVF9TRDY0OgotCQkJdmdhX3dzZXEgKGNpbmZvLT5y
ZWdiYXNlLCBDTF9TRVFSRiwgMHhiOCk7CisJCQl2Z2Ffd3NlcShjaW5mby0+cmVnYmFzZSwgQ0xf
U0VRUkYsIDB4YjgpOwogCQkJYnJlYWs7CiAJCWRlZmF1bHQ6Ci0JCQl2Z2Ffd3NlcSAoY2luZm8t
PnJlZ2Jhc2UsIENMX1NFUVIxNiwgMHgwZik7Ci0JCQl2Z2Ffd3NlcSAoY2luZm8tPnJlZ2Jhc2Us
IENMX1NFUVJGLCAweGIwKTsKKwkJCXZnYV93c2VxKGNpbmZvLT5yZWdiYXNlLCBDTF9TRVFSMTYs
IDB4MGYpOworCQkJdmdhX3dzZXEoY2luZm8tPnJlZ2Jhc2UsIENMX1NFUVJGLCAweGIwKTsKIAkJ
CWJyZWFrOwogCQl9CiAJfQotCXZnYV93c2VxIChjaW5mby0+cmVnYmFzZSwgVkdBX1NFUV9QTEFO
RV9XUklURSwgMHhmZik7CS8qIHBsYW5lIG1hc2s6IG5vdGhpbmcgKi8KLQl2Z2Ffd3NlcSAoY2lu
Zm8tPnJlZ2Jhc2UsIFZHQV9TRVFfQ0hBUkFDVEVSX01BUCwgMHgwMCk7CS8qIGNoYXJhY3RlciBt
YXAgc2VsZWN0OiBkb2Vzbid0IGV2ZW4gbWF0dGVyIGluIGd4IG1vZGUgKi8KLQl2Z2Ffd3NlcSAo
Y2luZm8tPnJlZ2Jhc2UsIFZHQV9TRVFfTUVNT1JZX01PREUsIDB4MGUpOwkvKiBtZW1vcnkgbW9k
ZTogY2hhaW4tNCwgbm8gb2RkL2V2ZW4sIGV4dC4gbWVtb3J5ICovCisJLyogcGxhbmUgbWFzazog
bm90aGluZyAqLworCXZnYV93c2VxKGNpbmZvLT5yZWdiYXNlLCBWR0FfU0VRX1BMQU5FX1dSSVRF
LCAweGZmKTsKKwkvKiBjaGFyYWN0ZXIgbWFwIHNlbGVjdDogZG9lc24ndCBldmVuIG1hdHRlciBp
biBneCBtb2RlICovCisJdmdhX3dzZXEoY2luZm8tPnJlZ2Jhc2UsIFZHQV9TRVFfQ0hBUkFDVEVS
X01BUCwgMHgwMCk7CisJLyogbWVtb3J5IG1vZGU6IGNoYWluLTQsIG5vIG9kZC9ldmVuLCBleHQu
IG1lbW9yeSAqLworCXZnYV93c2VxKGNpbmZvLT5yZWdiYXNlLCBWR0FfU0VRX01FTU9SWV9NT0RF
LCAweDBlKTsKIAogCS8qIGNvbnRyb2xsZXItaW50ZXJuYWwgYmFzZSBhZGRyZXNzIG9mIHZpZGVv
IG1lbW9yeSAqLwogCWlmIChiaS0+aW5pdF9zcjA3KQotCQl2Z2Ffd3NlcSAoY2luZm8tPnJlZ2Jh
c2UsIENMX1NFUVI3LCBiaS0+c3IwNyk7CisJCXZnYV93c2VxKGNpbmZvLT5yZWdiYXNlLCBDTF9T
RVFSNywgYmktPnNyMDcpOwogCi0JLyogIHZnYV93c2VxIChjaW5mby0+cmVnYmFzZSwgQ0xfU0VR
UjgsIDB4MDApOyAqLy8qIEVFUFJPTSBjb250cm9sOiBzaG91bGRuJ3QgYmUgbmVjZXNzYXJ5IHRv
IHdyaXRlIHRvIHRoaXMgYXQgYWxsLi4gKi8KKwkvKiAgdmdhX3dzZXEoY2luZm8tPnJlZ2Jhc2Us
IENMX1NFUVI4LCAweDAwKTsgKi8KKwkvKiBFRVBST00gY29udHJvbDogc2hvdWxkbid0IGJlIG5l
Y2Vzc2FyeSB0byB3cml0ZSB0byB0aGlzIGF0IGFsbC4uICovCiAKLQl2Z2Ffd3NlcSAoY2luZm8t
PnJlZ2Jhc2UsIENMX1NFUVIxMCwgMHgwMCk7CQkvKiBncmFwaGljcyBjdXJzb3IgWCBwb3NpdGlv
biAoaW5jb21wbGV0ZTsgcG9zaXRpb24gZ2l2ZXMgcmVtLiAzIGJpdHMgKi8KLQl2Z2Ffd3NlcSAo
Y2luZm8tPnJlZ2Jhc2UsIENMX1NFUVIxMSwgMHgwMCk7CQkvKiBncmFwaGljcyBjdXJzb3IgWSBw
b3NpdGlvbiAoLi4uIi4uLiApICovCi0JdmdhX3dzZXEgKGNpbmZvLT5yZWdiYXNlLCBDTF9TRVFS
MTIsIDB4MDApOwkJLyogZ3JhcGhpY3MgY3Vyc29yIGF0dHJpYnV0ZXMgKi8KLQl2Z2Ffd3NlcSAo
Y2luZm8tPnJlZ2Jhc2UsIENMX1NFUVIxMywgMHgwMCk7CQkvKiBncmFwaGljcyBjdXJzb3IgcGF0
dGVybiBhZGRyZXNzICovCisJLyogZ3JhcGhpY3MgY3Vyc29yIFggcG9zaXRpb24gKGluY29tcGxl
dGU7IHBvc2l0aW9uIGdpdmVzIHJlbS4gMyBiaXRzICovCisJdmdhX3dzZXEoY2luZm8tPnJlZ2Jh
c2UsIENMX1NFUVIxMCwgMHgwMCk7CisJLyogZ3JhcGhpY3MgY3Vyc29yIFkgcG9zaXRpb24gKC4u
LiIuLi4gKSAqLworCXZnYV93c2VxKGNpbmZvLT5yZWdiYXNlLCBDTF9TRVFSMTEsIDB4MDApOwor
CS8qIGdyYXBoaWNzIGN1cnNvciBhdHRyaWJ1dGVzICovCisJdmdhX3dzZXEoY2luZm8tPnJlZ2Jh
c2UsIENMX1NFUVIxMiwgMHgwMCk7CisJLyogZ3JhcGhpY3MgY3Vyc29yIHBhdHRlcm4gYWRkcmVz
cyAqLworCXZnYV93c2VxKGNpbmZvLT5yZWdiYXNlLCBDTF9TRVFSMTMsIDB4MDApOwogCiAJLyog
d3JpdGluZyB0aGVzZSBvbiBhIFA0IG1pZ2h0IGdpdmUgcHJvYmxlbXMuLiAgKi8KIAlpZiAoY2lu
Zm8tPmJ0eXBlICE9IEJUX1BJQ0FTU080KSB7Ci0JCXZnYV93c2VxIChjaW5mby0+cmVnYmFzZSwg
Q0xfU0VRUjE3LCAweDAwKTsJCS8qIGNvbmZpZ3VyYXRpb24gcmVhZGJhY2sgYW5kIGV4dC4gY29s
b3IgKi8KLQkJdmdhX3dzZXEgKGNpbmZvLT5yZWdiYXNlLCBDTF9TRVFSMTgsIDB4MDIpOwkJLyog
c2lnbmF0dXJlIGdlbmVyYXRvciAqLworCQkvKiBjb25maWd1cmF0aW9uIHJlYWRiYWNrIGFuZCBl
eHQuIGNvbG9yICovCisJCXZnYV93c2VxKGNpbmZvLT5yZWdiYXNlLCBDTF9TRVFSMTcsIDB4MDAp
OworCQkvKiBzaWduYXR1cmUgZ2VuZXJhdG9yICovCisJCXZnYV93c2VxKGNpbmZvLT5yZWdiYXNl
LCBDTF9TRVFSMTgsIDB4MDIpOwogCX0KIAogCS8qIE1DTEsgc2VsZWN0IGV0Yy4gKi8KIAlpZiAo
YmktPmluaXRfc3IxZikKLQkJdmdhX3dzZXEgKGNpbmZvLT5yZWdiYXNlLCBDTF9TRVFSMUYsIGJp
LT5zcjFmKTsKKwkJdmdhX3dzZXEoY2luZm8tPnJlZ2Jhc2UsIENMX1NFUVIxRiwgYmktPnNyMWYp
OwogCi0JdmdhX3djcnQgKGNpbmZvLT5yZWdiYXNlLCBWR0FfQ1JUQ19QUkVTRVRfUk9XLCAweDAw
KTsJLyogU2NyZWVuIEEgcHJlc2V0IHJvdyBzY2FuOiBub25lICovCi0JdmdhX3djcnQgKGNpbmZv
LT5yZWdiYXNlLCBWR0FfQ1JUQ19DVVJTT1JfU1RBUlQsIDB4MjApOwkvKiBUZXh0IGN1cnNvciBz
dGFydDogZGlzYWJsZSB0ZXh0IGN1cnNvciAqLwotCXZnYV93Y3J0IChjaW5mby0+cmVnYmFzZSwg
VkdBX0NSVENfQ1VSU09SX0VORCwgMHgwMCk7CS8qIFRleHQgY3Vyc29yIGVuZDogLSAqLwotCXZn
YV93Y3J0IChjaW5mby0+cmVnYmFzZSwgVkdBX0NSVENfU1RBUlRfSEksIDB4MDApOwkvKiBTY3Jl
ZW4gc3RhcnQgYWRkcmVzcyBoaWdoOiAwICovCi0JdmdhX3djcnQgKGNpbmZvLT5yZWdiYXNlLCBW
R0FfQ1JUQ19TVEFSVF9MTywgMHgwMCk7CS8qIFNjcmVlbiBzdGFydCBhZGRyZXNzIGxvdzogMCAq
LwotCXZnYV93Y3J0IChjaW5mby0+cmVnYmFzZSwgVkdBX0NSVENfQ1VSU09SX0hJLCAweDAwKTsJ
LyogdGV4dCBjdXJzb3IgbG9jYXRpb24gaGlnaDogMCAqLwotCXZnYV93Y3J0IChjaW5mby0+cmVn
YmFzZSwgVkdBX0NSVENfQ1VSU09SX0xPLCAweDAwKTsJLyogdGV4dCBjdXJzb3IgbG9jYXRpb24g
bG93OiAwICovCi0KLQl2Z2Ffd2NydCAoY2luZm8tPnJlZ2Jhc2UsIFZHQV9DUlRDX1VOREVSTElO
RSwgMHgwMCk7CS8qIFVuZGVybGluZSBSb3cgc2NhbmxpbmU6IC0gKi8KLQl2Z2Ffd2NydCAoY2lu
Zm8tPnJlZ2Jhc2UsIFZHQV9DUlRDX01PREUsIDB4YzMpOwkvKiBtb2RlIGNvbnRyb2w6IHRpbWlu
ZyBlbmFibGUsIGJ5dGUgbW9kZSwgbm8gY29tcGF0IG1vZGVzICovCi0JdmdhX3djcnQgKGNpbmZv
LT5yZWdiYXNlLCBWR0FfQ1JUQ19MSU5FX0NPTVBBUkUsIDB4MDApOwkvKiBMaW5lIENvbXBhcmU6
IG5vdCBuZWVkZWQgKi8KKwkvKiBTY3JlZW4gQSBwcmVzZXQgcm93IHNjYW46IG5vbmUgKi8KKwl2
Z2Ffd2NydChjaW5mby0+cmVnYmFzZSwgVkdBX0NSVENfUFJFU0VUX1JPVywgMHgwMCk7CisJLyog
VGV4dCBjdXJzb3Igc3RhcnQ6IGRpc2FibGUgdGV4dCBjdXJzb3IgKi8KKwl2Z2Ffd2NydChjaW5m
by0+cmVnYmFzZSwgVkdBX0NSVENfQ1VSU09SX1NUQVJULCAweDIwKTsKKwkvKiBUZXh0IGN1cnNv
ciBlbmQ6IC0gKi8KKwl2Z2Ffd2NydChjaW5mby0+cmVnYmFzZSwgVkdBX0NSVENfQ1VSU09SX0VO
RCwgMHgwMCk7CisJLyogU2NyZWVuIHN0YXJ0IGFkZHJlc3MgaGlnaDogMCAqLworCXZnYV93Y3J0
KGNpbmZvLT5yZWdiYXNlLCBWR0FfQ1JUQ19TVEFSVF9ISSwgMHgwMCk7CisJLyogU2NyZWVuIHN0
YXJ0IGFkZHJlc3MgbG93OiAwICovCisJdmdhX3djcnQoY2luZm8tPnJlZ2Jhc2UsIFZHQV9DUlRD
X1NUQVJUX0xPLCAweDAwKTsKKwkvKiB0ZXh0IGN1cnNvciBsb2NhdGlvbiBoaWdoOiAwICovCisJ
dmdhX3djcnQoY2luZm8tPnJlZ2Jhc2UsIFZHQV9DUlRDX0NVUlNPUl9ISSwgMHgwMCk7CisJLyog
dGV4dCBjdXJzb3IgbG9jYXRpb24gbG93OiAwICovCisJdmdhX3djcnQoY2luZm8tPnJlZ2Jhc2Us
IFZHQV9DUlRDX0NVUlNPUl9MTywgMHgwMCk7CisKKwkvKiBVbmRlcmxpbmUgUm93IHNjYW5saW5l
OiAtICovCisJdmdhX3djcnQoY2luZm8tPnJlZ2Jhc2UsIFZHQV9DUlRDX1VOREVSTElORSwgMHgw
MCk7CisJLyogbW9kZSBjb250cm9sOiB0aW1pbmcgZW5hYmxlLCBieXRlIG1vZGUsIG5vIGNvbXBh
dCBtb2RlcyAqLworCXZnYV93Y3J0KGNpbmZvLT5yZWdiYXNlLCBWR0FfQ1JUQ19NT0RFLCAweGMz
KTsKKwkvKiBMaW5lIENvbXBhcmU6IG5vdCBuZWVkZWQgKi8KKwl2Z2Ffd2NydChjaW5mby0+cmVn
YmFzZSwgVkdBX0NSVENfTElORV9DT01QQVJFLCAweDAwKTsKIAkvKiAjIyMgYWRkIDB4NDAgZm9y
IHRleHQgbW9kZXMgd2l0aCA+IDMwIE1IeiBwaXhjbG9jayAqLwotCXZnYV93Y3J0IChjaW5mby0+
cmVnYmFzZSwgQ0xfQ1JUMUIsIDB4MDIpOwkvKiBleHQuIGRpc3BsYXkgY29udHJvbHM6IGV4dC5h
ZHIuIHdyYXAgKi8KKwkvKiBleHQuIGRpc3BsYXkgY29udHJvbHM6IGV4dC5hZHIuIHdyYXAgKi8K
Kwl2Z2Ffd2NydChjaW5mby0+cmVnYmFzZSwgQ0xfQ1JUMUIsIDB4MDIpOwogCi0JdmdhX3dnZngg
KGNpbmZvLT5yZWdiYXNlLCBWR0FfR0ZYX1NSX1ZBTFVFLCAweDAwKTsJLyogU2V0L1Jlc2V0IHJl
Z2lzdGVzOiAtICovCi0JdmdhX3dnZnggKGNpbmZvLT5yZWdiYXNlLCBWR0FfR0ZYX1NSX0VOQUJM
RSwgMHgwMCk7CS8qIFNldC9SZXNldCBlbmFibGU6IC0gKi8KLQl2Z2Ffd2dmeCAoY2luZm8tPnJl
Z2Jhc2UsIFZHQV9HRlhfQ09NUEFSRV9WQUxVRSwgMHgwMCk7CS8qIENvbG9yIENvbXBhcmU6IC0g
Ki8KLQl2Z2Ffd2dmeCAoY2luZm8tPnJlZ2Jhc2UsIFZHQV9HRlhfREFUQV9ST1RBVEUsIDB4MDAp
OwkvKiBEYXRhIFJvdGF0ZTogLSAqLwotCXZnYV93Z2Z4IChjaW5mby0+cmVnYmFzZSwgVkdBX0dG
WF9QTEFORV9SRUFELCAweDAwKTsJLyogUmVhZCBNYXAgU2VsZWN0OiAtICovCi0JdmdhX3dnZngg
KGNpbmZvLT5yZWdiYXNlLCBWR0FfR0ZYX01PREUsIDB4MDApOwkvKiBNb2RlOiBjb25mLiBmb3Ig
MTYvNC8yIGNvbG9yIG1vZGUsIG5vIG9kZC9ldmVuLCByZWFkL3dyaXRlIG1vZGUgMCAqLwotCXZn
YV93Z2Z4IChjaW5mby0+cmVnYmFzZSwgVkdBX0dGWF9NSVNDLCAweDAxKTsJLyogTWlzY2VsbGFu
ZW91czogbWVtb3J5IG1hcCBiYXNlIGFkZHJlc3MsIGdyYXBoaWNzIG1vZGUgKi8KLQl2Z2Ffd2dm
eCAoY2luZm8tPnJlZ2Jhc2UsIFZHQV9HRlhfQ09NUEFSRV9NQVNLLCAweDBmKTsJLyogQ29sb3Ig
RG9uJ3QgY2FyZTogaW52b2x2ZSBhbGwgcGxhbmVzICovCi0JdmdhX3dnZnggKGNpbmZvLT5yZWdi
YXNlLCBWR0FfR0ZYX0JJVF9NQVNLLCAweGZmKTsJLyogQml0IE1hc2s6IG5vIG1hc2sgYXQgYWxs
ICovCisJLyogU2V0L1Jlc2V0IHJlZ2lzdGVzOiAtICovCisJdmdhX3dnZngoY2luZm8tPnJlZ2Jh
c2UsIFZHQV9HRlhfU1JfVkFMVUUsIDB4MDApOworCS8qIFNldC9SZXNldCBlbmFibGU6IC0gKi8K
Kwl2Z2Ffd2dmeChjaW5mby0+cmVnYmFzZSwgVkdBX0dGWF9TUl9FTkFCTEUsIDB4MDApOworCS8q
IENvbG9yIENvbXBhcmU6IC0gKi8KKwl2Z2Ffd2dmeChjaW5mby0+cmVnYmFzZSwgVkdBX0dGWF9D
T01QQVJFX1ZBTFVFLCAweDAwKTsKKwkvKiBEYXRhIFJvdGF0ZTogLSAqLworCXZnYV93Z2Z4KGNp
bmZvLT5yZWdiYXNlLCBWR0FfR0ZYX0RBVEFfUk9UQVRFLCAweDAwKTsKKwkvKiBSZWFkIE1hcCBT
ZWxlY3Q6IC0gKi8KKwl2Z2Ffd2dmeChjaW5mby0+cmVnYmFzZSwgVkdBX0dGWF9QTEFORV9SRUFE
LCAweDAwKTsKKwkvKiBNb2RlOiBjb25mLiBmb3IgMTYvNC8yIGNvbG9yIG1vZGUsIG5vIG9kZC9l
dmVuLCByZWFkL3dyaXRlIG1vZGUgMCAqLworCXZnYV93Z2Z4KGNpbmZvLT5yZWdiYXNlLCBWR0Ff
R0ZYX01PREUsIDB4MDApOworCS8qIE1pc2NlbGxhbmVvdXM6IG1lbW9yeSBtYXAgYmFzZSBhZGRy
ZXNzLCBncmFwaGljcyBtb2RlICovCisJdmdhX3dnZngoY2luZm8tPnJlZ2Jhc2UsIFZHQV9HRlhf
TUlTQywgMHgwMSk7CisJLyogQ29sb3IgRG9uJ3QgY2FyZTogaW52b2x2ZSBhbGwgcGxhbmVzICov
CisJdmdhX3dnZngoY2luZm8tPnJlZ2Jhc2UsIFZHQV9HRlhfQ09NUEFSRV9NQVNLLCAweDBmKTsK
KwkvKiBCaXQgTWFzazogbm8gbWFzayBhdCBhbGwgKi8KKwl2Z2Ffd2dmeChjaW5mby0+cmVnYmFz
ZSwgVkdBX0dGWF9CSVRfTUFTSywgMHhmZik7CiAJaWYgKGNpbmZvLT5idHlwZSA9PSBCVF9BTFBJ
TkUpCi0JCXZnYV93Z2Z4IChjaW5mby0+cmVnYmFzZSwgQ0xfR1JCLCAweDIwKTsJLyogKDU0MzQg
Y2FuJ3QgaGF2ZSBiaXQgMyBzZXQgZm9yIGJpdGJsdCkgKi8KKwkJLyogKDU0MzQgY2FuJ3QgaGF2
ZSBiaXQgMyBzZXQgZm9yIGJpdGJsdCkgKi8KKwkJdmdhX3dnZngoY2luZm8tPnJlZ2Jhc2UsIENM
X0dSQiwgMHgyMCk7CiAJZWxzZQotCQl2Z2Ffd2dmeCAoY2luZm8tPnJlZ2Jhc2UsIENMX0dSQiwg
MHgyOCk7CS8qIEdyYXBoaWNzIGNvbnRyb2xsZXIgbW9kZSBleHRlbnNpb25zOiBmaW5lciBncmFu
dWxhcml0eSwgOGJ5dGUgZGF0YSBsYXRjaGVzICovCisJLyogR3JhcGhpY3MgY29udHJvbGxlciBt
b2RlIGV4dGVuc2lvbnM6IGZpbmVyIGdyYW51bGFyaXR5LAorCSAqIDhieXRlIGRhdGEgbGF0Y2hl
cworCSAqLworCQl2Z2Ffd2dmeChjaW5mby0+cmVnYmFzZSwgQ0xfR1JCLCAweDI4KTsKIAotCXZn
YV93Z2Z4IChjaW5mby0+cmVnYmFzZSwgQ0xfR1JDLCAweGZmKTsJLyogQ29sb3IgS2V5IGNvbXBh
cmU6IC0gKi8KLQl2Z2Ffd2dmeCAoY2luZm8tPnJlZ2Jhc2UsIENMX0dSRCwgMHgwMCk7CS8qIENv
bG9yIEtleSBjb21wYXJlIG1hc2s6IC0gKi8KLQl2Z2Ffd2dmeCAoY2luZm8tPnJlZ2Jhc2UsIENM
X0dSRSwgMHgwMCk7CS8qIE1pc2NlbGxhbmVvdXMgY29udHJvbDogLSAqLwotCS8qICB2Z2Ffd2dm
eCAoY2luZm8tPnJlZ2Jhc2UsIENMX0dSMTAsIDB4MDApOyAqLy8qIEJhY2tncm91bmQgY29sb3Ig
Ynl0ZSAxOiAtICovCi0vKiAgdmdhX3dnZnggKGNpbmZvLT5yZWdiYXNlLCBDTF9HUjExLCAweDAw
KTsgKi8KLQotCXZnYV93YXR0ciAoY2luZm8tPnJlZ2Jhc2UsIFZHQV9BVENfUEFMRVRURTAsIDB4
MDApOwkvKiBBdHRyaWJ1dGUgQ29udHJvbGxlciBwYWxldHRlIHJlZ2lzdGVyczogImlkZW50aXR5
IG1hcHBpbmciICovCi0JdmdhX3dhdHRyIChjaW5mby0+cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRF
MSwgMHgwMSk7Ci0JdmdhX3dhdHRyIChjaW5mby0+cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRFMiwg
MHgwMik7Ci0JdmdhX3dhdHRyIChjaW5mby0+cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRFMywgMHgw
Myk7Ci0JdmdhX3dhdHRyIChjaW5mby0+cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRFNCwgMHgwNCk7
Ci0JdmdhX3dhdHRyIChjaW5mby0+cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRFNSwgMHgwNSk7Ci0J
dmdhX3dhdHRyIChjaW5mby0+cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRFNiwgMHgwNik7Ci0Jdmdh
X3dhdHRyIChjaW5mby0+cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRFNywgMHgwNyk7Ci0JdmdhX3dh
dHRyIChjaW5mby0+cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRFOCwgMHgwOCk7Ci0JdmdhX3dhdHRy
IChjaW5mby0+cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRFOSwgMHgwOSk7Ci0JdmdhX3dhdHRyIChj
aW5mby0+cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRFQSwgMHgwYSk7Ci0JdmdhX3dhdHRyIChjaW5m
by0+cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRFQiwgMHgwYik7Ci0JdmdhX3dhdHRyIChjaW5mby0+
cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRFQywgMHgwYyk7Ci0JdmdhX3dhdHRyIChjaW5mby0+cmVn
YmFzZSwgVkdBX0FUQ19QQUxFVFRFRCwgMHgwZCk7Ci0JdmdhX3dhdHRyIChjaW5mby0+cmVnYmFz
ZSwgVkdBX0FUQ19QQUxFVFRFRSwgMHgwZSk7Ci0JdmdhX3dhdHRyIChjaW5mby0+cmVnYmFzZSwg
VkdBX0FUQ19QQUxFVFRFRiwgMHgwZik7Ci0KLQl2Z2Ffd2F0dHIgKGNpbmZvLT5yZWdiYXNlLCBW
R0FfQVRDX01PREUsIDB4MDEpOwkvKiBBdHRyaWJ1dGUgQ29udHJvbGxlciBtb2RlOiBncmFwaGlj
cyBtb2RlICovCi0JdmdhX3dhdHRyIChjaW5mby0+cmVnYmFzZSwgVkdBX0FUQ19PVkVSU0NBTiwg
MHgwMCk7CS8qIE92ZXJzY2FuIGNvbG9yIHJlZy46IHJlZy4gMCAqLwotCXZnYV93YXR0ciAoY2lu
Zm8tPnJlZ2Jhc2UsIFZHQV9BVENfUExBTkVfRU5BQkxFLCAweDBmKTsJLyogQ29sb3IgUGxhbmUg
ZW5hYmxlOiBFbmFibGUgYWxsIDQgcGxhbmVzICovCi0vKiAjIyMgIHZnYV93YXR0ciAoY2luZm8t
PnJlZ2Jhc2UsIENMX0FSMzMsIDB4MDApOyAqIFBpeGVsIFBhbm5pbmc6IC0gKi8KLQl2Z2Ffd2F0
dHIgKGNpbmZvLT5yZWdiYXNlLCBWR0FfQVRDX0NPTE9SX1BBR0UsIDB4MDApOwkvKiBDb2xvciBT
ZWxlY3Q6IC0gKi8KKwl2Z2Ffd2dmeChjaW5mby0+cmVnYmFzZSwgQ0xfR1JDLCAweGZmKTsJLyog
Q29sb3IgS2V5IGNvbXBhcmU6IC0gKi8KKwl2Z2Ffd2dmeChjaW5mby0+cmVnYmFzZSwgQ0xfR1JE
LCAweDAwKTsJLyogQ29sb3IgS2V5IGNvbXBhcmUgbWFzazogLSAqLworCXZnYV93Z2Z4KGNpbmZv
LT5yZWdiYXNlLCBDTF9HUkUsIDB4MDApOwkvKiBNaXNjZWxsYW5lb3VzIGNvbnRyb2w6IC0gKi8K
KwkvKiBCYWNrZ3JvdW5kIGNvbG9yIGJ5dGUgMTogLSAqLworCS8qICB2Z2Ffd2dmeCAoY2luZm8t
PnJlZ2Jhc2UsIENMX0dSMTAsIDB4MDApOyAqLworCS8qICB2Z2Ffd2dmeCAoY2luZm8tPnJlZ2Jh
c2UsIENMX0dSMTEsIDB4MDApOyAqLworCisJLyogQXR0cmlidXRlIENvbnRyb2xsZXIgcGFsZXR0
ZSByZWdpc3RlcnM6ICJpZGVudGl0eSBtYXBwaW5nIiAqLworCXZnYV93YXR0cihjaW5mby0+cmVn
YmFzZSwgVkdBX0FUQ19QQUxFVFRFMCwgMHgwMCk7CisJdmdhX3dhdHRyKGNpbmZvLT5yZWdiYXNl
LCBWR0FfQVRDX1BBTEVUVEUxLCAweDAxKTsKKwl2Z2Ffd2F0dHIoY2luZm8tPnJlZ2Jhc2UsIFZH
QV9BVENfUEFMRVRURTIsIDB4MDIpOworCXZnYV93YXR0cihjaW5mby0+cmVnYmFzZSwgVkdBX0FU
Q19QQUxFVFRFMywgMHgwMyk7CisJdmdhX3dhdHRyKGNpbmZvLT5yZWdiYXNlLCBWR0FfQVRDX1BB
TEVUVEU0LCAweDA0KTsKKwl2Z2Ffd2F0dHIoY2luZm8tPnJlZ2Jhc2UsIFZHQV9BVENfUEFMRVRU
RTUsIDB4MDUpOworCXZnYV93YXR0cihjaW5mby0+cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRFNiwg
MHgwNik7CisJdmdhX3dhdHRyKGNpbmZvLT5yZWdiYXNlLCBWR0FfQVRDX1BBTEVUVEU3LCAweDA3
KTsKKwl2Z2Ffd2F0dHIoY2luZm8tPnJlZ2Jhc2UsIFZHQV9BVENfUEFMRVRURTgsIDB4MDgpOwor
CXZnYV93YXR0cihjaW5mby0+cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRFOSwgMHgwOSk7CisJdmdh
X3dhdHRyKGNpbmZvLT5yZWdiYXNlLCBWR0FfQVRDX1BBTEVUVEVBLCAweDBhKTsKKwl2Z2Ffd2F0
dHIoY2luZm8tPnJlZ2Jhc2UsIFZHQV9BVENfUEFMRVRURUIsIDB4MGIpOworCXZnYV93YXR0cihj
aW5mby0+cmVnYmFzZSwgVkdBX0FUQ19QQUxFVFRFQywgMHgwYyk7CisJdmdhX3dhdHRyKGNpbmZv
LT5yZWdiYXNlLCBWR0FfQVRDX1BBTEVUVEVELCAweDBkKTsKKwl2Z2Ffd2F0dHIoY2luZm8tPnJl
Z2Jhc2UsIFZHQV9BVENfUEFMRVRURUUsIDB4MGUpOworCXZnYV93YXR0cihjaW5mby0+cmVnYmFz
ZSwgVkdBX0FUQ19QQUxFVFRFRiwgMHgwZik7CisKKwkvKiBBdHRyaWJ1dGUgQ29udHJvbGxlciBt
b2RlOiBncmFwaGljcyBtb2RlICovCisJdmdhX3dhdHRyKGNpbmZvLT5yZWdiYXNlLCBWR0FfQVRD
X01PREUsIDB4MDEpOworCS8qIE92ZXJzY2FuIGNvbG9yIHJlZy46IHJlZy4gMCAqLworCXZnYV93
YXR0cihjaW5mby0+cmVnYmFzZSwgVkdBX0FUQ19PVkVSU0NBTiwgMHgwMCk7CisJLyogQ29sb3Ig
UGxhbmUgZW5hYmxlOiBFbmFibGUgYWxsIDQgcGxhbmVzICovCisJdmdhX3dhdHRyKGNpbmZvLT5y
ZWdiYXNlLCBWR0FfQVRDX1BMQU5FX0VOQUJMRSwgMHgwZik7CisvKiAjIyMgIHZnYV93YXR0cihj
aW5mby0+cmVnYmFzZSwgQ0xfQVIzMywgMHgwMCk7ICogUGl4ZWwgUGFubmluZzogLSAqLworCS8q
IENvbG9yIFNlbGVjdDogLSAqLworCXZnYV93YXR0cihjaW5mby0+cmVnYmFzZSwgVkdBX0FUQ19D
T0xPUl9QQUdFLCAweDAwKTsKIAotCVdHZW4gKGNpbmZvLCBWR0FfUEVMX01TSywgMHhmZik7CS8q
IFBpeGVsIG1hc2s6IG5vIG1hc2sgKi8KKwlXR2VuKGNpbmZvLCBWR0FfUEVMX01TSywgMHhmZik7
CS8qIFBpeGVsIG1hc2s6IG5vIG1hc2sgKi8KIAogCWlmIChjaW5mby0+YnR5cGUgIT0gQlRfQUxQ
SU5FICYmIGNpbmZvLT5idHlwZSAhPSBCVF9HRDU0ODApCi0JCVdHZW4gKGNpbmZvLCBWR0FfTUlT
X1csIDB4YzMpOwkvKiBwb2xhcml0eSAoLS8tKSwgZW5hYmxlIGRpc3BsYXkgbWVtLCBWR0FfQ1JU
Q19TVEFSVF9ISSBpL28gYmFzZSA9IGNvbG9yICovCisJLyogcG9sYXJpdHkgKC0vLSksIGVuYWJs
ZSBkaXNwbGF5IG1lbSwKKwkgKiBWR0FfQ1JUQ19TVEFSVF9ISSBpL28gYmFzZSA9IGNvbG9yCisJ
ICovCisJCVdHZW4oY2luZm8sIFZHQV9NSVNfVywgMHhjMyk7CiAKLQl2Z2Ffd2dmeCAoY2luZm8t
PnJlZ2Jhc2UsIENMX0dSMzEsIDB4MDQpOwkvKiBCTFQgU3RhcnQvc3RhdHVzOiBCbGl0dGVyIHJl
c2V0ICovCi0JdmdhX3dnZnggKGNpbmZvLT5yZWdiYXNlLCBDTF9HUjMxLCAweDAwKTsJLyogLSAi
IC0gICAgICAgICAgIDogImVuZC1vZi1yZXNldCIgKi8KKwkvKiBCTFQgU3RhcnQvc3RhdHVzOiBC
bGl0dGVyIHJlc2V0ICovCisJdmdhX3dnZngoY2luZm8tPnJlZ2Jhc2UsIENMX0dSMzEsIDB4MDQp
OworCS8qIC0gIiAtCSAgIDogImVuZC1vZi1yZXNldCIgKi8KKwl2Z2Ffd2dmeChjaW5mby0+cmVn
YmFzZSwgQ0xfR1IzMSwgMHgwMCk7CiAKIAkvKiBtaXNjLi4uICovCi0JV0hEUiAoY2luZm8sIDAp
OwkvKiBIaWRkZW4gREFDIHJlZ2lzdGVyOiAtICovCisJV0hEUihjaW5mbywgMCk7CS8qIEhpZGRl
biBEQUMgcmVnaXN0ZXI6IC0gKi8KIAotCXByaW50ayAoS0VSTl9ERUJVRyAiY2lycnVzZmI6IFRo
aXMgYm9hcmQgaGFzICVsZCBieXRlcyBvZiBEUkFNIG1lbW9yeVxuIiwgY2luZm8tPnNpemUpOwot
CURQUklOVEsgKCJFWElUXG4iKTsKKwlwcmludGsoS0VSTl9ERUJVRyAiY2lycnVzZmI6IFRoaXMg
Ym9hcmQgaGFzICVsZCBieXRlcyBvZiBEUkFNIG1lbW9yeVxuIiwKKwkJY2luZm8tPnNpemUpOwor
CURQUklOVEsoIkVYSVRcbiIpOwogCXJldHVybjsKIH0KIAotc3RhdGljIHZvaWQgc3dpdGNoX21v
bml0b3IgKHN0cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbywgaW50IG9uKQorc3RhdGljIHZvaWQg
c3dpdGNoX21vbml0b3Ioc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvLCBpbnQgb24pCiB7CiAj
aWZkZWYgQ09ORklHX1pPUlJPIC8qIG9ubHkgd29ya3Mgb24gWm9ycm8gYm9hcmRzICovCiAJc3Rh
dGljIGludCBJc09uID0gMDsJLyogWFhYIG5vdCBvayBmb3IgbXVsdGlwbGUgYm9hcmRzICovCiAK
LQlEUFJJTlRLICgiRU5URVJcbiIpOworCURQUklOVEsoIkVOVEVSXG4iKTsKIAogCWlmIChjaW5m
by0+YnR5cGUgPT0gQlRfUElDQVNTTzQpCiAJCXJldHVybjsJCS8qIG5vdGhpbmcgdG8gc3dpdGNo
ICovCkBAIC0xOTYzLDQ0ICsyMTA5LDQzIEBAIHN0YXRpYyB2b2lkIHN3aXRjaF9tb25pdG9yIChz
dHJ1Y3QgY2lycnUKIAkJcmV0dXJuOwkJLyogbm90aGluZyB0byBzd2l0Y2ggKi8KIAlpZiAoY2lu
Zm8tPmJ0eXBlID09IEJUX1BJQ0FTU08pIHsKIAkJaWYgKChvbiAmJiAhSXNPbikgfHwgKCFvbiAm
JiBJc09uKSkKLQkJCVdTRlIgKGNpbmZvLCAweGZmKTsKKwkJCVdTRlIoY2luZm8sIDB4ZmYpOwog
Ci0JCURQUklOVEsgKCJFWElUXG4iKTsKKwkJRFBSSU5USygiRVhJVFxuIik7CiAJCXJldHVybjsK
IAl9CiAJaWYgKG9uKSB7CiAJCXN3aXRjaCAoY2luZm8tPmJ0eXBlKSB7CiAJCWNhc2UgQlRfU0Q2
NDoKLQkJCVdTRlIgKGNpbmZvLCBjaW5mby0+U0ZSIHwgMHgyMSk7CisJCQlXU0ZSKGNpbmZvLCBj
aW5mby0+U0ZSIHwgMHgyMSk7CiAJCQlicmVhazsKIAkJY2FzZSBCVF9QSUNDT0xPOgotCQkJV1NG
UiAoY2luZm8sIGNpbmZvLT5TRlIgfCAweDI4KTsKKwkJCVdTRlIoY2luZm8sIGNpbmZvLT5TRlIg
fCAweDI4KTsKIAkJCWJyZWFrOwogCQljYXNlIEJUX1NQRUNUUlVNOgotCQkJV1NGUiAoY2luZm8s
IDB4NmYpOworCQkJV1NGUihjaW5mbywgMHg2Zik7CiAJCQlicmVhazsKIAkJZGVmYXVsdDogLyog
ZG8gbm90aGluZyAqLyBicmVhazsKIAkJfQogCX0gZWxzZSB7CiAJCXN3aXRjaCAoY2luZm8tPmJ0
eXBlKSB7CiAJCWNhc2UgQlRfU0Q2NDoKLQkJCVdTRlIgKGNpbmZvLCBjaW5mby0+U0ZSICYgMHhk
ZSk7CisJCQlXU0ZSKGNpbmZvLCBjaW5mby0+U0ZSICYgMHhkZSk7CiAJCQlicmVhazsKIAkJY2Fz
ZSBCVF9QSUNDT0xPOgotCQkJV1NGUiAoY2luZm8sIGNpbmZvLT5TRlIgJiAweGQ3KTsKKwkJCVdT
RlIoY2luZm8sIGNpbmZvLT5TRlIgJiAweGQ3KTsKIAkJCWJyZWFrOwogCQljYXNlIEJUX1NQRUNU
UlVNOgotCQkJV1NGUiAoY2luZm8sIDB4NGYpOworCQkJV1NGUihjaW5mbywgMHg0Zik7CiAJCQli
cmVhazsKIAkJZGVmYXVsdDogLyogZG8gbm90aGluZyAqLyBicmVhazsKIAkJfQogCX0KIAotCURQ
UklOVEsgKCJFWElUXG4iKTsKKwlEUFJJTlRLKCJFWElUXG4iKTsKICNlbmRpZiAvKiBDT05GSUdf
Wk9SUk8gKi8KIH0KIAotCiAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqLwogLyogTGludXggMi42LXN0eWxlICBhY2NlbGVyYXRlZCBmdW5jdGlvbnMgKi8KIC8qKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCkBAIC0yMDEyLDE1ICsyMTU3
LDE3IEBAIHN0YXRpYyB2b2lkIGNpcnJ1c2ZiX3ByaW1fZmlsbHJlY3Qoc3RydWMKIAl1MzIgY29s
b3IgPSAoY2luZm8tPmluZm8tPmZpeC52aXN1YWwgPT0gRkJfVklTVUFMX1RSVUVDT0xPUikgPwog
CQljaW5mby0+cHNldWRvX3BhbGV0dGVbcmVnaW9uLT5jb2xvcl0gOiByZWdpb24tPmNvbG9yOwog
Ci0JaWYoY2luZm8tPmluZm8tPnZhci5iaXRzX3Blcl9waXhlbCA9PSAxKSB7Ci0JCWNpcnJ1c2Zi
X1JlY3RGaWxsKGNpbmZvLT5yZWdiYXNlLCBjaW5mby0+aW5mby0+dmFyLmJpdHNfcGVyX3BpeGVs
LAorCWlmIChjaW5mby0+aW5mby0+dmFyLmJpdHNfcGVyX3BpeGVsID09IDEpIHsKKwkJY2lycnVz
ZmJfUmVjdEZpbGwoY2luZm8tPnJlZ2Jhc2UsCisJCQkJICBjaW5mby0+aW5mby0+dmFyLmJpdHNf
cGVyX3BpeGVsLAogCQkJCSAgcmVnaW9uLT5keCAvIDgsIHJlZ2lvbi0+ZHksCiAJCQkJICByZWdp
b24tPndpZHRoIC8gOCwgcmVnaW9uLT5oZWlnaHQsCiAJCQkJICBjb2xvciwKIAkJCQkgIGNpbmZv
LT5jdXJyZW50bW9kZS5saW5lX2xlbmd0aCk7CiAJfSBlbHNlIHsKLQkJbSA9ICggY2luZm8tPmlu
Zm8tPnZhci5iaXRzX3Blcl9waXhlbCArIDcgKSAvIDg7Ci0JCWNpcnJ1c2ZiX1JlY3RGaWxsKGNp
bmZvLT5yZWdiYXNlLCBjaW5mby0+aW5mby0+dmFyLmJpdHNfcGVyX3BpeGVsLAorCQltID0gKGNp
bmZvLT5pbmZvLT52YXIuYml0c19wZXJfcGl4ZWwgKyA3KSAvIDg7CisJCWNpcnJ1c2ZiX1JlY3RG
aWxsKGNpbmZvLT5yZWdiYXNlLAorCQkJCSAgY2luZm8tPmluZm8tPnZhci5iaXRzX3Blcl9waXhl
bCwKIAkJCQkgIHJlZ2lvbi0+ZHggKiBtLCByZWdpb24tPmR5LAogCQkJCSAgcmVnaW9uLT53aWR0
aCAqIG0sIHJlZ2lvbi0+aGVpZ2h0LAogCQkJCSAgY29sb3IsCkBAIC0yMDI5LDcgKzIxNzYsOCBA
QCBzdGF0aWMgdm9pZCBjaXJydXNmYl9wcmltX2ZpbGxyZWN0KHN0cnVjCiAJcmV0dXJuOwogfQog
Ci1zdGF0aWMgdm9pZCBjaXJydXNmYl9maWxscmVjdCAoc3RydWN0IGZiX2luZm8gKmluZm8sIGNv
bnN0IHN0cnVjdCBmYl9maWxscmVjdCAqcmVnaW9uKQorc3RhdGljIHZvaWQgY2lycnVzZmJfZmls
bHJlY3Qoc3RydWN0IGZiX2luZm8gKmluZm8sCisJCQkgICAgICBjb25zdCBzdHJ1Y3QgZmJfZmls
bHJlY3QgKnJlZ2lvbikKIHsKIAlzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8gPSBpbmZvLT5w
YXI7CiAJc3RydWN0IGZiX2ZpbGxyZWN0IG1vZGRlZDsKQEAgLTIwNDcsMTIgKzIxOTUsMTQgQEAg
c3RhdGljIHZvaWQgY2lycnVzZmJfZmlsbHJlY3QgKHN0cnVjdCBmYgogCiAJbWVtY3B5KCZtb2Rk
ZWQsIHJlZ2lvbiwgc2l6ZW9mKHN0cnVjdCBmYl9maWxscmVjdCkpOwogCi0JaWYoIW1vZGRlZC53
aWR0aCB8fCAhbW9kZGVkLmhlaWdodCB8fAorCWlmICghbW9kZGVkLndpZHRoIHx8ICFtb2RkZWQu
aGVpZ2h0IHx8CiAJICAgbW9kZGVkLmR4ID49IHZ4cmVzIHx8IG1vZGRlZC5keSA+PSB2eXJlcykK
IAkJcmV0dXJuOwogCi0JaWYobW9kZGVkLmR4ICsgbW9kZGVkLndpZHRoICA+IHZ4cmVzKSBtb2Rk
ZWQud2lkdGggID0gdnhyZXMgLSBtb2RkZWQuZHg7Ci0JaWYobW9kZGVkLmR5ICsgbW9kZGVkLmhl
aWdodCA+IHZ5cmVzKSBtb2RkZWQuaGVpZ2h0ID0gdnlyZXMgLSBtb2RkZWQuZHk7CisJaWYgKG1v
ZGRlZC5keCArIG1vZGRlZC53aWR0aCAgPiB2eHJlcykKKwkJbW9kZGVkLndpZHRoICA9IHZ4cmVz
IC0gbW9kZGVkLmR4OworCWlmIChtb2RkZWQuZHkgKyBtb2RkZWQuaGVpZ2h0ID4gdnlyZXMpCisJ
CW1vZGRlZC5oZWlnaHQgPSB2eXJlcyAtIG1vZGRlZC5keTsKIAogCWNpcnJ1c2ZiX3ByaW1fZmls
bHJlY3QoY2luZm8sICZtb2RkZWQpOwogfQpAQCAtMjA2MSwxNCArMjIxMSwxNCBAQCBzdGF0aWMg
dm9pZCBjaXJydXNmYl9wcmltX2NvcHlhcmVhKHN0cnVjCiAJCQkJICAgY29uc3Qgc3RydWN0IGZi
X2NvcHlhcmVhICphcmVhKQogewogCWludCBtOyAvKiBieXRlcyBwZXIgcGl4ZWwgKi8KLQlpZihj
aW5mby0+aW5mby0+dmFyLmJpdHNfcGVyX3BpeGVsID09IDEpIHsKKwlpZiAoY2luZm8tPmluZm8t
PnZhci5iaXRzX3Blcl9waXhlbCA9PSAxKSB7CiAJCWNpcnJ1c2ZiX0JpdEJMVChjaW5mby0+cmVn
YmFzZSwgY2luZm8tPmluZm8tPnZhci5iaXRzX3Blcl9waXhlbCwKIAkJCQlhcmVhLT5zeCAvIDgs
IGFyZWEtPnN5LAogCQkJCWFyZWEtPmR4IC8gOCwgYXJlYS0+ZHksCiAJCQkJYXJlYS0+d2lkdGgg
LyA4LCBhcmVhLT5oZWlnaHQsCiAJCQkJY2luZm8tPmN1cnJlbnRtb2RlLmxpbmVfbGVuZ3RoKTsK
IAl9IGVsc2UgewotCQltID0gKCBjaW5mby0+aW5mby0+dmFyLmJpdHNfcGVyX3BpeGVsICsgNyAp
IC8gODsKKwkJbSA9IChjaW5mby0+aW5mby0+dmFyLmJpdHNfcGVyX3BpeGVsICsgNykgLyA4Owog
CQljaXJydXNmYl9CaXRCTFQoY2luZm8tPnJlZ2Jhc2UsIGNpbmZvLT5pbmZvLT52YXIuYml0c19w
ZXJfcGl4ZWwsCiAJCQkJYXJlYS0+c3ggKiBtLCBhcmVhLT5zeSwKIAkJCQlhcmVhLT5keCAqIG0s
IGFyZWEtPmR5LApAQCAtMjA3OCw4ICsyMjI4LDggQEAgc3RhdGljIHZvaWQgY2lycnVzZmJfcHJp
bV9jb3B5YXJlYShzdHJ1YwogCXJldHVybjsKIH0KIAotCi1zdGF0aWMgdm9pZCBjaXJydXNmYl9j
b3B5YXJlYShzdHJ1Y3QgZmJfaW5mbyAqaW5mbywgY29uc3Qgc3RydWN0IGZiX2NvcHlhcmVhICph
cmVhKQorc3RhdGljIHZvaWQgY2lycnVzZmJfY29weWFyZWEoc3RydWN0IGZiX2luZm8gKmluZm8s
CisJCQkgICAgICBjb25zdCBzdHJ1Y3QgZmJfY29weWFyZWEgKmFyZWEpCiB7CiAJc3RydWN0IGNp
cnJ1c2ZiX2luZm8gKmNpbmZvID0gaW5mby0+cGFyOwogCXN0cnVjdCBmYl9jb3B5YXJlYSBtb2Rk
ZWQ7CkBAIC0yMTAxLDg5ICsyMjUxLDk5IEBAIHN0YXRpYyB2b2lkIGNpcnJ1c2ZiX2NvcHlhcmVh
KHN0cnVjdCBmYl8KIAl2eHJlcyA9IGluZm8tPnZhci54cmVzX3ZpcnR1YWw7CiAJdnlyZXMgPSBp
bmZvLT52YXIueXJlc192aXJ0dWFsOwogCi0JaWYoIW1vZGRlZC53aWR0aCB8fCAhbW9kZGVkLmhl
aWdodCB8fAorCWlmICghbW9kZGVkLndpZHRoIHx8ICFtb2RkZWQuaGVpZ2h0IHx8CiAJICAgbW9k
ZGVkLnN4ID49IHZ4cmVzIHx8IG1vZGRlZC5zeSA+PSB2eXJlcyB8fAogCSAgIG1vZGRlZC5keCA+
PSB2eHJlcyB8fCBtb2RkZWQuZHkgPj0gdnlyZXMpCiAJCXJldHVybjsKIAotCWlmKG1vZGRlZC5z
eCArIG1vZGRlZC53aWR0aCA+IHZ4cmVzKSAgbW9kZGVkLndpZHRoID0gdnhyZXMgLSBtb2RkZWQu
c3g7Ci0JaWYobW9kZGVkLmR4ICsgbW9kZGVkLndpZHRoID4gdnhyZXMpICBtb2RkZWQud2lkdGgg
PSB2eHJlcyAtIG1vZGRlZC5keDsKLQlpZihtb2RkZWQuc3kgKyBtb2RkZWQuaGVpZ2h0ID4gdnly
ZXMpIG1vZGRlZC5oZWlnaHQgPSB2eXJlcyAtIG1vZGRlZC5zeTsKLQlpZihtb2RkZWQuZHkgKyBt
b2RkZWQuaGVpZ2h0ID4gdnlyZXMpIG1vZGRlZC5oZWlnaHQgPSB2eXJlcyAtIG1vZGRlZC5keTsK
KwlpZiAobW9kZGVkLnN4ICsgbW9kZGVkLndpZHRoID4gdnhyZXMpCisJCW1vZGRlZC53aWR0aCA9
IHZ4cmVzIC0gbW9kZGVkLnN4OworCWlmIChtb2RkZWQuZHggKyBtb2RkZWQud2lkdGggPiB2eHJl
cykKKwkJbW9kZGVkLndpZHRoID0gdnhyZXMgLSBtb2RkZWQuZHg7CisJaWYgKG1vZGRlZC5zeSAr
IG1vZGRlZC5oZWlnaHQgPiB2eXJlcykKKwkJbW9kZGVkLmhlaWdodCA9IHZ5cmVzIC0gbW9kZGVk
LnN5OworCWlmIChtb2RkZWQuZHkgKyBtb2RkZWQuaGVpZ2h0ID4gdnlyZXMpCisJCW1vZGRlZC5o
ZWlnaHQgPSB2eXJlcyAtIG1vZGRlZC5keTsKIAogCWNpcnJ1c2ZiX3ByaW1fY29weWFyZWEoY2lu
Zm8sICZtb2RkZWQpOwogfQogCi1zdGF0aWMgdm9pZCBjaXJydXNmYl9pbWFnZWJsaXQoc3RydWN0
IGZiX2luZm8gKmluZm8sIGNvbnN0IHN0cnVjdCBmYl9pbWFnZSAqaW1hZ2UpCitzdGF0aWMgdm9p
ZCBjaXJydXNmYl9pbWFnZWJsaXQoc3RydWN0IGZiX2luZm8gKmluZm8sCisJCQkgICAgICAgY29u
c3Qgc3RydWN0IGZiX2ltYWdlICppbWFnZSkKIHsKIAlzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2lu
Zm8gPSBpbmZvLT5wYXI7CiAKLSAgICAgICAgY2lycnVzZmJfV2FpdEJMVChjaW5mby0+cmVnYmFz
ZSk7CisJY2lycnVzZmJfV2FpdEJMVChjaW5mby0+cmVnYmFzZSk7CiAJY2ZiX2ltYWdlYmxpdChp
bmZvLCBpbWFnZSk7CiB9CiAKLQogI2lmZGVmIENPTkZJR19QUENfUFJFUAogI2RlZmluZSBQUkVQ
X1ZJREVPX0JBU0UgKCh2b2xhdGlsZSB1bnNpZ25lZCBsb25nKSAweEMwMDAwMDAwKQogI2RlZmlu
ZSBQUkVQX0lPX0JBU0UgICAgKCh2b2xhdGlsZSB1bnNpZ25lZCBjaGFyICopIDB4ODAwMDAwMDAp
Ci1zdGF0aWMgdm9pZCBnZXRfcHJlcF9hZGRycyAodW5zaWduZWQgbG9uZyAqZGlzcGxheSwgdW5z
aWduZWQgbG9uZyAqcmVnaXN0ZXJzKQorc3RhdGljIHZvaWQgZ2V0X3ByZXBfYWRkcnModW5zaWdu
ZWQgbG9uZyAqZGlzcGxheSwgdW5zaWduZWQgbG9uZyAqcmVnaXN0ZXJzKQogewotCURQUklOVEsg
KCJFTlRFUlxuIik7CisJRFBSSU5USygiRU5URVJcbiIpOwogCiAJKmRpc3BsYXkgPSBQUkVQX1ZJ
REVPX0JBU0U7CiAJKnJlZ2lzdGVycyA9ICh1bnNpZ25lZCBsb25nKSBQUkVQX0lPX0JBU0U7CiAK
LQlEUFJJTlRLICgiRVhJVFxuIik7CisJRFBSSU5USygiRVhJVFxuIik7CiB9CiAKICNlbmRpZgkJ
CQkvKiBDT05GSUdfUFBDX1BSRVAgKi8KIAotCiAjaWZkZWYgQ09ORklHX1BDSQotc3RhdGljIGlu
dCByZWxlYXNlX2lvX3BvcnRzID0gMDsKK3N0YXRpYyBpbnQgcmVsZWFzZV9pb19wb3J0czsKIAog
LyogUHVsbGVkIHRoZSBsb2dpYyBmcm9tIFhGcmVlODYgQ2lycnVzIGRyaXZlciB0byBnZXQgdGhl
IG1lbW9yeSBzaXplLAogICogYmFzZWQgb24gdGhlIERSQU0gYmFuZHdpZHRoIGJpdCBhbmQgRFJB
TSBiYW5rIHN3aXRjaGluZyBiaXQuICBUaGlzCiAgKiB3b3JrcyB3aXRoIDFNQiwgMk1CIGFuZCA0
TUIgY29uZmlndXJhdGlvbnMgKHdoaWNoIHRoZSBNb3Rvcm9sYSBib2FyZHMKICAqIHNlZW0gdG8g
aGF2ZS4gKi8KLXN0YXRpYyB1bnNpZ25lZCBpbnQgY2lycnVzZmJfZ2V0X21lbXNpemUgKHU4IF9f
aW9tZW0gKnJlZ2Jhc2UpCitzdGF0aWMgdW5zaWduZWQgaW50IGNpcnJ1c2ZiX2dldF9tZW1zaXpl
KHU4IF9faW9tZW0gKnJlZ2Jhc2UpCiB7CiAJdW5zaWduZWQgbG9uZyBtZW07CiAJdW5zaWduZWQg
Y2hhciBTUkY7CiAKLQlEUFJJTlRLICgiRU5URVJcbiIpOworCURQUklOVEsoIkVOVEVSXG4iKTsK
IAotCVNSRiA9IHZnYV9yc2VxIChyZWdiYXNlLCBDTF9TRVFSRik7CisJU1JGID0gdmdhX3JzZXEo
cmVnYmFzZSwgQ0xfU0VRUkYpOwogCXN3aXRjaCAoKFNSRiAmIDB4MTgpKSB7Ci0JICAgIGNhc2Ug
MHgwODogbWVtID0gNTEyICogMTAyNDsgYnJlYWs7Ci0JICAgIGNhc2UgMHgxMDogbWVtID0gMTAy
NCAqIDEwMjQ7IGJyZWFrOwotCQkvKiA2NC1iaXQgRFJBTSBkYXRhIGJ1cyB3aWR0aDsgYXNzdW1l
IDJNQi4gQWxzbyBpbmRpY2F0ZXMgMk1CIG1lbW9yeQotCQkgICAqIG9uIHRoZSA1NDMwLiAqLwot
CSAgICBjYXNlIDB4MTg6IG1lbSA9IDIwNDggKiAxMDI0OyBicmVhazsKLQkgICAgZGVmYXVsdDog
cHJpbnRrICgiQ0xnZW5mYjogVW5rbm93biBtZW1vcnkgc2l6ZSFcbiIpOworCWNhc2UgMHgwODoK
KwkJbWVtID0gNTEyICogMTAyNDsKKwkJYnJlYWs7CisJY2FzZSAweDEwOgorCQltZW0gPSAxMDI0
ICogMTAyNDsKKwkJYnJlYWs7CisJLyogNjQtYml0IERSQU0gZGF0YSBidXMgd2lkdGg7IGFzc3Vt
ZSAyTUIuIEFsc28gaW5kaWNhdGVzIDJNQiBtZW1vcnkKKwkgKiBvbiB0aGUgNTQzMC4KKwkgKi8K
KwljYXNlIDB4MTg6CisJCW1lbSA9IDIwNDggKiAxMDI0OworCQlicmVhazsKKwlkZWZhdWx0Ogor
CQlwcmludGsoS0VSTl9XQVJOSU5HICJDTGdlbmZiOiBVbmtub3duIG1lbW9yeSBzaXplIVxuIik7
CiAJCW1lbSA9IDEwMjQgKiAxMDI0OwogCX0KLQlpZiAoU1JGICYgMHg4MCkgewotCQkvKiBJZiBE
UkFNIGJhbmsgc3dpdGNoaW5nIGlzIGVuYWJsZWQsIHRoZXJlIG11c3QgYmUgdHdpY2UgYXMgbXVj
aAotCQkgICAqIG1lbW9yeSBpbnN0YWxsZWQuICg0TUIgb24gdGhlIDU0MzQpICovCisJaWYgKFNS
RiAmIDB4ODApCisJLyogSWYgRFJBTSBiYW5rIHN3aXRjaGluZyBpcyBlbmFibGVkLCB0aGVyZSBt
dXN0IGJlIHR3aWNlIGFzIG11Y2gKKwkgKiBtZW1vcnkgaW5zdGFsbGVkLiAoNE1CIG9uIHRoZSA1
NDM0KQorCSAqLwogCQltZW0gKj0gMjsKLQl9CisKIAkvKiBUT0RPOiBIYW5kbGluZyBvZiBHRDU0
NDYvNTQ4MCAoc2VlIFhGODYgc291cmNlcyAuLi4pICovCiAKLQlEUFJJTlRLICgiRVhJVFxuIik7
CisJRFBSSU5USygiRVhJVFxuIik7CiAJcmV0dXJuIG1lbTsKIH0KIAotCi0KLXN0YXRpYyB2b2lk
IGdldF9wY2lfYWRkcnMgKGNvbnN0IHN0cnVjdCBwY2lfZGV2ICpwZGV2LAotCQkJICAgdW5zaWdu
ZWQgbG9uZyAqZGlzcGxheSwgdW5zaWduZWQgbG9uZyAqcmVnaXN0ZXJzKQorc3RhdGljIHZvaWQg
Z2V0X3BjaV9hZGRycyhjb25zdCBzdHJ1Y3QgcGNpX2RldiAqcGRldiwKKwkJCSAgdW5zaWduZWQg
bG9uZyAqZGlzcGxheSwgdW5zaWduZWQgbG9uZyAqcmVnaXN0ZXJzKQogewotCWFzc2VydCAocGRl
diAhPSBOVUxMKTsKLQlhc3NlcnQgKGRpc3BsYXkgIT0gTlVMTCk7Ci0JYXNzZXJ0IChyZWdpc3Rl
cnMgIT0gTlVMTCk7CisJYXNzZXJ0KHBkZXYgIT0gTlVMTCk7CisJYXNzZXJ0KGRpc3BsYXkgIT0g
TlVMTCk7CisJYXNzZXJ0KHJlZ2lzdGVycyAhPSBOVUxMKTsKIAotCURQUklOVEsgKCJFTlRFUlxu
Iik7CisJRFBSSU5USygiRU5URVJcbiIpOwogCiAJKmRpc3BsYXkgPSAwOwogCSpyZWdpc3RlcnMg
PSAwOwpAQCAtMjE5OCwxMyArMjM1OCwxMiBAQCBzdGF0aWMgdm9pZCBnZXRfcGNpX2FkZHJzIChj
b25zdCBzdHJ1Y3QgCiAJCSpyZWdpc3RlcnMgPSBwY2lfcmVzb3VyY2Vfc3RhcnQocGRldiwgMSk7
CiAJfQogCi0JYXNzZXJ0ICgqZGlzcGxheSAhPSAwKTsKKwlhc3NlcnQoKmRpc3BsYXkgIT0gMCk7
CiAKLQlEUFJJTlRLICgiRVhJVFxuIik7CisJRFBSSU5USygiRVhJVFxuIik7CiB9CiAKLQotc3Rh
dGljIHZvaWQgY2lycnVzZmJfcGNpX3VubWFwIChzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8p
CitzdGF0aWMgdm9pZCBjaXJydXNmYl9wY2lfdW5tYXAoc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNp
bmZvKQogewogCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gY2luZm8tPnBkZXY7CiAKQEAgLTIyMTks
MTkgKzIzNzgsMTggQEAgc3RhdGljIHZvaWQgY2lycnVzZmJfcGNpX3VubWFwIChzdHJ1Y3QgYwog
fQogI2VuZGlmIC8qIENPTkZJR19QQ0kgKi8KIAotCiAjaWZkZWYgQ09ORklHX1pPUlJPCi1zdGF0
aWMgdm9pZCBfX2RldmV4aXQgY2lycnVzZmJfem9ycm9fdW5tYXAgKHN0cnVjdCBjaXJydXNmYl9p
bmZvICpjaW5mbykKK3N0YXRpYyB2b2lkIF9fZGV2ZXhpdCBjaXJydXNmYl96b3Jyb191bm1hcChz
dHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8pCiB7CiAJem9ycm9fcmVsZWFzZV9kZXZpY2UoY2lu
Zm8tPnpkZXYpOwogCiAJaWYgKGNpbmZvLT5idHlwZSA9PSBCVF9QSUNBU1NPNCkgewogCQljaW5m
by0+cmVnYmFzZSAtPSAweDYwMDAwMDsKLQkJaW91bm1hcCAoKHZvaWQgKiljaW5mby0+cmVnYmFz
ZSk7Ci0JCWlvdW5tYXAgKCh2b2lkICopY2luZm8tPmZibWVtKTsKKwkJaW91bm1hcCgodm9pZCAq
KWNpbmZvLT5yZWdiYXNlKTsKKwkJaW91bm1hcCgodm9pZCAqKWNpbmZvLT5mYm1lbSk7CiAJfSBl
bHNlIHsKIAkJaWYgKHpvcnJvX3Jlc291cmNlX3N0YXJ0KGNpbmZvLT56ZGV2KSA+IDB4MDEwMDAw
MDApCi0JCQlpb3VubWFwICgodm9pZCAqKWNpbmZvLT5mYm1lbSk7CisJCQlpb3VubWFwKCh2b2lk
ICopY2luZm8tPmZibWVtKTsKIAl9CiAJZnJhbWVidWZmZXJfcmVsZWFzZShjaW5mby0+aW5mbyk7
CiB9CkBAIC0yMjY3LDcgKzI0MjUsOCBAQCBzdGF0aWMgaW50IGNpcnJ1c2ZiX3NldF9mYmluZm8o
c3RydWN0IGNpCiAJLyogbW9ub2Nocm9tZTogb25seSAxIG1lbW9yeSBwbGFuZSAqLwogCS8qIDgg
Yml0IGFuZCBhYm92ZTogVXNlIHdob2xlIG1lbW9yeSBhcmVhICovCiAJaW5mby0+Zml4LnNtZW1f
c3RhcnQgPSBjaW5mby0+ZmJtZW1fcGh5czsKLQlpbmZvLT5maXguc21lbV9sZW4gICA9ICh2YXIt
PmJpdHNfcGVyX3BpeGVsID09IDEpID8gY2luZm8tPnNpemUgLyA0IDogY2luZm8tPnNpemU7CisJ
aW5mby0+Zml4LnNtZW1fbGVuICAgPQorCQkodmFyLT5iaXRzX3Blcl9waXhlbCA9PSAxKSA/IGNp
bmZvLT5zaXplIC8gNCA6IGNpbmZvLT5zaXplOwogCWluZm8tPmZpeC50eXBlICAgICAgID0gY2lu
Zm8tPmN1cnJlbnRtb2RlLnR5cGU7CiAJaW5mby0+Zml4LnR5cGVfYXV4ICAgPSAwOwogCWluZm8t
PmZpeC52aXN1YWwgICAgID0gY2luZm8tPmN1cnJlbnRtb2RlLnZpc3VhbDsKQEAgLTIyOTIsMTcg
KzI0NTEsMTggQEAgc3RhdGljIGludCBjaXJydXNmYl9yZWdpc3RlcihzdHJ1Y3QgY2lycgogCWlu
dCBlcnI7CiAJY2lycnVzZmJfYm9hcmRfdCBidHlwZTsKIAotCURQUklOVEsgKCJFTlRFUlxuIik7
CisJRFBSSU5USygiRU5URVJcbiIpOwogCi0JcHJpbnRrIChLRVJOX0lORk8gImNpcnJ1c2ZiOiBE
cml2ZXIgZm9yIENpcnJ1cyBMb2dpYyBiYXNlZCBncmFwaGljIGJvYXJkcywgdiIgQ0lSUlVTRkJf
VkVSU0lPTiAiXG4iKTsKKwlwcmludGsoS0VSTl9JTkZPICJjaXJydXNmYjogRHJpdmVyIGZvciBD
aXJydXMgTG9naWMgYmFzZWQgIgorCQkiZ3JhcGhpYyBib2FyZHMsIHYiIENJUlJVU0ZCX1ZFUlNJ
T04gIlxuIik7CiAKIAlpbmZvID0gY2luZm8tPmluZm87CiAJYnR5cGUgPSBjaW5mby0+YnR5cGU7
CiAKIAkvKiBzYW5pdHkgY2hlY2tzICovCi0JYXNzZXJ0IChidHlwZSAhPSBCVF9OT05FKTsKKwlh
c3NlcnQoYnR5cGUgIT0gQlRfTk9ORSk7CiAKLQlEUFJJTlRLICgiY2lycnVzZmI6IChSQU0gc3Rh
cnQgc2V0IHRvOiAweCVwKVxuIiwgY2luZm8tPmZibWVtKTsKKwlEUFJJTlRLKCJjaXJydXNmYjog
KFJBTSBzdGFydCBzZXQgdG86IDB4JXApXG4iLCBjaW5mby0+ZmJtZW0pOwogCiAJLyogTWFrZSBw
cmV0ZW5kIHdlJ3ZlIHNldCB0aGUgdmFyIHNvIG91ciBzdHJ1Y3R1cmVzIGFyZSBpbiBhICJnb29k
IiAqLwogCS8qIHN0YXRlLCBldmVuIHRob3VnaCB3ZSBoYXZlbid0IHdyaXR0ZW4gdGhlIG1vZGUg
dG8gdGhlIGh3IHlldC4uLiAgKi8KQEAgLTIzMjEsMTEgKzI0ODEsMTIgQEAgc3RhdGljIGludCBj
aXJydXNmYl9yZWdpc3RlcihzdHJ1Y3QgY2lycgogCiAJZXJyID0gcmVnaXN0ZXJfZnJhbWVidWZm
ZXIoaW5mbyk7CiAJaWYgKGVyciA8IDApIHsKLQkJcHJpbnRrIChLRVJOX0VSUiAiY2lycnVzZmI6
IGNvdWxkIG5vdCByZWdpc3RlciBmYiBkZXZpY2U7IGVyciA9ICVkIVxuIiwgZXJyKTsKKwkJcHJp
bnRrKEtFUk5fRVJSICJjaXJydXNmYjogY291bGQgbm90IHJlZ2lzdGVyICIKKwkJCSJmYiBkZXZp
Y2U7IGVyciA9ICVkIVxuIiwgZXJyKTsKIAkJZ290byBlcnJfZGVhbGxvY19jbWFwOwogCX0KIAot
CURQUklOVEsgKCJFWElULCByZXR1cm5pbmcgMFxuIik7CisJRFBSSU5USygiRVhJVCwgcmV0dXJu
aW5nIDBcbiIpOwogCXJldHVybiAwOwogCiBlcnJfZGVhbGxvY19jbWFwOgpAQCAtMjMzNSwyNCAr
MjQ5NiwyMyBAQCBlcnJfdW5tYXBfY2lycnVzZmI6CiAJcmV0dXJuIGVycjsKIH0KIAotc3RhdGlj
IHZvaWQgX19kZXZleGl0IGNpcnJ1c2ZiX2NsZWFudXAgKHN0cnVjdCBmYl9pbmZvICppbmZvKQor
c3RhdGljIHZvaWQgX19kZXZleGl0IGNpcnJ1c2ZiX2NsZWFudXAoc3RydWN0IGZiX2luZm8gKmlu
Zm8pCiB7CiAJc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvID0gaW5mby0+cGFyOwotCURQUklO
VEsgKCJFTlRFUlxuIik7CisJRFBSSU5USygiRU5URVJcbiIpOwogCi0Jc3dpdGNoX21vbml0b3Ig
KGNpbmZvLCAwKTsKKwlzd2l0Y2hfbW9uaXRvcihjaW5mbywgMCk7CiAKLQl1bnJlZ2lzdGVyX2Zy
YW1lYnVmZmVyIChpbmZvKTsKLQlmYl9kZWFsbG9jX2NtYXAgKCZpbmZvLT5jbWFwKTsKLQlwcmlu
dGsgKCJGcmFtZWJ1ZmZlciB1bnJlZ2lzdGVyZWRcbiIpOworCXVucmVnaXN0ZXJfZnJhbWVidWZm
ZXIoaW5mbyk7CisJZmJfZGVhbGxvY19jbWFwKCZpbmZvLT5jbWFwKTsKKwlwcmludGsoIkZyYW1l
YnVmZmVyIHVucmVnaXN0ZXJlZFxuIik7CiAJY2luZm8tPnVubWFwKGNpbmZvKTsKIAotCURQUklO
VEsgKCJFWElUXG4iKTsKKwlEUFJJTlRLKCJFWElUXG4iKTsKIH0KIAotCiAjaWZkZWYgQ09ORklH
X1BDSQotc3RhdGljIGludCBjaXJydXNmYl9wY2lfcmVnaXN0ZXIgKHN0cnVjdCBwY2lfZGV2ICpw
ZGV2LAorc3RhdGljIGludCBjaXJydXNmYl9wY2lfcmVnaXN0ZXIoc3RydWN0IHBjaV9kZXYgKnBk
ZXYsCiAJCQkJICBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqZW50KQogewogCXN0cnVjdCBj
aXJydXNmYl9pbmZvICpjaW5mbzsKQEAgLTIzNzksMzEgKzI1MzksMzQgQEAgc3RhdGljIGludCBj
aXJydXNmYl9wY2lfcmVnaXN0ZXIgKHN0cnVjdAogCWNpbmZvLT5wZGV2ID0gcGRldjsKIAljaW5m
by0+YnR5cGUgPSBidHlwZSA9IChjaXJydXNmYl9ib2FyZF90KSBlbnQtPmRyaXZlcl9kYXRhOwog
Ci0JRFBSSU5USyAoIiBGb3VuZCBQQ0kgZGV2aWNlLCBiYXNlIGFkZHJlc3MgMCBpcyAweCVseCwg
YnR5cGUgc2V0IHRvICVkXG4iLAorCURQUklOVEsoIiBGb3VuZCBQQ0kgZGV2aWNlLCBiYXNlIGFk
ZHJlc3MgMCBpcyAweCVseCwgYnR5cGUgc2V0IHRvICVkXG4iLAogCQlwZGV2LT5yZXNvdXJjZVsw
XS5zdGFydCwgYnR5cGUpOwotCURQUklOVEsgKCIgYmFzZSBhZGRyZXNzIDEgaXMgMHglbHhcbiIs
IHBkZXYtPnJlc291cmNlWzFdLnN0YXJ0KTsKKwlEUFJJTlRLKCIgYmFzZSBhZGRyZXNzIDEgaXMg
MHglbHhcbiIsIHBkZXYtPnJlc291cmNlWzFdLnN0YXJ0KTsKIAotCWlmKGlzUFJlUCkgewotCQlw
Y2lfd3JpdGVfY29uZmlnX2R3b3JkIChwZGV2LCBQQ0lfQkFTRV9BRERSRVNTXzAsIDB4MDAwMDAw
MDApOworCWlmIChpc1BSZVApIHsKKwkJcGNpX3dyaXRlX2NvbmZpZ19kd29yZChwZGV2LCBQQ0lf
QkFTRV9BRERSRVNTXzAsIDB4MDAwMDAwMDApOwogI2lmZGVmIENPTkZJR19QUENfUFJFUAotCQln
ZXRfcHJlcF9hZGRycyAoJmJvYXJkX2FkZHIsICZjaW5mby0+ZmJyZWdzX3BoeXMpOworCQlnZXRf
cHJlcF9hZGRycygmYm9hcmRfYWRkciwgJmNpbmZvLT5mYnJlZ3NfcGh5cyk7CiAjZW5kaWYKLQkJ
LyogUFJlUCBkaWVzIGlmIHdlIGlvcmVtYXAgdGhlIElPIHJlZ2lzdGVycywgYnV0IGl0IHdvcmtz
IHcvb3V0Li4uICovCisJLyogUFJlUCBkaWVzIGlmIHdlIGlvcmVtYXAgdGhlIElPIHJlZ2lzdGVy
cywgYnV0IGl0IHdvcmtzIHcvb3V0Li4uICovCiAJCWNpbmZvLT5yZWdiYXNlID0gKGNoYXIgX19p
b21lbSAqKSBjaW5mby0+ZmJyZWdzX3BoeXM7CiAJfSBlbHNlIHsKLQkJRFBSSU5USyAoIkF0dGVt
cHQgdG8gZ2V0IFBDSSBpbmZvIGZvciBDaXJydXMgR3JhcGhpY3MgQ2FyZFxuIik7Ci0JCWdldF9w
Y2lfYWRkcnMgKHBkZXYsICZib2FyZF9hZGRyLCAmY2luZm8tPmZicmVnc19waHlzKTsKLQkJY2lu
Zm8tPnJlZ2Jhc2UgPSBOVUxMOwkJLyogRklYTUU6IHRoaXMgZm9yY2VzIFZHQS4gIGFsdGVybmF0
aXZlcz8gKi8KKwkJRFBSSU5USygiQXR0ZW1wdCB0byBnZXQgUENJIGluZm8gZm9yIENpcnJ1cyBH
cmFwaGljcyBDYXJkXG4iKTsKKwkJZ2V0X3BjaV9hZGRycyhwZGV2LCAmYm9hcmRfYWRkciwgJmNp
bmZvLT5mYnJlZ3NfcGh5cyk7CisJCS8qIEZJWE1FOiB0aGlzIGZvcmNlcyBWR0EuICBhbHRlcm5h
dGl2ZXM/ICovCisJCWNpbmZvLT5yZWdiYXNlID0gTlVMTDsKIAl9CiAKLQlEUFJJTlRLICgiQm9h
cmQgYWRkcmVzczogMHglbHgsIHJlZ2lzdGVyIGFkZHJlc3M6IDB4JWx4XG4iLCBib2FyZF9hZGRy
LCBjaW5mby0+ZmJyZWdzX3BoeXMpOworCURQUklOVEsoIkJvYXJkIGFkZHJlc3M6IDB4JWx4LCBy
ZWdpc3RlciBhZGRyZXNzOiAweCVseFxuIiwKKwkJYm9hcmRfYWRkciwgY2luZm8tPmZicmVnc19w
aHlzKTsKIAogCWJvYXJkX3NpemUgPSAoYnR5cGUgPT0gQlRfR0Q1NDgwKSA/Ci0JCTMyICogTUJf
IDogY2lycnVzZmJfZ2V0X21lbXNpemUgKGNpbmZvLT5yZWdiYXNlKTsKKwkJMzIgKiBNQl8gOiBj
aXJydXNmYl9nZXRfbWVtc2l6ZShjaW5mby0+cmVnYmFzZSk7CiAKIAlyZXQgPSBwY2lfcmVxdWVz
dF9yZWdpb25zKHBkZXYsICJjaXJydXNmYiIpOwotCWlmIChyZXQgPDApIHsKLQkJcHJpbnRrKEtF
Uk5fRVJSICJjaXJydXNmYjogY2Fubm90IHJlc2VydmUgcmVnaW9uIDB4JWx4LCBhYm9ydFxuIiwK
KwlpZiAocmV0IDwgMCkgeworCQlwcmludGsoS0VSTl9FUlIgImNpcnJ1c2ZiOiBjYW5ub3QgcmVz
ZXJ2ZSByZWdpb24gMHglbHgsICIKKwkJICAgICAgICJhYm9ydFxuIiwKIAkJICAgICAgIGJvYXJk
X2FkZHIpOwogCQlnb3RvIGVycl9yZWxlYXNlX2ZiOwogCX0KQEAgLTI0MjksOCArMjU5Miw5IEBA
IHN0YXRpYyBpbnQgY2lycnVzZmJfcGNpX3JlZ2lzdGVyIChzdHJ1Y3QKIAljaW5mby0+c2l6ZSA9
IGJvYXJkX3NpemU7CiAJY2luZm8tPnVubWFwID0gY2lycnVzZmJfcGNpX3VubWFwOwogCi0JcHJp
bnRrICgiIFJBTSAoJWx1IGtCKSBhdCAweHglbHgsICIsIGNpbmZvLT5zaXplIC8gS0JfLCBib2Fy
ZF9hZGRyKTsKLQlwcmludGsgKCJDaXJydXMgTG9naWMgY2hpcHNldCBvbiBQQ0kgYnVzXG4iKTsK
KwlwcmludGsoS0VSTl9JTkZPICIgUkFNICglbHUga0IpIGF0IDB4eCVseCwgIiwKKwkJY2luZm8t
PnNpemUgLyBLQl8sIGJvYXJkX2FkZHIpOworCXByaW50ayhLRVJOX0lORk8gIkNpcnJ1cyBMb2dp
YyBjaGlwc2V0IG9uIFBDSSBidXNcbiIpOwogCXBjaV9zZXRfZHJ2ZGF0YShwZGV2LCBpbmZvKTsK
IAogCXJldCA9IGNpcnJ1c2ZiX3JlZ2lzdGVyKGNpbmZvKTsKQEAgLTI0NTMsMTQgKzI2MTcsMTQg
QEAgZXJyX291dDoKIAlyZXR1cm4gcmV0OwogfQogCi1zdGF0aWMgdm9pZCBfX2RldmV4aXQgY2ly
cnVzZmJfcGNpX3VucmVnaXN0ZXIgKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQorc3RhdGljIHZvaWQg
X19kZXZleGl0IGNpcnJ1c2ZiX3BjaV91bnJlZ2lzdGVyKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQog
ewogCXN0cnVjdCBmYl9pbmZvICppbmZvID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOwotCURQUklO
VEsgKCJFTlRFUlxuIik7CisJRFBSSU5USygiRU5URVJcbiIpOwogCi0JY2lycnVzZmJfY2xlYW51
cCAoaW5mbyk7CisJY2lycnVzZmJfY2xlYW51cChpbmZvKTsKIAotCURQUklOVEsgKCJFWElUXG4i
KTsKKwlEUFJJTlRLKCJFWElUXG4iKTsKIH0KIAogc3RhdGljIHN0cnVjdCBwY2lfZHJpdmVyIGNp
cnJ1c2ZiX3BjaV9kcml2ZXIgPSB7CkBAIC0yNDc3LDcgKzI2NDEsNiBAQCBzdGF0aWMgc3RydWN0
IHBjaV9kcml2ZXIgY2lycnVzZmJfcGNpX2RyCiB9OwogI2VuZGlmIC8qIENPTkZJR19QQ0kgKi8K
IAotCiAjaWZkZWYgQ09ORklHX1pPUlJPCiBzdGF0aWMgaW50IGNpcnJ1c2ZiX3pvcnJvX3JlZ2lz
dGVyKHN0cnVjdCB6b3Jyb19kZXYgKnosCiAJCQkJICAgY29uc3Qgc3RydWN0IHpvcnJvX2Rldmlj
ZV9pZCAqZW50KQpAQCAtMjQ5OCw3ICsyNjYxLDcgQEAgc3RhdGljIGludCBjaXJydXNmYl96b3Jy
b19yZWdpc3RlcihzdHJ1YwogCiAJaW5mbyA9IGZyYW1lYnVmZmVyX2FsbG9jKHNpemVvZihzdHJ1
Y3QgY2lycnVzZmJfaW5mbyksICZ6LT5kZXYpOwogCWlmICghaW5mbykgewotCQlwcmludGsgKEtF
Uk5fRVJSICJjaXJydXNmYjogY291bGQgbm90IGFsbG9jYXRlIG1lbW9yeVxuIik7CisJCXByaW50
ayhLRVJOX0VSUiAiY2lycnVzZmI6IGNvdWxkIG5vdCBhbGxvY2F0ZSBtZW1vcnlcbiIpOwogCQly
ZXQgPSAtRU5PTUVNOwogCQlnb3RvIGVycl9vdXQ7CiAJfQpAQCAtMjUwNyw5ICsyNjcwLDkgQEAg
c3RhdGljIGludCBjaXJydXNmYl96b3Jyb19yZWdpc3RlcihzdHJ1YwogCWNpbmZvLT5pbmZvID0g
aW5mbzsKIAljaW5mby0+YnR5cGUgPSBidHlwZTsKIAotCWFzc2VydCAoeiA+IDApOwotCWFzc2Vy
dCAoejIgPj0gMCk7Ci0JYXNzZXJ0IChidHlwZSAhPSBCVF9OT05FKTsKKwlhc3NlcnQoeiA+IDAp
OworCWFzc2VydCh6MiA+PSAwKTsKKwlhc3NlcnQoYnR5cGUgIT0gQlRfTk9ORSk7CiAKIAljaW5m
by0+emRldiA9IHo7CiAJYm9hcmRfYWRkciA9IHpvcnJvX3Jlc291cmNlX3N0YXJ0KHopOwpAQCAt
MjUxNyw1NSArMjY4MCw1OSBAQCBzdGF0aWMgaW50IGNpcnJ1c2ZiX3pvcnJvX3JlZ2lzdGVyKHN0
cnVjCiAJY2luZm8tPnNpemUgPSBzaXplOwogCiAJaWYgKCF6b3Jyb19yZXF1ZXN0X2RldmljZSh6
LCAiY2lycnVzZmIiKSkgewotCQlwcmludGsoS0VSTl9FUlIgImNpcnJ1c2ZiOiBjYW5ub3QgcmVz
ZXJ2ZSByZWdpb24gMHglbHgsIGFib3J0XG4iLAorCQlwcmludGsoS0VSTl9FUlIgImNpcnJ1c2Zi
OiBjYW5ub3QgcmVzZXJ2ZSByZWdpb24gMHglbHgsICIKKwkJICAgICAgICJhYm9ydFxuIiwKIAkJ
ICAgICAgIGJvYXJkX2FkZHIpOwogCQlyZXQgPSAtRUJVU1k7CiAJCWdvdG8gZXJyX3JlbGVhc2Vf
ZmI7CiAJfQogCi0JcHJpbnRrICgiIFJBTSAoJWx1IE1CKSBhdCAkJWx4LCAiLCBib2FyZF9zaXpl
IC8gTUJfLCBib2FyZF9hZGRyKTsKKwlwcmludGsoIiBSQU0gKCVsdSBNQikgYXQgJCVseCwgIiwg
Ym9hcmRfc2l6ZSAvIE1CXywgYm9hcmRfYWRkcik7CiAKIAlyZXQgPSAtRUlPOwogCiAJaWYgKGJ0
eXBlID09IEJUX1BJQ0FTU080KSB7Ci0JCXByaW50ayAoIiBSRUcgYXQgJCVseFxuIiwgYm9hcmRf
YWRkciArIDB4NjAwMDAwKTsKKwkJcHJpbnRrKEtFUk5fSU5GTyAiIFJFRyBhdCAkJWx4XG4iLCBi
b2FyZF9hZGRyICsgMHg2MDAwMDApOwogCiAJCS8qIFRvIGJlIHByZWNpc2UsIGZvciB0aGUgUDQg
dGhpcyBpcyBub3QgdGhlICovCiAJCS8qIGJlZ2luIG9mIHRoZSBib2FyZCwgYnV0IHRoZSBiZWdp
biBvZiBSQU0uICovCiAJCS8qIGZvciBQNCwgbWFwIGluIGl0cyBhZGRyZXNzIHNwYWNlIGluIDIg
Y2h1bmtzICgjIyMgVEVTVCEgKSAqLwogCQkvKiAobm90ZSB0aGUgdWdseSBoYXJkY29kZWQgMTZN
IG51bWJlcikgKi8KLQkJY2luZm8tPnJlZ2Jhc2UgPSBpb3JlbWFwIChib2FyZF9hZGRyLCAxNjc3
NzIxNik7CisJCWNpbmZvLT5yZWdiYXNlID0gaW9yZW1hcChib2FyZF9hZGRyLCAxNjc3NzIxNik7
CiAJCWlmICghY2luZm8tPnJlZ2Jhc2UpCiAJCQlnb3RvIGVycl9yZWxlYXNlX3JlZ2lvbjsKIAot
CQlEUFJJTlRLICgiY2lycnVzZmI6IFZpcnR1YWwgYWRkcmVzcyBmb3IgYm9hcmQgc2V0IHRvOiAk
JXBcbiIsIGNpbmZvLT5yZWdiYXNlKTsKKwkJRFBSSU5USygiY2lycnVzZmI6IFZpcnR1YWwgYWRk
cmVzcyBmb3IgYm9hcmQgc2V0IHRvOiAkJXBcbiIsCisJCQljaW5mby0+cmVnYmFzZSk7CiAJCWNp
bmZvLT5yZWdiYXNlICs9IDB4NjAwMDAwOwogCQljaW5mby0+ZmJyZWdzX3BoeXMgPSBib2FyZF9h
ZGRyICsgMHg2MDAwMDA7CiAKIAkJY2luZm8tPmZibWVtX3BoeXMgPSBib2FyZF9hZGRyICsgMTY3
NzcyMTY7Ci0JCWNpbmZvLT5mYm1lbSA9IGlvcmVtYXAgKGNpbmZvLT5mYm1lbV9waHlzLCAxNjc3
NzIxNik7CisJCWNpbmZvLT5mYm1lbSA9IGlvcmVtYXAoY2luZm8tPmZibWVtX3BoeXMsIDE2Nzc3
MjE2KTsKIAkJaWYgKCFjaW5mby0+ZmJtZW0pCiAJCQlnb3RvIGVycl91bm1hcF9yZWdiYXNlOwog
CX0gZWxzZSB7Ci0JCXByaW50ayAoIiBSRUcgYXQgJCVseFxuIiwgKHVuc2lnbmVkIGxvbmcpIHoy
LT5yZXNvdXJjZS5zdGFydCk7CisJCXByaW50ayhLRVJOX0lORk8gIiBSRUcgYXQgJCVseFxuIiwK
KwkJCSh1bnNpZ25lZCBsb25nKSB6Mi0+cmVzb3VyY2Uuc3RhcnQpOwogCiAJCWNpbmZvLT5mYm1l
bV9waHlzID0gYm9hcmRfYWRkcjsKIAkJaWYgKGJvYXJkX2FkZHIgPiAweDAxMDAwMDAwKQotCQkJ
Y2luZm8tPmZibWVtID0gaW9yZW1hcCAoYm9hcmRfYWRkciwgYm9hcmRfc2l6ZSk7CisJCQljaW5m
by0+ZmJtZW0gPSBpb3JlbWFwKGJvYXJkX2FkZHIsIGJvYXJkX3NpemUpOwogCQllbHNlCi0JCQlj
aW5mby0+ZmJtZW0gPSAoY2FkZHJfdCkgWlRXT19WQUREUiAoYm9hcmRfYWRkcik7CisJCQljaW5m
by0+ZmJtZW0gPSAoY2FkZHJfdCkgWlRXT19WQUREUihib2FyZF9hZGRyKTsKIAkJaWYgKCFjaW5m
by0+ZmJtZW0pCiAJCQlnb3RvIGVycl9yZWxlYXNlX3JlZ2lvbjsKIAogCQkvKiBzZXQgYWRkcmVz
cyBmb3IgUkVHIGFyZWEgb2YgYm9hcmQgKi8KLQkJY2luZm8tPnJlZ2Jhc2UgPSAoY2FkZHJfdCkg
WlRXT19WQUREUiAoejItPnJlc291cmNlLnN0YXJ0KTsKKwkJY2luZm8tPnJlZ2Jhc2UgPSAoY2Fk
ZHJfdCkgWlRXT19WQUREUih6Mi0+cmVzb3VyY2Uuc3RhcnQpOwogCQljaW5mby0+ZmJyZWdzX3Bo
eXMgPSB6Mi0+cmVzb3VyY2Uuc3RhcnQ7CiAKLQkJRFBSSU5USyAoImNpcnJ1c2ZiOiBWaXJ0dWFs
IGFkZHJlc3MgZm9yIGJvYXJkIHNldCB0bzogJCVwXG4iLCBjaW5mby0+cmVnYmFzZSk7CisJCURQ
UklOVEsoImNpcnJ1c2ZiOiBWaXJ0dWFsIGFkZHJlc3MgZm9yIGJvYXJkIHNldCB0bzogJCVwXG4i
LAorCQkJY2luZm8tPnJlZ2Jhc2UpOwogCX0KIAljaW5mby0+dW5tYXAgPSBjaXJydXNmYl96b3Jy
b191bm1hcDsKIAotCXByaW50ayAoS0VSTl9JTkZPICJDaXJydXMgTG9naWMgY2hpcHNldCBvbiBa
b3JybyBidXNcbiIpOworCXByaW50ayhLRVJOX0lORk8gIkNpcnJ1cyBMb2dpYyBjaGlwc2V0IG9u
IFpvcnJvIGJ1c1xuIik7CiAJem9ycm9fc2V0X2RydmRhdGEoeiwgaW5mbyk7CiAKIAlyZXQgPSBj
aXJydXNmYl9yZWdpc3RlcihjaW5mbyk7CkBAIC0yNTkyLDExICsyNzU5LDExIEBAIGVycl9vdXQ6
CiB2b2lkIF9fZGV2ZXhpdCBjaXJydXNmYl96b3Jyb191bnJlZ2lzdGVyKHN0cnVjdCB6b3Jyb19k
ZXYgKnopCiB7CiAJc3RydWN0IGZiX2luZm8gKmluZm8gPSB6b3Jyb19nZXRfZHJ2ZGF0YSh6KTsK
LQlEUFJJTlRLICgiRU5URVJcbiIpOworCURQUklOVEsoIkVOVEVSXG4iKTsKIAotCWNpcnJ1c2Zi
X2NsZWFudXAgKGluZm8pOworCWNpcnJ1c2ZiX2NsZWFudXAoaW5mbyk7CiAKLQlEUFJJTlRLICgi
RVhJVFxuIik7CisJRFBSSU5USygiRVhJVFxuIik7CiB9CiAKIHN0YXRpYyBzdHJ1Y3Qgem9ycm9f
ZHJpdmVyIGNpcnJ1c2ZiX3pvcnJvX2RyaXZlciA9IHsKQEAgLTI2MjgsMjYgKzI3OTUsMjQgQEAg
c3RhdGljIGludCBfX2luaXQgY2lycnVzZmJfaW5pdCh2b2lkKQogCXJldHVybiBlcnJvcjsKIH0K
IAotCi0KICNpZm5kZWYgTU9EVUxFCiBzdGF0aWMgaW50IF9faW5pdCBjaXJydXNmYl9zZXR1cChj
aGFyICpvcHRpb25zKSB7CiAJY2hhciAqdGhpc19vcHQsIHNbMzJdOwogCWludCBpOwogCi0JRFBS
SU5USyAoIkVOVEVSXG4iKTsKKwlEUFJJTlRLKCJFTlRFUlxuIik7CiAKIAlpZiAoIW9wdGlvbnMg
fHwgISpvcHRpb25zKQogCQlyZXR1cm4gMDsKIAotCXdoaWxlICgodGhpc19vcHQgPSBzdHJzZXAg
KCZvcHRpb25zLCAiLCIpKSAhPSBOVUxMKSB7CQorCXdoaWxlICgodGhpc19vcHQgPSBzdHJzZXAo
Jm9wdGlvbnMsICIsIikpICE9IE5VTEwpIHsKIAkJaWYgKCEqdGhpc19vcHQpIGNvbnRpbnVlOwog
CiAJCURQUklOVEsoImNpcnJ1c2ZiX3NldHVwOiBvcHRpb24gJyVzJ1xuIiwgdGhpc19vcHQpOwog
CiAJCWZvciAoaSA9IDA7IGkgPCBOVU1fVE9UQUxfTU9ERVM7IGkrKykgewotCQkJc3ByaW50ZiAo
cywgIm1vZGU6JXMiLCBjaXJydXNmYl9wcmVkZWZpbmVkW2ldLm5hbWUpOwotCQkJaWYgKHN0cmNt
cCAodGhpc19vcHQsIHMpID09IDApCisJCQlzcHJpbnRmKHMsICJtb2RlOiVzIiwgY2lycnVzZmJf
cHJlZGVmaW5lZFtpXS5uYW1lKTsKKwkJCWlmIChzdHJjbXAodGhpc19vcHQsIHMpID09IDApCiAJ
CQkJY2lycnVzZmJfZGVmX21vZGUgPSBpOwogCQl9CiAJCWlmICghc3RyY21wKHRoaXNfb3B0LCAi
bm9hY2NlbCIpKQpAQCAtMjY1Nyw3ICsyODIyLDYgQEAgc3RhdGljIGludCBfX2luaXQgY2lycnVz
ZmJfc2V0dXAoY2hhciAqbwogfQogI2VuZGlmCiAKLQogICAgIC8qCiAgICAgICogIE1vZHVsYXJp
emF0aW9uCiAgICAgICovCkBAIC0yNjY2LDcgKzI4MzAsNyBAQCBNT0RVTEVfQVVUSE9SKCJDb3B5
cmlnaHQgMTk5OSwyMDAwIEplZmYgCiBNT0RVTEVfREVTQ1JJUFRJT04oIkFjY2VsZXJhdGVkIEZC
RGV2IGRyaXZlciBmb3IgQ2lycnVzIExvZ2ljIGNoaXBzIik7CiBNT0RVTEVfTElDRU5TRSgiR1BM
Iik7CiAKLXN0YXRpYyB2b2lkIF9fZXhpdCBjaXJydXNmYl9leGl0ICh2b2lkKQorc3RhdGljIHZv
aWQgX19leGl0IGNpcnJ1c2ZiX2V4aXQodm9pZCkKIHsKICNpZmRlZiBDT05GSUdfUENJCiAJcGNp
X3VucmVnaXN0ZXJfZHJpdmVyKCZjaXJydXNmYl9wY2lfZHJpdmVyKTsKQEAgLTI2ODIsNjYgKzI4
NDYsNjcgQEAgbW9kdWxlX2luaXQoY2lycnVzZmJfaW5pdCk7CiBtb2R1bGVfZXhpdChjaXJydXNm
Yl9leGl0KTsKICNlbmRpZgogCi0KIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwogLyogYWJvdXQgdGhlIGZvbGxv
d2luZyBmdW5jdGlvbnMgLSBJIGhhdmUgdXNlZCB0aGUgc2FtZSBuYW1lcyBmb3IgdGhlICovCiAv
KiBmdW5jdGlvbnMgYXMgTWFya3VzIFdpbGQgZGlkIGluIGhpcyBSZXRpbmEgZHJpdmVyIGZvciBO
ZXRCU0QgYXMgICAgKi8KIC8qIHRoZXkganVzdCBtYWRlIHNlbnNlIGZvciB0aGlzIHB1cnBvc2Uu
IEFwYXJ0IGZyb20gdGhhdCwgSSB3cm90ZSAgICAqLwotLyogdGhlc2UgZnVuY3Rpb25zIG15c2Vs
Zi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiB0aGVz
ZSBmdW5jdGlvbnMgbXlzZWxmLgkJCQkJICAgICovCiAvKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KIAogLyoqKiBX
R2VuKCkgLSB3cml0ZSBpbnRvIG9uZSBvZiB0aGUgZXh0ZXJuYWwvZ2VuZXJhbCByZWdpc3RlcnMg
KioqLwotc3RhdGljIHZvaWQgV0dlbiAoY29uc3Qgc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZv
LAorc3RhdGljIHZvaWQgV0dlbihjb25zdCBzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8sCiAJ
CSAgaW50IHJlZ251bSwgdW5zaWduZWQgY2hhciB2YWwpCiB7CiAJdW5zaWduZWQgbG9uZyByZWdv
ZnMgPSAwOwogCiAJaWYgKGNpbmZvLT5idHlwZSA9PSBCVF9QSUNBU1NPKSB7CiAJCS8qIFBpY2Fz
c28gSUkgc3BlY2lmaWMgaGFjayAqLwotLyogICAgICAgICAgICAgIGlmIChyZWdudW0gPT0gVkdB
X1BFTF9JUiB8fCByZWdudW0gPT0gVkdBX1BFTF9EIHx8IHJlZ251bSA9PSBDTF9WU1NNMikgKi8K
Ky8qCSAgICAgIGlmIChyZWdudW0gPT0gVkdBX1BFTF9JUiB8fCByZWdudW0gPT0gVkdBX1BFTF9E
IHx8CisJCSAgcmVnbnVtID09IENMX1ZTU00yKSAqLwogCQlpZiAocmVnbnVtID09IFZHQV9QRUxf
SVIgfHwgcmVnbnVtID09IFZHQV9QRUxfRCkKIAkJCXJlZ29mcyA9IDB4ZmZmOwogCX0KIAotCXZn
YV93IChjaW5mby0+cmVnYmFzZSwgcmVnb2ZzICsgcmVnbnVtLCB2YWwpOworCXZnYV93KGNpbmZv
LT5yZWdiYXNlLCByZWdvZnMgKyByZWdudW0sIHZhbCk7CiB9CiAKIC8qKiogUkdlbigpIC0gcmVh
ZCBvdXQgb25lIG9mIHRoZSBleHRlcm5hbC9nZW5lcmFsIHJlZ2lzdGVycyAqKiovCi1zdGF0aWMg
dW5zaWduZWQgY2hhciBSR2VuIChjb25zdCBzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8sIGlu
dCByZWdudW0pCitzdGF0aWMgdW5zaWduZWQgY2hhciBSR2VuKGNvbnN0IHN0cnVjdCBjaXJydXNm
Yl9pbmZvICpjaW5mbywgaW50IHJlZ251bSkKIHsKIAl1bnNpZ25lZCBsb25nIHJlZ29mcyA9IDA7
CiAKIAlpZiAoY2luZm8tPmJ0eXBlID09IEJUX1BJQ0FTU08pIHsKIAkJLyogUGljYXNzbyBJSSBz
cGVjaWZpYyBoYWNrICovCi0vKiAgICAgICAgICAgICAgaWYgKHJlZ251bSA9PSBWR0FfUEVMX0lS
IHx8IHJlZ251bSA9PSBWR0FfUEVMX0QgfHwgcmVnbnVtID09IENMX1ZTU00yKSAqLworLyoJICAg
ICAgaWYgKHJlZ251bSA9PSBWR0FfUEVMX0lSIHx8IHJlZ251bSA9PSBWR0FfUEVMX0QgfHwKKwkJ
ICByZWdudW0gPT0gQ0xfVlNTTTIpICovCiAJCWlmIChyZWdudW0gPT0gVkdBX1BFTF9JUiB8fCBy
ZWdudW0gPT0gVkdBX1BFTF9EKQogCQkJcmVnb2ZzID0gMHhmZmY7CiAJfQogCi0JcmV0dXJuIHZn
YV9yIChjaW5mby0+cmVnYmFzZSwgcmVnb2ZzICsgcmVnbnVtKTsKKwlyZXR1cm4gdmdhX3IoY2lu
Zm8tPnJlZ2Jhc2UsIHJlZ29mcyArIHJlZ251bSk7CiB9CiAKIC8qKiogQXR0ck9uKCkgLSB0dXJu
IG9uIFZpZGVvRW5hYmxlIGZvciBBdHRyaWJ1dGUgY29udHJvbGxlciAqKiovCi1zdGF0aWMgdm9p
ZCBBdHRyT24gKGNvbnN0IHN0cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbykKK3N0YXRpYyB2b2lk
IEF0dHJPbihjb25zdCBzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8pCiB7Ci0JYXNzZXJ0IChj
aW5mbyAhPSBOVUxMKTsKKwlhc3NlcnQoY2luZm8gIT0gTlVMTCk7CiAKLQlEUFJJTlRLICgiRU5U
RVJcbiIpOworCURQUklOVEsoIkVOVEVSXG4iKTsKIAotCWlmICh2Z2FfcmNydCAoY2luZm8tPnJl
Z2Jhc2UsIENMX0NSVDI0KSAmIDB4ODApIHsKKwlpZiAodmdhX3JjcnQoY2luZm8tPnJlZ2Jhc2Us
IENMX0NSVDI0KSAmIDB4ODApIHsKIAkJLyogaWYgd2UncmUganVzdCBpbiAid3JpdGUgdmFsdWUi
IG1vZGUsIHdyaXRlIGJhY2sgdGhlICovCiAJCS8qIHNhbWUgdmFsdWUgYXMgYmVmb3JlIHRvIG5v
dCBtb2RpZnkgYW55dGhpbmcgKi8KLQkJdmdhX3cgKGNpbmZvLT5yZWdiYXNlLCBWR0FfQVRUX0lX
LAotCQkgICAgICAgdmdhX3IgKGNpbmZvLT5yZWdiYXNlLCBWR0FfQVRUX1IpKTsKKwkJdmdhX3co
Y2luZm8tPnJlZ2Jhc2UsIFZHQV9BVFRfSVcsCisJCSAgICAgIHZnYV9yKGNpbmZvLT5yZWdiYXNl
LCBWR0FfQVRUX1IpKTsKIAl9CiAJLyogdHVybiBvbiB2aWRlbyBiaXQgKi8KLS8qICAgICAgdmdh
X3cgKGNpbmZvLT5yZWdiYXNlLCBWR0FfQVRUX0lXLCAweDIwKTsgKi8KLQl2Z2FfdyAoY2luZm8t
PnJlZ2Jhc2UsIFZHQV9BVFRfSVcsIDB4MzMpOworLyogICAgICB2Z2FfdyhjaW5mby0+cmVnYmFz
ZSwgVkdBX0FUVF9JVywgMHgyMCk7ICovCisJdmdhX3coY2luZm8tPnJlZ2Jhc2UsIFZHQV9BVFRf
SVcsIDB4MzMpOwogCiAJLyogZHVtbXkgd3JpdGUgb24gUmVnMCB0byBiZSBvbiAid3JpdGUgaW5k
ZXgiIG1vZGUgbmV4dCB0aW1lICovCi0JdmdhX3cgKGNpbmZvLT5yZWdiYXNlLCBWR0FfQVRUX0lX
LCAweDAwKTsKKwl2Z2FfdyhjaW5mby0+cmVnYmFzZSwgVkdBX0FUVF9JVywgMHgwMCk7CiAKLQlE
UFJJTlRLICgiRVhJVFxuIik7CisJRFBSSU5USygiRVhJVFxuIik7CiB9CiAKIC8qKiogV0hEUigp
IC0gd3JpdGUgaW50byB0aGUgSGlkZGVuIERBQyByZWdpc3RlciAqKiovCkBAIC0yNzUwLDExOSAr
MjkxNSwxMTUgQEAgc3RhdGljIHZvaWQgQXR0ck9uIChjb25zdCBzdHJ1Y3QgY2lycnVzZgogICog
cmVnaXN0ZXJzIG9mIHRoZWlyIGZ1bmN0aW9uYWwgZ3JvdXApIGhlcmUgaXMgYSBzcGVjaWFsaXpl
ZCByb3V0aW5lIGZvcgogICogYWNjZXNzaW5nIHRoZSBIRFIKICAqLwotc3RhdGljIHZvaWQgV0hE
UiAoY29uc3Qgc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvLCB1bnNpZ25lZCBjaGFyIHZhbCkK
K3N0YXRpYyB2b2lkIFdIRFIoY29uc3Qgc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvLCB1bnNp
Z25lZCBjaGFyIHZhbCkKIHsKIAl1bnNpZ25lZCBjaGFyIGR1bW15OwogCiAJaWYgKGNpbmZvLT5i
dHlwZSA9PSBCVF9QSUNBU1NPKSB7CiAJCS8qIEtsYXVzJyBoaW50IGZvciBjb3JyZWN0IGFjY2Vz
cyB0byBIRFIgb24gc29tZSBib2FyZHMgKi8KIAkJLyogZmlyc3Qgd3JpdGUgMCB0byBwaXhlbCBt
YXNrICgzYzYpICovCi0JCVdHZW4gKGNpbmZvLCBWR0FfUEVMX01TSywgMHgwMCk7Ci0JCXVkZWxh
eSAoMjAwKTsKKwkJV0dlbihjaW5mbywgVkdBX1BFTF9NU0ssIDB4MDApOworCQl1ZGVsYXkoMjAw
KTsKIAkJLyogbmV4dCByZWFkIGR1bW15IGZyb20gcGl4ZWwgYWRkcmVzcyAoM2M4KSAqLwotCQlk
dW1teSA9IFJHZW4gKGNpbmZvLCBWR0FfUEVMX0lXKTsKLQkJdWRlbGF5ICgyMDApOworCQlkdW1t
eSA9IFJHZW4oY2luZm8sIFZHQV9QRUxfSVcpOworCQl1ZGVsYXkoMjAwKTsKIAl9CiAJLyogbm93
IGRvIHRoZSB1c3VhbCBzdHVmZiB0byBhY2Nlc3MgdGhlIEhEUiAqLwogCi0JZHVtbXkgPSBSR2Vu
IChjaW5mbywgVkdBX1BFTF9NU0spOwotCXVkZWxheSAoMjAwKTsKLQlkdW1teSA9IFJHZW4gKGNp
bmZvLCBWR0FfUEVMX01TSyk7Ci0JdWRlbGF5ICgyMDApOwotCWR1bW15ID0gUkdlbiAoY2luZm8s
IFZHQV9QRUxfTVNLKTsKLQl1ZGVsYXkgKDIwMCk7Ci0JZHVtbXkgPSBSR2VuIChjaW5mbywgVkdB
X1BFTF9NU0spOwotCXVkZWxheSAoMjAwKTsKKwlkdW1teSA9IFJHZW4oY2luZm8sIFZHQV9QRUxf
TVNLKTsKKwl1ZGVsYXkoMjAwKTsKKwlkdW1teSA9IFJHZW4oY2luZm8sIFZHQV9QRUxfTVNLKTsK
Kwl1ZGVsYXkoMjAwKTsKKwlkdW1teSA9IFJHZW4oY2luZm8sIFZHQV9QRUxfTVNLKTsKKwl1ZGVs
YXkoMjAwKTsKKwlkdW1teSA9IFJHZW4oY2luZm8sIFZHQV9QRUxfTVNLKTsKKwl1ZGVsYXkoMjAw
KTsKIAotCVdHZW4gKGNpbmZvLCBWR0FfUEVMX01TSywgdmFsKTsKLQl1ZGVsYXkgKDIwMCk7CisJ
V0dlbihjaW5mbywgVkdBX1BFTF9NU0ssIHZhbCk7CisJdWRlbGF5KDIwMCk7CiAKIAlpZiAoY2lu
Zm8tPmJ0eXBlID09IEJUX1BJQ0FTU08pIHsKIAkJLyogbm93IGZpcnN0IHJlc2V0IEhEUiBhY2Nl
c3MgY291bnRlciAqLwotCQlkdW1teSA9IFJHZW4gKGNpbmZvLCBWR0FfUEVMX0lXKTsKLQkJdWRl
bGF5ICgyMDApOworCQlkdW1teSA9IFJHZW4oY2luZm8sIFZHQV9QRUxfSVcpOworCQl1ZGVsYXko
MjAwKTsKIAogCQkvKiBhbmQgYXQgdGhlIGVuZCwgcmVzdG9yZSB0aGUgbWFzayB2YWx1ZSAqLwog
CQkvKiAjIyBpcyB0aGlzIG1hc2sgYWx3YXlzIDB4ZmY/ICovCi0JCVdHZW4gKGNpbmZvLCBWR0Ff
UEVMX01TSywgMHhmZik7Ci0JCXVkZWxheSAoMjAwKTsKKwkJV0dlbihjaW5mbywgVkdBX1BFTF9N
U0ssIDB4ZmYpOworCQl1ZGVsYXkoMjAwKTsKIAl9CiB9CiAKLQogLyoqKiBXU0ZSKCkgLSB3cml0
ZSB0byB0aGUgInNwZWNpYWwgZnVuY3Rpb24gcmVnaXN0ZXIiIChTRlIpICoqKi8KLXN0YXRpYyB2
b2lkIFdTRlIgKHN0cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbywgdW5zaWduZWQgY2hhciB2YWwp
CitzdGF0aWMgdm9pZCBXU0ZSKHN0cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbywgdW5zaWduZWQg
Y2hhciB2YWwpCiB7CiAjaWZkZWYgQ09ORklHX1pPUlJPCi0JYXNzZXJ0IChjaW5mby0+cmVnYmFz
ZSAhPSBOVUxMKTsKKwlhc3NlcnQoY2luZm8tPnJlZ2Jhc2UgIT0gTlVMTCk7CiAJY2luZm8tPlNG
UiA9IHZhbDsKLQl6X3dyaXRlYiAodmFsLCBjaW5mby0+cmVnYmFzZSArIDB4ODAwMCk7CisJel93
cml0ZWIodmFsLCBjaW5mby0+cmVnYmFzZSArIDB4ODAwMCk7CiAjZW5kaWYKIH0KIAogLyogVGhl
IFBpY2Fzc28gaGFzIGEgc2Vjb25kIHJlZ2lzdGVyIGZvciBzd2l0Y2hpbmcgdGhlIG1vbml0b3Ig
Yml0ICovCi1zdGF0aWMgdm9pZCBXU0ZSMiAoc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvLCB1
bnNpZ25lZCBjaGFyIHZhbCkKK3N0YXRpYyB2b2lkIFdTRlIyKHN0cnVjdCBjaXJydXNmYl9pbmZv
ICpjaW5mbywgdW5zaWduZWQgY2hhciB2YWwpCiB7CiAjaWZkZWYgQ09ORklHX1pPUlJPCiAJLyog
d3JpdGluZyBhbiBhcmJpdHJhcnkgdmFsdWUgdG8gdGhpcyBvbmUgY2F1c2VzIHRoZSBtb25pdG9y
IHN3aXRjaGVyICovCiAJLyogdG8gZmxpcCB0byBBbWlnYSBkaXNwbGF5ICovCi0JYXNzZXJ0IChj
aW5mby0+cmVnYmFzZSAhPSBOVUxMKTsKKwlhc3NlcnQoY2luZm8tPnJlZ2Jhc2UgIT0gTlVMTCk7
CiAJY2luZm8tPlNGUiA9IHZhbDsKLQl6X3dyaXRlYiAodmFsLCBjaW5mby0+cmVnYmFzZSArIDB4
OTAwMCk7CisJel93cml0ZWIodmFsLCBjaW5mby0+cmVnYmFzZSArIDB4OTAwMCk7CiAjZW5kaWYK
IH0KIAotCiAvKioqIFdDbHV0IC0gc2V0IENMVVQgZW50cnkgKHJhbmdlOiAwLi42MykgKioqLwot
c3RhdGljIHZvaWQgV0NsdXQgKHN0cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbywgdW5zaWduZWQg
Y2hhciByZWdudW0sIHVuc2lnbmVkIGNoYXIgcmVkLAorc3RhdGljIHZvaWQgV0NsdXQoc3RydWN0
IGNpcnJ1c2ZiX2luZm8gKmNpbmZvLCB1bnNpZ25lZCBjaGFyIHJlZ251bSwgdW5zaWduZWQgY2hh
ciByZWQsCiAJICAgIHVuc2lnbmVkIGNoYXIgZ3JlZW4sIHVuc2lnbmVkIGNoYXIgYmx1ZSkKIHsK
IAl1bnNpZ25lZCBpbnQgZGF0YSA9IFZHQV9QRUxfRDsKIAogCS8qIGFkZHJlc3Mgd3JpdGUgbW9k
ZSByZWdpc3RlciBpcyBub3QgdHJhbnNsYXRlZC4uICovCi0JdmdhX3cgKGNpbmZvLT5yZWdiYXNl
LCBWR0FfUEVMX0lXLCByZWdudW0pOworCXZnYV93KGNpbmZvLT5yZWdiYXNlLCBWR0FfUEVMX0lX
LCByZWdudW0pOwogCiAJaWYgKGNpbmZvLT5idHlwZSA9PSBCVF9QSUNBU1NPIHx8IGNpbmZvLT5i
dHlwZSA9PSBCVF9QSUNBU1NPNCB8fAogCSAgICBjaW5mby0+YnR5cGUgPT0gQlRfQUxQSU5FIHx8
IGNpbmZvLT5idHlwZSA9PSBCVF9HRDU0ODApIHsKIAkJLyogYnV0IERBQyBkYXRhIHJlZ2lzdGVy
IElTLCBhdCBsZWFzdCBmb3IgUGljYXNzbyBJSSAqLwogCQlpZiAoY2luZm8tPmJ0eXBlID09IEJU
X1BJQ0FTU08pCiAJCQlkYXRhICs9IDB4ZmZmOwotCQl2Z2FfdyAoY2luZm8tPnJlZ2Jhc2UsIGRh
dGEsIHJlZCk7Ci0JCXZnYV93IChjaW5mby0+cmVnYmFzZSwgZGF0YSwgZ3JlZW4pOwotCQl2Z2Ff
dyAoY2luZm8tPnJlZ2Jhc2UsIGRhdGEsIGJsdWUpOworCQl2Z2FfdyhjaW5mby0+cmVnYmFzZSwg
ZGF0YSwgcmVkKTsKKwkJdmdhX3coY2luZm8tPnJlZ2Jhc2UsIGRhdGEsIGdyZWVuKTsKKwkJdmdh
X3coY2luZm8tPnJlZ2Jhc2UsIGRhdGEsIGJsdWUpOwogCX0gZWxzZSB7Ci0JCXZnYV93IChjaW5m
by0+cmVnYmFzZSwgZGF0YSwgYmx1ZSk7Ci0JCXZnYV93IChjaW5mby0+cmVnYmFzZSwgZGF0YSwg
Z3JlZW4pOwotCQl2Z2FfdyAoY2luZm8tPnJlZ2Jhc2UsIGRhdGEsIHJlZCk7CisJCXZnYV93KGNp
bmZvLT5yZWdiYXNlLCBkYXRhLCBibHVlKTsKKwkJdmdhX3coY2luZm8tPnJlZ2Jhc2UsIGRhdGEs
IGdyZWVuKTsKKwkJdmdhX3coY2luZm8tPnJlZ2Jhc2UsIGRhdGEsIHJlZCk7CiAJfQogfQogCi0K
ICNpZiAwCiAvKioqIFJDbHV0IC0gcmVhZCBDTFVUIGVudHJ5IChyYW5nZSAwLi42MykgKioqLwot
c3RhdGljIHZvaWQgUkNsdXQgKHN0cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbywgdW5zaWduZWQg
Y2hhciByZWdudW0sIHVuc2lnbmVkIGNoYXIgKnJlZCwKK3N0YXRpYyB2b2lkIFJDbHV0KHN0cnVj
dCBjaXJydXNmYl9pbmZvICpjaW5mbywgdW5zaWduZWQgY2hhciByZWdudW0sIHVuc2lnbmVkIGNo
YXIgKnJlZCwKIAkgICAgdW5zaWduZWQgY2hhciAqZ3JlZW4sIHVuc2lnbmVkIGNoYXIgKmJsdWUp
CiB7CiAJdW5zaWduZWQgaW50IGRhdGEgPSBWR0FfUEVMX0Q7CiAKLQl2Z2FfdyAoY2luZm8tPnJl
Z2Jhc2UsIFZHQV9QRUxfSVIsIHJlZ251bSk7CisJdmdhX3coY2luZm8tPnJlZ2Jhc2UsIFZHQV9Q
RUxfSVIsIHJlZ251bSk7CiAKIAlpZiAoY2luZm8tPmJ0eXBlID09IEJUX1BJQ0FTU08gfHwgY2lu
Zm8tPmJ0eXBlID09IEJUX1BJQ0FTU080IHx8CiAJICAgIGNpbmZvLT5idHlwZSA9PSBCVF9BTFBJ
TkUgfHwgY2luZm8tPmJ0eXBlID09IEJUX0dENTQ4MCkgewogCQlpZiAoY2luZm8tPmJ0eXBlID09
IEJUX1BJQ0FTU08pCiAJCQlkYXRhICs9IDB4ZmZmOwotCQkqcmVkID0gdmdhX3IgKGNpbmZvLT5y
ZWdiYXNlLCBkYXRhKTsKLQkJKmdyZWVuID0gdmdhX3IgKGNpbmZvLT5yZWdiYXNlLCBkYXRhKTsK
LQkJKmJsdWUgPSB2Z2FfciAoY2luZm8tPnJlZ2Jhc2UsIGRhdGEpOworCQkqcmVkID0gdmdhX3Io
Y2luZm8tPnJlZ2Jhc2UsIGRhdGEpOworCQkqZ3JlZW4gPSB2Z2FfcihjaW5mby0+cmVnYmFzZSwg
ZGF0YSk7CisJCSpibHVlID0gdmdhX3IoY2luZm8tPnJlZ2Jhc2UsIGRhdGEpOwogCX0gZWxzZSB7
Ci0JCSpibHVlID0gdmdhX3IgKGNpbmZvLT5yZWdiYXNlLCBkYXRhKTsKLQkJKmdyZWVuID0gdmdh
X3IgKGNpbmZvLT5yZWdiYXNlLCBkYXRhKTsKLQkJKnJlZCA9IHZnYV9yIChjaW5mby0+cmVnYmFz
ZSwgZGF0YSk7CisJCSpibHVlID0gdmdhX3IoY2luZm8tPnJlZ2Jhc2UsIGRhdGEpOworCQkqZ3Jl
ZW4gPSB2Z2FfcihjaW5mby0+cmVnYmFzZSwgZGF0YSk7CisJCSpyZWQgPSB2Z2FfcihjaW5mby0+
cmVnYmFzZSwgZGF0YSk7CiAJfQogfQogI2VuZGlmCiAKLQogLyoqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKIAljaXJydXNm
Yl9XYWl0QkxUKCkKIApAQCAtMjg3MCwxMCArMzAzMSwxMCBAQCBzdGF0aWMgdm9pZCBSQ2x1dCAo
c3RydWN0IGNpcnJ1c2ZiX2luZm8gCiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCiAKIC8qIEZJWE1FOiB1c2UgaW50
ZXJydXB0cyBpbnN0ZWFkICovCi1zdGF0aWMgdm9pZCBjaXJydXNmYl9XYWl0QkxUICh1OCBfX2lv
bWVtICpyZWdiYXNlKQorc3RhdGljIHZvaWQgY2lycnVzZmJfV2FpdEJMVCh1OCBfX2lvbWVtICpy
ZWdiYXNlKQogewogCS8qIG5vdyBidXN5LXdhaXQgdW50aWwgd2UncmUgZG9uZSAqLwotCXdoaWxl
ICh2Z2FfcmdmeCAocmVnYmFzZSwgQ0xfR1IzMSkgJiAweDA4KQorCXdoaWxlICh2Z2FfcmdmeChy
ZWdiYXNlLCBDTF9HUjMxKSAmIDB4MDgpCiAJCS8qIGRvIG5vdGhpbmcgKi8gOwogfQogCkBAIC0y
ODgzLDE1ICszMDQ0LDE3IEBAIHN0YXRpYyB2b2lkIGNpcnJ1c2ZiX1dhaXRCTFQgKHU4IF9faW9t
ZW0KIAlwZXJmb3JtIGFjY2VsZXJhdGVkICJzY3JvbGxpbmciCiAqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KIAotc3Rh
dGljIHZvaWQgY2lycnVzZmJfQml0QkxUICh1OCBfX2lvbWVtICpyZWdiYXNlLCBpbnQgYml0c19w
ZXJfcGl4ZWwsCi0JCQkgICAgIHVfc2hvcnQgY3VyeCwgdV9zaG9ydCBjdXJ5LCB1X3Nob3J0IGRl
c3R4LCB1X3Nob3J0IGRlc3R5LAotCQkJICAgICB1X3Nob3J0IHdpZHRoLCB1X3Nob3J0IGhlaWdo
dCwgdV9zaG9ydCBsaW5lX2xlbmd0aCkKK3N0YXRpYyB2b2lkIGNpcnJ1c2ZiX0JpdEJMVCh1OCBf
X2lvbWVtICpyZWdiYXNlLCBpbnQgYml0c19wZXJfcGl4ZWwsCisJCQkgICAgdV9zaG9ydCBjdXJ4
LCB1X3Nob3J0IGN1cnksCisJCQkgICAgdV9zaG9ydCBkZXN0eCwgdV9zaG9ydCBkZXN0eSwKKwkJ
CSAgICB1X3Nob3J0IHdpZHRoLCB1X3Nob3J0IGhlaWdodCwKKwkJCSAgICB1X3Nob3J0IGxpbmVf
bGVuZ3RoKQogewogCXVfc2hvcnQgbndpZHRoLCBuaGVpZ2h0OwogCXVfbG9uZyBuc3JjLCBuZGVz
dDsKIAl1X2NoYXIgYmx0bW9kZTsKIAotCURQUklOVEsgKCJFTlRFUlxuIik7CisJRFBSSU5USygi
RU5URVJcbiIpOwogCiAJbndpZHRoID0gd2lkdGggLSAxOwogCW5oZWlnaHQgPSBoZWlnaHQgLSAx
OwpAQCAtMjkxMSw5ICszMDc0LDEzIEBAIHN0YXRpYyB2b2lkIGNpcnJ1c2ZiX0JpdEJMVCAodTgg
X19pb21lbSAKIAkJbnNyYyA9IChjdXJ5ICogbGluZV9sZW5ndGgpICsgY3VyeDsKIAkJbmRlc3Qg
PSAoZGVzdHkgKiBsaW5lX2xlbmd0aCkgKyBkZXN0eDsKIAl9IGVsc2UgewotCQkvKiB0aGlzIG1l
YW5zIHN0YXJ0IGFkZHJlc3NlcyBhcmUgYXQgdGhlIGVuZCwgY291bnRpbmcgYmFja3dhcmRzICov
Ci0JCW5zcmMgPSBjdXJ5ICogbGluZV9sZW5ndGggKyBjdXJ4ICsgbmhlaWdodCAqIGxpbmVfbGVu
Z3RoICsgbndpZHRoOwotCQluZGVzdCA9IGRlc3R5ICogbGluZV9sZW5ndGggKyBkZXN0eCArIG5o
ZWlnaHQgKiBsaW5lX2xlbmd0aCArIG53aWR0aDsKKwkJLyogdGhpcyBtZWFucyBzdGFydCBhZGRy
ZXNzZXMgYXJlIGF0IHRoZSBlbmQsCisJCSAqIGNvdW50aW5nIGJhY2t3YXJkcworCQkgKi8KKwkJ
bnNyYyA9IGN1cnkgKiBsaW5lX2xlbmd0aCArIGN1cnggKworCQkJbmhlaWdodCAqIGxpbmVfbGVu
Z3RoICsgbndpZHRoOworCQluZGVzdCA9IGRlc3R5ICogbGluZV9sZW5ndGggKyBkZXN0eCArCisJ
CQluaGVpZ2h0ICogbGluZV9sZW5ndGggKyBud2lkdGg7CiAJfQogCiAJLyoKQEAgLTI5MjksNTIg
KzMwOTYsNjUgQEAgc3RhdGljIHZvaWQgY2lycnVzZmJfQml0QkxUICh1OCBfX2lvbWVtIAogCSAg
IHN0YXJ0L3N0b3AKIAkgKi8KIAotICAgICAgICBjaXJydXNmYl9XYWl0QkxUKHJlZ2Jhc2UpOwor
CWNpcnJ1c2ZiX1dhaXRCTFQocmVnYmFzZSk7CiAKIAkvKiBwaXRjaDogc2V0IHRvIGxpbmVfbGVu
Z3RoICovCi0JdmdhX3dnZnggKHJlZ2Jhc2UsIENMX0dSMjQsIGxpbmVfbGVuZ3RoICYgMHhmZik7
CS8qIGRlc3QgcGl0Y2ggbG93ICovCi0JdmdhX3dnZnggKHJlZ2Jhc2UsIENMX0dSMjUsIChsaW5l
X2xlbmd0aCA+PiA4KSk7CS8qIGRlc3QgcGl0Y2ggaGkgKi8KLQl2Z2Ffd2dmeCAocmVnYmFzZSwg
Q0xfR1IyNiwgbGluZV9sZW5ndGggJiAweGZmKTsJLyogc291cmNlIHBpdGNoIGxvdyAqLwotCXZn
YV93Z2Z4IChyZWdiYXNlLCBDTF9HUjI3LCAobGluZV9sZW5ndGggPj4gOCkpOwkvKiBzb3VyY2Ug
cGl0Y2ggaGkgKi8KKwkvKiBkZXN0IHBpdGNoIGxvdyAqLworCXZnYV93Z2Z4KHJlZ2Jhc2UsIENM
X0dSMjQsIGxpbmVfbGVuZ3RoICYgMHhmZik7CisJLyogZGVzdCBwaXRjaCBoaSAqLworCXZnYV93
Z2Z4KHJlZ2Jhc2UsIENMX0dSMjUsIGxpbmVfbGVuZ3RoID4+IDgpOworCS8qIHNvdXJjZSBwaXRj
aCBsb3cgKi8KKwl2Z2Ffd2dmeChyZWdiYXNlLCBDTF9HUjI2LCBsaW5lX2xlbmd0aCAmIDB4ZmYp
OworCS8qIHNvdXJjZSBwaXRjaCBoaSAqLworCXZnYV93Z2Z4KHJlZ2Jhc2UsIENMX0dSMjcsIGxp
bmVfbGVuZ3RoID4+IDgpOwogCiAJLyogQkxUIHdpZHRoOiBhY3R1YWwgbnVtYmVyIG9mIHBpeGVs
cyAtIDEgKi8KLQl2Z2Ffd2dmeCAocmVnYmFzZSwgQ0xfR1IyMCwgbndpZHRoICYgMHhmZik7CS8q
IEJMVCB3aWR0aCBsb3cgKi8KLQl2Z2Ffd2dmeCAocmVnYmFzZSwgQ0xfR1IyMSwgKG53aWR0aCA+
PiA4KSk7CS8qIEJMVCB3aWR0aCBoaSAqLworCS8qIEJMVCB3aWR0aCBsb3cgKi8KKwl2Z2Ffd2dm
eChyZWdiYXNlLCBDTF9HUjIwLCBud2lkdGggJiAweGZmKTsKKwkvKiBCTFQgd2lkdGggaGkgKi8K
Kwl2Z2Ffd2dmeChyZWdiYXNlLCBDTF9HUjIxLCBud2lkdGggPj4gOCk7CiAKIAkvKiBCTFQgaGVp
Z2h0OiBhY3R1YWwgbnVtYmVyIG9mIGxpbmVzIC0xICovCi0JdmdhX3dnZnggKHJlZ2Jhc2UsIENM
X0dSMjIsIG5oZWlnaHQgJiAweGZmKTsJLyogQkxUIGhlaWdodCBsb3cgKi8KLQl2Z2Ffd2dmeCAo
cmVnYmFzZSwgQ0xfR1IyMywgKG5oZWlnaHQgPj4gOCkpOwkvKiBCTFQgd2lkdGggaGkgKi8KKwkv
KiBCTFQgaGVpZ2h0IGxvdyAqLworCXZnYV93Z2Z4KHJlZ2Jhc2UsIENMX0dSMjIsIG5oZWlnaHQg
JiAweGZmKTsKKwkvKiBCTFQgd2lkdGggaGkgKi8KKwl2Z2Ffd2dmeChyZWdiYXNlLCBDTF9HUjIz
LCBuaGVpZ2h0ID4+IDgpOwogCiAJLyogQkxUIGRlc3RpbmF0aW9uICovCi0JdmdhX3dnZnggKHJl
Z2Jhc2UsIENMX0dSMjgsICh1X2NoYXIpIChuZGVzdCAmIDB4ZmYpKTsJLyogQkxUIGRlc3QgbG93
ICovCi0JdmdhX3dnZnggKHJlZ2Jhc2UsIENMX0dSMjksICh1X2NoYXIpIChuZGVzdCA+PiA4KSk7
CS8qIEJMVCBkZXN0IG1pZCAqLwotCXZnYV93Z2Z4IChyZWdiYXNlLCBDTF9HUjJBLCAodV9jaGFy
KSAobmRlc3QgPj4gMTYpKTsJLyogQkxUIGRlc3QgaGkgKi8KKwkvKiBCTFQgZGVzdCBsb3cgKi8K
Kwl2Z2Ffd2dmeChyZWdiYXNlLCBDTF9HUjI4LCAodV9jaGFyKSAobmRlc3QgJiAweGZmKSk7CisJ
LyogQkxUIGRlc3QgbWlkICovCisJdmdhX3dnZngocmVnYmFzZSwgQ0xfR1IyOSwgKHVfY2hhcikg
KG5kZXN0ID4+IDgpKTsKKwkvKiBCTFQgZGVzdCBoaSAqLworCXZnYV93Z2Z4KHJlZ2Jhc2UsIENM
X0dSMkEsICh1X2NoYXIpIChuZGVzdCA+PiAxNikpOwogCiAJLyogQkxUIHNvdXJjZSAqLwotCXZn
YV93Z2Z4IChyZWdiYXNlLCBDTF9HUjJDLCAodV9jaGFyKSAobnNyYyAmIDB4ZmYpKTsJLyogQkxU
IHNyYyBsb3cgKi8KLQl2Z2Ffd2dmeCAocmVnYmFzZSwgQ0xfR1IyRCwgKHVfY2hhcikgKG5zcmMg
Pj4gOCkpOwkJLyogQkxUIHNyYyBtaWQgKi8KLQl2Z2Ffd2dmeCAocmVnYmFzZSwgQ0xfR1IyRSwg
KHVfY2hhcikgKG5zcmMgPj4gMTYpKTsJLyogQkxUIHNyYyBoaSAqLworCS8qIEJMVCBzcmMgbG93
ICovCisJdmdhX3dnZngocmVnYmFzZSwgQ0xfR1IyQywgKHVfY2hhcikgKG5zcmMgJiAweGZmKSk7
CisJLyogQkxUIHNyYyBtaWQgKi8KKwl2Z2Ffd2dmeChyZWdiYXNlLCBDTF9HUjJELCAodV9jaGFy
KSAobnNyYyA+PiA4KSk7CisJLyogQkxUIHNyYyBoaSAqLworCXZnYV93Z2Z4KHJlZ2Jhc2UsIENM
X0dSMkUsICh1X2NoYXIpIChuc3JjID4+IDE2KSk7CiAKIAkvKiBCTFQgbW9kZSAqLwotCXZnYV93
Z2Z4IChyZWdiYXNlLCBDTF9HUjMwLCBibHRtb2RlKTsJLyogQkxUIG1vZGUgKi8KKwl2Z2Ffd2dm
eChyZWdiYXNlLCBDTF9HUjMwLCBibHRtb2RlKTsJLyogQkxUIG1vZGUgKi8KIAogCS8qIEJMVCBS
T1A6IFNyY0NvcHkgKi8KLQl2Z2Ffd2dmeCAocmVnYmFzZSwgQ0xfR1IzMiwgMHgwZCk7CQkvKiBC
TFQgUk9QICovCisJdmdhX3dnZngocmVnYmFzZSwgQ0xfR1IzMiwgMHgwZCk7CS8qIEJMVCBST1Ag
Ki8KIAogCS8qIGFuZCBmaW5hbGx5OiBHTyEgKi8KLQl2Z2Ffd2dmeCAocmVnYmFzZSwgQ0xfR1Iz
MSwgMHgwMik7CQkvKiBCTFQgU3RhcnQvc3RhdHVzICovCisJdmdhX3dnZngocmVnYmFzZSwgQ0xf
R1IzMSwgMHgwMik7CS8qIEJMVCBTdGFydC9zdGF0dXMgKi8KIAotCURQUklOVEsgKCJFWElUXG4i
KTsKKwlEUFJJTlRLKCJFWElUXG4iKTsKIH0KIAotCiAvKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgogCWNpcnJ1c2ZiX1Jl
Y3RGaWxsKCkKIAogCXBlcmZvcm0gYWNjZWxlcmF0ZWQgcmVjdGFuZ2xlIGZpbGwKICoqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqLwogCi1zdGF0aWMgdm9pZCBjaXJydXNmYl9SZWN0RmlsbCAodTggX19pb21lbSAqcmVnYmFz
ZSwgaW50IGJpdHNfcGVyX3BpeGVsLAorc3RhdGljIHZvaWQgY2lycnVzZmJfUmVjdEZpbGwodTgg
X19pb21lbSAqcmVnYmFzZSwgaW50IGJpdHNfcGVyX3BpeGVsLAogCQkgICAgIHVfc2hvcnQgeCwg
dV9zaG9ydCB5LCB1X3Nob3J0IHdpZHRoLCB1X3Nob3J0IGhlaWdodCwKIAkJICAgICB1X2NoYXIg
Y29sb3IsIHVfc2hvcnQgbGluZV9sZW5ndGgpCiB7CkBAIC0yOTgyLDkzICszMTYyLDk1IEBAIHN0
YXRpYyB2b2lkIGNpcnJ1c2ZiX1JlY3RGaWxsICh1OCBfX2lvbWUKIAl1X2xvbmcgbmRlc3Q7CiAJ
dV9jaGFyIG9wOwogCi0JRFBSSU5USyAoIkVOVEVSXG4iKTsKKwlEUFJJTlRLKCJFTlRFUlxuIik7
CiAKIAlud2lkdGggPSB3aWR0aCAtIDE7CiAJbmhlaWdodCA9IGhlaWdodCAtIDE7CiAKIAluZGVz
dCA9ICh5ICogbGluZV9sZW5ndGgpICsgeDsKIAotICAgICAgICBjaXJydXNmYl9XYWl0QkxUKHJl
Z2Jhc2UpOworCWNpcnJ1c2ZiX1dhaXRCTFQocmVnYmFzZSk7CiAKIAkvKiBwaXRjaDogc2V0IHRv
IGxpbmVfbGVuZ3RoICovCi0JdmdhX3dnZnggKHJlZ2Jhc2UsIENMX0dSMjQsIGxpbmVfbGVuZ3Ro
ICYgMHhmZik7CS8qIGRlc3QgcGl0Y2ggbG93ICovCi0JdmdhX3dnZnggKHJlZ2Jhc2UsIENMX0dS
MjUsIChsaW5lX2xlbmd0aCA+PiA4KSk7CS8qIGRlc3QgcGl0Y2ggaGkgKi8KLQl2Z2Ffd2dmeCAo
cmVnYmFzZSwgQ0xfR1IyNiwgbGluZV9sZW5ndGggJiAweGZmKTsJLyogc291cmNlIHBpdGNoIGxv
dyAqLwotCXZnYV93Z2Z4IChyZWdiYXNlLCBDTF9HUjI3LCAobGluZV9sZW5ndGggPj4gOCkpOwkv
KiBzb3VyY2UgcGl0Y2ggaGkgKi8KKwl2Z2Ffd2dmeChyZWdiYXNlLCBDTF9HUjI0LCBsaW5lX2xl
bmd0aCAmIDB4ZmYpOwkvKiBkZXN0IHBpdGNoIGxvdyAqLworCXZnYV93Z2Z4KHJlZ2Jhc2UsIENM
X0dSMjUsIGxpbmVfbGVuZ3RoID4+IDgpOwkvKiBkZXN0IHBpdGNoIGhpICovCisJdmdhX3dnZngo
cmVnYmFzZSwgQ0xfR1IyNiwgbGluZV9sZW5ndGggJiAweGZmKTsJLyogc291cmNlIHBpdGNoIGxv
dyAqLworCXZnYV93Z2Z4KHJlZ2Jhc2UsIENMX0dSMjcsIGxpbmVfbGVuZ3RoID4+IDgpOwkvKiBz
b3VyY2UgcGl0Y2ggaGkgKi8KIAogCS8qIEJMVCB3aWR0aDogYWN0dWFsIG51bWJlciBvZiBwaXhl
bHMgLSAxICovCi0JdmdhX3dnZnggKHJlZ2Jhc2UsIENMX0dSMjAsIG53aWR0aCAmIDB4ZmYpOwkv
KiBCTFQgd2lkdGggbG93ICovCi0JdmdhX3dnZnggKHJlZ2Jhc2UsIENMX0dSMjEsIChud2lkdGgg
Pj4gOCkpOwkvKiBCTFQgd2lkdGggaGkgKi8KKwl2Z2Ffd2dmeChyZWdiYXNlLCBDTF9HUjIwLCBu
d2lkdGggJiAweGZmKTsJLyogQkxUIHdpZHRoIGxvdyAqLworCXZnYV93Z2Z4KHJlZ2Jhc2UsIENM
X0dSMjEsIG53aWR0aCA+PiA4KTsJLyogQkxUIHdpZHRoIGhpICovCiAKIAkvKiBCTFQgaGVpZ2h0
OiBhY3R1YWwgbnVtYmVyIG9mIGxpbmVzIC0xICovCi0JdmdhX3dnZnggKHJlZ2Jhc2UsIENMX0dS
MjIsIG5oZWlnaHQgJiAweGZmKTsJCS8qIEJMVCBoZWlnaHQgbG93ICovCi0JdmdhX3dnZnggKHJl
Z2Jhc2UsIENMX0dSMjMsIChuaGVpZ2h0ID4+IDgpKTsJCS8qIEJMVCB3aWR0aCBoaSAqLworCXZn
YV93Z2Z4KHJlZ2Jhc2UsIENMX0dSMjIsIG5oZWlnaHQgJiAweGZmKTsJLyogQkxUIGhlaWdodCBs
b3cgKi8KKwl2Z2Ffd2dmeChyZWdiYXNlLCBDTF9HUjIzLCBuaGVpZ2h0ID4+IDgpOwkvKiBCTFQg
d2lkdGggaGkgKi8KIAogCS8qIEJMVCBkZXN0aW5hdGlvbiAqLwotCXZnYV93Z2Z4IChyZWdiYXNl
LCBDTF9HUjI4LCAodV9jaGFyKSAobmRlc3QgJiAweGZmKSk7CS8qIEJMVCBkZXN0IGxvdyAqLwot
CXZnYV93Z2Z4IChyZWdiYXNlLCBDTF9HUjI5LCAodV9jaGFyKSAobmRlc3QgPj4gOCkpOwkvKiBC
TFQgZGVzdCBtaWQgKi8KLQl2Z2Ffd2dmeCAocmVnYmFzZSwgQ0xfR1IyQSwgKHVfY2hhcikgKG5k
ZXN0ID4+IDE2KSk7CQkvKiBCTFQgZGVzdCBoaSAqLworCS8qIEJMVCBkZXN0IGxvdyAqLworCXZn
YV93Z2Z4KHJlZ2Jhc2UsIENMX0dSMjgsICh1X2NoYXIpIChuZGVzdCAmIDB4ZmYpKTsKKwkvKiBC
TFQgZGVzdCBtaWQgKi8KKwl2Z2Ffd2dmeChyZWdiYXNlLCBDTF9HUjI5LCAodV9jaGFyKSAobmRl
c3QgPj4gOCkpOworCS8qIEJMVCBkZXN0IGhpICovCisJdmdhX3dnZngocmVnYmFzZSwgQ0xfR1Iy
QSwgKHVfY2hhcikgKG5kZXN0ID4+IDE2KSk7CiAKIAkvKiBCTFQgc291cmNlOiBzZXQgdG8gMCAo
aXMgYSBkdW1teSBoZXJlIGFueXdheSkgKi8KLQl2Z2Ffd2dmeCAocmVnYmFzZSwgQ0xfR1IyQywg
MHgwMCk7CS8qIEJMVCBzcmMgbG93ICovCi0JdmdhX3dnZnggKHJlZ2Jhc2UsIENMX0dSMkQsIDB4
MDApOwkvKiBCTFQgc3JjIG1pZCAqLwotCXZnYV93Z2Z4IChyZWdiYXNlLCBDTF9HUjJFLCAweDAw
KTsJLyogQkxUIHNyYyBoaSAqLworCXZnYV93Z2Z4KHJlZ2Jhc2UsIENMX0dSMkMsIDB4MDApOwkv
KiBCTFQgc3JjIGxvdyAqLworCXZnYV93Z2Z4KHJlZ2Jhc2UsIENMX0dSMkQsIDB4MDApOwkvKiBC
TFQgc3JjIG1pZCAqLworCXZnYV93Z2Z4KHJlZ2Jhc2UsIENMX0dSMkUsIDB4MDApOwkvKiBCTFQg
c3JjIGhpICovCiAKIAkvKiBUaGlzIGlzIGEgQ29sb3JFeHBhbmQgQmx0LCB1c2luZyB0aGUgKi8K
IAkvKiBzYW1lIGNvbG9yIGZvciBmb3JlZ3JvdW5kIGFuZCBiYWNrZ3JvdW5kICovCi0JdmdhX3dn
ZnggKHJlZ2Jhc2UsIFZHQV9HRlhfU1JfVkFMVUUsIGNvbG9yKTsJLyogZm9yZWdyb3VuZCBjb2xv
ciAqLwotCXZnYV93Z2Z4IChyZWdiYXNlLCBWR0FfR0ZYX1NSX0VOQUJMRSwgY29sb3IpOwkvKiBi
YWNrZ3JvdW5kIGNvbG9yICovCisJdmdhX3dnZngocmVnYmFzZSwgVkdBX0dGWF9TUl9WQUxVRSwg
Y29sb3IpOwkvKiBmb3JlZ3JvdW5kIGNvbG9yICovCisJdmdhX3dnZngocmVnYmFzZSwgVkdBX0dG
WF9TUl9FTkFCTEUsIGNvbG9yKTsJLyogYmFja2dyb3VuZCBjb2xvciAqLwogCiAJb3AgPSAweGMw
OwogCWlmIChiaXRzX3Blcl9waXhlbCA9PSAxNikgewotCQl2Z2Ffd2dmeCAocmVnYmFzZSwgQ0xf
R1IxMCwgY29sb3IpOwkvKiBmb3JlZ3JvdW5kIGNvbG9yICovCi0JCXZnYV93Z2Z4IChyZWdiYXNl
LCBDTF9HUjExLCBjb2xvcik7CS8qIGJhY2tncm91bmQgY29sb3IgKi8KKwkJdmdhX3dnZngocmVn
YmFzZSwgQ0xfR1IxMCwgY29sb3IpOwkvKiBmb3JlZ3JvdW5kIGNvbG9yICovCisJCXZnYV93Z2Z4
KHJlZ2Jhc2UsIENMX0dSMTEsIGNvbG9yKTsJLyogYmFja2dyb3VuZCBjb2xvciAqLwogCQlvcCA9
IDB4NTA7CiAJCW9wID0gMHhkMDsKIAl9IGVsc2UgaWYgKGJpdHNfcGVyX3BpeGVsID09IDMyKSB7
Ci0JCXZnYV93Z2Z4IChyZWdiYXNlLCBDTF9HUjEwLCBjb2xvcik7CS8qIGZvcmVncm91bmQgY29s
b3IgKi8KLQkJdmdhX3dnZnggKHJlZ2Jhc2UsIENMX0dSMTEsIGNvbG9yKTsJLyogYmFja2dyb3Vu
ZCBjb2xvciAqLwotCQl2Z2Ffd2dmeCAocmVnYmFzZSwgQ0xfR1IxMiwgY29sb3IpOwkvKiBmb3Jl
Z3JvdW5kIGNvbG9yICovCi0JCXZnYV93Z2Z4IChyZWdiYXNlLCBDTF9HUjEzLCBjb2xvcik7CS8q
IGJhY2tncm91bmQgY29sb3IgKi8KLQkJdmdhX3dnZnggKHJlZ2Jhc2UsIENMX0dSMTQsIDApOwkv
KiBmb3JlZ3JvdW5kIGNvbG9yICovCi0JCXZnYV93Z2Z4IChyZWdiYXNlLCBDTF9HUjE1LCAwKTsJ
LyogYmFja2dyb3VuZCBjb2xvciAqLworCQl2Z2Ffd2dmeChyZWdiYXNlLCBDTF9HUjEwLCBjb2xv
cik7CS8qIGZvcmVncm91bmQgY29sb3IgKi8KKwkJdmdhX3dnZngocmVnYmFzZSwgQ0xfR1IxMSwg
Y29sb3IpOwkvKiBiYWNrZ3JvdW5kIGNvbG9yICovCisJCXZnYV93Z2Z4KHJlZ2Jhc2UsIENMX0dS
MTIsIGNvbG9yKTsJLyogZm9yZWdyb3VuZCBjb2xvciAqLworCQl2Z2Ffd2dmeChyZWdiYXNlLCBD
TF9HUjEzLCBjb2xvcik7CS8qIGJhY2tncm91bmQgY29sb3IgKi8KKwkJdmdhX3dnZngocmVnYmFz
ZSwgQ0xfR1IxNCwgMCk7CS8qIGZvcmVncm91bmQgY29sb3IgKi8KKwkJdmdhX3dnZngocmVnYmFz
ZSwgQ0xfR1IxNSwgMCk7CS8qIGJhY2tncm91bmQgY29sb3IgKi8KIAkJb3AgPSAweDUwOwogCQlv
cCA9IDB4ZjA7CiAJfQogCS8qIEJMVCBtb2RlOiBjb2xvciBleHBhbmQsIEVuYWJsZSA4eDggY29w
eSAoZmFzdGVyPykgKi8KLQl2Z2Ffd2dmeCAocmVnYmFzZSwgQ0xfR1IzMCwgb3ApOwkvKiBCTFQg
bW9kZSAqLworCXZnYV93Z2Z4KHJlZ2Jhc2UsIENMX0dSMzAsIG9wKTsJLyogQkxUIG1vZGUgKi8K
IAogCS8qIEJMVCBST1A6IFNyY0NvcHkgKi8KLQl2Z2Ffd2dmeCAocmVnYmFzZSwgQ0xfR1IzMiwg
MHgwZCk7CS8qIEJMVCBST1AgKi8KKwl2Z2Ffd2dmeChyZWdiYXNlLCBDTF9HUjMyLCAweDBkKTsJ
LyogQkxUIFJPUCAqLwogCiAJLyogYW5kIGZpbmFsbHk6IEdPISAqLwotCXZnYV93Z2Z4IChyZWdi
YXNlLCBDTF9HUjMxLCAweDAyKTsJLyogQkxUIFN0YXJ0L3N0YXR1cyAqLworCXZnYV93Z2Z4KHJl
Z2Jhc2UsIENMX0dSMzEsIDB4MDIpOwkvKiBCTFQgU3RhcnQvc3RhdHVzICovCiAKLQlEUFJJTlRL
ICgiRVhJVFxuIik7CisJRFBSSU5USygiRVhJVFxuIik7CiB9CiAKLQogLyoqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqCiAgKiBiZXN0Y2xvY2soKSAtIGRldGVybWluZSBjbG9zZXN0IHBvc3NpYmxlIGNsb2NrIGxv
d2VyKD8pIHRoYW4gdGhlCiAgKiBkZXNpcmVkIHBpeGVsIGNsb2NrCiAgKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KiovCi1zdGF0aWMgdm9pZCBiZXN0Y2xvY2sgKGxvbmcgZnJlcSwgbG9uZyAqYmVzdCwgbG9uZyAq
bm9tLAorc3RhdGljIHZvaWQgYmVzdGNsb2NrKGxvbmcgZnJlcSwgbG9uZyAqYmVzdCwgbG9uZyAq
bm9tLAogCQkgICAgICAgbG9uZyAqZGVuLCBsb25nICpkaXYsIGxvbmcgbWF4ZnJlcSkKIHsKIAls
b25nIG4sIGgsIGQsIGY7CiAKLQlhc3NlcnQgKGJlc3QgIT0gTlVMTCk7Ci0JYXNzZXJ0IChub20g
IT0gTlVMTCk7Ci0JYXNzZXJ0IChkZW4gIT0gTlVMTCk7Ci0JYXNzZXJ0IChkaXYgIT0gTlVMTCk7
Ci0JYXNzZXJ0IChtYXhmcmVxID4gMCk7CisJYXNzZXJ0KGJlc3QgIT0gTlVMTCk7CisJYXNzZXJ0
KG5vbSAhPSBOVUxMKTsKKwlhc3NlcnQoZGVuICE9IE5VTEwpOworCWFzc2VydChkaXYgIT0gTlVM
TCk7CisJYXNzZXJ0KG1heGZyZXEgPiAwKTsKIAogCSpub20gPSAwOwogCSpkZW4gPSAwOwogCSpk
aXYgPSAwOwogCi0JRFBSSU5USyAoIkVOVEVSXG4iKTsKKwlEUFJJTlRLKCJFTlRFUlxuIik7CiAK
IAlpZiAoZnJlcSA8IDgwMDApCiAJCWZyZXEgPSA4MDAwOwpAQCAtMzA4NSw3ICszMjY3LDcgQEAg
c3RhdGljIHZvaWQgYmVzdGNsb2NrIChsb25nIGZyZXEsIGxvbmcgKgogCQkJaWYgKGQgPiAzMSkK
IAkJCQlkID0gKGQgLyAyKSAqIDI7CiAJCQloID0gKDE0MzE4ICogbikgLyBkOwotCQkJaWYgKGFi
cyAoaCAtIGZyZXEpIDwgYWJzICgqYmVzdCAtIGZyZXEpKSB7CisJCQlpZiAoYWJzKGggLSBmcmVx
KSA8IGFicygqYmVzdCAtIGZyZXEpKSB7CiAJCQkJKmJlc3QgPSBoOwogCQkJCSpub20gPSBuOwog
CQkJCWlmIChkIDwgMzIpIHsKQEAgLTMxMDIsNyArMzI4NCw3IEBAIHN0YXRpYyB2b2lkIGJlc3Rj
bG9jayAobG9uZyBmcmVxLCBsb25nICoKIAkJCWlmIChkID4gMzEpCiAJCQkJZCA9IChkIC8gMikg
KiAyOwogCQkJaCA9ICgxNDMxOCAqIG4pIC8gZDsKLQkJCWlmIChhYnMgKGggLSBmcmVxKSA8IGFi
cyAoKmJlc3QgLSBmcmVxKSkgeworCQkJaWYgKGFicyhoIC0gZnJlcSkgPCBhYnMoKmJlc3QgLSBm
cmVxKSkgewogCQkJCSpiZXN0ID0gaDsKIAkJCQkqbm9tID0gbjsKIAkJCQlpZiAoZCA8IDMyKSB7
CkBAIC0zMTE2LDE0ICszMjk4LDEzIEBAIHN0YXRpYyB2b2lkIGJlc3RjbG9jayAobG9uZyBmcmVx
LCBsb25nICoKIAkJfQogCX0KIAotCURQUklOVEsgKCJCZXN0IHBvc3NpYmxlIHZhbHVlcyBmb3Ig
Z2l2ZW4gZnJlcXVlbmN5OlxuIik7Ci0JRFBSSU5USyAoIiAgICAgICAgYmVzdDogJWxkIGtIeiAg
bm9tOiAlbGQgIGRlbjogJWxkICBkaXY6ICVsZFxuIiwKLQkJIGZyZXEsICpub20sICpkZW4sICpk
aXYpOworCURQUklOVEsoIkJlc3QgcG9zc2libGUgdmFsdWVzIGZvciBnaXZlbiBmcmVxdWVuY3k6
XG4iKTsKKwlEUFJJTlRLKCIJYmVzdDogJWxkIGtIeiAgbm9tOiAlbGQgIGRlbjogJWxkICBkaXY6
ICVsZFxuIiwKKwkJZnJlcSwgKm5vbSwgKmRlbiwgKmRpdik7CiAKLQlEUFJJTlRLICgiRVhJVFxu
Iik7CisJRFBSSU5USygiRVhJVFxuIik7CiB9CiAKLQogLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogICoK
ICAqIGRlYnVnZ2luZyBmdW5jdGlvbnMKQEAgLTMxNDUsMjEgKzMzMjYsMjAgQEAgc3RhdGljIHZv
aWQgYmVzdGNsb2NrIChsb25nIGZyZXEsIGxvbmcgKgogICovCiAKIHN0YXRpYwotdm9pZCBjaXJy
dXNmYl9kYmdfcHJpbnRfYnl0ZSAoY29uc3QgY2hhciAqbmFtZSwgdW5zaWduZWQgY2hhciB2YWwp
Cit2b2lkIGNpcnJ1c2ZiX2RiZ19wcmludF9ieXRlKGNvbnN0IGNoYXIgKm5hbWUsIHVuc2lnbmVk
IGNoYXIgdmFsKQogewotCURQUklOVEsgKCIlOHMgPSAweCUwMlggKGJpdHMgNy0wOiAlYyVjJWMl
YyVjJWMlYyVjKVxuIiwKLQkJIG5hbWUsIHZhbCwKLQkJIHZhbCAmIDB4ODAgPyAnMScgOiAnMCcs
Ci0JCSB2YWwgJiAweDQwID8gJzEnIDogJzAnLAotCQkgdmFsICYgMHgyMCA/ICcxJyA6ICcwJywK
LQkJIHZhbCAmIDB4MTAgPyAnMScgOiAnMCcsCi0JCSB2YWwgJiAweDA4ID8gJzEnIDogJzAnLAot
CQkgdmFsICYgMHgwNCA/ICcxJyA6ICcwJywKLQkJIHZhbCAmIDB4MDIgPyAnMScgOiAnMCcsCi0J
CSB2YWwgJiAweDAxID8gJzEnIDogJzAnKTsKKwlEUFJJTlRLKCIlOHMgPSAweCUwMlggKGJpdHMg
Ny0wOiAlYyVjJWMlYyVjJWMlYyVjKVxuIiwKKwkJbmFtZSwgdmFsLAorCQl2YWwgJiAweDgwID8g
JzEnIDogJzAnLAorCQl2YWwgJiAweDQwID8gJzEnIDogJzAnLAorCQl2YWwgJiAweDIwID8gJzEn
IDogJzAnLAorCQl2YWwgJiAweDEwID8gJzEnIDogJzAnLAorCQl2YWwgJiAweDA4ID8gJzEnIDog
JzAnLAorCQl2YWwgJiAweDA0ID8gJzEnIDogJzAnLAorCQl2YWwgJiAweDAyID8gJzEnIDogJzAn
LAorCQl2YWwgJiAweDAxID8gJzEnIDogJzAnKTsKIH0KIAotCiAvKioKICAqIGNpcnJ1c2ZiX2Ri
Z19wcmludF9yZWdzCiAgKiBAYmFzZTogSWYgdXNpbmcgbmV3bW1pbywgdGhlIG5ld21taW8gYmFz
ZSBhZGRyZXNzLCBvdGhlcndpc2UgJU5VTEwKQEAgLTMxNzIsMjUgKzMzNTIsMjYgQEAgdm9pZCBj
aXJydXNmYl9kYmdfcHJpbnRfYnl0ZSAoY29uc3QgY2hhcgogICovCiAKIHN0YXRpYwotdm9pZCBj
aXJydXNmYl9kYmdfcHJpbnRfcmVncyAoY2FkZHJfdCByZWdiYXNlLCBjaXJydXNmYl9kYmdfcmVn
X2NsYXNzX3QgcmVnX2NsYXNzLC4uLikKK3ZvaWQgY2lycnVzZmJfZGJnX3ByaW50X3JlZ3MoY2Fk
ZHJfdCByZWdiYXNlLAorCQkJICAgICBjaXJydXNmYl9kYmdfcmVnX2NsYXNzX3QgcmVnX2NsYXNz
LCAuLi4pCiB7CiAJdmFfbGlzdCBsaXN0OwogCXVuc2lnbmVkIGNoYXIgdmFsID0gMDsKIAl1bnNp
Z25lZCByZWc7CiAJY2hhciAqbmFtZTsKIAotCXZhX3N0YXJ0IChsaXN0LCByZWdfY2xhc3MpOwor
CXZhX3N0YXJ0KGxpc3QsIHJlZ19jbGFzcyk7CiAKLQluYW1lID0gdmFfYXJnIChsaXN0LCBjaGFy
ICopOworCW5hbWUgPSB2YV9hcmcobGlzdCwgY2hhciAqKTsKIAl3aGlsZSAobmFtZSAhPSBOVUxM
KSB7Ci0JCXJlZyA9IHZhX2FyZyAobGlzdCwgaW50KTsKKwkJcmVnID0gdmFfYXJnKGxpc3QsIGlu
dCk7CiAKIAkJc3dpdGNoIChyZWdfY2xhc3MpIHsKIAkJY2FzZSBDUlQ6Ci0JCQl2YWwgPSB2Z2Ff
cmNydCAocmVnYmFzZSwgKHVuc2lnbmVkIGNoYXIpIHJlZyk7CisJCQl2YWwgPSB2Z2FfcmNydChy
ZWdiYXNlLCAodW5zaWduZWQgY2hhcikgcmVnKTsKIAkJCWJyZWFrOwogCQljYXNlIFNFUToKLQkJ
CXZhbCA9IHZnYV9yc2VxIChyZWdiYXNlLCAodW5zaWduZWQgY2hhcikgcmVnKTsKKwkJCXZhbCA9
IHZnYV9yc2VxKHJlZ2Jhc2UsICh1bnNpZ25lZCBjaGFyKSByZWcpOwogCQkJYnJlYWs7CiAJCWRl
ZmF1bHQ6CiAJCQkvKiBzaG91bGQgbmV2ZXIgb2NjdXIgKi8KQEAgLTMxOTgsMTUgKzMzNzksMTQg
QEAgdm9pZCBjaXJydXNmYl9kYmdfcHJpbnRfcmVncyAoY2FkZHJfdCByZQogCQkJYnJlYWs7CiAJ
CX0KIAotCQljaXJydXNmYl9kYmdfcHJpbnRfYnl0ZSAobmFtZSwgdmFsKTsKKwkJY2lycnVzZmJf
ZGJnX3ByaW50X2J5dGUobmFtZSwgdmFsKTsKIAotCQluYW1lID0gdmFfYXJnIChsaXN0LCBjaGFy
ICopOworCQluYW1lID0gdmFfYXJnKGxpc3QsIGNoYXIgKik7CiAJfQogCi0JdmFfZW5kIChsaXN0
KTsKKwl2YV9lbmQobGlzdCk7CiB9CiAKLQogLyoqCiAgKiBjaXJydXNmYl9kdW1wCiAgKiBAY2ly
cnVzZmJpbmZvOgpAQCAtMzIxNCwxMyArMzM5NCwxMSBAQCB2b2lkIGNpcnJ1c2ZiX2RiZ19wcmlu
dF9yZWdzIChjYWRkcl90IHJlCiAgKiBERVNDUklQVElPTjoKICAqLwogCi1zdGF0aWMKLXZvaWQg
Y2lycnVzZmJfZHVtcCAodm9pZCkKK3N0YXRpYyB2b2lkIGNpcnJ1c2ZiX2R1bXAodm9pZCkKIHsK
LQljaXJydXNmYl9kYmdfcmVnX2R1bXAgKE5VTEwpOworCWNpcnJ1c2ZiX2RiZ19yZWdfZHVtcChO
VUxMKTsKIH0KIAotCiAvKioKICAqIGNpcnJ1c2ZiX2RiZ19yZWdfZHVtcAogICogQGJhc2U6IElm
IHVzaW5nIG5ld21taW8sIHRoZSBuZXdtbWlvIGJhc2UgYWRkcmVzcywgb3RoZXJ3aXNlICVOVUxM
CkBAIC0zMjMyLDExICszNDEwLDExIEBAIHZvaWQgY2lycnVzZmJfZHVtcCAodm9pZCkKICAqLwog
CiBzdGF0aWMKLXZvaWQgY2lycnVzZmJfZGJnX3JlZ19kdW1wIChjYWRkcl90IHJlZ2Jhc2UpCit2
b2lkIGNpcnJ1c2ZiX2RiZ19yZWdfZHVtcChjYWRkcl90IHJlZ2Jhc2UpCiB7Ci0JRFBSSU5USyAo
IkNJUlJVU0ZCIFZHQSBDUlRDIHJlZ2lzdGVyIGR1bXA6XG4iKTsKKwlEUFJJTlRLKCJDSVJSVVNG
QiBWR0EgQ1JUQyByZWdpc3RlciBkdW1wOlxuIik7CiAKLQljaXJydXNmYl9kYmdfcHJpbnRfcmVn
cyAocmVnYmFzZSwgQ1JULAorCWNpcnJ1c2ZiX2RiZ19wcmludF9yZWdzKHJlZ2Jhc2UsIENSVCwK
IAkJCSAgICJDUjAwIiwgMHgwMCwKIAkJCSAgICJDUjAxIiwgMHgwMSwKIAkJCSAgICJDUjAyIiwg
MHgwMiwKQEAgLTMyODYsMTEgKzM0NjQsMTEgQEAgdm9pZCBjaXJydXNmYl9kYmdfcmVnX2R1bXAg
KGNhZGRyX3QgcmVnYgogCQkJICAgIkNSM0YiLCAweDNGLAogCQkJICAgTlVMTCk7CiAKLQlEUFJJ
TlRLICgiXG4iKTsKKwlEUFJJTlRLKCJcbiIpOwogCi0JRFBSSU5USyAoIkNJUlJVU0ZCIFZHQSBT
RVEgcmVnaXN0ZXIgZHVtcDpcbiIpOworCURQUklOVEsoIkNJUlJVU0ZCIFZHQSBTRVEgcmVnaXN0
ZXIgZHVtcDpcbiIpOwogCi0JY2lycnVzZmJfZGJnX3ByaW50X3JlZ3MgKHJlZ2Jhc2UsIFNFUSwK
KwljaXJydXNmYl9kYmdfcHJpbnRfcmVncyhyZWdiYXNlLCBTRVEsCiAJCQkgICAiU1IwMCIsIDB4
MDAsCiAJCQkgICAiU1IwMSIsIDB4MDEsCiAJCQkgICAiU1IwMiIsIDB4MDIsCkBAIC0zMzE5LDcg
KzM0OTcsNyBAQCB2b2lkIGNpcnJ1c2ZiX2RiZ19yZWdfZHVtcCAoY2FkZHJfdCByZWdiCiAJCQkg
ICAiU1IxRiIsIDB4MUYsCiAJCQkgICBOVUxMKTsKIAotCURQUklOVEsgKCJcbiIpOworCURQUklO
VEsoIlxuIik7CiB9CiAKICNlbmRpZgkJCQkvKiBDSVJSVVNGQl9ERUJVRyAqLwo=

--part46c5d111106b2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--part46c5d111106b2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part46c5d111106b2--

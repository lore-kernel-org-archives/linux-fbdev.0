From: Antonino Daplas <adaplas@pol.net>
Subject: i810fb: trivial fixes and cleanups
Date: 02 Jan 2003 21:35:14 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1041514441.1003.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-2ih34AgXvoCkrVCfz/T7"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18U5i1-0006yI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 02 Jan 2003 05:48:29 -0800
Received: from AP-202-70-105-22.compass.com.ph (AP-202-70-105-22.compass.com.ph [202.70.105.22])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id VAA74542
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 2 Jan 2003 21:48:24 +0800 (PHT)
	(envelope-from adaplas@pol.net)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-2ih34AgXvoCkrVCfz/T7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is a diff against linux-2.5.54.

1. i810fb_par should be built inf fb_set_par() instead of
fb_check_var().
2. changed __devinit*/__devexit* to __init/__exit.
3. removed unused/redundant variables

Tony 



--=-2ih34AgXvoCkrVCfz/T7
Content-Disposition: attachment; filename=i810fb.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=i810fb.diff; charset=ANSI_X3.4-1968

diff -Naur linux-2.5.54/drivers/video/i810/i810.h linux/drivers/video/i810/=
i810.h
--- linux-2.5.54/drivers/video/i810/i810.h	2003-01-02 13:13:46.000000000 +0=
000
+++ linux/drivers/video/i810/i810.h	2003-01-02 13:13:18.000000000 +0000
@@ -212,9 +212,7 @@
=20
 struct gtt_data {
 	agp_memory *i810_fb_memory;
-	agp_memory *i810_iring_memory;
 	agp_memory *i810_cursor_memory;
-	agp_memory *i810_pixmap_memory;
 };
=20
 struct mode_registers {
diff -Naur linux-2.5.54/drivers/video/i810/i810_accel.c linux/drivers/video=
/i810/i810_accel.c
--- linux-2.5.54/drivers/video/i810/i810_accel.c	2003-01-02 13:13:46.000000=
000 +0000
+++ linux/drivers/video/i810/i810_accel.c	2003-01-02 13:13:16.000000000 +00=
00
@@ -27,7 +27,6 @@
 }                                                                     =20
=20
 extern inline void flush_cache(void);
-extern int reinit_agp(struct fb_info *info);
=20
 /************************************************************/
=20
@@ -343,7 +342,7 @@
 	dy =3D rect->dy;
 	height =3D rect->height;
=20
-	dest =3D p->fix.smem_start +  (dy * p->fix.line_length) + dx;
+	dest =3D p->fix.smem_start + (dy * p->fix.line_length) + dx;
 	color_blit(width, height, p->fix.line_length, dest, rop, color,=20
 		   par->blit_bpp, par);
 }
@@ -394,11 +393,6 @@
 			 PAT_COPY_ROP, par->blit_bpp, par);
 }
=20
-/*
- * Blitting is done at 8x8 pixel-array at a time.  If map is not=20
- * monochrome or not a multiple of 8x8 pixels, cfb_imageblit will
- * be called instead. =20
- */
 void i810fb_imageblit(struct fb_info *p, struct fb_image *image)
 {
 	struct i810fb_par *par =3D (struct i810fb_par *) p->par;
@@ -422,9 +416,6 @@
 		bg =3D image->bg_color;
 		break;
 	case 16:
-		fg =3D ((u32 *)(p->pseudo_palette))[image->fg_color];
-		bg =3D ((u32 *)(p->pseudo_palette))[image->bg_color];
-		break;
 	case 24:
 		fg =3D ((u32 *)(p->pseudo_palette))[image->fg_color];
 		bg =3D ((u32 *)(p->pseudo_palette))[image->bg_color];
diff -Naur linux-2.5.54/drivers/video/i810/i810_dvt.c linux/drivers/video/i=
810/i810_dvt.c
--- linux-2.5.54/drivers/video/i810/i810_dvt.c	2003-01-02 13:13:46.00000000=
0 +0000
+++ linux/drivers/video/i810/i810_dvt.c	2003-01-02 13:13:16.000000000 +0000
@@ -218,7 +218,7 @@
 	u32 diff =3D 0, diff_best =3D 0xFFFFFFFF, i =3D 0, i_best =3D 0;=20
 	u8 hfl;
=20
-	hfl =3D  (u8) ((xres >> 3) - 1);
+	hfl =3D (u8) ((xres >> 3) - 1);
 	for (i =3D 0; i < ARRAY_SIZE(std_modes); i++) {=20
 		if (std_modes[i].cr01 =3D=3D hfl) {=20
 			if (std_modes[i].pixclock <=3D par->regs.pixclock)
diff -Naur linux-2.5.54/drivers/video/i810/i810_main.c linux/drivers/video/=
i810/i810_main.c
--- linux-2.5.54/drivers/video/i810/i810_main.c	2003-01-02 13:13:46.0000000=
00 +0000
+++ linux/drivers/video/i810/i810_main.c	2003-01-02 13:13:16.000000000 +000=
0
@@ -1221,7 +1221,7 @@
=20
     	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
=20
-    	strcpy(fix->id, i810fb_name);
+    	strcpy(fix->id, "I810");
     	fix->smem_start =3D par->fb.physical;
     	fix->smem_len =3D par->fb.size;
     	fix->type =3D FB_TYPE_PACKED_PIXELS;
@@ -1519,15 +1519,9 @@
 	struct i810fb_par *par =3D (struct i810fb_par *) info->par;
 	u32 total;
 	u8 *mmio =3D par->mmio_start_virtual;
-	int xoffset =3D var->xoffset, yoffset =3D var->yoffset;
 =09
-	if (xoffset < 0 ||
-	    xoffset+var->xres > var->xres_virtual ||
-	    yoffset < 0 ||
-	    yoffset+var->yres > var->yres_virtual)=20
-		return -EINVAL;
-
-	total =3D xoffset * par->depth + yoffset * info->fix.line_length;
+	total =3D var->xoffset * par->depth +=20
+		var->yoffset * info->fix.line_length;
 	i810_writel(DPLYBASE, mmio, par->fb.physical + total);
=20
 	return 0;
@@ -1575,6 +1569,7 @@
 {
 	struct i810fb_par *par =3D (struct i810fb_par *) info->par;
=20
+	decode_var(&info->var, par, info);
 	i810_load_regs(par);
 	i810_init_cursor(par);
 	par->cursor_reset =3D 1;
@@ -1586,7 +1581,6 @@
 static int i810fb_check_var(struct fb_var_screeninfo *var,=20
 			    struct fb_info *info)
 {
-	struct i810fb_par *par =3D (struct i810fb_par *) info->par;
 	int err;
=20
 	if (IS_DVT) {
@@ -1604,7 +1598,6 @@
=20
 	i810fb_fill_var_timings(var);
 	set_color_bitfields(var);
-	decode_var(&info->var, par, info);
 	return 0;
 }
=20
@@ -1699,13 +1692,14 @@
     .fb_copyarea =3D       i810fb_copyarea,
     .fb_imageblit =3D      i810fb_imageblit,
     .fb_cursor =3D         i810fb_cursor,
+    .fb_sync =3D           i810fb_sync,
 };
=20
 /***********************************************************************
  *                  AGP resource allocation                            *
  ***********************************************************************/
  =20
-static void __devinit i810_fix_pointers(struct i810fb_par *par)
+static void __init i810_fix_pointers(struct i810fb_par *par)
 {
       	par->fb.physical =3D par->aperture.physical+(par->fb.offset << 12);
 	par->fb.virtual =3D par->aperture.virtual+(par->fb.offset << 12);
@@ -1721,7 +1715,7 @@
 		(par->pixmap.offset << 12);
 }
=20
-static void __devinit i810_fix_offsets(struct i810fb_par *par)
+static void __init i810_fix_offsets(struct i810fb_par *par)
 {
 	if (vram + 1 > par->aperture.size >> 20)
 		vram =3D (par->aperture.size >> 20) - 1;
@@ -1744,7 +1738,7 @@
 	par->cursor_heap.size =3D 4096;
 }
=20
-static int __devinit i810_alloc_agp_mem(struct fb_info *info)
+static int __init i810_alloc_agp_mem(struct fb_info *info)
 {
 	struct i810fb_par *par =3D (struct i810fb_par *) info->par;
 	int size;
@@ -1809,7 +1803,7 @@
  * Sets the the user monitor's horizontal and vertical
  * frequency limits
  */
-static void __devinit i810_init_monspecs(struct fb_info *info)
+static void __init i810_init_monspecs(struct fb_info *info)
 {
 	if (!hsync1)
 		hsync1 =3D HFMIN;
@@ -1837,8 +1831,8 @@
  * @par: pointer to i810fb_par structure
  * @info: pointer to current fb_info structure
  */
-static void __devinit i810_init_defaults(struct i810fb_par *par,=20
-					 struct fb_info *info)
+static void __init i810_init_defaults(struct i810fb_par *par,=20
+				      struct fb_info *info)
 {
 	if (voffset) {
 		v_offset_default =3D voffset;
@@ -1866,16 +1860,16 @@
 		vyres =3D (vram << 20)/(xres*bpp >> 3);
=20
 	par->i810fb_ops =3D i810fb_ops;
-	i810fb_default.xres =3D xres;
-	i810fb_default.yres =3D yres;
-	i810fb_default.yres_virtual =3D vyres;
-	i810fb_default.bits_per_pixel =3D bpp;
+	info->var.xres =3D xres;
+	info->var.yres =3D yres;
+	info->var.yres_virtual =3D vyres;
+	info->var.bits_per_pixel =3D bpp;
 =09
 	if (dcolor)
-		i810fb_default.nonstd =3D 1;
+		info->var.nonstd =3D 1;
=20
 	if (par->dev_flags & HAS_ACCELERATION)=20
-		i810fb_default.accel_flags =3D 1;
+		info->var.accel_flags =3D 1;
=20
 	i810_init_monspecs(info);
 }
@@ -1884,7 +1878,7 @@
  * i810_init_device - initialize device
  * @par: pointer to i810fb_par structure
  */
-static void __devinit i810_init_device(struct i810fb_par *par)
+static void __init i810_init_device(struct i810fb_par *par)
 {
 	u8 reg, *mmio =3D par->mmio_start_virtual;
=20
@@ -1905,7 +1899,7 @@
 	i810fb_init_ringbuffer(par);
 }
=20
-static int __devinit=20
+static int __init=20
 i810_allocate_pci_resource(struct i810fb_par *par,=20
 			   const struct pci_device_id *entry)
 {
@@ -2014,7 +2008,7 @@
 	return 0;
 }
=20
-static int __devinit i810fb_init_pci (struct pci_dev *dev,=20
+static int __init i810fb_init_pci (struct pci_dev *dev,=20
 				      const struct pci_device_id *entry)
 {
 	struct fb_info    *info;
@@ -2061,7 +2055,6 @@
 =09
 	fb_alloc_cmap(&info->cmap, 256, 0);
=20
-	info->var =3D i810fb_default;
 	if ((err =3D info->fbops->fb_check_var(&info->var, info))) {
 		i810fb_release_resource(info, par);
 		return err;
@@ -2082,6 +2075,7 @@
 			  info->var.hsync_len + info->var.right_margin);
 	vfreq =3D hfreq/(info->var.yres + info->var.upper_margin +
 		       info->var.vsync_len + info->var.lower_margin);
+
       	printk("fb: %s v%d.%d.%d%s, Tony Daplas\n"
       	       "     Video RAM      : %dK\n"=20
 	       "     Mode           : %dx%d-%dbpp@%dHz\n"
@@ -2098,7 +2092,6 @@
 	       (ext_vga) ? "en" : "dis", (IS_DVT) ?=20
 	       "Intel(R) DVT" : "VESA GTF (US)");
=20
-=09
 	return 0;
 }
=20
@@ -2144,7 +2137,7 @@
 		kfree(info);
 }
=20
-static void __devexit i810fb_remove_pci(struct pci_dev *dev)
+static void __exit i810fb_remove_pci(struct pci_dev *dev)
 {
 	struct fb_info *info =3D pci_get_drvdata(dev);
 	struct i810fb_par *par =3D (struct i810fb_par *) info->par;
diff -Naur linux-2.5.54/drivers/video/i810/i810_main.h linux/drivers/video/=
i810/i810_main.h
--- linux-2.5.54/drivers/video/i810/i810_main.h	2003-01-02 13:13:46.0000000=
00 +0000
+++ linux/drivers/video/i810/i810_main.h	2003-01-02 13:13:18.000000000 +000=
0
@@ -14,9 +14,8 @@
 #ifndef __I810_MAIN_H__
 #define __I810_MAIN_H__
=20
-
 /* PCI */
-static const char *i810_pci_list[] __devinitdata =3D {
+static const char *i810_pci_list[] __initdata =3D {
 	"Intel(R) 810 Framebuffer Device"                                 ,
 	"Intel(R) 810-DC100 Framebuffer Device"                           ,
 	"Intel(R) 810E Framebuffer Device"                                ,
@@ -25,7 +24,7 @@
 	"Intel(R) 815 (Internal Graphics with AGP) Framebuffer Device" =20
 };
=20
-static struct pci_device_id i810fb_pci_tbl[] __devinitdata =3D {
+static struct pci_device_id i810fb_pci_tbl[] __initdata =3D {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG1,=20
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },=20
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG3,
@@ -41,64 +40,32 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5 }
 };	 =20
 	            =20
-static int  __devinit i810fb_init_pci (struct pci_dev *dev,=20
+static int  __init i810fb_init_pci (struct pci_dev *dev,=20
 				       const struct pci_device_id *entry);
-static void __devexit i810fb_remove_pci(struct pci_dev *dev);
+static void __exit i810fb_remove_pci(struct pci_dev *dev);
=20
 static struct pci_driver i810fb_driver =3D {
 	.name     =3D	"i810fb",
 	.id_table =3D	i810fb_pci_tbl,
 	.probe    =3D	i810fb_init_pci,
-	.remove   =3D	__devexit_p(i810fb_remove_pci),
+	.remove   =3D	__exit_p(i810fb_remove_pci),
 };=09
=20
-static int i810_init  __devinitdata =3D 0;
-static int vram       __devinitdata =3D 4;
-static int bpp        __devinitdata =3D 8;
-static int mtrr       __devinitdata =3D 0;
-static int accel      __devinitdata =3D 0;
-static int hsync1     __devinitdata =3D 0;
-static int hsync2     __devinitdata =3D 0;
-static int vsync1     __devinitdata =3D 0;
-static int vsync2     __devinitdata =3D 0;
-static int xres       __devinitdata =3D 640;
-static int yres       __devinitdata =3D 480;
-static int vyres      __devinitdata =3D 0;
-static int sync       __devinitdata =3D 0;
-static int ext_vga    __devinitdata =3D 0;
-static int dcolor     __devinitdata =3D 0;
-
-/* "use once" vars */
-static char i810fb_name[16]  =3D "i810fb";
-static struct fb_var_screeninfo i810fb_default __devinitdata =3D {
-	/* 640x480, 8 bpp */
-	.xres           =3D 640,=20
-	.yres           =3D 480,=20
-	.xres_virtual   =3D 640,=20
-	.yres_virtual   =3D 480,
-	.xoffset        =3D 0,=20
-	.yoffset        =3D 0,=20
-	.bits_per_pixel =3D 8,=20
-	.grayscale      =3D 0,
-	.red            =3D {0, 8, 0},=20
-	.green          =3D {0, 8, 0},=20
-	.blue           =3D {0, 8, 0},=20
-	.transp         =3D {0, 0, 0},
-	.nonstd         =3D 0,=20
-	.activate       =3D 0,=20
-	.height         =3D -1,=20
-	.width          =3D -1,=20
-	.accel_flags    =3D 0,=20
-	.pixclock       =3D 20000,=20
-	.left_margin    =3D 64,=20
-	.right_margin   =3D 64,=20
-	.upper_margin   =3D 32,=20
-	.lower_margin   =3D 32,=20
-	.hsync_len      =3D 64,=20
-	.vsync_len      =3D 2,
-	.sync           =3D 0,=20
-	.vmode          =3D FB_VMODE_NONINTERLACED
-};
+static int i810_init  __initdata =3D 0;
+static int vram       __initdata =3D 4;
+static int bpp        __initdata =3D 8;
+static int mtrr       __initdata =3D 0;
+static int accel      __initdata =3D 0;
+static int hsync1     __initdata =3D 0;
+static int hsync2     __initdata =3D 0;
+static int vsync1     __initdata =3D 0;
+static int vsync2     __initdata =3D 0;
+static int xres       __initdata =3D 640;
+static int yres       __initdata =3D 480;
+static int vyres      __initdata =3D 0;
+static int sync       __initdata =3D 0;
+static int ext_vga    __initdata =3D 0;
+static int dcolor     __initdata =3D 0;
=20
 /*
  * voffset - framebuffer offset in MiB from aperture start address.  In or=
der for
@@ -124,8 +91,8 @@
  *=20
  * Experiment with v_offset to find out which works best for you.
  */
-static u32 v_offset_default __devinitdata; /* For 32 MiB Aper size, 8 shou=
ld be the default */
-static u32 voffset          __devinitdata =3D 0;
+static u32 v_offset_default __initdata; /* For 32 MiB Aper size, 8 should =
be the default */
+static u32 voffset          __initdata =3D 0;
=20
 static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor);
=20
@@ -173,7 +140,7 @@
=20
 #ifdef CONFIG_MTRR
 #define KERNEL_HAS_MTRR 1
-static inline void __devinit set_mtrr(struct i810fb_par *par)
+static inline void __init set_mtrr(struct i810fb_par *par)
 {
 	par->mtrr_reg =3D mtrr_add((u32) par->aperture.physical,=20
 		 par->aperture.size, MTRR_TYPE_WRCOMB, 1);

--=-2ih34AgXvoCkrVCfz/T7--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

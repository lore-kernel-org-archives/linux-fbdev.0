From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: [PATCH] tdfxfb: checkpatch fixes
Date: Fri, 7 Sep 2007 00:32:28 +0200
Message-ID: <20070907003228.113352f5.krzysztof.h1@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ITPnX-0003nV-TJ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Sep 2007 15:26:14 -0700
Received: from nf-out-0910.google.com ([64.233.182.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ITPnW-0002Vy-9E
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Sep 2007 15:26:03 -0700
Received: by nf-out-0910.google.com with SMTP id 30so247964nfu
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 06 Sep 2007 15:26:01 -0700 (PDT)
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes all errors pointed by the checkpatch.pl
script.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.23-mm/drivers/video/tdfxfb.c	2007-09-07 00:24:56.639073042 +0=
200
+++ linux-2.6.23/drivers/video/tdfxfb.c	2007-09-07 00:28:13.378284570 +0200
@@ -4,7 +4,7 @@
  *
  * Author: Hannu Mallat <hmallat@cc.hut.fi>
  *
- * Copyright =A9 1999 Hannu Mallat
+ * Copyright (C) 1999 Hannu Mallat
  * All rights reserved
  *
  * Created      : Thu Sep 23 18:17:43 1999, hmallat
@@ -42,18 +42,18 @@
  *
  * Version history:
  *
- * 0.1.4 (released 2002-05-28) ported over to new fbdev api by James Simmo=
ns
+ * 0.1.4 (released 2002-05-28)	ported over to new fbdev api by James Simmo=
ns
  *
- * 0.1.3 (released 1999-11-02) added Attila's panning support, code
- *			       reorg, hwcursor address page size alignment
- *                             (for mmaping both frame buffer and regs),
- *                             and my changes to get rid of hardcoded
- *                             VGA i/o register locations (uses PCI
- *                             configuration info now)
- * 0.1.2 (released 1999-10-19) added Attila Kesmarki's bug fixes and
- *                             improvements
- * 0.1.1 (released 1999-10-07) added Voodoo3 support by Harold Oga.
- * 0.1.0 (released 1999-10-06) initial version
+ * 0.1.3 (released 1999-11-02)	added Attila's panning support, code
+ *				reorg, hwcursor address page size alignment
+ *				(for mmaping both frame buffer and regs),
+ *				and my changes to get rid of hardcoded
+ *				VGA i/o register locations (uses PCI
+ *				configuration info now)
+ * 0.1.2 (released 1999-10-19)	added Attila Kesmarki's bug fixes and
+ *				improvements
+ * 0.1.1 (released 1999-10-07)	added Voodoo3 support by Harold Oga.
+ * 0.1.0 (released 1999-10-06)	initial version
  *
  */
 =

@@ -72,9 +72,9 @@
 =

 #undef TDFXFB_DEBUG
 #ifdef TDFXFB_DEBUG
-#define DPRINTK(a,b...) printk(KERN_DEBUG "fb: %s: " a, __FUNCTION__ , ## =
b)
+#define DPRINTK(a, b...) printk(KERN_DEBUG "fb: %s: " a, __FUNCTION__ , ##=
 b)
 #else
-#define DPRINTK(a,b...)
+#define DPRINTK(a, b...)
 #endif
 =

 #ifdef CONFIG_MTRR
@@ -172,7 +172,7 @@ static char *mode_option __devinitdata;
 static int nomtrr __devinitdata;
 =

 /* -----------------------------------------------------------------------=
--
- *                      Hardware-specific funcions
+ *			Hardware-specific funcions
  * -----------------------------------------------------------------------=
-- */
 =

 static inline u8 vga_inb(struct tdfx_par *par, u32 reg)
@@ -276,7 +276,7 @@ static inline void banshee_make_room(str
 	while ((tdfx_inl(par, STATUS) & 0x1f) < size - 1)
 		cpu_relax();
 }
- =

+
 static int banshee_wait_idle(struct fb_info *info)
 {
 	struct tdfx_par *par =3D info->par;
@@ -286,8 +286,8 @@ static int banshee_wait_idle(struct fb_i
 	tdfx_outl(par, COMMAND_3D, COMMAND_3D_NOP);
 =

 	do {
- 		if ((tdfx_inl(par, STATUS) & STATUS_BUSY) =3D=3D 0)
-		       i++;
+		if ((tdfx_inl(par, STATUS) & STATUS_BUSY) =3D=3D 0)
+			i++;
 	} while (i < 3);
 =

 	return 0;
@@ -297,7 +297,7 @@ static int banshee_wait_idle(struct fb_i
  * Set the color of a palette entry in 8bpp mode
  */
 static inline void do_setpalentry(struct tdfx_par *par, unsigned regno, u3=
2 c)
-{  =

+{
 	banshee_make_room(par, 2);
 	tdfx_outl(par, DACADDR, regno);
 	/* read after write makes it working */
@@ -475,8 +475,12 @@ static int tdfxfb_check_var(struct fb_va
 	}
 	var->yoffset =3D 0;
 =

-	/* Banshee doesn't support interlace, but Voodoo4/5 and probably Voodoo3 =
do. */
-	/* no direct information about device id now? use max_pixclock for this..=
. */
+	/*
+	 * Banshee doesn't support interlace, but Voodoo4/5 and probably
+	 * Voodoo3 do.
+	 * no direct information about device id now?
+	 *  use max_pixclock for this...
+	 */
 	if (((var->vmode & FB_VMODE_MASK) =3D=3D FB_VMODE_INTERLACED) &&
 	    (par->max_pixclock < VOODOO3_MAX_PIXCLOCK)) {
 		DPRINTK("interlace not supported\n");
@@ -516,7 +520,10 @@ static int tdfxfb_check_var(struct fb_va
 	var->transp.length =3D 0;
 	switch (var->bits_per_pixel) {
 	case 8:
-		var->red.length =3D var->green.length =3D var->blue.length =3D 8;
+		var->red.length =3D 8;
+		var->red.offset =3D 0;
+		var->green =3D var->red;
+		var->blue =3D var->red;
 		break;
 	case 16:
 		var->red.offset   =3D 11;
@@ -536,7 +543,8 @@ static int tdfxfb_check_var(struct fb_va
 		var->red.length =3D var->green.length =3D var->blue.length =3D 8;
 		break;
 	}
-	var->height =3D var->width =3D -1;
+	var->width =3D -1;
+	var->height =3D -1;
 =

 	var->accel_flags =3D FB_ACCELF_TEXT;
 =

@@ -581,7 +589,8 @@ static int tdfxfb_set_par(struct fb_info
 		htotal   >>=3D 1;
 	}
 =

-	hd  =3D wd =3D (hdispend >> 3) - 1;
+	wd =3D (hdispend >> 3) - 1;
+	hd  =3D wd;
 	hs  =3D (hsyncsta >> 3) - 1;
 	he  =3D (hsyncend >> 3) - 1;
 	ht  =3D (htotal >> 3) - 1;
@@ -589,21 +598,23 @@ static int tdfxfb_set_par(struct fb_info
 	hbe =3D ht;
 =

 	if ((info->var.vmode & FB_VMODE_MASK) =3D=3D FB_VMODE_DOUBLE) {
-		vbs =3D vd =3D (info->var.yres << 1) - 1;
+		vd =3D (info->var.yres << 1) - 1;
 		vs  =3D vd + (info->var.lower_margin << 1);
 		ve  =3D vs + (info->var.vsync_len << 1);
-		vbe =3D vt =3D ve + (info->var.upper_margin << 1) - 1;
+		vt =3D ve + (info->var.upper_margin << 1) - 1;
 		reg.screensize =3D info->var.xres | (info->var.yres << 13);
 		reg.vidcfg |=3D VIDCFG_HALF_MODE;
 		reg.crt[0x09] =3D 0x80;
 	} else {
-		vbs =3D vd =3D info->var.yres - 1;
+		vd =3D info->var.yres - 1;
 		vs  =3D vd + info->var.lower_margin;
 		ve  =3D vs + info->var.vsync_len;
-		vbe =3D vt =3D ve + info->var.upper_margin - 1;
+		vt =3D ve + info->var.upper_margin - 1;
 		reg.screensize =3D info->var.xres | (info->var.yres << 12);
 		reg.vidcfg &=3D ~VIDCFG_HALF_MODE;
 	}
+	vbs =3D vd;
+	vbe =3D vt;
 =

 	/* this is all pretty standard VGA register stuffing */
 	reg.misc[0x00] =3D 0x0f |
@@ -736,7 +747,7 @@ static int tdfxfb_set_par(struct fb_info
 }
 =

 /* A handy macro shamelessly pinched from matroxfb */
-#define CNVT_TOHW(val, width) ((((val)<<(width))+0x7FFF-(val))>>16)
+#define CNVT_TOHW(val, width) ((((val) << (width)) + 0x7FFF - (val)) >> 16)
 =

 static int tdfxfb_setcolreg(unsigned regno, unsigned red, unsigned green,
 			    unsigned blue, unsigned transp,
@@ -751,14 +762,16 @@ static int tdfxfb_setcolreg(unsigned reg
 	/* grayscale works only partially under directcolor */
 	if (info->var.grayscale) {
 		/* grayscale =3D 0.30*R + 0.59*G + 0.11*B */
-		red =3D green =3D blue =3D (red * 77 + green * 151 + blue * 28) >> 8;
+		blue =3D (red * 77 + green * 151 + blue * 28) >> 8;
+		green =3D blue;
+		red =3D blue;
 	}
 =

 	switch (info->fix.visual) {
 	case FB_VISUAL_PSEUDOCOLOR:
-		rgbcol =3D(((u32)red   & 0xff00) << 8) |
-			(((u32)green & 0xff00) << 0) |
-			(((u32)blue  & 0xff00) >> 8);
+		rgbcol =3D (((u32)red   & 0xff00) << 8) |
+			 (((u32)green & 0xff00) << 0) |
+			 (((u32)blue  & 0xff00) >> 8);
 		do_setpalentry(par, regno, rgbcol);
 		break;
 	/* Truecolor has no hardware color palettes. */
@@ -851,7 +864,7 @@ static void tdfxfb_fillrect(struct fb_in
 	struct tdfx_par *par =3D info->par;
 	u32 bpp =3D info->var.bits_per_pixel;
 	u32 stride =3D info->fix.line_length;
-	u32 fmt=3D stride | ((bpp + ((bpp =3D=3D 8) ? 0 : 8)) << 13);
+	u32 fmt =3D stride | ((bpp + ((bpp =3D=3D 8) ? 0 : 8)) << 13);
 	int tdfx_rop;
 	u32 dx =3D rect->dx;
 	u32 dy =3D rect->dy;
@@ -922,13 +935,13 @@ static void tdfxfb_copyarea(struct fb_in
 	}
 =

 	if (area->sx <=3D area->dx) {
-		//-X
+		/* -X */
 		blitcmd |=3D BIT(14);
 		sx +=3D area->width - 1;
 		dx +=3D area->width - 1;
 	}
 	if (area->sy <=3D area->dy) {
-		//-Y
+		/* -Y */
 		blitcmd |=3D BIT(15);
 		sy +=3D area->height - 1;
 		dy +=3D area->height - 1;
@@ -961,9 +974,13 @@ static void tdfxfb_imageblit(struct fb_i
 	u32 dstbase =3D 0;
 =

 	if (image->depth !=3D 1) {
-		//banshee_make_room(par, 6 + ((size + 3) >> 2));
-		//srcfmt =3D stride | ((bpp+((bpp=3D=3D8) ? 0 : 8)) << 13) | 0x400000;
+#ifdef BROKEN_CODE
+		banshee_make_room(par, 6 + ((size + 3) >> 2));
+		srcfmt =3D stride | ((bpp + ((bpp =3D=3D 8) ? 0 : 8)) << 13) |
+			0x400000;
+#else
 		cfb_imageblit(info, image);
+#endif
 		return;
 	}
 	banshee_make_room(par, 9);
@@ -998,7 +1015,8 @@ static void tdfxfb_imageblit(struct fb_i
 	tdfx_outl(par, DSTBASE, dstbase);
 	tdfx_outl(par, SRCXY, 0);
 	tdfx_outl(par, DSTXY, dx | (dy << 16));
-	tdfx_outl(par, COMMAND_2D, COMMAND_2D_H2S_BITBLT | (TDFX_ROP_COPY << 24));
+	tdfx_outl(par, COMMAND_2D,
+		  COMMAND_2D_H2S_BITBLT | (TDFX_ROP_COPY << 24));
 	tdfx_outl(par, SRCFORMAT, srcfmt);
 	tdfx_outl(par, DSTFORMAT, dstfmt);
 	tdfx_outl(par, DSTSIZE, image->width | (image->height << 16));
@@ -1013,7 +1031,7 @@ static void tdfxfb_imageblit(struct fb_i
 			fifo_free =3D 31;
 			banshee_make_room(par, fifo_free);
 		}
-		tdfx_outl(par, LAUNCH_2D, *(u32*)chardata);
+		tdfx_outl(par, LAUNCH_2D, *(u32 *)chardata);
 		chardata +=3D 4;
 	}
 =

@@ -1026,11 +1044,11 @@ static void tdfxfb_imageblit(struct fb_i
 		tdfx_outl(par, LAUNCH_2D, *chardata);
 		break;
 	case 2:
-		tdfx_outl(par, LAUNCH_2D, *(u16*)chardata);
+		tdfx_outl(par, LAUNCH_2D, *(u16 *)chardata);
 		break;
 	case 3:
 		tdfx_outl(par, LAUNCH_2D,
-			*(u16*)chardata | ((chardata[3]) << 24));
+			*(u16 *)chardata | (chardata[3] << 24));
 		break;
 	}
 }
@@ -1175,8 +1193,9 @@ static int __devinit tdfxfb_probe(struct
 	struct fb_info *info;
 	int err, lpitch;
 =

-	if ((err =3D pci_enable_device(pdev))) {
-		printk(KERN_WARNING "tdfxfb: Can't enable pdev: %d\n", err);
+	err =3D pci_enable_device(pdev);
+	if (err) {
+		printk(KERN_ERR "tdfxfb: Can't enable pdev: %d\n", err);
 		return err;
 	}
 =

@@ -1207,33 +1226,36 @@ static int __devinit tdfxfb_probe(struct
 	tdfx_fix.mmio_len =3D pci_resource_len(pdev, 0);
 	if (!request_mem_region(tdfx_fix.mmio_start, tdfx_fix.mmio_len,
 				"tdfx regbase")) {
-		printk(KERN_WARNING "tdfxfb: Can't reserve regbase\n");
+		printk(KERN_ERR "tdfxfb: Can't reserve regbase\n");
 		goto out_err;
 	}
 =

 	default_par->regbase_virt =3D
 		ioremap_nocache(tdfx_fix.mmio_start, tdfx_fix.mmio_len);
 	if (!default_par->regbase_virt) {
-		printk("fb: Can't remap %s register area.\n", tdfx_fix.id);
+		printk(KERN_ERR "fb: Can't remap %s register area.\n",
+				tdfx_fix.id);
 		goto out_err_regbase;
 	}
 =

 	tdfx_fix.smem_start =3D pci_resource_start(pdev, 1);
-	if (!(tdfx_fix.smem_len =3D do_lfb_size(default_par, pdev->device))) {
-		printk("fb: Can't count %s memory.\n", tdfx_fix.id);
+	tdfx_fix.smem_len =3D do_lfb_size(default_par, pdev->device);
+	if (!tdfx_fix.smem_len) {
+		printk(KERN_ERR "fb: Can't count %s memory.\n", tdfx_fix.id);
 		goto out_err_regbase;
 	}
 =

 	if (!request_mem_region(tdfx_fix.smem_start,
 				pci_resource_len(pdev, 1), "tdfx smem")) {
-		printk(KERN_WARNING "tdfxfb: Can't reserve smem\n");
+		printk(KERN_ERR "tdfxfb: Can't reserve smem\n");
 		goto out_err_regbase;
 	}
 =

 	info->screen_base =3D ioremap_nocache(tdfx_fix.smem_start,
 					    tdfx_fix.smem_len);
 	if (!info->screen_base) {
-		printk("fb: Can't remap %s framebuffer.\n", tdfx_fix.id);
+		printk(KERN_ERR "fb: Can't remap %s framebuffer.\n",
+				tdfx_fix.id);
 		goto out_err_screenbase;
 	}
 =

@@ -1241,11 +1263,12 @@ static int __devinit tdfxfb_probe(struct
 =

 	if (!request_region(pci_resource_start(pdev, 2),
 			    pci_resource_len(pdev, 2), "tdfx iobase")) {
-		printk(KERN_WARNING "tdfxfb: Can't reserve iobase\n");
+		printk(KERN_ERR "tdfxfb: Can't reserve iobase\n");
 		goto out_err_screenbase;
 	}
 =

-	printk("fb: %s memory =3D %dK\n", tdfx_fix.id, tdfx_fix.smem_len >> 10);
+	printk(KERN_INFO "fb: %s memory =3D %dK\n", tdfx_fix.id,
+			tdfx_fix.smem_len >> 10);
 =

 	default_par->mtrr_handle =3D -1;
 	if (!nomtrr)
@@ -1261,7 +1284,7 @@ static int __devinit tdfxfb_probe(struct
 	info->pseudo_palette	=3D default_par->palette;
 	info->flags		=3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 #ifdef CONFIG_FB_3DFX_ACCEL
-	info->flags             |=3D FBINFO_HWACCEL_FILLRECT |
+	info->flags		|=3D FBINFO_HWACCEL_FILLRECT |
 				   FBINFO_HWACCEL_COPYAREA |
 				   FBINFO_HWACCEL_IMAGEBLIT |
 				   FBINFO_READS_FAST;
@@ -1286,12 +1309,12 @@ static int __devinit tdfxfb_probe(struct
 		goto out_err_iobase;
 =

 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
-		printk(KERN_WARNING "tdfxfb: Can't allocate color map\n");
+		printk(KERN_ERR "tdfxfb: Can't allocate color map\n");
 		goto out_err_iobase;
 	}
 =

 	if (register_framebuffer(info) < 0) {
-		printk("tdfxfb: can't register framebuffer\n");
+		printk(KERN_ERR "tdfxfb: can't register framebuffer\n");
 		fb_dealloc_cmap(&info->cmap);
 		goto out_err_iobase;
 	}

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/

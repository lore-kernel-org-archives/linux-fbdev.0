From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH 3/3] cirrusfb: code improvements
Date: Sat, 18 Aug 2007 08:23:37 +0200
Message-ID: <46c690693b868@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46c690693df67"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IMHio-0001SM-Kw for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 23:23:43 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IMHil-0006Lw-I3
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 23:23:42 -0700
Received: from poczta-16.free.wp-sa.pl (HELO localhost) ([10.1.1.71])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	18 Aug 2007 08:23:37 +0200
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

--part46c690693df67
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch does some "short-range" code improvements like
merging identical switch clauses, replacing conditional
branches with calculation of values, merging only once-used
functions into place they are called from.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This set of patches requires previously sent cirrusfb cleanup up.

--- linux-2.6.23.old/drivers/video/cirrusfb.c	2007-08-18 08:
05:00.000000000 +0200
+++ linux-2.6.23/drivers/video/cirrusfb.c	2007-08-18 08:08:
17.000000000 +0200
@@ -647,31 +647,17 @@ static int cirrusfb_check_var(struct fb_
 	  { -1, -1 } };
=20
 	switch (var->bits_per_pixel) {
-	case 0 ... 1:
-		var->bits_per_pixel =3D 1;
+	case 1:
 		nom =3D 4;
 		den =3D 8;
 		break;		/* 8 pixel per byte, only 1/4th of mem=20
usable */
-	case 2 ... 8:
-		var->bits_per_pixel =3D 8;
-		nom =3D 1;
+	case 8:
+	case 16:
+	case 24:
+	case 32:
+		nom =3D var->bits_per_pixel / 8;
 		den =3D 1;
 		break;		/* 1 pixel =3D=3D 1 byte */
-	case 9 ... 16:
-		var->bits_per_pixel =3D 16;
-		nom =3D 2;
-		den =3D 1;
-		break;		/* 2 bytes per pixel */
-	case 17 ... 24:
-		var->bits_per_pixel =3D 24;
-		nom =3D 3;
-		den =3D 1;
-		break;		/* 3 bytes per pixel */
-	case 25 ... 32:
-		var->bits_per_pixel =3D 32;
-		nom =3D 4;
-		den =3D 1;
-		break;		/* 4 bytes per pixel */
 	default:
 		printk(KERN_ERR "cirrusfb: mode %dx%dx%d rejected..."
 			"color depth not supported.\n",
@@ -732,19 +718,15 @@ static int cirrusfb_check_var(struct fb_
 	case 1:
 		var->red.offset =3D 0;
 		var->red.length =3D 1;
-		var->green.offset =3D 0;
-		var->green.length =3D 1;
-		var->blue.offset =3D 0;
-		var->blue.length =3D 1;
+		var->green =3D var->red;
+		var->blue =3D var->red;
 		break;
=20
 	case 8:
 		var->red.offset =3D 0;
 		var->red.length =3D 6;
-		var->green.offset =3D 0;
-		var->green.length =3D 6;
-		var->blue.offset =3D 0;
-		var->blue.length =3D 6;
+		var->green =3D var->red;
+		var->blue =3D var->red;
 		break;
=20
 	case 16:
@@ -763,20 +745,6 @@ static int cirrusfb_check_var(struct fb_
 		break;
=20
 	case 24:
-		if (isPReP) {
-			var->red.offset =3D 8;
-			var->green.offset =3D 16;
-			var->blue.offset =3D 24;
-		} else {
-			var->red.offset =3D 16;
-			var->green.offset =3D 8;
-			var->blue.offset =3D 0;
-		}
-		var->red.length =3D 8;
-		var->green.length =3D 8;
-		var->blue.length =3D 8;
-		break;
-
 	case 32:
 		if (isPReP) {
 			var->red.offset =3D 8;
@@ -828,7 +796,7 @@ static int cirrusfb_decode_var(const str
 {
 	long freq;
 	long maxclock;
-	int maxclockidx =3D 0;
+	int maxclockidx =3D var->bits_per_pixel >> 3;
 	struct cirrusfb_info *cinfo =3D info->par;
 	int xres, hfront, hsync, hback;
 	int yres, vfront, vsync, vback;
@@ -837,31 +805,18 @@ static int cirrusfb_decode_var(const str
 	case 1:
 		regs->line_length =3D var->xres_virtual / 8;
 		regs->visual =3D FB_VISUAL_MONO10;
-		maxclockidx =3D 0;
 		break;
=20
 	case 8:
 		regs->line_length =3D var->xres_virtual;
 		regs->visual =3D FB_VISUAL_PSEUDOCOLOR;
-		maxclockidx =3D 1;
 		break;
=20
 	case 16:
-		regs->line_length =3D var->xres_virtual * 2;
-		regs->visual =3D FB_VISUAL_DIRECTCOLOR;
-		maxclockidx =3D 2;
-		break;
-
 	case 24:
-		regs->line_length =3D var->xres_virtual * 3;
-		regs->visual =3D FB_VISUAL_DIRECTCOLOR;
-		maxclockidx =3D 3;
-		break;
-
 	case 32:
-		regs->line_length =3D var->xres_virtual * 4;
+		regs->line_length =3D var->xres_virtual * maxclockidx;
 		regs->visual =3D FB_VISUAL_DIRECTCOLOR;
-		maxclockidx =3D 4;
 		break;
=20
 	default:
@@ -874,7 +829,7 @@ static int cirrusfb_decode_var(const str
 	regs->type =3D FB_TYPE_PACKED_PIXELS;
=20
 	/* convert from ps to kHz */
-	freq =3D 1000000000 / var->pixclock;
+	freq =3D PICOS2KHZ(var->pixclock);
=20
 	DPRINTK("desired pixclock: %ld kHz\n", freq);
=20
@@ -1213,7 +1168,8 @@ static int cirrusfb_set_par_foo(struct f
 			break;
=20
 		case BT_PICCOLO:
-			DPRINTK("(for Piccolo)\n");
+		case BT_SPECTRUM:
+			DPRINTK("(for Piccolo/Spectrum)\n");
 			/* ### ueberall 0x22? */
 			/* ##vorher 1c MCLK select */
 			vga_wseq(regbase, CL_SEQR1F, 0x22);
@@ -1229,15 +1185,6 @@ static int cirrusfb_set_par_foo(struct f
 			vga_wseq(regbase, CL_SEQRF, 0xd0);
 			break;
=20
-		case BT_SPECTRUM:
-			DPRINTK("(for Spectrum)\n");
-			/* ### ueberall 0x22? */
-			/* ##vorher 1c MCLK select */
-			vga_wseq(regbase, CL_SEQR1F, 0x22);
-			/* evtl d0? avoid FIFO underruns..? */
-			vga_wseq(regbase, CL_SEQRF, 0xb0);
-			break;
-
 		case BT_PICASSO4:
 		case BT_ALPINE:
 		case BT_GD5480:
@@ -1306,19 +1253,7 @@ static int cirrusfb_set_par_foo(struct f
 			break;
=20
 		case BT_PICCOLO:
-			/* ### vorher 1c MCLK select */
-			vga_wseq(regbase, CL_SEQR1F, 0x22);
-			/* Fast Page-Mode writes */
-			vga_wseq(regbase, CL_SEQRF, 0xb0);
-			break;
-
 		case BT_PICASSO:
-			/* ### vorher 1c MCLK select */
-			vga_wseq(regbase, CL_SEQR1F, 0x22);
-			/* Fast Page-Mode writes */
-			vga_wseq(regbase, CL_SEQRF, 0xb0);
-			break;
-
 		case BT_SPECTRUM:
 			/* ### vorher 1c MCLK select */
 			vga_wseq(regbase, CL_SEQR1F, 0x22);
@@ -1385,6 +1320,7 @@ static int cirrusfb_set_par_foo(struct f
 			break;
=20
 		case BT_PICCOLO:
+		case BT_SPECTRUM:
 			vga_wseq(regbase, CL_SEQR7, 0x87);
 			/* Fast Page-Mode writes */
 			vga_wseq(regbase, CL_SEQRF, 0xb0);
@@ -1400,14 +1336,6 @@ static int cirrusfb_set_par_foo(struct f
 			vga_wseq(regbase, CL_SEQR1F, 0x22);
 			break;
=20
-		case BT_SPECTRUM:
-			vga_wseq(regbase, CL_SEQR7, 0x87);
-			/* Fast Page-Mode writes */
-			vga_wseq(regbase, CL_SEQRF, 0xb0);
-			/* MCLK select */
-			vga_wseq(regbase, CL_SEQR1F, 0x22);
-			break;
-
 		case BT_PICASSO4:
 			vga_wseq(regbase, CL_SEQR7, 0x27);
 /*			vga_wseq(regbase, CL_SEQR1F, 0x1c);  */
@@ -1473,6 +1401,7 @@ static int cirrusfb_set_par_foo(struct f
 			break;
=20
 		case BT_PICCOLO:
+		case BT_SPECTRUM:
 			vga_wseq(regbase, CL_SEQR7, 0x85);
 			/* Fast Page-Mode writes */
 			vga_wseq(regbase, CL_SEQRF, 0xb0);
@@ -1488,14 +1417,6 @@ static int cirrusfb_set_par_foo(struct f
 			vga_wseq(regbase, CL_SEQR1F, 0x22);
 			break;
=20
-		case BT_SPECTRUM:
-			vga_wseq(regbase, CL_SEQR7, 0x85);
-			/* Fast Page-Mode writes */
-			vga_wseq(regbase, CL_SEQRF, 0xb0);
-			/* MCLK select */
-			vga_wseq(regbase, CL_SEQR1F, 0x22);
-			break;
-
 		case BT_PICASSO4:
 			vga_wseq(regbase, CL_SEQR7, 0x25);
 /*			vga_wseq(regbase, CL_SEQR1F, 0x1c);  */
@@ -1662,18 +1583,7 @@ static int cirrusfb_setcolreg(unsigned r
 		    (green << info->var.green.offset) |
 		    (blue << info->var.blue.offset);
=20
-		switch (info->var.bits_per_pixel) {
-		case 8:
-			cinfo->pseudo_palette[regno] =3D v;
-			break;
-		case 16:
-			cinfo->pseudo_palette[regno] =3D v;
-			break;
-		case 24:
-		case 32:
-			cinfo->pseudo_palette[regno] =3D v;
-			break;
-		}
+		cinfo->pseudo_palette[regno] =3D v;
 		return 0;
 	}
=20
@@ -1743,12 +1653,8 @@ static int cirrusfb_pan_display(struct f
 	vga_wcrt(cinfo->regbase, CL_CRT1B, tmp2);
=20
 	/* construct bit 19 of screen start address */
-	if (cirrusfb_board_info[cinfo->btype].scrn_start_bit19) {
-		tmp2 =3D 0;
-		if (base & 0x80000)
-			tmp2 =3D 0x80;
-		vga_wcrt(cinfo->regbase, CL_CRT1D, tmp2);
-	}
+	if (cirrusfb_board_info[cinfo->btype].scrn_start_bit19)
+		vga_wcrt(cinfo->regbase, CL_CRT1D, (base >> 12) & 0x80);
=20
 	/* write pixel panning value to AR33; this does not quite=20
work in 8bpp
 	 *
@@ -2139,38 +2045,15 @@ static void switch_monitor(struct cirrus
 /* Linux 2.6-style  accelerated functions */
 /******************************************/
=20
-static void cirrusfb_prim_fillrect(struct fb_info *info,
-				   const struct fb_fillrect *region)
-{
-	struct cirrusfb_info *cinfo =3D info->par;
-	int m; /* bytes per pixel */
-	u32 color =3D (info->fix.visual =3D=3D FB_VISUAL_TRUECOLOR) ?
-		cinfo->pseudo_palette[region->color] : region->color;
-
-	if (info->var.bits_per_pixel =3D=3D 1) {
-		cirrusfb_RectFill(cinfo->regbase,
-				  info->var.bits_per_pixel,
-				  region->dx / 8, region->dy,
-				  region->width / 8, region->height,
-				  color,
-				  cinfo->currentmode.line_length);
-	} else {
-		m =3D (info->var.bits_per_pixel + 7) / 8;
-		cirrusfb_RectFill(cinfo->regbase,
-				  info->var.bits_per_pixel,
-				  region->dx * m, region->dy,
-				  region->width * m, region->height,
-				  color,
-				  cinfo->currentmode.line_length);
-	}
-	return;
-}
-
 static void cirrusfb_fillrect(struct fb_info *info,
 			      const struct fb_fillrect *region)
 {
 	struct fb_fillrect modded;
 	int vxres, vyres;
+	struct cirrusfb_info *cinfo =3D info->par;
+	int m =3D info->var.bits_per_pixel;
+	u32 color =3D (info->fix.visual =3D=3D FB_VISUAL_TRUECOLOR) ?
+		cinfo->pseudo_palette[region->color] : region->color;
=20
 	if (info->state !=3D FBINFO_STATE_RUNNING)
 		return;
@@ -2193,30 +2076,12 @@ static void cirrusfb_fillrect(struct fb_
 	if (modded.dy + modded.height > vyres)
 		modded.height =3D vyres - modded.dy;
=20
-	cirrusfb_prim_fillrect(info, &modded);
-}
-
-static void cirrusfb_prim_copyarea(struct fb_info *info,
-				   const struct fb_copyarea *area)
-{
-	struct cirrusfb_info *cinfo =3D info->par;
-	int m; /* bytes per pixel */
-
-	if (info->var.bits_per_pixel =3D=3D 1) {
-		cirrusfb_BitBLT(cinfo->regbase, info->var.
bits_per_pixel,
-				area->sx / 8, area->sy,
-				area->dx / 8, area->dy,
-				area->width / 8, area->height,
-				cinfo->currentmode.line_length);
-	} else {
-		m =3D (info->var.bits_per_pixel + 7) / 8;
-		cirrusfb_BitBLT(cinfo->regbase, info->var.
bits_per_pixel,
-				area->sx * m, area->sy,
-				area->dx * m, area->dy,
-				area->width * m, area->height,
-				cinfo->currentmode.line_length);
-	}
-	return;
+	cirrusfb_RectFill(cinfo->regbase,
+			  info->var.bits_per_pixel,
+			  (region->dx * m) / 8, region->dy,
+			  (region->width * m) / 8, region->height,
+			  color,
+			  cinfo->currentmode.line_length);
 }
=20
 static void cirrusfb_copyarea(struct fb_info *info,
@@ -2224,13 +2089,8 @@ static void cirrusfb_copyarea(struct fb_
 {
 	struct fb_copyarea modded;
 	u32 vxres, vyres;
-
-	modded.sx =3D area->sx;
-	modded.sy =3D area->sy;
-	modded.dx =3D area->dx;
-	modded.dy =3D area->dy;
-	modded.width  =3D area->width;
-	modded.height =3D area->height;
+	struct cirrusfb_info *cinfo =3D info->par;
+	int m =3D info->var.bits_per_pixel;
=20
 	if (info->state !=3D FBINFO_STATE_RUNNING)
 		return;
@@ -2241,6 +2101,7 @@ static void cirrusfb_copyarea(struct fb_
=20
 	vxres =3D info->var.xres_virtual;
 	vyres =3D info->var.yres_virtual;
+	memcpy(&modded, area, sizeof(struct fb_copyarea));
=20
 	if (!modded.width || !modded.height ||
 	   modded.sx >=3D vxres || modded.sy >=3D vyres ||
@@ -2256,7 +2117,12 @@ static void cirrusfb_copyarea(struct fb_
 	if (modded.dy + modded.height > vyres)
 		modded.height =3D vyres - modded.dy;
=20
-	cirrusfb_prim_copyarea(info, &modded);
+	cirrusfb_BitBLT(cinfo->regbase, info->var.bits_per_pixel,
+			(area->sx * m) / 8, area->sy,
+			(area->dx * m) / 8, area->dy,
+			(area->width * m) / 8, area->height,
+			cinfo->currentmode.line_length);
+
 }
=20
 static void cirrusfb_imageblit(struct fb_info *info,
@@ -2366,7 +2232,6 @@ static void cirrusfb_pci_unmap(struct fb
 	if (release_io_ports)
 		release_region(0x3C0, 32);
 	pci_release_regions(pdev);
-	framebuffer_release(info);
 }
 #endif /* CONFIG_PCI */
=20
@@ -2383,7 +2248,6 @@ static void __devexit cirrusfb_zorro_unm
 		if (zorro_resource_start(cinfo->zdev) > 0x01000000)
 			iounmap(info->screen_base);
 	}
-	framebuffer_release(cinfo->info);
 }
 #endif /* CONFIG_ZORRO */
=20
@@ -2481,6 +2345,7 @@ err_dealloc_cmap:
 	fb_dealloc_cmap(&info->cmap);
 err_unmap_cirrusfb:
 	cinfo->unmap(info);
+	framebuffer_release(info);
 	return err;
 }
=20
@@ -2495,6 +2360,7 @@ static void __devexit cirrusfb_cleanup(s
 	fb_dealloc_cmap(&info->cmap);
 	printk("Framebuffer unregistered\n");
 	cinfo->unmap(info);
+	framebuffer_release(info);
=20
 	DPRINTK("EXIT\n");
 }


----------------------------------------------------
Producenci filmu SEZON NA MISIA przedstawiaj=B1
surfuj=B1ce pingwiny w nowej, animowanej komedii
NA FALI -  w kinach od 10 sierpnia!=20
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fnafali_zwi=
astun.html&sid=3D1256

--part46c690693df67
Content-Type: application/octet-stream; name="cirrusfb-impro.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cirrusfb-impro.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggZG9l
cyBzb21lICJzaG9ydC1yYW5nZSIgY29kZSBpbXByb3ZlbWVudHMgbGlrZQptZXJnaW5nIGlkZW50
aWNhbCBzd2l0Y2ggY2xhdXNlcywgcmVwbGFjaW5nIGNvbmRpdGlvbmFsCmJyYW5jaGVzIHdpdGgg
Y2FsY3VsYXRpb24gb2YgdmFsdWVzLCBtZXJnaW5nIG9ubHkgb25jZS11c2VkCmZ1bmN0aW9ucyBp
bnRvIHBsYWNlIHRoZXkgYXJlIGNhbGxlZCBmcm9tLgoKU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9m
IEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KCi0tLQoKLS0tIGxpbnV4LTIuNi4yMy5vbGQvZHJp
dmVycy92aWRlby9jaXJydXNmYi5jCTIwMDctMDgtMTggMDg6MDU6MDAuMDAwMDAwMDAwICswMjAw
CisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9jaXJydXNmYi5jCTIwMDctMDgtMTggMDg6
MDg6MTcuMDAwMDAwMDAwICswMjAwCkBAIC02NDcsMzEgKzY0NywxNyBAQCBzdGF0aWMgaW50IGNp
cnJ1c2ZiX2NoZWNrX3ZhcihzdHJ1Y3QgZmJfCiAJICB7IC0xLCAtMSB9IH07CiAKIAlzd2l0Y2gg
KHZhci0+Yml0c19wZXJfcGl4ZWwpIHsKLQljYXNlIDAgLi4uIDE6Ci0JCXZhci0+Yml0c19wZXJf
cGl4ZWwgPSAxOworCWNhc2UgMToKIAkJbm9tID0gNDsKIAkJZGVuID0gODsKIAkJYnJlYWs7CQkv
KiA4IHBpeGVsIHBlciBieXRlLCBvbmx5IDEvNHRoIG9mIG1lbSB1c2FibGUgKi8KLQljYXNlIDIg
Li4uIDg6Ci0JCXZhci0+Yml0c19wZXJfcGl4ZWwgPSA4OwotCQlub20gPSAxOworCWNhc2UgODoK
KwljYXNlIDE2OgorCWNhc2UgMjQ6CisJY2FzZSAzMjoKKwkJbm9tID0gdmFyLT5iaXRzX3Blcl9w
aXhlbCAvIDg7CiAJCWRlbiA9IDE7CiAJCWJyZWFrOwkJLyogMSBwaXhlbCA9PSAxIGJ5dGUgKi8K
LQljYXNlIDkgLi4uIDE2OgotCQl2YXItPmJpdHNfcGVyX3BpeGVsID0gMTY7Ci0JCW5vbSA9IDI7
Ci0JCWRlbiA9IDE7Ci0JCWJyZWFrOwkJLyogMiBieXRlcyBwZXIgcGl4ZWwgKi8KLQljYXNlIDE3
IC4uLiAyNDoKLQkJdmFyLT5iaXRzX3Blcl9waXhlbCA9IDI0OwotCQlub20gPSAzOwotCQlkZW4g
PSAxOwotCQlicmVhazsJCS8qIDMgYnl0ZXMgcGVyIHBpeGVsICovCi0JY2FzZSAyNSAuLi4gMzI6
Ci0JCXZhci0+Yml0c19wZXJfcGl4ZWwgPSAzMjsKLQkJbm9tID0gNDsKLQkJZGVuID0gMTsKLQkJ
YnJlYWs7CQkvKiA0IGJ5dGVzIHBlciBwaXhlbCAqLwogCWRlZmF1bHQ6CiAJCXByaW50ayhLRVJO
X0VSUiAiY2lycnVzZmI6IG1vZGUgJWR4JWR4JWQgcmVqZWN0ZWQuLi4iCiAJCQkiY29sb3IgZGVw
dGggbm90IHN1cHBvcnRlZC5cbiIsCkBAIC03MzIsMTkgKzcxOCwxNSBAQCBzdGF0aWMgaW50IGNp
cnJ1c2ZiX2NoZWNrX3ZhcihzdHJ1Y3QgZmJfCiAJY2FzZSAxOgogCQl2YXItPnJlZC5vZmZzZXQg
PSAwOwogCQl2YXItPnJlZC5sZW5ndGggPSAxOwotCQl2YXItPmdyZWVuLm9mZnNldCA9IDA7Ci0J
CXZhci0+Z3JlZW4ubGVuZ3RoID0gMTsKLQkJdmFyLT5ibHVlLm9mZnNldCA9IDA7Ci0JCXZhci0+
Ymx1ZS5sZW5ndGggPSAxOworCQl2YXItPmdyZWVuID0gdmFyLT5yZWQ7CisJCXZhci0+Ymx1ZSA9
IHZhci0+cmVkOwogCQlicmVhazsKIAogCWNhc2UgODoKIAkJdmFyLT5yZWQub2Zmc2V0ID0gMDsK
IAkJdmFyLT5yZWQubGVuZ3RoID0gNjsKLQkJdmFyLT5ncmVlbi5vZmZzZXQgPSAwOwotCQl2YXIt
PmdyZWVuLmxlbmd0aCA9IDY7Ci0JCXZhci0+Ymx1ZS5vZmZzZXQgPSAwOwotCQl2YXItPmJsdWUu
bGVuZ3RoID0gNjsKKwkJdmFyLT5ncmVlbiA9IHZhci0+cmVkOworCQl2YXItPmJsdWUgPSB2YXIt
PnJlZDsKIAkJYnJlYWs7CiAKIAljYXNlIDE2OgpAQCAtNzYzLDIwICs3NDUsNiBAQCBzdGF0aWMg
aW50IGNpcnJ1c2ZiX2NoZWNrX3ZhcihzdHJ1Y3QgZmJfCiAJCWJyZWFrOwogCiAJY2FzZSAyNDoK
LQkJaWYgKGlzUFJlUCkgewotCQkJdmFyLT5yZWQub2Zmc2V0ID0gODsKLQkJCXZhci0+Z3JlZW4u
b2Zmc2V0ID0gMTY7Ci0JCQl2YXItPmJsdWUub2Zmc2V0ID0gMjQ7Ci0JCX0gZWxzZSB7Ci0JCQl2
YXItPnJlZC5vZmZzZXQgPSAxNjsKLQkJCXZhci0+Z3JlZW4ub2Zmc2V0ID0gODsKLQkJCXZhci0+
Ymx1ZS5vZmZzZXQgPSAwOwotCQl9Ci0JCXZhci0+cmVkLmxlbmd0aCA9IDg7Ci0JCXZhci0+Z3Jl
ZW4ubGVuZ3RoID0gODsKLQkJdmFyLT5ibHVlLmxlbmd0aCA9IDg7Ci0JCWJyZWFrOwotCiAJY2Fz
ZSAzMjoKIAkJaWYgKGlzUFJlUCkgewogCQkJdmFyLT5yZWQub2Zmc2V0ID0gODsKQEAgLTgyOCw3
ICs3OTYsNyBAQCBzdGF0aWMgaW50IGNpcnJ1c2ZiX2RlY29kZV92YXIoY29uc3Qgc3RyCiB7CiAJ
bG9uZyBmcmVxOwogCWxvbmcgbWF4Y2xvY2s7Ci0JaW50IG1heGNsb2NraWR4ID0gMDsKKwlpbnQg
bWF4Y2xvY2tpZHggPSB2YXItPmJpdHNfcGVyX3BpeGVsID4+IDM7CiAJc3RydWN0IGNpcnJ1c2Zi
X2luZm8gKmNpbmZvID0gaW5mby0+cGFyOwogCWludCB4cmVzLCBoZnJvbnQsIGhzeW5jLCBoYmFj
azsKIAlpbnQgeXJlcywgdmZyb250LCB2c3luYywgdmJhY2s7CkBAIC04MzcsMzEgKzgwNSwxOCBA
QCBzdGF0aWMgaW50IGNpcnJ1c2ZiX2RlY29kZV92YXIoY29uc3Qgc3RyCiAJY2FzZSAxOgogCQly
ZWdzLT5saW5lX2xlbmd0aCA9IHZhci0+eHJlc192aXJ0dWFsIC8gODsKIAkJcmVncy0+dmlzdWFs
ID0gRkJfVklTVUFMX01PTk8xMDsKLQkJbWF4Y2xvY2tpZHggPSAwOwogCQlicmVhazsKIAogCWNh
c2UgODoKIAkJcmVncy0+bGluZV9sZW5ndGggPSB2YXItPnhyZXNfdmlydHVhbDsKIAkJcmVncy0+
dmlzdWFsID0gRkJfVklTVUFMX1BTRVVET0NPTE9SOwotCQltYXhjbG9ja2lkeCA9IDE7CiAJCWJy
ZWFrOwogCiAJY2FzZSAxNjoKLQkJcmVncy0+bGluZV9sZW5ndGggPSB2YXItPnhyZXNfdmlydHVh
bCAqIDI7Ci0JCXJlZ3MtPnZpc3VhbCA9IEZCX1ZJU1VBTF9ESVJFQ1RDT0xPUjsKLQkJbWF4Y2xv
Y2tpZHggPSAyOwotCQlicmVhazsKLQogCWNhc2UgMjQ6Ci0JCXJlZ3MtPmxpbmVfbGVuZ3RoID0g
dmFyLT54cmVzX3ZpcnR1YWwgKiAzOwotCQlyZWdzLT52aXN1YWwgPSBGQl9WSVNVQUxfRElSRUNU
Q09MT1I7Ci0JCW1heGNsb2NraWR4ID0gMzsKLQkJYnJlYWs7Ci0KIAljYXNlIDMyOgotCQlyZWdz
LT5saW5lX2xlbmd0aCA9IHZhci0+eHJlc192aXJ0dWFsICogNDsKKwkJcmVncy0+bGluZV9sZW5n
dGggPSB2YXItPnhyZXNfdmlydHVhbCAqIG1heGNsb2NraWR4OwogCQlyZWdzLT52aXN1YWwgPSBG
Ql9WSVNVQUxfRElSRUNUQ09MT1I7Ci0JCW1heGNsb2NraWR4ID0gNDsKIAkJYnJlYWs7CiAKIAlk
ZWZhdWx0OgpAQCAtODc0LDcgKzgyOSw3IEBAIHN0YXRpYyBpbnQgY2lycnVzZmJfZGVjb2RlX3Zh
cihjb25zdCBzdHIKIAlyZWdzLT50eXBlID0gRkJfVFlQRV9QQUNLRURfUElYRUxTOwogCiAJLyog
Y29udmVydCBmcm9tIHBzIHRvIGtIeiAqLwotCWZyZXEgPSAxMDAwMDAwMDAwIC8gdmFyLT5waXhj
bG9jazsKKwlmcmVxID0gUElDT1MyS0haKHZhci0+cGl4Y2xvY2spOwogCiAJRFBSSU5USygiZGVz
aXJlZCBwaXhjbG9jazogJWxkIGtIelxuIiwgZnJlcSk7CiAKQEAgLTEyMTMsNyArMTE2OCw4IEBA
IHN0YXRpYyBpbnQgY2lycnVzZmJfc2V0X3Bhcl9mb28oc3RydWN0IGYKIAkJCWJyZWFrOwogCiAJ
CWNhc2UgQlRfUElDQ09MTzoKLQkJCURQUklOVEsoIihmb3IgUGljY29sbylcbiIpOworCQljYXNl
IEJUX1NQRUNUUlVNOgorCQkJRFBSSU5USygiKGZvciBQaWNjb2xvL1NwZWN0cnVtKVxuIik7CiAJ
CQkvKiAjIyMgdWViZXJhbGwgMHgyMj8gKi8KIAkJCS8qICMjdm9yaGVyIDFjIE1DTEsgc2VsZWN0
ICovCiAJCQl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9TRVFSMUYsIDB4MjIpOwpAQCAtMTIyOSwxNSAr
MTE4NSw2IEBAIHN0YXRpYyBpbnQgY2lycnVzZmJfc2V0X3Bhcl9mb28oc3RydWN0IGYKIAkJCXZn
YV93c2VxKHJlZ2Jhc2UsIENMX1NFUVJGLCAweGQwKTsKIAkJCWJyZWFrOwogCi0JCWNhc2UgQlRf
U1BFQ1RSVU06Ci0JCQlEUFJJTlRLKCIoZm9yIFNwZWN0cnVtKVxuIik7Ci0JCQkvKiAjIyMgdWVi
ZXJhbGwgMHgyMj8gKi8KLQkJCS8qICMjdm9yaGVyIDFjIE1DTEsgc2VsZWN0ICovCi0JCQl2Z2Ff
d3NlcShyZWdiYXNlLCBDTF9TRVFSMUYsIDB4MjIpOwotCQkJLyogZXZ0bCBkMD8gYXZvaWQgRklG
TyB1bmRlcnJ1bnMuLj8gKi8KLQkJCXZnYV93c2VxKHJlZ2Jhc2UsIENMX1NFUVJGLCAweGIwKTsK
LQkJCWJyZWFrOwotCiAJCWNhc2UgQlRfUElDQVNTTzQ6CiAJCWNhc2UgQlRfQUxQSU5FOgogCQlj
YXNlIEJUX0dENTQ4MDoKQEAgLTEzMDYsMTkgKzEyNTMsNyBAQCBzdGF0aWMgaW50IGNpcnJ1c2Zi
X3NldF9wYXJfZm9vKHN0cnVjdCBmCiAJCQlicmVhazsKIAogCQljYXNlIEJUX1BJQ0NPTE86Ci0J
CQkvKiAjIyMgdm9yaGVyIDFjIE1DTEsgc2VsZWN0ICovCi0JCQl2Z2Ffd3NlcShyZWdiYXNlLCBD
TF9TRVFSMUYsIDB4MjIpOwotCQkJLyogRmFzdCBQYWdlLU1vZGUgd3JpdGVzICovCi0JCQl2Z2Ff
d3NlcShyZWdiYXNlLCBDTF9TRVFSRiwgMHhiMCk7Ci0JCQlicmVhazsKLQogCQljYXNlIEJUX1BJ
Q0FTU086Ci0JCQkvKiAjIyMgdm9yaGVyIDFjIE1DTEsgc2VsZWN0ICovCi0JCQl2Z2Ffd3NlcShy
ZWdiYXNlLCBDTF9TRVFSMUYsIDB4MjIpOwotCQkJLyogRmFzdCBQYWdlLU1vZGUgd3JpdGVzICov
Ci0JCQl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9TRVFSRiwgMHhiMCk7Ci0JCQlicmVhazsKLQogCQlj
YXNlIEJUX1NQRUNUUlVNOgogCQkJLyogIyMjIHZvcmhlciAxYyBNQ0xLIHNlbGVjdCAqLwogCQkJ
dmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjFGLCAweDIyKTsKQEAgLTEzODUsNiArMTMyMCw3IEBA
IHN0YXRpYyBpbnQgY2lycnVzZmJfc2V0X3Bhcl9mb28oc3RydWN0IGYKIAkJCWJyZWFrOwogCiAJ
CWNhc2UgQlRfUElDQ09MTzoKKwkJY2FzZSBCVF9TUEVDVFJVTToKIAkJCXZnYV93c2VxKHJlZ2Jh
c2UsIENMX1NFUVI3LCAweDg3KTsKIAkJCS8qIEZhc3QgUGFnZS1Nb2RlIHdyaXRlcyAqLwogCQkJ
dmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUkYsIDB4YjApOwpAQCAtMTQwMCwxNCArMTMzNiw2IEBA
IHN0YXRpYyBpbnQgY2lycnVzZmJfc2V0X3Bhcl9mb28oc3RydWN0IGYKIAkJCXZnYV93c2VxKHJl
Z2Jhc2UsIENMX1NFUVIxRiwgMHgyMik7CiAJCQlicmVhazsKIAotCQljYXNlIEJUX1NQRUNUUlVN
OgotCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjcsIDB4ODcpOwotCQkJLyogRmFzdCBQYWdl
LU1vZGUgd3JpdGVzICovCi0JCQl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9TRVFSRiwgMHhiMCk7Ci0J
CQkvKiBNQ0xLIHNlbGVjdCAqLwotCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjFGLCAweDIy
KTsKLQkJCWJyZWFrOwotCiAJCWNhc2UgQlRfUElDQVNTTzQ6CiAJCQl2Z2Ffd3NlcShyZWdiYXNl
LCBDTF9TRVFSNywgMHgyNyk7CiAvKgkJCXZnYV93c2VxKHJlZ2Jhc2UsIENMX1NFUVIxRiwgMHgx
Yyk7ICAqLwpAQCAtMTQ3Myw2ICsxNDAxLDcgQEAgc3RhdGljIGludCBjaXJydXNmYl9zZXRfcGFy
X2ZvbyhzdHJ1Y3QgZgogCQkJYnJlYWs7CiAKIAkJY2FzZSBCVF9QSUNDT0xPOgorCQljYXNlIEJU
X1NQRUNUUlVNOgogCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjcsIDB4ODUpOwogCQkJLyog
RmFzdCBQYWdlLU1vZGUgd3JpdGVzICovCiAJCQl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9TRVFSRiwg
MHhiMCk7CkBAIC0xNDg4LDE0ICsxNDE3LDYgQEAgc3RhdGljIGludCBjaXJydXNmYl9zZXRfcGFy
X2ZvbyhzdHJ1Y3QgZgogCQkJdmdhX3dzZXEocmVnYmFzZSwgQ0xfU0VRUjFGLCAweDIyKTsKIAkJ
CWJyZWFrOwogCi0JCWNhc2UgQlRfU1BFQ1RSVU06Ci0JCQl2Z2Ffd3NlcShyZWdiYXNlLCBDTF9T
RVFSNywgMHg4NSk7Ci0JCQkvKiBGYXN0IFBhZ2UtTW9kZSB3cml0ZXMgKi8KLQkJCXZnYV93c2Vx
KHJlZ2Jhc2UsIENMX1NFUVJGLCAweGIwKTsKLQkJCS8qIE1DTEsgc2VsZWN0ICovCi0JCQl2Z2Ff
d3NlcShyZWdiYXNlLCBDTF9TRVFSMUYsIDB4MjIpOwotCQkJYnJlYWs7Ci0KIAkJY2FzZSBCVF9Q
SUNBU1NPNDoKIAkJCXZnYV93c2VxKHJlZ2Jhc2UsIENMX1NFUVI3LCAweDI1KTsKIC8qCQkJdmdh
X3dzZXEocmVnYmFzZSwgQ0xfU0VRUjFGLCAweDFjKTsgICovCkBAIC0xNjYyLDE4ICsxNTgzLDcg
QEAgc3RhdGljIGludCBjaXJydXNmYl9zZXRjb2xyZWcodW5zaWduZWQgcgogCQkgICAgKGdyZWVu
IDw8IGluZm8tPnZhci5ncmVlbi5vZmZzZXQpIHwKIAkJICAgIChibHVlIDw8IGluZm8tPnZhci5i
bHVlLm9mZnNldCk7CiAKLQkJc3dpdGNoIChpbmZvLT52YXIuYml0c19wZXJfcGl4ZWwpIHsKLQkJ
Y2FzZSA4OgotCQkJY2luZm8tPnBzZXVkb19wYWxldHRlW3JlZ25vXSA9IHY7Ci0JCQlicmVhazsK
LQkJY2FzZSAxNjoKLQkJCWNpbmZvLT5wc2V1ZG9fcGFsZXR0ZVtyZWdub10gPSB2OwotCQkJYnJl
YWs7Ci0JCWNhc2UgMjQ6Ci0JCWNhc2UgMzI6Ci0JCQljaW5mby0+cHNldWRvX3BhbGV0dGVbcmVn
bm9dID0gdjsKLQkJCWJyZWFrOwotCQl9CisJCWNpbmZvLT5wc2V1ZG9fcGFsZXR0ZVtyZWdub10g
PSB2OwogCQlyZXR1cm4gMDsKIAl9CiAKQEAgLTE3NDMsMTIgKzE2NTMsOCBAQCBzdGF0aWMgaW50
IGNpcnJ1c2ZiX3Bhbl9kaXNwbGF5KHN0cnVjdCBmCiAJdmdhX3djcnQoY2luZm8tPnJlZ2Jhc2Us
IENMX0NSVDFCLCB0bXAyKTsKIAogCS8qIGNvbnN0cnVjdCBiaXQgMTkgb2Ygc2NyZWVuIHN0YXJ0
IGFkZHJlc3MgKi8KLQlpZiAoY2lycnVzZmJfYm9hcmRfaW5mb1tjaW5mby0+YnR5cGVdLnNjcm5f
c3RhcnRfYml0MTkpIHsKLQkJdG1wMiA9IDA7Ci0JCWlmIChiYXNlICYgMHg4MDAwMCkKLQkJCXRt
cDIgPSAweDgwOwotCQl2Z2Ffd2NydChjaW5mby0+cmVnYmFzZSwgQ0xfQ1JUMUQsIHRtcDIpOwot
CX0KKwlpZiAoY2lycnVzZmJfYm9hcmRfaW5mb1tjaW5mby0+YnR5cGVdLnNjcm5fc3RhcnRfYml0
MTkpCisJCXZnYV93Y3J0KGNpbmZvLT5yZWdiYXNlLCBDTF9DUlQxRCwgKGJhc2UgPj4gMTIpICYg
MHg4MCk7CiAKIAkvKiB3cml0ZSBwaXhlbCBwYW5uaW5nIHZhbHVlIHRvIEFSMzM7IHRoaXMgZG9l
cyBub3QgcXVpdGUgd29yayBpbiA4YnBwCiAJICoKQEAgLTIxMzksMzggKzIwNDUsMTUgQEAgc3Rh
dGljIHZvaWQgc3dpdGNoX21vbml0b3Ioc3RydWN0IGNpcnJ1cwogLyogTGludXggMi42LXN0eWxl
ICBhY2NlbGVyYXRlZCBmdW5jdGlvbnMgKi8KIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKiovCiAKLXN0YXRpYyB2b2lkIGNpcnJ1c2ZiX3ByaW1fZmlsbHJlY3Qoc3Ry
dWN0IGZiX2luZm8gKmluZm8sCi0JCQkJICAgY29uc3Qgc3RydWN0IGZiX2ZpbGxyZWN0ICpyZWdp
b24pCi17Ci0Jc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvID0gaW5mby0+cGFyOwotCWludCBt
OyAvKiBieXRlcyBwZXIgcGl4ZWwgKi8KLQl1MzIgY29sb3IgPSAoaW5mby0+Zml4LnZpc3VhbCA9
PSBGQl9WSVNVQUxfVFJVRUNPTE9SKSA/Ci0JCWNpbmZvLT5wc2V1ZG9fcGFsZXR0ZVtyZWdpb24t
PmNvbG9yXSA6IHJlZ2lvbi0+Y29sb3I7Ci0KLQlpZiAoaW5mby0+dmFyLmJpdHNfcGVyX3BpeGVs
ID09IDEpIHsKLQkJY2lycnVzZmJfUmVjdEZpbGwoY2luZm8tPnJlZ2Jhc2UsCi0JCQkJICBpbmZv
LT52YXIuYml0c19wZXJfcGl4ZWwsCi0JCQkJICByZWdpb24tPmR4IC8gOCwgcmVnaW9uLT5keSwK
LQkJCQkgIHJlZ2lvbi0+d2lkdGggLyA4LCByZWdpb24tPmhlaWdodCwKLQkJCQkgIGNvbG9yLAot
CQkJCSAgY2luZm8tPmN1cnJlbnRtb2RlLmxpbmVfbGVuZ3RoKTsKLQl9IGVsc2UgewotCQltID0g
KGluZm8tPnZhci5iaXRzX3Blcl9waXhlbCArIDcpIC8gODsKLQkJY2lycnVzZmJfUmVjdEZpbGwo
Y2luZm8tPnJlZ2Jhc2UsCi0JCQkJICBpbmZvLT52YXIuYml0c19wZXJfcGl4ZWwsCi0JCQkJICBy
ZWdpb24tPmR4ICogbSwgcmVnaW9uLT5keSwKLQkJCQkgIHJlZ2lvbi0+d2lkdGggKiBtLCByZWdp
b24tPmhlaWdodCwKLQkJCQkgIGNvbG9yLAotCQkJCSAgY2luZm8tPmN1cnJlbnRtb2RlLmxpbmVf
bGVuZ3RoKTsKLQl9Ci0JcmV0dXJuOwotfQotCiBzdGF0aWMgdm9pZCBjaXJydXNmYl9maWxscmVj
dChzdHJ1Y3QgZmJfaW5mbyAqaW5mbywKIAkJCSAgICAgIGNvbnN0IHN0cnVjdCBmYl9maWxscmVj
dCAqcmVnaW9uKQogewogCXN0cnVjdCBmYl9maWxscmVjdCBtb2RkZWQ7CiAJaW50IHZ4cmVzLCB2
eXJlczsKKwlzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8gPSBpbmZvLT5wYXI7CisJaW50IG0g
PSBpbmZvLT52YXIuYml0c19wZXJfcGl4ZWw7CisJdTMyIGNvbG9yID0gKGluZm8tPmZpeC52aXN1
YWwgPT0gRkJfVklTVUFMX1RSVUVDT0xPUikgPworCQljaW5mby0+cHNldWRvX3BhbGV0dGVbcmVn
aW9uLT5jb2xvcl0gOiByZWdpb24tPmNvbG9yOwogCiAJaWYgKGluZm8tPnN0YXRlICE9IEZCSU5G
T19TVEFURV9SVU5OSU5HKQogCQlyZXR1cm47CkBAIC0yMTkzLDMwICsyMDc2LDEyIEBAIHN0YXRp
YyB2b2lkIGNpcnJ1c2ZiX2ZpbGxyZWN0KHN0cnVjdCBmYl8KIAlpZiAobW9kZGVkLmR5ICsgbW9k
ZGVkLmhlaWdodCA+IHZ5cmVzKQogCQltb2RkZWQuaGVpZ2h0ID0gdnlyZXMgLSBtb2RkZWQuZHk7
CiAKLQljaXJydXNmYl9wcmltX2ZpbGxyZWN0KGluZm8sICZtb2RkZWQpOwotfQotCi1zdGF0aWMg
dm9pZCBjaXJydXNmYl9wcmltX2NvcHlhcmVhKHN0cnVjdCBmYl9pbmZvICppbmZvLAotCQkJCSAg
IGNvbnN0IHN0cnVjdCBmYl9jb3B5YXJlYSAqYXJlYSkKLXsKLQlzdHJ1Y3QgY2lycnVzZmJfaW5m
byAqY2luZm8gPSBpbmZvLT5wYXI7Ci0JaW50IG07IC8qIGJ5dGVzIHBlciBwaXhlbCAqLwotCi0J
aWYgKGluZm8tPnZhci5iaXRzX3Blcl9waXhlbCA9PSAxKSB7Ci0JCWNpcnJ1c2ZiX0JpdEJMVChj
aW5mby0+cmVnYmFzZSwgaW5mby0+dmFyLmJpdHNfcGVyX3BpeGVsLAotCQkJCWFyZWEtPnN4IC8g
OCwgYXJlYS0+c3ksCi0JCQkJYXJlYS0+ZHggLyA4LCBhcmVhLT5keSwKLQkJCQlhcmVhLT53aWR0
aCAvIDgsIGFyZWEtPmhlaWdodCwKLQkJCQljaW5mby0+Y3VycmVudG1vZGUubGluZV9sZW5ndGgp
OwotCX0gZWxzZSB7Ci0JCW0gPSAoaW5mby0+dmFyLmJpdHNfcGVyX3BpeGVsICsgNykgLyA4Owot
CQljaXJydXNmYl9CaXRCTFQoY2luZm8tPnJlZ2Jhc2UsIGluZm8tPnZhci5iaXRzX3Blcl9waXhl
bCwKLQkJCQlhcmVhLT5zeCAqIG0sIGFyZWEtPnN5LAotCQkJCWFyZWEtPmR4ICogbSwgYXJlYS0+
ZHksCi0JCQkJYXJlYS0+d2lkdGggKiBtLCBhcmVhLT5oZWlnaHQsCi0JCQkJY2luZm8tPmN1cnJl
bnRtb2RlLmxpbmVfbGVuZ3RoKTsKLQl9Ci0JcmV0dXJuOworCWNpcnJ1c2ZiX1JlY3RGaWxsKGNp
bmZvLT5yZWdiYXNlLAorCQkJICBpbmZvLT52YXIuYml0c19wZXJfcGl4ZWwsCisJCQkgIChyZWdp
b24tPmR4ICogbSkgLyA4LCByZWdpb24tPmR5LAorCQkJICAocmVnaW9uLT53aWR0aCAqIG0pIC8g
OCwgcmVnaW9uLT5oZWlnaHQsCisJCQkgIGNvbG9yLAorCQkJICBjaW5mby0+Y3VycmVudG1vZGUu
bGluZV9sZW5ndGgpOwogfQogCiBzdGF0aWMgdm9pZCBjaXJydXNmYl9jb3B5YXJlYShzdHJ1Y3Qg
ZmJfaW5mbyAqaW5mbywKQEAgLTIyMjQsMTMgKzIwODksOCBAQCBzdGF0aWMgdm9pZCBjaXJydXNm
Yl9jb3B5YXJlYShzdHJ1Y3QgZmJfCiB7CiAJc3RydWN0IGZiX2NvcHlhcmVhIG1vZGRlZDsKIAl1
MzIgdnhyZXMsIHZ5cmVzOwotCi0JbW9kZGVkLnN4ID0gYXJlYS0+c3g7Ci0JbW9kZGVkLnN5ID0g
YXJlYS0+c3k7Ci0JbW9kZGVkLmR4ID0gYXJlYS0+ZHg7Ci0JbW9kZGVkLmR5ID0gYXJlYS0+ZHk7
Ci0JbW9kZGVkLndpZHRoICA9IGFyZWEtPndpZHRoOwotCW1vZGRlZC5oZWlnaHQgPSBhcmVhLT5o
ZWlnaHQ7CisJc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvID0gaW5mby0+cGFyOworCWludCBt
ID0gaW5mby0+dmFyLmJpdHNfcGVyX3BpeGVsOwogCiAJaWYgKGluZm8tPnN0YXRlICE9IEZCSU5G
T19TVEFURV9SVU5OSU5HKQogCQlyZXR1cm47CkBAIC0yMjQxLDYgKzIxMDEsNyBAQCBzdGF0aWMg
dm9pZCBjaXJydXNmYl9jb3B5YXJlYShzdHJ1Y3QgZmJfCiAKIAl2eHJlcyA9IGluZm8tPnZhci54
cmVzX3ZpcnR1YWw7CiAJdnlyZXMgPSBpbmZvLT52YXIueXJlc192aXJ0dWFsOworCW1lbWNweSgm
bW9kZGVkLCBhcmVhLCBzaXplb2Yoc3RydWN0IGZiX2NvcHlhcmVhKSk7CiAKIAlpZiAoIW1vZGRl
ZC53aWR0aCB8fCAhbW9kZGVkLmhlaWdodCB8fAogCSAgIG1vZGRlZC5zeCA+PSB2eHJlcyB8fCBt
b2RkZWQuc3kgPj0gdnlyZXMgfHwKQEAgLTIyNTYsNyArMjExNywxMiBAQCBzdGF0aWMgdm9pZCBj
aXJydXNmYl9jb3B5YXJlYShzdHJ1Y3QgZmJfCiAJaWYgKG1vZGRlZC5keSArIG1vZGRlZC5oZWln
aHQgPiB2eXJlcykKIAkJbW9kZGVkLmhlaWdodCA9IHZ5cmVzIC0gbW9kZGVkLmR5OwogCi0JY2ly
cnVzZmJfcHJpbV9jb3B5YXJlYShpbmZvLCAmbW9kZGVkKTsKKwljaXJydXNmYl9CaXRCTFQoY2lu
Zm8tPnJlZ2Jhc2UsIGluZm8tPnZhci5iaXRzX3Blcl9waXhlbCwKKwkJCShhcmVhLT5zeCAqIG0p
IC8gOCwgYXJlYS0+c3ksCisJCQkoYXJlYS0+ZHggKiBtKSAvIDgsIGFyZWEtPmR5LAorCQkJKGFy
ZWEtPndpZHRoICogbSkgLyA4LCBhcmVhLT5oZWlnaHQsCisJCQljaW5mby0+Y3VycmVudG1vZGUu
bGluZV9sZW5ndGgpOworCiB9CiAKIHN0YXRpYyB2b2lkIGNpcnJ1c2ZiX2ltYWdlYmxpdChzdHJ1
Y3QgZmJfaW5mbyAqaW5mbywKQEAgLTIzNjYsNyArMjIzMiw2IEBAIHN0YXRpYyB2b2lkIGNpcnJ1
c2ZiX3BjaV91bm1hcChzdHJ1Y3QgZmIKIAlpZiAocmVsZWFzZV9pb19wb3J0cykKIAkJcmVsZWFz
ZV9yZWdpb24oMHgzQzAsIDMyKTsKIAlwY2lfcmVsZWFzZV9yZWdpb25zKHBkZXYpOwotCWZyYW1l
YnVmZmVyX3JlbGVhc2UoaW5mbyk7CiB9CiAjZW5kaWYgLyogQ09ORklHX1BDSSAqLwogCkBAIC0y
MzgzLDcgKzIyNDgsNiBAQCBzdGF0aWMgdm9pZCBfX2RldmV4aXQgY2lycnVzZmJfem9ycm9fdW5t
CiAJCWlmICh6b3Jyb19yZXNvdXJjZV9zdGFydChjaW5mby0+emRldikgPiAweDAxMDAwMDAwKQog
CQkJaW91bm1hcChpbmZvLT5zY3JlZW5fYmFzZSk7CiAJfQotCWZyYW1lYnVmZmVyX3JlbGVhc2Uo
Y2luZm8tPmluZm8pOwogfQogI2VuZGlmIC8qIENPTkZJR19aT1JSTyAqLwogCkBAIC0yNDgxLDYg
KzIzNDUsNyBAQCBlcnJfZGVhbGxvY19jbWFwOgogCWZiX2RlYWxsb2NfY21hcCgmaW5mby0+Y21h
cCk7CiBlcnJfdW5tYXBfY2lycnVzZmI6CiAJY2luZm8tPnVubWFwKGluZm8pOworCWZyYW1lYnVm
ZmVyX3JlbGVhc2UoaW5mbyk7CiAJcmV0dXJuIGVycjsKIH0KIApAQCAtMjQ5NSw2ICsyMzYwLDcg
QEAgc3RhdGljIHZvaWQgX19kZXZleGl0IGNpcnJ1c2ZiX2NsZWFudXAocwogCWZiX2RlYWxsb2Nf
Y21hcCgmaW5mby0+Y21hcCk7CiAJcHJpbnRrKCJGcmFtZWJ1ZmZlciB1bnJlZ2lzdGVyZWRcbiIp
OwogCWNpbmZvLT51bm1hcChpbmZvKTsKKwlmcmFtZWJ1ZmZlcl9yZWxlYXNlKGluZm8pOwogCiAJ
RFBSSU5USygiRVhJVFxuIik7CiB9Cg==

--part46c690693df67
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--part46c690693df67
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part46c690693df67--

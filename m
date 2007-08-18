From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH 2/3] cirrusfb: remove fields from
	cirrusfb_info
Date: Sat, 18 Aug 2007 08:21:50 +0200
Message-ID: <46c68ffe8c46f@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46c68ffe8cf94"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IMHh4-0001Gn-45 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 23:21:54 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IMHh2-0005cx-Rs
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 23:21:54 -0700
Received: from poczta-16.free.wp-sa.pl (HELO localhost) ([10.1.1.71])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	18 Aug 2007 08:21:50 +0200
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

--part46c68ffe8cf94
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes unused or redundant fields
from cirrusfb_info structure.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.23.old/drivers/video/cirrusfb.c	2007-08-18 06:
50:10.000000000 +0200
+++ linux-2.6.23/drivers/video/cirrusfb.c	2007-08-18 07:14:
35.000000000 +0200
@@ -369,23 +369,14 @@ enum cirrusfb_dbg_reg_class {
=20
 /* info about board */
 struct cirrusfb_info {
-	struct fb_info *info;
-
-	u8 __iomem *fbmem;
 	u8 __iomem *regbase;
-	u8 __iomem *mem;
-	unsigned long size;
 	enum cirrus_board btype;
 	unsigned char SFR;	/* Shadow of special function=20
register */
=20
-	unsigned long fbmem_phys;
-	unsigned long fbregs_phys;
-
 	struct cirrusfb_regs currentmode;
 	int blank_mode;
=20
 	u32	pseudo_palette[16];
-	struct { u8 red, green, blue, pad; } palette[256];
=20
 #ifdef CONFIG_ZORRO
 	struct zorro_dev *zdev;
@@ -393,7 +384,7 @@ struct cirrusfb_info {
 #ifdef CONFIG_PCI
 	struct pci_dev *pdev;
 #endif
-	void (*unmap)(struct cirrusfb_info *cinfo);
+	void (*unmap)(struct fb_info *info);
 };
=20
 static unsigned cirrusfb_def_mode =3D 1;
@@ -536,7 +527,7 @@ static int cirrusfb_decode_var(const str
 				struct cirrusfb_regs *regs,
 				const struct fb_info *info);
 /*--- Internal routines=20
----------------------------------------------------*/
-static void init_vgachip(struct cirrusfb_info *cinfo);
+static void init_vgachip(struct fb_info *info);
 static void switch_monitor(struct cirrusfb_info *cinfo, int on);
 static void WGen(const struct cirrusfb_info *cinfo,
 		 int regnum, unsigned char val);
@@ -645,7 +636,6 @@ static long cirrusfb_get_mclk(long freq,
 static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 			      struct fb_info *info)
 {
-	struct cirrusfb_info *cinfo =3D info->par;
 	int nom, den;		/* translyting from pixels->bytes */
 	int yres, i;
 	static struct { int xres, yres; } modes[] =3D
@@ -690,7 +680,7 @@ static int cirrusfb_check_var(struct fb_
 		return -EINVAL;
 	}
=20
-	if (var->xres * nom / den * var->yres > cinfo->size) {
+	if (var->xres * nom / den * var->yres > info->screen_size)=20
{
 		printk(KERN_ERR "cirrusfb: mode %dx%dx%d rejected..."
 			"resolution too high to fit into video memory!\n",
 			var->xres, var->yres, var->bits_per_pixel);
@@ -704,7 +694,8 @@ static int cirrusfb_check_var(struct fb_
 		printk(KERN_INFO
 		     "cirrusfb: using maximum available virtual=20
resolution\n");
 		for (i =3D 0; modes[i].xres !=3D -1; i++) {
-			if (modes[i].xres * nom / den * modes[i].yres <=20
cinfo->size / 2)
+			int size =3D modes[i].xres * nom / den * modes[i].yres;
+			if (size < info->screen_size / 2)
 				break;
 		}
 		if (modes[i].xres =3D=3D -1) {
@@ -1018,7 +1009,7 @@ static int cirrusfb_set_par_foo(struct f
 	       var->xres, var->yres, var->bits_per_pixel);
 	DPRINTK("pixclock: %d\n", var->pixclock);
=20
-	init_vgachip(cinfo);
+	init_vgachip(info);
=20
 	err =3D cirrusfb_decode_var(var, &regs, info);
 	if (err) {
@@ -1686,10 +1677,6 @@ static int cirrusfb_setcolreg(unsigned r
 		return 0;
 	}
=20
-	cinfo->palette[regno].red =3D red;
-	cinfo->palette[regno].green =3D green;
-	cinfo->palette[regno].blue =3D blue;
-
 	if (info->var.bits_per_pixel =3D=3D 8)
 		WClut(cinfo, regno, red >> 10, green >> 10, blue >> 10);
=20
@@ -1848,8 +1835,9 @@ static int cirrusfb_blank(int blank_mode
=20
/****************************************************************
************/
 /**** BEGIN Internal Routines=20
***********************************************/
=20
-static void init_vgachip(struct cirrusfb_info *cinfo)
+static void init_vgachip(struct fb_info *info)
 {
+	struct cirrusfb_info *cinfo =3D info->par;
 	const struct cirrusfb_board_info_rec *bi;
=20
 	DPRINTK("ENTER\n");
@@ -1903,7 +1891,8 @@ static void init_vgachip(struct cirrusfb
 		break;
 	}
=20
-	assert(cinfo->size > 0); /* make sure RAM size set by this=20
point */
+	/* make sure RAM size set by this point */
+	assert(info->screen_size > 0);
=20
 	/* the P4 is not fully initialized here; I rely on it=20
having been */
 	/* inited under AmigaOS already, which seems to work just=20
fine    */
@@ -2089,7 +2078,7 @@ static void init_vgachip(struct cirrusfb
 	WHDR(cinfo, 0);	/* Hidden DAC register: - */
=20
 	printk(KERN_DEBUG "cirrusfb: This board has %ld bytes of=20
DRAM memory\n",
-		cinfo->size);
+		info->screen_size);
 	DPRINTK("EXIT\n");
 	return;
 }
@@ -2150,24 +2139,25 @@ static void switch_monitor(struct cirrus
 /* Linux 2.6-style  accelerated functions */
 /******************************************/
=20
-static void cirrusfb_prim_fillrect(struct cirrusfb_info *cinfo,
+static void cirrusfb_prim_fillrect(struct fb_info *info,
 				   const struct fb_fillrect *region)
 {
+	struct cirrusfb_info *cinfo =3D info->par;
 	int m; /* bytes per pixel */
-	u32 color =3D (cinfo->info->fix.visual =3D=3D=20
FB_VISUAL_TRUECOLOR) ?
+	u32 color =3D (info->fix.visual =3D=3D FB_VISUAL_TRUECOLOR) ?
 		cinfo->pseudo_palette[region->color] : region->color;
=20
-	if (cinfo->info->var.bits_per_pixel =3D=3D 1) {
+	if (info->var.bits_per_pixel =3D=3D 1) {
 		cirrusfb_RectFill(cinfo->regbase,
-				  cinfo->info->var.bits_per_pixel,
+				  info->var.bits_per_pixel,
 				  region->dx / 8, region->dy,
 				  region->width / 8, region->height,
 				  color,
 				  cinfo->currentmode.line_length);
 	} else {
-		m =3D (cinfo->info->var.bits_per_pixel + 7) / 8;
+		m =3D (info->var.bits_per_pixel + 7) / 8;
 		cirrusfb_RectFill(cinfo->regbase,
-				  cinfo->info->var.bits_per_pixel,
+				  info->var.bits_per_pixel,
 				  region->dx * m, region->dy,
 				  region->width * m, region->height,
 				  color,
@@ -2179,7 +2169,6 @@ static void cirrusfb_prim_fillrect(struc
 static void cirrusfb_fillrect(struct fb_info *info,
 			      const struct fb_fillrect *region)
 {
-	struct cirrusfb_info *cinfo =3D info->par;
 	struct fb_fillrect modded;
 	int vxres, vyres;
=20
@@ -2204,22 +2193,24 @@ static void cirrusfb_fillrect(struct fb_
 	if (modded.dy + modded.height > vyres)
 		modded.height =3D vyres - modded.dy;
=20
-	cirrusfb_prim_fillrect(cinfo, &modded);
+	cirrusfb_prim_fillrect(info, &modded);
 }
=20
-static void cirrusfb_prim_copyarea(struct cirrusfb_info *cinfo,
+static void cirrusfb_prim_copyarea(struct fb_info *info,
 				   const struct fb_copyarea *area)
 {
+	struct cirrusfb_info *cinfo =3D info->par;
 	int m; /* bytes per pixel */
-	if (cinfo->info->var.bits_per_pixel =3D=3D 1) {
-		cirrusfb_BitBLT(cinfo->regbase, cinfo->info->var.
bits_per_pixel,
+
+	if (info->var.bits_per_pixel =3D=3D 1) {
+		cirrusfb_BitBLT(cinfo->regbase, info->var.
bits_per_pixel,
 				area->sx / 8, area->sy,
 				area->dx / 8, area->dy,
 				area->width / 8, area->height,
 				cinfo->currentmode.line_length);
 	} else {
-		m =3D (cinfo->info->var.bits_per_pixel + 7) / 8;
-		cirrusfb_BitBLT(cinfo->regbase, cinfo->info->var.
bits_per_pixel,
+		m =3D (info->var.bits_per_pixel + 7) / 8;
+		cirrusfb_BitBLT(cinfo->regbase, info->var.
bits_per_pixel,
 				area->sx * m, area->sy,
 				area->dx * m, area->dy,
 				area->width * m, area->height,
@@ -2231,9 +2222,9 @@ static void cirrusfb_prim_copyarea(struc
 static void cirrusfb_copyarea(struct fb_info *info,
 			      const struct fb_copyarea *area)
 {
-	struct cirrusfb_info *cinfo =3D info->par;
 	struct fb_copyarea modded;
 	u32 vxres, vyres;
+
 	modded.sx =3D area->sx;
 	modded.sy =3D area->sy;
 	modded.dx =3D area->dx;
@@ -2265,7 +2256,7 @@ static void cirrusfb_copyarea(struct fb_
 	if (modded.dy + modded.height > vyres)
 		modded.height =3D vyres - modded.dy;
=20
-	cirrusfb_prim_copyarea(cinfo, &modded);
+	cirrusfb_prim_copyarea(info, &modded);
 }
=20
 static void cirrusfb_imageblit(struct fb_info *info,
@@ -2363,18 +2354,19 @@ static void get_pci_addrs(const struct p
 	DPRINTK("EXIT\n");
 }
=20
-static void cirrusfb_pci_unmap(struct cirrusfb_info *cinfo)
+static void cirrusfb_pci_unmap(struct fb_info *info)
 {
+	struct cirrusfb_info *cinfo =3D info->par;
 	struct pci_dev *pdev =3D cinfo->pdev;
=20
-	iounmap(cinfo->fbmem);
+	iounmap(info->screen_base);
 #if 0 /* if system didn't claim this region, we would... */
 	release_mem_region(0xA0000, 65535);
 #endif
 	if (release_io_ports)
 		release_region(0x3C0, 32);
 	pci_release_regions(pdev);
-	framebuffer_release(cinfo->info);
+	framebuffer_release(info);
 }
 #endif /* CONFIG_PCI */
=20
@@ -2386,21 +2378,20 @@ static void __devexit cirrusfb_zorro_unm
 	if (cinfo->btype =3D=3D BT_PICASSO4) {
 		cinfo->regbase -=3D 0x600000;
 		iounmap((void *)cinfo->regbase);
-		iounmap((void *)cinfo->fbmem);
+		iounmap(info->screen_base);
 	} else {
 		if (zorro_resource_start(cinfo->zdev) > 0x01000000)
-			iounmap((void *)cinfo->fbmem);
+			iounmap(info->screen_base);
 	}
 	framebuffer_release(cinfo->info);
 }
 #endif /* CONFIG_ZORRO */
=20
-static int cirrusfb_set_fbinfo(struct cirrusfb_info *cinfo)
+static int cirrusfb_set_fbinfo(struct fb_info *info)
 {
-	struct fb_info *info =3D cinfo->info;
+	struct cirrusfb_info *cinfo =3D info->par;
 	struct fb_var_screeninfo *var =3D &info->var;
=20
-	info->par =3D cinfo;
 	info->pseudo_palette =3D cinfo->pseudo_palette;
 	info->flags =3D FBINFO_DEFAULT
 		    | FBINFO_HWACCEL_XPAN
@@ -2410,7 +2401,6 @@ static int cirrusfb_set_fbinfo(struct ci
 	if (noaccel)
 		info->flags |=3D FBINFO_HWACCEL_DISABLED;
 	info->fbops =3D &cirrusfb_ops;
-	info->screen_base =3D cinfo->fbmem;
 	if (cinfo->btype =3D=3D BT_GD5480) {
 		if (var->bits_per_pixel =3D=3D 16)
 			info->screen_base +=3D 1 * MB_;
@@ -2424,9 +2414,9 @@ static int cirrusfb_set_fbinfo(struct ci
=20
 	/* monochrome: only 1 memory plane */
 	/* 8 bit and above: Use whole memory area */
-	info->fix.smem_start =3D cinfo->fbmem_phys;
-	info->fix.smem_len   =3D
-		(var->bits_per_pixel =3D=3D 1) ? cinfo->size / 4 :=20
cinfo->size;
+	info->fix.smem_len   =3D info->screen_size;
+	if (var->bits_per_pixel =3D=3D 1)
+		info->fix.smem_len /=3D 4;
 	info->fix.type       =3D cinfo->currentmode.type;
 	info->fix.type_aux   =3D 0;
 	info->fix.visual     =3D cinfo->currentmode.visual;
@@ -2436,7 +2426,6 @@ static int cirrusfb_set_fbinfo(struct ci
 	info->fix.line_length =3D cinfo->currentmode.line_length;
=20
 	/* FIXME: map region at 0xB8000 if available, fill in here=20
*/
-	info->fix.mmio_start =3D cinfo->fbregs_phys;
 	info->fix.mmio_len   =3D 0;
 	info->fix.accel =3D FB_ACCEL_NONE;
=20
@@ -2445,9 +2434,9 @@ static int cirrusfb_set_fbinfo(struct ci
 	return 0;
 }
=20
-static int cirrusfb_register(struct cirrusfb_info *cinfo)
+static int cirrusfb_register(struct fb_info *info)
 {
-	struct fb_info *info;
+	struct cirrusfb_info *cinfo =3D info->par;
 	int err;
 	enum cirrus_board btype;
=20
@@ -2456,13 +2445,12 @@ static int cirrusfb_register(struct cirr
 	printk(KERN_INFO "cirrusfb: Driver for Cirrus Logic based "
 		"graphic boards, v" CIRRUSFB_VERSION "\n");
=20
-	info =3D cinfo->info;
 	btype =3D cinfo->btype;
=20
 	/* sanity checks */
 	assert(btype !=3D BT_NONE);
=20
-	DPRINTK("cirrusfb: (RAM start set to: 0x%p)\n",=20
cinfo->fbmem);
+	DPRINTK("cirrusfb: (RAM start set to: 0x%p)\n",=20
info->screen_base);
=20
 	/* Make pretend we've set the var so our structures are in=20
a "good" */
 	/* state, even though we haven't written the mode to the hw=20
yet...  */
@@ -2477,7 +2465,7 @@ static int cirrusfb_register(struct cirr
 	}
=20
 	/* set all the vital stuff */
-	cirrusfb_set_fbinfo(cinfo);
+	cirrusfb_set_fbinfo(info);
=20
 	err =3D register_framebuffer(info);
 	if (err < 0) {
@@ -2492,7 +2480,7 @@ static int cirrusfb_register(struct cirr
 err_dealloc_cmap:
 	fb_dealloc_cmap(&info->cmap);
 err_unmap_cirrusfb:
-	cinfo->unmap(cinfo);
+	cinfo->unmap(info);
 	return err;
 }
=20
@@ -2506,7 +2494,7 @@ static void __devexit cirrusfb_cleanup(s
 	unregister_framebuffer(info);
 	fb_dealloc_cmap(&info->cmap);
 	printk("Framebuffer unregistered\n");
-	cinfo->unmap(cinfo);
+	cinfo->unmap(info);
=20
 	DPRINTK("EXIT\n");
 }
@@ -2535,7 +2523,6 @@ static int cirrusfb_pci_register(struct=20
 	}
=20
 	cinfo =3D info->par;
-	cinfo->info =3D info;
 	cinfo->pdev =3D pdev;
 	cinfo->btype =3D btype =3D (enum cirrus_board)=20
ent->driver_data;
=20
@@ -2546,19 +2533,19 @@ static int cirrusfb_pci_register(struct=20
 	if (isPReP) {
 		pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0,=20
0x00000000);
 #ifdef CONFIG_PPC_PREP
-		get_prep_addrs(&board_addr, &cinfo->fbregs_phys);
+		get_prep_addrs(&board_addr, &info->fix.mmio_start);
 #endif
 	/* PReP dies if we ioremap the IO registers, but it works=20
w/out... */
-		cinfo->regbase =3D (char __iomem *) cinfo->fbregs_phys;
+		cinfo->regbase =3D (char __iomem *) info->fix.mmio_start;
 	} else {
 		DPRINTK("Attempt to get PCI info for Cirrus Graphics=20
Card\n");
-		get_pci_addrs(pdev, &board_addr, &cinfo->fbregs_phys);
+		get_pci_addrs(pdev, &board_addr, &info->fix.mmio_start);
 		/* FIXME: this forces VGA.  alternatives? */
 		cinfo->regbase =3D NULL;
 	}
=20
 	DPRINTK("Board address: 0x%lx, register address: 0x%lx\n",
-		board_addr, cinfo->fbregs_phys);
+		board_addr, info->fix.mmio_start);
=20
 	board_size =3D (btype =3D=3D BT_GD5480) ?
 		32 * MB_ : cirrusfb_get_memsize(cinfo->regbase);
@@ -2582,24 +2569,24 @@ static int cirrusfb_pci_register(struct=20
 	if (request_region(0x3C0, 32, "cirrusfb"))
 		release_io_ports =3D 1;
=20
-	cinfo->fbmem =3D ioremap(board_addr, board_size);
-	if (!cinfo->fbmem) {
+	info->screen_base =3D ioremap(board_addr, board_size);
+	if (!info->screen_base) {
 		ret =3D -EIO;
 		goto err_release_legacy;
 	}
=20
-	cinfo->fbmem_phys =3D board_addr;
-	cinfo->size =3D board_size;
+	info->fix.smem_start =3D board_addr;
+	info->screen_size =3D board_size;
 	cinfo->unmap =3D cirrusfb_pci_unmap;
=20
 	printk(KERN_INFO " RAM (%lu kB) at 0xx%lx, ",
-		cinfo->size / KB_, board_addr);
+		info->screen_size / KB_, board_addr);
 	printk(KERN_INFO "Cirrus Logic chipset on PCI bus\n");
 	pci_set_drvdata(pdev, info);
=20
-	ret =3D cirrusfb_register(cinfo);
+	ret =3D cirrusfb_register(info);
 	if (ret)
-		iounmap(cinfo->fbmem);
+		iounmap(info->screen_base);
 	return ret;
=20
 err_release_legacy:
@@ -2677,7 +2664,7 @@ static int cirrusfb_zorro_register(struc
 	cinfo->zdev =3D z;
 	board_addr =3D zorro_resource_start(z);
 	board_size =3D zorro_resource_len(z);
-	cinfo->size =3D size;
+	info->screen_size =3D size;
=20
 	if (!zorro_request_device(z, "cirrusfb")) {
 		printk(KERN_ERR "cirrusfb: cannot reserve region 0x%lx,=20
"
@@ -2705,27 +2692,27 @@ static int cirrusfb_zorro_register(struc
 		DPRINTK("cirrusfb: Virtual address for board set to: $%
p\n",
 			cinfo->regbase);
 		cinfo->regbase +=3D 0x600000;
-		cinfo->fbregs_phys =3D board_addr + 0x600000;
+		info->fix.mmio_start =3D board_addr + 0x600000;
=20
-		cinfo->fbmem_phys =3D board_addr + 16777216;
-		cinfo->fbmem =3D ioremap(cinfo->fbmem_phys, 16777216);
-		if (!cinfo->fbmem)
+		info->fix.smem_start =3D board_addr + 16777216;
+		info->screen_base =3D ioremap(info->fix.smem_start,=20
16777216);
+		if (!info->screen_base)
 			goto err_unmap_regbase;
 	} else {
 		printk(KERN_INFO " REG at $%lx\n",
 			(unsigned long) z2->resource.start);
=20
-		cinfo->fbmem_phys =3D board_addr;
+		info->fix.smem_start =3D board_addr;
 		if (board_addr > 0x01000000)
-			cinfo->fbmem =3D ioremap(board_addr, board_size);
+			info->screen_base =3D ioremap(board_addr, board_size);
 		else
-			cinfo->fbmem =3D (caddr_t) ZTWO_VADDR(board_addr);
-		if (!cinfo->fbmem)
+			info->screen_base =3D (caddr_t) ZTWO_VADDR(board_addr);
+		if (!info->screen_base)
 			goto err_release_region;
=20
 		/* set address for REG area of board */
 		cinfo->regbase =3D (caddr_t) ZTWO_VADDR(z2->resource.
start);
-		cinfo->fbregs_phys =3D z2->resource.start;
+		info->fix.mmio_start =3D z2->resource.start;
=20
 		DPRINTK("cirrusfb: Virtual address for board set to: $%
p\n",
 			cinfo->regbase);
@@ -2738,10 +2725,10 @@ static int cirrusfb_zorro_register(struc
 	ret =3D cirrusfb_register(cinfo);
 	if (ret) {
 		if (btype =3D=3D BT_PICASSO4) {
-			iounmap(cinfo->fbmem);
+			iounmap(info->screen_base);
 			iounmap(cinfo->regbase - 0x600000);
 		} else if (board_addr > 0x01000000)
-			iounmap(cinfo->fbmem);
+			iounmap(info->screen_base);
 	}
 	return ret;
=20


----------------------------------------------------
Producenci filmu SEZON NA MISIA przedstawiaj=B1
surfuj=B1ce pingwiny w nowej, animowanej komedii
NA FALI -  w kinach od 10 sierpnia!=20
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fnafali_zwi=
astun.html&sid=3D1256

--part46c68ffe8cf94
Content-Type: application/octet-stream; name="cirrusfb-remove-fields.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cirrusfb-remove-fields.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggcmVt
b3ZlcyB1bnVzZWQgb3IgcmVkdW5kYW50IGZpZWxkcwpmcm9tIGNpcnJ1c2ZiX2luZm8gc3RydWN0
dXJlLgoKU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4K
Ci0tLQoKLS0tIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9jaXJydXNmYi5jCTIwMDct
MDgtMTggMDY6NTA6MTAuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92
aWRlby9jaXJydXNmYi5jCTIwMDctMDgtMTggMDc6MTQ6MzUuMDAwMDAwMDAwICswMjAwCkBAIC0z
NjksMjMgKzM2OSwxNCBAQCBlbnVtIGNpcnJ1c2ZiX2RiZ19yZWdfY2xhc3MgewogCiAvKiBpbmZv
IGFib3V0IGJvYXJkICovCiBzdHJ1Y3QgY2lycnVzZmJfaW5mbyB7Ci0Jc3RydWN0IGZiX2luZm8g
KmluZm87Ci0KLQl1OCBfX2lvbWVtICpmYm1lbTsKIAl1OCBfX2lvbWVtICpyZWdiYXNlOwotCXU4
IF9faW9tZW0gKm1lbTsKLQl1bnNpZ25lZCBsb25nIHNpemU7CiAJZW51bSBjaXJydXNfYm9hcmQg
YnR5cGU7CiAJdW5zaWduZWQgY2hhciBTRlI7CS8qIFNoYWRvdyBvZiBzcGVjaWFsIGZ1bmN0aW9u
IHJlZ2lzdGVyICovCiAKLQl1bnNpZ25lZCBsb25nIGZibWVtX3BoeXM7Ci0JdW5zaWduZWQgbG9u
ZyBmYnJlZ3NfcGh5czsKLQogCXN0cnVjdCBjaXJydXNmYl9yZWdzIGN1cnJlbnRtb2RlOwogCWlu
dCBibGFua19tb2RlOwogCiAJdTMyCXBzZXVkb19wYWxldHRlWzE2XTsKLQlzdHJ1Y3QgeyB1OCBy
ZWQsIGdyZWVuLCBibHVlLCBwYWQ7IH0gcGFsZXR0ZVsyNTZdOwogCiAjaWZkZWYgQ09ORklHX1pP
UlJPCiAJc3RydWN0IHpvcnJvX2RldiAqemRldjsKQEAgLTM5Myw3ICszODQsNyBAQCBzdHJ1Y3Qg
Y2lycnVzZmJfaW5mbyB7CiAjaWZkZWYgQ09ORklHX1BDSQogCXN0cnVjdCBwY2lfZGV2ICpwZGV2
OwogI2VuZGlmCi0Jdm9pZCAoKnVubWFwKShzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8pOwor
CXZvaWQgKCp1bm1hcCkoc3RydWN0IGZiX2luZm8gKmluZm8pOwogfTsKIAogc3RhdGljIHVuc2ln
bmVkIGNpcnJ1c2ZiX2RlZl9tb2RlID0gMTsKQEAgLTUzNiw3ICs1MjcsNyBAQCBzdGF0aWMgaW50
IGNpcnJ1c2ZiX2RlY29kZV92YXIoY29uc3Qgc3RyCiAJCQkJc3RydWN0IGNpcnJ1c2ZiX3JlZ3Mg
KnJlZ3MsCiAJCQkJY29uc3Qgc3RydWN0IGZiX2luZm8gKmluZm8pOwogLyotLS0gSW50ZXJuYWwg
cm91dGluZXMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSovCi1zdGF0aWMgdm9pZCBpbml0X3ZnYWNoaXAoc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNp
bmZvKTsKK3N0YXRpYyB2b2lkIGluaXRfdmdhY2hpcChzdHJ1Y3QgZmJfaW5mbyAqaW5mbyk7CiBz
dGF0aWMgdm9pZCBzd2l0Y2hfbW9uaXRvcihzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8sIGlu
dCBvbik7CiBzdGF0aWMgdm9pZCBXR2VuKGNvbnN0IHN0cnVjdCBjaXJydXNmYl9pbmZvICpjaW5m
bywKIAkJIGludCByZWdudW0sIHVuc2lnbmVkIGNoYXIgdmFsKTsKQEAgLTY0NSw3ICs2MzYsNiBA
QCBzdGF0aWMgbG9uZyBjaXJydXNmYl9nZXRfbWNsayhsb25nIGZyZXEsCiBzdGF0aWMgaW50IGNp
cnJ1c2ZiX2NoZWNrX3ZhcihzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8gKnZhciwKIAkJCSAgICAg
IHN0cnVjdCBmYl9pbmZvICppbmZvKQogewotCXN0cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbyA9
IGluZm8tPnBhcjsKIAlpbnQgbm9tLCBkZW47CQkvKiB0cmFuc2x5dGluZyBmcm9tIHBpeGVscy0+
Ynl0ZXMgKi8KIAlpbnQgeXJlcywgaTsKIAlzdGF0aWMgc3RydWN0IHsgaW50IHhyZXMsIHlyZXM7
IH0gbW9kZXNbXSA9CkBAIC02OTAsNyArNjgwLDcgQEAgc3RhdGljIGludCBjaXJydXNmYl9jaGVj
a192YXIoc3RydWN0IGZiXwogCQlyZXR1cm4gLUVJTlZBTDsKIAl9CiAKLQlpZiAodmFyLT54cmVz
ICogbm9tIC8gZGVuICogdmFyLT55cmVzID4gY2luZm8tPnNpemUpIHsKKwlpZiAodmFyLT54cmVz
ICogbm9tIC8gZGVuICogdmFyLT55cmVzID4gaW5mby0+c2NyZWVuX3NpemUpIHsKIAkJcHJpbnRr
KEtFUk5fRVJSICJjaXJydXNmYjogbW9kZSAlZHglZHglZCByZWplY3RlZC4uLiIKIAkJCSJyZXNv
bHV0aW9uIHRvbyBoaWdoIHRvIGZpdCBpbnRvIHZpZGVvIG1lbW9yeSFcbiIsCiAJCQl2YXItPnhy
ZXMsIHZhci0+eXJlcywgdmFyLT5iaXRzX3Blcl9waXhlbCk7CkBAIC03MDQsNyArNjk0LDggQEAg
c3RhdGljIGludCBjaXJydXNmYl9jaGVja192YXIoc3RydWN0IGZiXwogCQlwcmludGsoS0VSTl9J
TkZPCiAJCSAgICAgImNpcnJ1c2ZiOiB1c2luZyBtYXhpbXVtIGF2YWlsYWJsZSB2aXJ0dWFsIHJl
c29sdXRpb25cbiIpOwogCQlmb3IgKGkgPSAwOyBtb2Rlc1tpXS54cmVzICE9IC0xOyBpKyspIHsK
LQkJCWlmIChtb2Rlc1tpXS54cmVzICogbm9tIC8gZGVuICogbW9kZXNbaV0ueXJlcyA8IGNpbmZv
LT5zaXplIC8gMikKKwkJCWludCBzaXplID0gbW9kZXNbaV0ueHJlcyAqIG5vbSAvIGRlbiAqIG1v
ZGVzW2ldLnlyZXM7CisJCQlpZiAoc2l6ZSA8IGluZm8tPnNjcmVlbl9zaXplIC8gMikKIAkJCQli
cmVhazsKIAkJfQogCQlpZiAobW9kZXNbaV0ueHJlcyA9PSAtMSkgewpAQCAtMTAxOCw3ICsxMDA5
LDcgQEAgc3RhdGljIGludCBjaXJydXNmYl9zZXRfcGFyX2ZvbyhzdHJ1Y3QgZgogCSAgICAgICB2
YXItPnhyZXMsIHZhci0+eXJlcywgdmFyLT5iaXRzX3Blcl9waXhlbCk7CiAJRFBSSU5USygicGl4
Y2xvY2s6ICVkXG4iLCB2YXItPnBpeGNsb2NrKTsKIAotCWluaXRfdmdhY2hpcChjaW5mbyk7CisJ
aW5pdF92Z2FjaGlwKGluZm8pOwogCiAJZXJyID0gY2lycnVzZmJfZGVjb2RlX3Zhcih2YXIsICZy
ZWdzLCBpbmZvKTsKIAlpZiAoZXJyKSB7CkBAIC0xNjg2LDEwICsxNjc3LDYgQEAgc3RhdGljIGlu
dCBjaXJydXNmYl9zZXRjb2xyZWcodW5zaWduZWQgcgogCQlyZXR1cm4gMDsKIAl9CiAKLQljaW5m
by0+cGFsZXR0ZVtyZWdub10ucmVkID0gcmVkOwotCWNpbmZvLT5wYWxldHRlW3JlZ25vXS5ncmVl
biA9IGdyZWVuOwotCWNpbmZvLT5wYWxldHRlW3JlZ25vXS5ibHVlID0gYmx1ZTsKLQogCWlmIChp
bmZvLT52YXIuYml0c19wZXJfcGl4ZWwgPT0gOCkKIAkJV0NsdXQoY2luZm8sIHJlZ25vLCByZWQg
Pj4gMTAsIGdyZWVuID4+IDEwLCBibHVlID4+IDEwKTsKIApAQCAtMTg0OCw4ICsxODM1LDkgQEAg
c3RhdGljIGludCBjaXJydXNmYl9ibGFuayhpbnQgYmxhbmtfbW9kZQogLyoqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKiovCiAvKioqKiBCRUdJTiBJbnRlcm5hbCBSb3V0aW5lcyAqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KIAotc3RhdGljIHZvaWQgaW5pdF92Z2FjaGlw
KHN0cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbykKK3N0YXRpYyB2b2lkIGluaXRfdmdhY2hpcChz
dHJ1Y3QgZmJfaW5mbyAqaW5mbykKIHsKKwlzdHJ1Y3QgY2lycnVzZmJfaW5mbyAqY2luZm8gPSBp
bmZvLT5wYXI7CiAJY29uc3Qgc3RydWN0IGNpcnJ1c2ZiX2JvYXJkX2luZm9fcmVjICpiaTsKIAog
CURQUklOVEsoIkVOVEVSXG4iKTsKQEAgLTE5MDMsNyArMTg5MSw4IEBAIHN0YXRpYyB2b2lkIGlu
aXRfdmdhY2hpcChzdHJ1Y3QgY2lycnVzZmIKIAkJYnJlYWs7CiAJfQogCi0JYXNzZXJ0KGNpbmZv
LT5zaXplID4gMCk7IC8qIG1ha2Ugc3VyZSBSQU0gc2l6ZSBzZXQgYnkgdGhpcyBwb2ludCAqLwor
CS8qIG1ha2Ugc3VyZSBSQU0gc2l6ZSBzZXQgYnkgdGhpcyBwb2ludCAqLworCWFzc2VydChpbmZv
LT5zY3JlZW5fc2l6ZSA+IDApOwogCiAJLyogdGhlIFA0IGlzIG5vdCBmdWxseSBpbml0aWFsaXpl
ZCBoZXJlOyBJIHJlbHkgb24gaXQgaGF2aW5nIGJlZW4gKi8KIAkvKiBpbml0ZWQgdW5kZXIgQW1p
Z2FPUyBhbHJlYWR5LCB3aGljaCBzZWVtcyB0byB3b3JrIGp1c3QgZmluZSAgICAqLwpAQCAtMjA4
OSw3ICsyMDc4LDcgQEAgc3RhdGljIHZvaWQgaW5pdF92Z2FjaGlwKHN0cnVjdCBjaXJydXNmYgog
CVdIRFIoY2luZm8sIDApOwkvKiBIaWRkZW4gREFDIHJlZ2lzdGVyOiAtICovCiAKIAlwcmludGso
S0VSTl9ERUJVRyAiY2lycnVzZmI6IFRoaXMgYm9hcmQgaGFzICVsZCBieXRlcyBvZiBEUkFNIG1l
bW9yeVxuIiwKLQkJY2luZm8tPnNpemUpOworCQlpbmZvLT5zY3JlZW5fc2l6ZSk7CiAJRFBSSU5U
SygiRVhJVFxuIik7CiAJcmV0dXJuOwogfQpAQCAtMjE1MCwyNCArMjEzOSwyNSBAQCBzdGF0aWMg
dm9pZCBzd2l0Y2hfbW9uaXRvcihzdHJ1Y3QgY2lycnVzCiAvKiBMaW51eCAyLjYtc3R5bGUgIGFj
Y2VsZXJhdGVkIGZ1bmN0aW9ucyAqLwogLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKi8KIAotc3RhdGljIHZvaWQgY2lycnVzZmJfcHJpbV9maWxscmVjdChzdHJ1Y3Qg
Y2lycnVzZmJfaW5mbyAqY2luZm8sCitzdGF0aWMgdm9pZCBjaXJydXNmYl9wcmltX2ZpbGxyZWN0
KHN0cnVjdCBmYl9pbmZvICppbmZvLAogCQkJCSAgIGNvbnN0IHN0cnVjdCBmYl9maWxscmVjdCAq
cmVnaW9uKQogeworCXN0cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbyA9IGluZm8tPnBhcjsKIAlp
bnQgbTsgLyogYnl0ZXMgcGVyIHBpeGVsICovCi0JdTMyIGNvbG9yID0gKGNpbmZvLT5pbmZvLT5m
aXgudmlzdWFsID09IEZCX1ZJU1VBTF9UUlVFQ09MT1IpID8KKwl1MzIgY29sb3IgPSAoaW5mby0+
Zml4LnZpc3VhbCA9PSBGQl9WSVNVQUxfVFJVRUNPTE9SKSA/CiAJCWNpbmZvLT5wc2V1ZG9fcGFs
ZXR0ZVtyZWdpb24tPmNvbG9yXSA6IHJlZ2lvbi0+Y29sb3I7CiAKLQlpZiAoY2luZm8tPmluZm8t
PnZhci5iaXRzX3Blcl9waXhlbCA9PSAxKSB7CisJaWYgKGluZm8tPnZhci5iaXRzX3Blcl9waXhl
bCA9PSAxKSB7CiAJCWNpcnJ1c2ZiX1JlY3RGaWxsKGNpbmZvLT5yZWdiYXNlLAotCQkJCSAgY2lu
Zm8tPmluZm8tPnZhci5iaXRzX3Blcl9waXhlbCwKKwkJCQkgIGluZm8tPnZhci5iaXRzX3Blcl9w
aXhlbCwKIAkJCQkgIHJlZ2lvbi0+ZHggLyA4LCByZWdpb24tPmR5LAogCQkJCSAgcmVnaW9uLT53
aWR0aCAvIDgsIHJlZ2lvbi0+aGVpZ2h0LAogCQkJCSAgY29sb3IsCiAJCQkJICBjaW5mby0+Y3Vy
cmVudG1vZGUubGluZV9sZW5ndGgpOwogCX0gZWxzZSB7Ci0JCW0gPSAoY2luZm8tPmluZm8tPnZh
ci5iaXRzX3Blcl9waXhlbCArIDcpIC8gODsKKwkJbSA9IChpbmZvLT52YXIuYml0c19wZXJfcGl4
ZWwgKyA3KSAvIDg7CiAJCWNpcnJ1c2ZiX1JlY3RGaWxsKGNpbmZvLT5yZWdiYXNlLAotCQkJCSAg
Y2luZm8tPmluZm8tPnZhci5iaXRzX3Blcl9waXhlbCwKKwkJCQkgIGluZm8tPnZhci5iaXRzX3Bl
cl9waXhlbCwKIAkJCQkgIHJlZ2lvbi0+ZHggKiBtLCByZWdpb24tPmR5LAogCQkJCSAgcmVnaW9u
LT53aWR0aCAqIG0sIHJlZ2lvbi0+aGVpZ2h0LAogCQkJCSAgY29sb3IsCkBAIC0yMTc5LDcgKzIx
NjksNiBAQCBzdGF0aWMgdm9pZCBjaXJydXNmYl9wcmltX2ZpbGxyZWN0KHN0cnVjCiBzdGF0aWMg
dm9pZCBjaXJydXNmYl9maWxscmVjdChzdHJ1Y3QgZmJfaW5mbyAqaW5mbywKIAkJCSAgICAgIGNv
bnN0IHN0cnVjdCBmYl9maWxscmVjdCAqcmVnaW9uKQogewotCXN0cnVjdCBjaXJydXNmYl9pbmZv
ICpjaW5mbyA9IGluZm8tPnBhcjsKIAlzdHJ1Y3QgZmJfZmlsbHJlY3QgbW9kZGVkOwogCWludCB2
eHJlcywgdnlyZXM7CiAKQEAgLTIyMDQsMjIgKzIxOTMsMjQgQEAgc3RhdGljIHZvaWQgY2lycnVz
ZmJfZmlsbHJlY3Qoc3RydWN0IGZiXwogCWlmIChtb2RkZWQuZHkgKyBtb2RkZWQuaGVpZ2h0ID4g
dnlyZXMpCiAJCW1vZGRlZC5oZWlnaHQgPSB2eXJlcyAtIG1vZGRlZC5keTsKIAotCWNpcnJ1c2Zi
X3ByaW1fZmlsbHJlY3QoY2luZm8sICZtb2RkZWQpOworCWNpcnJ1c2ZiX3ByaW1fZmlsbHJlY3Qo
aW5mbywgJm1vZGRlZCk7CiB9CiAKLXN0YXRpYyB2b2lkIGNpcnJ1c2ZiX3ByaW1fY29weWFyZWEo
c3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvLAorc3RhdGljIHZvaWQgY2lycnVzZmJfcHJpbV9j
b3B5YXJlYShzdHJ1Y3QgZmJfaW5mbyAqaW5mbywKIAkJCQkgICBjb25zdCBzdHJ1Y3QgZmJfY29w
eWFyZWEgKmFyZWEpCiB7CisJc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZvID0gaW5mby0+cGFy
OwogCWludCBtOyAvKiBieXRlcyBwZXIgcGl4ZWwgKi8KLQlpZiAoY2luZm8tPmluZm8tPnZhci5i
aXRzX3Blcl9waXhlbCA9PSAxKSB7Ci0JCWNpcnJ1c2ZiX0JpdEJMVChjaW5mby0+cmVnYmFzZSwg
Y2luZm8tPmluZm8tPnZhci5iaXRzX3Blcl9waXhlbCwKKworCWlmIChpbmZvLT52YXIuYml0c19w
ZXJfcGl4ZWwgPT0gMSkgeworCQljaXJydXNmYl9CaXRCTFQoY2luZm8tPnJlZ2Jhc2UsIGluZm8t
PnZhci5iaXRzX3Blcl9waXhlbCwKIAkJCQlhcmVhLT5zeCAvIDgsIGFyZWEtPnN5LAogCQkJCWFy
ZWEtPmR4IC8gOCwgYXJlYS0+ZHksCiAJCQkJYXJlYS0+d2lkdGggLyA4LCBhcmVhLT5oZWlnaHQs
CiAJCQkJY2luZm8tPmN1cnJlbnRtb2RlLmxpbmVfbGVuZ3RoKTsKIAl9IGVsc2UgewotCQltID0g
KGNpbmZvLT5pbmZvLT52YXIuYml0c19wZXJfcGl4ZWwgKyA3KSAvIDg7Ci0JCWNpcnJ1c2ZiX0Jp
dEJMVChjaW5mby0+cmVnYmFzZSwgY2luZm8tPmluZm8tPnZhci5iaXRzX3Blcl9waXhlbCwKKwkJ
bSA9IChpbmZvLT52YXIuYml0c19wZXJfcGl4ZWwgKyA3KSAvIDg7CisJCWNpcnJ1c2ZiX0JpdEJM
VChjaW5mby0+cmVnYmFzZSwgaW5mby0+dmFyLmJpdHNfcGVyX3BpeGVsLAogCQkJCWFyZWEtPnN4
ICogbSwgYXJlYS0+c3ksCiAJCQkJYXJlYS0+ZHggKiBtLCBhcmVhLT5keSwKIAkJCQlhcmVhLT53
aWR0aCAqIG0sIGFyZWEtPmhlaWdodCwKQEAgLTIyMzEsOSArMjIyMiw5IEBAIHN0YXRpYyB2b2lk
IGNpcnJ1c2ZiX3ByaW1fY29weWFyZWEoc3RydWMKIHN0YXRpYyB2b2lkIGNpcnJ1c2ZiX2NvcHlh
cmVhKHN0cnVjdCBmYl9pbmZvICppbmZvLAogCQkJICAgICAgY29uc3Qgc3RydWN0IGZiX2NvcHlh
cmVhICphcmVhKQogewotCXN0cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbyA9IGluZm8tPnBhcjsK
IAlzdHJ1Y3QgZmJfY29weWFyZWEgbW9kZGVkOwogCXUzMiB2eHJlcywgdnlyZXM7CisKIAltb2Rk
ZWQuc3ggPSBhcmVhLT5zeDsKIAltb2RkZWQuc3kgPSBhcmVhLT5zeTsKIAltb2RkZWQuZHggPSBh
cmVhLT5keDsKQEAgLTIyNjUsNyArMjI1Niw3IEBAIHN0YXRpYyB2b2lkIGNpcnJ1c2ZiX2NvcHlh
cmVhKHN0cnVjdCBmYl8KIAlpZiAobW9kZGVkLmR5ICsgbW9kZGVkLmhlaWdodCA+IHZ5cmVzKQog
CQltb2RkZWQuaGVpZ2h0ID0gdnlyZXMgLSBtb2RkZWQuZHk7CiAKLQljaXJydXNmYl9wcmltX2Nv
cHlhcmVhKGNpbmZvLCAmbW9kZGVkKTsKKwljaXJydXNmYl9wcmltX2NvcHlhcmVhKGluZm8sICZt
b2RkZWQpOwogfQogCiBzdGF0aWMgdm9pZCBjaXJydXNmYl9pbWFnZWJsaXQoc3RydWN0IGZiX2lu
Zm8gKmluZm8sCkBAIC0yMzYzLDE4ICsyMzU0LDE5IEBAIHN0YXRpYyB2b2lkIGdldF9wY2lfYWRk
cnMoY29uc3Qgc3RydWN0IHAKIAlEUFJJTlRLKCJFWElUXG4iKTsKIH0KIAotc3RhdGljIHZvaWQg
Y2lycnVzZmJfcGNpX3VubWFwKHN0cnVjdCBjaXJydXNmYl9pbmZvICpjaW5mbykKK3N0YXRpYyB2
b2lkIGNpcnJ1c2ZiX3BjaV91bm1hcChzdHJ1Y3QgZmJfaW5mbyAqaW5mbykKIHsKKwlzdHJ1Y3Qg
Y2lycnVzZmJfaW5mbyAqY2luZm8gPSBpbmZvLT5wYXI7CiAJc3RydWN0IHBjaV9kZXYgKnBkZXYg
PSBjaW5mby0+cGRldjsKIAotCWlvdW5tYXAoY2luZm8tPmZibWVtKTsKKwlpb3VubWFwKGluZm8t
PnNjcmVlbl9iYXNlKTsKICNpZiAwIC8qIGlmIHN5c3RlbSBkaWRuJ3QgY2xhaW0gdGhpcyByZWdp
b24sIHdlIHdvdWxkLi4uICovCiAJcmVsZWFzZV9tZW1fcmVnaW9uKDB4QTAwMDAsIDY1NTM1KTsK
ICNlbmRpZgogCWlmIChyZWxlYXNlX2lvX3BvcnRzKQogCQlyZWxlYXNlX3JlZ2lvbigweDNDMCwg
MzIpOwogCXBjaV9yZWxlYXNlX3JlZ2lvbnMocGRldik7Ci0JZnJhbWVidWZmZXJfcmVsZWFzZShj
aW5mby0+aW5mbyk7CisJZnJhbWVidWZmZXJfcmVsZWFzZShpbmZvKTsKIH0KICNlbmRpZiAvKiBD
T05GSUdfUENJICovCiAKQEAgLTIzODYsMjEgKzIzNzgsMjAgQEAgc3RhdGljIHZvaWQgX19kZXZl
eGl0IGNpcnJ1c2ZiX3pvcnJvX3VubQogCWlmIChjaW5mby0+YnR5cGUgPT0gQlRfUElDQVNTTzQp
IHsKIAkJY2luZm8tPnJlZ2Jhc2UgLT0gMHg2MDAwMDA7CiAJCWlvdW5tYXAoKHZvaWQgKiljaW5m
by0+cmVnYmFzZSk7Ci0JCWlvdW5tYXAoKHZvaWQgKiljaW5mby0+ZmJtZW0pOworCQlpb3VubWFw
KGluZm8tPnNjcmVlbl9iYXNlKTsKIAl9IGVsc2UgewogCQlpZiAoem9ycm9fcmVzb3VyY2Vfc3Rh
cnQoY2luZm8tPnpkZXYpID4gMHgwMTAwMDAwMCkKLQkJCWlvdW5tYXAoKHZvaWQgKiljaW5mby0+
ZmJtZW0pOworCQkJaW91bm1hcChpbmZvLT5zY3JlZW5fYmFzZSk7CiAJfQogCWZyYW1lYnVmZmVy
X3JlbGVhc2UoY2luZm8tPmluZm8pOwogfQogI2VuZGlmIC8qIENPTkZJR19aT1JSTyAqLwogCi1z
dGF0aWMgaW50IGNpcnJ1c2ZiX3NldF9mYmluZm8oc3RydWN0IGNpcnJ1c2ZiX2luZm8gKmNpbmZv
KQorc3RhdGljIGludCBjaXJydXNmYl9zZXRfZmJpbmZvKHN0cnVjdCBmYl9pbmZvICppbmZvKQog
ewotCXN0cnVjdCBmYl9pbmZvICppbmZvID0gY2luZm8tPmluZm87CisJc3RydWN0IGNpcnJ1c2Zi
X2luZm8gKmNpbmZvID0gaW5mby0+cGFyOwogCXN0cnVjdCBmYl92YXJfc2NyZWVuaW5mbyAqdmFy
ID0gJmluZm8tPnZhcjsKIAotCWluZm8tPnBhciA9IGNpbmZvOwogCWluZm8tPnBzZXVkb19wYWxl
dHRlID0gY2luZm8tPnBzZXVkb19wYWxldHRlOwogCWluZm8tPmZsYWdzID0gRkJJTkZPX0RFRkFV
TFQKIAkJICAgIHwgRkJJTkZPX0hXQUNDRUxfWFBBTgpAQCAtMjQxMCw3ICsyNDAxLDYgQEAgc3Rh
dGljIGludCBjaXJydXNmYl9zZXRfZmJpbmZvKHN0cnVjdCBjaQogCWlmIChub2FjY2VsKQogCQlp
bmZvLT5mbGFncyB8PSBGQklORk9fSFdBQ0NFTF9ESVNBQkxFRDsKIAlpbmZvLT5mYm9wcyA9ICZj
aXJydXNmYl9vcHM7Ci0JaW5mby0+c2NyZWVuX2Jhc2UgPSBjaW5mby0+ZmJtZW07CiAJaWYgKGNp
bmZvLT5idHlwZSA9PSBCVF9HRDU0ODApIHsKIAkJaWYgKHZhci0+Yml0c19wZXJfcGl4ZWwgPT0g
MTYpCiAJCQlpbmZvLT5zY3JlZW5fYmFzZSArPSAxICogTUJfOwpAQCAtMjQyNCw5ICsyNDE0LDkg
QEAgc3RhdGljIGludCBjaXJydXNmYl9zZXRfZmJpbmZvKHN0cnVjdCBjaQogCiAJLyogbW9ub2No
cm9tZTogb25seSAxIG1lbW9yeSBwbGFuZSAqLwogCS8qIDggYml0IGFuZCBhYm92ZTogVXNlIHdo
b2xlIG1lbW9yeSBhcmVhICovCi0JaW5mby0+Zml4LnNtZW1fc3RhcnQgPSBjaW5mby0+ZmJtZW1f
cGh5czsKLQlpbmZvLT5maXguc21lbV9sZW4gICA9Ci0JCSh2YXItPmJpdHNfcGVyX3BpeGVsID09
IDEpID8gY2luZm8tPnNpemUgLyA0IDogY2luZm8tPnNpemU7CisJaW5mby0+Zml4LnNtZW1fbGVu
ICAgPSBpbmZvLT5zY3JlZW5fc2l6ZTsKKwlpZiAodmFyLT5iaXRzX3Blcl9waXhlbCA9PSAxKQor
CQlpbmZvLT5maXguc21lbV9sZW4gLz0gNDsKIAlpbmZvLT5maXgudHlwZSAgICAgICA9IGNpbmZv
LT5jdXJyZW50bW9kZS50eXBlOwogCWluZm8tPmZpeC50eXBlX2F1eCAgID0gMDsKIAlpbmZvLT5m
aXgudmlzdWFsICAgICA9IGNpbmZvLT5jdXJyZW50bW9kZS52aXN1YWw7CkBAIC0yNDM2LDcgKzI0
MjYsNiBAQCBzdGF0aWMgaW50IGNpcnJ1c2ZiX3NldF9mYmluZm8oc3RydWN0IGNpCiAJaW5mby0+
Zml4LmxpbmVfbGVuZ3RoID0gY2luZm8tPmN1cnJlbnRtb2RlLmxpbmVfbGVuZ3RoOwogCiAJLyog
RklYTUU6IG1hcCByZWdpb24gYXQgMHhCODAwMCBpZiBhdmFpbGFibGUsIGZpbGwgaW4gaGVyZSAq
LwotCWluZm8tPmZpeC5tbWlvX3N0YXJ0ID0gY2luZm8tPmZicmVnc19waHlzOwogCWluZm8tPmZp
eC5tbWlvX2xlbiAgID0gMDsKIAlpbmZvLT5maXguYWNjZWwgPSBGQl9BQ0NFTF9OT05FOwogCkBA
IC0yNDQ1LDkgKzI0MzQsOSBAQCBzdGF0aWMgaW50IGNpcnJ1c2ZiX3NldF9mYmluZm8oc3RydWN0
IGNpCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBpbnQgY2lycnVzZmJfcmVnaXN0ZXIoc3RydWN0
IGNpcnJ1c2ZiX2luZm8gKmNpbmZvKQorc3RhdGljIGludCBjaXJydXNmYl9yZWdpc3RlcihzdHJ1
Y3QgZmJfaW5mbyAqaW5mbykKIHsKLQlzdHJ1Y3QgZmJfaW5mbyAqaW5mbzsKKwlzdHJ1Y3QgY2ly
cnVzZmJfaW5mbyAqY2luZm8gPSBpbmZvLT5wYXI7CiAJaW50IGVycjsKIAllbnVtIGNpcnJ1c19i
b2FyZCBidHlwZTsKIApAQCAtMjQ1NiwxMyArMjQ0NSwxMiBAQCBzdGF0aWMgaW50IGNpcnJ1c2Zi
X3JlZ2lzdGVyKHN0cnVjdCBjaXJyCiAJcHJpbnRrKEtFUk5fSU5GTyAiY2lycnVzZmI6IERyaXZl
ciBmb3IgQ2lycnVzIExvZ2ljIGJhc2VkICIKIAkJImdyYXBoaWMgYm9hcmRzLCB2IiBDSVJSVVNG
Ql9WRVJTSU9OICJcbiIpOwogCi0JaW5mbyA9IGNpbmZvLT5pbmZvOwogCWJ0eXBlID0gY2luZm8t
PmJ0eXBlOwogCiAJLyogc2FuaXR5IGNoZWNrcyAqLwogCWFzc2VydChidHlwZSAhPSBCVF9OT05F
KTsKIAotCURQUklOVEsoImNpcnJ1c2ZiOiAoUkFNIHN0YXJ0IHNldCB0bzogMHglcClcbiIsIGNp
bmZvLT5mYm1lbSk7CisJRFBSSU5USygiY2lycnVzZmI6IChSQU0gc3RhcnQgc2V0IHRvOiAweCVw
KVxuIiwgaW5mby0+c2NyZWVuX2Jhc2UpOwogCiAJLyogTWFrZSBwcmV0ZW5kIHdlJ3ZlIHNldCB0
aGUgdmFyIHNvIG91ciBzdHJ1Y3R1cmVzIGFyZSBpbiBhICJnb29kIiAqLwogCS8qIHN0YXRlLCBl
dmVuIHRob3VnaCB3ZSBoYXZlbid0IHdyaXR0ZW4gdGhlIG1vZGUgdG8gdGhlIGh3IHlldC4uLiAg
Ki8KQEAgLTI0NzcsNyArMjQ2NSw3IEBAIHN0YXRpYyBpbnQgY2lycnVzZmJfcmVnaXN0ZXIoc3Ry
dWN0IGNpcnIKIAl9CiAKIAkvKiBzZXQgYWxsIHRoZSB2aXRhbCBzdHVmZiAqLwotCWNpcnJ1c2Zi
X3NldF9mYmluZm8oY2luZm8pOworCWNpcnJ1c2ZiX3NldF9mYmluZm8oaW5mbyk7CiAKIAllcnIg
PSByZWdpc3Rlcl9mcmFtZWJ1ZmZlcihpbmZvKTsKIAlpZiAoZXJyIDwgMCkgewpAQCAtMjQ5Miw3
ICsyNDgwLDcgQEAgc3RhdGljIGludCBjaXJydXNmYl9yZWdpc3RlcihzdHJ1Y3QgY2lycgogZXJy
X2RlYWxsb2NfY21hcDoKIAlmYl9kZWFsbG9jX2NtYXAoJmluZm8tPmNtYXApOwogZXJyX3VubWFw
X2NpcnJ1c2ZiOgotCWNpbmZvLT51bm1hcChjaW5mbyk7CisJY2luZm8tPnVubWFwKGluZm8pOwog
CXJldHVybiBlcnI7CiB9CiAKQEAgLTI1MDYsNyArMjQ5NCw3IEBAIHN0YXRpYyB2b2lkIF9fZGV2
ZXhpdCBjaXJydXNmYl9jbGVhbnVwKHMKIAl1bnJlZ2lzdGVyX2ZyYW1lYnVmZmVyKGluZm8pOwog
CWZiX2RlYWxsb2NfY21hcCgmaW5mby0+Y21hcCk7CiAJcHJpbnRrKCJGcmFtZWJ1ZmZlciB1bnJl
Z2lzdGVyZWRcbiIpOwotCWNpbmZvLT51bm1hcChjaW5mbyk7CisJY2luZm8tPnVubWFwKGluZm8p
OwogCiAJRFBSSU5USygiRVhJVFxuIik7CiB9CkBAIC0yNTM1LDcgKzI1MjMsNiBAQCBzdGF0aWMg
aW50IGNpcnJ1c2ZiX3BjaV9yZWdpc3RlcihzdHJ1Y3QgCiAJfQogCiAJY2luZm8gPSBpbmZvLT5w
YXI7Ci0JY2luZm8tPmluZm8gPSBpbmZvOwogCWNpbmZvLT5wZGV2ID0gcGRldjsKIAljaW5mby0+
YnR5cGUgPSBidHlwZSA9IChlbnVtIGNpcnJ1c19ib2FyZCkgZW50LT5kcml2ZXJfZGF0YTsKIApA
QCAtMjU0NiwxOSArMjUzMywxOSBAQCBzdGF0aWMgaW50IGNpcnJ1c2ZiX3BjaV9yZWdpc3Rlcihz
dHJ1Y3QgCiAJaWYgKGlzUFJlUCkgewogCQlwY2lfd3JpdGVfY29uZmlnX2R3b3JkKHBkZXYsIFBD
SV9CQVNFX0FERFJFU1NfMCwgMHgwMDAwMDAwMCk7CiAjaWZkZWYgQ09ORklHX1BQQ19QUkVQCi0J
CWdldF9wcmVwX2FkZHJzKCZib2FyZF9hZGRyLCAmY2luZm8tPmZicmVnc19waHlzKTsKKwkJZ2V0
X3ByZXBfYWRkcnMoJmJvYXJkX2FkZHIsICZpbmZvLT5maXgubW1pb19zdGFydCk7CiAjZW5kaWYK
IAkvKiBQUmVQIGRpZXMgaWYgd2UgaW9yZW1hcCB0aGUgSU8gcmVnaXN0ZXJzLCBidXQgaXQgd29y
a3Mgdy9vdXQuLi4gKi8KLQkJY2luZm8tPnJlZ2Jhc2UgPSAoY2hhciBfX2lvbWVtICopIGNpbmZv
LT5mYnJlZ3NfcGh5czsKKwkJY2luZm8tPnJlZ2Jhc2UgPSAoY2hhciBfX2lvbWVtICopIGluZm8t
PmZpeC5tbWlvX3N0YXJ0OwogCX0gZWxzZSB7CiAJCURQUklOVEsoIkF0dGVtcHQgdG8gZ2V0IFBD
SSBpbmZvIGZvciBDaXJydXMgR3JhcGhpY3MgQ2FyZFxuIik7Ci0JCWdldF9wY2lfYWRkcnMocGRl
diwgJmJvYXJkX2FkZHIsICZjaW5mby0+ZmJyZWdzX3BoeXMpOworCQlnZXRfcGNpX2FkZHJzKHBk
ZXYsICZib2FyZF9hZGRyLCAmaW5mby0+Zml4Lm1taW9fc3RhcnQpOwogCQkvKiBGSVhNRTogdGhp
cyBmb3JjZXMgVkdBLiAgYWx0ZXJuYXRpdmVzPyAqLwogCQljaW5mby0+cmVnYmFzZSA9IE5VTEw7
CiAJfQogCiAJRFBSSU5USygiQm9hcmQgYWRkcmVzczogMHglbHgsIHJlZ2lzdGVyIGFkZHJlc3M6
IDB4JWx4XG4iLAotCQlib2FyZF9hZGRyLCBjaW5mby0+ZmJyZWdzX3BoeXMpOworCQlib2FyZF9h
ZGRyLCBpbmZvLT5maXgubW1pb19zdGFydCk7CiAKIAlib2FyZF9zaXplID0gKGJ0eXBlID09IEJU
X0dENTQ4MCkgPwogCQkzMiAqIE1CXyA6IGNpcnJ1c2ZiX2dldF9tZW1zaXplKGNpbmZvLT5yZWdi
YXNlKTsKQEAgLTI1ODIsMjQgKzI1NjksMjQgQEAgc3RhdGljIGludCBjaXJydXNmYl9wY2lfcmVn
aXN0ZXIoc3RydWN0IAogCWlmIChyZXF1ZXN0X3JlZ2lvbigweDNDMCwgMzIsICJjaXJydXNmYiIp
KQogCQlyZWxlYXNlX2lvX3BvcnRzID0gMTsKIAotCWNpbmZvLT5mYm1lbSA9IGlvcmVtYXAoYm9h
cmRfYWRkciwgYm9hcmRfc2l6ZSk7Ci0JaWYgKCFjaW5mby0+ZmJtZW0pIHsKKwlpbmZvLT5zY3Jl
ZW5fYmFzZSA9IGlvcmVtYXAoYm9hcmRfYWRkciwgYm9hcmRfc2l6ZSk7CisJaWYgKCFpbmZvLT5z
Y3JlZW5fYmFzZSkgewogCQlyZXQgPSAtRUlPOwogCQlnb3RvIGVycl9yZWxlYXNlX2xlZ2FjeTsK
IAl9CiAKLQljaW5mby0+ZmJtZW1fcGh5cyA9IGJvYXJkX2FkZHI7Ci0JY2luZm8tPnNpemUgPSBi
b2FyZF9zaXplOworCWluZm8tPmZpeC5zbWVtX3N0YXJ0ID0gYm9hcmRfYWRkcjsKKwlpbmZvLT5z
Y3JlZW5fc2l6ZSA9IGJvYXJkX3NpemU7CiAJY2luZm8tPnVubWFwID0gY2lycnVzZmJfcGNpX3Vu
bWFwOwogCiAJcHJpbnRrKEtFUk5fSU5GTyAiIFJBTSAoJWx1IGtCKSBhdCAweHglbHgsICIsCi0J
CWNpbmZvLT5zaXplIC8gS0JfLCBib2FyZF9hZGRyKTsKKwkJaW5mby0+c2NyZWVuX3NpemUgLyBL
Ql8sIGJvYXJkX2FkZHIpOwogCXByaW50ayhLRVJOX0lORk8gIkNpcnJ1cyBMb2dpYyBjaGlwc2V0
IG9uIFBDSSBidXNcbiIpOwogCXBjaV9zZXRfZHJ2ZGF0YShwZGV2LCBpbmZvKTsKIAotCXJldCA9
IGNpcnJ1c2ZiX3JlZ2lzdGVyKGNpbmZvKTsKKwlyZXQgPSBjaXJydXNmYl9yZWdpc3RlcihpbmZv
KTsKIAlpZiAocmV0KQotCQlpb3VubWFwKGNpbmZvLT5mYm1lbSk7CisJCWlvdW5tYXAoaW5mby0+
c2NyZWVuX2Jhc2UpOwogCXJldHVybiByZXQ7CiAKIGVycl9yZWxlYXNlX2xlZ2FjeToKQEAgLTI2
NzcsNyArMjY2NCw3IEBAIHN0YXRpYyBpbnQgY2lycnVzZmJfem9ycm9fcmVnaXN0ZXIoc3RydWMK
IAljaW5mby0+emRldiA9IHo7CiAJYm9hcmRfYWRkciA9IHpvcnJvX3Jlc291cmNlX3N0YXJ0KHop
OwogCWJvYXJkX3NpemUgPSB6b3Jyb19yZXNvdXJjZV9sZW4oeik7Ci0JY2luZm8tPnNpemUgPSBz
aXplOworCWluZm8tPnNjcmVlbl9zaXplID0gc2l6ZTsKIAogCWlmICghem9ycm9fcmVxdWVzdF9k
ZXZpY2UoeiwgImNpcnJ1c2ZiIikpIHsKIAkJcHJpbnRrKEtFUk5fRVJSICJjaXJydXNmYjogY2Fu
bm90IHJlc2VydmUgcmVnaW9uIDB4JWx4LCAiCkBAIC0yNzA1LDI3ICsyNjkyLDI3IEBAIHN0YXRp
YyBpbnQgY2lycnVzZmJfem9ycm9fcmVnaXN0ZXIoc3RydWMKIAkJRFBSSU5USygiY2lycnVzZmI6
IFZpcnR1YWwgYWRkcmVzcyBmb3IgYm9hcmQgc2V0IHRvOiAkJXBcbiIsCiAJCQljaW5mby0+cmVn
YmFzZSk7CiAJCWNpbmZvLT5yZWdiYXNlICs9IDB4NjAwMDAwOwotCQljaW5mby0+ZmJyZWdzX3Bo
eXMgPSBib2FyZF9hZGRyICsgMHg2MDAwMDA7CisJCWluZm8tPmZpeC5tbWlvX3N0YXJ0ID0gYm9h
cmRfYWRkciArIDB4NjAwMDAwOwogCi0JCWNpbmZvLT5mYm1lbV9waHlzID0gYm9hcmRfYWRkciAr
IDE2Nzc3MjE2OwotCQljaW5mby0+ZmJtZW0gPSBpb3JlbWFwKGNpbmZvLT5mYm1lbV9waHlzLCAx
Njc3NzIxNik7Ci0JCWlmICghY2luZm8tPmZibWVtKQorCQlpbmZvLT5maXguc21lbV9zdGFydCA9
IGJvYXJkX2FkZHIgKyAxNjc3NzIxNjsKKwkJaW5mby0+c2NyZWVuX2Jhc2UgPSBpb3JlbWFwKGlu
Zm8tPmZpeC5zbWVtX3N0YXJ0LCAxNjc3NzIxNik7CisJCWlmICghaW5mby0+c2NyZWVuX2Jhc2Up
CiAJCQlnb3RvIGVycl91bm1hcF9yZWdiYXNlOwogCX0gZWxzZSB7CiAJCXByaW50ayhLRVJOX0lO
Rk8gIiBSRUcgYXQgJCVseFxuIiwKIAkJCSh1bnNpZ25lZCBsb25nKSB6Mi0+cmVzb3VyY2Uuc3Rh
cnQpOwogCi0JCWNpbmZvLT5mYm1lbV9waHlzID0gYm9hcmRfYWRkcjsKKwkJaW5mby0+Zml4LnNt
ZW1fc3RhcnQgPSBib2FyZF9hZGRyOwogCQlpZiAoYm9hcmRfYWRkciA+IDB4MDEwMDAwMDApCi0J
CQljaW5mby0+ZmJtZW0gPSBpb3JlbWFwKGJvYXJkX2FkZHIsIGJvYXJkX3NpemUpOworCQkJaW5m
by0+c2NyZWVuX2Jhc2UgPSBpb3JlbWFwKGJvYXJkX2FkZHIsIGJvYXJkX3NpemUpOwogCQllbHNl
Ci0JCQljaW5mby0+ZmJtZW0gPSAoY2FkZHJfdCkgWlRXT19WQUREUihib2FyZF9hZGRyKTsKLQkJ
aWYgKCFjaW5mby0+ZmJtZW0pCisJCQlpbmZvLT5zY3JlZW5fYmFzZSA9IChjYWRkcl90KSBaVFdP
X1ZBRERSKGJvYXJkX2FkZHIpOworCQlpZiAoIWluZm8tPnNjcmVlbl9iYXNlKQogCQkJZ290byBl
cnJfcmVsZWFzZV9yZWdpb247CiAKIAkJLyogc2V0IGFkZHJlc3MgZm9yIFJFRyBhcmVhIG9mIGJv
YXJkICovCiAJCWNpbmZvLT5yZWdiYXNlID0gKGNhZGRyX3QpIFpUV09fVkFERFIoejItPnJlc291
cmNlLnN0YXJ0KTsKLQkJY2luZm8tPmZicmVnc19waHlzID0gejItPnJlc291cmNlLnN0YXJ0Owor
CQlpbmZvLT5maXgubW1pb19zdGFydCA9IHoyLT5yZXNvdXJjZS5zdGFydDsKIAogCQlEUFJJTlRL
KCJjaXJydXNmYjogVmlydHVhbCBhZGRyZXNzIGZvciBib2FyZCBzZXQgdG86ICQlcFxuIiwKIAkJ
CWNpbmZvLT5yZWdiYXNlKTsKQEAgLTI3MzgsMTAgKzI3MjUsMTAgQEAgc3RhdGljIGludCBjaXJy
dXNmYl96b3Jyb19yZWdpc3RlcihzdHJ1YwogCXJldCA9IGNpcnJ1c2ZiX3JlZ2lzdGVyKGNpbmZv
KTsKIAlpZiAocmV0KSB7CiAJCWlmIChidHlwZSA9PSBCVF9QSUNBU1NPNCkgewotCQkJaW91bm1h
cChjaW5mby0+ZmJtZW0pOworCQkJaW91bm1hcChpbmZvLT5zY3JlZW5fYmFzZSk7CiAJCQlpb3Vu
bWFwKGNpbmZvLT5yZWdiYXNlIC0gMHg2MDAwMDApOwogCQl9IGVsc2UgaWYgKGJvYXJkX2FkZHIg
PiAweDAxMDAwMDAwKQotCQkJaW91bm1hcChjaW5mby0+ZmJtZW0pOworCQkJaW91bm1hcChpbmZv
LT5zY3JlZW5fYmFzZSk7CiAJfQogCXJldHVybiByZXQ7CiAK

--part46c68ffe8cf94
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--part46c68ffe8cf94
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part46c68ffe8cf94--

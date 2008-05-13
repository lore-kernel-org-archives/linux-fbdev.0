From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: add acceleration for TGUI
	families
Date: Tue, 13 May 2008 18:40:42 +0200
Message-ID: <20080513184042.e650a09d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jvxzb-0006a2-Vj for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 May 2008 10:08:48 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JvxzZ-000464-UM
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 May 2008 10:08:47 -0700
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
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds acceleration for TGUI 9440 and 96xx chips. 
These chips requires line length to be power of 2, so this is
also changed.

It also moves the troubling enable_mmio() function to its
final destination.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This is tridentfb patch number 19.

diff -urp linux-2.6.25/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-2.6.25/drivers/video/tridentfb.c	2008-05-13 18:32:24.091097855 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-13 18:33:02.227095118 +0200
@@ -492,6 +492,95 @@ static void image_copy_rect(struct tride
 }
 
 /*
+ * TGUI 9440/96XX acceleration
+ */
+
+static void tgui_init_accel(struct tridentfb_par *par, int pitch, int bpp)
+{
+	unsigned char x = 0;
+
+	/* disable clipping */
+	writemmr(par, 0x2148, 0);
+	writemmr(par, 0x214C, point(4095, 2047));
+
+	switch (bpp) {
+	case 8:
+		x = 0;
+		break;
+	case 16:
+		x = 1;
+		break;
+	case 24:
+		x = 3;
+		break;
+	case 32:
+		x = 2;
+		break;
+	}
+
+	switch ((pitch * bpp) / 8) {
+	case 8192:
+	case 512:
+		x |= 0x00;
+		break;
+	case 1024:
+		x |= 0x04;
+		break;
+	case 2048:
+		x |= 0x08;
+		break;
+	case 4096:
+		x |= 0x0C;
+		break;
+	}
+
+	fb_writew(x, par->io_virt + 0x2122);
+}
+
+static void tgui_fill_rect(struct tridentfb_par *par,
+			   u32 x, u32 y, u32 w, u32 h, u32 c, u32 rop)
+{
+	t_outb(par, ROP_P, 0x2127);
+	writemmr(par, 0x212c, c);
+	writemmr(par, 0x2128, 0x4020);
+	writemmr(par, 0x2140, point(w - 1, h - 1));
+	writemmr(par, 0x2138, point(x, y));
+	t_outb(par, 1, 0x2124);
+}
+
+static void tgui_copy_rect(struct tridentfb_par *par,
+			   u32 x1, u32 y1, u32 x2, u32 y2, u32 w, u32 h)
+{
+	int flags = 0;
+	u16 x1_tmp, x2_tmp, y1_tmp, y2_tmp;
+
+	if ((x1 < x2) && (y1 == y2)) {
+		flags |= 0x0200;
+		x1_tmp = x1 + w - 1;
+		x2_tmp = x2 + w - 1;
+	} else {
+		x1_tmp = x1;
+		x2_tmp = x2;
+	}
+
+	if (y1 < y2) {
+		flags |= 0x0100;
+		y1_tmp = y1 + h - 1;
+		y2_tmp = y2 + h - 1;
+	} else {
+		y1_tmp = y1;
+		y2_tmp = y2;
+	}
+
+	writemmr(par, 0x2128, 0x4 | flags);
+	t_outb(par, ROP_S, 0x2127);
+	writemmr(par, 0x213C, point(x1_tmp, y1_tmp));
+	writemmr(par, 0x2138, point(x2_tmp, y2_tmp));
+	writemmr(par, 0x2140, point(w - 1, h - 1));
+	t_outb(par, 1, 0x2124);
+}
+
+/*
  * Accel functions called by the upper layers
  */
 #ifdef CONFIG_FB_TRIDENT_ACCEL
@@ -530,12 +619,8 @@ static void tridentfb_copyarea(struct fb
 		       ca->width, ca->height);
 	par->wait_engine(par);
 }
-#else /* !CONFIG_FB_TRIDENT_ACCEL */
-#define tridentfb_fillrect cfb_fillrect
-#define tridentfb_copyarea cfb_copyarea
 #endif /* CONFIG_FB_TRIDENT_ACCEL */
 
-
 /*
  * Hardware access functions
  */
@@ -829,6 +914,7 @@ static int tridentfb_check_var(struct fb
 {
 	struct tridentfb_par *par = info->par;
 	int bpp = var->bits_per_pixel;
+	int line_length;
 	int ramdac = 230000; /* 230MHz for most 3D chips */
 	debug("enter\n");
 
@@ -844,9 +930,27 @@ static int tridentfb_check_var(struct fb
 	var->xres = (var->xres + 7) & ~0x7;
 	if (var->xres != var->xres_virtual)
 		var->xres_virtual = var->xres;
+	line_length = var->xres_virtual * bpp / 8;
+#ifdef CONFIG_FB_TRIDENT_ACCEL
+	if (!is3Dchip(par->chip_id)) {
+		/* acceleration requires line length to be power of 2 */
+		if (line_length <= 512)
+			var->xres_virtual = 512 * 8 / bpp;
+		else if (line_length <= 1024)
+			var->xres_virtual = 1024 * 8 / bpp;
+		else if (line_length <= 2048)
+			var->xres_virtual = 2048 * 8 / bpp;
+		else if (line_length <= 4096)
+			var->xres_virtual = 4096 * 8 / bpp;
+		else if (line_length <= 8192)
+			var->xres_virtual = 8192 * 8 / bpp;
+
+		line_length = var->xres_virtual * bpp / 8;
+	}
+#endif
 	if (var->yres > var->yres_virtual)
 		var->yres_virtual = var->yres;
-	if (var->xres * var->yres_virtual * bpp / 8 > info->fix.smem_len)
+	if (line_length * var->yres_virtual > info->fix.smem_len)
 		return -EINVAL;
 
 	switch (bpp) {
@@ -918,7 +1022,7 @@ static int tridentfb_pan_display(struct 
 	unsigned int offset;
 
 	debug("enter\n");
-	offset = (var->xoffset + (var->yoffset * var->xres))
+	offset = (var->xoffset + (var->yoffset * var->xres_virtual))
 		* var->bits_per_pixel / 32;
 	info->var.xoffset = var->xoffset;
 	info->var.yoffset = var->yoffset;
@@ -1049,7 +1153,7 @@ static int tridentfb_set_par(struct fb_i
 	write3X4(par, GraphEngReg, 0x80);
 
 #ifdef CONFIG_FB_TRIDENT_ACCEL
-	par->init_accel(par, info->var.xres, bpp);
+	par->init_accel(par, info->var.xres_virtual, bpp);
 #endif
 
 	switch (bpp) {
@@ -1147,9 +1251,9 @@ static int tridentfb_set_par(struct fb_i
 
 	if (par->flatpanel)
 		set_number_of_lines(par, info->var.yres);
-	set_lwidth(par, info->var.xres * bpp / (4 * 16));
+	info->fix.line_length = info->var.xres_virtual * bpp / 8;
+	set_lwidth(par, info->fix.line_length / 8);
 	info->fix.visual = (bpp == 8) ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
-	info->fix.line_length = info->var.xres * (bpp >> 3);
 	info->cmap.len = (bpp == 8) ? 256 : 16;
 	debug("exit\n");
 	return 0;
@@ -1248,9 +1352,11 @@ static struct fb_ops tridentfb_ops = {
 	.fb_blank = tridentfb_blank,
 	.fb_check_var = tridentfb_check_var,
 	.fb_set_par = tridentfb_set_par,
+#ifdef CONFIG_FB_TRIDENT_ACCEL
 	.fb_fillrect = tridentfb_fillrect,
 	.fb_copyarea = tridentfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
+#endif
 };
 
 static int __devinit trident_pci_probe(struct pci_dev *dev,
@@ -1328,11 +1434,16 @@ static int __devinit trident_pci_probe(s
 		default_par->wait_engine = blade_wait_engine;
 		default_par->fill_rect = blade_fill_rect;
 		default_par->copy_rect = blade_copy_rect;
-	} else {
+	} else if (chip3D) {			/* 3DImage family left */
 		default_par->init_accel = image_init_accel;
 		default_par->wait_engine = image_wait_engine;
 		default_par->fill_rect = image_fill_rect;
 		default_par->copy_rect = image_copy_rect;
+	} else { 				/* TGUI 9440/96XX family */
+		default_par->init_accel = tgui_init_accel;
+		default_par->wait_engine = xp_wait_engine;
+		default_par->fill_rect = tgui_fill_rect;
+		default_par->copy_rect = tgui_copy_rect;
 	}
 
 	default_par->chip_id = chip_id;
@@ -1359,12 +1470,12 @@ static int __devinit trident_pci_probe(s
 		goto out_unmap1;
 	}
 
+	enable_mmio();
+
 	/* setup framebuffer memory */
 	tridentfb_fix.smem_start = pci_resource_start(dev, 0);
 	tridentfb_fix.smem_len = get_memsize(default_par);
 
-	enable_mmio();
-
 	if (!request_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len, "tridentfb")) {
 		debug("request_mem_region failed!\n");
 		disable_mmio(info->par);

----------------------------------------------------------------------
Lepszy niz zakladki. 	
Kliknij >>> http://link.interia.pl/f1db1


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 7/8] tridentfb: move global acceleration
 hooks into structure
Date: Mon, 5 May 2008 18:58:49 +0200
Message-ID: <20080505185849.e640379f.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jt41o-0007xi-RS for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 09:59:04 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jt41j-000789-CY
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 09:59:03 -0700
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
Cc: adaplas@pol.net, akpm@linux-foundation.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch moves acceleration hooks into the
tridentfb_par structure and removes global hooks.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-old/drivers/video/tridentfb.c linux-pc/drivers/video/tridentfb.c
diff -urp linux-old/drivers/video/tridentfb.c linux-pc/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-05-03 04:02:48.000000000 +0200
+++ linux-pc/drivers/video/tridentfb.c	2008-05-03 04:04:40.000000000 +0200
@@ -31,6 +31,12 @@ struct tridentfb_par {
 	u32 pseudo_pal[16];
 	int chip_id;
 	int flatpanel;
+	void (*init_accel) (struct tridentfb_par *, int, int);
+	void (*wait_engine) (struct tridentfb_par *);
+	void (*fill_rect)
+		(struct tridentfb_par *par, u32, u32, u32, u32, u32, u32);
+	void (*copy_rect)
+		(struct tridentfb_par *par, u32, u32, u32, u32, u32, u32);
 };
 
 static unsigned char eng_oper;	/* engine operation... */
@@ -155,15 +161,6 @@ static inline u8 t_inb(struct tridentfb_
 	return fb_readb(p->io_virt + reg);
 }
 
-static struct accel_switch {
-	void (*init_accel) (struct tridentfb_par *, int, int);
-	void (*wait_engine) (struct tridentfb_par *);
-	void (*fill_rect)
-		(struct tridentfb_par *par, u32, u32, u32, u32, u32, u32);
-	void (*copy_rect)
-		(struct tridentfb_par *par, u32, u32, u32, u32, u32, u32);
-} *acc;
-
 static inline void writemmr(struct tridentfb_par *par, u16 r, u32 v)
 {
 	fb_writel(v, par->io_virt + r);
@@ -259,13 +256,6 @@ static void blade_copy_rect(struct tride
 	writemmr(par, DR2, direction ? d1 : d2);
 }
 
-static struct accel_switch accel_blade = {
-	blade_init_accel,
-	blade_wait_engine,
-	blade_fill_rect,
-	blade_copy_rect,
-};
-
 /*
  * BladeXP specific acceleration functions
  */
@@ -405,13 +395,6 @@ static void xp_copy_rect(struct tridentf
 	t_outb(par, 0x01, 0x2124);
 }
 
-static struct accel_switch accel_xp = {
-	xp_init_accel,
-	xp_wait_engine,
-	xp_fill_rect,
-	xp_copy_rect,
-};
-
 /*
  * Image specific acceleration functions
  */
@@ -491,13 +474,6 @@ static void image_copy_rect(struct tride
 		 0x80000000 | 1 << 22 | 1 << 10 | 1 << 7 | direction);
 }
 
-static struct accel_switch accel_image = {
-	image_init_accel,
-	image_wait_engine,
-	image_fill_rect,
-	image_copy_rect,
-};
-
 /*
  * Accel functions called by the upper layers
  */
@@ -524,18 +500,18 @@ static void tridentfb_fillrect(struct fb
 		break;
 	}
 
-	acc->fill_rect(par, fr->dx, fr->dy, fr->width,
+	par->fill_rect(par, fr->dx, fr->dy, fr->width,
 		       fr->height, col, fr->rop);
-	acc->wait_engine(par);
+	par->wait_engine(par);
 }
 static void tridentfb_copyarea(struct fb_info *info,
 			       const struct fb_copyarea *ca)
 {
 	struct tridentfb_par *par = info->par;
 
-	acc->copy_rect(par, ca->sx, ca->sy, ca->dx, ca->dy,
+	par->copy_rect(par, ca->sx, ca->sy, ca->dx, ca->dy,
 		       ca->width, ca->height);
-	acc->wait_engine(par);
+	par->wait_engine(par);
 }
 #else /* !CONFIG_FB_TRIDENT_ACCEL */
 #define tridentfb_fillrect cfb_fillrect
@@ -1029,7 +1005,7 @@ static int tridentfb_set_par(struct fb_i
 	write3X4(par, GraphEngReg, 0x80);
 
 #ifdef CONFIG_FB_TRIDENT_ACCEL
-	acc->init_accel(par, info->var.xres, bpp);
+	par->init_accel(par, info->var.xres, bpp);
 #endif
 
 	switch (bpp) {
@@ -1290,11 +1266,20 @@ static int __devinit trident_pci_probe(s
 	chip3D = is3Dchip(chip_id);
 
 	if (is_xp(chip_id)) {
-		acc = &accel_xp;
+		default_par->init_accel = xp_init_accel;
+		default_par->wait_engine = xp_wait_engine;
+		default_par->fill_rect = xp_fill_rect;
+		default_par->copy_rect = xp_copy_rect;
 	} else if (is_blade(chip_id)) {
-		acc = &accel_blade;
+		default_par->init_accel = blade_init_accel;
+		default_par->wait_engine = blade_wait_engine;
+		default_par->fill_rect = blade_fill_rect;
+		default_par->copy_rect = blade_copy_rect;
 	} else {
-		acc = &accel_image;
+		default_par->init_accel = image_init_accel;
+		default_par->wait_engine = image_wait_engine;
+		default_par->fill_rect = image_fill_rect;
+		default_par->copy_rect = image_copy_rect;
 	}
 
 	default_par->chip_id = chip_id;
@@ -1365,7 +1350,7 @@ static int __devinit trident_pci_probe(s
 	if (err < 0)
 		goto out_unmap2;
 
-	if (defaultaccel && acc)
+	if (defaultaccel && default_par->init_accel)
 		info->var.accel_flags |= FB_ACCELF_TEXT;
 	else
 		info->var.accel_flags &= ~FB_ACCELF_TEXT;

----------------------------------------------------------------------
Andrzej Piaseczny w roli kucharza? Zobacz!
http://link.interia.pl/f1dcb


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone

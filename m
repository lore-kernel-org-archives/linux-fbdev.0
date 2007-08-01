From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] cg6: code cleanup
Date: Wed, 1 Aug 2007 22:44:05 +0200
Message-ID: <20070801224405.89f66fa4.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGLCS-0003Sx-UU for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 13:53:47 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IGKzV-0008Mr-C0
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 13:40:24 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 1 Aug 2007 22:40:16 +0200
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

This patch:
- corrects coding style errors pointed by Lindent and checkpatch
- replaces space chunks with tabs
- removes one redundant include
- improves indentations of defines
- removes from comments leftovers from skeletonfb 
- adds __devinit attribute to two init functions

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch applies cleanly against 2.6.23-rc1-git10.

--- linux-2.6.23smp/drivers/video/cg6.c	2007-07-31 12:18:05.000000000 +0200
+++ linux-2.6.23/drivers/video/cg6.c	2007-08-01 21:56:16.000000000 +0200
@@ -19,7 +19,6 @@
 #include <linux/mm.h>
 
 #include <asm/io.h>
-#include <asm/prom.h>
 #include <asm/of_device.h>
 #include <asm/fbio.h>
 
@@ -65,41 +64,41 @@ static struct fb_ops cg6_ops = {
  * The FBC could be the frame buffer control
  * The FHC could is the frame buffer hardware control.
  */
-#define CG6_ROM_OFFSET       0x0UL
-#define CG6_BROOKTREE_OFFSET 0x200000UL
-#define CG6_DHC_OFFSET       0x240000UL
-#define CG6_ALT_OFFSET       0x280000UL
-#define CG6_FHC_OFFSET       0x300000UL
-#define CG6_THC_OFFSET       0x301000UL
-#define CG6_FBC_OFFSET       0x700000UL
-#define CG6_TEC_OFFSET       0x701000UL
-#define CG6_RAM_OFFSET       0x800000UL
+#define CG6_ROM_OFFSET			0x0UL
+#define CG6_BROOKTREE_OFFSET		0x200000UL
+#define CG6_DHC_OFFSET			0x240000UL
+#define CG6_ALT_OFFSET			0x280000UL
+#define CG6_FHC_OFFSET			0x300000UL
+#define CG6_THC_OFFSET			0x301000UL
+#define CG6_FBC_OFFSET			0x700000UL
+#define CG6_TEC_OFFSET			0x701000UL
+#define CG6_RAM_OFFSET			0x800000UL
 
 /* FHC definitions */
-#define CG6_FHC_FBID_SHIFT           24
-#define CG6_FHC_FBID_MASK            255
-#define CG6_FHC_REV_SHIFT            20
-#define CG6_FHC_REV_MASK             15
-#define CG6_FHC_FROP_DISABLE         (1 << 19)
-#define CG6_FHC_ROW_DISABLE          (1 << 18)
-#define CG6_FHC_SRC_DISABLE          (1 << 17)
-#define CG6_FHC_DST_DISABLE          (1 << 16)
-#define CG6_FHC_RESET                (1 << 15)
-#define CG6_FHC_LITTLE_ENDIAN        (1 << 13)
-#define CG6_FHC_RES_MASK             (3 << 11)
-#define CG6_FHC_1024                 (0 << 11)
-#define CG6_FHC_1152                 (1 << 11)
-#define CG6_FHC_1280                 (2 << 11)
-#define CG6_FHC_1600                 (3 << 11)
-#define CG6_FHC_CPU_MASK             (3 << 9)
-#define CG6_FHC_CPU_SPARC            (0 << 9)
-#define CG6_FHC_CPU_68020            (1 << 9)
-#define CG6_FHC_CPU_386              (2 << 9)
-#define CG6_FHC_TEST		     (1 << 8)
-#define CG6_FHC_TEST_X_SHIFT	     4
-#define CG6_FHC_TEST_X_MASK	     15
-#define CG6_FHC_TEST_Y_SHIFT	     0
-#define CG6_FHC_TEST_Y_MASK	     15
+#define CG6_FHC_FBID_SHIFT		24
+#define CG6_FHC_FBID_MASK		255
+#define CG6_FHC_REV_SHIFT		20
+#define CG6_FHC_REV_MASK		15
+#define CG6_FHC_FROP_DISABLE		(1 << 19)
+#define CG6_FHC_ROW_DISABLE		(1 << 18)
+#define CG6_FHC_SRC_DISABLE		(1 << 17)
+#define CG6_FHC_DST_DISABLE		(1 << 16)
+#define CG6_FHC_RESET			(1 << 15)
+#define CG6_FHC_LITTLE_ENDIAN		(1 << 13)
+#define CG6_FHC_RES_MASK		(3 << 11)
+#define CG6_FHC_1024			(0 << 11)
+#define CG6_FHC_1152			(1 << 11)
+#define CG6_FHC_1280			(2 << 11)
+#define CG6_FHC_1600			(3 << 11)
+#define CG6_FHC_CPU_MASK		(3 << 9)
+#define CG6_FHC_CPU_SPARC		(0 << 9)
+#define CG6_FHC_CPU_68020		(1 << 9)
+#define CG6_FHC_CPU_386			(2 << 9)
+#define CG6_FHC_TEST			(1 << 8)
+#define CG6_FHC_TEST_X_SHIFT		4
+#define CG6_FHC_TEST_X_MASK		15
+#define CG6_FHC_TEST_Y_SHIFT		0
+#define CG6_FHC_TEST_Y_MASK		15
 
 /* FBC mode definitions */
 #define CG6_FBC_BLIT_IGNORE		0x00000000
@@ -150,17 +149,17 @@ static struct fb_ops cg6_ops = {
 #define CG6_FBC_INDEX_MASK		0x00000030
 
 /* THC definitions */
-#define CG6_THC_MISC_REV_SHIFT       16
-#define CG6_THC_MISC_REV_MASK        15
-#define CG6_THC_MISC_RESET           (1 << 12)
-#define CG6_THC_MISC_VIDEO           (1 << 10)
-#define CG6_THC_MISC_SYNC            (1 << 9)
-#define CG6_THC_MISC_VSYNC           (1 << 8)
-#define CG6_THC_MISC_SYNC_ENAB       (1 << 7)
-#define CG6_THC_MISC_CURS_RES        (1 << 6)
-#define CG6_THC_MISC_INT_ENAB        (1 << 5)
-#define CG6_THC_MISC_INT             (1 << 4)
-#define CG6_THC_MISC_INIT            0x9f
+#define CG6_THC_MISC_REV_SHIFT		16
+#define CG6_THC_MISC_REV_MASK		15
+#define CG6_THC_MISC_RESET		(1 << 12)
+#define CG6_THC_MISC_VIDEO		(1 << 10)
+#define CG6_THC_MISC_SYNC		(1 << 9)
+#define CG6_THC_MISC_VSYNC		(1 << 8)
+#define CG6_THC_MISC_SYNC_ENAB		(1 << 7)
+#define CG6_THC_MISC_CURS_RES		(1 << 6)
+#define CG6_THC_MISC_INT_ENAB		(1 << 5)
+#define CG6_THC_MISC_INT		(1 << 4)
+#define CG6_THC_MISC_INIT		0x9f
 
 /* The contents are unknown */
 struct cg6_tec {
@@ -170,25 +169,25 @@ struct cg6_tec {
 };
 
 struct cg6_thc {
-        u32 thc_pad0[512];
-	u32 thc_hs;		/* hsync timing */
-	u32 thc_hsdvs;
-	u32 thc_hd;
-	u32 thc_vs;		/* vsync timing */
-	u32 thc_vd;
-	u32 thc_refresh;
-	u32 thc_misc;
-	u32 thc_pad1[56];
-	u32 thc_cursxy;	/* cursor x,y position (16 bits each) */
-	u32 thc_cursmask[32];	/* cursor mask bits */
-	u32 thc_cursbits[32];	/* what to show where mask enabled */
+	u32	thc_pad0[512];
+	u32	thc_hs;		/* hsync timing */
+	u32	thc_hsdvs;
+	u32	thc_hd;
+	u32	thc_vs;		/* vsync timing */
+	u32	thc_vd;
+	u32	thc_refresh;
+	u32	thc_misc;
+	u32	thc_pad1[56];
+	u32	thc_cursxy;	/* cursor x,y position (16 bits each) */
+	u32	thc_cursmask[32];	/* cursor mask bits */
+	u32	thc_cursbits[32];	/* what to show where mask enabled */
 };
 
 struct cg6_fbc {
 	u32	xxx0[1];
 	u32	mode;
 	u32	clip;
-	u32	xxx1[1];	    
+	u32	xxx1[1];
 	u32	s;
 	u32	draw;
 	u32	blit;
@@ -243,10 +242,10 @@ struct cg6_fbc {
 };
 
 struct bt_regs {
-	u32 addr;
-	u32 color_map;
-	u32 control;
-	u32 cursor;
+	u32	addr;
+	u32	color_map;
+	u32	control;
+	u32	cursor;
 };
 
 struct cg6_par {
@@ -267,7 +266,7 @@ struct cg6_par {
 
 static int cg6_sync(struct fb_info *info)
 {
-	struct cg6_par *par = (struct cg6_par *) info->par;
+	struct cg6_par *par = (struct cg6_par *)info->par;
 	struct cg6_fbc __iomem *fbc = par->fbc;
 	int limit = 10000;
 
@@ -281,16 +280,14 @@ static int cg6_sync(struct fb_info *info
 }
 
 /**
- *      cg6_fillrect - REQUIRED function. Can use generic routines if 
- *                     non acclerated hardware and packed pixel based.
- *                     Draws a rectangle on the screen.               
+ *	cg6_fillrect -	Draws a rectangle on the screen.
  *
- *      @info: frame buffer structure that represents a single frame buffer
- *      @rect: structure defining the rectagle and operation.
+ *	@info: frame buffer structure that represents a single frame buffer
+ *	@rect: structure defining the rectagle and operation.
  */
 static void cg6_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
-	struct cg6_par *par = (struct cg6_par *) info->par;
+	struct cg6_par *par = (struct cg6_par *)info->par;
 	struct cg6_fbc __iomem *fbc = par->fbc;
 	unsigned long flags;
 	s32 val;
@@ -316,16 +313,14 @@ static void cg6_fillrect(struct fb_info 
 }
 
 /**
- *      cg6_imageblit - REQUIRED function. Can use generic routines if
- *                      non acclerated hardware and packed pixel based.
- *                      Copies a image from system memory to the screen. 
+ *	cg6_imageblit -	Copies a image from system memory to the screen.
  *
- *      @info: frame buffer structure that represents a single frame buffer
- *      @image: structure defining the image.
+ *	@info: frame buffer structure that represents a single frame buffer
+ *	@image: structure defining the image.
  */
 static void cg6_imageblit(struct fb_info *info, const struct fb_image *image)
 {
-	struct cg6_par *par = (struct cg6_par *) info->par;
+	struct cg6_par *par = (struct cg6_par *)info->par;
 	struct cg6_fbc __iomem *fbc = par->fbc;
 	const u8 *data = image->data;
 	unsigned long flags;
@@ -363,7 +358,7 @@ static void cg6_imageblit(struct fb_info
 			sbus_writel(y, &fbc->y0);
 			sbus_writel(x, &fbc->x0);
 			sbus_writel(x + 32 - 1, &fbc->x1);
-			
+
 			val = ((u32)data[0] << 24) |
 			      ((u32)data[1] << 16) |
 			      ((u32)data[2] <<  8) |
@@ -404,19 +399,20 @@ static void cg6_imageblit(struct fb_info
 }
 
 /**
- *      cg6_setcolreg - Optional function. Sets a color register.
- *      @regno: boolean, 0 copy local, 1 get_user() function
- *      @red: frame buffer colormap structure
- *      @green: The green value which can be up to 16 bits wide
- *      @blue:  The blue value which can be up to 16 bits wide.
- *      @transp: If supported the alpha value which can be up to 16 bits wide.
- *      @info: frame buffer info structure
+ *	cg6_setcolreg - Sets a color register.
+ *
+ *	@regno: boolean, 0 copy local, 1 get_user() function
+ *	@red: frame buffer colormap structure
+ *	@green: The green value which can be up to 16 bits wide
+ *	@blue:  The blue value which can be up to 16 bits wide.
+ *	@transp: If supported the alpha value which can be up to 16 bits wide.
+ *	@info: frame buffer info structure
  */
 static int cg6_setcolreg(unsigned regno,
 			 unsigned red, unsigned green, unsigned blue,
 			 unsigned transp, struct fb_info *info)
 {
-	struct cg6_par *par = (struct cg6_par *) info->par;
+	struct cg6_par *par = (struct cg6_par *)info->par;
 	struct bt_regs __iomem *bt = par->bt;
 	unsigned long flags;
 
@@ -440,25 +436,24 @@ static int cg6_setcolreg(unsigned regno,
 }
 
 /**
- *      cg6_blank - Optional function.  Blanks the display.
- *      @blank_mode: the blank mode we want.
- *      @info: frame buffer structure that represents a single frame buffer
+ *	cg6_blank - Blanks the display.
+ *
+ *	@blank_mode: the blank mode we want.
+ *	@info: frame buffer structure that represents a single frame buffer
  */
-static int
-cg6_blank(int blank, struct fb_info *info)
+static int cg6_blank(int blank, struct fb_info *info)
 {
-	struct cg6_par *par = (struct cg6_par *) info->par;
+	struct cg6_par *par = (struct cg6_par *)info->par;
 	struct cg6_thc __iomem *thc = par->thc;
 	unsigned long flags;
 	u32 val;
 
 	spin_lock_irqsave(&par->lock, flags);
+	val = sbus_readl(&thc->thc_misc);
 
 	switch (blank) {
 	case FB_BLANK_UNBLANK: /* Unblanking */
-		val = sbus_readl(&thc->thc_misc);
 		val |= CG6_THC_MISC_VIDEO;
-		sbus_writel(val, &thc->thc_misc);
 		par->flags &= ~CG6_FLAG_BLANKED;
 		break;
 
@@ -466,13 +461,12 @@ cg6_blank(int blank, struct fb_info *inf
 	case FB_BLANK_VSYNC_SUSPEND: /* VESA blank (vsync off) */
 	case FB_BLANK_HSYNC_SUSPEND: /* VESA blank (hsync off) */
 	case FB_BLANK_POWERDOWN: /* Poweroff */
-		val = sbus_readl(&thc->thc_misc);
 		val &= ~CG6_THC_MISC_VIDEO;
-		sbus_writel(val, &thc->thc_misc);
 		par->flags |= CG6_FLAG_BLANKED;
 		break;
 	}
 
+	sbus_writel(val, &thc->thc_misc);
 	spin_unlock_irqrestore(&par->lock, flags);
 
 	return 0;
@@ -533,7 +527,7 @@ static int cg6_mmap(struct fb_info *info
 
 static int cg6_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
-	struct cg6_par *par = (struct cg6_par *) info->par;
+	struct cg6_par *par = (struct cg6_par *)info->par;
 
 	return sbusfb_ioctl_helper(cmd, arg, info,
 				   FBTYPE_SUNFAST_COLOR, 8, par->fbsize);
@@ -543,15 +537,14 @@ static int cg6_ioctl(struct fb_info *inf
  *  Initialisation
  */
 
-static void
-cg6_init_fix(struct fb_info *info, int linebytes)
+static void __devinit cg6_init_fix(struct fb_info *info, int linebytes)
 {
 	struct cg6_par *par = (struct cg6_par *)info->par;
 	const char *cg6_cpu_name, *cg6_card_name;
 	u32 conf;
 
 	conf = sbus_readl(par->fhc);
-	switch(conf & CG6_FHC_CPU_MASK) {
+	switch (conf & CG6_FHC_CPU_MASK) {
 	case CG6_FHC_CPU_SPARC:
 		cg6_cpu_name = "sparc";
 		break;
@@ -563,21 +556,19 @@ cg6_init_fix(struct fb_info *info, int l
 		break;
 	};
 	if (((conf >> CG6_FHC_REV_SHIFT) & CG6_FHC_REV_MASK) >= 11) {
-		if (par->fbsize <= 0x100000) {
+		if (par->fbsize <= 0x100000)
 			cg6_card_name = "TGX";
-		} else {
+		else
 			cg6_card_name = "TGX+";
-		}
 	} else {
-		if (par->fbsize <= 0x100000) {
+		if (par->fbsize <= 0x100000)
 			cg6_card_name = "GX";
-		} else {
+		else
 			cg6_card_name = "GX+";
-		}
 	}
 
 	sprintf(info->fix.id, "%s %s", cg6_card_name, cg6_cpu_name);
-	info->fix.id[sizeof(info->fix.id)-1] = 0;
+	info->fix.id[sizeof(info->fix.id) - 1] = 0;
 
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
@@ -588,28 +579,28 @@ cg6_init_fix(struct fb_info *info, int l
 }
 
 /* Initialize Brooktree DAC */
-static void cg6_bt_init(struct cg6_par *par)
+static void __devinit cg6_bt_init(struct cg6_par *par)
 {
 	struct bt_regs __iomem *bt = par->bt;
 
-	sbus_writel(0x04 << 24, &bt->addr);         /* color planes */
+	sbus_writel(0x04 << 24, &bt->addr);	 /* color planes */
 	sbus_writel(0xff << 24, &bt->control);
 	sbus_writel(0x05 << 24, &bt->addr);
 	sbus_writel(0x00 << 24, &bt->control);
-	sbus_writel(0x06 << 24, &bt->addr);         /* overlay plane */
+	sbus_writel(0x06 << 24, &bt->addr);	 /* overlay plane */
 	sbus_writel(0x73 << 24, &bt->control);
 	sbus_writel(0x07 << 24, &bt->addr);
 	sbus_writel(0x00 << 24, &bt->control);
 }
 
-static void cg6_chip_init(struct fb_info *info)
+static void __devinit cg6_chip_init(struct fb_info *info)
 {
-	struct cg6_par *par = (struct cg6_par *) info->par;
+	struct cg6_par *par = (struct cg6_par *)info->par;
 	struct cg6_tec __iomem *tec = par->tec;
 	struct cg6_fbc __iomem *fbc = par->fbc;
 	u32 rev, conf, mode;
 	int i;
-	
+
 	/* Turn off stuff in the Transform Engine. */
 	sbus_writel(0, &tec->tec_matrix);
 	sbus_writel(0, &tec->tec_clip);
@@ -635,13 +626,13 @@ static void cg6_chip_init(struct fb_info
 		i = sbus_readl(&fbc->s);
 	} while (i & 0x10000000);
 	mode &= ~(CG6_FBC_BLIT_MASK | CG6_FBC_MODE_MASK |
-		       CG6_FBC_DRAW_MASK | CG6_FBC_BWRITE0_MASK |
-		       CG6_FBC_BWRITE1_MASK | CG6_FBC_BREAD_MASK |
-		       CG6_FBC_BDISP_MASK);
+		  CG6_FBC_DRAW_MASK | CG6_FBC_BWRITE0_MASK |
+		  CG6_FBC_BWRITE1_MASK | CG6_FBC_BREAD_MASK |
+		  CG6_FBC_BDISP_MASK);
 	mode |= (CG6_FBC_BLIT_SRC | CG6_FBC_MODE_COLOR8 |
-		      CG6_FBC_DRAW_RENDER | CG6_FBC_BWRITE0_ENABLE |
-		      CG6_FBC_BWRITE1_DISABLE | CG6_FBC_BREAD_0 |
-		      CG6_FBC_BDISP_0);
+		 CG6_FBC_DRAW_RENDER | CG6_FBC_BWRITE0_ENABLE |
+		 CG6_FBC_BWRITE1_DISABLE | CG6_FBC_BREAD_0 |
+		 CG6_FBC_BDISP_0);
 	sbus_writel(mode, &fbc->mode);
 
 	sbus_writel(0, &fbc->clip);
@@ -671,7 +662,8 @@ static void cg6_unmap_regs(struct of_dev
 		of_iounmap(&op->resource[0], info->screen_base, par->fbsize);
 }
 
-static int __devinit cg6_probe(struct of_device *op, const struct of_device_id *match)
+static int __devinit cg6_probe(struct of_device *op,
+				const struct of_device_id *match)
 {
 	struct device_node *dp = op->node;
 	struct fb_info *info;
@@ -702,22 +694,22 @@ static int __devinit cg6_probe(struct of
 		par->fbsize *= 4;
 
 	par->fbc = of_ioremap(&op->resource[0], CG6_FBC_OFFSET,
-				  4096, "cgsix fbc");
+				4096, "cgsix fbc");
 	par->tec = of_ioremap(&op->resource[0], CG6_TEC_OFFSET,
-				  sizeof(struct cg6_tec), "cgsix tec");
+				sizeof(struct cg6_tec), "cgsix tec");
 	par->thc = of_ioremap(&op->resource[0], CG6_THC_OFFSET,
-				  sizeof(struct cg6_thc), "cgsix thc");
+				sizeof(struct cg6_thc), "cgsix thc");
 	par->bt = of_ioremap(&op->resource[0], CG6_BROOKTREE_OFFSET,
-				 sizeof(struct bt_regs), "cgsix dac");
+				sizeof(struct bt_regs), "cgsix dac");
 	par->fhc = of_ioremap(&op->resource[0], CG6_FHC_OFFSET,
-				  sizeof(u32), "cgsix fhc");
+				sizeof(u32), "cgsix fhc");
 
 	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_IMAGEBLIT |
-                          FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT;
+			FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT;
 	info->fbops = &cg6_ops;
 
-	info->screen_base =  of_ioremap(&op->resource[0], CG6_RAM_OFFSET,
-					    par->fbsize, "cgsix ram");
+	info->screen_base = of_ioremap(&op->resource[0], CG6_RAM_OFFSET,
+					par->fbsize, "cgsix ram");
 	if (!par->fbc || !par->tec || !par->thc ||
 	    !par->bt || !par->fhc || !info->screen_base)
 		goto out_unmap_regs;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/

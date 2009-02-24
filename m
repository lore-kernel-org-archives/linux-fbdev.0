From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 2/4] cirrusfb: acceleration improvements
Date: Tue, 24 Feb 2009 22:29:28 +0100
Message-ID: <20090224222928.ef9592d8.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1Lc4lN-0003vR-Oe
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Feb 2009 21:24:25 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lc4lI-0006Lz-Kk for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Feb 2009 21:24:25 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

1. Fix color expansion for 16bpp
and 32bpp modes in the cirrusfb_RectFill().

2. Make a function with a common blitter
code (cirrusfb_set_blitter).

3. Add fb_sync function to allow a higher
layer synchronize with the blitter.

4. Kill one redundant blitter reset.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |  186 +++++++++++++++++++---------------------------
 1 files changed, 75 insertions(+), 111 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index d2b72c2..1c1e35c 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -381,7 +381,7 @@ static void cirrusfb_BitBLT(u8 __iomem *regbase, int bits_per_pixel,
 static void cirrusfb_RectFill(u8 __iomem *regbase, int bits_per_pixel,
 			      u_short x, u_short y,
 			      u_short width, u_short height,
-			      u_char color, u_short line_length);
+			      u32 color, u_short line_length);
 
 static void bestclock(long freq, int *nom, int *den, int *div);
 
@@ -1550,9 +1550,6 @@ static void init_vgachip(struct fb_info *info)
 		/* unlock all extension registers */
 		vga_wseq(cinfo->regbase, CL_SEQR6, 0x12);
 
-		/* reset blitter */
-		vga_wgfx(cinfo->regbase, CL_GR31, 0x04);
-
 		switch (cinfo->btype) {
 		case BT_GD5480:
 			vga_wseq(cinfo->regbase, CL_SEQRF, 0x98);
@@ -1747,6 +1744,17 @@ static void switch_monitor(struct cirrusfb_info *cinfo, int on)
 /* Linux 2.6-style  accelerated functions */
 /******************************************/
 
+static int cirrusfb_sync(struct fb_info *info)
+{
+	struct cirrusfb_info *cinfo = info->par;
+
+	if (!is_laguna(cinfo)) {
+		while (vga_rgfx(cinfo->regbase, CL_GR31) & 0x03)
+			cpu_relax();
+	}
+	return 0;
+}
+
 static void cirrusfb_fillrect(struct fb_info *info,
 			      const struct fb_fillrect *region)
 {
@@ -1966,6 +1974,7 @@ static struct fb_ops cirrusfb_ops = {
 	.fb_blank	= cirrusfb_blank,
 	.fb_fillrect	= cirrusfb_fillrect,
 	.fb_copyarea	= cirrusfb_copyarea,
+	.fb_sync	= cirrusfb_sync,
 	.fb_imageblit	= cirrusfb_imageblit,
 };
 
@@ -2586,7 +2595,6 @@ static void RClut(struct cirrusfb_info *cinfo, unsigned char regnum, unsigned ch
 /* FIXME: use interrupts instead */
 static void cirrusfb_WaitBLT(u8 __iomem *regbase)
 {
-	/* now busy-wait until we're done */
 	while (vga_rgfx(regbase, CL_GR31) & 0x08)
 		cpu_relax();
 }
@@ -2597,58 +2605,12 @@ static void cirrusfb_WaitBLT(u8 __iomem *regbase)
 	perform accelerated "scrolling"
 ********************************************************************/
 
-static void cirrusfb_BitBLT(u8 __iomem *regbase, int bits_per_pixel,
-			    u_short curx, u_short cury,
-			    u_short destx, u_short desty,
-			    u_short width, u_short height,
-			    u_short line_length)
-{
-	u_short nwidth, nheight;
-	u_long nsrc, ndest;
-	u_char bltmode;
-
-	nwidth = width - 1;
-	nheight = height - 1;
-
-	bltmode = 0x00;
-	/* if source adr < dest addr, do the Blt backwards */
-	if (cury <= desty) {
-		if (cury == desty) {
-			/* if src and dest are on the same line, check x */
-			if (curx < destx)
-				bltmode |= 0x01;
-		} else
-			bltmode |= 0x01;
-	}
-	if (!bltmode) {
-		/* standard case: forward blitting */
-		nsrc = (cury * line_length) + curx;
-		ndest = (desty * line_length) + destx;
-	} else {
-		/* this means start addresses are at the end,
-		 * counting backwards
-		 */
-		nsrc = cury * line_length + curx +
-			nheight * line_length + nwidth;
-		ndest = desty * line_length + destx +
-			nheight * line_length + nwidth;
-	}
-
-	/*
-	   run-down of registers to be programmed:
-	   destination pitch
-	   source pitch
-	   BLT width/height
-	   source start
-	   destination start
-	   BLT mode
-	   BLT ROP
-	   VGA_GFX_SR_VALUE / VGA_GFX_SR_ENABLE: "fill color"
-	   start/stop
-	 */
-
-	cirrusfb_WaitBLT(regbase);
+static void cirrusfb_set_blitter(u8 __iomem *regbase,
+			    u_short nwidth, u_short nheight,
+			    u_long nsrc, u_long ndest,
+			    u_short bltmode, u_short line_length)
 
+{
 	/* pitch: set to line_length */
 	/* dest pitch low */
 	vga_wgfx(regbase, CL_GR24, line_length & 0xff);
@@ -2694,56 +2656,67 @@ static void cirrusfb_BitBLT(u8 __iomem *regbase, int bits_per_pixel,
 	vga_wgfx(regbase, CL_GR32, 0x0d);	/* BLT ROP */
 
 	/* and finally: GO! */
-	vga_wgfx(regbase, CL_GR31, 0x02);	/* BLT Start/status */
+	vga_wgfx(regbase, CL_GR31, 0x82);	/* BLT Start/status */
 }
 
 /*******************************************************************
-	cirrusfb_RectFill()
+	cirrusfb_BitBLT()
 
-	perform accelerated rectangle fill
+	perform accelerated "scrolling"
 ********************************************************************/
 
-static void cirrusfb_RectFill(u8 __iomem *regbase, int bits_per_pixel,
-		     u_short x, u_short y, u_short width, u_short height,
-		     u_char color, u_short line_length)
+static void cirrusfb_BitBLT(u8 __iomem *regbase, int bits_per_pixel,
+			    u_short curx, u_short cury,
+			    u_short destx, u_short desty,
+			    u_short width, u_short height,
+			    u_short line_length)
 {
-	u_short nwidth, nheight;
-	u_long ndest;
-	u_char op;
-
-	nwidth = width - 1;
-	nheight = height - 1;
+	u_short nwidth = width - 1;
+	u_short nheight = height - 1;
+	u_long nsrc, ndest;
+	u_char bltmode;
 
-	ndest = (y * line_length) + x;
+	bltmode = 0x00;
+	/* if source adr < dest addr, do the Blt backwards */
+	if (cury <= desty) {
+		if (cury == desty) {
+			/* if src and dest are on the same line, check x */
+			if (curx < destx)
+				bltmode |= 0x01;
+		} else
+			bltmode |= 0x01;
+	}
+	/* standard case: forward blitting */
+	nsrc = (cury * line_length) + curx;
+	ndest = (desty * line_length) + destx;
+	if (bltmode) {
+		/* this means start addresses are at the end,
+		 * counting backwards
+		 */
+		nsrc += nheight * line_length + nwidth;
+		ndest += nheight * line_length + nwidth;
+	}
 
 	cirrusfb_WaitBLT(regbase);
 
-	/* pitch: set to line_length */
-	vga_wgfx(regbase, CL_GR24, line_length & 0xff);	/* dest pitch low */
-	vga_wgfx(regbase, CL_GR25, line_length >> 8);	/* dest pitch hi */
-	vga_wgfx(regbase, CL_GR26, line_length & 0xff);	/* source pitch low */
-	vga_wgfx(regbase, CL_GR27, line_length >> 8);	/* source pitch hi */
+	cirrusfb_set_blitter(regbase, nwidth, nheight,
+			    nsrc, ndest, bltmode, line_length);
+}
 
-	/* BLT width: actual number of pixels - 1 */
-	vga_wgfx(regbase, CL_GR20, nwidth & 0xff);	/* BLT width low */
-	vga_wgfx(regbase, CL_GR21, nwidth >> 8);	/* BLT width hi */
+/*******************************************************************
+	cirrusfb_RectFill()
 
-	/* BLT height: actual number of lines -1 */
-	vga_wgfx(regbase, CL_GR22, nheight & 0xff);	/* BLT height low */
-	vga_wgfx(regbase, CL_GR23, nheight >> 8);	/* BLT width hi */
+	perform accelerated rectangle fill
+********************************************************************/
 
-	/* BLT destination */
-	/* BLT dest low */
-	vga_wgfx(regbase, CL_GR28, (u_char) (ndest & 0xff));
-	/* BLT dest mid */
-	vga_wgfx(regbase, CL_GR29, (u_char) (ndest >> 8));
-	/* BLT dest hi */
-	vga_wgfx(regbase, CL_GR2A, (u_char) (ndest >> 16));
+static void cirrusfb_RectFill(u8 __iomem *regbase, int bits_per_pixel,
+		     u_short x, u_short y, u_short width, u_short height,
+		     u32 color, u_short line_length)
+{
+	u_long ndest = (y * line_length) + x;
+	u_char op;
 
-	/* BLT source: set to 0 (is a dummy here anyway) */
-	vga_wgfx(regbase, CL_GR2C, 0x00);	/* BLT src low */
-	vga_wgfx(regbase, CL_GR2D, 0x00);	/* BLT src mid */
-	vga_wgfx(regbase, CL_GR2E, 0x00);	/* BLT src hi */
+	cirrusfb_WaitBLT(regbase);
 
 	/* This is a ColorExpand Blt, using the */
 	/* same color for foreground and background */
@@ -2751,29 +2724,20 @@ static void cirrusfb_RectFill(u8 __iomem *regbase, int bits_per_pixel,
 	vga_wgfx(regbase, VGA_GFX_SR_ENABLE, color);	/* background color */
 
 	op = 0xc0;
-	if (bits_per_pixel == 16) {
-		vga_wgfx(regbase, CL_GR10, color);	/* foreground color */
-		vga_wgfx(regbase, CL_GR11, color);	/* background color */
-		op = 0x50;
+	if (bits_per_pixel >= 16) {
+		vga_wgfx(regbase, CL_GR10, color >> 8);	/* foreground color */
+		vga_wgfx(regbase, CL_GR11, color >> 8);	/* background color */
 		op = 0xd0;
-	} else if (bits_per_pixel == 32) {
-		vga_wgfx(regbase, CL_GR10, color);	/* foreground color */
-		vga_wgfx(regbase, CL_GR11, color);	/* background color */
-		vga_wgfx(regbase, CL_GR12, color);	/* foreground color */
-		vga_wgfx(regbase, CL_GR13, color);	/* background color */
-		vga_wgfx(regbase, CL_GR14, 0);	/* foreground color */
-		vga_wgfx(regbase, CL_GR15, 0);	/* background color */
-		op = 0x50;
+	}
+	if (bits_per_pixel == 32) {
+		vga_wgfx(regbase, CL_GR12, color >> 16);/* foreground color */
+		vga_wgfx(regbase, CL_GR13, color >> 16);/* background color */
+		vga_wgfx(regbase, CL_GR14, color >> 24);/* foreground color */
+		vga_wgfx(regbase, CL_GR15, color >> 24);/* background color */
 		op = 0xf0;
 	}
-	/* BLT mode: color expand, Enable 8x8 copy (faster?) */
-	vga_wgfx(regbase, CL_GR30, op);	/* BLT mode */
-
-	/* BLT ROP: SrcCopy */
-	vga_wgfx(regbase, CL_GR32, 0x0d);	/* BLT ROP */
-
-	/* and finally: GO! */
-	vga_wgfx(regbase, CL_GR31, 0x02);	/* BLT Start/status */
+	cirrusfb_set_blitter(regbase, width - 1, height - 1,
+			    0, ndest, op, line_length);
 }
 
 /**************************************************************************
-- 
1.5.2.2


----------------------------------------------------------------------
SPEAK UP uczysz sie przez 3 miesiace za darmo. 
Sukces gwarantujemy na pismie! http://link.interia.pl/f206b


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H

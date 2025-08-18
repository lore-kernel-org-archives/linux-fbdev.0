Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857E147C9B
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Aug 2025 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550740; cv=none; b=usuVtECCKz4wQQ1Htc4kSqzxSR8qERGXd6aDgX8Q9RcsmwPw0vi0/PHUeD38iBvbgzB3qU+aVWtrMGHN71s4bSHW0j4VH0NeQrT0JSiTE6EikmyCXi0eLC7adtHcGb3eEBncw/p+qyW0WoU8ANQN61G40gSmUwWPtVGxZaCW33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550740; c=relaxed/simple;
	bh=KaLMgBHDHRU2t9gqT26NK4Ea0z2WBu/lMZPBk30Bxq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CHptEqItGyBNrCqqDJz/MXWP8+raGWpSmyUvLkT3EJeSfklLmur0UgtiGXDjEn8fLefxbE766WCzd9EeC1GJ0k82ynv9kYZe6FDcn0SqNxgfOxiw1AF//Dg+W4c7WUWLW+PsM0XMukiWa0IPdHX3jEtHeE73yjSQL6TbWrLDWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 55B591011E; Mon, 18 Aug 2025 22:49:14 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH] fbdev: s3fb: Implement 1 and 2 BPP modes, improve 4 BPP
Date: Mon, 18 Aug 2025 22:44:26 +0200
Message-Id: <20250818204426.32115-1-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the right setup S3 cards can display 1 and 2 BPP packed pixel
modes, even in high resolutions. So this patch makes them available.

The 4 BPP packed pixel mode had one pixel column of garbage on the
left side due to how the shift register works, this is fixed now.

There was a limitation that only 8 pixel wide fonts could be used at 4
BPP. Since the CFB routines were updated to handle reverse pixel
ordering correctly that limitation doesn't exists and was removed now.

In 4 BPP interleaved planes mode font widths of multiply of 8 are
accepted now, not just 8 pixels.

The horizontal screen position will not move as much between modes as it
used to. That was caused by the various amount of pipeline delay which
is compensated now as much as possible.

While adjusting the code direct port access of PEL registers was
corrected. Should work now on systems where these are memory mapped.

I've noticed that when in 1 BPP mode the console is used with Unicode
fonts erasing might be done with non-blanks. That's a bug in the VT code
and so not part of this patch.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/Kconfig |   1 +
 drivers/video/fbdev/s3fb.c  | 140 ++++++++++++++++++++++++++----------
 2 files changed, 105 insertions(+), 36 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index c21484d15..1500dca8c 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1060,6 +1060,7 @@ config FB_S3
 	select FB_TILEBLITTING
 	select FB_SVGALIB
 	select VGASTATE
+	select FB_CFB_REV_PIXELS_IN_BYTE
 	select FONT_8x16 if FRAMEBUFFER_CONSOLE
 	help
 	  Driver for graphics boards with S3 Trio / S3 Virge chip.
diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index ff84106ec..f618ff99e 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -50,10 +50,14 @@ struct s3fb_info {
 static const struct svga_fb_format s3fb_formats[] = {
 	{ 0,  {0, 6, 0},  {0, 6, 0},  {0, 6, 0}, {0, 0, 0}, 0,
 		FB_TYPE_TEXT, FB_AUX_TEXT_SVGA_STEP4,	FB_VISUAL_PSEUDOCOLOR, 8, 16},
-	{ 4,  {0, 4, 0},  {0, 4, 0},  {0, 4, 0}, {0, 0, 0}, 0,
-		FB_TYPE_PACKED_PIXELS, 0,		FB_VISUAL_PSEUDOCOLOR, 8, 16},
+	{ 1,  {0, 1, 0},  {0, 1, 0},  {0, 1, 0}, {0, 0, 0}, 2,
+		FB_TYPE_PACKED_PIXELS, 0,		FB_VISUAL_PSEUDOCOLOR, 32, 64},
+	{ 2,  {0, 2, 0},  {0, 2, 0},  {0, 2, 0}, {0, 0, 0}, 2,
+		FB_TYPE_PACKED_PIXELS, 0,		FB_VISUAL_PSEUDOCOLOR, 16, 32},
 	{ 4,  {0, 4, 0},  {0, 4, 0},  {0, 4, 0}, {0, 0, 0}, 1,
 		FB_TYPE_INTERLEAVED_PLANES, 1,		FB_VISUAL_PSEUDOCOLOR, 8, 16},
+	{ 4,  {0, 4, 0},  {0, 4, 0},  {0, 4, 0}, {0, 0, 0}, 2,
+		FB_TYPE_PACKED_PIXELS, 0,		FB_VISUAL_PSEUDOCOLOR, 8, 16},
 	{ 8,  {0, 8, 0},  {0, 8, 0},  {0, 8, 0}, {0, 0, 0}, 0,
 		FB_TYPE_PACKED_PIXELS, 0,		FB_VISUAL_PSEUDOCOLOR, 4, 8},
 	{16,  {10, 5, 0}, {5, 5, 0},  {0, 5, 0}, {0, 0, 0}, 0,
@@ -557,7 +561,7 @@ static int s3fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	/* 32bpp mode is not supported on VIRGE VX,
 	   24bpp is not supported on others */
-	if ((par->chip == CHIP_988_VIRGE_VX) ? (rv == 7) : (rv == 6))
+	if ((par->chip == CHIP_988_VIRGE_VX) ? (rv == 9) : (rv == 8))
 		rv = -EINVAL;
 
 	if (rv < 0) {
@@ -607,7 +611,7 @@ static int s3fb_set_par(struct fb_info *info)
 	struct s3fb_info *par = info->par;
 	u32 value, mode, hmul, offset_value, screen_size, multiplex, dbytes;
 	u32 bpp = info->var.bits_per_pixel;
-	u32 htotal, hsstart;
+	u32 htotal, hsstart, pel_msk;
 
 	if (bpp != 0) {
 		info->fix.ypanstep = 1;
@@ -617,9 +621,11 @@ static int s3fb_set_par(struct fb_info *info)
 		info->tileops = NULL;
 
 		/* in 4bpp supports 8p wide tiles only, any tiles otherwise */
-		if (bpp == 4) {
+		if (bpp == 4 && (info->var.nonstd & 1) != 0) {
+			int i;
 			bitmap_zero(info->pixmap.blit_x, FB_MAX_BLIT_WIDTH);
-			set_bit(8 - 1, info->pixmap.blit_x);
+			for (i = 8; i <= FB_MAX_BLIT_WIDTH; i += 8)
+				set_bit(i - 1, info->pixmap.blit_x);
 		} else {
 			bitmap_fill(info->pixmap.blit_x, FB_MAX_BLIT_WIDTH);
 		}
@@ -730,7 +736,7 @@ static int s3fb_set_par(struct fb_info *info)
 		vga_wcrt(par->state.vgabase, 0x50, 0x00);
 		vga_wcrt(par->state.vgabase, 0x67, 0x50);
 		msleep(10); /* screen remains blank sometimes without this */
-		vga_wcrt(par->state.vgabase, 0x63, (mode <= 2) ? 0x90 : 0x09);
+		vga_wcrt(par->state.vgabase, 0x63, (mode <= 4) ? 0x90 : 0x09);
 		vga_wcrt(par->state.vgabase, 0x66, 0x90);
 	}
 
@@ -763,12 +769,17 @@ static int s3fb_set_par(struct fb_info *info)
 	svga_wcrt_mask(par->state.vgabase, 0x31, 0x00, 0x40);
 	multiplex = 0;
 	hmul = 1;
+	pel_msk = 0xff;
+
+	svga_wcrt_mask(par->state.vgabase, 0x08, 0x00, 0x60);
+	svga_wcrt_mask(par->state.vgabase, 0x05, 0x00, 0x60);
 
 	/* Set mode-specific register values */
 	switch (mode) {
 	case 0:
 		fb_dbg(info, "text mode\n");
 		svga_set_textmode_vga_regs(par->state.vgabase);
+		pel_msk = 0x0f;
 
 		/* Set additional registers like in 8-bit mode */
 		svga_wcrt_mask(par->state.vgabase, 0x50, 0x00, 0x30);
@@ -783,8 +794,11 @@ static int s3fb_set_par(struct fb_info *info)
 		}
 		break;
 	case 1:
-		fb_dbg(info, "4 bit pseudocolor\n");
-		vga_wgfx(par->state.vgabase, VGA_GFX_MODE, 0x40);
+		fb_dbg(info, "1 bit pseudocolor\n");
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x10, 0x14);
+		svga_wcrt_mask(par->state.vgabase, 0x08, 0x60, 0x60);
+		svga_wcrt_mask(par->state.vgabase, 0x05, 0x40, 0x60);
+		pel_msk = 0x01;
 
 		/* Set additional registers like in 8-bit mode */
 		svga_wcrt_mask(par->state.vgabase, 0x50, 0x00, 0x30);
@@ -794,7 +808,13 @@ static int s3fb_set_par(struct fb_info *info)
 		svga_wcrt_mask(par->state.vgabase, 0x3A, 0x00, 0x30);
 		break;
 	case 2:
-		fb_dbg(info, "4 bit pseudocolor, planar\n");
+		fb_dbg(info, "2 bit pseudocolor\n");
+		svga_wseq_mask(par->state.vgabase, 0x01, 0x04, 0x14);
+		svga_wseq_mask(par->state.vgabase, 0x04, 0x08, 0x08);
+		vga_wgfx(par->state.vgabase, VGA_GFX_MODE, 0x20);
+		svga_wcrt_mask(par->state.vgabase, 0x08, 0x20, 0x60);
+		svga_wcrt_mask(par->state.vgabase, 0x05, 0x40, 0x60);
+		pel_msk = 0x03;
 
 		/* Set additional registers like in 8-bit mode */
 		svga_wcrt_mask(par->state.vgabase, 0x50, 0x00, 0x30);
@@ -804,8 +824,35 @@ static int s3fb_set_par(struct fb_info *info)
 		svga_wcrt_mask(par->state.vgabase, 0x3A, 0x00, 0x30);
 		break;
 	case 3:
+		fb_dbg(info, "4 bit pseudocolor, planar\n");
+		pel_msk = 0x0f;
+
+		/* Set additional registers like in 8-bit mode */
+		svga_wcrt_mask(par->state.vgabase, 0x50, 0x00, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x67, 0x00, 0xF0);
+		svga_wcrt_mask(par->state.vgabase, 0x05, 0x40, 0x60);
+
+		/* disable enhanced mode */
+		svga_wcrt_mask(par->state.vgabase, 0x3A, 0x00, 0x30);
+		break;
+	case 4:
+		fb_dbg(info, "4 bit pseudocolor\n");
+		vga_wgfx(par->state.vgabase, VGA_GFX_MODE, 0x40);
+		svga_wattr(par->state.vgabase, 0x33, 0x01);
+		svga_wcrt_mask(par->state.vgabase, 0x05, 0x40, 0x60);
+		pel_msk = 0xf0;
+
+		/* Set additional registers like in 8-bit mode */
+		svga_wcrt_mask(par->state.vgabase, 0x50, 0x00, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x67, 0x00, 0xF0);
+
+		/* disable enhanced mode */
+		svga_wcrt_mask(par->state.vgabase, 0x3A, 0x00, 0x30);
+		break;
+	case 5:
 		fb_dbg(info, "8 bit pseudocolor\n");
 		svga_wcrt_mask(par->state.vgabase, 0x50, 0x00, 0x30);
+		svga_wcrt_mask(par->state.vgabase, 0x05, 0x20, 0x60);
 		if (info->var.pixclock > 20000 ||
 		    par->chip == CHIP_357_VIRGE_GX2 ||
 		    par->chip == CHIP_359_VIRGE_GX2P ||
@@ -819,7 +866,7 @@ static int s3fb_set_par(struct fb_info *info)
 			multiplex = 1;
 		}
 		break;
-	case 4:
+	case 6:
 		fb_dbg(info, "5/5/5 truecolor\n");
 		if (par->chip == CHIP_988_VIRGE_VX) {
 			if (info->var.pixclock > 20000)
@@ -847,7 +894,7 @@ static int s3fb_set_par(struct fb_info *info)
 				hmul = 2;
 		}
 		break;
-	case 5:
+	case 7:
 		fb_dbg(info, "5/6/5 truecolor\n");
 		if (par->chip == CHIP_988_VIRGE_VX) {
 			if (info->var.pixclock > 20000)
@@ -875,12 +922,12 @@ static int s3fb_set_par(struct fb_info *info)
 				hmul = 2;
 		}
 		break;
-	case 6:
+	case 8:
 		/* VIRGE VX case */
 		fb_dbg(info, "8/8/8 truecolor\n");
 		svga_wcrt_mask(par->state.vgabase, 0x67, 0xD0, 0xF0);
 		break;
-	case 7:
+	case 9:
 		fb_dbg(info, "8/8/8/8 truecolor\n");
 		svga_wcrt_mask(par->state.vgabase, 0x50, 0x30, 0x30);
 		svga_wcrt_mask(par->state.vgabase, 0x67, 0xD0, 0xF0);
@@ -889,6 +936,7 @@ static int s3fb_set_par(struct fb_info *info)
 		fb_err(info, "unsupported mode - bug\n");
 		return -EINVAL;
 	}
+	vga_w(par->state.vgabase, VGA_PEL_MSK, pel_msk);
 
 	if (par->chip != CHIP_988_VIRGE_VX) {
 		svga_wseq_mask(par->state.vgabase, 0x15, multiplex ? 0x10 : 0x00, 0x10);
@@ -927,33 +975,26 @@ static int s3fb_set_par(struct fb_info *info)
 static int s3fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 				u_int transp, struct fb_info *fb)
 {
+	struct s3fb_info *par = fb->par;
+	int cols;
+
 	switch (fb->var.bits_per_pixel) {
 	case 0:
+	case 1:
+	case 2:
 	case 4:
-		if (regno >= 16)
-			return -EINVAL;
-
-		if ((fb->var.bits_per_pixel == 4) &&
-		    (fb->var.nonstd == 0)) {
-			outb(0xF0, VGA_PEL_MSK);
-			outb(regno*16, VGA_PEL_IW);
-		} else {
-			outb(0x0F, VGA_PEL_MSK);
-			outb(regno, VGA_PEL_IW);
-		}
-		outb(red >> 10, VGA_PEL_D);
-		outb(green >> 10, VGA_PEL_D);
-		outb(blue >> 10, VGA_PEL_D);
-		break;
 	case 8:
-		if (regno >= 256)
+		cols = 1 << (fb->var.bits_per_pixel ? fb->var.bits_per_pixel : 4);
+		if (regno >= cols)
 			return -EINVAL;
 
-		outb(0xFF, VGA_PEL_MSK);
-		outb(regno, VGA_PEL_IW);
-		outb(red >> 10, VGA_PEL_D);
-		outb(green >> 10, VGA_PEL_D);
-		outb(blue >> 10, VGA_PEL_D);
+		if ((fb->var.bits_per_pixel == 4) && ((fb->var.nonstd & 1) == 0))
+			regno <<= 4;
+
+		vga_w(par->state.vgabase, VGA_PEL_IW, regno);
+		vga_w(par->state.vgabase, VGA_PEL_D, red >> 10);
+		vga_w(par->state.vgabase, VGA_PEL_D, green >> 10);
+		vga_w(par->state.vgabase, VGA_PEL_D, blue >> 10);
 		break;
 	case 16:
 		if (regno >= 16)
@@ -1045,6 +1086,33 @@ static int s3fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 	return 0;
 }
 
+/* Get capabilities of accelerator based on the mode */
+
+static void s3fb_get_caps(struct fb_info *info, struct fb_blit_caps *caps,
+			  struct fb_var_screeninfo *var)
+{
+	int i;
+
+	if (var->bits_per_pixel == 0) {
+		/* can only support 256 8x16 bitmap */
+		bitmap_zero(caps->x, FB_MAX_BLIT_WIDTH);
+		set_bit(8 - 1, caps->x);
+		bitmap_zero(caps->y, FB_MAX_BLIT_HEIGHT);
+		set_bit(16 - 1, caps->y);
+		caps->len = 256;
+	} else {
+		if (var->bits_per_pixel == 4 && (var->nonstd & 1) != 0) {
+			bitmap_zero(caps->x, FB_MAX_BLIT_WIDTH);
+			for (i = 8; i <= FB_MAX_BLIT_WIDTH; i += 8)
+				set_bit(i - 1, caps->x);
+		} else {
+			bitmap_fill(caps->x, FB_MAX_BLIT_WIDTH);
+		}
+		bitmap_fill(caps->y, FB_MAX_BLIT_HEIGHT);
+		caps->len = ~(u32)0;
+	}
+}
+
 /* ------------------------------------------------------------------------- */
 
 /* Frame buffer operations */
@@ -1063,7 +1131,7 @@ static const struct fb_ops s3fb_ops = {
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= s3fb_imageblit,
 	__FB_DEFAULT_IOMEM_OPS_MMAP,
-	.fb_get_caps    = svga_get_caps,
+	.fb_get_caps	= s3fb_get_caps,
 };
 
 /* ------------------------------------------------------------------------- */
-- 
2.30.2


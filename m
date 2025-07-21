Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE08F2D6609;
	Mon, 21 Jul 2025 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102593; cv=none; b=Jqq9AIpzzFoxKUf3uLrq9t4AvYWQqgOhUwbrE7jEa+PL0nly8aJLmZxisTY01KaQ2GV9lS9Tuw/yI6zSWQKPRBgYXL+sIeBibXebLi+ndujePHXs8ezKik5HW6peCKKJOBuPafIA8MnK2j+UPFqzomN8MkwmmI4p54QfcTSSNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102593; c=relaxed/simple;
	bh=PfOYPiVGChUA1lb4czCViq+/vtUEEXAawmIkKLCLZ6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZwYFW9pYMfNwjdFl+t73/mMe+lkn0Andd6+VgkWQUeXrtBSrf3X2mD5TT7JTMp4UMpYFOzCgYR+UppO/SUZlUvSARMoBeNdtqBwUSW+XXjYH4HVhv/cyy7uF43bQ9U+6EJwyxBuNAg2aKXhxxBA822nI/3XpZj3xtoBHDb5M7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxrsgPIF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxrsgPIF"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23649faf69fso33701475ad.0;
        Mon, 21 Jul 2025 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753102591; x=1753707391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NTRKGfzOHatiL46xHxv71/tQ2NCbJIdvz6s8nypCsrM=;
        b=dxrsgPIFy7KKHSV9lArAII4ZBIXpRyJVgSnLFJ1frVgxHmkKQHHFGuj6HQZR/bRC0I
         7z9KOSew0YwjMjT218bKD7/o8O/SldubRXIHUeBtq0fiTKYThQGJzj9SGt9eqe08gQwh
         y0UEu6+nw8aJJ0bod7PBkuzFUU0cXkETGqoFvQkB+6lPaXB+rynB8JRyW0QC8BczMZvp
         yZTd3ycN8XH3y6sIEL0L9TJdRE/7VJUc3dTPOZBWKF330CDybR7tbMOuOiwEVlfrCulv
         SmEmWjRA9PEM6qNsw6eo4ZNKPam04Jq+WpyXVKEYhNHmISzbVVtOrz5Av3YxM59M7Cux
         jqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102591; x=1753707391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTRKGfzOHatiL46xHxv71/tQ2NCbJIdvz6s8nypCsrM=;
        b=RwG0/UYeXfPne8u9tqiS97F8h/uSnbmVfJN926fu/aY4/w4OLqPzx4akSskvDy7OIF
         Fqy1JDX+IxOez+KAnjl9Qyvyy6+dHwqRjoXdULexPFDUW2R8/Opg0kgLaXsRqxQSlpbp
         f9gBwK7judjpvuGDwtkgSlxfN6mNz85CGFFdOUXnWwB2ziAwswGs5x2bJ31PCrQTcn4D
         JOY7AsfWZg5pnZR8hWENKS7b2EZkq8kt0U8aC2fZoGTkCndtv7wLTP/F8AfDidGssqSe
         toLutr5jXwMeyGIBPs8FGuPH+Px/Jt+It35Zzl0K9BLavzinSaT7zEP4MalB9YgdAH+B
         2UZw==
X-Forwarded-Encrypted: i=1; AJvYcCVqy9lbZG4oa8NFJ1vqniRwCmV1GfJ6Wr7QfP3evQQ1Df4IO1vPL/Tl8z/bsSAdnbUYiAeLVNKFGbzVBJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32MjODzzCCObj18QejtEgA9RIlT0+s8mUOP67ptKNDNEZYvwo
	G/yyFN4miFlXQBblixvI2nK8oWrh/C2b9JhBn2h/C5lpZyDGEy2elU6W
X-Gm-Gg: ASbGncsVsz315C9lnSBn8XLcKPjZ+SqWVeyqPkEmieeusn31AiCDxr+G05XZCXx+gfY
	8GEPVgLnvOadUDcdAqE4kkjkQxLeGgYbOh9RnL04tntaa4xcxRIv/IPi8sNqbYj1Z+u2YGhtnMz
	PpsSmox6XrzzJocxuPkW8nC332I8cM/6PCbrBk4J+weQnJ4klxTxS78AmFYrqBwuzgY5j3Ej/9G
	DqZ2G8pY+RtBETJCekgKorJjOS6fVHVd0sAqTpZejXdrNVnbctciiquxL2ys/c7sUFf6wFQEdH8
	l6tRF4e5Gu7d87lO+qeM7hfp089Fwqcv+AWYvDQyI9cZi6982xifEl/XrSJzQXwRKy131gSwwb2
	MoSW+2jEdrt1OuXJ8AOHFJZiBU6oVkLZrVE8VSvePQPskPkFGiI/p4k2L0sYCV/0cbzOmpVGyAw
	==
X-Google-Smtp-Source: AGHT+IFamResX5lkIhYoIEIC7CTZPRcvOjSrboT2zvaKifB5ME1+0rD4aXdJdbbtOt1zPLxLSXzN2A==
X-Received: by 2002:a17:902:ceca:b0:235:2375:7eaa with SMTP id d9443c01a7336-23e256c99bemr303453015ad.22.1753102590906;
        Mon, 21 Jul 2025 05:56:30 -0700 (PDT)
Received: from SIQOL-WIN-0002-DARSHAN.localdomain ([49.36.70.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d1d61sm58083435ad.159.2025.07.21.05.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:56:29 -0700 (PDT)
From: "Darshan R." <rathod.darshan.0896@gmail.com>
To: simona@ffwll.ch,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dishank@siqol.com,
	"Darshan R." <rathod.darshan.0896@gmail.com>
Subject: [PATCH] fbdev: svgalib: Clean up coding style
Date: Mon, 21 Jul 2025 12:56:47 +0000
Message-ID: <20250721125648.27179-1-rathod.darshan.0896@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses various coding style issues in `svgalib.c` to improve readability and better align the code with the Linux kernel's formatting standards.

The changes primarily consist of:
- Adjusting whitespace around operators and after keywords.
- Standardizing brace placement for control flow statements.
- Removing unnecessary braces on single-statement if/else blocks.
- Deleting extraneous blank lines throughout the file.

These changes are purely stylistic and introduce no functional modifications.

Signed-off-by: Darshan R. <rathod.darshan.0896@gmail.com>
---
 drivers/video/fbdev/core/svgalib.c | 95 +++++++++++++-----------------
 1 file changed, 42 insertions(+), 53 deletions(-)

diff --git a/drivers/video/fbdev/core/svgalib.c b/drivers/video/fbdev/core/svgalib.c
index 821b89a0a645..5234ad109dfd 100644
--- a/drivers/video/fbdev/core/svgalib.c
+++ b/drivers/video/fbdev/core/svgalib.c
@@ -19,7 +19,6 @@
 #include <asm/types.h>
 #include <asm/io.h>
 
-
 /* Write a CRT register value spread across multiple registers */
 void svga_wcrt_multi(void __iomem *regbase, const struct vga_regset *regset, u32 value)
 {
@@ -31,12 +30,13 @@ void svga_wcrt_multi(void __iomem *regbase, const struct vga_regset *regset, u32
 		while (bitnum <= regset->highbit) {
 			bitval = 1 << bitnum;
 			regval = regval & ~bitval;
-			if (value & 1) regval = regval | bitval;
-			bitnum ++;
+			if (value & 1)
+				regval = regval | bitval;
+			bitnum++;
 			value = value >> 1;
 		}
 		vga_wcrt(regbase, regset->regnum, regval);
-		regset ++;
+		regset++;
 	}
 }
 
@@ -51,12 +51,13 @@ void svga_wseq_multi(void __iomem *regbase, const struct vga_regset *regset, u32
 		while (bitnum <= regset->highbit) {
 			bitval = 1 << bitnum;
 			regval = regval & ~bitval;
-			if (value & 1) regval = regval | bitval;
-			bitnum ++;
+			if (value & 1)
+				regval = regval | bitval;
+			bitnum++;
 			value = value >> 1;
 		}
 		vga_wseq(regbase, regset->regnum, regval);
-		regset ++;
+		regset++;
 	}
 }
 
@@ -66,15 +67,13 @@ static unsigned int svga_regset_size(const struct vga_regset *regset)
 
 	while (regset->regnum != VGA_REGSET_END_VAL) {
 		count += regset->highbit - regset->lowbit + 1;
-		regset ++;
+		regset++;
 	}
 	return 1 << count;
 }
 
-
 /* ------------------------------------------------------------------------- */
 
-
 /* Set graphics controller registers to sane values */
 void svga_set_default_gfx_regs(void __iomem *regbase)
 {
@@ -102,7 +101,7 @@ void svga_set_default_atc_regs(void __iomem *regbase)
 	vga_w(regbase, VGA_ATT_W, 0x00);
 
 	/* All standard ATC registers (AR00 - AR14) */
-	for (count = 0; count <= 0xF; count ++)
+	for (count = 0; count <= 0xF; count++)
 		svga_wattr(regbase, count, count);
 
 	svga_wattr(regbase, VGA_ATC_MODE, 0x01);
@@ -187,10 +186,8 @@ void svga_dump_var(struct fb_var_screeninfo *var, int node)
 }
 #endif  /*  0  */
 
-
 /* ------------------------------------------------------------------------- */
 
-
 void svga_settile(struct fb_info *info, struct fb_tilemap *map)
 {
 	const u8 *font = map->data;
@@ -229,7 +226,7 @@ void svga_tilecopy(struct fb_info *info, struct fb_tilearea *area)
 	    ((area->sy == area->dy) && (area->sx > area->dx))) {
 		src = fb + area->sx * colstride + area->sy * rowstride;
 		dst = fb + area->dx * colstride + area->dy * rowstride;
-	    } else {
+	} else {
 		src = fb + (area->sx + area->width - 1) * colstride
 			 + (area->sy + area->height - 1) * rowstride;
 		dst = fb + (area->dx + area->width - 1) * colstride
@@ -237,7 +234,7 @@ void svga_tilecopy(struct fb_info *info, struct fb_tilearea *area)
 
 		colstride = -colstride;
 		rowstride = -rowstride;
-	    }
+	}
 
 	for (dy = 0; dy < area->height; dy++) {
 		u16 __iomem *src2 = src;
@@ -284,19 +281,19 @@ void svga_tileblit(struct fb_info *info, struct fb_tileblit *blit)
 	u8 __iomem *fb = (u8 __iomem *)info->screen_base;
 	fb += blit->sx * colstride + blit->sy * rowstride;
 
-	i=0;
-	for (dy=0; dy < blit->height; dy ++) {
+	i = 0;
+	for (dy = 0; dy < blit->height; dy++) {
 		u8 __iomem *fb2 = fb;
-		for (dx = 0; dx < blit->width; dx ++) {
+		for (dx = 0; dx < blit->width; dx++) {
 			fb_writeb(blit->indices[i], fb2);
 			fb_writeb(attr, fb2 + 1);
 			fb2 += colstride;
-			i ++;
-			if (i == blit->length) return;
+			i++;
+			if (i == blit->length)
+				return;
 		}
 		fb += rowstride;
 	}
-
 }
 
 /* Set cursor in text (tileblit) mode */
@@ -308,15 +305,15 @@ void svga_tilecursor(void __iomem *regbase, struct fb_info *info, struct fb_tile
 		+ (cursor->sy + (info->var.yoffset / 16))
 		   * (info->var.xres_virtual / 8);
 
-	if (! cursor -> mode)
+	if (!cursor->mode)
 		return;
 
 	svga_wcrt_mask(regbase, 0x0A, 0x20, 0x20); /* disable cursor */
 
-	if (cursor -> shape == FB_TILE_CURSOR_NONE)
+	if (cursor->shape == FB_TILE_CURSOR_NONE)
 		return;
 
-	switch (cursor -> shape) {
+	switch (cursor->shape) {
 	case FB_TILE_CURSOR_UNDERLINE:
 		cs = 0x0d;
 		break;
@@ -374,7 +371,6 @@ EXPORT_SYMBOL(svga_get_caps);
 
 /* ------------------------------------------------------------------------- */
 
-
 /*
  *  Compute PLL settings (M, N, R)
  *  F_VCO = (F_BASE * M) / N
@@ -385,7 +381,7 @@ int svga_compute_pll(const struct svga_pll *pll, u32 f_wanted, u16 *m, u16 *n, u
 	u16 am, an, ar;
 	u32 f_vco, f_current, delta_current, delta_best;
 
-	pr_debug("fb%d: ideal frequency: %d kHz\n", node, (unsigned int) f_wanted);
+	pr_debug("fb%d: ideal frequency: %d kHz\n", node, (unsigned int)f_wanted);
 
 	ar = pll->r_max;
 	f_vco = f_wanted << ar;
@@ -416,7 +412,7 @@ int svga_compute_pll(const struct svga_pll *pll, u32 f_wanted, u16 *m, u16 *n, u
 
 	while ((am <= pll->m_max) && (an <= pll->n_max)) {
 		f_current = (pll->f_base * am) / an;
-		delta_current = abs_diff (f_current, f_vco);
+		delta_current = abs_diff(f_current, f_vco);
 
 		if (delta_current < delta_best) {
 			delta_best = delta_current;
@@ -424,58 +420,55 @@ int svga_compute_pll(const struct svga_pll *pll, u32 f_wanted, u16 *m, u16 *n, u
 			*n = an;
 		}
 
-		if (f_current <= f_vco) {
-			am ++;
-		} else {
-			an ++;
-		}
+		if (f_current <= f_vco)
+			am++;
+		else
+			an++;
 	}
 
 	f_current = (pll->f_base * *m) / *n;
-	pr_debug("fb%d: found frequency: %d kHz (VCO %d kHz)\n", node, (int) (f_current >> ar), (int) f_current);
-	pr_debug("fb%d: m = %d n = %d r = %d\n", node, (unsigned int) *m, (unsigned int) *n, (unsigned int) *r);
+	pr_debug("fb%d: found frequency: %d kHz (VCO %d kHz)\n", node, (int)(f_current >> ar), (int)f_current);
+	pr_debug("fb%d: m = %d n = %d r = %d\n", node, (unsigned int)*m, (unsigned int)*n, (unsigned int)*r);
 	return 0;
 }
 
-
 /* ------------------------------------------------------------------------- */
 
-
 /* Check CRT timing values */
 int svga_check_timings(const struct svga_timing_regs *tm, struct fb_var_screeninfo *var, int node)
 {
 	u32 value;
 
-	var->xres         = (var->xres+7)&~7;
-	var->left_margin  = (var->left_margin+7)&~7;
-	var->right_margin = (var->right_margin+7)&~7;
-	var->hsync_len    = (var->hsync_len+7)&~7;
+	var->xres         = (var->xres + 7) & ~7;
+	var->left_margin  = (var->left_margin + 7) & ~7;
+	var->right_margin = (var->right_margin + 7) & ~7;
+	var->hsync_len    = (var->hsync_len + 7) & ~7;
 
 	/* Check horizontal total */
 	value = var->xres + var->left_margin + var->right_margin + var->hsync_len;
-	if (((value / 8) - 5) >= svga_regset_size (tm->h_total_regs))
+	if (((value / 8) - 5) >= svga_regset_size(tm->h_total_regs))
 		return -EINVAL;
 
 	/* Check horizontal display and blank start */
 	value = var->xres;
-	if (((value / 8) - 1) >= svga_regset_size (tm->h_display_regs))
+	if (((value / 8) - 1) >= svga_regset_size(tm->h_display_regs))
 		return -EINVAL;
-	if (((value / 8) - 1) >= svga_regset_size (tm->h_blank_start_regs))
+	if (((value / 8) - 1) >= svga_regset_size(tm->h_blank_start_regs))
 		return -EINVAL;
 
 	/* Check horizontal sync start */
 	value = var->xres + var->right_margin;
-	if (((value / 8) - 1) >= svga_regset_size (tm->h_sync_start_regs))
+	if (((value / 8) - 1) >= svga_regset_size(tm->h_sync_start_regs))
 		return -EINVAL;
 
 	/* Check horizontal blank end (or length) */
 	value = var->left_margin + var->right_margin + var->hsync_len;
-	if ((value == 0) || ((value / 8) >= svga_regset_size (tm->h_blank_end_regs)))
+	if ((value == 0) || ((value / 8) >= svga_regset_size(tm->h_blank_end_regs)))
 		return -EINVAL;
 
 	/* Check horizontal sync end (or length) */
 	value = var->hsync_len;
-	if ((value == 0) || ((value / 8) >= svga_regset_size (tm->h_sync_end_regs)))
+	if ((value == 0) || ((value / 8) >= svga_regset_size(tm->h_sync_end_regs)))
 		return -EINVAL;
 
 	/* Check vertical total */
@@ -497,12 +490,12 @@ int svga_check_timings(const struct svga_timing_regs *tm, struct fb_var_screenin
 
 	/* Check vertical blank end (or length) */
 	value = var->upper_margin + var->lower_margin + var->vsync_len;
-	if ((value == 0) || (value >= svga_regset_size (tm->v_blank_end_regs)))
+	if ((value == 0) || (value >= svga_regset_size(tm->v_blank_end_regs)))
 		return -EINVAL;
 
 	/* Check vertical sync end  (or length) */
 	value = var->vsync_len;
-	if ((value == 0) || (value >= svga_regset_size (tm->v_sync_end_regs)))
+	if ((value == 0) || (value >= svga_regset_size(tm->v_sync_end_regs)))
 		return -EINVAL;
 
 	return 0;
@@ -596,18 +589,15 @@ void svga_set_timings(void __iomem *regbase, const struct svga_timing_regs *tm,
 	vga_w(regbase, VGA_MIS_W, regval);
 }
 
-
 /* ------------------------------------------------------------------------- */
 
-
 static inline int match_format(const struct svga_fb_format *frm,
 			       struct fb_var_screeninfo *var)
 {
 	int i = 0;
 	int stored = -EINVAL;
 
-	while (frm->bits_per_pixel != SVGA_FORMAT_END_VAL)
-	{
+	while (frm->bits_per_pixel != SVGA_FORMAT_END_VAL) {
 		if ((var->bits_per_pixel == frm->bits_per_pixel) &&
 		    (var->red.length     <= frm->red.length)     &&
 		    (var->green.length   <= frm->green.length)   &&
@@ -647,7 +637,6 @@ int svga_match_format(const struct svga_fb_format *frm,
 	return i;
 }
 
-
 EXPORT_SYMBOL(svga_wcrt_multi);
 EXPORT_SYMBOL(svga_wseq_multi);
 
-- 
2.43.0


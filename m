Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EF23D5246
	for <linux-fbdev@vger.kernel.org>; Sun, 16 Aug 2026 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786865884; cv=none; b=Qed3iWQILgSzURLTCv/gqn7b/Lr2VOCf0FUHQAlLPNCyHTFasUhARkrQo4b9c+/EHD7K4DByN43WSepatT72pPHB0UGHCbpWcxYZvqGNCuStpSzSV+e3/g+3iaQGsRrfxB2C3otj3cpg943CrLi7Nt2bZmq6lh4a1KCGpii24OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786865884; c=relaxed/simple;
	bh=emsftyw5wyoadJa+IORXBvBSvTjmZyYai6RX0k/JApg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHuFrZdSKAAYvdm0KJ1IJWpdFFEd7vxY+wTbUVPZ5BkJxl3By8/B4gCiHz5jYJQ/Pqs+wERvHPxpQXJjFyfMYI63gEm/W8a1xjjX1WlIguLV1E6CwTKAxEvpNjNU41VR9W2bG4hbBczzCnyDs16wfGgkoa/Thzhc3fDV8Kg0AH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xau7D2Pw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xau7D2Pw"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d01663d816so20632735ad.1
        for <linux-fbdev@vger.kernel.org>; Sun, 16 Aug 2026 00:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786865882; x=1787470682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eivPPKqM37O/esXZcj/rxFYzR0cZV1VDclO2F/dhLtM=;
        b=Xau7D2PwnCKn21ymO8YlRFeVQbIHbABk+xISVpVHlDwi8MwXDvJxR9XhFndl/WyPtj
         9oc90OTBhYEWTJPg7AYjdceQjMHJx/vIVt+cWgrFiaJjeCgsXyF+APMxsTvASu4oDKzD
         Y8pB9eC3qFAHyonT60Hs/vf+1Noh/AHV1S/DuWRgAfW+Gn1aSIz/HPRNF1SCMQ/n9sY7
         yyzzj85Po4cxOnKrYwCXrEm1QhGJm07NEdV4JCdRgMSezsnB+I5HGHMwHVzmJeLK88+7
         72vrJu+wqYDKcSre8tNgbjMTlY7hdlxyeVNpssmTMJO0iywO4EvCsVZLiyqalqWJ4YZa
         NjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786865882; x=1787470682;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eivPPKqM37O/esXZcj/rxFYzR0cZV1VDclO2F/dhLtM=;
        b=eUf27idvlXLv05BtBUCS1iX4V/nUvmB24943agnbH375Z4yV7Lpj12SnF0jQjvTQGP
         TLnpub362lQxXIajTxHnHehcfJaZGWT0D6MdkXEAdT5yARyHrMiF60oHR2yscqAHXC3E
         XqWawIyQ/nlfK5Z9H4ztwh3U+lybhd80XOisQiKIOPM259TfLVvcQ6ZxjcS3PVfZXDJZ
         4sHJUQtbFIMqwevzTAvqkFMUUl4/dXkBv+NUnH+Nqs4Ssa5t/yWu46+d97MadsQ5uVC4
         8iUD1wg3z9cyhBKhj/Kz3Kzw76UgYhyaDnBSN/ULTvUSo0Kh+P6UEW6+mmpnqYbXp4Nx
         11Pw==
X-Forwarded-Encrypted: i=1; AHgh+Rpv1igiQ1FMrt3ycdG6Q9jUnjzUpVUO2WYYDUHrFJqqtn+nT0xUHjx1jRgHAQtew3ag0WSBVnOlYvVxjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqJtHxKORrA5G5oduuc3GlD1LIELH9XqoW3kRCs5b83wy3kNBd
	+70MvS/n8/IwWLqO3QM4BfvvZnUKmXhKrkBQDtwThsKgYsQqOEZAkuPUxD/cNw==
X-Gm-Gg: AR+sD13NvylEmkzamCuWjq/oWi2TtQSlzJKaV3+aJjCAA/XjBGWhroF+sftjCc4f5Rr
	jEo0k3GNHuQ7KZ+OGAE8MOzKAvkzQhuAnRSc792TYYbLL3FDCxYMBwpm6GmESEDkO873B9waAij
	C5rcOf8baAaBIgFQ2NuuntCXHyPDYsGETrU3etSeDzjFIt5lv1Wvz8SLMJtVGbjL27TdsrLx5f8
	HQNzD/5Uf0pnkHB61fGSYq4zFYsdNfnxVE56w+3XeSu71TjmWVh53p+BKCsFz5EA8bHNWXhsFFv
	/XRTpfIlIn5j7bD3cKshxUrgAKQhgTHHFPQBR2EDk9zxZSVsbhPUgKK6I0Ztil2Qd26RZcv1cCb
	MTW93WIx1LLPcdIVM8JthkSWVOAEnQf5ZclA5zePyaNPwdjYkI0ILeUjNeKOLGGNQxCxM5Ivieu
	CQhVfZyiteEK1mUqY3dDYf2RfUSad3KZlL8olZZTVZXR/mWQdNNcDOQPLNVlR9JddMDaeKl7VJ5
	M49/NyVn5eEioRDC3+1gawRpqaV5piiq/t7Lh9JZNj6m8rE3cvgMw==
X-Received: by 2002:a17:90b:3d48:b0:381:528a:808c with SMTP id 98e67ed59e1d1-3933b8939dfmr18940629a91.12.1786865882042;
        Sun, 16 Aug 2026 00:38:02 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-170-159-fibre.sparkbb.co.nz. [222.152.170.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e84244sm843306a91.6.2026.08.16.00.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 00:38:01 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id 11BB3360495; Sun, 16 Aug 2026 19:37:58 +1200 (NZST)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org,
	geert@linux-m68k.org
Cc: schmitzmic@gmail.com,
	Miro Kropacek <miro.kropacek@gmail.com>,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v2 3/5] fbdev: Add support for further video bit depths on atafb:external
Date: Sun, 16 Aug 2026 19:37:50 +1200
Message-Id: <20260816073752.16656-4-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260816073752.16656-1-schmitzmic@gmail.com>
References: <20260816073752.16656-1-schmitzmic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Miro Kropacek <miro.kropacek@gmail.com>

Supervidel offers additional video bit depths (8-bit chunky, 16-bit
RGB565 (also on the originaln Videl) and ARGB888.

Add code to support these bit depths.

Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Cc: <linux-fbdev@vger.kernel.org>
Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
---
 drivers/video/fbdev/atafb.c | 89 ++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index 3d540803dc2b..50853d7a08e3 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -2081,8 +2081,12 @@ static int ext_encode_fix(struct fb_fix_screeninfo *fix, struct atafb_par *par)
 			 external_pmode == FB_TYPE_PACKED_PIXELS) ?
 				FB_VISUAL_MONO10 : FB_VISUAL_MONO01;
 	} else {
-		/* Use STATIC if we don't know how to access color registers */
-		int visual = external_vgaiobase ?
+		/* Use STATIC if we don't know how to access color registers;
+		 * SuperVidel 8bpp chunky (fb in SV RAM) uses the Falcon palette
+		 */
+		int visual = (external_vgaiobase ||
+			      (external_depth == 8 &&
+			       external_addr >= 0xa0000000)) ?
 					 FB_VISUAL_PSEUDOCOLOR :
 					 FB_VISUAL_STATIC_PSEUDOCOLOR;
 		switch (external_pmode) {
@@ -2159,6 +2163,35 @@ static int ext_encode_var(struct fb_var_screeninfo *var, struct atafb_par *par)
 	var->transp.offset = 0;
 	var->transp.length = 0;
 	var->transp.msb_right = 0;
+	if (external_pmode == -1 && external_depth == 16) {
+		/* RGB565 truecolor (e.g. SuperVidel native mode) */
+		var->red.offset = 11;
+		var->red.length = 5;
+		var->green.offset = 5;
+		var->green.length = 6;
+		var->blue.offset = 0;
+		var->blue.length = 5;
+	} else if (external_pmode == -1 && external_depth == 32) {
+		/* ARGB8888 truecolor (e.g. SuperVidel native mode) */
+		var->red.offset = 16;
+		var->red.length = 8;
+		var->green.offset = 8;
+		var->green.length = 8;
+		var->blue.offset = 0;
+		var->blue.length = 8;
+		var->transp.offset = 24;
+		var->transp.length = 8;
+	} else if (external_pmode == FB_TYPE_PACKED_PIXELS &&
+		   external_depth == 8 && external_addr >= 0xa0000000) {
+		/* SuperVidel 8bpp chunky: palette has 8 bits per channel.
+		 * Without this, fb_get_color_depth() sees length 0 and
+		 * fbcon falls back to its 2-color palette — the console
+		 * text (color 7) stays black on black.
+		 */
+		var->red.length = 8;
+		var->green.length = 8;
+		var->blue.length = 8;
+	}
 	var->yres_virtual = var->yres;
 	var->xoffset = 0;
 	var->yoffset = 0;
@@ -2193,6 +2226,38 @@ static int ext_setcolreg(unsigned int regno, unsigned int red,
 {
 	unsigned char colmask = (1 << external_bitspercol) - 1;
 
+	if (external_pmode == -1 && external_depth == 16) {
+		/* truecolor: only the pseudo palette for fbcon is needed */
+		if (regno > 15)
+			return 1;
+		((u32 *)info->pseudo_palette)[regno] = (red & 0xf800) |
+						       ((green & 0xfc00) >> 5) |
+						       ((blue & 0xf800) >> 11);
+		return 0;
+	}
+	if (external_pmode == -1 && external_depth == 32) {
+		/* ARGB8888, alpha forced opaque */
+		if (regno > 15)
+			return 1;
+		((u32 *)info->pseudo_palette)[regno] = 0xff000000 |
+						       ((red & 0xff00) << 8) |
+						       (green & 0xff00) |
+						       ((blue & 0xff00) >> 8);
+		return 0;
+	}
+	if (external_pmode == FB_TYPE_PACKED_PIXELS && external_depth == 8 &&
+	    external_addr >= 0xa0000000) {
+		/* SuperVidel native 8bpp chunky scans out via the Falcon
+		 * palette registers, honoring all 8 bits per channel
+		 */
+		if (regno > 255)
+			return 1;
+		f030_col[regno] = ((red & 0xff00) << 16) |
+				  ((green & 0xff00) << 8) |
+				  ((blue & 0xff00) >> 8);
+		return 0;
+	}
+
 	if (!external_vgaiobase)
 		return 1;
 
@@ -2422,7 +2487,9 @@ static void atafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 		return;
 
 #ifdef ATAFB_FALCON
-	if (info->var.bits_per_pixel == 16) {
+	/* chunky modes (Falcon hicolor, external packed/truecolor) */
+	if (info->fix.type == FB_TYPE_PACKED_PIXELS &&
+	    info->var.bits_per_pixel > 1) {
 		cfb_fillrect(info, rect);
 		return;
 	}
@@ -2463,7 +2530,9 @@ static void atafb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 	int rev_copy = 0;
 
 #ifdef ATAFB_FALCON
-	if (info->var.bits_per_pixel == 16) {
+	/* chunky modes (Falcon hicolor, external packed/truecolor) */
+	if (info->fix.type == FB_TYPE_PACKED_PIXELS &&
+	    info->var.bits_per_pixel > 1) {
 		cfb_copyarea(info, area);
 		return;
 	}
@@ -2517,7 +2586,9 @@ static void atafb_imageblit(struct fb_info *info, const struct fb_image *image)
 	u32 dx, dy, width, height, pitch;
 
 #ifdef ATAFB_FALCON
-	if (info->var.bits_per_pixel == 16) {
+	/* chunky modes (Falcon hicolor, external packed/truecolor) */
+	if (info->fix.type == FB_TYPE_PACKED_PIXELS &&
+	    info->var.bits_per_pixel > 1) {
 		cfb_imageblit(info, image);
 		return;
 	}
@@ -2753,7 +2824,7 @@ static void __init atafb_setup_ext(char *spec)
 		return;
 	depth = simple_strtoul(p, NULL, 10);
 	if (depth != 1 && depth != 2 && depth != 4 && depth != 8 &&
-	    depth != 16 && depth != 24)
+	    depth != 16 && depth != 24 && depth != 32)
 		return;
 
 	p = strsep(&spec, ";");
@@ -3131,7 +3202,11 @@ static int __init atafb_probe(struct platform_device *pdev)
 
 	atafb_set_disp(&fb_info);
 
-	fb_alloc_cmap(&(fb_info.cmap), 1 << fb_info.var.bits_per_pixel, 0);
+	/* truecolor visuals only need the 16-entry console palette; this
+	 * also avoids 1 << 32 overflowing at 32bpp
+	 */
+	fb_alloc_cmap(&(fb_info.cmap), fb_info.var.bits_per_pixel > 8 ?
+		      16 : 1 << fb_info.var.bits_per_pixel, 0);
 
 
 	dev_info(&pdev->dev, "Determined %dx%d, depth %d\n", fb_info.var.xres,
-- 
2.17.1


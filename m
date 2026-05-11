Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3998D3D1719
	for <linux-fbdev@vger.kernel.org>; Mon, 11 May 2026 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515819; cv=none; b=Eg3symDC9PACZZppLc1R3vyhPq9xfb7rjcMwxVwjJyEk5BI/uuP2S3N1U09+K1JHIU5ExOphdWT+EbSaTB9EI1b4n8A+hNYeFpXym+ZbwXxcvSNbd/eM5l5CO6dlr3TJHisEhV0J5ENRek+KkPFnrOEYqb+z6Tm1XPg16sD7pfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515819; c=relaxed/simple;
	bh=bqiGhSCKd81Tdlu5/C5rJxlJvZzGo177PumJ31CZo5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j02U+Mk3LVtv4qRF+8/TvRITv8zW/ctGilBdO1JkjStlBkzHx+roeWbjyO9OLgxR/urx0NMlepPgDejIUSLJ/ui1Rw/6n0R04b2XGUS90/JDIZpc6L6BKNyGjpfXpMmXgGIWlaD9m3LAM+9KSwQ5PiOjnyqdHlKci4NiGXz4Dso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDRcmr/r; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDRcmr/r"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2babfd18435so22953395ad.1
        for <linux-fbdev@vger.kernel.org>; Mon, 11 May 2026 09:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778515817; x=1779120617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=plSITfMA010SqNOgu3jqGN/TIycR52TrLYgXH248+w4=;
        b=EDRcmr/rsLOVPEU2I27La3zMa75qtxxWqO7hd3Mes/L0WVgfgZ2xdkVqqiEeDHzAMc
         IlFo2vhvm+ZHO8dfCm1XAwv5qmbuhgTls2N3+Ua+KUaO0EDKx1FPcvcDpDCvAc4kpMn8
         +0TmdUUoqGXr1JNQTRvAqW3tG45WhtUcl6WpRhLabjG/Snn+l8b3JJEstYCdinAKizLq
         IG7fzxkuxNGilKw/5Q0Yh2xwmr5U4+rtRmOUerpef4sM2Ojb/TLe08T2MjTJtm5lk37e
         LuPYytjU1cpmmBkDO/KD9aWZl9swUp/FwR2HE6yl2YxkE5iR+d3anjggff5v9rFI/vwF
         KaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515817; x=1779120617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plSITfMA010SqNOgu3jqGN/TIycR52TrLYgXH248+w4=;
        b=Snb3enaF+g8c0wGeD/bJ5Aw8tQrePzXsPD9wD+kIIOxOkhV6wPDQy5t+dADbIEb0gv
         vJhw2whBIbFDmvkvkPx2bxmrtHl/cC3z0d67vyxe8l9RCuRGNoEAFDerBIXEVUC3KMHh
         i5LtGjue/SsIR6R0CsnmxfWiJ6ng5bGc8Ku4MtXP6wZZzATtqnTtBfK3tb4H6R4XvXjO
         Fg460xDwrzNC7uq0FoE2cODfqBSJGS/7kTLdfy1tyHRtYHRUmThr9AOI4AtMwVedJeXq
         +RrGPB9NCATJKtlwsI9TT7OekXdnW4l2co3nv9Dp6aM6v9NeqVSd7d4YYMcHhloIH2Qg
         4CVQ==
X-Gm-Message-State: AOJu0Yz3XHSyRbZqkpuERZ0FGMS1rfb6I7/6+ne/tk6tZEBINnaaH4dM
	MBxlda7C3Osf/XtC2RXRd9tkB5SojUIOa0kmoMZGszSnVSg1ghhoKbjQWiaYCChs
X-Gm-Gg: Acq92OFE/Wf4bR/NVt3pm9/lBQGyf9FxPJYtgj3auBraxbJtQpI+iBoKtBjZoXYV/xz
	BSch33TOYD10IChMBRY0KNFMqv0ypg8SyRAmhejLhlMZD2QMnenWdW+ye0hibSY0rvnt+YhHWNm
	7/H6zBD3UWpDcCGPXOA+sUo+G5ItVxuOLGErjSe5BpPQKfLS8M8G34BjkWqAKX6lwI4CKZT+QxD
	TEZGc8waWrOoLPFMGNM1Px+LYT3fkI0IaMdDXoE7o6flur1UrpkWOdrwoBndspbS+JEYYoZ+1+q
	qBkUJPlrYp8fYkeY0K2Z+eWe1++edGWyVa0GHSGAMwV5wXJ09S5/C5A/BGPIW32Z/Hj0JrTDTN1
	CSAHLMJXfoHFFw+1ZKv6cqFYyORsOLeLbIe0GqO28iJOBQJXYnC+KJ0UVHQBrUiXYmObdav4YAe
	slXzVoTUh+ubIhXrp7BmZgFM16iV6aveYtOT8zm+9YoKMpNH221FmzYi8VOqkWzxBUW+A46LG95
	XaP
X-Received: by 2002:a17:903:1a68:b0:2bc:7486:21cf with SMTP id d9443c01a7336-2bc748623e7mr127942635ad.36.1778515816564;
        Mon, 11 May 2026 09:10:16 -0700 (PDT)
Received: from localhost.localdomain ([2404:7c00:52:d485:aae2:91ff:fe57:5e15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4057fsm104476225ad.21.2026.05.11.09.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:10:16 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH v2] staging: sm750fb: minor coding style cleanup
Date: Mon, 11 May 2026 21:54:05 +0545
Message-ID: <20260511160905.29938-1-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up various coding style issues including spacing in struct initializers and indentation of wrapped lines.

Signed-off-by: Alone <yogeshdangal66@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 203 ++++++++++++++++----------------
 1 file changed, 103 insertions(+), 100 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 9f3e3d37e82a..7fca2c9f6966 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,8 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+/* intentionally non-const since array is modified at runtime */
+static const char *g_fbmode[] = { NULL, NULL };
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
@@ -41,64 +42,62 @@ static char *g_option;
 
 static const struct fb_videomode lynx750_ext[] = {
 	/*	1024x600-60 VESA	[1.71:1] */
-	{NULL,  60, 1024, 600, 20423, 144,  40, 18, 1, 104, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	 FB_VMODE_NONINTERLACED},
+	{ NULL, 60, 1024, 600, 20423, 144, 40, 18, 1, 104, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED },
 
 	/*	1024x600-70 VESA */
-	{NULL,  70, 1024, 600, 17211, 152,  48, 21, 1, 104, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	 FB_VMODE_NONINTERLACED},
+	{ NULL, 70, 1024, 600, 17211, 152, 48, 21, 1, 104, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED },
 
 	/*	1024x600-75 VESA */
-	{NULL,  75, 1024, 600, 15822, 160,  56, 23, 1, 104, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	 FB_VMODE_NONINTERLACED},
+	{ NULL, 75, 1024, 600, 15822, 160, 56, 23, 1, 104, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED },
 
 	/*	1024x600-85 VESA */
-	{NULL,  85, 1024, 600, 13730, 168,  56, 26, 1, 112, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	 FB_VMODE_NONINTERLACED},
+	{ NULL, 85, 1024, 600, 13730, 168, 56, 26, 1, 112, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED },
 
 	/*	720x480	*/
-	{NULL, 60,  720,  480,  37427, 88,   16, 13, 1,   72,  3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	 FB_VMODE_NONINTERLACED},
+	{ NULL, 60, 720, 480, 37427, 88, 16, 13, 1, 72, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED },
 
 	/*	1280x720		[1.78:1]	*/
-	{NULL, 60,  1280,  720,  13426, 162, 86, 22, 1,  136, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	 FB_VMODE_NONINTERLACED},
+	{ NULL, 60, 1280, 720, 13426, 162, 86, 22, 1, 136, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED },
 
 	/*	1280x768@60 */
-	{NULL, 60, 1280, 768, 12579, 192, 64, 20, 3, 128, 7,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	 FB_VMODE_NONINTERLACED},
+	{ NULL, 60, 1280, 768, 12579, 192, 64, 20, 3, 128, 7,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED },
 
 	/*	1360 x 768	[1.77083:1]	*/
-	{NULL,  60, 1360, 768, 11804, 208,  64, 23, 1, 144, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	 FB_VMODE_NONINTERLACED},
+	{ NULL, 60, 1360, 768, 11804, 208, 64, 23, 1, 144, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED },
 
 	/*	1368 x 768      [1.78:1]	*/
-	{NULL, 60,  1368,  768,  11647, 216, 72, 23, 1,  144, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	 FB_VMODE_NONINTERLACED},
+	{ NULL, 60, 1368, 768, 11647, 216, 72, 23, 1, 144, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED },
 
 	/*	1440 x 900		[16:10]	*/
-	{NULL, 60, 1440, 900, 9392, 232, 80, 28, 1, 152, 3,
-	 FB_SYNC_VERT_HIGH_ACT,
-	 FB_VMODE_NONINTERLACED},
+	{ NULL, 60, 1440, 900, 9392, 232, 80, 28, 1, 152, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
 
 	/*	1440x960		[15:10]	*/
-	{NULL, 60, 1440, 960, 8733, 240, 88, 30, 1, 152, 3,
-	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	 FB_VMODE_NONINTERLACED},
+	{ NULL, 60, 1440, 960, 8733, 240, 88, 30, 1, 152, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED },
 
 	/*	1920x1080	[16:9]	*/
-	{NULL, 60, 1920, 1080, 6734, 148, 88, 41, 1, 44, 3,
-	 FB_SYNC_VERT_HIGH_ACT,
-	 FB_VMODE_NONINTERLACED},
+	{ NULL, 60, 1920, 1080, 6734, 148, 88, 41, 1, 44, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
 };
 
 /* no hardware cursor supported under version 2.6.10, kernel bug */
@@ -120,8 +119,7 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 
 	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
-		sm750_hw_cursor_set_size(cursor,
-					 fbcursor->image.width,
+		sm750_hw_cursor_set_size(cursor, fbcursor->image.width,
 					 fbcursor->image.height);
 
 	if (fbcursor->set & FB_CUR_SETPOS)
@@ -134,19 +132,23 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 		u16 fg, bg;
 
 		fg = ((info->cmap.red[fbcursor->image.fg_color] & 0xf800)) |
-		     ((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5) |
-		     ((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >> 11);
+		     ((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >>
+		      5) |
+		     ((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >>
+		      11);
 
 		bg = ((info->cmap.red[fbcursor->image.bg_color] & 0xf800)) |
-		     ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5) |
-		     ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
+		     ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >>
+		      5) |
+		     ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >>
+		      11);
 
 		sm750_hw_cursor_set_color(cursor, fg, bg);
 	}
 
 	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
-		sm750_hw_cursor_set_data(cursor, fbcursor->rop, fbcursor->image.data,
-					 fbcursor->mask);
+		sm750_hw_cursor_set_data(cursor, fbcursor->rop,
+					 fbcursor->image.data, fbcursor->mask);
 	}
 
 	if (fbcursor->enable)
@@ -178,7 +180,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	bpp = info->var.bits_per_pixel >> 3;
 
 	color = (bpp == 1) ? region->color :
-		((u32 *)info->pseudo_palette)[region->color];
+			     ((u32 *)info->pseudo_palette)[region->color];
 	rop = (region->rop != ROP_COPY) ? HW_ROP2_XOR : HW_ROP2_COPY;
 
 	/*
@@ -189,11 +191,9 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	 */
 	spin_lock(&sm750_dev->slock);
 
-	sm750_dev->accel.de_fillrect(&sm750_dev->accel,
-				     base, pitch, bpp,
-				     region->dx, region->dy,
-				     region->width, region->height,
-				     color, rop);
+	sm750_dev->accel.de_fillrect(&sm750_dev->accel, base, pitch, bpp,
+				     region->dx, region->dy, region->width,
+				     region->height, color, rop);
 	spin_unlock(&sm750_dev->slock);
 }
 
@@ -223,10 +223,9 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	 */
 	spin_lock(&sm750_dev->slock);
 
-	sm750_dev->accel.de_copyarea(&sm750_dev->accel,
-				     base, pitch, region->sx, region->sy,
-				     base, pitch, bpp, region->dx, region->dy,
-				     region->width, region->height,
+	sm750_dev->accel.de_copyarea(&sm750_dev->accel, base, pitch, region->sx,
+				     region->sy, base, pitch, bpp, region->dx,
+				     region->dy, region->width, region->height,
 				     HW_ROP2_COPY);
 	spin_unlock(&sm750_dev->slock);
 }
@@ -272,12 +271,11 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	 */
 	spin_lock(&sm750_dev->slock);
 
-	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
-				      image->data, image->width >> 3, 0,
-				      base, pitch, bpp,
-				      image->dx, image->dy,
-				      image->width, image->height,
-				      fgcol, bgcol, HW_ROP2_COPY);
+	sm750_dev->accel.de_imageblit(&sm750_dev->accel, image->data,
+				      image->width >> 3, 0, base, pitch, bpp,
+				      image->dx, image->dy, image->width,
+				      image->height, fgcol, bgcol,
+				      HW_ROP2_COPY);
 	spin_unlock(&sm750_dev->slock);
 }
 
@@ -385,7 +383,7 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 
 	var->height = -1;
 	var->width = -1;
-	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
+	var->accel_flags = 0; /*FB_ACCELF_TEXT;*/
 
 	if (ret) {
 		dev_err(info->device, "bpp %d not supported\n",
@@ -498,7 +496,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 
 	var->height = -1;
 	var->width = -1;
-	var->accel_flags = 0;/* FB_ACCELF_TEXT; */
+	var->accel_flags = 0; /* FB_ACCELF_TEXT; */
 
 	/* check if current fb's video memory big enough to hold the onscreen*/
 	request = var->xres_virtual * (var->bits_per_pixel >> 3);
@@ -514,12 +512,9 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	return hw_sm750_crtc_check_mode(crtc, var);
 }
 
-static int lynxfb_ops_setcolreg(unsigned int regno,
-				unsigned int red,
-				unsigned int green,
-				unsigned int blue,
-				unsigned int transp,
-				struct fb_info *info)
+static int lynxfb_ops_setcolreg(unsigned int regno, unsigned int red,
+				unsigned int green, unsigned int blue,
+				unsigned int transp, struct fb_info *info)
 {
 	struct lynxfb_par *par;
 	struct lynxfb_crtc *crtc;
@@ -556,8 +551,7 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
 	if (info->fix.visual == FB_VISUAL_TRUECOLOR && regno < 256) {
 		u32 val;
 
-		if (var->bits_per_pixel == 16 ||
-		    var->bits_per_pixel == 32 ||
+		if (var->bits_per_pixel == 16 || var->bits_per_pixel == 32 ||
 		    var->bits_per_pixel == 24) {
 			val = chan_to_field(red, &var->red);
 			val |= chan_to_field(green, &var->green);
@@ -616,7 +610,8 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 
 	/* chip specific phase */
 	sm750_dev->accel.de_wait = (sm750_dev->revid == SM750LE_REVISION_ID) ?
-				    hw_sm750le_de_wait : hw_sm750_de_wait;
+					   hw_sm750le_de_wait :
+					   hw_sm750_de_wait;
 	switch (sm750_dev->dataflow) {
 	case sm750_simul_pri:
 		output->paths = sm750_pnc;
@@ -670,7 +665,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 static const struct fb_ops lynxfb_ops = {
 	.owner = THIS_MODULE,
 	FB_DEFAULT_IOMEM_OPS,
-	.fb_check_var =  lynxfb_ops_check_var,
+	.fb_check_var = lynxfb_ops_check_var,
 	.fb_set_par = lynxfb_ops_set_par,
 	.fb_setcolreg = lynxfb_ops_setcolreg,
 	.fb_blank = lynxfb_ops_blank,
@@ -680,7 +675,7 @@ static const struct fb_ops lynxfb_ops = {
 static const struct fb_ops lynxfb_ops_with_cursor = {
 	.owner = THIS_MODULE,
 	FB_DEFAULT_IOMEM_OPS,
-	.fb_check_var =  lynxfb_ops_check_var,
+	.fb_check_var = lynxfb_ops_check_var,
 	.fb_set_par = lynxfb_ops_set_par,
 	.fb_setcolreg = lynxfb_ops_setcolreg,
 	.fb_blank = lynxfb_ops_blank,
@@ -691,7 +686,7 @@ static const struct fb_ops lynxfb_ops_with_cursor = {
 static const struct fb_ops lynxfb_ops_accel = {
 	.owner = THIS_MODULE,
 	__FB_DEFAULT_IOMEM_OPS_RDWR,
-	.fb_check_var =  lynxfb_ops_check_var,
+	.fb_check_var = lynxfb_ops_check_var,
 	.fb_set_par = lynxfb_ops_set_par,
 	.fb_setcolreg = lynxfb_ops_setcolreg,
 	.fb_blank = lynxfb_ops_blank,
@@ -705,7 +700,7 @@ static const struct fb_ops lynxfb_ops_accel = {
 static const struct fb_ops lynxfb_ops_accel_with_cursor = {
 	.owner = THIS_MODULE,
 	__FB_DEFAULT_IOMEM_OPS_RDWR,
-	.fb_check_var =  lynxfb_ops_check_var,
+	.fb_check_var = lynxfb_ops_check_var,
 	.fb_set_par = lynxfb_ops_set_par,
 	.fb_setcolreg = lynxfb_ops_setcolreg,
 	.fb_blank = lynxfb_ops_blank,
@@ -728,11 +723,14 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	struct fb_fix_screeninfo *fix;
 
 	const struct fb_videomode *pdb[] = {
-		lynx750_ext, NULL, vesa_modes,
+		lynx750_ext,
+		NULL,
+		vesa_modes,
 	};
-	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
+	int cdb[] = { ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE };
 	static const char *fix_id[2] = {
-		"sm750_fb1", "sm750_fb2",
+		"sm750_fb1",
+		"sm750_fb2",
 	};
 
 	int ret, line_length;
@@ -755,8 +753,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pvReg +
-		0x800f0 + (int)crtc->channel * 0x140;
+	crtc->cursor.mmio =
+		sm750_dev->pvReg + 0x800f0 + (int)crtc->channel * 0x140;
 
 	crtc->cursor.max_h = 64;
 	crtc->cursor.max_w = 64;
@@ -788,8 +786,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	}
 
 	for (i = 0; i < 3; i++) {
-		ret = fb_find_mode(var, info, g_fbmode[index],
-				   pdb[i], cdb[i], NULL, 8);
+		ret = fb_find_mode(var, info, g_fbmode[index], pdb[i], cdb[i],
+				   NULL, 8);
 
 		if (ret == 1 || ret == 2)
 			break;
@@ -901,7 +899,8 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 				dev_info(&sm750_dev->pdev->dev,
 					 "find fbmode1 : %s\n", g_fbmode[1]);
 			} else {
-				dev_warn(&sm750_dev->pdev->dev, "How many view you wann set?\n");
+				dev_warn(&sm750_dev->pdev->dev,
+					 "How many view you wann set?\n");
 			}
 		}
 	}
@@ -1112,8 +1111,12 @@ static int __init lynxfb_setup(char *options)
 }
 
 static const struct pci_device_id smi_pci_table[] = {
-	{ PCI_DEVICE(0x126f, 0x0750), },
-	{0,}
+	{
+		PCI_DEVICE(0x126f, 0x0750),
+	},
+	{
+		0,
+	}
 };
 
 MODULE_DEVICE_TABLE(pci, smi_pci_table);
@@ -1121,11 +1124,11 @@ MODULE_DEVICE_TABLE(pci, smi_pci_table);
 static SIMPLE_DEV_PM_OPS(lynxfb_pm_ops, lynxfb_suspend, lynxfb_resume);
 
 static struct pci_driver lynxfb_driver = {
-	.name =		"sm750fb",
-	.id_table =	smi_pci_table,
-	.probe =	lynxfb_pci_probe,
-	.remove =	lynxfb_pci_remove,
-	.driver.pm =	&lynxfb_pm_ops,
+	.name = "sm750fb",
+	.id_table = smi_pci_table,
+	.probe = lynxfb_pci_probe,
+	.remove = lynxfb_pci_remove,
+	.driver.pm = &lynxfb_pm_ops,
 };
 
 static int __init lynxfb_init(void)
@@ -1155,15 +1158,15 @@ module_exit(lynxfb_exit);
 
 module_param(g_option, charp, 0444);
 
-MODULE_PARM_DESC(g_option,
-		 "\n\t\tCommon options:\n"
-		 "\t\tnoaccel:disable 2d capabilities\n"
-		 "\t\tnomtrr:disable MTRR attribute for video memory\n"
-		 "\t\tdualview:dual frame buffer feature enabled\n"
-		 "\t\tnohwc:disable hardware cursor\n"
-		 "\t\tUsual example:\n"
-		 "\t\tinsmod ./sm750fb.ko g_option=\"noaccel,nohwc,1280x1024-8@60\"\n"
-		 );
+MODULE_PARM_DESC(
+	g_option,
+	"\n\t\tCommon options:\n"
+	"\t\tnoaccel:disable 2d capabilities\n"
+	"\t\tnomtrr:disable MTRR attribute for video memory\n"
+	"\t\tdualview:dual frame buffer feature enabled\n"
+	"\t\tnohwc:disable hardware cursor\n"
+	"\t\tUsual example:\n"
+	"\t\tinsmod ./sm750fb.ko g_option=\"noaccel,nohwc,1280x1024-8@60\"\n");
 
 MODULE_AUTHOR("monk liu <monk.liu@siliconmotion.com>");
 MODULE_AUTHOR("Sudip Mukherjee <sudip@vectorindia.org>");
-- 
2.54.0


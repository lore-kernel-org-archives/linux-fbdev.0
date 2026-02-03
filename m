Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FDF318149
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Feb 2026 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160085; cv=none; b=hGMutUQXOzIRabsbG+uUcxB0qIu9EDX6VJPFtkTXjoy/oyY3z2sCwn0NQ4ZgECBVZPQFZz9vVpygClpUDHDYWNV4TWsKuS0p+rJRtKwOeSO4fAcHMKxgHjuMedMuyW/Bbc0zYPi820Aqfw8rrTsYXtTDv8ivYGNAaVAbhS05/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160085; c=relaxed/simple;
	bh=Q1gCHN5uMpL1kagbFEw8kJ6uVdoragbdUhNbpUA5drI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnQzLrbQyPzonSbrw19cnbEuhUCqJ4ETU4fX3uBCZGcHbsq7KG0Iu++mVXbMiWYC8lREznFZ9Ri0JeZs/o6RHNEBgFmdgg/wayEoQ6JJHDrCxWy7H/C8V8qHWCjydx8R9cVNCv5Reak/jzOkf0NRyEBZ40TY6VVkuts1Q9T01o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QP6LvIYP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP6LvIYP"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8838339fc6so73173566b.0
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Feb 2026 15:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770160081; x=1770764881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfZ9Nw2wtlKFsXjzIlw61ClheMahhPP/gw97ao8PzPg=;
        b=QP6LvIYPEkH+oQvDrcYHkArmHc1YycE+emNicW2jSaqANR4tT/th1V0u2xPLWeWMo/
         NHuyzylhHJX/+pzIkRtOGAZE5B3+LvlRj40u2hMfNQEyNYXrf3on1EFkbBiPFyxs7fn3
         ZuPMCVkLP7i9QHOe5ot2r6Bb+KTiqBuKi6rXzHBaRbfvuyf06tprlNZxc93Smn6gqSNV
         Jp0Ro75NxetFyX3i9lYYafIbwWerVqSijOHZ7kTNWl8+JJhD9HqVOIz7ewnzsLybjpmn
         pCgWZqUO8u8ysRG9CEESfJoYnEaWXJM6QWI5T1T1HMGtvzPF0NfeZV9dlJZ0xGcV8KPH
         u7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770160081; x=1770764881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jfZ9Nw2wtlKFsXjzIlw61ClheMahhPP/gw97ao8PzPg=;
        b=dJq1COqBhBpm5+vmg1T56fXox61Nklebgz/KSaGft5Gs+j0elYFCueks93cL/ndElC
         Zka6dRJRatvTEyZJYRevCkfw5jbZnRw6jP6hG7Opb2wO+CUNs31JHF3fh3Yt4GyFjmcr
         LkLr3ajO+pw5ssHwnVmJD6TqoZW0Ah9TfJ6He6AeGwmtSPWEKRK7vz7Md8Ov2ZHPurC4
         30GO7GajnZgM5L3jvKansghXEpbEAymcTum0L/6bOIHdJ4M+93Vnw79btriD8P6MVt7n
         QDG88BvxDDhCeK6uab6/rLUglz2C21KVBWLJ8/LKDwvdOrculc2Yh98WW47DRIQq33e6
         VnGA==
X-Gm-Message-State: AOJu0YxgdemsHNA1afXApvBl4vtxqRcsfQiZEr9A8mCQZT1JVVZ289VM
	A4rEOGbxKNHMD2+R0kDYGNhe3sb1kdftPmoudYw56MLPowvl36lLT0TvtM2pK8WejcglrZWq
X-Gm-Gg: AZuq6aJQzkYUp3xwRLa5Q/f2618G7cb9pr7OUxBlUlr4M5VRfMx4Pbz4p7qvTcDCde4
	JlMT8QkXuZRZGCgygQL9yM/TxQDM5nLPg6aTZRVpqrWZoIUtMfo/xi4Dd0iUOMlJRG1226n8YSC
	7Xmgn5C30Bbs0NtVwvw1SIDzjZOsl0I3TC3ETSltrlNPWHt/8WVrYvnGUzftyw6bGYyIuGvMV+y
	BTk7+8ak+ZKDmOIxpkROSr1+HzRpVsAgVbOtalxt7qvQaJJFCgqpmuzo52Hp4Y5CJiZZu+2W2P3
	QqAKHUJBidVLjuapW6zm5IuVG9jZTmnD8mG1uA/Z4rerJCaZfg9p9kjcvKrnL15y96aTQ/TiSit
	jT7boe3L0a3+NLLNjwSnQS9p2Sx+M1F4qq3TSi7SlEx14ThbrH2n1zxTqUpk3J6QRZVBn5URY/D
	cTGQYoS3LXilwjihr9IwG2co0b9d0hnjV1WGUpB9eDF291A+8YlXb7A1WochuTMI9DBRFALS+Oi
	DTXHCCE2I4S8YuVs2dJapwgLzE3mVmm0SaEApOiVF2LLoL62f2DhZJ8P7aaDjOJtE8+lA==
X-Received: by 2002:a17:907:3f0f:b0:b70:4f7d:24f8 with SMTP id a640c23a62f3a-b8e9fb17c81mr59649366b.22.1770160081124;
        Tue, 03 Feb 2026 15:08:01 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-b.c.od237066db22328bb-tp.internal (33.242.13.34.bc.googleusercontent.com. [34.13.242.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea0021b3bsm38486566b.49.2026.02.03.15.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 15:08:00 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH 3/4] staging: sm750fb: convert pr_* to dev_* logging in sm750.c
Date: Tue,  3 Feb 2026 23:07:57 +0000
Message-ID: <20260203230758.3056-3-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203230758.3056-1-iprintercanon@gmail.com>
References: <20260203230758.3056-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert pr_info/pr_err/pr_debug/pr_warn calls to their dev_*
equivalents in functions where device context is available via
info->device or par->dev->pdev->dev. This adds device identification
to log messages, improving debuggability in multi-device systems.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 107 ++++++++++++++++----------------
 1 file changed, 54 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index bd2d4a290..247c58556 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -375,7 +375,7 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	line_length = var->xres_virtual * var->bits_per_pixel / 8;
 	line_length = ALIGN(line_length, crtc->line_pad);
 	fix->line_length = line_length;
-	pr_info("fix->line_length = %d\n", fix->line_length);
+	dev_info(info->device, "fix->line_length = %d\n", fix->line_length);
 
 	/*
 	 * var->red,green,blue,transp are need to be set by driver
@@ -389,7 +389,8 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
 
 	if (ret) {
-		pr_err("bpp %d not supported\n", var->bits_per_pixel);
+		dev_err(info->device, "bpp %d not supported\n",
+			var->bits_per_pixel);
 		return ret;
 	}
 	ret = hw_sm750_crtc_set_mode(crtc, var, fix);
@@ -485,15 +486,16 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	par = info->par;
 	crtc = &par->crtc;
 
-	pr_debug("check var:%dx%d-%d\n",
-		 var->xres,
-		 var->yres,
-		 var->bits_per_pixel);
+	dev_dbg(info->device, "check var:%dx%d-%d\n",
+		var->xres,
+		var->yres,
+		var->bits_per_pixel);
 
 	ret = lynxfb_set_color_offsets(info);
 
 	if (ret) {
-		pr_err("bpp %d not supported\n", var->bits_per_pixel);
+		dev_err(info->device, "bpp %d not supported\n",
+			var->bits_per_pixel);
 		return ret;
 	}
 
@@ -508,7 +510,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	request = ALIGN(request, crtc->line_pad);
 	request = request * var->yres_virtual;
 	if (crtc->vidmem_size < request) {
-		pr_err("not enough video memory for mode\n");
+		dev_err(info->device, "not enough video memory for mode\n");
 		return -ENOMEM;
 	}
 
@@ -533,7 +535,7 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
 	ret = 0;
 
 	if (regno > 256) {
-		pr_err("regno = %d\n", regno);
+		dev_err(info->device, "regno = %d\n", regno);
 		return -EINVAL;
 	}
 
@@ -580,10 +582,10 @@ static int lynxfb_ops_blank(int blank, struct fb_info *info)
 	struct lynxfb_par *par;
 	struct lynxfb_output *output;
 
-	pr_debug("blank = %d.\n", blank);
 	par = info->par;
 	output = &par->output;
 	sm750_dev = par->dev;
+	dev_dbg(info->device, "blank = %d.\n", blank);
 
 	if (sm750_dev->revid == SM750LE_REVISION_ID)
 		return hw_sm750le_set_blank(output, blank);
@@ -625,7 +627,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		crtc->channel = sm750_primary;
 		crtc->o_screen = 0;
 		crtc->v_screen = sm750_dev->pvMem;
-		pr_info("use simul primary mode\n");
+		dev_info(&par->dev->pdev->dev, "use simul primary mode\n");
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
@@ -767,7 +769,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	crtc->cursor.mmio = sm750_dev->pvReg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
-	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
+	dev_info(info->device, "crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
 	crtc->cursor.max_h = 64;
 	crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
@@ -802,45 +804,42 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 				   pdb[i], cdb[i], NULL, 8);
 
 		if (ret == 1) {
-			pr_info("success! use specified mode:%s in %s\n",
-				g_fbmode[index],
-				mdb_desc[i]);
+			dev_info(info->device,
+				 "success! use specified mode:%s in %s\n",
+				 g_fbmode[index],
+				 mdb_desc[i]);
 			break;
 		} else if (ret == 2) {
-			pr_warn("use specified mode:%s in %s,with an ignored refresh rate\n",
-				g_fbmode[index],
-				mdb_desc[i]);
+			dev_warn(info->device,
+				 "use specified mode:%s in %s,with an ignored refresh rate\n",
+				 g_fbmode[index],
+				 mdb_desc[i]);
 			break;
 		} else if (ret == 3) {
-			pr_warn("wanna use default mode\n");
+			dev_warn(info->device, "wanna use default mode\n");
 			/*break;*/
 		} else if (ret == 4) {
-			pr_warn("fall back to any valid mode\n");
+			dev_warn(info->device,
+				 "fall back to any valid mode\n");
 		} else {
-			pr_warn("ret = %d,fb_find_mode failed,with %s\n",
-				ret,
-				mdb_desc[i]);
+			dev_warn(info->device,
+				 "ret = %d,fb_find_mode failed,with %s\n",
+				 ret,
+				 mdb_desc[i]);
 		}
 	}
 
 	/* some member of info->var had been set by fb_find_mode */
 
-	pr_info("Member of info->var is :\n"
-		"xres=%d\n"
-		"yres=%d\n"
-		"xres_virtual=%d\n"
-		"yres_virtual=%d\n"
-		"xoffset=%d\n"
-		"yoffset=%d\n"
-		"bits_per_pixel=%d\n"
-		" ...\n",
-		var->xres,
-		var->yres,
-		var->xres_virtual,
-		var->yres_virtual,
-		var->xoffset,
-		var->yoffset,
-		var->bits_per_pixel);
+	dev_info(info->device,
+		 "Member of info->var is :\nxres=%d\nyres=%d\nxres_virtual=%d\nyres_virtual=%d\nxoffset=%d\nyoffset=%d\nbits_per_pixel=%d\n ...\n",
+		 var->xres,
+		 var->yres,
+		 var->xres_virtual,
+		 var->yres_virtual,
+		 var->xoffset,
+		 var->yoffset,
+		 var->bits_per_pixel);
 
 	/* set par */
 	par->info = info;
@@ -851,7 +850,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 	info->pseudo_palette = &par->pseudo_palette[0];
 	info->screen_base = crtc->v_screen;
-	pr_debug("screen_base vaddr = %p\n", info->screen_base);
+	dev_dbg(info->device, "screen_base vaddr = %p\n", info->screen_base);
 	info->screen_size = line_length * var->yres_virtual;
 
 	/* set info->fix */
@@ -865,7 +864,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	strscpy(fix->id, fixId[index], sizeof(fix->id));
 
 	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
-	pr_info("fix->smem_start = %lx\n", fix->smem_start);
+	dev_info(info->device, "fix->smem_start = %lx\n", fix->smem_start);
 	/*
 	 * according to mmap experiment from user space application,
 	 * fix->mmio_len should not larger than virtual size
@@ -874,13 +873,13 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * data into the bound over virtual size
 	 */
 	fix->smem_len = crtc->vidmem_size;
-	pr_info("fix->smem_len = %x\n", fix->smem_len);
+	dev_info(info->device, "fix->smem_len = %x\n", fix->smem_len);
 	info->screen_size = fix->smem_len;
 	fix->line_length = line_length;
 	fix->mmio_start = sm750_dev->vidreg_start;
-	pr_info("fix->mmio_start = %lx\n", fix->mmio_start);
+	dev_info(info->device, "fix->mmio_start = %lx\n", fix->mmio_start);
 	fix->mmio_len = sm750_dev->vidreg_size;
-	pr_info("fix->mmio_len = %x\n", fix->mmio_len);
+	dev_info(info->device, "fix->mmio_len = %x\n", fix->mmio_len);
 
 	lynxfb_set_visual_mode(info);
 
@@ -889,21 +888,23 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	var->accel_flags = 0;
 	var->vmode = FB_VMODE_NONINTERLACED;
 
-	pr_debug("#1 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
-		 info->cmap.start, info->cmap.len,
-		 info->cmap.red, info->cmap.green, info->cmap.blue,
-		 info->cmap.transp);
+	dev_dbg(info->device,
+		"#1 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
+		info->cmap.start, info->cmap.len,
+		info->cmap.red, info->cmap.green, info->cmap.blue,
+		info->cmap.transp);
 
 	ret = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (ret < 0) {
-		pr_err("Could not allocate memory for cmap.\n");
+		dev_err(info->device, "Could not allocate memory for cmap.\n");
 		goto exit;
 	}
 
-	pr_debug("#2 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
-		 info->cmap.start, info->cmap.len,
-		 info->cmap.red, info->cmap.green, info->cmap.blue,
-		 info->cmap.transp);
+	dev_dbg(info->device,
+		"#2 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
+		info->cmap.start, info->cmap.len,
+		info->cmap.red, info->cmap.green, info->cmap.blue,
+		info->cmap.transp);
 
 exit:
 	lynxfb_ops_check_var(var, info);
-- 
2.43.0


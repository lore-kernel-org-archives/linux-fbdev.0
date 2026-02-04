Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40D83D7D90
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200141; cv=none; b=nhoDbnLlom0DXOSCicg2vp+PN9KK8PcA7dx/HJLFGcRS2/LwcXbuFZIssL7clRkQLLp3MtgHT4friBvSSh1JO54ZFY+aHpaRp+aGLXW2v12n3T3I1d6ES1oBowYye8E2dXcQyxBmisYA63N/NkoCfJ++PAUHMNXXQ4G3mr7f4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200141; c=relaxed/simple;
	bh=0P+5vyVwVEV1GTQtvTLQ9ThuV7pwIJEYlEb7rAcqykY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qb+f5Pdhg/bQCH8gtjlDW98M+eOJxOTncvPXg3weVIryEJKYdF9Xtyalq2QuJA9d7auCU5Kx/Z1rtqXkjdu3FS0T5sPUaNc/yHWtfajiOF5NYQNoEy/NNT2uhEd3P53IzrUT2jOA5H0mO/KlDR/jpiDktW0KHsCETa0atRmYAic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRXJMmVF; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRXJMmVF"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8860d6251bso1011127266b.3
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 02:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770200139; x=1770804939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHlcDVwaqbGX9I5MXRFFi/8Xi9moTxugqVHCrZzW0fc=;
        b=HRXJMmVFf0PwuBiw/Op/jBRQoQawtqRdu/cCEt0keJODTzUtwrr0DES3SFm4v9jCVj
         3oR2uO/FOq3laBY6u/1qBD/LKo1nzJzIdx4Saj8rrNFQVoR57aA6niFI9tFYr5djmJFo
         CcUsznj+m9YmTB3/6jhlVD7KMHF6+yrrvCTDs/UUVKultebBt2H3bMDq3qNgU9GXYBAx
         R2Zzf+iQL+S+qE8Wh2edm3DzyV+j7CpwfTZalLccyTFB2CW5KV2Qei4WH4R6NP2xJF4S
         GeLSKAAHFY96dzqwBPgLMFtBgBHHR0b01PtBWmxsAh4vvSlIv4NaAS5lRgJtqhoBOcoy
         ToXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770200139; x=1770804939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHlcDVwaqbGX9I5MXRFFi/8Xi9moTxugqVHCrZzW0fc=;
        b=FxqYdD6DAoJ5apx6p9sOWB9GUBGbkezWIlUQMTgOPdhGWV0187kzb/itpvcPwvbh78
         65tljHyjuRX2pTkWdvFictjGhKumuRm9y6xAIkovDWExVJQ2OYwl8HU9JTB7883dNvhN
         8+SReCsTk0Yv2GzuXpU20Bfrmu7WQZOzWiSBqkaVkAt7K3m5FAC9KnTFmDbayKSrbQx0
         lHtZ8UaX4a0LJ7rWxuGJ1/D8L3t7Tr4D96CasidiomE3heEMUDrXZ3vcJ3NcpWNWvjHq
         9kf64pFvcdwK6Bbb8BKodyKcKqarWRjmm20ll3Nv0fxpMb4zsIoD3FGrcOcqTQAX9ibh
         /FGw==
X-Gm-Message-State: AOJu0YxjgAkuCXQr15B5I551ZblI0FkfZu6n4SsZZjEsRwzTC9n9IAcR
	c1xGB6nxndKsjsWwkVLzynbRhQll1qvOXfGPR4rRPmeTFnxpVAoMTbtU
X-Gm-Gg: AZuq6aLGrosGTYr7+JyAOOr/iXBJ3iJD8NtKQ7cUhiQ9/wG/w5EUIJFgioPtoTgxoJK
	E/4m8lFyCg92XxOIMxpZ9uWXnug9dlYmzcfgI7kfP2PfYNSjqpLpGvMG9ENf/Q+3QbEMNNvNmkJ
	7QRrYSwfeedtmA9EycZKWxvadYrZimuuhrm9FT9c6qJ3JJalKHeXHs7slwBK/zfNn33mN4sfxvC
	wzMDVqEamVKfe0oPQxTCuYLA0/O2ppOvw/KE5TxzREzDKkBkLjjAluG4JmDCGTrHVby3Uxpg54+
	45OL4hgwrjcxqRW/vQvH2QVDrt1NNjQkfsb9U4zADCQ3iFPk+e4K4UZ9/zsujuTvtGpNP3mqCEj
	trAa0eZZQTryVR9MmxOoAYIK8ouyR2G6YdpLPz/lmxWy61lBaIEspDFTSkcqXqMLeFeJVG1TKCO
	RS2UyG4C6jeV52GKIgK76p4FFNHB5WG6fEK2TkEfAFyUDiN30rjf4h/4NbyT52jCeqfd93VUjhM
	uihW9tqskF1L4A/oAz6XqDdvFlXyCl3hnLU19MdpN5C8cShzB220vKtUZFfbQ==
X-Received: by 2002:a17:907:3d8c:b0:b87:2780:1b2d with SMTP id a640c23a62f3a-b8e9f6634f6mr179140366b.56.1770200138896;
        Wed, 04 Feb 2026 02:15:38 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-b.c.od237066db22328bb-tp.internal (181.183.90.34.bc.googleusercontent.com. [34.90.183.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fef0e17sm106440366b.33.2026.02.04.02.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 02:15:38 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH v2 3/4] staging: sm750fb: remove debug prints and convert logging in sm750.c
Date: Wed,  4 Feb 2026 10:15:35 +0000
Message-ID: <20260204101536.3311-3-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204101536.3311-1-iprintercanon@gmail.com>
References: <20260204101536.3311-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove debug prints disguised as pr_info that dump internal variable
values, pointer addresses, and structure contents. Convert remaining
meaningful pr_err and pr_warn calls to dev_err and dev_warn where
device context is available.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 85 ++++++++-------------------------
 1 file changed, 20 insertions(+), 65 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 73d78f893..1feb97bee 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -375,7 +375,6 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	line_length = var->xres_virtual * var->bits_per_pixel / 8;
 	line_length = ALIGN(line_length, crtc->line_pad);
 	fix->line_length = line_length;
-	pr_info("fix->line_length = %d\n", fix->line_length);
 
 	/*
 	 * var->red,green,blue,transp are need to be set by driver
@@ -389,7 +388,8 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
 
 	if (ret) {
-		pr_err("bpp %d not supported\n", var->bits_per_pixel);
+		dev_err(info->device, "bpp %d not supported\n",
+			var->bits_per_pixel);
 		return ret;
 	}
 	ret = hw_sm750_crtc_set_mode(crtc, var, fix);
@@ -485,15 +485,11 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	par = info->par;
 	crtc = &par->crtc;
 
-	pr_debug("check var:%dx%d-%d\n",
-		 var->xres,
-		 var->yres,
-		 var->bits_per_pixel);
-
 	ret = lynxfb_set_color_offsets(info);
 
 	if (ret) {
-		pr_err("bpp %d not supported\n", var->bits_per_pixel);
+		dev_err(info->device, "bpp %d not supported\n",
+			var->bits_per_pixel);
 		return ret;
 	}
 
@@ -508,7 +504,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	request = ALIGN(request, crtc->line_pad);
 	request = request * var->yres_virtual;
 	if (crtc->vidmem_size < request) {
-		pr_err("not enough video memory for mode\n");
+		dev_err(info->device, "not enough video memory for mode\n");
 		return -ENOMEM;
 	}
 
@@ -533,7 +529,7 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
 	ret = 0;
 
 	if (regno > 256) {
-		pr_err("regno = %d\n", regno);
+		dev_err(info->device, "regno = %d\n", regno);
 		return -EINVAL;
 	}
 
@@ -580,7 +576,6 @@ static int lynxfb_ops_blank(int blank, struct fb_info *info)
 	struct lynxfb_par *par;
 	struct lynxfb_output *output;
 
-	pr_debug("blank = %d.\n", blank);
 	par = info->par;
 	output = &par->output;
 	sm750_dev = par->dev;
@@ -625,7 +620,6 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		crtc->channel = sm750_primary;
 		crtc->o_screen = 0;
 		crtc->v_screen = sm750_dev->pvMem;
-		pr_info("use simul primary mode\n");
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
@@ -767,7 +761,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	crtc->cursor.mmio = sm750_dev->pvReg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
-	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
 	crtc->cursor.max_h = 64;
 	crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
@@ -802,46 +795,26 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 				   pdb[i], cdb[i], NULL, 8);
 
 		if (ret == 1) {
-			pr_info("success! use specified mode:%s in %s\n",
-				g_fbmode[index],
-				mdb_desc[i]);
+			dev_info(info->device,
+				 "use specified mode:%s in %s\n",
+				 g_fbmode[index],
+				 mdb_desc[i]);
 			break;
 		} else if (ret == 2) {
-			pr_warn("use specified mode:%s in %s,with an ignored refresh rate\n",
-				g_fbmode[index],
-				mdb_desc[i]);
+			dev_warn(info->device,
+				 "use specified mode:%s in %s, with an ignored refresh rate\n",
+				 g_fbmode[index],
+				 mdb_desc[i]);
 			break;
-		} else if (ret == 3) {
-			pr_warn("wanna use default mode\n");
-			/*break;*/
-		} else if (ret == 4) {
-			pr_warn("fall back to any valid mode\n");
+		} else if (ret == 3 || ret == 4) {
+			continue;
 		} else {
-			pr_warn("ret = %d,fb_find_mode failed,with %s\n",
-				ret,
-				mdb_desc[i]);
+			dev_warn(info->device,
+				 "fb_find_mode failed with %s (ret=%d)\n",
+				 mdb_desc[i], ret);
 		}
 	}
 
-	/* some member of info->var had been set by fb_find_mode */
-
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
-
 	/* set par */
 	par->info = info;
 
@@ -851,7 +824,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 	info->pseudo_palette = &par->pseudo_palette[0];
 	info->screen_base = crtc->v_screen;
-	pr_debug("screen_base vaddr = %p\n", info->screen_base);
 	info->screen_size = line_length * var->yres_virtual;
 
 	/* set info->fix */
@@ -865,7 +837,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	strscpy(fix->id, fixId[index], sizeof(fix->id));
 
 	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
-	pr_info("fix->smem_start = %lx\n", fix->smem_start);
 	/*
 	 * according to mmap experiment from user space application,
 	 * fix->mmio_len should not larger than virtual size
@@ -874,13 +845,10 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * data into the bound over virtual size
 	 */
 	fix->smem_len = crtc->vidmem_size;
-	pr_info("fix->smem_len = %x\n", fix->smem_len);
 	info->screen_size = fix->smem_len;
 	fix->line_length = line_length;
 	fix->mmio_start = sm750_dev->vidreg_start;
-	pr_info("fix->mmio_start = %lx\n", fix->mmio_start);
 	fix->mmio_len = sm750_dev->vidreg_size;
-	pr_info("fix->mmio_len = %x\n", fix->mmio_len);
 
 	lynxfb_set_visual_mode(info);
 
@@ -889,22 +857,12 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	var->accel_flags = 0;
 	var->vmode = FB_VMODE_NONINTERLACED;
 
-	pr_debug("#1 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
-		 info->cmap.start, info->cmap.len,
-		 info->cmap.red, info->cmap.green, info->cmap.blue,
-		 info->cmap.transp);
-
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
-
 exit:
 	lynxfb_ops_check_var(var, info);
 	return ret;
@@ -934,9 +892,6 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	}
 
 	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
-		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
-		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
-
 		if (!strcmp(opt, "swap")) {
 			swap = 1;
 		} else if (!strcmp(opt, "nocrt")) {
-- 
2.43.0


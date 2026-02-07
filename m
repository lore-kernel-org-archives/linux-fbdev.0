Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7361D305045
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Feb 2026 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770478627; cv=none; b=lyoHn+x9xnnWX1BA5eiqhxYJa10Vpmo6efFkUegzAxdBVDhmXuIyhQTYerJ8NKYWzvCMDTNs/r9lKIMYKLCyo/sSVjT+jfNsjnnPNiYsZMZ1Pn5dpYT1mnsK88JU6RmOuHRVIJ25gVewGZ0TCiW/6Co+zTxiNJe6ncKyoMa8nqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770478627; c=relaxed/simple;
	bh=mmsOF+8mCTmv4usEVa5LGRU6vlMDYRpG+4LhjzRz1oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MF2A17jaVlkHYV4jr4xCO1VN7g6i6fMKL2+xna1eVV4lBxdxtvUB3AgDvjn3LTsX+4vdEgCut9X/a+3P8f9140MrI5JhlQJGxYB35eiu2cPJELFGv7ZzZmgHCrtUBaZK7DIc5g75oG40TRG4P/CpmG7wU2UNHLsLSM7OsYLVFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAdw1hlg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAdw1hlg"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65939428896so4577994a12.1
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Feb 2026 07:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770478626; x=1771083426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1H7/AHvvBIzcS+9ZNqDlojVn7lEdnc7V72Tg1pliomM=;
        b=VAdw1hlgGdBkxyYXwhLkJ9EDvLnlCoOxMrLtCZhCiuyVCjnDMSQZgg0fJIDuEAlHPL
         dVd4GdunfEVvXSRLs6AEgO6h8IoTX0szuYXl7OzqkBohDAxvS4+NRouEO36TmvdPIowu
         GeLU/U8lu7QzP3gIR6ag9h0GYRmhSkTqnKhpjZfqxHB5KzuMh88EmK3M5fcP2Zdj5ZMc
         fndJlveDxIoYp/m3/AudZEJ6EIAGyLs+ONE5qdJmiLvINKNpgNG8gweTkUWPX002qIzb
         tJUCThiKwUrll0P6mA1JjuOUblKOM5dXd+qIdeeQfbj+h1Fsb87bmwYZ3jQ+5cLWZXSR
         rBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770478626; x=1771083426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1H7/AHvvBIzcS+9ZNqDlojVn7lEdnc7V72Tg1pliomM=;
        b=Ov7rqWUmYiCNwZ36vNlr9ZS8lR1FI0EVPPy2EhgzwHgBBaQ3ChEkJlcmRxconaVNN8
         /7/xDbmI5EHxplark3Zhunzt/5kiZvPxWtTX2TaZyoosK8XssMnRsTLLdorpdIXzhpRk
         uW/zkKs7nsxBEfKamuEKycc/4Mf+QAnYr657AtRNcTR5w5ipaHKHVQZurrkCItxSkoTV
         ULf8N95A+jpbxlHap70uGMbGJil5LNPOQxiyITpR9S2flrXJFOIuao0YiLUqb3uh4OwK
         Ub0OlJbwxJGNB2KXpWbWd/qFdCy5Wm6dSRdrEQ/rHtNGnSMiNuIWkRmp4DknhnAfrDDr
         VHBw==
X-Gm-Message-State: AOJu0YxukxyGzflHmwcU0fbMGT13WsBnt2BYorgFQdRRrrKgs6KzWw16
	QV+JLpUTimWAvpeblT9CskSL1COH6R8LRMYs/oDWs/8PFEn6Ba8N1Axh
X-Gm-Gg: AZuq6aIxe+9sUiArQFwgYDucF1s6n3x8obq3jQ6w2f6/ATcIsKgN0vteE5IVzp6CBJ0
	RVenJjvoT0oT2tEfdtVGb9QNnRwfR7s83BTggkFDUoDd6+uByGCUfLiRC6MrzpecvAxv9dIavM6
	V9TO2tzuB8c+P5LlbDvEHTl2kTl8kp84NQ4qNgHsJsLKRMW2YKI5ZUB/Th3lReE4jfWhm4FeyFD
	Ub8Bkuza1iJg/chUrq4cnv1cLPKFTgf/KLfk61WpybfA1VCOIRi1rLO5TlNFzQEbUjYIivZV0wR
	FfvoEontvCQnozpJDSfUZl0YmwZOhwkro3laACtkszLve+DYPd1LMolxEm2HQOWQfUE1LufoMZA
	LvmIAp6UW689je6yy9dzyEl5+7WWmTUH0CtluMJ0/cQPic5YLAoOki8kvIm2wnwk8HPLLJHjlNq
	CWTC0/0TD3b6gLGodg9xt/L7yhdhX2KrM854hUAzeKuSliLrhoPAa/b/xPpvMz2Kg7EfsgJ0BWr
	jnwAi8b7hS2fSdffhrtLQQbXefLc0Y0lpXpHeC9IavcHHVbxV7ztIlrG4anT46s
X-Received: by 2002:a17:907:9717:b0:b87:2c3d:ef08 with SMTP id a640c23a62f3a-b8edf2feb09mr390835566b.33.1770478625495;
        Sat, 07 Feb 2026 07:37:05 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.od237066db22328bb-tp.internal (170.249.141.34.bc.googleusercontent.com. [34.141.249.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda748aa6sm181308666b.1.2026.02.07.07.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 07:37:04 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH v4 1/3] staging: sm750fb: remove debug and diagnostic prints
Date: Sat,  7 Feb 2026 15:37:01 +0000
Message-ID: <20260207153703.2049-2-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260207153703.2049-1-iprintercanon@gmail.com>
References: <20260207153703.2049-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove all pr_info, pr_debug, and pr_warn calls that dump internal
variable values, pointer addresses, and structure contents not useful
for production use. This includes the complete fb_find_mode() result
logging in lynxfb_set_fbinfo(), the CH7301 DVI chip status messages
in hw_sm750_inithw(), and various debug prints throughout the driver.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 76 +-----------------------------
 drivers/staging/sm750fb/sm750_hw.c | 18 +------
 2 files changed, 3 insertions(+), 91 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fecd7457e..987ba8772 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -375,7 +375,6 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	line_length = var->xres_virtual * var->bits_per_pixel / 8;
 	line_length = ALIGN(line_length, crtc->line_pad);
 	fix->line_length = line_length;
-	pr_info("fix->line_length = %d\n", fix->line_length);
 
 	/*
 	 * var->red,green,blue,transp are need to be set by driver
@@ -485,11 +484,6 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	par = info->par;
 	crtc = &par->crtc;
 
-	pr_debug("check var:%dx%d-%d\n",
-		 var->xres,
-		 var->yres,
-		 var->bits_per_pixel);
-
 	ret = lynxfb_set_color_offsets(info);
 
 	if (ret) {
@@ -580,7 +574,6 @@ static int lynxfb_ops_blank(int blank, struct fb_info *info)
 	struct lynxfb_par *par;
 	struct lynxfb_output *output;
 
-	pr_debug("blank = %d.\n", blank);
 	par = info->par;
 	output = &par->output;
 	sm750_dev = par->dev;
@@ -625,7 +618,6 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		crtc->channel = sm750_primary;
 		crtc->o_screen = 0;
 		crtc->v_screen = sm750_dev->pvMem;
-		pr_info("use simul primary mode\n");
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
@@ -734,12 +726,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		lynx750_ext, NULL, vesa_modes,
 	};
 	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
-	static const char * const mdb_desc[] = {
-		"driver prepared modes",
-		"kernel prepared default modedb",
-		"kernel HELPERS prepared vesa_modes",
-	};
-
 	static const char *fixId[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
@@ -767,7 +753,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	crtc->cursor.mmio = sm750_dev->pvReg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
-	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
 	crtc->cursor.max_h = 64;
 	crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
@@ -801,47 +786,10 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		ret = fb_find_mode(var, info, g_fbmode[index],
 				   pdb[i], cdb[i], NULL, 8);
 
-		if (ret == 1) {
-			pr_info("success! use specified mode:%s in %s\n",
-				g_fbmode[index],
-				mdb_desc[i]);
+		if (ret == 1 || ret == 2)
 			break;
-		} else if (ret == 2) {
-			pr_warn("use specified mode:%s in %s,with an ignored refresh rate\n",
-				g_fbmode[index],
-				mdb_desc[i]);
-			break;
-		} else if (ret == 3) {
-			pr_warn("wanna use default mode\n");
-			/*break;*/
-		} else if (ret == 4) {
-			pr_warn("fall back to any valid mode\n");
-		} else {
-			pr_warn("ret = %d,fb_find_mode failed,with %s\n",
-				ret,
-				mdb_desc[i]);
-		}
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
 
@@ -851,7 +799,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 	info->pseudo_palette = &par->pseudo_palette[0];
 	info->screen_base = crtc->v_screen;
-	pr_debug("screen_base vaddr = %p\n", info->screen_base);
 	info->screen_size = line_length * var->yres_virtual;
 
 	/* set info->fix */
@@ -865,7 +812,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	strscpy(fix->id, fixId[index], sizeof(fix->id));
 
 	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
-	pr_info("fix->smem_start = %lx\n", fix->smem_start);
 	/*
 	 * according to mmap experiment from user space application,
 	 * fix->mmio_len should not larger than virtual size
@@ -874,13 +820,10 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
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
 
@@ -889,22 +832,12 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	var->accel_flags = 0;
 	var->vmode = FB_VMODE_NONINTERLACED;
 
-	pr_debug("#1 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
-		 info->cmap.start, info->cmap.len,
-		 info->cmap.red, info->cmap.green, info->cmap.blue,
-		 info->cmap.transp);
-
 	ret = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (ret < 0) {
 		pr_err("Could not allocate memory for cmap.\n");
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
@@ -1131,12 +1064,8 @@ static int __init lynxfb_setup(char *options)
 	int len;
 	char *opt, *tmp;
 
-	if (!options || !*options) {
-		pr_warn("no options.\n");
+	if (!options || !*options)
 		return 0;
-	}
-
-	pr_info("options:%s\n", options);
 
 	len = strlen(options) + 1;
 	g_settings = kzalloc(len, GFP_KERNEL);
@@ -1173,7 +1102,6 @@ static int __init lynxfb_setup(char *options)
 	}
 
 	/* misc g_settings are transport to chip specific routines */
-	pr_info("parameter left for chip specific analysis:%s\n", g_settings);
 	return 0;
 }
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index ce46f240c..983b51164 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -34,8 +34,6 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	sm750_dev->vidreg_start = pci_resource_start(pdev, 1);
 	sm750_dev->vidreg_size = SZ_2M;
 
-	pr_info("mmio phyAddr = %lx\n", sm750_dev->vidreg_start);
-
 	/*
 	 * reserve the vidreg space of smi adaptor
 	 * if you do this, you need to add release region code
@@ -56,7 +54,6 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
 
 	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
 	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
@@ -72,8 +69,6 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	 * @ddk750_get_vm_size function can be safe.
 	 */
 	sm750_dev->vidmem_size = ddk750_get_vm_size();
-	pr_info("video memory phyAddr = %lx, size = %u bytes\n",
-		sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 
 	/* reserve the vidmem space of smi adaptor */
 	sm750_dev->pvMem =
@@ -84,7 +79,6 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("video memory vaddr = %p\n", sm750_dev->pvMem);
 exit:
 	return ret;
 }
@@ -163,11 +157,9 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 			 * The following register values for CH7301 are from
 			 * Chrontel app note and our experiment.
 			 */
-			pr_info("yes,CH7301 DVI chip found\n");
 			sm750_sw_i2c_write_reg(0xec, 0x1d, 0x16);
 			sm750_sw_i2c_write_reg(0xec, 0x21, 0x9);
 			sm750_sw_i2c_write_reg(0xec, 0x49, 0xC0);
-			pr_info("okay,CH7301 DVI chip setup done\n");
 		}
 	}
 
@@ -192,14 +184,12 @@ int hw_sm750_output_set_mode(struct lynxfb_output *output,
 
 	if (sm750_get_chip_type() != SM750LE) {
 		if (channel == sm750_primary) {
-			pr_info("primary channel\n");
 			if (output->paths & sm750_panel)
 				disp_set |= do_LCD1_PRI;
 			if (output->paths & sm750_crt)
 				disp_set |= do_CRT_PRI;
 
 		} else {
-			pr_info("secondary channel\n");
 			if (output->paths & sm750_panel)
 				disp_set |= do_LCD1_SEC;
 			if (output->paths & sm750_crt)
@@ -215,7 +205,6 @@ int hw_sm750_output_set_mode(struct lynxfb_output *output,
 		poke32(DISPLAY_CONTROL_750LE, reg);
 	}
 
-	pr_info("ddk setlogicdispout done\n");
 	return ret;
 }
 
@@ -232,10 +221,8 @@ int hw_sm750_crtc_check_mode(struct lynxfb_crtc *crtc,
 	case 16:
 		break;
 	case 32:
-		if (sm750_dev->revid == SM750LE_REVISION_ID) {
-			pr_debug("750le do not support 32bpp\n");
+		if (sm750_dev->revid == SM750LE_REVISION_ID)
 			return -EINVAL;
-		}
 		break;
 	default:
 		return -EINVAL;
@@ -302,7 +289,6 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 	else
 		clock = SECONDARY_PLL;
 
-	pr_debug("Request pixel clock = %lu\n", modparm.pixel_clock);
 	ret = ddk750_set_mode_timing(&modparm, clock);
 	if (ret) {
 		pr_err("Set mode timing failed\n");
@@ -431,12 +417,10 @@ int hw_sm750_set_blank(struct lynxfb_output *output, int blank)
 
 	switch (blank) {
 	case FB_BLANK_UNBLANK:
-		pr_debug("flag = FB_BLANK_UNBLANK\n");
 		dpms = SYSTEM_CTRL_DPMS_VPHP;
 		pps = PANEL_DISPLAY_CTRL_DATA;
 		break;
 	case FB_BLANK_NORMAL:
-		pr_debug("flag = FB_BLANK_NORMAL\n");
 		dpms = SYSTEM_CTRL_DPMS_VPHP;
 		crtdb = CRT_DISPLAY_CTRL_BLANK;
 		break;
-- 
2.43.0


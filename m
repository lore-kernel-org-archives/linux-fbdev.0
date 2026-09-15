Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20F3B6343
	for <linux-fbdev@vger.kernel.org>; Tue, 15 Sep 2026 05:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449649; cv=none; b=NgiqQK+BEcOv+LvXrheSWck0C1urnSC0aR+m6tOOA/M2c4NqKknzLkHOH31e2MOjrtCzC+KhrbAwSVK8VlEn59svOHogtJLGeVIn9Yk2rS7j4ZbTbrWO9oJO4guR0or0PexlBy4ehDnX4pwBgJY+ytVtmx3AhLw/uHx/HZ6M6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449649; c=relaxed/simple;
	bh=wszpl89rhMLihceAchczV2W1Iq1tua5BAIUCiIaRKHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KxWja74QuJVpaalp1YcAR3lHg75wqVoX3yyx6TYZy43j9KfwZAPv4bOqVHIPNQ+ix4R0XrozgMLVbRV+jOuMAI+BidlSdRGFSaxbPrDHzRHVDdopxVWbOmTajbjHebZ97IzYBBPP/0XPAltV/hBXyvO0SniJafxLjGAK+7rGSuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZjrdzsd; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZjrdzsd"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso2761897a91.1
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 22:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789449647; x=1790054447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rSU4R22SESbjjX3cQkBbS8lUy6Q/T1lRNgl0UnLZD5I=;
        b=DZjrdzsd+iI+UE9FH4/gWmyrpboGJU1A0h+wr28qHEbHr99bwB8WUR7sceBYuTKc1O
         7zuJqrGZPaqfUVqv0+OQ4ZL35pNbqzTQ8GtNFTp3B0tIHTvFy+qiMo2Lr0SgTiC9PV5e
         gQ3Zxx6omYQ5XyLLE87iZ6O9vNA0EHA6NU5+CevxC7vbxp7Q0RyxgwhJDUH5nazJf1/9
         BjrS/hinrPp4lkcoadpAavgxXSnU7e2ufFqrptXEaVJc7oJnf/m5wfOHV4buwopMgCQy
         GzyL469fU+rUjT1mwcf04AwAPhVuVt2Ykn790PmtgGuTrKggx+oFUzEuweGs8/1+V+PM
         8uIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789449647; x=1790054447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rSU4R22SESbjjX3cQkBbS8lUy6Q/T1lRNgl0UnLZD5I=;
        b=0LuTNV8JaxhRhVAlxtDmnNVtS/BA03nZEzZ/D9zVsYbXpJjrlzhf1SWVI8eXlNEy9Q
         HyR5sKfhtPBkMzSPNZj8e0gLGvaOtj3548VE8P72tvzSNBi03IgVDYZgMCKRYK8nDTRx
         Vt5l4dLKeqE5ogqMtIKVjR9fK14x6NBAynuOq2c+llzhCQMYNWS7Lf00wKCc1TjDUddh
         EUaRIkHa0L2zsfL6pQGlssDG3WbUlT8F/nuAC9wcowcX09qaSe4+LaWQsVUcGof/slkE
         D1oM/4/3e5fJ7iCSSMjkKP824yPXTFWtxIYIDwXecQhtJ4vKtlxVvtYkXq6iReYsBObs
         HaBA==
X-Forwarded-Encrypted: i=1; AKwUvBx+8LKseUrt/nWL62a+dR0hrQ11jPEo91klNR9jDQyZsR198QHrmotUh6a7Mh9PhUR7cAawWbOoe8+Lqg==@vger.kernel.org
X-Gm-Message-State: AFuF++kEJ4HWJP3/VfNR3yWdFWuXHbcNTlGi2hBT4la6I+5OQej5pOFI
	TQgUCjkIKwQjQDhhh+kpES7H4pTMvmN7/a1Lcwh5qFGxpW2MOGpHOXTh
X-Gm-Gg: AYBFou1ifSGOWS/8FwhzCSR2g5yOYafYidIF9PLHnVb24bigBoorm387MZjF6ZUBAYm
	oqJ3Vf9HXmsXfs9uKXByvUlRGAW8F6DklkPhEK4jSoNrtOmo474K7A81nEHW7ea3pEobTTBLwvH
	c1hXE2hQ/fIKPdMu8kNaQDF4LUTdIdz8byOeHPNptVk7yG0pyLnlxbOZud9PyHmiUvovP1HaIvI
	+d2iZiXX5Jq6YRp1eXT9b1/dApPAajiwQmecd4gbUB1hZVmCs+syDp7qsRPFMPANREmwqXjBM9R
	5563lny9GapAT7cMWi6ydXQgwS7+Yg/HdUQmGphaawlG6v4SvJZZGX4+xncqEvTEj+obtG0VP1e
	KnFQljxf4Gly3A3mhnRz+nAW0zikIUzBt11kWaP8GzNSBdejdKLW+rX1veUnR7aSkypZBnpYGJi
	i057slbcDcd6t8OzgCTj5yDKsVajnGhnLaAPPvCD1pxafOf5YPf+kShoP1bv4GG0/v47Cybm4mi
	tauub9tU+1cgb6bQX3YzfHeK7MqRPkcUV8i5XOYNmKn+PBkV2oiAcDDfKB+Egxa06ak25UND1Zp
	Rh4ils1ounp814Y49p6Jr6kR378GsAFrh6Y0eNsBfsnWoftp1VhK5w5d+KZtkI6Lug==
X-Received: by 2002:a05:6a20:1609:b0:3d3:afd9:6040 with SMTP id adf61e73a8af0-3db40746ea8mr13353608637.27.1789449646922;
        Mon, 14 Sep 2026 22:20:46 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f7390csm30258521eec.26.2026.09.14.22.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:20:46 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	Alex Guo <alexguo1023@gmail.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH] video: acornfb: remove unused code for 26-bit hardware
Date: Mon, 14 Sep 2026 22:20:29 -0700
Message-ID: <20260915052038.626258-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The acornfb driver contains code to support machines with a MEMC chip
and without IOMD and VIDC20 chips. All 32-bit Acorn hardware has IOMD
and VIDC20 chips and does not have a MEMC chip.

Linux formerly supported 26-bit Acorn computers, but that support was
removed in commit 99eb8a550dbc ("Remove the arm26 port") because it had
bitrotted to the extent that it did not even compile.

Remove this unused code. Also take the opportunity to remove incorrect
file paths in the file headers, which are bad style regardless.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/video/fbdev/acornfb.c | 57 +++++++++--------------------------
 drivers/video/fbdev/acornfb.h |  8 +----
 2 files changed, 15 insertions(+), 50 deletions(-)

diff --git a/drivers/video/fbdev/acornfb.c b/drivers/video/fbdev/acornfb.c
index f0600f6ca254..30781679c90a 100644
--- a/drivers/video/fbdev/acornfb.c
+++ b/drivers/video/fbdev/acornfb.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/drivers/video/acornfb.c
- *
  *  Copyright (C) 1998-2001 Russell King
  *
  * Frame buffer code for Acorn platforms
@@ -94,7 +92,6 @@ static struct vidc_timing current_vidc;
 
 extern unsigned int vram_size;	/* set by setup.c */
 
-#ifdef HAS_VIDC20
 #include <mach/acornfb.h>
 
 #define MAX_SIZE	(2*1024*1024)
@@ -306,7 +303,6 @@ acornfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 
 	return 0;
 }
-#endif
 
 /*
  * Before selecting the timing parameters, adjust
@@ -390,7 +386,6 @@ acornfb_adjust_timing(struct fb_info *info, struct fb_var_screeninfo *var, u_int
 	/* hsync_len must be even */
 	var->hsync_len = (var->hsync_len + 1) & ~1;
 
-#if defined(HAS_VIDC20)
 	/* left_margin must be even */
 	if (var->left_margin & 1) {
 		var->left_margin += 1;
@@ -400,7 +395,6 @@ acornfb_adjust_timing(struct fb_info *info, struct fb_var_screeninfo *var, u_int
 	/* right_margin must be even */
 	if (var->right_margin & 1)
 		var->right_margin += 1;
-#endif
 
 	if (var->vsync_len < 1)
 		var->vsync_len = 1;
@@ -436,11 +430,7 @@ acornfb_update_dma(struct fb_info *info, struct fb_var_screeninfo *var)
 {
 	u_int off = var->yoffset * info->fix.line_length;
 
-#if defined(HAS_MEMC)
-	memc_write(VDMA_INIT, off >> 2);
-#elif defined(HAS_IOMD)
 	iomd_writel(info->fix.smem_start + off, IOMD_VIDINIT);
-#endif
 }
 
 static int
@@ -469,7 +459,6 @@ acornfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 		var->transp.length = 0;
 		break;
 
-#ifdef HAS_VIDC20
 	case 16:
 		var->red.offset    = 0;
 		var->red.length    = 5;
@@ -491,7 +480,6 @@ acornfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 		var->transp.offset = 24;
 		var->transp.length = 4;
 		break;
-#endif
 	default:
 		return -EINVAL;
 	}
@@ -519,6 +507,9 @@ acornfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 static int acornfb_set_par(struct fb_info *info)
 {
+	unsigned long start, size;
+	u_int control;
+
 	switch (info->var.bits_per_pixel) {
 	case 1:
 		current_par.palette_size = 2;
@@ -536,7 +527,6 @@ static int acornfb_set_par(struct fb_info *info)
 		current_par.palette_size = VIDC_PALETTE_SIZE;
 		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
 		break;
-#ifdef HAS_VIDC20
 	case 16:
 		current_par.palette_size = 32;
 		info->fix.visual = FB_VISUAL_DIRECTCOLOR;
@@ -545,41 +535,26 @@ static int acornfb_set_par(struct fb_info *info)
 		current_par.palette_size = VIDC_PALETTE_SIZE;
 		info->fix.visual = FB_VISUAL_DIRECTCOLOR;
 		break;
-#endif
 	default:
 		BUG();
 	}
 
 	info->fix.line_length	= (info->var.xres * info->var.bits_per_pixel) / 8;
 
-#if defined(HAS_MEMC)
-	{
-		unsigned long size = info->fix.smem_len - VDMA_XFERSIZE;
+	start = info->fix.smem_start;
+	size  = current_par.screen_end;
 
-		memc_write(VDMA_START, 0);
-		memc_write(VDMA_END, size >> 2);
+	if (current_par.using_vram) {
+		size -= current_par.vram_half_sam;
+		control = DMA_CR_E | (current_par.vram_half_sam / 256);
+	} else {
+		size -= 16;
+		control = DMA_CR_E | DMA_CR_D | 16;
 	}
-#elif defined(HAS_IOMD)
-	{
-		unsigned long start, size;
-		u_int control;
-
-		start = info->fix.smem_start;
-		size  = current_par.screen_end;
-
-		if (current_par.using_vram) {
-			size -= current_par.vram_half_sam;
-			control = DMA_CR_E | (current_par.vram_half_sam / 256);
-		} else {
-			size -= 16;
-			control = DMA_CR_E | DMA_CR_D | 16;
-		}
 
-		iomd_writel(start,   IOMD_VIDSTART);
-		iomd_writel(size,    IOMD_VIDEND);
-		iomd_writel(control, IOMD_VIDCR);
-	}
-#endif
+	iomd_writel(start,   IOMD_VIDSTART);
+	iomd_writel(size,    IOMD_VIDEND);
+	iomd_writel(control, IOMD_VIDCR);
 
 	acornfb_update_dma(info, &info->var);
 	acornfb_set_timing(info);
@@ -709,10 +684,8 @@ static void acornfb_init_fbinfo(void)
 	 */
 	memset(&fb_info.var, 0, sizeof(fb_info.var));
 
-#if defined(HAS_VIDC20)
 	fb_info.var.red.length	   = 8;
 	fb_info.var.transp.length  = 4;
-#endif
 	fb_info.var.green	   = fb_info.var.red;
 	fb_info.var.blue	   = fb_info.var.red;
 	fb_info.var.nonstd	   = 0;
@@ -991,7 +964,6 @@ static int acornfb_probe(struct platform_device *dev)
 
 	size = PAGE_ALIGN(size);
 
-#if defined(HAS_VIDC20)
 	if (!current_par.using_vram) {
 		dma_addr_t handle;
 		void *base;
@@ -1011,7 +983,6 @@ static int acornfb_probe(struct platform_device *dev)
 		fb_info.screen_base = base;
 		fb_info.fix.smem_start = handle;
 	}
-#endif
 	fb_info.fix.smem_len = size;
 	current_par.palette_size   = VIDC_PALETTE_SIZE;
 
diff --git a/drivers/video/fbdev/acornfb.h b/drivers/video/fbdev/acornfb.h
index e65388587f80..e33ea24ae0e1 100644
--- a/drivers/video/fbdev/acornfb.h
+++ b/drivers/video/fbdev/acornfb.h
@@ -1,16 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  linux/drivers/video/acornfb.h
- *
  *  Copyright (C) 1998,1999 Russell King
  *
  *  Frame buffer code for Acorn platforms
  */
-#if defined(HAS_VIDC20)
 #include <mach/iomd.h>
+
 #define VIDC_PALETTE_SIZE	256
 #define VIDC_NAME		"VIDC20"
-#endif
 
 #define EXTEND8(x) ((x)|(x)<<8)
 #define EXTEND4(x) ((x)|(x)<<4|(x)<<8|(x)<<12)
@@ -94,7 +91,6 @@ struct modex_params {
 	const struct modey_params *modey;
 };
 
-#ifdef HAS_VIDC20
 /*
  * VIDC20 registers
  */
@@ -162,5 +158,3 @@ struct modex_params {
 #define VIDC20_DCTL_VRAM_PXCLK	(1 << 18)
 #define VIDC20_DCTL_VRAM_PXCLK2	(2 << 18)
 #define VIDC20_DCTL_VRAM_PXCLK4	(3 << 18)
-
-#endif
-- 
2.43.0


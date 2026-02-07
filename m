Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7805A306D2A
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Feb 2026 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770484375; cv=none; b=SuXfcBCYFlX/c8icQ4EkwL+k4pEJlOzbfEYjXm6LPpXJhu/ya/7H6u9bJ5wnaId4V8LNJz1UGT7ESifQ7TYYa9/ioKLcRC0h4Jqq+cFCUkJN/vtKqAfnFHp28eSfdrzKGcEWeh5F0wrRpo3ciIxGM4RJ+L/zdN1YiZm7TK4tjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770484375; c=relaxed/simple;
	bh=va/18+3PdZ7dHP1L2lqgEWnzeeTIO5/q/dn8hYQR5dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRpzVKyw66r941BCiYMKYNNWY6YplwPr1GaqabAjxncdeyvGk1dAOjgBMujWD69uPZ2lUB73NjPcwEkvxGligmeSaDRjnKcLALFJFC4W8s4xUw1JOtIJAdNCzSMrptX5lb+MDH/9n5dF1Rv+/tJ0ft4ns2EL+QuMmft5FjjCXIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ob0PvsrR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ob0PvsrR"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4362197d174so1861587f8f.3
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Feb 2026 09:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770484374; x=1771089174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AkIJzahYFWhAsrqcEiNKkW3iI8aeCrM5PKgRKdNg+M=;
        b=ob0PvsrRHbqvAEaqjgLNDEQPoj0ssB1YAP4tsvJvSfg4OTJb4mF+hoftqNg7CUxYx9
         62X8G0c0fNowpWpD7c2hRrwAgzNo72WEamNu+tc29lGr6ENdcHPO/oWkJmxX3Q0nEine
         mcTmyxXyFzATURHVXi+Ay/XyLU51cAPWgk16Y6PG/79J+TgSRwQH3DcI1sszn8WjEDej
         t1sjznZYPANJwEwdX9BjCy45xHwKUNdsIq7tikHEaTI0laDbieS3zrmL2xtIBUzfipje
         WT3JTGqrkyGDhrwd2gJkl0bxC8B9syZ/auZcsMwZKuPInaKXGwFJpdIOv+sCvyVJWedT
         p4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770484374; x=1771089174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5AkIJzahYFWhAsrqcEiNKkW3iI8aeCrM5PKgRKdNg+M=;
        b=PBqlPauTnWeIN1TXbG5+3+9xhEA6GPX5Qptt/lEU1eQETHTW4iQmyzAISOClmy1W6H
         yiyCYtK/N2yaEJjFdPmj3oSz6St6dbUMwpVaR/tI4c8ewsmb1h1JKFamViwGnlrli+/s
         v/JqmFb/ppTOj+3W+WFe2dC+cF1DxF3SCpG3jVbs+FnEEnz8wISBaUx8F9UvNDhdRJyX
         7LYGQQOCsV/7PFd0OU08uvFeEeJLtTakoKo/T3FMTMRJgWg3Uz0CsXVswGJaxvMq5Mj1
         u654kLIdwpSiOlgSj6DTY/J2wGuSW6FlVeram3xLX/eQYBw5ILYtB4bc7q1veNsRDig8
         ZGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnOV4bw/uuqHuqqWpATXul8RAD99pFhqmBQKS2EH4C8cAI25pYn7mVScgL62WZFPD5aPype2dMmUFzKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEZr1vV2ejEb4FJ/UOS0kqdkHIRTYWbSXhLcvdg3EEjwJTaT9w
	2kWVZHwNYSey+hl60eSS1Kw7F422c5cpN9GMDqOqC1g7ddKiAyUtG/8M6VTIAXXvDmk=
X-Gm-Gg: AZuq6aLeaMAJe3eevAMG14z9QewUA94n+GdOe9UjD9KJetuc26uxXVNKoyigioyPR/i
	T+175gWm+1cTKB1vUoGcDEXHH5Vtg7mvMf0MgPDwyVqU1oWgIdhoGEwBTTKt/uq8/rkY+2VRbJq
	0tpfuyLp71jrF9RD0+vy5zkxPqBDd1EargRKzwY/gX801g4XOeKjZ+WpqS+qej2IawmzcpVK4w0
	jX6TjKt2APO79qL+zieg1zMPGmyRblduFBCCIIuNLodFcfC+oJtN7FyQx9WuRc+ZFjfwvSDDY9G
	2OcOA2tEG6mhQwmpOVLpEzhJ1oA6GyEWZ5UCz541Jer4Ere8czkYTVz046fjJD8I38opnb4ygbO
	trWjr60Oq9lWsCO+yAZL36/ra5KxOdjAwdysAgwwkiKkidcBnfxIho0PRMut4zByDJJZWx5gNWK
	0mR5AQzwh1BcFtLZCw
X-Received: by 2002:a5d:64c5:0:b0:435:8d80:1b81 with SMTP id ffacd0b85a97d-4362923f722mr9422581f8f.21.1770484373777;
        Sat, 07 Feb 2026 09:12:53 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4362972fa4csm12998700f8f.26.2026.02.07.09.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 09:12:53 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/4] fbdev: au1100fb: Don't store device specific data in global variables
Date: Sat,  7 Feb 2026 18:12:34 +0100
Message-ID:  <0e1ecdde447dc32816f1f066812ec8e84b4aad0a.1770483674.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770483674.git.u.kleine-koenig@baylibre.com>
References: <cover.1770483674.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6471; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=va/18+3PdZ7dHP1L2lqgEWnzeeTIO5/q/dn8hYQR5dY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBph3KFv+sr/GhqcmNHOR8DDwM7Flb5hwdZVkPR7 xxIVybWvRuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYdyhQAKCRCPgPtYfRL+ TqJgB/40LjKbk77Mt+9JsYzvOfWeti/Ga4kqtEvjAZPPKLzdxRkozAczuoGyg6hT9AFh3vuHW2k xocJGQjEhbWmoTHfPFDR0GGKjQfivJX+GGT9Yq+7sp4vDmzISIYDHSg9/UCuzC7zJsK0DnhojV1 +pLssmp1q94T42nbBaZj7IbDssCz7N31Coo7NQwlp8jvMzm+qH35Ite6kcaScgZdEqeeIT002/8 Cf7HPs4+zOd0Fq7V1M6mnbSjTlGyLPttuV0mW2qn89ey6m+PrBgWVT7+mG9gAtGYDfL5jMTN8Fo MXZ/T2MpRJ0Z2q4JqtAN4eh2kh9bXCRU67FQtmxAY2qtKx/R
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Using global data to store device specific data is a bad pattern that
breaks if there is more than one device. So expand driver data and drop
the global variables.

While there is probably no machine that has two or more au1100fb
devices, this makes the driver a better template for new drivers and
saves some memory if there is no such bound device.

bloat-o-meter reports (for ARCH=arm allmodconfig + CONFIG_FB_AU1100=y
and ignoring the rename of the init function):

	add/remove: 1/4 grow/shrink: 2/2 up/down: 1360/-4800 (-3440)
	Function                                     old     new   delta
	au1100fb_drv_probe                          2648    3328    +680
	$a                                         12808   13484    +676
	au1100fb_drv_resume                          404     400      -4
	au1100fb_fix                                  68       -     -68
	au1100fb_var                                 160       -    -160
	fbregs                                      2048       -   -2048
	$d                                          9525    7009   -2516
	Total: Before=38664, After=35224, chg -8.90%

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
I think this doesn't need a Fixes line, but if you want, it would be:

	Fixes: 3b495f2bb749 ("Au1100 FB driver uplift for 2.6.")
	Fixes: f77f50ca1a23 ("[PATCH] au1100fb: add power management support")
---
 drivers/video/fbdev/au1100fb.c | 63 ++++++++++++++++------------------
 drivers/video/fbdev/au1100fb.h |  5 +++
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index feaa1061c436..75344ee080f3 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -84,21 +84,6 @@ struct fb_bitfield rgb_bitfields[][4] =
 	{ { 8, 4, 0 },  { 4, 4, 0 }, { 0, 4, 0 }, { 0, 0, 0 } },
 };
 
-static struct fb_fix_screeninfo au1100fb_fix = {
-	.id		= "AU1100 FB",
-	.xpanstep 	= 1,
-	.ypanstep 	= 1,
-	.type		= FB_TYPE_PACKED_PIXELS,
-	.accel		= FB_ACCEL_NONE,
-};
-
-static struct fb_var_screeninfo au1100fb_var = {
-	.activate	= FB_ACTIVATE_NOW,
-	.height		= -1,
-	.width		= -1,
-	.vmode		= FB_VMODE_NONINTERLACED,
-};
-
 /* fb_blank
  * Blank the screen. Depending on the mode, the screen will be
  * activated with the backlight color, or desactivated
@@ -432,19 +417,26 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 		return -EFAULT;
 	}
 
-	au1100fb_fix.mmio_start = regs_res->start;
-	au1100fb_fix.mmio_len = resource_size(regs_res);
+	fbdev->info.fix = (struct fb_fix_screeninfo) {
+		.mmio_start = regs_res->start,
+		.mmio_len = resource_size(regs_res),
+		.id = "AU1100 FB",
+		.xpanstep = 1,
+		.ypanstep = 1,
+		.type = FB_TYPE_PACKED_PIXELS,
+		.accel = FB_ACCEL_NONE,
+	};
 
 	if (!devm_request_mem_region(&dev->dev,
-				     au1100fb_fix.mmio_start,
-				     au1100fb_fix.mmio_len,
+				     fbdev->info.fix.mmio_start,
+				     fbdev->info.fix.mmio_len,
 				     DRIVER_NAME)) {
 		print_err("fail to lock memory region at 0x%08lx",
-				au1100fb_fix.mmio_start);
+			  fbdev->info.fix.mmio_start);
 		return -EBUSY;
 	}
 
-	fbdev->regs = (struct au1100fb_regs*)KSEG1ADDR(au1100fb_fix.mmio_start);
+	fbdev->regs = (struct au1100fb_regs*)KSEG1ADDR(fbdev->info.fix.mmio_start);
 
 	print_dbg("Register memory map at %p", fbdev->regs);
 	print_dbg("phys=0x%08x, size=%d", fbdev->regs_phys, fbdev->regs_len);
@@ -469,22 +461,27 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 		return -ENOMEM;
 	}
 
-	au1100fb_fix.smem_start = fbdev->fb_phys;
-	au1100fb_fix.smem_len = fbdev->fb_len;
+	fbdev->info.fix.smem_start = fbdev->fb_phys;
+	fbdev->info.fix.smem_len = fbdev->fb_len;
 
 	print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
 	print_dbg("phys=0x%08x, size=%dK", fbdev->fb_phys, fbdev->fb_len / 1024);
 
 	/* load the panel info into the var struct */
-	au1100fb_var.bits_per_pixel = fbdev->panel->bpp;
-	au1100fb_var.xres = fbdev->panel->xres;
-	au1100fb_var.xres_virtual = au1100fb_var.xres;
-	au1100fb_var.yres = fbdev->panel->yres;
-	au1100fb_var.yres_virtual = au1100fb_var.yres;
+	fbdev->info.var = (struct fb_var_screeninfo) {
+		.activate = FB_ACTIVATE_NOW,
+		.height = -1,
+		.width = -1,
+		.vmode = FB_VMODE_NONINTERLACED,
+		.bits_per_pixel = fbdev->panel->bpp,
+		.xres = fbdev->panel->xres,
+		.xres_virtual = fbdev->panel->xres,
+		.yres = fbdev->panel->yres,
+		.yres_virtual = fbdev->panel->yres,
+	};
 
 	fbdev->info.screen_base = fbdev->fb_mem;
 	fbdev->info.fbops = &au1100fb_ops;
-	fbdev->info.fix = au1100fb_fix;
 
 	fbdev->info.pseudo_palette =
 		devm_kcalloc(&dev->dev, 16, sizeof(u32), GFP_KERNEL);
@@ -497,8 +494,6 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 		return -EFAULT;
 	}
 
-	fbdev->info.var = au1100fb_var;
-
 	/* Set h/w registers */
 	au1100fb_setmode(fbdev);
 
@@ -547,7 +542,7 @@ void au1100fb_drv_remove(struct platform_device *dev)
 #ifdef CONFIG_PM
 static struct au1100fb_regs fbregs;
 
-int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
+static int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct au1100fb_device *fbdev = platform_get_drvdata(dev);
 
@@ -559,7 +554,7 @@ int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 
 	clk_disable(fbdev->lcdclk);
 
-	memcpy(&fbregs, fbdev->regs, sizeof(struct au1100fb_regs));
+	memcpy(&fbdev->pm_regs, fbdev->regs, sizeof(struct au1100fb_regs));
 
 	return 0;
 }
@@ -572,7 +567,7 @@ int au1100fb_drv_resume(struct platform_device *dev)
 	if (!fbdev)
 		return 0;
 
-	memcpy(fbdev->regs, &fbregs, sizeof(struct au1100fb_regs));
+	memcpy(fbdev->regs, &fbdev->pm_regs, sizeof(struct au1100fb_regs));
 
 	ret = clk_enable(fbdev->lcdclk);
 	if (ret)
diff --git a/drivers/video/fbdev/au1100fb.h b/drivers/video/fbdev/au1100fb.h
index 79f4048726f1..dc53d063fcc3 100644
--- a/drivers/video/fbdev/au1100fb.h
+++ b/drivers/video/fbdev/au1100fb.h
@@ -105,6 +105,11 @@ struct au1100fb_device {
 	size_t       		regs_len;
 	unsigned int 		regs_phys;
 
+#ifdef CONFIG_PM
+	/* stores the register values during suspend */
+	struct au1100fb_regs 	pm_regs;
+#endif
+
 	unsigned char* 		fb_mem;		/* FrameBuffer memory map */
 	size_t	      		fb_len;
 	dma_addr_t    		fb_phys;
-- 
2.47.3


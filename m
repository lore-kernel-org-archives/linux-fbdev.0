Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1239F38F94A
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196530; cv=none; b=a6rHU9zIF8xYN27S2oZl+Y4+nh0khr0wTfnDaksiSQzeAGxj71RZKjBsDYPf0PjpUuHN/+aT6L+1iZt/vBoGuj9XeCbvNSWRjFHLYJEGNq+EX6u0fV5Nf1jqy92eWeUFyzEXqtD8kgISyLlFoJsk27P2aSqDi9FqE+7ueOjYSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196530; c=relaxed/simple;
	bh=Fkf/4qCt+9aG00qHgsptGoNdY1IP6HFw4O4Wysl6GGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beeEYZq+qdhj5xQNKi0sW4t86s31Wg/KBmXhjnpOsxZHZj90x6uFGnLwsG68F4AM3B6MtBAQ20KbNjOA7IriRALjJLER0S5adM5aTT+/s/mMY/io7i49U3oSFgYvTlEbayf3gwYxfTAgh8pvsdwb5/wBcYQrN165AGPqXMZNnAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E/q8G23F; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E/q8G23F"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43615d9c5d0so737579f8f.1
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 01:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770196528; x=1770801328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGOswYvI1OpvSrdECniluvWPsTAO8EOjdql4emfj+68=;
        b=E/q8G23Fx4+VeSLQ6tcfDmopo4OvrtCEmgSR/rTiNGBeZzWGmV+IKiLbSAfs8flu+k
         TWW3Y5B1f0VE2fIFJzcFOLzsWxqVze02pj01azOWdkQAnADZ0Gn50AuPTDZYSkB+2mBt
         f4uWnnZO2cLBI0IOrcPi46JfY8roS87x0wrMvVmyuEtQ95jz9kmjM3E5ARFgtcPoNwpY
         vNsv9hY/KrWKDqqnv9KpR4Z4yuBm5QFSVeo4GUumknLT6axcS0RnjPdqBGZQfYF7Llk9
         Dx56CbPukH3YM1zsf7dcsL/cwyiI3jW10qqRaT0AVn+Gs8bAabmLl78oHcJ+0nKVeq5k
         usPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770196528; x=1770801328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cGOswYvI1OpvSrdECniluvWPsTAO8EOjdql4emfj+68=;
        b=A6i1LYQEfaRXxm8Snn0kAJZdlPpRWpCqdrRyljp814SJa9gSp5SjCck5OzXptkvY+g
         YtPk/nHu2GBJPqhNhYH8QM6a56xAajlijtYfxoi9Ar8d2gzoayN7aNyUbNZ42I4Eh+L7
         Ey9h5+SgJHWxHoUaVj1S63iKxabF2tOZOHhzbYhcQHtAn8J5F8vwxiO/J0hnk5VdsQC9
         cWEmII6xAgXWHnAcyrpUF26r/Awt7RCsTBIsUyDtyc27Xl9fIrUbGO8yo1zC4uKfA20g
         5xvJ3VF3p9De2kWvwfhzxpY0uTh4ATkv6P3J30SgFwIXEglwjAdQDD5ehRoHirDhof8Q
         jtuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXkv77Sx3r+gXUgQQQleT9RzsAOjMU+m7ZcMsrzWi8UK0kEApZEPSDGi9UTsk787GBcNQck20uPTFGJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBBNNdzZ7TT1tT5TQoxdtObYpDP/mIgPhVlTNOt9zPwKvUr7h
	Ru5F1Q58vrZlKCKzva7/MmA3f+TGCNvyjeQ9fTWSzIJY2QIN6KUF50gP9jQJEHeJqqUBP5arjKX
	VrGr+
X-Gm-Gg: AZuq6aL47ojRFiloc5IddremqseKdnmKgeNvV/Pw1ChYb90ob7XrQLrnOkGgKgFm3Dj
	yKgaEiuEYxYqkpcwg79JSOnSMYFUE1hDLtmB3vaWhe2RwudNiPliwCfzlUNlSQAmdgTl9q5YCEn
	yl0pO78tS6l/00yrHCZKp4vmHY1M/JLmm7szJbA8Gb2uKrgsrSNjHKs5ilCwUQH6DRsWuOcTJgp
	OZo+6ASKUdnjn0iypLcySa14iLfVsHkOYii0sSB9ay3BXIYOwXaKqJwtM0HR+M47sVYuWcEGZGM
	u1eB9HolO/+9CPaKiy7gT3PMxsb5TQSt6CLHKhOFxyUnm4d+eld71HHjm9V3I4f/iUUHJzlAJtm
	E3i74zR7tRFZKF9dIk6zYa0bP7Hw9fJLHH7yDxQJ/S7lxqNKrDjMcD5gMLLKnDhSL+WppkNYi5t
	g9AoynRPZXg6SABIB66++U5oGWV1LVv0jDm3nA/HKXPPPHhSIsfNE69usiXbdXZF/cUhvZm0OZN
	V8=
X-Received: by 2002:a05:6000:2303:b0:430:fbe1:3822 with SMTP id ffacd0b85a97d-4361805bbecmr2976113f8f.54.1770196528127;
        Wed, 04 Feb 2026 01:15:28 -0800 (PST)
Received: from localhost (p200300f65f20eb0470629fa1229c2efb.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:7062:9fa1:229c:2efb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43617e25683sm4887971f8f.6.2026.02.04.01.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:15:27 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v1 3/3] fbdev: au1100fb: Don't store device specific data in global variables
Date: Wed,  4 Feb 2026 10:15:13 +0100
Message-ID:  <9cbc57e4d65e131f39d702d061d554c1f4ede47c.1770196161.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770196161.git.u.kleine-koenig@baylibre.com>
References: <cover.1770196161.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6420; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Fkf/4qCt+9aG00qHgsptGoNdY1IP6HFw4O4Wysl6GGQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpgw4ml4IsrFX7ilaP914Wqoy26obnyR6BSe4cu n4m8xd3DmqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYMOJgAKCRCPgPtYfRL+ Tqd+B/4rGr6ZohD2F/IjB7PpXLBw8sP8Q2tYGQ2nh7dADWlElmZM6XAgZW3H7lwMnmWV72spPxQ iHdYZsjYpIS5tKSUwR3bhq30+KjVSQrHP02lA03lE6xQPLmgDI2j/V6ohhru3Vuj8RmQ7SfUX1E pKJ6MPZ1GcbnymsW8UxWu4jYb92uYBgtorpkLiuMLJi188VLeb8aovAZx+blYUy2n7LL2llqUBG uBW3cQk/Hqw1u62nYewPAeQ0/Ok9mfJ2F4sAlGIdAOnNIM/+1S+c4fovxbNcAHGdr2ZB3LDp9jV DdQmQuChQ0Vw+k9mnZot2NBE5zX9pSAkMEaMoaq9LE0vcV1u
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
 drivers/video/fbdev/au1100fb.c | 63 +++++++++++++++-------------------
 drivers/video/fbdev/au1100fb.h |  5 +++
 2 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 94514625965b..6da532ba1d84 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -89,21 +89,6 @@ struct fb_bitfield rgb_bitfields[][4] =
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
@@ -437,19 +422,26 @@ static int au1100fb_drv_probe(struct platform_device *dev)
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
@@ -474,22 +466,27 @@ static int au1100fb_drv_probe(struct platform_device *dev)
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
@@ -502,8 +499,6 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 		return -EFAULT;
 	}
 
-	fbdev->info.var = au1100fb_var;
-
 	/* Set h/w registers */
 	au1100fb_setmode(fbdev);
 
@@ -550,8 +545,6 @@ static void au1100fb_drv_remove(struct platform_device *dev)
 }
 
 #ifdef CONFIG_PM
-static struct au1100fb_regs fbregs;
-
 static int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct au1100fb_device *fbdev = platform_get_drvdata(dev);
@@ -564,7 +557,7 @@ static int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 
 	clk_disable(fbdev->lcdclk);
 
-	memcpy(&fbregs, fbdev->regs, sizeof(struct au1100fb_regs));
+	memcpy(&fbdev->pm_regs, fbdev->regs, sizeof(struct au1100fb_regs));
 
 	return 0;
 }
@@ -577,7 +570,7 @@ static int au1100fb_drv_resume(struct platform_device *dev)
 	if (!fbdev)
 		return 0;
 
-	memcpy(fbdev->regs, &fbregs, sizeof(struct au1100fb_regs));
+	memcpy(fbdev->regs, &fbdev->pm_regs, sizeof(struct au1100fb_regs));
 
 	ret = clk_enable(fbdev->lcdclk);
 	if (ret)
diff --git a/drivers/video/fbdev/au1100fb.h b/drivers/video/fbdev/au1100fb.h
index 8b29e424d017..998328cd16a2 100644
--- a/drivers/video/fbdev/au1100fb.h
+++ b/drivers/video/fbdev/au1100fb.h
@@ -103,6 +103,11 @@ struct au1100fb_device {
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


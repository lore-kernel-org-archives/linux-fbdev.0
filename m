Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CAD218845
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198427; cv=none; b=HvnUZLkPm+BeLWEAqHEjAb5V3G08N35/jII8m3IW4emdmzczm8W7/QkPTXCDxgVnvbGgmfKJytpfEwcUzEceR23xq+K4r3kpS2OFxuXKTR7qchcZhewLCuptbtOGEmyNJDYZpp30po8smzFEeympKbtia+mBHJf+CMVHMXMpDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198427; c=relaxed/simple;
	bh=hhm4j8GECKHBQ6/lpgUgfJqXCG0ZunFIpiac9ZrFSRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIAn3TVbHLZPMLqQoX8LHsO4TPRfnm2UpT6UhMb+t+SNoi14ZdpJOzei7BzNu4WFLKoBSNRsYem2s/PhKSz3j2iTCEBY24mme1P7QzO+GlILhU25wK4E7pBbeidiwtQ8Xh5avjGNgL3yHCsBF4i+78p0P8PqNXIQ3dIGN1ocii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UkIovkC9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UkIovkC9"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4362507f0feso1680592f8f.0
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 15:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771198424; x=1771803224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pELAZvBYJ7zPaLRs/K/s8XgiLo8Mv18z9SfAbA1/CD0=;
        b=UkIovkC917Ej2+JZ3B67vCzjU62Cm/Zzgi4+MnsDvPT+cs4DM2KoH7zWd80GP2P1QQ
         VnkbXHRVR3UbRck0Q2SGHXrQFgq6Gzn0zugwzuMTp27EZn/digxHPukmHpZsLwaBZ5YG
         VtoR4o/Fa4nW/9nP6WHq7qOhxitu/WLrC9sCIaq1SVy9YJahLvzGcVMyCGvDidvJO+OO
         6nqReCWdziugpunxZicg6Do8wg7lnmumaEBWxu682dMSWJPUtAlQTfxJxTncUSseIrZf
         3HK4cZYBLWXmcYne/75y5c9fWdgwqZnoWDkt2RTPERMyB/L+KnGqhVutNsoGxij1OIlh
         MfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771198424; x=1771803224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pELAZvBYJ7zPaLRs/K/s8XgiLo8Mv18z9SfAbA1/CD0=;
        b=fUIICeWk7F4KK6bq42SevDqoF2un9lPyJv8oRU9iKfIWz6KdxFBuGYw7nA98qIO9Rl
         bqNMKrdxIbfVXWQcsCGkQkcNfZlU3/qaIkMIVTxoM/SoZMugTFfzsIhVh/K3olnXf9sw
         i5IH0DeVceC7hMRoslSwc7i3MaLrEl+8kmTLXricG7zp+0hXiLzvlgOlU6itKTtvucKZ
         WTVDi5KmRq61gcQQrTEs14bk7euc8tx3q08K9M5WVAV/JsR00xlUmNikq6FF0/wbXVD7
         nQGCvBcrLQQ/AggjQxBtO0KGYlxd+9bFBZfPyWPtP3wPTnXHaEw9CYhQ/LU2ShmiIyX1
         PhPg==
X-Forwarded-Encrypted: i=1; AJvYcCW+9UUWUhky5c39K9UF0axP47DQAFBSmtsAAWmkNDDO1LjVkl7vEeSi6LBZoyHpfpxD/16Wc/dLWbKajw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYxR2ueIqCrso1rFAwbMHe2VgZO5u70jxF7vocVNttBdAB2CPq
	YAxnQjI26wbJ/OxLjzvyTmRA2tjgMwZeer8lBXXuVJiMnn9dHVVjLJazZKerVllAabY=
X-Gm-Gg: AZuq6aKHUDhFv2tD2BdNmMKqFBk5VsXiAzQrsCOW+N5zkVr7Tq3lNGTyDproQFHW3pF
	b1nJo9KdzPuLbX+3M0ZONtQrXie0R4ulNZYSiEqLfMxT64Gn+n0MquxjNsOS3BYhK70k9JoTGaF
	cYvX+VMoFsUELSW0r/HSYsapnsLyBhFGH+F9+UKW35D5LcmUzjbu3g3dptID5MH5xOskSUmQ/i2
	A7mWT2euAumSeGRe7EPUDnqfPQTTaZbv6ClnXVGCDjLwTWpHdWV6khaLtQIUlC+WM72rWLdBQ5c
	zbABcu4kydQMhiwM5kZZdgO/olhG/qJkO2vODdkeJsJbcZfWSCqwQ0xDI8+JrfkCWRw5GHPlL1L
	4VNd7MoOlg4VkTu2XRkfyIjcrntUy+yyanu5CN2NpLLtSK0xvTtBtXrNHdf/pSGOlmLktPvIvz3
	eQF1eR92DdQAFHfbFGs62EhbDl4yId
X-Received: by 2002:a5d:588d:0:b0:437:7710:5204 with SMTP id ffacd0b85a97d-43796afa1eemr18656547f8f.53.1771198423572;
        Sun, 15 Feb 2026 15:33:43 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43796ac7d91sm22790478f8f.26.2026.02.15.15.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 15:33:43 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 1/7] fbdev: au1100fb: Don't store device specific data in global variables
Date: Mon, 16 Feb 2026 00:33:17 +0100
Message-ID: <e8529f101d5bf5d4cfa5ae7db4e6de1f9ff87803.1771198101.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771198101.git.u.kleine-koenig@baylibre.com>
References: <cover.1771198101.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6477; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=hhm4j8GECKHBQ6/lpgUgfJqXCG0ZunFIpiac9ZrFSRY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpkle/AQNIpdvKpv37jW/13IcI6MSCxDyJMn5lW hfOYRAJhPWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZJXvwAKCRCPgPtYfRL+ TrETCACgzJXL0Hjx/HkKXgCTpU74REA8e+SVjmltXMMA7png7bK0JIIthASlxo9mIh2ecjkholt bv9RtPeiU2UJBPM0139mRKIJEgjgVql2E6k+Az9FUiolo2fo02w/K4z8GuZFpvd5LpsaKGG4EXW VoEBj8ooCSi1v9Lk4k2LyfO5djxLqJHOnY5aNs5BVc+FDd1d6vg8j6WkJ48lHNesjVZnMZYk5IN dWJb8BlRRFww36eaFxD5Xw4dfjeHoyULCmmK/roU4eGu8KJBXDP9KYjH3bIRC952XnMWDDoQnEi RQ7D2lcFbDDOx2cl2yAYQ3duTyTZM7bd2Vj0/xR7jBfkN7fm
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
 drivers/video/fbdev/au1100fb.c | 65 +++++++++++++++-------------------
 drivers/video/fbdev/au1100fb.h |  5 +++
 2 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index feaa1061c436..7bc224a8455c 100644
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
 
@@ -545,9 +540,7 @@ void au1100fb_drv_remove(struct platform_device *dev)
 }
 
 #ifdef CONFIG_PM
-static struct au1100fb_regs fbregs;
-
-int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
+static int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct au1100fb_device *fbdev = platform_get_drvdata(dev);
 
@@ -559,7 +552,7 @@ int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 
 	clk_disable(fbdev->lcdclk);
 
-	memcpy(&fbregs, fbdev->regs, sizeof(struct au1100fb_regs));
+	memcpy(&fbdev->pm_regs, fbdev->regs, sizeof(struct au1100fb_regs));
 
 	return 0;
 }
@@ -572,7 +565,7 @@ int au1100fb_drv_resume(struct platform_device *dev)
 	if (!fbdev)
 		return 0;
 
-	memcpy(fbdev->regs, &fbregs, sizeof(struct au1100fb_regs));
+	memcpy(fbdev->regs, &fbdev->pm_regs, sizeof(struct au1100fb_regs));
 
 	ret = clk_enable(fbdev->lcdclk);
 	if (ret)
diff --git a/drivers/video/fbdev/au1100fb.h b/drivers/video/fbdev/au1100fb.h
index 79f4048726f1..b7bf6e005572 100644
--- a/drivers/video/fbdev/au1100fb.h
+++ b/drivers/video/fbdev/au1100fb.h
@@ -105,6 +105,11 @@ struct au1100fb_device {
 	size_t       		regs_len;
 	unsigned int 		regs_phys;
 
+#ifdef CONFIG_PM
+	/* stores the register values during suspend */
+	struct au1100fb_regs	pm_regs;
+#endif
+
 	unsigned char* 		fb_mem;		/* FrameBuffer memory map */
 	size_t	      		fb_len;
 	dma_addr_t    		fb_phys;
-- 
2.47.3


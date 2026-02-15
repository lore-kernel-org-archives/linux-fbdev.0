Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A7258CE5
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771163939; cv=none; b=K1OesHcgOp4MfHU6Ao8fx/4T+TKjIay2heEpKAt/lxyxT3pFCqXXhMYc0AY5DiLf1f0fquMO8uKVfT8SHNh1RG0YH7qmhVXtXjyqUXgwq1yeHANRClP9yaVZuNSkzbZ89fsaPbCK/5wH/kzg8OyDJRMKyuMBtiTjpDQUp7m3OW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771163939; c=relaxed/simple;
	bh=4la8TwyhvmUsolxWT2IKcIbH80LEB7rogpe50paSgX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b31Dwy5j1iVOK+vDS9U3Tf0oQSqLQykZxSU9aX2kxS7eb9Q0JNMfPY+kkWIaTpvSnToQQl3xQhGf0+M4fmuHBeI97/BoDvrHhM0TJ6T2NeR5jNevn2pYREW2grrEFHyZ0WbhGQqeNnFTwWrTSVm/aXAJ27cYAurUNr/oEe4cIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NdeNdrcg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NdeNdrcg"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48374014a77so18954345e9.3
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 05:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771163936; x=1771768736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhki4gKsDPvT6xO+It70bVVw01PZcqITB4DychbCA1E=;
        b=NdeNdrcg7rVHduF7Aha0WQONQwCuyrPQRL7k1S0GJna8d3hIE3jmsLx565GBNTHe+0
         pQbOFvyagZG8NTVGfN1Or2+zotjGao7IEoKOM8gvQT9bNCtuRPI8f2nd0gzbouYA9nXT
         g8/hWxME2Q4VmzalY8UAk77TYBX/PTlQDqr68vaNEa4jb1lqrSytAwZzaDBEQFOATULc
         l5CyJgtw2+Es1VO0pMbDbiHRaOvdb+HDpNEYjLyHfssLaCTSC5wad4kCtNKD4kB6CBTK
         6F2lCuTpCLuEfskMOaeyaYPp8LjqYgT/U6zssndVOgA0WTE8Y7XREm7WpzXcznAiQl+Y
         6xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771163936; x=1771768736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhki4gKsDPvT6xO+It70bVVw01PZcqITB4DychbCA1E=;
        b=EzGhAQ9HZ+LbhW7OC8cpOEaXZCoAWQ0MZvsiCtpXG4M106/VVUAJbwQLhyroxLVu4+
         ZeECH9I95SqaBdpx6jukZm6sBDITPRP/IPtMMoMT9wYJrqnBaezVePxYV44qePp/mZ5+
         rMVM87gc6h7QmJAGXk65LR5jNoFW/nfWfDnRQgfLLEDgEkLADXGyB22ak6bSjRZ16TEl
         HWnFGJeSgqC+afCjPyRqla39Cy/WUFy0P8sGXuANOj/ESUO13Z3/0+tGkhWWvAfWA/ra
         9BzFL5yQzMWQ+aW5E1ZOJHx5WNPIpfodUZKP8FpC6g86Aq3XTmqDdedxUUoVvQntRUpX
         ZVtA==
X-Forwarded-Encrypted: i=1; AJvYcCXLI7ZAbr1I5YYbJzoT169yvhqWvNYDmUMXp9AxqJI5GPpSzx3q1hOJz61A/5O+4mS5toctSJzNvxV9tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUuqdZvkpyYFlzWdM9Xuj9ZX2BUuNP83LsbeO4CPElzqJAaCrM
	8S9xRNVVpnKzAyuc9LOl26KDsi7t/ntuFQjF5PWChgclycfLiI/elKikOH02VPlMGSiTyLDwIsd
	/GsfF
X-Gm-Gg: AZuq6aJr083SRL4SPlcqef2Gv2f69vhLCCsl55X+k0SUiX7hl4AJiVwBKBLHo1l1zmh
	n2Kb/cDrleFrRjNGMDe1yJAtyrGuvmn17T/ivjbCDthSzKiF+CY8LxvcQ4wjoJ7BxUJcJaAGuMp
	p1gswV9JnQuscoaFGrQwP+IqDNaHcoIL6ruteUoXeAdvh1x0+5jymhQ0doKHoId5h4QD+kW8SXd
	yy3g0xhqSoN8XPKZafSCHorG4zTgc35OJZdnQczP+PRQH3cex/UYKYUc+nfDhrOQVU/3luGPek7
	+e7BI+grv72M96rd/tu6MS+y830LanSMYH13Nmljo7h2nnRpXIQUAsRGwFCwcT5fAhfvFSgo0Gk
	rK7bqdfOncZ5lOIJlN6gwlmFoCmgQ8qqs7EmVRrenIRKgbeHIhaH9GksKp200jhj4ihWWU7ZBHa
	kgNZOVsKq3VkN66B69qoLYptokza0W2S1q1Y/J6Dw=
X-Received: by 2002:a05:600c:3151:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48373a0aed5mr136494685e9.12.1771163935262;
        Sun, 15 Feb 2026 05:58:55 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48370a3ee00sm62065325e9.1.2026.02.15.05.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 05:58:54 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v4 1/7] fbdev: au1100fb: Don't store device specific data in global variables
Date: Sun, 15 Feb 2026 14:58:28 +0100
Message-ID:  <384ec8818490781bff67b94488d28702da2936fd.1771163316.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771163316.git.u.kleine-koenig@baylibre.com>
References: <cover.1771163316.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6478; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=4la8TwyhvmUsolxWT2IKcIbH80LEB7rogpe50paSgX0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpkdEGL3TRaUA+u1LM7Zz91WCALv1wm/RbfBNuC +KmR4CzutqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZHRBgAKCRCPgPtYfRL+ TtFHB/9dhKfgxCNDkZROAuU/wyvxnp3AHALqUkmmrS1uUxHljs3/dSDSUN3za26GAXeUr2zFXpv pXBTYp3EWgTN7XummXpNobeGeCi14iBrx4NKtQRX3KYq1QAnPLdNZ7CGBgPKbFSQC1Gf/D9eYbJ AYPhp1uPjTFWpkhR/53YOUhRa/3/EOY7QovbKt9GguAYA3MHUvIARqyxEmakd92dlSeopEvpYdG xqyk7DqvMFmbx5rMlC+XoPROj+4mIDL/O+j+bN7GbeYwefL9hch5uulq3zPMsnjPuXL0iiF0O5k DLSTOGcmXD25WLJyDNL87KGsmT7WFwZ6Ie1V+J/nrP2FxoDY
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


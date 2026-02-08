Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D62D6E4B
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Feb 2026 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770573507; cv=none; b=B7s1ceTUgwzXQjK1Zu7an9pj7KdlaaspPrvMoE2wlnKBFlrTu26BNSloGtDSdNwLcMNgR9G2F5vxCUSEfudliHEtTatRLWGBrFEdpl/7H3vZYZUj0hN8YF8KB4TjO0HJ5+/HUvPGa98+jf4d5g3nClexMDPYKerOkAajDlwXN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770573507; c=relaxed/simple;
	bh=4la8TwyhvmUsolxWT2IKcIbH80LEB7rogpe50paSgX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRi3A3s5ACNGApAydAqQQuhgqeYz9/gsX4jrI0sBbsu6hNu692cvs0VbtZZ6uvc9JDd5kEeEyUMXzEgNoUBSGSz9oBQNtoXajHwRNpe8yIki1W1drbJAFf5OQYTj5fkgrXvMsrVZxszPcO7+EzaaL2VoLOTyuo99n9+ABeexH/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZK7T/E8q; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZK7T/E8q"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so34746095e9.0
        for <linux-fbdev@vger.kernel.org>; Sun, 08 Feb 2026 09:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770573505; x=1771178305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhki4gKsDPvT6xO+It70bVVw01PZcqITB4DychbCA1E=;
        b=ZK7T/E8qu67Z/O8djd6YRRh2kMhLZmin/3P6cq8HPBr+cBie9WcO4mtbmSXCYMRwaw
         53QaBg0G953z7cUepwRCVx6LHk14UVpu40XDGyefC/VRyye1P/gSuTNkaa6Zj2/U6jOZ
         eAZqwRpEinOtuiWQW5Mv5irmdEPbGsO8ee7fHTeQFCzg57epLpbf4Etu4aCOATRmTMDa
         FV8Eri6ddKqkZFYXUNYUS4u5X62Y2BgTcfXRXSgZ1ZuhF83e0KBB7B1wgkP19m4WBujc
         XN3RTp1Y/gg3VxXB2I4TyjNVA0JstMUQ1P0vHietWYNsXjC6FXBOfCuQQRmaMeNm4I2v
         326A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770573505; x=1771178305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhki4gKsDPvT6xO+It70bVVw01PZcqITB4DychbCA1E=;
        b=pag3YhszFI1oEBI/Z+vpLi7CQSfTOm975jtuN2CgYmASoPmBD1sYd9WNbLedS0FaS3
         yYrmQDShi77ZdwSljtp57NUsg2h4+jWvMMnEWtGNjYrZE7Dbd4BmZVar9kYIZJ/JLB3a
         dDg1l6R9gHIAS5HL1+V7KQdIzilIrdbGdbD5BXOIgxEtzMnHHonQffEdblZOyFzDwRxu
         Bh85wF0OzVKD0iqsIrlTFMnSKAEzPxXKMFT5tQ3JRCZRdk3zeovVEwToVyi/w/syzj86
         NgxZe4fjetGQvapjo0QQgGBi0VFxZC4k6f/U2o9XMKIKiMYuZwvJQnIsXGUPg6yoQbYK
         QVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN03UwkoFinO0GxPzLu+xHLEglCFT8wKfZXXDeb6e0CGtMaA5KJU2y6pv+wTJZq2VP7a+DVUfXwAi8hA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMNfw8AHjss9wOkGC7T5uz6gXbkVe2vYeMx5jSiv9EA0jGD+TL
	QJH5exBthI1KlCgFWagRgbEYJJqJX7KGQW3zMBV0i0PH+JWdHaVyFvx7z2P0K8CLsvdqgNQUdYv
	R6Ts0
X-Gm-Gg: AZuq6aKy+fsjfeK11l/pY/VIeiei1tYPpKCAumoV4sOsuEGwA4DRhbKFPEdsZ0nnzaZ
	5Ova9cKpCMCFfKsMJbBZOV2N5hcZpRefUeiRt/i7+IbU3c3EzgmsCT6sfRtIS+2UXtUUjPQ3b93
	OuWHofEDOeCzTPZbI0V2gESgtVmBvFgzqOSJKLmsADAFNLM28zRd08PGgUj/JQXJwheVcUovbZX
	VZ1MD4QD+GL9fc0VhF7dC1eJ/rJ7W/OX1od5zM24xF5loVAoGYjdha6ZZEWCZ8K0I+2FiVPlZI8
	SmgcixAC8I2jM1S4fAwPlQ9QCONoEv/UxBe0bAFwhY2gulU5u7gypLQnAh9ERg4EmKlWOEkzMNk
	kDoVYsiyktQW1+UOknzjoPXA2NIeQPbI4rE86VTIa6wSs8vDJASZCGbR6gq4FAiv8eiOgXo2xzM
	9m9SnIvZ7Jo43rD3vY
X-Received: by 2002:a05:600c:1f82:b0:47e:e981:78b4 with SMTP id 5b1f17b1804b1-483203d0b11mr142440925e9.12.1770573505515;
        Sun, 08 Feb 2026 09:58:25 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48333bad79bsm120232485e9.8.2026.02.08.09.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:58:25 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/6] fbdev: au1100fb: Don't store device specific data in global variables
Date: Sun,  8 Feb 2026 18:57:58 +0100
Message-ID:  <54c540f635a8a5992ef18b3adc6ed5ff84c60e51.1770572936.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770572936.git.u.kleine-koenig@baylibre.com>
References: <cover.1770572936.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6478; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=4la8TwyhvmUsolxWT2IKcIbH80LEB7rogpe50paSgX0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpiM6qqCjcXii1EkFEnUR6Vbwl1/eAxuqJe46Hu 4LfDViUpu+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYjOqgAKCRCPgPtYfRL+ Tp+0CACnhPK3WOeqyB8yHlqwIE6p4wl/Ow0xRAHGLJxIQi4qKKs45f+vTkW9EwLTqp2mqkIg0Y4 II471/9Dg88pQt/U49yLrqINcLfUxqemToM3pAiM4uCYkCwH/xS1NBTkbfWxe14NUoOyrrNCLka +VJyKHG1j4BGo7UIJeb+F1QSOfaBEyL4f8wEfLPnVlFc8f6D/giKt+8JP9WY4wTRuoJJ199T/PS VugQq+kcBadZnY9qhZWGr+d3iAr0Ae8/ynOATBh/rmq462dLGzecjgd9JEbn3vxCCbceBlYiw0V K503pxn9yA7Ymb38UJgI/o9cIhzSW5LaIAr1Dvd6i6UgRUTr
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


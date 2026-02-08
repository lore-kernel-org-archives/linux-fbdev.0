Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49DA2D6E4B
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Feb 2026 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770573517; cv=none; b=dP1JyIZZt0w+IJVAtpiu5NmiPwCWyckY1G4FV5YVHnR5YzwSEDQhlPk0L0xQaGU8v0BRUWKcZu+pLeT72xzqg9Nfmv6y7Ik9lGBroEG0LGj6K72Tfiu5N7XygDfsQrz5cB12fiYbY3I/hdc6/eov3prwW7eHAF7xS92ZPbgxj64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770573517; c=relaxed/simple;
	bh=wwKYNUPJRw0W2cD0OHtWkAyUq/jlJOznyKntCR6+JQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzHZH+74hOUlBqy/qJVMC65o3N9DIz+i3Ev8l80kj0quyZDg/qbLQR7LP8nljDOi60rBXKy/w2atba+HLtxLaKbrcvLrGfyOR/MgbVbboFBt8YhKwa9EL4wMWq7JSn8DRw21AvLlsNfv74L+s6sSh6/6SJIChUmCbt9Rmmjh8TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V9LQ+kQG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V9LQ+kQG"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so57423875e9.0
        for <linux-fbdev@vger.kernel.org>; Sun, 08 Feb 2026 09:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770573515; x=1771178315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QACDXN+eVHKEsQBMBF0EJETH5X3A4IUU1mF6R9Ztj+k=;
        b=V9LQ+kQGJgfU6X1aZ5iRRVg1thAbzA4fNcxo/4eVLd/UwbGUoI4lw/wMbdKNRZsDNm
         gkhUrieUfMhKX+GK3W7TYhcYE5OS7a07+MhKKyoNBJiMWEJ2QuXL4jmv4yIw8wu1h4g0
         Di8ql8P8f03LJke8rD842ozsLGVGHl43JdCJSLFiVvjy+hBOoFTKro+70fUMblGyqsiN
         KRB1Zpli3MehbENNizT3CqAVwy2xib3julDqvD4TpuWADASonOxZNTWLG1yfUDgfmaZs
         kR5kGhUIJ35+r47Ud3uKe4ymtDbN/MLRoQOMACkgOzLYp9bG+1eX7uhmjwgfmoJvxxG5
         ZK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770573515; x=1771178315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QACDXN+eVHKEsQBMBF0EJETH5X3A4IUU1mF6R9Ztj+k=;
        b=P5IV2Z2hAYqpTpENSHZZ3C+T9cweEbyAHLGPlYyzfkn7sEaz+Qkp2suy6g52pSEJJB
         t2i8ANhhg0udhAl9PKn2AnYW6rMFML18uCsNi7OK5t0V2+e3sGADqeLjPFm1Fu7J5IYU
         cCoklls/YfdgFqpS8mW8kELdiEJoIO3Es073Te60cUSt7bbR68EPxUC5yAvW7acLaUau
         r18TgHBRlIWIZFIvTrKZIttjQYM90lH5Oj5Op5lk0PheBxHZh/GhlsHYER/dQCquBZqn
         TkR98deAV/T+LJ+VxYVVfJ3WUWmmkqEZv0C47If1kFrSJIMroNgWxwrjLemkWMmCV1vV
         X+bg==
X-Forwarded-Encrypted: i=1; AJvYcCXJdsXMB9VM0qSomBlbhbUcu+wlziT6uaHNxRcDZBhrH2zpGeXDR6XqNlTop9WC9al5heBbWMDoh+DYGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy9jRYASixplpg+336D8n4FC2GK94w11moGsFCUaMlo5LLObiz
	TP4scwhT+7dqIz9KRNr6axqHCfCl6OAx5tzwkKHVcgvrk2zZrnhR0KvO9QtF3zfthwQ=
X-Gm-Gg: AZuq6aLBfQ4x4E2yj3T1B30x7YcKWl4zGdYetlNZhrUux7T//Wgkqwehr7gTPqBukoi
	VGgQDy4gMMKnEJOIScBJdXAzUTec+UA0fzQBuzxmsvbpAMUCEnsNptWLMFUw5uIXs8+rl+A3ArB
	duD+dh3/lXCXClv3W86SjcQ0dz7WTEcWqYVe3hVw/R2kEmPIWo2meVG8qVTwShRLZK4QA1ZMvf2
	MCiq9E4xFU/1Jh+z6cx/BygYm2OUvobUPbA3DBHUuouAxMWkMiaYbFYfC2QyiMzrYYmGzWQInuu
	9SKecEFTOHF8/jKxu+I3DQUNMkxWZNSXaItqGJSPCO4jpGeaAe6vKtjDVRP4xd+O1/JpVJJ418j
	a3ayVwe0XbuFzEmCfLwAnUzh5l30M8xdn6wUZniWRwM79fGwA+ZH2U/L3PYjxbE2mjZqCSvD9ix
	Kb/TAgkmbYiT6AvafO
X-Received: by 2002:a05:600c:6217:b0:47e:e91d:73c0 with SMTP id 5b1f17b1804b1-483202310a5mr124879955e9.19.1770573515190;
        Sun, 08 Feb 2026 09:58:35 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4376686130csm8860333f8f.1.2026.02.08.09.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:58:34 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 6/6] fbdev: au1100fb: Replace custom printk wrappers by pr_*
Date: Sun,  8 Feb 2026 18:58:03 +0100
Message-ID:  <067b7d9ea0e29e3a5ccbc5bc675e0ba4bb6b5b14.1770572936.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6894; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=wwKYNUPJRw0W2cD0OHtWkAyUq/jlJOznyKntCR6+JQY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpiM63niH9fEmkJElzgoR1TurKHVIwppQqeaJt+ 6VBh1yZH5qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYjOtwAKCRCPgPtYfRL+ TmXEB/47GTNrQjog4WtLjgzZEeaLm4wWSeXhsvgS52G99dIhOUREMg0mPqLKOUskV9lTPBOjl7y pejvnIR8dstJdJ1QCvmUhMGYels1dRuWCjt8fuZ7PG8oGeA/gqvpAWzFzFf+eoPlGBw33b19Xk4 +wctsg4JnueXmGYSTDpSs0C7J5JCO5snXZQzwMRI6m4LKcDPktgG6xoDVC535XQJVmW6M9hNIl1 IDustsX8XcI4uevnnn3ZDvDu+TbxNW07ivA8tftE4kWHCFFng65MZG0YtXjTXCEXf60nzzUIP88 p92bHRWVIpr4gfhbc1VESaOdaKTfIwYXDwfmvyiwLupYpQ9W
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The global wrappers also have the advantage to do stricter format
checking, so the pr_devel formats are also checked if DEBUG is not
defined. The global variants only check for DEBUG being defined and not
its actual value, to the #define to zero is dropped, too.

There is only a slight semantic change as the (by default disabled)
debug output doesn't contain __FILE__ any more.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/au1100fb.c | 41 +++++++++++++++++-----------------
 drivers/video/fbdev/au1100fb.h | 10 ---------
 2 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 782f70c3a98f..86aafa4f0966 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -41,6 +41,9 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
+#define pr_fmt(fmt) "au1100fb:" fmt "\n"
+
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -57,8 +60,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#define DEBUG 0
-
 #include "au1100fb.h"
 
 #if defined(CONFIG_COMPILE_TEST) && !defined(CONFIG_MIPS)
@@ -97,7 +98,7 @@ static int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
 {
 	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
 
-	print_dbg("fb_blank %d %p", blank_mode, fbi);
+	pr_devel("fb_blank %d %p", blank_mode, fbi);
 
 	switch (blank_mode) {
 
@@ -290,7 +291,7 @@ static int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info
 
 	fbdev = to_au1100fb_device(fbi);
 
-	print_dbg("fb_pan_display %p %p", var, fbi);
+	pr_devel("fb_pan_display %p %p", var, fbi);
 
 	if (!var || !fbdev) {
 		return -EINVAL;
@@ -301,13 +302,13 @@ static int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info
 		return -EINVAL;
 	}
 
-	print_dbg("fb_pan_display 2 %p %p", var, fbi);
+	pr_devel("fb_pan_display 2 %p %p", var, fbi);
 	dy = var->yoffset - fbi->var.yoffset;
 	if (dy) {
 
 		u32 dmaaddr;
 
-		print_dbg("Panning screen of %d lines", dy);
+		pr_devel("Panning screen of %d lines", dy);
 
 		dmaaddr = fbdev->regs->lcd_dmaaddr0;
 		dmaaddr += (fbi->fix.line_length * dy);
@@ -321,7 +322,7 @@ static int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info
 			fbdev->regs->lcd_dmaaddr0 = LCD_DMA_SA_N(dmaaddr);
 	}
 	}
-	print_dbg("fb_pan_display 3 %p %p", var, fbi);
+	pr_devel("fb_pan_display 3 %p %p", var, fbi);
 
 	return 0;
 }
@@ -364,7 +365,7 @@ static int au1100fb_setup(struct au1100fb_device *fbdev)
 	int num_panels = ARRAY_SIZE(known_lcd_panels);
 
 	if (num_panels <= 0) {
-		print_err("No LCD panels supported by driver!");
+		pr_err("No LCD panels supported by driver!");
 		return -ENODEV;
 	}
 
@@ -387,16 +388,16 @@ static int au1100fb_setup(struct au1100fb_device *fbdev)
 				}
 			}
 			if (i >= num_panels) {
-				print_warn("Panel '%s' not supported!", this_opt);
+				pr_warn("Panel '%s' not supported!", this_opt);
 				return -ENODEV;
 			}
 		}
 		/* Unsupported option */
 		else
-			print_warn("Unsupported option \"%s\"", this_opt);
+			pr_warn("Unsupported option \"%s\"", this_opt);
 	}
 
-	print_info("Panel=%s", fbdev->panel->name);
+	pr_info("Panel=%s", fbdev->panel->name);
 
 	return 0;
 }
@@ -421,7 +422,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	/* Allocate region for our registers and map them */
 	regs_res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!regs_res) {
-		print_err("fail to retrieve registers resource");
+		pr_err("fail to retrieve registers resource");
 		return -EFAULT;
 	}
 
@@ -439,15 +440,15 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 				     fbdev->info.fix.mmio_start,
 				     fbdev->info.fix.mmio_len,
 				     DRIVER_NAME)) {
-		print_err("fail to lock memory region at 0x%08lx",
+		pr_err("fail to lock memory region at 0x%08lx",
 			  fbdev->info.fix.mmio_start);
 		return -EBUSY;
 	}
 
 	fbdev->regs = (struct au1100fb_regs*)KSEG1ADDR(fbdev->info.fix.mmio_start);
 
-	print_dbg("Register memory map at %p", fbdev->regs);
-	print_dbg("phys=0x%08x, size=%zu", fbdev->regs_phys, fbdev->regs_len);
+	pr_devel("Register memory map at %p", fbdev->regs);
+	pr_devel("phys=0x%08x, size=%zu", fbdev->regs_phys, fbdev->regs_len);
 
 	c = clk_get(NULL, "lcd_intclk");
 	if (!IS_ERR(c)) {
@@ -464,7 +465,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 					    PAGE_ALIGN(fbdev->fb_len),
 					    &fbdev->fb_phys, GFP_KERNEL);
 	if (!fbdev->fb_mem) {
-		print_err("fail to allocate framebuffer (size: %zuK))",
+		pr_err("fail to allocate framebuffer (size: %zuK))",
 			  fbdev->fb_len / 1024);
 		return -ENOMEM;
 	}
@@ -472,8 +473,8 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	fbdev->info.fix.smem_start = fbdev->fb_phys;
 	fbdev->info.fix.smem_len = fbdev->fb_len;
 
-	print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
-	print_dbg("phys=0x%pad, size=%zuK", &fbdev->fb_phys, fbdev->fb_len / 1024);
+	pr_devel("Framebuffer memory map at %p", fbdev->fb_mem);
+	pr_devel("phys=0x%pad, size=%zuK", &fbdev->fb_phys, fbdev->fb_len / 1024);
 
 	/* load the panel info into the var struct */
 	fbdev->info.var = (struct fb_var_screeninfo) {
@@ -497,7 +498,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 		return -ENOMEM;
 
 	if (fb_alloc_cmap(&fbdev->info.cmap, AU1100_LCD_NBR_PALETTE_ENTRIES, 0) < 0) {
-		print_err("Fail to allocate colormap (%d entries)",
+		pr_err("Fail to allocate colormap (%d entries)",
 			   AU1100_LCD_NBR_PALETTE_ENTRIES);
 		return -EFAULT;
 	}
@@ -507,7 +508,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 
 	/* Register new framebuffer */
 	if (register_framebuffer(&fbdev->info) < 0) {
-		print_err("cannot register new framebuffer");
+		pr_err("cannot register new framebuffer");
 		goto failed;
 	}
 
diff --git a/drivers/video/fbdev/au1100fb.h b/drivers/video/fbdev/au1100fb.h
index 998328cd16a2..9b70208128a8 100644
--- a/drivers/video/fbdev/au1100fb.h
+++ b/drivers/video/fbdev/au1100fb.h
@@ -30,16 +30,6 @@
 #ifndef _AU1100LCD_H
 #define _AU1100LCD_H
 
-#define print_err(f, arg...) printk(KERN_ERR DRIVER_NAME ": " f "\n", ## arg)
-#define print_warn(f, arg...) printk(KERN_WARNING DRIVER_NAME ": " f "\n", ## arg)
-#define print_info(f, arg...) printk(KERN_INFO DRIVER_NAME ": " f "\n", ## arg)
-
-#if DEBUG
-#define print_dbg(f, arg...) printk(__FILE__ ": " f "\n", ## arg)
-#else
-#define print_dbg(f, arg...) do {} while (0)
-#endif
-
 #if defined(__BIG_ENDIAN)
 #define LCD_CONTROL_DEFAULT_PO LCD_CONTROL_PO_11
 #else
-- 
2.47.3


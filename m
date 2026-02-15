Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1512459C9
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 23:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198434; cv=none; b=tLPi8BLWEOqvZ+QCMp4JHEKUJ7QXT4qp9IivmVwU59r6HGrw/EKeLFFjcsKG7sii5t1TNycPggLymYHZ/9bbMUAsGw39E+WwXVIokZ9iJ43c2TUlMJ+sgGT5jOWFLayk8KJGHvY/szUm5bgl/nJBDR5bBqpdIntxCuMsOklzEJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198434; c=relaxed/simple;
	bh=9WHUEaOrVOm+WL4G/FUUC3aXFfCTRn5AFAGSSgL5t64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlSnggG/5JgwG4LMYmPYxDBdNE+aRlaHu5DtIENfhGY/1GP4Vtv7jc0PikSTKj1QFT2uFYBJlTfvuCEycBo4p2e16+KQmAUQke2NDDXxzyvBLs3Rnxp1YVbVBSfvKR0YCZvrdDnGrOp7eXDUVXf7V5UMFMtV/OUBdspMGLIp3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c/ot5uAH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c/ot5uAH"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso20040965e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 15:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771198431; x=1771803231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOqo3ZpoHBCEkKQn3Tj+aWTPXLOhLLz8545K4/itoW4=;
        b=c/ot5uAHubxwZYCVSvDdAIRMOYcVxKHXlNUSvstSlijgom0JHSbY53TAt4G0GFdlx1
         jw/CkvucpO63B8RPw7EdIOFo6TL5smV9rLuZcatNmONFZ2Fun0QH7SzSH3MnG//rh8KS
         YNZQZhPi7hvZr3jJTfcjnD59rLXPZ2NPlIWIKtghpUAF8CMiu+0//0Up0EE9I2b1UhVY
         klIGdp4/MzFdGQqiFBKBQ+l4hsM80kJZZD42jmE1VpeecGDxXD85SRFU68tCNf69mBX9
         MICmYOaLxGQhD5ai4arR08Ho1ePcDXyxx+OtsZyr5CBl3D/kF+r6PXrxZGzjOZJ9oXxs
         3mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771198431; x=1771803231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOqo3ZpoHBCEkKQn3Tj+aWTPXLOhLLz8545K4/itoW4=;
        b=ARZSK2NP+wchVHcGMCyzpLsSub74l6UjeYAROvdVnw3XFbaHPEdNBSNnZVk6gSkb2J
         JwPU28/rCR2XMULz76nt+kEqcaWuU+tF/OVaBTGOPzRwsOwO+r7eHie9hPIOzcS4HqeW
         7dBz+1zHpNYdOBsy9Kym902WL0BVwF7KNircdScgX4wDE7ClcHKZ62/U+J5OOR8UuQwa
         69DaBEVlTqE8kNCUlcSNWkId5YxLhR8SiDFlsdDXNUQX10Gsi31HRje7FzUQfZdvQDeN
         WW+gi8FGW+0UwO5qroFSWinffrTKdWN687N2dC6ac61ip/Q36RtRXiPiXdLr1T/8ihcd
         azMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSvFguysKaULqw5ETKivBxlsZZX06oQaJdEQlN/qCn7sXoClNKhZREb+iD91IcpuFIgmw2eHtwFuhuVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9z5KtgACw9gEFJbc9sf3C7GFEudmz3g2j9VypcjsSc+9ZclUq
	+0L3l3FUXDNWLsOsl6GFcYzEVNAh8exNDp4WjHH2EAhvrLaqJeRi7UDV92qHO6J3uPM7Vb7uKfG
	ASysD
X-Gm-Gg: AZuq6aJg+KIrrXdv2WpDrDVHveEMHYsp8Zo4A8NbRDTgcPgryKENl4Nm7EqRqHRGRUc
	wPXAEAMqQsxXy2xdqOBBsCOoWlSbZlCw8WG47Y9TEDehG4FonMx64Po9IX52cvFtA+kjf5E5YWZ
	krUQlNP1GdbGi21tNRVTzn9gyKxDj7FOPjImLjwBYf7/ps+r7PmvmGweiIy6wW1i1yzAWqaRrg2
	EitzMvqKXA7hQtmakns8ZwdH0brJyjtr61YCEm4/coDpDQZBS+Bo2rYhHf6QvMu1v1ImUiUTgFS
	iydat9GLReycN/wAsv9/GtD687mPZTqVrxM+HJjeHVXV0S5EUj7g9J1TiPGfUDkoe4UTW1aswfK
	0d/LYP+/MvpqxmJlJfDgRO14R2WVn2BxOUIFJsyfg2l1+vhS2St6P44cjyJPvoS4mEVC1kSlmVD
	lSPD3zJERsPIXuMwLEhahg9LUgQdCg
X-Received: by 2002:a05:600c:3594:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-483737bea7bmr140951365e9.0.1771198430936;
        Sun, 15 Feb 2026 15:33:50 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43796ac800esm23829050f8f.27.2026.02.15.15.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 15:33:50 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 5/7] fbdev: au1100fb: Replace custom printk wrappers by pr_*
Date: Mon, 16 Feb 2026 00:33:21 +0100
Message-ID: <6ca08f50fa1a6f9385cb4433db6406c311582bdc.1771198101.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6894; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=9WHUEaOrVOm+WL4G/FUUC3aXFfCTRn5AFAGSSgL5t64=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpklfJHEK4fUFWoAwE4Jd9RrovUhJQH8Gs64uHL h+S3+lepqmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZJXyQAKCRCPgPtYfRL+ TiQZCACOSbmduirm/ihLWyQPheMypnxlzY/f7fimpLUVUsadKMt1aODlcZSKHyYJLQMmwB/HyLx ncaNX6aGwDrdTlR42825JxVfPtjELct5Bv6YxV7B6HUEj5zwCkcxtaybnw3mxyaOJREsg1JCEtI U6Oi/6R/oshayEPwfRO0FSQ6MzHIyj5z1rz5mTiECQkzaVey5tz5+DGPaNNalPRSQ9BTWhshCTo JnV1jZ6dez03qo0TLwLrMjm1D46O4VnggMhRT+2PDE2NWwbTeopRfuQE1aE1fVU/tNDGADpxXXn iCchRdbw51EIYCOxomk3ILBKduGoR7CApKMLp8l5hMotiQQw
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The global wrappers also have the advantage to do stricter format
checking, so the pr_devel formats are also checked if DEBUG is not
defined. The global variants only check for DEBUG being defined and not
its actual value, so the #define to zero is dropped, too.

There is only a slight semantic change as the (by default disabled)
debug output doesn't contain __FILE__ any more.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/au1100fb.c | 41 +++++++++++++++++-----------------
 drivers/video/fbdev/au1100fb.h | 10 ---------
 2 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 7611dad0d68d..f589f90cce2c 100644
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
 
@@ -291,7 +292,7 @@ static int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info
 
 	fbdev = to_au1100fb_device(fbi);
 
-	print_dbg("fb_pan_display %p %p", var, fbi);
+	pr_devel("fb_pan_display %p %p", var, fbi);
 
 	if (!var || !fbdev) {
 		return -EINVAL;
@@ -302,13 +303,13 @@ static int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info
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
@@ -322,7 +323,7 @@ static int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info
 			fbdev->regs->lcd_dmaaddr0 = LCD_DMA_SA_N(dmaaddr);
 	}
 	}
-	print_dbg("fb_pan_display 3 %p %p", var, fbi);
+	pr_devel("fb_pan_display 3 %p %p", var, fbi);
 
 	return 0;
 }
@@ -365,7 +366,7 @@ static int au1100fb_setup(struct au1100fb_device *fbdev)
 	int num_panels = ARRAY_SIZE(known_lcd_panels);
 
 	if (num_panels <= 0) {
-		print_err("No LCD panels supported by driver!");
+		pr_err("No LCD panels supported by driver!");
 		return -ENODEV;
 	}
 
@@ -388,16 +389,16 @@ static int au1100fb_setup(struct au1100fb_device *fbdev)
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
@@ -422,7 +423,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	/* Allocate region for our registers and map them */
 	regs_res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!regs_res) {
-		print_err("fail to retrieve registers resource");
+		pr_err("fail to retrieve registers resource");
 		return -EFAULT;
 	}
 
@@ -440,15 +441,15 @@ static int au1100fb_drv_probe(struct platform_device *dev)
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
@@ -465,7 +466,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 					    PAGE_ALIGN(fbdev->fb_len),
 					    &fbdev->fb_phys, GFP_KERNEL);
 	if (!fbdev->fb_mem) {
-		print_err("fail to allocate framebuffer (size: %zuK))",
+		pr_err("fail to allocate framebuffer (size: %zuK))",
 			  fbdev->fb_len / 1024);
 		return -ENOMEM;
 	}
@@ -473,8 +474,8 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	fbdev->info.fix.smem_start = fbdev->fb_phys;
 	fbdev->info.fix.smem_len = fbdev->fb_len;
 
-	print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
-	print_dbg("phys=0x%pad, size=%zuK", &fbdev->fb_phys, fbdev->fb_len / 1024);
+	pr_devel("Framebuffer memory map at %p", fbdev->fb_mem);
+	pr_devel("phys=0x%pad, size=%zuK", &fbdev->fb_phys, fbdev->fb_len / 1024);
 
 	/* load the panel info into the var struct */
 	fbdev->info.var = (struct fb_var_screeninfo) {
@@ -498,7 +499,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 		return -ENOMEM;
 
 	if (fb_alloc_cmap(&fbdev->info.cmap, AU1100_LCD_NBR_PALETTE_ENTRIES, 0) < 0) {
-		print_err("Fail to allocate colormap (%d entries)",
+		pr_err("Fail to allocate colormap (%d entries)",
 			   AU1100_LCD_NBR_PALETTE_ENTRIES);
 		return -EFAULT;
 	}
@@ -508,7 +509,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 
 	/* Register new framebuffer */
 	if (register_framebuffer(&fbdev->info) < 0) {
-		print_err("cannot register new framebuffer");
+		pr_err("cannot register new framebuffer");
 		goto failed;
 	}
 
diff --git a/drivers/video/fbdev/au1100fb.h b/drivers/video/fbdev/au1100fb.h
index 63aef2f52141..80743b3e2376 100644
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


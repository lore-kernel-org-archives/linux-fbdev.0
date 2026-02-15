Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBFA2C2346
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771163944; cv=none; b=XxJUkav4LEf3fY79smiSOhA3FGGEYvZ0Ie9QchkzttcJir5R7boXGoNKOr+RRGAf/g0UDJnEmmZUVund32OW0VHGyBPwrUtScc2baduLMVWwSxbU1yBMu2PfKmrQrA1cX/mq7ulovuDuMmC3biQzdUpa4XUZOHiyosn3RAJGhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771163944; c=relaxed/simple;
	bh=knkEjt6E6SqfheIipY0HTc6BP4rRXr7oklWLe8fknuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHlkfgANYuKcKd/XT5fqAzFZ6QxGmkOwK1qGokN4OtSd3+WdVAxlmyODaIF9iBILWNNiwzwwoIb+Wvhevz0u/oAGQLwj3ZBt8878eUClUiq6O51F2lpq8EP5Lu5mPFtKksYlpsWQHHiE8az53fOXmnjwZfWMnj5V0rwmwJmySWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lVL9ehoP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lVL9ehoP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48375f10628so12170995e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 05:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771163942; x=1771768742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScnBj3oP04p3y5F7vVbJFUDlhPXEJXdunkul8Q3TBN4=;
        b=lVL9ehoP21qwxTCcRJvCyTiPiWW3iWBwIIBRCQZVHqthfKhqp3tMBoxBVZKWZOQ23t
         AJRzFFD9OlLbF5vKvSGRVykqH1RLUPPiSK4Acp3IIVc/Mu746XPxfbjYSuQH0/dtcyO7
         xRAWP5nYd8cjff4kXobHIgyAQXGxLWleIsW3aMyHuDYY+88/DRp/vvK9xMznxCCbPg0v
         hUVM2Yxal0G8Yz+wnaav5P/7HOukLJmlvAzk+zH8iKRKkTL3oosbsLtA4T7NI1PpV8Vw
         Tkq0q2YYlvr8VE1ybUCoGa4nl2UwnI3Xt8wiz9bKIBsjLPwrakCRgwy8Oju559xSjjF1
         +Akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771163942; x=1771768742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ScnBj3oP04p3y5F7vVbJFUDlhPXEJXdunkul8Q3TBN4=;
        b=bSpUKDP4etT6LJe3Vv7uEaqPWWcpPzZdp5h9R4iEiAjYTCGbmMj4VhJe3b2OT9YqFD
         cFm22bf2mkM3NbcwNrmO46/LpBkCgLU06aErpS6POq29LWoTpz4km5nTmXsqBzLYHWsm
         SkDUfcqww7spAWt60LxktS2TER2yCJi5HvLBdPxUKGRi984lSYAUrrc409U0UMLifEaT
         Oz2KUZ18IuhY8f8p4FCCAFkTk8TrWoto7oe2WgoFev3dLiOqJlL2sTMXliIfQPd652Ii
         X1cAfzpW5N82URs/nE9y2FTKrYhacIm57xtH9/XRUs6Esdtv6qNkf2uN41SfGIp6H8yX
         d/uA==
X-Forwarded-Encrypted: i=1; AJvYcCW3acUevlU8tonT4aepyUTiAT50SbUmzdUkKBXHwkpDSkqDwIlSOxH7UJQCN0mPNsiw4od3VKXYyw0l0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMp4KRE8V40GqVvspW9DPM7BuDJCtezrr++U/VsVJe87BUkSmi
	N1OTNHIEDoCEtqHgyRSb72/Zjj4tRD5ORXdnO0ZRSqG3a5qYdnqRWRQL9Tt86jCbhi12+vcXS4T
	oYqCF
X-Gm-Gg: AZuq6aLa/FpyObmAaqdaai11VH0KzK96vPO+rRglSQQGor9xIt+SffPeIdijNN6SaKW
	gZqPGCnuGsTLDYLmD4iqoI6TmyPNkEoZuReHu7ioEtTeYnMT9UGetyje/WX8YGH8CXmH/tRiT/L
	Zp726H6qRb1OBdykMURM1i+bJlZ2dLd23blpYdMdvMKvgNTMUmsTb1e2WQO206sVXaENtDNKJa/
	/NW5Xbu8a2HK6kcyHBZahFoOlB+tX9ypdo7iTheUjoIv4ZWHZ3aywNYN3umNAxU6kn9SHI+bnzw
	4Ei/utuBjT9sFV/bHxcLBRL15pgBadZhmLNDTH9sRmTrQcd+gBsoWUMo+Rt6p5NDOlu1mdD5ozD
	8F+krva+pI/GsnJWnLzYAyHFCQapJqMU0M6StonPZGgjRQ9BMqJ18sx7YUzWOQD0H8AaGwHvXap
	u+cCW18qu68/efc8HzMRYWj+XYtnl5
X-Received: by 2002:a05:600c:450d:b0:483:a21:774c with SMTP id 5b1f17b1804b1-48373a44430mr124838965e9.25.1771163941215;
        Sun, 15 Feb 2026 05:59:01 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483709f6935sm91936255e9.0.2026.02.15.05.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 05:59:00 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v4 5/7] fbdev: au1100fb: Replace custom printk wrappers by pr_*
Date: Sun, 15 Feb 2026 14:58:32 +0100
Message-ID:  <6c72b8bcd1b608d1ec7227b8d1aa6c7a73148a05.1771163316.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6894; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=knkEjt6E6SqfheIipY0HTc6BP4rRXr7oklWLe8fknuU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpkdEQBWydOy4yift6xDFkTdTLt0mB5wRzzbHWS gkG4pJLKZ2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZHREAAKCRCPgPtYfRL+ Tk+NCAC34rTeEDbwOc39WAvDUIaEFLFy739AZCqUK5LPsTtrkD0cVNrLQFYm4pS1l5X7lY++FNi zB6HiKY3oq4aNeETf1WuZJ6nT9JooXnnhKEJIgWXf7+IJag4hHcOOGq3M+Vp2QXgU5Hm1lu06UC 2T5tdyAxwSGgcA14XuPJiY/pKKrw+42Oja64ovL5bc3evK+N/jAFzlVgY68kAEhDBLeN5dSAygp 7TmSrhhOPwnY4vJSZ2GLCS8VSmERSleugzSMi5NR23BxWv1gTCD5fH6wXfWk/eLnHrn1vE87ydQ d689p2YkSKbmJjjj5F6ZyyhDgx2BVztLKQNWCU/BEmPWfMMS
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


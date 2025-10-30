Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C1341674
	for <linux-fbdev@vger.kernel.org>; Thu, 30 Oct 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854849; cv=none; b=t5q/BMgTNmsndn617JVEhzNjurUbcCK53U7IZjy1ApvZAI381TdO5G7KvlPcQGOt1+u1HyoyX+07IYnm8i+szvxDLTR2PRrMUB4oTAtYjrIiyXDPWCNrz3QnKuiGpHpeYEeJpvuXC6r8hF+4It0FQgL+FltxBg3jbF/c0D5xnMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854849; c=relaxed/simple;
	bh=3Js0uYAIC0bd6EOohKenbxNO7P8/ananC7e9waGafnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnWkF+OoDVcdAsu+wB4ZsmnvA6MTi71yUgEuSU4iJUFc5midSIUJdH4mB/f/htGQDEAXtDRkV/F5wDHLDwuYP+lD8GN11ds3kZXLFF72EUgCOV4J2I0ZiraqgdDfmV0b7AMm0kRqSMs2cPfi5D5ehL5N67JDwz+6VXvq7ai9GBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFE0Xpwz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFE0Xpwz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475c9881821so17299975e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Oct 2025 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761854846; x=1762459646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK5/MD5jQaHlgmEIIClreHp/khBkythuO8kivjpFv+4=;
        b=KFE0XpwzNcs9lQNbtUayZtpNSa60PdYVEsKDpy7alo/b1kWdo/5Hcl120BQL9O6qCZ
         QAmATvB2ECh4P1UxuL38vmZOwRPoo7hjBVIdawUKfmES7VEhNwZbhhGYUuDAMmSW5NvP
         5852hBUxPiE55bHSvB36OziSGqZ+avTyWW2NBFjGTiG7aLsPEXe7RmKahPRsKJ3COX1t
         u963RNbtEizc6MjYCN9IqTg6aGAJSnOjbi9I29Wi3wVQ8aoGHJD0+UzEb4n1minN5ChY
         eaBOvJm3mcx4cuaLaXqKLiolXxQKAsHfqnFIiG9k3TTL4FO5ybSfCqckxGEc/9xbS+qa
         N8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761854846; x=1762459646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IK5/MD5jQaHlgmEIIClreHp/khBkythuO8kivjpFv+4=;
        b=QXmcZS3oEA9kK2i5fKMBHvXmGg30jUIpcwx8crtuAu7HeMwS6XR5y+zbUNRaMml6mw
         jxm03tyRjwh33eMuRyWvQJ2Q44cFzhnqcXK+prewm8YU7vaIeGVeILjDZQgdViaOE/Fa
         5Zo0eHkl1oMHso4eBwF8N+jKtytpPVJ5fhny4LBA0MVvCYDTlsS5eJtPqlrR+XzqGULN
         8PACQL+LH3vxaXoXbaRaagfWfKiHLuTBXEmCr7EYLJWHx1AQrFnLG1KPToVHbKtJjh7X
         NBUG0rKpasjvvOEYfEFduklXJBr+R9uBthgbc4qzq2dpa6ZmYU30dpsGESb+gUWKiHnJ
         OHPA==
X-Gm-Message-State: AOJu0Yxw37k+Bu5UPV8wTB0ahA9RjNxhxH8S2Bcr4GlMzGOv/AppKyZb
	eDDP3OAueE4VnIJscHQzCovO+tpe3+2VvFDo1LcLN6C81it5Bk8h3T+F
X-Gm-Gg: ASbGnctpiFkEXGNUr/OxT9HbY7SApKixP9Qe+A5oEq2OMxHBN65NPyqccjh04JNTNp3
	YUXN5CAPFwPtuP+ZFW6GCtS0Whh9CVjxcH0HfB7EKe1BG8GpLHQpl7nge+oKiDo8n3abpTgTCaD
	Y18tVO5I/DzCbHvtWlio3w07WJQH12wvyiPCVcSDb8D3BnmH5WXc9dyG7CR/ipARRl0J0jmgQ6Q
	5tVBkw34n/6uQl1/mF6A3GoIb7ywNxCEV/PfjfFPgCFTVR81o17z5rKbwyF0JygDJRG1ljciq/0
	hjHnnXBrVZcHU618Zg9w7fYKU/GtildiITuYT0TL0U8VTQ8ULQIVhrWMkFtOQ6W6A7tArbufKEV
	seys8LLsGZYlITJjqYHiaf/yqq8V4zNr74ffmN6RBBEynXE5hQmqktnPh8K7T5DijzWfukj1cqL
	HdNJ+yrpNn4sHDWglRN16x7FdMHy0P0GyA+OPOnPzC6/+dyKmB0h4dn64kbog=
X-Google-Smtp-Source: AGHT+IEKK73PbMSHf6dhhfOw/8d7gi7F8JIqgvvWZVKIGfNyOVCe87Tf3SMiH0lxF2XB6hun78s0fA==
X-Received: by 2002:a05:600c:1c93:b0:46e:37d5:dbed with SMTP id 5b1f17b1804b1-4773010414fmr11136175e9.12.1761854845631;
        Thu, 30 Oct 2025 13:07:25 -0700 (PDT)
Received: from dell (229.red-88-1-12.dynamicip.rima-tde.net. [88.1.12.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952da645sm32485309f8f.30.2025.10.30.13.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 13:07:25 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH v2] fbdev/vesafb: Use dev_* fn's instead printk.
Date: Thu, 30 Oct 2025 21:07:23 +0100
Message-ID: <20251030200723.2788931-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028185021.2758401-1-rampxxxx@gmail.com>
References: <20251028185021.2758401-1-rampxxxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Family dev_* fn's will show device name, giving extra info to logs.
- Delete the prefix `vesafb:` from msg strings, not needed now.

[    0.981825] vesa-framebuffer vesa-framebuffer.0: scrolling: redraw

Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
v1 -> v2:
      * Fix checkpatch.pl messages, thanks Helge Deller.
      * v1 https://lore.kernel.org/lkml/20251028185021.2758401-1-rampxxxx@gmail.com/

 drivers/video/fbdev/vesafb.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index a81df8865143..f135033c22fb 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -314,8 +314,8 @@ static int vesafb_probe(struct platform_device *dev)
 #endif
 
 	if (!request_mem_region(vesafb_fix.smem_start, size_total, "vesafb")) {
-		printk(KERN_WARNING
-		       "vesafb: cannot reserve video memory at 0x%lx\n",
+		dev_warn(&dev->dev,
+		       "cannot reserve video memory at 0x%lx\n",
 			vesafb_fix.smem_start);
 		/* We cannot make this fatal. Sometimes this comes from magic
 		   spaces our resource handlers simply don't know about */
@@ -333,12 +333,12 @@ static int vesafb_probe(struct platform_device *dev)
 	par->base = si->lfb_base;
 	par->size = size_total;
 
-	printk(KERN_INFO "vesafb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
+	dev_info(&dev->dev, "mode is %dx%dx%d, linelength=%d, pages=%d\n",
 	       vesafb_defined.xres, vesafb_defined.yres, vesafb_defined.bits_per_pixel,
 	       vesafb_fix.line_length, si->pages);
 
 	if (si->vesapm_seg) {
-		printk(KERN_INFO "vesafb: protected mode interface info at %04x:%04x\n",
+		dev_info(&dev->dev, "protected mode interface info at %04x:%04x\n",
 		       si->vesapm_seg, si->vesapm_off);
 	}
 
@@ -352,9 +352,10 @@ static int vesafb_probe(struct platform_device *dev)
 		pmi_base  = (unsigned short *)phys_to_virt(pmi_phys);
 		pmi_start = (void*)((char*)pmi_base + pmi_base[1]);
 		pmi_pal   = (void*)((char*)pmi_base + pmi_base[2]);
-		printk(KERN_INFO "vesafb: pmi: set display start = %p, set palette = %p\n",pmi_start,pmi_pal);
+		dev_info(&dev->dev, "pmi: set display start = %p, set palette = %p\n",
+			 pmi_start, pmi_pal);
 		if (pmi_base[3]) {
-			printk(KERN_INFO "vesafb: pmi: ports = ");
+			dev_info(&dev->dev, "pmi: ports = ");
 			for (i = pmi_base[3]/2; pmi_base[i] != 0xffff; i++)
 				printk("%x ", pmi_base[i]);
 			printk("\n");
@@ -365,14 +366,14 @@ static int vesafb_probe(struct platform_device *dev)
 				 * Rules are: we have to set up a descriptor for the requested
 				 * memory area and pass it in the ES register to the BIOS function.
 				 */
-				printk(KERN_INFO "vesafb: can't handle memory requests, pmi disabled\n");
+				dev_info(&dev->dev, "can't handle memory requests, pmi disabled\n");
 				ypan = pmi_setpal = 0;
 			}
 		}
 	}
 
 	if (vesafb_defined.bits_per_pixel == 8 && !pmi_setpal && !vga_compat) {
-		printk(KERN_WARNING "vesafb: hardware palette is unchangeable,\n"
+		dev_warn(&dev->dev, "hardware palette is unchangeable,\n"
 		                    "        colors may be incorrect\n");
 		vesafb_fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR;
 	}
@@ -380,10 +381,10 @@ static int vesafb_probe(struct platform_device *dev)
 	vesafb_defined.xres_virtual = vesafb_defined.xres;
 	vesafb_defined.yres_virtual = vesafb_fix.smem_len / vesafb_fix.line_length;
 	if (ypan && vesafb_defined.yres_virtual > vesafb_defined.yres) {
-		printk(KERN_INFO "vesafb: scrolling: %s using protected mode interface, yres_virtual=%d\n",
+		dev_info(&dev->dev, "scrolling: %s using protected mode interface, yres_virtual=%d\n",
 		       (ypan > 1) ? "ywrap" : "ypan",vesafb_defined.yres_virtual);
 	} else {
-		printk(KERN_INFO "vesafb: scrolling: redraw\n");
+		dev_info(&dev->dev, "scrolling: redraw\n");
 		vesafb_defined.yres_virtual = vesafb_defined.yres;
 		ypan = 0;
 	}
@@ -410,7 +411,7 @@ static int vesafb_probe(struct platform_device *dev)
 		vesafb_defined.bits_per_pixel;
 	}
 
-	printk(KERN_INFO "vesafb: %s: "
+	dev_info(&dev->dev, "%s: "
 	       "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
 	       (vesafb_defined.bits_per_pixel > 8) ?
 	       "Truecolor" : (vga_compat || pmi_setpal) ?
@@ -453,14 +454,14 @@ static int vesafb_probe(struct platform_device *dev)
 	}
 
 	if (!info->screen_base) {
-		printk(KERN_ERR
-		       "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
+		dev_err(&dev->dev,
+		       "abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
 			vesafb_fix.smem_len, vesafb_fix.smem_start);
 		err = -EIO;
 		goto err_release_region;
 	}
 
-	printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, "
+	dev_info(&dev->dev, "framebuffer at 0x%lx, mapped to 0x%p, "
 	       "using %dk, total %dk\n",
 	       vesafb_fix.smem_start, info->screen_base,
 	       size_remap/1024, size_total/1024);
-- 
2.50.1


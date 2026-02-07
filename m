Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA52701C4
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Feb 2026 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770484380; cv=none; b=HKvcgFhkwJ1CdAstBj61fSWIayCPY9PoEpl0U6L44tq7u51e8nvWN7Kg1H/2xQEJHVSuA3+jPIUEWLf3yYad93UP2PN1EJkqysmDHGM5Zf5qzJUjnHySV6Gg/Lk6QfPunVo5XVaiAeIfQ4/hnklpi5HGNrViOOPjKKRjGmTvHi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770484380; c=relaxed/simple;
	bh=oZl+lgADvmA8kbyHw8foSoviF7bUk80UCdSGNLDQ4uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQhzfoyQVFVry0c/Y6nb2A0rhtH0O37fSJbkQ43QCeEKHjnyCXhlMZW2vcmKZGyQVOgufYUDhBxRHa0j5PW8v7UhcaaYxhB2Hak10RKhuq/D6bqW0kJb0B/bVfNtLGv9V+IOT47Md9/pe1FWJfn8T4yB6MyKj8Q+emza+uUUFhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L0pRZRYi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L0pRZRYi"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48327b8350dso12842815e9.1
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Feb 2026 09:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770484378; x=1771089178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiB07MXR0w3Yv+4X7yqykGv069A3QBCCsoHEyXAvo3w=;
        b=L0pRZRYiLcuDwLcsav2DDAub2+EBKtHKT2QdlLpCXpZfNUU9QsilWQfNw64KNgE5gf
         cXnKHahbL4rC1R/aA+wX7aCTbxFLqRwagtNsB8lgvdynH4eoTmukwZcObavEpZcrwUXJ
         Wmdqq6ZHooM7hXzVEusdiaM5OMI7YEyfXgx8BKkinITWhaypy6y4Q38LInkhWrJzBDsq
         wnlsMp6TgScpiBIN3Y6FUCWS8efaYi6J1mvOzgRQHaWIejTFdRLEFY+wQVcOqll4wTOb
         mk1zD0xnqlPCPuF5mMb8kOgHSyBDP3fbTsWcR11L1zS0wSoRnLicxFT0JpKsmhlLuFhN
         bkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770484378; x=1771089178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AiB07MXR0w3Yv+4X7yqykGv069A3QBCCsoHEyXAvo3w=;
        b=FeJQRPjulI/RD/B71o1pwL6xSkFTGFI6m/S83+T2IxNBb+UFJLK455HIk9JTsbyJia
         QpTWNIYFKxdltc8anrHtXj13rJY+4KNn96I7nQ2elHBI8Wh/nPEGHpj3PX1KcE6tBWqD
         I08+owoBIsiGoLVZx868MxsHwsNaiKRqzp5LutsGkoRHaf1+b1mk5/PiC5ONp5Mm1Z1f
         NbNVMAv88+bOehZoZwb0p+Ld3lrB2iDO1LB5b86gvvaqRc5mK1gxhtjMPWvuA/bsKsia
         EGMyUVqcJfC81VkzD/SbCpADL3uBip7pF2w+yf5oZaa9LEjuW/jtCwbwZBx/1NfAEXU1
         rHIA==
X-Forwarded-Encrypted: i=1; AJvYcCWKzg7Md9f7IUyna7xtSwvGrdRrGgNC/j8peqjge5vx9BPhBGQY7tocB2w3WuXbToA56GPXRE3cSahlag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoL6VriTER/N3BvweZMxYb7o022diR8ghzv14TvQ9Wtzf3Esgj
	Bc2gfYBegZCnrSso/t4ba1pM38Pze8M2GwOPsfN3T3dlTCvmaPh9HzIxgbjoOKRKfLit3iT7q8H
	raJWb
X-Gm-Gg: AZuq6aLOICA6AGvIJ8rk3fYCl5QrRE1R7/Bfdr4/cPmrgQ61w81zFhAA0rdZqfSt58p
	CnAJa+AlARvCLUOpRYfO+gb3gXmCNn+V4mFlFlo4UgIpbad0nc/rsZeJ0SrCUIArtjn6a6kB8Gk
	mv7jXR92PlXXpHBe0oOBH6OFZfa/WgBHO3e97DYeUvKfFT/a3cBpifyV0XKUZFMjgu5xIrs45xC
	FlcXBdNEnxEjXs8VhZlAbGop9dKwuRNxprqcs+ofowLb49UgakDlFgoHy3pXUzq8cs0E1OUtMMe
	fXOfD/Xik6tkdL71yrOykjDxDp0cisUlybU7dOzpZxfKecGbsCDmOIu3Mu0ozz7i/22X+koVCWz
	mQE0G0oCAigMjp7DnfohtM6/z8kHU70w1dPmXXRcX5zc5VX6u4ddLpTX/kANTQtVz1X8xFjzFVP
	oSf76QLlH/6wt5c1nO
X-Received: by 2002:a05:600c:5253:b0:471:114e:5894 with SMTP id 5b1f17b1804b1-4832021c93cmr96031505e9.25.1770484378102;
        Sat, 07 Feb 2026 09:12:58 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483206cc543sm131926195e9.4.2026.02.07.09.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 09:12:57 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 4/4] fbdev: au1100fb: Make driver compilable on non-mips platforms
Date: Sat,  7 Feb 2026 18:12:37 +0100
Message-ID:  <b894247689a7a920d9caa465dbcb840bca806cbf.1770483674.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=oZl+lgADvmA8kbyHw8foSoviF7bUk80UCdSGNLDQ4uE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBph3KM+wxlKuCbUdrARAzV28ZRbiKy3frerJonv /I4UpXIRLKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYdyjAAKCRCPgPtYfRL+ TiZ6B/4rc42teJyAFRENb2o0jpzcl56hH0YTnc4/3umhyWIKJCIFARNgl2O8FiK35lJ+cM9Tphv Y+IODwwVqLpUDZGPaX6hgK8B9JilLVV6Kx9Q/sha3UJ3RjCye3LeS/37mocWhe5knb1l536Y886 SgIwYTtFWvHi9hmPlA8/GGAO7HU8wOKegMVhR77vghyLMHiMJNAUeKkU9oAO1OBD0AUFU1LEUDa 4FzqzGE8VSE0mV0VBls/9F02x6y2o/LkKMrCkb/M0EDQjqs8gAAy9pHFWN7Fxb5zLY5dpEMM6Xs z9WAmYUl0EP0EDr/jbz2kOsO1NfqR0c/KCd3/pwfUZquf7N/
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The header asm/mach-au1x00/au1000.h is unused apart from pulling in
<linux/delay.h> (for mdelay()) and <linux/io.h> (for KSEG1ADDR()). Then
the only platform specific part in the driver is the usage of the KSEG1ADDR
macro, which for the non-mips case can be stubbed.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/Kconfig    |  3 ++-
 drivers/video/fbdev/au1100fb.c | 12 ++++++++++--
 drivers/video/fbdev/au1100fb.h |  2 --
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 45733522ff48..4514c42db9fa 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1345,7 +1345,8 @@ endchoice
 
 config FB_AU1100
 	bool "Au1100 LCD Driver"
-	depends on (FB = y) && MIPS_ALCHEMY
+	depends on FB
+	depends on MIPS_ALCHEMY || COMPILE_TEST
 	select FB_IOMEM_HELPERS
 	help
 	  This is the framebuffer driver for the AMD Au1100 SOC.  It can drive
diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index a0e1aceaf9a6..758002cb5ea8 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -42,6 +42,8 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -55,12 +57,15 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <asm/mach-au1x00/au1000.h>
-
 #define DEBUG 0
 
 #include "au1100fb.h"
 
+#if defined(CONFIG_COMPILE_TEST) && !defined(CONFIG_MIPS)
+/* This is only defined to be able to compile this driver on non-mips platforms */
+#define KSEG1ADDR(x) (x)
+#endif
+
 #define DRIVER_NAME "au1100fb"
 #define DRIVER_DESC "LCD controller driver for AU1100 processors"
 
@@ -331,7 +336,10 @@ static int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 
 	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
+#ifndef CONFIG_S390
+	/* On s390 pgprot_val() is a function and thus not a lvalue */
 	pgprot_val(vma->vm_page_prot) |= (6 << 9); //CCA=6
+#endif
 
 	return dma_mmap_coherent(fbdev->dev, vma, fbdev->fb_mem, fbdev->fb_phys,
 			fbdev->fb_len);
diff --git a/drivers/video/fbdev/au1100fb.h b/drivers/video/fbdev/au1100fb.h
index dc53d063fcc3..998328cd16a2 100644
--- a/drivers/video/fbdev/au1100fb.h
+++ b/drivers/video/fbdev/au1100fb.h
@@ -30,8 +30,6 @@
 #ifndef _AU1100LCD_H
 #define _AU1100LCD_H
 
-#include <asm/mach-au1x00/au1000.h>
-
 #define print_err(f, arg...) printk(KERN_ERR DRIVER_NAME ": " f "\n", ## arg)
 #define print_warn(f, arg...) printk(KERN_WARNING DRIVER_NAME ": " f "\n", ## arg)
 #define print_info(f, arg...) printk(KERN_INFO DRIVER_NAME ": " f "\n", ## arg)
-- 
2.47.3


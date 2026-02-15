Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E57C182B7
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198431; cv=none; b=ns5XRe0IxeDLYljUsinHm5gaa47efbKUZwTlqNRpkBr36dMnrwqKOdvVcAlvw67Ep3JQ0OnfkMVREJY8cih0GN77S+jiX2zXqeQCo2Z/w3e1LeaUg09AwBXbirm1u6aAGyK+63gKBmetFqMRLmQOr3+RMfnFx+3rEvs9FevRSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198431; c=relaxed/simple;
	bh=nodsy71+skdPZF7EJPJp2mOWEfyPOuOSUpcyMAifoE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUm5C7PEK2a2wZCi5s+qfmfH4FXkinKxBKop4xw4iVsJj41d95fOEZoXf+Oykk7EG0AUQ3P1smJwSKF+mSR/ney7ayox0Yf16jTXcd+NzbSNP1wPS8CKhAFam+LD6TB0hcDlewENIgl2+yQxKFa0BM78shOt9bTK1ZFSPQqaXD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OEMtHyFU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OEMtHyFU"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so25738945e9.2
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 15:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771198429; x=1771803229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uk53jnOeLmfvArEpFiciKSE6y7l3oB/rvlc5Pr3+3Y=;
        b=OEMtHyFUkPAI4itzBYQBcd7PKp5dUoAOkLeyiRWAAXk3BeHeGRslZWF6giL3a6IzYU
         T8jwVmbLoMe/eClk4/38AuSPzTQrluVYO/TgF6znKTNqN1u/ZOxr42YL7WB39B+wKUWr
         pzsvHMSk75fmox4VZc0ipIU8MbfjB0BMkNiHX8rCIUCFWeXDwygUTUWq9xq5KJ52Qx07
         nAaaXlzBsNEZM+Fb+72Mn2jq9z37xIn6BUJiX7Ov3TUQux2IlmbIVnDVpAO3X83K6WhP
         o7dj14XbhtQmPI0be6JW4n+4TZYUr3e8lmS5p8VgFIIOXZzyb7Lac2DHm+wDPe7gOYDk
         2tWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771198429; x=1771803229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+uk53jnOeLmfvArEpFiciKSE6y7l3oB/rvlc5Pr3+3Y=;
        b=vfN2G6whBuVfFmXSLdTWTDfJVgi7c34ktZ1o47DHCpAthco8yvbotu0Q8XTP6hi9P4
         kKa9w/56gaHLJbN5l9oXWiot7NxGTmTL84QD7TdKb1uwaaommmrJltzegDEZClHa8PTB
         JUkPw/5UMQyA76pp4DVr4c3MW53v9ftMf1w//YMWKNC2khFKYGZl89oAYYsxbw2w7UkM
         BpX6FYopftp+mojCUrdcwdPgP3xeD4MZQY556su5fX89HkA12A2rozppZ4ZCryxH1rvw
         +6atq4la+6ezSU58Cy40Nxew0yQ+gXW1ovxkVAkgQe7s7ap0xwStEFZr3ZDh07rVoD2S
         wFnw==
X-Forwarded-Encrypted: i=1; AJvYcCVQR9jyv1iWNrMIrPK6HhBcJyt+0saRbJU3OYBcehcNvf7GwxMaN31VkwSLUQfI8uHDQXS0GfBvSqU37g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQR5WzMecxr6QGWxqIekyeSiS5158vi8Wi2IvjRCvtNskeOyY
	kcAMyGAemsQf13GMMtNLW9LZIQwQ1/GOOhTMbUOtREIE+++gr1hLejrTjrnKw6jUW6I=
X-Gm-Gg: AZuq6aK/sfhpBUT6mQBAZqs6HXmtsqmcdSw+djkBlhyq1K59RmzOwuCBgKt1fP3uxJD
	DlmqTa+5+LtXyTlzTmCwagGdzSeFVGjEOUmAWggkaIIVuO4V5kasQjJN6h+aSp3YMlAu7FtkwAa
	VkLteAB+hT29pqGzzpdPSHfsp3tY3MgOVbxA4+u27SUlpmqM4osxQ2TZFb+ks5wZtow3Wtei6le
	6ITdsGNA8o+mVcH7kKHCn8TITz0tcVqPJlZoWz6Co4t6Bd+4uu1GO89R3qmwaW/Fo/B2iak87Tb
	VHAldLDrR6PKR2nHHU22fov3ptTA6qTFAWp6WUIdHJfMEhbXuDW+BIdOjU4zMxr7PGFJg5mldPi
	5NnxHKiq+SEIyMGdOqCtK80F5VA7845/UxJeI24EIz78iQuRmBtPLDUNzVdrY/F82PDI4hy42kv
	Vco4vZbJkeX7GpAl3qJRuywVY9bdkF
X-Received: by 2002:a05:600d:f:b0:483:7783:5363 with SMTP id 5b1f17b1804b1-483778355a1mr130445345e9.26.1771198428685;
        Sun, 15 Feb 2026 15:33:48 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4835d99497asm539810305e9.6.2026.02.15.15.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 15:33:48 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 4/7] fbdev: au1100fb: Make driver compilable on non-mips platforms
Date: Mon, 16 Feb 2026 00:33:20 +0100
Message-ID: <c858d7a655c5c984a03be813211e47952d963fad.1771198101.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2878; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=nodsy71+skdPZF7EJPJp2mOWEfyPOuOSUpcyMAifoE8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpklfHf6VCwf3tX/S+LU/WMTwKbeSksp6ifHEL4 Ko4XVmBytGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZJXxwAKCRCPgPtYfRL+ Tho0B/9qvhukL3iSwBk61XQHlxonw5P4wNdTyfGEN1nZTe+shcpBZLtIh8nAj1B14zKdEZ2aPg9 WJNfZNE+r6xQjFJ1OP/VzxR3t5TdYiz2wRrOMWU3VaZaWYyG32m5FHcnfqSNT0SVr7VEWk+bVBV zhq5K97sEYcVFZjd621DxFJficmoX4CTVpIOi3nuQfZ6ccaSJDw6nZePJjU0Z+LsPrqVU2OR0ui sNyrCmTNIKlt7GxXRGWZwm7IeSMzOmsiwqZSCjJf2m0I01aThbHBbL6I6ZHlJDR6UxjksxYwJ6T fSoG2XzWgiBza1D3VZw7PEHxay7jo3IHzoxC1t0DM1sBmuBR
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
index 45733522ff48..ac9ac4287c6a 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1345,7 +1345,8 @@ endchoice
 
 config FB_AU1100
 	bool "Au1100 LCD Driver"
-	depends on (FB = y) && MIPS_ALCHEMY
+	depends on FB = y
+	depends on MIPS_ALCHEMY || COMPILE_TEST
 	select FB_IOMEM_HELPERS
 	help
 	  This is the framebuffer driver for the AMD Au1100 SOC.  It can drive
diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 398375793f57..7611dad0d68d 100644
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
 
@@ -332,7 +337,10 @@ static int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 
 	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
+#ifndef CONFIG_S390
+	/* On s390 pgprot_val() is a function and thus not a lvalue */
 	pgprot_val(vma->vm_page_prot) |= (6 << 9); //CCA=6
+#endif
 
 	return dma_mmap_coherent(fbdev->dev, vma, fbdev->fb_mem, fbdev->fb_phys,
 			fbdev->fb_len);
diff --git a/drivers/video/fbdev/au1100fb.h b/drivers/video/fbdev/au1100fb.h
index b7bf6e005572..63aef2f52141 100644
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


Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCADD2C2346
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771163942; cv=none; b=PE9zTL3EE5sz0a6fw2haC3NQZZqyNbXHrSxXm1TfxfdUn8nOfQTTL6Ujgg68XANwjnMnYyg4iCpLvhe3/s9cT6UonrlEJq3OdcQXx0lGFIRXyUrBx0EVg5r4e7I3dAVm0cGN4QbC9tSby/8npgbj9rF7L6EzznGNofL2ytUqHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771163942; c=relaxed/simple;
	bh=nxLVIAxRrrPCwHxjKDubTojYoY2kHdt0zxcbF7maQAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbpEKcgWFbL5ynT3tqFIpm5f8n7axCpfkiKKDxkBockuijIRTYuErFV1siAN/i0BG/C2REGKazU2lhWcmMRE+btIV6tzg4N999sQraK0R0Nhuc+pQB62520h4US5IBKF3hohlvJhJWx8uutdt3Tc4tVLBD1UPbAmsGtkkpnz5mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F+ahcqmZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F+ahcqmZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48371119eacso22206245e9.2
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 05:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771163939; x=1771768739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzVzlNC4XTu3TVPShM5UZlmbPCmD3tKnvLjfSl0egiI=;
        b=F+ahcqmZLVOmC+FKXnoJEi2PfvRxfbvF+I2X7ycb4EMPXAWnyCsaLJD5aWWqttPdVk
         d7x1d7Sgz0VQUtlZaw7lDgYZ7RnD1nlImA/m0qLFaMBUu8qkQE2CvH9896EN+oTUWi0u
         LiwnOG1DLrt7hk+E+0Sj/AQqdKfRVk1ErcmIIFDJEXqwcFxiWr7cWv57cnBKDvYlePyu
         tXvcsrkQpVF4bn/0FcbPBi4YXU8n6ru2ETBO0XlcjWtu2LmRoC94Xhy6o5t+/B0wB8J8
         SnFlFA8bevbF4MP7Qt2aM9JTOxQ7+pYoHEo+cLi/Inh4eHELgR4A19KAKC8EYVWo0Rjb
         WR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771163939; x=1771768739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EzVzlNC4XTu3TVPShM5UZlmbPCmD3tKnvLjfSl0egiI=;
        b=drnYhNrzIBXaVFAitg+rdxK0HNCtlyDRLHG9eGFOJLl+nbYj7jofeJ3ivSGQw5gDzs
         jQlbvvvE8X6ofmhT/n/CsFamO5/BGEQzlfOn1sl471SkuflKiFOXpbJwdF8GZZc0XdMV
         GdRIkEmh0uDHKYxhEUwuAtkwTePMD3zpxFtWuSq61KxzXBjkllTA07TkqnHSVN5qicJ5
         iZU5z3MU1S0epTAlwkbmgE4kCdco0QYypXnS5JjWcHqRHKW3bJdjSKRtnbvuYFI5s4WF
         7AMLJYYagi7ZNAiFSbd9Ax2yUluV7/SiiQhYVxo3RRd3jGKX2MXe/BX8zY/duvTrsMR3
         wH9A==
X-Forwarded-Encrypted: i=1; AJvYcCULepqZ0Bfhvy15uj7/6uUszrcBma2ug60jKc709Lh7qtr3pSR90ljWgQP+B5oE7+u5U7J0RIkhaW160w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNr2RIOeEmNRb0FMMzdgJLy9g9Zkg0MeC03PLe+IB8T49MCMLd
	FJw0YMPbQ/jPE0RQF+Gy3U9PopBxlPxKmskrOQMC+glH7bBp56V4YEGSdn/ubZkkWss=
X-Gm-Gg: AZuq6aJfGUaDmUJHN4wNllrS7/n8GqosZzvT7b/eDqxDLED+qwZJHd0aQ4G4+hlTLU1
	Fx1HE2robGwvpbCCRfLRY9BuHbOCSKR95dZZmgMddERtrCoqtFG/H//DOBcvYpyf/o6k6a4+nOc
	WZr6A0UywMNFHD0VWxPIIx9qB4zVZnWOxkdmF0tCP75n2PrEUDuukrySt8yjmML2fHvaIB6hOFt
	/hH6w2qpsXJGyFjhgBZ+Z8Vlyb6qtuKJOdCQhUXgfCY5ieGGBEVIWS2hHhgDCo0mJDXIwQnnh0t
	++4Jm9aJhDCi56+U79cUpweQ7axGyE6AJcQCo8lJ08j1PQlACEQUZZD6YdeCEs+qme+krjLIo3v
	u6AmBrkE5O2D8sP3/et0r49AMhLZl3+PgOWiRGQW6Ba9l9gmERwIR0tjE4PTel9EtGd6qg9DUvL
	d6reEoMXgq6YAn59+3klnOQ1OiBiKc
X-Received: by 2002:a05:600c:6206:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-48373a0842fmr112466925e9.2.1771163939167;
        Sun, 15 Feb 2026 05:58:59 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4834d7e50casm376592965e9.8.2026.02.15.05.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 05:58:58 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v4 4/7] fbdev: au1100fb: Make driver compilable on non-mips platforms
Date: Sun, 15 Feb 2026 14:58:31 +0100
Message-ID:  <27c0747aa4a85e0b4f2dd7c0778784989522599c.1771163316.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2878; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=nxLVIAxRrrPCwHxjKDubTojYoY2kHdt0zxcbF7maQAE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpkdENjGEY/HsrG2a9fINb/lOMBBSEr3t47f6XX iwl7tuqpPuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZHRDQAKCRCPgPtYfRL+ Ti4AB/9r3BEwD/lbyGDQJpsF+XW7UVYSlS5SgXhoE5J0aknmjxSsiYIeqbVhJhAV14/lKv8uKsn 9bSSQB2tqGZEM0Eq8q1TzKKfZO2hKEh9jk1eH/HWtbif1pkqChxHzSOVxkjIXnusAq3Q4juc8bt Z6AEHS4MjJzGksA7g4ub5akvlQWwQ1JpJ+wJT2w+DNa6GZAYFjkio0Pu8ycsg6nD99xphEAMN3q H08z2Bf/cfi/vNIfPE6H7jIybGwiiBE/ZkVN4f0FXrwVJbqvIJvXe7C8ES+HMMwG++tZGXyMKJb Bz4gu4JCB7nCHZOgBLf8w5B2wqpT2sX06cmqpeQPBEEU35bc
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
index e43687ac74a1..782f70c3a98f 100644
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


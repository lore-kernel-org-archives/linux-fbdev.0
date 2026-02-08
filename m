Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1C02D6E4B
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Feb 2026 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770573515; cv=none; b=XG2Cj9YYRGCHbWIiDer7dnzHHJKarjXr8n9YVN48Z5DOgCbHQURmNcvI1hCMAmSwisM4/rGBT/YNO3qEiH/vRwSiYGnSPQb0X0sAmnMjY98Xl4WYcnrE9AFnsnIZERXh8HSaqK+n1Y/alCjCvSZnelqQMo2764VbofFFcsjEzAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770573515; c=relaxed/simple;
	bh=SSUSGx6lfA/GqkSQv4Fnk96BPhFxJytdlZm5TSFmJ5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2f8Ipu6yS03UV0zSBNjM5rqtUMtog1MVxnK15LipO8BVqhAQX0DeKWEx6IebMy1D4u406GgNaebipGrt/iAhEIV8rrO7foibCvz/VaL1IjotO+Wy4Ol0KVaaEPkVw5Cl7FT8RFRyCB4hp0kd5xtrM0p/L+h9i/QkczNu4Fpybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QB+AooTS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QB+AooTS"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-480142406b3so28163075e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 08 Feb 2026 09:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770573513; x=1771178313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9Wo4gV7QlG4gK1tupRVNO3sfYkc311HzUI77D5hLXc=;
        b=QB+AooTS7tWqFb6C47se2XD73KZCCqQPg0YToj+xXg1ctS5D9xewdqoBW82ETnrdO4
         fk0ZtTX+7QgOk73S/1l4YH8mR5lEMj3/jyqRDRbZ/wkfLLt8hYmZDM0Oms8zPlI1I3Sc
         xgGK8Kebmf4WVnEugG5l9EkGkGvQ2E8fWYTcG53rT7lGqZAkZxr7ix+woYW8hPmIO77m
         ntY7zkUDt+enjmFJLJYAhuvdtgZrfs2WE8VhcGP8VoJreWUVXpxf5tlKdRTT54r8lH8Z
         IZUYspp1O1HyXNBNpM/EdOdwAS+qAb4Pp6euCvto8Rzq8lMngfOV5xgS3G9X/Qa90SOw
         fpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770573513; x=1771178313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H9Wo4gV7QlG4gK1tupRVNO3sfYkc311HzUI77D5hLXc=;
        b=UDk7qf2OGisEJnAaIxKjukB6Luba8bnJripMD1BOLO8nv6hIccN0YY97rFR3kdxu0O
         Hw2VDDCFsNR+wmp6Z9VBh1o/S1RjBHQ/bRB9oVcvZAa6cUm5RqlnL2P896vpweup4UhW
         dmaUcGhjf3ee1oB+XwboFyz8JWSLqKU90BN2coej9QRz84EKInBEfCvyBy2V9VCfagCN
         S+OwJu/57A2ccTOOzsvtVolx9QN1E9KGve03VoGZk1n3OgErsWZSCFGMQkKQP01mNF+v
         qOYzzTX3R75lNaMAOxBZKBK5cEI9OUsrL0vm800x78DQbSvpniIl/taHEzE0JnZggtKC
         e/zA==
X-Forwarded-Encrypted: i=1; AJvYcCVMYGPF7j6Gvua/k9IkrqySGu0nkR9uJYmmrE7L5ZtvhfBLAz/E7dIVM4ZddFNeDac2+vBOAJnYUTd6Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqkhVZfQgN7oBCtLp0SaHp/zSQRVSmcAcC7YCFxFxH8Oz5Czlc
	SV+7AA1DCvTPvTY+S1gD2GO8ut/lkyVL9VuYyjZx+qnM19O4z8v9f5XAK598g/a87Ug=
X-Gm-Gg: AZuq6aKApHHHyRegKpxcpztqbjDTerUT+OLeCO7lBeQbzbrddhzmSfTqm8v5iWest/2
	7k5h8BdlINuApNmV8NI38NRImBjATfDLyO+c2xz7mE1YTXNUMOXYpkyHMj2XaPBsdV0tTOlnwdm
	CqSdvQ5zB7XXyX6omXhhyHi/iQtv2qziqTjmNKP9bNj4HYPShOwt/aZXDXXQuuZZ0gZo30LtLKc
	jUhfHBCr+PuesY1lBZZ7Ei1KC7wazCnCwyzw+L2Ft7AeAHydMJnQdmVbX8MK1T0oBvkj9wsKe1R
	D6l1xU72YJL5tImELLobrwcamKUoEr6uqoAiMsxB0uNkhxdmoBKn9T342o0rL9S9rY7U4b7YPts
	/OjG/DpV+FURJErpADlGVdDOhtyG+y29YkswaJzfR9OIqrb6jOZEmDTXJCBXB5/0pjGq0k5yn3V
	47n+dt0Ttns+jmTMOy28hi3YC3I6g=
X-Received: by 2002:a05:600c:8b2a:b0:480:1d0b:2d15 with SMTP id 5b1f17b1804b1-4832021d841mr125122475e9.27.1770573513194;
        Sun, 08 Feb 2026 09:58:33 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4832040a3cesm120516265e9.3.2026.02.08.09.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:58:32 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 5/6] fbdev: au1100fb: Make driver compilable on non-mips platforms
Date: Sun,  8 Feb 2026 18:58:02 +0100
Message-ID:  <67b7aa0157b9cf5de111ab6b2725d207ec98aae9.1770572936.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=SSUSGx6lfA/GqkSQv4Fnk96BPhFxJytdlZm5TSFmJ5s=; b=owGbwMvMwMXY3/A7olbonx/jabUkhsyOc1v6TA3nP/CYP/vRu/XRS6q1LFey+UfuZXhit6wpc FN27fq9nYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBMZAMf+185geblM7rsNdlP rJj8QCHHbJpYppavikBIfk/TnBU/TJkzvE3dJ7w+Epdw9uDx745zdv73jBMLjZIrSaz5/Fx5ldr 0iv3h1S5n+/ZLMj7frtSgtaq5uXNFmo+64ctjKo9ecpe/nvd7hvh2htwfP46zZGmGMZZNstJ6fy GJN+H56Y7yx18eqef/se4qEQlW9cjYY8kQ4CVuef/8nv+6LzXF3qh9u3UgTcAx9oPyJuPYoK8i7 1W+3MzeqOD9QfWAwiL+PC3Rtl280+44S4j/0/7eW3dUdtvCeSWLuDIuM2xdxO76yNtLRejVpBLX UotTcd8ZqhJPef3ZLy2zz2vvAw/HB2WmzmvZnHrkzbqLAA==
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


Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB72D6E4B
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Feb 2026 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770573511; cv=none; b=sC60y9XtGEO4LeFK3leiA39WSHMG7bUu92d/Ngdl/RmNM6v/1hruKiS8Hfc4Alw7PuU1+KvYqx2zl4XcvYp+1JtFMVgy1vkIdMWJtRSKZeyyPsVMgVz+t0TkyX/4tBeSTwrZ8lVcfc3MpmkJ8LAAyHh8oRd+oXJTotayIO3ERf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770573511; c=relaxed/simple;
	bh=ocIYw8RPn2RRPRZclHi+yTA/TG6btbTpOhOuJ2xDv9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTqPowTQPkNxEn3lQ1r5lZU8CzfIx7rvJ0bhOTMEHoTUQyclEcnyM0B3HLiyHV2JBVAzxr54lBWW2PT7svZm4Piio155rhxfiH0dMsaFYtG1Z8DrwSTRhCM9qjqJCPoqKURro1avqF3jr+lGlLLfnoVuVBnJu94WjP8HmRqw9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SS038ie3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SS038ie3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so28277105e9.3
        for <linux-fbdev@vger.kernel.org>; Sun, 08 Feb 2026 09:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770573509; x=1771178309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpJytYorM9mJTcd49LEsYiWb3s15L33VFGja9g/bZ4A=;
        b=SS038ie3GWdsu65evbJ3u7imEtYpHW5kqVAutItBRegxaPlNYNuq5r4ruShpQLxoKc
         PxSnrGlQFQDYmvYiK+mvnZOzn1y618LsfuM4tZoCNBSImb7ETahJ18PLZzcB2i+PPmfr
         /YCpGLKBQHzu4+/xsv4octN2vye2nIDIWfyehi5uQF4OocpZ7+77aTPbJRudsCTe/ZTI
         JqNp9aYRPdDuxnvHEfFEOMQMyk+TroY3v4rIeI69oCuOZapHM850yF7Sp+V4c3sgRLvG
         Ci4is+y8QXX7N4CsFm8RMGrvS+ZS74O8sRx/7zmWWl3tyQRuMrWkzMRjofRpdiLo/HxA
         zavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770573509; x=1771178309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jpJytYorM9mJTcd49LEsYiWb3s15L33VFGja9g/bZ4A=;
        b=w/pUZEk+yzVoE3j8ODaU921415DhQ4m+DhfjduIEgduahESqXp1rPgIEZcxJySCQZJ
         z9Z/7ogNtFw8f0S8GbHIpnE1J8cvg8Rh5qx4mf6WAFbd69J/n9K02VPlP6A8XuGua9vE
         y8EOUJ1vjWSq/zMIPTC/Mq6ReIZLmr5EpCSmnWkf/Zcl531Xy/R6a4te4XFKS2o/BUBh
         5jumcee0KfzfIqNv84Xj6f8QJFUTjwZFgsp5lD04Ho/QOlmKxKdy/YalNEtvfij6SE4T
         zW4OASR6zxUBFuEB5BOsElyd3fedZz9WpHh8G0n4K0F7ScounKmuYOu67tENjaHvyvwL
         8Pag==
X-Forwarded-Encrypted: i=1; AJvYcCUxCUZC16hlH5BdJIcKRgQdhSaqz35AWCmJrp9a7Q7umK6A40ujpRpVBTUJfXMMjN7+NnuBJwsbYfkz7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQHUTv880ww5LC/ibMJHiUknZG9uFHejuYUF4rLQ7rAPmyW/4F
	Gw/UdnPm24y+O304CPjAsamP0L8vSs9W5X1DAOgEimjaAqSp8Pr3HiqUGa1ubl5FXY8=
X-Gm-Gg: AZuq6aKWSogbR7uicU15XL4yemcLzaSfG73HsWYfxQXC07z6KaMRWc/qxgexEyeipl1
	ZDEfqGBOtjbhiupBTrhryjQ3Rh/yfibC7m+aRYSmLGJcVnppe6A6MK8lwmzkHYhu/pudX83pZAu
	Vit/c1WJMijGP8KUTqpvAQBjiD5eJmMn/XLRgqXy95h/3vmQvTphCqZO7V9cscry5hHk8Rjf1r/
	PmYCi4m70RQq327+Xt409SkwyBHjxUWQVo35BoNF43yy4rzrTx+odtYjj0d3UJUfhcfjWeRsKqe
	jsrzreEulKe//825cFRHTO4uVrbysiG+C92TR3kvbfnWEmJp8OUBfwQLhhDSRrzBSJmeSXqsMdW
	IzMKxZNJjJt04qu00y1bruxR2ncQl9+wClAEcMHiOqpWMvy2jiLEg1VKXvOnzEhRdcn+ZmtHQdj
	XcC4fWaDCkRurXHsaTMkkp32Nrk1Y=
X-Received: by 2002:a05:600c:628d:b0:480:53ce:45d3 with SMTP id 5b1f17b1804b1-48320214788mr119643465e9.18.1770573509175;
        Sun, 08 Feb 2026 09:58:29 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483203e37f9sm91236845e9.3.2026.02.08.09.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:58:28 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 3/6] fbdev: au1100fb: Use %zu to printk a value of type size_t
Date: Sun,  8 Feb 2026 18:58:00 +0100
Message-ID:  <3eea98cc14bae12a3ff6c6574971669e15a1f16a.1770572936.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ocIYw8RPn2RRPRZclHi+yTA/TG6btbTpOhOuJ2xDv9g=; b=owGbwMvMwMXY3/A7olbonx/jabUkhsyOc+ufTxLK95ILNE4rFbXamBRk5i+Vd9X5WpKm8jbXs 98qDwt0MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCRuEj2f1r5weckV75jeRkc u1AqkMf8TeXp75fdWHgXVZkyZfxsXTLB4tzn6RmSm+ew7Xhc0Pu04md10oqw93XTu6+cfmTzXiJ cIFnI1uJef+qTjR8NghkOfn99ouyST0z7IoebiyUNW7buPMiWy91oNt/cM9niXW9eU8LZh7rSlX We35h39jg9nMCe3u41N26z8yL7rjdqsr2nH9/tbs7493K/2Gt/E/G9LCvYNU+pHje71VRW0/Km5 3dL7VqV47yV3Z3J1b8Dn7jcDDPMu883309li4lHSc+xWLaGPdxet9+sztHTmLunouHk6XLRXDa2 7Iu3U5d0TtXyaTBayP4wMfFciAhP3l7v1g1RrS/do9kA
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

%zu is the dedicated type for size_t. %d only works on 32bit
architectures where size_t is typedef'd to be unsigned int. (And then
the signedness doesn't fit, but `gcc -Wformat` doesn't stumble over this.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/au1100fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index b1da51683de7..914f371a614c 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -439,7 +439,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	fbdev->regs = (struct au1100fb_regs*)KSEG1ADDR(fbdev->info.fix.mmio_start);
 
 	print_dbg("Register memory map at %p", fbdev->regs);
-	print_dbg("phys=0x%08x, size=%d", fbdev->regs_phys, fbdev->regs_len);
+	print_dbg("phys=0x%08x, size=%zu", fbdev->regs_phys, fbdev->regs_len);
 
 	c = clk_get(NULL, "lcd_intclk");
 	if (!IS_ERR(c)) {
@@ -456,7 +456,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 					    PAGE_ALIGN(fbdev->fb_len),
 					    &fbdev->fb_phys, GFP_KERNEL);
 	if (!fbdev->fb_mem) {
-		print_err("fail to allocate framebuffer (size: %dK))",
+		print_err("fail to allocate framebuffer (size: %zuK))",
 			  fbdev->fb_len / 1024);
 		return -ENOMEM;
 	}
@@ -465,7 +465,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	fbdev->info.fix.smem_len = fbdev->fb_len;
 
 	print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
-	print_dbg("phys=0x%08x, size=%dK", fbdev->fb_phys, fbdev->fb_len / 1024);
+	print_dbg("phys=0x%08x, size=%zuK", &fbdev->fb_phys, fbdev->fb_len / 1024);
 
 	/* load the panel info into the var struct */
 	fbdev->info.var = (struct fb_var_screeninfo) {
-- 
2.47.3


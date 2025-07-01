Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2275F23506D;
	Tue,  1 Jul 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388374; cv=none; b=BZy9p+GqR1yg9CabaXeTbLPSR5P+x9C5OrO8PvwJyf9JT8iX3DolkH5Nj4q13CNZmp1736IxIpf3UwngiMSAIdhMvjAifXA55PQ/Ibx/XA19HtJP27U1opbe47AirZY9tLIYvvqR7b+viZvCG0xwMFlRqbgbV5rXAaRUAHiP4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388374; c=relaxed/simple;
	bh=76wvwIqknZHK203y8r9Dza148N2nvEhXSSczeKFN11c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tk56JaWts9FN4uSPLpaQuba0ROcVdat96SOU959cRK1CSCsSZJe/LS90lb8ZWxmxGH0Jm2ZpU9Zm6Gq1/w5zNRZ8Gt9aPVFP6Lhteilsns2GiyhhvZDVc7Yzpf05YEXT/yCAaRrkact/3hi+azAYEjCdnsSn55bPTrafc0z8sYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnfqYEzw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnfqYEzw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235d6de331fso43956405ad.3;
        Tue, 01 Jul 2025 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751388372; x=1751993172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=88Hysw7tfEWlpEWhG5IHKz75tKeJyeimvESHZHy/1Ic=;
        b=fnfqYEzwpjf3X27ldjmCB+e2Bk4t+Z16sfAuxGuKdYAZMo0UlE4H+8uhDE6SPSW2Sd
         6poP0j/dpK+uoNT35zgLOk4RBkfvtPZsebrxlYrwQbOPwnDiXfD2lDe2MP+2yjKzYiVD
         bPFz0n+urAuydNfsH1KE+P37XCu7qDzOSl0zxAVKsWSiq0fxxPUNAhihV7GozOkOEbfb
         uuKb2wk+vGmTJdfO58yKLi0eOWeBA4qQMu0BItgHDrEK7GsXVo9f+foiB+eAKV/P5yGZ
         IQrOwmhISMaAuVjxJp2UuLmKk6gXFKpjngoK1BBDQQ9Io3WqeWnjfpTCLqMEEHDH6NPa
         IkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751388372; x=1751993172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88Hysw7tfEWlpEWhG5IHKz75tKeJyeimvESHZHy/1Ic=;
        b=T5f5/n/+C8zYLfB8GbTt6s5bpBZeeTiYqExte89+Bm8tHZ9s9MjtMJCnoQ7GHg6WZ5
         iLA3a6O9WCv8TzPPdqchIKDjXbzsREELwkh3tMaiquihxlZya2LfRH3AKtbywrky0RB+
         AeoQNrEa3E1I6vSXHmjARjhrz09XF1zQ7GcLA0OEXwkEE7U1HXMkbyahWdIeyC+PEXjK
         4l4K20PIv6sawvC3IIJCl7cz2pI91K+TBSQPCCNCnMJjTL1jLrnHpEH1W7/lLekdzz4f
         Yax9JhTsgVM0xjoRWn6r5yNvyZEI9QJnS58XOs2I6fH1RshqoWMtdaTqmoH/RrxFK2qW
         LpYw==
X-Forwarded-Encrypted: i=1; AJvYcCUsIlwYjIKm3Jc7eEp1FHukEsa3CMVT8CCmAApsvvcJdqpTRTTZkyK14hvlCHpP5/oAOgNSrvkyQUoycTF7@vger.kernel.org, AJvYcCWgEqys699ScZXgzFhEh8sMG2osStPMZWDRBGu2dcgSybO95rnHfTYl1SDJyZlyrbM3kuXJinuzCUiulA==@vger.kernel.org
X-Gm-Message-State: AOJu0YydZpdd73Ilk8Aerr/JINU4Ew9T/C0f+Lck2u91Aw455qnBJMzz
	OHFZHWrsIV2DnETiWexWhoQZYorF0pG1HGjjM8IMCt5f6W9uKrV6pkwk
X-Gm-Gg: ASbGncs8zzEOIH/9SZ7teYXJYjfNzDLYkaxaG8Pz3LquYNQKC+3AH4Sum4h/iCFFa9/
	PL1pgAaYIzQvza4k8WjVezd2GWmVkYgJgBiYFYgvqQxnZSAV6tg0JjZ7DfIF1WpI4glEHpKDHYk
	bBnWkysCla17daniL7HO6d7vmbGteFRMwifqN+w7OfR9HuP7frJG/0EoySDx2Bp1hQ7eDD2bB7T
	6dUb9hSsBtkPKVBoiW7JcMVPxQ/Is93M4iUh61ulNeQ4nCHxGRMh7BjzaTe1DueLu4yNX68EWIX
	uEWNCoWoXSODjtJeNDuXMbToKqIEZvFcJd7uNv1w5Bb82dVtLsW8C3ylNC0RAi5UhNHailgjgip
	5gg==
X-Google-Smtp-Source: AGHT+IHZt0VfzJMOgeHLYEftDnYkqQIleGj42Y9oD2BZX1/zzbgD2ktrtUJsRLvt9haEWURtwL3Kfg==
X-Received: by 2002:a17:902:e849:b0:235:a9b:21e0 with SMTP id d9443c01a7336-23ac19a8a29mr306652055ad.0.1751388372372;
        Tue, 01 Jul 2025 09:46:12 -0700 (PDT)
Received: from localhost.localdomain ([49.37.221.186])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb3d11b4sm111050085ad.254.2025.07.01.09.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:46:11 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: andy@kernel.org
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	dan.carpenter@linaro.org,
	gregkh@linuxfoundation.org,
	lorenzo.stoakes@oracle.com,
	tzimmermann@suse.de,
	riyandhiman14@gmail.com,
	willy@infradead.org,
	notro@tronnes.org,
	thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5] staging: fbtft: cleanup error handling in fbtft_framebuffer_alloc()
Date: Tue,  1 Jul 2025 22:15:36 +0530
Message-ID: <20250701164537.243282-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error handling in fbtft_framebuffer_alloc() mixes managed allocation
and plain allocation, and performs error handling in an order different
from the order in fbtft_framebuffer_release().

Fix them by moving vmem allocation closer to where it is used, and using
plain kzalloc() for txbuf allocation. Also remove the duplicate call to
fb_deferred_io_cleanup().

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v4->v5:
- Rebased on staging-testing, removing the duplicate call to
  fb_deferred_io_cleanup() and updating commit message.

I'm not sure if this needs a Fixes tag. If yes, please add this line
Fixes: 505bffe21233 ("staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()")
Because after that commit, there are two calls to
fb_deferred_io_cleanup() on error path causing a potential double free.


v3->v4:
- Added Reviewed-by tags

v2->v3: 
- Remove the if check before kfree of txbuf.buf, because it is zero
  initialized on allocation, and kfree is NULL aware.

Newly added in v2


 drivers/staging/fbtft/fbtft-core.c | 32 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index d920164e7710..9e7b84071174 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -568,18 +568,13 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 		height = display->height;
 	}
 
-	vmem_size = display->width * display->height * bpp / 8;
-	vmem = vzalloc(vmem_size);
-	if (!vmem)
-		goto alloc_fail;
-
 	fbdefio = devm_kzalloc(dev, sizeof(struct fb_deferred_io), GFP_KERNEL);
 	if (!fbdefio)
-		goto alloc_fail;
+		return NULL;
 
 	buf = devm_kzalloc(dev, 128, GFP_KERNEL);
 	if (!buf)
-		goto alloc_fail;
+		return NULL;
 
 	if (display->gamma_num && display->gamma_len) {
 		gamma_curves = devm_kcalloc(dev,
@@ -588,12 +583,17 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 					    sizeof(gamma_curves[0]),
 					    GFP_KERNEL);
 		if (!gamma_curves)
-			goto alloc_fail;
+			return NULL;
 	}
 
 	info = framebuffer_alloc(sizeof(struct fbtft_par), dev);
 	if (!info)
-		goto alloc_fail;
+		return NULL;
+
+	vmem_size = display->width * display->height * bpp / 8;
+	vmem = vzalloc(vmem_size);
+	if (!vmem)
+		goto release_framebuf;
 
 	info->screen_buffer = vmem;
 	info->fbops = &fbtft_ops;
@@ -613,7 +613,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	info->fix.accel =          FB_ACCEL_NONE;
 	info->fix.smem_len =       vmem_size;
 	if (fb_deferred_io_init(info))
-		goto release_framebuf;
+		goto release_screen_buffer;
 
 	info->var.rotate =         pdata->rotate;
 	info->var.xres =           width;
@@ -668,7 +668,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 #endif
 
 	if (txbuflen > 0) {
-		txbuf = devm_kzalloc(par->info->device, txbuflen, GFP_KERNEL);
+		txbuf = kzalloc(txbuflen, GFP_KERNEL);
 		if (!txbuf)
 			goto cleanup_deferred;
 		par->txbuf.buf = txbuf;
@@ -694,13 +694,10 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 
 cleanup_deferred:
 	fb_deferred_io_cleanup(info);
+release_screen_buffer:
+	vfree(info->screen_buffer);
 release_framebuf:
-	fb_deferred_io_cleanup(info);
 	framebuffer_release(info);
-
-alloc_fail:
-	vfree(vmem);
-
 	return NULL;
 }
 EXPORT_SYMBOL(fbtft_framebuffer_alloc);
@@ -713,6 +710,9 @@ EXPORT_SYMBOL(fbtft_framebuffer_alloc);
  */
 void fbtft_framebuffer_release(struct fb_info *info)
 {
+	struct fbtft_par *par = info->par;
+
+	kfree(par->txbuf.buf);
 	fb_deferred_io_cleanup(info);
 	vfree(info->screen_buffer);
 	framebuffer_release(info);
-- 
2.43.0


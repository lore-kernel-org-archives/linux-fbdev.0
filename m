Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7319E82A;
	Sat, 28 Jun 2025 04:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086786; cv=none; b=mLDSA0IepW6Ri1Jk3PyvOW5yZYwwWrSf3iKRiIoAgDsB6HJPVh3mQPjdKLdnfv7Cntyls+GIDzMJKv0hFSkpWHor8zaZbKGDmThUOSszOpgjoNswDAfpFm/fdVCESEL9SFCK0wGbI1fshqdxv+Pi+QbrldyMK6paUCxrplu29FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086786; c=relaxed/simple;
	bh=3AtvpzDjfslHPDxlxx8QNEQnI1HnDgZjUZovpUJ1MOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBkDGYeHcCWDlUdnj2ZzBQBxVIkLD2a9jiyInNA6Y8TLsbDDGCTvUGTVTrBV0yZ+0jDsnontWDwFTI8kKmafLb0l7zsdGda2C5WG0ekfcyC5Nm/+euEoiI2LwsYd9jbsbAi1J7vSVpgqJF8+bvBdBv/ShT1H4d/QB4ISWeBKgqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2Q1M5A+; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2Q1M5A+"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b321bd36a41so589768a12.2;
        Fri, 27 Jun 2025 21:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751086784; x=1751691584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6KFydMvKM3jMgYcZFX5+YrAej6q1x9tbL+4kgM9zm0=;
        b=k2Q1M5A+i+dwEKGs1Vt2Z6gSHeW5XVTyOG4qTry/08b9o0FKgAut/ORv2VYuKqn5AH
         ttx7qYcNeGs0yG7Mtwf0zRkZtS0pokVITDOLxVkPmBoJi5aIrO+LaNQdHBUXG/z9vmdQ
         Bw9kuRQmTGfDGGv2vVONrwi2+ciWGC1iyoJmfB9YWNvo24cM/fGjX2HNJ95TbbOaBG8j
         n1bKDgFoPW/bTY5x4WxqjcbXzWDavl7fuWvtHPTGlk87s2u8bdHdMwYIM879taI95O97
         e+9uQauxMOrWwslU4U5fTpDlTWfdfXfO3gyKk9mzVdT8jS/M/WHWgqkCzGKd52wmL+wX
         pvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086784; x=1751691584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6KFydMvKM3jMgYcZFX5+YrAej6q1x9tbL+4kgM9zm0=;
        b=olNghL/BPO2LxQUepFa7cpS/hfILpdSMoZy6FA4IZekj2Qp6pb5jmzguKqf/ADtK9Q
         wBq4M0Hux2r2Wh4Ena9Zp8ftJa7nCKm9AZzZWNhhdbGUaTeLbGjJITfWbFdMrr9QLPcG
         DaOGT7zgtKbd2ZTiTde6rYTp5hCjjxjUi6GQtVTfDmfHoQOpGjD7a/mhStPrwtFNwnQK
         smJn4ophXL5y+jFTbxGvVnWLZqBwZURgFnzslOWaR8oUdCwwdXnssnYPd18xamnBDcx5
         UX+dEJ5zRB8fHC+hZ2xvtrR47wwGRqRYAfsAO+JTaFoS4gQW5lfSWDmHsVPtg4pIXjPH
         cOXw==
X-Forwarded-Encrypted: i=1; AJvYcCWzx6/IqFEvMmi72BdOuZL8jswB6UMqqgrXmYl7l/84L5kiWtkdR7Da7cms4v4/4H7waBJiMABW+zpoEg==@vger.kernel.org, AJvYcCXQaNCRpaFdQWc9/RVzG0sfpHjKda5A5LHN0si6bHnC0dfK4YIhXNstyVWq0zjy+owUSmOoP/tWsV5mABId@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0yxH10KJkcLb+IXSRiwIntQJ71YBrBNohn8nBS6Nl/idXRlJm
	2Ql0bImk24iGDSpqI5pKbw/4BArRClVGeYZcb6XmTwdWTuwSTDZcBQmLF5CPUQ==
X-Gm-Gg: ASbGncvYviGzVOselv9bzUDFTlQ5WcalZB+KAWriQgrA26G19srV9VTZgF88BGac4Hv
	K4Nu/9sDnhJ26fZRyKN936D4H9gAp+hCmwAs+iErOrag9e8VKKj2po2/KntYFghw14qMcgfDLvG
	q8MaDDn9d5sIdrd3z2Ue4eY4Qqe7rESX1w0RkS1bpNbX9+DUBM++J9MgHuhCfAgd5cDM980ymFO
	ip9mlZmizVIlcNh0LrywypsxCLPYrMXt0MX9Ixs2meo79SLNC9cMg42RoGEynRtCeJlpDPNZU60
	z247XVLn+2+paGD6a5kN2WKyUqkSlag6uRbfKKnj11XJqshryf5NRmnG2PrnVSV/2ZHpKKsMXyi
	gsz7Rk4ldToKW
X-Google-Smtp-Source: AGHT+IHa+w+z2zouG9On8VvcTYwX0uju2SQmEjN08Q4IjPHgE02aAZdf8HosYP7aHwVRvq+HXQ+62g==
X-Received: by 2002:a17:90b:582d:b0:312:f650:c795 with SMTP id 98e67ed59e1d1-318c923b91bmr6942314a91.21.1751086784526;
        Fri, 27 Jun 2025 21:59:44 -0700 (PDT)
Received: from localhost.localdomain ([49.37.221.186])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-318c13a271asm3659713a91.17.2025.06.27.21.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 21:59:44 -0700 (PDT)
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
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2 2/2] staging: fbtft: cleanup error handling in fbtft_framebuffer_alloc()
Date: Sat, 28 Jun 2025 10:29:07 +0530
Message-ID: <62320323049c72b6e3fda6fa7a55e080b29491e8.1751086324.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751086324.git.abdun.nihaal@gmail.com>
References: <cover.1751086324.git.abdun.nihaal@gmail.com>
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
plain kzalloc() for txbuf allocation.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
Newly added in v2

 drivers/staging/fbtft/fbtft-core.c | 32 ++++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 8538b6bab6a5..f6a147cf0717 100644
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
@@ -694,12 +694,10 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 
 cleanup_deferred:
 	fb_deferred_io_cleanup(info);
+release_screen_buffer:
+	vfree(info->screen_buffer);
 release_framebuf:
 	framebuffer_release(info);
-
-alloc_fail:
-	vfree(vmem);
-
 	return NULL;
 }
 EXPORT_SYMBOL(fbtft_framebuffer_alloc);
@@ -712,6 +710,10 @@ EXPORT_SYMBOL(fbtft_framebuffer_alloc);
  */
 void fbtft_framebuffer_release(struct fb_info *info)
 {
+	struct fbtft_par *par = info->par;
+
+	if (par->txbuf.len > 0)
+		kfree(par->txbuf.buf);
 	fb_deferred_io_cleanup(info);
 	vfree(info->screen_buffer);
 	framebuffer_release(info);
-- 
2.43.0


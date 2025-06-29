Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA323183B;
	Sun, 29 Jun 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751208087; cv=none; b=bjBBMW9t4eyZGNod3wIjIDV0EQsfpJaykOo/GbNNRfCaZpasXqxm1GUpy3usdvWlTwqOfYcWk6OSObbeGMeQxUqya4vQCZj/XICDwyPEFqJKejb7/iRMb9lB3V7wX6AlTfMQarB0mCQyngmOKo4md8cPSOHZwZ3V+yB2UVT5O0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751208087; c=relaxed/simple;
	bh=4iptySoXMXJs2UzWlhwIPyIT0WKR/AuX6Cj72Rs0gYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXlPI2JHWmNvxMFM49VXF5KxCrIz6Hq7sYyVYvXS77CWFytkUIPAlzOwgDYTxFVWnxI5UhuMXx1mRHlfA2XzLl00mdDUJ9qXrDNPIUHrnQ17bw6CyZxdEiW1vVwn4vf5Q/9ohPMaN1AbJ1hfrBn4GQrARCfk7sP7RoMVhVdr2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKuEWC4D; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKuEWC4D"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747c2cc3419so3604712b3a.2;
        Sun, 29 Jun 2025 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751208085; x=1751812885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkH6WZ47tB33hOq1ktfgw4nXcDuqU5IvVV0uN0/lGcY=;
        b=cKuEWC4DJxs19wI2H3cULpmVMG8N4950MJRhuXBPFDi1dIGwWdbCJByAcMUq09E7YG
         REN0tcRsecCGI0wRsme/fxn3TmLrRL3QCPuCuKkFyTnP/FkCHJKxtQbQnqmJzpD7SVi6
         f/PJ+h6ILauHcaxu0pIdHQbNXPWKdFlrdzNLeBWkbgTvkbQR4S4FoXj/DA8rdzoSzig7
         AEPve/tm3sw3/SO/wOlc91cgRAQs7tM5o58Edeyz2n2pKcMHC1Oglx8Lg+zROB7b+riU
         AEDjZXBcGQdJCFWlgNAivcHvvQmv/nvVoLu+Pnf5p+V75JgaipoVlq8xkMBX3obzHhfE
         6pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751208085; x=1751812885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkH6WZ47tB33hOq1ktfgw4nXcDuqU5IvVV0uN0/lGcY=;
        b=dJCIC54nohxQ9ZMmhlvskY5BKUtkozhvN3j6tVDhKrTucIFp6pc/GG6GceE2kpd91e
         cOCIe430UZ3Zl5n/dAkmnSm0VSJQhyWouhNmmyjOR1MUH4s3eTfgHrZayFeYejCGV90b
         QBmoyEnBSR8lDofPs8oHY6wnhEB+CgMVqnszWHewTbrCecem/3LrXvs00AcxmFoAbAw6
         bPN0/ogZV0fOhcTh62PE+4xzdsMeBf48gWJQ/TCyzq32r7WcmAwpg41wY9rCy5Idpy3h
         JbyPSUxejpUPFdCmiWkeTZt78XUl/Cd07uS0Zm6n7gLwIyAjAg1eGDDsUFHKOJraYnMk
         kU/A==
X-Forwarded-Encrypted: i=1; AJvYcCVskIql5ueI9e6M9NHG0tLZhkXYkbhsujVcOlbky4lPT+AdzHFEzvjAmnvl2B0BsAWuT0WA0YmfjGwdFmVC@vger.kernel.org, AJvYcCXeY482NSkrYRyg+CYjwukXNCQ70RPRcIcYSmJ2AbYgWEVfw5ndovj4wB4M/9rgnmzDld/tJiLXnZzfZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtNs7xNLraRH2tx7Qia0iF4Kh9aqtx4Sn1ZgZPfTV/gr1Q1h/O
	vXtnldzQlmWaVvg/oK6oloJvds+eT7Al6zvwCKYvtLASOs9gKIvsfIgo
X-Gm-Gg: ASbGncvxs8oIKd1z/qtsm9rlQ1mOjIP8YO8zPh37Uvdn6y+NL8g86mDNCTnKLWz5iVi
	DgoBWjDsxGSGmiz1n8dIzISJnyCCtDd/vO2HORSQeBsBMVxmONO1M3j3fnpvp8kqQ676sdfNHtz
	lOt9uWQOMsQkLU/+qvxRBx5N6KT/U+sX4OI4lUcBU7+F7fXUIuTGK8K2AgqpnilSMIQbsW/PDLV
	0R6CQLbsNsokH8dbs67HFRlVk7ZqAdQjLg9T9sfsUIBNpB1mqx/ezOMwuhESSxPCUG7OaAlrGqe
	/fG+z5+FXsTsXbKAxjJgXBlmzFBWlBrvzwq2hB2w8YJjcNmnbNHXpBP6QMGPLEuUZSkCMocI+Ap
	Skw==
X-Google-Smtp-Source: AGHT+IFBiKmBx9yH5kYGSYjeMY9rQSEBpTMve8iNeUO9mG9D8vqHt/VBUqvbXcqaLSd2ovKMv+M48A==
X-Received: by 2002:a05:6a00:2d07:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-74af6e6659bmr12804699b3a.10.1751208085209;
        Sun, 29 Jun 2025 07:41:25 -0700 (PDT)
Received: from localhost.localdomain ([49.37.221.186])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74af55c7e89sm7039127b3a.109.2025.06.29.07.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 07:41:24 -0700 (PDT)
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
Subject: [PATCH v3 2/2] staging: fbtft: cleanup error handling in fbtft_framebuffer_alloc()
Date: Sun, 29 Jun 2025 20:10:11 +0530
Message-ID: <4e062d040806dc29d6124ac0309e741c63f13ac0.1751207100.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751207100.git.abdun.nihaal@gmail.com>
References: <cover.1751207100.git.abdun.nihaal@gmail.com>
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
v2->v3: 
- Remove the if check before kfree of txbuf.buf, because it is zero
  initialized on allocation, and kfree is NULL aware.

Newly added in v2

 drivers/staging/fbtft/fbtft-core.c | 31 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 8538b6bab6a5..9e7b84071174 100644
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
@@ -712,6 +710,9 @@ EXPORT_SYMBOL(fbtft_framebuffer_alloc);
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


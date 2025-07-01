Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD262309B0;
	Tue,  1 Jul 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362883; cv=none; b=QQ3z+24bki9RsZQvcKxtfSURrSgfl3QLRQrlzYGSSYlxv1LJpHSO6FlOp2SYrinqXOVEC7+Fy8WdcP0PJK3JlNTZpnYDXfmZIRFF0qAhpzbLW3InrOjCgLnFMZ9dQm5SfWqztIFc1g0jjUlptY+3yuwFFvXrDxIp4fCmW28AXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362883; c=relaxed/simple;
	bh=FaxaoUeulagyOhU2b4Z3SKWcM6w9W2nx/IlkDhnCqXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aF9yhY3NxNV12fYVZG3VIZrtkVJKCunrhWAL/cfv0Owr3CgWCiSDt9TRbCy7sMU4unKAnQVK/uhd68QWS/ClFGub8jB+pNRR21IIECkQ+KRWnN3G/YvlsrghuYuqB5Oo1iIwR3LazaqNc0CCmBWXpSKXPuCVkMAbGDNGqs0okdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyqWam4P; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyqWam4P"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7490acf57b9so2279426b3a.2;
        Tue, 01 Jul 2025 02:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751362881; x=1751967681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PnEDkQYSGlej4tjD/bQ1dPRo4xaWxnAEWg0UHJoseU=;
        b=EyqWam4PmJTsgcD7uo1zm3vcfmjuKwoZZn/XgqVfcjcyLT5A1QDKyKc7kKdbDCP0Z3
         9zrxXaurgyjSjusf+PWrFg6K+6UIIMFWzsbs/Xmwv+R498Y4CGARfZruHmhtghINCUQp
         l0plSjUWNMsQ2erjrVKd6Eak0QJ8zRYxA+UBxerwdtdu/snTkHbwHO+jadZnteNF4NK4
         FuzZPmVhtYWpnyRVx8Sll6lavWzAoP33jhI7fIzKcFEmKnCZ5b2iAyo6+S9D4UlZIYgQ
         Lj65lbX5vgtonHPL1RRPGQ6B8KqXQDwyIMMIi1aMblVqkCBNcAkmJWM9ARC2G1Kxg5i9
         5vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751362881; x=1751967681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PnEDkQYSGlej4tjD/bQ1dPRo4xaWxnAEWg0UHJoseU=;
        b=QUu0leV47GZo888cpsD1MqdFJzTWyA6F9Uzt9YZ4H9duOR8h25FgGylFsWdmFLMy1S
         nmLdim9fhh6+yEoDb88LgU6sVBK/PktnKGAKnzx5FerwSijZJWJnLwRS00RHz6thLhjj
         ikHM97pxdspl1FADB8DnM89SorSNejIzskeORAGW8+u13MtuVIsS2OhJdBTQmC2hBBY4
         9BrC6DGqwoX5NWaA0Fq3LdrzJPRmqYjcJFiF/DRJ5oUT6Ir+mLQ99w1gli3ugzrv0ZV/
         2ubEUqRsfd33Qz0rVI9XhFSMUkr11y6fnPLL165YysjMjRrrzJAZYIcoGHXnhbbMHaBY
         0NMg==
X-Forwarded-Encrypted: i=1; AJvYcCWuaV6RsiD4OyUbpbbsTyINV5Ffx56csRR4DwAQegDOmg9ApbXEqXMriezrwQPa9av3SV9BmY+GD8vLZA==@vger.kernel.org, AJvYcCXKRDj3KPIVJrNEMjE9ZXCRIQLUxj1aFoTzQHjc5z4XS4WJQ2qi42Rk1IB+tdfNhBRfJgxosoGrgTyVMH9+@vger.kernel.org
X-Gm-Message-State: AOJu0YwM2frZCp2lBTENOJJxIGoHDFNuABespRiuQeU3SYcOGu6iOQzT
	gIsAamF8f7+4PHeSxnfVlBI7AqXC+WqHptHseFDAvYWO1qG2eji2+8ZD
X-Gm-Gg: ASbGncsVSwDiiSK8+pWjALfavG8+yvoDdVEows5isimSbUp8XB19UJW2694RTQd6sTI
	NSXDyjQ6T9DkO+vjY4jWaYz9HRHgb8cwBFRBj3ttKycLlCJrbD1hHHk2nFw/CQmIBWrhqnGUAxM
	8UqLVCrV20GBll1zfLhvEZjGa7D7vFFAE7u3DASO3eatzb6lDAfjWZtQx2Io/B4uz7P+CQnytNl
	RySiAoypkA36GSrejwuad4XmllahnI0WNN/qbDN+6kYGQbtaHxbD3I2grDPzIRDzeWoGkI6wc/C
	E5Ffou+FQIvlMnXWw0O45cccl328uYBjxvpm+r9IhQYIUTuhlLMXC3PeUNUrcnKjeMRaU14p5wg
	Qgw==
X-Google-Smtp-Source: AGHT+IEbeQc69MS0gQNp4/0czRTMPM7cTE3egdA7+5pA0TfD6EU6FUYVk5lBMVTPZAs3gk2+USbR3A==
X-Received: by 2002:a05:6a00:2302:b0:748:1bac:ad5f with SMTP id d2e1a72fcca58-74af6f22722mr22370210b3a.12.1751362880881;
        Tue, 01 Jul 2025 02:41:20 -0700 (PDT)
Received: from localhost.localdomain ([49.37.221.186])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74af57e7279sm10945766b3a.150.2025.07.01.02.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 02:41:20 -0700 (PDT)
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
Subject: [PATCH v4 2/2] staging: fbtft: cleanup error handling in fbtft_framebuffer_alloc()
Date: Tue,  1 Jul 2025 15:10:23 +0530
Message-ID: <b0b55510097245e4f96663123130f197c01dca4d.1751361715.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751361715.git.abdun.nihaal@gmail.com>
References: <cover.1751361715.git.abdun.nihaal@gmail.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v3->v4:
- Added Reviewed-by tags

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


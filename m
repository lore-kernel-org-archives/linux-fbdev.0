Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E0919E82A;
	Sat, 28 Jun 2025 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086778; cv=none; b=KuaFE/5SELS9mLxxAMNeMkhASupXDhWrv9RgA9NFnZ+LdEM6dhiCG8JGg7XjUni6gDrt3DCPXrV+BCNHSQccEQwIrrOtvsCcTYnISMjhTx/9+x5VtTYJX6y2lnm+F42xeOq3f9/UMQocqaukMrVIMZ9Uz5VOTeX9JLkFTDl4fs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086778; c=relaxed/simple;
	bh=uyaNcW6jpA0hMKzNuZeCHPISe0X7+l/P6QMUM3HwBqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQt85z2kmSDjWpcJiwn47cHtqoaqO2m7H9OQe1tGobRUdCrwzX8CpSKtAJOidqKqfa/j+HryhI5331nguvJCMh8oiACm33QeAvvJsdhMXHr5N3HBh1BHvQMv3bs3htADmixazJzDyF9G1S8qInWAjrMhWmj063k5BwrgtJ1GKQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJtjwHha; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJtjwHha"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313154270bbso235491a91.2;
        Fri, 27 Jun 2025 21:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751086776; x=1751691576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmKo+C8fi9hzazphKwRBopOBdxfENaddm6XbHcVbzUg=;
        b=MJtjwHhagA0MU+VOhE4Lajyuys4dg3q/a42owu6O4k+gfHLJP0mhAW2ba8PbPXZdhR
         q9tA3PjLzmLFkm//jrVzsZ4AhJmBt7oPP/WzbUdtULvh7j0HULJsOmpQ7j9V3GModulx
         HuUqplnbXH72dBNoe7e9jq+KG8ur8E4fQB82XgMntE4f6+G3vcpIYRFyQ8MNnNN/EI2D
         WtEx3MeYB8GtcgErQn+f9TJv+DjMnsQ5v04ua1RU+d9SoIujkY41Xt1UQGVMMZKdVsnt
         EsPf7MLgI0atdGCH3Spmr31kaiqNrEecWg4q/txxVQ84y/1czs24fTBtDG16uNrw0diX
         dQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086776; x=1751691576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmKo+C8fi9hzazphKwRBopOBdxfENaddm6XbHcVbzUg=;
        b=dG62xLt6O1WOzbBSfW1FpdUxqORTsMk8VW7c0Z6y7iFmCYIi0iYGZi8vGEWhmeRnUs
         mm/kYSycxc7Vc6NgfVZnthCxy6ri2AGmMdTU9gWdkkwIkNtxdMh0DWjy+svtvHjQkOVB
         XX0AnUhKvN3LGVeB/5XJs7FMbeQz+HH4J2YxetwG7f74BGskjpntVovpEgQW9fqnYPar
         bXpLMmbj9GaKmEfWSzYQNhnpQ2U2kIsWzg9u8TVyHuShKWLJCUGGu787Fy05JDvVyYf6
         WEJFHD+NiNw1CguavDkEWHDH7AlL3v1s6blnzxlDjzj1+0Ipu+ARBFE/PRLLOH92pGXv
         2tuA==
X-Forwarded-Encrypted: i=1; AJvYcCVGnAFD2axqNWvdFtxm43CF+Y56d4ZMYKttPkSVW75TET5tZNL3RuMNGyS48DmF3s9zSmAGu0JKLp+bkB3s@vger.kernel.org, AJvYcCXgxhOh6eXfQ3BRxkgme6amULqMjv5ksXG2iUHB24RTEVaRpgOpHXbhPexL84NqPO4266QgQ7IrhOXqyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNcE2iC1tpJrU8P21yex0ZpjVjWf/a2YTlCozmTynVofcBPnwE
	RRnCcICguryuPpiRZmbq+TADPO+01fr1VXlGqTlo7Usx99SFAuhoS4pS
X-Gm-Gg: ASbGncviVUaVySbSXu5p/GjojvgeFT7bPsp/NsmVAsPCBIrD6/M5ULwk+Vfc1FmvSNy
	ZEymsbJdObB/YUiNMjyE60+2TDJ37mlUJgh4dOSywdZIz/muWEIiko4LethL2PEC/bSk90NJT+e
	qdPgYZi+wg9fclAlmBxjIfS/25KxTiQC0H1MbdLAo/hcvDlYNfUg0XFXEv6pu7X7B7Tt3ejaqJM
	7AW964bqDC5BirG8ccA6lXIisqevXRFQoZOAVjOQ2IZhCqg7xjURh3p8x7ZvFs8ZqKxBtmR8Wee
	ofDBuOSGIQ0gKircJezCNo02xpvc1LwE/zQit8mlBI3L9XE4e8W2WOzkfHUuFOReI8Zwu8ZbVUC
	p9/xskUXLVa1Y
X-Google-Smtp-Source: AGHT+IFhOudGHogRsEtI4KMV9dAd077PePKmHUXJX1znH/HZKoXbfKEqYzFx9OoEKg8xq+/T0eEo0w==
X-Received: by 2002:a17:90b:2c86:b0:311:ff18:b84b with SMTP id 98e67ed59e1d1-318c9264989mr7921897a91.25.1751086776032;
        Fri, 27 Jun 2025 21:59:36 -0700 (PDT)
Received: from localhost.localdomain ([49.37.221.186])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-318c13a271asm3659713a91.17.2025.06.27.21.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 21:59:35 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()
Date: Sat, 28 Jun 2025 10:29:06 +0530
Message-ID: <fd2be49cfef72799f17a96d01a4c6b92770cda7d.1751086324.git.abdun.nihaal@gmail.com>
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

After commit 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref
struct"), fb_deferred_io_init() allocates memory for info->pagerefs as
well as return an error code on failure. However the error code is
ignored here and the memory allocated could leak because of not calling
fb_deferred_io_cleanup() on the error path.

Fix them by adding the cleanup function on the error path, and handling
the error code returned by fb_deferred_io_init().

Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
v1->v2:
- Handle the error code returned by fb_deferred_io_init correctly
- Update Fixes tag to point to the commit that introduced the memory
  allocation which leads to the leak.

 drivers/staging/fbtft/fbtft-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index da9c64152a60..8538b6bab6a5 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -612,7 +612,8 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	info->fix.line_length =    width * bpp / 8;
 	info->fix.accel =          FB_ACCEL_NONE;
 	info->fix.smem_len =       vmem_size;
-	fb_deferred_io_init(info);
+	if (fb_deferred_io_init(info))
+		goto release_framebuf;
 
 	info->var.rotate =         pdata->rotate;
 	info->var.xres =           width;
@@ -652,7 +653,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (par->gamma.curves && gamma) {
 		if (fbtft_gamma_parse_str(par, par->gamma.curves, gamma,
 					  strlen(gamma)))
-			goto release_framebuf;
+			goto cleanup_deferred;
 	}
 
 	/* Transmit buffer */
@@ -669,7 +670,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (txbuflen > 0) {
 		txbuf = devm_kzalloc(par->info->device, txbuflen, GFP_KERNEL);
 		if (!txbuf)
-			goto release_framebuf;
+			goto cleanup_deferred;
 		par->txbuf.buf = txbuf;
 		par->txbuf.len = txbuflen;
 	}
@@ -691,6 +692,8 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 
 	return info;
 
+cleanup_deferred:
+	fb_deferred_io_cleanup(info);
 release_framebuf:
 	framebuffer_release(info);
 
-- 
2.43.0


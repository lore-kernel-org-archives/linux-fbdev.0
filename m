Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD02D879B
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Dec 2025 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765839207; cv=none; b=UCF8kCShuKjDVatWG5ev+VZ26mNsB3wT/w07dhj9/RcSoa/xAXdjnQF9lX4qvFDGt5mkY9MlaxkwlYnWjjno1gHred3zFtT9AThdnQVXgfWxPEPlzWsVYxLIf41rk5UHexBrrEPqCf9mlzG0gpXTj2NVCcKmeIknOWjikB+pp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765839207; c=relaxed/simple;
	bh=U5pUdxyvEPst47p179lKntth0kpH7/c4ygEMz1tZ1mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8P8FCsCQ8OEw/lgHp/GDLDGqoRUSeRvpZ9LFLG142JrhpAMaeSy8ihk4ruraV2FBtvm5b0du19WCiin2DhuPyhy4tQP2PLeq1WEo8AvDZKW55yQJHazpBY3eM9MiIblqH+bocRXkeABLlZObvGh3lFRr1uyIdxmbkX43J9VerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WosAcyky; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WosAcyky"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso26067945ad.1
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Dec 2025 14:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765839206; x=1766444006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b4y5PLcNykjjXFNDo27wTnIWBRQRo7DKJyM5i0+giPM=;
        b=WosAcykyPx2/KZkmR3SMLmdNli93sgV168DgiUy6v//xmYGfgmMFD5qhoPFedzetaV
         eyog6zq1Qnqhf9ETeWpu39z34VEKvpf6LuzPHipFJZMqqrbEQmHfCb4OoYZAcYOFng77
         +/AR3EdK7ySkY0V7M2Or1dRSGzY1g6wjT/N2K+9FGRzBTUsQl5UMv76d/+fMPUqwoej8
         WxOQrLV2YBsON/5hyy9lK6iR2ESLOY2Kp5BO40WTuF//Ko7ejMGKYZl6BFhmncBY7+o3
         p+NT5SUrZcfexo4MnDJLaMlQzY1XTpdKm0WWjhSqbKSDogzqYWajsEulA0R8PphHIXto
         R8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765839206; x=1766444006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4y5PLcNykjjXFNDo27wTnIWBRQRo7DKJyM5i0+giPM=;
        b=ccMxe9SRf8xDXf7p3aWgjm/Nwn9eTinU5y/sG/8Iiidn5hXVAUYxG2OQpSxD6cBB8X
         n3A/HKwyK9crfiNuV4WjnPnI50BVbQw0T+0yB8TQ5HozOhAtf63IezYDlVQd+IAaIhBc
         1AFuX1TVoQHNyppRbYJbH7Yqgd6Ku5QjLPcw6+x/G1yIfHiF/GGUW7/HJucH+gf2vNLE
         mHUm9Z/63WwFqPf6+06pN+iv3l70P6/nb0YV6GMf0GwU3bM7UJtBo9cjCWxiuN2OO7fA
         4+mDQJk4xsZM0Xmtb9OP0Idz0+OZyjuq5NaEetc1Kz+8JEaQfgIGI6wVnMfl+pcCNftO
         j1Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUG/8z29Vn2Z+e7HHQo4w1BpvoxFmdkEPAt71BwPIfZPWG1np2b+sqKyLj6E0ysCWZlzg02O0rSawU7Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzby38yyxc/B2w7CKdZwZFZ50cybP2rcmozwxR8VtEwYiv7pqnS
	j68hYZlg4F6m7C9g5NDqmhyfOSRGQhA5oW5WUyb0itj64lf8P9hCRvEpL9CgceP8
X-Gm-Gg: AY/fxX70cXN05d0V0G772tpQrwVNMf48ypReAdBsJxbVYydGBmeBjoxXGyiHOY7OjpB
	x1IBKX4zMNOIcdHMRihPRIqVZO8wIG34l8j41MfH4kv33kTDirK7+xeFxzXQUdg182+6oxMHzBw
	+0TiQdd9qQzCBH+wmQOq2CQTgcNR47d2DxWvJudHVWOf2KXvMjIAr2X/t5zmtVKO6RpRsPcHTSc
	HnQXtr90cyo2kCWac29fPQmHLAoif/nhKl3xulTw0Mrjs8sAgDnbipcJ6e77p7CvoIKFNa18nqX
	W6ehb0hKcbT/2T8PsdzHsLM1v43HSyiRr9KpcQsaUO7Xq1p0H0IEzzdB1JIw1XY9LCru/Qxmkvk
	EmI2NhF4ntVWCegMsnEHIpDCHI9TRUmRBkUiMkgMYDK2OlBzs1KR9rpTa62DOF1ckEwf3OCedQk
	aIYo0HhSp8nvaI8SPDK/Vg4iURMw==
X-Google-Smtp-Source: AGHT+IEZ9kpuajnTEPYHznFAawAXm9oPKcyxxTpunc95UjNrN7yiUhUAnO2BusqteKwTAEK8ENvJvQ==
X-Received: by 2002:a17:902:f789:b0:29f:2734:6ffb with SMTP id d9443c01a7336-29f27347628mr119839355ad.22.1765839205502;
        Mon, 15 Dec 2025 14:53:25 -0800 (PST)
Received: from localhost.localdomain ([2409:40f2:2e:1717:4362:2468:ba9b:e74a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f301bf609sm99085545ad.23.2025.12.15.14.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 14:53:25 -0800 (PST)
From: patdiviyam@gmail.com
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de,
	deller@gmx.de,
	linux-fbdev@vger.kernel.org,
	DiviyamPathak <patdiviyam@gmail.com>
Subject: [PATCH] fbdev: xilinxfb: request memory region before mapping framebuffer
Date: Tue, 16 Dec 2025 04:23:05 +0530
Message-ID: <20251215225305.3820098-1-patdiviyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: DiviyamPathak <patdiviyam@gmail.com>

The xilinxfb driver maps a physical framebuffer address with ioremap()
without first reserving the memory region. This can conflict with other
drivers accessing the same resource.

Request the memory region with devm_request_mem_region() before mapping
the framebuffer and use managed mappings for proper lifetime handling.

This addresses the fbdev TODO about requesting memory regions and avoids
potential resource conflicts.

Signed-off-by: DiviyamPathak <patdiviyam@gmail.com>
---
 drivers/video/fbdev/xilinxfb.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/xilinxfb.c b/drivers/video/fbdev/xilinxfb.c
index 0a6e05cd155a..f18437490de8 100644
--- a/drivers/video/fbdev/xilinxfb.c
+++ b/drivers/video/fbdev/xilinxfb.c
@@ -280,19 +280,27 @@ static int xilinxfb_assign(struct platform_device *pdev,
 	/* Allocate the framebuffer memory */
 	if (pdata->fb_phys) {
 		drvdata->fb_phys = pdata->fb_phys;
-		drvdata->fb_virt = ioremap(pdata->fb_phys, fbsize);
+		/* Request the memory region before mapping */
+		if (!devm_request_mem_region(dev, pdata->fb_phys, fbsize,
+					DRIVER_NAME)) {
+			dev_err(dev, "Cannot request framebuffer memory region\n");
+			return -EBUSY;
+		}
+		drvdata->fb_virt = devm_ioremap(dev, pdata->fb_phys, fbsize);
+		if (!drvdata->fb_virt) {
+			dev_err(dev, "Could not map framebuffer memory\n");
+			return -ENOMEM;
+		}
 	} else {
 		drvdata->fb_alloced = 1;
 		drvdata->fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(fbsize),
-						      &drvdata->fb_phys,
-						      GFP_KERNEL);
-	}
-
-	if (!drvdata->fb_virt) {
-		dev_err(dev, "Could not allocate frame buffer memory\n");
-		return -ENOMEM;
+					&drvdata->fb_phys,
+					GFP_KERNEL);
+		if (!drvdata->fb_virt) {
+			dev_err(dev, "Could not allocate frame buffer memory\n");
+			return -ENOMEM;
+		}
 	}
-
 	/* Clear (turn to black) the framebuffer */
 	memset_io((void __iomem *)drvdata->fb_virt, 0, fbsize);
 
@@ -362,8 +370,6 @@ static int xilinxfb_assign(struct platform_device *pdev,
 	if (drvdata->fb_alloced)
 		dma_free_coherent(dev, PAGE_ALIGN(fbsize), drvdata->fb_virt,
 				  drvdata->fb_phys);
-	else
-		iounmap(drvdata->fb_virt);
 
 	/* Turn off the display */
 	xilinx_fb_out32(drvdata, REG_CTRL, 0);
@@ -386,8 +392,6 @@ static void xilinxfb_release(struct device *dev)
 	if (drvdata->fb_alloced)
 		dma_free_coherent(dev, PAGE_ALIGN(drvdata->info.fix.smem_len),
 				  drvdata->fb_virt, drvdata->fb_phys);
-	else
-		iounmap(drvdata->fb_virt);
 
 	/* Turn off the display */
 	xilinx_fb_out32(drvdata, REG_CTRL, 0);
-- 
2.43.0


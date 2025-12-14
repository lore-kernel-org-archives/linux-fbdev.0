Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143523C51D
	for <linux-fbdev@vger.kernel.org>; Sat, 13 Dec 2025 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765655481; cv=none; b=oXmMra0g414AI1zEJsRH31gko5Hp+tD1wOaow8jIppatTETWqBbkTEW8nv2xTq2DPOQGEOk8t8oUhMOxAGZJJsiUvIInSPH/5odVtdpn4fa4dPqyWXt7GZK3Y5KoeFaPhVjOrkS6ScsBmTjjURK725YmZa4j+kIWegKnrhKCYus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765655481; c=relaxed/simple;
	bh=BwAlneBdYgyxM+NZNn6XPcOW8vAr03luZywi659mMVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkUTjr1Vobf0FYydnhxd+nm6wRAeypbkl0FVLu71XviGYnvHZzKevlAEJhSsFiTDmwHEtI5AXT2jkobMBlBb9UXrZylmIWIwh/3gI8Oldcyvw9V9t/MTHvmpQ+gIzaQsvtnbIJuC2OlR5UQBIZomF60x3Eq08U0MaBuGq6iSLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMaKPb9X; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMaKPb9X"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c1d84781bso1319752a91.2
        for <linux-fbdev@vger.kernel.org>; Sat, 13 Dec 2025 11:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765655479; x=1766260279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IsquRE2xz+HwwOQd61l9u2JoVfbUk9ALuRhwzEKiTUI=;
        b=bMaKPb9XOspYE/uiPYRJDEh2fCIV12WhnM28LPF3KqmAlBgcB7j1Ioqbm0vvyRljEy
         x8IN/HiUpifvr11XLzka+Mx5pdszdHk4sECMv2w4JXefCpJL4x86Bx1T2lbJNcC8Vc6s
         UVe7pmU0m+3Mh8HQZqErmEqRfoLbN9Je4LfNW/3HeZV5yKORulqOMbjT22daI+LqFP6L
         B+Os5wMLEkWHyfZxg1JbQdHOgT3W0tjAIO+L6WmRx7ROrpLxFE5udxBrEDdNmA85eosV
         ZfJjowmFiyAb1FsrxE8afx7nzagasvXxThMqKeY3o4+lF/2RVIWhJgZITLvbjs6H1qus
         zwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765655479; x=1766260279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsquRE2xz+HwwOQd61l9u2JoVfbUk9ALuRhwzEKiTUI=;
        b=IUur8juyObucE7zhs08gUjrB2vhmoqL1fIcxRZdYvndJIoq4/KS+J3LRYG75G45UAY
         I2gX37Lzx4BHejOlQNxZ1yMr/34A4QA/rR3bd8/WJ58h8+l0URaai7f1rSJpP2qc5RJQ
         GbDHFsr9QxPO3mLO/UUJ5VHFwjvfM4s6neYoU9DIgvDEArXRbXVabxh1wMlTQk8kcZD/
         r7cPYTcmzetXo7FNhkWv18BN3YugPoKRqB5K1HFOCpx7p1AvmO1nvj2uEjbwZtAzXJ6O
         wUJfMiFmmsL8JHpUKcnXRhrQpS2msIhwYPe8m34OsnZ2uuf3kS6p+mD8HmPI5E54IbaE
         wzkA==
X-Forwarded-Encrypted: i=1; AJvYcCVxBmUfnofpa+oQVuWa1/iagc2cVWgQUsn0gvkzKXS3WE0kJR1ftEhALIqZp86aY1n+OPNrk8hRTyR95w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxONkdCGkFmOiFX4bLR56ffNiR8xYNqaXTkg2vNl76EmKMnysdQ
	f3LWWHQ3wqenM2Au8hFli+zi6a0a/0ltdn4kazwQXtvZ43dvJRet8fN0
X-Gm-Gg: AY/fxX79vRyQhZuTZuZqVYP8jaBennxg43pq4D6vEwNiDTdgCxJiM5T0io7T7EyUr5U
	xu5e/gCZDhCKzIz9XtuYMLen0ods71YCUP3vIzXiNE7rn3+96PHDZ5k1eisAR/1/x3j7u84TC0V
	bq/P8Fd5SSpvXWMWJzu0K4PKfr/loUwNrc6S1wIpbU850TOF/D6xz3vAfQxD6eJ/Ua5BUoXJXsr
	A5eKfhD7TvUmZMbNm+Q8IDxOyMkitqZr2ir7O3HCWQn9wjHLMqCplQdjH9T8VxnCLWbFSDjjrGY
	ZccLGbHAomT07aTNUCLVyZcGlyH8HWXGnLuUa/IcqftZZkY/DpErLHXQ8aHB1OYwWenLuugRDWE
	zQdsz/Gi0FitYu9CRnC4HSFfHy3K38VsBjMwSRAyzSjQ5L04SuYPUBi8bybZCsDpdL2iviJCWPJ
	7wYmaoSCO5QtE7Eblm3Zs=
X-Google-Smtp-Source: AGHT+IHcREPDF7aTpD+URjYTZa/VwryKmBvbSW4AVWG1PR85eHFFSRycSwlqSkc8yc3qS6yEZ5ct4g==
X-Received: by 2002:a17:90b:1dce:b0:34a:b4a2:f0bf with SMTP id 98e67ed59e1d1-34abd6e2833mr5665920a91.16.1765655479201;
        Sat, 13 Dec 2025 11:51:19 -0800 (PST)
Received: from LilGuy ([2409:40c2:105b:dc88:1107:395c:23c0:2b1b])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34abe3a2623sm5001422a91.2.2025.12.13.11.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 11:51:18 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: Andres Salomon <dilinger@queued.net>,
	Helge Deller <deller@gmx.de>,
	linux-geode@lists.infradead.org (moderated list:AMD GEODE PROCESSOR/CHIPSET SUPPORT),
	linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
	dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH] fbdev: geode: lxfb: Use devm_request_mem_region
Date: Sun, 14 Dec 2025 01:20:59 +0000
Message-ID: <20251214012059.304043-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lxfb driver currently uses pci_request_region() for memory
reservation, which requires manual error handling and cleanup using
pci_release_region().

Simplify the driver by migrating to the managed helper
devm_request_mem_region(). This ensures that resources are automatically
released on driver detach, allowing the removal of explicit cleanup code
in the probe error path and the remove function.

This addresses the TODO item "Request memory regions in all fbdev
drivers" in Documentation/gpu/todo.rst.

Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
Compile-tested only on x86_64.

 drivers/video/fbdev/geode/lxfb_core.c | 36 +++++++++------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/geode/lxfb_core.c b/drivers/video/fbdev/geode/lxfb_core.c
index cad99f5b7fe8..8189d6a13c5d 100644
--- a/drivers/video/fbdev/geode/lxfb_core.c
+++ b/drivers/video/fbdev/geode/lxfb_core.c
@@ -335,25 +335,21 @@ static int lxfb_map_video_memory(struct fb_info *info, struct pci_dev *dev)
 	if (ret)
 		return ret;

-	ret = pci_request_region(dev, 0, "lxfb-framebuffer");
+	if (!devm_request_mem_region(&dev->dev, pci_resource_start(dev, 0),
+			      pci_resource_len(dev, 0), "lxfb-framebuffer"))
+		return -EBUSY;

-	if (ret)
-		return ret;
-
-	ret = pci_request_region(dev, 1, "lxfb-gp");
-
-	if (ret)
-		return ret;
+	if (!devm_request_mem_region(&dev->dev, pci_resource_start(dev, 1),
+			      pci_resource_len(dev, 1), "lxfb-gp"))
+		return -EBUSY;

-	ret = pci_request_region(dev, 2, "lxfb-vg");
+	if (!devm_request_mem_region(&dev->dev, pci_resource_start(dev, 2),
+			      pci_resource_len(dev, 2), "lxfb-vg"))
+		return -EBUSY;

-	if (ret)
-		return ret;
-
-	ret = pci_request_region(dev, 3, "lxfb-vp");
-
-	if (ret)
-		return ret;
+	if (!devm_request_mem_region(&dev->dev, pci_resource_start(dev, 3),
+			      pci_resource_len(dev, 3), "lxfb-vp"))
+		return -EBUSY;

 	info->fix.smem_start = pci_resource_start(dev, 0);
 	info->fix.smem_len = vram ? vram : lx_framebuffer_size();
@@ -546,19 +542,15 @@ static int lxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err:
 	if (info->screen_base) {
 		iounmap(info->screen_base);
-		pci_release_region(pdev, 0);
 	}
 	if (par->gp_regs) {
 		iounmap(par->gp_regs);
-		pci_release_region(pdev, 1);
 	}
 	if (par->dc_regs) {
 		iounmap(par->dc_regs);
-		pci_release_region(pdev, 2);
 	}
 	if (par->vp_regs) {
 		iounmap(par->vp_regs);
-		pci_release_region(pdev, 3);
 	}

 	fb_dealloc_cmap(&info->cmap);
@@ -575,16 +567,12 @@ static void lxfb_remove(struct pci_dev *pdev)
 	unregister_framebuffer(info);

 	iounmap(info->screen_base);
-	pci_release_region(pdev, 0);

 	iounmap(par->gp_regs);
-	pci_release_region(pdev, 1);

 	iounmap(par->dc_regs);
-	pci_release_region(pdev, 2);

 	iounmap(par->vp_regs);
-	pci_release_region(pdev, 3);

 	fb_dealloc_cmap(&info->cmap);
 	framebuffer_release(info);

base-commit: a859eca0e4cc96f63ff125dbe5388d961558b0e9
--
2.52.0


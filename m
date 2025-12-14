Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E09227E95
	for <linux-fbdev@vger.kernel.org>; Sat, 13 Dec 2025 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765655069; cv=none; b=a6f6K0vOVpQdbmz0F9HKyXhIkJ4s/HftS0gwaeIb0xaZTdDAd5unas9p+kS4vN6Pq8lBLL7d46GUG5obhYL8BsqGjma8b6zXIahBP0JXJaFttZ+7U5kwsTW62zevXTy/fkw4tnpCL5HlfBGvESq+atBli1dOqT+bqsCwFAxY6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765655069; c=relaxed/simple;
	bh=AMCWE44u5cMS1x6aBJsr5DzesxKcso31kx+fu4vsM3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZ6XUho7yBwowoLu06mo/hS9UAXCcoSEydtnfS1gIVvAGSa+VJfUOW0jUqWLngtVdwnTAQok3hxjR646XqVAs4MOVmkofNr/J2YCekihIwNMz6x0Z3yWOsIxsOzpYzGUWIY1eFhKgt1aTGudDdp1/BzJgKa8wZlewSy5iwYOcuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=az27o4aa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az27o4aa"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0c09bb78cso642545ad.0
        for <linux-fbdev@vger.kernel.org>; Sat, 13 Dec 2025 11:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765655068; x=1766259868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vpBRllM73qDKL2ScMHTVO5zPyQi4kKb5Ruh0b06m8BA=;
        b=az27o4aaZ/OvMYYVppqOimRrb0mZDrBkcLjZvMJzf569iscpkckFHZmu8JEB+FKgmL
         FBQzqZu4nR3tpyjjXrEbiZaqkRocaSXSMJfjbcJTA7KNKvvygI9s3VWeoKqgYYcK18pT
         Mq68ncCbBn84jO7rlDoWZ1cNWheyGBSxVoqSS/rXFTkfT2Rq/Kx3B8aCy797SuEI+vdo
         ZS1QWExwnuEwrDzJrW0jjPXOXPlmyaT/VvbidK1NBVG3cUiWuI7+ADKrnGnl2oHz7XJB
         5rMWWuII51yJVBmiIVg2kkC+VrgVBRVk/ac4YdzkHNEAciiRpHHqmceeWfmMeMILfY1+
         QgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765655068; x=1766259868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpBRllM73qDKL2ScMHTVO5zPyQi4kKb5Ruh0b06m8BA=;
        b=GODTLbzr+oE8Wa/m5PToZfvQ7V4sRnq/tfplBM0G8gr+Oco368es12nTHIlIVHH9Jd
         ow+ETScHKFPJDxoU1mfWZ2zorLDaKnGN7F0bp3fa+awVJMyytwJULGLY9WQ3b6ftjjXv
         GrXLClQhBqYAzUC+v/Ywxu7/+8C5lcETnkt0ZBoJOpROtThimUKHzGm3mz7pOEC+IITJ
         pfjdrkpJp//NT6t1barhPZNIz8gK43JhJ+E2C3XmnYOTdXkg7O7QCVbxARR0GEd8hEXI
         Srx27ipcA0nQVD1O6jpMoXoz0IrnopcN5+XCuRNRHfBAZoubw3If5fHdn61izSo2u0to
         suLw==
X-Forwarded-Encrypted: i=1; AJvYcCUN0PfV61U5x5bDqIRoCoFBQ+Aaq4mcny+1U1/xlfdgAXWBayVkatp5Z4WouJ3Dper/xNGKYlvLU5VGRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxplZzmgqaC+Kl9dxFG/RY06/+0SIiImuKEcWROBSmQrtJs0p7e
	gnTWWUikJsqzHT9gn2JokgeR7JxN0DtJ5EUMX9zAIV3vx/P7ROM0657P
X-Gm-Gg: AY/fxX7dNDeblzpBEh0vgP4aVNS95Ye5dm0xesjP7C/0LuSEq+u69ZJBD3rAncEQqql
	YuF5XlC387IzhC3m/oagnVfxBt5lXMXoYqzVZjQsQOS6Vqv+qpcDIQNL74XCGQ/yIJvBFN8FKOh
	jSSY7AGwZ2aafqKrIR7nToaYDFenaQ2Ci+MIqpWPKYgl8faXMO8WNqETjtkCEuXdlw8pD5NmXO6
	XtAqDVW2tUiG0xVR9r6hXdz/2yWhCRlT1LHGncVQCnzEbX5Nhe6Tqp39yisGWsmWV4ZaRbNppJ9
	N+/PJNq70BpRJtoEFqIzINczlW/mH5BeB3+V/B/LkoiDWaL4/k+GN3HnZ54ORiZY7+qmht5IwNd
	IFxsfxF/JoypQBgz9QyWIEZWMPkRgV5xlnb6gJXqIdo3C1k2DQrAS3ALs8ivz3llNzYMsu26RPO
	nj5T+T0Vr+kDCcXR4HU49D1dOS41ubDw==
X-Google-Smtp-Source: AGHT+IGyg92faWHXBt9zaVvBaBKtx3YFvdCAWY30UKXOk6xfy9iaNTDpTPM7MMtl4koyXzcqOdOtQg==
X-Received: by 2002:a17:902:d3ca:b0:298:68e:4042 with SMTP id d9443c01a7336-29eeec1d557mr62341375ad.26.1765655067642;
        Sat, 13 Dec 2025 11:44:27 -0800 (PST)
Received: from LilGuy ([2409:40c2:105b:dc88:1107:395c:23c0:2b1b])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29efd74f5e1sm72818695ad.16.2025.12.13.11.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 11:44:27 -0800 (PST)
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
Subject: [PATCH] fbdev: geode: gxfb: Use devm_request_mem_region
Date: Sun, 14 Dec 2025 01:13:59 +0000
Message-ID: <20251214011400.300460-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gxfb driver currently uses pci_request_region() for memory
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

 drivers/video/fbdev/geode/gxfb_core.c | 36 +++++++++++----------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/video/fbdev/geode/gxfb_core.c b/drivers/video/fbdev/geode/gxfb_core.c
index 8d69be7c9d31..05af546c8c92 100644
--- a/drivers/video/fbdev/geode/gxfb_core.c
+++ b/drivers/video/fbdev/geode/gxfb_core.c
@@ -223,31 +223,33 @@ static int gxfb_map_video_memory(struct fb_info *info, struct pci_dev *dev)
 	if (ret < 0)
 		return ret;

-	ret = pci_request_region(dev, 3, "gxfb (video processor)");
-	if (ret < 0)
-		return ret;
+	if (!devm_request_mem_region(&dev->dev, pci_resource_start(dev, 3),
+			      pci_resource_len(dev, 3), "gxfb (video processor)"))
+		return -EBUSY;
+
 	par->vid_regs = pci_ioremap_bar(dev, 3);
 	if (!par->vid_regs)
 		return -ENOMEM;

-	ret = pci_request_region(dev, 2, "gxfb (display controller)");
-	if (ret < 0)
-		return ret;
+	if (!devm_request_mem_region(&dev->dev, pci_resource_start(dev, 2),
+			      pci_resource_len(dev, 2), "gxfb (display controller)"))
+		return -EBUSY;
+
 	par->dc_regs = pci_ioremap_bar(dev, 2);
 	if (!par->dc_regs)
 		return -ENOMEM;

-	ret = pci_request_region(dev, 1, "gxfb (graphics processor)");
-	if (ret < 0)
-		return ret;
-	par->gp_regs = pci_ioremap_bar(dev, 1);
+	if (!devm_request_mem_region(&dev->dev, pci_resource_start(dev, 1),
+			      pci_resource_len(dev, 1), "gxfb (graphics processor)"))
+		return -EBUSY;

+	par->gp_regs = pci_ioremap_bar(dev, 1);
 	if (!par->gp_regs)
 		return -ENOMEM;

-	ret = pci_request_region(dev, 0, "gxfb (framebuffer)");
-	if (ret < 0)
-		return ret;
+	if (!devm_request_mem_region(&dev->dev, pci_resource_start(dev, 0),
+			      pci_resource_len(dev, 0), "gxfb (framebuffer)"))
+		return -EBUSY;

 	info->fix.smem_start = pci_resource_start(dev, 0);
 	info->fix.smem_len = vram ? vram : gx_frame_buffer_size();
@@ -414,19 +416,15 @@ static int gxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
   err:
 	if (info->screen_base) {
 		iounmap(info->screen_base);
-		pci_release_region(pdev, 0);
 	}
 	if (par->vid_regs) {
 		iounmap(par->vid_regs);
-		pci_release_region(pdev, 3);
 	}
 	if (par->dc_regs) {
 		iounmap(par->dc_regs);
-		pci_release_region(pdev, 2);
 	}
 	if (par->gp_regs) {
 		iounmap(par->gp_regs);
-		pci_release_region(pdev, 1);
 	}

 	fb_dealloc_cmap(&info->cmap);
@@ -442,16 +440,12 @@ static void gxfb_remove(struct pci_dev *pdev)
 	unregister_framebuffer(info);

 	iounmap((void __iomem *)info->screen_base);
-	pci_release_region(pdev, 0);

 	iounmap(par->vid_regs);
-	pci_release_region(pdev, 3);

 	iounmap(par->dc_regs);
-	pci_release_region(pdev, 2);

 	iounmap(par->gp_regs);
-	pci_release_region(pdev, 1);

 	fb_dealloc_cmap(&info->cmap);


base-commit: a859eca0e4cc96f63ff125dbe5388d961558b0e9
--
2.52.0


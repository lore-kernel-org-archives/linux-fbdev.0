Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7823504B
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048406; cv=none; b=PBMY2Ao4NIqdDDwhhxCn6lY/KBp08FyMsDiDmBQ9dCfTZlfBR9KwZuXZQeu4KinPqGFN+3rVJzYjhSZVMyAG82Az4J5PDoZxfad9L3WQ/q74UfvvIfnd/QXmwVJGCn81CKjbvKMkpLw3lYMoI+VR271EA8TBMUlux8DB77ps1z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048406; c=relaxed/simple;
	bh=fWAdnNp6S9fa7yC7p4RxMwzLXSQupmIgT4NcZ1R7fAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aphIV1p1e0VlZH2dtmmagfR0MZ+RH4X2KMu4l7c2Sv4TdYzPDVtQlVxTfT4P9K+ArKPST7XSDVPRFlYUdKGV1fxj+I0E1cRE278QuJHM9NsFmSAo1Q8NSAMjWJMlqRwxU84GC5Jq/YYr0MQq0w+hZ36D9myIDjvDly8HtgnS/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ydh2HE//; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ydh2HE//"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36a8ee1e28cso5944135a91.0
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 02:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780048405; x=1780653205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpuWQIio79Op9n9NGUwcLhgNaTc0EoKJH55R45RoEes=;
        b=Ydh2HE//Uxd9tOYJJwsaP8iFd3ywW9KmeGmGWe1kRRe059VRc077gC3wbU5JKmFKAJ
         Btb/D6LVQUfNNgSWe46RUTgcM5AxxAHYFLZcLpVGres440wnU7EbqvkYPdaEG6JZXuIp
         rJLeIGPX1DLgQyejPLvF3wDzrRxLUWgv51jAsTuUedmuGu/y1yykNwWPce3Zl+EV7Z0+
         4bd+yBLA2WSKjPK5g60IYKcSNgDYB14fDtyiXLRjvwbHAOPCDg4v7C9cEDHSJNncyu5n
         7JHF0V3DBOzXnZv+mokrgQ6gz3kzuOUu0+JhLUuDFwwGNRCXRiB315gPGQIFsXFELKCA
         hdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780048405; x=1780653205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpuWQIio79Op9n9NGUwcLhgNaTc0EoKJH55R45RoEes=;
        b=kamk2zuw6sramLzxbp9HoHxEjV93c2UZTRM2BPy4sDnoZOLxQpghnOquHxrtVgSE69
         fTNDlc41wEdjqupPBWW1+SHGi7AAm6dIuCNbNLEiclb+UkJ5kGDT3OBTxtVxvTfKaHF7
         mwwpb5oKkd6VHWZIKc9mB1DBnVexLP59XybKiol/mfKYHgzLM9O/PFXv9p9C+piMbiPZ
         avQdKHCv+bK5svjINt9jIlVdx/63w05dffH/ABBhNTtnkAHGlZqLWCRPmYnS18cUhc/7
         OIoVJLKIJxBSDuBBG7+cv7R6emHJsgEQCJ34zr3vw6cSSkKHEgxGKm6yHF2FiWTENgCe
         bfPw==
X-Forwarded-Encrypted: i=1; AFNElJ8in4UPjSW6DeFmcgC4chFv7ynAR5wcxGoWXJyxU+xMQnYuKAsoGQ0G6D862skQj8yWutjEqAQ0fBo3QA==@vger.kernel.org
X-Gm-Message-State: AOJu0YypsaR32qPdAjhafxDqPlol5/L+T6HC/H4FOdZ+1Cm2QYlXp3AK
	0GA+Pe8Zei6mQ8ZOjpAl5o42pIELrpxspXzArnx2JtHA+ndohCIB/kVV
X-Gm-Gg: Acq92OGKz8h82t1rll9TzUryr+LAhw99QD0n6R/MU8cx1aFvJ0K/FKDijDfit+hYIgS
	vyWY1iqzpNmmfKBZaLCno2lfuaaqpW3Z9QoGeEG+TseGxvOroBfzHYt+32kb4pjkjdmK8eQ2jjq
	p5nO2kEhCTuG6Xp45sHCBSLEUOLCcB6P/VMVRXmS7scthh+zE9Bnt5lqqWMr9C2reDop1mTKX/F
	IV/0vTEckLjTeGAbZsYmYI9eumG7DK+39sty8QOOu9Q2JxSREmJ8eWAeqKoKDHObhpco9HKoFcL
	C8QCz79cD4+dadGnQrtmwyiOB0IfEAyOB9UAVtc/p+N8J30Qgk0QmZmo0r2wzn5U4XohoUYFP7m
	a90cNRR/vxvYreR8pGWnb/lhpvvCKtf2NmFAJX+eZ/czTaVP7Z5wpLWVgc5o1/BuP1uym8b7rbT
	HrOL9f+zp4DIFzf6bn60o2r7Ru3lzLFAA+
X-Received: by 2002:a17:90b:3c8c:b0:36b:a0fa:ff96 with SMTP id 98e67ed59e1d1-36bbcd99b10mr2981231a91.12.1780048404665;
        Fri, 29 May 2026 02:53:24 -0700 (PDT)
Received: from onish ([2404:7c80:75:55f3:d423:9757:6acf:6ef9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc1d9f2bbsm993497a91.2.2026.05.29.02.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 02:53:24 -0700 (PDT)
From: Onish Sharma <neharora23587@gmail.com>
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Onish Sharma <neharora23587@gmail.com>
Subject: [PATCH v2] staging: sm750fb: rename pv_reg to io_base
Date: Fri, 29 May 2026 15:22:33 +0530
Message-ID: <20260529095233.9015-1-neharora23587@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ahhN_kiSb-yRWfiI@stanley.mountain>
References: <ahhN_kiSb-yRWfiI@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename pv_reg to io_base to follow kernel naming style and improve
readability.

No functional changes intended.
---
 drivers/staging/sm750fb/sm750.c    |  4 ++--
 drivers/staging/sm750fb/sm750.h    |  2 +-
 drivers/staging/sm750fb/sm750_hw.c | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 716a8935f58d..c2d2864f135b 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -743,7 +743,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pv_reg +
+	crtc->cursor.mmio = sm750_dev->io_base +
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	crtc->cursor.max_h = 64;
@@ -1047,7 +1047,7 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->pv_reg);
+	iounmap(sm750_dev->io_base);
 	iounmap(sm750_dev->vmem);
 	pci_release_region(pdev, 1);
 	kfree(g_settings);
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index e8885133da2e..c42800313c6a 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -97,7 +97,7 @@ struct sm750_dev {
 	unsigned long vidreg_start;
 	__u32 vidmem_size;
 	__u32 vidreg_size;
-	void __iomem *pv_reg;
+	void __iomem *io_base;
 	unsigned char __iomem *vmem;
 	/* locks*/
 	spinlock_t slock;
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 95f797e5776a..dc1118808b4f 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -23,18 +23,18 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 
 	/* now map mmio and vidmem */
-	sm750_dev->pv_reg =
+	sm750_dev->io_base =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
-	if (!sm750_dev->pv_reg) {
+	if (!sm750_dev->io_base) {
 		dev_err(&pdev->dev, "mmio failed\n");
 		ret = -EFAULT;
 		goto err_release_region;
 	}
 
-	sm750_dev->accel.dpr_base = sm750_dev->pv_reg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dp_port_base = sm750_dev->pv_reg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->io_base + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dp_port_base = sm750_dev->io_base + DE_PORT_ADDR_TYPE1;
 
-	mmio750 = sm750_dev->pv_reg;
+	mmio750 = sm750_dev->io_base;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
 
 	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
@@ -58,7 +58,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	return 0;
 
 err_unmap_reg:
-	iounmap(sm750_dev->pv_reg);
+	iounmap(sm750_dev->io_base);
 err_release_region:
 	pci_release_region(pdev, 1);
 	return ret;
-- 
2.54.0


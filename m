Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663C23D2FE6
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053591; cv=none; b=Lvum6/vpZPpw0FC05ybl/teAdvJVOnBsqO3+/j6BKLoAYZ2Iv+37EY3VJ71NZEUpBpb7z4qcAei6N9VudfMp5E59EfD/ihNZni3845qI6nk8N/hH79z7rpQ5knccpMJionBc7PsdIlXlVCfG/dZVmd6yXuwldgMdaReH9MRMGqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053591; c=relaxed/simple;
	bh=OGcciJ6W6CeaavRf76dr+/31XpWcTllTwZpLV2apEtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPo+fY4HJ8SrHa9LBm8i+jCoK8aQqyfc0w2JIyGc7Ufm5MLoAkPPv1uqB4XU3qIR8piEBk/2k7CH1gZeq7wkP8NU58NlkXLDG5oMOP8+Qk5/Fec6LKhgkJHeorPbz0zzuaILb3aFHUsDzk2O9G45XuyKMNdT1IMAdZZ+8mRxEss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKxaO8+8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKxaO8+8"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36a8ee1e28cso6001076a91.0
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 04:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780053587; x=1780658387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWrnxSsae63bDDyuIeyXqVcedd+iF5iTIGjUSHH9BKM=;
        b=DKxaO8+8h0yeMdFxTDgkJQTmk28cwISULv1rndV9IpyCr8WGP8o6sn2RV+52e13/Su
         uGyxTEwSNUspryZm+Tcl4NQL5JC5YDUCaIs1s+WYhR1LclbR7AG8jXDADdHSicKoBq9B
         gglxZzlEBxRn+JAx+q78jK6SYGaeergV9LoSi24jc8MDELNhvY4gPRdyN1ync9i6oWM8
         sIQiiwJbgJcHMPPjt1YSujBeTmGj6qqGccPUdPfhRhwzvz8m8MzZGsQpMJvpvVZF98dw
         NWBKUWK0r3iWR/tIcCWBMh1pEngSzPUJGrepyqJkN0bTgjEHPRJCODyBSkV69y+XWaQi
         t/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053587; x=1780658387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWrnxSsae63bDDyuIeyXqVcedd+iF5iTIGjUSHH9BKM=;
        b=n384chEZaUBQak6oEka9U46H/O4iWQvBmHE0YO5bepdVOCS/SxulfdWhv3fiRvUocA
         rpFhhwZ5PRgGxUa7mnklaNMQBlMopegA8orMK2s918H1l0etAuwzCJS4DSDpZscSiSOj
         4xNj5laa4IEl8VCXU0M8BLqitfRm4kIZXbVSClJZomAO6OMvS7hNGrveUvR6a8RxnwGw
         p70fpdTsWjBTmOZfN2FRLLMYBqIMi50DcJx2K3SgVkg+ws8y07PPammQTho/p3cknrc/
         DWLj8BLIMIR2YW7T0zo/OS5qJw28y5P1kuHKxsraosCVaMdP3RzBUJSgweMe2dy1dbrn
         tgaA==
X-Gm-Message-State: AOJu0YxmKEcFLKVPSKT1gfKagCcOAyg+58QqZYtr/JspWi3keOCQWGh6
	Q5IrOBER2Ab4b+o70g4JGyiojWAoKXZCUmxylo0j4ZAzvXDh7xraB3nn
X-Gm-Gg: Acq92OFKmAFhZUBQePUSk1MZHdIgUxyzpRrnYtbiusXdBDT43WWDoo83p4JVyL1sNvM
	u9QMvYfTWEiqYM16/jPeD8kqSxDLWy/aUIA32M9tPyf13uo3JPUdp4mpgUGNmEjBz+TXK/Arvpy
	xlHDsU+P4AzDxVCYpJF7MN/jR5pcCPO4Xe9iGXojmAWN89GYvEhB/zdEMCzZLO54504Shl1Ac8i
	JOWCwK7YDp26DCbyAp6iH8JG9V3FItP1Uh7eJi2/YCDjC+gRDSAzZ0v985rGTfn1loxqH0+TCKT
	RFRdcjQoJu+WozLtE64nCcGCyYPXu14abw2cI8lWpfipOTtXKoTgw2qYR8Z1Z/YbmY6CBsh8Fkg
	vU4v5D7fd0pv0pl9zHFfvcYrNSTxRTgpuIc4ntzbQaYUU1pyg3BwAYsykVMJceqvs2r1IqSRrnY
	j4f5H57gnKkwzz2O3BwJS9n/pOl4YbGS+E
X-Received: by 2002:a17:90b:3c09:b0:368:f0d0:1ce8 with SMTP id 98e67ed59e1d1-36bbcd63077mr2994526a91.9.1780053587514;
        Fri, 29 May 2026 04:19:47 -0700 (PDT)
Received: from onish ([2404:7c80:75:55f3:d423:9757:6acf:6ef9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc0c1ab21sm1826945a91.14.2026.05.29.04.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:19:46 -0700 (PDT)
From: Onish Sharma <neharora23587@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Onish Sharma <neharora23587@gmail.com>
Subject: [PATCH v3] staging: sm750fb: rename pv_reg to io_base
Date: Fri, 29 May 2026 16:49:27 +0530
Message-ID: <20260529111927.14138-1-neharora23587@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Signed-off-by: Onish Sharma <neharora23587@gmail.com>
---
Changes in v3:
- Added mandatory Signed-off-by line.
- Rename pv_reg to io_base to remove hungarian notation

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

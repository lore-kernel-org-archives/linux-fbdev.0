Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434122C0303
	for <linux-fbdev@vger.kernel.org>; Tue,  7 Jul 2026 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424736; cv=none; b=bWNP8cV1HnQ6qR9/MImUYTgEGx/96dTord3DkBUkEtaXyvW4TROIwS4QaFd7SaYGTPUMTVeYlpNUD9hdV/l9dw6+KHRaxqRwmm2ugN1MF/navF6Z2W0kikpeZeJy5NldrkQ0xZHYBKHxSIgd4wtbZiK18/ct/+vZtt9di3zAPuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424736; c=relaxed/simple;
	bh=SoJJ8BOMf7cdzDJ0cUre6solF4ZSDAQO1ZeC2RRfv6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7/AzKAIZW0bGGd8VtfRfKQmVFGbiHKn1n93rCxBzB1T8w5dU2sUbB9epKocL/HnR39cLnjoH5QG/qBrK1Z3Wm1TbzIgLe+1Aoh6Kh5rmgSEHovE9J1x/V3uqCsGr0n6eQtEnl4fkfRV8peSxIPwntc2AvLZ2wJPGsb9BvFyiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2paVRZ8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2paVRZ8"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso5449422a91.1
        for <linux-fbdev@vger.kernel.org>; Tue, 07 Jul 2026 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783424735; x=1784029535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qxi6illuNTTea6xdL0f4eYIc+eOVoLU4Wgp7U1BzVO0=;
        b=L2paVRZ80jnnrfoUW6Num2jxc6W3rPIL7ihNsj4hqH5TFZCLl4e9YmHYxKzeeMnv7W
         TnlPhjq4U/UmAOMKFNXY3HbR4mQ0kSI8HVpm1BVztJb/x/g9nviRVP0hBCbEPm4uDECE
         U6xQdQjK3V4+0NfnQbt0+fcx2E3e2QKJqSSQaosKCCg7lsmsnILsfv3fZ+LWNxkuYgKG
         ZGaLXY27p5X8LO0A006PLKNtS/ZShgxfoDhggiBuQwQzNhWuZCg5IkQmeaFEnOoNPX9p
         x47kj6fprxHxTxpC6F9Y4jTV1Q9xYaE9JnzmdyA4p+7Jhrm/DqlAyZdufggB53Ur+Sz+
         fHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783424735; x=1784029535;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qxi6illuNTTea6xdL0f4eYIc+eOVoLU4Wgp7U1BzVO0=;
        b=HZvKBB/AgXYYpdapT+e0PsPuu/PTlRiqkG3po50OI0Ot6ok73PRodhuFqT6w0Fx+vw
         +bpoysiAzF+2LROyY4tNRQ6QqsQLIVMt/atR24z5z2lkk676++5kgwcF/EdmbDRQAXCI
         HNGzkjALmX8Xx6QjZu7684eumBjJ46xh6ublEwlWvAcWskEfvJX/6HVEACBPDnh5DLOR
         vcTqX5Dp7nFnZBwDY48pw6ILFter0siLWcQ/K6GW79d/Jo0TwGerUJiqSOHCEs9v6sJt
         BJVVYRiQ4k7BocVEGamj6uVx+FssIJAodpDZgX6Sw07Y5sCycHHLz4/iH4BueRNt69kH
         l0Qg==
X-Forwarded-Encrypted: i=1; AHgh+RrAQU0soG/GMg4sN4yxgRW/defq7bw2dLcBYVV7Ss2/L4WzQmzB51rF6D6jbQAaD9MKwMl/v9Kdw+LeFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRVd/+/lwZSHp6Ai0kizYBlU5uUzypoZ/wq/b5Qsdu0cesF54
	GHpTw7Tjw+hbxUwKu/7goyq141w6s6B+nrxp9GFRbt5JqHH+2aMbDs+C
X-Gm-Gg: AfdE7cluocqW6K1cgn6hoCH19bOhN1hUKfYnujQ3tsD4yKQ3W4j7h60WbDxnOMN0pTv
	522yBzOx0ASRe2obHKfk9rl3AqNOjOFiqOt0MFk24Sw6bUxIZuZOHsHU410o/TJO1e/PEhHE/4P
	lcENiBN6Z26QpDVlck/vixPXnDgF4g8FZn85FE2sfiy4rCPlh3yZDPCG7CcVSil8kDzwHAXv0EO
	QQkDNt4oPDKXR783gkrFrt4McvYySC+EvlOYcLlaeFlJjFv6S9MmFN0cestMwoMRdh68GOThXFl
	eGLOQx05VfyGJ6B1ix5WvxTP10YPPZKIADHIz6F8fjj9qx/WlYF5yeu7fxpPFv2yuyu5lUj8pvW
	H5zl343+1Qh4gEudkBX9v4lqQYnfIUfP4TH4kntPy5ubIU+c75gCjRKh2J0DO/PZuiRLQ6XGmTI
	jpKEETeLI=
X-Received: by 2002:a17:90b:4f47:b0:387:e0db:3fa9 with SMTP id 98e67ed59e1d1-387e0db4809mr2744852a91.34.1783424734563;
        Tue, 07 Jul 2026 04:45:34 -0700 (PDT)
Received: from adr.. ([103.216.221.83])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f598dsm8204137eec.6.2026.07.07.04.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 04:45:34 -0700 (PDT)
From: =?UTF-8?q?Andr=C3=A9=20Moreira?= <andrem.33333@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Moreira?= <andrem.33333@gmail.com>
Subject: [PATCH v3] staging: sm750fb: rename variables to comply with kernel style
Date: Tue,  7 Jul 2026 08:43:27 -0300
Message-ID: <20260707114327.22950-1-andrem.33333@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026070710-exact-unveiling-e321@gregkh>
References: <2026070710-exact-unveiling-e321@gregkh>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rename 'pvReg' to 'regs' to remove Hungarian notation, and rename
'setAllEngOff' to 'set_all_eng_off' to avoid CamelCase throughout
the driver.

Signed-off-by: André Moreira <andrem.33333@gmail.com>
---
Changes in v3:
  - Added changelog history to satisfy the bot.

Changes in v2:
  - Renamed 'pv_reg' to 'regs' to completely remove Hungarian notation, based on Greg KH's feedback.

 drivers/staging/sm750fb/sm750.c    |  6 +++---
 drivers/staging/sm750fb/sm750.h    |  4 ++--
 drivers/staging/sm750fb/sm750_hw.c | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c4..7cd9cb0b3498c 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -743,7 +743,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pvReg +
+	crtc->cursor.mmio = sm750_dev->regs +
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	crtc->cursor.max_h = 64;
@@ -848,7 +848,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	sm750_dev->init_parm.mem_clk = 0;
 	sm750_dev->init_parm.master_clk = 0;
 	sm750_dev->init_parm.power_mode = 0;
-	sm750_dev->init_parm.setAllEngOff = 0;
+	sm750_dev->init_parm.set_all_eng_off = 0;
 	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
@@ -1047,7 +1047,7 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->pvReg);
+	iounmap(sm750_dev->regs);
 	iounmap(sm750_dev->vmem);
 	pci_release_region(pdev, 1);
 	kfree(g_settings);
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d2c522e67f26a..32f9a9ac7be73 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -44,7 +44,7 @@ struct init_status {
 	ushort chip_clk;
 	ushort mem_clk;
 	ushort master_clk;
-	ushort setAllEngOff;
+	ushort set_all_eng_off;
 	ushort reset_memory;
 };
 
@@ -97,7 +97,7 @@ struct sm750_dev {
 	unsigned long vidreg_start;
 	__u32 vidmem_size;
 	__u32 vidreg_size;
-	void __iomem *pvReg;
+	void __iomem *regs;
 	unsigned char __iomem *vmem;
 	/* locks*/
 	spinlock_t slock;
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 34a837fb4b649..c5a495bb5ac57 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -23,18 +23,18 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 
 	/* now map mmio and vidmem */
-	sm750_dev->pvReg =
+	sm750_dev->regs =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
-	if (!sm750_dev->pvReg) {
+	if (!sm750_dev->regs) {
 		dev_err(&pdev->dev, "mmio failed\n");
 		ret = -EFAULT;
 		goto err_release_region;
 	}
 
-	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->regs + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dp_port_base = sm750_dev->regs + DE_PORT_ADDR_TYPE1;
 
-	mmio750 = sm750_dev->pvReg;
+	mmio750 = sm750_dev->regs;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
 
 	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
@@ -58,7 +58,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	return 0;
 
 err_unmap_reg:
-	iounmap(sm750_dev->pvReg);
+	iounmap(sm750_dev->regs);
 err_release_region:
 	pci_release_region(pdev, 1);
 	return ret;
-- 
2.43.0


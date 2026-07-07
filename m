Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151F23D7E3
	for <linux-fbdev@vger.kernel.org>; Tue,  7 Jul 2026 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420327; cv=none; b=mbWuz7WjBtqLGoMi1gR5XCT9xM151R/PX1RhNwogljfQLe9T8/55ZmDYplOXHQjb7chHbBOpeGDB1cYVtAhnVyy0bgxbcmOPMPyjsbLm0ZspisBL/4tjB2PzUPzyBu9UzFcRFkWgM1KXH6cvLVNLS6NdeT/4Zsjj5fl/lkYu76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420327; c=relaxed/simple;
	bh=j1XBFunEU6BwQkC5nNZIrOSvYAs4W1maioqJqDuKPAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6UyMHXxMwoV5ZyFXAXsgP54999vf/DAzL55A00GdZv0nEotELqKrZFy0eVpzdrV/xfg377uuKcWrtItP+U7ArtClTqTS9qiI7A7dMHJMBLZ3NvryHQMDFETxBW7lqVS8bXUtM7nCpCk0EsM+kVYUvWBdZG4c8VozHS4cFuFX8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXrCtk4N; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXrCtk4N"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso2872620a12.3
        for <linux-fbdev@vger.kernel.org>; Tue, 07 Jul 2026 03:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783420325; x=1784025125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6xy7w3iaM3CPGjGH2norsW2YY0eS10nlgFN5gxOYh8k=;
        b=ZXrCtk4N02Xs4WJw6MAP2/LTQLM0ZbB+rkJntI2v0RyHerSxdhLnyGBJNcjkQIRzH7
         51Q2knL7ROidIUf255Xsfis7dLabyt2o+kIkviLHKLX1gr/DIrryNowpyQyb+RDqVeUK
         oOOVbsHYxiOvMT9Xx+5tzlD1+YJceeKraY5qkSiPcNbnNn5DJqd9XmCuE6iCQyqYvjmq
         0lpQ+/t/yzCvthmCTZBKTF73hH3W/+xdU1wyMJOh52uNbp4Zr1KxfWgh7JZQZ4j2TTge
         /hOX9kEYqyFPoKdtpvOfGw76VtaCrAWN6nZiv2zy1YE5NgzJSC7qxn2AgQ5Ot8blks1g
         CoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783420325; x=1784025125;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6xy7w3iaM3CPGjGH2norsW2YY0eS10nlgFN5gxOYh8k=;
        b=XiqtrGtdO0lzWPU6VJzbveDLP+wMcb3U+Lafd6KnTFcNSYaabLNkeYbF5ZEfF4sJmH
         R3NlzbH+JwbesQ4xtBvpdJ/F8577l65vA1E3sUfqHP1Q13oVugr6Myrro3LhVFkZUnYA
         MU/1xy7lBiF+xBgcv34aq3Tn2oEjuCQCvboqeqwz2wEWrLsqKaJNkRiWneg3YEvwsuhx
         iX0drCyM8p8evKFYXVdf7wTjeYxDgs5yhboUuYDdZCmQaTnLEhy/Cp4/bvHopWJ9/QBY
         43OBrbyFKb3i0UBGbzgE1KbqFPKHYkJ4X/PlE0qdILuST//RN7wTmutUQJZbsqF+Dsz5
         FXtg==
X-Forwarded-Encrypted: i=1; AHgh+RqTQB3oxb2VgKS5+KbtyYKyhWzlHRWeNEMf3kmGuyfUC2yoM5O0Yh8Bd/XUSy6mRFcwPlUKWwRxHj8Udw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSzmRWbZtCwjIBC5JCMf+o5pxs4wbZOSeFwdrp+/IQCqceGIPN
	uVWNV3rzWXKjZcF2dOMEijNJ31Y1jVLGuoe4DcGrWCMrtqBPQJFKj4lF
X-Gm-Gg: AfdE7cnjlmVRTYWWOE4TZZ4f9GMnEbyfN7t3AzQ1A8Om0eaAoBMcODR2vVmnpNN+G1e
	8abhJMITgfWLEKs5WBQcD2yD/Te2MdLbGk5895e+NO6jsV5slnm4nUDJJH3XidLkHsIOONniu/o
	61hTvnl9ss901YYsnB11+wlc126KicAOGpAdxBaK486aC0rjJKdxhaiPRv4R6HkZdtuGzWIeY2B
	GWUvoZnrr6u8QjAPylUIG/5MhoV42B9wVdK1nzt3dhJ5UqNvgbBT873+xVdR6yQfJVAnWlDYbnY
	H74BJA1jPskPo1LRDUn7AwxfdA1mZHxX4scBuXyWNSCfFUcXMQuCYLn/XA7kBpfzUCsvgWhAQZR
	Y2ggYqa/URSNVYnG2rZrWqFsehL6t5hODjqOu1BPl+58sPbqkSONfx0idzcmWZHfqpSb5lk0UPh
	/mbeMwN2g=
X-Received: by 2002:a05:6a20:cf88:b0:3b4:605c:2163 with SMTP id adf61e73a8af0-3c08ec71668mr6396365637.4.1783420325236;
        Tue, 07 Jul 2026 03:32:05 -0700 (PDT)
Received: from adr.. ([103.216.221.83])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c8665sm7264138c88.10.2026.07.07.03.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 03:32:04 -0700 (PDT)
From: =?UTF-8?q?Andr=C3=A9=20Moreira?= <andrem.33333@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Moreira?= <andrem.33333@gmail.com>
Subject: [PATCH v2] staging: sm750fb: rename variables to comply with kernel style
Date: Tue,  7 Jul 2026 07:27:48 -0300
Message-ID: <20260707102749.15163-1-andrem.33333@gmail.com>
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
the driver. This complies with the Linux kernel coding style.

Signed-off-by: André Moreira <andrem.33333@gmail.com>
---
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


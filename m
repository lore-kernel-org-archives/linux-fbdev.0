Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610922ACFA
	for <linux-fbdev@vger.kernel.org>; Sun, 12 Jul 2026 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783856025; cv=none; b=ez3zc/fl2YcHcR8qvoDHPymgM37Be9lc4cc2B/lDG/ixKOCbAFzLi43JT4NcuvtKqibfDxpOJAmQpX91+WiRZFKHC4K2k8bGFrOcE1NxvS/JkBKJfvYzspmC7aEvFiaK7xXC/tFbmWK0VV2dsgYSmDeinl+1DCm46GVMRqCwPmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783856025; c=relaxed/simple;
	bh=jF9fsCkkGQu1f7DEOkog22pDX+f4gpxLB5Vx9AMYf1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N6Nf4BK6xaWFYT80fmjJrTNvQ+trH07uiYOm/mo3Yy3UblRJlR8fj/aDpiQRJ1MPlDc61agjy9D7pOZQuzc/nh9qipgZEzuAG0bvqB7UCsOg7gkufNww4DxXvo9eDlrhWrAjW8vKOjplh4AlkNVJTfY3kLxPpZ2D1FoUsb7qU/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lW9kyDhK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW9kyDhK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so16959595e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 12 Jul 2026 04:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783856022; x=1784460822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ImbRmyPuF87o8drMyB50OaHVQ0XEVSJT3dNuQHoMKNA=;
        b=lW9kyDhK1npiHPaQY5Y2pcBhOSRnfJmFEVvByNfacEXHSJTEOX4+hhxq8awgVWhOeZ
         uJONI/+uhEmmGFK3pXygxti4/7sk2J+YrjeDvpL57iVP23UbTkKo3FGducFXqp2jbRi/
         TxgblZOQ3/XwVBGFVH16Nqarg8YvygvSH+9kjWWCAeGd5hGtKSdsQD3tASVNuwkddc87
         nES2PHi87B1qGUyNh9W4Fmr+1FPIHiEfjqsT4sT/v1W52k+oTD46jHHqREMjISP3qioH
         z1TLYPQD3bKn8UcilMV6W3lxHCZISlPtMHSyCX+ZpQuNjE4nhQ/GA1jVheIUTNsMJqCc
         kNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783856022; x=1784460822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ImbRmyPuF87o8drMyB50OaHVQ0XEVSJT3dNuQHoMKNA=;
        b=CeQxi4GRskOFjhmwtm9wlggpSsK71lk52xC+Iv8VbXyw5ekLyUZX4B8THvYYJwlW9T
         olB+d+Wi4Dtx7jPP9sIXCmmw7X6tQPQ3NsPRnFHRM4BWbz25DtTPc1RAitTDuG7/BJs8
         81YU3gx78laBCrlQOMMrSjjvCbd9T6814w/ELw8rocwxeYPzA9lZsX16cAuNIOinimN0
         3/HvtsXV3GrXKxblE2XBDA9CTJi1IjslJhDH5wdkjycCnhv1DVPWAM9x2PQqHNNECqC0
         wbl1m18Qx8MU/sjq4g3fbeiUsEH028hdxjh4i9EO4N8QkbNk2K7OZ7NTAFSk3+K1QU11
         RpUA==
X-Gm-Message-State: AOJu0YyS795fFq/KjKIDGXG/gPB4PKXeLFWZqLsPoOEHzMkMd3dLH6CQ
	AtUjfiOEoJUCdY/SuzUpvDaCs2HlpaiO697Q5dyGfQScx8jSW35rIHtM
X-Gm-Gg: AfdE7cn6JiGHL2zJ/V20/aXOQhhOOpoph1VivaQWzR/PmURMpzJrzcPKXFUw8bPd/vA
	2B1slXW0xjtP1ZQRNaxa2ytasdUmXLiRYu+L6pLsnKgCBP5xTLmRgNHI+5PFyWKmjQlfa6W4BJg
	9LjP2zfEvhoMBVHm9z6VA1LNRWthfHc+lbIvKcDTEhnBtGDLWGWJhbjXv+VRLYsik7EtShCpKGG
	0gxrHrAzbAPvqlfuK0YgbSDGar2RYVFNt2jToN+ZpHty6OIf4SyGb6F7+TkZmVgOtq/kQ1z6gam
	w7KZaTgN8Q8d1ba03LEBdnEhabfZKRzPt+ZsEQ+pHZ+RP9Uc9Ym45dKt+oFFx7K/xZSYHDMQyfr
	2vs60yBB00GoPtcYd1pCPavGvPduVgBJN4p2uS92XshRT8zhaYlFTS06XVRO1KI6Mp1aysptWV6
	Hm2Hiwd8o=
X-Received: by 2002:a05:600c:6286:b0:493:f9ca:fa with SMTP id 5b1f17b1804b1-493f9ca0655mr49509855e9.3.1783856022173;
        Sun, 12 Jul 2026 04:33:42 -0700 (PDT)
Received: from fedora ([169.224.36.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2a38b19sm147253505e9.0.2026.07.12.04.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 04:33:41 -0700 (PDT)
From: toveno <teamakeads@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	teamakeads@gmail.com
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH] staging: sm750fb: fix CamelCase naming checks
Date: Sun, 12 Jul 2026 14:33:15 +0300
Message-ID: <20260712113315.38615-1-teamakeads@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch.pl issues regarding CamelCase naming conventions by
converting internal driver variables to standard lowercase snake_case.
- Rename pvReg to pv_reg
- Rename setAllEngOff to set_all_eng_off

Signed-off-by: toveno <teamakeads@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    |  6 +++---
 drivers/staging/sm750fb/sm750.h    |  4 ++--
 drivers/staging/sm750fb/sm750_hw.c | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c..716a8935f58d 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -743,7 +743,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pvReg +
+	crtc->cursor.mmio = sm750_dev->pv_reg +
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
+	iounmap(sm750_dev->pv_reg);
 	iounmap(sm750_dev->vmem);
 	pci_release_region(pdev, 1);
 	kfree(g_settings);
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d2c522e67f26..e8885133da2e 100644
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
+	void __iomem *pv_reg;
 	unsigned char __iomem *vmem;
 	/* locks*/
 	spinlock_t slock;
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 34a837fb4b64..95f797e5776a 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -23,18 +23,18 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 
 	/* now map mmio and vidmem */
-	sm750_dev->pvReg =
+	sm750_dev->pv_reg =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
-	if (!sm750_dev->pvReg) {
+	if (!sm750_dev->pv_reg) {
 		dev_err(&pdev->dev, "mmio failed\n");
 		ret = -EFAULT;
 		goto err_release_region;
 	}
 
-	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->pv_reg + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dp_port_base = sm750_dev->pv_reg + DE_PORT_ADDR_TYPE1;
 
-	mmio750 = sm750_dev->pvReg;
+	mmio750 = sm750_dev->pv_reg;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
 
 	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
@@ -58,7 +58,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	return 0;
 
 err_unmap_reg:
-	iounmap(sm750_dev->pvReg);
+	iounmap(sm750_dev->pv_reg);
 err_release_region:
 	pci_release_region(pdev, 1);
 	return ret;
-- 
2.55.0


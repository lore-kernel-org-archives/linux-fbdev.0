Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E62609EE
	for <linux-fbdev@vger.kernel.org>; Wed, 24 Jun 2026 04:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782276261; cv=none; b=rtNUUn+0j0bkejFkF7Hjbz4wBMyqggFFe0iLQzK7s61IDIJUVNjcgs2wek+p1RKkPZLVPGmi7OBkUidR5GJ+fi5TxEYsj2rqeTjpkUxnowJxc61PZEZVCFtns6CLh/0CTr5CtzwRuCIkEozAeqk6OcGkNROPAQ0gKMMMcKtuS/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782276261; c=relaxed/simple;
	bh=Ip1s9CHl8ZzsdAveDPfvFvSCDHHCgPFS/WQP8N+uSTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxqgtZk6qSRMSBx2FEbsIA3ns5WJRYIkrm4MSpXMTITIWJ5jeMzZSwqtVHTWSwaqOwzbYM5b95Dk5K/YbyrS/496q0OmEaN1W3t5gOjKo2QozbSoyWE3wkQ9nZLzOTqRgLEAvRWPz75z1KLSJAY7m3Z+FmyClWm57iRr3DgqYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl/hri2H; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl/hri2H"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37c867bd3e0so384998a91.0
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Jun 2026 21:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782276259; x=1782881059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHCLB8AQgq5vY37BJcIWdXKDYn7/wlkr75J7OWaF0kQ=;
        b=Kl/hri2HrPmuVCta9MiWUU0E4GCSZEjbRjNddPKZouhKhiKIzgNCjw4QMMCIsE4cI9
         8HppbfWXB2g/ogb6jk+zf2W5Eyoua+T4U8Xs+rtwumgMYfHA7/1zmtCGNgv+3j42Ow8l
         PkW44f7kZPV3jqeZ294n/cZqoSGVgXBUYT9mdPjQ/w0lvSvUPlLVdaFYI5dgJJX6eIZu
         Txbg+lTZ53ZSZLL21Lwb6/vEt08HEJkXs/E5b7kxiE3GulCdWmhUPYcPCANp4I3IqAaq
         QoLnUHhYGUKTq3GAAHcFFnlTbt+rihf6Xln6NyiJfqtkvawLTk9rX3qbrGC+K6K/nXOa
         Xanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782276259; x=1782881059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vHCLB8AQgq5vY37BJcIWdXKDYn7/wlkr75J7OWaF0kQ=;
        b=Yy1ZDIh/bvBUvTgwtYbj0ThjN1KvWcSplRh0lIfHtrR8cJ0oMngpnN/TXyUWP38Ym3
         MqiHl71r3m1A5MhjN1u4Cjc2/2R0ETWIgnZKg7oxiNP4wlK/ArzMeGw/sn8fkzW3P8Xc
         Uud4s3/S7aN7yFDKvEwRU/eYDPr11XZKAaPJXRF+UkTPCH+7iWhMXg8Y+/fY1CLBYAvk
         968/vTWkNySkbvgKcGGjrnpsdAWEs6dPTZVbz0AOhVuvgJZ7n4X4seR90ZUDLfJq5QB6
         bit35IPi76gKvEh+VlVzsSS60H592hDO0YUUKk/9azkYsve2KbDs7Wv03vjaV3pZ2V/r
         NTFA==
X-Gm-Message-State: AOJu0YwAmper/9rmhEV5jKjFMcaLj9iEvz0eLf6FuDAINjY5NrtlL6lK
	fr/H77RcIM8uP3YBo22GGSk35u8CfufxbQxP576i6JoRauz9lUHW7AXS
X-Gm-Gg: AfdE7clfGfjZFjX3+1wFcuYDr5XzKayczohiwXYk87hbe4FhR7pqjR5tpHZ73Le7GPs
	BjmYIREu2mZlj/Fgj3hD5/w4aEs9ANn7kzFY/mQR5APM/cFhF+Z1z9uA+VTNZnMfw72vvmivBu8
	FBvwDQezXjjlBRXcbXa6XK6E97h1znVwrpuGEhaqGboHImTfVQdkMBaC1TN5qU1e7+fco4mCrqb
	iGIJxuIFhJhROhSBhfJPTl4WE5u++uWiILFAvws0hRzJIR2WVy+omBLFTSnhs9gHJ4CDmHH7eWi
	wAi8zVco4Oa76kUsXS0AVqRMY8IZfpcfl2J7iTytdc66NyNff12TJYYhcAUFH3EzvPxttd8k3/U
	EkJjKMvE4E92B5/+4/0oSho4ClxosgHmNWMngGygVxXMfIvz+hWhaV6DGXokEfPlhNgPJ2oNH71
	jiq5snd9vTIa7z0jZ5qvBYloEtn1uWyQP6Xs0cgYCG9oVyYo8f5v6O1lnu/HesBCDa6yAikmZ1A
	EFgPH3QjNdtPRWwz+yQ9p+5sgsQKZf7T2IzcydBxtVIzhJFQnbmYZKmv9igR+hdiVZg
X-Received: by 2002:a17:90b:2fc4:b0:37d:c9b6:437d with SMTP id 98e67ed59e1d1-37de43b3febmr1911850a91.21.1782276259330;
        Tue, 23 Jun 2026 21:44:19 -0700 (PDT)
Received: from kapoor.mahindrauniversity.edu.in ([122.184.65.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3aa1b1csm1062671a91.5.2026.06.23.21.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 21:44:18 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] staging: sm750fb: rename CamelCase pvMem and pvReg
Date: Wed, 24 Jun 2026 10:14:11 +0530
Message-ID: <20260624044412.67464-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <MESSAGE-ID>
References: <MESSAGE-ID>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the remaining CamelCase structure members
to follow kernel coding style.

Rename:

* pvMem -> vram
* pvReg -> reg

Fix build errors by renaming the corresponding
structure members in sm750.h as well.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606240823.hWXfYyPf-lkp@intel.com/
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 22 +++++++++++-----------
 drivers/staging/sm750fb/sm750.h    |  4 ++--
 drivers/staging/sm750fb/sm750_hw.c | 16 ++++++++--------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 858eda551..efadb9c73 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -622,26 +622,26 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->vram;
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_secondary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->vram;
 		break;
 	case sm750_dual_normal:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->vram;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
 			/* not consider of padding stuffs for o_screen,need fix */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->vram + crtc->o_screen;
 		}
 		break;
 	case sm750_dual_swap:
@@ -649,7 +649,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->vram;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
@@ -657,7 +657,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			 * need fix
 			 */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->vram + crtc->o_screen;
 		}
 		break;
 	default:
@@ -755,13 +755,13 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pvReg +
+	crtc->cursor.mmio = sm750_dev->reg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	crtc->cursor.max_h = 64;
 	crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
-	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
+	crtc->cursor.vstart = sm750_dev->vram + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
 	if (!g_hwcursor)
@@ -1028,7 +1028,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 		sm750_dev->mtrr.vram = arch_phys_wc_add(sm750_dev->vidmem_start,
 							sm750_dev->vidmem_size);
 
-	memset_io(sm750_dev->pvMem, 0, sm750_dev->vidmem_size);
+	memset_io(sm750_dev->vram, 0, sm750_dev->vidmem_size);
 
 	pci_set_drvdata(pdev, sm750_dev);
 
@@ -1059,8 +1059,8 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->pvReg);
-	iounmap(sm750_dev->pvMem);
+	iounmap(sm750_dev->reg);
+	iounmap(sm750_dev->vram);
 	pci_release_region(pdev, 1);
 	kfree(g_settings);
 }
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 9da154f1a..dadf5874a 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -97,8 +97,8 @@ struct sm750_dev {
 	unsigned long vidreg_start;
 	__u32 vidmem_size;
 	__u32 vidreg_size;
-	void __iomem *pvReg;
-	unsigned char __iomem *pvMem;
+	void __iomem *reg;
+	unsigned char __iomem *vram;
 	/* locks*/
 	spinlock_t slock;
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 59fb3a207..1b768be20 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -42,18 +42,18 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 
 	/* now map mmio and vidmem */
-	sm750_dev->pvReg =
+	sm750_dev->reg =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
-	if (!sm750_dev->pvReg) {
+	if (!sm750_dev->reg) {
 		dev_err(&pdev->dev, "mmio failed\n");
 		ret = -EFAULT;
 		goto err_release_region;
 	}
 
-	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->reg + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dp_port_base = sm750_dev->reg + DE_PORT_ADDR_TYPE1;
 
-	mmio750 = sm750_dev->pvReg;
+	mmio750 = sm750_dev->reg;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
 
 	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
@@ -66,9 +66,9 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	sm750_dev->vidmem_size = ddk750_get_vm_size();
 
 	/* reserve the vidmem space of smi adaptor */
-	sm750_dev->pvMem =
+	sm750_dev->vram =
 		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
-	if (!sm750_dev->pvMem) {
+	if (!sm750_dev->vram) {
 		dev_err(&pdev->dev, "Map video memory failed\n");
 		ret = -EFAULT;
 		goto err_unmap_reg;
@@ -77,7 +77,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	return 0;
 
 err_unmap_reg:
-	iounmap(sm750_dev->pvReg);
+	iounmap(sm750_dev->reg);
 err_release_region:
 	pci_release_region(pdev, 1);
 	return ret;
-- 
2.53.0


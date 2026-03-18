Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2C3264F3
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855337; cv=none; b=Ln8eFAidB8q/AU9EMLkHUyuAVmgH4/9D9EzlaKXm5xGRJr0cgFdVvyBROwV8TxRaxhOCx7U+odMSTE3TPkOEYHR2qVBbvhkm90J7bE5Zkw8JRbYdLwPRK7nn9OGb3/RhDUFhHhaXQjfD4v4uxB8WPBAPcNi+QlZanldPxcjSe78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855337; c=relaxed/simple;
	bh=JZN/Sf7S8MZqsy5dV2hcfkkN1gQiAk5D6N7QGuLcopE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxSn0Op1Y3uE9mJq1UvqtUUL+z2q0FOBcdtmE4tuOyCGAfBHwtymL5j6wpkoxx3ZAqEPF+cwOVCdN38nSRiDzuPM6r2QJEP2aqHied+RWAk3b9S19DrT6NQiY5AYBvrXyeJz3eP89WQVIm+RfsPz+X1E6SC7KNM/9c4YyFtcBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQQvoHA+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQQvoHA+"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-356337f058aso152412a91.2
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 10:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773855334; x=1774460134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVrzVgKBVzV1WI1Cg1lfykJIIDMEjWWUc4jXfvsbWKY=;
        b=mQQvoHA+S6xMtX4aiNdpJvJF6EaFGUxKcpsxtuZ2kNiBCaxnrI3qcNiYaPe2dbDt20
         t/Q6Kozkhx6fnpmHgKGvf6FA0FDUP2bJURRO39HYu0WkEvmHr5/xq9MrMoIgv/OW6p7h
         rV8gDs+kIX8/S5Xj9VvptWcl9CyAHhl5rULfQRW9Tc4bphqxEwqeZBHDSg8zP7wO3Nac
         gP4mR7QyMrNjr4ovfIiuG2ChBnfk5RkIBJRq0VF+apJlQuLsfBDYjAGbJdhgHiG4rEvJ
         UCl2h6sh2JljksY3dbUgukw8aj3cZA38mkcX3H8ntmky5bNYsuMfP7BABysjJqIR6dee
         w2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773855334; x=1774460134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VVrzVgKBVzV1WI1Cg1lfykJIIDMEjWWUc4jXfvsbWKY=;
        b=ZqL8z1//2WRF4q5aF0+xua7ZX8sLS0LZ56WFZ6a/khAm6XSdHsz91CEb04hA+9d3J0
         wfL2PO8NcM8cDLcI47mbAFs5IbOKLrL0PsCwAVJ6TEPalG1T8TBC0Edy9iyheW3NRG++
         K6idup8bHlkRuMejRwPG4WaTRk/QB/sWsQMVQF4qLiXQgAUO/D7L+LoS0GAVkxZOkbrx
         DCPtDWuz5QD9HZ9KJDnbIjohQIf220I8589uPUwDXKbY2O6DvyMrnAMY76Du4svFE9+s
         IjTSgYHh0kPmqFQbJjRbm6AVjj4gi/APUc3jaH5yZWwj2NwRE4QU780odZBbTV5bdESI
         nOzg==
X-Gm-Message-State: AOJu0Yx5GX9+56uy3WJ4m97OB9N/pRQiNBdOn1XaMCQ/uSjRrEaTvtPx
	qzbt9zG2tmu/lyzAHHcN6afWtmFvZ3wGOVSvkAUvanx850xppUrU/LmZ
X-Gm-Gg: ATEYQzwKQ07SKh6M7PN/mMjPfxkx47zAY71t9kTGSMxVOl+B8KlfTxHBS7EnN9coeRl
	8QCxXdyUiqWENcPdwtW/czxEY1QOCzgYrm+T+bXNy2c9fMwzAbwmpAvXTJmyZE4JRxzpcAXvVHJ
	zpPr+YtddqPN6H5MK2nLh+nLlMu4y6DLdt7f6CYo+MRP80Y7kO0gvlDZDWO+a1RjTCKlktUHLMl
	UuvejTRsCoRl5uX7YE7R4mtsxkAn28InpU+fY82FLYWxsudG4SjSE/uGGTUgHWm56pL4pRhd4O4
	1PtKNIDgen55NZ8xg38MD3hMUoumYA/MvfyeMkKk/Faxbx997jjH+mQDjOdn6VVD9JTytQuQ9Jq
	JBtI/kaX4tGM65pgV9tfCclht2TW9I5OQ2bA5Olx8EF5PwmQcaHwT3s2LTc6o4vIOuW4NYw+R30
	T2JsRvqmHBR3XB10njoo1K9z54j2XjmMkgNDA=
X-Received: by 2002:a17:90b:1dc6:b0:34a:b8e0:dd64 with SMTP id 98e67ed59e1d1-35bb9e41137mr3490835a91.1.1773855333955;
        Wed, 18 Mar 2026 10:35:33 -0700 (PDT)
Received: from fedora ([2409:40e5:1052:9a56:3b6f:933a:89fd:e530])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc5ff704bsm247103a91.2.2026.03.18.10.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 10:35:33 -0700 (PDT)
From: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
To: gregkh@linuxfoundation.org,
	sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Subject: [PATCH v2 3/3] staging: sm750fb: Rename struct sm750_dev members to snake_case
Date: Wed, 18 Mar 2026 23:04:40 +0530
Message-ID: <20260318173440.9457-4-chakrabortyshubham66@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318173440.9457-1-chakrabortyshubham66@gmail.com>
References: <20260318173440.9457-1-chakrabortyshubham66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename CamelCase members pvReg and pvMem to follow the Linux kernel
coding style.

Signed-off-by: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 22 +++++++++++-----------
 drivers/staging/sm750fb/sm750.h    |  4 ++--
 drivers/staging/sm750fb/sm750_hw.c | 20 ++++++++++----------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index c30ffab8a5f3..1c60ba056719 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -624,27 +624,27 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->pv_mem;
 		pr_info("use simul primary mode\n");
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_secondary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->pv_mem;
 		break;
 	case sm750_dual_normal:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->pv_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
 			/* not consider of padding stuffs for o_screen,need fix */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->pv_mem + crtc->o_screen;
 		}
 		break;
 	case sm750_dual_swap:
@@ -652,7 +652,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->pv_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
@@ -660,7 +660,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			 * need fix
 			 */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->pv_mem + crtc->o_screen;
 		}
 		break;
 	default:
@@ -764,14 +764,14 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pvReg +
+	crtc->cursor.mmio = sm750_dev->pv_reg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
 	crtc->cursor.max_h = 64;
 	crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
-	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
+	crtc->cursor.vstart = sm750_dev->pv_mem + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
 	if (!g_hwcursor)
@@ -1090,7 +1090,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 		sm750_dev->mtrr.vram = arch_phys_wc_add(sm750_dev->vidmem_start,
 							sm750_dev->vidmem_size);
 
-	memset_io(sm750_dev->pvMem, 0, sm750_dev->vidmem_size);
+	memset_io(sm750_dev->pv_mem, 0, sm750_dev->vidmem_size);
 
 	pci_set_drvdata(pdev, sm750_dev);
 
@@ -1121,8 +1121,8 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->pvReg);
-	iounmap(sm750_dev->pvMem);
+	iounmap(sm750_dev->pv_reg);
+	iounmap(sm750_dev->pv_mem);
 	kfree(g_settings);
 }
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index b683a82af349..3f6570fc8f08 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -97,8 +97,8 @@ struct sm750_dev {
 	unsigned long vidreg_start;
 	__u32 vidmem_size;
 	__u32 vidreg_size;
-	void __iomem *pvReg;
-	unsigned char __iomem *pvMem;
+	void __iomem *pv_reg;
+	unsigned char __iomem *pv_mem;
 	/* locks*/
 	spinlock_t slock;
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 0e594734a8b9..32b3813d0d8b 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -49,19 +49,19 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 
 	/* now map mmio and vidmem */
-	sm750_dev->pvReg =
+	sm750_dev->pv_reg =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
-	if (!sm750_dev->pvReg) {
+	if (!sm750_dev->pv_reg) {
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
+	pr_info("mmio virtual addr = %p\n", sm750_dev->pv_reg);
 
-	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->pv_reg + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dp_port_base = sm750_dev->pv_reg + DE_PORT_ADDR_TYPE1;
 
-	mmio750 = sm750_dev->pvReg;
+	mmio750 = sm750_dev->pv_reg;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
 
 	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
@@ -76,15 +76,15 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 
 	/* reserve the vidmem space of smi adaptor */
-	sm750_dev->pvMem =
+	sm750_dev->pv_mem =
 		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
-	if (!sm750_dev->pvMem) {
-		iounmap(sm750_dev->pvReg);
+	if (!sm750_dev->pv_mem) {
+		iounmap(sm750_dev->pv_reg);
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("video memory vaddr = %p\n", sm750_dev->pvMem);
+	pr_info("video memory vaddr = %p\n", sm750_dev->pv_mem);
 exit:
 	return ret;
 }
-- 
2.53.0


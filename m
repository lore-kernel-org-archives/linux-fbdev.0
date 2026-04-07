Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE5E3A257B
	for <linux-fbdev@vger.kernel.org>; Tue,  7 Apr 2026 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548147; cv=none; b=NHlFTMieyaLC9XiEoc+FcSuySWSZbUCq5xmUqkIG/2B84DIaI+m9lEyDNUCEOmmuLCgIIookJrC8wrvgAfV5LP3iDDl3H+f2nJk2X3mgrLKvRK4KAGTfTkufUOkTyKb1EoIooRsBw7XV9kwmeM3tyDlAT4HVIjmcfgW5j5HBTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548147; c=relaxed/simple;
	bh=lTgQ6P82H63rquzLxY2/WnhMS6d1SxwK0O7GAUYbnnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOFzx7utIjlrgQ/M3iezQK1ZVtwteklS6P3Bx/ntTK9iJJz3nuTGgARMFLSgcHN+EzwoR4nOEqbW9BgG4nQyHk9e3XnKTmTVkOyrk31GU7af4gmq+G9XSBlsAZ8JXFUFYpEiOuq1TF3UvHMzuEJ++0rQm/aLZfAKpEbcdMmCfj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohMTb4UN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohMTb4UN"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82cf636dac8so2152957b3a.3
        for <linux-fbdev@vger.kernel.org>; Tue, 07 Apr 2026 00:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775548145; x=1776152945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me0CKHf/sm8CRWgP3GPZt1y+gKBd/mvXJslLZ2AW7O0=;
        b=ohMTb4UNBCNaHMnyxY/P0LASzP5QJJgNAIRNfIUnBli6uRA8F9jvtuYeYvxk73hVTQ
         Bu9iLYU7Y9N5rICwjbzoyQmaFw5lGeYi5Dz/ltIkiX5G1YHBxzPPQQWq/QQctwBiPMC9
         4ex3rXI7MkNeLWvhtgr9fRdBYJrD8L2bL2uuw0rfpp204WOtZarFOPEEUReHVC0O5DKA
         wMu3adzdHHJvdtfEhcEaRMpdB3JdQSWytCBFkWE3Tye8GFUFdza4WWZhz4QcApu1E4Em
         yLexqxbNz486YRLv1zJO+AYGGxdkWxu2gUkO+vQ2JTIzHFFVUWL2mPlv76xGX6RjgTPl
         5gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775548145; x=1776152945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=me0CKHf/sm8CRWgP3GPZt1y+gKBd/mvXJslLZ2AW7O0=;
        b=eCOiPaT1543Wv4mJUGggu2K3b7kMiEgaDHhzYDg8srFBL1u5Wqo86ud2sAcTGj/TTK
         NxQWeAr/rMeXm07LXWRYVVHHZahPbTB0azGswwAajRH3gDRPfyao4remOMk1oFA3REBk
         i/1V6X9Yqx3IHXI2pPXKMaCZe9WS0vh66I7JKWark5hp1Hx6VvfTE85G/uW/ImBs5L9F
         3WdFItVR0tYBqryiP1dF+8Wy0qrwDOiY1xLIsfIHh9YsDN5K4KhgO1bv+EpK1mBgsqYo
         nAENzhDf/6UvVeZlncPwWz3SFU+DVVjl68dlNKew6/bDO7ho/EU0RBCpgYBK6kk2uDrj
         Qs3w==
X-Forwarded-Encrypted: i=1; AJvYcCU5d1t4lfWtUTtP5UbpyiD0Y8iMJMEuj+ODONo0TGxEUK2junYHjVAVd7uNdr+S3YxSTFhynm/xq2d5pA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuOUo+OkVYLYc5E7Kebk5kQ6iSrC8Ap3PithPi5OniIt8W6vUE
	dbz0jOJWh90kVHMD2DrPqtKcm+ZEz9mCHw6Cm/ryRwRNpm6yLduiNT+x
X-Gm-Gg: AeBDieufvVFai3VvX5/uPAGHAntAjS1Fph3bc7sRSEomlwd0zD2tt5f27aoPxLLXypT
	76j6XFQlc+cnUS3xABo9RYSzDbpDLrjlW9u551mGbR8MMmoX5kiNJ4I15cTa/3kPkdiyTm7H+MV
	CDCU3NHvP4Q+LXv4SJb4v0QSyBvThDNAyXpoz11Gry++wwzRrCBAIN2/ePefK3acDgB8/keuiTR
	FbDVY+7oTdPrOLP4KpJwJZF52l4bwcW1GQwTnswYtZucSdmsiKi1dX+MD5jZtSct5cUN+F2nGaY
	gQox/HUbws+xzsWqWV/i6dbRYM3tq1hFeSpZZ9ncAGXsiT1JktYF55Oz2sJ0Bj66HLmgE7gwnvJ
	bgJJZdoKF7raGPKTCgYhc/2y2j7HucYFVz6ZZru3tzdPYZoa8msvcXrLXjEAeov0ef9S8tABaDJ
	xHDjsRR/tbq0B5wfEiljcdraOmebOIyM6GOi+MNZ2CMtHrhQ==
X-Received: by 2002:a05:6a00:800f:b0:82c:e60c:f36d with SMTP id d2e1a72fcca58-82d0dbf1a4emr14179901b3a.48.1775548145206;
        Tue, 07 Apr 2026 00:49:05 -0700 (PDT)
Received: from fedora ([2409:40e5:1126:477b:379d:30fd:d3e2:3b3c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9ba21sm22093716b3a.51.2026.04.07.00.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 00:49:03 -0700 (PDT)
From: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Subject: [PATCH v3 3/3] staging: sm750fb: Rename sm750_dev members to snake_case
Date: Tue,  7 Apr 2026 13:18:05 +0530
Message-ID: <20260407074805.14505-4-chakrabortyshubham66@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407074805.14505-1-chakrabortyshubham66@gmail.com>
References: <20260407074805.14505-1-chakrabortyshubham66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the sm750_dev structure members pvReg and pvMem to snake_case to
follow the kernel coding style.

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


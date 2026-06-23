Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FC63C141F
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Jun 2026 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252487; cv=none; b=dC5fiWXFp568w+r/szkkQY/OJ/cZRideGhfbOaF2a7V02uB3j0N3RIcWbjDQ27ULYPY8YqcQYTcqNFgC77kBZTs+ylxttT7rG9Eg4JLcxHtSr7eBHd3/wsE8HVGC3gWuIuAL97AMIy/cjfkPGSckx2REXs/oBe/y1exbxQD2Aco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252487; c=relaxed/simple;
	bh=lNXn1c7ul1Qw9cqjrQBp7PVBWt6LnOI3GgUPNKi5+4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WQRbvd5z3emJ5IgbyivuIAFLNReCh0hiMmua3Zk+/pDqhsoBUMS6uWa5RM7o7XJ0Jlx05E9HO57zjWmmusVse0oyMFpnQd+xk1OblXoUJ15FYEWPZL6jUjIE3EDKIdKcDlTggoi012RH+2e6mBttjo6r1/+/qwaQ4nwPtc1714M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbMMEp6J; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbMMEp6J"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-139b5e604b9so455129c88.0
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Jun 2026 15:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782252484; x=1782857284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YOL8VtWrnRwJt4crP4/M+gcAvtEL34NsfOvVl0X3Szg=;
        b=qbMMEp6JGgi8zhFRZHiwNfIXmu8nyf8TgJGzS9ChPBI/1jsG9Egb+3nEHc2+afACKr
         oAeYqs+E/8Ij78QRgHDU7wjavw1sJTJ1h1gO3HDHpFT2F43wGO97scmyVt/4S+Ob4KxA
         c+WkAyyhNpko3AfWux5crTbFsNKUH0BoizQ7OH5+k8WISgCgDy9d/fCzpHeJaVW82jqi
         jJ2xD/D3jlCPdJ0vbRUNgyYfk5dr7W18a1IqGaTOMAmsTQlbUJJ6SC943KQvoDXLG91u
         2o/JaH6YCiR0JqD5FlgXyQ5HGA/GWs+kCJmfU5M8frgPbUOk1KL/xX6/HghGPOxGs3BT
         AeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782252484; x=1782857284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOL8VtWrnRwJt4crP4/M+gcAvtEL34NsfOvVl0X3Szg=;
        b=HCeOhdC9Nl99YwZSQ9+TZqs15nYHejH7JaZe/GKSPdagYkIYZHm5SnyOjDLs+3D31A
         igFIRC/icpnoKWftP6XkOD67U6ZVRNAp0boJtnnpZjXupZhw4KBjkZJ+VSZkWGh9H0yX
         wk18/zMgGid058yW2U4sRciwpKp3RVtEpT8v1caQ2tjbSy34wLupkmenmUD24Na8Nx46
         pIOUufdci5Bp3mhbgORmTwmJbA67jbo8SFths2PZwMf2X7OQDoA0bt1LGtOesRdmQcPs
         Hl1gwvq8qtgkRRO3y5/eMI9KRKKvj9fWDQdm7Y3Di5jJrIqp0skBNB9hMvJ02o2W7Dnf
         r13w==
X-Gm-Message-State: AOJu0YxibM3rN/md2GwIVpuRymmUIlGOEZor8Q2xNTeucCIHVIdVj1c8
	rZDwlz9oA4pV6gke+RE1ZeJvtTkzpTXEg+0sJqpJ4Pkn/g3p2DCC/6Pr
X-Gm-Gg: AfdE7cmfL0gtQQluJcy4Ruda5mTF2YcPHE/h/PIWu53EwBuICImiKyF37ow6kWI8+4K
	TiSHtzhXast9rG6DxD/55eDs+dFhGFC5hUyNo8orcbToqvv9uZ8Vvbo9FHBAsr+B+QI8kMVZ2xC
	cWfBRqYLjISGS4ehZ9C+zrz3B2NbJ3g7styuZHGL39ZH0WScTrd355LgxYuLbujLq30/vE9agS6
	hDoU3cyoINk6eeAKcavs9mtAgSr+B6mjqCq0x1z+UxczMdcPXVzRSutnNnDDgYjLTVc3JuavICy
	lLr71BV+wiCw6mKnrFlV0Q3VpOdPofESJIalvY4ErM4JlTAEg0EtCFkVSOf3KXOOy8FkPRztUgb
	/ct46qVGaHQNRbFBTSMKXmHtqS/8hP8eaIePfhu1lJjKSzLPN8KfeYwvg2XCGriiwSRU2s4x3rE
	PcP7BEtQI9
X-Received: by 2002:a05:7022:2606:b0:139:9e79:43fa with SMTP id a92af1059eb24-139c5cfe482mr3602277c88.9.1782252484284;
        Tue, 23 Jun 2026 15:08:04 -0700 (PDT)
Received: from adr.. ([103.216.221.115])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139c2f622d1sm8699410c88.7.2026.06.23.15.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 15:08:03 -0700 (PDT)
From: =?UTF-8?q?Andr=C3=A9=20Moreira?= <andrem.33333@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Moreira?= <andrem.33333@gmail.com>
Subject: [PATCH] staging: sm750fb: rename variables to avoid CamelCase
Date: Tue, 23 Jun 2026 19:06:14 -0300
Message-ID: <20260623220614.29682-1-andrem.33333@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rename 'pvReg' to 'pv_reg' and 'setAllEngOff' to 'set_all_eng_off'
throughout the driver to comply with the Linux kernel coding style.

Signed-off-by: André Moreira <andrem.33333@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    |  6 +++---
 drivers/staging/sm750fb/sm750.h    |  4 ++--
 drivers/staging/sm750fb/sm750_hw.c | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c4..716a8935f58d1 100644
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
index d2c522e67f26a..e8885133da2e1 100644
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
index 34a837fb4b649..95f797e5776a2 100644
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
2.43.0


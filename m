Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD433B3C18
	for <linux-fbdev@vger.kernel.org>; Sun, 24 May 2026 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779664550; cv=none; b=udp6NYRhbnEKjoZgfAwRYfGQE+zJM3SM99BhP0fScyClTMgd+jT4RFdIwVK4Ii0s/1kDE03lVOA/PDRUMnzbzB/Kqr/Yn3fv8npjarmPWIJaB1Upe6jxi3R1wJzKkc6bVmdkJMuZifUE/S18uNXVYXe8mWdFODaSGv94hx4MsHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779664550; c=relaxed/simple;
	bh=R8HH9LkEOmCtSPM3nqsmnqfr8yvO/w0/cKwJO4nfKBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYXb1FkdVwG1xyukrgNiBLlkL241UlQSYxke1wX97e5cIw88KjPTbocNHGLya7MzeYgyvZsiPPShsNi9+SnT3u3pVxfSoPd32oEhi0OAbYcb3mJeSn7+B+WmdjxMh3RW4YlNelkASmsO2e63wKxf92/LkBzYdQbwn5yElzqdjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVcvAazv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVcvAazv"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49050bfe053so16240075e9.3
        for <linux-fbdev@vger.kernel.org>; Sun, 24 May 2026 16:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779664547; x=1780269347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOw794GgxaqZfd5jkfXrvTqVTMmQaQeV6xdMiXoheSg=;
        b=YVcvAazvTr0mw7MZU9B/5wrv87lN34sTPTTanIS7dVPeS/EN3IC6+cdv6Ub7HIoJwd
         35oBJrZEJOsq35PQsGyiZP/nEw5qqdfUFMh5ROjcF82EhJeSpQaoaQGJ62DmuciBv0Tv
         8QF6T/9x+9nv4AN4CGWnaE2We/N1KXjWw32dcTdpJiVyyavSVUyzRvt17Y647e/+BKdq
         G2SKqiUFguG/mV4azARw4/FhUS1tqIxYfdLxQxvufm+e+14G1ySWPr+iACek3AycKavg
         IqjFmDSEdJOKdLIDQ+NGv6Lntzb9bKhgv14AEXXJZ+Qo/1EmjwP+YUO0xY2LU6BuV/Jl
         iHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779664547; x=1780269347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QOw794GgxaqZfd5jkfXrvTqVTMmQaQeV6xdMiXoheSg=;
        b=f3DqUtqN+9cK63PPdACj0xlPXTcY1tAwqNaTvDDowY4f0e20mP2+CS/IS/Kt8T76Yy
         0lkMa7iYVaCN7CGiSMlUECz2o88ZXK+puvlr4tIoLG4MQOVtJc/RvVmU1capbaoeohEw
         Jnq0WK3yJDTNpx9ugfnlORaNmYQGFKhkU329oGG7Trk4wfG3fUcz6X8yyET2whEKKsh6
         zqni4Uhx2Ra1ME9EySAOhSAjdLdQEA+nGhnf+SK3Knxd1501ZPDG1KEYbVcrblFbg0r9
         uWriqayn3Yl31m7iwFlJj+YHBaHaZU5z7ZWhOgoC3kWxjHCylqEBz5o15f/NbfHTw0Si
         yzzA==
X-Gm-Message-State: AOJu0YxgzL4hQjpQOvetBebWh1h/dX4nBU+ApPsvDeBXB7dt0bjpIRGb
	UfEY+4Z4+76IgnMEasVUWv7jEe4lhJOLxDDo3hmVQIx3KM6YW1LP4+sX
X-Gm-Gg: Acq92OHkOaoY4oQe3J/ENGMcStqQ0Zjw4Uyw/EklBkx7VzSORaOM1T+LgJ5MekivhFy
	2cjTw0LYrgz+d8f0bRNDnvWPvDDt6ea/29tppNc39vaCZ3gobrsLSeAHlI93VgiGBxA2Z+1QFU7
	UZZJwAt0xKMKdCmBTcf5PBa4AL/2J3KjAp2qaZ+UJ5+XKyCXq3nw/+PuScg+pDbocT+tx8OFUCm
	mvBQ4kmUyYMuKxSuIk8N9vhCOv2pCGCosY3rF1pKHIWoMiMTbxGSwGBggYF/1jkwsrdeuTLVYEu
	BiZqN+DE7BxHZ7vOxjU/86IFJqHg0nRu4D7tg1ZOvfouQphsdOccaE8swEdYSthONN74fO/Q0cI
	enx9w0DrR68BxqPuGJQMoGix43DJJ55mg+wOM+sEW8DAF0q59RAAdwSW45aYyzDH1Rg6ja1n5Cm
	s7G8tTtxc52hXcDURAZLNZNiHSiCIy6mIYiIpxuWRCNMTZnWM+tIsIPcE/gZI=
X-Received: by 2002:a05:600c:4ecc:b0:48a:56de:d62a with SMTP id 5b1f17b1804b1-490424b3c7fmr181385095e9.11.1779664546865;
        Sun, 24 May 2026 16:15:46 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49041787932sm95960575e9.1.2026.05.24.16.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 16:15:46 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v2 2/2] staging: sm750fb: rename pvReg to pv_reg
Date: Mon, 25 May 2026 02:15:38 +0300
Message-ID: <fae018f80f61acea030d9893f3085998a78e4edf.1779661132.git.michail.tatas@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779661132.git.michail.tatas@gmail.com>
References: <cover.1779661132.git.michail.tatas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable pvReg to pv_reg as per
the Linux coding standards

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    |  4 ++--
 drivers/staging/sm750fb/sm750.h    |  2 +-
 drivers/staging/sm750fb/sm750_hw.c | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 00c293430a7d..716a8935f58d 100644
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
@@ -1047,7 +1047,7 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->pvReg);
+	iounmap(sm750_dev->pv_reg);
 	iounmap(sm750_dev->vmem);
 	pci_release_region(pdev, 1);
 	kfree(g_settings);
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 589ae51444f8..e8885133da2e 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
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
2.43.0


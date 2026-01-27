Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E61346766
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Jan 2026 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515918; cv=none; b=hnX0sB/qFmJ3paY6lFe8Wgaz4fvHtzu10luzd0s4oYOcKcVqhjl+b56LTGgzEd7vqM4tDAQMWJj7BHbl8qwHFEeyEBBLVC0VoxAmPWUhFM9qeutvot5zKGHtHQnWQ2lwWa6Xgc8NH+CvpKNMarlkyEeGH91fhDLhxezuSvrz6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515918; c=relaxed/simple;
	bh=b9v22AUSCfTaKIsQ4VFtZPDmF2c1At2qTNXouGoPoho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CwDdyqAfp6zyWIhdj7sExull6Q9+AFWVoGRR98qJbNlZmU2QNT1I3Vi4omPE645d8+Y2VVVtxlWs5D2kaeovC/wR6vqG2ygC0qpNanoICtInqlXVymishiRQxQUJ9Cms4p3ExVlSrxxylrauIHR75OK5H+IXLj6RYRBxX8GHFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsdUhP8k; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsdUhP8k"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4359a302794so3490797f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Jan 2026 04:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769515915; x=1770120715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1wsJb+rtQg6iY1Y2LWY03K9kG/QiXgPzzCpfegIvLgs=;
        b=LsdUhP8kMfPH7b/lAugBp+sQyGufCqkIR52HQCyZdJOfQNdkKNKLtfmjIfZT8/2Smp
         z8TVgf+aYYOQqxNvS+uha90zEA+NU/jhG2tWma1pN2xVg5AfYwRrC3mpqxjptsw81D/z
         m9RbDazdtzeLt45yofy9uywV78J6h30tWLaOlAmudqx8xdJtHyIW7H2JeEOT/fMRAM4H
         C6umRq46+kQ2cXjzZG+cBIpNaNutT0OKBvEqzxITEmwi82dG9Qq5cd19Tyqccg7ByRLh
         WDj7ARLJF1pMCnAAjKagNGBVJ+OtmWiSlYTAl4p3HbMdXG9SyFyjFLrTjNoP6P2/dRNs
         OHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769515915; x=1770120715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wsJb+rtQg6iY1Y2LWY03K9kG/QiXgPzzCpfegIvLgs=;
        b=MP2LwoOIiJNrwXJqPc1FvBSllFTmfFE3igYoLvheaWZYteuJfgjVWc4SvYRF0tz0Lm
         IcluGN1pZS6FGXyxOYBrYP96E3tlcOryT5bMxiuk37o44nx7+OrCFofbjtk6j/esY/Gy
         /1rp97mi4lscI+xSssPJNj0c5N7C6yilBR8etmXHRVoqo/PrL4xM/kt0E9ta77hNFsXC
         t29vU7h4YwWr+de7yi5gsEQbS+HQkYwKQjSF+pHxwrOXK9Bd5Iji10uD4O71L6wKc2SD
         NlXrIxhcQzRCG2PIn9R9Ps6CwXeW27OyavgqtPVKr0cDLeeqnmN9UBsomfq27Y6ruJui
         2PEg==
X-Gm-Message-State: AOJu0Yy3ht22KT/BNU1ZqQOmQDkeJG0qSeX/m9fHEhbLGOp/646D5mIn
	gxXiLcfOsnl/RG40A1H7FbsBZZBE0FeeLDb4lWyDbSAX1hybX/ysO55L
X-Gm-Gg: AZuq6aJvcZaPJWvykmwQgp9K8+FX3rzZFbPBNf+ZcszqrTRwoV1eW8jGCp8YvI9AjsS
	mW0tlxCcMWyaIGvgLPrDacHqr7OPN0zoaZNikGNcvFHVxTX+oc0wdR//MUTBmh5llYV/d3DzxI0
	7hA5qfwOTE0TEkD5UEYqUgl0X4y8+6v/NHSZoGTEzn6jH3e0Ax45cGsvqQaMFX5Xdx5ir9CyEl+
	z4LLOBjeCzGkQiKXaqJg/h2ztVycQDj8+jd6czwXSKV+RWVNF6B8UryEAknLAkeRHTFz1zjLZOg
	WxY4qOkrBQY4xNIcmxM6gYgnqiaXGGlajIgADZUd8Nmw3CPnO6NASEhAeUvhVSj7yG+SAWoBsXu
	x5B1yWhZH87RL/AIiC4A+gaoSUvpGLVTz5I1W+nR7xyJ184Q/yHFCzrtyFK2hNWAxu4DopLn4p9
	cQF4HeF2j7ulrdseAQZ8o=
X-Received: by 2002:a05:6000:2088:b0:432:4c01:db00 with SMTP id ffacd0b85a97d-435dd06f676mr2285348f8f.27.1769515915207;
        Tue, 27 Jan 2026 04:11:55 -0800 (PST)
Received: from Madhu.broadband ([83.106.123.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02dd4sm37407236f8f.5.2026.01.27.04.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 04:11:54 -0800 (PST)
From: Madhumitha Sundar <madhuananda18@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Madhumitha Sundar <madhuananda18@gmail.com>
Subject: [PATCH] staging: sm750fb: rename initParm to init_parm
Date: Tue, 27 Jan 2026 12:11:48 +0000
Message-ID: <20260127121148.36632-1-madhuananda18@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux kernel coding style prefers snake_case over CamelCase for
variable names.

Rename the 'initParm' member to 'init_parm' to comply with this
standard.

Signed-off-by: Madhumitha Sundar <madhuananda18@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 12 ++++++------
 drivers/staging/sm750fb/sm750.h    |  2 +-
 drivers/staging/sm750fb/sm750_hw.c |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fecd7457e..6f15131ee 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -918,12 +918,12 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 
 	swap = 0;
 
-	sm750_dev->initParm.chip_clk = 0;
-	sm750_dev->initParm.mem_clk = 0;
-	sm750_dev->initParm.master_clk = 0;
-	sm750_dev->initParm.powerMode = 0;
-	sm750_dev->initParm.setAllEngOff = 0;
-	sm750_dev->initParm.resetMemory = 1;
+	sm750_dev->init_parm.chip_clk = 0;
+	sm750_dev->init_parm.mem_clk = 0;
+	sm750_dev->init_parm.master_clk = 0;
+	sm750_dev->init_parm.powerMode = 0;
+	sm750_dev->init_parm.setAllEngOff = 0;
+	sm750_dev->init_parm.resetMemory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
 	g_hwcursor = 3;
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index fcb7d586e..67b9bfa23 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -102,7 +102,7 @@ struct sm750_dev {
 	/* locks*/
 	spinlock_t slock;
 
-	struct init_status initParm;
+	struct init_status init_parm;
 	enum sm750_pnltype pnltype;
 	enum sm750_dataflow dataflow;
 	int nocrt;
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index ce46f240c..a29faee91 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -93,7 +93,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 {
 	struct init_status *parm;
 
-	parm = &sm750_dev->initParm;
+	parm = &sm750_dev->init_parm;
 	if (parm->chip_clk == 0)
 		parm->chip_clk = (sm750_get_chip_type() == SM750LE) ?
 					       DEFAULT_SM750LE_CHIP_CLOCK :
@@ -104,7 +104,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	if (parm->master_clk == 0)
 		parm->master_clk = parm->chip_clk / 3;
 
-	ddk750_init_hw((struct initchip_param *)&sm750_dev->initParm);
+	ddk750_init_hw((struct initchip_param *)&sm750_dev->init_parm);
 	/* for sm718, open pci burst */
 	if (sm750_dev->devid == 0x718) {
 		poke32(SYSTEM_CTRL,
-- 
2.43.0


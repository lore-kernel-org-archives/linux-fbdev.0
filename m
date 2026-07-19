Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C002F8E82
	for <linux-fbdev@vger.kernel.org>; Sun, 19 Jul 2026 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784491183; cv=none; b=drueMVVVjO7ecpoMnjToDutNv9f+aNAkB3zzFWjWTMPC2KvdwKapLRFuzK3iQ9E4Bp1K/hGfauHqd+RvbSQdukJnhTRijYalpLLJDyQ5/H+l96Bo/arSawaC8PiipuUd1/QLtwT5wI4Sre/1HdhG38HNCtyNs+i4Bi9GWaVrnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784491183; c=relaxed/simple;
	bh=EEPlKfCoC30099HNBnVHrIieVhx+FCQ0TXswDsBvPAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZghQbAQrweQAXT753TaEyLyxfBdAz64wmlIVLOsebOdk2fA72ueMgcMWSIqNoRfFWGMn8OW6c/46JK79TRXuWz3LMICZTXEHTrxkuWLga0nW0hoDF3/KHQ4eNKHPrZY08eOLJ3MUdDBCdkNYWaDNjzC2fgrLG709JS4GK9LzDZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfGb/9MX; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfGb/9MX"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38101f85591so2497669a91.1
        for <linux-fbdev@vger.kernel.org>; Sun, 19 Jul 2026 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784491182; x=1785095982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=29R4VvP0t4h5JYvi0rHChbjYG421EIIS5l4SaCWoOTE=;
        b=RfGb/9MXbsEQOOH34yT3+tBDUYnme+b46iDU64Q5HZ2/ra9PiA97W05sExCaOjM5vH
         4TiOSkL85iRms0N9ERQ6ABpQtG9skwrW9iVGFcIckWFIkiwia8wPL24SgPGH87XNivM7
         E0BxlCct9gLH7ieUgvheauDYJ5RmRO9eCWb5m7k0p10BfGDOJh2jqo0zeQj3n2Ul7Bth
         K/evRMaIPP5dBTDjOzHSF6IDPmEtFLb34m3wpnQWPXozSSJE+p92MvLklDpQPpu2w3Gg
         boEBiWMcFK9D+1fLtP54bQp+IfBSAJalexajwwxP4ZDWOMpn4qKfexvuMeOaGFWlirM/
         n4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784491182; x=1785095982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=29R4VvP0t4h5JYvi0rHChbjYG421EIIS5l4SaCWoOTE=;
        b=Bacl4Jx3bUF1ykQESlEqlj14OgNX7YE3M2k8gHUdz8Kw3L/PV12SoMg/d2pdnCk66b
         vnUgN5CoYpCZIkhlMHe7bffDlRRQLlwq8LzwYnorYMLOTA+RCqTlfElKT4zoikO0Ihlh
         OvK5r4LiaeFxVlt23mLl2u8BIjpkdabmSyc6CjZ6xyVjSUSlJ+z4925eBRZNAX7gZbMu
         FIC6bKm/HhxUhfogY6h7K9KTg9y2dTbUjGKJ+hE+j4bDy0asOWVLGEynQGI0mISI0t/q
         pP/b5UBtkeqVEdZYe6UG4iRJ8iKcC4WdegYhFbB3tWsnjj3U+BwSapJzT5WWPvO8ZEpN
         QSrw==
X-Gm-Message-State: AOJu0YycOszHgU10sVwUw2CXoFFwoBRmalVKzyzmmin8IFttve9MXRPA
	PxvgRuBzPULJQDvwOOGVRXG0f809HaWzN3GA6eX7DifZwkP49U27F6m4
X-Gm-Gg: AfdE7ckI+O9ApFfXt7AwiIGRC+LLrAt1ckcwecvBAnqZV+xfx8P13O0CbztztbPqzC9
	nOXFmJGJTWe4E6qrMP+9JDwAFWmEDYrXpB8LQIshCzztFHnx4LC6/eNjgYFLlGgh6y1925cQbzR
	kpiGiPfqsN9PxQAH+GDb0OuQWVWy8fl7rPNkcdKHvRKCz2S/se1YSNvuNZo7Ke+5lA1K13/rRXF
	Iz14TevmAU4l1NJtthwgF/SKjRC/zztd009IYOzxCYKG2weIoSBzT180c+ThNJLSPG2cUzsUdQK
	ZeCZRbvrfV1ayeh4d96LHwYEmGl/GBCpoiNYK4ID563h/nhqBIPhtJxa3ZIwtceL/qvY9nd8HF6
	/KeY6JyZfRhLUilLZtlchWBUOEwsmaKvBMz5PmJBtkEtxZm7z8lT61HUVjkuoWhVXeINSypwYLQ
	iJ
X-Received: by 2002:a05:6a21:6e88:b0:3bf:bbad:500e with SMTP id adf61e73a8af0-3c3acc2f2aemr11768807637.5.1784491181685;
        Sun, 19 Jul 2026 12:59:41 -0700 (PDT)
Received: from PC.. ([103.172.209.59])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20c158sm31076333eec.29.2026.07.19.12.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 12:59:40 -0700 (PDT)
From: MishraMohit21 <mishraloopmohit@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	MishraMohit21 <mishraloopmohit@gmail.com>
Subject: [PATCH] staging: sm750fb: select FB_IOMEM_FOPS in Kconfig
Date: Mon, 20 Jul 2026 01:28:38 +0530
Message-ID: <20260719195839.24937-1-mishraloopmohit@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses the FB_DEFAULT_IOMEM_OPS macro in sm750.c to define its
framebuffer operations. This macro references core framebuffer operations
fb_io_read, fb_io_write, and fb_io_mmap. These symbols are defined in
fb_io_fops.c, which is compiled only under CONFIG_FB_IOMEM_FOPS.

Since config FB_SM750 does not currently select FB_IOMEM_FOPS, compiling
the driver on a config that has no other framebuffer drivers enabled
fails with undefined symbol link errors during MODPOST.

Add 'select FB_IOMEM_FOPS' to Kconfig to ensure the driver core helpers
build successfully in all configurations. Keep the select statements
sorted alphabetically.

Signed-off-by: MishraMohit21 <mishraloopmohit@gmail.com>
---
 drivers/staging/sm750fb/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/Kconfig b/drivers/staging/sm750fb/Kconfig
index 08bcccdd0f1c..7d5ad423e41f 100644
--- a/drivers/staging/sm750fb/Kconfig
+++ b/drivers/staging/sm750fb/Kconfig
@@ -2,10 +2,11 @@
 config FB_SM750
 	tristate "Silicon Motion SM750 framebuffer support"
 	depends on FB && PCI && HAS_IOPORT
-	select FB_MODE_HELPERS
-	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
+	select FB_CFB_FILLRECT
 	select FB_CFB_IMAGEBLIT
+	select FB_IOMEM_FOPS
+	select FB_MODE_HELPERS
 	help
 	  Frame buffer driver for the Silicon Motion SM750 chip
 	  with 2D acceleration and dual head support.
-- 
2.43.0


Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC8F451047
	for <linux-fbdev@vger.kernel.org>; Thu, 30 Jul 2026 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436026; cv=none; b=amYNy/YORvTfT6+XQtD33ciCxMuCRJRsGJMmvcntPlHgUcezP3rmHqUrXeUH4IeE2Dgc2IIw7ZCrdzv2+e8e8uesWI+oZCZdhqyZ81+vCnxSxX+99o2p3SdH8bnJpW7Hu3KXtKWAfPV8acbuz4zAb9fLjfRIwv0daJGC/kIeLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436026; c=relaxed/simple;
	bh=XS7Qs4QsnRKqZN6IJuYlNM42sb9shnXftjUIHrca3FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNSSxs/oAfTR77phc0OVglddPAOK3TD072xP5kVeezdiuLWBFvf7YFCOFWfDHUoha2ZiBi0f2cd7Z0umRRwPl0OaUQytIyCO4pq0tZZ9ckW4SV2KAP0ccPRmdkSUsS43XQd77+x1qlmkjXp2hnztrBBaAedQ80/QHsODQ30Bt98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=h7OZEaSi; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="h7OZEaSi"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8485ef63b68so252462b3a.1
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jul 2026 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785436023; x=1786040823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ah2rwf0hV1PovcGf/j0qIadVcdG1awQwiOMYTwXzGks=;
        b=h7OZEaSi5zhfnCTT98EH3xFxCmAz2mrc19HFBJAIEIhXoYyOXxLpnTt8fjSbc/kLwh
         AGsw2P/qcR2CIG0WIgrpd7mn/8uoMC4idKaM+IhZKQvcohdfRWstGC2KT+2anATkzo4T
         N7UBiLnxoXC4isCzbzzbkMH3BRq8uG8xRmcSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436023; x=1786040823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ah2rwf0hV1PovcGf/j0qIadVcdG1awQwiOMYTwXzGks=;
        b=C1jBLRhJhcFh8tV9Px9nobFThVuRjTRG6Pz8w85Y3w8A09xS8uT/AX0+3XLoIZrHlY
         z6TrZrfEzTDZCi2bliqF7Rr8TdaresNWfdd3gb3ARu5qfcsCJJrZOn//CSq7Cw04I7Ck
         2pDKhNxR0X2XcsvK3WQLaxlrE0FTz8hzBGZ6kKssXishRjon69aLMHrQ35D242Rdxrq8
         PxFgtqKBoSaN511dJ0PZk332PY4U3WqPdpG2mvt8B0AZOERtQ+dM2tJSmPSGhgRsKe3P
         n+71+IG6I0oDvB5cjQeM0q6jt59c5atfv/x3iYZs+iqgm7yEYXqDdPjxSHikzSLgJ680
         gSzw==
X-Gm-Message-State: AOJu0YxmiJcqaDqLmcAKFGildjN4jaONGX8kNllX0JKEGDBKveih+p+3
	0V9ieHeokw1nF7qtwEz2+VK3NQYy5qjMR9FbByjP129bvZ2vl72F+mXS1TI/KSSW8gYYkE8VjRB
	x53NW
X-Gm-Gg: AR+sD12vWB+k5Jq1lxQXkecYgZ1GO507Il2sI4eyfTWy11nWBdcPsyN1HJtfKKFmteD
	09oR4qRoiU5kj35lIw6otKCFLEAxNHvtY5g7yM26rR+6BOZF1D6PIJaP2T/HJx/0ptb1nPwFXji
	hDLMDq7PwXoYL3oWC89f72G+gGuWMOwtXgXxDd4pxVIJi/AcgMTgjtfuNcA0rLID7htClG4TtNc
	151tVygybhWnXcJAXSfcno0dStaGjRsIFuTPaXXukAbrb7Y6fxMr1b2orCA4DCOOIfX36uBdKKn
	l8ITv6f+SGAn32AkbVqyRtOICmdoAahqRxKe56JXyqlUwbTJom2kfCbmmw2VNJ3Lzy3JY9C/lUK
	RJgNX8vljGeoD/4AKFc+MQeEzfekaD4Lib3B/WaKjx2ALM//mqapod2yAmcOPcz7SHpZYWE2eJI
	O+n/VWTchlQsOGX+ZedqiQXIgnxWFKg4EF/ymLalN2MkLGKy4ZO30=
X-Received: by 2002:a05:6a00:99b:b0:847:7f3c:b5f5 with SMTP id d2e1a72fcca58-84ebc1ee58dmr3508630b3a.11.1785436023495;
        Thu, 30 Jul 2026 11:27:03 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:f84d:1f36:28ac:c15e])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84ea0378b18sm3428806b3a.48.2026.07.30.11.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:27:02 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 2/5] fbdev: tdfxfb: Attempt to detect if the card wasn't booted
Date: Fri, 31 Jul 2026 03:26:37 +0900
Message-ID: <20260730182640.2808572-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730182640.2808572-1-daniel@0x0f.com>
References: <20260730182640.2808572-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until now a card had to have been booted by its video BIOS
otherwise the driver would probe, create the fb etc but there
would be no output on the display.

There doesn't seem to be a documented way work out if the BIOS
ran or not. Checking if the values in registers match what is
in the config table in the BIOS seems to be the only option.

On my 16MB Voodoo 3 3000 the registers show 4MB of memory when
unbooted. Checking 4MB != 16MB is enough decide if to reject
the card or not for my machine at least.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index fa554b09a0a6..1d8bffe1e9fd 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -410,6 +410,25 @@ static bool tdfxfb_get_bios_cfg(struct pci_dev *pdev,
 	return false;
 }
 
+/*
+ * Try to work out if the card was booted or not, just checks
+ * if the register reported memory amount matches what the BIOS
+ * reports for now.
+ */
+static int tdfxfb_hw_init(struct fb_info *info, struct pci_dev *pdev)
+{
+	struct tdfx_par *par = info->par;
+	struct tdfx_bios_cfg cfg;
+
+	if (tdfxfb_get_bios_cfg(pdev, &cfg) &&
+	    tdfx_inl(par, DRAMINIT0) == le32_to_cpu(cfg.draminit0))
+		return 0;
+
+	dev_err(&pdev->dev,
+		"Card hasn't booted and is unusable\n");
+	return -ENODEV;
+}
+
 static void do_write_regs(struct fb_info *info, struct banshee_reg *reg)
 {
 	struct tdfx_par *par = info->par;
@@ -1505,6 +1524,9 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_err_regbase;
 	}
 
+	if (tdfxfb_hw_init(info, pdev))
+		goto out_err_regbase;
+
 	info->fix.smem_start = pci_resource_start(pdev, 1);
 	info->fix.smem_len = do_lfb_size(default_par, pdev->device);
 	if (!info->fix.smem_len) {
-- 
2.53.0


Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281E47FB09
	for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792332976; cv=none; b=D24wNxt3bfu2dv3Jz21z2f+8XQcxbYfAtz3HQMflzX0SIS4s0SJSPvjotyyD50KEc+eZQsG9sDxxcTjSXZ+DkXhY+E7BGnb540UP7GMzHfRcW0UzZHDiAbPkP4RlJP5GeZ+N+6jn0kPAxHo/KSVAiGy1SzREdpiUKPTOcz57Q7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792332976; c=relaxed/simple;
	bh=+0efL/d5HgWmlvhtS1btQMAIp2DjfmYK7noKBvdE5hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nbT8RcKGeqWcqi6BBJ0RN6G5IIPGTG5WOOplWbKt8ji7cSK4GKTJ9WJLyVxH+Q4E+hUb2QTWabagC7UPUrQWH0ywUSFA/HZtzoJhmVRj2elvC9/HMNV1f3b5eCyHR1VXQl7MvX4VAVkgVvDZHpm8YINGTHXi8X8R6ZGy3IPLSx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mF7PVCq8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF7PVCq8"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1e266fca2so2292395e9.3
        for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 07:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792332969; x=1792937769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QhsdJcCo+/WkuOVJZ+oJc7ZbMY9uosQoFaCm6vyl6e0=;
        b=mF7PVCq8FeU2wyXBVinlmqHKwiCRTQ2uSyT6VdxSW48Rj8D8tLwgQpC+weaw7nHXpf
         s9AxopAWhXWUfBr0a87YJqU/imKsFOZHbzPMJSArqZHKYQ9rW8VjTi5y0H0M5fvbvRHM
         P/Rvw8BymVEQPbUKWnwe8maRo47uwVZDAw2lABckCeho6b7PA9D6GsMMJNZsKH8u7dB4
         MMBFgd/d2QU4GFLNm80UkKfgz9r8FIrHl8vr6VTlDUZ3qs1prES/alyCFNs0j7ZlywhD
         9c7Y5rh6GubvNKpi96m9tMKpJm+n+dnKR6O07NsmSlsqFYAZaY7a26dj86YZ7p+/mEfq
         +5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792332969; x=1792937769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QhsdJcCo+/WkuOVJZ+oJc7ZbMY9uosQoFaCm6vyl6e0=;
        b=lbLTZa1vlfBHkkamHQH3FZq0Zowj1thxW7FXOSGUKoPwK2u4QO5QATl7HF8iKpsLUj
         /58xAdc33GU30LcyjHtvuRdzb0KpRP8XQT9MjQPL1smc/Bp1WJAbXw5aXVL4x81OH0/b
         zeZqkh9yAthOzB49+Z/t/N2LDev/mePjo5Ajw4NAeMViHXece7cc9rz13Bxy4QaLU1Wq
         WsIedMz4261cE1jXjnEnMT90mV+CBxllqXpb4R41GwohxFabh4vzpcmMtm/0FhqfqveC
         SFDiEa60dpyegd2unsmJ/aOaNlP50D1ICIb9DxbFqztLq4GaR14zz8KEiaHvaQqFCYc2
         UrrA==
X-Forwarded-Encrypted: i=1; AKwUvBzOjK528tShoiSbIByDg/IEqjnv2veMIEiQxLXl/0RCCoam6m+W/7pHFW3lpbDdItRR8kFQ+QfI16MPpA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLhnZ/+kpjisLS5pa314D5WbIOo5lY3Kmqu5St9aAaPWDtLWuvS
	NqxduT1/dm1LKifBk+WtjmUKNvKEeP9gSlLprxj6bgkfDq04B19TfHwp
X-Gm-Gg: AYBFou1NcgkooyD33IhVlXMZlpEkYOfIJsnrqXfbQUEmOJHnndB6w6kszXHtTST7VFt
	01Dw5UXJMb9fu4OSJYYvUGUizKQhyZy6t+LB1ArzCNQrYTMlUmLw2R3dpLgyfwEco1s668skuXx
	7EMkTlf0S4GCLpsrQUOyNbxg5YnyAssNgQvtSwSM/zj0NViJtAmchXjXAJTDSdiUGaI2nWKf7YN
	CggKBLbWU15fILDFT4pHrzX9Rl1oI4G1V1BnIoB60smt2aZjdIAds084Sy5xunn6xa8Go8v5ucx
	1NBGwJRgfuSc1a9EX1dxpoQJfSYMrZkKLtGTX3WvJ8l/oR6xImUtzfRaaMo32GyXQQf7bxRwH71
	qwtVv5jGtv5YgmuB+Gj8/OuRnIWuvrgRHqJmgMOKlzn9C/oVvG7omAFrPoo2XGATxP9OTSJ+O+B
	Eif8LX12d6e8WXPb4Xo2prqRpSSnelkhXBQH2nUOJXRgKeLIXtyS6iFICuZJfGrerSmg6vY7MRG
	faDhkKSnbAPhFnOgnIxQ4GgpvM=
X-Received: by 2002:a05:600c:858c:b0:4a1:d957:733e with SMTP id 5b1f17b1804b1-4a1d95773ccmr63893425e9.26.1792332969114;
        Sun, 18 Oct 2026 07:16:09 -0700 (PDT)
Received: from DESKTOP-0KSTGNI.localdomain ([156.213.131.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ce32absm140555935e9.1.2026.10.18.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:16:08 -0700 (PDT)
From: Temitope obabi <obabitemitope765@gmail.com>
To: outreachy@lists.linux.dev
Cc: Temitope obabi <obabitemitope765@gmail.com>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: Remove redundant zero assignments
Date: Sun, 18 Oct 2026 17:15:18 +0300
Message-ID: <20261018141519.10165-1-obabitemitope765@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sm750_dev structure is allocated with devm_kzalloc() before
sm750fb_setup() is called, so the init_parm fields are already zero.
Remove the four assignments that set them to zero again.

Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8b93bfeb217b..21744a5a63fb 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -833,10 +833,6 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 
 	swap = 0;
 
-	sm750_dev->init_parm.chip_clock = 0;
-	sm750_dev->init_parm.mem_clock = 0;
-	sm750_dev->init_parm.master_clock = 0;
-	sm750_dev->init_parm.power_mode = 0;
 	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
-- 
2.53.0


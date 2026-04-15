Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C2315D3E
	for <linux-fbdev@vger.kernel.org>; Wed, 15 Apr 2026 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280680; cv=none; b=TXRryS9h+QM0alSLk1WMIa0rLkZfNYGdhm1M1jWXknNybLx7zVZQt6d+cV1O7iRr8Zm8mW15rWQdEUPJHihymj+9B0TgenwyRn7RTr9uGJyT4FJOaYbT4BN/96aQiVli0x8eaujnFpG1X51EfQLCrf1ho+zKnIetJkLK+gUJIL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280680; c=relaxed/simple;
	bh=tU1EdtcTkfiSn33FVUfgxFLQ6+RoNw+otoyWsdjSe/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruVQJWMeNEbOUMCzyKvw+ImO/ZUPaE/rh9/qfmhGZ2ZCO+dWfEQL1dcle3i/F4Gh6H2guEPdeN2lwz9wWk7mfVZIgrd3nrFXhiVwgfjT/9xueDOF6yliuPZw8GBIcF1UvXHrHw8EK44tsUJT6YH4eoUsT0o2dlxRO2ZWIo29eQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5aQWJzo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5aQWJzo"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b458ca2296so26854185ad.0
        for <linux-fbdev@vger.kernel.org>; Wed, 15 Apr 2026 12:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776280679; x=1776885479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=db1viqbuVUDqwJpETiZkl//3ER+sg+ZcMt0690Q+Yiw=;
        b=M5aQWJzo63TTC0+jytJyBW/wM7qf1tQRh8wHeakV2i6liL9o9ThKNxPeoCzcdWJVgF
         Max5r7dpqtNBrM9ajScjBNiCuZu1B8dZ1dacS+HP2g/kL3sIVbZAyCvbjkX4T3nnX67B
         S+2T3tOUI918VkFRipzz9hJq1bGokozkS09PVATVQ/Ks/CBMY/T6WZn85Vl/6n5tVn78
         grwAN8qlAYffmI/Yv0RU4uxENUhZfs5Q/80ng99gVUnSO1CxO4Pgd/Kx6VkbquX4TbLe
         /nvpnToaUUQp7smPqBBVJEtWQTGHlL4Kd19ljc06iiGDjh8zSpXz7JUD878TkIpThJ6z
         b0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776280679; x=1776885479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=db1viqbuVUDqwJpETiZkl//3ER+sg+ZcMt0690Q+Yiw=;
        b=ZE3PEzGdprkiJqrnZ20dPzdJHZW4I2zO5IbKrD0mfh+8pr/9Y4h7OQ8itvPAHH4I2T
         ZjePf8PbZ7vQjUISW70OOFAAa8+edfkp/Fo9hUjjiKQUjLHlXizUOkU7NfD/VbpQIUHt
         EteMymV28n00u9AKAkrtt4zHJUZ6Pg1kPza1VDwAQ7B8qk2gCBoY6Gh4GqR7878Ib2j0
         BQLt/6Fkx/XqkmTdAYpavtX+P25H6pZLENAKP65yVx04YgyQVc9OTcMSDoQWEGPHZdyt
         SzX7FLwU3U3U+UWcwzp4RODAu23CEsYD34ighXNDMAzcw4wGPRLkVi4GrlRczbhvoEDe
         F3qw==
X-Forwarded-Encrypted: i=1; AFNElJ+7FrNqbJdI2mEehI8eERcxXLqiazl8pbCAaheN6nxrxRNkijOWGdE6Ez+OsvtloxLmnd9F6biOiCAUYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHX9Z1B5OCkuDA+eAzlVlwH2uOkM/U0ijCgsl8yBHsFN5u+IKZ
	ilJOJUAFIxB1y8WNDA3VNmLBJxLLEv8YYpHfWbtFcRIBkguaaMYkcbYV
X-Gm-Gg: AeBDieuWiI9hvTHsg3zoNqAKA+bynMHhSnclDPGg443Xg8tvzOscxkV2/W46wqZHINi
	BATZcdtbKDE/uXIh2RUbh0CEWNnQrPA7X+O+XPsmJ+jJtL6SMauesiErIaPOcvPLGVi4QG3Xr7g
	EuEiIYH/3yIH1pL2MuStAx1kbmW6gOgms2NMEZKSFXEhMe1P5QFTtQodWp6RkyY1cmCeVScTao1
	hgv/W7KcUDpe9PCCzdy2J2t4lvWvWVF0R9lkKv+FbE+rooYy6dNiCR0wlBUVUUZBiLP+cFA5xKn
	uIlD4pAQdjvh954aq1Hm49XMEUAnb5gGVLlFtKpcut1PRnDTZ5Y1SL40eSzTu4fK+QnZtjf34yc
	8Vjmu9MGUU/i36A/iV6T/tSGue/HaX/jEUTnwDH1o2vrZ5Sx6ioBR7TTIcaDswks+5l8wm7u/Nk
	7ssViq9dB/Ob0kYyra3F+mKz3C1wHQgzJ2vmQ=
X-Received: by 2002:a17:903:284:b0:2b2:5822:7a70 with SMTP id d9443c01a7336-2b2d5a63d4dmr227552715ad.38.1776280678725;
        Wed, 15 Apr 2026 12:17:58 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782acaf0sm32022445ad.67.2026.04.15.12.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:17:58 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Kees Cook <kees@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Tomi Valkeinen <tomi.valkeinen@nokia.com>,
	linux-fbdev@vger.kernel.org,
	linux-omap@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] fbdev: omapfb: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 03:17:47 +0800
Message-ID: <20260415191747.3845525-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When platform_device_register() fails in omapfb_probe(), the embedded
struct device in omapdss_device has already been initialized by
device_initialize(), but the failure path only reports the error and
returns without dropping the device reference for the current platform
device:

  omapfb_probe()
    -> platform_device_register(&omapdss_device)
       -> device_initialize(&omapdss_device.dev)
       -> setup_pdev_dma_masks(&omapdss_device)
       -> platform_device_add(&omapdss_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: f778a12dd3320 ("OMAP: OMAPFB: fix clk_get for RFBI")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index cafe859d6e5a..0d47a8aec5c5 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1768,6 +1768,7 @@ static int omapfb_probe(struct platform_device *pdev)
 	r = platform_device_register(&omapdss_device);
 	if (r) {
 		dev_err(&pdev->dev, "can't register omapdss device\n");
+		platform_device_put(&omapdss_device);
 		return r;
 	}
 
-- 
2.43.0


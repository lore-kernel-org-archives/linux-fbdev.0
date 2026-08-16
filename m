Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6683D9050
	for <linux-fbdev@vger.kernel.org>; Sun, 16 Aug 2026 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786865884; cv=none; b=TgxG31eocG6DZ6gntYtxQNeydZai2JIVsC0P6jfO/7Q2RooLNRNvt8vGHRCPNi1/IPiWjDLN1bXx2UzAb6Rge77xch6EWD4mlEPPkq+cxK/A5jBQIcRHiDVtZP2Lp6NMi+Scxr0bWNgd3IJdBto3qFwuxLf+8RCC0i/8Nl0Ny3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786865884; c=relaxed/simple;
	bh=6p0KUKOvqhpzwnEMabN6JsRFez3Atv297O+0llpMI7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ol3uXsNcAh4PcgWDcZ90yjbA7rmsV3X9Cx+IP2UyS5SeO05uob9Ho7BcFRe318e/owOZj7la9eH0qRfneT8c24ZLET1EtFx8m5cIV2MraZBBWD6+tNJxAn5RBuLKHLSBdokw0GhAToQ5930lvPLXDu7lmZjYjLncnkZU5wtC2cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfuEf3od; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfuEf3od"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84a2dcede83so3270148b3a.3
        for <linux-fbdev@vger.kernel.org>; Sun, 16 Aug 2026 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786865882; x=1787470682; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EWLdfVwIK8p9qDUnqOt56ytabxmXxZOehZL3bwR5nVw=;
        b=rfuEf3odTetK68l9mgUv6bC+XYV3Hb9XBzL5DGF/ZzhONhViH4gTA0qP6fFcD6C1EJ
         M6q8QjItxvti07gba2GGP2zbeW6iefsYNFTRcQF7eeh+rH4CTOPGiZ0e0e1+budtPutT
         EJ+gKbxiqYGzrrNJoNk6BXFSrDgoIgFtY9bCtWU1lMzyeym4qgyGEGXyu3URFFcqyajV
         +WGwzxkm3pxJs6XT0E0lXsAcrNVgxS6mfSdO7ee1u2JIWReIQFFPJeNhDf5IVcipv4uC
         fP6McceyEiB2WEUNBOsyUJgBQJpW0RxHqG7dgsm2FMVlOV0bg23U4+aFugmWOG8Pjt/4
         MsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786865882; x=1787470682;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EWLdfVwIK8p9qDUnqOt56ytabxmXxZOehZL3bwR5nVw=;
        b=Tn2XyGy9WJiNvmB7OfFCqX/LB+Hsk3KWWU6ncbSjmKJYZdo/3E1npza9S63vrCPsOY
         cxEf4aUNwhXAxMHVBTlZYtkQtlGFIrS49SsWkSpzMdoml/fXxlMC1IGdOeIscCuV2ZG4
         x8LGpu6PFBadCctc9aOJSHk66EB8LkqWJWFonAg+qMq1nD86HCasQYDPBJkDE0QnJccv
         NVdTiIrdjR6uYcx51oO9Lz/EN33LxhRtc6CKN1IgxKzcte6wXrc5cNATnDLQJeSeMAv6
         v0hy7cbn1hVmptixvz1SDxoJw8dPKp+lQ2rz+KHYMgzIZaRtmrx9BEpkJgntodYmsigm
         hkAA==
X-Forwarded-Encrypted: i=1; AHgh+RrpoBjT7eAvtvPU0julp+anrfpg4yGbHsjyCwEcuA2f8CpOSQsp3pk7U3MlkmO8m2tcH8mom9iItMOAWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqQuUnZ/YUKeSFH1owMG+K61r9G+Vok/R/f48HH9yjLgILYkv
	weqwvX/BWl/wGBwRfszmyTm4JUDbeiXGX/1/GL6wVyg/vh+u4PGKt6et
X-Gm-Gg: AR+sD10W9tBp881fq2xoExJhQpZ/H+dc2PWfEr2NCkQvYjF9M0K5WN1YnySAjoHDmby
	NuuS5Upt4Lv82U6pE54W8RrVaoIIFAPDvp7jeygVBixWo9KGtVVsYMtnb6UvKknanKwELcQnxFx
	nDoRvinulQZfb7JXpaCzZqen2BmeGW//d9mHyykIOrh/1IySvWTKCPewFoZhY0XK/Yt/W/DvEpF
	q/se2eDz5f5o9tY1anRy+nXecjd9WuEUP1KFLb2OUvwsapYWJCGUiw4yK0toa63XBZO43/QbvzT
	IxJV02n3n1xixXGHyc96ts6Xmcu5caPwVUnRKv4ZhUibMKdNqhp4b0QQmWjRRHfDg8+72I27sT2
	LGmKvv5xt6K6Qd61+z1+jqJqMVmFpj8sSuaa1O87+BLVTKuhyQfuszo8jpsY9bDY0lvdo7DcJqD
	SkMPisXFqmm9IdR2EKgIVquowjoIkmh+vsKdWQ9dYLa5oMkRV2EMULR6fRXuWyfPl/wDtDnECBU
	xsCn6Q6S7B4x0b50VhLyt71d5Ra1pdWM+/z5Z8zJ26hOuOUP/mgPNQu4olesrRl
X-Received: by 2002:a05:6a00:4654:b0:848:4faa:480b with SMTP id d2e1a72fcca58-84fddfce887mr16321511b3a.12.1786865882275;
        Sun, 16 Aug 2026 00:38:02 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-170-159-fibre.sparkbb.co.nz. [222.152.170.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517cfeb3d9sm1749977b3a.11.2026.08.16.00.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 00:38:01 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id 3E635360489; Sun, 16 Aug 2026 19:37:57 +1200 (NZST)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org,
	geert@linux-m68k.org
Cc: schmitzmic@gmail.com,
	Miro Kropacek <miro.kropacek@gmail.com>,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v2 2/5] fbdev: Give atafb proper parent
Date: Sun, 16 Aug 2026 19:37:49 +1200
Message-Id: <20260816073752.16656-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260816073752.16656-1-schmitzmic@gmail.com>
References: <20260816073752.16656-1-schmitzmic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

From: Miro Kropacek <miro.kropacek@gmail.com>

The atafb fb device registers no parent, causing a missing symlink
(/sys/class/graphics/fb0/device). Xorg fbdevhw driver looks for that
symlink when scanning for devices, so add a parent node for atafb.

Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Cc: <linux-fbdev@vger.kernel.org>
Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
---
 drivers/video/fbdev/atafb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index b8ed1c537293..3d540803dc2b 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -3101,6 +3101,11 @@ static int __init atafb_probe(struct platform_device *pdev)
 #endif /* ATAFB_EXT */
 
 //	strcpy(fb_info.mode->name, "Atari Builtin ");
+	/* Parent the fb device properly: without this fb0 registers as a
+	 * virtual sysfs device with no /sys/class/graphics/fb0/device link,
+	 * which makes Xorg's fbdevhw reject it ("No devices detected").
+	 */
+	fb_info.device = &pdev->dev;
 	fb_info.fbops = &atafb_ops;
 	// try to set default (detected; requested) var
 	do_fb_set_var(&atafb_predefined[default_par - 1], 1);
-- 
2.17.1


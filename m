Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B736D50C
	for <linux-fbdev@vger.kernel.org>; Thu, 20 Nov 2025 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661786; cv=none; b=TAbO9wR0XTi56wwahuJJiSI7+1PGfwTcyM9ZuN7UboPAzjnhcH4cp2MXD8QS8L83imanLdTolJWY2bIO23ZxBAmJ7yh8OM4tDgku+jzl1NAvsIPO3nfZSUdynMeFR2o5KZaL5i0v6cH7PjDtiWCWuBtbRLLbc5pODSA7X/4jZZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661786; c=relaxed/simple;
	bh=XS0cNN/hbk2CoekhfPxIuRPJF9sLiIuFp3f/+4IHrLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VWMCAfkQiIBcz0H2LlYJml0P2JGlu9grJWUt6X6Y7SD/0RCiQw01FFF4XpmjjYDfKzyCS9qOly5e/Jdhg12vd5pUxkKU5G7X/5qLl+EJkrybR5w9aav6FxKcC2QA7A+kdQObSiZnwBxTH20MREbtnuq/LTlZg8Q9X3FhC90w/2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpVNqErx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpVNqErx"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-298144fb9bcso13027455ad.0
        for <linux-fbdev@vger.kernel.org>; Thu, 20 Nov 2025 10:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763661779; x=1764266579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OVOCoFGzHJ7bReA22yhITmPN5CZ4NhXsYXi1foSFcWo=;
        b=mpVNqErxwh3ekMBbJrPw3XqbjY3B5kKuBWgP+4pCdOlemBVaDuovWKAAJUvvkoPiu5
         9sTYd6YyPbEyL3YjeSfZ9P1hBz9oMdRYO2fakB4yNNGic00E0f+uLwajObzmHwCDVOZS
         G7qSp1kkXAQ1JaYr2yj56uIo9Xq1lloYs7VZ49Cc7bTwALURsdcXig79GejO7OCHZMNj
         e0ESoiH6Ks4D0BFUqMNiAzBFpFl/w3ffVSJc4RubjwtNnJOY5bwpxdgEJ+ifIxYXDutC
         QWQrhqMr+5RO3W18EYSIQ14iOHfr6Dqm0i65ND20dbRiEF3jxC/T4Jzs2RBg4iQ+7rEL
         K/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763661779; x=1764266579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVOCoFGzHJ7bReA22yhITmPN5CZ4NhXsYXi1foSFcWo=;
        b=lsRAtU6yeSYnR92Ugyup3Sxk6hZj1H6kzk/R4rD0hq/odWmZ4AsdFhImnjzbsRX1sZ
         P/NiweoucHqTOViz8S0fVvKMlpyn9I9Aj+ajBMElDFDBNpHIgkPBFh7oRM/LJ2HPCel4
         TwXHT85dxRZnadiqTZPLIN5hDp9tqQk7iqOTU9XxTdXlwJivXUoHy+24luYv19lUEaru
         W7y4n+fAGumC0z8JBSbCgyiGVvju3RNgItE0Kcsozy2RPfPryjpe8EPzVne8G4Sn9SU9
         p11CFcdDqDW6pinilBZ9UlGzbXdRIp11r36R8y5TsPDZuP9peGlkzkaew4vTAcWJE3LU
         fhkg==
X-Forwarded-Encrypted: i=1; AJvYcCW5S6+XFxjKJdiWoaYtTIiHOl5MRHr0+TAFkols5izLX7mSx/3hsKNwkQN9OiN25+M+8oumguc+leiIsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2SinfYjYqn1qLc5gBd/BZMI5w3ACX8UUe2O1503E/WUpcQh+T
	qdx13jnN2cyGLUGWPw/aBWZOB6NWDpj1JjFNMV58v36i6S0DksuNF1wE
X-Gm-Gg: ASbGnctwgFfbouudXZPOnyHnMn8TXYvcbtigZOaOumy4RydHjGdFLgJop1AG6ObDkdz
	MMOdMBA7AZNXLmscrXJ7VGK17goXviE6PjVsoxD9uZ81koZ3JVuRT9HaagZMlfUask5rBbDD6To
	GuDd8usxYfrAticJlxfd5wdiTSvrqjiYdscGGZSP/yyp3FN6eKx176vnVLlIM2JFEhvHcH8Mmw+
	luKEmQqx/o7Yt74wFWyFqWvIsicb1nfUWgpO+0vkFgYROgVG8BoWL1vyhBspCQsKul7Bk9mvtIc
	nTOGxLuJ4PwNgBZc4EqbkNk3jzyyYzfbRD7fx1wTQku3o3NOVH/bvvmghUWCe6nxExf0O+sM6sV
	wbbcDV7GQa4KhOpYLXLCg0fcqxQgb/JCrGXwvQiEdMv8o2xivHvxkbHBc06rhwlyB3O0E3P6p6i
	QtqY5z5P4=
X-Google-Smtp-Source: AGHT+IGQuK6OHOkNhp4JqOpNkOEA0iq7GPJam063fPFCVHzw2hLDL/dgREEsMf/1FgZxDvo6dgcodA==
X-Received: by 2002:a17:903:2ecc:b0:296:3f23:b910 with SMTP id d9443c01a7336-29b5b02ea46mr45621375ad.9.1763661777896;
        Thu, 20 Nov 2025 10:02:57 -0800 (PST)
Received: from hsukr3.. ([2405:201:d019:4042:962d:7736:8598:eb91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b111e01sm32720885ad.7.2025.11.20.10.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 10:02:57 -0800 (PST)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Sukrut Heroorkar <hsukrut3@gmail.com>,
	linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
	dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: shuah@kernel.org,
	david.hunter.linux@gamil.com
Subject: [RFC/RFT PATCH] fbdev: q40fb: request memory region
Date: Thu, 20 Nov 2025 23:32:27 +0530
Message-ID: <20251120180233.763975-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The q40fb driver uses a fixed physical address but never reserves
the corresponding I/O region. Reserve the range  as suggested in
Documentation/gpu/todo.rst ("Request memory regions in all fbdev drivers").

If the memory cannot be reserved, fail probe with -EBUSY to avoid
conflicting with another user of the same address.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
Testing: This patch is sent as RFT since Q40 hardware is unavilable and  
QEMU does not emulated a Q40 platform. The change is therefore compile-tested
only.

 drivers/video/fbdev/q40fb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/q40fb.c b/drivers/video/fbdev/q40fb.c
index 1ff8fa176124..7b5c31745041 100644
--- a/drivers/video/fbdev/q40fb.c
+++ b/drivers/video/fbdev/q40fb.c
@@ -101,6 +101,13 @@ static int q40fb_probe(struct platform_device *dev)
 	info->par = NULL;
 	info->screen_base = (char *) q40fb_fix.smem_start;
 
+	if (!request_mem_region(q40fb_fix.smem_start, q40fb_fix.smem_len,
+				"q40fb")) {
+		dev_err(&dev->dev, "cannot reserve video memory at 0x%lx\n",
+			q40fb_fix.smem_start);
+		return -EBUSY;
+	}
+
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		framebuffer_release(info);
 		return -ENOMEM;
-- 
2.43.0


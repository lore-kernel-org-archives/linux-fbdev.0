Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A31529A9FE
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Dec 2025 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766123030; cv=none; b=lGprpA4lURRfz+/p8IxkKRzC1Ee1BKDOS2Vz1iQSFxD0+g3zQtNo9MhqWKalGayEt3Hsk4VW/uD/GNiiurduVhN95gsJrjDduJ6hltvvF7vnG6jOWPkISSJfkBEwdaAzpz+3H9HvlxRHCA/0iNPL9PbQGSwR9DxAq0Y63D5zgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766123030; c=relaxed/simple;
	bh=UkrCfcHpZ1i8AvHQA/75nfwWAOIjYXg29xVkb1liZX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBGhCUt8N2b+ByxfeBUu6zvZj3aJb4AbbR5whLWpjOlXlf1AIF61HyRbF9M6BqKOiiN1b9NL9sB7GBj4Wj8NEaxZcqI7Sw/Wu3+8TR0KNB1iFoWvDiqr+N2csYJbjhTF6hy1FvyYlXuSG/+vMWEKbVJJUAChRNwSE7H9MnHuJ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2V9tFrw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2V9tFrw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a102494058so12463715ad.0
        for <linux-fbdev@vger.kernel.org>; Thu, 18 Dec 2025 21:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766123027; x=1766727827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OguNjtskMuqb5lnf7iu+ciDjHTh+c3vKrdbcOWFfIs=;
        b=m2V9tFrwPsthnDwSsO1gfcgtW2II7tx4ucMLGwjFF+cFNFTtVrq2GH8epS+99WbX98
         pPGvAsAlXvL6BsNXODoPDAPzLya/F5kSHMZ2C/PgRYWYmNWXWlmoKccIA/l4XKfECmaW
         a6+SLG9nGKZSobhp/xoGfCpx3SJeog55yuUr88gT70TMso4EHKUQZiUsZxmzEBlcs9Le
         Ps9GpvxHqpqVeuLURr9gSIdoDZ1r3oktEk4gu3DRqPO9Swoj9DqGdY6lSYJ9lSD2Novp
         XxOv2YsTY2/NuFxtT0/dvSOFLUYy8lylfFUlBJocPJDSa/OEjIIAMP9K0ix7CuUsrRtQ
         EBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766123027; x=1766727827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7OguNjtskMuqb5lnf7iu+ciDjHTh+c3vKrdbcOWFfIs=;
        b=c+DyOe6LXHfr2XqxYVQnoSbpMiI+/InuyTrC1ShfsiTCbms9hNhRvnv6NOVrxC815A
         tJ/h5Y2kX8HY1myBBrsJhACUcroQioYdpepr4BGFDMO3BFCm/zk4TksMYH/2TN5KR7me
         n9N3Au4u+LrSsF/Ebm/MFGlz+YTkP6/tcm3rXwrDNCP9w7JSW+NVg/0XZ7Xm2CHzDBSq
         fEQbfO0DD7p60GcGft1RLZ37ZSPbRbhB0I0K1OEG2BaHj/U5PyGouq74Is6YKJMH4lY5
         +Oef8cJa52k0rqltqO5ltKspDInnHcn6iq0rAQSyt4nj2MDl2p4OnTTEWMvtWuKwQNN6
         P0CQ==
X-Gm-Message-State: AOJu0YzjAOWgEVM7pZmgYlCzPr7ario3ziLFWl/5kiyFIRt6K0Vxn949
	eCWGmLZ4DzmxLhpV1n6EWlCarCIf40JCHY/QETUYAA2pRcqpi5/U7f05aPyEYEWe
X-Gm-Gg: AY/fxX7UIKvvcGwjJCZLYsq541g/KruxlFkzv+kXRyGa5XLWI6Ag6cri6BdeMXKbF1h
	NXGejRm58DhCVp4L4CUmeUoVHfENUu7Q1iFHmKJOmHvQJk1mkhYgYoJBzE1ZaacsyWQEqNKxj12
	AkWS9pT0YgxUaVxhVIxBi5n0xausc5KvSciJZ1C7yDC1M2LPKg3eNc7t6UQz322cm7ZJ5Q9FMP/
	sGKuk579+2U93oePesGsUIaxSDLmjg9wJwrszt3YPaP+wemRvZe3yNmLD+9fQbPxbhplk2fvdFw
	ERfgBjdxnI+cJfCSOUHy9P+zdgmHj+mzVlifNQqMCWnqRuy2Nq4KgWJAcAiGWDAXVuueVEe6yZ7
	iHcHkjRyGVj3UOvP81pY5N0mryHufH+RpblYnEspaZH3P/wsSQ1eViQEyRZjM36uebAcvTOcjTF
	8uPGFp8DtjgWc5wT6PL2ssQ0de/69ML3EhHzloCzfzVwg=
X-Google-Smtp-Source: AGHT+IFIN9O1bSTaoX7Y9Xly+yqtX/VSEkwqhmoGFiL1kW7k2Mixeaj5EcJ8LC8LuF4Nk/249G3y9g==
X-Received: by 2002:a17:902:cec7:b0:295:134:9ae5 with SMTP id d9443c01a7336-2a2f0d41127mr17823485ad.24.1766123027055;
        Thu, 18 Dec 2025 21:43:47 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:5160:2cad:cf88:afa5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3da7dabsm9878955ad.25.2025.12.18.21.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 21:43:46 -0800 (PST)
From: Chintan Patel <chintanlike@gmail.com>
To: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	tzimmermann@suse.de,
	andy@kernel.org,
	deller@gmx.de,
	gregkh@linuxfoundation.org,
	Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH v2 3/4] fbdev: omapfb: Make FB_DEVICE dependency optional
Date: Thu, 18 Dec 2025 21:43:18 -0800
Message-ID: <20251219054320.447281-4-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219054320.447281-1-chintanlike@gmail.com>
References: <20251219054320.447281-1-chintanlike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omapfb provides several sysfs interfaces for framebuffer configuration
and debugging, but these are not required for the core driver.

Remove the hard dependency on CONFIG_FB_DEVICE and make sysfs support
optional by using dev_of_fbinfo() to obtain the backing device at runtime.
When FB_DEVICE is disabled, sysfs operations are skipped while the code
still builds and is type-checked.

v2:
- Replace CONFIG_FB_DEVICE ifdefs and stubs with runtime checks
- Use dev_of_fbinfo() to skip sysfs when unavailable

Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/Kconfig        |  3 ++-
 drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/Kconfig b/drivers/video/fbdev/omap2/omapfb/Kconfig
index f4cdf999a080..2d20e79adefc 100644
--- a/drivers/video/fbdev/omap2/omapfb/Kconfig
+++ b/drivers/video/fbdev/omap2/omapfb/Kconfig
@@ -5,7 +5,6 @@ config OMAP2_VRFB
 menuconfig FB_OMAP2
 	tristate "OMAP2+ frame buffer support"
 	depends on FB
-	depends on FB_DEVICE
 	depends on DRM_OMAP = n
 	depends on GPIOLIB
 	select FB_OMAP2_DSS
@@ -13,6 +12,8 @@ menuconfig FB_OMAP2
 	select FB_IOMEM_HELPERS
 	help
 	  Frame buffer driver for OMAP2+ based boards.
+	  FB_DEVICE is not required, but if enabled, provides sysfs interface
+	  for framebuffer configuration and debugging.
 
 if FB_OMAP2
 
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c b/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
index 831b2c2fbdf9..ef555dd598aa 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
@@ -558,10 +558,14 @@ int omapfb_create_sysfs(struct omapfb2_device *fbdev)
 
 	DBG("create sysfs for fbs\n");
 	for (i = 0; i < fbdev->num_fbs; i++) {
+		struct device *dev = dev_of_fbinfo(fbdev->fbs[i]);
 		int t;
+
+		if (!dev)
+			continue;
+
 		for (t = 0; t < ARRAY_SIZE(omapfb_attrs); t++) {
-			r = device_create_file(fbdev->fbs[i]->dev,
-					&omapfb_attrs[t]);
+			r = device_create_file(dev, &omapfb_attrs[t]);
 
 			if (r) {
 				dev_err(fbdev->dev, "failed to create sysfs "
@@ -580,9 +584,13 @@ void omapfb_remove_sysfs(struct omapfb2_device *fbdev)
 
 	DBG("remove sysfs for fbs\n");
 	for (i = 0; i < fbdev->num_fbs; i++) {
+		struct device *dev = dev_of_fbinfo(fbdev->fbs[i]);
+
+		if (!dev)
+			continue;
+
 		for (t = 0; t < ARRAY_SIZE(omapfb_attrs); t++)
-			device_remove_file(fbdev->fbs[i]->dev,
-					&omapfb_attrs[t]);
+			device_remove_file(dev, &omapfb_attrs[t]);
 	}
 }
 
-- 
2.43.0


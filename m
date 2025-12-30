Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373DB2E7BD3
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Dec 2025 05:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767072551; cv=none; b=ORI6XC5cI7PmaizqunnQQLLDNVj2WIY5FNGjTjYNz0lwQA5RjVhAc90r5Ksp+tkKTjYHoCMKyOiiIXIg7P1NtPOVEJe5rF4yDvup4a9qIhLjwsXseeMCjnqU+1/Epr4/N0xrzKsVtJJro4BkQkeF7zfx0S50NP9ZmsZ02wldgoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767072551; c=relaxed/simple;
	bh=NLZLkjHuusyZxcw9lTFQIq8VGGtemLVYiNqCQHZYJL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSrJeGPscL2dPuLWav2ZB2qlUu3QnpKgUaUVYOx7tDTypWvLeaJJ8K+obTNQJ7a8dfqw1INS1Y+sNslqrdOsZDAdIYfULDWbMWZa0qX7DjzDajPetATiiOFEUcFRBN1d5HjCTcdG4QljzpmfIWenwFPta67SBTfZ2sDtMSZ0f3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNvpcxIY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNvpcxIY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a12ebe4b74so172909115ad.0
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Dec 2025 21:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767072548; x=1767677348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ci5hl1fGtHa6SMuwo1VapvWaLUMCAvqlqzaI482cWA=;
        b=KNvpcxIYzc/Nn8MFw9dep+CALY84eksZAo0WvR/gSdQXEs3jXjLIwRcqdMKH1Hmq16
         nz9gJZc38J5sKVNTy1mKQDdBgagvj/46awh1jFTgCB0X1UYh4mhi8yZMq3+Lw70cfV2y
         z6a+nV0ygViFK8la3fDgOOyZaNuIgLwpCZyRclxW7f74KKpNC/NfVTDpIS5/b2Ccr6Lr
         d1GQ0RG4+9nsYFScie75W5L2KZxSXh1/kWnRBePPiUrhjuvNCLDWWU7dG2P8phW7CCEm
         SsFf5Lpxi+5xPEV11uk5zk/1Nyifv+ReDtyCsnzO8uOmgxsTp+nItzT0f3My8laCl7O5
         NH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767072548; x=1767677348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ci5hl1fGtHa6SMuwo1VapvWaLUMCAvqlqzaI482cWA=;
        b=Gn01+sAfubTYAr25GBmJgKbPwJ5t/eajrY47vahrJI68nU4Ecuv/9HSMTjLgDDHAue
         0ujNkVjaKsNkyF1ezmgrFBlT+OAEuAKE92QoMg+q4SqNQqOxopzzkS5cEhjXqpvVX6RR
         ENGc3Zl3lhamjPxQEF7qzND1e9MHnLleoqrTQNjTitAHYRzUrnldZJ1NsNgrCjkY9TTi
         yPbhNZaNIHCeG9SP3T+n/NXlFe14Qj53E4yYErDyiMDRY2w/zqCGriEuN7nrBX1CPm16
         +g0fRPdon3ue8HTaQFBbbonHmYd0B2kKAIiCAcoLSFaohXJ4JoxMw4PwL8CohNzR+rpw
         hIrA==
X-Gm-Message-State: AOJu0YyCtK1xzHALTJffY9uO0V6HRXYvPf/xT2FD4tIqvNhPkZp3RCQl
	yT4J2DRyvj7+MnnTw4du3t4ERqgr3ejXazfNHxjIu17El69SSY+qAxTl8QZtb6/E
X-Gm-Gg: AY/fxX6Kr5Mtt57GKwt13nmYBa9NrYIl3DmG7rMDWnydFdh8ELAyfx6f/++4/lncBUp
	pWqYvn5vsW5kyJjABnJhWU6r1qTsUWMw29DeG0PE1Rh9kpcZPPZNOqV3a3Hli8pLQ6NsuYIYAYP
	NIk08siuagyoZZx7oaGlOLh+QXg8YKKNkO8HorE/serp09zNvWnsmPnscM1xJcwNbEMr2OP2HW0
	iN23dEGUGp3dz/RL/UrLx1R+uB0rtiSEZ6NtqJnDnX5180+6yCC9J/gIa9dkaEYYwPHdCS/nQVG
	d6FSPqNxnbcXSq03Kcc69oY0Imf986CDNi+D0HLnCwLLNRWsRlkJp3yS/YnOvrTCbW9WOK+KCxC
	3LxxHo0DlaaRjPQXOFXZYPTQpasrN0aOyPQ507i6mAxFLSoWJofikOx3e8TQVhyxWC2ZxLMw1oN
	J4Y+5ws7Iljx+H/UlAkyzNRgOebeaQLKg8VTo16TRZWA==
X-Google-Smtp-Source: AGHT+IGHZFAx8HgkjBpBEKVqWvo2fMWKQIfWR+KFRWNCjGwdqjZSd66OErzGlHaqwrUbyJ5EQMboOQ==
X-Received: by 2002:a17:903:4405:b0:295:565b:c691 with SMTP id d9443c01a7336-2a2f22292e6mr304546365ad.17.1767072548211;
        Mon, 29 Dec 2025 21:29:08 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:f7a0:c2f:d915:faf0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c8286esm289290375ad.33.2025.12.29.21.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 21:29:07 -0800 (PST)
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
Subject: [PATCH v3 3/4] fbdev: omapfb: Make FB_DEVICE dependency optional
Date: Mon, 29 Dec 2025 21:28:21 -0800
Message-ID: <20251230052827.4676-4-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230052827.4676-1-chintanlike@gmail.com>
References: <20251230052827.4676-1-chintanlike@gmail.com>
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


Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804B38237F
	for <linux-fbdev@vger.kernel.org>; Wed, 15 Apr 2026 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280071; cv=none; b=panzJExgURsqulaycCqakDFf1wKs3MUc7baT4YgfkJN8kDzG8HLtjabWJAH5JyOjqZ6/Omya27Qsz4t0wGI4shprfvoGoiXjGRh3QkSwaLsI38ffcs3kdsEL4bkJ8j0zFmmql+fW1kW3dRS7MdwENknAJi8ta4V7OGPPm5vlc38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280071; c=relaxed/simple;
	bh=MQ/sUqpism27LsU0EGoWQQpbieUlKUv3I6sun9A9TAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYtyqfI2ysd/DyEpijMUZkKegYYhecCKIMfNgLr6AFnTmAhzuJS2tmzH8qVF3Ak5B3NVMt4mW2LLJcWfugxY/0qSRzRhZzGhlodbkiY32HLcNkELnlCKXgeRu9IezRs/tkTeVqV5IzY3IKPmx3dHUztjVGWeuG73XOHBhuJDAXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNkTn3fB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNkTn3fB"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so6404530a91.1
        for <linux-fbdev@vger.kernel.org>; Wed, 15 Apr 2026 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776280069; x=1776884869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PDtRvz4EVThH1+OkwbQhx5LhEh7Xl5HdhpT/91cyYas=;
        b=LNkTn3fBV9tYuTD6LWYr8LE0O+pvQT+z1WDCZURwKg1pcCaQFebJ7k2uNVTwIUGUmg
         E3PkHHftn48OGQ7q/zuzuJaV+ZJWKXHkNSERRGP2sfkkvToepOiCJLyPQgq7d8+YshEu
         9MLKZ/oNTZn9uwMVUiWIfpF7Pn3Mp+biJ3+sEQWz61hKBqQ2u+OXR50fobUxwjNzjtps
         nbN3ri4N7Q7e75MZFNmC+H3i3Dky13tfCfl8lyBe9Q25ECnJTafcT3XO0mTn7DD/kEuR
         GCxY0+PibliVZRSqh7p01n/o7/yCmhJXJpwXlexzef8xgtLsOy7SFSgLlIJiIb9ZJ8d3
         6sHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776280069; x=1776884869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDtRvz4EVThH1+OkwbQhx5LhEh7Xl5HdhpT/91cyYas=;
        b=GcU3WuLTYCelGVOc+y/8r7DbJHzGIOh1Srp1n1DAHAq5qe5zOuUy/45kY1+H2qAMG7
         7TKtTsVzxoyM7YhWzWAIOZv1mwe+kezqZA3uluEgYUmElPY4QaJn/rk7ep6qoYsSzlJh
         VehhqudI/xQDgc/SiUR1XgBF7f+OzUuhF0wqHKaKrBLWR0xN5zSRdmRwdE+qsLt/UbAZ
         AN299CElyLGxiIFGWJRlF1yLv+F6qwuZ/UmZA0STMg3hdQftFs8xb4PNxFuMQptcnBvm
         3t3m7TViKkzeju+KJr0MJIiKc3cZ9pNNr/laiFeooDt4W8L2Fz65XNoX1kpxT7LkY6ly
         IgPA==
X-Forwarded-Encrypted: i=1; AFNElJ8C+qFsICUNN6k8CddMyeEX+GodrAkwcDg8PBeiklqpYFX6P8qGC1fGXcL1cxx/YVCRm3gFH0aqt/gjWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLyR/rG/DP8Z4M65xU8GoUUeV03lq1ghNyAcfvCE6WTgiZ5EIN
	P4pxvxL9wcV9lS7K7Jh9+gZtfzSOze1vUEphJ8uACmDZoa6WGoC5Iyvv
X-Gm-Gg: AeBDiev+bhSO/bK8n8sr+7ja6B5gu4s3DZJ9HhQGSsYwh+mJI7R6pEExQjo1ucoxhsE
	AU2pCFCMl8U+FD5eP6Ity5aUTDBHp0MpBhpeY3TlGisxRLVxa0z4zx9K6jY/xpqkyKT1Sg+d2FJ
	WwntlS7o8Ikc7JFlPdMwJKKrn7wW5CH4pVkK5WiSbJ7gbQe0wlwJWcTICF/Y66IOfhYk1H2eJ5G
	O8F8WxdMAA13IJ3Ixk+VXS17EU8liZxz93FfY8CJK9M7NxmY5MzFP6ApFmrvEGkoQIZmlNN3Bh3
	cUmPtTgydrEH0VeyJupeSwEyumzdp+hRX3w5Pkh8r/Q+FIEOK9YsjKctummcRTgenlAR32/PckV
	xQutiVBr0dgjoTdHpyUEo7i8FEaf2VtRXqDBuJ4TpOVyWeGQBFUa7UvvyClGuBWKCR3t+mdsiKz
	9zWi3Kn6wpRAyaJo7Bqj4QeSIJTUoCxYC/AkQ=
X-Received: by 2002:a17:902:9341:b0:2b0:4fb6:85ce with SMTP id d9443c01a7336-2b2d5a45a0bmr183001445ad.21.1776280068622;
        Wed, 15 Apr 2026 12:07:48 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782b53e2sm41305185ad.74.2026.04.15.12.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:07:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] fbdev: dnfb: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 03:07:38 +0800
Message-ID: <20260415190738.3821974-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When platform_device_register() fails in dnfb_init(), the embedded
struct device in dnfb_device has already been initialized by
device_initialize(), but the failure path only unregisters the platform
driver and does not drop the device reference for the current platform
device:

  dnfb_init()
    -> platform_device_register(&dnfb_device)
       -> device_initialize(&dnfb_device.dev)
       -> setup_pdev_dma_masks(&dnfb_device)
       -> platform_device_add(&dnfb_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before unregistering the
platform driver.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/video/fbdev/dnfb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/dnfb.c b/drivers/video/fbdev/dnfb.c
index c4d24540d9ef..72a9c47418f8 100644
--- a/drivers/video/fbdev/dnfb.c
+++ b/drivers/video/fbdev/dnfb.c
@@ -296,8 +296,10 @@ static int __init dnfb_init(void)
 
 	if (!ret) {
 		ret = platform_device_register(&dnfb_device);
-		if (ret)
+		if (ret) {
+			platform_device_put(&dnfb_device);
 			platform_driver_unregister(&dnfb_driver);
+		}
 	}
 	return ret;
 }
-- 
2.43.0


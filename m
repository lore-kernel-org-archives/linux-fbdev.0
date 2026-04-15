Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C6D346E64
	for <linux-fbdev@vger.kernel.org>; Wed, 15 Apr 2026 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280215; cv=none; b=h4VkdjoDveUTK+s4HMssuFGNyY209pdYE3DGsINNklgh5X1QStiPz8hhYSsv13B+reytV2ZWCDUEibhb19GS3fDduq1cOIzz0BWjJ5UhcmAhNYn4IWdgMPajsu9JWm11l/UYzSwg3UDbW/LMCMY9wYpzJqXnycHcR9wDM4A8B6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280215; c=relaxed/simple;
	bh=EHnhESO1Tx/OJNq6G8Y2HbREZZHJK7I6MopoJjS56d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDykc3sXOE/vh8zDy1lfuzD3sCZ32WBf/Goq+rgDVqfgcqRR1yTqS+zQmpHg48culiHqDW7oOoPyJ29WwzOPJfOiM7m8nP7TF9Eg/eJpBLLVs5ik+IP+HJl+kK415OnjORPAOdeb/V9JJTkbCl4bE8qyKycjzOrkYhoG8nZPrOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUMTIqyD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUMTIqyD"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d95017a68so4534551a91.3
        for <linux-fbdev@vger.kernel.org>; Wed, 15 Apr 2026 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776280213; x=1776885013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTqrfv4BEcpMmcd4d3ppiH5KBkdSGHZGeXMM12mQixA=;
        b=JUMTIqyDIATG+tzvtLpOSPwhRZiFGvkUy8gz8vZyTZlLt9Qm4ur8sogteyfRf4ZmNh
         D02DMhvdBf1KOgVLrSLLZA2gMvLfyil4zia2vkqnO+r2obc/Y66iFJHomlrVKBkpSfG0
         Qp7sCWBIbG0odU0DtYiwa2LplwsZuMnoRkt4C9+NJTTIO7mKJbeVfPeMdtlHUdVs6OYE
         SWkvbY8Z0q+lWpLX9kYlknPCZNJo4YYMGTcmDUtuCsEqLlqC6C+duhyBy1zOSVAwnS+5
         rndF0m3KhIklbqbp5vyVzTB4FKkLWWuoX8m1l/ScYzKzP65EqSXQG4dQVnn6pS+gfJKe
         GAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776280213; x=1776885013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTqrfv4BEcpMmcd4d3ppiH5KBkdSGHZGeXMM12mQixA=;
        b=OQMnsYofeERZ3hbNo96Sp3XZaPCyOYqIcKThrqkV2PCDsjkjazMfvFxRxLvmnphFVC
         BWtqQvFkbI09zNwrrZTTJ0J5AbaCJxbcZBU8UocpBT7wkLAeJ8YNQxgmeMsV2vpXa8kD
         ThQuJ9cNNPWrqd/PHO4MI5A6+ekkftLg6/pXO3aDaiP2GXmoMiTPQQ6DumpHXeKgDc+q
         HNDtDANYppUSD8sU5rY3tVDIC4C7s1wFlKsswic+j1HQF/6KrzDqTfV7V4G2JCBxcS6g
         /dpAUL/dOiBpuKVd0qfHUvGEwOod0G6DlBj0gclpNTADSH/z1bwi4RFvdkYHPKKw8RoK
         jISw==
X-Forwarded-Encrypted: i=1; AFNElJ+W+/v2Q3ynuMM7Nl/YPkena5BIPVSFDiNSUCbSoTNT1nWBODFg59vT/kgMAHdAS4HnL9SpHEQGY6YcWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9bt6+lcFmX+jxsCdwM+sMt3xHn87WpbpLvwEOwMZylZm4U7Et
	DPBOeP3vPwAPWXHzSuP498Tr3HEgJW/BIH4JY2fmCeXcEnF2yHZwZE6I
X-Gm-Gg: AeBDievpbWvv1mJ8mkoJU6/uF45izwfuKouNkiwMVCLNi+YV/T4rXKByNfFUU2OISoF
	7oBK9JoX16XPTAHOAPHOx+N8BgjnCXMvI4/ZJlMor4muN286kXEHCM8zwnrk49DEssR67X2HTUn
	eEV2/MD57pKJDISEIJVog8eetKqg6Aux8UocOvTYR7NBUev17VXTObaLQs1cmPKaB+WYHO+5WN4
	VwfHGo0F8BFhVB2XFv1XYTTSjsfaOSDw8e1cRD+2f0ArE3TK4tnkOpGRrdN4lKMhCm5eM9OwP0M
	xHv/KDkG5yNWiVEGVo9APOLhuAAeEwRpT8E5wU464ncQkDCjwV67Xew5udrv1QQn280sLlZYrPV
	sl5QKsXTi3nhgZuDhd9W+jPhdSTeAWKLrGSqV2NenUFLiPyj3rwURmugXIsFp/rhhdFJp21R/Mq
	MsUO7GWSSB+f5XiNmmcky/RzjL1VfOW9XdOiarYneaxUViVQ==
X-Received: by 2002:a17:90b:350b:b0:35d:a2d3:5c44 with SMTP id 98e67ed59e1d1-35e428581f9mr22426248a91.28.1776280213582;
        Wed, 15 Apr 2026 12:10:13 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd3074758sm2759890a91.1.2026.04.15.12.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:10:13 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Andriy Skulysh <askulysh@gmail.com>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] fbdev: hitfb: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 03:10:03 +0800
Message-ID: <20260415191003.3829558-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When platform_device_register() fails in hitfb_init(), the embedded
struct device in hitfb_device has already been initialized by
device_initialize(), but the failure path only unregisters the platform
driver and does not drop the device reference for the current platform
device:

  hitfb_init()
    -> platform_device_register(&hitfb_device)
       -> device_initialize(&hitfb_device.dev)
       -> setup_pdev_dma_masks(&hitfb_device)
       -> platform_device_add(&hitfb_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before unregistering the
platform driver.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 048839dc548a5 ("video: hitfb suspend/resume and updates.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/video/fbdev/hitfb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hitfb.c b/drivers/video/fbdev/hitfb.c
index 97db325df2b4..29708c2d506d 100644
--- a/drivers/video/fbdev/hitfb.c
+++ b/drivers/video/fbdev/hitfb.c
@@ -495,8 +495,10 @@ static int __init hitfb_init(void)
 	ret = platform_driver_register(&hitfb_driver);
 	if (!ret) {
 		ret = platform_device_register(&hitfb_device);
-		if (ret)
+		if (ret) {
+			platform_device_put(&hitfb_device);
 			platform_driver_unregister(&hitfb_driver);
+		}
 	}
 	return ret;
 }
-- 
2.43.0


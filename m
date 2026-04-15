Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4767382F34
	for <linux-fbdev@vger.kernel.org>; Wed, 15 Apr 2026 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280396; cv=none; b=cnM1cK90ZeOHBT4DXftrjtnkOTgzaC0y0oMOB1GzXYoJVDlhLgDrZ0YvSceFlWjWivGrAG/5vzFmt6IrEF5sOOIVc0smoeLHf9lu9wxGJlN0+EHk4HJYTjbXoEkDgaOYcMUtFIBtpAmDAG2edGFKmlelAMqn/hdUPCSexfQmXWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280396; c=relaxed/simple;
	bh=QlduOW42d2EffleOxDkxogb+jCXsqBEYC48mTTvHmVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Faa5EMCaz1me+JNQQwmXiA8zlE1PBiKLuj2kqIKHjunxDNg8xCebeFD4DOTCtpyo5q5SPCo61T1t1zZPfdg8dym4HMRhiqLQ1GwdTxenOR63vHFX9seVXALHMx0UHo49xEGb2B/noQWfdDymX4i+3k86xJGUwJVuFBdNYmw9Tfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nv7P6FY7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nv7P6FY7"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f2766905fso2005134b3a.3
        for <linux-fbdev@vger.kernel.org>; Wed, 15 Apr 2026 12:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776280395; x=1776885195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jBcpP2Xf91EXqMzxfz4ls9MLPGhLhWDU+QsE/IF+8uQ=;
        b=nv7P6FY7CyKmdwNaTxZ3dmk/QPCRI226/mRw1G2mVDJQHjxTdG41g9PvLHTXS0bCcp
         C5dADNCJp3muA8dXvja6fjmp+3akwPh+X2qtWOgUd9mvhpaJFzUgSybkgfzAdDKN9Hcd
         PPJmCYGh67SMN6TBxHWDE2EKlFMExN2Cuf5nIzN8b8tv7ZIaK2kbOMIRKAwXYdPpArYL
         C06ruc7QAhlY2betlyK8YO1YRE+NAv19vpQXkmtxnnUCdc/ni9cIps6nFoEhZhpzE88U
         FSVq5gH2TZoo+PtcJSg/aJIxrKp5agVAepsbuL3Hnr2MdmFcQMMQPIo/C2/AUtcRS5c7
         Ds3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776280395; x=1776885195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBcpP2Xf91EXqMzxfz4ls9MLPGhLhWDU+QsE/IF+8uQ=;
        b=NIpC7BVDrxGlt6U3IgtEWZC0wmU2I/Rq+764m1LGMIzik+5bDZITkINmzqtQoI4HcD
         w/JQBGM2Gc4WrJZqIgtapPgC9vO6a2PN312kedQo6jRzB2IDGbEAjkqD1xJRdgyzYwUF
         FpIJSJkpah5aJcyucifhbEHBiVpD6kuPCBbsKTebVjbF9xfgIAgUyk3Xs2VkXyeF7+W8
         w11btET0+ygdwLe/ECGhPtbazpQdSUjusXTHmw23zb+D1UD+2LUd+bXVd2Lqnb+I8mce
         cegd6hirvNYPhFtN4/WlWDYJ+qAi3/flvGQcZIgOx2xV2jeaYdhcWqzl7xjYIMjhRdZQ
         FZ9w==
X-Forwarded-Encrypted: i=1; AFNElJ+3gdXJovWGTjrB91Bc/PSBvI5M4hd+0cHBHp0Xdq9QNhOo3U35XoMR+0nguCEjApTSnoIhuxJBzOBx9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVI70mTrXMyHJ2bDyrBnoy75yWDDqH1LMt/N/FNqPqFnQUDff
	4aquPM7HeCpg9rqi2I899NkFeRGwHYiGUYhnHB67h4P/nt4t/0643Pkv
X-Gm-Gg: AeBDies2LIc5iWCx5FcJyMBWi5v9K1zOYAMacFmBOX9HLalTTiPNbVSh88OuddEjAdP
	l+nCcF/kKCibaZImPqZtBAiN680qvGVgVQjkqbULdiRJbScNLmo4kCyNfnN1dR2Q9aBzFduH5WW
	otp5plHTUFmlauCX7aozOCSXHTQchw0PZHMl76oGxQXFV0zkY6rPtLlH1dYBe3/R1V4Zdkm0JTv
	RnrPXzrUjR1BkN5JaDhpioJustBW2YOhHVJfgnb2w4W8pJOnJEC+IzuW4TigHxcimK/6O6jOCZb
	U+0nQxRXfVmepgDbaxox8DV+zEav4EfKfK61gNlDjze4vn4Wj0JlKHUOjmIDgWoMO1C3fq8vSDA
	Jjy5Z70rNX9Ed0RxzdEFPDu9/H27S+9H6PeKkZV4s+16R0f6wT80hU+KJwk+ySw3Ou8c32x7IUp
	Tndy1/IIkdouPf8k9ODB8LA4SEjXBgkCZRevc=
X-Received: by 2002:a05:6a00:3485:b0:82c:e5d0:5249 with SMTP id d2e1a72fcca58-82f0c25abe9mr21497068b3a.8.1776280395057;
        Wed, 15 Apr 2026 12:13:15 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6747541bsm2934574b3a.59.2026.04.15.12.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:13:14 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] fbdev: q40fb: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 03:13:06 +0800
Message-ID: <20260415191306.3837839-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When platform_device_register() fails in q40fb_init(), the embedded
struct device in q40fb_device has already been initialized by
device_initialize(), but the failure path only unregisters the platform
driver and does not drop the device reference for the current platform
device:

  q40fb_init()
    -> platform_device_register(&q40fb_device)
       -> device_initialize(&q40fb_device.dev)
       -> setup_pdev_dma_masks(&q40fb_device)
       -> platform_device_add(&q40fb_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before unregistering the
platform driver.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/video/fbdev/q40fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/q40fb.c b/drivers/video/fbdev/q40fb.c
index 1ff8fa176124..0151a41267b3 100644
--- a/drivers/video/fbdev/q40fb.c
+++ b/drivers/video/fbdev/q40fb.c
@@ -141,8 +141,10 @@ static int __init q40fb_init(void)
 
 	if (!ret) {
 		ret = platform_device_register(&q40fb_device);
-		if (ret)
+		if (ret) {
+			platform_device_put(&q40fb_device);
 			platform_driver_unregister(&q40fb_driver);
+		}
 	}
 	return ret;
 }
-- 
2.43.0


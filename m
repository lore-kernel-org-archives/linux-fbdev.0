Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615133EAFE
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Feb 2026 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120907; cv=none; b=MbAtpM4iLvjjbAQraw5PqrMHGIbUZ3fypY8GRMmpD1gkek6c5Pfz4xHhs6sMLc3QMlzz0xrPw+gzcQGXnjKvdqStDdhTlndEJT4HRxLBjdR/W7OmybEl+dADcjFvb1JbQO6gZkEef8oqcaJZju8YrS4VmUDfgBzFaSolf4R7AI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120907; c=relaxed/simple;
	bh=Z9DoncZRp1hGTgs52zuEEOEhMYNvMiELdJSmhQoVOuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kPwtl/ODJQBcQGh4axXTgYy0M3ScdY6lwO4Sw0ne3NgohNEEWQmzVI2n8Tg9QNZAD2E0ksKbt7qNQRxTI0tvZbEKqb5eEwzZHaYetfxN7FakjzRy0dZ4He+2aLIZEsZfkeYUO2ZdVwuRRRzNpsZw4QPHq8c3BzN4ZpaA7BWU+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO0RFIS8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO0RFIS8"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29efd139227so36922285ad.1
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Feb 2026 04:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770120905; x=1770725705; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LVb3ZndkYPxb0vLCFm6FM7GNTS9TCg3b/+4i6KnRxlE=;
        b=BO0RFIS81KFNnj0npHKFKMz2TnbBCP8FaRFIG+mDZdQFP0AcHBId4+o+lYai4eCS7i
         FFNbMMI3/9QXp68Wxsr/1plwgzEaLPg7kQ7pn2NMx+iu2BiU5998ozshOpZVhWmKAssX
         s7ey3Nim2GS3BYUSOblSaPTBvFd3lsROkClahiKJF1NPibDMn1AUsJQ3wSpUaDr7hcVg
         v2YRCNfRUbIVKWz5V0LHeuHP79fcAgyDqh5Zl/8yR++4bU7V7DCpNGj82xjHm6FjWmWy
         uQPWttOcKU5qB6w09UD6eC9/uNNwsLyzkG3D2kbqEq17kPSRXtKDbY4mDgssoSnWLfma
         gn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770120905; x=1770725705;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVb3ZndkYPxb0vLCFm6FM7GNTS9TCg3b/+4i6KnRxlE=;
        b=puSs7GO90sxg/L2y6jrHv0B6fXZd3BUT5bqFsyfDgz3hQ1DtXlYKysDI42Ntg4X6u6
         nvKWieHjM3U+Jk/0K7cDYxGp/KLwp+nVbLDzlbr470t3J7weCpB9BB0GaU7UbMQj7FPI
         auP2vcrYy65taLjLQjMotTkDEAYULlxpCnJemruK4KV4Njt/3jyLdQcr/FZrLX4F2NXE
         MxKoG/GRQ9Fwyloc+vnCZXkLpPox/b5AbRI4b81sVq3Tf3kNEaz4GuEAZpt3bBZQVvsj
         dOenmwwT+rZEcuh/KJ4NjvkSQcu5WGt9qMuNANd9mqZ65elm/hNKKQkReQM24dZAccVQ
         eGVw==
X-Gm-Message-State: AOJu0YzUYAksXNL9rTPfIzqT9Snc6ktvYlw8EfcEYIrNivKjU+WSDfSo
	lwRCIdi+MvYI5aPR9e1a8/Nc7K5pqDBlXDzPMJ8No7tsVx86qvVW6JsD
X-Gm-Gg: AZuq6aJpDoobjAxFON6+hZIiLi3c4JCPoxZEMwXCBOcercR8tunOKeDjy7EKS++kuOj
	cULniT9aeay9pEly9EaDbKjqTNzgZwMlknpP5OBLBdPhOXaBv0G+6cu23a3bL0kbZZg8Wy2E2Jf
	EdGojLWpr+D1mMbXImZOtrOUQr/7nW5VPARJVrfh+jS/Tr2qnPTvFkG4mQCt6tAQQKdex+bDj4x
	+OnH3lq1NTObFSwNWFIhiGM1E1DpQGstISCni2WXon2P6J3H05/Q4kdGcuSky4mI7coWh6WEoyA
	pN+UAoeynNqYzrukiSXQ+NfyZnlos/mDyp6HddLvADu+gIvnAS/AzMRXRqMHPQKKbIaFwGmUx8R
	7Fc6ZJi8cF82bPKnw1BFWXecdF/U1DfmmaW/hlQfR/xcQNCgHtlssAaVoDi0wA0ni1iamkEb2cp
	pZhznX+y+I5v39aWaaDB1FdvySVg==
X-Received: by 2002:a17:903:2c04:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-2a8d7eaadd2mr149945765ad.12.1770120905361;
        Tue, 03 Feb 2026 04:15:05 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9008:ba52:f091:7dff:927e:f788])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3db4sm183413415ad.50.2026.02.03.04.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:15:05 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 03 Feb 2026 20:14:58 +0800
Subject: [PATCH] fbdev: au1200fb: Fix a memory leak in au1200fb_drv_probe()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-au1200fb-v1-1-7889c4061337@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMHmgWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwNj3cRSQyMDg7QkXXNzMyMTE6OkZLM0AyWg8oKi1LTMCrBR0bG1tQC
 ZhAwuWgAAAA==
X-Change-ID: 20260203-au1200fb-7762442bc6f0
To: Helge Deller <deller@gmx.de>, Zhang Shurong <zhang_shurong@foxmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770120902; l=1120;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=Z9DoncZRp1hGTgs52zuEEOEhMYNvMiELdJSmhQoVOuU=;
 b=STbOjk+2U9pG24k+N3Z0e3r2giORI4ny9g7q6UZRZr1BYvAHqq9qT9OEGEdSXbyMrbpFP9jfH
 +TC2o9HFL5GBnTkn5B1TXGOv1owwlmXHOxLzhZSEXFi4/PCiqhPggma
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In au1200fb_drv_probe(), when platform_get_irq fails(), it directly
returns from the function with an error code, which causes a memory
leak.

Replace it with a goto label to ensure proper cleanup.

Fixes: 4e88761f5f8c ("fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/video/fbdev/au1200fb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index ed770222660b..685e629e7e16 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1724,8 +1724,10 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 
 	/* Now hook interrupt too */
 	irq = platform_get_irq(dev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto failed;
+	}
 
 	ret = request_irq(irq, au1200fb_handle_irq,
 			  IRQF_SHARED, "lcd", (void *)dev);

---
base-commit: 193579fe01389bc21aff0051d13f24e8ea95b47d
change-id: 20260203-au1200fb-7762442bc6f0

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>


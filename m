Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F72FFDFC
	for <linux-fbdev@vger.kernel.org>; Sat, 22 Aug 2026 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787387663; cv=none; b=Ho1Bd68G8XZcaFGYtxfn6iFgUwhacdA5C2hQTj0R9pQ+xwCTJ+6sU8KSEpr9cJEd437b4NM8e1dvfSXFMYzJoMD37tO6qDKApTgvadbOHa7IqJwLeN6Oe/vC86DmRTrKrAFTdcj4LLBXODpe+1y1Sb5qxNXKO6HAvrLQKduLaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787387663; c=relaxed/simple;
	bh=yA3+VoYwcK6KSK/cIn8PJOKv5e27qnifHs5zHsBOJ1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z08ZEADHfqMux14nOfQfOZOi8TpT1/TlA2HjJHrjq1Qy8YaX6vMd2yowDIVh890M+GEJV3uc1/jMffk/Z1M57TMWQeROQuI5JMl+otxRlvrwKp0s1fH+rFwvS9CyVU04mvA17pgtMzclXjCBG/ADq/irgRj9ll3QQ46KdVBWlmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjnmmzTW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjnmmzTW"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d032846c95so22252955ad.1
        for <linux-fbdev@vger.kernel.org>; Sat, 22 Aug 2026 01:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787387662; x=1787992462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P4Ty7m/Oy5sE0aj81AZUZepR8b+A2n+RRtNSKUbvbgk=;
        b=YjnmmzTW8x5LtU4g26JJspyd0ydmqxdZLKEBrsf9zThCIGzb2Slu3Xn05NGgbeRUnq
         me0XUPJtBbbGnzGZD6o8ulNUFabr8v4Uh6G9R3b5/E7sShAXmAUt7cZcuklKEqKC0ovm
         1OcDKEN9IB8ipwR1pMfQXPtM6qgi9xxQPFDc+JPWVQHxfam9bi+GBTT/CU7KUyZwjQSa
         Fs/NaJWJ03f2viIqqKhmznOohdS8V3tR5K0qFd7kCp+iWGfj64J3MTdrZtPbnu0k+DuL
         zXsuiSNo4ZYIuhaKXIb/Ne0h9ZZZWsZe2xG1PzK8AE+pxHG9yb7gUG8XIuf0kajeztC8
         Gl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787387662; x=1787992462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P4Ty7m/Oy5sE0aj81AZUZepR8b+A2n+RRtNSKUbvbgk=;
        b=dPupNDOsGNJ0ySfw8X8OSj3M6Reb8NRiDnTwtFkakdktsOoHyfwaZKq0k9i7424xG7
         2q3sBl6ob/KDNAgzbu3SYPNeU/DT2MfaeS8dkmP3yxtB6RpF/ckaPMU74x2UrJJptx1v
         oxvS5CFa2bPKqICNmScKkG4i/Z1wikXntwE/8A453KUHlEY9HUSGPMcT0ud5hgQxJDt5
         5i3QK+5z2YAh8+F5CSD+rJQXEVAS/hiJWgiebz4w/1XG8loxTCgzNymCAqhy6gvWV3qQ
         7vWGKugbl/3w/ejiBdortyEvrQCl3NCwMxNhuvZfXw9jTq7D8eVNsf9digfqHOFrQjK4
         TtCw==
X-Forwarded-Encrypted: i=1; AHgh+RpUMUPocPUYU0BwRbU+L0+LlA7K/rmr0aiv/VlLvs4L5uYa6QvzjEcE2xHaylgfV8VrSFixCA2XC4oFpQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n+eCLRAk4fjPZ95AA7vLuVEZx8fQabG2O3kWwiJnNVyFp/AnbU
	SgKwybwAIGS6h5su5nUFz6Hpc/bHfZdG+vAl3SdbmryvWdsTUjHmGhg=
X-Gm-Gg: AR+sD13/erXCrBZfZnZl66lPxOCKVR00esdxR9fdL360NzbRJ7x4A4Gto1imRqonx3Z
	Mccho7EspFj4yFOaUr6KYlrkWkx4oW+UAzrT+8V5jyTGIGu1o7zqxbWLbIZJAm1/jJMwlKw94cv
	+EUnICZ7pdJXjehGiBJNPufFTSMf7VuELuVL1mD8Ly/s2KTcsMZ+F7kFly3/ajydfN7eFZkNH0l
	jEarScxV0z/OwluGB1RRV+iy7+xBSxXQFDA8oXo+5YWcAmhVf5MZKE0+QYQreRxVmq267jz+3xH
	kbElZIhGBP0DFp6x2IUvN0rXZaVyEaCAXPG5k9nOgGz4shtyMKKjq5+Dj9aoFUEZBBCLw+DhZ0d
	/YKjrTylcuE6SdO4qbPzlPMZ95V97tbOtcuUCUZIx0zLPwi3xCH1prQ/97ZaBsb2ayC1QAzTO11
	87SPPhqGg1+2f4gShBIKtbjMW7SpDJ/gXEVOa6ONrC/Bd+RAuBrJyE2xXENNaC/B0pxE2sIKAKG
	vXUvdF3YxzHBiYH3EujjZKqiVfCZd/5bNDqXIrO6NUd4yGpZS5ECglJF+xrcX1rMAeZ2Q==
X-Received: by 2002:a17:903:46cc:b0:2c9:b396:1a55 with SMTP id d9443c01a7336-2d64b162098mr245699135ad.12.1787387661938;
        Sat, 22 Aug 2026 01:34:21 -0700 (PDT)
Received: from codespaces-2db70c.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net ([23.97.62.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676788239sm2764105ad.18.2026.08.22.01.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:34:21 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] staging: sm750: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Sat, 22 Aug 2026 08:34:08 +0000
Message-ID: <20260822083408.44764-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the deprecated SIMPLE_DEV_PM_OPS to DEFINE_SIMPLE_DEV_PM_OPS
and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the suspend
and resume callbacks, also reduces kernel size in case CONFIG_PM
or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c..ed6d0a93f0dc 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -394,7 +394,7 @@ static inline unsigned int chan_to_field(unsigned int chan,
 	return chan << bf->offset;
 }
 
-static int __maybe_unused lynxfb_suspend(struct device *dev)
+static int lynxfb_suspend(struct device *dev)
 {
 	struct fb_info *info;
 	struct sm750_dev *sm750_dev;
@@ -415,7 +415,7 @@ static int __maybe_unused lynxfb_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused lynxfb_resume(struct device *dev)
+static int lynxfb_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct fb_info *info;
@@ -1106,14 +1106,14 @@ static const struct pci_device_id smi_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, smi_pci_table);
 
-static SIMPLE_DEV_PM_OPS(lynxfb_pm_ops, lynxfb_suspend, lynxfb_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(lynxfb_pm_ops, lynxfb_suspend, lynxfb_resume);
 
 static struct pci_driver lynxfb_driver = {
 	.name =		"sm750fb",
 	.id_table =	smi_pci_table,
 	.probe =	lynxfb_pci_probe,
 	.remove =	lynxfb_pci_remove,
-	.driver.pm =	&lynxfb_pm_ops,
+	.driver.pm =	pm_sleep_ptr(&lynxfb_pm_ops),
 };
 
 static int __init lynxfb_init(void)
-- 
2.53.0


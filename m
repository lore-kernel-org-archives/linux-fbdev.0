Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45295288C18;
	Wed,  9 Jul 2025 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054856; cv=none; b=daCmpU4DnVENDy5PY+B6ZKu3kkjpzrxmM26ZNZKOVZB07oHRMXCJJ+HRe2zfYXQWgXxIpsryWxS+vbES6amdpLcVcxfFVcI7KqG4rVkUmReqXXl3RGPof6WhF1fW7+yKw/rbOFiVVxxa3a6tlejqAW0kGsXB8TsR2+TLzt/uN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054856; c=relaxed/simple;
	bh=PA6tyXSN3kKOjxeqqbgx4QyiylMI4/pz8chyTNUBIuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3YnP982NwMfX8ZfdnMZ0pOXWTzfwhXDd8sJG/fRuFMGPWbR+AqjGukC9QNFcOEYQ7VARKVGR2n2yjCJLkvYo/QujmYcZBp2rytX9KSZXUL3Vznh7NSLgwzOlooMiZ9mGHXt4ArM7Jcu2ollM+uOSfTpNd3doyaHaXVSgsUiNVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8BF1ofx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8BF1ofx"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acb5ec407b1so931880466b.1;
        Wed, 09 Jul 2025 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752054853; x=1752659653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoN0VUpKGYfuP7sFSFacY57Yy7Y1Fx9KVASbGOfFZP4=;
        b=Y8BF1ofxxKzSy7bh8azDrPqz4lWhtslA+Wuz66JQ60U0l0TPkYFEYejwHGH7koTsKN
         7drjf4INvXdRpVMl6veLDg0MofjFUIR+U9OOvlto0hIV8QpaTp/Kz6fV0FNDHoQaygOj
         hIn1DZZ3zpES2lnKpE7xEw+Z/oSqv4fuOAPRYk9znxPPocWkRd0pewXcEP494iB3Gfl9
         3XVK89GxAXShIQYnaat5RLJkC4G2vPLlYB4QtOcwIlyGySptOWgnDAHCgA84lKnXkg56
         6LXu47J0w5OVrIp2QlXFhD04ghXA6Gyx5lqjdZoQiK1FyqHsGSbtMSgSr4AjXjuJzYLp
         Deog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752054853; x=1752659653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoN0VUpKGYfuP7sFSFacY57Yy7Y1Fx9KVASbGOfFZP4=;
        b=nSy7FZs9FqjOlLhe3KbhEg3AphRdofGEH3wypUFEGxYz06QohsEa/q1TsxbgPAxi9C
         jkvP4XwQbfB5iK6DHFYJQqgbH7vdwbc+KIeCHwv/zISJcdaTEQJj2YedJnN/xiFtgrbh
         w56aDn8uL642xaS64mCVAjnSCJm3NauB5MUN1aSC319uGfuXWeRNwrtSjbd9N4Fw8fRo
         Y4VX4Mn6i2uu+0Jf0EqgBiyAWmPSD1AIj+2EmYN89p/66ZmfIZNDGd6wrTHljoiP/GKg
         BxfvyBIKbHiv0wC+UbLB5BIlcX754OkEvKWT+zw4LA0G9GhqBp07bQ/QBIXqzvrdiGGZ
         h7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWvovzqgNoFi4AI5qnyKQ6x4G9J0FwOEMfuuzv5zAp53s8WfyYeDDit+oBRCDvHGJQYAGNu8qR7xSCxqwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP6MpVr7dofILPHHmVdtNj+wJZySd3OokvnqTaPQYPhNQ2Fjq5
	EBHQEfeIlHRsonbY5pFDIPXG3eToflIWOfbgKayPwwckvCOpydZ+vvOv
X-Gm-Gg: ASbGncuLDeRGFacOi3YVPCVI9sgr8IF3aSvvRjTl0ms1v6hA2rOMo0lcXXKT+QPlAvU
	V/vtBPDVCPvspZHnbs8oZXoPJAg/ObKhpl5Qm374k76anYvsHNftjg5Z8rCIwYWzuWoDbXcf3o8
	+q0a0ipj0AIr61fK2x2S9HKRyrXOcoW8ID6yc43/5dGhrZpiUSuZkzow0J6dGbFsTMs98bzgPBM
	UpjnMysCPI8FUC78Lsrgddu5Gucqd/LRy5GB+XH57MqxgC0iXhh8VgTtqH7paKHoZhg1r+c0ReB
	3UJ3XVIHupsYMRaRsf/N726ifRhk6ddMqfBJEUOymR9yvgu1nYqPdRoZOtLg6+aGCrwjhXG2/rA
	YdukRdFNcjstsr/D9qysg+7EPRvsrv8ObZeFrQNS02+wBWnUKSou/zUduf6hZdg5l5ZVwbA6OYN
	59pg==
X-Google-Smtp-Source: AGHT+IEFFYxIMd7Lz9ID+tmxDQr5/HjZ3P78ChW4+9hdOBxyvQ8l1d4pgIb5QGWP5ddtvPtghS99uQ==
X-Received: by 2002:a17:907:6091:b0:ae0:bee7:ad7c with SMTP id a640c23a62f3a-ae6cf7a9237mr179523766b.46.1752054853338;
        Wed, 09 Jul 2025 02:54:13 -0700 (PDT)
Received: from kubuntu-e14.homenet.telecomitalia.it (host-87-21-242-88.retail.telecomitalia.it. [87.21.242.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6949cb2sm1074172266b.67.2025.07.09.02.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:54:12 -0700 (PDT)
From: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
To: tzimmermann@suse.de,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
Subject: [PATCH v3 2/3] fbdev: kyro: Use devm_ioremap() for mmio registers
Date: Wed,  9 Jul 2025 11:53:53 +0200
Message-ID: <20250709095354.931589-3-giovanni.disanti.lkl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709095354.931589-1-giovanni.disanti.lkl@gmail.com>
References: <20250709095354.931589-1-giovanni.disanti.lkl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the manual ioremap() call for the MMIO registers with the
device-managed devm_ioremap() variant.

This simplifies the driver's resource management by ensuring the memory is
automatically unmapped when the driver detaches from the device.

Signed-off-by: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
---
 drivers/video/fbdev/kyro/fbdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index 86e5d60ed0ff..ddc241f508b1 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -701,13 +701,14 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kyro_fix.mmio_len   = pci_resource_len(pdev, 1);
 
 	currentpar->regbase = deviceInfo.pSTGReg =
-		ioremap(kyro_fix.mmio_start, kyro_fix.mmio_len);
+		devm_ioremap(&pdev->dev, kyro_fix.mmio_start,
+			     kyro_fix.mmio_len);
 	if (!currentpar->regbase)
 		goto out_free_fb;
 
 	info->screen_base = pci_ioremap_wc_bar(pdev, 0);
 	if (!info->screen_base)
-		goto out_unmap_regs;
+		goto out_free_fb;
 
 	if (!nomtrr)
 		currentpar->wc_cookie = arch_phys_wc_add(kyro_fix.smem_start,
@@ -755,8 +756,6 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 out_unmap:
 	iounmap(info->screen_base);
-out_unmap_regs:
-	iounmap(currentpar->regbase);
 out_free_fb:
 	framebuffer_release(info);
 
@@ -779,7 +778,6 @@ static void kyrofb_remove(struct pci_dev *pdev)
 	deviceInfo.ulOverlayOffset = 0;
 
 	iounmap(info->screen_base);
-	iounmap(par->regbase);
 
 	arch_phys_wc_del(par->wc_cookie);
 
-- 
2.43.0


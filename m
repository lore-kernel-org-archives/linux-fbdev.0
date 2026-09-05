Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B035838A
	for <linux-fbdev@vger.kernel.org>; Sat,  5 Sep 2026 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616891; cv=none; b=ieT/3L0V9TOBjyZELFelq60i0RtfHt9MrMH7PJzQbq1hwnvTB48CDiCU/seRePXBTcoH3DbvHQCYuePI5NAk8gup5mS9tyjoOSFBdSxDdCcwXVXNn0EKUIRCbLMXcGbAMI3kD4QdShAP6sdrOVGhwVBdNak+PwATzgbqz9Sh/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616891; c=relaxed/simple;
	bh=6f5p//qeeEhJiLT6hla2lNz47zEGEWS2WmSvXXHcHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POVTHomoqXAInnGkp6mNadMHZygHE/Bf8zAW3DglTEDvrBMt2pXX5cNzD/AGTYwx5xrw3/Q1CJyfFTjCSEF3+yxYB4jwpuwaZuBqahAexdwuzLPMHOda78x4DfhQKcbt01rQ9f0aU/2mmY4ljKMDeCPVn2k3Il9HG4EpM6SmCms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZpV17zU; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZpV17zU"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7542a2ee156so1183751137.0
        for <linux-fbdev@vger.kernel.org>; Sat, 05 Sep 2026 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788616883; x=1789221683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=MZpV17zU6O8ZzOYCM6mSh6Pc5bMWELB+jnQuQi5HQCi6EKwnfgmZ0AEBpaSpAQDW8S
         16IVmCmWPcQCQ7FUoAc2mjdXI6Vun4CESOtgp7TZ/BbzPL1ysQvKYMFBk+jIWWhuCbdj
         gBI6DgINw00GjdIA9p44lmwqHYK57/id3xwbTs5uCy8v4cZNIxLxiIv0AMx2XLjAnH3C
         Ea+l+j6WgNoLX1w28TuRU6e+lpGdTNOmLFjggreQG9OFR3L71bhcUPSJ4VvBiNxuPuvq
         ddKBGzFKZUmonKqMeFOYYTi1Tw6vtCRVa1cj6NAo3DraG3ex8OCKO8Q8YmVB4pM+sOEV
         hYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788616883; x=1789221683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=si4BfsZOMWLG/71u+dXSmSnLmMrzxMt5XLDbEk7yNUTE+ui7Pdw09cI0jS1h8Ih2rL
         EFr0KxNvrumFYR8+hWUfXWofWJYC3Riato6k+WSOIgsGUHcGxpVjqcHhKrynLEyZ3Cra
         6tMX456GVpOi09aBTcoMhFtdjilDG9hlRMFuF3HYL8a+LHr7SJytLWFWblBLwvmmhCth
         RYYI+W75Psm/H7cnPSwdQyCIXJcNCgyJqWmCd2+6pleYhj+pepJdp+YIuuXL5Pbagi4M
         CCX98tO2s35Mh40OYsahrnuMVY2hXdbLN0f10ApCYlDQ8equvtuF/LUWJTL5FgNJpHBx
         U0Tw==
X-Forwarded-Encrypted: i=1; AKwUvBzpD3eEJxmAo5a7/waKMaunIzLvgiPaW+0hOTfFYu8k8Y8bl+Vi5jtmJrdid/kXH4HSfoWiTWAXqoazHw==@vger.kernel.org
X-Gm-Message-State: AFuF++mlBUrZV9fUIgL05bsRkHCcsHQIO8KxuNN5N2ZMxiI1jvcS3A0B
	tWaGOoLuecyLyAhzg9fBvlHnWMhgMjRBTfCwLGj6LOdk5TccuUwq2Wc6
X-Gm-Gg: AYBFou3EBs0Y/eOcspqxKKxWp1LB56GpsCUDZAlQRf98dgAdTmwpn9ColwHyPci2bWi
	oluyfRTT02HDFfjlC25NuMZWdi6td65aJnme1hOAUxF+tJZWY0rDhvm6gGQNQ34K32gCcYwiu6h
	fX2/Fpb7N/MRFOsjSxpZWm8sxRjRESNdtk9Usl+H72axagSOxDXhCad0l7oiaFJVDryvr1cBC1j
	LhgGFW5HP4b4AtUtrUWFoMn//HYjFtzjD0gOGKhKwllMT6M7LdApwTJe6tC/etd3yI4U6YUhiId
	t4UZqkTt4ERZj+Kw4MYz0rwnOL0zbJerhpdh/LHkiqsA7sBONYAgfDkHwvc88ldOJYAy9FKTriw
	kqUuQk/TGGE7EBEsghgA/SErTElx/p22rwCK8HvgPkyz5JyHxgtIlpsVPgjHaEugkwTRUIO7LT4
	/MynohBaHdYxbbmLhHt+sVvADJZvLN0gUyJEWOC3j/SuJNX6/ETsQxAj6QbOW4CWOJAmjBToP2Y
	DKWUTf+DE8Hv+1yRuFw2wAJAr8XGPS9
X-Received: by 2002:a05:6102:1484:b0:785:1d9c:633c with SMTP id ada2fe7eead31-78a4a8436b7mr5213627137.7.1788616882765;
        Sat, 05 Sep 2026 07:01:22 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee4d743sm3706877241.9.2026.09.05.07.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:01:20 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v11 1/3] interconnect: mediatek: fix Makefile typo for mt8196
Date: Sat,  5 Sep 2026 11:01:11 -0300
Message-ID: <20260905140113.21638-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a copy-paste typo in the MediaTek interconnect Makefile that
mapped mt8196.o to CONFIG_INTERCONNECT_MTK_MT8195 instead of MT8196.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/interconnect/mediatek/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
index 6bd656668..64170ab16 100644
--- a/drivers/interconnect/mediatek/Makefile
+++ b/drivers/interconnect/mediatek/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_INTERCONNECT_MTK_DVFSRC_EMI) += icc-emi.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8183) += mt8183.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8195.o
-obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8196.o
+obj-$(CONFIG_INTERCONNECT_MTK_MT8196) += mt8196.o
-- 
2.43.0


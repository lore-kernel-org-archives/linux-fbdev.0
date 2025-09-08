Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA901EB1AA;
	Mon,  8 Sep 2025 05:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757308968; cv=none; b=IblUY3mMJXZE+L+cTVyN/S29MW3RiBNrp0CUGpYzMSI+wsO+jqIif3CS5j0pM+7TPURDeTl1SwIPZ+PcFqX2quct2rLhlAB4TIDI9DqbQwrMhF4o/EJuuba3Tt6a5ISFPRZbFBiJAYvjoUaMe4h3yKzOuBtOSFEN6w274BH9hDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757308968; c=relaxed/simple;
	bh=Q8fpKLoaCLJRBLF0hQCnVeq7R37c/PR9mcxFpHuubWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pnU65u4pKY+9WOz0UYynJ2aFy6g6migVTHASFGUN71+b3iaT2WclJEa9tcS2ck/QddAYEU4aHiM0mVxCijqox6mlk+ZbCqDTbQuMZrxUN2UmaxNrA5f20BylRcrlkLgY66tJLuql+/oiJKgyCbE1fNjy9ChbgKjLFbthz+oHcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMd8jLgG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMd8jLgG"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77269d19280so3486340b3a.3;
        Sun, 07 Sep 2025 22:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757308967; x=1757913767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6em99myf6OEai2igjeP0O8GalT30GBXa7U7AblBA4yY=;
        b=PMd8jLgGpCqFA7L+4pw1cIzB8p4WrLpdPDfBtkPIj9CsdHqV5JHXssVBCjPJdcQDle
         SDAZjBU+f2gZXTfAVcIWXz8HZPA1TZIDPad2O5m5bkPJKqmn1oSUFbKUvXaFLziNxsG5
         LlNLh4Gr/ZzFhDjnIHLJQJbPLOArIwtxdmDKIHgRohGCsgkxFc1RojF0YhvWhv5snjkP
         r/o41avLu9vLXt9GJxuhkHBibFt7bAhy65ISTIWYR3C+qpGV1ZdSMXzOrOjV7zkEwvVX
         K32biM3yO/JFImWswDCupxqTbZ6K60vp+L38z7MiWlIR7hnfL89EbUZkQtJxCjDX9Vpc
         MOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757308967; x=1757913767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6em99myf6OEai2igjeP0O8GalT30GBXa7U7AblBA4yY=;
        b=RkpaxZFaz0G2AZl8s5gDXweAZO52tNw9hC6BTU08enStq7vcVTtkPZkF5bL/dvmg8h
         mfxBqnDTZUDeELWEbt7nzTWOvSaywD+kkadOK7ZFDCfiK3P86i2hrwjmsps09GzQdvu5
         f6s1MVxFzDJ0OfPUEnIDrJhdYReqUjXyopTIuOpA9I4vYbxCC6uBidi8ptU5J32Wd5HA
         BxswFTkbybbCh7atOkvVnPKYRBeYsFXx5zR81DOuUj6ufzOM+FoWI1NrMQ3j/3cLKFV1
         R2Hx61IGBE0WEO8c4CmQeKxfRIB4d2CHmpIPLwxCtjQmThzCUS9uFbW5z+N/S4W57Fab
         M4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvKsLWbWIQjcpKft4OcvUoP65Qlt96PV4uIQMdQS0eNy4uxNuBGE/QHLDJmdfC33jAwNmHBF9d+HAZW2nn@vger.kernel.org, AJvYcCWgYsgCVt7zpqXV13e7bneB6n//926JdFBsFMJ+hjIyUQOGM3qidlutXRPGjpIJZVfx54MZpPf4KrCWtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCz8/LWBoFGCeMm3VebrvAHIT5Icm2EYq3svXD39+/WZLP8E3R
	jDQn//zeXWRjlslwYi571Fsgbw8uiz2Nur/aQJIDk+t0ulpHu8Ttl5pWorU3ZppbFTM=
X-Gm-Gg: ASbGncs9vyR1A4W0HP0dRauMmZjHMy8wnsP8HrD8qDyV3Lep59DjPVuNbjgI83bCzbO
	YdnfSN1mr2pTsZHr9m7z9OEFt1PhD7jznp/JodgHCxdQg9RA09BaHzOSQpev2vvlvRbnFBWMf/y
	7bVz9b/TIlTyHuvEj5koAlbIW+u7PjRs8sunRJMCDvSkSBal/diRgOME43+CsK9QK+cd6TS6nE1
	Kj6EMYOxHrMoMl2WTFBRp4BRBfVAbeR2epmKYSQjPkbbGtmmFD0TY3+V4F9yAm214ZDApsnEYIj
	9IOAsgK+XKUPytP1YL+ApilK73hqR5378c9hd4nc9vKOFfwvbO7GcyKUKLkj/M/mBzG+TXU5hI0
	8W3cLPbFLvvL7KMyizAHgKl44NDo2T3xaCUVTwh8YhW4nHosKo20sfqUMQyXnf0nYHH8lvz2DMf
	RJwFO/FyqUTMnh
X-Google-Smtp-Source: AGHT+IFrTsmPSdUiPcaM2RVIukPGO/87uamBKynsgb9AJLgE624HPMFK/q1miJkzcxQACG9phsofkg==
X-Received: by 2002:a05:6a00:2d83:b0:771:ec42:1c1e with SMTP id d2e1a72fcca58-7742ddeddb5mr7074610b3a.16.1757308966588;
        Sun, 07 Sep 2025 22:22:46 -0700 (PDT)
Received: from klmny09 (n058152022194.netvigator.com. [58.152.22.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e27d1sm28076608b3a.81.2025.09.07.22.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:22:46 -0700 (PDT)
From: Yiming Qian <qianym1996@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yiming Qian <qianym1996@gmail.com>
Subject: [PATCH] staging: sm750fb: fix coding style issues in sm750.h
Date: Mon,  8 Sep 2025 13:21:33 +0800
Message-ID: <20250908052133.8888-1-qianym1996@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses several coding style warnings
reported by checkpatch.pl:

1. Replaces CamelCase variable names with snake_case:
   - dprBase -> dpr_base
   - dpPortBase -> dp_port_base

2. Removes unnecessary use of 'volatile' qualifier
   from the lynx_share_struct members.

These changes improve code readability and maintain
consistency with the kernel coding style guidelines.
No functional changes are introduced.

Signed-off-by: Yiming Qian <qianym1996@gmail.com>
---
 drivers/staging/sm750fb/sm750.h       | 6 +++---
 drivers/staging/sm750fb/sm750_accel.c | 7 +++----
 drivers/staging/sm750fb/sm750_hw.c    | 4 ++--
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d7f40efe3..fcb7d586e 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -50,9 +50,9 @@ struct init_status {
 
 struct lynx_accel {
 	/* base virtual address of DPR registers */
-	volatile unsigned char __iomem *dprBase;
+	unsigned char __iomem *dpr_base;
 	/* base virtual address of de data port */
-	volatile unsigned char __iomem *dpPortBase;
+	unsigned char __iomem *dp_port_base;
 
 	/* function pointers */
 	void (*de_init)(struct lynx_accel *accel);
@@ -128,7 +128,7 @@ struct lynx_cursor {
 	char __iomem *vstart;
 	int offset;
 	/* mmio addr of hw cursor */
-	volatile char __iomem *mmio;
+	char __iomem *mmio;
 };
 
 struct lynxfb_crtc {
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 44b9e3fe3..6bee37bf5 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -19,17 +19,17 @@
 #include "sm750_accel.h"
 static inline void write_dpr(struct lynx_accel *accel, int offset, u32 regValue)
 {
-	writel(regValue, accel->dprBase + offset);
+	writel(regValue, accel->dpr_base + offset);
 }
 
 static inline u32 read_dpr(struct lynx_accel *accel, int offset)
 {
-	return readl(accel->dprBase + offset);
+	return readl(accel->dpr_base + offset);
 }
 
 static inline void write_dpPort(struct lynx_accel *accel, u32 data)
 {
-	writel(data, accel->dpPortBase);
+	writel(data, accel->dp_port_base);
 }
 
 void sm750_hw_de_init(struct lynx_accel *accel)
@@ -410,4 +410,3 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 
 	return 0;
 }
-
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 7119b67ef..ce46f240c 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -58,8 +58,8 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 	pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
 
-	sm750_dev->accel.dprBase = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dpPortBase = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
 
 	mmio750 = sm750_dev->pvReg;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
-- 
2.51.0


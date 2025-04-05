Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A101EFFB5;
	Sat,  5 Apr 2025 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743858230; cv=none; b=J6Nv2i9PZxZISViBTx8zlXTHDS28F+alaxt4mXFXarEk4Z9TIDsd/qdvigahoRW4PnmBDy3Y5XTRFYGMbpFViI3L1sBftzuW5fBbhxysPwZvzA9bpLIchrt0ILvuFVQKfFlUZZObdpN93DVgXRLNTqV3PDb69ukkORn7AmQz528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743858230; c=relaxed/simple;
	bh=gcvZnMhtR0XkyTMXHmFjgItkzTjcKo4d+SyWoFfroaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GAa1n07LKuySaaSqv+GKKCqKCGIOke/B93vcCBHQBIsVxlXHO0eVnN+DNQ90HNYFYVNZbVWo6Udrw97xlZfG1F1sJkwyiENdulbpXShYGWXHFpzdgG1gvuXcmxBZP1ERY9yt7ntsuWpqRj6wEJKureftWgGgMTBR3o58JA1BGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKOVCZ1h; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKOVCZ1h"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso2481168f8f.1;
        Sat, 05 Apr 2025 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743858227; x=1744463027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZIIlDBSj3POSZxjDzaSA5f1J19DQOtsWmRISrShn7M=;
        b=YKOVCZ1hb4Z7EcTH6GZiLYRPFan4GxyzxEFF0vjPOVDmdXNq7Ry2XxczKFiPfDtWQ8
         2QqU2ofFOT3isvXwbS0MkAfFLS2srgsfYtluJVZ8hy728kEV4BSgFwggBP5klKGCSkkS
         RSpCK5VDHpuXS9eY2DQQ7CPh9fsckDdVXUag47lYsvtUJsHSkzVBy6nmVtlKefSwW+er
         l0Mt5Bk7olHOGDKAHdN5LB+xzxqQjuSImcvTmMk+QHjz4p6FjfaPWA4izEWmzPm+t898
         rHzP1bSunQdsOuwrARdTlyU5TDB3onig8BwqdmhpVCWknRWApg3LiX50rZXyuTNfglBM
         1VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743858227; x=1744463027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZIIlDBSj3POSZxjDzaSA5f1J19DQOtsWmRISrShn7M=;
        b=F0zwrGg1KDShx+Uh4nPyqJcNVzBbPLSlQvSaZYtza8uu1Csn8iE/ft75cDk9F/oa0c
         N3csLXJesBdRoDzMPZszzDmcMmHyI9KdAjEG0FHZQN0kHGFxuqN8ZMFPgEoC5mciysnL
         1aO2nEu45tf+FBv+0ANc+c3J5XqP6cSPlzCMT2jOdWxB7A93XkL5nUkS/w02YEGFXUXo
         /pMpKkgVodYBU4KexOhoIPxuHzmeWTZwZk6rxDXc6VbjlNk16lvKMq1SG5JXh2ZXHK5i
         uTbrcnKyI5LU20A6qBNNeCodefxlB+PZ7m53AoR9aSrvwTSZ81CMY36DanIi/C650gk3
         gUww==
X-Forwarded-Encrypted: i=1; AJvYcCU1T8xLRre6o5EP99a0lUrrUCMRKs0sroP8CABiJveyNgnnwyOBhxqiDX2vkACZK+LK8e0yI4RZuA7DPZ8P@vger.kernel.org, AJvYcCVHRSPXwg+xCjQSuIw2g2PrvJNJh60qtp0LTPRUijNkQ8MKSxHwEhl25W5v10iZV8OfsC8jCczLT/Xpzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWKKZrajc66WP+ohHA5Y5ingBODqFI+5+o+OQRimmA0lybI9X
	0o8TfJHM+VdCS5q8vtbwnoaEct//ZxXZZEfnciqTBvqAzgT0PIki
X-Gm-Gg: ASbGncsqWEA0Gtqrmstc7eB02f7mGIjhVU+QKHUUuLvs2yElNQ0bmOc0EtVLoWStcd/
	W0A47MXj1nNU12VpWxyJqrnQey2HdX6LWTdEFqq9L+DpNqxAVc7uIjwzLSNW3/vsKz/kmkRN63M
	4HXYBMq1Y0R3fFxptQ2PznAsQ/SYAI/LBU7S4/pXs2ix1Z1DfmsloUhLI2WhwoWKOPNzlaEURVf
	npx6Jax00/yIkAeEsTs0YJb8p9qlDUhva7gfaIKbGXQQz0QLnfAK0u0rRaLb4sZE40QdEm5qNOl
	1eaq5+UE29JMI52Ero5fu/Z14Q==
X-Google-Smtp-Source: AGHT+IGjYIqX2gJsmdrsMxTZ/QsNit5EW1azXy6aw0u6NIGAnqxr/B3pJ6+P7OW06m9+2yvVvJWXbg==
X-Received: by 2002:a5d:5f4b:0:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-39cb35aeb5amr6349321f8f.8.1743858226575;
        Sat, 05 Apr 2025 06:03:46 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d661sm7039310f8f.66.2025.04.05.06.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 06:03:46 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH 2/8] staging: sm750fb: change sii164ResetChip to snake_case
Date: Sat,  5 Apr 2025 14:00:53 +0100
Message-Id: <0974eb17fa67b707e8d2972668da4d8a692a9702.1743857160.git.princerichard17a@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1743857160.git.princerichard17a@gmail.com>
References: <cover.1743857160.git.princerichard17a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change camelCase function name sii164ResetChip to sii164_reset_chip
to conform to kernel code styles as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164ResetChip>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 3fb14eff2de1..6dee95e60a6e 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -18,7 +18,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.get_vendor_id = sii164_get_vendor_id,
 		.get_device_id = sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
-		.reset_chip = sii164ResetChip,
+		.reset_chip = sii164_reset_chip,
 		.get_chip_string = sii164GetChipString,
 		.set_power = sii164SetPower,
 		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 223c181dc649..284c32f7e9b4 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -250,10 +250,10 @@ long sii164_init_chip(unsigned char edge_select,
 #ifdef SII164_FULL_FUNCTIONS
 
 /*
- *  sii164ResetChip
+ *  sii164_reset_chip
  *      This function resets the DVI Controller Chip.
  */
-void sii164ResetChip(void)
+void sii164_reset_chip(void)
 {
 	/* Power down */
 	sii164SetPower(0);
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index a76091f6622b..7a71f94a1e9b 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -31,7 +31,7 @@ unsigned short sii164_get_vendor_id(void);
 unsigned short sii164_get_device_id(void);
 
 #ifdef SII164_FULL_FUNCTIONS
-void sii164ResetChip(void);
+void sii164_reset_chip(void);
 char *sii164GetChipString(void);
 void sii164SetPower(unsigned char powerUp);
 void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
-- 
2.39.5


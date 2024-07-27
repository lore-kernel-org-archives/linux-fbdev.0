Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94583CF65;
	Sat, 27 Jul 2024 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722072701; cv=none; b=MOP+XQrolYLJLJGRDFN+dco9o3VicbwyYFlHlhvcfFd9lPJyp7Nq2yhqltUo+dbNdkg0k4XfdAp57zqOV+UsaBm7y6t4f+r9nWDnE5eSFafay7iAXqdIckNngOrI0Kb5STLDfl5dcD81X6B7n0H/Y51M5oeUM9epsG+OAqa8fnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722072701; c=relaxed/simple;
	bh=/qFW5Ca5kgqHBPu15m59/5gnXX3T+j5zWhdd3LNCfmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XbMh/avU6Wnx+3AlHBnJmSmUSnc68QqSbW/yUmCxxN/NxOmkHIORVewwyS4TbbP2E6I9jAvoWx6IPXHPU34MyrNLye7lbqtTPBp36wEz/6g/KCVkGoE7PAwkJSJu+QuQR9tbSwo4lRM9vNO8ZfughJITKD6TLbUVLY3Fp85pte0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2XsBDDV; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2XsBDDV"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70eaf5874ddso1450472b3a.3;
        Sat, 27 Jul 2024 02:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722072699; x=1722677499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ6xbkKisMWheOb5DEgUNo89JS6VKyra5I1hoBscMO0=;
        b=C2XsBDDV21B0f7CUkruuMzO57DAeSvZuWKcsCnCn4UasbzJTfxweGkT6IJj1tHthZe
         UYXQm0b3H8Hro/px0ouq8U4Uxum7p2X/PSjcdsXI7LWamhl13ACvz5CM9iGItqMeq1YW
         juDTlKKS6OimW1HXfDk8PcSR8ZrDq1ngdo2pX7DoxKw/V8KQSOtR9Pb0wkkl6nBi9u+X
         MJYFMBA1L3qxuXLvzKv3ZWUMaiDwcmwlPYCAIcLUk8DC83ZsgqOXifOVVZoqrMfOaHTB
         m6PgO0IdYgvAeM6NXwMfghYlqIeMO4uMXtoMH0EQDBFbAQy2N34Cl1KuPVP/V4jlh27P
         vcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722072699; x=1722677499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZ6xbkKisMWheOb5DEgUNo89JS6VKyra5I1hoBscMO0=;
        b=rk9sKCRBvY43qtoB1927vUWt84wiHzDpH/m4sELpeHiro4ntOuaU64rxO8iulWuYK7
         1U2APdkIe5d+M4kMI7zhc3OVDKejcZDFkkl4XksF7xBHm+tXziixulH9469qNTt3yhtC
         byZcx3HP+SoTLsxDLWS/FPoN+SF2WGFHmsI8PDoak47GfBaVr574d8MPu2ioZMgV5iKZ
         72tBF/WLxfGJb3MJVE0tMJlibngtwFWvsQ6/xE9DD0tz4VWmwftcBhvYMY7M59mnCBix
         dIHRjSlzxGT8w/DREx4tcJL86627s6lHNo5hHfjW957Ia2wcT18bvZjPUQE4twuuleV/
         BK+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUapREsRouVUbm8Jq86vcl/purYQw1lm69Gysn6prLmu7KolxiHkjPs89kcSpOqGhRUyR0gjoLsEpZ1LWkThijy2aZjVBx/2sIXRlKZ2R0IhJFKiY6sUYXRXTqI7fmKGZ+9WXzjLIS4V30=
X-Gm-Message-State: AOJu0YwqjlWrW2RK+qjDNFzjcwi+tp1g7E/ju3mwEFbftcHzg/SP/JiG
	oek4fj2cqawFztnTQqhCrX0ufaLSYugkteZwZzZhKnWsTo1ZCsco
X-Google-Smtp-Source: AGHT+IGl8+M8s7vYPYnrmY+kyvUAZGBLMAvnuu5Uxvsd7sa9rLn8732cnUOfBx8BnCpGmzJ47DNlxA==
X-Received: by 2002:a05:6a00:138e:b0:70d:37f4:2c73 with SMTP id d2e1a72fcca58-70ecea13e6amr2223477b3a.10.1722072698999;
        Sat, 27 Jul 2024 02:31:38 -0700 (PDT)
Received: from Riyan.inspiron ([122.176.193.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a2bebsm3880245b3a.212.2024.07.27.02.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 02:31:38 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] staging: fbtft: Fix mutex and spinlock without comment warning
Date: Sat, 27 Jul 2024 15:01:06 +0530
Message-Id: <20240727093106.11214-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style

Reported by checkpatch:

CHECK: spinlock_t definition without comment
CHECK: mutex definition without comment

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index f86ed9d470b8..3e00a26a29d5 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -202,6 +202,7 @@ struct fbtft_par {
 	u8 *buf;
 	u8 startbyte;
 	struct fbtft_ops fbtftops;
+	/* Spinlock to ensure thread-safe access to dirty_lines_start and dirty_lines_end */
 	spinlock_t dirty_lock;
 	unsigned int dirty_lines_start;
 	unsigned int dirty_lines_end;
@@ -218,6 +219,7 @@ struct fbtft_par {
 	} gpio;
 	const s16 *init_sequence;
 	struct {
+		/* Mutex to synchronize access to gamma curve locking */
 		struct mutex lock;
 		u32 *curves;
 		int num_values;
-- 
2.39.2


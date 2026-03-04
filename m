Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687913BFE36
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645738; cv=none; b=K50LdZXeBb1EM0Abcc93TSXfBiPJE0m+NcUUBJLN5htYv9ojy3YZ2ASd1ZyYWCarNj9Iy6Y5fM5iFIZMwbHnEP8CMB80LED+MqpWqN4JNXeCa6Osq34Zq4Ntp4QnMEKNSQTxmUFvYHwsueBRRuPrm22edK9MowpipDVF7fj+jEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645738; c=relaxed/simple;
	bh=/mgLq6MyipgAXakM35FmxxzZYKnWCLgWV+pnzFPnrtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GcB9z6mo9dzK4q3sjtqqGpTFxKsskbiTIghSx0PsO6qBDa8jALvwJt5DE47QEXpXb8+l5QpSASZIVklxkrLG/TvseB4DIRIYhHgQq6ieBDo3XXjkTeCYXe5Fcjvx1q5RcSxHB0mbcUDOp+Jsx+uPvskNoxPvVTcsdijQjRtRA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8/ty/D7; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8/ty/D7"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2aae4d2d215so16624075ad.2
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 09:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772645737; x=1773250537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtmuCRd6e+N3D2PnsalDY4juU7geywSEbJtG8JH60jw=;
        b=B8/ty/D7cSHorQLerRrjs4I8CVa2x6QbCyzrVhjusibL9ndnf870WTGpOaU6t8m8NC
         PlByazysssAh/xytEIPJ9+5LqopExZ7f5WBPCq9aRkVP35N1egs29G1UIS6jPOTyjnA2
         I311HNmasXzWmykuNXb4U/mpmrAFp8hROsRosERqpBVtmp+mzO0khpQsJfSoKAf2lHM6
         guaw0Ls9GJh0lDXf7JFTaCoRZ4aZ1NnYeB1fdVre3uUkSf62BO5JH/VPnkAnVxFM6YJh
         7dlHusMLYLkILLGR+aUDokWWpiZ0bvLFeBhU4iZ8doX2SpMupLPePbK9gn4J3MgG/sw/
         mdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772645737; x=1773250537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtmuCRd6e+N3D2PnsalDY4juU7geywSEbJtG8JH60jw=;
        b=SHfd/6fZgSlimvMrgpKkZrQYwOUOaWHCCvbJPromsphLktmT5x2OHpy/eeAmCFKahC
         0/WbcbsRHRqIKgNFjVRrqSqSrnPHqfU76HPFJOtbhDTem7UJrbo4erR2KL4zAsZIHlG+
         8dwoBt2ZKG8zc2mzzRqw6y/1ggzwl61G7otNxwEsGqO8QcKEuVxr4T35r/ik2hqfEj/i
         ypiQX9Al+dOYPFExPXeF75Fx18RsHHmsrOJqOTYevvFL8V9YiuT4NwN/BimrQRm27D94
         wmcgh9GNk/Xi11PPIBuyJ7NaycLZGmvM5ZaW2LwtLhz07YRx1sKI//GX6F65387GToZT
         UWfw==
X-Forwarded-Encrypted: i=1; AJvYcCUdbneYxH4u7K608ZX/WqpnQ5n3bV5ktSU9KGicvmy6nE/vloYoHIak+ppdxhE8+RxfxEY02r59eQHHLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcDXzWMPZCJrOOA6fY/A3CGigk31yKz0gxQ7HPcgR+vl3YO5QV
	0d/qhmB7jHWbE3qjl4GwPDtZsHCuceNrQRm4TqPeFntftrRWpa/MnNdF
X-Gm-Gg: ATEYQzwyir4n6RgPLCBEikgKgXnGziYBk/XMZU71TdNq+0MSmc0Q5BRRp6Jp0h8n5J3
	T07q8arqOTwbV6ZLmfTfTNcI/huCB8VsTXM7k7GG4PHHHzErj4FH3tiYZyAUnFe+8xITR24Kafl
	tQpYgQNtpYEhGTTsnH6tdPOVDRe0TCBnSpemCQ/sqcDqy9i1Y23C42mvbl6SixLfZcH6tSvoOa8
	eN8k/bBphGvmqgRXEaQmz2V/9YEKy7hPv42dPIIvhzURcbAAIu915Q1FOolMnu3yuAIJIfpY5MD
	3NGcKo6cr61sfgI8loSUuInbnWhYNuLfVFGIZLbZRz1+28+dNy2p/wdSXPoYQIZVeDZcL1WUYWm
	O7t7hH8dp3sngWvFNCsdk1OyzjtvTOEKcEnN+Kj4I3kFYnIpRxF3R3HffdwQKE/6TOHqIiFVEUb
	1HU6mwqSavM8zEEJTv8TKjXuvAhatDy8KEzbH6IloLutw35J+UmtBJZTF8Yjg/QTIFCQpwQqr+Z
	dDxNTrLj6iiSbk=
X-Received: by 2002:a17:902:e746:b0:2ae:6364:e6ef with SMTP id d9443c01a7336-2ae6a9da3c6mr22605315ad.1.1772645736597;
        Wed, 04 Mar 2026 09:35:36 -0800 (PST)
Received: from cute.. ([2405:201:31:d01f:950d:ab7d:5e5c:5244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4bbdec99sm136901955ad.64.2026.03.04.09.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:35:36 -0800 (PST)
From: Soham Kute <officialsohamkute@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	Soham Kute <officialsohamkute@gmail.com>
Subject: [PATCH 1/6] staging: sm750fb: hw_sm750le_de_wait: return -ETIMEDOUT on timeout
Date: Wed,  4 Mar 2026 23:05:24 +0530
Message-Id: <20260304173529.192067-1-officialsohamkute@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aaVT1mSeKrSSlrha@stanley.mountain>
References: <aaVT1mSeKrSSlrha@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return -ETIMEDOUT instead of -1 when the DE engine poll loop
times out. The callers check for non-zero return value and
propagate the error code back to their callers.

Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index ce46f240cbaf..e4b6b254335e 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -518,7 +518,7 @@ int hw_sm750le_de_wait(void)
 			return 0;
 	}
 	/* timeout error */
-	return -1;
+	return -ETIMEDOUT;
 }
 
 int hw_sm750_de_wait(void)
@@ -536,7 +536,7 @@ int hw_sm750_de_wait(void)
 			return 0;
 	}
 	/* timeout error */
-	return -1;
+	return -ETIMEDOUT;
 }
 
 int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
-- 
2.34.1


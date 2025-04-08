Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A426B2D1;
	Tue,  8 Apr 2025 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107679; cv=none; b=cinOi5CCWpbkuIICQXzLNDPEJEaabJxfzGifRMWneMBci5Ch7Aguimb1ucaRZC67jkM3sX/NL4hTG2rViZ/zKuSuGkFWywt9S9v5ekmN9lBMLPSXpmo9yxxoJY4fv4x/Swpn+O1pIRfWY9chWWgBxnMG7eXHYS6KNiH+yTTh4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107679; c=relaxed/simple;
	bh=u6zEX+t1aVIDzy0JiAoJ7d4d/Fs9Xyppen8tPxxJuLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+dkfJm/z/UITKqjsKdJVfLrgyFoQZkUwukWXg1VLh7bexOoZX3e4A/mCmOBRjjwuIlgX/0hzWuAk+8Zbyrgc71p3GznJywGAv9L5/5OaX0KQX5EXsr31ZvIXncYJbL0bkWbliBPjWLEqmGxinBhe3W7wJG1Ow9tuZJKFbL2WB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JV1Era81; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV1Era81"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfe574976so36974945e9.1;
        Tue, 08 Apr 2025 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744107676; x=1744712476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvS5tdlccUpYMdewqVDUL2P1AZVRPsP3RNJi07oU4SQ=;
        b=JV1Era8141Jyr/eGbsoNzfLum3/9HlFAsdhyRSFKUrm/6Ny4sP8xGq6nCDj1sSqtf3
         tvZjotqcncKUCFZVTKuMONkkgqj1ZcoVee8xGKbn3f/U8EzYIqFwKe6J+lelVYwjQvRd
         eNZRKd6urxhUjmuCdCscgEayd8kxFBfEIbONR+sdh+TQNMXqkasxFsyLcfdu1RtQztwy
         dqrocfyZdj4muLcex4+AeOJ4WqDyTOm38EfO0K53eQJl7i7B2cYVT3zALxT/GtLHR0Om
         7bMu+F3lJ3Dzd6Lc1ONcTczutyzGmMY1xVI1QLVcBVVYAZIlUBWtEqAK0Q3QYIIaIjf6
         snnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107676; x=1744712476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvS5tdlccUpYMdewqVDUL2P1AZVRPsP3RNJi07oU4SQ=;
        b=ZLwa0BgxrG1de3qPEAPEInE/uKDkGT5ihkFPX+fVoRzgdzWkfwUmVdG8oZhapZq6VK
         nCDQgjd8b3Rt/k86sfwwIZx2HhzhAD6VRtVgXpkIuP9Imbl+TOJrcA3hlUS0lY8+3QtB
         iYq5rxliom6c8226fEwcsGYBLAwyrQgaGZkwaRNq60B0hnGlya4B5J17rcROlc4L5THI
         szWarm7Sa1eq5SNYyeYloMFAu2Oi70CYB6Kr7pdRwU2Dwy2SKJBiIxKWuAoK/heJeqRP
         BwELcVNowt5aEh6f5QAeCKpy/VJe+A+Omz4cDUDihL47IdSzqZreNixj5SXHo9A1Dgku
         IHJw==
X-Forwarded-Encrypted: i=1; AJvYcCUq/68XV58yv7kOnCAU+UpQMR5gD3hluerRdLM7/zfexEOdcgAdhkryEAIBlV0Jc7i6Zm9veN4HqHKaaA==@vger.kernel.org, AJvYcCXC1FUjS9+lLzyaE8IBmI00Su3aA6WT34uejcQgyaQpDWyh26gN481mSABYKAB9eEJawj6ISG7IDE33hZU7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrv+1G7xEl4qoTKtoC15AUQIYUOuKXFoo4UTPvB/dVsDAyAVyI
	V4UpH3UxBerCPeOPSX3sV4Kwfqo17+49HdRAEFj4tXX92mGXLr91
X-Gm-Gg: ASbGnctZcdxl1lhLAfgWqIpSOe9Rda24sfjzfk7JxfCRLBAp+UN0+eoJ/gpfeVxrPI+
	ghSelsIp7MwysTavyk0tREjOvdkOmRKq2aQUKBsaJ8BHUUn/7018SGuXgzhsq4Mbv9ajwK+FxQ1
	MnBHiCIgpzTC5sYO9nMx0nY3W4VpiT3FWXOCP6Hq4Tt4WtMMwvisL9P1Yw5rWMN1uZ26w8kYswE
	N1Imr9V/ZcMSY7IIFH7merP/ToX16PHSmGGiqnMY06xx98rPQYSuml28OzJQMr643ijUmWcLc5Z
	4OSoaSz7TEV6nOSas+COR4nS06k=
X-Google-Smtp-Source: AGHT+IHTQ7zdy21IjggxB65+WUeE2WffLJ03VXeHe93ycTaduBaTH+0V/SULfFmqu1/Ro1Mn7ZBtWA==
X-Received: by 2002:a05:600c:4ca7:b0:43c:e8ba:e166 with SMTP id 5b1f17b1804b1-43edd3bd698mr70802975e9.22.1744107676131;
        Tue, 08 Apr 2025 03:21:16 -0700 (PDT)
Received: from parrot ([105.113.112.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec364c959sm155838995e9.25.2025.04.08.03.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:21:15 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH v2 8/8] staging: sm750fb: change sii164ClearInterrupt to snake_case
Date: Tue,  8 Apr 2025 11:20:40 +0100
Message-Id: <549b645b265edcb793458a534427f75f0ea343c4.1744105389.git.princerichard17a@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1744105388.git.princerichard17a@gmail.com>
References: <cover.1744105388.git.princerichard17a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change camelCase function name sii164ClearInterrupt to
sii164_clear_interrupt in order to conform to kernel code styles
as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164ClearInterrupt>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 1def02be4cce..6fef1ab484c1 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -24,7 +24,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
 		.is_connected = sii164_is_connected,
 		.check_interrupt = sii164_check_interrupt,
-		.clear_interrupt = sii164ClearInterrupt,
+		.clear_interrupt = sii164_clear_interrupt,
 #endif
 	},
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index aebde3d8b903..fc725a9952d4 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -390,10 +390,10 @@ unsigned char sii164_check_interrupt(void)
 }
 
 /*
- *  sii164ClearInterrupt
+ *  sii164_clear_interrupt
  *      Clear the hot plug interrupt.
  */
-void sii164ClearInterrupt(void)
+void sii164_clear_interrupt(void)
 {
 	unsigned char detectReg;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index aa3f34c13979..ebc173658f0e 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -37,7 +37,7 @@ void sii164_set_power(unsigned char powerUp);
 void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug);
 unsigned char sii164_is_connected(void);
 unsigned char sii164_check_interrupt(void);
-void sii164ClearInterrupt(void);
+void sii164_clear_interrupt(void);
 #endif
 /*
  * below register definition is used for
-- 
2.39.5


Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621638229C
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613978; cv=none; b=hfervm86cOhGTYESz0CjyVx70znpZ6DHQlv/iNd1ywK90eHvz/etI2ROyUUNs+JDUwWIM+GPJtpfFmMr5/cQC9ceK8peFdYU2F7OJnLiS5YSVxAetLcjA35irPwrdcNSSJNBxOqPn8z8XOnN0VftW2s3cxMKehxyRyCEb1TsC6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613978; c=relaxed/simple;
	bh=YBpifJqm/54bZf8fKNduKAhexgzSPQz3kLt7ReTQDcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jhrQn7djyWlBI/855FfbD7CcdXJdFOCnTgOTd57aByLKK8XCrpRrAFXyyY9LsoH/5M9cbz/5xnRYqquEbC20nk9PWjLN/6wXZ1roTvS6UK5KfHzP6eVYp3WWbErdOzCjZpMA0iV9rvGpQ0I+q5nBRMRMkXOyNyneZgtbJdBWZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjrYWGon; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjrYWGon"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-35448ca4689so764391a91.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 00:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772613977; x=1773218777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMIriR80Bv2/px5vVUBdIIwvGCQt0tK9lk6zU9lA43M=;
        b=NjrYWGonEefk6v3d3hoeJW6vyX9BN1D9lW+yptdkHHA3O0+D7Je3sRv0IKCpamr+xd
         6Zdm4wxLj7NdPOYS7U1GECSaSYzUA8ljyoiuAXzpSlcVzv5zczUMt4kYSpj1wGyMqf24
         528jVV2yAdGn4ijsLI2cKaUd6zBzI++MNCmgDLOUIKm8lhesEM1prVaHMYJ++Y3Inrvh
         mEIfRPmzpXxS+yZsTFCBaXu77i/4t5x85xuGRcSOSh8TqNw/vPxe5s8yuk0Fg2pDAvUw
         dew/aOTKGlA6D/HUeYlRPoxqIpz27xxGgF6UEgG9gzaMuvDy2HJ5IoZ10TjRejo4Cqfh
         y+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772613977; x=1773218777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GMIriR80Bv2/px5vVUBdIIwvGCQt0tK9lk6zU9lA43M=;
        b=J4cKg6VUK/eALJMrUxBdI1Mk8cn8kEfIydqcXlpv3F2ZJUhRAygB6yqoNkFJg3L+Su
         eQRHvqgQvKyoWqpszgYpixKOCWrdFEPotAOUNrc3B++HWDwDJZrxYi0bLjoiW5955SMq
         Pf79ajI9go1UjcXwzs946gGUtyuvOJuksfh2qh+z7l9M6mms/sh74WO3vVFuFVoZ0ZuZ
         haU5qIk4G7tyPeGYGrHF3Cl3sqvWMna5X3GJIPfr7ucSrkDEraCT9gy3pui9VATpPGtr
         HsaaUkmsh/pwGtduwr6CJAdpDn+ZLJwwLkpy8a3hed1rHmPS3qyuFEhVLsTKpRTIluIL
         nDkg==
X-Forwarded-Encrypted: i=1; AJvYcCV8WcAbnntj13UO3kw5Mdjmor1zBaBoNbpreEXuBQQYUymaj4GblcTnpmdO688hS7r3Q9XDTHYYFULpBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuCBHBDOdnFfERASDYnLTqKxWML4sMw+6Wz9acCUSfkgpdME8j
	UzvilCWr8xppli1m/bZO2bU8mBVc883XCA+GHyBBpRm5c2dTbBVEhQfS
X-Gm-Gg: ATEYQzxUBSWbAOP6qLnOqa19OciIFfzE2rbbzU3B7Ofrn8+1UqK6pCVctCqstqZYN7U
	FQ+RfgHX8tyfWvk3Map3Wu6xZyM1jZRLs6XRYCX+C8xkaIY0zrPmCKllwADiAF6Xju0X0MrdL2L
	SlpQ9CAeil8I2GB6j1P+kqWUQhRzhNicDybHGoUlpFr/8fyVhz44qsHyhgMvAtNsZ3Tc0Wa+SNe
	LPyieJHzMDseo/3cLtkE8YAbRuCjSGsnxIn4vt/7QIszI1BdMCHJnZhGhYCYPw1txsnLp60+7mz
	RtgVu2OgU3ykFSnIuLMZJU+gcSuLOCpnLCAeQIg/AehiMgXh1c10+eV4WyuAYDqXp0Sd5INwSAt
	h1/9tBLyJJYq7oKdHSrDN8nX7B+7zoIkjxLBMx/WzfR+9puFNoX65LJIrsEwIWnyEZew6dCSg/s
	TUivGKXfcJA57sS06bvfHwL2QMDluwVLNVZ1xfxHSnl8yjjEsmHgLJejfNyLuiUtdhr5RCob3Kz
	aG0+HqLCcZiptc=
X-Received: by 2002:a17:902:e851:b0:2ae:5038:6998 with SMTP id d9443c01a7336-2ae6ab75e62mr10505315ad.8.1772613976792;
        Wed, 04 Mar 2026 00:46:16 -0800 (PST)
Received: from cute.. ([2405:201:31:d01f:950d:ab7d:5e5c:5244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d1b2c5esm122010285ad.6.2026.03.04.00.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:46:16 -0800 (PST)
From: Soham Kute <officialsohamkute@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	Soham Kute <officialsohamkute@gmail.com>
Subject: [PATCH 5/6] staging: sm750fb: sw_i2c_write_byte: return -ETIMEDOUT on timeout
Date: Wed,  4 Mar 2026 14:15:44 +0530
Message-Id: <20260304084545.156170-6-officialsohamkute@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304084545.156170-1-officialsohamkute@gmail.com>
References: <aaVT1mSeKrSSlrha@stanley.mountain>
 <20260304084545.156170-1-officialsohamkute@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return -ETIMEDOUT instead of -1 when the I2C byte write times out.
The callers check for non-zero return value and treat it as failure.

Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 0ef8d4ff2ef9..a17f758dda6c 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -294,7 +294,7 @@ static long sw_i2c_write_byte(unsigned char data)
 	if (i < 0xff)
 		return 0;
 	else
-		return -1;
+		return -ETIMEDOUT;
 }
 
 /*
-- 
2.34.1


Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E9383C9E
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613962; cv=none; b=E9M/dHyS97szgF+pL7EYzqabxtw7N27fONzjrQvcUy4IVkAj6RsjvgiZs+nBI1Vjf48hSc1U2a3aDhnjWhkyynXj31EfIJme4Scb4auv8BbpBrThfq8NaQyT1EKRa9SJIYxqw8kgVFj8G6nV4rfi0pZbhQALVlPyagpVNWfMMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613962; c=relaxed/simple;
	bh=/mgLq6MyipgAXakM35FmxxzZYKnWCLgWV+pnzFPnrtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B7V4vdZ+WMir5pD80nz54rz2JEnBgGswtVQx5SezIIfXMcqDKze39W6Po8FzyOM1aJaFfbDHOhYSLd/8YinFrEmmhPQjcSCs6ZsSg+EtgFxzZEKsfHTEdQRMcPvyw/VC/QpOuWHFo6474OZ1HdrHWfmOEWOCD3fyErHvdTw5sIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVvfFKiN; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVvfFKiN"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2ab08e6c553so4732815ad.3
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 00:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772613957; x=1773218757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtmuCRd6e+N3D2PnsalDY4juU7geywSEbJtG8JH60jw=;
        b=ZVvfFKiNihAMkJuozvL1NpQlLJpdq4kpWhsJD3pR54hr7HCksIwSkv/ZhrljvOm40w
         f1WGAk+XI0VKkTEM/ZUyuE84JpKA53IqgAdGeeqMaJPGbj3eF9l/4ZkU+JX8WWIK2H1s
         7/kB3EUtZ1/6qLd/PQrmcAVM+JwEuKHu6sdsB91fP412rrSWW/istEzwC38HLwXk5395
         Ea49TITSt6bHJqez7Ha417Cq8encM1w3uLBeUJKhRlCff5IhEUPCVLYwolt5gwU5NXIB
         ihMq8EG5OkbMpMz0MKorUgQmCeswYxzk8MdcBhmmHxI2tanEOr+U6nwR4c8XpCXWKg3d
         OuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772613957; x=1773218757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtmuCRd6e+N3D2PnsalDY4juU7geywSEbJtG8JH60jw=;
        b=NB3dEEzxjE95YJC9CLwPKRFC2s0qMO1cDBlySqz7BW0IFTWYZ0ln4C23OO7U+sDUCe
         EEC3G6nNhWMy95OzHtbFgJxObehE5soXHuJ1VKR28Z+844NtNbFoJtgnjB8YPkwrj+pg
         1d02NvZBxWlbPgK1zq0efMJNTYAfYan3wN+RCSPk5GTmgE85h1mKyDZu+b/BZjClI/ro
         ZlsUwHAYvb+3EN6aEhkFLKA43SHfj6+iiPxaZIaXCqGoh5yium/40xrn7hHQVwjdKPtp
         1CJX4iYM+TkLcwZuKDc3uyoTu24vybaRPlLWCB2bczklf9vaQWEA2KnIMFK3zlbRZNhY
         3kRA==
X-Forwarded-Encrypted: i=1; AJvYcCVOs30Hj289gYayLlumj0aO/MxXt7nCWDLmSy2+5Z8AHl3dUt/eTBMR5Kn7hKouWQRCjGevERENHqt1pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCwuUp2yg3+QZkCRYybGD3K3zQFhRqrEIIwIPJ3ZbAtmDX2rn7
	5gRlmZv4+BZkhOFIsY4R6z3JL/TTM1nZ8ONSgrhFq848WQ9rPH7j3h8p
X-Gm-Gg: ATEYQzyYJy4TV3hVorw8keIWEXjU38T2Kc6zj4LNfoAHpXw4cPO/UhVQfoyWohDZmoV
	CyUNZBjDIZPAtly95EplFi9kZEUnoNVGYK5yMApYlxdgL7JBfXJUJWk8ywicLKZWPNRDIbBw2sc
	E0Za+DClpUvCw+pG2GpfWdBunDNeum/BbGQ493Lt39OXrzzA2oF7VIAA7kbMy5sGw41G/LRv73E
	pD4++Kij+yhps70oW6FNdWFxEAuezSD0x4C9IIy/LAFnmzkvTE/5NQJoxQcfzewKTInd4z7VPaW
	HeoKPoFloHsyDivpJTfxydFs9aRgzyjqsawJGxSendbqVv0H0S8IdgfVJm9bNXxPomf5bjThtW/
	qZ9lMUnmU8m7cPqc0gnC+lGoIK7MghBlAHPf1bdZEwk0smT5kN3Mrq0nHObB1IZkQYC/nlcuYYr
	v8HCCqCs75/bp6kAOR75ZIcjn4lLhuheOmAZoWB8k0nfnDlyovJsFVVxben0jrnqjoBRCTRFL+3
	Qsirt8VkepUEqs=
X-Received: by 2002:a17:903:2443:b0:2ae:5127:3d55 with SMTP id d9443c01a7336-2ae6ab18e06mr9614875ad.5.1772613957289;
        Wed, 04 Mar 2026 00:45:57 -0800 (PST)
Received: from cute.. ([2405:201:31:d01f:950d:ab7d:5e5c:5244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d1b2c5esm122010285ad.6.2026.03.04.00.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:45:57 -0800 (PST)
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
Date: Wed,  4 Mar 2026 14:15:40 +0530
Message-Id: <20260304084545.156170-2-officialsohamkute@gmail.com>
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

